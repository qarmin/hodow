#version 450
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
	mediump vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var), vec4(-2.0, 4.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (vec4(-3.0, 6.0, 7.0, 3.0));
}
#version 450
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
	lowp uvec2 var;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var), uvec2(2u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (uvec2(6u, 3u));
}
#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[1][0], 7.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, -9.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(4.0, 8.0));
	var[1] = (vec2(5.0, -8.0));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
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

	var[0] = (vec2(-8.0, 9.0));
	var[1] = (vec2(3.0, 2.0));
	var[2] = (vec2(3.0, -1.0));
	var[3] = (vec2(-9.0, -8.0));
}
#version 450
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
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(-4.0, 1.0, -2.0, -6.0, 1.0, 6.0, -7.0, 4.0, 3.0, -5.0, 1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-7.0, -9.0, 3.0));
	var[1] = (vec3(-3.0, -5.0, -8.0));
	var[2] = (vec3(5.0, -3.0, -6.0));
	var[3] = (vec3(1.0, 6.0, -7.0));
}
#version 450
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
	mediump ivec4 var;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var), ivec4(-1, -2, -7, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (ivec4(3, 4, -3, -6));
}
#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(8.0, -4.0, 9.0, -3.0, -9.0, 9.0, -2.0, -1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(-6.0, 6.0, 1.0, 6.0, -7.0, -8.0, -7.0, -6.0, -6.0));
}
#version 450
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
	allOk = compare_mat4(var, mat4(5.0, 5.0, 1.0, -2.0, 6.0, -1.0, -4.0, 5.0, 5.0, -8.0, 7.0, -8.0, 5.0, 4.0, 0.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4(4.0, -9.0, -5.0, 2.0, -3.0, -4.0, 6.0, 6.0, 2.0, 2.0, 7.0, -7.0, 5.0, -2.0, 0.0, 8.0));
}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(1.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-4.0, 8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(6.0, 8.0, 5.0, 2.0, -2.0, -1.0));
}
#version 450
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
	highp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(6.0, -1.0, -3.0, -3.0, -7.0, 2.0, 4.0, 3.0, -7.0, 9.0, 7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(6.0, 7.0, -9.0, -7.0, 8.0, 0.0, -5.0, -6.0, 0.0, -3.0, -8.0, 3.0));
}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(9.0, 7.0, 1.0, -5.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0] = (vec2(7.0, 5.0));
	var[1] = (vec2(7.0, 4.0));
	var[2] = (vec2(8.0, -9.0));
}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(2.0, -7.0, 9.0, -8.0, 7.0, -7.0, -6.0, -6.0, 1.0, 3.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0] = (vec4(-8.0, -5.0, -7.0, 1.0));
	var[1] = (vec4(2.0, -4.0, -6.0, 6.0));
	var[2] = (vec4(2.0, 2.0, 0.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	var[1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	var[2] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
}
#version 450
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
	highp uvec2 var[3];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var[0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((var[1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((var[2]), uvec2(1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (uvec2(6u, 1u));
	var[1] = (uvec2(8u, 1u));
	var[2] = (uvec2(7u, 4u));
}
#version 450
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
	allOk = compare_mat4(var[0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	var[1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	var[2] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3(var[0], mat3(-4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0] = (vec3(-4.0, 9.0, -4.0));
	var[0][1] = (vec3(2.0, 5.0, 5.0));
	var[0][2] = (vec3(-9.0, -5.0, 3.0));
	var[1][0] = (vec3(1.0, 8.0, 6.0));
	var[1][1] = (vec3(9.0, -8.0, -1.0));
	var[1][2] = (vec3(5.0, 1.0, 6.0));
	var[2][0] = (vec3(-5.0, -4.0, -8.0));
	var[2][1] = (vec3(-8.0, -2.0, 9.0));
	var[2][2] = (vec3(-4.0, 4.0, 4.0));
}
#version 450
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
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(9.0, -6.0, -8.0, -7.0, 2.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-4.0, 1.0, 5.0, 2.0, -6.0, 5.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(8.0, 9.0, 2.0, -7.0, -8.0, 9.0, -9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0][0] = (vec2(-2.0, 8.0));
	var[0][1] = (vec2(-4.0, 4.0));
	var[0][2] = (vec2(9.0, 5.0));
	var[0][3] = (vec2(-9.0, -2.0));
	var[1][0] = (vec2(6.0, -8.0));
	var[1][1] = (vec2(-5.0, -1.0));
	var[1][2] = (vec2(9.0, 0.0));
	var[1][3] = (vec2(4.0, 5.0));
	var[2][0] = (vec2(4.0, -5.0));
	var[2][1] = (vec2(-2.0, -4.0));
	var[2][2] = (vec2(6.0, 4.0));
	var[2][3] = (vec2(-2.0, 5.0));
}
#version 450
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

	var[0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	var[1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	var[2] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
	var[3] = (mat3x2(0.0, 6.0, -5.0, 4.0, -2.0, 0.0));
	var[4] = (mat3x2(-3.0, -3.0, -2.0, 9.0, -2.0, -7.0));
	var[5] = (mat3x2(-9.0, -2.0, -8.0, 4.0, 3.0, 8.0));
	var[6] = (mat3x2(7.0, 9.0, -5.0, 9.0, -1.0, 4.0));
	var[7] = (mat3x2(6.0, -4.0, -6.0, 0.0, 7.0, -2.0));
	var[8] = (mat3x2(-1.0, -9.0, 8.0, -6.0, -9.0, 5.0));
	var[9] = (mat3x2(2.0, -9.0, 9.0, 4.0, -4.0, 9.0));
	var[10] = (mat3x2(3.0, 3.0, 1.0, -4.0, 0.0, -7.0));
	var[11] = (mat3x2(-4.0, 7.0, 7.0, -1.0, -2.0, 6.0));
	var[12] = (mat3x2(4.0, -9.0, -8.0, 7.0, -5.0, -1.0));
	var[13] = (mat3x2(-7.0, 4.0, -2.0, -6.0, -5.0, 6.0));
	var[14] = (mat3x2(-3.0, -7.0, 9.0, 9.0, -8.0, 0.0));
	var[15] = (mat3x2(6.0, -3.0, 9.0, -2.0, -5.0, -4.0));
	var[16] = (mat3x2(-4.0, 6.0, -7.0, 5.0, -1.0, 5.0));
	var[17] = (mat3x2(4.0, -7.0, -3.0, 6.0, -8.0, 2.0));
	var[18] = (mat3x2(-3.0, -4.0, -7.0, 0.0, 8.0, 4.0));
}
#version 450
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
	var[3][0] = (vec2(6.0, -1.0));
	var[3][1] = (vec2(-7.0, -5.0));
	var[3][2] = (vec2(-2.0, -8.0));
	var[3][3] = (vec2(1.0, 3.0));
	var[4][0] = (vec2(4.0, 2.0));
	var[4][1] = (vec2(-9.0, 2.0));
	var[4][2] = (vec2(-3.0, 3.0));
	var[4][3] = (vec2(0.0, 1.0));
	var[5][0] = (vec2(-5.0, -9.0));
	var[5][1] = (vec2(2.0, -2.0));
	var[5][2] = (vec2(-3.0, 0.0));
	var[5][3] = (vec2(9.0, 6.0));
	var[6][0] = (vec2(3.0, -4.0));
	var[6][1] = (vec2(2.0, -3.0));
	var[6][2] = (vec2(6.0, 5.0));
	var[6][3] = (vec2(0.0, -2.0));
	var[7][0] = (vec2(-3.0, -2.0));
	var[7][1] = (vec2(-7.0, 3.0));
	var[7][2] = (vec2(-6.0, 2.0));
	var[7][3] = (vec2(9.0, 6.0));
	var[8][0] = (vec2(-4.0, 4.0));
	var[8][1] = (vec2(0.0, -3.0));
	var[8][2] = (vec2(-7.0, 0.0));
	var[8][3] = (vec2(-9.0, 1.0));
	var[9][0] = (vec2(7.0, 2.0));
	var[9][1] = (vec2(1.0, 9.0));
	var[9][2] = (vec2(-3.0, 3.0));
	var[9][3] = (vec2(-7.0, 9.0));
	var[10][0] = (vec2(-4.0, -1.0));
	var[10][1] = (vec2(3.0, 6.0));
	var[10][2] = (vec2(8.0, 3.0));
	var[10][3] = (vec2(1.0, 5.0));
	var[11][0] = (vec2(7.0, 0.0));
	var[11][1] = (vec2(0.0, -2.0));
	var[11][2] = (vec2(3.0, -7.0));
	var[11][3] = (vec2(-3.0, 1.0));
	var[12][0] = (vec2(4.0, 2.0));
	var[12][1] = (vec2(-4.0, 1.0));
	var[12][2] = (vec2(5.0, -7.0));
	var[12][3] = (vec2(5.0, 5.0));
	var[13][0] = (vec2(-5.0, 1.0));
	var[13][1] = (vec2(-7.0, -3.0));
	var[13][2] = (vec2(-1.0, 1.0));
	var[13][3] = (vec2(4.0, 7.0));
	var[14][0] = (vec2(-9.0, 1.0));
	var[14][1] = (vec2(-6.0, 7.0));
	var[14][2] = (vec2(8.0, -7.0));
	var[14][3] = (vec2(2.0, 1.0));
	var[15][0] = (vec2(-7.0, 4.0));
	var[15][1] = (vec2(-4.0, 4.0));
	var[15][2] = (vec2(0.0, 7.0));
	var[15][3] = (vec2(7.0, -1.0));
	var[16][0] = (vec2(0.0, -2.0));
	var[16][1] = (vec2(-8.0, 2.0));
	var[16][2] = (vec2(8.0, -1.0));
	var[16][3] = (vec2(5.0, 2.0));
	var[17][0] = (vec2(4.0, 1.0));
	var[17][1] = (vec2(-6.0, 7.0));
	var[17][2] = (vec2(-7.0, 1.0));
	var[17][3] = (vec2(2.0, -4.0));
	var[18][0] = (vec2(-8.0, -5.0));
	var[18][1] = (vec2(8.0, -8.0));
	var[18][2] = (vec2(7.0, -2.0));
	var[18][3] = (vec2(-7.0, -7.0));
}
#version 450
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
	i8vec2 var[];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(var[0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2]), ivec2(0, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[4]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(var[5]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(var[6]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[7]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[8]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[9]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[10]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[11]), ivec2(3, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[12]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(var[13]), ivec2(2, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(var[14]), ivec2(4294967290, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[15]), ivec2(5, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[16]), ivec2(8, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[17]), ivec2(4294967294, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(var[18]), ivec2(7, 4294967292)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = i8vec2(ivec2(0, 8));
	var[1] = i8vec2(ivec2(4294967292, 9));
	var[2] = i8vec2(ivec2(4294967294, 4294967295));
	var[3] = i8vec2(ivec2(8, 4294967290));
	var[4] = i8vec2(ivec2(8, 4294967289));
	var[5] = i8vec2(ivec2(7, 4294967294));
	var[6] = i8vec2(ivec2(4294967293, 4294967293));
	var[7] = i8vec2(ivec2(4294967290, 3));
	var[8] = i8vec2(ivec2(4294967295, 8));
	var[9] = i8vec2(ivec2(5, 8));
	var[10] = i8vec2(ivec2(4294967293, 4294967292));
	var[11] = i8vec2(ivec2(4294967287, 6));
	var[12] = i8vec2(ivec2(4294967293, 0));
	var[13] = i8vec2(ivec2(3, 4294967291));
	var[14] = i8vec2(ivec2(4294967295, 4294967292));
	var[15] = i8vec2(ivec2(5, 4294967292));
	var[16] = i8vec2(ivec2(4294967291, 4));
	var[17] = i8vec2(ivec2(0, 4294967293));
	var[18] = i8vec2(ivec2(4294967292, 4294967292));
}
#version 450
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
	allOk = compare_mat3(var[0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(5.0, -7.0, 2.0, -4.0, -1.0, -2.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(5.0, -7.0, 6.0, 5.0, 2.0, -2.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(1.0, -3.0, 4.0, 0.0, -1.0, 8.0, 6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(2.0, 7.0, -2.0, 3.0, 3.0, -2.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(9.0, 4.0, -5.0, 1.0, 0.0, -1.0, -5.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(9.0, 4.0, -9.0, 4.0, 7.0, -5.0, 6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(-3.0, -5.0, 8.0, -6.0, -4.0, -4.0, 7.0, -9.0, -8.0)) && allOk;
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
	var[3][0] = (vec3(-8.0, 7.0, 8.0));
	var[3][1] = (vec3(8.0, 2.0, -9.0));
	var[3][2] = (vec3(-3.0, 6.0, -3.0));
	var[4][0] = (vec3(7.0, -3.0, 6.0));
	var[4][1] = (vec3(-7.0, 6.0, -7.0));
	var[4][2] = (vec3(2.0, 3.0, -3.0));
	var[5][0] = (vec3(-1.0, -5.0, -1.0));
	var[5][1] = (vec3(8.0, 4.0, -3.0));
	var[5][2] = (vec3(8.0, -6.0, 4.0));
	var[6][0] = (vec3(5.0, 9.0, -7.0));
	var[6][1] = (vec3(1.0, -3.0, -7.0));
	var[6][2] = (vec3(-5.0, 4.0, 1.0));
	var[7][0] = (vec3(-3.0, -5.0, -8.0));
	var[7][1] = (vec3(-5.0, 6.0, 2.0));
	var[7][2] = (vec3(-9.0, -9.0, -1.0));
	var[8][0] = (vec3(2.0, 8.0, -8.0));
	var[8][1] = (vec3(-6.0, 0.0, 3.0));
	var[8][2] = (vec3(9.0, -8.0, 3.0));
	var[9][0] = (vec3(-9.0, 9.0, 2.0));
	var[9][1] = (vec3(6.0, -4.0, -8.0));
	var[9][2] = (vec3(3.0, 8.0, 1.0));
	var[10][0] = (vec3(-9.0, -5.0, -7.0));
	var[10][1] = (vec3(-4.0, -1.0, -4.0));
	var[10][2] = (vec3(-6.0, 4.0, 9.0));
	var[11][0] = (vec3(-3.0, -9.0, 0.0));
	var[11][1] = (vec3(-9.0, -5.0, -9.0));
	var[11][2] = (vec3(-1.0, -9.0, 7.0));
	var[12][0] = (vec3(-4.0, 8.0, 7.0));
	var[12][1] = (vec3(1.0, 7.0, -5.0));
	var[12][2] = (vec3(7.0, 9.0, 4.0));
	var[13][0] = (vec3(-2.0, 2.0, 1.0));
	var[13][1] = (vec3(-8.0, -6.0, 7.0));
	var[13][2] = (vec3(-3.0, 2.0, -5.0));
	var[14][0] = (vec3(-6.0, 6.0, -7.0));
	var[14][1] = (vec3(1.0, 3.0, -7.0));
	var[14][2] = (vec3(6.0, -8.0, 4.0));
	var[15][0] = (vec3(-3.0, -8.0, 3.0));
	var[15][1] = (vec3(-5.0, -8.0, 8.0));
	var[15][2] = (vec3(7.0, 2.0, -3.0));
	var[16][0] = (vec3(3.0, -1.0, -6.0));
	var[16][1] = (vec3(-1.0, 6.0, 7.0));
	var[16][2] = (vec3(9.0, -1.0, 2.0));
	var[17][0] = (vec3(-9.0, -6.0, 9.0));
	var[17][1] = (vec3(4.0, 9.0, 5.0));
	var[17][2] = (vec3(5.0, 4.0, -9.0));
	var[18][0] = (vec3(3.0, 3.0, 8.0));
	var[18][1] = (vec3(1.0, -2.0, 0.0));
	var[18][2] = (vec3(-9.0, 5.0, 1.0));
}
#version 450
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
	highp mat2x3 var[];
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
	allOk = compare_mat2x3(var[3], mat2x3(0.0, -5.0, -8.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(8.0, 5.0, -3.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(-6.0, -2.0, 1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(1.0, 7.0, 8.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(-8.0, -9.0, -2.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(-5.0, -5.0, 6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(7.0, 0.0, 2.0, 4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(4.0, -9.0, 5.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(1.0, 5.0, -6.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(-8.0, -8.0, 8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(-5.0, 9.0, -6.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(4.0, 2.0, 6.0, 8.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(-3.0, 7.0, -7.0, -6.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(-6.0, -9.0, -2.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(8.0, -6.0, -6.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(9.0, -9.0, 3.0, -4.0, -3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(-7.0, -8.0, 7.0));
	var[0][1] = (vec3(-6.0, -3.0, -4.0));
	var[1][0] = (vec3(3.0, -8.0, -9.0));
	var[1][1] = (vec3(-2.0, 5.0, 6.0));
	var[2][0] = (vec3(6.0, -5.0, -7.0));
	var[2][1] = (vec3(1.0, 1.0, -3.0));
	var[3][0] = (vec3(9.0, -7.0, 2.0));
	var[3][1] = (vec3(5.0, -4.0, 6.0));
	var[4][0] = (vec3(-3.0, -8.0, 6.0));
	var[4][1] = (vec3(8.0, 2.0, 4.0));
	var[5][0] = (vec3(0.0, 8.0, 0.0));
	var[5][1] = (vec3(-2.0, 1.0, -3.0));
	var[6][0] = (vec3(-6.0, 3.0, 9.0));
	var[6][1] = (vec3(3.0, -2.0, -9.0));
	var[7][0] = (vec3(-7.0, -8.0, -6.0));
	var[7][1] = (vec3(-7.0, 2.0, -3.0));
	var[8][0] = (vec3(1.0, -1.0, 8.0));
	var[8][1] = (vec3(7.0, -2.0, -6.0));
	var[9][0] = (vec3(-1.0, -1.0, -5.0));
	var[9][1] = (vec3(-1.0, 1.0, -1.0));
	var[10][0] = (vec3(5.0, 5.0, -6.0));
	var[10][1] = (vec3(6.0, 7.0, -2.0));
	var[11][0] = (vec3(-5.0, -7.0, -1.0));
	var[11][1] = (vec3(4.0, -3.0, -7.0));
	var[12][0] = (vec3(5.0, 5.0, -4.0));
	var[12][1] = (vec3(1.0, -9.0, 1.0));
	var[13][0] = (vec3(3.0, 0.0, -6.0));
	var[13][1] = (vec3(5.0, -6.0, -6.0));
	var[14][0] = (vec3(7.0, 1.0, -9.0));
	var[14][1] = (vec3(7.0, -8.0, -1.0));
	var[15][0] = (vec3(5.0, -3.0, 9.0));
	var[15][1] = (vec3(-6.0, 4.0, -4.0));
	var[16][0] = (vec3(2.0, 5.0, 0.0));
	var[16][1] = (vec3(1.0, -8.0, 0.0));
	var[17][0] = (vec3(7.0, -2.0, -7.0));
	var[17][1] = (vec3(-6.0, -5.0, 3.0));
	var[18][0] = (vec3(1.0, -4.0, 2.0));
	var[18][1] = (vec3(0.0, 1.0, -8.0));
}
#version 450
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
	u8vec4 var[];
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(var[0]), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1]), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2]), uvec4(1u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3]), uvec4(7u, 7u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[4]), uvec4(3u, 3u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[5]), uvec4(7u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[6]), uvec4(6u, 9u, 5u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[7]), uvec4(5u, 2u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[8]), uvec4(8u, 3u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[9]), uvec4(5u, 7u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[10]), uvec4(5u, 8u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[11]), uvec4(8u, 6u, 3u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[12]), uvec4(6u, 5u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[13]), uvec4(8u, 7u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[14]), uvec4(9u, 5u, 6u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[15]), uvec4(7u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[16]), uvec4(1u, 0u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[17]), uvec4(1u, 3u, 8u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[18]), uvec4(1u, 4u, 1u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	var[1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	var[2] = u8vec4(uvec4(6u, 7u, 1u, 9u));
	var[3] = u8vec4(uvec4(8u, 9u, 3u, 3u));
	var[4] = u8vec4(uvec4(3u, 9u, 0u, 6u));
	var[5] = u8vec4(uvec4(8u, 7u, 6u, 7u));
	var[6] = u8vec4(uvec4(7u, 7u, 4u, 8u));
	var[7] = u8vec4(uvec4(8u, 5u, 3u, 1u));
	var[8] = u8vec4(uvec4(1u, 4u, 7u, 1u));
	var[9] = u8vec4(uvec4(3u, 6u, 3u, 3u));
	var[10] = u8vec4(uvec4(4u, 7u, 8u, 8u));
	var[11] = u8vec4(uvec4(1u, 7u, 7u, 2u));
	var[12] = u8vec4(uvec4(5u, 2u, 7u, 4u));
	var[13] = u8vec4(uvec4(8u, 9u, 1u, 4u));
	var[14] = u8vec4(uvec4(7u, 0u, 8u, 1u));
	var[15] = u8vec4(uvec4(0u, 4u, 9u, 9u));
	var[16] = u8vec4(uvec4(9u, 3u, 5u, 3u));
	var[17] = u8vec4(uvec4(1u, 4u, 3u, 3u));
	var[18] = u8vec4(uvec4(8u, 9u, 4u, 7u));
}
#version 450
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
	allOk = compare_mat3(var[0][0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(8.0, 3.0, 9.0));
	var[0][0][1] = (vec3(6.0, 2.0, -9.0));
	var[0][0][2] = (vec3(-8.0, 5.0, 2.0));
	var[0][1][0] = (vec3(3.0, -3.0, -4.0));
	var[0][1][1] = (vec3(2.0, -9.0, -5.0));
	var[0][1][2] = (vec3(5.0, 8.0, 8.0));
	var[0][2][0] = (vec3(-5.0, -3.0, -3.0));
	var[0][2][1] = (vec3(3.0, -5.0, -4.0));
	var[0][2][2] = (vec3(-7.0, 5.0, 3.0));
	var[1][0][0] = (vec3(-8.0, 7.0, 8.0));
	var[1][0][1] = (vec3(8.0, 2.0, -9.0));
	var[1][0][2] = (vec3(-3.0, 6.0, -3.0));
	var[1][1][0] = (vec3(7.0, -3.0, 6.0));
	var[1][1][1] = (vec3(-7.0, 6.0, -7.0));
	var[1][1][2] = (vec3(2.0, 3.0, -3.0));
	var[1][2][0] = (vec3(-1.0, -5.0, -1.0));
	var[1][2][1] = (vec3(8.0, 4.0, -3.0));
	var[1][2][2] = (vec3(8.0, -6.0, 4.0));
	var[2][0][0] = (vec3(5.0, 9.0, -7.0));
	var[2][0][1] = (vec3(1.0, -3.0, -7.0));
	var[2][0][2] = (vec3(-5.0, 4.0, 1.0));
	var[2][1][0] = (vec3(-3.0, -5.0, -8.0));
	var[2][1][1] = (vec3(-5.0, 6.0, 2.0));
	var[2][1][2] = (vec3(-9.0, -9.0, -1.0));
	var[2][2][0] = (vec3(2.0, 8.0, -8.0));
	var[2][2][1] = (vec3(-6.0, 0.0, 3.0));
	var[2][2][2] = (vec3(9.0, -8.0, 3.0));
	var[3][0][0] = (vec3(-9.0, 9.0, 2.0));
	var[3][0][1] = (vec3(6.0, -4.0, -8.0));
	var[3][0][2] = (vec3(3.0, 8.0, 1.0));
	var[3][1][0] = (vec3(-9.0, -5.0, -7.0));
	var[3][1][1] = (vec3(-4.0, -1.0, -4.0));
	var[3][1][2] = (vec3(-6.0, 4.0, 9.0));
	var[3][2][0] = (vec3(-3.0, -9.0, 0.0));
	var[3][2][1] = (vec3(-9.0, -5.0, -9.0));
	var[3][2][2] = (vec3(-1.0, -9.0, 7.0));
}
#version 450
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(0.0, -5.0, -8.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(8.0, 5.0, -3.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(-6.0, -2.0, 1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(1.0, 7.0, 8.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(-8.0, -9.0, -2.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(-5.0, -5.0, 6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(7.0, 0.0, 2.0, 4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(4.0, -9.0, 5.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(1.0, 5.0, -6.0, 4.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(-7.0, -8.0, 7.0));
	var[0][0][1] = (vec3(-6.0, -3.0, -4.0));
	var[0][1][0] = (vec3(3.0, -8.0, -9.0));
	var[0][1][1] = (vec3(-2.0, 5.0, 6.0));
	var[0][2][0] = (vec3(6.0, -5.0, -7.0));
	var[0][2][1] = (vec3(1.0, 1.0, -3.0));
	var[1][0][0] = (vec3(9.0, -7.0, 2.0));
	var[1][0][1] = (vec3(5.0, -4.0, 6.0));
	var[1][1][0] = (vec3(-3.0, -8.0, 6.0));
	var[1][1][1] = (vec3(8.0, 2.0, 4.0));
	var[1][2][0] = (vec3(0.0, 8.0, 0.0));
	var[1][2][1] = (vec3(-2.0, 1.0, -3.0));
	var[2][0][0] = (vec3(-6.0, 3.0, 9.0));
	var[2][0][1] = (vec3(3.0, -2.0, -9.0));
	var[2][1][0] = (vec3(-7.0, -8.0, -6.0));
	var[2][1][1] = (vec3(-7.0, 2.0, -3.0));
	var[2][2][0] = (vec3(1.0, -1.0, 8.0));
	var[2][2][1] = (vec3(7.0, -2.0, -6.0));
	var[3][0][0] = (vec3(-1.0, -1.0, -5.0));
	var[3][0][1] = (vec3(-1.0, 1.0, -1.0));
	var[3][1][0] = (vec3(5.0, 5.0, -6.0));
	var[3][1][1] = (vec3(6.0, 7.0, -2.0));
	var[3][2][0] = (vec3(-5.0, -7.0, -1.0));
	var[3][2][1] = (vec3(4.0, -3.0, -7.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
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
	float16_t var[4][3];
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(var[0][0]), -7.0) && allOk;
	allOk = compare_float16_t(float(var[0][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[0][2]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[1][0]), 0.0) && allOk;
	allOk = compare_float16_t(float(var[1][1]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[1][2]), 9.0) && allOk;
	allOk = compare_float16_t(float(var[2][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[2][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[2][2]), 7.0) && allOk;
	allOk = compare_float16_t(float(var[3][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[3][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[3][2]), -3.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = float16_t(-8.0);
	var[0][1] = float16_t(9.0);
	var[0][2] = float16_t(-2.0);
	var[1][0] = float16_t(7.0);
	var[1][1] = float16_t(8.0);
	var[1][2] = float16_t(-9.0);
	var[2][0] = float16_t(2.0);
	var[2][1] = float16_t(-8.0);
	var[2][2] = float16_t(-1.0);
	var[3][0] = float16_t(6.0);
	var[3][1] = float16_t(-7.0);
	var[3][2] = float16_t(-5.0);
}
#version 450
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
	highp uvec3 var[4][3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 9u) && allOk;
	allOk = compare_uvec3((var[0][0]), uvec3(6u, 4u, 7u)) && allOk;
	allOk = compare_uvec3((var[0][1]), uvec3(2u, 7u, 5u)) && allOk;
	allOk = compare_uvec3((var[0][2]), uvec3(0u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((var[1][0]), uvec3(8u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((var[1][1]), uvec3(5u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((var[1][2]), uvec3(2u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((var[2][0]), uvec3(1u, 7u, 1u)) && allOk;
	allOk = compare_uvec3((var[2][1]), uvec3(5u, 4u, 0u)) && allOk;
	allOk = compare_uvec3((var[2][2]), uvec3(4u, 3u, 1u)) && allOk;
	allOk = compare_uvec3((var[3][0]), uvec3(4u, 3u, 8u)) && allOk;
	allOk = compare_uvec3((var[3][1]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_uvec3((var[3][2]), uvec3(2u, 6u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3u);
	var[0][0] = (uvec3(5u, 6u, 5u));
	var[0][1] = (uvec3(4u, 5u, 4u));
	var[0][2] = (uvec3(9u, 4u, 4u));
	var[1][0] = (uvec3(7u, 7u, 0u));
	var[1][1] = (uvec3(2u, 9u, 4u));
	var[1][2] = (uvec3(7u, 8u, 9u));
	var[2][0] = (uvec3(4u, 3u, 5u));
	var[2][1] = (uvec3(8u, 0u, 5u));
	var[2][2] = (uvec3(4u, 6u, 7u));
	var[3][0] = (uvec3(7u, 5u, 3u));
	var[3][1] = (uvec3(7u, 0u, 8u));
	var[3][2] = (uvec3(1u, 2u, 1u));
}
#version 450
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
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat2x4(var[0][0], mat2x4(-2.0, 1.0, -1.0, 0.0, 3.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(1.0, 1.0, 2.0, -9.0, -1.0, 3.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(2.0, -6.0, 0.0, -3.0, 1.0, -8.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(0.0, -9.0, -1.0, 7.0, -3.0, -7.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(9.0, 6.0, -6.0, 8.0, 4.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(5.0, -3.0, -4.0, 4.0, 0.0, -3.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-2.0, 9.0, -9.0, -7.0, -5.0, 8.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(2.0, 3.0, 3.0, -9.0, 5.0, 0.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(-5.0, 2.0, 6.0, 6.0, 1.0, 0.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(4.0, -5.0, 1.0, 5.0, 3.0, 4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(-1.0, 1.0, 7.0, 0.0, 0.0, 0.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(3.0, -7.0, 6.0, 1.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0][0] = (vec4(-1.0, -8.0, 7.0, 5.0));
	var[0][0][1] = (vec4(1.0, 7.0, 1.0, -7.0));
	var[0][1][0] = (vec4(7.0, -4.0, 8.0, -2.0));
	var[0][1][1] = (vec4(2.0, -1.0, 4.0, 2.0));
	var[0][2][0] = (vec4(1.0, 0.0, -4.0, 1.0));
	var[0][2][1] = (vec4(5.0, -2.0, 1.0, 0.0));
	var[1][0][0] = (vec4(9.0, -1.0, -7.0, -7.0));
	var[1][0][1] = (vec4(5.0, -3.0, 3.0, 1.0));
	var[1][1][0] = (vec4(7.0, 6.0, 7.0, -4.0));
	var[1][1][1] = (vec4(9.0, -1.0, 8.0, -4.0));
	var[1][2][0] = (vec4(4.0, -1.0, -9.0, 3.0));
	var[1][2][1] = (vec4(2.0, -4.0, 6.0, 0.0));
	var[2][0][0] = (vec4(-6.0, 8.0, -9.0, -3.0));
	var[2][0][1] = (vec4(-3.0, -2.0, 3.0, -9.0));
	var[2][1][0] = (vec4(4.0, 7.0, -7.0, 7.0));
	var[2][1][1] = (vec4(3.0, -2.0, 6.0, 5.0));
	var[2][2][0] = (vec4(-4.0, -3.0, -2.0, 4.0));
	var[2][2][1] = (vec4(2.0, 7.0, -9.0, -3.0));
	var[3][0][0] = (vec4(-1.0, -1.0, 6.0, -8.0));
	var[3][0][1] = (vec4(-8.0, -4.0, 6.0, -4.0));
	var[3][1][0] = (vec4(-2.0, 4.0, -8.0, 6.0));
	var[3][1][1] = (vec4(-2.0, -8.0, 4.0, 4.0));
	var[3][2][0] = (vec4(4.0, 0.0, -9.0, 1.0));
	var[3][2][1] = (vec4(-8.0, 8.0, -8.0, -4.0));
}
#version 450
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
	highp int var[4][2][3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var[0][0][0]), 6) && allOk;
	allOk = compare_int((var[0][0][1]), 0) && allOk;
	allOk = compare_int((var[0][0][2]), 9) && allOk;
	allOk = compare_int((var[0][1][0]), 5) && allOk;
	allOk = compare_int((var[0][1][1]), -3) && allOk;
	allOk = compare_int((var[0][1][2]), 4) && allOk;
	allOk = compare_int((var[1][0][0]), -6) && allOk;
	allOk = compare_int((var[1][0][1]), -9) && allOk;
	allOk = compare_int((var[1][0][2]), -8) && allOk;
	allOk = compare_int((var[1][1][0]), 4) && allOk;
	allOk = compare_int((var[1][1][1]), -9) && allOk;
	allOk = compare_int((var[1][1][2]), -9) && allOk;
	allOk = compare_int((var[2][0][0]), 8) && allOk;
	allOk = compare_int((var[2][0][1]), -9) && allOk;
	allOk = compare_int((var[2][0][2]), -1) && allOk;
	allOk = compare_int((var[2][1][0]), 3) && allOk;
	allOk = compare_int((var[2][1][1]), -1) && allOk;
	allOk = compare_int((var[2][1][2]), -9) && allOk;
	allOk = compare_int((var[3][0][0]), 0) && allOk;
	allOk = compare_int((var[3][0][1]), -9) && allOk;
	allOk = compare_int((var[3][0][2]), 5) && allOk;
	allOk = compare_int((var[3][1][0]), -7) && allOk;
	allOk = compare_int((var[3][1][1]), 9) && allOk;
	allOk = compare_int((var[3][1][2]), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (8);
	var[0][0][1] = (2);
	var[0][0][2] = (-5);
	var[0][1][0] = (-4);
	var[0][1][1] = (9);
	var[0][1][2] = (-8);
	var[1][0][0] = (0);
	var[1][0][1] = (-7);
	var[1][0][2] = (-7);
	var[1][1][0] = (4);
	var[1][1][1] = (-4);
	var[1][1][2] = (5);
	var[2][0][0] = (-8);
	var[2][0][1] = (6);
	var[2][0][2] = (-6);
	var[2][1][0] = (-3);
	var[2][1][1] = (-3);
	var[2][1][2] = (6);
	var[3][0][0] = (6);
	var[3][0][1] = (-5);
	var[3][0][2] = (5);
	var[3][1][0] = (-2);
	var[3][1][1] = (5);
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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat2x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-8.0, -8.0, 8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-5.0, 9.0, -6.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(4.0, 2.0, 6.0, 8.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(0.0, -5.0, -8.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(8.0, 5.0, -3.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(-6.0, -2.0, 1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-3.0, 7.0, -7.0, -6.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-6.0, -9.0, -2.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(8.0, -6.0, -6.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(1.0, 7.0, 8.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(-8.0, -9.0, -2.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(-5.0, -5.0, 6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(9.0, -9.0, 3.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-6.0, 0.0, -2.0, 2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(-1.0, -5.0, 0.0, -2.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(7.0, 0.0, 2.0, 4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(4.0, -9.0, 5.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(1.0, 5.0, -6.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(1.0, -6.0, -2.0, -1.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(-2.0, 3.0, 0.0, -6.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(0.0, 5.0, 8.0, -1.0, 9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(-7.0, -8.0, 7.0));
	var[0][0][0][1] = (vec3(-6.0, -3.0, -4.0));
	var[0][0][1][0] = (vec3(3.0, -8.0, -9.0));
	var[0][0][1][1] = (vec3(-2.0, 5.0, 6.0));
	var[0][0][2][0] = (vec3(6.0, -5.0, -7.0));
	var[0][0][2][1] = (vec3(1.0, 1.0, -3.0));
	var[0][1][0][0] = (vec3(5.0, 5.0, -4.0));
	var[0][1][0][1] = (vec3(1.0, -9.0, 1.0));
	var[0][1][1][0] = (vec3(3.0, 0.0, -6.0));
	var[0][1][1][1] = (vec3(5.0, -6.0, -6.0));
	var[0][1][2][0] = (vec3(7.0, 1.0, -9.0));
	var[0][1][2][1] = (vec3(7.0, -8.0, -1.0));
	var[1][0][0][0] = (vec3(9.0, -7.0, 2.0));
	var[1][0][0][1] = (vec3(5.0, -4.0, 6.0));
	var[1][0][1][0] = (vec3(-3.0, -8.0, 6.0));
	var[1][0][1][1] = (vec3(8.0, 2.0, 4.0));
	var[1][0][2][0] = (vec3(0.0, 8.0, 0.0));
	var[1][0][2][1] = (vec3(-2.0, 1.0, -3.0));
	var[1][1][0][0] = (vec3(5.0, -3.0, 9.0));
	var[1][1][0][1] = (vec3(-6.0, 4.0, -4.0));
	var[1][1][1][0] = (vec3(2.0, 5.0, 0.0));
	var[1][1][1][1] = (vec3(1.0, -8.0, 0.0));
	var[1][1][2][0] = (vec3(7.0, -2.0, -7.0));
	var[1][1][2][1] = (vec3(-6.0, -5.0, 3.0));
	var[2][0][0][0] = (vec3(-6.0, 3.0, 9.0));
	var[2][0][0][1] = (vec3(3.0, -2.0, -9.0));
	var[2][0][1][0] = (vec3(-7.0, -8.0, -6.0));
	var[2][0][1][1] = (vec3(-7.0, 2.0, -3.0));
	var[2][0][2][0] = (vec3(1.0, -1.0, 8.0));
	var[2][0][2][1] = (vec3(7.0, -2.0, -6.0));
	var[2][1][0][0] = (vec3(1.0, -4.0, 2.0));
	var[2][1][0][1] = (vec3(0.0, 1.0, -8.0));
	var[2][1][1][0] = (vec3(-3.0, -9.0, 6.0));
	var[2][1][1][1] = (vec3(-3.0, 6.0, 6.0));
	var[2][1][2][0] = (vec3(-6.0, 1.0, 4.0));
	var[2][1][2][1] = (vec3(7.0, 9.0, -9.0));
	var[3][0][0][0] = (vec3(-1.0, -1.0, -5.0));
	var[3][0][0][1] = (vec3(-1.0, 1.0, -1.0));
	var[3][0][1][0] = (vec3(5.0, 5.0, -6.0));
	var[3][0][1][1] = (vec3(6.0, 7.0, -2.0));
	var[3][0][2][0] = (vec3(-5.0, -7.0, -1.0));
	var[3][0][2][1] = (vec3(4.0, -3.0, -7.0));
	var[3][1][0][0] = (vec3(-1.0, -8.0, 8.0));
	var[3][1][0][1] = (vec3(7.0, 1.0, -4.0));
	var[3][1][1][0] = (vec3(-3.0, 5.0, -5.0));
	var[3][1][1][1] = (vec3(4.0, 1.0, 9.0));
	var[3][1][2][0] = (vec3(3.0, -8.0, 6.0));
	var[3][1][2][1] = (vec3(-7.0, -7.0, -1.0));
}
#version 450
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
	highp mat2x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-9.0, 2.0, -4.0, -7.0, -8.0, -5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(0.0, 5.0, 4.0, -5.0, 1.0, -3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-2.0, -8.0, -5.0, -3.0, -6.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(2.0, -8.0, -6.0, -8.0, 7.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(4.0, 5.0, 0.0, 5.0, -4.0, -9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-9.0, 3.0, -9.0, 0.0, 2.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(4.0, -5.0, -6.0, -5.0, 5.0, 1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(6.0, -6.0, -1.0, -2.0, -4.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(-1.0, 6.0, -6.0, 3.0, -7.0, -1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(-8.0, -4.0, -7.0, -3.0, -8.0, -2.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(0.0, 8.0, 9.0, -5.0, -4.0, -9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(9.0, -2.0, -5.0, 3.0, 7.0, -8.0, -6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	var[0][0][1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	var[0][0][2] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
	var[0][1][0] = (mat2x4(7.0, -5.0, -6.0, -8.0, -5.0, 3.0, -4.0, -5.0));
	var[0][1][1] = (mat2x4(-3.0, -5.0, 7.0, -7.0, 7.0, 8.0, 6.0, 7.0));
	var[0][1][2] = (mat2x4(-8.0, 2.0, 0.0, 3.0, 7.0, 9.0, 3.0, 0.0));
	var[1][0][0] = (mat2x4(-7.0, -4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0));
	var[1][0][1] = (mat2x4(0.0, -4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0));
	var[1][0][2] = (mat2x4(3.0, -8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0));
	var[1][1][0] = (mat2x4(-9.0, 1.0, -3.0, 3.0, 2.0, 9.0, -5.0, 3.0));
	var[1][1][1] = (mat2x4(4.0, 1.0, 6.0, 5.0, 6.0, -8.0, 9.0, -8.0));
	var[1][1][2] = (mat2x4(-6.0, -7.0, 0.0, -1.0, -3.0, -5.0, -4.0, 3.0));
	var[2][0][0] = (mat2x4(4.0, -7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0));
	var[2][0][1] = (mat2x4(-2.0, 1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0));
	var[2][0][2] = (mat2x4(-8.0, 7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0));
	var[2][1][0] = (mat2x4(-7.0, -3.0, -2.0, -2.0, -6.0, -7.0, 1.0, 6.0));
	var[2][1][1] = (mat2x4(0.0, 7.0, 8.0, 8.0, 2.0, -2.0, 6.0, -8.0));
	var[2][1][2] = (mat2x4(5.0, -2.0, 5.0, -9.0, -1.0, 4.0, 6.0, 1.0));
	var[3][0][0] = (mat2x4(2.0, 9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0));
	var[3][0][1] = (mat2x4(5.0, -9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0));
	var[3][0][2] = (mat2x4(-6.0, -9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0));
	var[3][1][0] = (mat2x4(6.0, -8.0, 1.0, -8.0, -1.0, 0.0, -1.0, 9.0));
	var[3][1][1] = (mat2x4(-7.0, 0.0, 8.0, 0.0, -6.0, 3.0, -9.0, -7.0));
	var[3][1][2] = (mat2x4(0.0, 2.0, -7.0, -2.0, -3.0, 9.0, 7.0, 7.0));
}
#version 450
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
	highp mat3x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(2.0, -3.0, -1.0, -7.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(1.0, -2.0, -2.0, -2.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(0.0, -1.0, 1.0, 9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(8.0, -7.0, 1.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(4.0, -3.0, -4.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(8.0, 4.0, 1.0, 2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-9.0, 7.0, -7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(7.0, 4.0, 0.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(-3.0, 3.0, -7.0, -9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(6.0, 6.0, -8.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(-9.0, -8.0, -5.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(-7.0, -9.0, 9.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(7.0, 5.0, -6.0, -4.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-5.0, -3.0, -9.0, 2.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(5.0, 2.0, 7.0, -1.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(8.0, -7.0, 7.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(2.0, -1.0, 5.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-7.0, -5.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(9.0, 7.0, -8.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(-9.0, -8.0, 9.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(7.0, -7.0, -2.0, 2.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(-2.0, 8.0));
	var[0][0][0][1] = (vec2(1.0, 8.0));
	var[0][0][0][2] = (vec2(-7.0, 5.0));
	var[0][0][1][0] = (vec2(2.0, 0.0));
	var[0][0][1][1] = (vec2(-3.0, 1.0));
	var[0][0][1][2] = (vec2(2.0, -5.0));
	var[0][0][2][0] = (vec2(6.0, 3.0));
	var[0][0][2][1] = (vec2(6.0, 5.0));
	var[0][0][2][2] = (vec2(-5.0, 9.0));
	var[0][1][0][0] = (vec2(2.0, -2.0));
	var[0][1][0][1] = (vec2(-2.0, -8.0));
	var[0][1][0][2] = (vec2(7.0, -7.0));
	var[0][1][1][0] = (vec2(-1.0, 6.0));
	var[0][1][1][1] = (vec2(-8.0, 4.0));
	var[0][1][1][2] = (vec2(-5.0, 3.0));
	var[0][1][2][0] = (vec2(-9.0, -8.0));
	var[0][1][2][1] = (vec2(8.0, -9.0));
	var[0][1][2][2] = (vec2(-1.0, 1.0));
	var[1][0][0][0] = (vec2(-8.0, 9.0));
	var[1][0][0][1] = (vec2(3.0, -3.0));
	var[1][0][0][2] = (vec2(3.0, -5.0));
	var[1][0][1][0] = (vec2(7.0, -8.0));
	var[1][0][1][1] = (vec2(3.0, 1.0));
	var[1][0][1][2] = (vec2(-2.0, 1.0));
	var[1][0][2][0] = (vec2(4.0, -9.0));
	var[1][0][2][1] = (vec2(3.0, 6.0));
	var[1][0][2][2] = (vec2(7.0, 1.0));
	var[1][1][0][0] = (vec2(0.0, 2.0));
	var[1][1][0][1] = (vec2(-1.0, -9.0));
	var[1][1][0][2] = (vec2(3.0, 4.0));
	var[1][1][1][0] = (vec2(6.0, -1.0));
	var[1][1][1][1] = (vec2(-4.0, -4.0));
	var[1][1][1][2] = (vec2(0.0, -6.0));
	var[1][1][2][0] = (vec2(5.0, -8.0));
	var[1][1][2][1] = (vec2(6.0, -8.0));
	var[1][1][2][2] = (vec2(-5.0, -8.0));
	var[2][0][0][0] = (vec2(9.0, -9.0));
	var[2][0][0][1] = (vec2(0.0, -6.0));
	var[2][0][0][2] = (vec2(-7.0, 7.0));
	var[2][0][1][0] = (vec2(-8.0, 7.0));
	var[2][0][1][1] = (vec2(9.0, 6.0));
	var[2][0][1][2] = (vec2(-1.0, 0.0));
	var[2][0][2][0] = (vec2(-3.0, 6.0));
	var[2][0][2][1] = (vec2(-1.0, -6.0));
	var[2][0][2][2] = (vec2(-1.0, -3.0));
	var[2][1][0][0] = (vec2(4.0, -9.0));
	var[2][1][0][1] = (vec2(-4.0, 4.0));
	var[2][1][0][2] = (vec2(5.0, 3.0));
	var[2][1][1][0] = (vec2(-3.0, -5.0));
	var[2][1][1][1] = (vec2(5.0, 1.0));
	var[2][1][1][2] = (vec2(3.0, -3.0));
	var[2][1][2][0] = (vec2(-1.0, -6.0));
	var[2][1][2][1] = (vec2(-6.0, 8.0));
	var[2][1][2][2] = (vec2(-3.0, 7.0));
	var[3][0][0][0] = (vec2(0.0, -1.0));
	var[3][0][0][1] = (vec2(4.0, -9.0));
	var[3][0][0][2] = (vec2(1.0, 1.0));
	var[3][0][1][0] = (vec2(-9.0, 7.0));
	var[3][0][1][1] = (vec2(0.0, 4.0));
	var[3][0][1][2] = (vec2(-3.0, -3.0));
	var[3][0][2][0] = (vec2(6.0, 8.0));
	var[3][0][2][1] = (vec2(-7.0, 5.0));
	var[3][0][2][2] = (vec2(-6.0, -5.0));
	var[3][1][0][0] = (vec2(-6.0, 6.0));
	var[3][1][0][1] = (vec2(6.0, 7.0));
	var[3][1][0][2] = (vec2(3.0, -9.0));
	var[3][1][1][0] = (vec2(-4.0, -6.0));
	var[3][1][1][1] = (vec2(-6.0, 2.0));
	var[3][1][1][2] = (vec2(6.0, -3.0));
	var[3][1][2][0] = (vec2(-1.0, -9.0));
	var[3][1][2][1] = (vec2(8.0, -4.0));
	var[3][1][2][2] = (vec2(-9.0, -4.0));
}
#version 450
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
	uint8_t var[4][2][3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(var[0][0][0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[0][0][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[0][0][2]), 3u) && allOk;
	allOk = compare_uint8_t(uint(var[0][1][0]), 6u) && allOk;
	allOk = compare_uint8_t(uint(var[0][1][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[0][1][2]), 5u) && allOk;
	allOk = compare_uint8_t(uint(var[1][0][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[1][0][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[1][0][2]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[1][1][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[1][1][1]), 8u) && allOk;
	allOk = compare_uint8_t(uint(var[1][1][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[2][0][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[2][0][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[2][0][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[2][1][0]), 3u) && allOk;
	allOk = compare_uint8_t(uint(var[2][1][1]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[2][1][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[3][0][0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[3][0][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[3][0][2]), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[3][1][0]), 0u) && allOk;
	allOk = compare_uint8_t(uint(var[3][1][1]), 6u) && allOk;
	allOk = compare_uint8_t(uint(var[3][1][2]), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = uint8_t(9u);
	var[0][0][1] = uint8_t(5u);
	var[0][0][2] = uint8_t(2u);
	var[0][1][0] = uint8_t(6u);
	var[0][1][1] = uint8_t(0u);
	var[0][1][2] = uint8_t(5u);
	var[1][0][0] = uint8_t(6u);
	var[1][0][1] = uint8_t(7u);
	var[1][0][2] = uint8_t(5u);
	var[1][1][0] = uint8_t(4u);
	var[1][1][1] = uint8_t(1u);
	var[1][1][2] = uint8_t(3u);
	var[2][0][0] = uint8_t(8u);
	var[2][0][1] = uint8_t(4u);
	var[2][0][2] = uint8_t(2u);
	var[2][1][0] = uint8_t(0u);
	var[2][1][1] = uint8_t(3u);
	var[2][1][2] = uint8_t(3u);
	var[3][0][0] = uint8_t(6u);
	var[3][0][1] = uint8_t(0u);
	var[3][0][2] = uint8_t(1u);
	var[3][1][0] = uint8_t(3u);
	var[3][1][1] = uint8_t(3u);
	var[3][1][2] = uint8_t(3u);
}
#version 450
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
	highp uint var[][4][2];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var[0][0][0]), 3u) && allOk;
	allOk = compare_uint((var[0][0][1]), 6u) && allOk;
	allOk = compare_uint((var[0][1][0]), 6u) && allOk;
	allOk = compare_uint((var[0][1][1]), 4u) && allOk;
	allOk = compare_uint((var[0][2][0]), 7u) && allOk;
	allOk = compare_uint((var[0][2][1]), 8u) && allOk;
	allOk = compare_uint((var[0][3][0]), 4u) && allOk;
	allOk = compare_uint((var[0][3][1]), 8u) && allOk;
	allOk = compare_uint((var[1][0][0]), 9u) && allOk;
	allOk = compare_uint((var[1][0][1]), 0u) && allOk;
	allOk = compare_uint((var[1][1][0]), 2u) && allOk;
	allOk = compare_uint((var[1][1][1]), 5u) && allOk;
	allOk = compare_uint((var[1][2][0]), 6u) && allOk;
	allOk = compare_uint((var[1][2][1]), 9u) && allOk;
	allOk = compare_uint((var[1][3][0]), 7u) && allOk;
	allOk = compare_uint((var[1][3][1]), 9u) && allOk;
	allOk = compare_uint((var[2][0][0]), 3u) && allOk;
	allOk = compare_uint((var[2][0][1]), 7u) && allOk;
	allOk = compare_uint((var[2][1][0]), 7u) && allOk;
	allOk = compare_uint((var[2][1][1]), 5u) && allOk;
	allOk = compare_uint((var[2][2][0]), 0u) && allOk;
	allOk = compare_uint((var[2][2][1]), 1u) && allOk;
	allOk = compare_uint((var[2][3][0]), 7u) && allOk;
	allOk = compare_uint((var[2][3][1]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (7u);
	var[0][0][1] = (9u);
	var[0][1][0] = (4u);
	var[0][1][1] = (8u);
	var[0][2][0] = (7u);
	var[0][2][1] = (8u);
	var[0][3][0] = (6u);
	var[0][3][1] = (8u);
	var[1][0][0] = (1u);
	var[1][0][1] = (0u);
	var[1][1][0] = (7u);
	var[1][1][1] = (5u);
	var[1][2][0] = (6u);
	var[1][2][1] = (1u);
	var[1][3][0] = (6u);
	var[1][3][1] = (2u);
	var[2][0][0] = (7u);
	var[2][0][1] = (7u);
	var[2][1][0] = (7u);
	var[2][1][1] = (2u);
	var[2][2][0] = (9u);
	var[2][2][1] = (8u);
	var[2][3][0] = (5u);
	var[2][3][1] = (3u);
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	uint16_t var[][4][2];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(var[0][0][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[0][0][1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(var[0][1][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[0][1][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[0][2][0]), 7u) && allOk;
	allOk = compare_uint16_t(uint(var[0][2][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[0][3][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[0][3][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[1][0][0]), 4u) && allOk;
	allOk = compare_uint16_t(uint(var[1][0][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[1][1][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[1][1][1]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[1][2][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[1][2][1]), 7u) && allOk;
	allOk = compare_uint16_t(uint(var[1][3][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[1][3][1]), 4u) && allOk;
	allOk = compare_uint16_t(uint(var[2][0][0]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[2][0][1]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[2][1][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[2][1][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[2][2][0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[2][2][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[2][3][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[2][3][1]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = uint16_t(9u);
	var[0][0][1] = uint16_t(1u);
	var[0][1][0] = uint16_t(8u);
	var[0][1][1] = uint16_t(1u);
	var[0][2][0] = uint16_t(3u);
	var[0][2][1] = uint16_t(1u);
	var[0][3][0] = uint16_t(2u);
	var[0][3][1] = uint16_t(9u);
	var[1][0][0] = uint16_t(1u);
	var[1][0][1] = uint16_t(0u);
	var[1][1][0] = uint16_t(9u);
	var[1][1][1] = uint16_t(7u);
	var[1][2][0] = uint16_t(0u);
	var[1][2][1] = uint16_t(2u);
	var[1][3][0] = uint16_t(3u);
	var[1][3][1] = uint16_t(0u);
	var[2][0][0] = uint16_t(7u);
	var[2][0][1] = uint16_t(5u);
	var[2][1][0] = uint16_t(2u);
	var[2][1][1] = uint16_t(6u);
	var[2][2][0] = uint16_t(1u);
	var[2][2][1] = uint16_t(1u);
	var[2][3][0] = uint16_t(8u);
	var[2][3][1] = uint16_t(4u);
}
#version 450
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
	f16vec2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(var[0][0][0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][0][1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][1][0]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][1][1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][2][0]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][2][1]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][3][0]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][3][1]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][0][0]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][0][1]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][1][0]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][1][1]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][2][0]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][2][1]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][3][0]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][3][1]), vec2(-3.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][0][0]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][0][1]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][1][0]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][1][1]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][2][0]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][2][1]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][3][0]), vec2(0.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][3][1]), vec2(3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = f16vec2(vec2(-2.0, 4.0));
	var[0][0][1] = f16vec2(vec2(-2.0, 4.0));
	var[0][1][0] = f16vec2(vec2(2.0, 2.0));
	var[0][1][1] = f16vec2(vec2(-6.0, 5.0));
	var[0][2][0] = f16vec2(vec2(6.0, 0.0));
	var[0][2][1] = f16vec2(vec2(3.0, 5.0));
	var[0][3][0] = f16vec2(vec2(7.0, -6.0));
	var[0][3][1] = f16vec2(vec2(-2.0, -4.0));
	var[1][0][0] = f16vec2(vec2(-1.0, 1.0));
	var[1][0][1] = f16vec2(vec2(9.0, 4.0));
	var[1][1][0] = f16vec2(vec2(5.0, -7.0));
	var[1][1][1] = f16vec2(vec2(3.0, 0.0));
	var[1][2][0] = f16vec2(vec2(9.0, -9.0));
	var[1][2][1] = f16vec2(vec2(-6.0, 7.0));
	var[1][3][0] = f16vec2(vec2(5.0, -2.0));
	var[1][3][1] = f16vec2(vec2(5.0, 2.0));
	var[2][0][0] = f16vec2(vec2(8.0, -8.0));
	var[2][0][1] = f16vec2(vec2(1.0, -3.0));
	var[2][1][0] = f16vec2(vec2(-2.0, 3.0));
	var[2][1][1] = f16vec2(vec2(-6.0, 5.0));
	var[2][2][0] = f16vec2(vec2(3.0, -7.0));
	var[2][2][1] = f16vec2(vec2(4.0, -5.0));
	var[2][3][0] = f16vec2(vec2(8.0, -7.0));
	var[2][3][1] = f16vec2(vec2(3.0, -7.0));
}
#version 450
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
layout(std140, binding = 1) buffer Block
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
	allOk = compare_mat3(t[0].a, mat3(-7.0, 5.0, -5.0, 5.0, 3.0, 0.0, -3.0, 5.0, -2.0)) && allOk;
	allOk = compare_ivec3((t[0].b[0].a), ivec3(-7, -9, 2)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[0]), ivec2(5, 8)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[1]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[2]), ivec2(-7, 3)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[3]), ivec2(4, 6)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(-8.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_ivec3((t[0].b[1].a), ivec3(3, 4, -1)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[0]), ivec2(4, -8)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[1]), ivec2(8, 7)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[2]), ivec2(0, 5)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[3]), ivec2(0, 7)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(2.0, -7.0, 2.0, -3.0)) && allOk;
	allOk = compare_ivec3((t[0].b[2].a), ivec3(-4, -6, 6)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[0]), ivec2(8, 9)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[1]), ivec2(-9, 6)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[2]), ivec2(-8, 1)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[3]), ivec2(2, -6)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(-2.0, 1.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3(t[1].a, mat3(-5.0, -5.0, -4.0, -5.0, 7.0, -4.0, -9.0, 3.0, -7.0)) && allOk;
	allOk = compare_ivec3((t[1].b[0].a), ivec3(-1, 9, 0)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[0]), ivec2(-9, 1)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[1]), ivec2(1, -7)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[2]), ivec2(6, 1)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[3]), ivec2(6, -2)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-3.0, 8.0, -4.0, 7.0)) && allOk;
	allOk = compare_ivec3((t[1].b[1].a), ivec3(-1, -3, 4)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[0]), ivec2(-7, 9)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[1]), ivec2(2, -2)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[2]), ivec2(-5, -7)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[3]), ivec2(-4, -9)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(-6.0, -8.0, 2.0, -2.0)) && allOk;
	allOk = compare_ivec3((t[1].b[2].a), ivec3(2, 3, 7)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[0]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[1]), ivec2(3, -2)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[2]), ivec2(-4, -4)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[3]), ivec2(8, -9)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(6.0, -3.0, 8.0, 2.0)) && allOk;
	allOk = compare_uint((u), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(-6, -2, 3));
	s.b[0] = (ivec2(4, 0));
	s.b[1] = (ivec2(-1, -9));
	s.b[2] = (ivec2(-8, 0));
	s.b[3] = (ivec2(7, 2));
	s.c = (vec4(7.0, -7.0, 5.0, 1.0));
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
} block[3];

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
layout(std430, binding = 1) buffer Block
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
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(0, -2, -5)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(-8.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(-2, -1, 5)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(-3.0, 5.0, -1.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(-5, -1, 1)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(0.0, -7.0, 3.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(-4, -8, 1)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(-1.0, 6.0, -6.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(1, -8, -9)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-2.0, 3.0, 5.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(5, 3, -1)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(5.0, 2.0, 0.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(-7, 8, -1)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(-5.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(-9, 7, 0)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(1.0, -9.0, -1.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(-7, -4, 5)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(-2.0, -7.0, 5.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(0, 2, 7)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-9.0, -1.0, 2.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(-9, -3, -9)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(1.0, 2.0, 6.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(-4, -5, 3)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(-1.0, -3.0, -3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(-4.0, 7.0, 5.0, 3.0));
	block[0].s[0][0].a = (ivec3(-9, -1, 5));
	block[0].s[0][0].c = (vec4(-6.0, -1.0, 4.0, 9.0));
	block[0].s[0][1].a = (ivec3(8, 2, -2));
	block[0].s[0][1].c = (vec4(-4.0, 6.0, 8.0, -8.0));
	block[0].s[1][0].a = (ivec3(9, -5, 5));
	block[0].s[1][0].c = (vec4(-7.0, -5.0, -1.0, 5.0));
	block[0].s[1][1].a = (ivec3(-9, -2, 1));
	block[0].s[1][1].c = (vec4(4.0, 0.0, 5.0, 3.0));
	block[0].s[2][0].a = (ivec3(7, -1, -8));
	block[0].s[2][0].c = (vec4(9.0, -8.0, 6.0, -9.0));
	block[0].s[2][1].a = (ivec3(2, -1, 5));
	block[0].s[2][1].c = (vec4(3.0, 7.0, -2.0, -3.0));
	block[1].v = (vec4(-8.0, 9.0, 4.0, -6.0));
	block[1].s[0][0].a = (ivec3(1, -4, -2));
	block[1].s[0][0].c = (vec4(-7.0, 7.0, 5.0, 2.0));
	block[1].s[0][1].a = (ivec3(6, -6, 5));
	block[1].s[0][1].c = (vec4(5.0, 4.0, -7.0, -5.0));
	block[1].s[1][0].a = (ivec3(9, 6, -3));
	block[1].s[1][0].c = (vec4(-7.0, 6.0, 1.0, 3.0));
	block[1].s[1][1].a = (ivec3(-6, 3, 5));
	block[1].s[1][1].c = (vec4(6.0, -2.0, 8.0, -4.0));
	block[2].v = (vec4(7.0, -9.0, 9.0, 8.0));
	block[2].s[0][0].a = (ivec3(-9, 6, 0));
	block[2].s[0][0].c = (vec4(0.0, 7.0, 1.0, -9.0));
	block[2].s[0][1].a = (ivec3(-1, -3, 1));
	block[2].s[0][1].c = (vec4(9.0, 0.0, 9.0, 7.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 8.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-4.0, 3.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-8.0, 8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -5.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(4.0, -5.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 4.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2(2.0, 4.0, 4.0, -1.0));
	block[1].var = (mat2(2.0, -5.0, 1.0, -1.0));
	block[2].var = (mat2(-2.0, -9.0, -3.0, -8.0));
}
#version 450
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
	highp mat2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -1.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-7.0, -9.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-7.0, -1.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -6.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(8.0, 9.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(8.0, -6.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -8.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(8.0, -6.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(7.0, -3.0));
	block[0].var[1] = (vec2(-2.0, 4.0));
	block[1].var[0] = (vec2(1.0, -3.0));
	block[1].var[1] = (vec2(2.0, -4.0));
	block[2].var[0] = (vec2(-1.0, 1.0));
	block[2].var[1] = (vec2(-4.0, 3.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 6.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 8.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-4.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(3.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(-9.0, -8.0, 8.0)) && allOk;
	allOk = compare_float((block[1].padding), 5.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -2.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-8.0, -6.0, -8.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-7.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(1.0, -4.0, -2.0)) && allOk;
	allOk = compare_float((block[2].padding), -2.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 7.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 0.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-8.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-4.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(3.0, 7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (2.0);
	block[0].var[0] = (vec3(-4.0, 9.0, -4.0));
	block[0].var[1] = (vec3(2.0, 5.0, 5.0));
	block[0].var[2] = (vec3(-9.0, -5.0, 3.0));
	block[1].padding = (1.0);
	block[1].var[0] = (vec3(8.0, 6.0, 9.0));
	block[1].var[1] = (vec3(-8.0, -1.0, 5.0));
	block[1].var[2] = (vec3(1.0, 6.0, -5.0));
	block[2].padding = (-4.0);
	block[2].var[0] = (vec3(-8.0, -8.0, -2.0));
	block[2].var[1] = (vec3(9.0, -4.0, 4.0));
	block[2].var[2] = (vec3(4.0, -1.0, 5.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -9.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 3.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-4.0, -4.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-7.0, 2.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(2.0, 3.0)) && allOk;
	allOk = compare_float((block[1].padding), -9.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -5.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(0.0, -3.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(-1.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -3.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -4.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(3.0, -9.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-4.0);
	block[0].var = (mat3x2(-6.0, 1.0, -8.0, 7.0, 6.0, -1.0));
	block[1].padding = (-6.0);
	block[1].var = (mat3x2(-4.0, -7.0, 0.0, -7.0, 7.0, -2.0));
	block[2].padding = (-6.0);
	block[2].var = (mat3x2(-5.0, -4.0, -6.0, 4.0, -4.0, 9.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -1.0) && allOk;
	allOk = compare_mat3x2(block[0].var, mat3x2(4.0, -9.0, -1.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_float((block[1].padding), 6.0) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(3.0, 1.0, 8.0, 0.0, -8.0, -3.0)) && allOk;
	allOk = compare_float((block[2].padding), 3.0) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(-3.0, -4.0, 8.0, 1.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-2.0);
	block[0].var = (mat3x2(-2.0, -8.0, 0.0, -9.0, 9.0, 0.0));
	block[1].padding = (1.0);
	block[1].var = (mat3x2(-3.0, -6.0, -5.0, -7.0, 5.0, -4.0));
	block[2].padding = (8.0);
	block[2].var = (mat3x2(-1.0, -8.0, 1.0, 2.0, 1.0, -5.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 2.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 1.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -4.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(9.0, 7.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(3.0, 6.0, 6.0, 9.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(-9.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_float((block[1].padding), 6.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 3.0) && allOk;
	allOk = compare_float(block[1].var[2][3], -5.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(9.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(2.0, -4.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(3.0, -9.0, 3.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), 6.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 7.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][3], 1.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-3.0, 3.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-3.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-9.0, -9.0, 6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (8.0);
	block[0].var[0] = (vec4(8.0, -2.0, 8.0, 8.0));
	block[0].var[1] = (vec4(3.0, 5.0, -5.0, 7.0));
	block[0].var[2] = (vec4(6.0, -9.0, 3.0, 0.0));
	block[1].padding = (-3.0);
	block[1].var[0] = (vec4(1.0, -9.0, -9.0, -6.0));
	block[1].var[1] = (vec4(-5.0, 1.0, 9.0, 0.0));
	block[1].var[2] = (vec4(-9.0, -2.0, -4.0, -3.0));
	block[2].padding = (-1.0);
	block[2].var[0] = (vec4(-6.0, 1.0, -2.0, -2.0));
	block[2].var[1] = (vec4(-1.0, -7.0, 8.0, 0.0));
	block[2].var[2] = (vec4(-6.0, -1.0, 7.0, -6.0));
}
#version 450
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
	mediump uvec2 a;
	lowp ivec4 b;
};
layout(std140, binding = 2) buffer BlockC
{
	highp uvec2 c;
} blockC;

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockC.c), uvec2(3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec2(7u, 4u));
	blockC.c = (uvec2(2u, 0u));
}
#version 450
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
	lowp mat4x2 e[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp mat3 f;
	mediump vec2 g[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(a, mat3x2(-4.0, -7.0, 6.0, -9.0, 6.0, 5.0)) && allOk;
	allOk = compare_ivec4((c), ivec4(6, -2, -6, 4)) && allOk;
	allOk = compare_mat4x2(e[0], mat4x2(-3.0, -5.0, 2.0, -7.0, -9.0, 3.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat4x2(e[1], mat4x2(2.0, 0.0, -9.0, 1.0, 0.0, -8.0, -5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x2(9.0, -9.0, -7.0, -8.0, -5.0, 0.0));
	blockC.f = (mat3(8.0, -9.0, 9.0, -5.0, -1.0, -8.0, 4.0, -6.0, -4.0));
}
#version 450
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
	mediump vec4 a;
	highp uint b[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump int c;
	highp mat4 d;
	lowp mat2 e;
	lowp uvec2 f;
	lowp uvec3 g[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	mediump uint h;
	lowp mat2x3 i;
	highp ivec2 j;
	mediump int k[1];
	lowp ivec3 l;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a), vec4(0.0, 2.0, -8.0, 6.0)) && allOk;
	allOk = compare_uint((b[0]), 2u) && allOk;
	allOk = compare_mat2(blockC.e, mat2(2.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(7u, 9u)) && allOk;
	allOk = compare_uint((blockD.h), 5u) && allOk;
	allOk = compare_int((blockD.k[0]), 1) && allOk;
	allOk = compare_ivec3((blockD.l), ivec3(3, -9, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (7u);
	blockC.f = (uvec2(2u, 3u));
	blockC.g[0] = (uvec3(4u, 6u, 5u));
	blockD.h = (2u);
	blockD.i = (mat2x3(8.0, 4.0, -4.0, 0.0, 7.0, 6.0));
	blockD.k[0] = (3);
}
#version 450
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
	mediump mat3x2 b;
	mediump mat3 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	a = (7u);
	b = (mat3x2(4.0, -4.0, -7.0, -3.0, -9.0, 1.0));
	c[0] = (mat3(2.0, 8.0, -2.0, 5.0, -7.0, -5.0, -9.0, -9.0, -7.0));
}
#version 450
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
	lowp int a;
	mediump uvec3 b[5];
	mediump float c;
	lowp int d;
	bvec3 e[];
} blockB;
layout(std430, column_major, binding = 2) readonly buffer BlockC
{
	highp uvec4 f[][7];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	lowp mat3x2 g;
	bool h[][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 6) && allOk;
	allOk = compare_bvec3((blockB.e[0]), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7);
	blockB.b[0] = (uvec3(7u, 6u, 8u));
	blockB.b[1] = (uvec3(9u, 7u, 0u));
	blockB.b[2] = (uvec3(9u, 6u, 8u));
	blockB.b[3] = (uvec3(6u, 7u, 8u));
	blockB.b[4] = (uvec3(8u, 6u, 3u));
	blockB.c = (-7.0);
	blockB.e[0] = (bvec3(false, true, true));
	h[0][0] = (false);
	h[0][1] = (true);
	h[0][2] = (false);
	h[1][0] = (false);
	h[1][1] = (true);
	h[1][2] = (true);
	h[2][0] = (false);
	h[2][1] = (false);
	h[2][2] = (false);
}
#version 450
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
	highp ivec3 a[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	bvec4 b;
	highp uvec2 c;
	highp uvec3 d[][8];
} blockC;

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a[0]), ivec3(0, 7, 4)) && allOk;
	allOk = compare_ivec3((blockB.a[1]), ivec3(-8, -2, -7)) && allOk;
	allOk = compare_ivec3((blockB.a[2]), ivec3(1, 0, 5)) && allOk;
	allOk = compare_ivec3((blockB.a[3]), ivec3(7, -2, -5)) && allOk;
	allOk = compare_ivec3((blockB.a[4]), ivec3(-1, -9, -3)) && allOk;
	allOk = compare_ivec3((blockB.a[5]), ivec3(-4, 6, -9)) && allOk;
	allOk = compare_ivec3((blockB.a[6]), ivec3(-1, -6, 7)) && allOk;
	allOk = compare_bvec4((blockC.b), bvec4(true, true, false, false)) && allOk;
	allOk = compare_uvec2((blockC.c), uvec2(9u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec3(6, -8, -5));
	blockB.a[1] = (ivec3(-5, 8, -6));
	blockB.a[2] = (ivec3(-1, -8, -8));
	blockB.a[3] = (ivec3(-6, 1, -2));
	blockB.a[4] = (ivec3(4, 9, -9));
	blockB.a[5] = (ivec3(-5, 8, 3));
	blockB.a[6] = (ivec3(-1, 7, -2));
	blockC.b = (bvec4(true, true, false, true));
	blockC.c = (uvec2(0u, 3u));
}
#version 450
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
	layout(offset = 16) highp uvec4 b[1];
	layout(offset = 32) bvec2 c;
	layout(offset = 40) bvec2 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec3 e;
	layout(offset = 16) bvec2 f;
	layout(offset = 24) lowp uvec2 g;
	layout(offset = 32) bvec3 h;
	layout(offset = 44) mediump uint i;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump vec2 j;
	layout(offset = 16) bvec3 k;
	layout(offset = 32) lowp ivec3 l;
	layout(offset = 48) lowp vec4 m;
	layout(offset = 64) lowp vec4 n;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) highp uvec4 o;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uvec4((blockB.b[0]), uvec4(6u, 9u, 0u, 9u)) && allOk;
	allOk = compare_bvec2((blockB.c), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((f), bvec2(true, true)) && allOk;
	allOk = compare_uvec2((g), uvec2(5u, 2u)) && allOk;
	allOk = compare_bvec3((h), bvec3(true, false, false)) && allOk;
	allOk = compare_vec2((j), vec2(8.0, 4.0)) && allOk;
	allOk = compare_ivec3((l), ivec3(-2, 9, 4)) && allOk;
	allOk = compare_vec4((m), vec4(-2.0, 0.0, 5.0, -3.0)) && allOk;
	allOk = compare_vec4((n), vec4(-8.0, -4.0, -3.0, -6.0)) && allOk;
	allOk = compare_uvec4((o), uvec4(5u, 3u, 9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (uvec4(5u, 2u, 1u, 3u));
	blockB.c = (bvec2(false, true));
	blockB.d = (bvec2(false, false));
	e = (bvec3(false, false, true));
	f = (bvec2(false, false));
	i = (2u);
	j = (vec2(9.0, -7.0));
	k = (bvec3(false, true, true));
	n = (vec4(-2.0, 0.0, -6.0, -7.0));
	o = (uvec4(4u, 1u, 3u, 0u));
}
#version 450
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
	bvec3 a;
	bvec2 b;
	lowp vec2 c;
	highp int d[];
} blockB[3];
layout(scalar, binding = 2) buffer BlockC
{
	highp vec3 e;
	mediump mat4x2 f;
	highp uvec2 g;
	mediump vec3 h[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[0].a), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec2((blockB[0].b), bvec2(true, false)) && allOk;
	allOk = compare_vec2((blockB[0].c), vec2(6.0, 8.0)) && allOk;
	allOk = compare_int((blockB[0].d[0]), 3) && allOk;
	allOk = compare_int((blockB[0].d[1]), -8) && allOk;
	allOk = compare_int((blockB[0].d[2]), 7) && allOk;
	allOk = compare_int((blockB[0].d[3]), 2) && allOk;
	allOk = compare_bvec3((blockB[1].a), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec2((blockB[1].b), bvec2(false, true)) && allOk;
	allOk = compare_vec2((blockB[1].c), vec2(3.0, -8.0)) && allOk;
	allOk = compare_int((blockB[1].d[0]), -1) && allOk;
	allOk = compare_int((blockB[1].d[1]), -4) && allOk;
	allOk = compare_int((blockB[1].d[2]), 2) && allOk;
	allOk = compare_int((blockB[1].d[3]), -4) && allOk;
	allOk = compare_int((blockB[1].d[4]), -2) && allOk;
	allOk = compare_int((blockB[1].d[5]), 1) && allOk;
	allOk = compare_bvec3((blockB[2].a), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec2((blockB[2].b), bvec2(false, true)) && allOk;
	allOk = compare_vec2((blockB[2].c), vec2(0.0, -9.0)) && allOk;
	allOk = compare_int((blockB[2].d[0]), -1) && allOk;
	allOk = compare_int((blockB[2].d[1]), -1) && allOk;
	allOk = compare_int((blockB[2].d[2]), 2) && allOk;
	allOk = compare_int((blockB[2].d[3]), 4) && allOk;
	allOk = compare_int((blockB[2].d[4]), 4) && allOk;
	allOk = compare_int((blockB[2].d[5]), 6) && allOk;
	allOk = compare_mat4x2(blockC.f, mat4x2(-9.0, 7.0, 1.0, 5.0, -6.0, 3.0, 7.0, 9.0)) && allOk;
	allOk = compare_uvec2((blockC.g), uvec2(2u, 3u)) && allOk;
	allOk = compare_vec3((blockC.h[0]), vec3(-5.0, 9.0, -1.0)) && allOk;
	allOk = compare_vec3((blockC.h[1]), vec3(-5.0, 4.0, -3.0)) && allOk;
	allOk = compare_vec3((blockC.h[2]), vec3(-1.0, 1.0, 7.0)) && allOk;
	allOk = compare_vec3((blockC.h[3]), vec3(3.0, -3.0, -9.0)) && allOk;
	allOk = compare_vec3((blockC.h[4]), vec3(3.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec3((blockC.h[5]), vec3(5.0, -7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec3(true, false, true));
	blockB[0].d[0] = (0);
	blockB[0].d[1] = (-6);
	blockB[0].d[2] = (-6);
	blockB[0].d[3] = (1);
	blockB[1].a = (bvec3(false, false, true));
	blockB[1].d[0] = (-9);
	blockB[1].d[1] = (9);
	blockB[1].d[2] = (-1);
	blockB[1].d[3] = (8);
	blockB[1].d[4] = (-7);
	blockB[1].d[5] = (-8);
	blockB[2].a = (bvec3(true, false, false));
	blockB[2].d[0] = (4);
	blockB[2].d[1] = (-4);
	blockB[2].d[2] = (-8);
	blockB[2].d[3] = (6);
	blockB[2].d[4] = (2);
	blockB[2].d[5] = (-8);
	blockC.f = (mat4x2(-8.0, 0.0, 0.0, -2.0, -8.0, 8.0, 7.0, 6.0));
	blockC.h[0] = (vec3(-5.0, 5.0, 6.0));
	blockC.h[1] = (vec3(-1.0, -4.0, -3.0));
	blockC.h[2] = (vec3(-2.0, -8.0, 7.0));
	blockC.h[3] = (vec3(9.0, -2.0, -5.0));
	blockC.h[4] = (vec3(7.0, 0.0, -6.0));
	blockC.h[5] = (vec3(7.0, 9.0, -3.0));
}
#version 450
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
};
struct sB
{
	mediump uvec4 mA;
};
struct sC
{
	sB mA;
	bvec2 mB;
	bool mC;
};
struct sD
{
	mediump vec2 mA;
};
struct sE
{
	highp vec4 mA;
	lowp mat4 mB;
};
struct sF
{
	bvec2 mA;
	sE mB;
	mediump vec3 mC;
	mediump int mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	highp uvec3 a;
	lowp vec2 b[];
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	sA c;
	bvec3 d[7];
	bvec4 e;
};
layout(scalar, row_major, binding = 3) buffer BlockD
{
	mediump mat4x3 f[5];
	bvec3 g[];
} blockD;
layout(scalar, binding = 4) buffer BlockE
{
	sC h;
	mediump mat2x3 i;
	sD j;
	sF k[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((a), uvec3(9u, 2u, 1u)) && allOk;
	allOk = compare_vec2((b[0]), vec2(0.0, -6.0)) && allOk;
	allOk = compare_vec2((b[1]), vec2(5.0, 9.0)) && allOk;
	allOk = compare_vec2((b[2]), vec2(8.0, -2.0)) && allOk;
	allOk = compare_vec2((b[3]), vec2(4.0, -9.0)) && allOk;
	allOk = compare_vec2((b[4]), vec2(8.0, -7.0)) && allOk;
	allOk = compare_int((c.mA), 5) && allOk;
	allOk = compare_bvec4((e), bvec4(true, false, false, false)) && allOk;
	allOk = compare_mat4x3(blockD.f[0], mat4x3(-6.0, 6.0, -6.0, 8.0, -7.0, -7.0, -2.0, 3.0, -4.0, -5.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockD.f[1], mat4x3(0.0, 6.0, 4.0, -7.0, -5.0, -9.0, -2.0, -8.0, -6.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockD.f[2], mat4x3(-4.0, -9.0, -9.0, -8.0, 1.0, 5.0, 5.0, 1.0, -1.0, -2.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockD.f[3], mat4x3(-1.0, 2.0, 0.0, 0.0, -8.0, -9.0, 4.0, -4.0, -6.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockD.f[4], mat4x3(-3.0, -7.0, -7.0, 8.0, -3.0, -1.0, 9.0, 5.0, 4.0, -8.0, -3.0, -4.0)) && allOk;
	allOk = compare_uvec4((blockE.h.mA.mA), uvec4(0u, 6u, 2u, 9u)) && allOk;
	allOk = compare_bvec2((blockE.h.mB), bvec2(true, false)) && allOk;
	allOk = compare_bool((blockE.h.mC), false) && allOk;
	allOk = compare_vec2((blockE.j.mA), vec2(-8.0, 6.0)) && allOk;
	allOk = compare_bvec2((blockE.k[0].mA), bvec2(false, true)) && allOk;
	allOk = compare_vec4((blockE.k[0].mB.mA), vec4(-5.0, 6.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4(blockE.k[0].mB.mB, mat4(-4.0, 8.0, -3.0, 9.0, -8.0, -2.0, -2.0, 8.0, -1.0, 9.0, -5.0, 5.0, 5.0, 2.0, 2.0, -2.0)) && allOk;
	allOk = compare_vec3((blockE.k[0].mC), vec3(9.0, -9.0, 8.0)) && allOk;
	allOk = compare_int((blockE.k[0].mD), 8) && allOk;
	allOk = compare_bvec2((blockE.k[1].mA), bvec2(false, false)) && allOk;
	allOk = compare_vec4((blockE.k[1].mB.mA), vec4(7.0, -1.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4(blockE.k[1].mB.mB, mat4(-3.0, -4.0, 4.0, 4.0, -1.0, 0.0, 2.0, 0.0, 9.0, 9.0, -2.0, 0.0, 0.0, -1.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec3((blockE.k[1].mC), vec3(-4.0, -2.0, -6.0)) && allOk;
	allOk = compare_int((blockE.k[1].mD), 2) && allOk;
	allOk = compare_bvec2((blockE.k[2].mA), bvec2(false, true)) && allOk;
	allOk = compare_vec4((blockE.k[2].mB.mA), vec4(-4.0, 5.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4(blockE.k[2].mB.mB, mat4(-1.0, -9.0, -6.0, -9.0, 0.0, -2.0, 1.0, 6.0, 0.0, 8.0, 1.0, -3.0, -8.0, -9.0, -5.0, -6.0)) && allOk;
	allOk = compare_vec3((blockE.k[2].mC), vec3(5.0, -9.0, 6.0)) && allOk;
	allOk = compare_int((blockE.k[2].mD), -9) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (vec2(-3.0, 8.0));
	b[1] = (vec2(-6.0, 4.0));
	b[2] = (vec2(-4.0, -7.0));
	b[3] = (vec2(9.0, 4.0));
	b[4] = (vec2(6.0, -1.0));
	c.mA = (-5);
	d[0] = (bvec3(false, false, false));
	d[1] = (bvec3(false, false, false));
	d[2] = (bvec3(false, false, true));
	d[3] = (bvec3(true, false, true));
	d[4] = (bvec3(true, true, false));
	d[5] = (bvec3(false, false, true));
	d[6] = (bvec3(true, true, true));
	blockD.f[0] = (mat4x3(-2.0, 7.0, 2.0, -6.0, -2.0, 7.0, -3.0, -6.0, -3.0, -9.0, -6.0, -4.0));
	blockD.f[1] = (mat4x3(-2.0, 4.0, 9.0, 7.0, -9.0, 4.0, 1.0, -5.0, -8.0, 1.0, 7.0, 2.0));
	blockD.f[2] = (mat4x3(-5.0, -5.0, 7.0, 4.0, 7.0, 8.0, -6.0, -2.0, -3.0, 0.0, -7.0, -3.0));
	blockD.f[3] = (mat4x3(3.0, 4.0, -3.0, -8.0, 1.0, -5.0, 7.0, -2.0, -2.0, 0.0, 3.0, 7.0));
	blockD.f[4] = (mat4x3(9.0, 7.0, -5.0, -1.0, -8.0, 3.0, 2.0, -1.0, -3.0, 3.0, 1.0, -9.0));
	blockD.g[0] = (bvec3(false, true, true));
	blockE.j.mA = (vec2(-9.0, -7.0));
	blockE.k[0].mA = (bvec2(true, false));
	blockE.k[0].mB.mA = (vec4(-6.0, 9.0, 8.0, 8.0));
	blockE.k[0].mB.mB = (mat4(-2.0, 3.0, 9.0, -3.0, 9.0, 1.0, 9.0, 0.0, 7.0, -7.0, 0.0, -7.0, 8.0, -4.0, 0.0, 2.0));
	blockE.k[0].mC = (vec3(5.0, -7.0, -5.0));
	blockE.k[0].mD = (8);
	blockE.k[1].mA = (bvec2(false, true));
	blockE.k[1].mB.mA = (vec4(5.0, 7.0, 5.0, 8.0));
	blockE.k[1].mB.mB = (mat4(-7.0, 0.0, 8.0, 3.0, -6.0, 2.0, 4.0, 5.0, 9.0, 1.0, -2.0, -4.0, -2.0, -5.0, 1.0, -4.0));
	blockE.k[1].mC = (vec3(2.0, -8.0, -6.0));
	blockE.k[1].mD = (-5);
	blockE.k[2].mA = (bvec2(true, true));
	blockE.k[2].mB.mA = (vec4(-5.0, 4.0, -8.0, -5.0));
	blockE.k[2].mB.mB = (mat4(3.0, -9.0, 6.0, 3.0, -8.0, 1.0, 2.0, 6.0, -7.0, -6.0, 7.0, -5.0, 2.0, -3.0, 8.0, 7.0));
	blockE.k[2].mC = (vec3(3.0, 3.0, -5.0));
	blockE.k[2].mD = (-4);
}
#version 450
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
	mediump float a;
	lowp mat4x2 b;
	i16vec3 c[];
} blockB;
layout(std140, binding = 2) readonly buffer BlockC
{
	f16vec2 d[7];
	highp mat3 e;
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp vec4 f;
	highp uvec2 g;
	lowp int h;
	i16vec2 i[2];
	highp uvec3 j[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -2.0) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.c[0]), ivec3(-2, -3, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.c[1]), ivec3(-6, 9, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.c[2]), ivec3(5, -6, -3)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.c[3]), ivec3(0, -6, 1)) && allOk;
	allOk = compare_f16vec2(vec2(d[0]), vec2(2.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(d[1]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(d[2]), vec2(0.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(d[3]), vec2(4.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(d[4]), vec2(9.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(d[5]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(d[6]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_mat3(e, mat3(-7.0, -5.0, -4.0, 3.0, 5.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((blockD.f), vec4(6.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_uvec2((blockD.g), uvec2(7u, 6u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.i[0]), ivec2(0, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.i[1]), ivec2(4, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4x2(3.0, -1.0, -9.0, 9.0, -7.0, -4.0, -4.0, -4.0));
	blockD.f = (vec4(5.0, 5.0, 3.0, 8.0));
	blockD.h = (3);
	blockD.i[0] = i16vec2(ivec2(6, 5));
	blockD.i[1] = i16vec2(ivec2(1, 1));
}
#version 450
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
	i16vec2 a;
	highp vec4 b[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	f16vec4 c[5];
	mediump vec4 d[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	mediump int e[];
} blockD;
layout(std140, binding = 4) readonly buffer BlockE
{
	mediump uvec2 f;
	lowp vec3 g;
	u16vec2 h[][6];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockC.c[0]), vec4(-4.0, -8.0, 8.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.c[1]), vec4(-6.0, -2.0, 9.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.c[2]), vec4(-2.0, 1.0, 1.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.c[3]), vec4(-1.0, 9.0, -5.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.c[4]), vec4(4.0, -9.0, 8.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC.d[0]), vec4(8.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC.d[1]), vec4(3.0, -5.0, -3.0, 0.0)) && allOk;
	allOk = compare_vec4((blockC.d[2]), vec4(-2.0, -4.0, 4.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC.d[3]), vec4(-3.0, 5.0, -2.0, 4.0)) && allOk;
	allOk = compare_vec3((g), vec3(8.0, -5.0, 8.0)) && allOk;
	allOk = compare_u16vec2(uvec2(h[0][0]), uvec2(4u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[0][1]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[0][2]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[0][3]), uvec2(3u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[0][4]), uvec2(0u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[0][5]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[1][0]), uvec2(0u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[1][1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[1][2]), uvec2(6u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[1][3]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[1][4]), uvec2(4u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[1][5]), uvec2(2u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[2][0]), uvec2(2u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[2][1]), uvec2(9u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[2][2]), uvec2(1u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[2][3]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[2][4]), uvec2(3u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[2][5]), uvec2(2u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[3][0]), uvec2(3u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[3][1]), uvec2(3u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[3][2]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[3][3]), uvec2(9u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[3][4]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[3][5]), uvec2(7u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[4][0]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[4][1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[4][2]), uvec2(5u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[4][3]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[4][4]), uvec2(5u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[4][5]), uvec2(8u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[5][0]), uvec2(5u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[5][1]), uvec2(1u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[5][2]), uvec2(8u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[5][3]), uvec2(1u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[5][4]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(h[5][5]), uvec2(9u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i16vec2(ivec2(-5, 9));
	blockC.c[0] = f16vec4(vec4(6.0, 1.0, 9.0, -5.0));
	blockC.c[1] = f16vec4(vec4(9.0, -3.0, 6.0, 7.0));
	blockC.c[2] = f16vec4(vec4(-9.0, -6.0, -1.0, 3.0));
	blockC.c[3] = f16vec4(vec4(5.0, 3.0, 9.0, 8.0));
	blockC.c[4] = f16vec4(vec4(-4.0, -8.0, -5.0, -1.0));
	blockC.d[0] = (vec4(2.0, 0.0, 5.0, 3.0));
	blockC.d[1] = (vec4(-3.0, 2.0, 4.0, 4.0));
	blockC.d[2] = (vec4(-6.0, 4.0, -5.0, -2.0));
	blockC.d[3] = (vec4(-4.0, -5.0, 7.0, 6.0));
	blockD.e[0] = (-9);
	blockD.e[1] = (0);
	blockD.e[2] = (-7);
	blockD.e[3] = (2);
	blockD.e[4] = (1);
	blockD.e[5] = (9);
	blockD.e[6] = (2);
}
#version 450
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
	f16vec2 a;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB.a), vec2(-5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec2(vec2(3.0, -4.0));
}
#version 450
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
};
struct sB
{
	bvec4 mA;
};
struct sC
{
	sB mA;
	mediump float mB;
	mediump mat3x2 mC;
};
layout(std430, column_major, binding = 1) readonly buffer BlockB
{
	int16_t a[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	sA b;
	mediump uvec4 c;
	lowp mat2x3 d;
	lowp uvec3 e;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	highp ivec2 f;
	bvec2 g;
	mediump uvec2 h;
	sC i;
	int16_t j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.a[0]), -8) && allOk;
	allOk = compare_f16vec2(vec2(blockC.b.mA), vec2(-2.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockC.b.mB), ivec2(-5, 5)) && allOk;
	allOk = compare_mat2x3(blockC.d, mat2x3(6.0, -9.0, 8.0, 0.0, 1.0, 1.0)) && allOk;
	allOk = compare_ivec2((f), ivec2(-1, -8)) && allOk;
	allOk = compare_bvec2((g), bvec2(false, true)) && allOk;
	allOk = compare_uvec2((h), uvec2(1u, 7u)) && allOk;
	allOk = compare_int16_t(int(j[0]), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b.mA = f16vec2(vec2(1.0, -4.0));
	blockC.b.mB = (ivec2(1, 8));
	blockC.d = (mat2x3(0.0, -6.0, 4.0, -9.0, 3.0, -1.0));
	blockC.e = (uvec3(6u, 2u, 3u));
	f = (ivec2(-3, 6));
	h = (uvec2(7u, 5u));
	j[0] = int16_t(8);
}
#version 450
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
	float16_t mA;
	highp ivec4 mB;
	lowp vec4 mC;
	lowp mat4x3 mD;
};
struct sC
{
	sA mA;
	sB mB;
	lowp mat2x3 mC;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	highp mat4x3 a;
	uint16_t b;
	mediump mat3x4 c[];
} blockB;
layout(std430, column_major, binding = 2) readonly buffer BlockC
{
	highp vec3 d;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	mediump mat2x3 e[];
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	sC f[1];
	highp mat3 g;
	i16vec3 h;
	u16vec2 i;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.c[0], mat3x4(-9.0, -9.0, 7.0, -5.0, 2.0, 0.0, 0.0, 2.0, 0.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[1], mat3x4(-7.0, 8.0, -5.0, 8.0, -2.0, 9.0, 2.0, 7.0, 9.0, 0.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[2], mat3x4(-3.0, -9.0, -1.0, 0.0, 1.0, 2.0, -3.0, 2.0, 4.0, 7.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[3], mat3x4(3.0, -4.0, 0.0, -5.0, 3.0, 8.0, 4.0, -5.0, 8.0, 0.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[4], mat3x4(6.0, -3.0, -9.0, -8.0, -9.0, 5.0, -6.0, -6.0, -1.0, 1.0, -5.0, -8.0)) && allOk;
	allOk = compare_vec3((blockC.d), vec3(-6.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3(g, mat3(-8.0, 2.0, -1.0, -8.0, -2.0, -9.0, 5.0, 9.0, -7.0)) && allOk;
	allOk = compare_i16vec3(ivec3(h), ivec3(-6, 5, -1)) && allOk;
	allOk = compare_u16vec2(uvec2(i), uvec2(7u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = uint16_t(9u);
	blockB.c[0] = (mat3x4(-1.0, 5.0, -2.0, -9.0, 6.0, -6.0, 2.0, -5.0, 9.0, -1.0, -3.0, 3.0));
	blockB.c[1] = (mat3x4(5.0, -2.0, -3.0, -3.0, -5.0, 8.0, -8.0, -1.0, -2.0, -3.0, 1.0, 3.0));
	blockB.c[2] = (mat3x4(7.0, -1.0, -9.0, -8.0, -4.0, -3.0, 8.0, -8.0, -5.0, 1.0, 9.0, 3.0));
	blockB.c[3] = (mat3x4(-3.0, 6.0, 6.0, -1.0, 0.0, 1.0, 0.0, 5.0, 4.0, -4.0, -2.0, 2.0));
	blockB.c[4] = (mat3x4(-7.0, -6.0, -9.0, 9.0, -6.0, 9.0, 5.0, -9.0, -2.0, 9.0, -3.0, -7.0));
	blockD.e[0] = (mat2x3(4.0, 5.0, -3.0, 0.0, 5.0, 0.0));
	f[0].mA.mA = (mat4(1.0, -1.0, 0.0, -7.0, -6.0, 7.0, -2.0, -1.0, -5.0, -6.0, -6.0, 2.0, 5.0, 9.0, -4.0, -6.0));
	f[0].mB.mA = float16_t(-4.0);
	f[0].mB.mB = (ivec4(3, 5, 0, 3));
	f[0].mB.mC = (vec4(2.0, -8.0, -4.0, -3.0));
	f[0].mB.mD = (mat4x3(-7.0, 3.0, 1.0, 6.0, 1.0, -9.0, -9.0, 0.0, -8.0, -1.0, -3.0, 8.0));
	f[0].mC = (mat2x3(-5.0, 3.0, 5.0, -7.0, 9.0, 7.0));
	g = (mat3(-3.0, 2.0, 1.0, 4.0, -3.0, 5.0, -3.0, -2.0, 1.0));
}
#version 450
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
	mediump mat2x3 b;
	highp float c;
	u16vec3 d;
	mediump uvec2 e[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.c), 3.0) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.d), uvec3(0u, 6u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.e[0]), uvec2(8u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.e[1]), uvec2(0u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.e[2]), uvec2(7u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.e[3]), uvec2(3u, 1u)) && allOk;
	allOk = compare_uvec2((blockB.e[4]), uvec2(7u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.e[5]), uvec2(7u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec3(vec3(6.0, -5.0, -1.0));
	blockB.d = u16vec3(uvec3(2u, 7u, 1u));
	blockB.e[0] = (uvec2(1u, 5u));
	blockB.e[1] = (uvec2(2u, 7u));
	blockB.e[2] = (uvec2(9u, 9u));
	blockB.e[3] = (uvec2(3u, 3u));
	blockB.e[4] = (uvec2(6u, 7u));
	blockB.e[5] = (uvec2(9u, 5u));
}
#version 450
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
	layout(offset = 0) u16vec4 a;
	layout(offset = 8) float16_t b;
	layout(offset = 16) highp uvec3 c;
	layout(offset = 32) lowp vec3 d;
	layout(offset = 48) mediump ivec4 e;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec3 f;
	layout(offset = 16) f16vec3 g;
	layout(offset = 32) bvec3 h;
	layout(offset = 44) bool i;
	layout(offset = 48) mediump vec3 j[1];
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.b), -9.0) && allOk;
	allOk = compare_uvec3((blockB.c), uvec3(4u, 4u, 0u)) && allOk;
	allOk = compare_bvec3((blockC[0].f), bvec3(false, true, true)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[0].g), vec3(8.0, -6.0, 2.0)) && allOk;
	allOk = compare_bvec3((blockC[0].h), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((blockC[0].j[0]), vec3(-6.0, -5.0, -9.0)) && allOk;
	allOk = compare_bvec3((blockC[1].f), bvec3(false, true, true)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[1].g), vec3(8.0, -9.0, -4.0)) && allOk;
	allOk = compare_bvec3((blockC[1].h), bvec3(true, false, true)) && allOk;
	allOk = compare_vec3((blockC[1].j[0]), vec3(-2.0, 2.0, -1.0)) && allOk;
	allOk = compare_bvec3((blockC[2].f), bvec3(true, false, true)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[2].g), vec3(-1.0, -8.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockC[2].h), bvec3(false, true, true)) && allOk;
	allOk = compare_vec3((blockC[2].j[0]), vec3(-1.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(4u, 0u, 2u, 8u));
	blockB.b = float16_t(2.0);
	blockB.c = (uvec3(2u, 5u, 2u));
	blockB.d = (vec3(-5.0, 5.0, -3.0));
	blockB.e = (ivec4(4, -8, 9, -2));
	blockC[0].f = (bvec3(true, false, true));
	blockC[0].g = f16vec3(vec3(-2.0, 9.0, -6.0));
	blockC[0].h = (bvec3(true, true, false));
	blockC[0].i = (true);
	blockC[0].j[0] = (vec3(-5.0, -8.0, 3.0));
	blockC[1].f = (bvec3(true, false, false));
	blockC[1].g = f16vec3(vec3(8.0, 2.0, -4.0));
	blockC[1].h = (bvec3(true, true, true));
	blockC[1].i = (false);
	blockC[1].j[0] = (vec3(-5.0, -2.0, -3.0));
	blockC[2].f = (bvec3(false, true, true));
	blockC[2].g = f16vec3(vec3(-9.0, 9.0, -1.0));
	blockC[2].h = (bvec3(true, true, true));
	blockC[2].i = (true);
	blockC[2].j[0] = (vec3(8.0, 5.0, 0.0));
}
#version 450
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
	mediump uint b[1];
	lowp int c;
	int8_t d;
	bool e;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	bool f;
	highp float g;
	int8_t h;
	highp float i;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	uint8_t j[1];
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	highp float k;
	mediump float l;
	mediump float m;
	lowp int n;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -4.0) && allOk;
	allOk = compare_int8_t(int(blockB.d), 4294967289) && allOk;
	allOk = compare_bool((blockB.e), false) && allOk;
	allOk = compare_float((blockC.g), -4.0) && allOk;
	allOk = compare_float((blockC.i), 8.0) && allOk;
	allOk = compare_uint8_t(uint(blockD.j[0]), 3u) && allOk;
	allOk = compare_float((k), -2.0) && allOk;
	allOk = compare_float((m), 4.0) && allOk;
	allOk = compare_int((n), -6) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (9.0);
	blockB.b[0] = (0u);
	blockB.c = (-5);
	blockB.d = int8_t(4294967287);
	blockB.e = (true);
	blockC.g = (0.0);
	blockC.i = (7.0);
	blockD.j[0] = uint8_t(0u);
	k = (2.0);
	l = (-5.0);
	n = (-6);
}
#version 450
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
	highp mat4x2 a[][8];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(a[0][0], mat4x2(-5.0, -9.0, -7.0, 9.0, -1.0, 0.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(a[0][1], mat4x2(-2.0, 0.0, 3.0, -3.0, 2.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(a[0][2], mat4x2(-3.0, 8.0, 5.0, -7.0, -3.0, -9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x2(a[0][3], mat4x2(7.0, 4.0, 6.0, 7.0, -8.0, 9.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(a[0][4], mat4x2(-8.0, 6.0, -3.0, -8.0, -7.0, -2.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(a[0][5], mat4x2(-9.0, 1.0, 3.0, -6.0, -8.0, 0.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat4x2(a[0][6], mat4x2(-3.0, -6.0, -9.0, 0.0, 9.0, 0.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(a[0][7], mat4x2(6.0, -3.0, 9.0, 7.0, 8.0, 8.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x2(a[1][0], mat4x2(-7.0, 7.0, -8.0, -7.0, -8.0, -2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x2(a[1][1], mat4x2(4.0, -1.0, -7.0, -2.0, 5.0, 6.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x2(a[1][2], mat4x2(-5.0, -2.0, 8.0, -5.0, 0.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(a[1][3], mat4x2(-2.0, 5.0, -9.0, 5.0, -7.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x2(a[1][4], mat4x2(0.0, -9.0, -4.0, -3.0, -2.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(a[1][5], mat4x2(4.0, -5.0, 6.0, -2.0, 3.0, -6.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x2(a[1][6], mat4x2(-8.0, -1.0, 7.0, -9.0, -3.0, 6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x2(a[1][7], mat4x2(4.0, 5.0, -8.0, -4.0, -4.0, 2.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(a[2][0], mat4x2(-2.0, 4.0, 3.0, 1.0, -2.0, 7.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(a[2][1], mat4x2(1.0, 0.0, -9.0, 6.0, -6.0, 7.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(a[2][2], mat4x2(-1.0, -8.0, -5.0, 7.0, -9.0, -9.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x2(a[2][3], mat4x2(9.0, -1.0, -7.0, 1.0, 4.0, 4.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(a[2][4], mat4x2(-4.0, -8.0, -8.0, -9.0, 5.0, -8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(a[2][5], mat4x2(-9.0, -1.0, -8.0, -7.0, 2.0, -6.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(a[2][6], mat4x2(-1.0, -8.0, -9.0, 6.0, 6.0, -9.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(a[2][7], mat4x2(2.0, 8.0, -4.0, 7.0, -2.0, 5.0, -5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0][0] = (mat4x2(-7.0, 4.0, -4.0, -7.0, -3.0, -9.0, 1.0, 2.0));
	a[0][1] = (mat4x2(8.0, -2.0, 5.0, -7.0, -5.0, -9.0, -9.0, -7.0));
	a[0][2] = (mat4x2(3.0, 1.0, 2.0, -4.0, -6.0, 7.0, 1.0, 9.0));
	a[0][3] = (mat4x2(1.0, 3.0, 9.0, 6.0, 4.0, -5.0, -6.0, 2.0));
	a[0][4] = (mat4x2(8.0, 0.0, 6.0, 5.0, 6.0, -3.0, -8.0, 8.0));
	a[0][5] = (mat4x2(-8.0, -6.0, -5.0, 0.0, 0.0, 2.0, -1.0, -4.0));
	a[0][6] = (mat4x2(-3.0, 0.0, 5.0, -3.0, 7.0, 4.0, 0.0, -3.0));
	a[0][7] = (mat4x2(-8.0, -4.0, -1.0, -5.0, 1.0, -7.0, 2.0, -4.0));
	a[1][0] = (mat4x2(1.0, -2.0, -8.0, 3.0, -7.0, -4.0, 3.0, -7.0));
	a[1][1] = (mat4x2(1.0, -7.0, -5.0, 5.0, -5.0, -6.0, -6.0, -6.0));
	a[1][2] = (mat4x2(-3.0, 2.0, 9.0, -3.0, -7.0, -9.0, 8.0, 6.0));
	a[1][3] = (mat4x2(-1.0, 6.0, -9.0, 0.0, 8.0, -1.0, 0.0, -2.0));
	a[1][4] = (mat4x2(-4.0, 2.0, 9.0, 6.0, -2.0, 6.0, -4.0, -5.0));
	a[1][5] = (mat4x2(-2.0, 0.0, -2.0, -4.0, 8.0, 8.0, 9.0, 7.0));
	a[1][6] = (mat4x2(-3.0, -5.0, -7.0, -8.0, -8.0, 1.0, 6.0, 6.0));
	a[1][7] = (mat4x2(-6.0, -4.0, -7.0, -9.0, -2.0, -5.0, 1.0, 7.0));
	a[2][0] = (mat4x2(0.0, -3.0, 5.0, -2.0, 4.0, -4.0, 0.0, -5.0));
	a[2][1] = (mat4x2(-5.0, 1.0, 3.0, -8.0, -9.0, -4.0, 6.0, 6.0));
	a[2][2] = (mat4x2(-9.0, -2.0, 3.0, 3.0, 5.0, 1.0, 6.0, 4.0));
	a[2][3] = (mat4x2(1.0, -4.0, 1.0, 5.0, 4.0, 4.0, -9.0, 8.0));
	a[2][4] = (mat4x2(-6.0, -3.0, 9.0, 3.0, -7.0, 0.0, -4.0, -3.0));
	a[2][5] = (mat4x2(-9.0, -1.0, -8.0, -1.0, 4.0, 5.0, -4.0, 2.0));
	a[2][6] = (mat4x2(2.0, 1.0, -3.0, 4.0, 0.0, -8.0, 4.0, -1.0));
	a[2][7] = (mat4x2(-4.0, -7.0, 3.0, 5.0, -1.0, -2.0, -4.0, 9.0));
}
#version 450
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
	u8vec2 a;
	mediump mat4x3 b;
	mediump uvec2 c[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.a), uvec2(8u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.c[0]), uvec2(2u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.c[1]), uvec2(5u, 7u)) && allOk;
	allOk = compare_uvec2((blockB.c[2]), uvec2(4u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.c[3]), uvec2(3u, 1u)) && allOk;
	allOk = compare_uvec2((blockB.c[4]), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.c[5]), uvec2(5u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(4u, 0u));
	blockB.c[0] = (uvec2(9u, 3u));
	blockB.c[1] = (uvec2(8u, 7u));
	blockB.c[2] = (uvec2(5u, 8u));
	blockB.c[3] = (uvec2(0u, 8u));
	blockB.c[4] = (uvec2(0u, 6u));
	blockB.c[5] = (uvec2(2u, 6u));
}
#version 450
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
	lowp mat4x2 mB[8];
};
struct sB
{
	sA mA;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	mediump uvec4 a;
	bool b;
	uint8_t c;
	i8vec4 d;
	bool e[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump ivec3 f[7];
	bvec3 g;
	sB h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((a), uvec4(5u, 7u, 4u, 7u)) && allOk;
	allOk = compare_uint8_t(uint(c), 3u) && allOk;
	allOk = compare_bool((e[0]), false) && allOk;
	allOk = compare_bool((e[1]), true) && allOk;
	allOk = compare_bool((e[2]), false) && allOk;
	allOk = compare_bool((e[3]), false) && allOk;
	allOk = compare_bool((e[4]), true) && allOk;
	allOk = compare_bool((e[5]), false) && allOk;
	allOk = compare_bool((e[6]), false) && allOk;
	allOk = compare_bvec3((g), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((h[0].mA.mA), bvec3(true, false, false)) && allOk;
	allOk = compare_mat4x2(h[0].mA.mB[0], mat4x2(-9.0, 3.0, 5.0, 3.0, 4.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat4x2(h[0].mA.mB[1], mat4x2(1.0, 2.0, 7.0, 3.0, 3.0, -8.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(h[0].mA.mB[2], mat4x2(3.0, -5.0, -4.0, 8.0, -6.0, 3.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4x2(h[0].mA.mB[3], mat4x2(-6.0, -8.0, 6.0, 8.0, -1.0, -2.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(h[0].mA.mB[4], mat4x2(8.0, -8.0, 8.0, -1.0, -7.0, -4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(h[0].mA.mB[5], mat4x2(-9.0, -7.0, -9.0, -8.0, -1.0, -4.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(h[0].mA.mB[6], mat4x2(-3.0, -5.0, -6.0, 2.0, -6.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x2(h[0].mA.mB[7], mat4x2(-7.0, -8.0, 8.0, 8.0, 2.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_bvec3((h[1].mA.mA), bvec3(false, true, true)) && allOk;
	allOk = compare_mat4x2(h[1].mA.mB[0], mat4x2(1.0, -5.0, -9.0, 0.0, -7.0, -8.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(h[1].mA.mB[1], mat4x2(-1.0, 3.0, 5.0, 0.0, 5.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(h[1].mA.mB[2], mat4x2(-6.0, -5.0, -9.0, 9.0, -9.0, -4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x2(h[1].mA.mB[3], mat4x2(-8.0, 8.0, 1.0, -2.0, -3.0, 8.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(h[1].mA.mB[4], mat4x2(-5.0, 5.0, -7.0, -2.0, 2.0, -7.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x2(h[1].mA.mB[5], mat4x2(8.0, -1.0, 9.0, 7.0, -6.0, -1.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4x2(h[1].mA.mB[6], mat4x2(-4.0, -2.0, 2.0, 5.0, -6.0, -2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(h[1].mA.mB[7], mat4x2(1.0, -1.0, 2.0, 2.0, 6.0, 4.0, 1.0, -8.0)) && allOk;
	allOk = compare_bvec3((h[2].mA.mA), bvec3(true, false, true)) && allOk;
	allOk = compare_mat4x2(h[2].mA.mB[0], mat4x2(8.0, -6.0, -1.0, -4.0, 1.0, -6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x2(h[2].mA.mB[1], mat4x2(8.0, 1.0, 0.0, -5.0, -7.0, 8.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(h[2].mA.mB[2], mat4x2(-6.0, 6.0, 7.0, -9.0, 2.0, 0.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x2(h[2].mA.mB[3], mat4x2(1.0, -8.0, 3.0, -7.0, 7.0, 3.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(h[2].mA.mB[4], mat4x2(6.0, -6.0, 0.0, -2.0, 2.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x2(h[2].mA.mB[5], mat4x2(-9.0, -3.0, 1.0, 3.0, -4.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(h[2].mA.mB[6], mat4x2(-7.0, 0.0, -7.0, -7.0, 9.0, -8.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(h[2].mA.mB[7], mat4x2(2.0, -3.0, -3.0, 2.0, 9.0, -5.0, -9.0, -9.0)) && allOk;
	allOk = compare_bvec3((h[3].mA.mA), bvec3(false, true, false)) && allOk;
	allOk = compare_mat4x2(h[3].mA.mB[0], mat4x2(9.0, -6.0, 4.0, 4.0, 0.0, -8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(h[3].mA.mB[1], mat4x2(-6.0, 5.0, 7.0, -7.0, -4.0, 5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(h[3].mA.mB[2], mat4x2(7.0, 2.0, 3.0, 5.0, 6.0, -9.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat4x2(h[3].mA.mB[3], mat4x2(2.0, -2.0, 5.0, -6.0, 5.0, 8.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(h[3].mA.mB[4], mat4x2(1.0, -6.0, 5.0, 6.0, -2.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(h[3].mA.mB[5], mat4x2(0.0, -1.0, -6.0, -1.0, -9.0, 7.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4x2(h[3].mA.mB[6], mat4x2(7.0, -6.0, 4.0, -1.0, -2.0, -8.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4x2(h[3].mA.mB[7], mat4x2(8.0, 3.0, 1.0, -2.0, 3.0, -3.0, 6.0, -3.0)) && allOk;
	allOk = compare_bvec3((h[4].mA.mA), bvec3(false, false, true)) && allOk;
	allOk = compare_mat4x2(h[4].mA.mB[0], mat4x2(9.0, -6.0, 9.0, 4.0, -3.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x2(h[4].mA.mB[1], mat4x2(-2.0, -6.0, 1.0, 0.0, 9.0, -2.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4x2(h[4].mA.mB[2], mat4x2(4.0, 9.0, -3.0, 8.0, -9.0, 6.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(h[4].mA.mB[3], mat4x2(-7.0, -2.0, 0.0, 0.0, -6.0, 1.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(h[4].mA.mB[4], mat4x2(1.0, 7.0, 4.0, 7.0, 4.0, 7.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(h[4].mA.mB[5], mat4x2(-6.0, 7.0, 8.0, -5.0, 5.0, -8.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(h[4].mA.mB[6], mat4x2(4.0, -2.0, -4.0, 4.0, -8.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(h[4].mA.mB[7], mat4x2(6.0, -4.0, 4.0, 3.0, -7.0, -3.0, -4.0, -5.0)) && allOk;
	allOk = compare_bvec3((h[5].mA.mA), bvec3(false, false, false)) && allOk;
	allOk = compare_mat4x2(h[5].mA.mB[0], mat4x2(-7.0, 1.0, 8.0, 6.0, 7.0, 5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(h[5].mA.mB[1], mat4x2(5.0, -4.0, 0.0, 3.0, -1.0, 4.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(h[5].mA.mB[2], mat4x2(8.0, 3.0, -4.0, 2.0, 1.0, -5.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4x2(h[5].mA.mB[3], mat4x2(-1.0, 5.0, 4.0, -7.0, 2.0, -9.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4x2(h[5].mA.mB[4], mat4x2(1.0, 4.0, 3.0, 9.0, 9.0, 0.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat4x2(h[5].mA.mB[5], mat4x2(1.0, 2.0, -2.0, 3.0, 4.0, 3.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x2(h[5].mA.mB[6], mat4x2(3.0, 3.0, 5.0, 8.0, -1.0, 5.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4x2(h[5].mA.mB[7], mat4x2(2.0, 0.0, 6.0, -6.0, 0.0, -7.0, -5.0, -3.0)) && allOk;
	allOk = compare_bvec3((h[6].mA.mA), bvec3(true, true, true)) && allOk;
	allOk = compare_mat4x2(h[6].mA.mB[0], mat4x2(-1.0, -6.0, -5.0, -3.0, 5.0, -3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(h[6].mA.mB[1], mat4x2(-1.0, 0.0, -9.0, -1.0, 4.0, -8.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4x2(h[6].mA.mB[2], mat4x2(6.0, 9.0, 4.0, -7.0, 7.0, 0.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4x2(h[6].mA.mB[3], mat4x2(-8.0, 3.0, 5.0, -3.0, -1.0, 9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat4x2(h[6].mA.mB[4], mat4x2(5.0, 1.0, -8.0, -8.0, 1.0, 6.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat4x2(h[6].mA.mB[5], mat4x2(-4.0, -5.0, -7.0, 0.0, -5.0, -7.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4x2(h[6].mA.mB[6], mat4x2(8.0, -1.0, -1.0, 8.0, 1.0, 0.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x2(h[6].mA.mB[7], mat4x2(-1.0, -2.0, 1.0, 5.0, -4.0, 6.0, -4.0, 0.0)) && allOk;
	allOk = compare_bvec3((h[7].mA.mA), bvec3(true, false, true)) && allOk;
	allOk = compare_mat4x2(h[7].mA.mB[0], mat4x2(-4.0, -8.0, 1.0, -1.0, 6.0, 6.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(h[7].mA.mB[1], mat4x2(-6.0, -7.0, 7.0, 3.0, -9.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(h[7].mA.mB[2], mat4x2(9.0, -9.0, -3.0, -4.0, 9.0, 4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x2(h[7].mA.mB[3], mat4x2(9.0, 6.0, 3.0, 4.0, -9.0, 7.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat4x2(h[7].mA.mB[4], mat4x2(5.0, -8.0, -5.0, -7.0, -2.0, 7.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(h[7].mA.mB[5], mat4x2(0.0, -2.0, 0.0, 1.0, 1.0, 9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(h[7].mA.mB[6], mat4x2(-2.0, -8.0, 1.0, -9.0, 5.0, 6.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(h[7].mA.mB[7], mat4x2(3.0, -6.0, 6.0, -2.0, 3.0, 6.0, 2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec4(9u, 2u, 5u, 7u));
	c = uint8_t(4u);
	d = i8vec4(ivec4(7, 6, 4294967292, 5));
	e[0] = (true);
	e[1] = (true);
	e[2] = (true);
	e[3] = (false);
	e[4] = (true);
	e[5] = (true);
	e[6] = (true);
	g = (bvec3(true, false, false));
	h[0].mA.mA = (bvec3(true, false, false));
	h[0].mA.mB[0] = (mat4x2(-4.0, 9.0, -7.0, -1.0, 7.0, -1.0, 9.0, 0.0));
	h[0].mA.mB[1] = (mat4x2(-6.0, 0.0, -6.0, -6.0, 7.0, 7.0, 9.0, 4.0));
	h[0].mA.mB[2] = (mat4x2(-6.0, -9.0, -6.0, 7.0, 1.0, -5.0, -1.0, 0.0));
	h[0].mA.mB[3] = (mat4x2(-4.0, 7.0, 7.0, -4.0, 2.0, 7.0, -2.0, 2.0));
	h[0].mA.mB[4] = (mat4x2(8.0, 9.0, -9.0, -3.0, -2.0, -1.0, -8.0, -4.0));
	h[0].mA.mB[5] = (mat4x2(8.0, 3.0, 1.0, 6.0, 0.0, 8.0, -1.0, 6.0));
	h[0].mA.mB[6] = (mat4x2(-7.0, 1.0, -6.0, -6.0, 6.0, -9.0, -3.0, 9.0));
	h[0].mA.mB[7] = (mat4x2(3.0, 3.0, 5.0, 6.0, 7.0, 1.0, -2.0, -9.0));
	h[1].mA.mA = (bvec3(true, false, true));
	h[1].mA.mB[0] = (mat4x2(0.0, -7.0, -8.0, -1.0, -5.0, 6.0, 8.0, -9.0));
	h[1].mA.mB[1] = (mat4x2(7.0, 9.0, 8.0, -8.0, 4.0, 0.0, -2.0, 5.0));
	h[1].mA.mB[2] = (mat4x2(2.0, 4.0, 4.0, 4.0, 7.0, -4.0, 1.0, 5.0));
	h[1].mA.mB[3] = (mat4x2(5.0, 2.0, 2.0, -5.0, 0.0, -5.0, -5.0, 5.0));
	h[1].mA.mB[4] = (mat4x2(-9.0, 8.0, 9.0, 3.0, 0.0, 9.0, 8.0, 1.0));
	h[1].mA.mB[5] = (mat4x2(-8.0, 1.0, 4.0, 1.0, 6.0, 6.0, 8.0, -5.0));
	h[1].mA.mB[6] = (mat4x2(6.0, 1.0, -4.0, -8.0, -2.0, 8.0, -4.0, -3.0));
	h[1].mA.mB[7] = (mat4x2(-3.0, -8.0, 5.0, 9.0, 9.0, 6.0, -2.0, -3.0));
	h[2].mA.mA = (bvec3(true, false, true));
	h[2].mA.mB[0] = (mat4x2(-8.0, 7.0, 6.0, -2.0, 8.0, 0.0, -5.0, -4.0));
	h[2].mA.mB[1] = (mat4x2(-8.0, -6.0, -6.0, -5.0, 3.0, 6.0, 0.0, -1.0));
	h[2].mA.mB[2] = (mat4x2(1.0, 1.0, -4.0, -5.0, 9.0, -7.0, -3.0, 4.0));
	h[2].mA.mB[3] = (mat4x2(9.0, -8.0, -9.0, 6.0, 8.0, -6.0, -9.0, 9.0));
	h[2].mA.mB[4] = (mat4x2(-3.0, 3.0, 4.0, 6.0, 3.0, -6.0, -1.0, -9.0));
	h[2].mA.mB[5] = (mat4x2(-2.0, -4.0, 6.0, 9.0, 0.0, 3.0, -3.0, 7.0));
	h[2].mA.mB[6] = (mat4x2(-2.0, -1.0, 4.0, 4.0, 8.0, 8.0, -3.0, -2.0));
	h[2].mA.mB[7] = (mat4x2(5.0, -2.0, 7.0, -1.0, -3.0, -4.0, 3.0, 2.0));
	h[3].mA.mA = (bvec3(false, false, false));
	h[3].mA.mB[0] = (mat4x2(-5.0, 6.0, -1.0, -9.0, -8.0, -4.0, 7.0, -7.0));
	h[3].mA.mB[1] = (mat4x2(9.0, -6.0, -3.0, -3.0, 4.0, -5.0, -8.0, -6.0));
	h[3].mA.mB[2] = (mat4x2(4.0, 0.0, 3.0, -2.0, 1.0, 9.0, 2.0, 0.0));
	h[3].mA.mB[3] = (mat4x2(3.0, 4.0, -3.0, 5.0, -3.0, 3.0, 2.0, 7.0));
	h[3].mA.mB[4] = (mat4x2(0.0, 0.0, 6.0, 2.0, 4.0, 7.0, -8.0, -4.0));
	h[3].mA.mB[5] = (mat4x2(3.0, -5.0, -5.0, 0.0, 1.0, 0.0, 9.0, 5.0));
	h[3].mA.mB[6] = (mat4x2(-3.0, -7.0, 9.0, -4.0, 3.0, 8.0, -5.0, -8.0));
	h[3].mA.mB[7] = (mat4x2(0.0, -5.0, 3.0, -5.0, 7.0, 2.0, -8.0, -7.0));
	h[4].mA.mA = (bvec3(false, false, true));
	h[4].mA.mB[0] = (mat4x2(0.0, -8.0, -6.0, 7.0, -1.0, -7.0, 2.0, 6.0));
	h[4].mA.mB[1] = (mat4x2(7.0, 2.0, -2.0, 9.0, -1.0, 9.0, 5.0, -8.0));
	h[4].mA.mB[2] = (mat4x2(-6.0, 2.0, -3.0, -7.0, -3.0, -8.0, 5.0, 8.0));
	h[4].mA.mB[3] = (mat4x2(8.0, -3.0, -9.0, -1.0, 8.0, -4.0, -8.0, -4.0));
	h[4].mA.mB[4] = (mat4x2(-5.0, 2.0, 2.0, -4.0, -1.0, -6.0, 0.0, 5.0));
	h[4].mA.mB[5] = (mat4x2(1.0, -3.0, 2.0, -3.0, -9.0, 2.0, -9.0, -9.0));
	h[4].mA.mB[6] = (mat4x2(-7.0, -4.0, 1.0, -8.0, 2.0, -7.0, -8.0, -6.0));
	h[4].mA.mB[7] = (mat4x2(-1.0, 3.0, 5.0, -9.0, -3.0, 8.0, -5.0, 1.0));
	h[5].mA.mA = (bvec3(true, false, true));
	h[5].mA.mB[0] = (mat4x2(7.0, -8.0, 7.0, 7.0, -6.0, 5.0, -3.0, -1.0));
	h[5].mA.mB[1] = (mat4x2(7.0, 0.0, -1.0, -8.0, 2.0, 8.0, -7.0, -4.0));
	h[5].mA.mB[2] = (mat4x2(9.0, -1.0, 2.0, 4.0, -3.0, -1.0, -2.0, -1.0));
	h[5].mA.mB[3] = (mat4x2(-7.0, 1.0, 1.0, -5.0, 9.0, -7.0, -8.0, -5.0));
	h[5].mA.mB[4] = (mat4x2(7.0, 1.0, 1.0, 0.0, -1.0, 6.0, 7.0, -5.0));
	h[5].mA.mB[5] = (mat4x2(-6.0, 6.0, 9.0, -6.0, 0.0, -1.0, 3.0, 0.0));
	h[5].mA.mB[6] = (mat4x2(-3.0, 6.0, 5.0, -6.0, -1.0, 8.0, -5.0, -4.0));
	h[5].mA.mB[7] = (mat4x2(-2.0, 3.0, 9.0, 9.0, 8.0, -2.0, 2.0, 8.0));
	h[6].mA.mA = (bvec3(false, false, true));
	h[6].mA.mB[0] = (mat4x2(-9.0, -3.0, -2.0, 9.0, 2.0, -9.0, -3.0, -8.0));
	h[6].mA.mB[1] = (mat4x2(-9.0, -8.0, 6.0, -7.0, -7.0, -3.0, 0.0, 7.0));
	h[6].mA.mB[2] = (mat4x2(1.0, -4.0, 7.0, -4.0, 4.0, -2.0, -8.0, -2.0));
	h[6].mA.mB[3] = (mat4x2(-6.0, -9.0, 3.0, 4.0, 5.0, 9.0, -4.0, 1.0));
	h[6].mA.mB[4] = (mat4x2(9.0, 5.0, -3.0, 4.0, -6.0, -1.0, 7.0, -1.0));
	h[6].mA.mB[5] = (mat4x2(1.0, 3.0, 4.0, 8.0, 6.0, -5.0, -8.0, -2.0));
	h[6].mA.mB[6] = (mat4x2(4.0, 6.0, -2.0, 3.0, -3.0, -6.0, 8.0, -5.0));
	h[6].mA.mB[7] = (mat4x2(7.0, 6.0, 5.0, -7.0, -1.0, 7.0, 1.0, 1.0));
	h[7].mA.mA = (bvec3(false, false, true));
	h[7].mA.mB[0] = (mat4x2(-4.0, -6.0, -1.0, 1.0, 5.0, 4.0, -4.0, -6.0));
	h[7].mA.mB[1] = (mat4x2(4.0, 5.0, 2.0, 5.0, 0.0, -5.0, 5.0, 9.0));
	h[7].mA.mB[2] = (mat4x2(-1.0, -6.0, -6.0, -7.0, 0.0, -9.0, 7.0, -6.0));
	h[7].mA.mB[3] = (mat4x2(-1.0, 3.0, 5.0, -6.0, 3.0, -1.0, -9.0, -9.0));
	h[7].mA.mB[4] = (mat4x2(-6.0, 3.0, 3.0, -4.0, 9.0, 3.0, 9.0, -9.0));
	h[7].mA.mB[5] = (mat4x2(-4.0, -5.0, 4.0, -7.0, -8.0, 4.0, -1.0, -5.0));
	h[7].mA.mB[6] = (mat4x2(2.0, -9.0, 0.0, 1.0, 8.0, -5.0, 4.0, -2.0));
	h[7].mA.mB[7] = (mat4x2(8.0, -1.0, 5.0, 8.0, 7.0, 9.0, 2.0, -7.0));
}
#version 450
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
	u8vec3 mA;
	mediump mat2 mB;
};
struct sB
{
	u8vec2 mA;
	highp mat2x3 mB;
};
layout(std140, binding = 1) readonly buffer BlockB
{
	sA a;
	sB b[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	mediump mat3x2 c[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	int8_t d;
	mediump uvec3 e[];
} blockD[2];
layout(std430, binding = 4) buffer BlockE
{
	lowp mat3x4 f;
	bvec4 g[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(a.mA), uvec3(8u, 0u, 0u)) && allOk;
	allOk = compare_mat2(a.mB, mat2(6.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_u8vec2(uvec2(b[0].mA), uvec2(2u, 5u)) && allOk;
	allOk = compare_mat2x3(b[0].mB, mat2x3(8.0, 0.0, 4.0, -4.0, 7.0, 2.0)) && allOk;
	allOk = compare_u8vec2(uvec2(b[1].mA), uvec2(1u, 5u)) && allOk;
	allOk = compare_mat2x3(b[1].mB, mat2x3(-1.0, 7.0, -5.0, -4.0, 3.0, -5.0)) && allOk;
	allOk = compare_u8vec2(uvec2(b[2].mA), uvec2(2u, 0u)) && allOk;
	allOk = compare_mat2x3(b[2].mB, mat2x3(-3.0, -1.0, 1.0, 0.0, -3.0, 1.0)) && allOk;
	allOk = compare_u8vec2(uvec2(b[3].mA), uvec2(0u, 3u)) && allOk;
	allOk = compare_mat2x3(b[3].mB, mat2x3(3.0, -9.0, -4.0, 3.0, 9.0, 1.0)) && allOk;
	allOk = compare_u8vec2(uvec2(b[4].mA), uvec2(0u, 7u)) && allOk;
	allOk = compare_mat2x3(b[4].mB, mat2x3(3.0, -9.0, -5.0, 9.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockC.c[0], mat3x2(1.0, -3.0, 6.0, 4.0, 0.0, -7.0)) && allOk;
	allOk = compare_uvec3((blockD[0].e[0]), uvec3(3u, 5u, 0u)) && allOk;
	allOk = compare_uvec3((blockD[0].e[1]), uvec3(8u, 7u, 2u)) && allOk;
	allOk = compare_uvec3((blockD[0].e[2]), uvec3(8u, 3u, 0u)) && allOk;
	allOk = compare_uvec3((blockD[0].e[3]), uvec3(7u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((blockD[0].e[4]), uvec3(9u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((blockD[0].e[5]), uvec3(3u, 6u, 9u)) && allOk;
	allOk = compare_uvec3((blockD[0].e[6]), uvec3(3u, 5u, 6u)) && allOk;
	allOk = compare_uvec3((blockD[1].e[0]), uvec3(6u, 9u, 5u)) && allOk;
	allOk = compare_uvec3((blockD[1].e[1]), uvec3(7u, 3u, 4u)) && allOk;
	allOk = compare_uvec3((blockD[1].e[2]), uvec3(5u, 5u, 6u)) && allOk;
	allOk = compare_uvec3((blockD[1].e[3]), uvec3(1u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((blockD[1].e[4]), uvec3(5u, 6u, 0u)) && allOk;
	allOk = compare_uvec3((blockD[1].e[5]), uvec3(5u, 4u, 5u)) && allOk;
	allOk = compare_bvec4((blockE.g[0]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((blockE.g[1]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockE.g[2]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockE.g[3]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockE.g[4]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockE.g[5]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockE.g[6]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockE.g[7]), bvec4(true, false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c[0] = (mat3x2(-8.0, 8.0, 5.0, 9.0, 6.0, 0.0));
	blockD[0].d = int8_t(4294967289);
	blockD[1].d = int8_t(4294967290);
	blockE.g[0] = (bvec4(false, false, false, false));
	blockE.g[1] = (bvec4(false, true, true, false));
	blockE.g[2] = (bvec4(true, true, true, true));
	blockE.g[3] = (bvec4(false, true, true, false));
	blockE.g[4] = (bvec4(false, false, false, false));
	blockE.g[5] = (bvec4(false, true, true, true));
	blockE.g[6] = (bvec4(true, false, false, true));
	blockE.g[7] = (bvec4(false, false, true, false));
}
#version 450
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
struct sB
{
	mediump ivec4 mA;
};
layout(scalar, binding = 1) buffer BlockB
{
	mediump mat3x4 a;
	u8vec4 b;
	highp float c;
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	mediump uvec2 d;
	sA e;
	i8vec4 f;
	mediump ivec4 g;
	lowp uvec2 h[];
};
layout(scalar, column_major, binding = 3) buffer BlockD
{
	sB i;
	mediump ivec4 j[][6];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.c), 9.0) && allOk;
	allOk = compare_uvec2((d), uvec2(3u, 4u)) && allOk;
	allOk = compare_int((e.mA), 8) && allOk;
	allOk = compare_uvec2((h[0]), uvec2(5u, 6u)) && allOk;
	allOk = compare_uvec2((h[1]), uvec2(0u, 4u)) && allOk;
	allOk = compare_uvec2((h[2]), uvec2(5u, 9u)) && allOk;
	allOk = compare_uvec2((h[3]), uvec2(4u, 5u)) && allOk;
	allOk = compare_uvec2((h[4]), uvec2(2u, 4u)) && allOk;
	allOk = compare_uvec2((h[5]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((h[6]), uvec2(6u, 1u)) && allOk;
	allOk = compare_ivec4((j[0][0]), ivec4(6, -5, 8, -8)) && allOk;
	allOk = compare_ivec4((j[0][1]), ivec4(-5, 9, 5, 3)) && allOk;
	allOk = compare_ivec4((j[0][2]), ivec4(0, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((j[0][3]), ivec4(-7, 5, -3, -9)) && allOk;
	allOk = compare_ivec4((j[0][4]), ivec4(-7, -8, 0, 3)) && allOk;
	allOk = compare_ivec4((j[0][5]), ivec4(-1, -5, -5, 2)) && allOk;
	allOk = compare_ivec4((j[1][0]), ivec4(-5, -5, 4, 2)) && allOk;
	allOk = compare_ivec4((j[1][1]), ivec4(9, 3, 6, -1)) && allOk;
	allOk = compare_ivec4((j[1][2]), ivec4(2, 9, 9, -9)) && allOk;
	allOk = compare_ivec4((j[1][3]), ivec4(7, 4, 0, -2)) && allOk;
	allOk = compare_ivec4((j[1][4]), ivec4(0, -5, 5, 0)) && allOk;
	allOk = compare_ivec4((j[1][5]), ivec4(0, 9, -5, -7)) && allOk;
	allOk = compare_ivec4((j[2][0]), ivec4(-7, 4, 0, 5)) && allOk;
	allOk = compare_ivec4((j[2][1]), ivec4(9, -1, -9, -2)) && allOk;
	allOk = compare_ivec4((j[2][2]), ivec4(-8, 6, 5, 0)) && allOk;
	allOk = compare_ivec4((j[2][3]), ivec4(-4, -9, 0, -4)) && allOk;
	allOk = compare_ivec4((j[2][4]), ivec4(-7, -5, 8, -3)) && allOk;
	allOk = compare_ivec4((j[2][5]), ivec4(-4, -8, -9, -2)) && allOk;
	allOk = compare_ivec4((j[3][0]), ivec4(-9, 7, 0, 2)) && allOk;
	allOk = compare_ivec4((j[3][1]), ivec4(1, -8, -4, -6)) && allOk;
	allOk = compare_ivec4((j[3][2]), ivec4(1, 0, -9, 8)) && allOk;
	allOk = compare_ivec4((j[3][3]), ivec4(-3, 3, 2, 0)) && allOk;
	allOk = compare_ivec4((j[3][4]), ivec4(-1, 9, 3, 3)) && allOk;
	allOk = compare_ivec4((j[3][5]), ivec4(-8, -1, 8, -8)) && allOk;
	allOk = compare_ivec4((j[4][0]), ivec4(-8, 5, -2, 2)) && allOk;
	allOk = compare_ivec4((j[4][1]), ivec4(-6, -7, 7, 1)) && allOk;
	allOk = compare_ivec4((j[4][2]), ivec4(9, -2, 3, 3)) && allOk;
	allOk = compare_ivec4((j[4][3]), ivec4(4, -9, 0, 5)) && allOk;
	allOk = compare_ivec4((j[4][4]), ivec4(6, 8, 6, -9)) && allOk;
	allOk = compare_ivec4((j[4][5]), ivec4(-5, -2, 2, -2)) && allOk;
	allOk = compare_ivec4((j[5][0]), ivec4(-2, -4, 7, -8)) && allOk;
	allOk = compare_ivec4((j[5][1]), ivec4(2, 6, -8, -6)) && allOk;
	allOk = compare_ivec4((j[5][2]), ivec4(8, 3, 6, 5)) && allOk;
	allOk = compare_ivec4((j[5][3]), ivec4(-7, 0, -4, -8)) && allOk;
	allOk = compare_ivec4((j[5][4]), ivec4(8, 1, -3, -3)) && allOk;
	allOk = compare_ivec4((j[5][5]), ivec4(4, -8, -5, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(-9.0, -9.0, 8.0, -8.0, -4.0, 0.0, 0.0, 8.0, -5.0, 7.0, 4.0, 3.0));
	blockB.b = u8vec4(uvec4(5u, 6u, 0u, 2u));
	blockB.c = (-7.0);
	d = (uvec2(1u, 4u));
	e.mA = (-8);
	f = i8vec4(ivec4(4294967291, 4294967287, 4294967295, 4294967291));
	g = (ivec4(-2, -8, 8, -2));
	h[0] = (uvec2(8u, 9u));
	h[1] = (uvec2(4u, 3u));
	h[2] = (uvec2(3u, 4u));
	h[3] = (uvec2(5u, 8u));
	h[4] = (uvec2(6u, 4u));
	h[5] = (uvec2(5u, 5u));
	h[6] = (uvec2(0u, 4u));
	i.mA = (ivec4(8, -9, -1, -4));
	j[0][0] = (ivec4(3, 5, -4, -7));
	j[0][1] = (ivec4(2, 8, -2, -4));
	j[0][2] = (ivec4(-2, -4, -5, 3));
	j[0][3] = (ivec4(-2, -3, -9, -5));
	j[0][4] = (ivec4(-7, -9, -7, 4));
	j[0][5] = (ivec4(-7, -9, 8, 4));
	j[1][0] = (ivec4(-5, -5, 2, 3));
	j[1][1] = (ivec4(-6, 7, -1, 8));
	j[1][2] = (ivec4(3, 2, -4, -1));
	j[1][3] = (ivec4(-9, 4, -9, -3));
	j[1][4] = (ivec4(-6, 6, -7, 1));
	j[1][5] = (ivec4(3, 8, -3, -9));
	j[2][0] = (ivec4(7, 3, 2, 0));
	j[2][1] = (ivec4(6, -7, 0, -6));
	j[2][2] = (ivec4(-4, -7, 5, 3));
	j[2][3] = (ivec4(4, -4, -5, -1));
	j[2][4] = (ivec4(3, -5, -7, -1));
	j[2][5] = (ivec4(4, -8, 9, -9));
	j[3][0] = (ivec4(1, 9, 3, -5));
	j[3][1] = (ivec4(-7, -4, 7, -7));
	j[3][2] = (ivec4(3, -3, -1, 9));
	j[3][3] = (ivec4(1, -9, 4, 7));
	j[3][4] = (ivec4(-7, -1, -9, 5));
	j[3][5] = (ivec4(3, 0, -6, -5));
	j[4][0] = (ivec4(-4, 3, 1, 5));
	j[4][1] = (ivec4(3, -6, -3, 0));
	j[4][2] = (ivec4(-8, 4, 7, -5));
	j[4][3] = (ivec4(7, 3, -7, 9));
	j[4][4] = (ivec4(-2, 8, -6, -6));
	j[4][5] = (ivec4(-7, -3, 8, -7));
	j[5][0] = (ivec4(-1, 0, -2, 4));
	j[5][1] = (ivec4(-2, -4, -5, -5));
	j[5][2] = (ivec4(6, -2, -8, 7));
	j[5][3] = (ivec4(2, 9, 4, -6));
	j[5][4] = (ivec4(3, 0, -4, -1));
	j[5][5] = (ivec4(6, 1, -8, -8));
}
#version 450
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
struct sB
{
	highp uvec4 mA;
	u8vec4 mB;
};
struct sC
{
	highp mat3x4 mA;
};
struct sD
{
	sC mA;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	lowp uvec2 a[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	sA b;
	mediump mat4x3 c;
	sB d[4];
	sD e[][1];
} blockC;
layout(scalar, column_major, binding = 3) readonly buffer BlockD
{
	u8vec3 f[];
} blockD[2];
layout(scalar, binding = 4) buffer BlockE
{
	i8vec2 g;
	u8vec2 h;
	bvec2 i[][5];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a[0]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((blockB.a[1]), uvec2(2u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.a[2]), uvec2(7u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.a[3]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.a[4]), uvec2(3u, 1u)) && allOk;
	allOk = compare_uvec2((blockB.a[5]), uvec2(4u, 7u)) && allOk;
	allOk = compare_mat4x3(blockC.c, mat4x3(9.0, 7.0, 8.0, -7.0, -5.0, -4.0, 9.0, -6.0, 6.0, 8.0, -3.0, 1.0)) && allOk;
	allOk = compare_uvec4((blockC.d[0].mA), uvec4(8u, 5u, 4u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.d[0].mB), uvec4(7u, 0u, 1u, 4u)) && allOk;
	allOk = compare_uvec4((blockC.d[1].mA), uvec4(9u, 7u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.d[1].mB), uvec4(4u, 2u, 8u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.d[2].mA), uvec4(6u, 2u, 7u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.d[2].mB), uvec4(0u, 8u, 6u, 8u)) && allOk;
	allOk = compare_uvec4((blockC.d[3].mA), uvec4(7u, 8u, 4u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.d[3].mB), uvec4(4u, 8u, 4u, 4u)) && allOk;
	allOk = compare_mat3x4(blockC.e[0][0].mA.mA, mat3x4(5.0, 1.0, 5.0, 6.0, 3.0, 2.0, 5.0, 2.0, -6.0, 4.0, -2.0, -2.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockE.g), ivec2(2, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec2(1u, 7u));
	blockB.a[1] = (uvec2(6u, 4u));
	blockB.a[2] = (uvec2(7u, 1u));
	blockB.a[3] = (uvec2(9u, 3u));
	blockB.a[4] = (uvec2(8u, 6u));
	blockB.a[5] = (uvec2(1u, 8u));
	blockC.b.mA = (mat4(2.0, 5.0, 2.0, 9.0, -2.0, -3.0, -8.0, 2.0, 3.0, 0.0, -2.0, 6.0, -6.0, 5.0, -1.0, -1.0));
	blockC.c = (mat4x3(-2.0, 0.0, -4.0, 2.0, -7.0, -9.0, 0.0, -3.0, 2.0, -4.0, -8.0, 3.0));
	blockC.d[0].mA = (uvec4(2u, 9u, 7u, 8u));
	blockC.d[0].mB = u8vec4(uvec4(2u, 8u, 9u, 7u));
	blockC.d[1].mA = (uvec4(8u, 9u, 4u, 4u));
	blockC.d[1].mB = u8vec4(uvec4(5u, 7u, 8u, 0u));
	blockC.d[2].mA = (uvec4(9u, 2u, 4u, 5u));
	blockC.d[2].mB = u8vec4(uvec4(0u, 3u, 7u, 1u));
	blockC.d[3].mA = (uvec4(5u, 9u, 6u, 2u));
	blockC.d[3].mB = u8vec4(uvec4(6u, 2u, 8u, 9u));
	blockC.e[0][0].mA.mA = (mat3x4(-5.0, -5.0, 7.0, -7.0, -6.0, -9.0, -8.0, 6.0, -9.0, -1.0, -9.0, -9.0));
	blockE.g = i8vec2(ivec2(4294967292, 4294967291));
	blockE.i[0][0] = (bvec2(false, false));
	blockE.i[0][1] = (bvec2(false, true));
	blockE.i[0][2] = (bvec2(true, true));
	blockE.i[0][3] = (bvec2(true, true));
	blockE.i[0][4] = (bvec2(false, true));
	blockE.i[1][0] = (bvec2(false, false));
	blockE.i[1][1] = (bvec2(false, false));
	blockE.i[1][2] = (bvec2(false, false));
	blockE.i[1][3] = (bvec2(true, false));
	blockE.i[1][4] = (bvec2(false, true));
	blockE.i[2][0] = (bvec2(true, false));
	blockE.i[2][1] = (bvec2(false, true));
	blockE.i[2][2] = (bvec2(true, true));
	blockE.i[2][3] = (bvec2(true, false));
	blockE.i[2][4] = (bvec2(false, false));
	blockE.i[3][0] = (bvec2(true, true));
	blockE.i[3][1] = (bvec2(false, false));
	blockE.i[3][2] = (bvec2(false, true));
	blockE.i[3][3] = (bvec2(false, false));
	blockE.i[3][4] = (bvec2(false, true));
	blockE.i[4][0] = (bvec2(true, true));
	blockE.i[4][1] = (bvec2(true, true));
	blockE.i[4][2] = (bvec2(false, true));
	blockE.i[4][3] = (bvec2(true, false));
	blockE.i[4][4] = (bvec2(false, true));
	blockE.i[5][0] = (bvec2(false, true));
	blockE.i[5][1] = (bvec2(true, false));
	blockE.i[5][2] = (bvec2(true, false));
	blockE.i[5][3] = (bvec2(true, false));
	blockE.i[5][4] = (bvec2(false, false));
	blockE.i[6][0] = (bvec2(false, true));
	blockE.i[6][1] = (bvec2(true, true));
	blockE.i[6][2] = (bvec2(true, true));
	blockE.i[6][3] = (bvec2(true, false));
	blockE.i[6][4] = (bvec2(false, false));
}
#version 450
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
	u8vec4 var;
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(var), uvec4(3u, 4u, 6u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], 2.0) && allOk;
	allOk = compare_float(var[0][3], 2.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], -1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-7.0, -4.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(3.0, -9.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[0][2], -3.0) && allOk;
	allOk = compare_float(var[0][3], 3.0) && allOk;
	allOk = compare_float(var[1][0], 1.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], -4.0) && allOk;
	allOk = compare_float(var[1][3], -6.0) && allOk;
	allOk = compare_float(var[2][0], -7.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], 9.0) && allOk;
	allOk = compare_float(var[2][3], -5.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-8.0, 4.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(1.0, 4.0, -4.0, -6.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-7.0, -6.0, 9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[0][3], -2.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[1][3], 4.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], -4.0) && allOk;
	allOk = compare_float(var[2][2], -5.0) && allOk;
	allOk = compare_float(var[2][3], -2.0) && allOk;
	allOk = compare_float(var[3][0], 5.0) && allOk;
	allOk = compare_float(var[3][1], 0.0) && allOk;
	allOk = compare_float(var[3][2], -8.0) && allOk;
	allOk = compare_float(var[3][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(6.0, 9.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-1.0, 0.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(2.0, -4.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(5.0, 0.0, -8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], 6.0) && allOk;
	allOk = compare_float(var[0][3], 1.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[1][3], 6.0) && allOk;
	allOk = compare_float(var[2][0], 0.0) && allOk;
	allOk = compare_float(var[2][1], -1.0) && allOk;
	allOk = compare_float(var[2][2], -3.0) && allOk;
	allOk = compare_float(var[2][3], -6.0) && allOk;
	allOk = compare_vec4(var[0], vec4(7.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(6.0, 8.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(0.0, -1.0, -3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat4(var[0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, binding = 1) readonly buffer Block
{
	u16vec3 var[3];
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(var[0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2]), uvec3(7u, 1u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat3(var[0], mat3(-9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4(var[0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(7.0, 2.0, -1.0, 1.0, 5.0, -3.0, 1.0, 4.0, -4.0, 9.0, -1.0, 3.0, -1.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(-9.0, 5.0, -4.0, 9.0, 0.0, -8.0, 3.0, -9.0, -3.0, -7.0, -2.0, -9.0, -9.0, 5.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(-8.0, 2.0, -5.0, 2.0, -4.0, 3.0, -8.0, 7.0, 2.0, -8.0, 3.0, -9.0, 2.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(3.0, 1.0, 0.0, 3.0, -2.0, -4.0, 2.0, 4.0, 9.0, -4.0, 0.0, -2.0, -9.0, 6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(-9.0, 1.0, 0.0, -6.0, 2.0, -3.0, 5.0, -9.0, -7.0, -4.0, -1.0, -8.0, 7.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(1.0, 3.0, -1.0, 1.0, 2.0, -3.0, 6.0, -8.0, 2.0, 7.0, -8.0, 5.0, -3.0, 2.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(5.0, -1.0, 9.0, -9.0, -4.0, 1.0, -2.0, 0.0, -1.0, -4.0, -4.0, -4.0, 1.0, 3.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	f16vec2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(var[0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[4]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[5]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[6]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[7]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[8]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[9]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[10]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[11]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[12]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[13]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[14]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[15]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[16]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[17]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[18]), vec2(-4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var[];
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
	allOk = compare_mat3x2(var[3], mat3x2(5.0, -5.0, -4.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(4.0, -6.0, -8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(1.0, 3.0, 6.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(-5.0, -8.0, -9.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(-8.0, 8.0, -1.0, -4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(2.0, 8.0, 8.0, -5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(-9.0, 8.0, -3.0, -8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(-5.0, 7.0, 5.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-6.0, -3.0, -1.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-5.0, -1.0, -9.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(-1.0, 6.0, 2.0, 9.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(4.0, 7.0, 5.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(1.0, -8.0, 5.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(3.0, -9.0, 0.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(5.0, -7.0, -7.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(-3.0, 8.0, 5.0, 5.0, -7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	lowp vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((block.var), vec2(-9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (vec2(2.0, 7.0));
}
#version 450
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
	highp uint var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.var), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (7u);
}
#version 450
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
	mediump uvec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((block.var), uvec4(1u, 4u, 9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec4(5u, 0u, 1u, 3u));
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x2(block.var, mat3x2(8.0, 9.0, 7.0, 1.0, -5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(7.0, 7.0));
	block.var[1] = (vec2(5.0, 7.0));
	block.var[2] = (vec2(4.0, 8.0));
}
#version 450
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
	highp uvec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((block.var), uvec4(0u, 2u, 6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec4(2u, 1u, 9u, 1u));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(5.0, -7.0, 8.0, -5.0, 5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(-9.0, 1.0, -5.0, 1.0, 5.0, -3.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[1][0], 1.0) && allOk;
	allOk = compare_float(block.var[1][1], 7.0) && allOk;
	allOk = compare_float(block.var[2][0], 5.0) && allOk;
	allOk = compare_float(block.var[2][1], -7.0) && allOk;
	allOk = compare_float(block.var[3][0], 1.0) && allOk;
	allOk = compare_float(block.var[3][1], -5.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-3.0, -6.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-5.0, 5.0, 7.0, -1.0, -3.0, 6.0, 9.0, -7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -5.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[0][2], -6.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], 3.0) && allOk;
	allOk = compare_float(block.var[1][2], -4.0) && allOk;
	allOk = compare_float(block.var[2][0], 9.0) && allOk;
	allOk = compare_float(block.var[2][1], 6.0) && allOk;
	allOk = compare_float(block.var[2][2], -6.0) && allOk;
	allOk = compare_float(block.var[3][0], 1.0) && allOk;
	allOk = compare_float(block.var[3][1], 8.0) && allOk;
	allOk = compare_float(block.var[3][2], 1.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-5.0, -7.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(9.0, 3.0, -4.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(9.0, 6.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(1.0, 8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(0.0, 7.0, -1.0, 6.0, -7.0, 7.0, -9.0, -9.0, 4.0, 1.0, 2.0, -2.0));
}
#version 450
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
	i8vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(block.var), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_float(block.var[0][0], 3.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], -8.0) && allOk;
	allOk = compare_float(block.var[1][0], -9.0) && allOk;
	allOk = compare_float(block.var[1][1], 1.0) && allOk;
	allOk = compare_float(block.var[1][2], -6.0) && allOk;
	allOk = compare_float(block.var[2][0], 6.0) && allOk;
	allOk = compare_float(block.var[2][1], 5.0) && allOk;
	allOk = compare_float(block.var[2][2], -2.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(3.0, 1.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-9.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(6.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var = (mat3(3.0, 8.0, 1.0, -9.0, -6.0, 9.0, 3.0, -3.0, -9.0));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat4(block.var, mat4(5.0, 6.0, -3.0, 3.0, 8.0, -6.0, 6.0, 4.0, 6.0, 4.0, 6.0, 4.0, 5.0, -2.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-8.0);
	block.var = (mat4(8.0, -7.0, -7.0, 5.0, 9.0, -3.0, -7.0, 6.0, -4.0, -3.0, 0.0, -4.0, -5.0, 5.0, 0.0, 8.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], -4.0) && allOk;
	allOk = compare_float(block.var[0][3], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -9.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][2], -9.0) && allOk;
	allOk = compare_float(block.var[1][3], 4.0) && allOk;
	allOk = compare_float(block.var[2][0], 7.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], -9.0) && allOk;
	allOk = compare_float(block.var[2][3], -4.0) && allOk;
	allOk = compare_float(block.var[3][0], 3.0) && allOk;
	allOk = compare_float(block.var[3][1], -6.0) && allOk;
	allOk = compare_float(block.var[3][2], -3.0) && allOk;
	allOk = compare_float(block.var[3][3], -2.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-4.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-9.0, 5.0, -9.0, 4.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(7.0, -6.0, -9.0, -4.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(3.0, -6.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0] = (vec4(5.0, -7.0, 4.0, -8.0));
	block.var[1] = (vec4(-8.0, 0.0, -6.0, 9.0));
	block.var[2] = (vec4(-2.0, 0.0, -8.0, 3.0));
	block.var[3] = (vec4(9.0, -1.0, -5.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat4(block.var, mat4(1.0, 3.0, -2.0, 5.0, -5.0, -6.0, 2.0, -1.0, 0.0, -3.0, 9.0, -3.0, -6.0, -5.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var[0] = (vec4(-5.0, -9.0, -5.0, 1.0));
	block.var[1] = (vec4(4.0, 1.0, -2.0, -6.0));
	block.var[2] = (vec4(-7.0, -7.0, -1.0, 5.0));
	block.var[3] = (vec4(-5.0, -2.0, -2.0, -9.0));
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat4x3(block.var[0], mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
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
}
#version 450
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
	i8vec2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(block.var[0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2]), ivec2(0, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i8vec2(ivec2(0, 8));
	block.var[1] = i8vec2(ivec2(4294967292, 9));
	block.var[2] = i8vec2(ivec2(4294967294, 4294967295));
}
#version 450
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
	u16vec2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(block.var[0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2]), uvec2(6u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u16vec2(uvec2(8u, 0u));
	block.var[1] = u16vec2(uvec2(6u, 0u));
	block.var[2] = u16vec2(uvec2(6u, 9u));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	block.var[1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	block.var[2] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	block.var[1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	block.var[2] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_mat2(block.var[0], mat2(3.0, -3.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(3.0, 0.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-5.0, -3.0, -4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0] = (vec2(1.0, -7.0));
	block.var[0][1] = (vec2(-1.0, 5.0));
	block.var[1][0] = (vec2(-3.0, 4.0));
	block.var[1][1] = (vec2(8.0, -2.0));
	block.var[2][0] = (vec2(-6.0, -5.0));
	block.var[2][1] = (vec2(-1.0, 3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat3(block.var[0], mat3(1.0, -5.0, -1.0, 3.0, 7.0, 4.0, 7.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(7.0, -6.0, -4.0, 7.0, -1.0, -5.0, -8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-3.0, 1.0, -3.0, -8.0, 8.0, 8.0, 2.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0] = (mat3(7.0, 5.0, 2.0, 9.0, -1.0, -9.0, -7.0, 1.0, 6.0));
	block.var[1] = (mat3(-1.0, -8.0, -8.0, 0.0, 9.0, 1.0, -5.0, 8.0, 1.0));
	block.var[2] = (mat3(-6.0, -1.0, 9.0, -6.0, 0.0, 5.0, -4.0, 5.0, -4.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(3.0, 6.0, -5.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(9.0, 2.0, 6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(-7.0, -2.0, -4.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(6.0, 8.0, -4.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(6.0, 6.0, -9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(5.0, -3.0, 6.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(-9.0, -2.0, -3.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(0.0, 2.0, -1.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(-9.0, -7.0, 7.0, 0.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(-5.0, 3.0, -2.0, -8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(1.0, -5.0, -5.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(-2.0, 0.0, 7.0, 6.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(3.0, 9.0, 1.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(-9.0, -2.0, 6.0, 8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(5.0, -2.0, 0.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(-2.0, -7.0, 9.0, 9.0, -5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	block.var[1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	block.var[2] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
	block.var[3] = (mat2x3(7.0, -4.0, 4.0, -5.0, -1.0, 0.0));
	block.var[4] = (mat2x3(2.0, -5.0, 6.0, 7.0, -2.0, 4.0));
	block.var[5] = (mat2x3(-3.0, 7.0, 6.0, -3.0, -2.0, -6.0));
	block.var[6] = (mat2x3(7.0, -3.0, 2.0, 8.0, -1.0, 2.0));
	block.var[7] = (mat2x3(2.0, -9.0, 3.0, 1.0, -7.0, -7.0));
	block.var[8] = (mat2x3(3.0, -3.0, -5.0, 4.0, -6.0, 8.0));
	block.var[9] = (mat2x3(7.0, -9.0, 2.0, -8.0, 9.0, 9.0));
	block.var[10] = (mat2x3(3.0, 5.0, 8.0, 5.0, -7.0, 6.0));
	block.var[11] = (mat2x3(3.0, 6.0, 6.0, 1.0, 2.0, -7.0));
	block.var[12] = (mat2x3(-9.0, 1.0, 2.0, -3.0, 0.0, -3.0));
	block.var[13] = (mat2x3(-2.0, 3.0, -2.0, 5.0, -6.0, -7.0));
	block.var[14] = (mat2x3(-7.0, 3.0, -4.0, -6.0, -2.0, 6.0));
	block.var[15] = (mat2x3(-7.0, -3.0, 3.0, -9.0, 3.0, 8.0));
	block.var[16] = (mat2x3(-1.0, 7.0, 4.0, -9.0, -7.0, 2.0));
	block.var[17] = (mat2x3(1.0, -7.0, -2.0, 5.0, -6.0, -6.0));
	block.var[18] = (mat2x3(-1.0, -2.0, 6.0, 9.0, 1.0, -6.0));
}
#version 450
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
	u8vec3 var[];
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
	allOk = compare_u8vec3(uvec3(block.var[3]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[4]), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[5]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[6]), uvec3(3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[7]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[8]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[9]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[10]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[11]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[12]), uvec3(8u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[13]), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[14]), uvec3(3u, 9u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[15]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[16]), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[17]), uvec3(9u, 3u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[18]), uvec3(5u, 0u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u8vec3(uvec3(4u, 5u, 9u));
	block.var[1] = u8vec3(uvec3(6u, 9u, 4u));
	block.var[2] = u8vec3(uvec3(7u, 1u, 5u));
	block.var[3] = u8vec3(uvec3(1u, 7u, 9u));
	block.var[4] = u8vec3(uvec3(3u, 4u, 3u));
	block.var[5] = u8vec3(uvec3(5u, 7u, 4u));
	block.var[6] = u8vec3(uvec3(5u, 4u, 7u));
	block.var[7] = u8vec3(uvec3(0u, 0u, 5u));
	block.var[8] = u8vec3(uvec3(2u, 5u, 5u));
	block.var[9] = u8vec3(uvec3(5u, 9u, 6u));
	block.var[10] = u8vec3(uvec3(9u, 7u, 3u));
	block.var[11] = u8vec3(uvec3(9u, 4u, 9u));
	block.var[12] = u8vec3(uvec3(5u, 7u, 3u));
	block.var[13] = u8vec3(uvec3(9u, 8u, 1u));
	block.var[14] = u8vec3(uvec3(6u, 2u, 7u));
	block.var[15] = u8vec3(uvec3(0u, 2u, 7u));
	block.var[16] = u8vec3(uvec3(4u, 8u, 8u));
	block.var[17] = u8vec3(uvec3(6u, 1u, 2u));
	block.var[18] = u8vec3(uvec3(3u, 6u, 6u));
}
#version 450
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
	highp int var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.var[0]), 6) && allOk;
	allOk = compare_int((block.var[1]), 0) && allOk;
	allOk = compare_int((block.var[2]), 9) && allOk;
	allOk = compare_int((block.var[3]), -6) && allOk;
	allOk = compare_int((block.var[4]), -9) && allOk;
	allOk = compare_int((block.var[5]), -8) && allOk;
	allOk = compare_int((block.var[6]), 8) && allOk;
	allOk = compare_int((block.var[7]), -9) && allOk;
	allOk = compare_int((block.var[8]), -1) && allOk;
	allOk = compare_int((block.var[9]), 0) && allOk;
	allOk = compare_int((block.var[10]), -9) && allOk;
	allOk = compare_int((block.var[11]), 5) && allOk;
	allOk = compare_int((block.var[12]), 5) && allOk;
	allOk = compare_int((block.var[13]), -3) && allOk;
	allOk = compare_int((block.var[14]), 4) && allOk;
	allOk = compare_int((block.var[15]), 4) && allOk;
	allOk = compare_int((block.var[16]), -9) && allOk;
	allOk = compare_int((block.var[17]), -9) && allOk;
	allOk = compare_int((block.var[18]), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (8);
	block.var[1] = (2);
	block.var[2] = (-5);
	block.var[3] = (0);
	block.var[4] = (-7);
	block.var[5] = (-7);
	block.var[6] = (-8);
	block.var[7] = (6);
	block.var[8] = (-6);
	block.var[9] = (6);
	block.var[10] = (-5);
	block.var[11] = (5);
	block.var[12] = (-4);
	block.var[13] = (9);
	block.var[14] = (-8);
	block.var[15] = (4);
	block.var[16] = (-4);
	block.var[17] = (5);
	block.var[18] = (-3);
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(5.0, -7.0, 2.0, -4.0, -1.0, -2.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(5.0, -7.0, 6.0, 5.0, 2.0, -2.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(1.0, -3.0, 4.0, 0.0, -1.0, 8.0, 6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(2.0, 7.0, -2.0, 3.0, 3.0, -2.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(9.0, 4.0, -5.0, 1.0, 0.0, -1.0, -5.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(9.0, 4.0, -9.0, 4.0, 7.0, -5.0, 6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(-3.0, -5.0, 8.0, -6.0, -4.0, -4.0, 7.0, -9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(8.0, 3.0, 9.0));
	block.var[0][1] = (vec3(6.0, 2.0, -9.0));
	block.var[0][2] = (vec3(-8.0, 5.0, 2.0));
	block.var[1][0] = (vec3(3.0, -3.0, -4.0));
	block.var[1][1] = (vec3(2.0, -9.0, -5.0));
	block.var[1][2] = (vec3(5.0, 8.0, 8.0));
	block.var[2][0] = (vec3(-5.0, -3.0, -3.0));
	block.var[2][1] = (vec3(3.0, -5.0, -4.0));
	block.var[2][2] = (vec3(-7.0, 5.0, 3.0));
	block.var[3][0] = (vec3(-8.0, 7.0, 8.0));
	block.var[3][1] = (vec3(8.0, 2.0, -9.0));
	block.var[3][2] = (vec3(-3.0, 6.0, -3.0));
	block.var[4][0] = (vec3(7.0, -3.0, 6.0));
	block.var[4][1] = (vec3(-7.0, 6.0, -7.0));
	block.var[4][2] = (vec3(2.0, 3.0, -3.0));
	block.var[5][0] = (vec3(-1.0, -5.0, -1.0));
	block.var[5][1] = (vec3(8.0, 4.0, -3.0));
	block.var[5][2] = (vec3(8.0, -6.0, 4.0));
	block.var[6][0] = (vec3(5.0, 9.0, -7.0));
	block.var[6][1] = (vec3(1.0, -3.0, -7.0));
	block.var[6][2] = (vec3(-5.0, 4.0, 1.0));
	block.var[7][0] = (vec3(-3.0, -5.0, -8.0));
	block.var[7][1] = (vec3(-5.0, 6.0, 2.0));
	block.var[7][2] = (vec3(-9.0, -9.0, -1.0));
	block.var[8][0] = (vec3(2.0, 8.0, -8.0));
	block.var[8][1] = (vec3(-6.0, 0.0, 3.0));
	block.var[8][2] = (vec3(9.0, -8.0, 3.0));
	block.var[9][0] = (vec3(-9.0, 9.0, 2.0));
	block.var[9][1] = (vec3(6.0, -4.0, -8.0));
	block.var[9][2] = (vec3(3.0, 8.0, 1.0));
	block.var[10][0] = (vec3(-9.0, -5.0, -7.0));
	block.var[10][1] = (vec3(-4.0, -1.0, -4.0));
	block.var[10][2] = (vec3(-6.0, 4.0, 9.0));
	block.var[11][0] = (vec3(-3.0, -9.0, 0.0));
	block.var[11][1] = (vec3(-9.0, -5.0, -9.0));
	block.var[11][2] = (vec3(-1.0, -9.0, 7.0));
	block.var[12][0] = (vec3(-4.0, 8.0, 7.0));
	block.var[12][1] = (vec3(1.0, 7.0, -5.0));
	block.var[12][2] = (vec3(7.0, 9.0, 4.0));
	block.var[13][0] = (vec3(-2.0, 2.0, 1.0));
	block.var[13][1] = (vec3(-8.0, -6.0, 7.0));
	block.var[13][2] = (vec3(-3.0, 2.0, -5.0));
	block.var[14][0] = (vec3(-6.0, 6.0, -7.0));
	block.var[14][1] = (vec3(1.0, 3.0, -7.0));
	block.var[14][2] = (vec3(6.0, -8.0, 4.0));
	block.var[15][0] = (vec3(-3.0, -8.0, 3.0));
	block.var[15][1] = (vec3(-5.0, -8.0, 8.0));
	block.var[15][2] = (vec3(7.0, 2.0, -3.0));
	block.var[16][0] = (vec3(3.0, -1.0, -6.0));
	block.var[16][1] = (vec3(-1.0, 6.0, 7.0));
	block.var[16][2] = (vec3(9.0, -1.0, 2.0));
	block.var[17][0] = (vec3(-9.0, -6.0, 9.0));
	block.var[17][1] = (vec3(4.0, 9.0, 5.0));
	block.var[17][2] = (vec3(5.0, 4.0, -9.0));
	block.var[18][0] = (vec3(3.0, 3.0, 8.0));
	block.var[18][1] = (vec3(1.0, -2.0, 0.0));
	block.var[18][2] = (vec3(-9.0, 5.0, 1.0));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x3(block.var[0], mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(-6.0, 8.0, -3.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(6.0, -2.0, -7.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(7.0, -3.0, 2.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(7.0, -9.0, 0.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(5.0, 3.0, 9.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(5.0, -3.0, 6.0, 8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(9.0, 5.0, 6.0, 7.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(1.0, 9.0, 5.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(1.0, 6.0, -5.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(1.0, -3.0, -1.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(-2.0, 8.0, 1.0, 6.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(2.0, 5.0, 0.0, -6.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(9.0, 7.0, -7.0, 4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(3.0, 7.0, 0.0, -3.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(9.0, 5.0, -9.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(-3.0, -8.0, -3.0, 7.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(0.0, 5.0, 5.0));
	block.var[0][1] = (vec3(0.0, -7.0, 8.0));
	block.var[1][0] = (vec3(-7.0, -4.0, 6.0));
	block.var[1][1] = (vec3(1.0, 3.0, 2.0));
	block.var[2][0] = (vec3(-6.0, 5.0, 2.0));
	block.var[2][1] = (vec3(1.0, 8.0, -8.0));
	block.var[3][0] = (vec3(2.0, -7.0, 5.0));
	block.var[3][1] = (vec3(-4.0, -6.0, -9.0));
	block.var[4][0] = (vec3(3.0, 0.0, -7.0));
	block.var[4][1] = (vec3(2.0, -4.0, 1.0));
	block.var[5][0] = (vec3(-2.0, -2.0, -5.0));
	block.var[5][1] = (vec3(2.0, 5.0, 4.0));
	block.var[6][0] = (vec3(4.0, -1.0, 7.0));
	block.var[6][1] = (vec3(9.0, -2.0, -4.0));
	block.var[7][0] = (vec3(8.0, -4.0, 2.0));
	block.var[7][1] = (vec3(5.0, -1.0, -3.0));
	block.var[8][0] = (vec3(3.0, -2.0, -8.0));
	block.var[8][1] = (vec3(6.0, 0.0, 9.0));
	block.var[9][0] = (vec3(1.0, -5.0, -1.0));
	block.var[9][1] = (vec3(-6.0, -6.0, 3.0));
	block.var[10][0] = (vec3(1.0, -8.0, -5.0));
	block.var[10][1] = (vec3(8.0, 5.0, 8.0));
	block.var[11][0] = (vec3(5.0, 5.0, 7.0));
	block.var[11][1] = (vec3(-9.0, 8.0, 0.0));
	block.var[12][0] = (vec3(8.0, 7.0, -1.0));
	block.var[12][1] = (vec3(-6.0, 1.0, -2.0));
	block.var[13][0] = (vec3(8.0, -6.0, -8.0));
	block.var[13][1] = (vec3(9.0, -5.0, 5.0));
	block.var[14][0] = (vec3(-8.0, 1.0, -3.0));
	block.var[14][1] = (vec3(-4.0, -5.0, 1.0));
	block.var[15][0] = (vec3(4.0, -2.0, -5.0));
	block.var[15][1] = (vec3(-9.0, -8.0, -5.0));
	block.var[16][0] = (vec3(5.0, 9.0, 6.0));
	block.var[16][1] = (vec3(7.0, 5.0, 7.0));
	block.var[17][0] = (vec3(0.0, 9.0, -4.0));
	block.var[17][1] = (vec3(7.0, -3.0, 7.0));
	block.var[18][0] = (vec3(5.0, -5.0, 1.0));
	block.var[18][1] = (vec3(9.0, 2.0, -6.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(6.0, -5.0, -6.0, 6.0, 3.0, -1.0, 3.0, 3.0, 7.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(-8.0, 2.0, 5.0, -7.0, 6.0, -6.0, -4.0, 3.0, 5.0, 1.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(-3.0, 2.0, 2.0, -2.0, -2.0, 2.0, 5.0, 6.0, 3.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(-8.0, -7.0, 6.0, 1.0, 0.0, -2.0, -9.0, 5.0, 0.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(9.0, 5.0, 6.0, 9.0, -3.0, -5.0, -4.0, -2.0, 3.0, -9.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(5.0, -9.0, -3.0, 8.0, -8.0, 6.0, 6.0, 8.0, -6.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(9.0, 7.0, 1.0, 2.0, 8.0, 4.0, 2.0, -2.0, 1.0, 2.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	block.var[1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	block.var[2] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	block.var[3] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	block.var[4] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	block.var[5] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	block.var[6] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	block.var[7] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	block.var[8] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	block.var[9] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	block.var[10] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	block.var[11] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
	block.var[12] = (mat4x3(-6.0, 9.0, 3.0, 4.0, 2.0, -2.0, -4.0, 3.0, 0.0, 4.0, -2.0, 0.0));
	block.var[13] = (mat4x3(6.0, -8.0, 4.0, 9.0, 3.0, 0.0, -8.0, -3.0, 5.0, 5.0, 7.0, 7.0));
	block.var[14] = (mat4x3(-1.0, -4.0, -7.0, -7.0, 7.0, 9.0, -7.0, 3.0, 7.0, -6.0, -6.0, 8.0));
	block.var[15] = (mat4x3(7.0, -7.0, -8.0, -3.0, 8.0, -1.0, -8.0, 2.0, -9.0, 9.0, 0.0, -7.0));
	block.var[16] = (mat4x3(-4.0, -2.0, 9.0, 2.0, -9.0, 7.0, 0.0, -4.0, 0.0, -3.0, 4.0, -6.0));
	block.var[17] = (mat4x3(9.0, -7.0, 9.0, 4.0, -8.0, 9.0, 0.0, -6.0, -6.0, 4.0, 4.0, 3.0));
	block.var[18] = (mat4x3(-9.0, -6.0, -4.0, -8.0, 0.0, 1.0, -9.0, -8.0, 1.0, 6.0, 3.0, -7.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0], mat4(5.0, 8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(-6.0, -5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(-1.0, -6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(-9.0, -1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(-2.0, 7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(-9.0, 9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(1.0, 8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(4.0, -6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(9.0, -9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(6.0, 1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(-3.0, 2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(-1.0, -3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	block.var[0][1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	block.var[0][2] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
	block.var[1][0] = (mat4(-3.0, -9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0));
	block.var[1][1] = (mat4(1.0, 5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0));
	block.var[1][2] = (mat4(-7.0, 5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0));
	block.var[2][0] = (mat4(6.0, -8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0));
	block.var[2][1] = (mat4(6.0, 9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0));
	block.var[2][2] = (mat4(6.0, -6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0));
	block.var[3][0] = (mat4(-5.0, 3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0));
	block.var[3][1] = (mat4(-9.0, 5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0));
	block.var[3][2] = (mat4(5.0, -1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	block.var[0][1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	block.var[0][2] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	block.var[1][0] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	block.var[1][1] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	block.var[1][2] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	block.var[2][0] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	block.var[2][1] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	block.var[2][2] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	block.var[3][0] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	block.var[3][1] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	block.var[3][2] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(-5.0, 7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(-9.0, 6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(-9.0, 7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(-8.0, 1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(-9.0, 9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(-5.0, -8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(8.0, 4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(7.0, -3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(9.0, 2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	block.var[0][0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	block.var[0][0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	block.var[0][1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	block.var[0][1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	block.var[0][1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	block.var[0][2][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	block.var[0][2][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	block.var[0][2][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
	block.var[1][0][0] = (vec4(8.0, -2.0, 1.0, 1.0));
	block.var[1][0][1] = (vec4(-6.0, -1.0, -9.0, 6.0));
	block.var[1][0][2] = (vec4(7.0, -1.0, 1.0, -8.0));
	block.var[1][1][0] = (vec4(6.0, 8.0, -2.0, 7.0));
	block.var[1][1][1] = (vec4(1.0, -6.0, -3.0, 9.0));
	block.var[1][1][2] = (vec4(1.0, -6.0, 1.0, -6.0));
	block.var[1][2][0] = (vec4(3.0, -1.0, 5.0, -2.0));
	block.var[1][2][1] = (vec4(7.0, -1.0, -2.0, -3.0));
	block.var[1][2][2] = (vec4(-6.0, 4.0, -4.0, -1.0));
	block.var[2][0][0] = (vec4(-3.0, -3.0, 3.0, -7.0));
	block.var[2][0][1] = (vec4(2.0, 8.0, -4.0, 1.0));
	block.var[2][0][2] = (vec4(-1.0, 6.0, -4.0, 7.0));
	block.var[2][1][0] = (vec4(5.0, -8.0, -2.0, 6.0));
	block.var[2][1][1] = (vec4(-2.0, 8.0, -2.0, 2.0));
	block.var[2][1][2] = (vec4(3.0, 7.0, 0.0, 2.0));
	block.var[2][2][0] = (vec4(3.0, 9.0, 8.0, 5.0));
	block.var[2][2][1] = (vec4(2.0, -3.0, -7.0, 2.0));
	block.var[2][2][2] = (vec4(-1.0, 1.0, -4.0, -1.0));
	block.var[3][0][0] = (vec4(-6.0, -4.0, -1.0, -3.0));
	block.var[3][0][1] = (vec4(-8.0, 5.0, -4.0, -9.0));
	block.var[3][0][2] = (vec4(8.0, 3.0, -8.0, 0.0));
	block.var[3][1][0] = (vec4(7.0, -2.0, 0.0, 8.0));
	block.var[3][1][1] = (vec4(-9.0, 2.0, -3.0, -7.0));
	block.var[3][1][2] = (vec4(-5.0, 3.0, 9.0, -6.0));
	block.var[3][2][0] = (vec4(-7.0, -8.0, -8.0, -7.0));
	block.var[3][2][1] = (vec4(-9.0, 2.0, 4.0, -7.0));
	block.var[3][2][2] = (vec4(8.0, -7.0, 4.0, -8.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-4.0, -7.0, 7.0, -5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(3.0, -3.0, 0.0, 8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(6.0, 2.0, -1.0, -6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(-9.0, -5.0, -9.0, 1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(-7.0, -4.0, 0.0, 2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(-7.0, 4.0, 9.0, 8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(0.0, -9.0, -1.0, 9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(5.0, -5.0, -1.0, -9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(-3.0, 1.0, 7.0, -9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	block.var[0][1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	block.var[0][2] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
	block.var[1][0] = (mat4x3(9.0, -7.0, -4.0, -3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0));
	block.var[1][1] = (mat4x3(9.0, 0.0, 0.0, 7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0));
	block.var[1][2] = (mat4x3(-4.0, 1.0, 3.0, -5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0));
	block.var[2][0] = (mat4x3(-8.0, -3.0, -8.0, -5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0));
	block.var[2][1] = (mat4x3(8.0, -8.0, -9.0, 9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0));
	block.var[2][2] = (mat4x3(-8.0, 9.0, 8.0, -9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0));
	block.var[3][0] = (mat4x3(8.0, -3.0, -6.0, 2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0));
	block.var[3][1] = (mat4x3(1.0, -6.0, -5.0, -5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0));
	block.var[3][2] = (mat4x3(-4.0, 8.0, 5.0, -4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0));
}
#version 450
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
	f16vec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(block.var[0][0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][2]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][2]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][2]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][0]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][1]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][2]), vec2(1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = f16vec2(vec2(-2.0, 4.0));
	block.var[0][1] = f16vec2(vec2(-2.0, 4.0));
	block.var[0][2] = f16vec2(vec2(-1.0, 1.0));
	block.var[1][0] = f16vec2(vec2(9.0, 4.0));
	block.var[1][1] = f16vec2(vec2(8.0, -8.0));
	block.var[1][2] = f16vec2(vec2(1.0, -3.0));
	block.var[2][0] = f16vec2(vec2(2.0, 2.0));
	block.var[2][1] = f16vec2(vec2(-6.0, 5.0));
	block.var[2][2] = f16vec2(vec2(5.0, -7.0));
	block.var[3][0] = f16vec2(vec2(3.0, 0.0));
	block.var[3][1] = f16vec2(vec2(-2.0, 3.0));
	block.var[3][2] = f16vec2(vec2(-6.0, 5.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	u16vec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(block.var[0][0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][2]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][0]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][1]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][2]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][0]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][1]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][2]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][0]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][1]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][2]), uvec3(3u, 6u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = u16vec3(uvec3(1u, 2u, 6u));
	block.var[0][1] = u16vec3(uvec3(8u, 3u, 3u));
	block.var[0][2] = u16vec3(uvec3(4u, 4u, 9u));
	block.var[1][0] = u16vec3(uvec3(7u, 5u, 4u));
	block.var[1][1] = u16vec3(uvec3(5u, 6u, 5u));
	block.var[1][2] = u16vec3(uvec3(7u, 0u, 6u));
	block.var[2][0] = u16vec3(uvec3(4u, 7u, 0u));
	block.var[2][1] = u16vec3(uvec3(4u, 2u, 1u));
	block.var[2][2] = u16vec3(uvec3(0u, 2u, 8u));
	block.var[3][0] = u16vec3(uvec3(0u, 7u, 0u));
	block.var[3][1] = u16vec3(uvec3(2u, 8u, 7u));
	block.var[3][2] = u16vec3(uvec3(1u, 2u, 8u));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_mat2(block.var[0][0], mat2(3.0, -3.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(3.0, 0.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(-5.0, -3.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(8.0, -5.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(-4.0, -5.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(1.0, 3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(-4.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(-4.0, 5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(-3.0, 2.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(-6.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(1.0, -5.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(3.0, 7.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0][0] = (vec2(1.0, -7.0));
	block.var[0][0][1] = (vec2(-1.0, 5.0));
	block.var[0][1][0] = (vec2(-3.0, 4.0));
	block.var[0][1][1] = (vec2(8.0, -2.0));
	block.var[0][2][0] = (vec2(-6.0, -5.0));
	block.var[0][2][1] = (vec2(-1.0, 3.0));
	block.var[1][0][0] = (vec2(4.0, -8.0));
	block.var[1][0][1] = (vec2(6.0, 6.0));
	block.var[1][1][0] = (vec2(-2.0, 1.0));
	block.var[1][1][1] = (vec2(3.0, 2.0));
	block.var[1][2][0] = (vec2(1.0, 7.0));
	block.var[1][2][1] = (vec2(-2.0, -4.0));
	block.var[2][0][0] = (vec2(2.0, -1.0));
	block.var[2][0][1] = (vec2(-4.0, -5.0));
	block.var[2][1][0] = (vec2(-8.0, 3.0));
	block.var[2][1][1] = (vec2(-7.0, 5.0));
	block.var[2][2][0] = (vec2(0.0, -4.0));
	block.var[2][2][1] = (vec2(-9.0, 9.0));
	block.var[3][0][0] = (vec2(1.0, 7.0));
	block.var[3][0][1] = (vec2(9.0, 1.0));
	block.var[3][1][0] = (vec2(3.0, -3.0));
	block.var[3][1][1] = (vec2(7.0, 1.0));
	block.var[3][2][0] = (vec2(5.0, 4.0));
	block.var[3][2][1] = (vec2(1.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(4.0, 7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-6.0, 0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-1.0, 7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-7.0, 9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(6.0, -8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-1.0, -3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-2.0, -2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(-1.0, -1.0, -5.0, 9.0, -1.0, -8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(7.0, 6.0, 2.0, -6.0, 9.0, -8.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(9.0, 4.0, -9.0, -9.0, -7.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(3.0, -5.0, -6.0, 1.0, 6.0, -7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(4.0, -4.0, -5.0, -1.0, -7.0, 6.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	block.var[0][0][0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	block.var[0][0][1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	block.var[0][0][1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	block.var[0][0][2][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	block.var[0][0][2][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	block.var[0][1][0][0] = (vec4(-7.0, 4.0, -9.0, 1.0));
	block.var[0][1][0][1] = (vec4(0.0, -5.0, 6.0, -3.0));
	block.var[0][1][1][0] = (vec4(-9.0, -4.0, 8.0, -1.0));
	block.var[0][1][1][1] = (vec4(7.0, -1.0, -9.0, -2.0));
	block.var[0][1][2][0] = (vec4(-9.0, -6.0, -1.0, -3.0));
	block.var[0][1][2][1] = (vec4(6.0, -6.0, 2.0, 1.0));
	block.var[1][0][0][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	block.var[1][0][0][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	block.var[1][0][1][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	block.var[1][0][1][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	block.var[1][0][2][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	block.var[1][0][2][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	block.var[1][1][0][0] = (vec4(-3.0, -3.0, -5.0, -1.0));
	block.var[1][1][0][1] = (vec4(4.0, 0.0, -9.0, -1.0));
	block.var[1][1][1][0] = (vec4(1.0, -2.0, 4.0, -4.0));
	block.var[1][1][1][1] = (vec4(3.0, -9.0, 0.0, -4.0));
	block.var[1][1][2][0] = (vec4(-7.0, 7.0, 9.0, -2.0));
	block.var[1][1][2][1] = (vec4(5.0, -3.0, -5.0, 5.0));
	block.var[2][0][0][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	block.var[2][0][0][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	block.var[2][0][1][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	block.var[2][0][1][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	block.var[2][0][2][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	block.var[2][0][2][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	block.var[2][1][0][0] = (vec4(-2.0, 4.0, 0.0, -2.0));
	block.var[2][1][0][1] = (vec4(9.0, -8.0, 7.0, 0.0));
	block.var[2][1][1][0] = (vec4(-8.0, 7.0, 0.0, 3.0));
	block.var[2][1][1][1] = (vec4(1.0, -9.0, -3.0, -8.0));
	block.var[2][1][2][0] = (vec4(1.0, 2.0, -4.0, -3.0));
	block.var[2][1][2][1] = (vec4(6.0, -7.0, 1.0, 0.0));
	block.var[3][0][0][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	block.var[3][0][0][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	block.var[3][0][1][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	block.var[3][0][1][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	block.var[3][0][2][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	block.var[3][0][2][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
	block.var[3][1][0][0] = (vec4(-8.0, 1.0, -9.0, 2.0));
	block.var[3][1][0][1] = (vec4(9.0, 1.0, 2.0, -7.0));
	block.var[3][1][1][0] = (vec4(9.0, -9.0, -9.0, -8.0));
	block.var[3][1][1][1] = (vec4(-5.0, 8.0, 3.0, -6.0));
	block.var[3][1][2][0] = (vec4(-2.0, -3.0, 3.0, -1.0));
	block.var[3][1][2][1] = (vec4(8.0, 7.0, -4.0, -8.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-6.0, 3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-9.0, -3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(-1.0, 1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(8.0, 8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(1.0, 4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(0.0, 7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(1.0, 5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(1.0, -3.0, 5.0, -1.0, 9.0, -5.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(-9.0, -3.0, 6.0, -4.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(6.0, 6.0, -3.0, -8.0, 8.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(2.0, 8.0, 1.0, -5.0, 6.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(-6.0, -9.0, 5.0, 1.0, -8.0, 1.0, -6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(2.0, -4.0));
	block.var[0][0][0][1] = (vec2(-5.0, 3.0));
	block.var[0][0][0][2] = (vec2(7.0, 1.0));
	block.var[0][0][0][3] = (vec2(8.0, -5.0));
	block.var[0][0][1][0] = (vec2(7.0, -3.0));
	block.var[0][0][1][1] = (vec2(1.0, -6.0));
	block.var[0][0][1][2] = (vec2(9.0, -3.0));
	block.var[0][0][1][3] = (vec2(1.0, -5.0));
	block.var[0][0][2][0] = (vec2(-8.0, 4.0));
	block.var[0][0][2][1] = (vec2(5.0, -9.0));
	block.var[0][0][2][2] = (vec2(1.0, -5.0));
	block.var[0][0][2][3] = (vec2(-4.0, -2.0));
	block.var[0][1][0][0] = (vec2(4.0, 2.0));
	block.var[0][1][0][1] = (vec2(-4.0, 1.0));
	block.var[0][1][0][2] = (vec2(5.0, -7.0));
	block.var[0][1][0][3] = (vec2(5.0, 5.0));
	block.var[0][1][1][0] = (vec2(-5.0, 1.0));
	block.var[0][1][1][1] = (vec2(-7.0, -3.0));
	block.var[0][1][1][2] = (vec2(-1.0, 1.0));
	block.var[0][1][1][3] = (vec2(4.0, 7.0));
	block.var[0][1][2][0] = (vec2(-9.0, 1.0));
	block.var[0][1][2][1] = (vec2(-6.0, 7.0));
	block.var[0][1][2][2] = (vec2(8.0, -7.0));
	block.var[0][1][2][3] = (vec2(2.0, 1.0));
	block.var[1][0][0][0] = (vec2(6.0, -1.0));
	block.var[1][0][0][1] = (vec2(-7.0, -5.0));
	block.var[1][0][0][2] = (vec2(-2.0, -8.0));
	block.var[1][0][0][3] = (vec2(1.0, 3.0));
	block.var[1][0][1][0] = (vec2(4.0, 2.0));
	block.var[1][0][1][1] = (vec2(-9.0, 2.0));
	block.var[1][0][1][2] = (vec2(-3.0, 3.0));
	block.var[1][0][1][3] = (vec2(0.0, 1.0));
	block.var[1][0][2][0] = (vec2(-5.0, -9.0));
	block.var[1][0][2][1] = (vec2(2.0, -2.0));
	block.var[1][0][2][2] = (vec2(-3.0, 0.0));
	block.var[1][0][2][3] = (vec2(9.0, 6.0));
	block.var[1][1][0][0] = (vec2(-7.0, 4.0));
	block.var[1][1][0][1] = (vec2(-4.0, 4.0));
	block.var[1][1][0][2] = (vec2(0.0, 7.0));
	block.var[1][1][0][3] = (vec2(7.0, -1.0));
	block.var[1][1][1][0] = (vec2(0.0, -2.0));
	block.var[1][1][1][1] = (vec2(-8.0, 2.0));
	block.var[1][1][1][2] = (vec2(8.0, -1.0));
	block.var[1][1][1][3] = (vec2(5.0, 2.0));
	block.var[1][1][2][0] = (vec2(4.0, 1.0));
	block.var[1][1][2][1] = (vec2(-6.0, 7.0));
	block.var[1][1][2][2] = (vec2(-7.0, 1.0));
	block.var[1][1][2][3] = (vec2(2.0, -4.0));
	block.var[2][0][0][0] = (vec2(3.0, -4.0));
	block.var[2][0][0][1] = (vec2(2.0, -3.0));
	block.var[2][0][0][2] = (vec2(6.0, 5.0));
	block.var[2][0][0][3] = (vec2(0.0, -2.0));
	block.var[2][0][1][0] = (vec2(-3.0, -2.0));
	block.var[2][0][1][1] = (vec2(-7.0, 3.0));
	block.var[2][0][1][2] = (vec2(-6.0, 2.0));
	block.var[2][0][1][3] = (vec2(9.0, 6.0));
	block.var[2][0][2][0] = (vec2(-4.0, 4.0));
	block.var[2][0][2][1] = (vec2(0.0, -3.0));
	block.var[2][0][2][2] = (vec2(-7.0, 0.0));
	block.var[2][0][2][3] = (vec2(-9.0, 1.0));
	block.var[2][1][0][0] = (vec2(-8.0, -5.0));
	block.var[2][1][0][1] = (vec2(8.0, -8.0));
	block.var[2][1][0][2] = (vec2(7.0, -2.0));
	block.var[2][1][0][3] = (vec2(-7.0, -7.0));
	block.var[2][1][1][0] = (vec2(6.0, -1.0));
	block.var[2][1][1][1] = (vec2(0.0, -4.0));
	block.var[2][1][1][2] = (vec2(-5.0, -3.0));
	block.var[2][1][1][3] = (vec2(-7.0, -5.0));
	block.var[2][1][2][0] = (vec2(-7.0, -7.0));
	block.var[2][1][2][1] = (vec2(-6.0, -7.0));
	block.var[2][1][2][2] = (vec2(3.0, 1.0));
	block.var[2][1][2][3] = (vec2(9.0, -1.0));
	block.var[3][0][0][0] = (vec2(7.0, 2.0));
	block.var[3][0][0][1] = (vec2(1.0, 9.0));
	block.var[3][0][0][2] = (vec2(-3.0, 3.0));
	block.var[3][0][0][3] = (vec2(-7.0, 9.0));
	block.var[3][0][1][0] = (vec2(-4.0, -1.0));
	block.var[3][0][1][1] = (vec2(3.0, 6.0));
	block.var[3][0][1][2] = (vec2(8.0, 3.0));
	block.var[3][0][1][3] = (vec2(1.0, 5.0));
	block.var[3][0][2][0] = (vec2(7.0, 0.0));
	block.var[3][0][2][1] = (vec2(0.0, -2.0));
	block.var[3][0][2][2] = (vec2(3.0, -7.0));
	block.var[3][0][2][3] = (vec2(-3.0, 1.0));
	block.var[3][1][0][0] = (vec2(-5.0, 4.0));
	block.var[3][1][0][1] = (vec2(6.0, 6.0));
	block.var[3][1][0][2] = (vec2(-4.0, -7.0));
	block.var[3][1][0][3] = (vec2(1.0, -7.0));
	block.var[3][1][1][0] = (vec2(-5.0, 3.0));
	block.var[3][1][1][1] = (vec2(-7.0, -3.0));
	block.var[3][1][1][2] = (vec2(-6.0, 7.0));
	block.var[3][1][1][3] = (vec2(-4.0, 1.0));
	block.var[3][1][2][0] = (vec2(-7.0, -7.0));
	block.var[3][1][2][1] = (vec2(0.0, 4.0));
	block.var[3][1][2][2] = (vec2(4.0, -9.0));
	block.var[3][1][2][3] = (vec2(-5.0, -8.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(5.0, -7.0, 2.0, -4.0, -1.0, -2.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(5.0, -7.0, 6.0, 5.0, 2.0, -2.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(1.0, -3.0, 4.0, 0.0, -1.0, 8.0, 6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(2.0, 7.0, -2.0, 3.0, 3.0, -2.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(9.0, 4.0, -5.0, 1.0, 0.0, -1.0, -5.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(9.0, 4.0, -9.0, 4.0, 7.0, -5.0, 6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-3.0, -5.0, 8.0, -6.0, -4.0, -4.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(-5.0, 4.0, 8.0, -2.0, -6.0, -6.0, 1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(6.0, -1.0, 4.0, 5.0, 0.0, 4.0, 4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(5.0, -1.0, -1.0, -6.0, 5.0, -7.0, -5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(-7.0, 8.0, 7.0, 6.0, 0.0, 5.0, 6.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(-2.0, 7.0, 3.0, -6.0, -7.0, -9.0, -5.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(8.0, 3.0, 9.0));
	block.var[0][0][0][1] = (vec3(6.0, 2.0, -9.0));
	block.var[0][0][0][2] = (vec3(-8.0, 5.0, 2.0));
	block.var[0][0][1][0] = (vec3(3.0, -3.0, -4.0));
	block.var[0][0][1][1] = (vec3(2.0, -9.0, -5.0));
	block.var[0][0][1][2] = (vec3(5.0, 8.0, 8.0));
	block.var[0][0][2][0] = (vec3(-5.0, -3.0, -3.0));
	block.var[0][0][2][1] = (vec3(3.0, -5.0, -4.0));
	block.var[0][0][2][2] = (vec3(-7.0, 5.0, 3.0));
	block.var[0][1][0][0] = (vec3(-4.0, 8.0, 7.0));
	block.var[0][1][0][1] = (vec3(1.0, 7.0, -5.0));
	block.var[0][1][0][2] = (vec3(7.0, 9.0, 4.0));
	block.var[0][1][1][0] = (vec3(-2.0, 2.0, 1.0));
	block.var[0][1][1][1] = (vec3(-8.0, -6.0, 7.0));
	block.var[0][1][1][2] = (vec3(-3.0, 2.0, -5.0));
	block.var[0][1][2][0] = (vec3(-6.0, 6.0, -7.0));
	block.var[0][1][2][1] = (vec3(1.0, 3.0, -7.0));
	block.var[0][1][2][2] = (vec3(6.0, -8.0, 4.0));
	block.var[1][0][0][0] = (vec3(-8.0, 7.0, 8.0));
	block.var[1][0][0][1] = (vec3(8.0, 2.0, -9.0));
	block.var[1][0][0][2] = (vec3(-3.0, 6.0, -3.0));
	block.var[1][0][1][0] = (vec3(7.0, -3.0, 6.0));
	block.var[1][0][1][1] = (vec3(-7.0, 6.0, -7.0));
	block.var[1][0][1][2] = (vec3(2.0, 3.0, -3.0));
	block.var[1][0][2][0] = (vec3(-1.0, -5.0, -1.0));
	block.var[1][0][2][1] = (vec3(8.0, 4.0, -3.0));
	block.var[1][0][2][2] = (vec3(8.0, -6.0, 4.0));
	block.var[1][1][0][0] = (vec3(-3.0, -8.0, 3.0));
	block.var[1][1][0][1] = (vec3(-5.0, -8.0, 8.0));
	block.var[1][1][0][2] = (vec3(7.0, 2.0, -3.0));
	block.var[1][1][1][0] = (vec3(3.0, -1.0, -6.0));
	block.var[1][1][1][1] = (vec3(-1.0, 6.0, 7.0));
	block.var[1][1][1][2] = (vec3(9.0, -1.0, 2.0));
	block.var[1][1][2][0] = (vec3(-9.0, -6.0, 9.0));
	block.var[1][1][2][1] = (vec3(4.0, 9.0, 5.0));
	block.var[1][1][2][2] = (vec3(5.0, 4.0, -9.0));
	block.var[2][0][0][0] = (vec3(5.0, 9.0, -7.0));
	block.var[2][0][0][1] = (vec3(1.0, -3.0, -7.0));
	block.var[2][0][0][2] = (vec3(-5.0, 4.0, 1.0));
	block.var[2][0][1][0] = (vec3(-3.0, -5.0, -8.0));
	block.var[2][0][1][1] = (vec3(-5.0, 6.0, 2.0));
	block.var[2][0][1][2] = (vec3(-9.0, -9.0, -1.0));
	block.var[2][0][2][0] = (vec3(2.0, 8.0, -8.0));
	block.var[2][0][2][1] = (vec3(-6.0, 0.0, 3.0));
	block.var[2][0][2][2] = (vec3(9.0, -8.0, 3.0));
	block.var[2][1][0][0] = (vec3(3.0, 3.0, 8.0));
	block.var[2][1][0][1] = (vec3(1.0, -2.0, 0.0));
	block.var[2][1][0][2] = (vec3(-9.0, 5.0, 1.0));
	block.var[2][1][1][0] = (vec3(-2.0, 0.0, 0.0));
	block.var[2][1][1][1] = (vec3(-3.0, 7.0, -8.0));
	block.var[2][1][1][2] = (vec3(0.0, 1.0, -3.0));
	block.var[2][1][2][0] = (vec3(-7.0, 1.0, 4.0));
	block.var[2][1][2][1] = (vec3(-2.0, -1.0, -5.0));
	block.var[2][1][2][2] = (vec3(-1.0, 4.0, -2.0));
	block.var[3][0][0][0] = (vec3(-9.0, 9.0, 2.0));
	block.var[3][0][0][1] = (vec3(6.0, -4.0, -8.0));
	block.var[3][0][0][2] = (vec3(3.0, 8.0, 1.0));
	block.var[3][0][1][0] = (vec3(-9.0, -5.0, -7.0));
	block.var[3][0][1][1] = (vec3(-4.0, -1.0, -4.0));
	block.var[3][0][1][2] = (vec3(-6.0, 4.0, 9.0));
	block.var[3][0][2][0] = (vec3(-3.0, -9.0, 0.0));
	block.var[3][0][2][1] = (vec3(-9.0, -5.0, -9.0));
	block.var[3][0][2][2] = (vec3(-1.0, -9.0, 7.0));
	block.var[3][1][0][0] = (vec3(-9.0, -3.0, 6.0));
	block.var[3][1][0][1] = (vec3(-4.0, 8.0, 0.0));
	block.var[3][1][0][2] = (vec3(-5.0, -4.0, 2.0));
	block.var[3][1][1][0] = (vec3(-8.0, 0.0, -8.0));
	block.var[3][1][1][1] = (vec3(-8.0, 8.0, 0.0));
	block.var[3][1][1][2] = (vec3(-8.0, -6.0, -9.0));
	block.var[3][1][2][0] = (vec3(1.0, 3.0, 8.0));
	block.var[3][1][2][1] = (vec3(-2.0, 9.0, -6.0));
	block.var[3][1][2][2] = (vec3(-2.0, 6.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-7.0, -3.0, 7.0, -3.0, 8.0, 3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(8.0, 0.0, -1.0, 2.0, 2.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-5.0, 6.0, 6.0, 8.0, -9.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-5.0, 5.0, -1.0, 2.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-5.0, 8.0, 6.0, 1.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-8.0, -3.0, 1.0, -2.0, 5.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(5.0, -7.0, 7.0, 2.0, 1.0, -3.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(5.0, -1.0, 6.0, -9.0, -1.0, 6.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(-8.0, -2.0, -9.0, 0.0, 5.0, -8.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(-3.0, 3.0, -7.0, 1.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(4.0, -5.0, 0.0, -6.0, 4.0, -3.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(-9.0, 1.0, 6.0, -4.0, 3.0, -3.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	block.var[0][0][0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	block.var[0][0][1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	block.var[0][0][1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	block.var[0][0][2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	block.var[0][0][2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	block.var[0][1][0][0] = (vec4(5.0, 0.0, 0.0, -1.0));
	block.var[0][1][0][1] = (vec4(9.0, 1.0, -4.0, 7.0));
	block.var[0][1][1][0] = (vec4(8.0, 0.0, -5.0, -4.0));
	block.var[0][1][1][1] = (vec4(2.0, 1.0, -9.0, 5.0));
	block.var[0][1][2][0] = (vec4(-5.0, 0.0, 5.0, 7.0));
	block.var[0][1][2][1] = (vec4(8.0, -8.0, 8.0, 1.0));
	block.var[1][0][0][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	block.var[1][0][0][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	block.var[1][0][1][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	block.var[1][0][1][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	block.var[1][0][2][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	block.var[1][0][2][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	block.var[1][1][0][0] = (vec4(6.0, -3.0, -3.0, -4.0));
	block.var[1][1][0][1] = (vec4(-9.0, 1.0, 6.0, -4.0));
	block.var[1][1][1][0] = (vec4(-8.0, -4.0, -9.0, -8.0));
	block.var[1][1][1][1] = (vec4(-1.0, -1.0, 1.0, -7.0));
	block.var[1][1][2][0] = (vec4(7.0, -4.0, -6.0, -8.0));
	block.var[1][1][2][1] = (vec4(-8.0, -1.0, -2.0, 1.0));
	block.var[2][0][0][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	block.var[2][0][0][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	block.var[2][0][1][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	block.var[2][0][1][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	block.var[2][0][2][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	block.var[2][0][2][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	block.var[2][1][0][0] = (vec4(-8.0, 3.0, -6.0, 6.0));
	block.var[2][1][0][1] = (vec4(2.0, 1.0, 3.0, -6.0));
	block.var[2][1][1][0] = (vec4(-1.0, -4.0, -2.0, 6.0));
	block.var[2][1][1][1] = (vec4(6.0, 2.0, 1.0, 2.0));
	block.var[2][1][2][0] = (vec4(8.0, 9.0, 4.0, -4.0));
	block.var[2][1][2][1] = (vec4(5.0, -4.0, 9.0, 9.0));
	block.var[3][0][0][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	block.var[3][0][0][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	block.var[3][0][1][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	block.var[3][0][1][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	block.var[3][0][2][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	block.var[3][0][2][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
	block.var[3][1][0][0] = (vec4(-8.0, 6.0, 2.0, 3.0));
	block.var[3][1][0][1] = (vec4(-1.0, 2.0, 2.0, -7.0));
	block.var[3][1][1][0] = (vec4(9.0, 2.0, -3.0, 1.0));
	block.var[3][1][1][1] = (vec4(5.0, 2.0, -3.0, 3.0));
	block.var[3][1][2][0] = (vec4(-9.0, -1.0, -7.0, 1.0));
	block.var[3][1][2][1] = (vec4(1.0, 5.0, -1.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(-5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-2.0, 5.0, 8.0, 5.0, -1.0, 2.0, -4.0, -9.0, -5.0, -7.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(7.0, -4.0, 9.0, 4.0, -1.0, -2.0, -8.0, 7.0, 9.0, 8.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(1.0, 9.0, 3.0, -6.0, -4.0, 9.0, 3.0, -7.0, -3.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-7.0, 7.0, 2.0, -5.0, 3.0, 2.0, 0.0, 8.0, -1.0, -5.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(6.0, 2.0, -5.0, -7.0, -7.0, -4.0, -9.0, 7.0, 3.0, 1.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(7.0, 6.0, 3.0, 4.0, 5.0, -2.0, 3.0, 8.0, -7.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-4.0, -5.0, 2.0, -6.0, -3.0, -7.0, 2.0, 6.0, 4.0, -4.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(2.0, -9.0, -6.0, -7.0, -2.0, -2.0, 6.0, -5.0, -9.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(1.0, -3.0, -3.0, -1.0, -5.0, -5.0, 7.0, -9.0, 6.0, 4.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(7.0, 1.0, -2.0, 9.0, -5.0, -3.0, 1.0, -6.0, 6.0, -1.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(8.0, 5.0, 4.0, 7.0, -1.0, 6.0, -6.0, 2.0, 8.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(6.0, -8.0, -4.0, -8.0, 8.0, -5.0, 7.0, 3.0, 9.0, -3.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-3.0, 5.0, 4.0, -3.0, 7.0, -7.0, -8.0, -9.0, 2.0, 6.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(3.0, -1.0, -6.0, 2.0, 2.0, -2.0, -9.0, -7.0, -1.0, -3.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(-5.0, 6.0, -8.0, 6.0, 3.0, 6.0, -5.0, 9.0, -1.0, 5.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(-3.0, 0.0, -3.0, 2.0, -8.0, 6.0, 5.0, -2.0, 2.0, 7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(4.0, 5.0, -8.0, -1.0, -2.0, -8.0, -4.0, 2.0, 8.0, 5.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(-1.0, 3.0, 3.0, -3.0, 4.0, -6.0, -5.0, 1.0, 4.0, -4.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(3.0, -8.0, -6.0, -6.0, 0.0, 4.0, -1.0, 4.0, -5.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(9.0, -3.0, 5.0, 2.0, -6.0, -7.0, -3.0, -2.0, -8.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(7.0, 5.0, -4.0, 6.0, 1.0, -7.0, 9.0, 2.0, -1.0, -4.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0][0][0] = (mat4x3(8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0, 4.0));
	block.var[0][0][1] = (mat4x3(-2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0, -7.0));
	block.var[0][0][2] = (mat4x3(-4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0, -6.0));
	block.var[0][1][0] = (mat4x3(3.0, 9.0, 9.0, -7.0, 4.0, 4.0, 8.0, 7.0, -7.0, 2.0, 2.0, -2.0));
	block.var[0][1][1] = (mat4x3(-1.0, -7.0, 6.0, 7.0, -7.0, 6.0, 0.0, 2.0, -3.0, -6.0, -4.0, 5.0));
	block.var[0][1][2] = (mat4x3(-5.0, 1.0, 9.0, 0.0, 3.0, 6.0, -8.0, 7.0, -6.0, 0.0, -2.0, 3.0));
	block.var[1][0][0] = (mat4x3(-5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0, -6.0));
	block.var[1][0][1] = (mat4x3(5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0, -7.0));
	block.var[1][0][2] = (mat4x3(-2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0, -9.0));
	block.var[1][1][0] = (mat4x3(0.0, 5.0, 8.0, 6.0, -4.0, 7.0, 1.0, 1.0, 5.0, -3.0, -3.0, 5.0));
	block.var[1][1][1] = (mat4x3(-3.0, -4.0, -9.0, 2.0, 9.0, -3.0, 1.0, -8.0, -8.0, 0.0, 9.0, -8.0));
	block.var[1][1][2] = (mat4x3(9.0, -9.0, 4.0, -4.0, 3.0, -4.0, -1.0, -6.0, -7.0, 7.0, 6.0, -6.0));
	block.var[2][0][0] = (mat4x3(-7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0, -8.0));
	block.var[2][0][1] = (mat4x3(-4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0, -3.0));
	block.var[2][0][2] = (mat4x3(-7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0, 3.0));
	block.var[2][1][0] = (mat4x3(5.0, 8.0, 3.0, -8.0, 8.0, -6.0, -2.0, 5.0, 6.0, 4.0, 8.0, -9.0));
	block.var[2][1][1] = (mat4x3(0.0, -2.0, -2.0, 9.0, 5.0, 0.0, -8.0, -1.0, 0.0, -6.0, 6.0, -4.0));
	block.var[2][1][2] = (mat4x3(1.0, -2.0, -8.0, -6.0, 8.0, 0.0, 0.0, -5.0, 8.0, -1.0, -7.0, -2.0));
	block.var[3][0][0] = (mat4x3(-8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0, -6.0));
	block.var[3][0][1] = (mat4x3(-9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0, -1.0));
	block.var[3][0][2] = (mat4x3(-9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0, -2.0));
	block.var[3][1][0] = (mat4x3(-2.0, 5.0, -5.0, -4.0, -9.0, -9.0, 1.0, -1.0, -8.0, 2.0, -9.0, -2.0));
	block.var[3][1][1] = (mat4x3(3.0, 5.0, -9.0, -2.0, -6.0, 8.0, 6.0, 6.0, -9.0, 2.0, 5.0, -7.0));
	block.var[3][1][2] = (mat4x3(-4.0, -5.0, -3.0, 0.0, 4.0, 0.0, -4.0, -9.0, -5.0, -6.0, -2.0, 7.0));
}
#version 450
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
	highp vec3 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((block.var[0][0][0]), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((block.var[0][0][1]), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((block.var[0][1][0]), vec3(1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3((block.var[0][1][1]), vec3(5.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3((block.var[0][2][0]), vec3(-1.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((block.var[0][2][1]), vec3(2.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3((block.var[0][3][0]), vec3(-8.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec3((block.var[0][3][1]), vec3(8.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec3((block.var[1][0][0]), vec3(1.0, -1.0, 7.0)) && allOk;
	allOk = compare_vec3((block.var[1][0][1]), vec3(-1.0, -9.0, 3.0)) && allOk;
	allOk = compare_vec3((block.var[1][1][0]), vec3(-3.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec3((block.var[1][1][1]), vec3(8.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((block.var[1][2][0]), vec3(8.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3((block.var[1][2][1]), vec3(6.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3((block.var[1][3][0]), vec3(9.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3((block.var[1][3][1]), vec3(9.0, 4.0, 9.0)) && allOk;
	allOk = compare_vec3((block.var[2][0][0]), vec3(-7.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec3((block.var[2][0][1]), vec3(3.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec3((block.var[2][1][0]), vec3(5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3((block.var[2][1][1]), vec3(-7.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec3((block.var[2][2][0]), vec3(-6.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec3((block.var[2][2][1]), vec3(2.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec3((block.var[2][3][0]), vec3(-5.0, 0.0, -8.0)) && allOk;
	allOk = compare_vec3((block.var[2][3][1]), vec3(-2.0, -4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(5.0, 4.0, 7.0));
	block.var[0][0][1] = (vec3(8.0, -2.0, 7.0));
	block.var[0][1][0] = (vec3(0.0, 5.0, 1.0));
	block.var[0][1][1] = (vec3(-5.0, 0.0, 1.0));
	block.var[0][2][0] = (vec3(-4.0, 5.0, 1.0));
	block.var[0][2][1] = (vec3(-9.0, 6.0, -2.0));
	block.var[0][3][0] = (vec3(3.0, 3.0, -7.0));
	block.var[0][3][1] = (vec3(2.0, 9.0, 0.0));
	block.var[1][0][0] = (vec3(-5.0, -7.0, 9.0));
	block.var[1][0][1] = (vec3(6.0, 6.0, 0.0));
	block.var[1][1][0] = (vec3(0.0, 7.0, -2.0));
	block.var[1][1][1] = (vec3(-2.0, 8.0, -1.0));
	block.var[1][2][0] = (vec3(-8.0, -9.0, 3.0));
	block.var[1][2][1] = (vec3(4.0, -2.0, -9.0));
	block.var[1][3][0] = (vec3(5.0, 9.0, 4.0));
	block.var[1][3][1] = (vec3(-1.0, 6.0, -1.0));
	block.var[2][0][0] = (vec3(-5.0, 2.0, -8.0));
	block.var[2][0][1] = (vec3(5.0, 0.0, 2.0));
	block.var[2][1][0] = (vec3(-1.0, 5.0, 1.0));
	block.var[2][1][1] = (vec3(-1.0, -3.0, 8.0));
	block.var[2][2][0] = (vec3(-2.0, 6.0, -7.0));
	block.var[2][2][1] = (vec3(6.0, -4.0, 3.0));
	block.var[2][3][0] = (vec3(4.0, 2.0, -8.0));
	block.var[2][3][1] = (vec3(-3.0, 2.0, -9.0));
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(0.0, -5.0, 8.0, -6.0, -1.0, -7.0, 0.0, 3.0, -2.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(-4.0, -5.0, 4.0, 2.0, -5.0, -5.0, -9.0, 2.0, -7.0, 9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(0.0, -3.0, -6.0, 4.0, -8.0, -1.0, 9.0, 9.0, 2.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(-7.0, 4.0, 7.0, 7.0, 0.0, -9.0, -8.0, -1.0, -6.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(2.0, 0.0, -4.0, 6.0, 3.0, -2.0, -9.0, 8.0, -8.0, 8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(-7.0, -2.0, 9.0, -3.0, 9.0, -8.0, 1.0, -7.0, -8.0, -9.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(8.0, -2.0, 1.0, 8.0, 4.0, 6.0, -6.0, -5.0, 1.0, -7.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(5.0, 1.0, 1.0, -6.0, 0.0, -8.0, -7.0, 3.0, 3.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(-2.0, 9.0, -3.0, -1.0, -8.0, 5.0, 9.0, -3.0, 7.0, 2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(0.0, 7.0, -2.0, 1.0, 7.0, 1.0, -5.0, 4.0, 4.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-2.0, -2.0, 3.0, -6.0, -5.0, -1.0, 2.0, -4.0, -8.0, -7.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(-3.0, -9.0, 3.0, 8.0, 3.0, 7.0, 9.0, 3.0, -3.0, 7.0, -8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	block.var[0][0][0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	block.var[0][0][0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	block.var[0][0][1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	block.var[0][0][1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	block.var[0][0][1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	block.var[0][1][0][0] = (vec4(7.0, 4.0, -2.0, -4.0));
	block.var[0][1][0][1] = (vec4(6.0, -9.0, -7.0, 3.0));
	block.var[0][1][0][2] = (vec4(-3.0, -6.0, -1.0, 0.0));
	block.var[0][1][1][0] = (vec4(2.0, 3.0, -1.0, 9.0));
	block.var[0][1][1][1] = (vec4(-3.0, -9.0, -1.0, 0.0));
	block.var[0][1][1][2] = (vec4(-9.0, 1.0, 6.0, 5.0));
	block.var[0][2][0][0] = (vec4(7.0, 5.0, 1.0, 8.0));
	block.var[0][2][0][1] = (vec4(-4.0, 6.0, -3.0, -6.0));
	block.var[0][2][0][2] = (vec4(2.0, -9.0, -8.0, 6.0));
	block.var[0][2][1][0] = (vec4(-7.0, 0.0, 5.0, 8.0));
	block.var[0][2][1][1] = (vec4(9.0, 8.0, -6.0, -2.0));
	block.var[0][2][1][2] = (vec4(9.0, -5.0, 4.0, -4.0));
	block.var[0][3][0][0] = (vec4(-1.0, -1.0, -9.0, -5.0));
	block.var[0][3][0][1] = (vec4(6.0, 2.0, -2.0, 8.0));
	block.var[0][3][0][2] = (vec4(9.0, 2.0, -4.0, 7.0));
	block.var[0][3][1][0] = (vec4(-8.0, -7.0, 8.0, -8.0));
	block.var[0][3][1][1] = (vec4(-5.0, 2.0, -3.0, 5.0));
	block.var[0][3][1][2] = (vec4(-3.0, -2.0, -5.0, 3.0));
	block.var[1][0][0][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	block.var[1][0][0][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	block.var[1][0][0][2] = (vec4(0.0, 4.0, 1.0, -9.0));
	block.var[1][0][1][0] = (vec4(3.0, -3.0, 5.0, 9.0));
	block.var[1][0][1][1] = (vec4(4.0, -2.0, -3.0, -6.0));
	block.var[1][0][1][2] = (vec4(8.0, 9.0, -9.0, -5.0));
	block.var[1][1][0][0] = (vec4(-8.0, 4.0, -8.0, 5.0));
	block.var[1][1][0][1] = (vec4(4.0, 3.0, -7.0, 5.0));
	block.var[1][1][0][2] = (vec4(-4.0, 7.0, 2.0, -6.0));
	block.var[1][1][1][0] = (vec4(-2.0, 4.0, -9.0, -3.0));
	block.var[1][1][1][1] = (vec4(7.0, 5.0, -1.0, 1.0));
	block.var[1][1][1][2] = (vec4(6.0, -2.0, -5.0, 9.0));
	block.var[1][2][0][0] = (vec4(-5.0, -1.0, -2.0, -8.0));
	block.var[1][2][0][1] = (vec4(-2.0, 5.0, -5.0, 9.0));
	block.var[1][2][0][2] = (vec4(7.0, -5.0, -3.0, 0.0));
	block.var[1][2][1][0] = (vec4(-5.0, -6.0, 7.0, 0.0));
	block.var[1][2][1][1] = (vec4(7.0, -8.0, -6.0, 0.0));
	block.var[1][2][1][2] = (vec4(7.0, -9.0, 2.0, 3.0));
	block.var[1][3][0][0] = (vec4(-3.0, 8.0, -3.0, -6.0));
	block.var[1][3][0][1] = (vec4(-4.0, 6.0, -2.0, -2.0));
	block.var[1][3][0][2] = (vec4(-4.0, -3.0, -1.0, -3.0));
	block.var[1][3][1][0] = (vec4(7.0, 9.0, -4.0, 8.0));
	block.var[1][3][1][1] = (vec4(-6.0, 4.0, -4.0, -8.0));
	block.var[1][3][1][2] = (vec4(1.0, 2.0, 2.0, -4.0));
	block.var[2][0][0][0] = (vec4(3.0, 4.0, -1.0, -5.0));
	block.var[2][0][0][1] = (vec4(9.0, -2.0, 4.0, -9.0));
	block.var[2][0][0][2] = (vec4(1.0, -8.0, -2.0, 1.0));
	block.var[2][0][1][0] = (vec4(-8.0, -2.0, 9.0, 8.0));
	block.var[2][0][1][1] = (vec4(-5.0, -8.0, -2.0, 7.0));
	block.var[2][0][1][2] = (vec4(-3.0, -9.0, 0.0, -9.0));
	block.var[2][1][0][0] = (vec4(-6.0, 2.0, 5.0, -5.0));
	block.var[2][1][0][1] = (vec4(2.0, 4.0, -3.0, 1.0));
	block.var[2][1][0][2] = (vec4(9.0, -1.0, -1.0, -1.0));
	block.var[2][1][1][0] = (vec4(7.0, -4.0, -7.0, -3.0));
	block.var[2][1][1][1] = (vec4(9.0, -7.0, -5.0, -9.0));
	block.var[2][1][1][2] = (vec4(3.0, 9.0, 2.0, -5.0));
	block.var[2][2][0][0] = (vec4(6.0, -9.0, -7.0, 6.0));
	block.var[2][2][0][1] = (vec4(0.0, 2.0, 9.0, -1.0));
	block.var[2][2][0][2] = (vec4(3.0, -4.0, 9.0, -2.0));
	block.var[2][2][1][0] = (vec4(-4.0, 6.0, 1.0, -2.0));
	block.var[2][2][1][1] = (vec4(-4.0, 3.0, 1.0, -1.0));
	block.var[2][2][1][2] = (vec4(9.0, -4.0, -1.0, 3.0));
	block.var[2][3][0][0] = (vec4(-1.0, -9.0, 2.0, 6.0));
	block.var[2][3][0][1] = (vec4(5.0, 9.0, 3.0, -7.0));
	block.var[2][3][0][2] = (vec4(7.0, -8.0, -1.0, -8.0));
	block.var[2][3][1][0] = (vec4(3.0, -4.0, 6.0, -5.0));
	block.var[2][3][1][1] = (vec4(-5.0, 3.0, 5.0, -2.0));
	block.var[2][3][1][2] = (vec4(-3.0, 2.0, 1.0, 6.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(4.0, -4.0, -2.0, 1.0, 2.0, 6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(8.0, 8.0, -3.0, -7.0, 8.0, -1.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(6.0, 8.0, 5.0, -7.0, -9.0, 6.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(1.0, -1.0, 8.0, 0.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-4.0, 5.0, -6.0, 5.0, -9.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(-9.0, -9.0, 0.0, -2.0, 7.0, 4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(0.0, 1.0, -7.0, 0.0, -4.0, 9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(-3.0, 5.0, 6.0, 1.0, -2.0, 9.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(0.0, -7.0, -8.0, 5.0, 7.0, -1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(4.0, 3.0, 5.0, -4.0, 8.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(2.0, 8.0, -2.0, -7.0, 4.0, -5.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-1.0, 2.0, 3.0, -6.0, 2.0, 8.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	block.var[0][0][1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	block.var[0][1][0] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	block.var[0][1][1] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	block.var[0][2][0] = (mat4x2(2.0, -6.0, -9.0, 6.0, 2.0, -2.0, 9.0, 8.0));
	block.var[0][2][1] = (mat4x2(8.0, 3.0, -2.0, -8.0, 8.0, 4.0, -3.0, 4.0));
	block.var[0][3][0] = (mat4x2(-1.0, 2.0, 5.0, -9.0, 3.0, 2.0, -5.0, 4.0));
	block.var[0][3][1] = (mat4x2(-2.0, 3.0, -1.0, -4.0, -7.0, 3.0, 1.0, -1.0));
	block.var[1][0][0] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	block.var[1][0][1] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	block.var[1][1][0] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	block.var[1][1][1] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	block.var[1][2][0] = (mat4x2(-5.0, 5.0, 9.0, -8.0, -8.0, -5.0, -4.0, -1.0));
	block.var[1][2][1] = (mat4x2(-1.0, -6.0, 6.0, -3.0, -5.0, 2.0, 6.0, 1.0));
	block.var[1][3][0] = (mat4x2(3.0, 6.0, -6.0, -2.0, -8.0, 0.0, -9.0, -5.0));
	block.var[1][3][1] = (mat4x2(-9.0, 5.0, -9.0, 2.0, -2.0, -5.0, -3.0, 5.0));
	block.var[2][0][0] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	block.var[2][0][1] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	block.var[2][1][0] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	block.var[2][1][1] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
	block.var[2][2][0] = (mat4x2(-9.0, 0.0, -5.0, -9.0, 9.0, 8.0, -6.0, -4.0));
	block.var[2][2][1] = (mat4x2(-4.0, -8.0, 9.0, 7.0, -5.0, -3.0, 3.0, 7.0));
	block.var[2][3][0] = (mat4x2(-8.0, -1.0, 9.0, 1.0, -6.0, 5.0, -5.0, -9.0));
	block.var[2][3][1] = (mat4x2(7.0, 1.0, 0.0, 3.0, 4.0, 8.0, 8.0, -2.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(1.0, -2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(5.0, -9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(3.0, -6.0, 9.0, 8.0, -1.0, 8.0, -4.0, 2.0, 6.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(5.0, -1.0, 4.0, 2.0, -4.0, -2.0, -1.0, -4.0, 5.0, 9.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(0.0, 1.0, 5.0, -8.0, -8.0, 0.0, -9.0, 5.0, 2.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(5.0, -4.0, 3.0, -9.0, 3.0, 4.0, -2.0, 4.0, 4.0, 2.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-9.0, 3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-1.0, -2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(5.0, 4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(2.0, -6.0, -1.0, 6.0, 9.0, -3.0, -8.0, 7.0, -5.0, 0.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(7.0, -5.0, -4.0, -3.0, 5.0, 8.0, 9.0, -5.0, -5.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(-2.0, 0.0, 6.0, 2.0, -9.0, 3.0, 3.0, -4.0, 5.0, -3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(8.0, -9.0, -9.0, -6.0, 7.0, -8.0, 3.0, 0.0, -3.0, 3.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(9.0, -8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(-3.0, -2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-1.0, 6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(1.0, 6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(9.0, -2.0, 0.0, 1.0, -8.0, -4.0, -9.0, 3.0, -1.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(-5.0, 1.0, 6.0, 5.0, 6.0, -1.0, -1.0, 1.0, -6.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(-6.0, 1.0, 6.0, -1.0, 3.0, -4.0, 7.0, -7.0, -6.0, -3.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(-8.0, -1.0, 9.0, -6.0, 8.0, -4.0, -1.0, 0.0, -5.0, 0.0, -6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(-3.0, -6.0, 6.0));
	block.var[0][0][0][1] = (vec3(1.0, -4.0, -3.0));
	block.var[0][0][0][2] = (vec3(-3.0, 3.0, -2.0));
	block.var[0][0][0][3] = (vec3(-7.0, 1.0, -5.0));
	block.var[0][0][1][0] = (vec3(-1.0, -5.0, 7.0));
	block.var[0][0][1][1] = (vec3(1.0, -2.0, -4.0));
	block.var[0][0][1][2] = (vec3(-4.0, -6.0, 5.0));
	block.var[0][0][1][3] = (vec3(-2.0, 6.0, -9.0));
	block.var[0][1][0][0] = (vec3(-7.0, -7.0, -7.0));
	block.var[0][1][0][1] = (vec3(6.0, -9.0, 3.0));
	block.var[0][1][0][2] = (vec3(-5.0, 2.0, 4.0));
	block.var[0][1][0][3] = (vec3(-2.0, -4.0, -6.0));
	block.var[0][1][1][0] = (vec3(-1.0, 5.0, 5.0));
	block.var[0][1][1][1] = (vec3(-9.0, -3.0, -9.0));
	block.var[0][1][1][2] = (vec3(3.0, 2.0, 0.0));
	block.var[0][1][1][3] = (vec3(0.0, -9.0, 7.0));
	block.var[0][2][0][0] = (vec3(-5.0, -6.0, -3.0));
	block.var[0][2][0][1] = (vec3(-2.0, 5.0, 8.0));
	block.var[0][2][0][2] = (vec3(2.0, -9.0, 7.0));
	block.var[0][2][0][3] = (vec3(7.0, -3.0, 4.0));
	block.var[0][2][1][0] = (vec3(9.0, 4.0, 1.0));
	block.var[0][2][1][1] = (vec3(5.0, -9.0, 2.0));
	block.var[0][2][1][2] = (vec3(-7.0, -3.0, -9.0));
	block.var[0][2][1][3] = (vec3(9.0, -6.0, 3.0));
	block.var[0][3][0][0] = (vec3(-4.0, -7.0, 3.0));
	block.var[0][3][0][1] = (vec3(6.0, 4.0, 1.0));
	block.var[0][3][0][2] = (vec3(-3.0, 3.0, 8.0));
	block.var[0][3][0][3] = (vec3(-6.0, 5.0, -6.0));
	block.var[0][3][1][0] = (vec3(3.0, 2.0, 3.0));
	block.var[0][3][1][1] = (vec3(1.0, -7.0, 3.0));
	block.var[0][3][1][2] = (vec3(6.0, -3.0, -2.0));
	block.var[0][3][1][3] = (vec3(3.0, 1.0, -1.0));
	block.var[1][0][0][0] = (vec3(5.0, -5.0, 7.0));
	block.var[1][0][0][1] = (vec3(-4.0, 8.0, -3.0));
	block.var[1][0][0][2] = (vec3(-2.0, 0.0, 8.0));
	block.var[1][0][0][3] = (vec3(-2.0, 6.0, -3.0));
	block.var[1][0][1][0] = (vec3(-9.0, -2.0, -2.0));
	block.var[1][0][1][1] = (vec3(7.0, 9.0, -4.0));
	block.var[1][0][1][2] = (vec3(3.0, 1.0, 0.0));
	block.var[1][0][1][3] = (vec3(-9.0, -2.0, -7.0));
	block.var[1][1][0][0] = (vec3(5.0, -5.0, -2.0));
	block.var[1][1][0][1] = (vec3(6.0, 5.0, -4.0));
	block.var[1][1][0][2] = (vec3(-2.0, 9.0, -3.0));
	block.var[1][1][0][3] = (vec3(2.0, 5.0, -4.0));
	block.var[1][1][1][0] = (vec3(6.0, 4.0, 7.0));
	block.var[1][1][1][1] = (vec3(1.0, -4.0, -6.0));
	block.var[1][1][1][2] = (vec3(4.0, -6.0, -5.0));
	block.var[1][1][1][3] = (vec3(5.0, 6.0, -1.0));
	block.var[1][2][0][0] = (vec3(-9.0, -4.0, 0.0));
	block.var[1][2][0][1] = (vec3(5.0, 8.0, 9.0));
	block.var[1][2][0][2] = (vec3(-7.0, -9.0, -5.0));
	block.var[1][2][0][3] = (vec3(0.0, -1.0, -6.0));
	block.var[1][2][1][0] = (vec3(-9.0, -9.0, 9.0));
	block.var[1][2][1][1] = (vec3(9.0, -1.0, 8.0));
	block.var[1][2][1][2] = (vec3(8.0, -8.0, 4.0));
	block.var[1][2][1][3] = (vec3(9.0, -8.0, 8.0));
	block.var[1][3][0][0] = (vec3(0.0, 9.0, -4.0));
	block.var[1][3][0][1] = (vec3(6.0, -5.0, 0.0));
	block.var[1][3][0][2] = (vec3(-2.0, 4.0, 6.0));
	block.var[1][3][0][3] = (vec3(-5.0, 2.0, 4.0));
	block.var[1][3][1][0] = (vec3(-4.0, -4.0, 0.0));
	block.var[1][3][1][1] = (vec3(-2.0, 5.0, 7.0));
	block.var[1][3][1][2] = (vec3(8.0, 8.0, -3.0));
	block.var[1][3][1][3] = (vec3(-9.0, -7.0, 5.0));
	block.var[2][0][0][0] = (vec3(-5.0, -6.0, 5.0));
	block.var[2][0][0][1] = (vec3(-2.0, -7.0, 5.0));
	block.var[2][0][0][2] = (vec3(-2.0, -6.0, 4.0));
	block.var[2][0][0][3] = (vec3(9.0, 5.0, -9.0));
	block.var[2][0][1][0] = (vec3(-3.0, 3.0, 7.0));
	block.var[2][0][1][1] = (vec3(3.0, -4.0, -8.0));
	block.var[2][0][1][2] = (vec3(-2.0, 2.0, -1.0));
	block.var[2][0][1][3] = (vec3(1.0, -9.0, 9.0));
	block.var[2][1][0][0] = (vec3(6.0, 3.0, -9.0));
	block.var[2][1][0][1] = (vec3(-7.0, 3.0, -4.0));
	block.var[2][1][0][2] = (vec3(1.0, 2.0, 6.0));
	block.var[2][1][0][3] = (vec3(-2.0, 3.0, 7.0));
	block.var[2][1][1][0] = (vec3(-5.0, 8.0, -9.0));
	block.var[2][1][1][1] = (vec3(-4.0, -1.0, -9.0));
	block.var[2][1][1][2] = (vec3(5.0, 5.0, 6.0));
	block.var[2][1][1][3] = (vec3(-8.0, 1.0, -7.0));
	block.var[2][2][0][0] = (vec3(4.0, 6.0, 1.0));
	block.var[2][2][0][1] = (vec3(-9.0, 7.0, 3.0));
	block.var[2][2][0][2] = (vec3(-4.0, -3.0, 8.0));
	block.var[2][2][0][3] = (vec3(-9.0, -9.0, 2.0));
	block.var[2][2][1][0] = (vec3(0.0, -2.0, 5.0));
	block.var[2][2][1][1] = (vec3(8.0, 4.0, -4.0));
	block.var[2][2][1][2] = (vec3(5.0, 4.0, -5.0));
	block.var[2][2][1][3] = (vec3(0.0, -3.0, 9.0));
	block.var[2][3][0][0] = (vec3(6.0, -7.0, -2.0));
	block.var[2][3][0][1] = (vec3(0.0, 3.0, -5.0));
	block.var[2][3][0][2] = (vec3(-6.0, -7.0, -4.0));
	block.var[2][3][0][3] = (vec3(-8.0, 1.0, -7.0));
	block.var[2][3][1][0] = (vec3(2.0, -4.0, -7.0));
	block.var[2][3][1][1] = (vec3(-3.0, -4.0, 0.0));
	block.var[2][3][1][2] = (vec3(-8.0, -2.0, 6.0));
	block.var[2][3][1][3] = (vec3(-7.0, -7.0, 2.0));
}
#version 450
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
	highp uint var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.var[0][0][0]), 3u) && allOk;
	allOk = compare_uint((block.var[0][0][1]), 6u) && allOk;
	allOk = compare_uint((block.var[0][1][0]), 6u) && allOk;
	allOk = compare_uint((block.var[0][1][1]), 4u) && allOk;
	allOk = compare_uint((block.var[0][2][0]), 7u) && allOk;
	allOk = compare_uint((block.var[0][2][1]), 8u) && allOk;
	allOk = compare_uint((block.var[0][3][0]), 4u) && allOk;
	allOk = compare_uint((block.var[0][3][1]), 8u) && allOk;
	allOk = compare_uint((block.var[1][0][0]), 9u) && allOk;
	allOk = compare_uint((block.var[1][0][1]), 0u) && allOk;
	allOk = compare_uint((block.var[1][1][0]), 2u) && allOk;
	allOk = compare_uint((block.var[1][1][1]), 5u) && allOk;
	allOk = compare_uint((block.var[1][2][0]), 6u) && allOk;
	allOk = compare_uint((block.var[1][2][1]), 9u) && allOk;
	allOk = compare_uint((block.var[1][3][0]), 7u) && allOk;
	allOk = compare_uint((block.var[1][3][1]), 9u) && allOk;
	allOk = compare_uint((block.var[2][0][0]), 3u) && allOk;
	allOk = compare_uint((block.var[2][0][1]), 7u) && allOk;
	allOk = compare_uint((block.var[2][1][0]), 7u) && allOk;
	allOk = compare_uint((block.var[2][1][1]), 5u) && allOk;
	allOk = compare_uint((block.var[2][2][0]), 0u) && allOk;
	allOk = compare_uint((block.var[2][2][1]), 1u) && allOk;
	allOk = compare_uint((block.var[2][3][0]), 7u) && allOk;
	allOk = compare_uint((block.var[2][3][1]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (7u);
	block.var[0][0][1] = (9u);
	block.var[0][1][0] = (4u);
	block.var[0][1][1] = (8u);
	block.var[0][2][0] = (7u);
	block.var[0][2][1] = (8u);
	block.var[0][3][0] = (6u);
	block.var[0][3][1] = (8u);
	block.var[1][0][0] = (1u);
	block.var[1][0][1] = (0u);
	block.var[1][1][0] = (7u);
	block.var[1][1][1] = (5u);
	block.var[1][2][0] = (6u);
	block.var[1][2][1] = (1u);
	block.var[1][3][0] = (6u);
	block.var[1][3][1] = (2u);
	block.var[2][0][0] = (7u);
	block.var[2][0][1] = (7u);
	block.var[2][1][0] = (7u);
	block.var[2][1][1] = (2u);
	block.var[2][2][0] = (9u);
	block.var[2][2][1] = (8u);
	block.var[2][3][0] = (5u);
	block.var[2][3][1] = (3u);
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(-9.0, -9.0, 1.0, 6.0, -2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-6.0, 1.0, -4.0, 2.0, 9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(-7.0, -8.0, -1.0, 5.0, 6.0, -6.0, -4.0, 9.0, -5.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(-9.0, 3.0, 1.0, 8.0, 7.0, 0.0, 7.0, 9.0, -1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(-5.0, -7.0, 0.0, -4.0, 1.0, 2.0, -2.0, -3.0, -4.0, 2.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(6.0, -3.0, 9.0, 7.0, -4.0, -2.0, 6.0, 5.0, 2.0, -2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-3.0, 1.0, 4.0, 2.0, -2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-6.0, 5.0, 3.0, -1.0, 6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-8.0, 6.0, 7.0, -3.0, -3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(3.0, 8.0, 0.0, -6.0, -6.0, -1.0, -2.0, 5.0, 1.0, -3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(0.0, 8.0, -9.0, 6.0, -5.0, 3.0, -8.0, -1.0, -9.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(0.0, -8.0, -2.0, 7.0, 5.0, -6.0, 9.0, 6.0, 4.0, -4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(-2.0, 8.0, -4.0, 7.0, 4.0, 5.0, 1.0, -1.0, 3.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(6.0, -6.0, -8.0, 8.0, 4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(2.0, 8.0, -9.0, 0.0, 3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-9.0, 1.0, 2.0, 0.0, -3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(4.0, 8.0, -1.0, 7.0, 0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(-8.0, 8.0, -1.0, 9.0, 1.0, -5.0, -4.0, 3.0, 5.0, 7.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(-2.0, 6.0, 5.0, 9.0, 2.0, -3.0, 3.0, 8.0, 8.0, 6.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-6.0, 1.0, -9.0, 0.0, -5.0, 8.0, -9.0, 1.0, -2.0, -2.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(-7.0, -6.0, -7.0, 6.0, 0.0, -6.0, 7.0, 3.0, 0.0, -7.0, 7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	block.var[0][0][1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	block.var[0][1][0] = (mat3x4(3.0, 1.0, -4.0, -8.0, -9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0));
	block.var[0][1][1] = (mat3x4(1.0, -1.0, -1.0, -7.0, -9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0));
	block.var[0][2][0] = (mat3x4(-5.0, -6.0, -9.0, -2.0, 3.0, 0.0, 8.0, 5.0, 9.0, 8.0, 5.0, -4.0));
	block.var[0][2][1] = (mat3x4(5.0, 8.0, 3.0, -2.0, -6.0, -3.0, 3.0, 3.0, 0.0, 9.0, -9.0, 4.0));
	block.var[0][3][0] = (mat3x4(2.0, -3.0, -5.0, 8.0, -5.0, 3.0, 2.0, 1.0, 4.0, -5.0, -7.0, -9.0));
	block.var[0][3][1] = (mat3x4(5.0, 1.0, 4.0, 9.0, -7.0, -7.0, -7.0, 9.0, -4.0, 1.0, 3.0, 5.0));
	block.var[1][0][0] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
	block.var[1][0][1] = (mat3x4(-9.0, 1.0, -3.0, -5.0, -5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0));
	block.var[1][1][0] = (mat3x4(9.0, 2.0, -4.0, -9.0, -7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0));
	block.var[1][1][1] = (mat3x4(4.0, -5.0, 0.0, -5.0, -7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0));
	block.var[1][2][0] = (mat3x4(-8.0, -7.0, 4.0, -2.0, -9.0, -4.0, -3.0, -8.0, 7.0, 8.0, -1.0, -7.0));
	block.var[1][2][1] = (mat3x4(0.0, -4.0, 5.0, 2.0, 2.0, -3.0, 7.0, -3.0, 7.0, 0.0, -2.0, 0.0));
	block.var[1][3][0] = (mat3x4(-6.0, 6.0, 7.0, 7.0, -3.0, -3.0, -7.0, -3.0, 5.0, -8.0, 3.0, 3.0));
	block.var[1][3][1] = (mat3x4(-9.0, 1.0, 5.0, 5.0, -5.0, 8.0, 4.0, -4.0, 9.0, -2.0, 1.0, -8.0));
	block.var[2][0][0] = (mat3x4(-4.0, 4.0, 3.0, 8.0, -8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0));
	block.var[2][0][1] = (mat3x4(-9.0, -3.0, 7.0, -7.0, -6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0));
	block.var[2][1][0] = (mat3x4(-9.0, 0.0, 8.0, 4.0, -9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0));
	block.var[2][1][1] = (mat3x4(6.0, -3.0, -7.0, -8.0, 6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0));
	block.var[2][2][0] = (mat3x4(-3.0, 7.0, -2.0, 4.0, -6.0, -3.0, 4.0, -8.0, 7.0, -3.0, -5.0, -5.0));
	block.var[2][2][1] = (mat3x4(-6.0, -2.0, 3.0, 6.0, 7.0, 1.0, -6.0, 7.0, -9.0, 5.0, 5.0, 3.0));
	block.var[2][3][0] = (mat3x4(-2.0, 9.0, 3.0, 9.0, 9.0, -1.0, -9.0, 3.0, -9.0, 2.0, 2.0, -6.0));
	block.var[2][3][1] = (mat3x4(-9.0, 4.0, 0.0, 2.0, 4.0, -2.0, 9.0, -7.0, 4.0, -5.0, 3.0, -2.0));
}
#version 450
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
layout(std430, buffer_reference) buffer Block
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
	allOk = compare_mat3(block.t[0].a, mat3(-5.0, -4.0, 8.0, 8.0, 1.0, -5.0, -8.0, -8.0, -8.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[0].a), ivec3(6, 9, 9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[0]), ivec2(5, -4)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[1]), ivec2(1, 5)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[2]), ivec2(-1, -5)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[3]), ivec2(-4, 9)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(-7.0, 2.0, 7.0, -1.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[1].a), ivec3(8, -5, 6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[0]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[1]), ivec2(8, 2)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[2]), ivec2(8, -7)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[3]), ivec2(-2, 4)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(-3.0, 5.0, 3.0, -6.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[2].a), ivec3(-8, 9, -8)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[0]), ivec2(6, 1)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[1]), ivec2(9, -1)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[2]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[3]), ivec2(-1, 9)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(8.0, 1.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(block.t[1].a, mat3(-2.0, 8.0, -8.0, -7.0, 8.0, -2.0, -6.0, -6.0, -8.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[0].a), ivec3(9, -7, -1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[0]), ivec2(5, 0)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[1]), ivec2(4, -5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[2]), ivec2(-7, -7)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[3]), ivec2(-6, -8)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(-5.0, 4.0, 0.0, 6.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[1].a), ivec3(0, 4, 5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[0]), ivec2(-2, 9)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[1]), ivec2(-8, 4)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[2]), ivec2(-8, 5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[3]), ivec2(4, 9)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(0.0, -6.0, 6.0, -2.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[2].a), ivec3(3, 9, 5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[0]), ivec2(-4, -9)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[1]), ivec2(-3, -3)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[2]), ivec2(6, 1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[3]), ivec2(-4, 3)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_uint((block.u), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(-1, 0, 1));
	block.s.b[0] = (ivec2(6, -6));
	block.s.b[1] = (ivec2(5, 6));
	block.s.b[2] = (ivec2(-9, 8));
	block.s.b[3] = (ivec2(1, 4));
	block.s.c = (vec4(-5.0, 1.0, 8.0, -2.0));
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
	highp ivec3 a;
	mediump ivec2 b[4];
	highp vec4 c;
};
struct T
{
	mediump mat3 a;
	S b[3];
};
layout(std430, buffer_reference) buffer Block
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
	allOk = compare_mat3(block[0].t[0].a, mat3(-2.0, -1.0, -4.0, 3.0, 4.0, 2.0, -4.0, 4.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(7, 3, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(2, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(-1, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(-7, 5)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(9.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(-8, 3, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(6, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(6, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(-4, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(6, -6)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-7.0, -5.0, -8.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(6, -5, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(-5, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(8, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(-4, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(-2, 8)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(0.0, 4.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(-6.0, -1.0, 6.0, -1.0, 2.0, 8.0, 8.0, -9.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(1, 1, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(-5, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(-2, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(2, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(-1, -7)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(7.0, 3.0, 8.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(3, -1, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(-1, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(-7, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(5, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(6, -6)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(7.0, -3.0, -7.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(0, -8, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(5, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(9, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(2, -9)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-9.0, -1.0, 3.0, -3.0)) && allOk;
	allOk = compare_uint((block[0].u), 1u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(-3.0, 4.0, 7.0, 1.0, -9.0, -1.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(-2, -5, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(0, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(5, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(3, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(6, -7)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-8.0, 1.0, -6.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(-5, 4, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(-2, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(-7, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(5, -4)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(3.0, -8.0, -4.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(1, -2, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(-1, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(-6, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(0, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(1, -8)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(4.0, 8.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(8.0, 9.0, -2.0, 6.0, 4.0, 9.0, -4.0, 8.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(8, -5, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(2, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(1, -5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(-9, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(5, -7)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(2.0, -6.0, -2.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(-9, 9, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(-1, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(-8, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(-4, -5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(-8, 6)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(-5.0, 5.0, 4.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(-4, 2, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(-9, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(-1, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(9, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(-2, 1)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(-7.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_uint((block[1].u), 3u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(8.0, 7.0, -3.0, -4.0, -8.0, 8.0, -9.0, -3.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(4, 5, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(-5, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(-2, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(-6, -9)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(7.0, -8.0, 3.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(-4, 9, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(-8, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(-9, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-6, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(-4, 6)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-9.0, -8.0, -3.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(-6, 0, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(-6, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(5, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(-2, 0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(4.0, 2.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(1.0, -6.0, -2.0, 5.0, 0.0, -2.0, 5.0, -6.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(6, 9, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(9, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(8, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(-9, 3)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(-5.0, -2.0, 0.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(-8, 0, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(-2, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(-4, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(1, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(-5, -9)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(-5.0, -8.0, 5.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(6, -3, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(7, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(3, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(-6, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(-4, -3)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(-4.0, 0.0, -1.0, -9.0)) && allOk;
	allOk = compare_uint((block[2].u), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(3, -4, 1));
	block[0].s.b[0] = (ivec2(7, -2));
	block[0].s.b[1] = (ivec2(8, -4));
	block[0].s.b[2] = (ivec2(-3, 2));
	block[0].s.b[3] = (ivec2(-3, -9));
	block[0].s.c = (vec4(7.0, 5.0, -5.0, 3.0));
	block[0].u = (0u);
	block[1].s.a = (ivec3(9, 6, -1));
	block[1].s.b[0] = (ivec2(-9, -4));
	block[1].s.b[1] = (ivec2(8, 3));
	block[1].s.b[2] = (ivec2(6, -7));
	block[1].s.b[3] = (ivec2(-5, -8));
	block[1].s.c = (vec4(7.0, -7.0, 5.0, 5.0));
	block[1].u = (4u);
	block[2].s.a = (ivec3(3, -6, 6));
	block[2].s.b[0] = (ivec2(-2, -3));
	block[2].s.b[1] = (ivec2(-9, -8));
	block[2].s.b[2] = (ivec2(-2, 5));
	block[2].s.b[3] = (ivec2(6, 9));
	block[2].s.c = (vec4(0.0, 3.0, 0.0, 0.0));
	block[2].u = (6u);
}
#version 450
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
	allOk = compare_uint((block[0].u), 0u) && allOk;
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(-8.0, 9.0, 0.0, -2.0, -3.0, -7.0, 4.0, -8.0, 8.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(2u, 6u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(-2.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(-7.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(0.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(1.0, -2.0, -5.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(7u, 6u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(7.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(-2.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(-6.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(9.0, -2.0, 9.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(5u, 1u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(-1.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(5.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(-7.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(-6.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-1.0, 3.0, 3.0, 0.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), 0) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(2.0, 1.0, 6.0, 1.0, 5.0, -8.0, -9.0, 3.0, 5.0, 6.0, -3.0, -8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(1u, 9u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(-3.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(-2.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(-2.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(8.0, -5.0, -8.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(5u, 3u, 3u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(5.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(4.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(6.0, -7.0, -6.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(7u, 6u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(8.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(4.0, -3.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(6.0, 6.0, -1.0, -7.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), -2) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(2.0, 9.0, 7.0, 8.0, -1.0, 2.0, -4.0, -3.0, -8.0, 8.0, 6.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(4u, 4u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(-3.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(-5.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(9.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(-8.0, 9.0, 7.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(5u, 9u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(1.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(-9.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(9.0, -1.0, 7.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(9u, 4u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(5.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(8.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(6.0, 4.0, 6.0, 4.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), 9) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(-8.0, -5.0, -5.0, 7.0, -5.0, 5.0, -6.0, -7.0, 1.0, 0.0, 2.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(5u, 7u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(-3.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(-1.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(-6.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(6.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(-5.0, 0.0, 1.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(1u, 0u, 3u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(-9.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(9.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(-9.0, -8.0, 6.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(0u, 3u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(-7.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(1.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(5.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(3.0, -4.0, -2.0, 7.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), -4) && allOk;
	allOk = compare_uint((block[1].u), 4u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(8.0, 3.0, -9.0, 6.0, 5.0, 5.0, 4.0, 5.0, -7.0, -1.0, -2.0, 6.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(8u, 9u, 1u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(-3.0, -6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(2.0, 9.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(5.0, -5.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-6.0, -5.0, -2.0, 7.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(4u, 6u, 0u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(3.0, -8.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(0.0, -7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(7.0, 7.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-2.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(6u, 0u, 8u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(-6.0, -2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(7.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-6.0, 5.0, 7.0, -9.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), -8) && allOk;
	allOk = compare_uint((block[2].u), 4u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(-4.0, 6.0, -5.0, -6.0, -6.0, -2.0, -1.0, 7.0, -5.0, -4.0, -3.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(9u, 3u, 4u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(-2.0, 1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(3.0, 3.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(-3.0, 1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-8.0, 0.0, 5.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(0u, 2u, 6u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(-7.0, 8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(2.0, -5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(-7.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(4u, 8u, 0u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(-9.0, 5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(-7.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(4.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(0u, 9u, 3u));
	block[0].s.b[0] = (vec2(-2.0, -9.0));
	block[0].s.b[1] = (vec2(-6.0, 1.0));
	block[0].s.b[2] = (vec2(-4.0, 0.0));
	block[0].s.b[3] = (vec2(4.0, 4.0));
	block[0].s.c = (vec4(-7.0, -8.0, -9.0, 6.0));
	block[0].u = (6u);
	block[1].s.a = (uvec3(3u, 5u, 5u));
	block[1].s.b[0] = (vec2(-5.0, -2.0));
	block[1].s.b[1] = (vec2(5.0, 2.0));
	block[1].s.b[2] = (vec2(9.0, -3.0));
	block[1].s.b[3] = (vec2(8.0, -1.0));
	block[1].s.c = (vec4(3.0, 4.0, 5.0, 3.0));
	block[1].u = (0u);
	block[2].s.a = (uvec3(1u, 5u, 9u));
	block[2].s.b[0] = (vec2(2.0, -3.0));
	block[2].s.b[1] = (vec2(-6.0, -5.0));
	block[2].s.b[2] = (vec2(-2.0, -6.0));
	block[2].s.b[3] = (vec2(-2.0, 5.0));
	block[2].s.c = (vec4(-6.0, -2.0, -3.0, 7.0));
	block[2].u = (5u);
}
#version 450
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
	int8_t var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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
	allOk = compare_mat4x3(block[0].var, mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(1.0, 3.0, -7.0));
	block[0].var[1] = (vec3(-7.0, 2.0, 3.0));
	block[0].var[2] = (vec3(1.0, -2.0, -1.0));
	block[0].var[3] = (vec3(-5.0, -1.0, 9.0));
	block[1].var[0] = (vec3(8.0, -4.0, 3.0));
	block[1].var[1] = (vec3(4.0, 9.0, -6.0));
	block[1].var[2] = (vec3(7.0, 6.0, -5.0));
	block[1].var[3] = (vec3(2.0, 6.0, 3.0));
	block[2].var[0] = (vec3(2.0, 7.0, -1.0));
	block[2].var[1] = (vec3(-3.0, -3.0, -7.0));
	block[2].var[2] = (vec3(-5.0, 3.0, 4.0));
	block[2].var[3] = (vec3(-4.0, -2.0, 8.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 0.0) && allOk;
	allOk = compare_mat4x3(block[0].var, mat4x3(1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_float((block[1].padding), 2.0) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0, -7.0, 9.0)) && allOk;
	allOk = compare_float((block[2].padding), 2.0) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(-3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0, -5.0, 4.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (2.0);
	block[0].var = (mat4x3(4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0, 6.0));
	block[1].padding = (-2.0);
	block[1].var = (mat4x3(-2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0, 1.0, 7.0));
	block[2].padding = (0.0);
	block[2].var = (mat4x3(5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0, 3.0, 1.0, -4.0));
}
#version 450
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

layout(std140, buffer_reference) readonly buffer BlockB
{
	bvec3 a;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	bvec2 b;
	highp ivec4 c;
	lowp mat3 d;
	highp ivec3 e[2];
	mediump float f;
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp mat3x2 g;
	mediump mat3x2 h;
	highp mat4 i;
};
layout(std140, buffer_reference) buffer BlockE
{
	mediump uvec2 j;
	highp mat4x2 k;
	lowp mat2x3 l;
	lowp vec2 m;
	mediump mat3 n;
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
	allOk = compare_ivec3((blockC.e[0]), ivec3(-3, 1, 5)) && allOk;
	allOk = compare_ivec3((blockC.e[1]), ivec3(6, 9, 0)) && allOk;
	allOk = compare_mat3x2(blockD.h, mat3x2(6.0, 6.0, 5.0, 1.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat4(blockD.i, mat4(-4.0, 0.0, 1.0, 2.0, -1.0, 9.0, -9.0, 9.0, 3.0, -9.0, 3.0, 5.0, 2.0, 3.0, 1.0, -6.0)) && allOk;
	allOk = compare_uvec2((blockE.j), uvec2(6u, 8u)) && allOk;
	allOk = compare_mat4x2(blockE.k, mat4x2(1.0, 5.0, -7.0, 6.0, -1.0, -9.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(blockE.n, mat3(-2.0, 0.0, -1.0, -3.0, -7.0, 2.0, 3.0, 2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (bvec2(false, true));
	blockC.c = (ivec4(-1, -9, 0, 0));
	blockC.f = (-7.0);
	blockD.h = (mat3x2(2.0, 0.0, -6.0, -5.0, -6.0, 6.0));
	blockD.i = (mat4(-7.0, 0.0, -9.0, -1.0, -1.0, 4.0, -2.0, -5.0, 5.0, 3.0, 0.0, 9.0, -5.0, -3.0, 3.0, -7.0));
	blockE.j = (uvec2(9u, 1u));
	blockE.k = (mat4x2(-2.0, 7.0, -9.0, -8.0, 3.0, 5.0, 5.0, -1.0));
	blockE.l = (mat2x3(7.0, -1.0, -8.0, 0.0, -8.0, 4.0));
	blockE.m = (vec2(-3.0, -4.0));
	blockE.n = (mat3(9.0, -9.0, -8.0, 8.0, 1.0, 2.0, -6.0, 8.0, -9.0));
}
#version 450
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
};
layout(std430, column_major, buffer_reference) readonly buffer BlockC
{
	highp ivec3 b;
	mediump mat4 c;
	lowp uvec4 d[1];
	mediump vec3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockC.c, mat4(8.0, 3.0, 7.0, 5.0, -6.0, 5.0, -9.0, -2.0, 4.0, -1.0, -1.0, -5.0, 2.0, -6.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec3((blockC.e[0]), vec3(7.0, 8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(-2.0, -9.0, -3.0, -1.0, -2.0, 7.0, -7.0, -6.0, -5.0, -9.0, 4.0, -6.0));
}
#version 450
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
	lowp vec4 mB;
};
struct sB
{
	mediump mat4x3 mA;
	lowp mat4x3 mB;
	mediump int mC;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	sA a;
	bvec3 b;
	highp mat4x3 c;
	mediump mat4 d;
	sB e[];
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a.mA, mat4x2(0.0, 2.0, -8.0, 6.0, 7.0, 5.0, -6.0, 1.0)) && allOk;
	allOk = compare_vec4((blockB.a.mB), vec4(9.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(false, false, false)) && allOk;
	allOk = compare_mat4x3(blockB.c, mat4x3(-8.0, -9.0, 8.0, 0.0, 4.0, -4.0, 7.0, 2.0, -1.0, 7.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4(blockB.d, mat4(3.0, -5.0, -3.0, -1.0, 1.0, 0.0, -3.0, 1.0, 3.0, -9.0, -4.0, 3.0, 9.0, 1.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (mat4x2(6.0, -1.0, 0.0, 3.0, -7.0, 6.0, -7.0, 6.0));
	blockB.a.mB = (vec4(-8.0, -4.0, -6.0, 3.0));
	blockB.c = (mat4x3(7.0, -5.0, -5.0, -2.0, -2.0, 7.0, -2.0, 1.0, 3.0, -9.0, -2.0, -7.0));
	blockB.d = (mat4(9.0, -9.0, 4.0, -1.0, 8.0, 4.0, -4.0, 0.0, 7.0, 6.0, 5.0, 3.0, 3.0, -4.0, -6.0, 4.0));
}
#version 450
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
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	lowp ivec3 a;
	sA b;
	highp vec3 c;
	lowp ivec2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.b.mA, mat2(0.0, 5.0, 5.0, 5.0)) && allOk;
	allOk = compare_ivec2((blockB.d[0]), ivec2(1, -6)) && allOk;
	allOk = compare_ivec2((blockB.d[1]), ivec2(-8, -5)) && allOk;
	allOk = compare_ivec2((blockB.d[2]), ivec2(9, 7)) && allOk;
	allOk = compare_ivec2((blockB.d[3]), ivec2(-8, 1)) && allOk;
	allOk = compare_ivec2((blockB.d[4]), ivec2(5, -5)) && allOk;
	allOk = compare_ivec2((blockB.d[5]), ivec2(-8, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(-9, -3, 8));
	blockB.b.mA = (mat2(0.0, -3.0, 9.0, -5.0));
	blockB.c = (vec3(2.0, 1.0, 8.0));
}
#version 450
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
	mediump mat3x2 mA;
	bvec2 mB;
	highp mat4x2 mC;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	bvec4 a;
	mediump uvec3 b[1][5];
	mediump float c;
	lowp int d;
	bvec3 e[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp mat2x3 f;
};
layout(std430, row_major, buffer_reference) readonly buffer BlockD
{
	lowp vec3 g;
	sA h;
	lowp float i[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec3((blockB.e[0]), bvec3(false, true, true)) && allOk;
	allOk = compare_vec3((blockD.g), vec3(-1.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockD.h.mA, mat3x2(-9.0, 8.0, 3.0, -2.0, 3.0, -3.0)) && allOk;
	allOk = compare_bvec2((blockD.h.mB), bvec2(true, false)) && allOk;
	allOk = compare_mat4x2(blockD.h.mC, mat4x2(0.0, 3.0, 1.0, -3.0, -3.0, 2.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, false, false));
	blockB.b[0][0] = (uvec3(0u, 9u, 6u));
	blockB.b[0][1] = (uvec3(8u, 6u, 7u));
	blockB.b[0][2] = (uvec3(8u, 8u, 6u));
	blockB.b[0][3] = (uvec3(3u, 6u, 9u));
	blockB.b[0][4] = (uvec3(3u, 5u, 0u));
	blockB.c = (2.0);
	blockB.e[0] = (bvec3(true, false, false));
	blockC.f = (mat2x3(5.0, 9.0, 9.0, 6.0, 9.0, -5.0));
}
#version 450
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
	layout(offset = 0) mediump int a;
	layout(offset = 4) highp float b;
	layout(offset = 16) lowp vec4 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp uvec2 d[1];
	layout(offset = 8) bool e;
	layout(offset = 16) lowp ivec3 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump uvec3 g;
	layout(offset = 16) mediump ivec2 h;
	layout(offset = 32) mediump uvec4 i;
	layout(offset = 48) highp uvec2 j;
	layout(offset = 64) highp vec3 k;
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.c), vec4(6.0, 1.0, -7.0, 2.0)) && allOk;
	allOk = compare_uvec2((blockC.d[0]), uvec2(1u, 5u)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(-7, -4, -1)) && allOk;
	allOk = compare_uvec3((blockD.g), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_ivec2((blockD.h), ivec2(-8, -3)) && allOk;
	allOk = compare_uvec4((blockD.i), uvec4(6u, 7u, 5u, 1u)) && allOk;
	allOk = compare_uvec2((blockD.j), uvec2(8u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6);
	blockB.b = (9.0);
	blockB.c = (vec4(-9.0, -1.0, 5.0, 2.0));
	blockC.d[0] = (uvec2(2u, 4u));
	blockC.e = (true);
	blockC.f = (ivec3(-6, 3, 7));
	blockD.g = (uvec3(3u, 7u, 0u));
	blockD.h = (ivec2(-9, -4));
	blockD.j = (uvec2(0u, 6u));
	blockD.k = (vec3(9.0, -3.0, 7.0));
}
#version 450
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
	layout(offset = 16) mediump vec4 b;
	layout(offset = 32) lowp vec3 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp uvec2 d;
	layout(offset = 16) highp vec3 e;
	layout(offset = 32) lowp uvec4 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) highp vec3 g;
	layout(offset = 16) highp ivec3 h;
	layout(offset = 28) mediump float i;
	layout(offset = 32) lowp uint j;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) lowp uvec3 k;
	layout(offset = 16) lowp ivec2 l[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(6.0, 6.0)) && allOk;
	allOk = compare_vec4((blockB.b), vec4(3.0, 4.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(5.0, 8.0, -2.0)) && allOk;
	allOk = compare_uvec2((blockC[0].d), uvec2(1u, 1u)) && allOk;
	allOk = compare_uvec4((blockC[0].f), uvec4(2u, 7u, 2u, 4u)) && allOk;
	allOk = compare_uvec2((blockC[1].d), uvec2(3u, 4u)) && allOk;
	allOk = compare_uvec4((blockC[1].f), uvec4(6u, 3u, 8u, 0u)) && allOk;
	allOk = compare_vec3((blockD.g), vec3(8.0, 7.0, 9.0)) && allOk;
	allOk = compare_uint((blockD.j), 4u) && allOk;
	allOk = compare_uvec3((blockE.k), uvec3(1u, 2u, 7u)) && allOk;
	allOk = compare_ivec2((blockE.l[0]), ivec2(-9, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(-8.0, -1.0));
	blockB.b = (vec4(-8.0, -4.0, 6.0, -8.0));
	blockB.c = (vec3(-5.0, 4.0, 9.0));
	blockC[0].e = (vec3(5.0, 8.0, -3.0));
	blockC[0].f = (uvec4(8u, 0u, 1u, 3u));
	blockC[1].e = (vec3(9.0, -9.0, 2.0));
	blockC[1].f = (uvec4(6u, 3u, 5u, 7u));
	blockD.g = (vec3(-9.0, 3.0, -5.0));
	blockD.h = (ivec3(4, -4, 6));
	blockD.i = (2.0);
	blockD.j = (9u);
	blockE.k = (uvec3(9u, 6u, 1u));
}
#version 450
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
	mediump ivec2 a;
	highp ivec3 b;
};
layout(scalar, buffer_reference) buffer BlockC
{
	highp uint c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(8, 0)) && allOk;
	allOk = compare_uint((blockC.c[0]), 1u) && allOk;
	allOk = compare_uint((blockC.c[1]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c[0] = (1u);
	blockC.c[1] = (3u);
}
#version 450
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
	highp uvec4 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a[0]), uvec4(0u, 8u, 9u, 4u)) && allOk;
	allOk = compare_uvec4((blockB.a[1]), uvec4(1u, 8u, 1u, 3u)) && allOk;
	allOk = compare_uvec4((blockB.a[2]), uvec4(0u, 2u, 0u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.a[3]), uvec4(2u, 9u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((blockB.a[4]), uvec4(7u, 5u, 1u, 3u)) && allOk;
	allOk = compare_uvec4((blockB.a[5]), uvec4(8u, 3u, 5u, 0u)) && allOk;
	allOk = compare_uvec4((blockB.a[6]), uvec4(7u, 8u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((blockB.a[7]), uvec4(5u, 6u, 7u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec4(6u, 4u, 7u, 1u));
	blockB.a[1] = (uvec4(7u, 8u, 5u, 2u));
	blockB.a[2] = (uvec4(7u, 3u, 5u, 5u));
	blockB.a[3] = (uvec4(8u, 8u, 3u, 3u));
	blockB.a[4] = (uvec4(9u, 1u, 0u, 5u));
	blockB.a[5] = (uvec4(2u, 3u, 5u, 1u));
	blockB.a[6] = (uvec4(5u, 6u, 6u, 7u));
	blockB.a[7] = (uvec4(0u, 6u, 2u, 4u));
}
#version 450
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
	int16_t a;
	mediump ivec2 b;
	highp mat2x3 c;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	uint16_t d;
	i16vec2 e;
	mediump mat2x3 f;
};
layout(std140, buffer_reference) buffer BlockD
{
	int16_t g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.a), -7) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(3, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int16_t(-6);
	blockB.b = (ivec2(-2, 3));
	blockC[0].d = uint16_t(1u);
	blockC[0].e = i16vec2(ivec2(5, -4));
	blockC[1].d = uint16_t(3u);
	blockC[1].e = i16vec2(ivec2(3, 2));
	blockC[2].d = uint16_t(1u);
	blockC[2].e = i16vec2(ivec2(4, 1));
	blockD.g[0] = int16_t(-3);
	blockD.g[1] = int16_t(-8);
}
#version 450
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
};
struct sB
{
	highp uint mA;
	lowp vec2 mB;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	mediump uint a;
	i16vec4 b;
	mediump uvec3 c;
	lowp uvec3 d;
	sA e[];
};
layout(std430, buffer_reference) readonly buffer BlockC
{
	highp vec2 f[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	mediump mat4x2 g;
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	sB h;
	highp mat3x4 i;
	u16vec3 j;
	u16vec3 k[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 4u) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.b), ivec4(3, 3, 2, 0)) && allOk;
	allOk = compare_uvec3((blockB.c), uvec3(2u, 2u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.d), uvec3(0u, 8u, 1u)) && allOk;
	allOk = compare_int((blockB.e[0].mA), 6) && allOk;
	allOk = compare_int((blockB.e[1].mA), 2) && allOk;
	allOk = compare_int((blockB.e[2].mA), 3) && allOk;
	allOk = compare_int((blockB.e[3].mA), 3) && allOk;
	allOk = compare_int((blockB.e[4].mA), 3) && allOk;
	allOk = compare_int((blockB.e[5].mA), 5) && allOk;
	allOk = compare_int((blockB.e[6].mA), -5) && allOk;
	allOk = compare_vec2((blockC.f[0]), vec2(-2.0, -6.0)) && allOk;
	allOk = compare_vec2((blockC.f[1]), vec2(6.0, -8.0)) && allOk;
	allOk = compare_vec2((blockC.f[2]), vec2(7.0, -3.0)) && allOk;
	allOk = compare_vec2((blockC.f[3]), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec2((blockC.f[4]), vec2(8.0, 2.0)) && allOk;
	allOk = compare_vec2((blockC.f[5]), vec2(4.0, -4.0)) && allOk;
	allOk = compare_vec2((blockC.f[6]), vec2(-4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockD.g, mat4x2(9.0, -1.0, 6.0, -9.0, -2.0, -2.0, 1.0, 7.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.k[0]), uvec3(4u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.k[1]), uvec3(4u, 1u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.k[2]), uvec3(5u, 9u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (8u);
	blockB.b = i16vec4(ivec4(-5, 3, 9, -5));
	blockB.d = (uvec3(0u, 5u, 7u));
	blockB.e[0].mA = (-8);
	blockB.e[1].mA = (-4);
	blockB.e[2].mA = (8);
	blockB.e[3].mA = (6);
	blockB.e[4].mA = (-3);
	blockB.e[5].mA = (-7);
	blockB.e[6].mA = (-4);
	blockD.g = (mat4x2(4.0, 6.0, -9.0, 5.0, 6.0, 1.0, 3.0, 0.0));
	blockE.j = u16vec3(uvec3(7u, 5u, 9u));
}
#version 450
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
	f16vec4 mA[1];
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	mediump int a;
	mediump mat3 b[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	sA c;
	u16vec3 d;
	uint16_t e[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	highp vec4 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 2) && allOk;
	allOk = compare_mat3(blockB.b[0], mat3(5.0, 9.0, -9.0, -9.0, -4.0, 4.0, 5.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3(blockB.b[1], mat3(5.0, 1.0, -2.0, 6.0, 3.0, -6.0, -9.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3(blockB.b[2], mat3(8.0, 8.0, -6.0, 2.0, -6.0, -8.0, 9.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB.b[3], mat3(-6.0, -5.0, -9.0, -3.0, -5.0, 3.0, 0.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB.b[4], mat3(-9.0, -4.0, 1.0, 1.0, -4.0, -5.0, -1.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(blockB.b[5], mat3(-2.0, 2.0, -1.0, 8.0, -8.0, 9.0, -3.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB.b[6], mat3(-8.0, -7.0, 4.0, -5.0, 4.0, 7.0, -4.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB.b[7], mat3(-8.0, 8.0, 0.0, -3.0, 1.0, -6.0, 9.0, 0.0, 9.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].d), uvec3(3u, 9u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].d), uvec3(5u, 5u, 3u)) && allOk;
	allOk = compare_vec4((blockD.f[0]), vec4(4.0, -9.0, 6.0, -8.0)) && allOk;
	allOk = compare_vec4((blockD.f[1]), vec4(-7.0, 9.0, 9.0, -7.0)) && allOk;
	allOk = compare_vec4((blockD.f[2]), vec4(-8.0, 4.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((blockD.f[3]), vec4(9.0, -8.0, -7.0, -2.0)) && allOk;
	allOk = compare_vec4((blockD.f[4]), vec4(-3.0, -1.0, -6.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.f[5]), vec4(8.0, 9.0, -7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-1);
	blockB.b[0] = (mat3(-4.0, 2.0, -1.0, 2.0, 2.0, -5.0, 7.0, -5.0, 5.0));
	blockB.b[1] = (mat3(-3.0, 4.0, -8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0));
	blockB.b[2] = (mat3(3.0, -2.0, 9.0, -6.0, 3.0, 5.0, 5.0, 9.0, 3.0));
	blockB.b[3] = (mat3(-9.0, -1.0, -5.0, -8.0, 3.0, 0.0, -6.0, -8.0, -3.0));
	blockB.b[4] = (mat3(8.0, 2.0, -4.0, 6.0, 9.0, 9.0, -1.0, -2.0, 8.0));
	blockB.b[5] = (mat3(7.0, -5.0, -2.0, -3.0, -4.0, 3.0, 1.0, -2.0, -3.0));
	blockB.b[6] = (mat3(-9.0, 9.0, -1.0, -3.0, -4.0, -3.0, 1.0, 0.0, -5.0));
	blockB.b[7] = (mat3(8.0, -3.0, 8.0, 5.0, 0.0, 1.0, 2.0, 6.0, 8.0));
	blockC[0].d = u16vec3(uvec3(5u, 4u, 5u));
	blockC[1].d = u16vec3(uvec3(0u, 5u, 3u));
	blockD.f[0] = (vec4(1.0, -4.0, 8.0, 4.0));
	blockD.f[1] = (vec4(-7.0, -8.0, 6.0, -8.0));
	blockD.f[2] = (vec4(6.0, -9.0, 0.0, -6.0));
	blockD.f[3] = (vec4(-3.0, -5.0, 3.0, 5.0));
	blockD.f[4] = (vec4(-5.0, 7.0, 0.0, -9.0));
	blockD.f[5] = (vec4(-9.0, -8.0, 9.0, 3.0));
}
#version 450
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
	layout(offset = 16) highp vec4 b;
	layout(offset = 32) u16vec2 c;
	layout(offset = 36) lowp float d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[0].a), bvec2(true, false)) && allOk;
	allOk = compare_vec4((blockB[0].b), vec4(-1.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB[0].c), uvec2(1u, 6u)) && allOk;
	allOk = compare_bvec2((blockB[1].a), bvec2(false, false)) && allOk;
	allOk = compare_vec4((blockB[1].b), vec4(2.0, 7.0, 9.0, -8.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB[1].c), uvec2(8u, 9u)) && allOk;
	allOk = compare_bvec2((blockB[2].a), bvec2(true, true)) && allOk;
	allOk = compare_vec4((blockB[2].b), vec4(-1.0, -4.0, 2.0, -4.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB[2].c), uvec2(6u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec2(true, false));
	blockB[0].b = (vec4(-1.0, 6.0, -5.0, 3.0));
	blockB[0].c = u16vec2(uvec2(1u, 4u));
	blockB[0].d = (9.0);
	blockB[1].a = (bvec2(true, false));
	blockB[1].b = (vec4(1.0, 0.0, 6.0, -1.0));
	blockB[1].c = u16vec2(uvec2(4u, 5u));
	blockB[1].d = (-4.0);
	blockB[2].a = (bvec2(false, true));
	blockB[2].b = (vec4(-9.0, 9.0, -1.0, 8.0));
	blockB[2].c = u16vec2(uvec2(6u, 2u));
	blockB[2].d = (-3.0);
	blockC[0].e = (bvec4(true, false, true, false));
}
#version 450
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
	highp vec2 a[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	lowp mat3 b;
	bvec4 c;
	mediump uvec3 d;
	f16vec2 e;
	f16vec3 f[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	lowp float g;
	bvec3 h;
	lowp mat3 i;
	highp ivec4 j;
	bvec3 k[];
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockE
{
	mediump mat4x2 l[];
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
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a[0]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec2((blockB.a[1]), vec2(9.0, -4.0)) && allOk;
	allOk = compare_vec2((blockB.a[2]), vec2(2.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB.a[3]), vec2(-9.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB.a[4]), vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec2((blockB.a[5]), vec2(-8.0, 1.0)) && allOk;
	allOk = compare_vec2((blockB.a[6]), vec2(-1.0, -6.0)) && allOk;
	allOk = compare_vec2((blockB.a[7]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockC.c), bvec4(false, true, true, false)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.f[0]), vec3(8.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(blockD.i, mat3(-6.0, 7.0, -4.0, 0.0, 9.0, -7.0, -1.0, 3.0, -8.0)) && allOk;
	allOk = compare_ivec4((blockD.j), ivec4(-8, -2, 4, 6)) && allOk;
	allOk = compare_bvec3((blockD.k[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockD.k[1]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockD.k[2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockD.k[3]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockD.k[4]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockD.k[5]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockD.k[6]), bvec3(true, false, false)) && allOk;
	allOk = compare_mat4x2(blockE.l[0], mat4x2(-4.0, 9.0, -6.0, -9.0, 3.0, 0.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockE.l[1], mat4x2(9.0, 0.0, -7.0, 3.0, 2.0, 9.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockE.l[2], mat4x2(-4.0, 4.0, -6.0, -1.0, 8.0, 4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockE.l[3], mat4x2(-1.0, 8.0, 0.0, -6.0, 7.0, -8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockE.l[4], mat4x2(-6.0, 8.0, -3.0, -8.0, -4.0, -6.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat3(5.0, -3.0, 0.0, 5.0, 2.0, -8.0, -2.0, -1.0, 9.0));
	blockC.c = (bvec4(false, true, true, true));
	blockC.f[0] = f16vec3(vec3(-9.0, 2.0, 3.0));
	blockD.h = (bvec3(true, false, true));
	blockD.j = (ivec4(5, -5, 3, -2));
}
#version 450
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
	mediump uint b;
	uint8_t c[1];
	uint8_t d;
	lowp uint e[1];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump float f[1];
	mediump float g;
	highp int h[1];
	mediump float i;
	mediump float j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

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

	blockB.a = (8.0);
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

layout(std140, buffer_reference) buffer BlockB
{
	lowp vec3 a[1];
	i8vec4 b;
	i8vec2 c;
	highp uvec4 d;
	bvec4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.b), ivec4(6, 7, 5, 4294967290)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c), ivec2(1, 9)) && allOk;
	allOk = compare_uvec4((blockB.d), uvec4(1u, 5u, 2u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = i8vec4(ivec4(3, 4294967289, 6, 4294967289));
	blockB.e = (bvec4(false, true, true, false));
}
#version 450
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
	highp ivec3 b[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp vec3 c[];
};
layout(std430, buffer_reference) buffer BlockD
{
	u8vec3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(1.0, -5.0)) && allOk;
	allOk = compare_vec3((blockC.c[0]), vec3(-7.0, 1.0, 2.0)) && allOk;
	allOk = compare_vec3((blockC.c[1]), vec3(8.0, 7.0, 9.0)) && allOk;
	allOk = compare_vec3((blockC.c[2]), vec3(-8.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3((blockC.c[3]), vec3(6.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec3((blockC.c[4]), vec3(3.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec3((blockC.c[5]), vec3(4.0, -2.0, 9.0)) && allOk;
	allOk = compare_vec3((blockC.c[6]), vec3(2.0, -5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (ivec3(-5, -4, -8));
	blockC.c[0] = (vec3(-5.0, 0.0, 0.0));
	blockC.c[1] = (vec3(-7.0, 5.0, 3.0));
	blockC.c[2] = (vec3(4.0, 7.0, 8.0));
	blockC.c[3] = (vec3(3.0, 8.0, 8.0));
	blockC.c[4] = (vec3(0.0, 8.0, -6.0));
	blockC.c[5] = (vec3(5.0, 1.0, 7.0));
	blockC.c[6] = (vec3(-1.0, -9.0, -2.0));
	blockD.d[0] = u8vec3(uvec3(7u, 8u, 4u));
	blockD.d[1] = u8vec3(uvec3(3u, 4u, 5u));
	blockD.d[2] = u8vec3(uvec3(8u, 0u, 6u));
}
#version 450
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
	mediump int a;
	int8_t b;
	u8vec4 c;
	bvec2 d;
	u8vec3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(blockB.b), 7) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(true, true)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.e[0]), uvec3(5u, 1u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = int8_t(9);
	blockB.c = u8vec4(uvec4(9u, 1u, 5u, 2u));
	blockB.d = (bvec2(true, false));
	blockB.e[0] = u8vec3(uvec3(6u, 5u, 3u));
}
#version 450
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
	u8vec3 mB;
	highp ivec3 mC;
	uint8_t mD;
};
layout(std140, buffer_reference) readonly buffer BlockB
{
	i8vec2 a;
	lowp mat3x4 b;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	sA c;
	highp mat2x3 d;
	mediump mat4 e;
	highp vec2 f[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.a), ivec2(0, 2)) && allOk;
	allOk = compare_mat2x3(blockC.d, mat2x3(-5.0, -4.0, 3.0, -5.0, -3.0, -1.0)) && allOk;
	allOk = compare_vec2((blockC.f[0]), vec2(1.0, 6.0)) && allOk;
	allOk = compare_vec2((blockC.f[1]), vec2(0.0, -3.0)) && allOk;
	allOk = compare_vec2((blockC.f[2]), vec2(4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.d = (mat2x3(-9.0, -2.0, -7.0, 9.0, -9.0, 4.0));
	blockC.e = (mat4(-1.0, 8.0, 4.0, -4.0, 0.0, 7.0, 6.0, 5.0, 3.0, 3.0, -4.0, -6.0, 4.0, 2.0, -6.0, 7.0));
	blockC.f[0] = (vec2(-8.0, 5.0));
	blockC.f[1] = (vec2(6.0, 8.0));
	blockC.f[2] = (vec2(9.0, 0.0));
}
#version 450
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
	lowp mat4 a;
	i8vec4 b;
	mediump vec3 c[3];
	u8vec2 d;
	u8vec2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(2.0, 6.0, -4.0, 4.0, -4.0, 2.0, 9.0, -6.0, -7.0, -2.0, 7.0, -1.0, 7.0, -6.0, 0.0, -8.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b), ivec4(4294967288, 1, 4294967291, 0)) && allOk;
	allOk = compare_vec3((blockB.c[0]), vec3(-8.0, 3.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB.c[1]), vec3(-9.0, 1.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB.c[2]), vec3(9.0, -3.0, 2.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.d), uvec2(0u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = i8vec4(ivec4(9, 1, 0, 4294967295));
	blockB.c[0] = (vec3(4.0, -4.0, -2.0));
	blockB.c[1] = (vec3(-2.0, 6.0, -3.0));
	blockB.c[2] = (vec3(8.0, 7.0, -8.0));
	blockB.d = u8vec2(uvec2(1u, 3u));
	blockB.e[0] = u8vec2(uvec2(8u, 0u));
	blockB.e[1] = u8vec2(uvec2(1u, 3u));
	blockB.e[2] = u8vec2(uvec2(8u, 6u));
	blockB.e[3] = u8vec2(uvec2(5u, 6u));
	blockB.e[4] = u8vec2(uvec2(6u, 5u));
}
#version 450
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
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec2(ivec2(8, 2));
}
#version 450
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
	layout(offset = 0) bvec3 a;
	layout(offset = 16) mediump uvec4 b;
	layout(offset = 32) highp ivec2 c;
	layout(offset = 40) uint8_t d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump ivec3 e;
	layout(offset = 12) mediump int f;
	layout(offset = 16) highp uvec4 g;
	layout(offset = 32) bvec3 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC[3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB[0].b), uvec4(6u, 6u, 5u, 1u)) && allOk;
	allOk = compare_uint8_t(uint(blockB[0].d), 1u) && allOk;
	allOk = compare_uvec4((blockB[1].b), uvec4(3u, 8u, 9u, 4u)) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d), 8u) && allOk;
	allOk = compare_uvec4((blockB[2].b), uvec4(6u, 3u, 9u, 2u)) && allOk;
	allOk = compare_uint8_t(uint(blockB[2].d), 9u) && allOk;
	allOk = compare_int((blockC[0].f), -9) && allOk;
	allOk = compare_uvec4((blockC[0].g), uvec4(9u, 9u, 9u, 1u)) && allOk;
	allOk = compare_bvec3((blockC[0].h), bvec3(false, false, true)) && allOk;
	allOk = compare_int((blockC[1].f), 1) && allOk;
	allOk = compare_uvec4((blockC[1].g), uvec4(9u, 5u, 1u, 4u)) && allOk;
	allOk = compare_bvec3((blockC[1].h), bvec3(true, false, false)) && allOk;
	allOk = compare_int((blockC[2].f), 4) && allOk;
	allOk = compare_uvec4((blockC[2].g), uvec4(4u, 8u, 9u, 5u)) && allOk;
	allOk = compare_bvec3((blockC[2].h), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec3(true, false, true));
	blockB[0].c = (ivec2(9, 0));
	blockB[0].d = uint8_t(8u);
	blockB[1].a = (bvec3(false, false, false));
	blockB[1].c = (ivec2(-4, -9));
	blockB[1].d = uint8_t(4u);
	blockB[2].a = (bvec3(true, false, false));
	blockB[2].c = (ivec2(-8, -9));
	blockB[2].d = uint8_t(8u);
	blockC[0].e = (ivec3(9, 2, 8));
	blockC[0].g = (uvec4(8u, 5u, 9u, 8u));
	blockC[0].h = (bvec3(false, false, true));
	blockC[1].e = (ivec3(-5, -6, -8));
	blockC[1].g = (uvec4(1u, 1u, 5u, 8u));
	blockC[1].h = (bvec3(false, false, false));
	blockC[2].e = (ivec3(-3, -5, 5));
	blockC[2].g = (uvec4(4u, 2u, 1u, 5u));
	blockC[2].h = (bvec3(false, false, false));
}
#version 450
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
	layout(offset = 0) highp uvec3 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump ivec2 b;
};
layout(buffer_reference) readonly buffer BlockD
{
	layout(offset = 0) lowp vec3 c;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) lowp uvec4 d;
	layout(offset = 16) i8vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(2u, 5u, 5u)) && allOk;
	allOk = compare_vec3((blockD.c), vec3(-2.0, -3.0, 0.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.e), ivec3(4294967292, 4, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (ivec2(-6, -5));
	blockE.d = (uvec4(8u, 3u, 3u, 5u));
	blockE.e = i8vec3(ivec3(3, 4294967291, 0));
}
#version 450
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
	mediump mat2x3 a;
	lowp uint b;
	highp uvec4 c;
	i8vec2 d;
	lowp mat4 e[];
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockC
{
	lowp mat2x3 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(3.0, 8.0, -8.0, -3.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(-5.0, -4.0, 8.0, -4.0, 1.0, -5.0));
	blockB.c = (uvec4(8u, 8u, 9u, 3u));
}
