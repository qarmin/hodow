#version 450
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

layout(std140, binding = 1) buffer Block
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

	var = (mat3x2(-5.0, 7.0, 6.0, 9.0, -6.0, 8.0));
}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(8.0, -8.0, -9.0, -5.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(-5.0, 0.0, 7.0, -6.0, -3.0, -3.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(-5.0, 9.0, 3.0, -7.0, 8.0, 0.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(6.0, 0.0));
	var[1] = (vec2(-6.0, -8.0));
	var[2] = (vec2(-6.0, -7.0));
	var[3] = (vec2(-7.0, 1.0));
}
#version 450
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
	lowp vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var), vec4(-7.0, 4.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (vec4(-2.0, -3.0, 0.0, 1.0));
}
#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_float(var[2][0], -7.0) && allOk;
	allOk = compare_float(var[2][1], 5.0) && allOk;
	allOk = compare_float(var[2][2], 9.0) && allOk;
	allOk = compare_vec3(var[0], vec3(6.0, 9.0, -7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(8.0, 9.0, -1.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-7.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(9.0, 3.0, 2.0));
	var[1] = (vec3(5.0, 0.0, -9.0));
	var[2] = (vec3(-5.0, -3.0, 2.0));
}
#version 450
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

	var[0] = (vec3(7.0, -5.0, -9.0));
	var[1] = (vec3(6.0, 6.0, -2.0));
	var[2] = (vec3(6.0, 0.0, -8.0));
}
#version 450
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

	var = (mat3x2(-5.0, 7.0, 6.0, 9.0, -6.0, 8.0));
}
#version 450
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

	var[0] = (vec4(-3.0, -8.0, -4.0, -6.0));
	var[1] = (vec4(8.0, -1.0, 9.0, -1.0));
	var[2] = (vec4(1.0, 3.0, -5.0, 5.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	uint padding;
	mediump uvec3 var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 8u) && allOk;
	allOk = compare_uvec3((var), uvec3(5u, 9u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6u);
	var = (uvec3(0u, 5u, 1u));
}
#version 450
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

	padding = (2.0);
	var = (mat4(0.0, -9.0, -5.0, 3.0, -8.0, 5.0, -4.0, 0.0, 1.0, 6.0, -2.0, -7.0, -5.0, 0.0, -5.0, 0.0));
}
#version 450
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -2.0) && allOk;
	allOk = compare_float(var[0][2], 0.0) && allOk;
	allOk = compare_float(var[0][3], -1.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], 2.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 4.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[2][3], 8.0) && allOk;
	allOk = compare_float(var[3][0], 1.0) && allOk;
	allOk = compare_float(var[3][1], -2.0) && allOk;
	allOk = compare_float(var[3][2], -1.0) && allOk;
	allOk = compare_float(var[3][3], -9.0) && allOk;
	allOk = compare_vec4(var[0], vec4(1.0, -2.0, 0.0, -1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(5.0, 5.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-6.0, 4.0, 6.0, 8.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(1.0, -2.0, -1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0] = (vec4(5.0, -1.0, -5.0, 4.0));
	var[1] = (vec4(2.0, 8.0, -7.0, -2.0));
	var[2] = (vec4(6.0, -3.0, -1.0, -2.0));
	var[3] = (vec4(5.0, 7.0, 1.0, 8.0));
}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[0][3], 2.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], 2.0) && allOk;
	allOk = compare_float(var[1][3], 3.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-5.0, -9.0, -2.0, 2.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-5.0, 5.0, 2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0] = (vec4(-7.0, -8.0, 7.0, -1.0));
	var[1] = (vec4(0.0, 6.0, -3.0, -3.0));
}
#version 450
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
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(3.0, -5.0, -5.0, -3.0, 3.0, -1.0, 2.0, 2.0, -2.0, -8.0, -3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var = (mat3x4(3.0, -6.0, 0.0, -5.0, -3.0, 7.0, -5.0, -3.0, 6.0, 8.0, 7.0, 5.0));
}
#version 450
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

	var[0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	var[1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	var[2] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0], mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	var[1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	var[2] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
}
#version 450
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
	bvec3 var[3];
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((var[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[2]), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (bvec3(true, true, false));
	var[1] = (bvec3(false, true, true));
	var[2] = (bvec3(false, false, false));
}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(0.0, 5.0, 5.0));
	var[0][1] = (vec3(0.0, -7.0, 8.0));
	var[1][0] = (vec3(-7.0, -4.0, 6.0));
	var[1][1] = (vec3(1.0, 3.0, 2.0));
	var[2][0] = (vec3(-6.0, 5.0, 2.0));
	var[2][1] = (vec3(1.0, 8.0, -8.0));
}
#version 450
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

	var[0][0] = (vec2(4.0, -9.0));
	var[0][1] = (vec2(-2.0, 8.0));
	var[0][2] = (vec2(-4.0, 4.0));
	var[0][3] = (vec2(9.0, 5.0));
	var[1][0] = (vec2(-2.0, 4.0));
	var[1][1] = (vec2(6.0, -8.0));
	var[1][2] = (vec2(-5.0, -1.0));
	var[1][3] = (vec2(9.0, 0.0));
	var[2][0] = (vec2(5.0, -2.0));
	var[2][1] = (vec2(4.0, -5.0));
	var[2][2] = (vec2(-2.0, -4.0));
	var[2][3] = (vec2(6.0, 4.0));
}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2(var[0], mat2(-7.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(8.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-3.0, -8.0, -6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0][0] = (vec2(-2.0, 4.0));
	var[0][1] = (vec2(-3.0, 1.0));
	var[1][0] = (vec2(2.0, -4.0));
	var[1][1] = (vec2(-3.0, -1.0));
	var[2][0] = (vec2(-4.0, 3.0));
	var[2][1] = (vec2(1.0, 7.0));
}
#version 450
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(-7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0, 8.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0, -3.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0, -8.0, 6.0, 3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0] = (vec4(-8.0, -4.0, 1.0, -8.0));
	var[0][1] = (vec4(-4.0, 3.0, 6.0, -4.0));
	var[0][2] = (vec4(-8.0, -5.0, 9.0, -4.0));
	var[1][0] = (vec4(0.0, 7.0, -9.0, 4.0));
	var[1][1] = (vec4(-4.0, -4.0, -8.0, 9.0));
	var[1][2] = (vec4(-7.0, 6.0, -4.0, 2.0));
	var[2][0] = (vec4(-1.0, -7.0, 7.0, 1.0));
	var[2][1] = (vec4(0.0, 4.0, 1.0, -9.0));
	var[2][2] = (vec4(-7.0, 2.0, -6.0, 3.0));
}
#version 450
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

	var[0] = (mat2(2.0, 4.0, 4.0, -1.0));
	var[1] = (mat2(2.0, -5.0, 1.0, -1.0));
	var[2] = (mat2(-2.0, -9.0, -3.0, -8.0));
	var[3] = (mat2(-6.0, -7.0, 1.0, -1.0));
	var[4] = (mat2(6.0, 2.0, -7.0, 8.0));
	var[5] = (mat2(-3.0, -2.0, 2.0, -7.0));
	var[6] = (mat2(-1.0, -3.0, -7.0, 2.0));
	var[7] = (mat2(-3.0, -6.0, 2.0, 7.0));
	var[8] = (mat2(4.0, -2.0, -7.0, 4.0));
	var[9] = (mat2(-7.0, -5.0, -7.0, -5.0));
	var[10] = (mat2(-6.0, 4.0, 6.0, 4.0));
	var[11] = (mat2(2.0, -1.0, 9.0, 6.0));
	var[12] = (mat2(-5.0, 7.0, -8.0, 6.0));
	var[13] = (mat2(1.0, 0.0, 7.0, -3.0));
	var[14] = (mat2(9.0, -8.0, -6.0, -9.0));
	var[15] = (mat2(-6.0, 8.0, 1.0, -2.0));
	var[16] = (mat2(-4.0, -5.0, -4.0, 2.0));
	var[17] = (mat2(4.0, -9.0, 8.0, -9.0));
	var[18] = (mat2(-2.0, 2.0, 3.0, -3.0));
}
#version 450
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
	i16vec3 var[];
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(var[0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2]), ivec3(6, -5, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3]), ivec3(9, 4, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[4]), ivec3(-6, 6, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[5]), ivec3(2, -1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[6]), ivec3(-1, -4, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[7]), ivec3(2, -8, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[8]), ivec3(0, -3, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(var[9]), ivec3(-6, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[10]), ivec3(5, 1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[11]), ivec3(8, 5, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[12]), ivec3(6, -2, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[13]), ivec3(-6, 6, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[14]), ivec3(-4, -6, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[15]), ivec3(-5, -9, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(var[16]), ivec3(7, -7, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[17]), ivec3(2, 6, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[18]), ivec3(-6, 2, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = i16vec3(ivec3(6, 1, -2));
	var[1] = i16vec3(ivec3(-3, -1, -4));
	var[2] = i16vec3(ivec3(-2, -2, 2));
	var[3] = i16vec3(ivec3(0, -6, -2));
	var[4] = i16vec3(ivec3(0, -9, 2));
	var[5] = i16vec3(ivec3(-8, 6, 2));
	var[6] = i16vec3(ivec3(-5, -4, -8));
	var[7] = i16vec3(ivec3(0, 9, 6));
	var[8] = i16vec3(ivec3(5, -3, 4));
	var[9] = i16vec3(ivec3(-3, 9, 0));
	var[10] = i16vec3(ivec3(1, -5, 8));
	var[11] = i16vec3(ivec3(-5, 0, 7));
	var[12] = i16vec3(ivec3(-6, 7, -4));
	var[13] = i16vec3(ivec3(-8, 4, 1));
	var[14] = i16vec3(ivec3(5, -4, -6));
	var[15] = i16vec3(ivec3(-6, 2, -7));
	var[16] = i16vec3(ivec3(-2, 2, -5));
	var[17] = i16vec3(ivec3(-3, -1, 0));
	var[18] = i16vec3(ivec3(-6, 9, -3));
}
#version 450
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
	highp mat4x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	var[0][1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	var[0][2] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	var[1][0] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	var[1][1] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	var[1][2] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	var[2][0] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	var[2][1] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	var[2][2] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	var[3][0] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	var[3][1] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	var[3][2] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
}
#version 450
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
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat3(var[0][0], mat3(-3.0, 4.0, 5.0, -1.0, 7.0, 7.0, 0.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(-3.0, 0.0, -1.0, -5.0, 6.0, 9.0, 4.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(8.0, 3.0, -2.0, -1.0, 8.0, -2.0, 4.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(-3.0, -4.0, 7.0, -1.0, 9.0, -7.0, 8.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(5.0, -2.0, 0.0, 7.0, -3.0, 1.0, -6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(8.0, -9.0, -1.0, -4.0, 4.0, -3.0, 9.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(2.0, -6.0, -2.0, -2.0, 3.0, -5.0, 8.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(-9.0, -5.0, 8.0, -7.0, 2.0, -9.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(5.0, 4.0, 9.0, 7.0, 8.0, -2.0, 6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(-1.0, 6.0, 0.0, -2.0, -1.0, -1.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(-4.0, -9.0, 2.0, 5.0, 1.0, -1.0, 1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(1.0, 2.0, 2.0, -5.0, 1.0, -1.0, 9.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0][0][0] = (vec3(2.0, 4.0, 6.0));
	var[0][0][1] = (vec3(2.0, -9.0, 0.0));
	var[0][0][2] = (vec3(-9.0, 3.0, -7.0));
	var[0][1][0] = (vec3(-4.0, -4.0, 5.0));
	var[0][1][1] = (vec3(-4.0, 1.0, -7.0));
	var[0][1][2] = (vec3(3.0, -3.0, 7.0));
	var[0][2][0] = (vec3(8.0, 2.0, 5.0));
	var[0][2][1] = (vec3(-9.0, 7.0, -2.0));
	var[0][2][2] = (vec3(9.0, -7.0, -7.0));
	var[1][0][0] = (vec3(-1.0, 1.0, 0.0));
	var[1][0][1] = (vec3(7.0, 7.0, 9.0));
	var[1][0][2] = (vec3(3.0, 4.0, 4.0));
	var[1][1][0] = (vec3(9.0, 1.0, -6.0));
	var[1][1][1] = (vec3(7.0, -6.0, -1.0));
	var[1][1][2] = (vec3(4.0, -3.0, -5.0));
	var[1][2][0] = (vec3(-8.0, -9.0, 6.0));
	var[1][2][1] = (vec3(2.0, -2.0, -7.0));
	var[1][2][2] = (vec3(-2.0, -7.0, 6.0));
	var[2][0][0] = (vec3(9.0, 2.0, -4.0));
	var[2][0][1] = (vec3(-9.0, -5.0, 4.0));
	var[2][0][2] = (vec3(-2.0, -1.0, -1.0));
	var[2][1][0] = (vec3(-1.0, 3.0, 0.0));
	var[2][1][1] = (vec3(-7.0, 1.0, -6.0));
	var[2][1][2] = (vec3(-6.0, 9.0, 0.0));
	var[2][2][0] = (vec3(8.0, 6.0, 4.0));
	var[2][2][1] = (vec3(7.0, -4.0, 4.0));
	var[2][2][2] = (vec3(-6.0, 0.0, -6.0));
	var[3][0][0] = (vec3(0.0, -8.0, 6.0));
	var[3][0][1] = (vec3(-7.0, -2.0, 7.0));
	var[3][0][2] = (vec3(3.0, -3.0, 4.0));
	var[3][1][0] = (vec3(-6.0, 7.0, 1.0));
	var[3][1][1] = (vec3(6.0, 3.0, 0.0));
	var[3][1][2] = (vec3(-8.0, 1.0, -2.0));
	var[3][2][0] = (vec3(1.0, 3.0, 4.0));
	var[3][2][1] = (vec3(5.0, -3.0, -6.0));
	var[3][2][2] = (vec3(-9.0, 9.0, -7.0));
}
#version 450
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
	f16vec3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), 4.0) && allOk;
	allOk = compare_f16vec3(vec3(var[0][0]), vec3(1.0, 9.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][1]), vec3(7.0, -5.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][2]), vec3(2.0, -4.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][0]), vec3(4.0, 5.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][1]), vec3(1.0, 1.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][2]), vec3(2.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][0]), vec3(-2.0, -4.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][1]), vec3(-7.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][2]), vec3(-2.0, -2.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][0]), vec3(6.0, -1.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][1]), vec3(-4.0, 6.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][2]), vec3(6.0, 4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = float16_t(3.0);
	var[0][0] = f16vec3(vec3(3.0, 7.0, -3.0));
	var[0][1] = f16vec3(vec3(-5.0, -9.0, -1.0));
	var[0][2] = f16vec3(vec3(0.0, 6.0, 5.0));
	var[1][0] = f16vec3(vec3(-7.0, 2.0, 9.0));
	var[1][1] = f16vec3(vec3(1.0, -5.0, -5.0));
	var[1][2] = f16vec3(vec3(5.0, 2.0, -5.0));
	var[2][0] = f16vec3(vec3(-4.0, 6.0, -3.0));
	var[2][1] = f16vec3(vec3(-7.0, -4.0, -4.0));
	var[2][2] = f16vec3(vec3(5.0, 0.0, -6.0));
	var[3][0] = f16vec3(vec3(4.0, -1.0, -2.0));
	var[3][1] = f16vec3(vec3(3.0, -8.0, -4.0));
	var[3][2] = f16vec3(vec3(-2.0, 4.0, 6.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(9.0, 0.0, -3.0, 4.0, 4.0, -5.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-8.0, -3.0, 1.0, 8.0, -8.0, 0.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-5.0, 5.0, 8.0, -8.0, 4.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(1.0, -3.0, -7.0, -4.0, 0.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(-2.0, 4.0, -8.0, 4.0, 9.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(8.0, 0.0, -3.0, 9.0, 5.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(5.0, 9.0, 3.0, -3.0, -8.0, 3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(4.0, -7.0, 1.0, -4.0, 7.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(8.0, -6.0, 1.0, 8.0, 5.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-6.0, -5.0, 8.0, 2.0, -2.0, 9.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-1.0, 5.0, 0.0, -4.0, 2.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(2.0, 1.0, 0.0, -1.0, -5.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(1.0, 9.0, -9.0, -8.0, 5.0, -5.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(1.0, -8.0, 8.0, 4.0, 5.0, -7.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(0.0, 8.0, 4.0, 8.0, -5.0, -2.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(3.0, 3.0, 4.0, 8.0, 4.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(-1.0, 0.0, 0.0, -2.0, -1.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(-9.0, 2.0, -8.0, 1.0, 3.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(-5.0, 9.0, -7.0, 7.0, 1.0, -9.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(8.0, 0.0, -5.0, 3.0, 2.0, -6.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(0.0, -5.0, -5.0, 9.0, -4.0, 2.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(2.0, 1.0, 7.0, 1.0));
	var[0][0][0][1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	var[0][0][1][0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	var[0][0][1][1] = (vec4(7.0, -4.0, 8.0, -2.0));
	var[0][0][2][0] = (vec4(2.0, 5.0, -2.0, 1.0));
	var[0][0][2][1] = (vec4(1.0, 0.0, -4.0, 1.0));
	var[0][1][0][0] = (vec4(-4.0, 8.0, 5.0, 5.0));
	var[0][1][0][1] = (vec4(6.0, 7.0, 9.0, 5.0));
	var[0][1][1][0] = (vec4(9.0, 9.0, 2.0, -5.0));
	var[0][1][1][1] = (vec4(5.0, 9.0, -6.0, -8.0));
	var[0][1][2][0] = (vec4(-2.0, 0.0, 7.0, 4.0));
	var[0][1][2][1] = (vec4(8.0, -3.0, -7.0, -6.0));
	var[1][0][0][0] = (vec4(0.0, 5.0, -3.0, 3.0));
	var[1][0][0][1] = (vec4(9.0, -1.0, -7.0, -7.0));
	var[1][0][1][0] = (vec4(1.0, 9.0, -1.0, 8.0));
	var[1][0][1][1] = (vec4(7.0, 6.0, 7.0, -4.0));
	var[1][0][2][0] = (vec4(-4.0, 2.0, -4.0, 6.0));
	var[1][0][2][1] = (vec4(4.0, -1.0, -9.0, 3.0));
	var[1][1][0][0] = (vec4(-6.0, -1.0, 5.0, -7.0));
	var[1][1][0][1] = (vec4(-8.0, -6.0, 3.0, -3.0));
	var[1][1][1][0] = (vec4(-4.0, -4.0, 5.0, -9.0));
	var[1][1][1][1] = (vec4(-3.0, 0.0, -2.0, 7.0));
	var[1][1][2][0] = (vec4(3.0, 3.0, -3.0, 9.0));
	var[1][1][2][1] = (vec4(-2.0, 1.0, -8.0, -2.0));
	var[2][0][0][0] = (vec4(0.0, -3.0, -2.0, 3.0));
	var[2][0][0][1] = (vec4(-6.0, 8.0, -9.0, -3.0));
	var[2][0][1][0] = (vec4(-9.0, 3.0, -2.0, 6.0));
	var[2][0][1][1] = (vec4(4.0, 7.0, -7.0, 7.0));
	var[2][0][2][0] = (vec4(5.0, 2.0, 7.0, -9.0));
	var[2][0][2][1] = (vec4(-4.0, -3.0, -2.0, 4.0));
	var[2][1][0][0] = (vec4(6.0, -5.0, 0.0, 4.0));
	var[2][1][0][1] = (vec4(8.0, -6.0, 8.0, -7.0));
	var[2][1][1][0] = (vec4(8.0, 0.0, 1.0, -6.0));
	var[2][1][1][1] = (vec4(0.0, 1.0, 1.0, -9.0));
	var[2][1][2][0] = (vec4(-6.0, 9.0, 2.0, -5.0));
	var[2][1][2][1] = (vec4(-7.0, -6.0, 3.0, -2.0));
	var[3][0][0][0] = (vec4(-3.0, -8.0, -4.0, 6.0));
	var[3][0][0][1] = (vec4(-1.0, -1.0, 6.0, -8.0));
	var[3][0][1][0] = (vec4(-4.0, -2.0, -8.0, 4.0));
	var[3][0][1][1] = (vec4(-2.0, 4.0, -8.0, 6.0));
	var[3][0][2][0] = (vec4(4.0, -8.0, 8.0, -8.0));
	var[3][0][2][1] = (vec4(4.0, 0.0, -9.0, 1.0));
	var[3][1][0][0] = (vec4(1.0, -8.0, 4.0, -7.0));
	var[3][1][0][1] = (vec4(-3.0, 9.0, 4.0, -6.0));
	var[3][1][1][0] = (vec4(-7.0, -3.0, 9.0, -8.0));
	var[3][1][1][1] = (vec4(1.0, -6.0, 7.0, 1.0));
	var[3][1][2][0] = (vec4(5.0, -9.0, 3.0, -2.0));
	var[3][1][2][1] = (vec4(-1.0, 1.0, -7.0, 8.0));
}
#version 450
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
	highp mat3x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-7.0, 3.0, -2.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(0.0, 9.0, -3.0, 8.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(8.0, -3.0, 6.0, 0.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(1.0, 1.0, -3.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(2.0, 8.0, 7.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(-4.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(6.0, -8.0, 1.0, -6.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(8.0, 9.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(1.0, -7.0, 6.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(8.0, -8.0, -7.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(3.0, 9.0, -2.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(-3.0, 9.0, 6.0, 2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-9.0, 9.0, 5.0, -2.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-3.0, 6.0, 4.0, 5.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(2.0, -9.0, -7.0, 3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(7.0, 1.0, 1.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(2.0, 7.0, -2.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-8.0, -1.0, -7.0, 9.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(-3.0, 9.0, 2.0, -2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(-3.0, 1.0, 6.0, 9.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(2.0, -2.0, -9.0, -3.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	var[0][0][1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	var[0][0][2] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
	var[0][1][0] = (mat3x2(-7.0, -7.0, -1.0, 1.0, -5.0, 2.0));
	var[0][1][1] = (mat3x2(5.0, 5.0, 3.0, -9.0, 7.0, -4.0));
	var[0][1][2] = (mat3x2(-1.0, -7.0, -6.0, -4.0, -4.0, 8.0));
	var[1][0][0] = (mat3x2(2.0, 1.0, -5.0, 0.0, -3.0, 1.0));
	var[1][0][1] = (mat3x2(-4.0, 4.0, 5.0, -5.0, -6.0, 3.0));
	var[1][0][2] = (mat3x2(1.0, -2.0, 3.0, -8.0, -6.0, 2.0));
	var[1][1][0] = (mat3x2(3.0, -5.0, 8.0, 6.0, 0.0, -2.0));
	var[1][1][1] = (mat3x2(9.0, -9.0, -7.0, -9.0, -9.0, 4.0));
	var[1][1][2] = (mat3x2(5.0, 9.0, 6.0, -1.0, 0.0, -2.0));
	var[2][0][0] = (mat3x2(-5.0, -4.0, -8.0, 9.0, -9.0, -8.0));
	var[2][0][1] = (mat3x2(8.0, -4.0, 1.0, -1.0, 7.0, 0.0));
	var[2][0][2] = (mat3x2(1.0, -3.0, 6.0, -4.0, -6.0, -5.0));
	var[2][1][0] = (mat3x2(-2.0, -4.0, 7.0, -2.0, 0.0, 0.0));
	var[2][1][1] = (mat3x2(-4.0, 1.0, -6.0, -5.0, -1.0, 0.0));
	var[2][1][2] = (mat3x2(-7.0, -3.0, -5.0, -9.0, 7.0, -3.0));
	var[3][0][0] = (mat3x2(-6.0, -4.0, 6.0, 4.0, 2.0, -8.0));
	var[3][0][1] = (mat3x2(2.0, 1.0, -3.0, -3.0, -5.0, -1.0));
	var[3][0][2] = (mat3x2(6.0, 9.0, 9.0, 9.0, -4.0, 8.0));
	var[3][1][0] = (mat3x2(4.0, 1.0, 0.0, 2.0, -6.0, -1.0));
	var[3][1][1] = (mat3x2(-4.0, 4.0, 0.0, -1.0, -4.0, -4.0));
	var[3][1][2] = (mat3x2(-2.0, 9.0, 8.0, 9.0, -3.0, -7.0));
}
#version 450
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
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(1.0, 8.0, 9.0, 7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-9.0, -9.0, -7.0, -5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(-8.0, -7.0, 9.0, 6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-5.0, -8.0, -6.0, 4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(-5.0, -1.0, 5.0, 4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(0.0, -6.0, -8.0, -7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-2.0, 8.0, 2.0, 7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(0.0, 8.0, 9.0, -9.0, -9.0, 4.0, 1.0, -1.0, 9.0, 0.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(-2.0, -8.0, 7.0, 1.0, 5.0, 7.0, 8.0, -2.0, 4.0, -4.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(6.0, 3.0, 4.0, -2.0, 5.0, 6.0, -9.0, 4.0, 7.0, 7.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(9.0, 9.0, -6.0, -7.0, -9.0, -9.0, 5.0, 9.0, 5.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(3.0, 6.0, -3.0, -8.0, -1.0, 5.0, -8.0, -5.0, 3.0, -4.0, -9.0, 6.0)) && allOk;
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
	var[0][0][2][0] = (vec3(-4.0, -9.0, 8.0));
	var[0][0][2][1] = (vec3(9.0, 2.0, 2.0));
	var[0][0][2][2] = (vec3(9.0, -7.0, 3.0));
	var[0][0][2][3] = (vec3(8.0, 2.0, 4.0));
	var[0][1][0][0] = (vec3(-5.0, 2.0, -4.0));
	var[0][1][0][1] = (vec3(-7.0, -3.0, -4.0));
	var[0][1][0][2] = (vec3(4.0, -3.0, -8.0));
	var[0][1][0][3] = (vec3(-5.0, -1.0, 1.0));
	var[0][1][1][0] = (vec3(6.0, -2.0, 8.0));
	var[0][1][1][1] = (vec3(-7.0, 1.0, 4.0));
	var[0][1][1][2] = (vec3(6.0, 8.0, -5.0));
	var[0][1][1][3] = (vec3(1.0, -6.0, 4.0));
	var[0][1][2][0] = (vec3(-9.0, 3.0, -3.0));
	var[0][1][2][1] = (vec3(0.0, -5.0, -3.0));
	var[0][1][2][2] = (vec3(-5.0, -8.0, 3.0));
	var[0][1][2][3] = (vec3(3.0, -6.0, 8.0));
	var[1][0][0][0] = (vec3(2.0, 4.0, -3.0));
	var[1][0][0][1] = (vec3(-8.0, 7.0, 3.0));
	var[1][0][0][2] = (vec3(0.0, -8.0, 0.0));
	var[1][0][0][3] = (vec3(6.0, -9.0, 0.0));
	var[1][0][1][0] = (vec3(-4.0, 5.0, 5.0));
	var[1][0][1][1] = (vec3(-7.0, -8.0, -1.0));
	var[1][0][1][2] = (vec3(6.0, -3.0, -5.0));
	var[1][0][1][3] = (vec3(0.0, 8.0, -8.0));
	var[1][0][2][0] = (vec3(-4.0, 4.0, 8.0));
	var[1][0][2][1] = (vec3(-4.0, -4.0, -3.0));
	var[1][0][2][2] = (vec3(3.0, 3.0, 2.0));
	var[1][0][2][3] = (vec3(8.0, -8.0, -6.0));
	var[1][1][0][0] = (vec3(-3.0, 5.0, 6.0));
	var[1][1][0][1] = (vec3(5.0, -1.0, 6.0));
	var[1][1][0][2] = (vec3(8.0, 7.0, 1.0));
	var[1][1][0][3] = (vec3(-5.0, 6.0, -6.0));
	var[1][1][1][0] = (vec3(-3.0, -7.0, 7.0));
	var[1][1][1][1] = (vec3(-9.0, -3.0, 6.0));
	var[1][1][1][2] = (vec3(0.0, -7.0, 3.0));
	var[1][1][1][3] = (vec3(2.0, -7.0, 1.0));
	var[1][1][2][0] = (vec3(8.0, -1.0, -9.0));
	var[1][1][2][1] = (vec3(8.0, 8.0, 2.0));
	var[1][1][2][2] = (vec3(7.0, -5.0, -2.0));
	var[1][1][2][3] = (vec3(-9.0, 6.0, 2.0));
	var[2][0][0][0] = (vec3(9.0, 1.0, -1.0));
	var[2][0][0][1] = (vec3(-1.0, 2.0, 4.0));
	var[2][0][0][2] = (vec3(4.0, 2.0, 0.0));
	var[2][0][0][3] = (vec3(5.0, 6.0, -6.0));
	var[2][0][1][0] = (vec3(-3.0, 7.0, -6.0));
	var[2][0][1][1] = (vec3(7.0, 9.0, 8.0));
	var[2][0][1][2] = (vec3(-9.0, -9.0, -9.0));
	var[2][0][1][3] = (vec3(6.0, -7.0, -3.0));
	var[2][0][2][0] = (vec3(7.0, -1.0, -4.0));
	var[2][0][2][1] = (vec3(-9.0, 0.0, -1.0));
	var[2][0][2][2] = (vec3(-7.0, -2.0, -3.0));
	var[2][0][2][3] = (vec3(1.0, 4.0, 5.0));
	var[2][1][0][0] = (vec3(-1.0, 7.0, 7.0));
	var[2][1][0][1] = (vec3(3.0, -4.0, -1.0));
	var[2][1][0][2] = (vec3(-4.0, 5.0, 7.0));
	var[2][1][0][3] = (vec3(-5.0, 7.0, 5.0));
	var[2][1][1][0] = (vec3(-1.0, -1.0, 5.0));
	var[2][1][1][1] = (vec3(9.0, 7.0, -5.0));
	var[2][1][1][2] = (vec3(3.0, -1.0, 3.0));
	var[2][1][1][3] = (vec3(8.0, -5.0, 3.0));
	var[2][1][2][0] = (vec3(-6.0, 1.0, 0.0));
	var[2][1][2][1] = (vec3(8.0, -8.0, 5.0));
	var[2][1][2][2] = (vec3(-3.0, 5.0, -4.0));
	var[2][1][2][3] = (vec3(-3.0, -2.0, 2.0));
	var[3][0][0][0] = (vec3(9.0, 8.0, 7.0));
	var[3][0][0][1] = (vec3(5.0, 4.0, 7.0));
	var[3][0][0][2] = (vec3(3.0, -3.0, 4.0));
	var[3][0][0][3] = (vec3(3.0, -6.0, 5.0));
	var[3][0][1][0] = (vec3(-8.0, -4.0, -9.0));
	var[3][0][1][1] = (vec3(4.0, 8.0, -3.0));
	var[3][0][1][2] = (vec3(-9.0, 7.0, -2.0));
	var[3][0][1][3] = (vec3(0.0, -3.0, -3.0));
	var[3][0][2][0] = (vec3(4.0, -2.0, -4.0));
	var[3][0][2][1] = (vec3(-5.0, -7.0, 1.0));
	var[3][0][2][2] = (vec3(-8.0, 1.0, 9.0));
	var[3][0][2][3] = (vec3(-8.0, 0.0, -2.0));
	var[3][1][0][0] = (vec3(-5.0, 3.0, -6.0));
	var[3][1][0][1] = (vec3(-6.0, -4.0, -2.0));
	var[3][1][0][2] = (vec3(-5.0, -2.0, -2.0));
	var[3][1][0][3] = (vec3(-8.0, 2.0, 4.0));
	var[3][1][1][0] = (vec3(-1.0, -1.0, 1.0));
	var[3][1][1][1] = (vec3(-9.0, -7.0, -8.0));
	var[3][1][1][2] = (vec3(-8.0, -5.0, -1.0));
	var[3][1][1][3] = (vec3(2.0, 0.0, -4.0));
	var[3][1][2][0] = (vec3(7.0, 6.0, 4.0));
	var[3][1][2][1] = (vec3(-5.0, -5.0, 8.0));
	var[3][1][2][2] = (vec3(-3.0, 4.0, -5.0));
	var[3][1][2][3] = (vec3(-8.0, 5.0, -2.0));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-8.0, 7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-8.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(-3.0, -8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(6.0, -4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(3.0, 2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(5.0, -3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-9.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(9.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(2.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-7.0, 8.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(3.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(4.0, 4.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-3.0, -7.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(5.0, -7.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(2.0, -7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(1.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(-5.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(-3.0, -7.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(6.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(2.0, 7.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(1.0, 2.0, 6.0, -6.0));
	var[0][0][1] = (mat2(2.0, 4.0, 4.0, 7.0));
	var[0][0][2] = (mat2(0.0, 8.0, 0.0, -1.0));
	var[0][1][0] = (mat2(5.0, 1.0, -7.0, -2.0));
	var[0][1][1] = (mat2(-8.0, -9.0, 4.0, -4.0));
	var[0][1][2] = (mat2(-7.0, -9.0, -5.0, 3.0));
	var[1][0][0] = (mat2(8.0, -4.0, -5.0, 7.0));
	var[1][0][1] = (mat2(-3.0, -1.0, 0.0, 6.0));
	var[1][0][2] = (mat2(-6.0, 7.0, 4.0, -7.0));
	var[1][1][0] = (mat2(-1.0, -1.0, -6.0, -3.0));
	var[1][1][1] = (mat2(-9.0, -4.0, -8.0, -1.0));
	var[1][1][2] = (mat2(-8.0, 1.0, -2.0, 9.0));
	var[2][0][0] = (mat2(1.0, -8.0, -9.0, -7.0));
	var[2][0][1] = (mat2(1.0, -2.0, -6.0, -8.0));
	var[2][0][2] = (mat2(-6.0, -6.0, 2.0, -9.0));
	var[2][1][0] = (mat2(9.0, 4.0, -3.0, -3.0));
	var[2][1][1] = (mat2(0.0, -1.0, -5.0, -6.0));
	var[2][1][2] = (mat2(-8.0, 0.0, 8.0, 8.0));
	var[3][0][0] = (mat2(9.0, 0.0, -3.0, -7.0));
	var[3][0][1] = (mat2(8.0, 8.0, 7.0, -3.0));
	var[3][0][2] = (mat2(7.0, 2.0, -8.0, -7.0));
	var[3][1][0] = (mat2(-3.0, -9.0, 5.0, -2.0));
	var[3][1][1] = (mat2(1.0, 9.0, -3.0, -5.0));
	var[3][1][2] = (mat2(-3.0, 5.0, 0.0, -9.0));
}
#version 450
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
	allOk = compare_mat4(var[0][0][0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(-3.0, 4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-6.0, -2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(0.0, -2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-2.0, -2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(1.0, -7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(-2.0, -9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(1.0, 6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-3.0, -8.0, 9.0, 1.0, 3.0, -9.0, 9.0, -2.0, -7.0, 2.0, 9.0, -7.0, -5.0, 5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(-6.0, -4.0, -8.0, -3.0, -3.0, 0.0, 3.0, 9.0, 7.0, 2.0, 4.0, 6.0, -9.0, 8.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-5.0, -2.0, 1.0, -4.0, 8.0, -8.0, -5.0, -7.0, 8.0, -9.0, 4.0, 3.0, 2.0, 9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(4.0, -4.0, 9.0, 3.0, -5.0, -7.0, 0.0, 3.0, -3.0, 6.0, -9.0, 9.0, 9.0, 8.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(9.0, 7.0, -7.0, -6.0, 0.0, -3.0, -2.0, 5.0, 2.0, -1.0, 0.0, -8.0, 1.0, -4.0, -7.0, 9.0)) && allOk;
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
	var[0][0][2][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	var[0][0][2][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	var[0][0][2][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	var[0][0][2][3] = (vec4(0.0, -7.0, 7.0, 8.0));
	var[0][1][0][0] = (vec4(8.0, -9.0, 9.0, 7.0));
	var[0][1][0][1] = (vec4(-9.0, 5.0, 1.0, -4.0));
	var[0][1][0][2] = (vec4(-1.0, -2.0, 1.0, 5.0));
	var[0][1][0][3] = (vec4(-1.0, -5.0, 7.0, -6.0));
	var[0][1][1][0] = (vec4(1.0, 0.0, 9.0, -3.0));
	var[0][1][1][1] = (vec4(7.0, 0.0, -6.0, -7.0));
	var[0][1][1][2] = (vec4(-8.0, 1.0, -2.0, 9.0));
	var[0][1][1][3] = (vec4(0.0, -2.0, 6.0, -1.0));
	var[0][1][2][0] = (vec4(-5.0, -1.0, -3.0, 5.0));
	var[0][1][2][1] = (vec4(-7.0, 4.0, 5.0, -9.0));
	var[0][1][2][2] = (vec4(-1.0, 0.0, 8.0, 8.0));
	var[0][1][2][3] = (vec4(-3.0, 4.0, -4.0, -4.0));
	var[1][0][0][0] = (vec4(-6.0, -6.0, -1.0, 6.0));
	var[1][0][0][1] = (vec4(3.0, 5.0, -8.0, 3.0));
	var[1][0][0][2] = (vec4(1.0, -1.0, 3.0, -5.0));
	var[1][0][0][3] = (vec4(4.0, -4.0, 3.0, 4.0));
	var[1][0][1][0] = (vec4(-4.0, -8.0, 4.0, 5.0));
	var[1][0][1][1] = (vec4(-5.0, 0.0, -3.0, -4.0));
	var[1][0][1][2] = (vec4(5.0, -4.0, -7.0, 4.0));
	var[1][0][1][3] = (vec4(-3.0, 9.0, 3.0, -4.0));
	var[1][0][2][0] = (vec4(-3.0, -9.0, 6.0, -3.0));
	var[1][0][2][1] = (vec4(-6.0, -1.0, 8.0, 3.0));
	var[1][0][2][2] = (vec4(-2.0, 9.0, -2.0, -3.0));
	var[1][0][2][3] = (vec4(-8.0, 3.0, -8.0, 5.0));
	var[1][1][0][0] = (vec4(5.0, 8.0, -8.0, -1.0));
	var[1][1][0][1] = (vec4(-7.0, 8.0, 4.0, -1.0));
	var[1][1][0][2] = (vec4(-1.0, -9.0, 3.0, 2.0));
	var[1][1][0][3] = (vec4(4.0, -2.0, 7.0, 5.0));
	var[1][1][1][0] = (vec4(0.0, -5.0, 2.0, 2.0));
	var[1][1][1][1] = (vec4(4.0, 4.0, -9.0, 3.0));
	var[1][1][1][2] = (vec4(1.0, 0.0, 5.0, -8.0));
	var[1][1][1][3] = (vec4(-3.0, -3.0, 3.0, -6.0));
	var[1][1][2][0] = (vec4(-5.0, 9.0, 0.0, -6.0));
	var[1][1][2][1] = (vec4(-2.0, -4.0, 3.0, 1.0));
	var[1][1][2][2] = (vec4(4.0, 1.0, -3.0, 6.0));
	var[1][1][2][3] = (vec4(-2.0, -7.0, -7.0, 9.0));
	var[2][0][0][0] = (vec4(7.0, -2.0, -7.0, 3.0));
	var[2][0][0][1] = (vec4(8.0, -7.0, -6.0, 4.0));
	var[2][0][0][2] = (vec4(-4.0, 6.0, -2.0, -7.0));
	var[2][0][0][3] = (vec4(7.0, 8.0, -8.0, -2.0));
	var[2][0][1][0] = (vec4(-8.0, 3.0, 9.0, 3.0));
	var[2][0][1][1] = (vec4(1.0, -3.0, -5.0, -8.0));
	var[2][0][1][2] = (vec4(-7.0, 5.0, -1.0, -6.0));
	var[2][0][1][3] = (vec4(8.0, -8.0, 4.0, 8.0));
	var[2][0][2][0] = (vec4(6.0, -5.0, 4.0, -3.0));
	var[2][0][2][1] = (vec4(-1.0, -8.0, 3.0, 5.0));
	var[2][0][2][2] = (vec4(0.0, 7.0, 6.0, -4.0));
	var[2][0][2][3] = (vec4(1.0, 4.0, 3.0, 6.0));
	var[2][1][0][0] = (vec4(-2.0, -6.0, -2.0, -5.0));
	var[2][1][0][1] = (vec4(-9.0, 4.0, 4.0, -5.0));
	var[2][1][0][2] = (vec4(-1.0, -1.0, 0.0, -7.0));
	var[2][1][0][3] = (vec4(5.0, 7.0, -3.0, -7.0));
	var[2][1][1][0] = (vec4(9.0, -7.0, 5.0, 1.0));
	var[2][1][1][1] = (vec4(-7.0, 4.0, 8.0, -9.0));
	var[2][1][1][2] = (vec4(6.0, 2.0, -8.0, 8.0));
	var[2][1][1][3] = (vec4(3.0, 6.0, 9.0, 6.0));
	var[2][1][2][0] = (vec4(-4.0, -8.0, -1.0, 1.0));
	var[2][1][2][1] = (vec4(0.0, 5.0, 8.0, 6.0));
	var[2][1][2][2] = (vec4(3.0, 8.0, -7.0, -1.0));
	var[2][1][2][3] = (vec4(2.0, 3.0, 7.0, 3.0));
	var[3][0][0][0] = (vec4(-3.0, -8.0, -6.0, 5.0));
	var[3][0][0][1] = (vec4(-9.0, -3.0, 0.0, -1.0));
	var[3][0][0][2] = (vec4(-5.0, 9.0, -8.0, -9.0));
	var[3][0][0][3] = (vec4(-1.0, 2.0, 5.0, 6.0));
	var[3][0][1][0] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[3][0][1][1] = (vec4(-7.0, -1.0, 5.0, -3.0));
	var[3][0][1][2] = (vec4(5.0, -3.0, -4.0, 6.0));
	var[3][0][1][3] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[3][0][2][0] = (vec4(7.0, -3.0, -8.0, 1.0));
	var[3][0][2][1] = (vec4(1.0, 2.0, 3.0, 1.0));
	var[3][0][2][2] = (vec4(5.0, -2.0, 2.0, -2.0));
	var[3][0][2][3] = (vec4(-9.0, -1.0, 2.0, -1.0));
	var[3][1][0][0] = (vec4(-2.0, -1.0, 0.0, -2.0));
	var[3][1][0][1] = (vec4(7.0, -6.0, 5.0, 5.0));
	var[3][1][0][2] = (vec4(-9.0, -8.0, -5.0, 0.0));
	var[3][1][0][3] = (vec4(-2.0, 3.0, 8.0, 4.0));
	var[3][1][1][0] = (vec4(-2.0, -3.0, -9.0, 9.0));
	var[3][1][1][1] = (vec4(-6.0, -1.0, -3.0, 3.0));
	var[3][1][1][2] = (vec4(-7.0, 5.0, -6.0, 8.0));
	var[3][1][1][3] = (vec4(0.0, -5.0, 0.0, 4.0));
	var[3][1][2][0] = (vec4(-2.0, -9.0, -1.0, -2.0));
	var[3][1][2][1] = (vec4(2.0, -4.0, -6.0, -5.0));
	var[3][1][2][2] = (vec4(4.0, -4.0, 7.0, 2.0));
	var[3][1][2][3] = (vec4(3.0, 2.0, -2.0, -5.0));
}
#version 450
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
	allOk = compare_mat3x2(var[0][0][0], mat3x2(5.0, -6.0, -5.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-5.0, -6.0, -8.0, 6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(2.0, -8.0, 9.0, -8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-1.0, 7.0, 3.0, 8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(6.0, -7.0, 7.0, 5.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(9.0, 0.0, 2.0, -5.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(5.0, 0.0, 4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(-1.0, -1.0, -2.0, -8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(-8.0, -6.0, 0.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-5.0, 6.0, -3.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(9.0, -6.0, -8.0, -7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(-2.0, -1.0, 1.0, 6.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(-1.0, 7.0, -4.0, 3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(-5.0, -2.0, 0.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(-7.0, -4.0, 1.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(1.0, -2.0, -2.0, -9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(8.0, 2.0, -1.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(-6.0, 0.0, 6.0, 9.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(-8.0, -7.0, -1.0, -4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(7.0, 9.0, 8.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(8.0, -3.0, 8.0, -5.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(1.0, 8.0, 6.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(2.0, 5.0, 4.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(-7.0, -1.0, -1.0, -7.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	var[0][0][1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	var[0][0][2] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
	var[0][1][0] = (mat3x2(4.0, -9.0, -8.0, 7.0, -5.0, -1.0));
	var[0][1][1] = (mat3x2(-7.0, 4.0, -2.0, -6.0, -5.0, 6.0));
	var[0][1][2] = (mat3x2(-3.0, -7.0, 9.0, 9.0, -8.0, 0.0));
	var[1][0][0] = (mat3x2(0.0, 6.0, -5.0, 4.0, -2.0, 0.0));
	var[1][0][1] = (mat3x2(-3.0, -3.0, -2.0, 9.0, -2.0, -7.0));
	var[1][0][2] = (mat3x2(-9.0, -2.0, -8.0, 4.0, 3.0, 8.0));
	var[1][1][0] = (mat3x2(6.0, -3.0, 9.0, -2.0, -5.0, -4.0));
	var[1][1][1] = (mat3x2(-4.0, 6.0, -7.0, 5.0, -1.0, 5.0));
	var[1][1][2] = (mat3x2(4.0, -7.0, -3.0, 6.0, -8.0, 2.0));
	var[2][0][0] = (mat3x2(7.0, 9.0, -5.0, 9.0, -1.0, 4.0));
	var[2][0][1] = (mat3x2(6.0, -4.0, -6.0, 0.0, 7.0, -2.0));
	var[2][0][2] = (mat3x2(-1.0, -9.0, 8.0, -6.0, -9.0, 5.0));
	var[2][1][0] = (mat3x2(-3.0, -4.0, -7.0, 0.0, 8.0, 4.0));
	var[2][1][1] = (mat3x2(-8.0, -5.0, -1.0, -5.0, 2.0, -6.0));
	var[2][1][2] = (mat3x2(3.0, 4.0, 5.0, 1.0, -7.0, 1.0));
	var[3][0][0] = (mat3x2(2.0, -9.0, 9.0, 4.0, -4.0, 9.0));
	var[3][0][1] = (mat3x2(3.0, 3.0, 1.0, -4.0, 0.0, -7.0));
	var[3][0][2] = (mat3x2(-4.0, 7.0, 7.0, -1.0, -2.0, 6.0));
	var[3][1][0] = (mat3x2(2.0, -7.0, -1.0, -4.0, 8.0, 1.0));
	var[3][1][1] = (mat3x2(-8.0, 2.0, 7.0, 8.0, -5.0, -3.0));
	var[3][1][2] = (mat3x2(8.0, -6.0, 3.0, -2.0, 7.0, -4.0));
}
#version 450
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
	highp mat3x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0, -9.0, 3.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0, -4.0, 9.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0, -6.0, -7.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0, 7.0, 9.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0, -7.0, 1.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0, 8.0, -8.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0, -4.0, 2.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0, 3.0, 9.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0, -4.0, -9.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0, -4.0, -6.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0, 2.0, -1.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0, 1.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0, 0.0, -7.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0, 9.0, -9.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(-9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0, -2.0, -1.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0, -2.0, 7.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(4.0, -7.0, 8.0, -2.0, -7.0, -1.0, 9.0, 0.0, 0.0, -2.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(4.0, 9.0, 5.0, 4.0, 9.0, -4.0, 5.0, 4.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(-3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0, 1.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0, 5.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0, 4.0, 1.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(-3.0, 3.0, -7.0, 4.0, 1.0, 0.0, 9.0, 9.0, 0.0, -7.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(-2.0, 8.0, 8.0, 5.0, 3.0, -7.0, -8.0, -4.0, 9.0, 4.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(-6.0, 9.0, 2.0, 4.0, 4.0, 1.0, -1.0, -6.0, -3.0, 1.0, -8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var[0][0][0][0] = (vec4(-2.0, 4.0, -5.0, 8.0));
	var[0][0][0][1] = (vec4(-4.0, 6.0, -9.0, -9.0));
	var[0][0][0][2] = (vec4(-4.0, 2.0, -3.0, 0.0));
	var[0][0][1][0] = (vec4(5.0, 2.0, 6.0, 6.0));
	var[0][0][1][1] = (vec4(-7.0, -6.0, -8.0, 0.0));
	var[0][0][1][2] = (vec4(6.0, 0.0, 6.0, 3.0));
	var[0][0][2][0] = (vec4(-8.0, -5.0, -5.0, 1.0));
	var[0][0][2][1] = (vec4(7.0, -8.0, -3.0, -2.0));
	var[0][0][2][2] = (vec4(-3.0, 6.0, -2.0, 6.0));
	var[0][1][0][0] = (vec4(9.0, 5.0, 9.0, -1.0));
	var[0][1][0][1] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[0][1][0][2] = (vec4(2.0, 8.0, -5.0, 0.0));
	var[0][1][1][0] = (vec4(4.0, 1.0, 9.0, 9.0));
	var[0][1][1][1] = (vec4(-9.0, -5.0, 3.0, 8.0));
	var[0][1][1][2] = (vec4(-4.0, 7.0, 1.0, 4.0));
	var[0][1][2][0] = (vec4(-5.0, 4.0, -2.0, -4.0));
	var[0][1][2][1] = (vec4(8.0, -7.0, -1.0, -9.0));
	var[0][1][2][2] = (vec4(-1.0, -2.0, 2.0, 8.0));
	var[1][0][0][0] = (vec4(-5.0, -8.0, -9.0, -8.0));
	var[1][0][0][1] = (vec4(9.0, 0.0, 3.0, -4.0));
	var[1][0][0][2] = (vec4(4.0, -5.0, 8.0, 0.0));
	var[1][0][1][0] = (vec4(9.0, -8.0, -1.0, -7.0));
	var[1][0][1][1] = (vec4(1.0, 2.0, 0.0, -9.0));
	var[1][0][1][2] = (vec4(-6.0, 5.0, 1.0, 2.0));
	var[1][0][2][0] = (vec4(-7.0, 0.0, 3.0, 4.0));
	var[1][0][2][1] = (vec4(4.0, 5.0, 2.0, -3.0));
	var[1][0][2][2] = (vec4(0.0, 5.0, -4.0, 0.0));
	var[1][1][0][0] = (vec4(0.0, 6.0, 0.0, 2.0));
	var[1][1][0][1] = (vec4(-1.0, -5.0, -6.0, -4.0));
	var[1][1][0][2] = (vec4(5.0, 3.0, 6.0, -3.0));
	var[1][1][1][0] = (vec4(-8.0, -8.0, 1.0, 7.0));
	var[1][1][1][1] = (vec4(-6.0, -3.0, -7.0, 1.0));
	var[1][1][1][2] = (vec4(-5.0, -4.0, -4.0, -5.0));
	var[1][1][2][0] = (vec4(6.0, 2.0, 5.0, 5.0));
	var[1][1][2][1] = (vec4(5.0, -1.0, -7.0, -1.0));
	var[1][1][2][2] = (vec4(5.0, 0.0, 1.0, 1.0));
	var[2][0][0][0] = (vec4(3.0, -2.0, -3.0, 1.0));
	var[2][0][0][1] = (vec4(-5.0, -9.0, -7.0, -7.0));
	var[2][0][0][2] = (vec4(-7.0, 3.0, -8.0, -2.0));
	var[2][0][1][0] = (vec4(7.0, -6.0, -4.0, 6.0));
	var[2][0][1][1] = (vec4(-5.0, -4.0, -8.0, -4.0));
	var[2][0][1][2] = (vec4(-9.0, -7.0, -8.0, 9.0));
	var[2][0][2][0] = (vec4(-6.0, -4.0, 5.0, -5.0));
	var[2][0][2][1] = (vec4(-5.0, 7.0, 6.0, 6.0));
	var[2][0][2][2] = (vec4(-2.0, 7.0, -9.0, 0.0));
	var[2][1][0][0] = (vec4(5.0, 8.0, 5.0, -9.0));
	var[2][1][0][1] = (vec4(7.0, -9.0, 0.0, -3.0));
	var[2][1][0][2] = (vec4(-1.0, -4.0, 2.0, -6.0));
	var[2][1][1][0] = (vec4(5.0, 3.0, 4.0, 8.0));
	var[2][1][1][1] = (vec4(7.0, 0.0, -5.0, -6.0));
	var[2][1][1][2] = (vec4(6.0, -6.0, -5.0, 5.0));
	var[2][1][2][0] = (vec4(3.0, -1.0, -7.0, 0.0));
	var[2][1][2][1] = (vec4(-1.0, 6.0, -6.0, 1.0));
	var[2][1][2][2] = (vec4(0.0, 8.0, 4.0, 0.0));
	var[3][0][0][0] = (vec4(-7.0, 6.0, -7.0, -1.0));
	var[3][0][0][1] = (vec4(-6.0, -6.0, 2.0, 8.0));
	var[3][0][0][2] = (vec4(9.0, -3.0, -9.0, -6.0));
	var[3][0][1][0] = (vec4(2.0, 0.0, 0.0, -2.0));
	var[3][0][1][1] = (vec4(-9.0, -3.0, 2.0, 2.0));
	var[3][0][1][2] = (vec4(6.0, -8.0, -3.0, -7.0));
	var[3][0][2][0] = (vec4(-3.0, 1.0, -7.0, 9.0));
	var[3][0][2][1] = (vec4(-9.0, -8.0, 0.0, 8.0));
	var[3][0][2][2] = (vec4(-4.0, 9.0, 7.0, 6.0));
	var[3][1][0][0] = (vec4(-6.0, 8.0, -5.0, -1.0));
	var[3][1][0][1] = (vec4(0.0, 6.0, -9.0, 9.0));
	var[3][1][0][2] = (vec4(8.0, 0.0, 9.0, 8.0));
	var[3][1][1][0] = (vec4(1.0, 4.0, -3.0, -6.0));
	var[3][1][1][1] = (vec4(2.0, -2.0, -2.0, 3.0));
	var[3][1][1][2] = (vec4(-2.0, -5.0, 0.0, -5.0));
	var[3][1][2][0] = (vec4(-6.0, 0.0, 1.0, 9.0));
	var[3][1][2][1] = (vec4(2.0, 5.0, -8.0, 5.0));
	var[3][1][2][2] = (vec4(-4.0, -6.0, 2.0, 5.0));
}
#version 450
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
	bvec3 var[][4][2];
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((var[0][0][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[0][0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[0][1][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((var[0][1][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[0][2][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[0][2][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[0][3][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[0][3][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[1][0][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[1][0][1]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[1][1][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[1][1][1]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[1][2][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[1][2][1]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[1][3][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[1][3][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[2][0][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[2][0][1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((var[2][1][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[2][1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[2][2][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[2][2][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[2][3][0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((var[2][3][1]), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (bvec3(true, true, false));
	var[0][0][1] = (bvec3(false, true, true));
	var[0][1][0] = (bvec3(false, true, true));
	var[0][1][1] = (bvec3(true, true, true));
	var[0][2][0] = (bvec3(false, false, true));
	var[0][2][1] = (bvec3(true, false, true));
	var[0][3][0] = (bvec3(true, true, false));
	var[0][3][1] = (bvec3(false, true, false));
	var[1][0][0] = (bvec3(false, false, false));
	var[1][0][1] = (bvec3(true, false, false));
	var[1][1][0] = (bvec3(true, true, true));
	var[1][1][1] = (bvec3(true, false, false));
	var[1][2][0] = (bvec3(false, false, false));
	var[1][2][1] = (bvec3(true, true, false));
	var[1][3][0] = (bvec3(false, true, false));
	var[1][3][1] = (bvec3(false, false, false));
	var[2][0][0] = (bvec3(true, true, true));
	var[2][0][1] = (bvec3(false, true, true));
	var[2][1][0] = (bvec3(false, true, false));
	var[2][1][1] = (bvec3(true, false, false));
	var[2][2][0] = (bvec3(false, false, true));
	var[2][2][1] = (bvec3(false, false, true));
	var[2][3][0] = (bvec3(true, true, false));
	var[2][3][1] = (bvec3(false, true, false));
}
#version 450
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
	allOk = compare_mat2x3(var[0][0][0], mat2x3(3.0, -1.0, 4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(7.0, 0.0, -3.0, 7.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-1.0, 9.0, -7.0, -1.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(6.0, -9.0, -4.0, 2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(0.0, -2.0, -7.0, 9.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(-6.0, 8.0, -1.0, 3.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(7.0, 5.0, -9.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(1.0, 4.0, -6.0, 3.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-3.0, -5.0, -4.0, -9.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(8.0, -6.0, -1.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(6.0, 0.0, -9.0, -8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(0.0, 1.0, -9.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(-5.0, -2.0, 3.0, -9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(4.0, 7.0, 0.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(1.0, -7.0, -5.0, -9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(4.0, 5.0, 5.0, 8.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-5.0, -2.0, 2.0, -7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(3.0, 5.0, 2.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-4.0, 5.0, -3.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(9.0, 8.0, 8.0, 5.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(4.0, 4.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(2.0, 4.0, 7.0, 9.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(-6.0, 0.0, -5.0, 2.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(-6.0, -8.0, -1.0, -8.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	var[0][0][1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	var[0][1][0] = (mat2x3(-2.0, -1.0, 6.0, 5.0, -8.0, 8.0));
	var[0][1][1] = (mat2x3(-3.0, 5.0, -8.0, -9.0, 9.0, 7.0));
	var[0][2][0] = (mat2x3(-1.0, -9.0, 3.0, -5.0, 2.0, 6.0));
	var[0][2][1] = (mat2x3(5.0, 8.0, 1.0, 0.0, 1.0, -3.0));
	var[0][3][0] = (mat2x3(-2.0, 1.0, -5.0, -3.0, -5.0, -9.0));
	var[0][3][1] = (mat2x3(3.0, 8.0, -9.0, 8.0, 6.0, 0.0));
	var[1][0][0] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
	var[1][0][1] = (mat2x3(9.0, 3.0, 8.0, 4.0, 4.0, 2.0));
	var[1][1][0] = (mat2x3(-3.0, -1.0, -2.0, 6.0, 2.0, -6.0));
	var[1][1][1] = (mat2x3(-7.0, 6.0, 7.0, -8.0, 5.0, -5.0));
	var[1][2][0] = (mat2x3(-5.0, -7.0, -6.0, -7.0, -8.0, -4.0));
	var[1][2][1] = (mat2x3(-9.0, 8.0, 1.0, -7.0, 4.0, 8.0));
	var[1][3][0] = (mat2x3(2.0, 3.0, 4.0, 3.0, 4.0, 2.0));
	var[1][3][1] = (mat2x3(-1.0, -4.0, 9.0, -8.0, 2.0, 8.0));
	var[2][0][0] = (mat2x3(4.0, -1.0, -6.0, -5.0, 9.0, 7.0));
	var[2][0][1] = (mat2x3(-1.0, -3.0, -1.0, 6.0, 4.0, 8.0));
	var[2][1][0] = (mat2x3(5.0, -1.0, 8.0, -7.0, -3.0, -4.0));
	var[2][1][1] = (mat2x3(-5.0, 3.0, -8.0, 9.0, -8.0, 3.0));
	var[2][2][0] = (mat2x3(3.0, -9.0, 6.0, 7.0, 2.0, -8.0));
	var[2][2][1] = (mat2x3(0.0, -7.0, -7.0, -2.0, 8.0, -5.0));
	var[2][3][0] = (mat2x3(6.0, -6.0, 4.0, -3.0, -1.0, -9.0));
	var[2][3][1] = (mat2x3(6.0, 3.0, -4.0, -2.0, 7.0, -7.0));
}
#version 450
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
	highp mat3x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-8.0, 1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-9.0, 9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(8.0, 5.0, 9.0, 6.0, -3.0, 4.0, 6.0, -8.0, -9.0, -2.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(1.0, 7.0, -6.0, 3.0, 2.0, 9.0, -9.0, 1.0, 0.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(-8.0, -4.0, 5.0, -8.0, -2.0, -1.0, -3.0, 5.0, 7.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(0.0, 0.0, -6.0, 6.0, -6.0, -9.0, 8.0, 2.0, 6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-5.0, 7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-5.0, -8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(8.0, 4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(1.0, 0.0, 9.0, -2.0, -2.0, 1.0, 8.0, 0.0, 0.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(9.0, -5.0, 2.0, 8.0, -5.0, -3.0, -6.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(-2.0, 4.0, -9.0, -3.0, -4.0, 1.0, -6.0, -1.0, -7.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(-5.0, -5.0, 3.0, 2.0, 1.0, -9.0, 5.0, -2.0, -9.0, 4.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-9.0, 6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-9.0, 7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(7.0, -3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(9.0, 2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(2.0, 0.0, -2.0, -7.0, 6.0, -9.0, 9.0, -6.0, 3.0, -2.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(-5.0, 4.0, 0.0, 2.0, 9.0, 7.0, -3.0, 3.0, 5.0, 2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-2.0, 4.0, -7.0, -4.0, 3.0, 6.0, 0.0, -2.0, -7.0, 2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(-8.0, 6.0, -6.0, 2.0, 7.0, 0.0, 4.0, -6.0, 5.0, 3.0, -8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	var[0][0][0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	var[0][0][0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	var[0][0][1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	var[0][0][1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	var[0][0][1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	var[0][1][0][0] = (vec4(-3.0, -3.0, 3.0, -7.0));
	var[0][1][0][1] = (vec4(2.0, 8.0, -4.0, 1.0));
	var[0][1][0][2] = (vec4(-1.0, 6.0, -4.0, 7.0));
	var[0][1][1][0] = (vec4(5.0, -8.0, -2.0, 6.0));
	var[0][1][1][1] = (vec4(-2.0, 8.0, -2.0, 2.0));
	var[0][1][1][2] = (vec4(3.0, 7.0, 0.0, 2.0));
	var[0][2][0][0] = (vec4(0.0, 7.0, 3.0, -7.0));
	var[0][2][0][1] = (vec4(-7.0, 7.0, -4.0, -5.0));
	var[0][2][0][2] = (vec4(-8.0, -8.0, -7.0, 4.0));
	var[0][2][1][0] = (vec4(6.0, -3.0, 8.0, -1.0));
	var[0][2][1][1] = (vec4(-4.0, 8.0, 8.0, 1.0));
	var[0][2][1][2] = (vec4(-8.0, -7.0, 5.0, -9.0));
	var[0][3][0][0] = (vec4(3.0, 0.0, -5.0, -4.0));
	var[0][3][0][1] = (vec4(-9.0, -4.0, 0.0, -5.0));
	var[0][3][0][2] = (vec4(-9.0, -9.0, 6.0, -4.0));
	var[0][3][1][0] = (vec4(-7.0, 0.0, 8.0, -6.0));
	var[0][3][1][1] = (vec4(-3.0, 8.0, 9.0, 3.0));
	var[0][3][1][2] = (vec4(7.0, -2.0, -6.0, -6.0));
	var[1][0][0][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	var[1][0][0][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	var[1][0][0][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
	var[1][0][1][0] = (vec4(8.0, -2.0, 1.0, 1.0));
	var[1][0][1][1] = (vec4(-6.0, -1.0, -9.0, 6.0));
	var[1][0][1][2] = (vec4(7.0, -1.0, 1.0, -8.0));
	var[1][1][0][0] = (vec4(3.0, 9.0, 8.0, 5.0));
	var[1][1][0][1] = (vec4(2.0, -3.0, -7.0, 2.0));
	var[1][1][0][2] = (vec4(-1.0, 1.0, -4.0, -1.0));
	var[1][1][1][0] = (vec4(-6.0, -4.0, -1.0, -3.0));
	var[1][1][1][1] = (vec4(-8.0, 5.0, -4.0, -9.0));
	var[1][1][1][2] = (vec4(8.0, 3.0, -8.0, 0.0));
	var[1][2][0][0] = (vec4(1.0, -8.0, 2.0, -2.0));
	var[1][2][0][1] = (vec4(-8.0, -9.0, 1.0, -3.0));
	var[1][2][0][2] = (vec4(-4.0, 3.0, -9.0, 6.0));
	var[1][2][1][0] = (vec4(-8.0, 3.0, -5.0, 6.0));
	var[1][2][1][1] = (vec4(9.0, 2.0, -1.0, 8.0));
	var[1][2][1][2] = (vec4(-2.0, 5.0, -2.0, 6.0));
	var[1][3][0][0] = (vec4(6.0, -9.0, 2.0, 0.0));
	var[1][3][0][1] = (vec4(9.0, 5.0, 5.0, 7.0));
	var[1][3][0][2] = (vec4(8.0, 2.0, 1.0, -1.0));
	var[1][3][1][0] = (vec4(-4.0, 6.0, -3.0, 4.0));
	var[1][3][1][1] = (vec4(9.0, 0.0, -2.0, -7.0));
	var[1][3][1][2] = (vec4(4.0, 7.0, 8.0, 6.0));
	var[2][0][0][0] = (vec4(6.0, 8.0, -2.0, 7.0));
	var[2][0][0][1] = (vec4(1.0, -6.0, -3.0, 9.0));
	var[2][0][0][2] = (vec4(1.0, -6.0, 1.0, -6.0));
	var[2][0][1][0] = (vec4(3.0, -1.0, 5.0, -2.0));
	var[2][0][1][1] = (vec4(7.0, -1.0, -2.0, -3.0));
	var[2][0][1][2] = (vec4(-6.0, 4.0, -4.0, -1.0));
	var[2][1][0][0] = (vec4(7.0, -2.0, 0.0, 8.0));
	var[2][1][0][1] = (vec4(-9.0, 2.0, -3.0, -7.0));
	var[2][1][0][2] = (vec4(-5.0, 3.0, 9.0, -6.0));
	var[2][1][1][0] = (vec4(-7.0, -8.0, -8.0, -7.0));
	var[2][1][1][1] = (vec4(-9.0, 2.0, 4.0, -7.0));
	var[2][1][1][2] = (vec4(8.0, -7.0, 4.0, -8.0));
	var[2][2][0][0] = (vec4(1.0, 2.0, 8.0, -3.0));
	var[2][2][0][1] = (vec4(6.0, -3.0, -8.0, 2.0));
	var[2][2][0][2] = (vec4(-6.0, -8.0, 3.0, 3.0));
	var[2][2][1][0] = (vec4(0.0, 9.0, 4.0, -8.0));
	var[2][2][1][1] = (vec4(-7.0, 6.0, -4.0, -8.0));
	var[2][2][1][2] = (vec4(2.0, 9.0, 1.0, 0.0));
	var[2][3][0][0] = (vec4(-1.0, -3.0, 7.0, 5.0));
	var[2][3][0][1] = (vec4(-4.0, -6.0, 0.0, -2.0));
	var[2][3][0][2] = (vec4(-6.0, 2.0, 3.0, 4.0));
	var[2][3][1][0] = (vec4(-6.0, -1.0, 1.0, -2.0));
	var[2][3][1][1] = (vec4(2.0, -6.0, -2.0, 3.0));
	var[2][3][1][2] = (vec4(-8.0, 4.0, -4.0, 7.0));
}
#version 450
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
	highp mat4x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(1.0, -2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(5.0, -9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(3.0, -6.0, 9.0, 8.0, -1.0, 8.0, -4.0, 2.0, 6.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(5.0, -1.0, 4.0, 2.0, -4.0, -2.0, -1.0, -4.0, 5.0, 9.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(0.0, 1.0, 5.0, -8.0, -8.0, 0.0, -9.0, 5.0, 2.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(5.0, -4.0, 3.0, -9.0, 3.0, 4.0, -2.0, 4.0, 4.0, 2.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-9.0, 3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-1.0, -2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(5.0, 4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(2.0, -6.0, -1.0, 6.0, 9.0, -3.0, -8.0, 7.0, -5.0, 0.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(7.0, -5.0, -4.0, -3.0, 5.0, 8.0, 9.0, -5.0, -5.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(-2.0, 0.0, 6.0, 2.0, -9.0, 3.0, 3.0, -4.0, 5.0, -3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(8.0, -9.0, -9.0, -6.0, 7.0, -8.0, 3.0, 0.0, -3.0, 3.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(9.0, -8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(-3.0, -2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-1.0, 6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(1.0, 6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(9.0, -2.0, 0.0, 1.0, -8.0, -4.0, -9.0, 3.0, -1.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(-5.0, 1.0, 6.0, 5.0, 6.0, -1.0, -1.0, 1.0, -6.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(-6.0, 1.0, 6.0, -1.0, 3.0, -4.0, 7.0, -7.0, -6.0, -3.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(-8.0, -1.0, 9.0, -6.0, 8.0, -4.0, -1.0, 0.0, -5.0, 0.0, -6.0, -2.0)) && allOk;
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
	var[0][1][0][0] = (vec3(-7.0, -7.0, -7.0));
	var[0][1][0][1] = (vec3(6.0, -9.0, 3.0));
	var[0][1][0][2] = (vec3(-5.0, 2.0, 4.0));
	var[0][1][0][3] = (vec3(-2.0, -4.0, -6.0));
	var[0][1][1][0] = (vec3(-1.0, 5.0, 5.0));
	var[0][1][1][1] = (vec3(-9.0, -3.0, -9.0));
	var[0][1][1][2] = (vec3(3.0, 2.0, 0.0));
	var[0][1][1][3] = (vec3(0.0, -9.0, 7.0));
	var[0][2][0][0] = (vec3(-5.0, -6.0, -3.0));
	var[0][2][0][1] = (vec3(-2.0, 5.0, 8.0));
	var[0][2][0][2] = (vec3(2.0, -9.0, 7.0));
	var[0][2][0][3] = (vec3(7.0, -3.0, 4.0));
	var[0][2][1][0] = (vec3(9.0, 4.0, 1.0));
	var[0][2][1][1] = (vec3(5.0, -9.0, 2.0));
	var[0][2][1][2] = (vec3(-7.0, -3.0, -9.0));
	var[0][2][1][3] = (vec3(9.0, -6.0, 3.0));
	var[0][3][0][0] = (vec3(-4.0, -7.0, 3.0));
	var[0][3][0][1] = (vec3(6.0, 4.0, 1.0));
	var[0][3][0][2] = (vec3(-3.0, 3.0, 8.0));
	var[0][3][0][3] = (vec3(-6.0, 5.0, -6.0));
	var[0][3][1][0] = (vec3(3.0, 2.0, 3.0));
	var[0][3][1][1] = (vec3(1.0, -7.0, 3.0));
	var[0][3][1][2] = (vec3(6.0, -3.0, -2.0));
	var[0][3][1][3] = (vec3(3.0, 1.0, -1.0));
	var[1][0][0][0] = (vec3(5.0, -5.0, 7.0));
	var[1][0][0][1] = (vec3(-4.0, 8.0, -3.0));
	var[1][0][0][2] = (vec3(-2.0, 0.0, 8.0));
	var[1][0][0][3] = (vec3(-2.0, 6.0, -3.0));
	var[1][0][1][0] = (vec3(-9.0, -2.0, -2.0));
	var[1][0][1][1] = (vec3(7.0, 9.0, -4.0));
	var[1][0][1][2] = (vec3(3.0, 1.0, 0.0));
	var[1][0][1][3] = (vec3(-9.0, -2.0, -7.0));
	var[1][1][0][0] = (vec3(5.0, -5.0, -2.0));
	var[1][1][0][1] = (vec3(6.0, 5.0, -4.0));
	var[1][1][0][2] = (vec3(-2.0, 9.0, -3.0));
	var[1][1][0][3] = (vec3(2.0, 5.0, -4.0));
	var[1][1][1][0] = (vec3(6.0, 4.0, 7.0));
	var[1][1][1][1] = (vec3(1.0, -4.0, -6.0));
	var[1][1][1][2] = (vec3(4.0, -6.0, -5.0));
	var[1][1][1][3] = (vec3(5.0, 6.0, -1.0));
	var[1][2][0][0] = (vec3(-9.0, -4.0, 0.0));
	var[1][2][0][1] = (vec3(5.0, 8.0, 9.0));
	var[1][2][0][2] = (vec3(-7.0, -9.0, -5.0));
	var[1][2][0][3] = (vec3(0.0, -1.0, -6.0));
	var[1][2][1][0] = (vec3(-9.0, -9.0, 9.0));
	var[1][2][1][1] = (vec3(9.0, -1.0, 8.0));
	var[1][2][1][2] = (vec3(8.0, -8.0, 4.0));
	var[1][2][1][3] = (vec3(9.0, -8.0, 8.0));
	var[1][3][0][0] = (vec3(0.0, 9.0, -4.0));
	var[1][3][0][1] = (vec3(6.0, -5.0, 0.0));
	var[1][3][0][2] = (vec3(-2.0, 4.0, 6.0));
	var[1][3][0][3] = (vec3(-5.0, 2.0, 4.0));
	var[1][3][1][0] = (vec3(-4.0, -4.0, 0.0));
	var[1][3][1][1] = (vec3(-2.0, 5.0, 7.0));
	var[1][3][1][2] = (vec3(8.0, 8.0, -3.0));
	var[1][3][1][3] = (vec3(-9.0, -7.0, 5.0));
	var[2][0][0][0] = (vec3(-5.0, -6.0, 5.0));
	var[2][0][0][1] = (vec3(-2.0, -7.0, 5.0));
	var[2][0][0][2] = (vec3(-2.0, -6.0, 4.0));
	var[2][0][0][3] = (vec3(9.0, 5.0, -9.0));
	var[2][0][1][0] = (vec3(-3.0, 3.0, 7.0));
	var[2][0][1][1] = (vec3(3.0, -4.0, -8.0));
	var[2][0][1][2] = (vec3(-2.0, 2.0, -1.0));
	var[2][0][1][3] = (vec3(1.0, -9.0, 9.0));
	var[2][1][0][0] = (vec3(6.0, 3.0, -9.0));
	var[2][1][0][1] = (vec3(-7.0, 3.0, -4.0));
	var[2][1][0][2] = (vec3(1.0, 2.0, 6.0));
	var[2][1][0][3] = (vec3(-2.0, 3.0, 7.0));
	var[2][1][1][0] = (vec3(-5.0, 8.0, -9.0));
	var[2][1][1][1] = (vec3(-4.0, -1.0, -9.0));
	var[2][1][1][2] = (vec3(5.0, 5.0, 6.0));
	var[2][1][1][3] = (vec3(-8.0, 1.0, -7.0));
	var[2][2][0][0] = (vec3(4.0, 6.0, 1.0));
	var[2][2][0][1] = (vec3(-9.0, 7.0, 3.0));
	var[2][2][0][2] = (vec3(-4.0, -3.0, 8.0));
	var[2][2][0][3] = (vec3(-9.0, -9.0, 2.0));
	var[2][2][1][0] = (vec3(0.0, -2.0, 5.0));
	var[2][2][1][1] = (vec3(8.0, 4.0, -4.0));
	var[2][2][1][2] = (vec3(5.0, 4.0, -5.0));
	var[2][2][1][3] = (vec3(0.0, -3.0, 9.0));
	var[2][3][0][0] = (vec3(6.0, -7.0, -2.0));
	var[2][3][0][1] = (vec3(0.0, 3.0, -5.0));
	var[2][3][0][2] = (vec3(-6.0, -7.0, -4.0));
	var[2][3][0][3] = (vec3(-8.0, 1.0, -7.0));
	var[2][3][1][0] = (vec3(2.0, -4.0, -7.0));
	var[2][3][1][1] = (vec3(-3.0, -4.0, 0.0));
	var[2][3][1][2] = (vec3(-8.0, -2.0, 6.0));
	var[2][3][1][3] = (vec3(-7.0, -7.0, 2.0));
}
#version 450
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
	i8vec4 var[][4][2];
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(var[0][0][0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][0][1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][1][0]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][1][1]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][2][0]), ivec4(4294967293, 4294967294, 4, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][2][1]), ivec4(4294967289, 6, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][3][0]), ivec4(4294967287, 4294967291, 5, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][3][1]), ivec4(3, 4294967287, 4294967291, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][0][0]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][0][1]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][1][0]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][1][1]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][2][0]), ivec4(4294967290, 4294967289, 4294967295, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][2][1]), ivec4(4294967293, 4294967287, 4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][3][0]), ivec4(4294967291, 8, 0, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][3][1]), ivec4(6, 4294967288, 3, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][0][0]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][0][1]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][1][0]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][1][1]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][2][0]), ivec4(5, 4294967290, 4294967294, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][2][1]), ivec4(9, 3, 7, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][3][0]), ivec4(4, 4294967290, 7, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][3][1]), ivec4(0, 5, 8, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	var[0][0][1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	var[0][1][0] = i8vec4(ivec4(8, 5, 4, 5));
	var[0][1][1] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	var[0][2][0] = i8vec4(ivec4(3, 4294967293, 4294967290, 4294967290));
	var[0][2][1] = i8vec4(ivec4(8, 4294967289, 4294967292, 2));
	var[0][3][0] = i8vec4(ivec4(1, 0, 5, 0));
	var[0][3][1] = i8vec4(ivec4(4294967293, 0, 4294967294, 6));
	var[1][0][0] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	var[1][0][1] = i8vec4(ivec4(6, 4, 9, 4294967287));
	var[1][1][0] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	var[1][1][1] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	var[1][2][0] = i8vec4(ivec4(4294967295, 9, 4294967295, 6));
	var[1][2][1] = i8vec4(ivec4(6, 4294967289, 4294967293, 4294967289));
	var[1][3][0] = i8vec4(ivec4(6, 1, 0, 2));
	var[1][3][1] = i8vec4(ivec4(6, 1, 9, 4294967291));
	var[2][0][0] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	var[2][0][1] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	var[2][1][0] = i8vec4(ivec4(2, 5, 4, 6));
	var[2][1][1] = i8vec4(ivec4(4294967292, 7, 8, 9));
	var[2][2][0] = i8vec4(ivec4(6, 7, 5, 5));
	var[2][2][1] = i8vec4(ivec4(4294967291, 4, 3, 4294967290));
	var[2][3][0] = i8vec4(ivec4(4294967295, 0, 3, 9));
	var[2][3][1] = i8vec4(ivec4(2, 7, 7, 4294967293));
}
#version 450
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
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c;
};
layout(std430, binding = 1) buffer Block
{
	lowp uint u;
	S s[3];
	mediump vec4 v;
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
	allOk = compare_ivec3((s[0].a), ivec3(2, -1, -2)) && allOk;
	allOk = compare_mat3(s[0].b[0], mat3(2.0, 5.0, -3.0, -2.0, -3.0, -7.0, 7.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(s[0].b[1], mat3(8.0, 8.0, 1.0, -5.0, -8.0, -8.0, -8.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3(s[0].b[2], mat3(-8.0, -7.0, 8.0, -2.0, -6.0, -6.0, -8.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(s[0].b[3], mat3(9.0, 9.0, -7.0, -1.0, 5.0, -4.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_vec4((s[0].c), vec4(1.0, 6.0, 1.0, 4.0)) && allOk;
	allOk = compare_ivec3((s[1].a), ivec3(7, 2, 9)) && allOk;
	allOk = compare_mat3(s[1].b[0], mat3(-5.0, -4.0, 9.0, 5.0, 0.0, 4.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat3(s[1].b[1], mat3(-6.0, -8.0, -7.0, 2.0, 7.0, -1.0, -5.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(s[1].b[2], mat3(6.0, 8.0, -5.0, 6.0, 0.0, 4.0, 5.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3(s[1].b[3], mat3(8.0, 2.0, 8.0, -7.0, -2.0, 4.0, -2.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec4((s[1].c), vec4(3.0, 9.0, -2.0, -3.0)) && allOk;
	allOk = compare_ivec3((s[2].a), ivec3(0, 5, 4)) && allOk;
	allOk = compare_mat3(s[2].b[0], mat3(4.0, -8.0, 5.0, 4.0, 9.0, -3.0, 5.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(s[2].b[1], mat3(0.0, -6.0, 6.0, -2.0, -8.0, 9.0, -8.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(s[2].b[2], mat3(5.0, 6.0, 1.0, 9.0, -1.0, 7.0, -4.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3(s[2].b[3], mat3(-4.0, -9.0, -3.0, -3.0, 6.0, 1.0, -4.0, 3.0, 8.0)) && allOk;
	allOk = compare_vec4((s[2].c), vec4(-3.0, -2.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s[0].a = (ivec3(0, 1, 6));
	s[0].b[0][0] = (vec3(4.0, -5.0, 1.0));
	s[0].b[0][1] = (vec3(8.0, -2.0, -1.0));
	s[0].b[0][2] = (vec3(-5.0, -4.0, -2.0));
	s[0].b[1][0] = (vec3(0.0, 2.0, 6.0));
	s[0].b[1][1] = (vec3(8.0, 8.0, 8.0));
	s[0].b[1][2] = (vec3(9.0, 9.0, -4.0));
	s[0].b[2][0] = (vec3(4.0, -1.0, -8.0));
	s[0].b[2][1] = (vec3(7.0, 3.0, -6.0));
	s[0].b[2][2] = (vec3(4.0, -9.0, -1.0));
	s[0].b[3][0] = (vec3(8.0, 7.0, 2.0));
	s[0].b[3][1] = (vec3(7.0, -5.0, 3.0));
	s[0].b[3][2] = (vec3(-9.0, 7.0, -2.0));
	s[0].c = (vec4(7.0, -8.0, 3.0, 0.0));
	s[1].a = (ivec3(-6, 5, 6));
	s[1].b[0][0] = (vec3(-2.0, 9.0, 3.0));
	s[1].b[0][1] = (vec3(-8.0, -5.0, 2.0));
	s[1].b[0][2] = (vec3(9.0, 4.0, -2.0));
	s[1].b[1][0] = (vec3(-1.0, -6.0, -1.0));
	s[1].b[1][1] = (vec3(1.0, -4.0, 6.0));
	s[1].b[1][2] = (vec3(5.0, -4.0, 4.0));
	s[1].b[2][0] = (vec3(-1.0, 1.0, -5.0));
	s[1].b[2][1] = (vec3(-4.0, -9.0, 1.0));
	s[1].b[2][2] = (vec3(-3.0, -1.0, 1.0));
	s[1].b[3][0] = (vec3(2.0, -7.0, -3.0));
	s[1].b[3][1] = (vec3(-9.0, -3.0, 0.0));
	s[1].b[3][2] = (vec3(4.0, 5.0, -8.0));
	s[1].c = (vec4(-9.0, -8.0, -7.0, 5.0));
	s[2].a = (ivec3(-9, 8, 1));
	s[2].b[0][0] = (vec3(6.0, 5.0, -3.0));
	s[2].b[0][1] = (vec3(2.0, 0.0, 1.0));
	s[2].b[0][2] = (vec3(6.0, -2.0, -7.0));
	s[2].b[1][0] = (vec3(3.0, -6.0, -2.0));
	s[2].b[1][1] = (vec3(2.0, 5.0, -9.0));
	s[2].b[1][2] = (vec3(3.0, -7.0, 8.0));
	s[2].b[2][0] = (vec3(5.0, -6.0, 4.0));
	s[2].b[2][1] = (vec3(1.0, -9.0, 6.0));
	s[2].b[2][2] = (vec3(5.0, -1.0, -5.0));
	s[2].b[3][0] = (vec3(4.0, 8.0, 2.0));
	s[2].b[3][1] = (vec3(1.0, 2.0, -9.0));
	s[2].b[3][2] = (vec3(-5.0, -6.0, 1.0));
	s[2].c = (vec4(-7.0, 1.0, 3.0, -9.0));
	v = (vec4(8.0, 5.0, -6.0, -7.0));
}
#version 450
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
layout(scalar, binding = 1) buffer Block
{
	S s;
	lowp vec2 v;
	T t[2];
	highp uint u;
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
	allOk = compare_mat3(t[0].a, mat3(0.0, -7.0, 8.0, -4.0, 6.0, -2.0, -9.0, -2.0, 8.0)) && allOk;
	allOk = compare_ivec3((t[0].b[0].a), ivec3(8, -7, 9)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[0]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[1]), ivec2(4, 0)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[2]), ivec2(0, 5)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[3]), ivec2(-2, 8)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(-2.0, 8.0, 6.0, -9.0)) && allOk;
	allOk = compare_ivec3((t[0].b[1].a), ivec3(2, -9, 4)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[0]), ivec2(1, 6)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[1]), ivec2(9, -8)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[2]), ivec2(5, -6)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[3]), ivec2(8, -9)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(3.0, 4.0, -6.0, -6.0)) && allOk;
	allOk = compare_ivec3((t[0].b[2].a), ivec3(-3, -7, -6)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[0]), ivec2(5, -1)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[1]), ivec2(8, 5)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[2]), ivec2(-2, -1)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[3]), ivec2(8, 1)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(-1.0, -5.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(t[1].a, mat3(4.0, -2.0, -2.0, -1.0, 7.0, 2.0, 6.0, 0.0, 9.0)) && allOk;
	allOk = compare_ivec3((t[1].b[0].a), ivec3(8, -7, -3)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[0]), ivec2(4, -7)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[1]), ivec2(5, 1)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[2]), ivec2(4, 0)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[3]), ivec2(-8, 5)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(9.0, -7.0, -6.0, -1.0)) && allOk;
	allOk = compare_ivec3((t[1].b[1].a), ivec3(2, -3, -2)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[0]), ivec2(0, 6)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[1]), ivec2(9, 5)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[2]), ivec2(-6, -8)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[3]), ivec2(-3, -7)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_ivec3((t[1].b[2].a), ivec3(9, -9, -8)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[0]), ivec2(8, -6)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[1]), ivec2(-9, -6)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[2]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[3]), ivec2(3, -4)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(9.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_uint((u), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(2, -3, 7));
	s.b[0] = (ivec2(0, -9));
	s.b[1] = (ivec2(6, 1));
	s.b[2] = (ivec2(-9, -8));
	s.b[3] = (ivec2(-6, 5));
	s.c = (vec4(4.0, -2.0, -8.0, 3.0));
	u = (9u);
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 4.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-2.0, 7.0, 9.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(1.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(3.0, 7.0, 4.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -5.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-8.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(7.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(7.0, -1.0, -5.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 8.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-2.0, 2.0, -3.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-3.0, 1.0, -3.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(-8.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	block[1].var = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	block[2].var = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
}
#version 450
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
	highp mat2x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(block[0].var, mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(2.0, 1.0, 7.0, 1.0));
	block[0].var[1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	block[1].var[0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	block[1].var[1] = (vec4(7.0, -4.0, 8.0, -2.0));
	block[2].var[0] = (vec4(2.0, 5.0, -2.0, 1.0));
	block[2].var[1] = (vec4(1.0, 0.0, -4.0, 1.0));
}
#version 450
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
	highp mat2x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 8.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-9.0, -2.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][3], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -3.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-4.0, 1.0, 0.0, -7.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -1.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(5.0, 4.0, -2.0, 4.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(2.0, -4.0, 5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	block[0].var[1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block[1].var[0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	block[1].var[1] = (vec4(1.0, 7.0, 0.0, 9.0));
	block[2].var[0] = (vec4(8.0, 6.0, -7.0, -4.0));
	block[2].var[1] = (vec4(-6.0, 5.0, 5.0, -6.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(block[0].var), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block[1].var), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block[2].var), vec3(4.0, 2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = f16vec3(vec3(3.0, 3.0, 7.0));
	block[1].var = f16vec3(vec3(-3.0, -5.0, -9.0));
	block[2].var = f16vec3(vec3(-1.0, 0.0, 6.0));
}
#version 450
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
	highp mat2x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(block[0].var, mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(4.0, -6.0, -9.0, -3.0));
	block[0].var[1] = (vec4(5.0, 1.0, -7.0, 1.0));
	block[1].var[0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	block[1].var[1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	block[2].var[0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	block[2].var[1] = (vec4(-7.0, 5.0, 8.0, 4.0));
}
#version 450
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
	highp mat3x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 0.0) && allOk;
	allOk = compare_mat3x2(block[0].var, mat3x2(5.0, 2.0, -5.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_float((block[1].padding), -9.0) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(-5.0, 3.0, -3.0, 6.0, 0.0, -2.0)) && allOk;
	allOk = compare_float((block[2].padding), -3.0) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(-9.0, 8.0, 6.0, 1.0, -4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-2.0);
	block[0].var[0] = (vec2(1.0, 8.0));
	block[0].var[1] = (vec2(-7.0, 5.0));
	block[0].var[2] = (vec2(8.0, 2.0));
	block[1].padding = (-3.0);
	block[1].var[0] = (vec2(2.0, -5.0));
	block[1].var[1] = (vec2(0.0, 6.0));
	block[1].var[2] = (vec2(1.0, 6.0));
	block[2].padding = (-5.0);
	block[2].var[0] = (vec2(3.0, -8.0));
	block[2].var[1] = (vec2(5.0, 3.0));
	block[2].var[2] = (vec2(9.0, 3.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 3.0) && allOk;
	allOk = compare_mat4x3(block[0].var, mat4x3(5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0, 9.0, 5.0, -9.0)) && allOk;
	allOk = compare_float((block[1].padding), 6.0) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(0.0, 3.0, -4.0, 2.0, 0.0, -9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 6.0)) && allOk;
	allOk = compare_float((block[2].padding), 8.0) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(-9.0, -8.0, 2.0, 8.0, 7.0, -4.0, 1.0, 3.0, -5.0, -4.0, 7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-5.0);
	block[0].var = (mat4x3(-5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0, 9.0, 2.0, -5.0));
	block[1].padding = (-6.0);
	block[1].var = (mat4x3(-6.0, -1.0, -4.0, 3.0, 9.0, -1.0, 2.0, 4.0, 4.0, 1.0, 3.0, -9.0));
	block[2].padding = (-9.0);
	block[2].var = (mat4x3(6.0, -5.0, -5.0, 2.0, 8.0, 9.0, -8.0, -5.0, -3.0, -6.0, -7.0, 2.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 3.0) && allOk;
	allOk = compare_mat4x3(block[0].var, mat4x3(6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0, -1.0)) && allOk;
	allOk = compare_float((block[1].padding), 1.0) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0, 9.0, 4.0)) && allOk;
	allOk = compare_float((block[2].padding), 5.0) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(-9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0, -5.0, -5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (1.0);
	block[0].var[0] = (vec3(2.0, -5.0, -3.0));
	block[0].var[1] = (vec3(-2.0, 2.0, -5.0));
	block[0].var[2] = (vec3(9.0, 4.0, 2.0));
	block[0].var[3] = (vec3(-4.0, 9.0, 8.0));
	block[1].padding = (-4.0);
	block[1].var[0] = (vec3(-5.0, -5.0, 6.0));
	block[1].var[1] = (vec3(8.0, -7.0, 4.0));
	block[1].var[2] = (vec3(-8.0, -1.0, 1.0));
	block[1].var[3] = (vec3(1.0, -4.0, 5.0));
	block[2].padding = (7.0);
	block[2].var[0] = (vec3(9.0, 5.0, -7.0));
	block[2].var[1] = (vec3(8.0, 9.0, 0.0));
	block[2].var[2] = (vec3(-3.0, 3.0, 0.0));
	block[2].var[3] = (vec3(7.0, -8.0, -7.0));
}
#version 450
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
	float16_t var;
} block[3];

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block[0].var), -7.0) && allOk;
	allOk = compare_float16_t(float(block[1].var), 4.0) && allOk;
	allOk = compare_float16_t(float(block[2].var), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = float16_t(-8.0);
	block[1].var = float16_t(9.0);
	block[2].var = float16_t(-2.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
} blockA[3];
layout(std430, binding = 2) buffer BlockB
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c;
	bool d;
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
	allOk = compare_float((blockA[0].a), -9.0) && allOk;
	allOk = compare_float(blockA[0].c[0][0], 5.0) && allOk;
	allOk = compare_float(blockA[0].c[0][1], 0.0) && allOk;
	allOk = compare_float(blockA[0].c[1][0], -2.0) && allOk;
	allOk = compare_float(blockA[0].c[1][1], -5.0) && allOk;
	allOk = compare_vec2(blockA[0].c[0], vec2(5.0, 0.0)) && allOk;
	allOk = compare_vec2(blockA[0].c[1], vec2(-2.0, -5.0)) && allOk;
	allOk = compare_float((blockA[1].a), -5.0) && allOk;
	allOk = compare_float(blockA[1].c[0][0], -8.0) && allOk;
	allOk = compare_float(blockA[1].c[0][1], -9.0) && allOk;
	allOk = compare_float(blockA[1].c[1][0], -8.0) && allOk;
	allOk = compare_float(blockA[1].c[1][1], -2.0) && allOk;
	allOk = compare_vec2(blockA[1].c[0], vec2(-8.0, -9.0)) && allOk;
	allOk = compare_vec2(blockA[1].c[1], vec2(-8.0, -2.0)) && allOk;
	allOk = compare_float((blockA[2].a), -9.0) && allOk;
	allOk = compare_float(blockA[2].c[0][0], 3.0) && allOk;
	allOk = compare_float(blockA[2].c[0][1], 0.0) && allOk;
	allOk = compare_float(blockA[2].c[1][0], -2.0) && allOk;
	allOk = compare_float(blockA[2].c[1][1], 3.0) && allOk;
	allOk = compare_vec2(blockA[2].c[0], vec2(3.0, 0.0)) && allOk;
	allOk = compare_vec2(blockA[2].c[1], vec2(-2.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(3, -1)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(8, 4)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(-3, -9)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-3.0);
	blockA[1].a = (9.0);
	blockA[2].a = (4.0);
	blockB[0].a = (mat3(6.0, -9.0, 8.0, 2.0, -2.0, -9.0, -2.0, 1.0, 2.0));
	blockB[0].d = (true);
	blockB[1].a = (mat3(5.0, 3.0, 3.0, 7.0, -2.0, -3.0, -5.0, -8.0, 9.0));
	blockB[1].d = (true);
	blockB[2].a = (mat3(-7.0, 7.0, 5.0, 2.0, -7.0, 6.0, 1.0, 3.0, 6.0));
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
} blockA;
layout(std140, binding = 2) buffer BlockB
{
	mediump mat2 a;
	T b;
	bvec4 c;
	bool d;
} blockB;

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
	allOk = compare_float((blockA.a), 4.0) && allOk;
	allOk = compare_uint((blockB.b.a), 0u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(7.0, -4.0, -9.0, 3.0, -7.0, -7.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(9, 0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(5, 8)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(-7, 3)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(4.0, 6.0, -9.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-6.0);
	blockA.b.a[0] = (vec3(-2.0, 3.0, 4.0));
	blockA.b.a[1] = (vec3(0.0, -1.0, -9.0));
	blockA.b.a[2] = (vec3(-8.0, 0.0, 7.0));
	blockA.b.b[0] = (ivec2(2, 7));
	blockA.b.b[1] = (ivec2(-7, 5));
	blockA.b.b[2] = (ivec2(1, -7));
	blockA.b.b[3] = (ivec2(-6, -4));
	blockA.b.c = (vec4(-5.0, 1.0, -1.0, 7.0));
	blockB.a[0] = (vec2(7.0, 1.0));
	blockB.a[1] = (vec2(-5.0, 3.0));
	blockB.b.a = (9u);
	blockB.b.b.a[0] = (vec3(9.0, -2.0, -6.0));
	blockB.b.b.a[1] = (vec3(1.0, 1.0, -5.0));
	blockB.b.b.a[2] = (vec3(-7.0, 4.0, 7.0));
	blockB.b.b.b[0] = (ivec2(-6, 2));
	blockB.b.b.b[1] = (ivec2(7, 6));
	blockB.b.b.b[2] = (ivec2(-1, -3));
	blockB.b.b.b[3] = (ivec2(7, 8));
	blockB.b.b.c = (vec4(-8.0, -1.0, -2.0, 9.0));
	blockB.b.c = (bvec4(false, true, false, true));
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
	allOk = compare_float((blockA[0].a), -9.0) && allOk;
	allOk = compare_float((blockA[1].a), -1.0) && allOk;
	allOk = compare_float((blockA[2].a), 4.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(-8.0, -2.0, -4.0, -2.0, -3.0, -9.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(2, 6)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(3, -4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(-5, 3)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(-1, -3)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(-3.0, 0.0, 3.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b.a), 6u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(6.0, -3.0, -6.0, 8.0, -2.0, -6.0, 2.0, 1.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(-2, -4)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(-3, 9)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(-4, -8)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(7, -5)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(0.0, 3.0, 8.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_uint((blockB[2].b.a), 4u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(5.0, 4.0, 9.0, -4.0, 8.0, 0.0, -1.0, 1.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(1, 5)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(-9, -3)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(-3, 5)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(2.0, 1.0, -1.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-3.0);
	blockA[0].b.a = (mat3(-4.0, 7.0, 5.0, 3.0, -9.0, -1.0, 5.0, 9.0, -5.0));
	blockA[0].b.b[0] = (ivec2(5, 7));
	blockA[0].b.b[1] = (ivec2(-1, -8));
	blockA[0].b.b[2] = (ivec2(-6, -1));
	blockA[0].b.b[3] = (ivec2(4, 9));
	blockA[0].b.c = (vec4(-7.0, -5.0, -1.0, 5.0));
	blockA[1].a = (-9.0);
	blockA[1].b.a = (mat3(8.0, 2.0, -2.0, -9.0, -2.0, 1.0, 2.0, -1.0, 5.0));
	blockA[1].b.b[0] = (ivec2(-4, 6));
	blockA[1].b.b[1] = (ivec2(8, -8));
	blockA[1].b.b[2] = (ivec2(4, 0));
	blockA[1].b.b[3] = (ivec2(5, 3));
	blockA[1].b.c = (vec4(3.0, 7.0, -2.0, -3.0));
	blockA[2].a = (4.0);
	blockA[2].b.a = (mat3(-6.0, 1.0, -4.0, -2.0, 9.0, 6.0, -3.0, -7.0, 7.0));
	blockA[2].b.b[0] = (ivec2(5, 2));
	blockA[2].b.b[1] = (ivec2(-7, 6));
	blockA[2].b.b[2] = (ivec2(1, 3));
	blockA[2].b.b[3] = (ivec2(6, -6));
	blockA[2].b.c = (vec4(5.0, -6.0, 3.0, 5.0));
	blockB[0].a = (mat2(-5.0, 6.0, -2.0, 8.0));
	blockB[0].b.a = (2u);
	blockB[0].b.b.a = (mat3(1.0, 7.0, -9.0, 9.0, 8.0, -9.0, 6.0, 0.0, 0.0));
	blockB[0].b.b.b[0] = (ivec2(7, 1));
	blockB[0].b.b.b[1] = (ivec2(-9, -1));
	blockB[0].b.b.b[2] = (ivec2(-3, 1));
	blockB[0].b.b.b[3] = (ivec2(9, 0));
	blockB[0].b.b.c = (vec4(9.0, 7.0, -1.0, 0.0));
	blockB[0].b.c = (bvec4(true, true, false, true));
	blockB[0].d = (true);
	blockB[1].a = (mat2(-1.0, -8.0, 6.0, 0.0));
	blockB[1].b.a = (3u);
	blockB[1].b.b.a = (mat3(-5.0, -6.0, 8.0, -2.0, 4.0, -6.0, -4.0, 9.0, 1.0));
	blockB[1].b.b.b[0] = (ivec2(0, 7));
	blockB[1].b.b.b[1] = (ivec2(-2, 1));
	blockB[1].b.b.b[2] = (ivec2(-6, 2));
	blockB[1].b.b.b[3] = (ivec2(6, -8));
	blockB[1].b.b.c = (vec4(4.0, -9.0, -8.0, -1.0));
	blockB[1].b.c = (bvec4(true, false, false, true));
	blockB[1].d = (true);
	blockB[2].a = (mat2(-2.0, 4.0, -5.0, 9.0));
	blockB[2].b.a = (6u);
	blockB[2].b.b.a = (mat3(1.0, 5.0, -4.0, 9.0, 7.0, -9.0, -9.0, 1.0, 5.0));
	blockB[2].b.b.b[0] = (ivec2(5, -8));
	blockB[2].b.b.b[1] = (ivec2(8, 7));
	blockB[2].b.b.b[2] = (ivec2(4, -3));
	blockB[2].b.b.b[3] = (ivec2(-7, 4));
	blockB[2].b.b.c = (vec4(9.0, 9.0, 4.0, -6.0));
	blockB[2].b.c = (bvec4(false, true, true, true));
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
	mediump ivec4 a;
	mediump mat4x3 b;
	bvec3 c;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	bool d;
	lowp mat2 e;
	bool f;
	mediump uvec4 g;
	highp int h;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	highp mat4x3 i;
	mediump ivec3 j[1];
};
layout(std430, column_major, binding = 4) buffer BlockE
{
	mediump uvec2 k;
	bvec4 l;
	lowp uvec2 m[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.c), bvec3(false, true, false)) && allOk;
	allOk = compare_mat2(blockC.e, mat2(0.0, 2.0, 5.0, 6.0)) && allOk;
	allOk = compare_bool((blockC.f), false) && allOk;
	allOk = compare_uvec4((blockC.g), uvec4(8u, 4u, 9u, 4u)) && allOk;
	allOk = compare_uvec2((m[0]), uvec2(8u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(8, 9, -5, 5));
	blockB.b = (mat4x3(-4.0, 2.0, -1.0, 9.0, -3.0, 5.0, -8.0, -2.0, 4.0, 1.0, -2.0, -8.0));
	blockC.d = (true);
	blockC.e = (mat2(5.0, -6.0, 4.0, -3.0));
	blockC.f = (false);
	blockC.g = (uvec4(6u, 4u, 4u, 4u));
	blockC.h = (-7);
	i = (mat4x3(-2.0, 5.0, 1.0, 3.0, -3.0, -1.0, 1.0, -6.0, -5.0, -4.0, -2.0, 8.0));
	k = (uvec2(7u, 9u));
	l = (bvec4(true, false, false, true));
}
#version 450
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
	highp ivec4 a;
	lowp mat3 b[1];
	bool c[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump uvec2 d;
	lowp vec2 e;
	mediump mat4x3 f;
	bvec2 g;
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	bvec4 h;
	mediump vec4 i;
	highp mat3x2 j[1];
	mediump mat4 k;
	mediump ivec3 l[];
};
layout(std140, column_major, binding = 4) buffer BlockE
{
	bvec4 m;
	lowp mat3x4 n;
	mediump uvec3 o[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((a), ivec4(1, -5, -9, -5)) && allOk;
	allOk = compare_mat3(b[0], mat3(1.0, -7.0, 1.0, 2.0, 8.0, 7.0, 9.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec2((e), vec2(7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(f, mat4x3(-3.0, 9.0, -6.0, 7.0, 2.0, 8.0, 4.0, -5.0, 5.0, -2.0, 1.0, 5.0)) && allOk;
	allOk = compare_bvec2((g), bvec2(true, true)) && allOk;
	allOk = compare_bvec4((h), bvec4(true, false, false, false)) && allOk;
	allOk = compare_vec4((i), vec4(3.0, 1.0, 1.0, -9.0)) && allOk;
	allOk = compare_ivec3((l[0]), ivec3(5, -2, -4)) && allOk;
	allOk = compare_bvec4((blockE.m), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uvec3((blockE.o[0]), uvec3(7u, 5u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (mat3(-8.0, -5.0, 0.0, 0.0, -7.0, 5.0, 3.0, 4.0, 7.0));
	c[0] = (false);
	d = (uvec2(2u, 7u));
	e = (vec2(8.0, 0.0));
	f = (mat4x3(8.0, 7.0, -7.0, -6.0, -1.0, -5.0, 5.0, -9.0, 7.0, 1.0, -2.0, -9.0));
	g = (bvec2(true, false));
	i = (vec4(-8.0, 4.0, 8.0, 5.0));
	k = (mat4(-8.0, 1.0, -8.0, 2.0, -7.0, -2.0, 2.0, -5.0, -5.0, -8.0, -6.0, -3.0, -6.0, -4.0, -7.0, 7.0));
	blockE.n = (mat3x4(-4.0, -8.0, 6.0, -6.0, 3.0, -9.0, -6.0, 1.0, 9.0, -7.0, 2.0, 5.0));
	blockE.o[0] = (uvec3(5u, 9u, 3u));
}
#version 450
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
	mediump ivec3 b[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	a = (vec2(5.0, -5.0));
	b[0] = (ivec3(3, 9, -5));
}
#version 450
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
	highp uint mB;
	mediump uint mC;
};
struct sB
{
	mediump ivec3 mA;
	sA mB;
};
layout(std430, binding = 1) readonly buffer BlockB
{
	mediump uvec3 a;
	highp mat3 b;
	sB c;
	highp mat4x3 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((a), uvec3(0u, 2u, 0u)) && allOk;
	allOk = compare_mat3(b, mat3(0.0, -4.0, -5.0, 9.0, -4.0, -6.0, -1.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat4x3(d[0], mat4x3(1.0, -4.0, -9.0, 1.0, -4.0, 0.0, 2.0, 0.0, 6.0, 2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(d[1], mat4x3(-1.0, -5.0, -1.0, -9.0, -6.0, -9.0, -8.0, 6.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(d[2], mat4x3(-7.0, -2.0, -5.0, 4.0, 8.0, -9.0, -8.0, -2.0, -8.0, -2.0, -9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
};
struct sB
{
	lowp mat4x3 mA;
	lowp ivec3 mB[3];
};
struct sC
{
	highp mat4 mA;
	highp mat2x3 mB;
	sB mC;
	lowp ivec3 mD;
};
struct sD
{
	lowp float mA;
	mediump ivec3 mB;
	lowp uint mC;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	sA a;
	mediump mat2x3 b[4];
	bvec4 c;
	lowp mat4x2 d[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	sC e;
	bvec2 f;
	sD g[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	lowp mat3x2 h[];
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	highp mat3 i[7];
	lowp float j[];
} blockE[1];

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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a.mA, mat4(4.0, 4.0, -5.0, 7.0, 4.0, 1.0, -8.0, -1.0, -4.0, 9.0, -6.0, -1.0, 7.0, 3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockB.b[0], mat2x3(-5.0, -6.0, -7.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockB.b[1], mat2x3(-7.0, 0.0, -7.0, -7.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB.b[2], mat2x3(-9.0, -2.0, -2.0, 3.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockB.b[3], mat2x3(-6.0, -1.0, 9.0, 0.0, 7.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(false, false)) && allOk;
	allOk = compare_float((blockC.g[0].mA), 2.0) && allOk;
	allOk = compare_ivec3((blockC.g[0].mB), ivec3(-9, 8, -4)) && allOk;
	allOk = compare_uint((blockC.g[0].mC), 9u) && allOk;
	allOk = compare_float((blockC.g[1].mA), 8.0) && allOk;
	allOk = compare_ivec3((blockC.g[1].mB), ivec3(1, 3, 1)) && allOk;
	allOk = compare_uint((blockC.g[1].mC), 9u) && allOk;
	allOk = compare_float((blockC.g[2].mA), 8.0) && allOk;
	allOk = compare_ivec3((blockC.g[2].mB), ivec3(1, 7, 2)) && allOk;
	allOk = compare_uint((blockC.g[2].mC), 8u) && allOk;
	allOk = compare_float((blockC.g[3].mA), -6.0) && allOk;
	allOk = compare_ivec3((blockC.g[3].mB), ivec3(9, -8, -2)) && allOk;
	allOk = compare_uint((blockC.g[3].mC), 7u) && allOk;
	allOk = compare_float((blockC.g[4].mA), 2.0) && allOk;
	allOk = compare_ivec3((blockC.g[4].mB), ivec3(5, -1, 6)) && allOk;
	allOk = compare_uint((blockC.g[4].mC), 9u) && allOk;
	allOk = compare_float((blockC.g[5].mA), 9.0) && allOk;
	allOk = compare_ivec3((blockC.g[5].mB), ivec3(4, -1, -7)) && allOk;
	allOk = compare_uint((blockC.g[5].mC), 2u) && allOk;
	allOk = compare_mat3x2(blockD.h[0], mat3x2(0.0, 2.0, 8.0, 5.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockD.h[1], mat3x2(-5.0, 1.0, 5.0, 9.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockD.h[2], mat3x2(-3.0, -5.0, 4.0, -9.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (mat4(-5.0, -8.0, -5.0, 2.0, 4.0, 8.0, -5.0, -4.0, -9.0, 4.0, -7.0, -8.0, -7.0, 6.0, 5.0, 0.0));
	blockB.b[0] = (mat2x3(9.0, 1.0, 4.0, 3.0, -6.0, -4.0));
	blockB.b[1] = (mat2x3(-6.0, 3.0, 7.0, 9.0, 7.0, -8.0));
	blockB.b[2] = (mat2x3(5.0, -7.0, 5.0, -2.0, -2.0, 0.0));
	blockB.b[3] = (mat2x3(-1.0, 4.0, -1.0, 5.0, -9.0, -1.0));
	blockC.g[0].mA = (-7.0);
	blockC.g[0].mB = (ivec3(1, 0, -6));
	blockC.g[0].mC = (1u);
	blockC.g[1].mA = (5.0);
	blockC.g[1].mB = (ivec3(8, -7, -8));
	blockC.g[1].mC = (3u);
	blockC.g[2].mA = (-3.0);
	blockC.g[2].mB = (ivec3(-3, 7, 5));
	blockC.g[2].mC = (6u);
	blockC.g[3].mA = (1.0);
	blockC.g[3].mB = (ivec3(4, 5, -7));
	blockC.g[3].mC = (8u);
	blockC.g[4].mA = (1.0);
	blockC.g[4].mB = (ivec3(6, 7, 6));
	blockC.g[4].mC = (4u);
	blockC.g[5].mA = (-9.0);
	blockC.g[5].mB = (ivec3(-2, 5, 8));
	blockC.g[5].mC = (0u);
	blockD.h[0] = (mat3x2(-3.0, -3.0, 8.0, 9.0, -5.0, -2.0));
	blockD.h[1] = (mat3x2(7.0, 5.0, 4.0, -4.0, 2.0, -1.0));
	blockD.h[2] = (mat3x2(2.0, 0.0, -5.0, -2.0, 2.0, -5.0));
	blockE[0].i[0] = (mat3(0.0, -7.0, 4.0, 8.0, -4.0, -5.0, -8.0, -1.0, 3.0));
	blockE[0].i[1] = (mat3(-8.0, -4.0, 5.0, 8.0, -5.0, -3.0, 6.0, -9.0, -6.0));
	blockE[0].i[2] = (mat3(1.0, 3.0, 9.0, -2.0, -5.0, 2.0, 2.0, 8.0, 4.0));
	blockE[0].i[3] = (mat3(-3.0, 4.0, -8.0, -7.0, -9.0, -2.0, -9.0, -3.0, -2.0));
	blockE[0].i[4] = (mat3(0.0, 6.0, -4.0, 8.0, -1.0, 0.0, 2.0, -2.0, 5.0));
	blockE[0].i[5] = (mat3(-6.0, 1.0, -4.0, 9.0, 0.0, 8.0, 6.0, -5.0, 5.0));
	blockE[0].i[6] = (mat3(-3.0, -8.0, 7.0, 0.0, -3.0, 1.0, -1.0, 0.0, 0.0));
}
#version 450
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
	highp uvec4 mB;
	lowp vec3 mC;
	mediump uvec3 mD;
};
struct sB
{
	highp mat3 mA;
	highp mat3x2 mB;
	sA mC;
};
layout(std140, binding = 1) buffer BlockB
{
	lowp int a[2][6][6];
	mediump ivec3 b[7];
	bool c;
	highp uvec2 d;
	lowp ivec4 e[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump uvec2 f;
	mediump uint g;
	lowp mat4x2 h[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	sB i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.d), uvec2(0u, 0u)) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(7u, 8u)) && allOk;
	allOk = compare_uint((blockC.g), 9u) && allOk;
	allOk = compare_mat4x2(blockC.h[0], mat4x2(9.0, 2.0, -6.0, 6.0, 6.0, -6.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockC.h[1], mat4x2(7.0, 5.0, -8.0, 3.0, -4.0, -3.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockC.h[2], mat4x2(1.0, 7.0, -5.0, -4.0, -2.0, 2.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockC.h[3], mat4x2(-2.0, -6.0, -6.0, -6.0, 6.0, 0.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3(i[0].mA, mat3(4.0, 6.0, 5.0, 8.0, -3.0, 3.0, -6.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3x2(i[0].mB, mat3x2(-4.0, 9.0, -5.0, 2.0, 9.0, -8.0)) && allOk;
	allOk = compare_bvec4((i[0].mC.mA), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uvec4((i[0].mC.mB), uvec4(8u, 8u, 9u, 0u)) && allOk;
	allOk = compare_vec3((i[0].mC.mC), vec3(-1.0, 9.0, -8.0)) && allOk;
	allOk = compare_uvec3((i[0].mC.mD), uvec3(8u, 8u, 7u)) && allOk;
	allOk = compare_mat3(i[1].mA, mat3(-4.0, 4.0, 7.0, -3.0, 7.0, 5.0, 3.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(i[1].mB, mat3x2(9.0, 8.0, 0.0, 2.0, 8.0, -1.0)) && allOk;
	allOk = compare_bvec4((i[1].mC.mA), bvec4(false, true, false, false)) && allOk;
	allOk = compare_uvec4((i[1].mC.mB), uvec4(0u, 8u, 8u, 9u)) && allOk;
	allOk = compare_vec3((i[1].mC.mC), vec3(-5.0, 9.0, 8.0)) && allOk;
	allOk = compare_uvec3((i[1].mC.mD), uvec3(8u, 5u, 3u)) && allOk;
	allOk = compare_mat3(i[2].mA, mat3(6.0, -5.0, 0.0, -4.0, 8.0, -8.0, -8.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3x2(i[2].mB, mat3x2(1.0, 0.0, -7.0, -4.0, 7.0, 3.0)) && allOk;
	allOk = compare_bvec4((i[2].mC.mA), bvec4(false, false, true, true)) && allOk;
	allOk = compare_uvec4((i[2].mC.mB), uvec4(2u, 5u, 3u, 6u)) && allOk;
	allOk = compare_vec3((i[2].mC.mC), vec3(1.0, 2.0, 6.0)) && allOk;
	allOk = compare_uvec3((i[2].mC.mD), uvec3(4u, 6u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0][0][0] = (8);
	blockB.a[0][0][1] = (7);
	blockB.a[0][0][2] = (-2);
	blockB.a[0][0][3] = (6);
	blockB.a[0][0][4] = (0);
	blockB.a[0][0][5] = (5);
	blockB.a[0][1][0] = (5);
	blockB.a[0][1][1] = (8);
	blockB.a[0][1][2] = (6);
	blockB.a[0][1][3] = (2);
	blockB.a[0][1][4] = (-7);
	blockB.a[0][1][5] = (-2);
	blockB.a[0][2][0] = (-8);
	blockB.a[0][2][1] = (6);
	blockB.a[0][2][2] = (-7);
	blockB.a[0][2][3] = (4);
	blockB.a[0][2][4] = (6);
	blockB.a[0][2][5] = (-2);
	blockB.a[0][3][0] = (-3);
	blockB.a[0][3][1] = (3);
	blockB.a[0][3][2] = (2);
	blockB.a[0][3][3] = (2);
	blockB.a[0][3][4] = (-6);
	blockB.a[0][3][5] = (-8);
	blockB.a[0][4][0] = (-1);
	blockB.a[0][4][1] = (-2);
	blockB.a[0][4][2] = (-4);
	blockB.a[0][4][3] = (3);
	blockB.a[0][4][4] = (-1);
	blockB.a[0][4][5] = (4);
	blockB.a[0][5][0] = (9);
	blockB.a[0][5][1] = (2);
	blockB.a[0][5][2] = (-2);
	blockB.a[0][5][3] = (-2);
	blockB.a[0][5][4] = (7);
	blockB.a[0][5][5] = (3);
	blockB.a[1][0][0] = (9);
	blockB.a[1][0][1] = (-5);
	blockB.a[1][0][2] = (4);
	blockB.a[1][0][3] = (7);
	blockB.a[1][0][4] = (-1);
	blockB.a[1][0][5] = (6);
	blockB.a[1][1][0] = (-4);
	blockB.a[1][1][1] = (-2);
	blockB.a[1][1][2] = (4);
	blockB.a[1][1][3] = (-2);
	blockB.a[1][1][4] = (3);
	blockB.a[1][1][5] = (0);
	blockB.a[1][2][0] = (-5);
	blockB.a[1][2][1] = (3);
	blockB.a[1][2][2] = (0);
	blockB.a[1][2][3] = (9);
	blockB.a[1][2][4] = (-2);
	blockB.a[1][2][5] = (3);
	blockB.a[1][3][0] = (-6);
	blockB.a[1][3][1] = (4);
	blockB.a[1][3][2] = (-7);
	blockB.a[1][3][3] = (-9);
	blockB.a[1][3][4] = (7);
	blockB.a[1][3][5] = (-3);
	blockB.a[1][4][0] = (-2);
	blockB.a[1][4][1] = (9);
	blockB.a[1][4][2] = (-2);
	blockB.a[1][4][3] = (8);
	blockB.a[1][4][4] = (-5);
	blockB.a[1][4][5] = (-8);
	blockB.a[1][5][0] = (7);
	blockB.a[1][5][1] = (3);
	blockB.a[1][5][2] = (-1);
	blockB.a[1][5][3] = (-2);
	blockB.a[1][5][4] = (1);
	blockB.a[1][5][5] = (2);
	blockB.c = (true);
	blockB.d = (uvec2(3u, 0u));
	blockB.e[0] = (ivec4(2, -8, -8, 2));
	blockB.e[1] = (ivec4(2, 6, 5, 2));
	blockB.e[2] = (ivec4(-4, -9, -7, 4));
	blockB.e[3] = (ivec4(0, 6, -6, 0));
	blockB.e[4] = (ivec4(5, -3, 3, -2));
	blockB.e[5] = (ivec4(-9, -5, -3, -9));
	blockB.e[6] = (ivec4(7, 9, 8, 2));
	blockC.f = (uvec2(8u, 2u));
	i[0].mA = (mat3(-9.0, 5.0, -5.0, -7.0, -2.0, -7.0, -1.0, -3.0, -4.0));
	i[0].mB = (mat3x2(-4.0, -2.0, -6.0, 3.0, -9.0, -5.0));
	i[0].mC.mA = (bvec4(true, false, true, false));
	i[0].mC.mB = (uvec4(7u, 3u, 5u, 5u));
	i[0].mC.mC = (vec3(5.0, -3.0, 7.0));
	i[0].mC.mD = (uvec3(7u, 5u, 1u));
	i[1].mA = (mat3(-3.0, -7.0, -3.0, 7.0, 7.0, -1.0, 9.0, -1.0, -3.0));
	i[1].mB = (mat3x2(9.0, -3.0, 3.0, -1.0, -7.0, -1.0));
	i[1].mC.mA = (bvec4(false, false, true, true));
	i[1].mC.mB = (uvec4(4u, 1u, 6u, 5u));
	i[1].mC.mC = (vec3(-7.0, 7.0, 2.0));
	i[1].mC.mD = (uvec3(8u, 9u, 5u));
	i[2].mA = (mat3(8.0, 9.0, -5.0, 1.0, -9.0, -7.0, 6.0, 2.0, -4.0));
	i[2].mB = (mat3x2(7.0, -7.0, -3.0, 8.0, -1.0, 9.0));
	i[2].mC.mA = (bvec4(true, false, true, true));
	i[2].mC.mB = (uvec4(0u, 6u, 4u, 2u));
	i[2].mC.mC = (vec3(-6.0, 1.0, 0.0));
	i[2].mC.mD = (uvec3(6u, 5u, 5u));
}
#version 450
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
	layout(offset = 0) mediump ivec3 a[1];
	layout(offset = 16) bvec4 b;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp int c[1];
	layout(offset = 4) lowp vec2 d;
	layout(offset = 16) highp vec3 e;
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a[0]), ivec3(8, 1, 7)) && allOk;
	allOk = compare_bvec4((b), bvec4(true, true, true, false)) && allOk;
	allOk = compare_int((blockC[0].c[0]), 9) && allOk;
	allOk = compare_vec2((blockC[0].d), vec2(0.0, -2.0)) && allOk;
	allOk = compare_vec3((blockC[0].e), vec3(6.0, -1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (ivec3(9, 9, 3));
	b = (bvec4(true, false, false, true));
	blockC[0].c[0] = (2);
	blockC[0].d = (vec2(-8.0, -1.0));
	blockC[0].e = (vec3(-3.0, -1.0, 4.0));
}
#version 450
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
	layout(offset = 0) highp ivec2 a[1];
} blockB;
layout(binding = 2) readonly buffer BlockC
{
	layout(offset = 0) lowp int b;
} blockC;
layout(binding = 3) readonly buffer BlockD
{
	layout(offset = 0) bvec4 c[1];
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) lowp uvec2 d;
	layout(offset = 8) mediump int e;
	layout(offset = 16) lowp ivec4 f[1];
	layout(offset = 32) bvec3 g;
	layout(offset = 44) lowp float h;
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a[0]), ivec2(-6, 0)) && allOk;
	allOk = compare_int((blockC.b), 9) && allOk;
	allOk = compare_bvec4((c[0]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_uvec2((blockE[0].d), uvec2(3u, 1u)) && allOk;
	allOk = compare_int((blockE[0].e), -8) && allOk;
	allOk = compare_ivec4((blockE[0].f[0]), ivec4(1, -1, -6, 6)) && allOk;
	allOk = compare_bvec3((blockE[0].g), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec2(4, 8));
	blockE[0].d = (uvec2(8u, 6u));
	blockE[0].f[0] = (ivec4(-8, 2, -2, 3));
	blockE[0].g = (bvec3(false, false, false));
	blockE[0].h = (0.0);
}
#version 450
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
	bool a;
} blockB;

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
}
#version 450
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
	highp ivec3 a;
	lowp ivec3 b;
	highp uint c[6];
	bvec4 d;
	highp ivec4 e[];
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	highp uvec3 f;
	mediump mat3 g;
	lowp mat3x2 h[];
} blockC[1];
layout(scalar, row_major, binding = 3) buffer BlockD
{
	lowp mat4 i[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((b), ivec3(8, -8, 7)) && allOk;
	allOk = compare_uint((c[0]), 2u) && allOk;
	allOk = compare_uint((c[1]), 8u) && allOk;
	allOk = compare_uint((c[2]), 4u) && allOk;
	allOk = compare_uint((c[3]), 3u) && allOk;
	allOk = compare_uint((c[4]), 9u) && allOk;
	allOk = compare_uint((c[5]), 5u) && allOk;
	allOk = compare_mat3x2(blockC[0].h[0], mat3x2(1.0, -5.0, -2.0, -3.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockC[0].h[1], mat3x2(9.0, 2.0, 3.0, -9.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockC[0].h[2], mat3x2(7.0, -8.0, 6.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockC[0].h[3], mat3x2(-1.0, 0.0, 9.0, 5.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockC[0].h[4], mat3x2(9.0, 3.0, -4.0, -3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockC[0].h[5], mat3x2(-8.0, -5.0, -1.0, -7.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec3(1, 8, 5));
	b = (ivec3(5, 1, 5));
	c[0] = (1u);
	c[1] = (8u);
	c[2] = (3u);
	c[3] = (5u);
	c[4] = (8u);
	c[5] = (9u);
	d = (bvec4(false, false, true, false));
	blockC[0].h[0] = (mat3x2(-2.0, -9.0, -7.0, -5.0, -9.0, -3.0));
	blockC[0].h[1] = (mat3x2(-8.0, -1.0, -6.0, -6.0, -4.0, 3.0));
	blockC[0].h[2] = (mat3x2(2.0, 5.0, 5.0, 0.0, -9.0, -3.0));
	blockC[0].h[3] = (mat3x2(-4.0, 6.0, -8.0, 0.0, -3.0, -5.0));
	blockC[0].h[4] = (mat3x2(-8.0, 6.0, -8.0, -1.0, -4.0, 1.0));
	blockC[0].h[5] = (mat3x2(9.0, 1.0, -7.0, -3.0, 8.0, 6.0));
	blockD.i[0] = (mat4(6.0, -9.0, 5.0, -5.0, -9.0, 7.0, 6.0, 2.0, 1.0, -7.0, -6.0, -8.0, -1.0, 4.0, 4.0, -2.0));
	blockD.i[1] = (mat4(-6.0, -7.0, 9.0, -5.0, 9.0, -9.0, 6.0, -9.0, -1.0, 6.0, -8.0, 0.0, 0.0, 4.0, 0.0, -3.0));
	blockD.i[2] = (mat4(4.0, 4.0, 9.0, -1.0, -7.0, 9.0, 6.0, -5.0, 4.0, 3.0, -7.0, -4.0, -4.0, 0.0, -1.0, 0.0));
	blockD.i[3] = (mat4(9.0, -8.0, 9.0, 6.0, 3.0, -8.0, 2.0, -8.0, 1.0, 5.0, 6.0, 5.0, -6.0, 3.0, 0.0, -5.0));
	blockD.i[4] = (mat4(-3.0, 1.0, -1.0, 4.0, -4.0, 7.0, -2.0, -9.0, 3.0, -8.0, -7.0, 1.0, -9.0, -4.0, 5.0, 8.0));
}
#version 450
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
	highp vec4 a[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a[0]), vec4(8.0, 5.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec4((a[1]), vec4(-6.0, -9.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (vec4(-4.0, 4.0, -1.0, 8.0));
	a[1] = (vec4(3.0, -4.0, 2.0, 9.0));
}
#version 450
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
	mediump ivec3 mB[8];
	bvec3 mC;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	highp uvec4 a[];
};
layout(scalar, binding = 2) buffer BlockC
{
	mediump vec4 b;
	highp mat3 c;
	sA d;
	mediump ivec3 e;
	lowp mat2 f[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockC.b), vec4(-4.0, -3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(blockC.c, mat3(8.0, 5.0, -9.0, -3.0, 9.0, 9.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockC.d.mA, mat2x3(4.0, -7.0, -6.0, -5.0, 5.0, 1.0)) && allOk;
	allOk = compare_ivec3((blockC.d.mB[0]), ivec3(-9, 4, -8)) && allOk;
	allOk = compare_ivec3((blockC.d.mB[1]), ivec3(2, -9, 3)) && allOk;
	allOk = compare_ivec3((blockC.d.mB[2]), ivec3(0, -5, 2)) && allOk;
	allOk = compare_ivec3((blockC.d.mB[3]), ivec3(-5, 5, 9)) && allOk;
	allOk = compare_ivec3((blockC.d.mB[4]), ivec3(-7, 4, 0)) && allOk;
	allOk = compare_ivec3((blockC.d.mB[5]), ivec3(-7, 9, 9)) && allOk;
	allOk = compare_ivec3((blockC.d.mB[6]), ivec3(5, -9, -8)) && allOk;
	allOk = compare_ivec3((blockC.d.mB[7]), ivec3(7, -8, 2)) && allOk;
	allOk = compare_bvec3((blockC.d.mC), bvec3(false, true, false)) && allOk;
	allOk = compare_mat2(blockC.f[0], mat2(1.0, -4.0, -9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (uvec4(9u, 2u, 4u, 5u));
	a[1] = (uvec4(7u, 3u, 8u, 1u));
	a[2] = (uvec4(6u, 8u, 7u, 3u));
	a[3] = (uvec4(3u, 6u, 1u, 6u));
	a[4] = (uvec4(7u, 5u, 7u, 1u));
	a[5] = (uvec4(7u, 9u, 8u, 4u));
	a[6] = (uvec4(3u, 8u, 7u, 1u));
	a[7] = (uvec4(4u, 2u, 3u, 0u));
	blockC.b = (vec4(6.0, -3.0, -3.0, -7.0));
	blockC.c = (mat3(3.0, 7.0, 1.0, -2.0, -3.0, 0.0, -6.0, -4.0, 8.0));
	blockC.f[0] = (mat2(-8.0, -9.0, -1.0, 2.0));
}
#version 450
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
	layout(offset = 0) mediump mat4 a;
	layout(offset = 64) lowp int b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB[nonuniformEXT(0)].a, mat4(0.0, 7.0, 4.0, -8.0, -2.0, -7.0, 1.0, 0.0, 5.0, 7.0, -2.0, -5.0, -1.0, -9.0, -3.0, -4.0)) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(0)].b), 6) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(1)].a, mat4(-9.0, -1.0, -6.0, 7.0, 5.0, 4.0, 0.0, 0.0, 9.0, 1.0, -3.0, -7.0, 3.0, -8.0, 9.0, 3.0)) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(1)].b), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (8);
	blockB[nonuniformEXT(1)].b = (-3);
}
#version 450
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
	uint16_t a;
	uint16_t b;
	bool c;
	highp uint d;
	float16_t e;
};
layout(std430, binding = 2) readonly buffer BlockC
{
	int16_t f;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(a), 8u) && allOk;
	allOk = compare_uint16_t(uint(b), 2u) && allOk;
	allOk = compare_bool((c), true) && allOk;
	allOk = compare_uint((d), 6u) && allOk;
	allOk = compare_int16_t(int(f), -6) && allOk;
    if (allOk)
        ac_numPassed++;

	a = uint16_t(9u);
	c = (true);
	d = (9u);
	e = float16_t(-7.0);
}
#version 450
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
	highp uvec4 a;
	bool b;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp ivec3 c;
	int16_t d;
	mediump uvec4 e[8];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	int16_t f;
	uint16_t g;
	int16_t h;
	mediump mat3 i;
	i16vec2 j;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((a), uvec4(4u, 0u, 4u, 6u)) && allOk;
	allOk = compare_bool((b), true) && allOk;
	allOk = compare_ivec3((c), ivec3(5, -5, -2)) && allOk;
	allOk = compare_uvec4((e[0]), uvec4(9u, 7u, 0u, 6u)) && allOk;
	allOk = compare_uvec4((e[1]), uvec4(6u, 5u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((e[2]), uvec4(6u, 8u, 7u, 4u)) && allOk;
	allOk = compare_uvec4((e[3]), uvec4(5u, 0u, 6u, 4u)) && allOk;
	allOk = compare_uvec4((e[4]), uvec4(1u, 5u, 6u, 9u)) && allOk;
	allOk = compare_uvec4((e[5]), uvec4(6u, 0u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((e[6]), uvec4(0u, 4u, 2u, 0u)) && allOk;
	allOk = compare_uvec4((e[7]), uvec4(5u, 1u, 0u, 3u)) && allOk;
	allOk = compare_int16_t(int(blockD.f), 0) && allOk;
	allOk = compare_int16_t(int(blockD.h), -6) && allOk;
	allOk = compare_mat3(blockD.i, mat3(-1.0, -5.0, 6.0, 5.0, -8.0, 9.0, 1.0, -6.0, 9.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.j), ivec2(-6, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (ivec3(9, -5, 2));
	d = int16_t(1);
	e[0] = (uvec4(4u, 3u, 9u, 4u));
	e[1] = (uvec4(7u, 9u, 7u, 4u));
	e[2] = (uvec4(0u, 9u, 6u, 1u));
	e[3] = (uvec4(7u, 8u, 7u, 5u));
	e[4] = (uvec4(7u, 8u, 1u, 6u));
	e[5] = (uvec4(5u, 0u, 5u, 5u));
	e[6] = (uvec4(3u, 6u, 1u, 7u));
	e[7] = (uvec4(9u, 9u, 0u, 0u));
	blockD.f = int16_t(-1);
	blockD.g = uint16_t(0u);
	blockD.h = int16_t(2);
	blockD.i = (mat3(-2.0, 0.0, 2.0, -1.0, -8.0, 1.0, 3.0, 9.0, -2.0));
	blockD.j = i16vec2(ivec2(-3, -1));
}
#version 450
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
	highp vec4 a;
};
layout(std140, row_major, binding = 2) readonly buffer BlockC
{
	highp mat3x2 b[];
};
layout(std430, binding = 3) buffer BlockD
{
	u16vec2 c;
	f16vec3 d;
	highp ivec2 e;
	lowp mat3x4 f;
	mediump float g;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(b[0], mat3x2(-9.0, -9.0, 5.0, 8.0, -4.0, 6.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.c), uvec2(2u, 0u)) && allOk;
	allOk = compare_ivec2((blockD.e), ivec2(2, -9)) && allOk;
	allOk = compare_float((blockD.g), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(9.0, -7.0, -5.0, -9.0));
	blockD.c = u16vec2(uvec2(0u, 9u));
	blockD.e = (ivec2(-3, 9));
	blockD.f = (mat3x4(4.0, 0.0, 4.0, 5.0, -2.0, 4.0, -6.0, 5.0, -4.0, 9.0, 1.0, 4.0));
	blockD.g = (-5.0);
}
#version 450
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
	highp mat3x4 a[1];
	bvec3 b;
	mediump float c;
	u16vec4 d[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	lowp vec2 e;
	highp ivec3 f;
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	f16vec2 g;
	bvec2 h;
	highp mat3x2 i[];
} blockD[3];
layout(std430, binding = 4) buffer BlockE
{
	float16_t j;
	highp ivec4 k;
	i16vec3 l;
	highp mat4 m;
	bvec3 n[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a[0], mat3x4(4.0, 7.0, 9.0, -8.0, 4.0, 4.0, 3.0, -6.0, -4.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_float((c), 6.0) && allOk;
	allOk = compare_u16vec4(uvec4(d[0]), uvec4(8u, 5u, 6u, 1u)) && allOk;
	allOk = compare_vec2((blockC.e), vec2(-7.0, -4.0)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(-7, -7, 0)) && allOk;
	allOk = compare_bvec2((blockD[0].h), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[1].h), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[2].h), bvec2(false, false)) && allOk;
	allOk = compare_float16_t(float(j), 4.0) && allOk;
	allOk = compare_ivec4((k), ivec4(9, -4, 9, 8)) && allOk;
	allOk = compare_bvec3((n[0]), bvec3(false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat3x4(-5.0, -7.0, 4.0, -5.0, 4.0, -8.0, 6.0, -7.0, -9.0, 8.0, -5.0, 5.0));
	b = (bvec3(true, true, true));
	c = (1.0);
	d[0] = u16vec4(uvec4(3u, 8u, 2u, 9u));
	blockC.e = (vec2(9.0, 3.0));
	blockC.f = (ivec3(7, 7, -8));
	blockD[0].h = (bvec2(false, false));
	blockD[0].i[0] = (mat3x2(5.0, 0.0, -1.0, 5.0, 4.0, -9.0));
	blockD[1].h = (bvec2(false, true));
	blockD[1].i[0] = (mat3x2(7.0, 4.0, -3.0, 1.0, 6.0, 5.0));
	blockD[2].h = (bvec2(false, false));
	blockD[2].i[0] = (mat3x2(-1.0, 2.0, -8.0, -1.0, -2.0, -8.0));
	j = float16_t(1.0);
	k = (ivec4(-7, -3, 3, -6));
	l = i16vec3(ivec3(1, -1, -1));
	m = (mat4(1.0, 2.0, -5.0, -4.0, 4.0, 7.0, -2.0, 8.0, -5.0, -9.0, 2.0, 3.0, 1.0, -5.0, -2.0, 5.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, column_major, binding = 1) readonly buffer BlockB
{
	mediump ivec3 a[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp mat4x3 b;
	mediump vec3 c;
	lowp mat4x2 d[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockC.d[0], mat4x2(3.0, 2.0, 8.0, -6.0, 8.0, -8.0, -6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat4x3(-1.0, 7.0, 4.0, 2.0, -5.0, -8.0, 2.0, 5.0, 9.0, -5.0, -3.0, -2.0));
	blockC.c = (vec3(5.0, -1.0, 9.0));
	blockC.d[0] = (mat4x2(2.0, -6.0, 3.0, 3.0, -2.0, 5.0, 9.0, 5.0));
}
#version 450
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
struct sB
{
	mediump uint mA;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	i16vec4 a;
	sA b;
	highp float c;
	mediump mat2 d;
	u16vec3 e[];
};
layout(std430, binding = 2) readonly buffer BlockC
{
	lowp mat3 f[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	highp uvec3 g;
	lowp mat2x3 h;
	highp uvec3 i;
	u16vec3 j;
} blockD[1];
layout(std140, row_major, binding = 4) buffer BlockE
{
	mediump mat3x4 k;
	sB l;
	lowp mat4x3 m[];
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(a), ivec4(6, 6, -6, -3)) && allOk;
	allOk = compare_f16vec4(vec4(b.mA), vec4(-1.0, -9.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockD[0].h, mat2x3(8.0, 8.0, -5.0, -6.0, 2.0, 9.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD[0].j), uvec3(4u, 6u, 2u)) && allOk;
	allOk = compare_uint((blockE[0].l.mA), 7u) && allOk;
	allOk = compare_uint((blockE[1].l.mA), 5u) && allOk;
	allOk = compare_uint((blockE[2].l.mA), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (-9.0);
	d = (mat2(2.0, 6.0, 1.0, 9.0));
	blockD[0].g = (uvec3(5u, 3u, 4u));
	blockD[0].h = (mat2x3(-5.0, 2.0, 5.0, -1.0, 0.0, 3.0));
	blockD[0].i = (uvec3(4u, 8u, 8u));
	blockD[0].j = u16vec3(uvec3(2u, 9u, 5u));
	blockE[0].k = (mat3x4(-5.0, -5.0, -9.0, 2.0, -2.0, 7.0, 0.0, 1.0, -4.0, 6.0, -7.0, 9.0));
	blockE[0].l.mA = (4u);
	blockE[0].m[0] = (mat4x3(-9.0, 8.0, -6.0, -2.0, 8.0, -3.0, -7.0, 7.0, -1.0, 8.0, 9.0, 3.0));
	blockE[1].k = (mat3x4(7.0, -7.0, 8.0, -8.0, -2.0, -5.0, 6.0, -7.0, -7.0, 3.0, -1.0, 3.0));
	blockE[1].l.mA = (3u);
	blockE[1].m[0] = (mat4x3(1.0, 7.0, -8.0, 4.0, 0.0, 2.0, -7.0, -9.0, -1.0, -3.0, 0.0, 4.0));
	blockE[2].k = (mat3x4(-7.0, -3.0, 6.0, -1.0, 7.0, 5.0, 7.0, 4.0, 8.0, -2.0, -8.0, 4.0));
	blockE[2].l.mA = (3u);
	blockE[2].m[0] = (mat4x3(3.0, -1.0, -2.0, -2.0, -6.0, 3.0, -4.0, -4.0, 4.0, 1.0, 9.0, 8.0));
}
#version 450
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
	u16vec4 a;
	highp mat2 b;
	i16vec2 c;
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp uvec2 d;
	bvec3 e[1];
	mediump mat4x2 f;
	mediump mat4x3 g;
	uint16_t h[];
} blockC[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(a), uvec4(7u, 1u, 2u, 9u)) && allOk;
	allOk = compare_uvec2((blockC[0].d), uvec2(9u, 6u)) && allOk;
	allOk = compare_bvec3((blockC[0].e[0]), bvec3(false, true, true)) && allOk;
	allOk = compare_mat4x3(blockC[0].g, mat4x3(-1.0, 9.0, -6.0, 8.0, -4.0, 4.0, 1.0, -6.0, -2.0, -3.0, -5.0, 4.0)) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].h[0]), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].h[1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].h[2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].h[3]), 7u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].h[4]), 8u) && allOk;
	allOk = compare_uvec2((blockC[1].d), uvec2(3u, 4u)) && allOk;
	allOk = compare_bvec3((blockC[1].e[0]), bvec3(false, true, true)) && allOk;
	allOk = compare_mat4x3(blockC[1].g, mat4x3(1.0, 1.0, 0.0, 9.0, -2.0, -1.0, -4.0, -8.0, 0.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].h[0]), 5u) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].h[1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].h[2]), 0u) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].h[3]), 6u) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].h[4]), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].h[5]), 9u) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].h[6]), 7u) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].h[7]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u16vec4(uvec4(7u, 8u, 1u, 1u));
	blockC[0].e[0] = (bvec3(false, true, false));
	blockC[0].g = (mat4x3(-8.0, 6.0, -7.0, 4.0, 6.0, -2.0, -5.0, 3.0, 0.0, 9.0, -2.0, 3.0));
	blockC[0].h[0] = uint16_t(9u);
	blockC[0].h[1] = uint16_t(1u);
	blockC[0].h[2] = uint16_t(3u);
	blockC[0].h[3] = uint16_t(4u);
	blockC[0].h[4] = uint16_t(9u);
	blockC[1].e[0] = (bvec3(false, false, true));
	blockC[1].g = (mat4x3(9.0, -2.0, 8.0, -5.0, -8.0, 9.0, 2.0, -2.0, -2.0, 7.0, 3.0, 7.0));
	blockC[1].h[0] = uint16_t(8u);
	blockC[1].h[1] = uint16_t(7u);
	blockC[1].h[2] = uint16_t(4u);
	blockC[1].h[3] = uint16_t(5u);
	blockC[1].h[4] = uint16_t(9u);
	blockC[1].h[5] = uint16_t(5u);
	blockC[1].h[6] = uint16_t(6u);
	blockC[1].h[7] = uint16_t(3u);
}
#version 450
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
	i16vec3 a[];
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(a[0]), ivec3(1, -6, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = i16vec3(ivec3(9, 7, 5));
}
#version 450
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
	layout(offset = 0) highp vec2 a[1];
	layout(offset = 8) f16vec4 b;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp uvec3 c[1];
	layout(offset = 16) mediump uvec2 d;
} blockC;
layout(binding = 3) readonly buffer BlockD
{
	layout(offset = 0) bvec3 e;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) f16vec4 f;
	layout(offset = 8) i16vec3 g;
	layout(offset = 16) mediump int h;
	layout(offset = 20) bvec2 i;
	layout(offset = 28) lowp float j;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a[0]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b), vec4(-3.0, -9.0, -1.0, 5.0)) && allOk;
	allOk = compare_uvec3((blockC.c[0]), uvec3(2u, 6u, 1u)) && allOk;
	allOk = compare_bvec3((blockD.e), bvec3(false, false, true)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.f), vec4(-5.0, 1.0, -1.0, -5.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.g), ivec3(-2, -4, -5)) && allOk;
	allOk = compare_float((blockE.j), 6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec2(-3.0, -4.0));
	blockC.c[0] = (uvec3(6u, 2u, 5u));
	blockC.d = (uvec2(1u, 2u));
	blockE.f = f16vec4(vec4(8.0, -6.0, -9.0, -8.0));
	blockE.g = i16vec3(ivec3(-5, -7, 4));
	blockE.h = (4);
	blockE.i = (bvec2(false, false));
	blockE.j = (1.0);
}
#version 450
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
	bvec2 a;
	highp mat4x2 b[][4];
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	float16_t c;
	highp vec3 d[6];
	mediump mat3x4 e[];
} blockC[1];
layout(scalar, column_major, binding = 3) buffer BlockD
{
	mediump ivec2 f;
	mediump mat4x2 g;
	u16vec4 h[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((a), bvec2(true, false)) && allOk;
	allOk = compare_mat4x2(b[0][0], mat4x2(0.0, 5.0, 5.0, 5.0, -5.0, -2.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(b[0][1], mat4x2(-6.0, -8.0, -5.0, 9.0, 7.0, -8.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x2(b[0][2], mat4x2(-5.0, -8.0, -7.0, 7.0, -5.0, 8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4x2(b[0][3], mat4x2(-8.0, -4.0, -3.0, 5.0, 0.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat4x2(b[1][0], mat4x2(8.0, -4.0, -1.0, 6.0, -7.0, -9.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4x2(b[1][1], mat4x2(-4.0, -6.0, -1.0, 5.0, 1.0, -5.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x2(b[1][2], mat4x2(6.0, 9.0, 9.0, -6.0, -6.0, -3.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(b[1][3], mat4x2(-3.0, -1.0, -1.0, 9.0, 6.0, 3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(b[2][0], mat4x2(0.0, 1.0, 7.0, -2.0, -9.0, -5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(b[2][1], mat4x2(-9.0, -7.0, 8.0, -7.0, -6.0, -9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(b[2][2], mat4x2(3.0, -4.0, -9.0, -3.0, 0.0, 4.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(b[2][3], mat4x2(7.0, -3.0, -7.0, 0.0, -5.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(b[3][0], mat4x2(7.0, 7.0, -3.0, -7.0, -7.0, 1.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4x2(b[3][1], mat4x2(2.0, -8.0, -3.0, -1.0, 6.0, 7.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4x2(b[3][2], mat4x2(4.0, -1.0, -7.0, -8.0, 1.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(b[3][3], mat4x2(-2.0, 7.0, -2.0, 7.0, -4.0, -8.0, -4.0, -9.0)) && allOk;
	allOk = compare_vec3((blockC[0].d[0]), vec3(0.0, 4.0, -6.0)) && allOk;
	allOk = compare_vec3((blockC[0].d[1]), vec3(2.0, 5.0, -6.0)) && allOk;
	allOk = compare_vec3((blockC[0].d[2]), vec3(6.0, 7.0, 8.0)) && allOk;
	allOk = compare_vec3((blockC[0].d[3]), vec3(0.0, 7.0, 9.0)) && allOk;
	allOk = compare_vec3((blockC[0].d[4]), vec3(6.0, 4.0, -9.0)) && allOk;
	allOk = compare_vec3((blockC[0].d[5]), vec3(9.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].e[0], mat3x4(-8.0, 1.0, -1.0, 7.0, -5.0, -1.0, 4.0, 0.0, -5.0, 8.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].e[1], mat3x4(4.0, 8.0, -5.0, 8.0, -4.0, 8.0, 5.0, 1.0, -8.0, -6.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].e[2], mat3x4(-6.0, -4.0, -1.0, -9.0, 8.0, -8.0, 2.0, 9.0, -3.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].e[3], mat3x4(5.0, 8.0, -4.0, 9.0, 2.0, 4.0, -3.0, 6.0, 2.0, -6.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].e[4], mat3x4(-9.0, -2.0, 8.0, -1.0, 4.0, -5.0, 6.0, 7.0, -1.0, -9.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].e[5], mat3x4(3.0, 2.0, 4.0, -9.0, -2.0, -6.0, 5.0, -9.0, 6.0, 5.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].e[6], mat3x4(-6.0, 7.0, -3.0, 8.0, 3.0, -5.0, -4.0, 0.0, 8.0, 7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].e[7], mat3x4(-3.0, -7.0, -4.0, 1.0, -6.0, 9.0, 8.0, 6.0, -2.0, -1.0, -5.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockD.f), ivec2(-9, 1)) && allOk;
	allOk = compare_mat4x2(blockD.g, mat4x2(-9.0, 8.0, 5.0, 1.0, -9.0, 1.0, -5.0, -9.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.h[0]), uvec4(1u, 0u, 9u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.h[1]), uvec4(5u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.h[2]), uvec4(7u, 7u, 9u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.h[3]), uvec4(5u, 5u, 0u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec2(true, false));
	b[0][0] = (mat4x2(0.0, -3.0, 9.0, -5.0, 2.0, 1.0, 8.0, 6.0));
	b[0][1] = (mat4x2(2.0, 9.0, 8.0, 5.0, -5.0, 8.0, -1.0, 7.0));
	b[0][2] = (mat4x2(-9.0, -3.0, -1.0, 6.0, -2.0, -4.0, 9.0, -4.0));
	b[0][3] = (mat4x2(2.0, -4.0, 4.0, -8.0, -4.0, 1.0, -4.0, -4.0));
	b[1][0] = (mat4x2(-7.0, -1.0, 9.0, -8.0, 6.0, 2.0, -1.0, 0.0));
	b[1][1] = (mat4x2(2.0, -2.0, -1.0, 3.0, 0.0, -8.0, 9.0, 2.0));
	b[1][2] = (mat4x2(1.0, -2.0, -3.0, -1.0, 2.0, -5.0, 4.0, -6.0));
	b[1][3] = (mat4x2(-5.0, -3.0, -5.0, 6.0, 6.0, -1.0, -3.0, -7.0));
	b[2][0] = (mat4x2(-3.0, -6.0, -2.0, 0.0, -2.0, -3.0, -8.0, 1.0));
	b[2][1] = (mat4x2(8.0, -6.0, -3.0, 1.0, 6.0, -6.0, -9.0, 6.0));
	b[2][2] = (mat4x2(8.0, -8.0, 9.0, 5.0, -6.0, -6.0, -1.0, -6.0));
	b[2][3] = (mat4x2(-2.0, 3.0, -4.0, 7.0, -6.0, -9.0, -3.0, 1.0));
	b[3][0] = (mat4x2(8.0, 7.0, -9.0, 6.0, -4.0, 4.0, -5.0, 5.0));
	b[3][1] = (mat4x2(-1.0, 8.0, 1.0, -2.0, 0.0, 0.0, -7.0, -4.0));
	b[3][2] = (mat4x2(9.0, -2.0, 6.0, 6.0, 4.0, 5.0, -9.0, -6.0));
	b[3][3] = (mat4x2(-6.0, -2.0, -4.0, -6.0, 3.0, -4.0, -9.0, 0.0));
	blockC[0].d[0] = (vec3(4.0, 3.0, 7.0));
	blockC[0].d[1] = (vec3(1.0, 2.0, 6.0));
	blockC[0].d[2] = (vec3(1.0, 4.0, -8.0));
	blockC[0].d[3] = (vec3(2.0, 2.0, 5.0));
	blockC[0].d[4] = (vec3(7.0, -1.0, -2.0));
	blockC[0].d[5] = (vec3(-4.0, -4.0, 5.0));
	blockD.g = (mat4x2(0.0, 3.0, -6.0, 5.0, 3.0, 3.0, -3.0, 0.0));
	blockD.h[0] = u16vec4(uvec4(8u, 4u, 2u, 4u));
	blockD.h[1] = u16vec4(uvec4(2u, 2u, 7u, 8u));
	blockD.h[2] = u16vec4(uvec4(1u, 5u, 5u, 7u));
	blockD.h[3] = u16vec4(uvec4(0u, 5u, 7u, 8u));
}
#version 450
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
	highp ivec3 mB;
	u16vec4 mC;
	mediump vec2 mD;
};
struct sB
{
	lowp mat4x3 mA;
	sA mB;
	mediump ivec2 mC;
	mediump vec4 mD;
};
struct sC
{
	highp vec2 mA;
	i16vec4 mB;
};
struct sD
{
	mediump mat3 mA;
	mediump uint mB;
	lowp uvec2 mC;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	bvec3 a[];
};
layout(scalar, binding = 2) buffer BlockC
{
	u16vec4 b;
	sB c;
	lowp int d[];
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	sC e;
	mediump mat3x2 f;
	mediump vec4 g;
	sD h[8];
	lowp vec2 i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((a[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((a[1]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((a[2]), bvec3(true, true, false)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.b), uvec4(7u, 4u, 3u, 1u)) && allOk;
	allOk = compare_vec2((e.mA), vec2(0.0, 3.0)) && allOk;
	allOk = compare_i16vec4(ivec4(e.mB), ivec4(-3, -3, -3, 7)) && allOk;
	allOk = compare_vec2((i[0]), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_vec2((i[1]), vec2(-8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (bvec3(true, false, true));
	a[1] = (bvec3(false, false, false));
	a[2] = (bvec3(true, true, true));
	blockC.d[0] = (5);
	blockC.d[1] = (7);
	blockC.d[2] = (-2);
	blockC.d[3] = (8);
	e.mA = (vec2(-8.0, 7.0));
	e.mB = i16vec4(ivec4(4, 7, -2, 6));
	f = (mat3x2(5.0, -8.0, 2.0, -3.0, -9.0, -6.0));
	g = (vec4(7.0, -8.0, 3.0, 6.0));
	i[0] = (vec2(7.0, 0.0));
	i[1] = (vec2(-3.0, 3.0));
}
#version 450
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
	u16vec4 mA;
};
struct sB
{
	highp ivec4 mA;
	lowp mat4 mB;
	lowp mat4x3 mC;
};
layout(scalar, binding = 1) buffer BlockB
{
	highp ivec2 a;
	bvec2 b;
	sA c;
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	sB d[3];
	bvec3 e;
	lowp float f;
	lowp ivec4 g;
	u16vec4 h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(6, -4)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c.mA = u16vec4(uvec4(2u, 4u, 2u, 1u));
	d[0].mA = (ivec4(-9, -9, 4, -3));
	d[0].mB = (mat4(-1.0, -7.0, 5.0, -9.0, -3.0, -2.0, -5.0, -7.0, -6.0, -7.0, -6.0, -1.0, 1.0, 7.0, 9.0, 0.0));
	d[0].mC = (mat4x3(9.0, -5.0, -7.0, 7.0, -4.0, -8.0, 9.0, -9.0, -6.0, -2.0, -3.0, 4.0));
	d[1].mA = (ivec4(-7, -6, 6, -3));
	d[1].mB = (mat4(4.0, -5.0, -8.0, 8.0, -4.0, -9.0, 2.0, -1.0, -2.0, -3.0, 0.0, 4.0, 4.0, -1.0, -8.0, -8.0));
	d[1].mC = (mat4x3(7.0, 0.0, 0.0, -5.0, 7.0, 1.0, 8.0, 7.0, 6.0, -4.0, 5.0, -3.0));
	d[2].mA = (ivec4(6, 0, -4, 2));
	d[2].mB = (mat4(2.0, 1.0, 3.0, -8.0, 6.0, 9.0, 4.0, -5.0, 3.0, -4.0, -8.0, -1.0, -5.0, -6.0, 7.0, 9.0));
	d[2].mC = (mat4x3(-3.0, -1.0, -9.0, -5.0, -8.0, -6.0, -4.0, 1.0, 0.0, -2.0, 9.0, 9.0));
	g = (ivec4(-9, 9, -8, 0));
	h = u16vec4(uvec4(5u, 6u, 3u, 2u));
}
#version 450
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
	highp mat3x2 mA;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	mediump uvec2 a;
	sA b;
	int8_t c;
	sB d;
	lowp mat2x3 e[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	u8vec2 f;
	mediump mat3x2 g;
	lowp ivec4 h;
	bvec4 i;
	mediump uvec4 j[];
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(8u, 5u)) && allOk;
	allOk = compare_mat2x3(blockB.e[0], mat2x3(1.0, 5.0, 1.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[1], mat2x3(3.0, 7.0, 5.0, -6.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[2], mat2x3(-2.0, 4.0, -1.0, -1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[3], mat2x3(-6.0, 8.0, -7.0, -4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[4], mat2x3(2.0, 7.0, 8.0, -1.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[5], mat2x3(-1.0, 5.0, -9.0, 2.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[6], mat2x3(-3.0, -9.0, -2.0, 5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[7], mat2x3(-5.0, -1.0, 5.0, 8.0, -5.0, 7.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[0].f), uvec2(0u, 2u)) && allOk;
	allOk = compare_bvec4((blockC[0].i), bvec4(false, false, true, false)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[1].f), uvec2(5u, 2u)) && allOk;
	allOk = compare_bvec4((blockC[1].i), bvec4(true, false, true, false)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[2].f), uvec2(6u, 3u)) && allOk;
	allOk = compare_bvec4((blockC[2].i), bvec4(false, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(8u, 5u));
	blockB.d.mA = (mat3x2(-2.0, 7.0, -7.0, -6.0, -5.0, -9.0));
	blockB.e[0] = (mat2x3(4.0, -6.0, 2.0, 6.0, 4.0, 6.0));
	blockB.e[1] = (mat2x3(-5.0, 2.0, -9.0, -8.0, 3.0, 6.0));
	blockB.e[2] = (mat2x3(-6.0, 5.0, 6.0, -6.0, 3.0, 7.0));
	blockB.e[3] = (mat2x3(-8.0, -2.0, -6.0, -3.0, 0.0, 7.0));
	blockB.e[4] = (mat2x3(-1.0, -5.0, -8.0, 9.0, 7.0, -9.0));
	blockB.e[5] = (mat2x3(-8.0, -4.0, 0.0, -3.0, 9.0, 9.0));
	blockB.e[6] = (mat2x3(-2.0, 2.0, -6.0, 0.0, -6.0, -6.0));
	blockB.e[7] = (mat2x3(-4.0, -9.0, 4.0, -5.0, 8.0, 8.0));
	blockC[0].g = (mat3x2(2.0, -1.0, -2.0, 7.0, 2.0, -1.0));
	blockC[0].j[0] = (uvec4(6u, 4u, 9u, 9u));
	blockC[0].j[1] = (uvec4(3u, 2u, 7u, 5u));
	blockC[0].j[2] = (uvec4(7u, 2u, 1u, 2u));
	blockC[0].j[3] = (uvec4(5u, 3u, 3u, 5u));
	blockC[0].j[4] = (uvec4(9u, 8u, 8u, 6u));
	blockC[0].j[5] = (uvec4(9u, 5u, 2u, 0u));
	blockC[0].j[6] = (uvec4(0u, 5u, 6u, 6u));
	blockC[0].j[7] = (uvec4(0u, 7u, 1u, 8u));
	blockC[1].g = (mat3x2(3.0, -9.0, 4.0, -7.0, 8.0, -3.0));
	blockC[1].j[0] = (uvec4(9u, 7u, 0u, 6u));
	blockC[1].j[1] = (uvec4(0u, 6u, 5u, 6u));
	blockC[1].j[2] = (uvec4(5u, 2u, 3u, 3u));
	blockC[1].j[3] = (uvec4(4u, 1u, 5u, 0u));
	blockC[1].j[4] = (uvec4(1u, 9u, 8u, 1u));
	blockC[1].j[5] = (uvec4(1u, 6u, 0u, 8u));
	blockC[2].g = (mat3x2(7.0, 5.0, 4.0, -9.0, 0.0, 4.0));
	blockC[2].j[0] = (uvec4(7u, 2u, 6u, 7u));
}
#version 450
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
	layout(offset = 16) bvec4 b;
	layout(offset = 32) u8vec3 c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp uvec4 d;
	layout(offset = 16) bool e;
	layout(offset = 32) lowp uvec4 f;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump uvec3 g;
	layout(offset = 12) mediump uint h;
} blockD;

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a[0]), uvec3(3u, 1u, 9u)) && allOk;
	allOk = compare_bvec4((blockB.b), bvec4(false, false, false, false)) && allOk;
	allOk = compare_uvec4((blockC.d), uvec4(5u, 6u, 7u, 3u)) && allOk;
	allOk = compare_bool((blockC.e), false) && allOk;
	allOk = compare_uvec4((blockC.f), uvec4(1u, 8u, 5u, 6u)) && allOk;
	allOk = compare_uvec3((blockD.g), uvec3(1u, 3u, 5u)) && allOk;
	allOk = compare_uint((blockD.h), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec3(3u, 2u, 9u));
	blockB.b = (bvec4(true, true, true, true));
	blockB.c = u8vec3(uvec3(1u, 9u, 5u));
	blockC.d = (uvec4(8u, 3u, 9u, 8u));
	blockC.e = (false);
	blockC.f = (uvec4(3u, 8u, 2u, 9u));
	blockD.g = (uvec3(0u, 6u, 2u));
}
#version 450
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
	highp uvec4 mB;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	mediump mat2 a;
	highp ivec4 b[4];
	mediump ivec2 c[];
};
layout(scalar, binding = 2) buffer BlockC
{
	highp mat2x3 d;
	mediump mat3 e[];
} blockC[2];
layout(scalar, binding = 3) buffer BlockD
{
	mediump uint f;
	highp uvec2 g;
	lowp mat4x2 h;
	highp mat4 i;
	mediump ivec3 j[];
};
layout(scalar, binding = 4) buffer BlockE
{
	mediump mat4x2 k;
	bvec3 l;
	sA m;
	mediump vec4 n[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(a, mat2(-4.0, -3.0, 9.0, 4.0)) && allOk;
	allOk = compare_ivec4((b[0]), ivec4(3, -2, 6, -9)) && allOk;
	allOk = compare_ivec4((b[1]), ivec4(5, 4, 8, 2)) && allOk;
	allOk = compare_ivec4((b[2]), ivec4(8, -1, -2, -1)) && allOk;
	allOk = compare_ivec4((b[3]), ivec4(1, -2, -3, -8)) && allOk;
	allOk = compare_ivec2((c[0]), ivec2(1, -8)) && allOk;
	allOk = compare_mat2x3(blockC[0].d, mat2x3(7.0, 7.0, 9.0, -1.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3(blockC[0].e[0], mat3(0.0, 3.0, -1.0, 8.0, 0.0, -7.0, -5.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3(blockC[0].e[1], mat3(3.0, -7.0, 0.0, -8.0, -3.0, 8.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3(blockC[0].e[2], mat3(5.0, 9.0, -8.0, 6.0, 4.0, -5.0, -1.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(blockC[0].e[3], mat3(-5.0, 9.0, -8.0, 6.0, 4.0, -9.0, 5.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].d, mat2x3(0.0, -6.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(blockC[1].e[0], mat3(5.0, -7.0, -5.0, 3.0, -7.0, -7.0, -6.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3(blockC[1].e[1], mat3(4.0, 4.0, 5.0, 3.0, 5.0, -5.0, 1.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat3(blockC[1].e[2], mat3(0.0, -9.0, 1.0, 6.0, 0.0, -1.0, 3.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(blockC[1].e[3], mat3(5.0, -6.0, 5.0, 1.0, 5.0, 6.0, 9.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3(blockC[1].e[4], mat3(-9.0, 5.0, -1.0, 5.0, -5.0, -8.0, -3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(blockC[1].e[5], mat3(-1.0, 1.0, -8.0, 5.0, -7.0, 0.0, 0.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3(blockC[1].e[6], mat3(6.0, -5.0, 2.0, -5.0, -3.0, -4.0, 2.0, 5.0, 1.0)) && allOk;
	allOk = compare_uint((f), 5u) && allOk;
	allOk = compare_uvec2((g), uvec2(2u, 3u)) && allOk;
	allOk = compare_mat4(i, mat4(7.0, 3.0, -3.0, 5.0, 8.0, -7.0, -3.0, -1.0, 4.0, -8.0, 7.0, 0.0, 6.0, 4.0, 3.0, 7.0)) && allOk;
	allOk = compare_ivec3((j[0]), ivec3(-2, 9, 2)) && allOk;
	allOk = compare_ivec3((j[1]), ivec3(-3, -9, -2)) && allOk;
	allOk = compare_ivec3((j[2]), ivec3(-7, -1, 2)) && allOk;
	allOk = compare_ivec3((j[3]), ivec3(-6, 5, 6)) && allOk;
	allOk = compare_mat4x2(k, mat4x2(-6.0, -6.0, 1.0, 5.0, 0.0, -3.0, -6.0, 4.0)) && allOk;
	allOk = compare_uvec4((m.mA), uvec4(2u, 2u, 3u, 1u)) && allOk;
	allOk = compare_uvec4((m.mB), uvec4(2u, 6u, 3u, 1u)) && allOk;
	allOk = compare_vec4((n[0]), vec4(0.0, 5.0, -9.0, 4.0)) && allOk;
	allOk = compare_vec4((n[1]), vec4(9.0, -7.0, -9.0, 1.0)) && allOk;
	allOk = compare_vec4((n[2]), vec4(8.0, 8.0, 2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (ivec4(4, 4, -7, -7));
	b[1] = (ivec4(8, 1, -6, 9));
	b[2] = (ivec4(4, 7, 1, 5));
	b[3] = (ivec4(2, -1, -4, 9));
	c[0] = (ivec2(9, -5));
	blockC[0].e[0] = (mat3(9.0, -5.0, 4.0, 4.0, 3.0, -2.0, -7.0, -3.0, -7.0));
	blockC[0].e[1] = (mat3(6.0, -7.0, -7.0, 1.0, -6.0, -3.0, 0.0, -3.0, 5.0));
	blockC[0].e[2] = (mat3(3.0, -8.0, -2.0, -2.0, -6.0, 2.0, 0.0, -8.0, 1.0));
	blockC[0].e[3] = (mat3(3.0, 3.0, 0.0, -1.0, 1.0, 8.0, -2.0, 7.0, 1.0));
	blockC[1].e[0] = (mat3(-7.0, 5.0, -8.0, -1.0, 9.0, 3.0, -7.0, -3.0, 1.0));
	blockC[1].e[1] = (mat3(0.0, -3.0, -6.0, 7.0, -9.0, -4.0, 3.0, -7.0, 7.0));
	blockC[1].e[2] = (mat3(4.0, -4.0, 1.0, -3.0, 4.0, 0.0, 5.0, -9.0, 3.0));
	blockC[1].e[3] = (mat3(-1.0, -3.0, 8.0, 7.0, 7.0, -3.0, -6.0, -6.0, -5.0));
	blockC[1].e[4] = (mat3(-6.0, -9.0, 7.0, -3.0, 0.0, -2.0, -4.0, 6.0, 4.0));
	blockC[1].e[5] = (mat3(-3.0, -9.0, -9.0, -3.0, 8.0, -7.0, 1.0, 3.0, -6.0));
	blockC[1].e[6] = (mat3(5.0, 1.0, 4.0, -4.0, 2.0, 3.0, -6.0, 3.0, -7.0));
	f = (2u);
	h = (mat4x2(-2.0, -3.0, 1.0, -6.0, -3.0, -1.0, -4.0, -5.0));
	i = (mat4(-4.0, 9.0, 2.0, 4.0, 3.0, 6.0, -6.0, 1.0, -4.0, 1.0, 7.0, -4.0, -7.0, 0.0, -9.0, 6.0));
	k = (mat4x2(-5.0, -5.0, 4.0, 8.0, -2.0, 4.0, -9.0, 5.0));
	l = (bvec3(false, true, false));
	n[0] = (vec4(8.0, 6.0, -2.0, 2.0));
	n[1] = (vec4(2.0, -5.0, 4.0, 8.0));
	n[2] = (vec4(-9.0, 3.0, -8.0, -6.0));
}
#version 450
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
	highp uint a;
	i8vec2 b;
	lowp vec2 c;
	uint8_t d;
} blockB[];

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
#version 450
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

layout(std140, row_major, binding = 1) readonly buffer Block
{
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(3.0, 8.0, -6.0, -8.0, -3.0, 7.0, -7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[2][0], 7.0) && allOk;
	allOk = compare_float(var[2][1], 1.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[3][0], -6.0) && allOk;
	allOk = compare_float(var[3][1], 9.0) && allOk;
	allOk = compare_float(var[3][2], -4.0) && allOk;
	allOk = compare_vec3(var[0], vec3(4.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-5.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(7.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-6.0, 9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	u8vec3 var;
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(var), uvec3(4u, 3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp uint var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(-9.0, 1.0, 0.0, 2.0, 1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2x3(var, mat2x3(5.0, -7.0, 8.0, -5.0, 5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, column_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[0][3], -5.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[1][2], -9.0) && allOk;
	allOk = compare_float(var[1][3], -4.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], 8.0) && allOk;
	allOk = compare_float(var[2][3], -9.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-4.0, 7.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-7.0, 0.0, -9.0, -4.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-9.0, 9.0, 8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(8.0, 9.0, 9.0, 9.0, 9.0, -1.0, -9.0, 9.0, 7.0, 9.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp vec2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var[0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((var[1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[2]), vec2(-7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3(var[0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	u8vec4 var[3];
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(var[0]), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1]), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2]), uvec4(1u, 4u, 6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, column_major, binding = 1) readonly buffer Block
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

layout(std430, binding = 1) readonly buffer Block
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

layout(scalar, binding = 1) readonly buffer Block
{
	highp mat3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0], mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(6.0, 2.0, -2.0, -8.0, 6.0, -8.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(2.0, -5.0, -3.0, 8.0, -9.0, -7.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(4.0, 7.0, -9.0, 5.0, 0.0, -7.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(-1.0, -3.0, 9.0, -3.0, 4.0, 3.0, 3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(6.0, 8.0, -8.0, 7.0, -1.0, 4.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(2.0, 8.0, 8.0, -5.0, 4.0, -5.0, 8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(8.0, 6.0, -5.0, 8.0, 3.0, 2.0, -2.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4(var[0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(8.0, -5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(8.0, 7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-7.0, 4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(-7.0, -9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(5.0, -2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(-6.0, 8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(6.0, 4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(4.0, -6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-4.0, -7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(-3.0, 6.0, 6.0, -1.0, -2.0, -7.0, 1.0, 0.0, -5.0, 3.0, -7.0, 2.0, 6.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(5.0, -4.0, -3.0, 9.0, -8.0, -9.0, 2.0, 5.0, -3.0, -3.0, -4.0, 9.0, -2.0, -8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(-9.0, 0.0, 3.0, 0.0, 6.0, -5.0, 8.0, 6.0, -3.0, -9.0, -1.0, 2.0, 3.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(9.0, -8.0, -7.0, -1.0, -3.0, 9.0, -4.0, -9.0, 3.0, -3.0, -7.0, -7.0, 3.0, 1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(3.0, 0.0, 5.0, -1.0, 2.0, 2.0, -2.0, 3.0, -9.0, 7.0, 0.0, -8.0, -4.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(-2.0, 8.0, -8.0, -3.0, 0.0, -5.0, 4.0, -3.0, -1.0, -8.0, 4.0, -2.0, -7.0, 0.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(1.0, 5.0, -7.0, -8.0, 2.0, 4.0, -9.0, -7.0, -4.0, 6.0, -7.0, 0.0, 5.0, 3.0, -3.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, buffer_reference) buffer Block
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], 4.0) && allOk;
	allOk = compare_float(block.var[0][1], -8.0) && allOk;
	allOk = compare_float(block.var[0][2], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], -8.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_float(block.var[1][2], 4.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(4.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-8.0, -9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(7.0, -2.0, -7.0, 8.0, -4.0, 9.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(-1.0, 2.0, -7.0, 9.0, -8.0, 7.0, -7.0, -6.0, -6.0, 1.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(0.0, -8.0, -5.0, -7.0));
	block.var[1] = (vec4(1.0, 2.0, -4.0, -6.0));
	block.var[2] = (vec4(6.0, 2.0, 2.0, 0.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(-4.0, 8.0, 9.0, 9.0, 9.0, 9.0, -1.0, -9.0, 9.0, 7.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(4.0, 9.0, 2.0, 7.0, -6.0, -9.0, 2.0, -3.0, 1.0, 4.0, 3.0, 2.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
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
	allOk = compare_mat3(block.var, mat3(6.0, -1.0, -9.0, 1.0, -6.0, 5.0, 1.0, 0.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-1.0, -1.0, 4.0));
	block.var[1] = (vec3(-4.0, 0.0, 5.0));
	block.var[2] = (vec3(5.0, 5.0, -8.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], 9.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], 2.0) && allOk;
	allOk = compare_float(block.var[2][0], 6.0) && allOk;
	allOk = compare_float(block.var[2][1], 3.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-4.0, -5.0, 8.0, -8.0, -7.0, -9.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(-4.0, 1.0, -2.0, -6.0, 1.0, 6.0, -7.0, 4.0, 3.0, -5.0, 1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-7.0, -9.0, 3.0));
	block.var[1] = (vec3(-3.0, -5.0, -8.0));
	block.var[2] = (vec3(5.0, -3.0, -6.0));
	block.var[3] = (vec3(1.0, 6.0, -7.0));
}
#version 450
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
	highp vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_vec4((block.var), vec4(-4.0, -9.0, -6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var = (vec4(1.0, 5.0, 7.0, -4.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], -5.0) && allOk;
	allOk = compare_float(block.var[0][2], 8.0) && allOk;
	allOk = compare_float(block.var[0][3], 3.0) && allOk;
	allOk = compare_float(block.var[1][0], -9.0) && allOk;
	allOk = compare_float(block.var[1][1], 2.0) && allOk;
	allOk = compare_float(block.var[1][2], 2.0) && allOk;
	allOk = compare_float(block.var[1][3], 2.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(1.0, -5.0, 8.0, 3.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-9.0, 2.0, 2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0] = (vec4(5.0, -3.0, 7.0, 4.0));
	block.var[1] = (vec4(-6.0, 0.0, 2.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_mat3x4(block.var, mat3x4(-8.0, -3.0, 4.0, -5.0, -8.0, 3.0, 2.0, -4.0, -1.0, -2.0, -5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var[0] = (vec4(6.0, -2.0, 8.0, -8.0));
	block.var[1] = (vec4(4.0, -8.0, -3.0, -9.0));
	block.var[2] = (vec4(8.0, -6.0, 0.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat4x3(block.var, mat4x3(-2.0, 9.0, 1.0, 7.0, 8.0, 6.0, -6.0, -1.0, 4.0, -6.0, 2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var = (mat4x3(4.0, 5.0, -8.0, -8.0, 2.0, 7.0, 9.0, 8.0, 4.0, -9.0, 9.0, 9.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	block.var[0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block.var[1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	block.var[1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	block.var[2][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	block.var[2][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	block.var[1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	block.var[2] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	bool var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.var[0]), false) && allOk;
	allOk = compare_bool((block.var[1]), true) && allOk;
	allOk = compare_bool((block.var[2]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (false);
	block.var[1] = (false);
	block.var[2] = (true);
}
#version 450
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
	bvec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.padding), true) && allOk;
	allOk = compare_bvec3((block.var[0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[2]), bvec3(true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (true);
	block.var[0] = (bvec3(true, false, false));
	block.var[1] = (bvec3(true, true, false));
	block.var[2] = (bvec3(false, false, true));
}
#version 450
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_mat3(block.var[0], mat3(2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0][0] = (vec3(1.0, 4.0, 6.0));
	block.var[0][1] = (vec3(-5.0, -5.0, 9.0));
	block.var[0][2] = (vec3(-6.0, 5.0, 7.0));
	block.var[1][0] = (vec3(7.0, -2.0, -4.0));
	block.var[1][1] = (vec3(1.0, -5.0, 8.0));
	block.var[1][2] = (vec3(-1.0, -8.0, -6.0));
	block.var[2][0] = (vec3(-4.0, 5.0, 3.0));
	block.var[2][1] = (vec3(9.0, -8.0, -4.0));
	block.var[2][2] = (vec3(8.0, 0.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat3x4(block.var[0], mat3x4(9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8.0);
	block.var[0][0] = (vec4(8.0, -2.0, 8.0, 8.0));
	block.var[0][1] = (vec4(3.0, 5.0, -5.0, 7.0));
	block.var[0][2] = (vec4(6.0, -9.0, 3.0, 0.0));
	block.var[1][0] = (vec4(-3.0, 1.0, -9.0, -9.0));
	block.var[1][1] = (vec4(-6.0, -5.0, 1.0, 9.0));
	block.var[1][2] = (vec4(0.0, -9.0, -2.0, -4.0));
	block.var[2][0] = (vec4(-3.0, -1.0, -6.0, 1.0));
	block.var[2][1] = (vec4(-2.0, -2.0, -1.0, -7.0));
	block.var[2][2] = (vec4(8.0, 0.0, -6.0, -1.0));
}
#version 450
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
	i16vec4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.padding), -6) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0]), ivec4(-9, 9, 8, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1]), ivec4(-8, 8, 9, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2]), ivec4(4, 0, 9, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int16_t(-4);
	block.var[0] = i16vec4(ivec4(-8, -4, 9, 2));
	block.var[1] = i16vec4(ivec4(7, -4, 4, 8));
	block.var[2] = i16vec4(ivec4(9, 5, 1, -3));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(5.0, 8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(-6.0, -5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-1.0, -6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(-9.0, -1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(-2.0, 7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(-9.0, 9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(1.0, 8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(4.0, -6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(9.0, -9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(6.0, 1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(-3.0, 2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(-1.0, -3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(9.0, -6.0, 0.0, -6.0, -4.0, 0.0, 7.0, 0.0, 7.0, 0.0, 8.0, 2.0, -6.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(9.0, -2.0, 1.0, -9.0, -6.0, -1.0, -4.0, 6.0, 8.0, -7.0, 1.0, 3.0, -9.0, 5.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(-2.0, 4.0, 5.0, 9.0, 0.0, 0.0, 9.0, 3.0, -9.0, -4.0, 5.0, -2.0, 7.0, 9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(9.0, 0.0, -2.0, -7.0, -8.0, 0.0, 3.0, -1.0, -9.0, 1.0, 9.0, -1.0, 5.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(4.0, -5.0, -9.0, 5.0, 4.0, 7.0, 0.0, -6.0, -5.0, -9.0, 6.0, 9.0, 4.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(2.0, 5.0, 9.0, -6.0, 4.0, 6.0, -4.0, 1.0, 6.0, 1.0, 3.0, 4.0, 3.0, 8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(-2.0, -4.0, 3.0, -3.0, 5.0, 1.0, -7.0, 8.0, 7.0, -9.0, -3.0, 7.0, 9.0, -9.0, -5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	block.var[1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	block.var[2] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
	block.var[3] = (mat4(-3.0, -9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0));
	block.var[4] = (mat4(1.0, 5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0));
	block.var[5] = (mat4(-7.0, 5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0));
	block.var[6] = (mat4(6.0, -8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0));
	block.var[7] = (mat4(6.0, 9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0));
	block.var[8] = (mat4(6.0, -6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0));
	block.var[9] = (mat4(-5.0, 3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0));
	block.var[10] = (mat4(-9.0, 5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0));
	block.var[11] = (mat4(5.0, -1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0));
	block.var[12] = (mat4(-4.0, -9.0, -7.0, -9.0, -9.0, -3.0, -8.0, 0.0, -1.0, -4.0, -1.0, -8.0, 5.0, -8.0, -3.0, 1.0));
	block.var[13] = (mat4(-1.0, -6.0, -1.0, 0.0, -8.0, 6.0, 6.0, -5.0, -6.0, 9.0, 2.0, 6.0, 6.0, -5.0, -7.0, 0.0));
	block.var[14] = (mat4(2.0, 6.0, 3.0, 6.0, 1.0, -3.0, -6.0, 0.0, -2.0, 0.0, -9.0, 1.0, 6.0, 9.0, -9.0, 0.0));
	block.var[15] = (mat4(-9.0, 4.0, 1.0, 5.0, 0.0, 9.0, 3.0, -2.0, -8.0, 9.0, -9.0, 2.0, -8.0, 0.0, 7.0, 7.0));
	block.var[16] = (mat4(6.0, -5.0, 5.0, 3.0, -2.0, -8.0, 6.0, 2.0, 7.0, -1.0, -2.0, 8.0, -9.0, 1.0, -4.0, 1.0));
	block.var[17] = (mat4(-5.0, -8.0, 1.0, 9.0, -7.0, -4.0, 0.0, -3.0, 6.0, 2.0, 2.0, -2.0, -8.0, 4.0, 1.0, 7.0));
	block.var[18] = (mat4(4.0, -5.0, 2.0, -2.0, -1.0, 1.0, 4.0, 0.0, -1.0, -4.0, -1.0, 2.0, -4.0, 7.0, -7.0, -7.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	highp ivec3 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.var[0]), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((block.var[1]), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((block.var[2]), ivec3(3, -1, -7)) && allOk;
	allOk = compare_ivec3((block.var[3]), ivec3(-1, 2, 9)) && allOk;
	allOk = compare_ivec3((block.var[4]), ivec3(-8, 4, 9)) && allOk;
	allOk = compare_ivec3((block.var[5]), ivec3(-3, -3, -9)) && allOk;
	allOk = compare_ivec3((block.var[6]), ivec3(9, 3, -6)) && allOk;
	allOk = compare_ivec3((block.var[7]), ivec3(-6, 7, 3)) && allOk;
	allOk = compare_ivec3((block.var[8]), ivec3(6, 9, 0)) && allOk;
	allOk = compare_ivec3((block.var[9]), ivec3(5, 8, 2)) && allOk;
	allOk = compare_ivec3((block.var[10]), ivec3(7, -7, 2)) && allOk;
	allOk = compare_ivec3((block.var[11]), ivec3(1, -4, 0)) && allOk;
	allOk = compare_ivec3((block.var[12]), ivec3(2, -2, 7)) && allOk;
	allOk = compare_ivec3((block.var[13]), ivec3(5, 2, 0)) && allOk;
	allOk = compare_ivec3((block.var[14]), ivec3(9, 6, 7)) && allOk;
	allOk = compare_ivec3((block.var[15]), ivec3(0, 4, -6)) && allOk;
	allOk = compare_ivec3((block.var[16]), ivec3(1, 7, 4)) && allOk;
	allOk = compare_ivec3((block.var[17]), ivec3(-6, 9, 3)) && allOk;
	allOk = compare_ivec3((block.var[18]), ivec3(1, 5, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (ivec3(-5, 0, -9));
	block.var[1] = (ivec3(2, 4, 1));
	block.var[2] = (ivec3(6, 6, 2));
	block.var[3] = (ivec3(4, 4, 2));
	block.var[4] = (ivec3(-4, -1, -7));
	block.var[5] = (ivec3(8, -4, 1));
	block.var[6] = (ivec3(-4, -1, 5));
	block.var[7] = (ivec3(-4, 2, -2));
	block.var[8] = (ivec3(6, 7, -1));
	block.var[9] = (ivec3(-1, -3, -1));
	block.var[10] = (ivec3(-4, -1, -3));
	block.var[11] = (ivec3(6, -3, 8));
	block.var[12] = (ivec3(6, -8, 1));
	block.var[13] = (ivec3(-5, -4, 9));
	block.var[14] = (ivec3(-2, 6, -6));
	block.var[15] = (ivec3(-7, 3, 0));
	block.var[16] = (ivec3(-7, -5, -7));
	block.var[17] = (ivec3(-7, -2, -9));
	block.var[18] = (ivec3(6, 7, -4));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(-7.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(9.0, -6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(-7.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(3.0, -4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(-8.0, -4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(2.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(2.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(9.0, 6.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(-8.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(6.0, 6.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(0.0, -7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(-9.0, 1.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(4.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(9.0, -5.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(2.0, 4.0, 4.0, -1.0));
	block.var[1] = (mat2(2.0, -5.0, 1.0, -1.0));
	block.var[2] = (mat2(-2.0, -9.0, -3.0, -8.0));
	block.var[3] = (mat2(-6.0, -7.0, 1.0, -1.0));
	block.var[4] = (mat2(6.0, 2.0, -7.0, 8.0));
	block.var[5] = (mat2(-3.0, -2.0, 2.0, -7.0));
	block.var[6] = (mat2(-1.0, -3.0, -7.0, 2.0));
	block.var[7] = (mat2(-3.0, -6.0, 2.0, 7.0));
	block.var[8] = (mat2(4.0, -2.0, -7.0, 4.0));
	block.var[9] = (mat2(-7.0, -5.0, -7.0, -5.0));
	block.var[10] = (mat2(-6.0, 4.0, 6.0, 4.0));
	block.var[11] = (mat2(2.0, -1.0, 9.0, 6.0));
	block.var[12] = (mat2(-5.0, 7.0, -8.0, 6.0));
	block.var[13] = (mat2(1.0, 0.0, 7.0, -3.0));
	block.var[14] = (mat2(9.0, -8.0, -6.0, -9.0));
	block.var[15] = (mat2(-6.0, 8.0, 1.0, -2.0));
	block.var[16] = (mat2(-4.0, -5.0, -4.0, 2.0));
	block.var[17] = (mat2(4.0, -9.0, 8.0, -9.0));
	block.var[18] = (mat2(-2.0, 2.0, 3.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(6.0, 7.0, 9.0, 7.0, 0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(7.0, -7.0, 1.0, 0.0, -9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(0.0, 8.0, -8.0, -9.0, 5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(9.0, -4.0, -6.0, 0.0, 0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(5.0, 2.0, -1.0, 1.0, 1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(-5.0, 1.0, 4.0, 5.0, 5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(-2.0, -2.0, 7.0, -9.0, 3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	block.var[0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block.var[0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block.var[1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	block.var[1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	block.var[1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block.var[2][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	block.var[2][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block.var[2][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	block.var[3][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	block.var[3][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	block.var[3][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	block.var[4][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	block.var[4][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	block.var[4][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	block.var[5][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	block.var[5][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	block.var[5][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	block.var[6][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	block.var[6][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	block.var[6][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	block.var[7][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	block.var[7][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	block.var[7][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	block.var[8][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	block.var[8][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	block.var[8][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	block.var[9][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	block.var[9][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	block.var[9][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	block.var[10][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	block.var[10][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	block.var[10][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	block.var[11][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	block.var[11][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	block.var[11][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
	block.var[12][0] = (vec4(6.0, 2.0, 8.0, -5.0));
	block.var[12][1] = (vec4(9.0, 5.0, 9.0, -1.0));
	block.var[12][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[13][0] = (vec4(0.0, -4.0, 7.0, 1.0));
	block.var[13][1] = (vec4(4.0, 1.0, 9.0, 9.0));
	block.var[13][2] = (vec4(-9.0, -5.0, 3.0, 8.0));
	block.var[14][0] = (vec4(4.0, -1.0, -2.0, 2.0));
	block.var[14][1] = (vec4(-5.0, 4.0, -2.0, -4.0));
	block.var[14][2] = (vec4(8.0, -7.0, -1.0, -9.0));
	block.var[15][0] = (vec4(8.0, 5.0, 3.0, 6.0));
	block.var[15][1] = (vec4(0.0, 6.0, 0.0, 2.0));
	block.var[15][2] = (vec4(-1.0, -5.0, -6.0, -4.0));
	block.var[16][0] = (vec4(-3.0, -5.0, -4.0, -4.0));
	block.var[16][1] = (vec4(-8.0, -8.0, 1.0, 7.0));
	block.var[16][2] = (vec4(-6.0, -3.0, -7.0, 1.0));
	block.var[17][0] = (vec4(-5.0, 5.0, 0.0, 1.0));
	block.var[17][1] = (vec4(6.0, 2.0, 5.0, 5.0));
	block.var[17][2] = (vec4(5.0, -1.0, -7.0, -1.0));
	block.var[18][0] = (vec4(1.0, -1.0, -4.0, 2.0));
	block.var[18][1] = (vec4(5.0, 8.0, 5.0, -9.0));
	block.var[18][2] = (vec4(7.0, -9.0, 0.0, -3.0));
}
#version 450
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
	bool var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.var[0]), false) && allOk;
	allOk = compare_bool((block.var[1]), true) && allOk;
	allOk = compare_bool((block.var[2]), true) && allOk;
	allOk = compare_bool((block.var[3]), false) && allOk;
	allOk = compare_bool((block.var[4]), false) && allOk;
	allOk = compare_bool((block.var[5]), true) && allOk;
	allOk = compare_bool((block.var[6]), true) && allOk;
	allOk = compare_bool((block.var[7]), false) && allOk;
	allOk = compare_bool((block.var[8]), false) && allOk;
	allOk = compare_bool((block.var[9]), false) && allOk;
	allOk = compare_bool((block.var[10]), false) && allOk;
	allOk = compare_bool((block.var[11]), true) && allOk;
	allOk = compare_bool((block.var[12]), true) && allOk;
	allOk = compare_bool((block.var[13]), false) && allOk;
	allOk = compare_bool((block.var[14]), true) && allOk;
	allOk = compare_bool((block.var[15]), true) && allOk;
	allOk = compare_bool((block.var[16]), false) && allOk;
	allOk = compare_bool((block.var[17]), true) && allOk;
	allOk = compare_bool((block.var[18]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (false);
	block.var[1] = (false);
	block.var[2] = (true);
	block.var[3] = (true);
	block.var[4] = (false);
	block.var[5] = (false);
	block.var[6] = (true);
	block.var[7] = (true);
	block.var[8] = (true);
	block.var[9] = (true);
	block.var[10] = (false);
	block.var[11] = (false);
	block.var[12] = (false);
	block.var[13] = (false);
	block.var[14] = (true);
	block.var[15] = (false);
	block.var[16] = (true);
	block.var[17] = (false);
	block.var[18] = (true);
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(1.0, 7.0, -4.0, 6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(5.0, 4.0, 8.0, -8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(6.0, 3.0, 0.0, -3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(5.0, -7.0, -7.0, -6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(2.0, 5.0, 2.0, 0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(-9.0, -1.0, -2.0, -2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(-5.0, -8.0, 7.0, 3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(5.0, 2.0, 7.0, 6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(-7.0, 4.0, 6.0, 2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(8.0, 3.0, -4.0, -1.0, -1.0, 6.0, 4.0, -5.0, 5.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(-2.0, -4.0, 7.0, -7.0, -5.0, 7.0, 0.0, 0.0, -1.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(8.0, 9.0, 4.0, 2.0, 6.0, 1.0, -3.0, 0.0, 1.0, -6.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(0.0, 9.0, 4.0, -6.0, 8.0, 9.0, 3.0, -5.0, -8.0, 4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(7.0, -4.0, -1.0, -2.0, 6.0, 7.0, 5.0, -4.0, 3.0, 1.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(4.0, -5.0, 9.0, 5.0, 6.0, 2.0, 5.0, 5.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(-4.0, -2.0, -6.0, -6.0, -1.0, -4.0, 1.0, 5.0, -2.0, 2.0, -5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(1.0, 3.0, -7.0));
	block.var[0][1] = (vec3(-7.0, 2.0, 3.0));
	block.var[0][2] = (vec3(1.0, -2.0, -1.0));
	block.var[0][3] = (vec3(-5.0, -1.0, 9.0));
	block.var[1][0] = (vec3(8.0, -4.0, 3.0));
	block.var[1][1] = (vec3(4.0, 9.0, -6.0));
	block.var[1][2] = (vec3(7.0, 6.0, -5.0));
	block.var[1][3] = (vec3(2.0, 6.0, 3.0));
	block.var[2][0] = (vec3(2.0, 7.0, -1.0));
	block.var[2][1] = (vec3(-3.0, -3.0, -7.0));
	block.var[2][2] = (vec3(-5.0, 3.0, 4.0));
	block.var[2][3] = (vec3(-4.0, -2.0, 8.0));
	block.var[3][0] = (vec3(-1.0, -8.0, 8.0));
	block.var[3][1] = (vec3(-4.0, -7.0, -7.0));
	block.var[3][2] = (vec3(8.0, 4.0, -6.0));
	block.var[3][3] = (vec3(6.0, 0.0, 1.0));
	block.var[4][0] = (vec3(7.0, -1.0, -8.0));
	block.var[4][1] = (vec3(9.0, 9.0, -6.0));
	block.var[4][2] = (vec3(0.0, 1.0, 1.0));
	block.var[4][3] = (vec3(2.0, 7.0, 2.0));
	block.var[5][0] = (vec3(-3.0, -6.0, 5.0));
	block.var[5][1] = (vec3(3.0, -1.0, -1.0));
	block.var[5][2] = (vec3(-2.0, 9.0, -5.0));
	block.var[5][3] = (vec3(8.0, -6.0, -5.0));
	block.var[6][0] = (vec3(-9.0, 3.0, -2.0));
	block.var[6][1] = (vec3(5.0, 6.0, -7.0));
	block.var[6][2] = (vec3(-8.0, 1.0, 8.0));
	block.var[6][3] = (vec3(1.0, 6.0, -1.0));
	block.var[7][0] = (vec3(-5.0, 0.0, -6.0));
	block.var[7][1] = (vec3(5.0, -3.0, 2.0));
	block.var[7][2] = (vec3(-5.0, 2.0, -2.0));
	block.var[7][3] = (vec3(-7.0, -9.0, -1.0));
	block.var[8][0] = (vec3(-2.0, -3.0, -7.0));
	block.var[8][1] = (vec3(-9.0, -4.0, 9.0));
	block.var[8][2] = (vec3(4.0, -4.0, 5.0));
	block.var[8][3] = (vec3(7.0, 1.0, 7.0));
	block.var[9][0] = (vec3(-9.0, 5.0, 4.0));
	block.var[9][1] = (vec3(4.0, 0.0, 0.0));
	block.var[9][2] = (vec3(0.0, -3.0, 3.0));
	block.var[9][3] = (vec3(1.0, 8.0, 0.0));
	block.var[10][0] = (vec3(-2.0, 9.0, -8.0));
	block.var[10][1] = (vec3(-8.0, 7.0, -9.0));
	block.var[10][2] = (vec3(3.0, -2.0, -3.0));
	block.var[10][3] = (vec3(-5.0, 1.0, -4.0));
	block.var[11][0] = (vec3(5.0, 5.0, 8.0));
	block.var[11][1] = (vec3(3.0, 7.0, -3.0));
	block.var[11][2] = (vec3(-2.0, 2.0, -9.0));
	block.var[11][3] = (vec3(0.0, 9.0, 5.0));
	block.var[12][0] = (vec3(-5.0, 5.0, -2.0));
	block.var[12][1] = (vec3(1.0, -7.0, -9.0));
	block.var[12][2] = (vec3(4.0, -9.0, 8.0));
	block.var[12][3] = (vec3(2.0, 5.0, -4.0));
	block.var[13][0] = (vec3(-9.0, -9.0, 5.0));
	block.var[13][1] = (vec3(-3.0, 6.0, -3.0));
	block.var[13][2] = (vec3(7.0, -9.0, -4.0));
	block.var[13][3] = (vec3(9.0, 6.0, 2.0));
	block.var[14][0] = (vec3(-3.0, -5.0, 2.0));
	block.var[14][1] = (vec3(-9.0, 5.0, -6.0));
	block.var[14][2] = (vec3(5.0, -7.0, -9.0));
	block.var[14][3] = (vec3(0.0, 9.0, 9.0));
	block.var[15][0] = (vec3(-9.0, 5.0, 5.0));
	block.var[15][1] = (vec3(-2.0, 7.0, 7.0));
	block.var[15][2] = (vec3(-2.0, 7.0, -9.0));
	block.var[15][3] = (vec3(5.0, 5.0, -4.0));
	block.var[16][0] = (vec3(6.0, -3.0, 7.0));
	block.var[16][1] = (vec3(-3.0, 1.0, -7.0));
	block.var[16][2] = (vec3(-1.0, 0.0, -9.0));
	block.var[16][3] = (vec3(0.0, -4.0, 9.0));
	block.var[17][0] = (vec3(-6.0, -5.0, 7.0));
	block.var[17][1] = (vec3(6.0, 1.0, -2.0));
	block.var[17][2] = (vec3(2.0, 8.0, 9.0));
	block.var[17][3] = (vec3(2.0, -8.0, -9.0));
	block.var[18][0] = (vec3(-1.0, -5.0, 2.0));
	block.var[18][1] = (vec3(4.0, 7.0, -4.0));
	block.var[18][2] = (vec3(6.0, 2.0, -4.0));
	block.var[18][3] = (vec3(8.0, -8.0, -1.0));
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat4(block.var[0][0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(-3.0, 8.0, -3.0, -7.0, -4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(3.0, -9.0, -5.0, 9.0, -5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(6.0, -4.0, -9.0, 2.0, 1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(5.0, -7.0, -8.0, -6.0, 7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(-6.0, -8.0, 2.0, -5.0, 0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(-1.0, 5.0, 8.0, -3.0, -9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(-3.0, 3.0, 3.0, -3.0, -6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(-8.0, -8.0, 8.0, -1.0, -8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(8.0, 8.0, -7.0, -5.0, 0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-9.0, 0.0, -1.0, -4.0));
	block.var[0][0][1] = (vec4(-9.0, -4.0, -9.0, -5.0));
	block.var[0][0][2] = (vec4(-2.0, 9.0, 0.0, -8.0));
	block.var[0][0][3] = (vec4(-6.0, -3.0, -8.0, 3.0));
	block.var[0][1][0] = (vec4(4.0, 9.0, 4.0, -3.0));
	block.var[0][1][1] = (vec4(7.0, -9.0, 6.0, 5.0));
	block.var[0][1][2] = (vec4(6.0, -1.0, -3.0, -3.0));
	block.var[0][1][3] = (vec4(-9.0, 3.0, -9.0, 0.0));
	block.var[0][2][0] = (vec4(1.0, -4.0, -6.0, 5.0));
	block.var[0][2][1] = (vec4(2.0, 1.0, 9.0, -4.0));
	block.var[0][2][2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	block.var[0][2][3] = (vec4(9.0, 9.0, -5.0, -7.0));
	block.var[1][0][0] = (vec4(-9.0, 5.0, 8.0, 6.0));
	block.var[1][0][1] = (vec4(4.0, 6.0, -1.0, -7.0));
	block.var[1][0][2] = (vec4(7.0, 8.0, 5.0, -1.0));
	block.var[1][0][3] = (vec4(8.0, 2.0, -8.0, 0.0));
	block.var[1][1][0] = (vec4(-9.0, -1.0, -5.0, 7.0));
	block.var[1][1][1] = (vec4(3.0, 1.0, 2.0, 2.0));
	block.var[1][1][2] = (vec4(-3.0, -7.0, 1.0, 0.0));
	block.var[1][1][3] = (vec4(9.0, 5.0, -2.0, 6.0));
	block.var[1][2][0] = (vec4(-9.0, 1.0, 2.0, -3.0));
	block.var[1][2][1] = (vec4(-2.0, -2.0, -8.0, -4.0));
	block.var[1][2][2] = (vec4(7.0, -4.0, -1.0, 2.0));
	block.var[1][2][3] = (vec4(7.0, 7.0, 2.0, 8.0));
	block.var[2][0][0] = (vec4(-5.0, 9.0, 9.0, 4.0));
	block.var[2][0][1] = (vec4(6.0, -2.0, -1.0, -2.0));
	block.var[2][0][2] = (vec4(0.0, 5.0, -4.0, 5.0));
	block.var[2][0][3] = (vec4(8.0, -8.0, 9.0, -3.0));
	block.var[2][1][0] = (vec4(4.0, -8.0, -1.0, 0.0));
	block.var[2][1][1] = (vec4(-3.0, -4.0, -7.0, 1.0));
	block.var[2][1][2] = (vec4(4.0, -2.0, 1.0, -8.0));
	block.var[2][1][3] = (vec4(-8.0, 5.0, 4.0, 7.0));
	block.var[2][2][0] = (vec4(7.0, -2.0, -6.0, 9.0));
	block.var[2][2][1] = (vec4(-7.0, -5.0, 2.0, 2.0));
	block.var[2][2][2] = (vec4(4.0, 8.0, 4.0, -9.0));
	block.var[2][2][3] = (vec4(0.0, -9.0, 0.0, 0.0));
	block.var[3][0][0] = (vec4(9.0, -1.0, -1.0, -3.0));
	block.var[3][0][1] = (vec4(-9.0, -6.0, -8.0, 4.0));
	block.var[3][0][2] = (vec4(-6.0, 9.0, -8.0, 3.0));
	block.var[3][0][3] = (vec4(0.0, 1.0, -1.0, -7.0));
	block.var[3][1][0] = (vec4(-9.0, -4.0, 4.0, 6.0));
	block.var[3][1][1] = (vec4(4.0, 9.0, 4.0, -4.0));
	block.var[3][1][2] = (vec4(3.0, -1.0, 2.0, 8.0));
	block.var[3][1][3] = (vec4(-3.0, -6.0, -4.0, 0.0));
	block.var[3][2][0] = (vec4(2.0, -1.0, 1.0, -1.0));
	block.var[3][2][1] = (vec4(8.0, 5.0, 3.0, 0.0));
	block.var[3][2][2] = (vec4(-2.0, 0.0, 7.0, -5.0));
	block.var[3][2][3] = (vec4(6.0, 0.0, 6.0, -6.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0], mat2x3(2.0, -7.0, 8.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(5.0, -2.0, 1.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(6.0, 7.0, 2.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(-5.0, 5.0, 9.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(9.0, 7.0, 9.0, 5.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(1.0, 4.0, -6.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(-9.0, 9.0, 8.0, -5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(9.0, -3.0, -8.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(-8.0, 9.0, 4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(-4.0, -8.0, 0.0, -2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(-3.0, 2.0, 2.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(-3.0, 9.0, -3.0, -8.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	block.var[0][1] = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	block.var[0][2] = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
	block.var[1][0] = (mat2x3(-4.0, 3.0, 7.0, -5.0, -6.0, 7.0));
	block.var[1][1] = (mat2x3(3.0, 8.0, -7.0, -7.0, -6.0, 2.0));
	block.var[1][2] = (mat2x3(-8.0, 8.0, -7.0, -2.0, 5.0, 7.0));
	block.var[2][0] = (mat2x3(4.0, -7.0, -7.0, 6.0, -8.0, -8.0));
	block.var[2][1] = (mat2x3(7.0, -8.0, 4.0, 7.0, 0.0, 3.0));
	block.var[2][2] = (mat2x3(9.0, 4.0, 7.0, 4.0, -7.0, 6.0));
	block.var[3][0] = (mat2x3(1.0, 3.0, 2.0, -1.0, -8.0, -8.0));
	block.var[3][1] = (mat2x3(2.0, 9.0, -3.0, -1.0, -2.0, -1.0));
	block.var[3][2] = (mat2x3(-1.0, 8.0, 1.0, -6.0, -9.0, -3.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(-5.0, -8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(1.0, 4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(4.0, 4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-2.0, 5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(-9.0, -7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(-5.0, -4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(-9.0, 2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(-5.0, 2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(6.0, 1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	block.var[0][1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	block.var[0][2] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
	block.var[1][0] = (mat2x4(-3.0, -9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0));
	block.var[1][1] = (mat2x4(-3.0, -3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0));
	block.var[1][2] = (mat2x4(4.0, 9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0));
	block.var[2][0] = (mat2x4(-6.0, 9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0));
	block.var[2][1] = (mat2x4(8.0, -6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0));
	block.var[2][2] = (mat2x4(-1.0, 2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0));
	block.var[3][0] = (mat2x4(2.0, 0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0));
	block.var[3][1] = (mat2x4(5.0, -8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0));
	block.var[3][2] = (mat2x4(4.0, 9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2(3.0, -6.0, 2.0, -8.0));
	block.var[0][1] = (mat2(2.0, -5.0, -3.0, 9.0));
	block.var[0][2] = (mat2(4.0, -9.0, -2.0, -6.0));
	block.var[1][0] = (mat2(-2.0, 4.0, -5.0, -1.0));
	block.var[1][1] = (mat2(3.0, 1.0, 6.0, 0.0));
	block.var[1][2] = (mat2(-2.0, -5.0, 2.0, 8.0));
	block.var[2][0] = (mat2(-2.0, -7.0, -8.0, 6.0));
	block.var[2][1] = (mat2(2.0, 3.0, -8.0, 4.0));
	block.var[2][2] = (mat2(7.0, -3.0, 8.0, -1.0));
	block.var[3][0] = (mat2(7.0, -8.0, 5.0, -2.0));
	block.var[3][1] = (mat2(-5.0, -2.0, -2.0, 1.0));
	block.var[3][2] = (mat2(6.0, 0.0, 1.0, 8.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	block.var[0][1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	block.var[0][2] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
	block.var[1][0] = (mat2x4(-7.0, -4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0));
	block.var[1][1] = (mat2x4(0.0, -4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0));
	block.var[1][2] = (mat2x4(3.0, -8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0));
	block.var[2][0] = (mat2x4(4.0, -7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0));
	block.var[2][1] = (mat2x4(-2.0, 1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0));
	block.var[2][2] = (mat2x4(-8.0, 7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0));
	block.var[3][0] = (mat2x4(2.0, 9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0));
	block.var[3][1] = (mat2x4(5.0, -9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0));
	block.var[3][2] = (mat2x4(-6.0, -9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(7.0, -4.0, -4.0, -6.0, 9.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(-2.0, 5.0, 6.0, 4.0, -6.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(-5.0, 9.0, -4.0, -6.0, 4.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(-4.0, 9.0, -1.0, -6.0, 5.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(-7.0, -7.0, -9.0, 9.0, 5.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(-6.0, -5.0, -7.0, -3.0, 6.0, -7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(7.0, -9.0, -5.0, -3.0, -6.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(-4.0, -9.0, 9.0, -7.0, -6.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(8.0, 6.0, 7.0, -6.0, 0.0, 0.0, 6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	block.var[0][1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	block.var[0][2] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	block.var[1][0] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	block.var[1][1] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	block.var[1][2] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	block.var[2][0] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	block.var[2][1] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	block.var[2][2] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	block.var[3][0] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	block.var[3][1] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	block.var[3][2] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
}
#version 450
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
	u16vec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(block.var[0][0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][2]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][2]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][0]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][1]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3][2]), uvec4(7u, 0u, 8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	block.var[0][1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	block.var[0][2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	block.var[1][0] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	block.var[1][1] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	block.var[1][2] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	block.var[2][0] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	block.var[2][1] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	block.var[2][2] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	block.var[3][0] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	block.var[3][1] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	block.var[3][2] = u16vec4(uvec4(1u, 8u, 4u, 7u));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat2(block.var[0][0], mat2(3.0, 2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(2.0, 1.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(2.0, 4.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(8.0, -1.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(8.0, 1.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(2.0, -8.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(-3.0, 4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(8.0, 7.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(5.0, 2.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(-1.0, -6.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(9.0, -7.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(1.0, 5.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var[0][0][0] = (vec2(-4.0, 5.0));
	block.var[0][0][1] = (vec2(1.0, -8.0));
	block.var[0][1][0] = (vec2(-1.0, 9.0));
	block.var[0][1][1] = (vec2(-8.0, 5.0));
	block.var[0][2][0] = (vec2(-4.0, 5.0));
	block.var[0][2][1] = (vec2(-2.0, 9.0));
	block.var[1][0][0] = (vec2(-9.0, -1.0));
	block.var[1][0][1] = (vec2(6.0, -4.0));
	block.var[1][1][0] = (vec2(7.0, -8.0));
	block.var[1][1][1] = (vec2(1.0, 4.0));
	block.var[1][2][0] = (vec2(-4.0, 6.0));
	block.var[1][2][1] = (vec2(-5.0, 4.0));
	block.var[2][0][0] = (vec2(-3.0, 6.0));
	block.var[2][0][1] = (vec2(7.0, -7.0));
	block.var[2][1][0] = (vec2(-9.0, 5.0));
	block.var[2][1][1] = (vec2(0.0, 9.0));
	block.var[2][2][0] = (vec2(2.0, 1.0));
	block.var[2][2][1] = (vec2(-6.0, 8.0));
	block.var[3][0][0] = (vec2(-8.0, 5.0));
	block.var[3][0][1] = (vec2(-5.0, -5.0));
	block.var[3][1][0] = (vec2(4.0, 5.0));
	block.var[3][1][1] = (vec2(0.0, 6.0));
	block.var[3][2][0] = (vec2(9.0, 5.0));
	block.var[3][2][1] = (vec2(-8.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_mat3(block.var[0][0], mat3(2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(-8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(-2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(-7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(-4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(-5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0][0][0] = (vec3(1.0, 4.0, 6.0));
	block.var[0][0][1] = (vec3(-5.0, -5.0, 9.0));
	block.var[0][0][2] = (vec3(-6.0, 5.0, 7.0));
	block.var[0][1][0] = (vec3(7.0, -2.0, -4.0));
	block.var[0][1][1] = (vec3(1.0, -5.0, 8.0));
	block.var[0][1][2] = (vec3(-1.0, -8.0, -6.0));
	block.var[0][2][0] = (vec3(-4.0, 5.0, 3.0));
	block.var[0][2][1] = (vec3(9.0, -8.0, -4.0));
	block.var[0][2][2] = (vec3(8.0, 0.0, 5.0));
	block.var[1][0][0] = (vec3(-1.0, 2.0, 3.0));
	block.var[1][0][1] = (vec3(0.0, 8.0, -8.0));
	block.var[1][0][2] = (vec3(-9.0, -1.0, -9.0));
	block.var[1][1][0] = (vec3(4.0, -9.0, 7.0));
	block.var[1][1][1] = (vec3(3.0, 7.0, 5.0));
	block.var[1][1][2] = (vec3(-4.0, 3.0, -9.0));
	block.var[1][2][0] = (vec3(9.0, 4.0, 7.0));
	block.var[1][2][1] = (vec3(-1.0, 2.0, -5.0));
	block.var[1][2][2] = (vec3(2.0, -9.0, 9.0));
	block.var[2][0][0] = (vec3(-7.0, -5.0, -4.0));
	block.var[2][0][1] = (vec3(-8.0, -6.0, -9.0));
	block.var[2][0][2] = (vec3(-6.0, -5.0, 7.0));
	block.var[2][1][0] = (vec3(-5.0, 1.0, -7.0));
	block.var[2][1][1] = (vec3(6.0, -4.0, -3.0));
	block.var[2][1][2] = (vec3(-4.0, -2.0, -4.0));
	block.var[2][2][0] = (vec3(-4.0, 3.0, -9.0));
	block.var[2][2][1] = (vec3(-7.0, 0.0, 3.0));
	block.var[2][2][2] = (vec3(0.0, -1.0, -5.0));
	block.var[3][0][0] = (vec3(-6.0, 8.0, 3.0));
	block.var[3][0][1] = (vec3(3.0, -1.0, -7.0));
	block.var[3][0][2] = (vec3(5.0, 7.0, 7.0));
	block.var[3][1][0] = (vec3(4.0, -7.0, 7.0));
	block.var[3][1][1] = (vec3(7.0, -4.0, -5.0));
	block.var[3][1][2] = (vec3(9.0, -8.0, -6.0));
	block.var[3][2][0] = (vec3(-7.0, -1.0, 8.0));
	block.var[3][2][1] = (vec3(9.0, 3.0, 0.0));
	block.var[3][2][2] = (vec3(-5.0, -7.0, 4.0));
}
#version 450
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
	i8vec2 var[4][3];
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
	allOk = compare_i8vec2(ivec2(block.var[0][0]), ivec2(4294967293, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][1]), ivec2(9, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][2]), ivec2(1, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][0]), ivec2(4294967293, 4294967290)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][1]), ivec2(4294967287, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][2]), ivec2(2, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][0]), ivec2(7, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][1]), ivec2(0, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][2]), ivec2(7, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][0]), ivec2(4294967293, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][1]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][2]), ivec2(1, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int8_t(0);
	block.var[0][0] = i8vec2(ivec2(8, 4294967292));
	block.var[0][1] = i8vec2(ivec2(9, 4294967294));
	block.var[0][2] = i8vec2(ivec2(4294967295, 8));
	block.var[1][0] = i8vec2(ivec2(4294967290, 8));
	block.var[1][1] = i8vec2(ivec2(4294967289, 7));
	block.var[1][2] = i8vec2(ivec2(4294967294, 4294967293));
	block.var[2][0] = i8vec2(ivec2(4294967293, 4294967290));
	block.var[2][1] = i8vec2(ivec2(3, 4294967295));
	block.var[2][2] = i8vec2(ivec2(8, 5));
	block.var[3][0] = i8vec2(ivec2(8, 4294967293));
	block.var[3][1] = i8vec2(ivec2(4294967292, 4294967287));
	block.var[3][2] = i8vec2(ivec2(6, 4294967293));
}
#version 450
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
	f16vec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.padding), 4.0) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][0]), vec3(1.0, 9.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][1]), vec3(7.0, -5.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][2]), vec3(2.0, -4.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][0]), vec3(4.0, 5.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][1]), vec3(1.0, 1.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][2]), vec3(2.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][0]), vec3(-2.0, -4.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][1]), vec3(-7.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][2]), vec3(-2.0, -2.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][0]), vec3(6.0, -1.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][1]), vec3(-4.0, 6.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][2]), vec3(6.0, 4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = float16_t(3.0);
	block.var[0][0] = f16vec3(vec3(3.0, 7.0, -3.0));
	block.var[0][1] = f16vec3(vec3(-5.0, -9.0, -1.0));
	block.var[0][2] = f16vec3(vec3(0.0, 6.0, 5.0));
	block.var[1][0] = f16vec3(vec3(-7.0, 2.0, 9.0));
	block.var[1][1] = f16vec3(vec3(1.0, -5.0, -5.0));
	block.var[1][2] = f16vec3(vec3(5.0, 2.0, -5.0));
	block.var[2][0] = f16vec3(vec3(-4.0, 6.0, -3.0));
	block.var[2][1] = f16vec3(vec3(-7.0, -4.0, -4.0));
	block.var[2][2] = f16vec3(vec3(5.0, 0.0, -6.0));
	block.var[3][0] = f16vec3(vec3(4.0, -1.0, -2.0));
	block.var[3][1] = f16vec3(vec3(3.0, -8.0, -4.0));
	block.var[3][2] = f16vec3(vec3(-2.0, 4.0, 6.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(-1.0, 5.0, -1.0, 7.0, -2.0, -7.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-3.0, -8.0, 0.0, -2.0, 6.0, -7.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(1.0, 7.0, 9.0, -8.0, 7.0, -3.0, -9.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-4.0, -2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-2.0, 1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(3.0, 0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-9.0, 2.0, -9.0, 9.0, 5.0, 3.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(2.0, -4.0, -3.0, 6.0, -4.0, -3.0, -8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(-1.0, 5.0, -7.0, -9.0, 2.0, 9.0, -3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(0.0, 1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-5.0, -7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(4.0, -4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(0.0, 0.0, 9.0, -5.0, 2.0, 9.0, -4.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(4.0, -6.0, 6.0, -1.0, 7.0, 1.0, -1.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(5.0, -1.0, -5.0, -9.0, -2.0, -5.0, 0.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(0.0, -5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(-1.0, 3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(-4.0, 7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(-8.0, 4.0, 0.0, 6.0, -4.0, -5.0, 8.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(-2.0, -3.0, -8.0, 5.0, 6.0, 7.0, -3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(7.0, -5.0, -7.0, -8.0, 4.0, 4.0, 0.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(-1.0, 1.0, 4.0));
	block.var[0][0][0][1] = (vec3(6.0, -5.0, -5.0));
	block.var[0][0][0][2] = (vec3(9.0, -6.0, 5.0));
	block.var[0][0][1][0] = (vec3(7.0, 7.0, -2.0));
	block.var[0][0][1][1] = (vec3(-4.0, 1.0, -5.0));
	block.var[0][0][1][2] = (vec3(8.0, -1.0, -8.0));
	block.var[0][0][2][0] = (vec3(-6.0, -4.0, 5.0));
	block.var[0][0][2][1] = (vec3(3.0, 9.0, -8.0));
	block.var[0][0][2][2] = (vec3(-4.0, 8.0, 0.0));
	block.var[0][1][0][0] = (vec3(4.0, 2.0, 9.0));
	block.var[0][1][0][1] = (vec3(-7.0, 2.0, 0.0));
	block.var[0][1][0][2] = (vec3(0.0, -4.0, 3.0));
	block.var[0][1][1][0] = (vec3(-7.0, -7.0, 1.0));
	block.var[0][1][1][1] = (vec3(1.0, -5.0, 0.0));
	block.var[0][1][1][2] = (vec3(5.0, -6.0, 7.0));
	block.var[0][1][2][0] = (vec3(-2.0, 8.0, -5.0));
	block.var[0][1][2][1] = (vec3(4.0, -8.0, 2.0));
	block.var[0][1][2][2] = (vec3(4.0, 2.0, -7.0));
	block.var[1][0][0][0] = (vec3(5.0, -1.0, 2.0));
	block.var[1][0][0][1] = (vec3(3.0, 0.0, 8.0));
	block.var[1][0][0][2] = (vec3(-8.0, -9.0, -1.0));
	block.var[1][0][1][0] = (vec3(-9.0, 4.0, -9.0));
	block.var[1][0][1][1] = (vec3(7.0, 3.0, 7.0));
	block.var[1][0][1][2] = (vec3(5.0, -4.0, 3.0));
	block.var[1][0][2][0] = (vec3(-9.0, 9.0, 4.0));
	block.var[1][0][2][1] = (vec3(7.0, -1.0, 2.0));
	block.var[1][0][2][2] = (vec3(-5.0, 2.0, -9.0));
	block.var[1][1][0][0] = (vec3(-5.0, 2.0, -4.0));
	block.var[1][1][0][1] = (vec3(0.0, 5.0, -5.0));
	block.var[1][1][0][2] = (vec3(3.0, 3.0, -8.0));
	block.var[1][1][1][0] = (vec3(0.0, -7.0, -2.0));
	block.var[1][1][1][1] = (vec3(-8.0, 3.0, -2.0));
	block.var[1][1][1][2] = (vec3(9.0, -7.0, -7.0));
	block.var[1][1][2][0] = (vec3(4.0, -6.0, -3.0));
	block.var[1][1][2][1] = (vec3(-9.0, -3.0, 8.0));
	block.var[1][1][2][2] = (vec3(-8.0, -1.0, -6.0));
	block.var[2][0][0][0] = (vec3(9.0, -7.0, -5.0));
	block.var[2][0][0][1] = (vec3(-4.0, -8.0, -6.0));
	block.var[2][0][0][2] = (vec3(-9.0, -6.0, -5.0));
	block.var[2][0][1][0] = (vec3(7.0, -5.0, 1.0));
	block.var[2][0][1][1] = (vec3(-7.0, 6.0, -4.0));
	block.var[2][0][1][2] = (vec3(-3.0, -4.0, -2.0));
	block.var[2][0][2][0] = (vec3(-4.0, -4.0, 3.0));
	block.var[2][0][2][1] = (vec3(-9.0, -7.0, 0.0));
	block.var[2][0][2][2] = (vec3(3.0, 0.0, -1.0));
	block.var[2][1][0][0] = (vec3(0.0, 5.0, 9.0));
	block.var[2][1][0][1] = (vec3(-2.0, -2.0, 3.0));
	block.var[2][1][0][2] = (vec3(-5.0, 3.0, -7.0));
	block.var[2][1][1][0] = (vec3(-2.0, -3.0, 0.0));
	block.var[2][1][1][1] = (vec3(-8.0, -8.0, 6.0));
	block.var[2][1][1][2] = (vec3(2.0, -2.0, -4.0));
	block.var[2][1][2][0] = (vec3(7.0, 1.0, 7.0));
	block.var[2][1][2][1] = (vec3(-6.0, 7.0, -3.0));
	block.var[2][1][2][2] = (vec3(4.0, -6.0, -5.0));
	block.var[3][0][0][0] = (vec3(-5.0, -6.0, 8.0));
	block.var[3][0][0][1] = (vec3(3.0, 3.0, -1.0));
	block.var[3][0][0][2] = (vec3(-7.0, 5.0, 7.0));
	block.var[3][0][1][0] = (vec3(7.0, 4.0, -7.0));
	block.var[3][0][1][1] = (vec3(7.0, 7.0, -4.0));
	block.var[3][0][1][2] = (vec3(-5.0, 9.0, -8.0));
	block.var[3][0][2][0] = (vec3(-6.0, -7.0, -1.0));
	block.var[3][0][2][1] = (vec3(8.0, 9.0, 3.0));
	block.var[3][0][2][2] = (vec3(0.0, -5.0, -7.0));
	block.var[3][1][0][0] = (vec3(-6.0, -9.0, -9.0));
	block.var[3][1][0][1] = (vec3(-3.0, 9.0, -8.0));
	block.var[3][1][0][2] = (vec3(7.0, 7.0, -2.0));
	block.var[3][1][1][0] = (vec3(-3.0, 4.0, 1.0));
	block.var[3][1][1][1] = (vec3(-6.0, 4.0, 7.0));
	block.var[3][1][1][2] = (vec3(-2.0, -4.0, -3.0));
	block.var[3][1][2][0] = (vec3(-3.0, -5.0, 1.0));
	block.var[3][1][2][1] = (vec3(4.0, 9.0, -7.0));
	block.var[3][1][2][2] = (vec3(-1.0, -7.0, -9.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(6.0, 0.0, 6.0, 8.0, -9.0, 4.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-9.0, -1.0, 7.0, 9.0, 0.0, -2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-8.0, 4.0, 8.0, 3.0, -3.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(9.0, -9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(6.0, -4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(0.0, -5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-9.0, 6.0, -4.0, -8.0, -5.0, -4.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-8.0, 0.0, 4.0, -6.0, 5.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-1.0, -2.0, 0.0, -7.0, 8.0, -2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-9.0, -1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(1.0, 2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(-8.0, 1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(9.0, -3.0, -7.0, 2.0, -4.0, -3.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(1.0, -8.0, -2.0, 6.0, 8.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(-7.0, 3.0, 5.0, -3.0, -6.0, 8.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(-7.0, -6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(-5.0, -2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(2.0, -3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(-6.0, -9.0, 7.0, 2.0, -1.0, 5.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(4.0, 2.0, 9.0, -9.0, -1.0, 9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(7.0, 8.0, 4.0, -3.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	block.var[0][0][1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	block.var[0][0][2] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
	block.var[0][1][0] = (mat2x4(8.0, 3.0, 0.0, -3.0, 5.0, -4.0, 8.0, -3.0));
	block.var[0][1][1] = (mat2x4(7.0, -1.0, 5.0, 0.0, -5.0, 2.0, -3.0, -8.0));
	block.var[0][1][2] = (mat2x4(-9.0, 5.0, -6.0, -2.0, 0.0, 0.0, -2.0, -9.0));
	block.var[1][0][0] = (mat2x4(-8.0, -9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0));
	block.var[1][0][1] = (mat2x4(-5.0, 8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0));
	block.var[1][0][2] = (mat2x4(-6.0, -7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0));
	block.var[1][1][0] = (mat2x4(3.0, -5.0, -5.0, -6.0, 3.0, 0.0, -2.0, 5.0));
	block.var[1][1][1] = (mat2x4(-9.0, -9.0, 4.0, -7.0, -9.0, -2.0, 5.0, 9.0));
	block.var[1][1][2] = (mat2x4(0.0, 6.0, -3.0, -4.0, 0.0, -2.0, 8.0, 1.0));
	block.var[2][0][0] = (mat2x4(0.0, -6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0));
	block.var[2][0][1] = (mat2x4(-5.0, 4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0));
	block.var[2][0][2] = (mat2x4(-4.0, -7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0));
	block.var[2][1][0] = (mat2x4(-3.0, -9.0, -7.0, -5.0, -2.0, 8.0, -8.0, -8.0));
	block.var[2][1][1] = (mat2x4(-5.0, 1.0, -1.0, 8.0, 3.0, 3.0, -4.0, 8.0));
	block.var[2][1][2] = (mat2x4(2.0, 5.0, -9.0, 0.0, -3.0, 2.0, -2.0, 9.0));
	block.var[3][0][0] = (mat2x4(-1.0, 7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0));
	block.var[3][0][1] = (mat2x4(-5.0, 3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0));
	block.var[3][0][2] = (mat2x4(5.0, 7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0));
	block.var[3][1][0] = (mat2x4(-7.0, -3.0, 5.0, -4.0, -2.0, 0.0, 2.0, -6.0));
	block.var[3][1][1] = (mat2x4(2.0, 3.0, 1.0, 6.0, -7.0, -8.0, -7.0, 9.0));
	block.var[3][1][2] = (mat2x4(-6.0, -2.0, -6.0, -8.0, -5.0, 7.0, 9.0, -5.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(8.0, 3.0, -4.0, -1.0, -1.0, 6.0, 4.0, -5.0, 5.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-2.0, -4.0, 7.0, -7.0, -5.0, 7.0, 0.0, 0.0, -1.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(8.0, 9.0, 4.0, 2.0, 6.0, 1.0, -3.0, 0.0, 1.0, -6.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(1.0, 7.0, -4.0, 6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(5.0, 4.0, 8.0, -8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(6.0, 3.0, 0.0, -3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(0.0, 9.0, 4.0, -6.0, 8.0, 9.0, 3.0, -5.0, -8.0, 4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(7.0, -4.0, -1.0, -2.0, 6.0, 7.0, 5.0, -4.0, 3.0, 1.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(4.0, -5.0, 9.0, 5.0, 6.0, 2.0, 5.0, 5.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(5.0, -7.0, -7.0, -6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(2.0, 5.0, 2.0, 0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(-9.0, -1.0, -2.0, -2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-4.0, -2.0, -6.0, -6.0, -1.0, -4.0, 1.0, 5.0, -2.0, 2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-7.0, 4.0, -9.0, 9.0, -7.0, -9.0, -7.0, -1.0, 9.0, -4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(4.0, -3.0, 2.0, 1.0, -6.0, 3.0, 7.0, -1.0, 0.0, 8.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(-5.0, -8.0, 7.0, 3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(5.0, 2.0, 7.0, 6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(-7.0, 4.0, 6.0, 2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(-9.0, -9.0, -9.0, 3.0, 7.0, 2.0, 9.0, 2.0, 9.0, 2.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(1.0, 3.0, -2.0, 4.0, 1.0, 2.0, 5.0, -9.0, -7.0, 3.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(-5.0, 3.0, 3.0, 2.0, -4.0, 4.0, -8.0, -3.0, 4.0, 4.0, 0.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(1.0, 3.0, -7.0));
	block.var[0][0][0][1] = (vec3(-7.0, 2.0, 3.0));
	block.var[0][0][0][2] = (vec3(1.0, -2.0, -1.0));
	block.var[0][0][0][3] = (vec3(-5.0, -1.0, 9.0));
	block.var[0][0][1][0] = (vec3(8.0, -4.0, 3.0));
	block.var[0][0][1][1] = (vec3(4.0, 9.0, -6.0));
	block.var[0][0][1][2] = (vec3(7.0, 6.0, -5.0));
	block.var[0][0][1][3] = (vec3(2.0, 6.0, 3.0));
	block.var[0][0][2][0] = (vec3(2.0, 7.0, -1.0));
	block.var[0][0][2][1] = (vec3(-3.0, -3.0, -7.0));
	block.var[0][0][2][2] = (vec3(-5.0, 3.0, 4.0));
	block.var[0][0][2][3] = (vec3(-4.0, -2.0, 8.0));
	block.var[0][1][0][0] = (vec3(-5.0, 5.0, -2.0));
	block.var[0][1][0][1] = (vec3(1.0, -7.0, -9.0));
	block.var[0][1][0][2] = (vec3(4.0, -9.0, 8.0));
	block.var[0][1][0][3] = (vec3(2.0, 5.0, -4.0));
	block.var[0][1][1][0] = (vec3(-9.0, -9.0, 5.0));
	block.var[0][1][1][1] = (vec3(-3.0, 6.0, -3.0));
	block.var[0][1][1][2] = (vec3(7.0, -9.0, -4.0));
	block.var[0][1][1][3] = (vec3(9.0, 6.0, 2.0));
	block.var[0][1][2][0] = (vec3(-3.0, -5.0, 2.0));
	block.var[0][1][2][1] = (vec3(-9.0, 5.0, -6.0));
	block.var[0][1][2][2] = (vec3(5.0, -7.0, -9.0));
	block.var[0][1][2][3] = (vec3(0.0, 9.0, 9.0));
	block.var[1][0][0][0] = (vec3(-1.0, -8.0, 8.0));
	block.var[1][0][0][1] = (vec3(-4.0, -7.0, -7.0));
	block.var[1][0][0][2] = (vec3(8.0, 4.0, -6.0));
	block.var[1][0][0][3] = (vec3(6.0, 0.0, 1.0));
	block.var[1][0][1][0] = (vec3(7.0, -1.0, -8.0));
	block.var[1][0][1][1] = (vec3(9.0, 9.0, -6.0));
	block.var[1][0][1][2] = (vec3(0.0, 1.0, 1.0));
	block.var[1][0][1][3] = (vec3(2.0, 7.0, 2.0));
	block.var[1][0][2][0] = (vec3(-3.0, -6.0, 5.0));
	block.var[1][0][2][1] = (vec3(3.0, -1.0, -1.0));
	block.var[1][0][2][2] = (vec3(-2.0, 9.0, -5.0));
	block.var[1][0][2][3] = (vec3(8.0, -6.0, -5.0));
	block.var[1][1][0][0] = (vec3(-9.0, 5.0, 5.0));
	block.var[1][1][0][1] = (vec3(-2.0, 7.0, 7.0));
	block.var[1][1][0][2] = (vec3(-2.0, 7.0, -9.0));
	block.var[1][1][0][3] = (vec3(5.0, 5.0, -4.0));
	block.var[1][1][1][0] = (vec3(6.0, -3.0, 7.0));
	block.var[1][1][1][1] = (vec3(-3.0, 1.0, -7.0));
	block.var[1][1][1][2] = (vec3(-1.0, 0.0, -9.0));
	block.var[1][1][1][3] = (vec3(0.0, -4.0, 9.0));
	block.var[1][1][2][0] = (vec3(-6.0, -5.0, 7.0));
	block.var[1][1][2][1] = (vec3(6.0, 1.0, -2.0));
	block.var[1][1][2][2] = (vec3(2.0, 8.0, 9.0));
	block.var[1][1][2][3] = (vec3(2.0, -8.0, -9.0));
	block.var[2][0][0][0] = (vec3(-9.0, 3.0, -2.0));
	block.var[2][0][0][1] = (vec3(5.0, 6.0, -7.0));
	block.var[2][0][0][2] = (vec3(-8.0, 1.0, 8.0));
	block.var[2][0][0][3] = (vec3(1.0, 6.0, -1.0));
	block.var[2][0][1][0] = (vec3(-5.0, 0.0, -6.0));
	block.var[2][0][1][1] = (vec3(5.0, -3.0, 2.0));
	block.var[2][0][1][2] = (vec3(-5.0, 2.0, -2.0));
	block.var[2][0][1][3] = (vec3(-7.0, -9.0, -1.0));
	block.var[2][0][2][0] = (vec3(-2.0, -3.0, -7.0));
	block.var[2][0][2][1] = (vec3(-9.0, -4.0, 9.0));
	block.var[2][0][2][2] = (vec3(4.0, -4.0, 5.0));
	block.var[2][0][2][3] = (vec3(7.0, 1.0, 7.0));
	block.var[2][1][0][0] = (vec3(-1.0, -5.0, 2.0));
	block.var[2][1][0][1] = (vec3(4.0, 7.0, -4.0));
	block.var[2][1][0][2] = (vec3(6.0, 2.0, -4.0));
	block.var[2][1][0][3] = (vec3(8.0, -8.0, -1.0));
	block.var[2][1][1][0] = (vec3(-8.0, -9.0, 2.0));
	block.var[2][1][1][1] = (vec3(-8.0, -2.0, -1.0));
	block.var[2][1][1][2] = (vec3(-4.0, 5.0, 4.0));
	block.var[2][1][1][3] = (vec3(-6.0, -1.0, 7.0));
	block.var[2][1][2][0] = (vec3(1.0, -1.0, 9.0));
	block.var[2][1][2][1] = (vec3(-9.0, 4.0, 7.0));
	block.var[2][1][2][2] = (vec3(-5.0, -9.0, 1.0));
	block.var[2][1][2][3] = (vec3(-1.0, 2.0, -5.0));
	block.var[3][0][0][0] = (vec3(-9.0, 5.0, 4.0));
	block.var[3][0][0][1] = (vec3(4.0, 0.0, 0.0));
	block.var[3][0][0][2] = (vec3(0.0, -3.0, 3.0));
	block.var[3][0][0][3] = (vec3(1.0, 8.0, 0.0));
	block.var[3][0][1][0] = (vec3(-2.0, 9.0, -8.0));
	block.var[3][0][1][1] = (vec3(-8.0, 7.0, -9.0));
	block.var[3][0][1][2] = (vec3(3.0, -2.0, -3.0));
	block.var[3][0][1][3] = (vec3(-5.0, 1.0, -4.0));
	block.var[3][0][2][0] = (vec3(5.0, 5.0, 8.0));
	block.var[3][0][2][1] = (vec3(3.0, 7.0, -3.0));
	block.var[3][0][2][2] = (vec3(-2.0, 2.0, -9.0));
	block.var[3][0][2][3] = (vec3(0.0, 9.0, 5.0));
	block.var[3][1][0][0] = (vec3(3.0, 6.0, 7.0));
	block.var[3][1][0][1] = (vec3(4.0, -5.0, 8.0));
	block.var[3][1][0][2] = (vec3(4.0, 6.0, 1.0));
	block.var[3][1][0][3] = (vec3(-4.0, 5.0, -7.0));
	block.var[3][1][1][0] = (vec3(-2.0, -3.0, -9.0));
	block.var[3][1][1][1] = (vec3(5.0, -8.0, -5.0));
	block.var[3][1][1][2] = (vec3(-7.0, -4.0, -3.0));
	block.var[3][1][1][3] = (vec3(-1.0, 8.0, -8.0));
	block.var[3][1][2][0] = (vec3(-2.0, -6.0, 6.0));
	block.var[3][1][2][1] = (vec3(-3.0, -2.0, -8.0));
	block.var[3][1][2][2] = (vec3(-3.0, -2.0, -2.0));
	block.var[3][1][2][3] = (vec3(-9.0, 4.0, 7.0));
}
#version 450
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
	int16_t var[4][2][3];
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
	allOk = compare_int16_t(int(block.var[0][0][2]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[0][1][0]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[0][1][1]), 5) && allOk;
	allOk = compare_int16_t(int(block.var[0][1][2]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[1][0][0]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[1][0][1]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[1][0][2]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[1][1][0]), -3) && allOk;
	allOk = compare_int16_t(int(block.var[1][1][1]), -1) && allOk;
	allOk = compare_int16_t(int(block.var[1][1][2]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[2][0][0]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[2][0][1]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[2][0][2]), 3) && allOk;
	allOk = compare_int16_t(int(block.var[2][1][0]), 1) && allOk;
	allOk = compare_int16_t(int(block.var[2][1][1]), -9) && allOk;
	allOk = compare_int16_t(int(block.var[2][1][2]), -7) && allOk;
	allOk = compare_int16_t(int(block.var[3][0][0]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[3][0][1]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[3][0][2]), -7) && allOk;
	allOk = compare_int16_t(int(block.var[3][1][0]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[3][1][1]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[3][1][2]), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = int16_t(6);
	block.var[0][0][1] = int16_t(8);
	block.var[0][0][2] = int16_t(-2);
	block.var[0][1][0] = int16_t(3);
	block.var[0][1][1] = int16_t(9);
	block.var[0][1][2] = int16_t(6);
	block.var[1][0][0] = int16_t(-4);
	block.var[1][0][1] = int16_t(-3);
	block.var[1][0][2] = int16_t(9);
	block.var[1][1][0] = int16_t(2);
	block.var[1][1][1] = int16_t(3);
	block.var[1][1][2] = int16_t(7);
	block.var[2][0][0] = int16_t(-5);
	block.var[2][0][1] = int16_t(-8);
	block.var[2][0][2] = int16_t(-3);
	block.var[2][1][0] = int16_t(7);
	block.var[2][1][1] = int16_t(7);
	block.var[2][1][2] = int16_t(1);
	block.var[3][0][0] = int16_t(2);
	block.var[3][0][1] = int16_t(-1);
	block.var[3][0][2] = int16_t(4);
	block.var[3][1][0] = int16_t(-9);
	block.var[3][1][1] = int16_t(-3);
	block.var[3][1][2] = int16_t(0);
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	i16vec4 var[4][2][3];
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
	allOk = compare_i16vec4(ivec4(block.var[0][0][2]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][1][0]), ivec4(3, -5, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][1][1]), ivec4(6, 3, 6, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][1][2]), ivec4(9, -8, -9, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0][0]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0][1]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0][2]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1][0]), ivec4(-9, -3, -3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1][1]), ivec4(-7, -4, 3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1][2]), ivec4(-4, 5, -2, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0][0]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0][1]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0][2]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1][0]), ivec4(4, -6, 5, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1][1]), ivec4(5, -2, 3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1][2]), ivec4(0, 5, -8, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][0][0]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][0][1]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][0][2]), ivec4(4, 8, -6, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][1][0]), ivec4(-6, 7, 7, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][1][1]), ivec4(-5, 7, 3, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][1][2]), ivec4(-4, 7, 8, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i16vec4(ivec4(-4, -8, -4, 9));
	block.var[0][0][1] = i16vec4(ivec4(2, 7, -4, 4));
	block.var[0][0][2] = i16vec4(ivec4(8, 9, 5, 1));
	block.var[0][1][0] = i16vec4(ivec4(7, -1, 8, -5));
	block.var[0][1][1] = i16vec4(ivec4(-9, -6, -2, -2));
	block.var[0][1][2] = i16vec4(ivec4(-3, 8, 7, -4));
	block.var[1][0][0] = i16vec4(ivec4(-3, 3, 8, 7));
	block.var[1][0][1] = i16vec4(ivec4(2, 6, -9, 9));
	block.var[1][0][2] = i16vec4(ivec4(-2, 4, -8, -7));
	block.var[1][1][0] = i16vec4(ivec4(-2, 0, 6, -2));
	block.var[1][1][1] = i16vec4(ivec4(6, -5, -6, -3));
	block.var[1][1][2] = i16vec4(ivec4(4, -4, -4, 9));
	block.var[2][0][0] = i16vec4(ivec4(-9, -1, -8, -1));
	block.var[2][0][1] = i16vec4(ivec4(-1, -6, 5, 2));
	block.var[2][0][2] = i16vec4(ivec4(-3, 8, -7, -2));
	block.var[2][1][0] = i16vec4(ivec4(7, 6, 4, -1));
	block.var[2][1][1] = i16vec4(ivec4(8, 3, 4, 5));
	block.var[2][1][2] = i16vec4(ivec4(-3, 5, -8, -5));
	block.var[3][0][0] = i16vec4(ivec4(9, 7, 6, -9));
	block.var[3][0][1] = i16vec4(ivec4(5, -3, 8, 5));
	block.var[3][0][2] = i16vec4(ivec4(-6, -9, -6, 2));
	block.var[3][1][0] = i16vec4(ivec4(9, 3, -3, 9));
	block.var[3][1][1] = i16vec4(ivec4(1, -5, 8, -2));
	block.var[3][1][2] = i16vec4(ivec4(7, -6, -6, 0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(1.0, -6.0, -4.0, 8.0, -1.0, -9.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(3.0, 8.0, -3.0, -7.0, 6.0, -6.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(6.0, 7.0, -1.0, 8.0, 1.0, 1.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(-5.0, -4.0, -5.0, -1.0, 5.0, 1.0, 5.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(8.0, 2.0, -2.0, -2.0, 0.0, 9.0, 3.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(-7.0, -4.0, -3.0, 2.0, -3.0, 1.0, 2.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(3.0, -6.0, -6.0, 5.0, 5.0, -8.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-9.0, -1.0, -4.0, -4.0, -4.0, 9.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(4.0, -5.0, 6.0, 7.0, -8.0, 2.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(4.0, -8.0, -9.0, 5.0, 9.0, 1.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(7.0, 6.0, -5.0, -8.0, -5.0, 4.0, -8.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(0.0, 0.0, 7.0, -4.0, -1.0, -9.0, -6.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(1.0, 7.0, -3.0, 4.0, 3.0, 4.0, -1.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-6.0, 3.0, -5.0, 0.0, 5.0, 8.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-1.0, 4.0, -4.0, 9.0, 2.0, 5.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(9.0, 7.0, 4.0, 2.0, 8.0, 1.0, -9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(0.0, -6.0, 9.0, 7.0, 3.0, 2.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(0.0, -8.0, 3.0, -4.0, -5.0, 7.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(5.0, -3.0, 3.0, 7.0, 2.0, 8.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(5.0, 3.0, -7.0, -1.0, 5.0, -5.0, 9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(-4.0, 8.0, -8.0, -3.0, -9.0, 2.0, 5.0, 0.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	block.var[0][0][1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	block.var[0][1][0] = (mat3(8.0, 7.0, -7.0, -4.0, 7.0, -5.0, 8.0, 3.0, -4.0));
	block.var[0][1][1] = (mat3(-5.0, 6.0, -1.0, 6.0, -8.0, 1.0, 7.0, 5.0, 7.0));
	block.var[0][2][0] = (mat3(8.0, 0.0, -7.0, 0.0, -7.0, 5.0, -5.0, -2.0, -9.0));
	block.var[0][2][1] = (mat3(6.0, 5.0, 8.0, 2.0, 5.0, -8.0, 2.0, -9.0, -7.0));
	block.var[0][3][0] = (mat3(-1.0, 1.0, 8.0, 9.0, 5.0, -2.0, -6.0, -8.0, -3.0));
	block.var[0][3][1] = (mat3(-7.0, 4.0, 8.0, -8.0, -8.0, -9.0, -8.0, -9.0, 0.0));
	block.var[1][0][0] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
	block.var[1][0][1] = (mat3(-4.0, 3.0, -8.0, -9.0, 9.0, -7.0, -1.0, -9.0, -9.0));
	block.var[1][1][0] = (mat3(1.0, 7.0, -1.0, -8.0, 9.0, -2.0, 7.0, 9.0, -5.0));
	block.var[1][1][1] = (mat3(8.0, 7.0, 6.0, -6.0, -1.0, -2.0, 9.0, 6.0, 0.0));
	block.var[1][2][0] = (mat3(-8.0, 3.0, -4.0, 9.0, 2.0, 0.0, -3.0, -6.0, 4.0));
	block.var[1][2][1] = (mat3(6.0, -6.0, 5.0, -5.0, -5.0, -9.0, -4.0, -5.0, 7.0));
	block.var[1][3][0] = (mat3(5.0, 9.0, 0.0, -1.0, 0.0, -6.0, -7.0, -9.0, -2.0));
	block.var[1][3][1] = (mat3(7.0, 9.0, -3.0, 3.0, -7.0, 4.0, 9.0, 3.0, -8.0));
	block.var[2][0][0] = (mat3(-2.0, 7.0, -3.0, 2.0, -6.0, -7.0, 4.0, 8.0, -8.0));
	block.var[2][0][1] = (mat3(6.0, 1.0, 9.0, 7.0, -9.0, 5.0, -9.0, 9.0, 1.0));
	block.var[2][1][0] = (mat3(-4.0, -3.0, -6.0, -5.0, -8.0, -6.0, 5.0, -5.0, 2.0));
	block.var[2][1][1] = (mat3(7.0, 5.0, -4.0, 7.0, 9.0, -8.0, -9.0, 8.0, -9.0));
	block.var[2][2][0] = (mat3(-7.0, 5.0, 9.0, 0.0, -7.0, 7.0, 9.0, 9.0, 9.0));
	block.var[2][2][1] = (mat3(7.0, -1.0, 7.0, -4.0, 1.0, -3.0, 8.0, 0.0, 4.0));
	block.var[2][3][0] = (mat3(-1.0, 2.0, 8.0, 0.0, -8.0, -5.0, 6.0, 2.0, 6.0));
	block.var[2][3][1] = (mat3(-5.0, 0.0, 1.0, 8.0, 9.0, -2.0, 3.0, 4.0, 1.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(1.0, 8.0, 9.0, 7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(-9.0, -9.0, -7.0, -5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(-2.0, 8.0, 2.0, 7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(0.0, 8.0, 9.0, -9.0, -9.0, 4.0, 1.0, -1.0, 9.0, 0.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(-8.0, -7.0, 9.0, 6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(-5.0, -8.0, -6.0, 4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(-2.0, -8.0, 7.0, 1.0, 5.0, 7.0, 8.0, -2.0, 4.0, -4.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(6.0, 3.0, 4.0, -2.0, 5.0, 6.0, -9.0, 4.0, 7.0, 7.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(-5.0, -1.0, 5.0, 4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(0.0, -6.0, -8.0, -7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(9.0, 9.0, -6.0, -7.0, -9.0, -9.0, 5.0, 9.0, 5.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(3.0, 6.0, -3.0, -8.0, -1.0, 5.0, -8.0, -5.0, 3.0, -4.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(7.0, 4.0, -4.0));
	block.var[0][0][0][1] = (vec3(-6.0, 3.0, -3.0));
	block.var[0][0][0][2] = (vec3(9.0, -2.0, 3.0));
	block.var[0][0][0][3] = (vec3(9.0, -9.0, 7.0));
	block.var[0][0][1][0] = (vec3(5.0, 1.0, -9.0));
	block.var[0][0][1][1] = (vec3(-1.0, -2.0, 6.0));
	block.var[0][0][1][2] = (vec3(-4.0, 6.0, 4.0));
	block.var[0][0][1][3] = (vec3(-8.0, 7.0, 3.0));
	block.var[0][1][0][0] = (vec3(9.0, 1.0, -1.0));
	block.var[0][1][0][1] = (vec3(-1.0, 2.0, 4.0));
	block.var[0][1][0][2] = (vec3(4.0, 2.0, 0.0));
	block.var[0][1][0][3] = (vec3(5.0, 6.0, -6.0));
	block.var[0][1][1][0] = (vec3(-3.0, 7.0, -6.0));
	block.var[0][1][1][1] = (vec3(7.0, 9.0, 8.0));
	block.var[0][1][1][2] = (vec3(-9.0, -9.0, -9.0));
	block.var[0][1][1][3] = (vec3(6.0, -7.0, -3.0));
	block.var[0][2][0][0] = (vec3(-5.0, 2.0, -4.0));
	block.var[0][2][0][1] = (vec3(-7.0, -3.0, -4.0));
	block.var[0][2][0][2] = (vec3(4.0, -3.0, -8.0));
	block.var[0][2][0][3] = (vec3(-5.0, -1.0, 1.0));
	block.var[0][2][1][0] = (vec3(6.0, -2.0, 8.0));
	block.var[0][2][1][1] = (vec3(-7.0, 1.0, 4.0));
	block.var[0][2][1][2] = (vec3(6.0, 8.0, -5.0));
	block.var[0][2][1][3] = (vec3(1.0, -6.0, 4.0));
	block.var[0][3][0][0] = (vec3(-1.0, 7.0, 7.0));
	block.var[0][3][0][1] = (vec3(3.0, -4.0, -1.0));
	block.var[0][3][0][2] = (vec3(-4.0, 5.0, 7.0));
	block.var[0][3][0][3] = (vec3(-5.0, 7.0, 5.0));
	block.var[0][3][1][0] = (vec3(-1.0, -1.0, 5.0));
	block.var[0][3][1][1] = (vec3(9.0, 7.0, -5.0));
	block.var[0][3][1][2] = (vec3(3.0, -1.0, 3.0));
	block.var[0][3][1][3] = (vec3(8.0, -5.0, 3.0));
	block.var[1][0][0][0] = (vec3(-4.0, -9.0, 8.0));
	block.var[1][0][0][1] = (vec3(9.0, 2.0, 2.0));
	block.var[1][0][0][2] = (vec3(9.0, -7.0, 3.0));
	block.var[1][0][0][3] = (vec3(8.0, 2.0, 4.0));
	block.var[1][0][1][0] = (vec3(2.0, 4.0, -3.0));
	block.var[1][0][1][1] = (vec3(-8.0, 7.0, 3.0));
	block.var[1][0][1][2] = (vec3(0.0, -8.0, 0.0));
	block.var[1][0][1][3] = (vec3(6.0, -9.0, 0.0));
	block.var[1][1][0][0] = (vec3(7.0, -1.0, -4.0));
	block.var[1][1][0][1] = (vec3(-9.0, 0.0, -1.0));
	block.var[1][1][0][2] = (vec3(-7.0, -2.0, -3.0));
	block.var[1][1][0][3] = (vec3(1.0, 4.0, 5.0));
	block.var[1][1][1][0] = (vec3(9.0, 8.0, 7.0));
	block.var[1][1][1][1] = (vec3(5.0, 4.0, 7.0));
	block.var[1][1][1][2] = (vec3(3.0, -3.0, 4.0));
	block.var[1][1][1][3] = (vec3(3.0, -6.0, 5.0));
	block.var[1][2][0][0] = (vec3(-9.0, 3.0, -3.0));
	block.var[1][2][0][1] = (vec3(0.0, -5.0, -3.0));
	block.var[1][2][0][2] = (vec3(-5.0, -8.0, 3.0));
	block.var[1][2][0][3] = (vec3(3.0, -6.0, 8.0));
	block.var[1][2][1][0] = (vec3(-3.0, 5.0, 6.0));
	block.var[1][2][1][1] = (vec3(5.0, -1.0, 6.0));
	block.var[1][2][1][2] = (vec3(8.0, 7.0, 1.0));
	block.var[1][2][1][3] = (vec3(-5.0, 6.0, -6.0));
	block.var[1][3][0][0] = (vec3(-6.0, 1.0, 0.0));
	block.var[1][3][0][1] = (vec3(8.0, -8.0, 5.0));
	block.var[1][3][0][2] = (vec3(-3.0, 5.0, -4.0));
	block.var[1][3][0][3] = (vec3(-3.0, -2.0, 2.0));
	block.var[1][3][1][0] = (vec3(-5.0, 3.0, -6.0));
	block.var[1][3][1][1] = (vec3(-6.0, -4.0, -2.0));
	block.var[1][3][1][2] = (vec3(-5.0, -2.0, -2.0));
	block.var[1][3][1][3] = (vec3(-8.0, 2.0, 4.0));
	block.var[2][0][0][0] = (vec3(-4.0, 5.0, 5.0));
	block.var[2][0][0][1] = (vec3(-7.0, -8.0, -1.0));
	block.var[2][0][0][2] = (vec3(6.0, -3.0, -5.0));
	block.var[2][0][0][3] = (vec3(0.0, 8.0, -8.0));
	block.var[2][0][1][0] = (vec3(-4.0, 4.0, 8.0));
	block.var[2][0][1][1] = (vec3(-4.0, -4.0, -3.0));
	block.var[2][0][1][2] = (vec3(3.0, 3.0, 2.0));
	block.var[2][0][1][3] = (vec3(8.0, -8.0, -6.0));
	block.var[2][1][0][0] = (vec3(-8.0, -4.0, -9.0));
	block.var[2][1][0][1] = (vec3(4.0, 8.0, -3.0));
	block.var[2][1][0][2] = (vec3(-9.0, 7.0, -2.0));
	block.var[2][1][0][3] = (vec3(0.0, -3.0, -3.0));
	block.var[2][1][1][0] = (vec3(4.0, -2.0, -4.0));
	block.var[2][1][1][1] = (vec3(-5.0, -7.0, 1.0));
	block.var[2][1][1][2] = (vec3(-8.0, 1.0, 9.0));
	block.var[2][1][1][3] = (vec3(-8.0, 0.0, -2.0));
	block.var[2][2][0][0] = (vec3(-3.0, -7.0, 7.0));
	block.var[2][2][0][1] = (vec3(-9.0, -3.0, 6.0));
	block.var[2][2][0][2] = (vec3(0.0, -7.0, 3.0));
	block.var[2][2][0][3] = (vec3(2.0, -7.0, 1.0));
	block.var[2][2][1][0] = (vec3(8.0, -1.0, -9.0));
	block.var[2][2][1][1] = (vec3(8.0, 8.0, 2.0));
	block.var[2][2][1][2] = (vec3(7.0, -5.0, -2.0));
	block.var[2][2][1][3] = (vec3(-9.0, 6.0, 2.0));
	block.var[2][3][0][0] = (vec3(-1.0, -1.0, 1.0));
	block.var[2][3][0][1] = (vec3(-9.0, -7.0, -8.0));
	block.var[2][3][0][2] = (vec3(-8.0, -5.0, -1.0));
	block.var[2][3][0][3] = (vec3(2.0, 0.0, -4.0));
	block.var[2][3][1][0] = (vec3(7.0, 6.0, 4.0));
	block.var[2][3][1][1] = (vec3(-5.0, -5.0, 8.0));
	block.var[2][3][1][2] = (vec3(-3.0, 4.0, -5.0));
	block.var[2][3][1][3] = (vec3(-8.0, 5.0, -2.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(-7.0, -9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(5.0, -2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(-3.0, 6.0, 6.0, -1.0, -2.0, -7.0, 1.0, 0.0, -5.0, 3.0, -7.0, 2.0, 6.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(5.0, -4.0, -3.0, 9.0, -8.0, -9.0, 2.0, 5.0, -3.0, -3.0, -4.0, 9.0, -2.0, -8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(1.0, 5.0, -7.0, -8.0, 2.0, 4.0, -9.0, -7.0, -4.0, 6.0, -7.0, 0.0, 5.0, 3.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(-1.0, 9.0, 7.0, 3.0, 6.0, 4.0, -2.0, 2.0, -4.0, 0.0, -3.0, 6.0, -6.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(8.0, -5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-6.0, 8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(6.0, 4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(-9.0, 0.0, 3.0, 0.0, 6.0, -5.0, 8.0, 6.0, -3.0, -9.0, -1.0, 2.0, 3.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(9.0, -8.0, -7.0, -1.0, -3.0, 9.0, -4.0, -9.0, 3.0, -3.0, -7.0, -7.0, 3.0, 1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(5.0, 7.0, -3.0, 4.0, 0.0, 8.0, -1.0, -4.0, 0.0, -5.0, 3.0, -8.0, -7.0, 5.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(-6.0, 7.0, -2.0, 2.0, 4.0, 7.0, -2.0, 9.0, -2.0, -5.0, 2.0, -7.0, 7.0, -5.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(8.0, 7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-7.0, 4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(4.0, -6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-4.0, -7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(3.0, 0.0, 5.0, -1.0, 2.0, 2.0, -2.0, 3.0, -9.0, 7.0, 0.0, -8.0, -4.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(-2.0, 8.0, -8.0, -3.0, 0.0, -5.0, 4.0, -3.0, -1.0, -8.0, 4.0, -2.0, -7.0, 0.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(-6.0, -6.0, -9.0, 2.0, 9.0, 6.0, -9.0, -1.0, -3.0, -9.0, -4.0, 4.0, -8.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(-3.0, -1.0, 6.0, -9.0, 6.0, -3.0, -5.0, 3.0, 8.0, -8.0, -6.0, 6.0, -1.0, 4.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	block.var[0][0][1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	block.var[0][1][0] = (mat4(3.0, 6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0));
	block.var[0][1][1] = (mat4(1.0, 2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0));
	block.var[0][2][0] = (mat4(5.0, 1.0, 7.0, 8.0, 0.0, -3.0, 8.0, 5.0, -2.0, -2.0, -1.0, -2.0, 4.0, -6.0, 1.0, 5.0));
	block.var[0][2][1] = (mat4(-1.0, 8.0, 6.0, 8.0, -7.0, -4.0, -5.0, -8.0, 5.0, 0.0, 7.0, -8.0, 8.0, -2.0, 6.0, 5.0));
	block.var[0][3][0] = (mat4(-2.0, -1.0, 8.0, 8.0, -9.0, 9.0, 6.0, -1.0, 3.0, -9.0, -4.0, -6.0, -2.0, 6.0, -7.0, 3.0));
	block.var[0][3][1] = (mat4(9.0, -7.0, 6.0, 8.0, -2.0, -6.0, -5.0, 5.0, -8.0, -5.0, 8.0, 4.0, 2.0, 2.0, 4.0, -9.0));
	block.var[1][0][0] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
	block.var[1][0][1] = (mat4(2.0, 3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0));
	block.var[1][1][0] = (mat4(2.0, 4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0));
	block.var[1][1][1] = (mat4(8.0, 9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0));
	block.var[1][2][0] = (mat4(2.0, 8.0, -1.0, 1.0, -9.0, -1.0, 9.0, -4.0, 9.0, 4.0, -2.0, 9.0, 6.0, 7.0, 1.0, 3.0));
	block.var[1][2][1] = (mat4(-7.0, -5.0, 2.0, -5.0, 8.0, -5.0, -6.0, 3.0, -5.0, -8.0, 1.0, -1.0, 1.0, 2.0, -5.0, 3.0));
	block.var[1][3][0] = (mat4(-5.0, -6.0, 9.0, -7.0, 8.0, -4.0, 0.0, -3.0, -1.0, 7.0, 1.0, -5.0, 8.0, 4.0, -7.0, 8.0));
	block.var[1][3][1] = (mat4(7.0, 1.0, 8.0, -1.0, 2.0, -4.0, 3.0, 6.0, -2.0, 9.0, 0.0, 2.0, -1.0, -5.0, 2.0, -6.0));
	block.var[2][0][0] = (mat4(-4.0, -1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0));
	block.var[2][0][1] = (mat4(-5.0, -1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0));
	block.var[2][1][0] = (mat4(-8.0, 6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0));
	block.var[2][1][1] = (mat4(-2.0, 0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0));
	block.var[2][2][0] = (mat4(7.0, 2.0, 8.0, -4.0, -1.0, 2.0, 4.0, 1.0, 9.0, 7.0, -6.0, 7.0, 7.0, -5.0, 0.0, 3.0));
	block.var[2][2][1] = (mat4(-4.0, -1.0, -2.0, -3.0, 6.0, 2.0, 7.0, 0.0, 3.0, 4.0, -4.0, 2.0, 8.0, -4.0, 7.0, -4.0));
	block.var[2][3][0] = (mat4(4.0, 2.0, -1.0, 5.0, 7.0, 1.0, -8.0, 4.0, 2.0, -3.0, -2.0, 1.0, -5.0, -8.0, 3.0, -8.0));
	block.var[2][3][1] = (mat4(-8.0, 9.0, 1.0, 7.0, -4.0, 3.0, -8.0, 6.0, 8.0, -5.0, -3.0, 2.0, 4.0, -5.0, -3.0, 8.0));
}
#version 450
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
	allOk = compare_uint((block.u), 7u) && allOk;
	allOk = compare_mat4x3(block.t[0].a, mat4x3(0.0, 7.0, 8.0, -1.0, -2.0, -1.0, -6.0, 9.0, -8.0, -3.0, 2.0, 8.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[0].a), uvec3(1u, 8u, 8u)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[0]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[1]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[2]), vec2(-5.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[3]), vec2(3.0, -7.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(-8.0, -4.0, 1.0, -8.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[1].a), uvec3(6u, 0u, 1u)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[0]), vec2(5.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[1]), vec2(0.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[2]), vec2(-2.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[3]), vec2(-6.0, 7.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(-8.0, 6.0, -8.0, -1.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[2].a), uvec3(4u, 6u, 7u)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[0]), vec2(-2.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[1]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[2]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[3]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(6.0, 2.0, 8.0, -3.0)) && allOk;
	allOk = compare_int((block.t[0].c), 5) && allOk;
	allOk = compare_mat4x3(block.t[1].a, mat4x3(9.0, -8.0, -7.0, -4.0, 4.0, 0.0, 9.0, 9.0, -8.0, 1.0, 3.0, -5.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[0].a), uvec3(1u, 5u, 9u)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[0]), vec2(6.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[1]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[2]), vec2(-2.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[3]), vec2(8.0, 1.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(-6.0, -4.0, -5.0, 4.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[1].a), uvec3(0u, 4u, 8u)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[0]), vec2(4.0, 5.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[1]), vec2(6.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[2]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[3]), vec2(-7.0, 4.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(3.0, 0.0, 7.0, -7.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[2].a), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[0]), vec2(5.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[1]), vec2(5.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[2]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[3]), vec2(-7.0, -9.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(-2.0, 6.0, -3.0, -2.0)) && allOk;
	allOk = compare_int((block.t[1].c), 9) && allOk;
	allOk = compare_mat4x3(block.t[2].a, mat4x3(3.0, 2.0, -9.0, 7.0, -4.0, -9.0, 1.0, -7.0, 7.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[0].a), uvec3(6u, 3u, 3u)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[0]), vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[1]), vec2(-2.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[2]), vec2(8.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[3]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[0].c), vec4(2.0, 8.0, -8.0, 4.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[1].a), uvec3(8u, 8u, 7u)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[0]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[1]), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[2]), vec2(9.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[3]), vec2(3.0, 8.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[1].c), vec4(-5.0, 8.0, 0.0, -8.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[2].a), uvec3(4u, 2u, 9u)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[0]), vec2(-5.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[1]), vec2(-3.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[2]), vec2(-6.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[3]), vec2(-8.0, 4.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[2].c), vec4(-3.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_int((block.t[2].c), -9) && allOk;
	allOk = compare_mat4x3(block.t[3].a, mat4x3(-7.0, -6.0, -7.0, -7.0, -3.0, 6.0, -3.0, 5.0, 2.0, -4.0, 7.0, 9.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[0].a), uvec3(0u, 0u, 5u)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[0]), vec2(2.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[1]), vec2(3.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[2]), vec2(8.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[3]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[0].c), vec4(-9.0, 6.0, -7.0, -8.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[1].a), uvec3(6u, 0u, 6u)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[0]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[1]), vec2(-2.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[2]), vec2(2.0, 1.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[3]), vec2(2.0, -6.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[1].c), vec4(1.0, 0.0, 0.0, -4.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[2].a), uvec3(4u, 6u, 4u)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[0]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[1]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[2]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[3]), vec2(-7.0, 5.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[2].c), vec4(-5.0, 7.0, 7.0, -7.0)) && allOk;
	allOk = compare_int((block.t[3].c), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (uvec3(5u, 0u, 9u));
	block.s.b[0] = (vec2(-3.0, 0.0));
	block.s.b[1] = (vec2(2.0, -7.0));
	block.s.b[2] = (vec2(0.0, -8.0));
	block.s.b[3] = (vec2(0.0, -4.0));
	block.s.c = (vec4(-7.0, 9.0, -3.0, 9.0));
	block.u = (8u);
}
#version 450
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
	allOk = compare_mat4x2(block[0].var, mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	block[1].var = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	block[2].var = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
}
#version 450
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
    Block block[3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block[0].padding), 4u) && allOk;
	allOk = compare_uvec4((block[0].var), uvec4(1u, 8u, 2u, 1u)) && allOk;
	allOk = compare_uint((block[1].padding), 9u) && allOk;
	allOk = compare_uvec4((block[1].var), uvec4(5u, 9u, 3u, 6u)) && allOk;
	allOk = compare_uint((block[2].padding), 5u) && allOk;
	allOk = compare_uvec4((block[2].var), uvec4(1u, 2u, 3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (2u);
	block[0].var = (uvec4(7u, 2u, 9u, 7u));
	block[1].padding = (9u);
	block[1].var = (uvec4(5u, 1u, 3u, 4u));
	block[2].padding = (4u);
	block[2].var = (uvec4(2u, 0u, 5u, 6u));
}
#version 450
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
	allOk = compare_float((block[0].padding), 9.0) && allOk;
	allOk = compare_mat3x4(block[0].var, mat3x4(-4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_float((block[1].padding), -7.0) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0, -7.0, 5.0)) && allOk;
	allOk = compare_float((block[2].padding), -6.0) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0, -5.0, 6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (3.0);
	block[0].var = (mat3x4(-9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0, -5.0));
	block[1].padding = (-1.0);
	block[1].var = (mat3x4(-8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0, -3.0, -3.0));
	block[2].padding = (9.0);
	block[2].var = (mat3x4(-7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0, -5.0, -5.0, -9.0));
}
#version 450
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
	bvec2 b;
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump vec2 c;
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp ivec4 d[1];
	highp ivec4 e;
	highp ivec2 f;
	bvec4 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(false, true)) && allOk;
	allOk = compare_ivec4((blockD.d[0]), ivec4(-2, 0, 3, -3)) && allOk;
	allOk = compare_ivec4((blockD.e), ivec4(2, -3, 8, 8)) && allOk;
	allOk = compare_ivec2((blockD.f), ivec2(-3, 8)) && allOk;
	allOk = compare_bvec4((blockD.g), bvec4(true, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockB.b = (bvec2(true, true));
	blockC.c = (vec2(2.0, 8.0));
	blockD.d[0] = (ivec4(-2, 5, -7, -5));
	blockD.e = (ivec4(-9, -9, -7, 3));
	blockD.g = (bvec4(false, true, false, false));
}
#version 450
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
	lowp ivec4 e;
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
	blockB.e = (ivec4(6, -5, 2, -9));
}
#version 450
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
	lowp mat2 a;
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
	allOk = compare_mat2(blockB.a, mat2(1.0, -5.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3x2 a[6];
	mediump vec4 b;
	highp mat3x4 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a[0], mat3x2(7.0, 4.0, 2.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1], mat3x2(5.0, 0.0, -4.0, 7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[2], mat3x2(-5.0, 7.0, 8.0, 0.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[3], mat3x2(-7.0, -4.0, -4.0, 2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[4], mat3x2(-3.0, -7.0, -4.0, 1.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[5], mat3x2(-3.0, 0.0, 5.0, 3.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[0], mat3x4(8.0, -8.0, -9.0, -4.0, -2.0, 7.0, -8.0, 5.0, -9.0, -4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[1], mat3x4(6.0, -4.0, -7.0, 8.0, 5.0, 5.0, -1.0, -3.0, -5.0, -6.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[2], mat3x4(-8.0, 5.0, 9.0, -9.0, 3.0, 3.0, 9.0, 0.0, 3.0, -8.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[3], mat3x4(-6.0, -8.0, 9.0, 6.0, 1.0, -1.0, 6.0, -1.0, -3.0, -1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[4], mat3x4(9.0, 6.0, 9.0, -2.0, 8.0, 8.0, -9.0, -6.0, -1.0, -2.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[5], mat3x4(8.0, -1.0, 5.0, -9.0, 1.0, 6.0, 0.0, 3.0, 5.0, -5.0, 2.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3x2(-1.0, 8.0, 1.0, 9.0, -1.0, -4.0));
	blockB.a[1] = (mat3x2(-2.0, 3.0, 9.0, -8.0, -9.0, -9.0));
	blockB.a[2] = (mat3x2(-4.0, 4.0, -3.0, 5.0, 2.0, 8.0));
	blockB.a[3] = (mat3x2(2.0, -5.0, -6.0, -5.0, 4.0, -9.0));
	blockB.a[4] = (mat3x2(-7.0, 8.0, 7.0, -9.0, -8.0, 1.0));
	blockB.a[5] = (mat3x2(1.0, 5.0, 7.0, 4.0, 4.0, 8.0));
	blockB.b = (vec4(-7.0, 0.0, 5.0, 7.0));
	blockB.c[0] = (mat3x4(-8.0, 1.0, -9.0, 0.0, -8.0, 2.0, 6.0, 1.0, 1.0, -5.0, -9.0, -7.0));
	blockB.c[1] = (mat3x4(-8.0, -4.0, -5.0, 5.0, 4.0, -3.0, -2.0, -5.0, 2.0, -5.0, -6.0, -9.0));
	blockB.c[2] = (mat3x4(-8.0, 9.0, -8.0, 0.0, 2.0, -4.0, -4.0, 3.0, -9.0, -1.0, -5.0, 4.0));
	blockB.c[3] = (mat3x4(-4.0, 6.0, 4.0, -5.0, 7.0, -2.0, 5.0, -1.0, -6.0, 0.0, 7.0, -2.0));
	blockB.c[4] = (mat3x4(6.0, 3.0, -4.0, -4.0, 7.0, 4.0, 3.0, 4.0, 7.0, -8.0, 1.0, -3.0));
	blockB.c[5] = (mat3x4(-9.0, -7.0, 8.0, -7.0, -3.0, 7.0, -9.0, -9.0, 0.0, -6.0, -7.0, -5.0));
}
#version 450
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
	layout(offset = 0) lowp uint a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec4 b;
	layout(offset = 16) mediump vec4 c;
	layout(offset = 32) mediump uvec4 d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump uint e;
	layout(offset = 4) mediump int f;
	layout(offset = 16) highp vec3 g;
	layout(offset = 32) highp vec3 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 9u) && allOk;
	allOk = compare_bvec4((blockC.b), bvec4(false, true, true, true)) && allOk;
	allOk = compare_vec4((blockC.c), vec4(-6.0, 3.0, -7.0, 9.0)) && allOk;
	allOk = compare_uint((blockD[0].e), 4u) && allOk;
	allOk = compare_int((blockD[0].f), -5) && allOk;
	allOk = compare_vec3((blockD[0].g), vec3(-4.0, -9.0, 3.0)) && allOk;
	allOk = compare_vec3((blockD[0].h), vec3(-4.0, 1.0, 9.0)) && allOk;
	allOk = compare_uint((blockD[1].e), 3u) && allOk;
	allOk = compare_int((blockD[1].f), -9) && allOk;
	allOk = compare_vec3((blockD[1].g), vec3(-8.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec3((blockD[1].h), vec3(2.0, -6.0, 9.0)) && allOk;
	allOk = compare_uint((blockD[2].e), 6u) && allOk;
	allOk = compare_int((blockD[2].f), -6) && allOk;
	allOk = compare_vec3((blockD[2].g), vec3(-9.0, 8.0, -6.0)) && allOk;
	allOk = compare_vec3((blockD[2].h), vec3(-7.0, 2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (3u);
	blockC.b = (bvec4(false, false, true, false));
	blockC.c = (vec4(7.0, -5.0, -5.0, -4.0));
	blockC.d = (uvec4(2u, 7u, 1u, 1u));
	blockD[0].e = (5u);
	blockD[0].g = (vec3(-8.0, 6.0, 5.0));
	blockD[0].h = (vec3(0.0, 1.0, -1.0));
	blockD[1].e = (7u);
	blockD[1].g = (vec3(6.0, -6.0, 2.0));
	blockD[1].h = (vec3(6.0, 9.0, -9.0));
	blockD[2].e = (7u);
	blockD[2].g = (vec3(-4.0, -4.0, 0.0));
	blockD[2].h = (vec3(3.0, -8.0, 1.0));
}
#version 450
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
	layout(offset = 0) lowp int a[1];
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp ivec2 b;
	layout(offset = 8) bvec2 c;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockC.b), ivec2(4, 3)) && allOk;
	allOk = compare_bvec2((blockC.c), bvec2(false, true)) && allOk;
	allOk = compare_bvec4((blockD.d), bvec4(false, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (-7);
	blockB[1].a[0] = (-2);
	blockC.b = (ivec2(8, -4));
	blockC.c = (bvec2(false, false));
	blockD.d = (bvec4(true, true, false, false));
}
#version 450
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
	bool mA[2];
	mediump mat2 mB[2];
	bool mC;
	highp int mD;
};
layout(scalar, buffer_reference) buffer BlockB
{
	highp mat2x3 a;
	bool b;
	sA c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.c.mA[0]), true) && allOk;
	allOk = compare_bool((blockB.c.mA[1]), true) && allOk;
	allOk = compare_mat2(blockB.c.mB[0], mat2(-2.0, -7.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(blockB.c.mB[1], mat2(-5.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_bool((blockB.c.mC), false) && allOk;
	allOk = compare_int((blockB.c.mD), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(7.0, -6.0, 8.0, 6.0, -3.0, 9.0));
	blockB.b = (true);
	blockB.c.mA[0] = (false);
	blockB.c.mA[1] = (false);
	blockB.c.mB[0] = (mat2(-8.0, 3.0, -3.0, 9.0));
	blockB.c.mB[1] = (mat2(-2.0, -9.0, 8.0, 3.0));
	blockB.c.mC = (false);
	blockB.c.mD = (9);
}
#version 450
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
	lowp ivec4 a;
};
layout(scalar, buffer_reference) buffer BlockC
{
	mediump mat4x2 b;
	lowp float c;
	bvec4 d[];
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockD
{
	highp uint e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	lowp mat4x3 f;
	lowp ivec2 g;
	mediump mat4x3 h;
	mediump mat3 i;
	mediump ivec4 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(-9, 1, 0, -9)) && allOk;
	allOk = compare_mat4x2(blockC.b, mat4x2(6.0, 8.0, -2.0, 2.0, -1.0, 1.0, -9.0, 4.0)) && allOk;
	allOk = compare_bvec4((blockC.d[0]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.d[1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((blockC.d[2]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((blockC.d[3]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC.d[4]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((blockC.d[5]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_mat4x3(blockE.f, mat4x3(6.0, 1.0, 6.0, -6.0, -1.0, 7.0, 8.0, 7.0, -1.0, 6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(blockE.i, mat3(-7.0, -5.0, -2.0, -1.0, -2.0, 5.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_ivec4((blockE.j[0]), ivec4(-5, -3, -1, -2)) && allOk;
	allOk = compare_ivec4((blockE.j[1]), ivec4(1, 0, -7, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-4, 7, 8, 2));
	blockC.b = (mat4x2(0.0, -4.0, -9.0, 1.0, 6.0, -8.0, -5.0, 9.0));
	blockC.c = (6.0);
	blockC.d[0] = (bvec4(false, false, false, true));
	blockC.d[1] = (bvec4(false, false, true, false));
	blockC.d[2] = (bvec4(false, true, false, true));
	blockC.d[3] = (bvec4(true, true, true, true));
	blockC.d[4] = (bvec4(true, false, false, true));
	blockC.d[5] = (bvec4(false, true, true, false));
	blockE.f = (mat4x3(9.0, 4.0, 9.0, 0.0, -7.0, 0.0, 4.0, -4.0, -6.0, 5.0, 0.0, -4.0));
	blockE.g = (ivec2(-2, -6));
	blockE.i = (mat3(3.0, 8.0, 8.0, -6.0, 9.0, 7.0, 9.0, 1.0, -2.0));
	blockE.j[0] = (ivec4(-6, -3, 4, 8));
	blockE.j[1] = (ivec4(-3, 3, 3, 2));
}
#version 450
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
	highp mat4x3 a;
	bvec4 b;
	highp mat3 c;
	mediump vec4 d;
	highp mat3x4 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b), bvec4(true, true, true, false)) && allOk;
	allOk = compare_mat3(blockB.c, mat3(-6.0, -2.0, -8.0, -9.0, -5.0, 2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB.d), vec4(-7.0, 3.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB.e[0], mat3x4(-7.0, 6.0, 1.0, -4.0, -3.0, -5.0, -7.0, 2.0, 8.0, 8.0, -2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(3.0, -3.0, 2.0, 0.0, -2.0, 3.0, -3.0, 1.0, 7.0, -9.0, 9.0, 8.0));
	blockB.b = (bvec4(true, false, true, true));
	blockB.d = (vec4(-8.0, -1.0, -7.0, 4.0));
	blockB.e[0] = (mat3x4(8.0, 5.0, 2.0, -7.0, 3.0, -9.0, -3.0, -9.0, 8.0, -3.0, 4.0, -9.0));
}
#version 450
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
	mediump float a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

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

layout(std140, buffer_reference) readonly buffer BlockB
{
	bool a;
	bool b;
	lowp uint c;
};
layout(std140, buffer_reference) buffer BlockC
{
	int16_t d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockC.d = int16_t(-6);
}
#version 450
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
	float16_t a;
	highp ivec2 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp mat3 c[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	float16_t d;
	bvec3 e;
	mediump uvec3 f;
	lowp mat2x3 g;
	int16_t h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockD.d), -2.0) && allOk;
	allOk = compare_int16_t(int(blockD.h[0]), -2) && allOk;
	allOk = compare_int16_t(int(blockD.h[1]), 2) && allOk;
	allOk = compare_int16_t(int(blockD.h[2]), 9) && allOk;
	allOk = compare_int16_t(int(blockD.h[3]), -3) && allOk;
	allOk = compare_int16_t(int(blockD.h[4]), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c[0] = (mat3(-4.0, -8.0, -5.0, 0.0, 0.0, -7.0, 5.0, 3.0, 4.0));
	blockC.c[1] = (mat3(7.0, 8.0, 3.0, 8.0, 8.0, 0.0, 8.0, -6.0, 5.0));
	blockD.e = (bvec3(false, false, false));
	blockD.g = (mat2x3(7.0, -9.0, -5.0, 5.0, 3.0, 7.0));
	blockD.h[0] = int16_t(-7);
	blockD.h[1] = int16_t(-6);
	blockD.h[2] = int16_t(1);
	blockD.h[3] = int16_t(8);
	blockD.h[4] = int16_t(8);
}
#version 450
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
	mediump mat2x3 a;
	uint16_t b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp int c[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	highp ivec2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(-8.0, -8.0, 0.0, -9.0, -1.0, 4.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[0]), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(-2.0, -9.0, -3.0, -1.0, -2.0, 7.0));
	blockC.c[0] = (-6);
	blockD.d = (ivec2(-5, -9));
}
#version 450
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
	bvec4 mB;
};
struct sB
{
	lowp mat3x2 mA;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	sA a;
	mediump vec3 b;
	sB c;
	mediump int d[1];
	u16vec4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.b), vec3(-4.0, -3.0, 4.0)) && allOk;
	allOk = compare_int((blockB.d[0]), 0) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.e), uvec4(9u, 8u, 9u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = f16vec4(vec4(6.0, -1.0, 0.0, 3.0));
	blockB.a.mB = (bvec4(false, false, true, false));
	blockB.b = (vec3(-4.0, -6.0, 3.0));
	blockB.c.mA = (mat3x2(-2.0, 5.0, -2.0, 6.0, 7.0, -5.0));
}
#version 450
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
	u16vec2 mB;
	u16vec2 mC;
	f16vec4 mD;
};
struct sB
{
	uint16_t mA;
	mediump vec3 mB;
	sA mC;
};
struct sC
{
	f16vec3 mA;
	highp mat4x2 mB;
	uint16_t mC;
};
struct sD
{
	i16vec4 mA;
	sC mB;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	mediump mat3 a[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	sB b;
	mediump mat2x3 c;
	highp mat4x2 d;
	sD e;
	mediump mat4 f[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a[0], mat3(-2.0, -8.0, -4.0, 4.0, 3.0, -5.0, 3.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockC.c, mat2x3(-4.0, 5.0, -3.0, 3.0, 9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3(-7.0, -7.0, 9.0, 3.0, -4.0, -4.0, -9.0, -1.0, -4.0));
	blockC.b.mA = uint16_t(4u);
	blockC.b.mB = (vec3(-7.0, -4.0, 0.0));
	blockC.b.mC.mA = (mat4(-7.0, -7.0, 9.0, 1.0, -9.0, 2.0, -1.0, -8.0, -8.0, -5.0, 9.0, -2.0, -4.0, -9.0, 4.0, -5.0));
	blockC.b.mC.mB = u16vec2(uvec2(2u, 9u));
	blockC.b.mC.mC = u16vec2(uvec2(2u, 7u));
	blockC.b.mC.mD = f16vec4(vec4(-2.0, 9.0, -6.0, 8.0));
	blockC.c = (mat2x3(5.0, -3.0, -2.0, 3.0, 6.0, 2.0));
	blockC.d = (mat4x2(-5.0, 8.0, 5.0, 5.0, 5.0, 5.0, 3.0, 3.0));
	blockC.e.mA = i16vec4(ivec4(6, 5, 1, 1));
	blockC.e.mB.mA = f16vec3(vec3(-2.0, -3.0, 8.0));
	blockC.e.mB.mB = (mat4x2(2.0, -7.0, -1.0, 5.0, -8.0, 1.0, 9.0, 3.0));
	blockC.e.mB.mC = uint16_t(3u);
	blockC.f[0] = (mat4(-8.0, 6.0, -6.0, 4.0, -8.0, -5.0, 0.0, -4.0, -6.0, 7.0, 7.0, -8.0, 7.0, 6.0, -7.0, 1.0));
}
#version 450
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
};
struct sB
{
	bvec2 mA;
	bvec2 mB;
	sA mC;
	mediump mat3 mD;
};
struct sC
{
	i16vec3 mA;
	bvec2 mB;
	bvec3 mC;
	highp ivec2 mD;
};
layout(std430, buffer_reference) readonly buffer BlockB
{
	highp vec3 a;
	sB b;
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	int16_t c[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	sC d;
	highp vec4 e;
	uint16_t f;
	highp mat3 g;
	highp int h[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	f16vec4 i;
	mediump mat2x3 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.b.mA), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.b.mB), bvec2(true, false)) && allOk;
	allOk = compare_vec3((blockB.b.mC.mA), vec3(-7.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB.b.mD, mat3(-1.0, 5.0, 2.0, -4.0, 7.0, 7.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD.d.mA), ivec3(-4, 7, -6)) && allOk;
	allOk = compare_bvec2((blockD.d.mB), bvec2(true, true)) && allOk;
	allOk = compare_bvec3((blockD.d.mC), bvec3(false, true, false)) && allOk;
	allOk = compare_ivec2((blockD.d.mD), ivec2(3, 3)) && allOk;
	allOk = compare_vec4((blockD.e), vec4(-7.0, 7.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3(blockD.g, mat3(3.0, -6.0, -5.0, -1.0, -5.0, 2.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.i), vec4(4.0, -4.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockE.j[0], mat2x3(-1.0, -1.0, -1.0, 9.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockE.j[1], mat2x3(-8.0, 9.0, -5.0, 7.0, -8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockD.d.mA = i16vec3(ivec3(-8, -8, 9));
	blockD.d.mB = (bvec2(false, true));
	blockD.d.mC = (bvec3(false, false, true));
	blockD.d.mD = (ivec2(-9, 2));
	blockD.g = (mat3(-2.0, -4.0, -1.0, -5.0, -9.0, -8.0, -5.0, 7.0, 9.0));
	blockD.h[0] = (2);
	blockD.h[1] = (5);
	blockD.h[2] = (-2);
	blockE.i = f16vec4(vec4(-5.0, 0.0, -4.0, 9.0));
	blockE.j[0] = (mat2x3(0.0, -5.0, 8.0, -4.0, 6.0, -6.0));
	blockE.j[1] = (mat2x3(2.0, 7.0, 8.0, 7.0, -6.0, -2.0));
}
#version 450
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
	layout(offset = 0) u16vec3 a;
	layout(offset = 8) highp uint b;
	layout(offset = 16) i16vec3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.b), 3u) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.c), ivec3(0, -6, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec3(uvec3(4u, 2u, 0u));
	blockB.b = (1u);
	blockB.c = i16vec3(ivec3(-9, 0, 4));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(column_major, buffer_reference) buffer BlockB
{
	layout(offset = 0) mediump ivec2 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].a), ivec2(-5, -9)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].a), ivec2(-7, 9)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(2)].a), ivec2(-1, 0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(3)].a), ivec2(-3, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (ivec2(-7, 4));
	blockB[nonuniformEXT(1)].a = (ivec2(-4, -7));
	blockB[nonuniformEXT(2)].a = (ivec2(-3, -9));
	blockB[nonuniformEXT(3)].a = (ivec2(1, 2));
}
#version 450
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
	mediump uvec4 a;
	u8vec2 b;
};
layout(std430, buffer_reference) buffer BlockC
{
	u8vec4 c[1];
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump ivec3 d;
	u8vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(2u, 5u, 1u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.c[0]), uvec4(9u, 2u, 0u, 4u)) && allOk;
	allOk = compare_ivec3((blockD.d), ivec3(4, -7, 3)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.e), uvec3(2u, 4u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(6u, 8u, 4u, 7u));
	blockC.c[0] = u8vec4(uvec4(4u, 7u, 8u, 6u));
	blockD.e = u8vec3(uvec3(2u, 4u, 9u));
}
#version 450
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
	highp uvec4 a;
	mediump float b;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	mediump uvec2 c;
	u8vec3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(4u, 0u, 4u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (uvec2(7u, 2u));
}
#version 450
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
	highp mat4 a;
	lowp vec4 b;
	bvec4 c;
	lowp mat2 d[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp vec4 e[2];
	lowp uvec2 f[];
};
layout(std430, buffer_reference) buffer BlockD
{
	highp uvec4 g;
	highp mat4 h;
	lowp mat4 i[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	i8vec3 j;
	highp vec3 k[];
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
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b), vec4(-8.0, -6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(blockB.d[0], mat2(-2.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2(blockB.d[1], mat2(5.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(blockB.d[2], mat2(4.0, 8.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec4((blockC.e[0]), vec4(3.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_vec4((blockC.e[1]), vec4(-5.0, -9.0, -7.0, 6.0)) && allOk;
	allOk = compare_uvec2((blockC.f[0]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((blockC.f[1]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((blockC.f[2]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((blockC.f[3]), uvec2(0u, 4u)) && allOk;
	allOk = compare_uvec2((blockC.f[4]), uvec2(6u, 5u)) && allOk;
	allOk = compare_uvec2((blockC.f[5]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((blockC.f[6]), uvec2(2u, 5u)) && allOk;
	allOk = compare_uvec2((blockC.f[7]), uvec2(1u, 0u)) && allOk;
	allOk = compare_uvec4((blockD.g), uvec4(7u, 2u, 8u, 1u)) && allOk;
	allOk = compare_mat4(blockD.h, mat4(4.0, -2.0, 5.0, 9.0, -1.0, -9.0, -6.0, 3.0, 8.0, 5.0, 4.0, 7.0, -2.0, -1.0, -2.0, -6.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.j), ivec3(4294967289, 8, 4294967290)) && allOk;
	allOk = compare_vec3((blockE.k[0]), vec3(-3.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d[0] = (mat2(0.0, 3.0, 9.0, -8.0));
	blockB.d[1] = (mat2(-9.0, -2.0, 0.0, 2.0));
	blockB.d[2] = (mat2(6.0, -7.0, 3.0, 9.0));
	blockC.e[0] = (vec4(8.0, 1.0, 7.0, -9.0));
	blockC.e[1] = (vec4(2.0, 7.0, 0.0, -8.0));
	blockC.f[0] = (uvec2(3u, 7u));
	blockC.f[1] = (uvec2(6u, 8u));
	blockC.f[2] = (uvec2(2u, 8u));
	blockC.f[3] = (uvec2(0u, 1u));
	blockC.f[4] = (uvec2(8u, 3u));
	blockC.f[5] = (uvec2(1u, 6u));
	blockC.f[6] = (uvec2(4u, 9u));
	blockC.f[7] = (uvec2(2u, 7u));
	blockD.g = (uvec4(7u, 5u, 2u, 8u));
	blockD.h = (mat4(-8.0, 2.0, -3.0, 9.0, -5.0, -1.0, 0.0, -3.0, 7.0, 4.0, 1.0, 5.0, 4.0, -6.0, -7.0, -2.0));
	blockD.i[0] = (mat4(4.0, -8.0, -4.0, -5.0, 9.0, -4.0, 5.0, 1.0, -5.0, 9.0, 0.0, -8.0, -7.0, -6.0, -8.0, 2.0));
	blockE.k[0] = (vec3(-3.0, -5.0, -9.0));
}
#version 450
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
	u8vec3 a;
	bool b[6];
	i8vec2 c;
	int8_t d[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp mat4x3 e;
	int8_t f;
	lowp uvec4 g;
	highp uvec3 h;
	highp uvec4 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.a), uvec3(5u, 4u, 9u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c), ivec2(2, 0)) && allOk;
	allOk = compare_int8_t(int(blockB.d[0]), 4294967287) && allOk;
	allOk = compare_mat4x3(blockC.e, mat4x3(0.0, -2.0, -7.0, -9.0, -5.0, -2.0, 7.0, 2.0, 9.0, 0.0, 4.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockC.h), uvec3(5u, 1u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec3(uvec3(3u, 1u, 6u));
	blockB.b[0] = (false);
	blockB.b[1] = (true);
	blockB.b[2] = (true);
	blockB.b[3] = (false);
	blockB.b[4] = (true);
	blockB.b[5] = (false);
	blockB.c = i8vec2(ivec2(4294967293, 4294967295));
	blockB.d[0] = int8_t(6);
	blockC.f = int8_t(4294967294);
	blockC.h = (uvec3(2u, 9u, 0u));
}
#version 450
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
	int8_t mB;
};
struct sB
{
	mediump float mA;
	lowp uint mB;
	lowp mat2 mC;
	highp uint mD[5];
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	mediump uvec4 a;
	lowp ivec2 b;
	sA c;
	bvec4 d;
	lowp ivec3 e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	bvec2 f;
	lowp mat4x2 g;
	sB h;
	u8vec3 i[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	mediump int j;
	lowp mat3x2 k;
	uint8_t l;
	u8vec2 m[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	highp ivec3 n;
	highp ivec2 o;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(3u, 1u, 9u, 8u)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(4, 1)) && allOk;
	allOk = compare_uvec4((blockB.c.mA), uvec4(8u, 8u, 0u, 7u)) && allOk;
	allOk = compare_int8_t(int(blockB.c.mB), 4294967290) && allOk;
	allOk = compare_ivec3((blockB.e[0]), ivec3(-5, 5, -6)) && allOk;
	allOk = compare_ivec3((blockB.e[1]), ivec3(5, -7, -4)) && allOk;
	allOk = compare_ivec3((blockB.e[2]), ivec3(-7, -7, 0)) && allOk;
	allOk = compare_ivec3((blockB.e[3]), ivec3(6, -7, 5)) && allOk;
	allOk = compare_ivec3((blockB.e[4]), ivec3(-9, 3, -2)) && allOk;
	allOk = compare_float((blockC.h.mA), 1.0) && allOk;
	allOk = compare_uint((blockC.h.mB), 6u) && allOk;
	allOk = compare_mat2(blockC.h.mC, mat2(-5.0, 3.0, 6.0, 9.0)) && allOk;
	allOk = compare_uint((blockC.h.mD[0]), 4u) && allOk;
	allOk = compare_uint((blockC.h.mD[1]), 9u) && allOk;
	allOk = compare_uint((blockC.h.mD[2]), 1u) && allOk;
	allOk = compare_uint((blockC.h.mD[3]), 1u) && allOk;
	allOk = compare_uint((blockC.h.mD[4]), 4u) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.i[0]), uvec3(3u, 9u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.i[1]), uvec3(2u, 6u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.i[2]), uvec3(8u, 5u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.i[3]), uvec3(1u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.i[4]), uvec3(8u, 6u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.i[5]), uvec3(3u, 4u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.i[6]), uvec3(1u, 9u, 6u)) && allOk;
	allOk = compare_mat3x2(blockD.k, mat3x2(-1.0, -8.0, -9.0, 2.0, -6.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockE.o), ivec2(-6, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(3u, 2u, 9u, 0u));
	blockB.c.mA = (uvec4(4u, 0u, 5u, 6u));
	blockB.c.mB = int8_t(4294967289);
	blockB.d = (bvec4(true, true, false, true));
	blockB.e[0] = (ivec3(1, -6, 4));
	blockB.e[1] = (ivec3(-4, -6, 9));
	blockB.e[2] = (ivec3(3, 7, 7));
	blockB.e[3] = (ivec3(-8, 5, -2));
	blockB.e[4] = (ivec3(-7, -2, 5));
	blockC.f = (bvec2(true, true));
	blockC.h.mA = (-3.0);
	blockC.h.mB = (4u);
	blockC.h.mC = (mat2(6.0, 5.0, 8.0, 5.0));
	blockC.h.mD[0] = (8u);
	blockC.h.mD[1] = (5u);
	blockC.h.mD[2] = (2u);
	blockC.h.mD[3] = (9u);
	blockC.h.mD[4] = (3u);
	blockD.j = (2);
	blockD.k = (mat3x2(3.0, 1.0, -5.0, -2.0, 5.0, -1.0));
	blockD.l = uint8_t(6u);
	blockE.n = (ivec3(4, -9, 9));
}
#version 450
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
	layout(offset = 0) mediump uvec2 a;
	layout(offset = 16) bvec3 b;
	layout(offset = 32) mediump ivec2 c;
	layout(offset = 48) mediump uvec4 d;
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) bvec4 e;
};
layout(buffer_reference) readonly buffer BlockD
{
	layout(offset = 0) i8vec2 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(1u, 9u)) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(false, false, false)) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(-7, 1)) && allOk;
	allOk = compare_uvec4((blockB.d), uvec4(6u, 2u, 7u, 6u)) && allOk;
	allOk = compare_bvec4((blockC.e), bvec4(true, false, false, true)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.f), ivec2(3, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (ivec2(0, 0));
	blockB.d = (uvec4(5u, 8u, 1u, 5u));
}
#version 450
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
	layout(offset = 0) lowp ivec4 a;
	layout(offset = 16) bvec2 b;
	layout(offset = 24) lowp int c;
	layout(offset = 28) int8_t d;
	layout(offset = 32) bvec4 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) uint8_t f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
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
	allOk = compare_uint8_t(uint(blockC.f), 9u) && allOk;
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
	blockC.f = uint8_t(0u);
}
#version 450
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
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump vec2 b;
	layout(offset = 16) lowp ivec3 c;
	layout(offset = 28) u8vec4 d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump ivec2 e;
	layout(offset = 16) highp vec4 f[1];
	layout(offset = 32) highp float g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockC.b), vec2(3.0, -8.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.d), uvec4(3u, 4u, 3u, 4u)) && allOk;
	allOk = compare_ivec2((blockD.e), ivec2(6, -6)) && allOk;
	allOk = compare_vec4((blockD.f[0]), vec4(9.0, -2.0, 5.0, -6.0)) && allOk;
	allOk = compare_float((blockD.g), -3.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockC.b = (vec2(-9.0, -7.0));
	blockC.c = (ivec3(-4, -1, 9));
	blockC.d = u8vec4(uvec4(0u, 6u, 4u, 5u));
	blockD.e = (ivec2(-4, 0));
	blockD.f[0] = (vec4(-7.0, -9.0, -8.0, -4.0));
	blockD.g = (-7.0);
}
#version 450
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
	layout(offset = 0) int8_t a;
	layout(offset = 8) highp uvec2 b[1];
	layout(offset = 16) mediump uvec2 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) u8vec4 d;
	layout(offset = 16) lowp ivec4 e;
	layout(offset = 32) i8vec3 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump ivec3 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.b[0]), uvec2(1u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.d), uvec4(6u, 8u, 8u, 0u)) && allOk;
	allOk = compare_ivec4((blockC.e), ivec4(-8, -6, 0, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f), ivec3(4294967295, 4294967295, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int8_t(4294967291);
	blockB.b[0] = (uvec2(2u, 9u));
	blockB.c = (uvec2(0u, 7u));
	blockC.e = (ivec4(-5, -7, 5, 2));
	blockC.f = i8vec3(ivec3(4294967292, 4294967288, 0));
	blockD.g = (ivec3(9, 3, 1));
}
#version 450
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
	layout(offset = 0) u8vec4 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) u8vec2 b;
	layout(offset = 2) uint8_t c;
	layout(offset = 4) highp float d[1];
	layout(offset = 8) u8vec2 e;
	layout(offset = 16) mediump uvec3 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec3 g;
	layout(offset = 16) bvec3 h;
	layout(offset = 32) bvec3 i;
	layout(offset = 48) mediump vec3 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockC.b), uvec2(8u, 5u)) && allOk;
	allOk = compare_uint8_t(uint(blockC.c), 2u) && allOk;
	allOk = compare_float((blockC.d[0]), 3.0) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.e), uvec2(5u, 6u)) && allOk;
	allOk = compare_uvec3((blockC.f), uvec3(3u, 7u, 8u)) && allOk;
	allOk = compare_bvec3((blockD[0].g), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockD[0].h), bvec3(true, false, true)) && allOk;
	allOk = compare_vec3((blockD[0].j), vec3(5.0, 8.0, -1.0)) && allOk;
	allOk = compare_bvec3((blockD[1].g), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockD[1].h), bvec3(true, false, false)) && allOk;
	allOk = compare_vec3((blockD[1].j), vec3(-9.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = u8vec4(uvec4(4u, 3u, 5u, 0u));
	blockC.c = uint8_t(3u);
	blockC.d[0] = (6.0);
	blockC.e = u8vec2(uvec2(3u, 2u));
	blockD[0].h = (bvec3(true, true, true));
	blockD[0].i = (bvec3(true, false, true));
	blockD[0].j = (vec3(8.0, 7.0, 8.0));
	blockD[1].h = (bvec3(false, false, false));
	blockD[1].i = (bvec3(true, true, false));
	blockD[1].j = (vec3(5.0, 7.0, -2.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, buffer_reference) readonly buffer BlockB
{
	highp mat4 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a[0], mat4(8.0, 3.0, 8.0, -9.0, -5.0, 4.0, -1.0, 5.0, -1.0, 6.0, -8.0, 3.0, 0.0, 4.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(blockB.a[1], mat4(-5.0, 2.0, -8.0, 8.0, -9.0, 1.0, -7.0, 8.0, 1.0, -8.0, 9.0, 2.0, 6.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4(blockB.a[2], mat4(3.0, 1.0, -1.0, 3.0, 4.0, 0.0, 6.0, 1.0, -7.0, -5.0, 8.0, 6.0, -6.0, 4.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat4(blockB.a[3], mat4(7.0, 3.0, 9.0, 0.0, -6.0, -1.0, -4.0, 9.0, -1.0, -8.0, -8.0, 1.0, -6.0, -3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4(blockB.a[4], mat4(-2.0, 6.0, 8.0, 5.0, 8.0, 0.0, -5.0, 5.0, -5.0, -6.0, 6.0, 7.0, 3.0, -3.0, -7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
