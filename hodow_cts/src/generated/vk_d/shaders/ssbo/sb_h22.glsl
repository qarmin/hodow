#version 450
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
	highp float var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var), 7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (7.0);
}
#version 450
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
	mediump vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((var), vec3(1.0, 0.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (vec3(6.0, 8.0, -1.0));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
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
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[0][2], 0.0) && allOk;
	allOk = compare_float(var[0][3], -2.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 9.0) && allOk;
	allOk = compare_float(var[1][3], 3.0) && allOk;
	allOk = compare_float(var[2][0], 7.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], -1.0) && allOk;
	allOk = compare_float(var[2][3], -8.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-5.0, -9.0, 0.0, -2.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(8.0, 8.0, 9.0, 3.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(7.0, -6.0, -1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-7.0, 4.0, -1.0, -8.0));
	var[1] = (vec4(7.0, 3.0, -3.0, 1.0));
	var[2] = (vec4(-4.0, 5.0, -8.0, -6.0));
}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(1.0, 9.0, -9.0, 3.0, 0.0, 7.0, -1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(6.0, -6.0, 7.0, 3.0, 8.0, 3.0, -6.0, 3.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
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
	allOk = compare_mat3(var, mat3(4.0, -3.0, 1.0, -7.0, 7.0, -7.0, -5.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(-5.0, -3.0, -5.0, -2.0, 2.0, -5.0, 6.0, 3.0, -8.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -3.0) && allOk;
	allOk = compare_float(var[2][0], -2.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], 9.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-2.0, -4.0, -7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-1.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-2.0, 9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(-9.0, 4.0, -5.0, 5.0, 0.0, 3.0, -6.0, 8.0, -3.0));
}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(-6.0, -1.0, -7.0, -3.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(7.0, -6.0, -6.0));
	var[1] = (vec3(-9.0, 5.0, 7.0));
}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[0][3], -3.0) && allOk;
	allOk = compare_float(var[1][0], 7.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_float(var[1][3], 1.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], 8.0) && allOk;
	allOk = compare_float(var[2][2], 1.0) && allOk;
	allOk = compare_float(var[2][3], 6.0) && allOk;
	allOk = compare_vec4(var[0], vec4(9.0, 0.0, -1.0, -3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(7.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(6.0, 8.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(3.0, -9.0, -2.0, 8.0, -8.0, -1.0, 8.0, 1.0, -5.0, -8.0, -1.0, 2.0));
}
#version 450
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

	var = (mat4x2(3.0, -6.0, -3.0, 7.0, 2.0, -3.0, 7.0, 4.0));
}
#version 450
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
	highp uvec4 var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 0u) && allOk;
	allOk = compare_uvec4((var), uvec4(2u, 6u, 7u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2u);
	var = (uvec4(1u, 9u, 1u, 8u));
}
#version 450
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
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat2(var, mat2(-4.0, 1.0, 1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0] = (vec2(-1.0, -7.0));
	var[1] = (vec2(-9.0, 5.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat2(var, mat2(8.0, -4.0, 0.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var = (mat2(9.0, 7.0, -4.0, -3.0));
}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_float(var[0][0], 5.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[0][3], 6.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[1][3], -6.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], -7.0) && allOk;
	allOk = compare_float(var[2][2], -4.0) && allOk;
	allOk = compare_float(var[2][3], 2.0) && allOk;
	allOk = compare_float(var[3][0], -6.0) && allOk;
	allOk = compare_float(var[3][1], -4.0) && allOk;
	allOk = compare_float(var[3][2], -7.0) && allOk;
	allOk = compare_float(var[3][3], -7.0) && allOk;
	allOk = compare_vec4(var[0], vec4(5.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-3.0, -2.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(2.0, -7.0, -4.0, 2.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-6.0, -4.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var = (mat4(-6.0, -9.0, 9.0, -9.0, 8.0, 8.0, -8.0, 3.0, -3.0, 5.0, -9.0, -3.0, 2.0, 0.0, -1.0, -9.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[0][3], 2.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_float(var[1][3], 2.0) && allOk;
	allOk = compare_float(var[2][0], 8.0) && allOk;
	allOk = compare_float(var[2][1], 3.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_float(var[2][3], -5.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], -8.0) && allOk;
	allOk = compare_float(var[3][2], -8.0) && allOk;
	allOk = compare_float(var[3][3], 5.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-4.0, 1.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(8.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(8.0, 3.0, -6.0, -5.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-5.0, -8.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var = (mat4(1.0, -7.0, 4.0, 0.0, 8.0, 8.0, 0.0, 6.0, 7.0, 7.0, -5.0, 7.0, -7.0, 8.0, -5.0, 3.0));
}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[2][0], -3.0) && allOk;
	allOk = compare_float(var[2][1], 7.0) && allOk;
	allOk = compare_vec2(var[0], vec2(2.0, 1.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-4.0, 1.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0] = (vec2(6.0, 5.0));
	var[1] = (vec2(9.0, -1.0));
	var[2] = (vec2(-6.0, -1.0));
}
#version 450
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
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[0][3], 2.0) && allOk;
	allOk = compare_float(var[1][0], 0.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 9.0) && allOk;
	allOk = compare_float(var[1][3], -9.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 3.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[2][3], 1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(3.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(0.0, 8.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-6.0, 3.0, 6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-8.0);
	var[0] = (vec4(-3.0, 3.0, -7.0, 7.0));
	var[1] = (vec4(6.0, 3.0, -2.0, 7.0));
	var[2] = (vec4(7.0, -9.0, -7.0, 6.0));
}
#version 450
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
	allOk = compare_mat3(var[0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	var[1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	var[2] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
}
#version 450
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	var[0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	var[0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	var[1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	var[1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	var[1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	var[2][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	var[2][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	var[2][2] = (vec4(7.0, -8.0, -3.0, -2.0));
}
#version 450
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat2x3(var[0], mat2x3(7.0, -5.0, -9.0, 5.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(8.0, 9.0, 2.0, 6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-5.0, -8.0, 2.0, -2.0, 6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0][0] = (vec3(-3.0, 9.0, -8.0));
	var[0][1] = (vec3(-1.0, 1.0, -5.0));
	var[1][0] = (vec3(3.0, -3.0, 7.0));
	var[1][1] = (vec3(6.0, 6.0, -9.0));
	var[2][0] = (vec3(7.0, 0.0, -8.0));
	var[2][1] = (vec3(-2.0, -7.0, 0.0));
}
#version 450
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

	padding = int16_t(6);
	var[0] = int16_t(8);
	var[1] = int16_t(-2);
	var[2] = int16_t(-4);
}
#version 450
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

	var[0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	var[0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	var[0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	var[0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	var[1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	var[1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	var[1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	var[1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	var[2][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	var[2][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	var[2][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[2][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	var[3][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	var[3][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	var[3][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	var[3][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	var[4][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	var[4][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	var[4][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	var[4][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	var[5][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	var[5][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	var[5][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	var[5][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	var[6][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	var[6][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	var[6][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	var[6][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	var[7][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	var[7][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	var[7][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	var[7][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	var[8][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	var[8][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	var[8][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	var[8][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	var[9][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	var[9][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	var[9][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	var[9][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	var[10][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	var[10][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	var[10][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	var[10][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	var[11][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	var[11][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[11][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	var[11][3] = (vec4(8.0, -7.0, 0.0, -8.0));
	var[12][0] = (vec4(4.0, 9.0, -9.0, 1.0));
	var[12][1] = (vec4(-5.0, 7.0, 2.0, -4.0));
	var[12][2] = (vec4(-7.0, -5.0, -4.0, -9.0));
	var[12][3] = (vec4(6.0, -7.0, 7.0, -2.0));
	var[13][0] = (vec4(-3.0, -6.0, 6.0, -4.0));
	var[13][1] = (vec4(-2.0, 1.0, 1.0, 9.0));
	var[13][2] = (vec4(-3.0, 5.0, 1.0, 7.0));
	var[13][3] = (vec4(-2.0, 9.0, -6.0, -6.0));
	var[14][0] = (vec4(-8.0, 2.0, 1.0, -8.0));
	var[14][1] = (vec4(5.0, -3.0, 8.0, 1.0));
	var[14][2] = (vec4(7.0, -4.0, 8.0, -5.0));
	var[14][3] = (vec4(-6.0, -1.0, 9.0, -9.0));
	var[15][0] = (vec4(3.0, -3.0, 3.0, -8.0));
	var[15][1] = (vec4(2.0, -3.0, -6.0, -2.0));
	var[15][2] = (vec4(-3.0, -9.0, -6.0, -3.0));
	var[15][3] = (vec4(8.0, 4.0, 6.0, 7.0));
	var[16][0] = (vec4(7.0, -9.0, 8.0, -1.0));
	var[16][1] = (vec4(9.0, 5.0, 8.0, -4.0));
	var[16][2] = (vec4(-8.0, -2.0, -3.0, 3.0));
	var[16][3] = (vec4(6.0, 4.0, 0.0, -1.0));
	var[17][0] = (vec4(6.0, 3.0, 4.0, -9.0));
	var[17][1] = (vec4(5.0, 5.0, 8.0, -6.0));
	var[17][2] = (vec4(8.0, 3.0, -1.0, -4.0));
	var[17][3] = (vec4(-4.0, 1.0, 4.0, -4.0));
	var[18][0] = (vec4(-5.0, 7.0, -6.0, -2.0));
	var[18][1] = (vec4(-1.0, -6.0, 6.0, 7.0));
	var[18][2] = (vec4(-6.0, 2.0, 9.0, -1.0));
	var[18][3] = (vec4(-1.0, 0.0, -7.0, 8.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(-5.0, -5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(-5.0, 8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(5.0, -4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(-3.0, 0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(-1.0, 0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(7.0, -1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(2.0, 6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(2.0, -4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(-7.0, -7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(7.0, -9.0, 1.0, -8.0, -1.0, -4.0, -7.0, -5.0, 8.0, -9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(-5.0, 9.0, 1.0, 3.0, 0.0, -5.0, 3.0, 4.0, -5.0, 1.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(7.0, -8.0, -6.0, 5.0, -1.0, -9.0, 2.0, -2.0, 6.0, -5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(-9.0, -8.0, -9.0, -3.0, -2.0, 8.0, 4.0, 3.0, -8.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(8.0, -3.0, -6.0, 8.0, -2.0, 8.0, 9.0, 0.0, 1.0, -3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(7.0, 0.0, 3.0, 4.0, -5.0, -8.0, 5.0, 0.0, 8.0, 2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(-8.0, 1.0, -1.0, -1.0, -9.0, 7.0, -4.0, 0.0, -7.0, -9.0, 4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(1.0, 2.0, -5.0));
	var[0][1] = (vec3(-3.0, -2.0, 2.0));
	var[0][2] = (vec3(-5.0, 9.0, 4.0));
	var[0][3] = (vec3(2.0, -4.0, 9.0));
	var[1][0] = (vec3(8.0, -4.0, -5.0));
	var[1][1] = (vec3(-5.0, 6.0, 8.0));
	var[1][2] = (vec3(-7.0, 4.0, -8.0));
	var[1][3] = (vec3(-1.0, 1.0, 1.0));
	var[2][0] = (vec3(-4.0, 5.0, 7.0));
	var[2][1] = (vec3(9.0, 5.0, -7.0));
	var[2][2] = (vec3(8.0, 9.0, 0.0));
	var[2][3] = (vec3(-3.0, 3.0, 0.0));
	var[3][0] = (vec3(7.0, -8.0, -7.0));
	var[3][1] = (vec3(2.0, 7.0, 5.0));
	var[3][2] = (vec3(5.0, -7.0, 0.0));
	var[3][3] = (vec3(-2.0, 9.0, -7.0));
	var[4][0] = (vec3(2.0, -9.0, 0.0));
	var[4][1] = (vec3(9.0, -2.0, -8.0));
	var[4][2] = (vec3(-9.0, 5.0, 9.0));
	var[4][3] = (vec3(0.0, 8.0, -9.0));
	var[5][0] = (vec3(2.0, 1.0, -7.0));
	var[5][1] = (vec3(-7.0, 8.0, 7.0));
	var[5][2] = (vec3(8.0, -8.0, -5.0));
	var[5][3] = (vec3(5.0, 1.0, -3.0));
	var[6][0] = (vec3(2.0, 5.0, 2.0));
	var[6][1] = (vec3(2.0, 3.0, -2.0));
	var[6][2] = (vec3(5.0, 4.0, 6.0));
	var[6][3] = (vec3(-1.0, 5.0, 6.0));
	var[7][0] = (vec3(1.0, 2.0, -4.0));
	var[7][1] = (vec3(9.0, -1.0, 6.0));
	var[7][2] = (vec3(9.0, -1.0, -2.0));
	var[7][3] = (vec3(-1.0, -8.0, 3.0));
	var[8][0] = (vec3(-4.0, 1.0, -4.0));
	var[8][1] = (vec3(4.0, 2.0, 0.0));
	var[8][2] = (vec3(1.0, -6.0, 1.0));
	var[8][3] = (vec3(-7.0, -9.0, 8.0));
	var[9][0] = (vec3(1.0, 9.0, -4.0));
	var[9][1] = (vec3(1.0, -5.0, 9.0));
	var[9][2] = (vec3(2.0, -1.0, -1.0));
	var[9][3] = (vec3(5.0, 7.0, -4.0));
	var[10][0] = (vec3(-2.0, 9.0, -4.0));
	var[10][1] = (vec3(-4.0, 4.0, -1.0));
	var[10][2] = (vec3(0.0, 7.0, 9.0));
	var[10][3] = (vec3(-8.0, 3.0, 9.0));
	var[11][0] = (vec3(-7.0, -1.0, -9.0));
	var[11][1] = (vec3(-7.0, 3.0, 5.0));
	var[11][2] = (vec3(-7.0, 1.0, -1.0));
	var[11][3] = (vec3(-5.0, -7.0, 7.0));
	var[12][0] = (vec3(-5.0, 3.0, -5.0));
	var[12][1] = (vec3(-6.0, 6.0, 3.0));
	var[12][2] = (vec3(-6.0, 0.0, -5.0));
	var[12][3] = (vec3(-9.0, 8.0, -8.0));
	var[13][0] = (vec3(-5.0, 2.0, -7.0));
	var[13][1] = (vec3(-1.0, -2.0, 7.0));
	var[13][2] = (vec3(4.0, -7.0, 7.0));
	var[13][3] = (vec3(-3.0, 7.0, 6.0));
	var[14][0] = (vec3(9.0, -2.0, 2.0));
	var[14][1] = (vec3(-3.0, -6.0, 3.0));
	var[14][2] = (vec3(7.0, -7.0, -1.0));
	var[14][3] = (vec3(0.0, 1.0, -3.0));
	var[15][0] = (vec3(-6.0, 6.0, 2.0));
	var[15][1] = (vec3(-5.0, 0.0, 4.0));
	var[15][2] = (vec3(7.0, -6.0, -6.0));
	var[15][3] = (vec3(3.0, 8.0, 1.0));
	var[16][0] = (vec3(-3.0, -1.0, 7.0));
	var[16][1] = (vec3(-2.0, -7.0, -9.0));
	var[16][2] = (vec3(-8.0, -1.0, 4.0));
	var[16][3] = (vec3(0.0, -2.0, -5.0));
	var[17][0] = (vec3(2.0, -7.0, 3.0));
	var[17][1] = (vec3(-2.0, 4.0, -6.0));
	var[17][2] = (vec3(8.0, -7.0, -9.0));
	var[17][3] = (vec3(-4.0, 5.0, 4.0));
	var[18][0] = (vec3(1.0, -1.0, 8.0));
	var[18][1] = (vec3(8.0, 3.0, -9.0));
	var[18][2] = (vec3(1.0, -1.0, -7.0));
	var[18][3] = (vec3(-1.0, -7.0, -5.0));
}
#version 450
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
	highp mat2x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(-5.0, -8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(1.0, 4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(4.0, 4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-2.0, 5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-9.0, -7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(-5.0, -4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(-9.0, 2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(-5.0, 2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(6.0, 1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(-8.0, 0.0, 0.0, 1.0, 3.0, -4.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(0.0, -3.0, 4.0, -6.0, 4.0, 7.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(1.0, -8.0, 0.0, 1.0, -3.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(8.0, -3.0, 0.0, -2.0, -4.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(0.0, -9.0, 7.0, 0.0, -5.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-7.0, -9.0, -7.0, 4.0, -9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(5.0, -4.0, -9.0, 2.0, -4.0, 7.0, 4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	var[1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	var[2] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
	var[3] = (mat2x4(-3.0, -9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0));
	var[4] = (mat2x4(-3.0, -3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0));
	var[5] = (mat2x4(4.0, 9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0));
	var[6] = (mat2x4(-6.0, 9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0));
	var[7] = (mat2x4(8.0, -6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0));
	var[8] = (mat2x4(-1.0, 2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0));
	var[9] = (mat2x4(2.0, 0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0));
	var[10] = (mat2x4(5.0, -8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0));
	var[11] = (mat2x4(4.0, 9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0));
	var[12] = (mat2x4(4.0, 9.0, -8.0, 5.0, 6.0, -1.0, 4.0, -3.0));
	var[13] = (mat2x4(3.0, -1.0, -8.0, 3.0, 0.0, 1.0, -4.0, -1.0));
	var[14] = (mat2x4(-3.0, 4.0, 1.0, 2.0, 2.0, 0.0, 7.0, 2.0));
	var[15] = (mat2x4(6.0, 1.0, -2.0, 4.0, 9.0, -2.0, -7.0, 5.0));
	var[16] = (mat2x4(-8.0, 2.0, -4.0, 4.0, -8.0, 1.0, -7.0, -7.0));
	var[17] = (mat2x4(1.0, 7.0, 2.0, 3.0, -2.0, 1.0, 0.0, 7.0));
	var[18] = (mat2x4(-5.0, 6.0, 0.0, 7.0, -5.0, 2.0, 0.0, -5.0));
}
#version 450
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
	u8vec3 var[];
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(var[0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2]), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[4]), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[5]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[6]), uvec3(3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[7]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[8]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[9]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[10]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[11]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[12]), uvec3(8u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[13]), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[14]), uvec3(3u, 9u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[15]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[16]), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[17]), uvec3(9u, 3u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[18]), uvec3(5u, 0u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = u8vec3(uvec3(4u, 5u, 9u));
	var[1] = u8vec3(uvec3(6u, 9u, 4u));
	var[2] = u8vec3(uvec3(7u, 1u, 5u));
	var[3] = u8vec3(uvec3(1u, 7u, 9u));
	var[4] = u8vec3(uvec3(3u, 4u, 3u));
	var[5] = u8vec3(uvec3(5u, 7u, 4u));
	var[6] = u8vec3(uvec3(5u, 4u, 7u));
	var[7] = u8vec3(uvec3(0u, 0u, 5u));
	var[8] = u8vec3(uvec3(2u, 5u, 5u));
	var[9] = u8vec3(uvec3(5u, 9u, 6u));
	var[10] = u8vec3(uvec3(9u, 7u, 3u));
	var[11] = u8vec3(uvec3(9u, 4u, 9u));
	var[12] = u8vec3(uvec3(5u, 7u, 3u));
	var[13] = u8vec3(uvec3(9u, 8u, 1u));
	var[14] = u8vec3(uvec3(6u, 2u, 7u));
	var[15] = u8vec3(uvec3(0u, 2u, 7u));
	var[16] = u8vec3(uvec3(4u, 8u, 8u));
	var[17] = u8vec3(uvec3(6u, 1u, 2u));
	var[18] = u8vec3(uvec3(3u, 6u, 6u));
}
#version 450
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
	u16vec4 var[];
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(var[0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[4]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[5]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[6]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[7]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[8]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[9]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[10]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[11]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[12]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[13]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[14]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[15]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[16]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[17]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[18]), uvec4(2u, 6u, 2u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	var[1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	var[2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	var[3] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	var[4] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	var[5] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	var[6] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	var[7] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	var[8] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	var[9] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	var[10] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	var[11] = u16vec4(uvec4(1u, 8u, 4u, 7u));
	var[12] = u16vec4(uvec4(6u, 9u, 4u, 2u));
	var[13] = u16vec4(uvec4(9u, 7u, 6u, 2u));
	var[14] = u16vec4(uvec4(8u, 4u, 6u, 2u));
	var[15] = u16vec4(uvec4(2u, 1u, 0u, 1u));
	var[16] = u16vec4(uvec4(9u, 9u, 4u, 6u));
	var[17] = u16vec4(uvec4(4u, 4u, 2u, 8u));
	var[18] = u16vec4(uvec4(7u, 8u, 2u, 8u));
}
#version 450
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
	highp mat3x4 var[];
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
	allOk = compare_mat3x4(var[3], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(-7.0, -9.0, 9.0, 4.0, 9.0, 5.0, -2.0, -3.0, 8.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(1.0, 1.0, -3.0, 0.0, -6.0, -1.0, -5.0, -8.0, -9.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(9.0, 0.0, -8.0, 0.0, -8.0, 1.0, -3.0, 3.0, -4.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(-4.0, -3.0, 7.0, 1.0, -8.0, -8.0, -5.0, 8.0, -6.0, 9.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(-9.0, -2.0, 7.0, -7.0, 5.0, -9.0, 2.0, 8.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(-1.0, -3.0, 3.0, -5.0, 9.0, -5.0, 3.0, 9.0, 7.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(8.0, -7.0, 0.0, 6.0, 2.0, -6.0, 7.0, -8.0, -5.0, 4.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(8.0, 8.0, -2.0, 8.0));
	var[0][1] = (vec4(8.0, 3.0, 5.0, -5.0));
	var[0][2] = (vec4(7.0, 6.0, -9.0, 3.0));
	var[1][0] = (vec4(0.0, -3.0, 1.0, -9.0));
	var[1][1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	var[1][2] = (vec4(9.0, 0.0, -9.0, -2.0));
	var[2][0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	var[2][1] = (vec4(1.0, -2.0, -2.0, -1.0));
	var[2][2] = (vec4(-7.0, 8.0, 0.0, -6.0));
	var[3][0] = (vec4(-1.0, 7.0, -6.0, -1.0));
	var[3][1] = (vec4(-7.0, -8.0, 7.0, -8.0));
	var[3][2] = (vec4(6.0, -8.0, 2.0, -5.0));
	var[4][0] = (vec4(9.0, -7.0, 4.0, -1.0));
	var[4][1] = (vec4(-3.0, -8.0, -1.0, 1.0));
	var[4][2] = (vec4(-6.0, -4.0, -8.0, 4.0));
	var[5][0] = (vec4(5.0, 0.0, -6.0, 5.0));
	var[5][1] = (vec4(-1.0, 4.0, 3.0, -6.0));
	var[5][2] = (vec4(1.0, 8.0, -2.0, 3.0));
	var[6][0] = (vec4(-1.0, -9.0, 4.0, 9.0));
	var[6][1] = (vec4(0.0, 2.0, -7.0, -7.0));
	var[6][2] = (vec4(-1.0, 8.0, -9.0, -3.0));
	var[7][0] = (vec4(5.0, 7.0, -8.0, 1.0));
	var[7][1] = (vec4(-5.0, 0.0, -7.0, -3.0));
	var[7][2] = (vec4(-5.0, -4.0, 3.0, -5.0));
	var[8][0] = (vec4(4.0, 5.0, -9.0, -6.0));
	var[8][1] = (vec4(5.0, 3.0, -6.0, -7.0));
	var[8][2] = (vec4(-3.0, 9.0, 3.0, -7.0));
	var[9][0] = (vec4(-9.0, -9.0, 6.0, -9.0));
	var[9][1] = (vec4(6.0, -1.0, -1.0, -4.0));
	var[9][2] = (vec4(5.0, 2.0, -6.0, 8.0));
	var[10][0] = (vec4(4.0, 2.0, 4.0, -3.0));
	var[10][1] = (vec4(9.0, 8.0, 5.0, -3.0));
	var[10][2] = (vec4(7.0, -4.0, 6.0, 4.0));
	var[11][0] = (vec4(0.0, -2.0, 1.0, 8.0));
	var[11][1] = (vec4(1.0, 4.0, 6.0, 4.0));
	var[11][2] = (vec4(-2.0, 9.0, 9.0, 7.0));
	var[12][0] = (vec4(4.0, -1.0, 2.0, -8.0));
	var[12][1] = (vec4(-6.0, 4.0, -8.0, 9.0));
	var[12][2] = (vec4(0.0, 7.0, -2.0, 2.0));
	var[13][0] = (vec4(2.0, 9.0, -9.0, 2.0));
	var[13][1] = (vec4(1.0, 5.0, 5.0, 5.0));
	var[13][2] = (vec4(0.0, 9.0, 8.0, 7.0));
	var[14][0] = (vec4(7.0, 5.0, -7.0, -6.0));
	var[14][1] = (vec4(-4.0, 4.0, -5.0, -7.0));
	var[14][2] = (vec4(2.0, 2.0, 1.0, -7.0));
	var[15][0] = (vec4(1.0, -1.0, 9.0, -4.0));
	var[15][1] = (vec4(4.0, 1.0, 7.0, -4.0));
	var[15][2] = (vec4(1.0, 9.0, -7.0, 4.0));
	var[16][0] = (vec4(-2.0, 5.0, -1.0, 9.0));
	var[16][1] = (vec4(-9.0, -6.0, 3.0, 7.0));
	var[16][2] = (vec4(-1.0, -6.0, 3.0, -3.0));
	var[17][0] = (vec4(1.0, 7.0, 2.0, -9.0));
	var[17][1] = (vec4(0.0, -8.0, -8.0, 4.0));
	var[17][2] = (vec4(7.0, 6.0, 8.0, -2.0));
	var[18][0] = (vec4(8.0, 9.0, -2.0, -1.0));
	var[18][1] = (vec4(7.0, -4.0, -8.0, 9.0));
	var[18][2] = (vec4(-5.0, 7.0, 9.0, -6.0));
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
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

	var[0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	var[1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	var[2] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
	var[3] = (mat4x3(-7.0, 2.0, -4.0, -9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0));
	var[4] = (mat4x3(0.0, 1.0, -1.0, -6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0));
	var[5] = (mat4x3(-9.0, -1.0, -4.0, -9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0));
	var[6] = (mat4x3(0.0, 5.0, -1.0, -3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0));
	var[7] = (mat4x3(2.0, 9.0, -6.0, 5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0));
	var[8] = (mat4x3(8.0, 9.0, 0.0, 1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0));
	var[9] = (mat4x3(2.0, 7.0, 3.0, 1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0));
	var[10] = (mat4x3(-1.0, 7.0, 7.0, 4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0));
	var[11] = (mat4x3(9.0, 4.0, 1.0, -2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0));
	var[12] = (mat4x3(7.0, -6.0, 6.0, 6.0, 0.0, 6.0, -2.0, 0.0, 4.0, -2.0, -4.0, 0.0));
	var[13] = (mat4x3(0.0, 0.0, 8.0, 0.0, 5.0, -8.0, -7.0, 0.0, 2.0, 1.0, 6.0, -6.0));
	var[14] = (mat4x3(-9.0, 8.0, 6.0, 9.0, -9.0, 5.0, -2.0, 2.0, -2.0, 2.0, -6.0, -1.0));
	var[15] = (mat4x3(1.0, -7.0, -5.0, 9.0, -4.0, -7.0, -9.0, 7.0, -4.0, 9.0, -3.0, 3.0));
	var[16] = (mat4x3(7.0, -7.0, -2.0, -5.0, 7.0, 7.0, -1.0, 6.0, -1.0, 6.0, -9.0, 8.0));
	var[17] = (mat4x3(8.0, 7.0, -8.0, 1.0, 9.0, -1.0, -8.0, -3.0, 7.0, 9.0, -5.0, 8.0));
	var[18] = (mat4x3(-3.0, -3.0, 9.0, 5.0, -4.0, 6.0, 4.0, -2.0, 9.0, 0.0, -7.0, 3.0));
}
#version 450
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
	highp mat3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	var[0][1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	var[0][2] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
	var[1][0] = (mat3(-9.0, 3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0));
	var[1][1] = (mat3(4.0, 7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0));
	var[1][2] = (mat3(7.0, -6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0));
	var[2][0] = (mat3(5.0, 4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0));
	var[2][1] = (mat3(-3.0, 6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0));
	var[2][2] = (mat3(-4.0, -4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0));
	var[3][0] = (mat3(-8.0, -8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0));
	var[3][1] = (mat3(-3.0, -8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0));
	var[3][2] = (mat3(3.0, -2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0][0], mat2x3(2.0, -7.0, 8.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(5.0, -2.0, 1.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(6.0, 7.0, 2.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(-5.0, 5.0, 9.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(9.0, 7.0, 9.0, 5.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(1.0, 4.0, -6.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(-9.0, 9.0, 8.0, -5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(9.0, -3.0, -8.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(-8.0, 9.0, 4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(-4.0, -8.0, 0.0, -2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(-3.0, 2.0, 2.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(-3.0, 9.0, -3.0, -8.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	var[0][1] = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	var[0][2] = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
	var[1][0] = (mat2x3(-4.0, 3.0, 7.0, -5.0, -6.0, 7.0));
	var[1][1] = (mat2x3(3.0, 8.0, -7.0, -7.0, -6.0, 2.0));
	var[1][2] = (mat2x3(-8.0, 8.0, -7.0, -2.0, 5.0, 7.0));
	var[2][0] = (mat2x3(4.0, -7.0, -7.0, 6.0, -8.0, -8.0));
	var[2][1] = (mat2x3(7.0, -8.0, 4.0, 7.0, 0.0, 3.0));
	var[2][2] = (mat2x3(9.0, 4.0, 7.0, 4.0, -7.0, 6.0));
	var[3][0] = (mat2x3(1.0, 3.0, 2.0, -1.0, -8.0, -8.0));
	var[3][1] = (mat2x3(2.0, 9.0, -3.0, -1.0, -2.0, -1.0));
	var[3][2] = (mat2x3(-1.0, 8.0, 1.0, -6.0, -9.0, -3.0));
}
#version 450
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
	highp uint var[4][3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var[0][0]), 3u) && allOk;
	allOk = compare_uint((var[0][1]), 6u) && allOk;
	allOk = compare_uint((var[0][2]), 9u) && allOk;
	allOk = compare_uint((var[1][0]), 0u) && allOk;
	allOk = compare_uint((var[1][1]), 3u) && allOk;
	allOk = compare_uint((var[1][2]), 7u) && allOk;
	allOk = compare_uint((var[2][0]), 6u) && allOk;
	allOk = compare_uint((var[2][1]), 4u) && allOk;
	allOk = compare_uint((var[2][2]), 2u) && allOk;
	allOk = compare_uint((var[3][0]), 5u) && allOk;
	allOk = compare_uint((var[3][1]), 7u) && allOk;
	allOk = compare_uint((var[3][2]), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (7u);
	var[0][1] = (9u);
	var[0][2] = (1u);
	var[1][0] = (0u);
	var[1][1] = (7u);
	var[1][2] = (7u);
	var[2][0] = (4u);
	var[2][1] = (8u);
	var[2][2] = (7u);
	var[3][0] = (5u);
	var[3][1] = (7u);
	var[3][2] = (2u);
}
#version 450
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
	u16vec4 var[4][3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 6u) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][0]), uvec4(0u, 8u, 3u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][1]), uvec4(7u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][2]), uvec4(7u, 1u, 8u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][0]), uvec4(0u, 5u, 8u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][1]), uvec4(4u, 6u, 1u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][2]), uvec4(3u, 6u, 0u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][0]), uvec4(2u, 2u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][1]), uvec4(9u, 3u, 0u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][2]), uvec4(0u, 4u, 9u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][0]), uvec4(7u, 1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][1]), uvec4(7u, 4u, 5u, 7u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][2]), uvec4(0u, 8u, 3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint16_t(0u);
	var[0][0] = u16vec4(uvec4(6u, 9u, 4u, 5u));
	var[0][1] = u16vec4(uvec4(0u, 1u, 0u, 7u));
	var[0][2] = u16vec4(uvec4(6u, 5u, 9u, 8u));
	var[1][0] = u16vec4(uvec4(3u, 6u, 1u, 7u));
	var[1][1] = u16vec4(uvec4(9u, 3u, 8u, 1u));
	var[1][2] = u16vec4(uvec4(4u, 3u, 9u, 9u));
	var[2][0] = u16vec4(uvec4(3u, 0u, 2u, 3u));
	var[2][1] = u16vec4(uvec4(5u, 0u, 2u, 5u));
	var[2][2] = u16vec4(uvec4(1u, 5u, 5u, 4u));
	var[3][0] = u16vec4(uvec4(0u, 8u, 4u, 0u));
	var[3][1] = u16vec4(uvec4(3u, 7u, 1u, 1u));
	var[3][2] = u16vec4(uvec4(8u, 4u, 7u, 6u));
}
#version 450
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
	i16vec3 var[4][3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), 3) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][0]), ivec3(4, 8, 7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][1]), ivec3(-4, 0, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][2]), ivec3(-5, -9, 9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][0]), ivec3(4, 2, -6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][1]), ivec3(6, -2, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][2]), ivec3(-1, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][0]), ivec3(-4, -8, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][1]), ivec3(-8, 6, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][2]), ivec3(-3, 3, -6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][0]), ivec3(0, -1, 5)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][1]), ivec3(1, 0, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][2]), ivec3(5, 1, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int16_t(6);
	var[0][0] = i16vec3(ivec3(1, -2, -3));
	var[0][1] = i16vec3(ivec3(-1, -4, -2));
	var[0][2] = i16vec3(ivec3(-2, 2, 0));
	var[1][0] = i16vec3(ivec3(-6, -2, 0));
	var[1][1] = i16vec3(ivec3(-9, 2, -8));
	var[1][2] = i16vec3(ivec3(6, 2, -5));
	var[2][0] = i16vec3(ivec3(-4, -8, 0));
	var[2][1] = i16vec3(ivec3(9, 6, 5));
	var[2][2] = i16vec3(ivec3(-3, 4, -3));
	var[3][0] = i16vec3(ivec3(9, 0, 1));
	var[3][1] = i16vec3(ivec3(-5, 8, -5));
	var[3][2] = i16vec3(ivec3(0, 7, -6));
}
#version 450
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
	f16vec2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(var[0][0][0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][0][1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][0][2]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][1][0]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][1][1]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][1][2]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][0][0]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][0][1]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][0][2]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][1][0]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][1][1]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][1][2]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][0][0]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][0][1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][0][2]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][1][0]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][1][1]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][1][2]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][0][0]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][0][1]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][0][2]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][1][0]), vec2(-3.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][1][1]), vec2(0.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][1][2]), vec2(3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = f16vec2(vec2(-2.0, 4.0));
	var[0][0][1] = f16vec2(vec2(-2.0, 4.0));
	var[0][0][2] = f16vec2(vec2(-1.0, 1.0));
	var[0][1][0] = f16vec2(vec2(6.0, 0.0));
	var[0][1][1] = f16vec2(vec2(3.0, 5.0));
	var[0][1][2] = f16vec2(vec2(9.0, -9.0));
	var[1][0][0] = f16vec2(vec2(9.0, 4.0));
	var[1][0][1] = f16vec2(vec2(8.0, -8.0));
	var[1][0][2] = f16vec2(vec2(1.0, -3.0));
	var[1][1][0] = f16vec2(vec2(-6.0, 7.0));
	var[1][1][1] = f16vec2(vec2(3.0, -7.0));
	var[1][1][2] = f16vec2(vec2(4.0, -5.0));
	var[2][0][0] = f16vec2(vec2(2.0, 2.0));
	var[2][0][1] = f16vec2(vec2(-6.0, 5.0));
	var[2][0][2] = f16vec2(vec2(5.0, -7.0));
	var[2][1][0] = f16vec2(vec2(7.0, -6.0));
	var[2][1][1] = f16vec2(vec2(-2.0, -4.0));
	var[2][1][2] = f16vec2(vec2(5.0, -2.0));
	var[3][0][0] = f16vec2(vec2(3.0, 0.0));
	var[3][0][1] = f16vec2(vec2(-2.0, 3.0));
	var[3][0][2] = f16vec2(vec2(-6.0, 5.0));
	var[3][1][0] = f16vec2(vec2(5.0, 2.0));
	var[3][1][1] = f16vec2(vec2(8.0, -7.0));
	var[3][1][2] = f16vec2(vec2(3.0, -7.0));
}
#version 450
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
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(6.0, -1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-5.0, -9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(2.0, -1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(7.0, 1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(2.0, 9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(9.0, 6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(6.0, -3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(7.0, 8.0, 7.0, 3.0, 8.0, -3.0, -9.0, -6.0, 2.0, 0.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(4.0, -8.0, 4.0, 1.0, 8.0, -2.0, 5.0, -4.0, -7.0, -4.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(-9.0, 7.0, -5.0, 5.0, -6.0, -9.0, -8.0, 4.0, 1.0, 0.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(-5.0, 3.0, -9.0, 7.0, -8.0, -8.0, 4.0, -3.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(2.0, -3.0, 2.0, -8.0, 3.0, -8.0, 3.0, 0.0, -9.0, 0.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	var[0][0][1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	var[0][0][2] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	var[0][1][0] = (mat4x3(-2.0, 7.0, -6.0, -4.0, -2.0, 0.0, 4.0, -2.0, 6.0, -6.0, -5.0, -8.0));
	var[0][1][1] = (mat4x3(-1.0, 2.0, 4.0, 2.0, -2.0, 9.0, 0.0, -4.0, 6.0, -7.0, -4.0, 2.0));
	var[0][1][2] = (mat4x3(1.0, 2.0, -9.0, -3.0, 6.0, -9.0, 8.0, 2.0, 1.0, -8.0, 3.0, 2.0));
	var[1][0][0] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	var[1][0][1] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	var[1][0][2] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	var[1][1][0] = (mat4x3(1.0, 4.0, 9.0, -7.0, -5.0, 2.0, -8.0, 0.0, 0.0, -4.0, 9.0, 5.0));
	var[1][1][1] = (mat4x3(-2.0, -9.0, 6.0, -9.0, -4.0, -7.0, 9.0, -5.0, 3.0, 5.0, -1.0, -4.0));
	var[1][1][2] = (mat4x3(1.0, -1.0, -8.0, 4.0, 4.0, 4.0, -3.0, 4.0, 0.0, 0.0, -7.0, -1.0));
	var[2][0][0] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	var[2][0][1] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	var[2][0][2] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	var[2][1][0] = (mat4x3(2.0, 6.0, 9.0, -5.0, -9.0, -9.0, 5.0, 6.0, 4.0, 6.0, -3.0, 1.0));
	var[2][1][1] = (mat4x3(3.0, -1.0, 9.0, -2.0, 9.0, 6.0, -9.0, 4.0, 3.0, -7.0, -3.0, 3.0));
	var[2][1][2] = (mat4x3(-7.0, 9.0, 6.0, -6.0, 1.0, 1.0, -3.0, -1.0, 8.0, -2.0, 3.0, -3.0));
	var[3][0][0] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	var[3][0][1] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	var[3][0][2] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
	var[3][1][0] = (mat4x3(-5.0, 4.0, 0.0, -9.0, 9.0, -1.0, 0.0, -9.0, -3.0, 6.0, -2.0, 0.0));
	var[3][1][1] = (mat4x3(-5.0, -9.0, 2.0, -1.0, 4.0, 0.0, -4.0, 1.0, 3.0, -9.0, -5.0, -6.0));
	var[3][1][2] = (mat4x3(7.0, -4.0, 3.0, 0.0, -2.0, -5.0, -8.0, 3.0, 5.0, -1.0, 3.0, 5.0));
}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0, 8.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0, -3.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(-1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0, -8.0, 6.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-1.0, -7.0, 0.0, 3.0, -2.0, -4.0, -5.0, -7.0, -5.0, 8.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-5.0, -5.0, -9.0, 2.0, -7.0, 9.0, 0.0, -6.0, -5.0, 4.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(3.0, -2.0, -9.0, 8.0, -8.0, 8.0, 8.0, -2.0, 0.0, -4.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0, 5.0, -5.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0, -2.0, 3.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0, -3.0, 1.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(9.0, -8.0, 1.0, -7.0, -8.0, -9.0, -2.0, 3.0, -2.0, 9.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-8.0, 5.0, 9.0, -3.0, 7.0, 2.0, -1.0, 3.0, 9.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(7.0, 1.0, -5.0, 4.0, 4.0, -5.0, 0.0, 0.0, 7.0, -2.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0, 6.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0, 8.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0, -3.0, -4.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-8.0, -1.0, 9.0, 9.0, 2.0, 9.0, -6.0, -8.0, -3.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(0.0, -9.0, -8.0, -1.0, -6.0, 9.0, 7.0, -5.0, 4.0, 7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(4.0, 6.0, -6.0, -5.0, 1.0, -7.0, 8.0, -6.0, -2.0, 1.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0, -5.0, 7.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0, 4.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0, 1.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(0.0, -8.0, -7.0, 3.0, 3.0, -8.0, 1.0, 1.0, 1.0, 1.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(-5.0, -1.0, 2.0, -4.0, -8.0, -7.0, -1.0, 0.0, -2.0, 3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(3.0, 7.0, 9.0, 3.0, -3.0, 7.0, -8.0, 1.0, -9.0, 3.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0][0][0] = (vec4(-8.0, -4.0, 1.0, -8.0));
	var[0][0][0][1] = (vec4(-4.0, 3.0, 6.0, -4.0));
	var[0][0][0][2] = (vec4(-8.0, -5.0, 9.0, -4.0));
	var[0][0][1][0] = (vec4(0.0, 7.0, -9.0, 4.0));
	var[0][0][1][1] = (vec4(-4.0, -4.0, -8.0, 9.0));
	var[0][0][1][2] = (vec4(-7.0, 6.0, -4.0, 2.0));
	var[0][0][2][0] = (vec4(-1.0, -7.0, 7.0, 1.0));
	var[0][0][2][1] = (vec4(0.0, 4.0, 1.0, -9.0));
	var[0][0][2][2] = (vec4(-7.0, 2.0, -6.0, 3.0));
	var[0][1][0][0] = (vec4(-4.0, 6.0, -3.0, -6.0));
	var[0][1][0][1] = (vec4(2.0, -9.0, -8.0, 6.0));
	var[0][1][0][2] = (vec4(5.0, 1.0, 8.0, -7.0));
	var[0][1][1][0] = (vec4(9.0, 8.0, -6.0, -2.0));
	var[0][1][1][1] = (vec4(9.0, -5.0, 4.0, -4.0));
	var[0][1][1][2] = (vec4(0.0, 5.0, 8.0, -5.0));
	var[0][1][2][0] = (vec4(-2.0, 5.0, -5.0, 9.0));
	var[0][1][2][1] = (vec4(7.0, -5.0, -3.0, 0.0));
	var[0][1][2][2] = (vec4(-1.0, -2.0, -8.0, -5.0));
	var[1][0][0][0] = (vec4(4.0, -2.0, -3.0, -6.0));
	var[1][0][0][1] = (vec4(8.0, 9.0, -9.0, -5.0));
	var[1][0][0][2] = (vec4(-3.0, 5.0, 9.0, 3.0));
	var[1][0][1][0] = (vec4(9.0, -2.0, 4.0, -9.0));
	var[1][0][1][1] = (vec4(1.0, -8.0, -2.0, 1.0));
	var[1][0][1][2] = (vec4(4.0, -1.0, -5.0, -8.0));
	var[1][0][2][0] = (vec4(-5.0, -8.0, -2.0, 7.0));
	var[1][0][2][1] = (vec4(-3.0, -9.0, 0.0, -9.0));
	var[1][0][2][2] = (vec4(-2.0, 9.0, 8.0, 7.0));
	var[1][1][0][0] = (vec4(7.0, -8.0, -6.0, 0.0));
	var[1][1][0][1] = (vec4(7.0, -9.0, 2.0, 3.0));
	var[1][1][0][2] = (vec4(-6.0, 7.0, 0.0, 6.0));
	var[1][1][1][0] = (vec4(0.0, 2.0, 9.0, -1.0));
	var[1][1][1][1] = (vec4(3.0, -4.0, 9.0, -2.0));
	var[1][1][1][2] = (vec4(-9.0, -7.0, 6.0, -4.0));
	var[1][1][2][0] = (vec4(-4.0, 3.0, 1.0, -1.0));
	var[1][1][2][1] = (vec4(9.0, -4.0, -1.0, 3.0));
	var[1][1][2][2] = (vec4(6.0, 1.0, -2.0, -1.0));
	var[2][0][0][0] = (vec4(6.0, -9.0, -7.0, 3.0));
	var[2][0][0][1] = (vec4(-3.0, -6.0, -1.0, 0.0));
	var[2][0][0][2] = (vec4(4.0, -2.0, -4.0, 2.0));
	var[2][0][1][0] = (vec4(-3.0, -9.0, -1.0, 0.0));
	var[2][0][1][1] = (vec4(-9.0, 1.0, 6.0, 5.0));
	var[2][0][1][2] = (vec4(3.0, -1.0, 9.0, -8.0));
	var[2][0][2][0] = (vec4(4.0, 3.0, -7.0, 5.0));
	var[2][0][2][1] = (vec4(-4.0, 7.0, 2.0, -6.0));
	var[2][0][2][2] = (vec4(4.0, -8.0, 5.0, -2.0));
	var[2][1][0][0] = (vec4(6.0, 2.0, -2.0, 8.0));
	var[2][1][0][1] = (vec4(9.0, 2.0, -4.0, 7.0));
	var[2][1][0][2] = (vec4(-1.0, -9.0, -5.0, -8.0));
	var[2][1][1][0] = (vec4(-5.0, 2.0, -3.0, 5.0));
	var[2][1][1][1] = (vec4(-3.0, -2.0, -5.0, 3.0));
	var[2][1][1][2] = (vec4(-7.0, 8.0, -8.0, -3.0));
	var[2][1][2][0] = (vec4(-4.0, 6.0, -2.0, -2.0));
	var[2][1][2][1] = (vec4(-4.0, -3.0, -1.0, -3.0));
	var[2][1][2][2] = (vec4(8.0, -3.0, -6.0, 7.0));
	var[3][0][0][0] = (vec4(7.0, 5.0, -1.0, 1.0));
	var[3][0][0][1] = (vec4(6.0, -2.0, -5.0, 9.0));
	var[3][0][0][2] = (vec4(4.0, -9.0, -3.0, -6.0));
	var[3][0][1][0] = (vec4(2.0, 4.0, -3.0, 1.0));
	var[3][0][1][1] = (vec4(9.0, -1.0, -1.0, -1.0));
	var[3][0][1][2] = (vec4(2.0, 5.0, -5.0, 7.0));
	var[3][0][2][0] = (vec4(9.0, -7.0, -5.0, -9.0));
	var[3][0][2][1] = (vec4(3.0, 9.0, 2.0, -5.0));
	var[3][0][2][2] = (vec4(-4.0, -7.0, -3.0, 7.0));
	var[3][1][0][0] = (vec4(-6.0, 4.0, -4.0, -8.0));
	var[3][1][0][1] = (vec4(1.0, 2.0, 2.0, -4.0));
	var[3][1][0][2] = (vec4(9.0, -4.0, 8.0, -1.0));
	var[3][1][1][0] = (vec4(5.0, 9.0, 3.0, -7.0));
	var[3][1][1][1] = (vec4(7.0, -8.0, -1.0, -8.0));
	var[3][1][1][2] = (vec4(-9.0, 2.0, 6.0, 3.0));
	var[3][1][2][0] = (vec4(-5.0, 3.0, 5.0, -2.0));
	var[3][1][2][1] = (vec4(-3.0, 2.0, 1.0, 6.0));
	var[3][1][2][2] = (vec4(-4.0, 6.0, -5.0, 8.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(5.0, 8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(-6.0, -5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(1.0, 8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(4.0, -6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(9.0, -6.0, 0.0, -6.0, -4.0, 0.0, 7.0, 0.0, 7.0, 0.0, 8.0, 2.0, -6.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(9.0, -2.0, 1.0, -9.0, -6.0, -1.0, -4.0, 6.0, 8.0, -7.0, 1.0, 3.0, -9.0, 5.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(-2.0, -4.0, 3.0, -3.0, 5.0, 1.0, -7.0, 8.0, 7.0, -9.0, -3.0, 7.0, 9.0, -9.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(4.0, -2.0, 4.0, -4.0, 1.0, 7.0, 6.0, 9.0, 8.0, -8.0, -3.0, -4.0, -7.0, 4.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-1.0, -6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-9.0, -1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(9.0, -9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(6.0, 1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(-2.0, 4.0, 5.0, 9.0, 0.0, 0.0, 9.0, 3.0, -9.0, -4.0, 5.0, -2.0, 7.0, 9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(9.0, 0.0, -2.0, -7.0, -8.0, 0.0, 3.0, -1.0, -9.0, 1.0, 9.0, -1.0, 5.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(-3.0, -5.0, 2.0, 3.0, -9.0, -7.0, 3.0, -6.0, 4.0, 1.0, -7.0, 9.0, 2.0, 6.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-7.0, -7.0, -4.0, 1.0, 4.0, 3.0, 9.0, -8.0, -6.0, -7.0, -1.0, -7.0, -7.0, 7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-2.0, 7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-9.0, 9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(-3.0, 2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-1.0, -3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(4.0, -5.0, -9.0, 5.0, 4.0, 7.0, 0.0, -6.0, -5.0, -9.0, 6.0, 9.0, 4.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(2.0, 5.0, 9.0, -6.0, 4.0, 6.0, -4.0, 1.0, 6.0, 1.0, 3.0, 4.0, 3.0, 8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(-6.0, 2.0, 5.0, 3.0, 5.0, -7.0, 3.0, -6.0, -7.0, 6.0, 1.0, -5.0, -6.0, 9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(2.0, -7.0, -4.0, -2.0, -7.0, 1.0, -1.0, 4.0, -9.0, 4.0, 9.0, -9.0, 0.0, -9.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	var[0][0][1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	var[0][1][0] = (mat4(6.0, -8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0));
	var[0][1][1] = (mat4(6.0, 9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0));
	var[0][2][0] = (mat4(-4.0, -9.0, -7.0, -9.0, -9.0, -3.0, -8.0, 0.0, -1.0, -4.0, -1.0, -8.0, 5.0, -8.0, -3.0, 1.0));
	var[0][2][1] = (mat4(-1.0, -6.0, -1.0, 0.0, -8.0, 6.0, 6.0, -5.0, -6.0, 9.0, 2.0, 6.0, 6.0, -5.0, -7.0, 0.0));
	var[0][3][0] = (mat4(4.0, -5.0, 2.0, -2.0, -1.0, 1.0, 4.0, 0.0, -1.0, -4.0, -1.0, 2.0, -4.0, 7.0, -7.0, -7.0));
	var[0][3][1] = (mat4(1.0, -8.0, 7.0, -2.0, 3.0, 6.0, -2.0, -7.0, -7.0, -8.0, 7.0, 1.0, -1.0, -5.0, 6.0, -5.0));
	var[1][0][0] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
	var[1][0][1] = (mat4(-3.0, -9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0));
	var[1][1][0] = (mat4(6.0, -6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0));
	var[1][1][1] = (mat4(-5.0, 3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0));
	var[1][2][0] = (mat4(2.0, 6.0, 3.0, 6.0, 1.0, -3.0, -6.0, 0.0, -2.0, 0.0, -9.0, 1.0, 6.0, 9.0, -9.0, 0.0));
	var[1][2][1] = (mat4(-9.0, 4.0, 1.0, 5.0, 0.0, 9.0, 3.0, -2.0, -8.0, 9.0, -9.0, 2.0, -8.0, 0.0, 7.0, 7.0));
	var[1][3][0] = (mat4(6.0, -7.0, -1.0, -1.0, -1.0, -3.0, -6.0, 3.0, -9.0, -8.0, -5.0, 6.0, -3.0, 3.0, 8.0, -8.0));
	var[1][3][1] = (mat4(5.0, -4.0, 6.0, 7.0, 5.0, 0.0, 0.0, -5.0, 4.0, -8.0, -9.0, -1.0, -8.0, 5.0, 0.0, -4.0));
	var[2][0][0] = (mat4(1.0, 5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0));
	var[2][0][1] = (mat4(-7.0, 5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0));
	var[2][1][0] = (mat4(-9.0, 5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0));
	var[2][1][1] = (mat4(5.0, -1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0));
	var[2][2][0] = (mat4(6.0, -5.0, 5.0, 3.0, -2.0, -8.0, 6.0, 2.0, 7.0, -1.0, -2.0, 8.0, -9.0, 1.0, -4.0, 1.0));
	var[2][2][1] = (mat4(-5.0, -8.0, 1.0, 9.0, -7.0, -4.0, 0.0, -3.0, 6.0, 2.0, 2.0, -2.0, -8.0, 4.0, 1.0, 7.0));
	var[2][3][0] = (mat4(2.0, 7.0, -3.0, 8.0, -6.0, 0.0, 1.0, 7.0, 8.0, -8.0, -8.0, -9.0, -3.0, -1.0, -7.0, 0.0));
	var[2][3][1] = (mat4(6.0, -2.0, -5.0, -4.0, -6.0, 9.0, -4.0, -9.0, 8.0, -7.0, -5.0, -3.0, 3.0, 5.0, 4.0, -2.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(1.0, 3.0, -2.0, -3.0, -6.0, 5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(8.0, -1.0, 5.0, 7.0, -6.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(-4.0, 9.0, 9.0, 0.0, 9.0, -4.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(-9.0, 6.0, 5.0, 1.0, 2.0, 1.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(-6.0, 4.0, 9.0, -5.0, -9.0, 7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(-9.0, 8.0, -3.0, 8.0, -9.0, -6.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(-1.0, 0.0, -9.0, 6.0, 9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(9.0, -3.0, -8.0, 7.0, 2.0, -5.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(-6.0, -1.0, -6.0, -5.0, -3.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(-1.0, -8.0, -4.0, 8.0, -6.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(0.0, 5.0, 8.0, -5.0, 9.0, 4.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(1.0, 5.0, 6.0, -2.0, 0.0, -8.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	var[0][0][1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	var[0][1][0] = (mat2x4(-7.0, 0.0, -8.0, 2.0, -6.0, -5.0, 9.0, 2.0));
	var[0][1][1] = (mat2x4(2.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 2.0));
	var[0][2][0] = (mat2x4(1.0, -7.0, -5.0, 8.0, 7.0, 5.0, -9.0, 8.0));
	var[0][2][1] = (mat2x4(-9.0, -3.0, 4.0, 1.0, 7.0, 5.0, -2.0, 7.0));
	var[0][3][0] = (mat2x4(8.0, 2.0, 5.0, 5.0, 6.0, -6.0, 6.0, -3.0));
	var[0][3][1] = (mat2x4(1.0, 8.0, 2.0, 3.0, 2.0, -5.0, 3.0, 3.0));
	var[1][0][0] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
	var[1][0][1] = (mat2x4(-6.0, 1.0, 7.0, -9.0, 7.0, -5.0, -1.0, -8.0));
	var[1][1][0] = (mat2x4(4.0, 2.0, 8.0, -5.0, -9.0, -1.0, 6.0, -2.0));
	var[1][1][1] = (mat2x4(4.0, 1.0, -1.0, -1.0, 7.0, 0.0, 6.0, 9.0));
	var[1][2][0] = (mat2x4(5.0, 2.0, 3.0, -3.0, -1.0, 8.0, 4.0, -9.0));
	var[1][2][1] = (mat2x4(2.0, 5.0, 5.0, -9.0, -7.0, 9.0, 4.0, -1.0));
	var[1][3][0] = (mat2x4(-4.0, -9.0, -5.0, -3.0, 6.0, 8.0, 8.0, 7.0));
	var[1][3][1] = (mat2x4(-3.0, -4.0, -9.0, -1.0, -5.0, -2.0, 3.0, 1.0));
	var[2][0][0] = (mat2x4(-2.0, -6.0, -6.0, 6.0, 6.0, -7.0, 6.0, 9.0));
	var[2][0][1] = (mat2x4(3.0, 9.0, 4.0, -6.0, 7.0, -1.0, 9.0, 5.0));
	var[2][1][0] = (mat2x4(5.0, 9.0, -6.0, -6.0, -2.0, -9.0, 9.0, 3.0));
	var[2][1][1] = (mat2x4(2.0, 4.0, -3.0, 6.0, 6.0, 9.0, 1.0, 5.0));
	var[2][2][0] = (mat2x4(7.0, 7.0, -4.0, 6.0, 0.0, -9.0, 5.0, -7.0));
	var[2][2][1] = (mat2x4(-4.0, 5.0, -1.0, 5.0, 8.0, -2.0, -5.0, 5.0));
	var[2][3][0] = (mat2x4(-1.0, 9.0, -7.0, 4.0, -9.0, 0.0, -7.0, 1.0));
	var[2][3][1] = (mat2x4(9.0, -7.0, -5.0, 9.0, -5.0, 3.0, -8.0, 6.0));
}
#version 450
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

struct S
{
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c;
};
layout(scalar, binding = 1) buffer Block
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
	allOk = compare_ivec3((s[0].a), ivec3(6, -5, -9)) && allOk;
	allOk = compare_mat3(s[0].b[0], mat3(-3.0, -9.0, 9.0, 4.0, 3.0, -7.0, 4.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(s[0].b[1], mat3(8.0, -4.0, 6.0, -2.0, -9.0, -2.0, 8.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(s[0].b[2], mat3(-2.0, -1.0, 7.0, 2.0, 6.0, 0.0, 9.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3(s[0].b[3], mat3(9.0, 8.0, -7.0, -3.0, -8.0, 8.0, 4.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((s[0].c), vec4(-5.0, -5.0, -4.0, 9.0)) && allOk;
	allOk = compare_ivec3((s[1].a), ivec3(-4, 2, -6)) && allOk;
	allOk = compare_mat3(s[1].b[0], mat3(5.0, -2.0, 8.0, 4.0, -7.0, 5.0, 1.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(s[1].b[1], mat3(-8.0, 5.0, -2.0, 8.0, 6.0, -9.0, 9.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat3(s[1].b[2], mat3(-1.0, 2.0, -9.0, 4.0, 2.0, -3.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(s[1].b[3], mat3(9.0, -8.0, 5.0, -6.0, 8.0, -9.0, 0.0, 6.0, 9.0)) && allOk;
	allOk = compare_vec4((s[1].c), vec4(4.0, 7.0, -5.0, -4.0)) && allOk;
	allOk = compare_ivec3((s[2].a), ivec3(5, -9, -6)) && allOk;
	allOk = compare_mat3(s[2].b[0], mat3(5.0, -6.0, -8.0, -3.0, -7.0, 3.0, 4.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(s[2].b[1], mat3(0.0, -4.0, 3.0, 7.0, -3.0, -7.0, -6.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat3(s[2].b[2], mat3(-8.0, 5.0, -1.0, 8.0, 5.0, -2.0, -1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3(s[2].b[3], mat3(8.0, -6.0, -9.0, -6.0, -3.0, -1.0, 3.0, -4.0, -1.0)) && allOk;
	allOk = compare_vec4((s[2].c), vec4(-5.0, 3.0, 4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s[0].a = (ivec3(-3, 7, 0));
	s[0].b[0][0] = (vec3(5.0, 4.0, -2.0));
	s[0].b[0][1] = (vec3(-8.0, 3.0, 7.0));
	s[0].b[0][2] = (vec3(-4.0, -3.0, -3.0));
	s[0].b[1][0] = (vec3(-4.0, 2.0, -2.0));
	s[0].b[1][1] = (vec3(-8.0, -5.0, 6.0));
	s[0].b[1][2] = (vec3(-2.0, -5.0, -2.0));
	s[0].b[2][0] = (vec3(3.0, -7.0, 5.0));
	s[0].b[2][1] = (vec3(8.0, 0.0, 4.0));
	s[0].b[2][2] = (vec3(-4.0, -7.0, -7.0));
	s[0].b[3][0] = (vec3(1.0, 5.0, 2.0));
	s[0].b[3][1] = (vec3(0.0, -9.0, -6.0));
	s[0].b[3][2] = (vec3(-7.0, -7.0, 9.0));
	s[0].c = (vec4(-5.0, -2.0, -8.0, -2.0));
	s[1].a = (ivec3(-9, 6, 1));
	s[1].b[0][0] = (vec3(-1.0, -4.0, 4.0));
	s[1].b[0][1] = (vec3(-7.0, 5.0, 5.0));
	s[1].b[0][2] = (vec3(-7.0, 4.0, -7.0));
	s[1].b[1][0] = (vec3(1.0, 6.0, 8.0));
	s[1].b[1][1] = (vec3(9.0, 5.0, 6.0));
	s[1].b[1][2] = (vec3(-7.0, -9.0, 1.0));
	s[1].b[2][0] = (vec3(2.0, 5.0, 0.0));
	s[1].b[2][1] = (vec3(0.0, -1.0, 9.0));
	s[1].b[2][2] = (vec3(-1.0, -2.0, 1.0));
	s[1].b[3][0] = (vec3(-2.0, -4.0, -7.0));
	s[1].b[3][1] = (vec3(-9.0, -8.0, -3.0));
	s[1].b[3][2] = (vec3(-1.0, 7.0, -7.0));
	s[1].c = (vec4(-3.0, -5.0, 0.0, -2.0));
	s[2].a = (ivec3(-9, -8, -6));
	s[2].b[0][0] = (vec3(-1.0, -6.0, -5.0));
	s[2].b[0][1] = (vec3(9.0, 2.0, -8.0));
	s[2].b[0][2] = (vec3(-5.0, -7.0, -6.0));
	s[2].b[1][0] = (vec3(3.0, -4.0, -9.0));
	s[2].b[1][1] = (vec3(8.0, 1.0, 4.0));
	s[2].b[1][2] = (vec3(-5.0, -4.0, 7.0));
	s[2].b[2][0] = (vec3(0.0, -1.0, 7.0));
	s[2].b[2][1] = (vec3(4.0, -5.0, -8.0));
	s[2].b[2][2] = (vec3(-9.0, 7.0, -5.0));
	s[2].b[3][0] = (vec3(-4.0, -6.0, -9.0));
	s[2].b[3][1] = (vec3(-3.0, -4.0, 0.0));
	s[2].b[3][2] = (vec3(8.0, 9.0, -5.0));
	s[2].c = (vec4(-8.0, 0.0, 2.0, 3.0));
	v = (vec4(6.0, 7.0, 5.0, 9.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0].a), ivec3(1, 9, -3)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(-6.0, 1.0, 8.0, -5.0, -3.0, 1.0, -6.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(2.0, -1.0, 5.0, -5.0, 5.0, -9.0, 1.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(-7.0, -4.0, -3.0, 2.0, -1.0, -9.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(-4.0, 7.0, 3.0, -2.0, -4.0, 4.0, 1.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(-6.0, 1.0, 2.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(1, 7, 4)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(-6.0, 2.0, 3.0, -2.0, -4.0, -8.0, -4.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(-2.0, 2.0, 8.0, 1.0, 4.0, 6.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(-5.0, -4.0, -2.0, 9.0, -2.0, 4.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(-5.0, -1.0, -9.0, -3.0, 7.0, 1.0, 9.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(0.0, 0.0, -4.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(2, 5, 8)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(-2.0, 5.0, -4.0, -9.0, -2.0, 8.0, 9.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(-5.0, 4.0, -8.0, -8.0, 0.0, -2.0, -2.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(1.0, 7.0, 6.0, 3.0, -9.0, -4.0, 9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(-8.0, -8.0, -4.0, 5.0, 0.0, -5.0, 2.0, 0.0, -4.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(0.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(8, -6, 0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(-2.0, 2.0, 0.0, 9.0, 3.0, -1.0, -1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(6.0, 4.0, 7.0, -7.0, -8.0, 7.0, 5.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(5.0, 9.0, 9.0, 0.0, 0.0, -5.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(0.0, -1.0, -1.0, 3.0, 2.0, -3.0, 2.0, -2.0, 7.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(-2.0, 7.0, 2.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(8, -8, 9)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(-4.0, -7.0, 4.0, 2.0, -1.0, -6.0, 5.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(-4.0, -9.0, 0.0, 2.0, -6.0, 6.0, 8.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(-8.0, -4.0, -2.0, -2.0, 4.0, 6.0, -2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(2.0, -6.0, 7.0, -6.0, -2.0, 1.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(-8.0, 7.0, 3.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(0, 0, -3)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(0.0, -7.0, -5.0, 2.0, 1.0, 7.0, -9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(-5.0, -8.0, -5.0, 6.0, -5.0, 0.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(-6.0, 4.0, 1.0, -8.0, 2.0, -5.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(-3.0, 6.0, 8.0, -6.0, -6.0, -2.0, 6.0, 3.0, 4.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(9.0, 0.0, -3.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(-9, -1, 8)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(9.0, -8.0, -4.0, 7.0, 5.0, -2.0, 4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(-7.0, -4.0, 2.0, -4.0, 5.0, -8.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(-7.0, 3.0, 7.0, -7.0, 6.0, -8.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(3.0, 2.0, 6.0, -2.0, 9.0, 9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(-7.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(-9, -9, 8)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(-6.0, -6.0, -3.0, 1.0, 1.0, 3.0, 0.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(-5.0, -7.0, 0.0, -2.0, -8.0, -7.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(-2.0, -2.0, -7.0, -8.0, -6.0, -8.0, -8.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(7.0, 2.0, 1.0, 0.0, 0.0, -6.0, 6.0, -5.0, -4.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(0.0, -5.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(-5, -4, 4)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(7.0, 5.0, 1.0, 4.0, -7.0, -3.0, 8.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(-9.0, -3.0, -6.0, 1.0, 2.0, 5.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(-5.0, -7.0, 7.0, -1.0, 2.0, -5.0, -7.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(-1.0, 1.0, 1.0, 4.0, -6.0, -4.0, 5.0, -9.0, -9.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(4.0, -5.0, 2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(6, -3, -9));
	block[0].s[0].b[0][0] = (vec3(6.0, 9.0, 4.0));
	block[0].s[0].b[0][1] = (vec3(-9.0, 3.0, 9.0));
	block[0].s[0].b[0][2] = (vec3(4.0, 0.0, 2.0));
	block[0].s[0].b[1][0] = (vec3(-1.0, -8.0, 5.0));
	block[0].s[0].b[1][1] = (vec3(4.0, 0.0, 4.0));
	block[0].s[0].b[1][2] = (vec3(7.0, -7.0, -9.0));
	block[0].s[0].b[2][0] = (vec3(8.0, -3.0, 3.0));
	block[0].s[0].b[2][1] = (vec3(-3.0, -8.0, 5.0));
	block[0].s[0].b[2][2] = (vec3(-8.0, 7.0, -5.0));
	block[0].s[0].b[3][0] = (vec3(8.0, -3.0, 9.0));
	block[0].s[0].b[3][1] = (vec3(-9.0, -7.0, 3.0));
	block[0].s[0].b[3][2] = (vec3(5.0, 7.0, 3.0));
	block[0].s[0].c = (vec4(-7.0, -5.0, -7.0, 9.0));
	block[0].s[1].a = (ivec3(3, -7, -7));
	block[0].s[1].b[0][0] = (vec3(6.0, 3.0, 5.0));
	block[0].s[1].b[0][1] = (vec3(3.0, -4.0, 1.0));
	block[0].s[1].b[0][2] = (vec3(-3.0, -4.0, -6.0));
	block[0].s[1].b[1][0] = (vec3(3.0, 2.0, -2.0));
	block[0].s[1].b[1][1] = (vec3(6.0, 6.0, 8.0));
	block[0].s[1].b[1][2] = (vec3(5.0, -2.0, 3.0));
	block[0].s[1].b[2][0] = (vec3(-9.0, 0.0, 8.0));
	block[0].s[1].b[2][1] = (vec3(2.0, -8.0, -4.0));
	block[0].s[1].b[2][2] = (vec3(4.0, 1.0, 5.0));
	block[0].s[1].b[3][0] = (vec3(-6.0, -6.0, -4.0));
	block[0].s[1].b[3][1] = (vec3(-4.0, -6.0, -1.0));
	block[0].s[1].b[3][2] = (vec3(7.0, 7.0, -8.0));
	block[0].s[1].c = (vec4(8.0, 2.0, -5.0, 1.0));
	block[0].s[2].a = (ivec3(9, -9, -7));
	block[0].s[2].b[0][0] = (vec3(-6.0, -2.0, 3.0));
	block[0].s[2].b[0][1] = (vec3(-3.0, 8.0, 2.0));
	block[0].s[2].b[0][2] = (vec3(-9.0, 9.0, 0.0));
	block[0].s[2].b[1][0] = (vec3(4.0, -9.0, -3.0));
	block[0].s[2].b[1][1] = (vec3(6.0, -6.0, -9.0));
	block[0].s[2].b[1][2] = (vec3(5.0, 4.0, -4.0));
	block[0].s[2].b[2][0] = (vec3(-2.0, -8.0, -9.0));
	block[0].s[2].b[2][1] = (vec3(5.0, 5.0, 1.0));
	block[0].s[2].b[2][2] = (vec3(8.0, 3.0, 7.0));
	block[0].s[2].b[3][0] = (vec3(1.0, 0.0, 6.0));
	block[0].s[2].b[3][1] = (vec3(-4.0, 3.0, 7.0));
	block[0].s[2].b[3][2] = (vec3(4.0, 2.0, 8.0));
	block[0].s[2].c = (vec4(8.0, -1.0, -5.0, 5.0));
	block[0].v = (vec4(-5.0, 7.0, 8.0, -4.0));
	block[1].s[0].a = (ivec3(2, 1, 6));
	block[1].s[0].b[0][0] = (vec3(-2.0, 5.0, 0.0));
	block[1].s[0].b[0][1] = (vec3(9.0, 1.0, -5.0));
	block[1].s[0].b[0][2] = (vec3(-9.0, -3.0, -4.0));
	block[1].s[0].b[1][0] = (vec3(4.0, -5.0, 5.0));
	block[1].s[0].b[1][1] = (vec3(-8.0, -7.0, 9.0));
	block[1].s[0].b[1][2] = (vec3(8.0, -5.0, 4.0));
	block[1].s[0].b[2][0] = (vec3(-1.0, -9.0, 3.0));
	block[1].s[0].b[2][1] = (vec3(-8.0, 7.0, 2.0));
	block[1].s[0].b[2][2] = (vec3(-4.0, 5.0, 1.0));
	block[1].s[0].b[3][0] = (vec3(7.0, -8.0, -4.0));
	block[1].s[0].b[3][1] = (vec3(-8.0, -7.0, -5.0));
	block[1].s[0].b[3][2] = (vec3(-6.0, 5.0, -1.0));
	block[1].s[0].c = (vec4(-1.0, -9.0, 3.0, 8.0));
	block[1].s[1].a = (ivec3(5, -6, -7));
	block[1].s[1].b[0][0] = (vec3(-9.0, 3.0, -5.0));
	block[1].s[1].b[0][1] = (vec3(-2.0, -5.0, -4.0));
	block[1].s[1].b[0][2] = (vec3(3.0, 3.0, 7.0));
	block[1].s[1].b[1][0] = (vec3(5.0, 1.0, 5.0));
	block[1].s[1].b[1][1] = (vec3(-9.0, 6.0, 0.0));
	block[1].s[1].b[1][2] = (vec3(-3.0, -5.0, 5.0));
	block[1].s[1].b[2][0] = (vec3(-5.0, 7.0, -7.0));
	block[1].s[1].b[2][1] = (vec3(9.0, -9.0, 1.0));
	block[1].s[1].b[2][2] = (vec3(-9.0, 9.0, 7.0));
	block[1].s[1].b[3][0] = (vec3(6.0, -2.0, -1.0));
	block[1].s[1].b[3][1] = (vec3(-4.0, 1.0, 3.0));
	block[1].s[1].b[3][2] = (vec3(-5.0, 4.0, -5.0));
	block[1].s[1].c = (vec4(9.0, 1.0, -7.0, 9.0));
	block[1].s[2].a = (ivec3(-2, 4, 8));
	block[1].s[2].b[0][0] = (vec3(-4.0, 6.0, 9.0));
	block[1].s[2].b[0][1] = (vec3(-6.0, -6.0, -8.0));
	block[1].s[2].b[0][2] = (vec3(3.0, 8.0, 0.0));
	block[1].s[2].b[1][0] = (vec3(-2.0, -1.0, 3.0));
	block[1].s[2].b[1][1] = (vec3(7.0, 7.0, -4.0));
	block[1].s[2].b[1][2] = (vec3(-4.0, 0.0, -9.0));
	block[1].s[2].b[2][0] = (vec3(5.0, 3.0, -9.0));
	block[1].s[2].b[2][1] = (vec3(5.0, -8.0, -2.0));
	block[1].s[2].b[2][2] = (vec3(-7.0, -9.0, 6.0));
	block[1].s[2].b[3][0] = (vec3(6.0, 0.0, 6.0));
	block[1].s[2].b[3][1] = (vec3(2.0, 4.0, -4.0));
	block[1].s[2].b[3][2] = (vec3(-5.0, 4.0, -9.0));
	block[1].s[2].c = (vec4(-4.0, 5.0, -6.0, -6.0));
	block[1].v = (vec4(-5.0, -6.0, 6.0, 7.0));
	block[2].s[0].a = (ivec3(-9, 9, -1));
	block[2].s[0].b[0][0] = (vec3(-7.0, 1.0, 0.0));
	block[2].s[0].b[0][1] = (vec3(-4.0, 0.0, 8.0));
	block[2].s[0].b[0][2] = (vec3(-6.0, 9.0, -4.0));
	block[2].s[0].b[1][0] = (vec3(0.0, 8.0, 8.0));
	block[2].s[0].b[1][1] = (vec3(4.0, 9.0, 3.0));
	block[2].s[0].b[1][2] = (vec3(4.0, -3.0, 0.0));
	block[2].s[0].b[2][0] = (vec3(8.0, 3.0, 8.0));
	block[2].s[0].b[2][1] = (vec3(-8.0, -7.0, 9.0));
	block[2].s[0].b[2][2] = (vec3(-8.0, -3.0, 8.0));
	block[2].s[0].b[3][0] = (vec3(8.0, -4.0, -8.0));
	block[2].s[0].b[3][1] = (vec3(4.0, 6.0, -1.0));
	block[2].s[0].b[3][2] = (vec3(9.0, 6.0, 7.0));
	block[2].s[0].c = (vec4(-6.0, 1.0, 3.0, -2.0));
	block[2].s[1].a = (ivec3(5, -4, -5));
	block[2].s[1].b[0][0] = (vec3(-1.0, 1.0, 5.0));
	block[2].s[1].b[0][1] = (vec3(7.0, -8.0, -7.0));
	block[2].s[1].b[0][2] = (vec3(-9.0, 2.0, -6.0));
	block[2].s[1].b[1][0] = (vec3(-7.0, 5.0, -5.0));
	block[2].s[1].b[1][1] = (vec3(9.0, 0.0, 6.0));
	block[2].s[1].b[1][2] = (vec3(9.0, -6.0, -4.0));
	block[2].s[1].b[2][0] = (vec3(-8.0, -4.0, 4.0));
	block[2].s[1].b[2][1] = (vec3(-9.0, 3.0, -4.0));
	block[2].s[1].b[2][2] = (vec3(5.0, -7.0, 6.0));
	block[2].s[1].b[3][0] = (vec3(-1.0, -2.0, 1.0));
	block[2].s[1].b[3][1] = (vec3(-7.0, -3.0, 1.0));
	block[2].s[1].b[3][2] = (vec3(8.0, 0.0, -8.0));
	block[2].s[1].c = (vec4(-2.0, -4.0, 9.0, -1.0));
	block[2].s[2].a = (ivec3(3, 3, -4));
	block[2].s[2].b[0][0] = (vec3(9.0, -9.0, -1.0));
	block[2].s[2].b[0][1] = (vec3(-2.0, 5.0, 3.0));
	block[2].s[2].b[0][2] = (vec3(8.0, 2.0, -4.0));
	block[2].s[2].b[1][0] = (vec3(8.0, 7.0, -5.0));
	block[2].s[2].b[1][1] = (vec3(1.0, 6.0, -9.0));
	block[2].s[2].b[1][2] = (vec3(-6.0, -1.0, 8.0));
	block[2].s[2].b[2][0] = (vec3(-9.0, 8.0, -5.0));
	block[2].s[2].b[2][1] = (vec3(-6.0, -4.0, 3.0));
	block[2].s[2].b[2][2] = (vec3(-4.0, -3.0, 7.0));
	block[2].s[2].b[3][0] = (vec3(-4.0, 2.0, 5.0));
	block[2].s[2].b[3][1] = (vec3(-3.0, -6.0, 2.0));
	block[2].s[2].b[3][2] = (vec3(-8.0, 0.0, -4.0));
	block[2].s[2].c = (vec4(-7.0, -1.0, 5.0, 6.0));
	block[2].v = (vec4(-5.0, 7.0, -4.0, -6.0));
}
#version 450
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
layout(scalar, binding = 1) buffer Block
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
	allOk = compare_ivec3((s.a), ivec3(-4, 7, -6)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(5.0, 5.0, 2.0, -3.0, 7.0, 6.0, 5.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(8.0, 6.0, -9.0, -6.0, -4.0, -4.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(0.0, -4.0, 7.0, 2.0, -1.0, -3.0, 5.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(-8.0, 2.0, 1.0, 5.0, -2.0, -9.0, 7.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(7.0, 7.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3(t.a, mat3(-1.0, -7.0, -7.0, 6.0, 9.0, -5.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_ivec3((t.b.a), ivec3(3, -4, 7)) && allOk;
	allOk = compare_mat3(t.b.b[0], mat3(8.0, -9.0, 4.0, 7.0, -7.0, 6.0, 8.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(t.b.b[1], mat3(-8.0, 0.0, -2.0, 6.0, 8.0, 7.0, 1.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3(t.b.b[2], mat3(1.0, 3.0, -6.0, -1.0, 3.0, -9.0, 6.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3(t.b.b[3], mat3(9.0, 5.0, 9.0, -7.0, -8.0, 8.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_vec4((t.b.c), vec4(3.0, 9.0, -8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	t.a = (mat3(4.0, 1.0, -4.0, -8.0, 4.0, -2.0, 3.0, -8.0, -4.0));
	t.b.a = (ivec3(-3, -7, 1));
	t.b.b[0] = (mat3(-1.0, 4.0, 0.0, -5.0, 8.0, -1.0, 3.0, -9.0, 4.0));
	t.b.b[1] = (mat3(4.0, -5.0, -1.0, 9.0, 5.0, 4.0, -5.0, 9.0, -4.0));
	t.b.b[2] = (mat3(7.0, -8.0, -6.0, 4.0, 5.0, -3.0, 3.0, 5.0, 4.0));
	t.b.b[3] = (mat3(-6.0, -4.0, -2.0, -6.0, 4.0, 5.0, -8.0, -8.0, 6.0));
	t.b.c = (vec4(-2.0, -6.0, 3.0, -4.0));
	u = (4u);
}
#version 450
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
layout(scalar, binding = 1) buffer Block
{
	S s;
	lowp vec2 v;
	T t;
	highp uint u;
} block[3];

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
	allOk = compare_ivec3((block[0].s.a), ivec3(9, 1, 9)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-3.0, 1.0, 7.0, 4.0, 2.0, 5.0, 8.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(8.0, -5.0, -3.0, 1.0, -6.0, -1.0, 8.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(5.0, -5.0, 5.0, -9.0, 1.0, -1.0, 7.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-3.0, 2.0, -1.0, -9.0, -9.0, -8.0, 2.0, -4.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(3.0, -2.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(-6.0, -6.0, 2.0, 3.0, -2.0, -4.0, -8.0, -4.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(1, -2, 2)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(8.0, 1.0, 4.0, 6.0, 1.0, 7.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(-2.0, 9.0, -2.0, 4.0, 9.0, 2.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(-9.0, -3.0, 7.0, 1.0, 9.0, 8.0, -5.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(-4.0, -9.0, -2.0, 8.0, 9.0, -1.0, -8.0, -5.0, 4.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(-8.0, -8.0, 0.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(-6, -2, 1)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(7.0, 6.0, 3.0, -9.0, -4.0, 9.0, 1.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-8.0, -4.0, 5.0, 0.0, -5.0, 2.0, 0.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(1.0, 2.0, -4.0, 0.0, 0.0, -4.0, 8.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-4.0, 8.0, 5.0, 5.0, 1.0, -5.0, -8.0, 8.0, -6.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(0.0, 8.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(-3.0, -2.0, 2.0, 0.0, 9.0, 3.0, -1.0, -1.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(0, 6, 4)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(7.0, -7.0, -8.0, 7.0, 5.0, -9.0, 4.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(9.0, 0.0, 0.0, -5.0, 1.0, 0.0, -6.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(-1.0, 3.0, 2.0, -3.0, 2.0, -2.0, 7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(4.0, 2.0, -1.0, -6.0, 5.0, 2.0, -8.0, -4.0, -9.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(0.0, 2.0, -6.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-3, 4, -8)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-4.0, -2.0, -2.0, 4.0, 6.0, -2.0, 8.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-6.0, 7.0, -6.0, -2.0, 1.0, 3.0, 7.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-7.0, -5.0, 2.0, 1.0, 7.0, -9.0, -8.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-8.0, -5.0, 6.0, -5.0, 0.0, 4.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(4.0, 1.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(1.0, -6.0, -3.0, 6.0, 8.0, -6.0, -6.0, -2.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(3, 4, -2)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(7.0, 2.0, 1.0, -8.0, 7.0, 3.0, 6.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(-3.0, 0.0, 9.0, 7.0, 8.0, 1.0, 4.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(8.0, -9.0, -9.0, 8.0, -5.0, -4.0, 4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(-4.0, 7.0, 5.0, -2.0, 4.0, -5.0, 2.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(2.0, -4.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a[0] = (vec3(3.0, 6.0, 3.0));
	block[0].t.a[1] = (vec3(5.0, 3.0, -4.0));
	block[0].t.a[2] = (vec3(1.0, -3.0, -4.0));
	block[0].t.b.a = (ivec3(-6, 3, 2));
	block[0].t.b.b[0][0] = (vec3(-2.0, 6.0, 6.0));
	block[0].t.b.b[0][1] = (vec3(8.0, 5.0, -2.0));
	block[0].t.b.b[0][2] = (vec3(3.0, -9.0, 0.0));
	block[0].t.b.b[1][0] = (vec3(8.0, 2.0, -8.0));
	block[0].t.b.b[1][1] = (vec3(-4.0, 4.0, 1.0));
	block[0].t.b.b[1][2] = (vec3(5.0, -6.0, -6.0));
	block[0].t.b.b[2][0] = (vec3(-4.0, -4.0, -6.0));
	block[0].t.b.b[2][1] = (vec3(-1.0, 7.0, 7.0));
	block[0].t.b.b[2][2] = (vec3(-8.0, -6.0, -2.0));
	block[0].t.b.b[3][0] = (vec3(3.0, -3.0, 8.0));
	block[0].t.b.b[3][1] = (vec3(2.0, -9.0, 9.0));
	block[0].t.b.b[3][2] = (vec3(0.0, 4.0, -9.0));
	block[0].t.b.c = (vec4(-3.0, 6.0, -6.0, -9.0));
	block[0].u = (7u);
	block[1].t.a[0] = (vec3(8.0, -2.0, 5.0));
	block[1].t.a[1] = (vec3(0.0, 9.0, 1.0));
	block[1].t.a[2] = (vec3(-5.0, -9.0, -3.0));
	block[1].t.b.a = (ivec3(-4, 4, -5));
	block[1].t.b.b[0][0] = (vec3(5.0, -8.0, -7.0));
	block[1].t.b.b[0][1] = (vec3(9.0, 8.0, -5.0));
	block[1].t.b.b[0][2] = (vec3(4.0, -1.0, -9.0));
	block[1].t.b.b[1][0] = (vec3(3.0, -8.0, 7.0));
	block[1].t.b.b[1][1] = (vec3(2.0, -4.0, 5.0));
	block[1].t.b.b[1][2] = (vec3(1.0, 7.0, -8.0));
	block[1].t.b.b[2][0] = (vec3(-4.0, -8.0, -7.0));
	block[1].t.b.b[2][1] = (vec3(-5.0, -6.0, 5.0));
	block[1].t.b.b[2][2] = (vec3(-1.0, -9.0, 3.0));
	block[1].t.b.b[3][0] = (vec3(-5.0, -2.0, -5.0));
	block[1].t.b.b[3][1] = (vec3(-4.0, 3.0, 3.0));
	block[1].t.b.b[3][2] = (vec3(7.0, 5.0, 1.0));
	block[1].t.b.c = (vec4(5.0, -9.0, 6.0, 0.0));
	block[1].u = (2u);
	block[2].t.a[0] = (vec3(-9.0, 6.0, 6.0));
	block[2].t.a[1] = (vec3(0.0, 6.0, 2.0));
	block[2].t.a[2] = (vec3(4.0, -4.0, -5.0));
	block[2].t.b.a = (ivec3(4, -9, -1));
	block[2].t.b.b[0][0] = (vec3(-9.0, 3.0, 8.0));
	block[2].t.b.b[0][1] = (vec3(9.0, 1.0, -7.0));
	block[2].t.b.b[0][2] = (vec3(9.0, -4.0, 5.0));
	block[2].t.b.b[1][0] = (vec3(-6.0, -6.0, -5.0));
	block[2].t.b.b[1][1] = (vec3(-6.0, 6.0, 7.0));
	block[2].t.b.b[1][2] = (vec3(-6.0, -9.0, 9.0));
	block[2].t.b.b[2][0] = (vec3(-1.0, 5.0, -4.0));
	block[2].t.b.b[2][1] = (vec3(-5.0, 3.0, 3.0));
	block[2].t.b.b[2][2] = (vec3(-4.0, -7.0, 1.0));
	block[2].t.b.b[3][0] = (vec3(0.0, -4.0, 0.0));
	block[2].t.b.b[3][1] = (vec3(8.0, -6.0, 9.0));
	block[2].t.b.b[3][2] = (vec3(-4.0, 0.0, 8.0));
	block[2].t.b.c = (vec4(8.0, 4.0, 9.0, 3.0));
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

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(block[0].var, mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(block[1].var, mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block[2].var, mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2(3.0, -6.0, 2.0, -8.0));
	block[1].var = (mat2(2.0, -5.0, -3.0, 9.0));
	block[2].var = (mat2(4.0, -9.0, -2.0, -6.0));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat4x2 var;
} block[3];

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

layout(std140, column_major, binding = 1) buffer Block
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

layout(std430, binding = 1) buffer BlockB
{
	lowp uint a[1];
	mediump uint b;
	bool c[1];
	lowp int d;
};
layout(std430, binding = 2) buffer BlockC
{
	mediump int e;
	lowp int f;
	lowp float g;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	lowp uint h[1];
	lowp float i;
	lowp int j;
	highp int k;
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	lowp int l;
	lowp int m;
	bool n;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((c[0]), true) && allOk;
	allOk = compare_int((d), -9) && allOk;
	allOk = compare_int((blockC.f), -9) && allOk;
	allOk = compare_uint((blockD.h[0]), 5u) && allOk;
	allOk = compare_int((blockD.j), -5) && allOk;
	allOk = compare_int((blockE.l), 2) && allOk;
	allOk = compare_int((blockE.m), 7) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (5u);
	c[0] = (false);
	blockC.g = (-9.0);
	blockD.h[0] = (5u);
	blockD.i = (1.0);
	blockD.k = (5);
	blockE.l = (-4);
	blockE.m = (-9);
	blockE.n = (false);
}
#version 450
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
	bvec4 a[1];
	bvec2 b;
	mediump uint c;
	highp ivec2 d;
	highp uvec4 e;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((b), bvec2(false, true)) && allOk;
	allOk = compare_uvec4((e), uvec4(2u, 0u, 0u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (bvec4(true, true, false, false));
	b = (bvec2(true, false));
	c = (4u);
}
#version 450
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
	bvec3 c[3];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp uvec3 d[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	highp mat3x2 e;
	highp uint f[];
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	lowp mat4x3 g;
	highp uvec2 h;
	highp uint i;
	highp mat3 j;
	highp int k[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((c[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((c[1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((c[2]), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec3((blockC.d[0]), uvec3(9u, 0u, 4u)) && allOk;
	allOk = compare_uvec3((blockC.d[1]), uvec3(8u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((blockC.d[2]), uvec3(3u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((blockC.d[3]), uvec3(4u, 5u, 6u)) && allOk;
	allOk = compare_uint((blockD.f[0]), 4u) && allOk;
	allOk = compare_uint((blockD.f[1]), 7u) && allOk;
	allOk = compare_uint((blockD.f[2]), 2u) && allOk;
	allOk = compare_uint((blockD.f[3]), 4u) && allOk;
	allOk = compare_uint((blockD.f[4]), 9u) && allOk;
	allOk = compare_uint((blockD.f[5]), 3u) && allOk;
	allOk = compare_uint((blockD.f[6]), 1u) && allOk;
	allOk = compare_uint((blockD.f[7]), 0u) && allOk;
	allOk = compare_uvec2((h), uvec2(3u, 4u)) && allOk;
	allOk = compare_uint((i), 6u) && allOk;
	allOk = compare_mat3(j, mat3(8.0, 9.0, 7.0, -7.0, 7.0, -8.0, -7.0, -8.0, -2.0)) && allOk;
	allOk = compare_int((k[0]), -1) && allOk;
	allOk = compare_int((k[1]), 6) && allOk;
	allOk = compare_int((k[2]), 4) && allOk;
	allOk = compare_int((k[3]), -1) && allOk;
	allOk = compare_int((k[4]), -7) && allOk;
	allOk = compare_int((k[5]), -2) && allOk;
	allOk = compare_int((k[6]), 5) && allOk;
	allOk = compare_int((k[7]), 6) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (false);
	c[0] = (bvec3(true, true, true));
	c[1] = (bvec3(true, false, true));
	c[2] = (bvec3(true, false, false));
	blockC.d[0] = (uvec3(5u, 4u, 6u));
	blockC.d[1] = (uvec3(8u, 0u, 2u));
	blockC.d[2] = (uvec3(3u, 3u, 8u));
	blockC.d[3] = (uvec3(6u, 3u, 3u));
	blockD.e = (mat3x2(8.0, 0.0, 6.0, 5.0, 6.0, -3.0));
	blockD.f[0] = (0u);
	blockD.f[1] = (4u);
	blockD.f[2] = (8u);
	blockD.f[3] = (9u);
	blockD.f[4] = (3u);
	blockD.f[5] = (2u);
	blockD.f[6] = (2u);
	blockD.f[7] = (1u);
	g = (mat4x3(-1.0, -4.0, -3.0, 0.0, 5.0, -3.0, 7.0, 4.0, 0.0, -3.0, -8.0, -4.0));
	h = (uvec2(3u, 2u));
	j = (mat3(-7.0, 2.0, -4.0, 1.0, -2.0, -8.0, 3.0, -7.0, -4.0));
}
#version 450
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
	mediump mat4x2 a[1];
	mediump uint b;
	mediump uvec2 c;
	highp ivec3 d[];
} blockB[1];

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

layout(std430, column_major, binding = 1) readonly buffer BlockB
{
	lowp mat4 a[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	mediump uvec3 b;
	mediump ivec3 c[1];
	highp mat4x3 d[1];
	mediump mat3 e[];
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(a[0], mat4(1.0, -3.0, 9.0, 7.0, -5.0, 2.0, -1.0, -8.0, 2.0, -6.0, 5.0, -7.0, 2.0, 8.0, 8.0, 6.0)) && allOk;
	allOk = compare_uvec3((blockC[0].b), uvec3(9u, 2u, 1u)) && allOk;
	allOk = compare_mat3(blockC[0].e[0], mat3(-1.0, -2.0, -9.0, 1.0, 0.0, 8.0, 0.0, 5.0, -7.0)) && allOk;
	allOk = compare_uvec3((blockC[1].b), uvec3(2u, 6u, 6u)) && allOk;
	allOk = compare_mat3(blockC[1].e[0], mat3(-9.0, -1.0, -4.0, 5.0, 1.0, -9.0, 8.0, 9.0, -6.0)) && allOk;
	allOk = compare_uvec3((blockC[2].b), uvec3(7u, 8u, 3u)) && allOk;
	allOk = compare_mat3(blockC[2].e[0], mat3(1.0, 7.0, 3.0, 2.0, 2.0, 3.0, -8.0, -6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].c[0] = (ivec3(-3, 1, 0));
	blockC[0].d[0] = (mat4x3(-8.0, -8.0, 5.0, 2.0, 6.0, 6.0, -9.0, 7.0, 6.0, 3.0, 9.0, -8.0));
	blockC[1].c[0] = (ivec3(-8, -2, 5));
	blockC[1].d[0] = (mat4x3(-8.0, 0.0, -6.0, 9.0, 3.0, -2.0, 9.0, -1.0, 8.0, 4.0, 9.0, -5.0));
	blockC[2].c[0] = (ivec3(6, 3, -9));
	blockC[2].d[0] = (mat4x3(6.0, 8.0, 1.0, -3.0, -2.0, -8.0, 1.0, -4.0, -7.0, 7.0, 9.0, 9.0));
}
#version 450
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
	highp mat3x2 a;
	highp uint b;
	mediump mat2 c[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	bvec4 d;
	lowp mat3 e;
	mediump mat3x2 f;
	mediump int g;
	mediump mat4 h[];
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	bvec4 i;
	bvec4 j[3];
	lowp ivec3 k[7];
	highp mat2 l[];
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	lowp mat3x2 m;
	lowp ivec2 n[];
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(a, mat3x2(1.0, -5.0, -9.0, -5.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2(c[0], mat2(2.0, 8.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat2(c[1], mat2(-8.0, 2.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2(c[2], mat2(-5.0, 7.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2(c[3], mat2(7.0, 4.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat2(c[4], mat2(2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2(c[5], mat2(8.0, 5.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(c[6], mat2(3.0, 1.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(blockC.e, mat3(3.0, 1.0, 1.0, -9.0, -3.0, -9.0, -7.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4(blockC.h[0], mat4(-3.0, -9.0, -6.0, 6.0, 5.0, -5.0, 2.0, 4.0, 9.0, 2.0, 5.0, -2.0, -4.0, 7.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4(blockC.h[1], mat4(-9.0, 5.0, 1.0, -5.0, 5.0, -3.0, 6.0, 6.0, 2.0, 4.0, 4.0, -3.0, 3.0, 8.0, 6.0, -3.0)) && allOk;
	allOk = compare_bvec4((blockD.i), bvec4(true, true, true, false)) && allOk;
	allOk = compare_ivec3((blockD.k[0]), ivec3(-7, 7, -2)) && allOk;
	allOk = compare_ivec3((blockD.k[1]), ivec3(-7, 4, 1)) && allOk;
	allOk = compare_ivec3((blockD.k[2]), ivec3(-2, 4, -3)) && allOk;
	allOk = compare_ivec3((blockD.k[3]), ivec3(6, 1, -2)) && allOk;
	allOk = compare_ivec3((blockD.k[4]), ivec3(5, 2, -8)) && allOk;
	allOk = compare_ivec3((blockD.k[5]), ivec3(-6, -5, 7)) && allOk;
	allOk = compare_ivec3((blockD.k[6]), ivec3(5, -6, 5)) && allOk;
	allOk = compare_mat2(blockD.l[0], mat2(-5.0, -8.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2(blockD.l[1], mat2(5.0, 7.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2(blockD.l[2], mat2(-8.0, -8.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m, mat3x2(9.0, -9.0, 2.0, 8.0, -1.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockE[0].n[0]), ivec2(7, -7)) && allOk;
	allOk = compare_ivec2((blockE[0].n[1]), ivec2(9, -1)) && allOk;
	allOk = compare_ivec2((blockE[0].n[2]), ivec2(7, 7)) && allOk;
	allOk = compare_ivec2((blockE[0].n[3]), ivec2(-6, 9)) && allOk;
	allOk = compare_mat3x2(blockE[1].m, mat3x2(-4.0, 0.0, 6.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_ivec2((blockE[1].n[0]), ivec2(-2, -8)) && allOk;
	allOk = compare_ivec2((blockE[1].n[1]), ivec2(6, 6)) && allOk;
	allOk = compare_ivec2((blockE[1].n[2]), ivec2(2, 9)) && allOk;
	allOk = compare_ivec2((blockE[1].n[3]), ivec2(7, -8)) && allOk;
	allOk = compare_ivec2((blockE[1].n[4]), ivec2(-5, 8)) && allOk;
	allOk = compare_ivec2((blockE[1].n[5]), ivec2(-3, -5)) && allOk;
	allOk = compare_mat3x2(blockE[2].m, mat3x2(7.0, -3.0, -5.0, 7.0, -2.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockE[2].n[0]), ivec2(-9, 5)) && allOk;
	allOk = compare_ivec2((blockE[2].n[1]), ivec2(9, 6)) && allOk;
	allOk = compare_ivec2((blockE[2].n[2]), ivec2(-8, -2)) && allOk;
	allOk = compare_ivec2((blockE[2].n[3]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((blockE[2].n[4]), ivec2(-7, -9)) && allOk;
	allOk = compare_ivec2((blockE[2].n[5]), ivec2(2, -2)) && allOk;
	allOk = compare_ivec2((blockE[2].n[6]), ivec2(-9, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x2(2.0, 7.0, -5.0, -4.0, -8.0, -5.0));
	b = (9u);
	blockC.d = (bvec4(true, true, false, true));
	blockC.e = (mat3(8.0, 5.0, 3.0, 5.0, -4.0, 8.0, 8.0, 0.0, -8.0));
	blockC.g = (-5);
	blockD.i = (bvec4(false, false, true, false));
	blockD.j[0] = (bvec4(false, true, true, false));
	blockD.j[1] = (bvec4(true, false, false, false));
	blockD.j[2] = (bvec4(true, true, true, false));
	blockD.k[0] = (ivec3(8, 7, 4));
	blockD.k[1] = (ivec3(7, -3, 9));
	blockD.k[2] = (ivec3(-4, 7, -1));
	blockD.k[3] = (ivec3(5, 3, -8));
	blockD.k[4] = (ivec3(4, 2, -4));
	blockD.k[5] = (ivec3(1, 6, -8));
	blockD.k[6] = (ivec3(-2, -6, 8));
	blockD.l[0] = (mat2(-6.0, -5.0, 2.0, -8.0));
	blockD.l[1] = (mat2(-5.0, 2.0, -4.0, 2.0));
	blockD.l[2] = (mat2(2.0, -2.0, -1.0, 6.0));
	blockE[0].n[0] = (ivec2(4, 9));
	blockE[0].n[1] = (ivec2(3, -7));
	blockE[0].n[2] = (ivec2(-9, -8));
	blockE[0].n[3] = (ivec2(-7, 1));
	blockE[1].n[0] = (ivec2(-1, -7));
	blockE[1].n[1] = (ivec2(0, 9));
	blockE[1].n[2] = (ivec2(-3, -4));
	blockE[1].n[3] = (ivec2(-9, -1));
	blockE[1].n[4] = (ivec2(-3, -9));
	blockE[1].n[5] = (ivec2(4, 2));
	blockE[2].n[0] = (ivec2(1, 2));
	blockE[2].n[1] = (ivec2(1, 2));
	blockE[2].n[2] = (ivec2(-3, 2));
	blockE[2].n[3] = (ivec2(-2, -6));
	blockE[2].n[4] = (ivec2(9, 3));
	blockE[2].n[5] = (ivec2(1, -9));
	blockE[2].n[6] = (ivec2(-9, 5));
}
#version 450
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
	mediump ivec4 a;
	lowp mat3x2 b[7];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((a), ivec4(-5, 5, -6, -9)) && allOk;
	allOk = compare_mat3x2(b[0], mat3x2(9.0, 7.0, -5.0, 0.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(b[1], mat3x2(-7.0, -1.0, -5.0, 5.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(b[2], mat3x2(-4.0, -1.0, 7.0, 3.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3x2(b[3], mat3x2(-1.0, 3.0, -5.0, 9.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x2(b[4], mat3x2(1.0, 4.0, 8.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(b[5], mat3x2(-1.0, 7.0, 4.0, 1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x2(b[6], mat3x2(7.0, 6.0, -6.0, 8.0, 0.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (mat3x2(4.0, -4.0, 9.0, -9.0, -2.0, -2.0));
	b[1] = (mat3x2(0.0, -5.0, 9.0, 4.0, 8.0, -6.0));
	b[2] = (mat3x2(-8.0, 4.0, -5.0, 7.0, 0.0, 3.0));
	b[3] = (mat3x2(-2.0, 6.0, 9.0, -5.0, 0.0, 5.0));
	b[4] = (mat3x2(5.0, -4.0, -5.0, -4.0, -2.0, -9.0));
	b[5] = (mat3x2(-5.0, -8.0, 4.0, -8.0, -3.0, 9.0));
	b[6] = (mat3x2(4.0, 8.0, 4.0, -6.0, -3.0, -2.0));
}
#version 450
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
	lowp mat4 b[];
} blockB[3];

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

layout(std140, column_major, binding = 1) buffer BlockB
{
	mediump mat4 a;
	lowp vec3 b[];
};
layout(std140, row_major, binding = 2) readonly buffer BlockC
{
	lowp uvec3 c;
	highp mat4 d;
	lowp ivec2 e[];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((b[0]), vec3(6.0, 0.0, 6.0)) && allOk;
	allOk = compare_vec3((b[1]), vec3(0.0, 8.0, 4.0)) && allOk;
	allOk = compare_vec3((b[2]), vec3(2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(blockC[0].d, mat4(-5.0, 7.0, 8.0, -4.0, -2.0, 6.0, 8.0, -6.0, -4.0, 2.0, 0.0, -1.0, 9.0, 3.0, 8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4(5.0, -4.0, 7.0, 9.0, 0.0, 9.0, -5.0, -3.0, 3.0, 5.0, -9.0, 5.0, 5.0, 2.0, 6.0, -5.0));
	b[0] = (vec3(-8.0, -8.0, -6.0));
	b[1] = (vec3(9.0, 7.0, 0.0));
	b[2] = (vec3(1.0, -3.0, 1.0));
}
#version 450
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
	highp vec3 a[6];
	mediump ivec2 b[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((a[0]), vec3(0.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3((a[1]), vec3(9.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec3((a[2]), vec3(-8.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec3((a[3]), vec3(-9.0, 4.0, -4.0)) && allOk;
	allOk = compare_vec3((a[4]), vec3(-2.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec3((a[5]), vec3(-4.0, 7.0, 1.0)) && allOk;
	allOk = compare_ivec2((b[0]), ivec2(-4, -8)) && allOk;
	allOk = compare_ivec2((b[1]), ivec2(6, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (vec3(-3.0, -9.0, -1.0));
	a[1] = (vec3(-1.0, -1.0, -7.0));
	a[2] = (vec3(2.0, -3.0, -3.0));
	a[3] = (vec3(5.0, 2.0, 2.0));
	a[4] = (vec3(4.0, 9.0, 3.0));
	a[5] = (vec3(-6.0, -7.0, -9.0));
	b[0] = (ivec2(-4, 7));
	b[1] = (ivec2(1, -2));
}
#version 450
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
	layout(offset = 0) highp vec2 a;
	layout(offset = 16) mediump uvec4 b;
	layout(offset = 32) highp ivec3 c;
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp uvec4 d;
	layout(offset = 16) mediump vec2 e[1];
	layout(offset = 24) highp int f;
	layout(offset = 28) bool g;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp vec3 h;
	layout(offset = 16) bvec4 i;
	layout(offset = 32) bool j;
	layout(offset = 36) lowp vec3 k;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump ivec2 l;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB[0].b), uvec4(9u, 8u, 8u, 1u)) && allOk;
	allOk = compare_uvec4((blockB[1].b), uvec4(9u, 6u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((d), uvec4(6u, 8u, 7u, 2u)) && allOk;
	allOk = compare_vec2((e[0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_int((f), -7) && allOk;
	allOk = compare_bool((g), true) && allOk;
	allOk = compare_bvec4((i), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bool((j), false) && allOk;
	allOk = compare_vec3((k), vec3(-6.0, -5.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockE.l), ivec2(-4, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec2(-1.0, -2.0));
	blockB[0].b = (uvec4(9u, 2u, 8u, 5u));
	blockB[0].c = (ivec3(7, -6, 5));
	blockB[1].a = (vec2(2.0, 1.0));
	blockB[1].b = (uvec4(1u, 4u, 6u, 6u));
	blockB[1].c = (ivec3(-5, 1, -3));
	d = (uvec4(5u, 0u, 8u, 3u));
	e[0] = (vec2(-7.0, 2.0));
	f = (2);
	g = (false);
	h = (vec3(9.0, 1.0, 0.0));
	i = (bvec4(false, true, false, true));
	j = (true);
	k = (vec3(4.0, -7.0, 4.0));
	blockE.l = (ivec2(9, 3));
}
#version 450
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
	layout(offset = 0) highp ivec4 a;
	layout(offset = 16) lowp vec3 b;
	layout(offset = 32) highp ivec4 c;
	layout(offset = 48) mediump uvec4 d;
	layout(offset = 64) highp vec3 e;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec2 f;
	layout(offset = 8) mediump ivec2 g;
	layout(offset = 16) lowp uvec4 h;
	layout(offset = 32) bvec4 i[1];
	layout(offset = 48) highp uvec4 j;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(6, 8, 4, -9)) && allOk;
	allOk = compare_ivec4((blockB.c), ivec4(7, 2, -8, 2)) && allOk;
	allOk = compare_uvec4((blockB.d), uvec4(0u, 1u, 5u, 7u)) && allOk;
	allOk = compare_vec3((blockB.e), vec3(3.0, -8.0, 1.0)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(true, false)) && allOk;
	allOk = compare_ivec2((blockC.g), ivec2(5, -5)) && allOk;
	allOk = compare_uvec4((blockC.h), uvec4(1u, 5u, 1u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(7, 7, 1, -6));
	blockB.b = (vec3(-1.0, 9.0, 3.0));
	blockB.d = (uvec4(7u, 8u, 8u, 6u));
	blockC.f = (bvec2(false, true));
	blockC.h = (uvec4(1u, 1u, 4u, 1u));
	blockC.i[0] = (bvec4(false, false, false, true));
	blockC.j = (uvec4(5u, 1u, 1u, 7u));
}
#version 450
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
	bvec4 mB;
	bvec3 mC;
};
struct sB
{
	sA mA;
	mediump int mB;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	bvec4 a;
	highp ivec4 b;
	bvec3 c;
	lowp mat3x2 d[];
};
layout(scalar, binding = 2) buffer BlockC
{
	sB e;
	highp vec3 f;
	highp mat3x4 g;
	lowp ivec3 h;
	lowp vec3 i;
} blockC[3];
layout(scalar, column_major, binding = 3) buffer BlockD
{
	bvec2 j;
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((b), ivec4(-9, 6, -7, 3)) && allOk;
	allOk = compare_mat3x2(d[0], mat3x2(5.0, -3.0, -8.0, 4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(d[1], mat3x2(9.0, 7.0, 8.0, 0.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(d[2], mat3x2(-8.0, -6.0, -1.0, -2.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3x2(d[3], mat3x2(-4.0, 0.0, 2.0, -8.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].g, mat3x4(8.0, -9.0, -7.0, 3.0, -5.0, -4.0, 5.0, 0.0, 6.0, 4.0, -7.0, 5.0)) && allOk;
	allOk = compare_ivec3((blockC[0].h), ivec3(-6, -4, -4)) && allOk;
	allOk = compare_mat3x4(blockC[1].g, mat3x4(-9.0, -9.0, -2.0, 1.0, -6.0, -5.0, 5.0, 4.0, 0.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_ivec3((blockC[1].h), ivec3(-1, -5, 9)) && allOk;
	allOk = compare_mat3x4(blockC[2].g, mat3x4(8.0, -1.0, 5.0, -2.0, -7.0, -9.0, -1.0, 6.0, 8.0, -7.0, -3.0, -3.0)) && allOk;
	allOk = compare_ivec3((blockC[2].h), ivec3(-2, 6, 0)) && allOk;
	allOk = compare_bvec2((blockD[0].j), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[1].j), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, true, false, false));
	b = (ivec4(7, -9, -2, 5));
	c = (bvec3(true, false, false));
	d[0] = (mat3x2(9.0, -8.0, -9.0, -9.0, 4.0, 2.0));
	d[1] = (mat3x2(-3.0, -9.0, -6.0, 2.0, 0.0, 1.0));
	d[2] = (mat3x2(0.0, -1.0, 6.0, 1.0, -3.0, 2.0));
	d[3] = (mat3x2(9.0, -7.0, -8.0, 6.0, 2.0, 6.0));
	blockC[0].e.mA.mA = (vec2(4.0, -6.0));
	blockC[0].e.mA.mB = (bvec4(true, false, true, false));
	blockC[0].e.mA.mC = (bvec3(false, false, true));
	blockC[0].e.mB = (6);
	blockC[0].f = (vec3(2.0, -3.0, 0.0));
	blockC[0].g = (mat3x4(3.0, 6.0, 4.0, 2.0, 0.0, -2.0, -1.0, 6.0, 4.0, 5.0, 4.0, -1.0));
	blockC[0].i = (vec3(-3.0, 8.0, -9.0));
	blockC[1].e.mA.mA = (vec2(9.0, -6.0));
	blockC[1].e.mA.mB = (bvec4(false, true, true, true));
	blockC[1].e.mA.mC = (bvec3(true, false, true));
	blockC[1].e.mB = (-5);
	blockC[1].f = (vec3(-9.0, 1.0, 9.0));
	blockC[1].g = (mat3x4(-2.0, -6.0, -6.0, 0.0, -8.0, -1.0, 4.0, -4.0, 2.0, -3.0, 4.0, 9.0));
	blockC[1].i = (vec3(-8.0, -1.0, 7.0));
	blockC[2].e.mA.mA = (vec2(1.0, -7.0));
	blockC[2].e.mA.mB = (bvec4(true, false, true, true));
	blockC[2].e.mA.mC = (bvec3(true, true, false));
	blockC[2].e.mB = (-7);
	blockC[2].f = (vec3(5.0, 3.0, -2.0));
	blockC[2].g = (mat3x4(-6.0, 5.0, -9.0, 2.0, 2.0, 6.0, 9.0, 4.0, -4.0, -6.0, 7.0, -2.0));
	blockC[2].i = (vec3(-6.0, -7.0, 7.0));
	blockD[0].j = (bvec2(true, true));
	blockD[1].j = (bvec2(false, false));
}
#version 450
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
	mediump uvec4 a;
	mediump vec2 b;
	highp int c[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(2u, 2u, 9u, 8u)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(8u, 1u, 3u, 6u));
	blockB.b = (vec2(-3.0, -6.0));
}
#version 450
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
	f16vec4 a;
	i16vec2 b;
};
layout(std140, binding = 2) buffer BlockC
{
	uint16_t c;
	mediump ivec2 d;
	lowp uvec4 e;
	mediump int f;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(b), ivec2(9, -5)) && allOk;
	allOk = compare_uvec4((blockC.e), uvec4(9u, 0u, 9u, 9u)) && allOk;
	allOk = compare_int((blockC.f), -1) && allOk;
    if (allOk)
        ac_numPassed++;

	a = f16vec4(vec4(3.0, -4.0, 2.0, 2.0));
	b = i16vec2(ivec2(4, 9));
	blockC.d = (ivec2(-4, -9));
	blockC.e = (uvec4(7u, 1u, 0u, 8u));
	blockC.f = (-5);
}
#version 450
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
	mediump uvec4 a;
	lowp mat3x2 b;
	highp float c[8];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	i16vec3 d;
	lowp uvec2 e;
	bvec4 f;
	lowp uint g[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	highp mat3x4 h;
	highp vec3 i;
	mediump mat4x3 j;
	lowp mat3x2 k;
	i16vec4 l[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((a), uvec4(6u, 7u, 4u, 4u)) && allOk;
	allOk = compare_mat3x2(b, mat3x2(-1.0, 3.0, -2.0, 2.0, 6.0, 3.0)) && allOk;
	allOk = compare_float((c[0]), -6.0) && allOk;
	allOk = compare_float((c[1]), -4.0) && allOk;
	allOk = compare_float((c[2]), -6.0) && allOk;
	allOk = compare_float((c[3]), -3.0) && allOk;
	allOk = compare_float((c[4]), -1.0) && allOk;
	allOk = compare_float((c[5]), 4.0) && allOk;
	allOk = compare_float((c[6]), 8.0) && allOk;
	allOk = compare_float((c[7]), -1.0) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.d), ivec3(6, 5, -8)) && allOk;
	allOk = compare_uvec2((blockC.e), uvec2(2u, 9u)) && allOk;
	allOk = compare_bvec4((blockC.f), bvec4(true, true, false, true)) && allOk;
	allOk = compare_mat4x3(blockD.j, mat4x3(3.0, 4.0, -7.0, 3.0, 6.0, -3.0, -1.0, 7.0, 5.0, 7.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockD.k, mat3x2(-8.0, 4.0, -5.0, 8.0, 9.0, 3.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.l[0]), ivec4(-3, 3, 6, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.l[1]), ivec4(-8, 3, 2, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.l[2]), ivec4(-4, -2, -4, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.l[3]), ivec4(-4, 2, 5, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec4(6u, 4u, 7u, 8u));
	blockC.e = (uvec2(4u, 3u));
	blockC.f = (bvec4(true, true, false, true));
	blockD.j = (mat4x3(9.0, -2.0, -6.0, 3.0, 6.0, 8.0, -7.0, 5.0, 6.0, -4.0, 7.0, 6.0));
	blockD.k = (mat3x2(5.0, 0.0, -8.0, 8.0, 5.0, 8.0));
}
#version 450
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
	lowp mat2 a;
	bvec3 b[];
} blockB[1];
layout(std430, row_major, binding = 2) buffer BlockC
{
	i16vec4 c;
	bvec3 d;
	f16vec4 e;
	highp ivec4 f;
};
layout(std430, binding = 3) buffer BlockD
{
	mediump mat3x2 g;
	mediump uvec2 h;
	mediump vec4 i;
	lowp mat4 j;
	bool k[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(c), ivec4(-6, 4, 5, 6)) && allOk;
	allOk = compare_bvec3((d), bvec3(true, false, false)) && allOk;
	allOk = compare_f16vec4(vec4(e), vec4(-7.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockD.g, mat3x2(2.0, 3.0, -7.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_uvec2((blockD.h), uvec2(7u, 9u)) && allOk;
	allOk = compare_vec4((blockD.i), vec4(3.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(blockD.j, mat4(6.0, -4.0, 6.0, 7.0, 5.0, 8.0, -9.0, -5.0, -1.0, -8.0, 9.0, 7.0, -8.0, 5.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat2(8.0, -1.0, -2.0, -6.0));
	c = i16vec4(ivec4(5, 4, 8, 6));
	d = (bvec3(true, false, true));
	e = f16vec4(vec4(4.0, 7.0, 0.0, 9.0));
	f = (ivec4(-4, -5, 4, 9));
	blockD.g = (mat3x2(-7.0, -6.0, -2.0, -4.0, 8.0, -6.0));
	blockD.h = (uvec2(4u, 6u));
	blockD.i = (vec4(-3.0, -6.0, 8.0, -6.0));
	blockD.j = (mat4(-7.0, -1.0, 4.0, -7.0, 2.0, -1.0, 4.0, -6.0, 5.0, -5.0, -1.0, -2.0, -3.0, -7.0, 8.0, -6.0));
}
#version 450
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
	f16vec4 mB;
	highp uvec3 mC;
};
layout(std430, binding = 1) buffer BlockB
{
	sA a;
	lowp mat3x2 b;
	u16vec3 c;
	uint16_t d[];
};
layout(std430, column_major, binding = 2) readonly buffer BlockC
{
	lowp mat3x4 e;
	int16_t f;
	mediump mat3x2 g;
} blockC[3];
layout(std430, row_major, binding = 3) readonly buffer BlockD
{
	mediump mat3 h;
	lowp mat2 i[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(c), uvec3(6u, 3u, 1u)) && allOk;
	allOk = compare_uint16_t(uint(d[0]), 5u) && allOk;
	allOk = compare_uint16_t(uint(d[1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(d[2]), 8u) && allOk;
	allOk = compare_uint16_t(uint(d[3]), 1u) && allOk;
	allOk = compare_mat3x4(blockC[0].e, mat3x4(6.0, 9.0, 0.0, 1.0, -3.0, 1.0, 6.0, 6.0, 6.0, -8.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockC[1].e, mat3x4(2.0, -1.0, 9.0, -9.0, 9.0, 3.0, -9.0, 3.0, 5.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockC[2].e, mat3x4(-1.0, -9.0, -5.0, 8.0, 5.0, -4.0, -1.0, -8.0, 4.0, -7.0, 1.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat3x2(0.0, 0.0, 6.0, -6.0, -5.0, 2.0));
	c = u16vec3(uvec3(5u, 6u, 6u));
	d[0] = uint16_t(9u);
	d[1] = uint16_t(3u);
	d[2] = uint16_t(0u);
	d[3] = uint16_t(9u);
}
#version 450
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
	lowp uvec2 a;
	bvec2 b[];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((a), uvec2(9u, 8u)) && allOk;
	allOk = compare_bvec2((b[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((b[1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((b[2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((b[3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((b[4]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((b[5]), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec2(1u, 5u));
	b[0] = (bvec2(false, true));
	b[1] = (bvec2(true, true));
	b[2] = (bvec2(false, false));
	b[3] = (bvec2(true, false));
	b[4] = (bvec2(true, false));
	b[5] = (bvec2(true, false));
}
#version 450
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
	layout(offset = 16) highp ivec4 b[1];
	layout(offset = 32) i16vec4 c;
	layout(offset = 48) bvec4 d;
	layout(offset = 64) i16vec2 e;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump uint f;
	layout(offset = 8) u16vec4 g[1];
	layout(offset = 16) int16_t h;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) i16vec4 i;
	layout(offset = 8) uint16_t j;
} blockD;

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((b[0]), ivec4(-3, 7, -7, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(c), ivec4(3, 1, -6, -6)) && allOk;
	allOk = compare_int16_t(int(h), -6) && allOk;
	allOk = compare_uint16_t(uint(blockD.j), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, true, true, true));
	b[0] = (ivec4(6, 7, 4, 3));
	c = i16vec4(ivec4(9, 4, 4, -4));
	d = (bvec4(true, false, false, true));
	e = i16vec2(ivec2(-3, 2));
	f = (5u);
	g[0] = u16vec4(uvec4(4u, 4u, 6u, 8u));
	h = int16_t(-5);
	blockD.i = i16vec4(ivec4(5, -9, 3, -8));
}
#version 450
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
	layout(offset = 16) mediump int b[1];
	layout(offset = 20) uint16_t c;
	layout(offset = 22) f16vec2 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump vec3 e;
	layout(offset = 16) mediump vec3 f;
	layout(offset = 32) lowp ivec2 g[1];
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump ivec2 h;
	layout(offset = 8) u16vec4 i;
	layout(offset = 16) highp vec4 j;
	layout(offset = 32) highp vec3 k;
	layout(offset = 48) mediump ivec3 l[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uint16_t(uint(blockB.c), 2u) && allOk;
	allOk = compare_vec3((e), vec3(5.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec3((f), vec3(-6.0, -1.0, -7.0)) && allOk;
	allOk = compare_ivec2((g[0]), ivec2(0, -8)) && allOk;
	allOk = compare_ivec2((h), ivec2(1, -8)) && allOk;
	allOk = compare_vec4((j), vec4(-5.0, -1.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec3((k), vec3(-5.0, 7.0, -9.0)) && allOk;
	allOk = compare_ivec3((l[0]), ivec3(-8, 1, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, true));
	blockB.b[0] = (8);
	blockB.c = uint16_t(4u);
	blockB.d = f16vec2(vec2(-2.0, -7.0));
	f = (vec3(-3.0, 3.0, 4.0));
	g[0] = (ivec2(2, -9));
	h = (ivec2(9, 7));
	i = u16vec4(uvec4(0u, 3u, 9u, 6u));
	l[0] = (ivec3(4, 1, -3));
}
#version 450
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
	layout(offset = 0) lowp mat4 a;
	layout(offset = 64) bool b;
	layout(offset = 68) i16vec2 c;
	layout(offset = 72) f16vec4 d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB[nonuniformEXT(0)].a, mat4(-8.0, -2.0, 9.0, -5.0, 5.0, 6.0, -1.0, 9.0, -1.0, 6.0, 0.0, -9.0, 1.0, 8.0, 1.0, -2.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(0)].c), ivec2(-6, -1)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(0)].d), vec4(-8.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(1)].a, mat4(9.0, -6.0, 5.0, -2.0, -8.0, -1.0, -6.0, 5.0, 3.0, 3.0, -9.0, 4.0, 8.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(1)].c), ivec2(4, -2)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(1)].d), vec4(-5.0, -9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(2)].a, mat4(-3.0, 6.0, 4.0, 1.0, -3.0, 4.0, 0.0, -4.0, -7.0, 5.0, -1.0, 6.0, 8.0, -2.0, 6.0, 1.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(2)].c), ivec2(-3, -5)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(2)].d), vec4(-7.0, 4.0, -2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4(1.0, 1.0, -4.0, 1.0, 8.0, -4.0, 1.0, -9.0, 3.0, 0.0, -9.0, -6.0, 3.0, 4.0, -1.0, -4.0));
	blockB[nonuniformEXT(0)].c = i16vec2(ivec2(-3, 6));
	blockB[nonuniformEXT(1)].a = (mat4(-8.0, 2.0, 0.0, 3.0, 9.0, -8.0, -9.0, -2.0, 0.0, 2.0, 6.0, -7.0, 3.0, 9.0, 8.0, 1.0));
	blockB[nonuniformEXT(1)].c = i16vec2(ivec2(2, 7));
	blockB[nonuniformEXT(2)].a = (mat4(-6.0, -2.0, 0.0, -4.0, -4.0, -9.0, 1.0, 5.0, -8.0, -8.0, 9.0, -4.0, 9.0, -7.0, 5.0, 9.0));
	blockB[nonuniformEXT(2)].c = i16vec2(ivec2(-8, 2));
}
#version 450
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
	highp uvec4 a;
	i8vec4 b;
	i8vec3 c;
	mediump ivec4 d;
	i8vec4 e;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	u8vec2 f;
} blockC;

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(1u, 9u, 8u, 5u)) && allOk;
	allOk = compare_ivec4((blockB.d), ivec4(-8, 2, 9, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.e), ivec4(4294967291, 7, 3, 4294967293)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.f), uvec2(0u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(5u, 2u, 5u, 7u));
	blockB.b = i8vec4(ivec4(4294967288, 4294967291, 0, 0));
	blockB.c = i8vec3(ivec3(4294967289, 5, 3));
	blockB.d = (ivec4(4, 7, 8, 3));
	blockB.e = i8vec4(ivec4(8, 8, 0, 8));
	blockC.f = u8vec2(uvec2(5u, 3u));
}
#version 450
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
	i8vec4 a;
	lowp mat3 b;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.b, mat3(-5.0, -8.0, 5.0, 2.0, 2.0, -7.0, -1.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec4(ivec4(9, 4294967294, 4294967293, 4294967289));
	blockB.b = (mat3(6.0, 7.0, 5.0, 2.0, 6.0, 7.0, -8.0, -4.0, 9.0));
}
#version 450
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
	layout(offset = 0) i8vec4 a;
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(a), ivec4(8, 5, 4294967292, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i8vec4(ivec4(4294967292, 4, 4294967295, 8));
}
#version 450
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
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump uvec3 b;
	layout(offset = 12) mediump int c;
	layout(offset = 16) lowp uvec4 d[1];
	layout(offset = 32) mediump uvec3 e;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB[0].a), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec3((b), uvec3(3u, 7u, 0u)) && allOk;
	allOk = compare_uvec4((d[0]), uvec4(9u, 5u, 7u, 3u)) && allOk;
	allOk = compare_uvec3((e), uvec3(4u, 4u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = u8vec2(uvec2(0u, 4u));
	b = (uvec3(1u, 4u, 5u));
	c = (7);
	d[0] = (uvec4(2u, 1u, 4u, 9u));
}
#version 450
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
	allOk = compare_mat4x2(var, mat4x2(6.0, 9.0, 9.0, 6.0, 5.0, -7.0, -2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

layout(std430, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	allOk = compare_mat2x4(var, mat2x4(6.0, -3.0, -8.0, 0.0, 2.0, 7.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x2(var, mat3x2(8.0, -6.0, -5.0, 4.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[3][0], -8.0) && allOk;
	allOk = compare_float(var[3][1], -5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-9.0, 0.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bvec3 var;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), true) && allOk;
	allOk = compare_bvec3((var), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -3.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[2][0], 9.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-4.0, -7.0, -1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, -3.0, -2.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(9.0, 9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-2.0, 8.0, -5.0, 9.0, -6.0, -1.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_float(var[0][0], -9.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[0][3], -3.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_float(var[1][2], -6.0) && allOk;
	allOk = compare_float(var[1][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-9.0, -6.0, -9.0, -3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-7.0, 6.0, -6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[2][2], 8.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], -2.0) && allOk;
	allOk = compare_float(var[3][2], 0.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-4.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(8.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-4.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-4.0, -2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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

layout(scalar, row_major, binding = 1) readonly buffer Block
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
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(-7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0, -9.0, 3.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0, -4.0, 9.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0, -6.0, -7.0, 8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp float var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var[0]), 7.0) && allOk;
	allOk = compare_float((var[1]), -1.0) && allOk;
	allOk = compare_float((var[2]), -6.0) && allOk;
	allOk = compare_float((var[3]), 0.0) && allOk;
	allOk = compare_float((var[4]), -7.0) && allOk;
	allOk = compare_float((var[5]), 5.0) && allOk;
	allOk = compare_float((var[6]), 4.0) && allOk;
	allOk = compare_float((var[7]), 2.0) && allOk;
	allOk = compare_float((var[8]), -1.0) && allOk;
	allOk = compare_float((var[9]), -6.0) && allOk;
	allOk = compare_float((var[10]), -2.0) && allOk;
	allOk = compare_float((var[11]), -1.0) && allOk;
	allOk = compare_float((var[12]), 1.0) && allOk;
	allOk = compare_float((var[13]), -3.0) && allOk;
	allOk = compare_float((var[14]), -7.0) && allOk;
	allOk = compare_float((var[15]), 8.0) && allOk;
	allOk = compare_float((var[16]), -9.0) && allOk;
	allOk = compare_float((var[17]), -4.0) && allOk;
	allOk = compare_float((var[18]), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3], mat3x4(8.0, -1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(-3.0, -9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-2.0, -4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(-9.0, -4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-1.0, 9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(-2.0, 2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(0.0, 2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(4.0, 1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(8.0, -5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(3.0, 8.0, 5.0, 9.0, 4.0, 6.0, 7.0, 0.0, 4.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(8.0, -7.0, -1.0, 4.0, -8.0, -5.0, 3.0, 6.0, 4.0, -1.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(6.0, -2.0, -4.0, 2.0, -1.0, -5.0, -1.0, -2.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(-9.0, 3.0, 2.0, 5.0, -9.0, -1.0, -7.0, 5.0, -3.0, -9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(7.0, 3.0, 5.0, 9.0, -3.0, -2.0, -1.0, 5.0, -5.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(2.0, 0.0, -7.0, 6.0, 9.0, -6.0, -1.0, 6.0, 6.0, 4.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(8.0, 9.0, 2.0, 2.0, 6.0, -3.0, 4.0, -7.0, 0.0, 1.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, binding = 1) readonly buffer Block
{
	float16_t var[];
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(var[0]), -7.0) && allOk;
	allOk = compare_float16_t(float(var[1]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[2]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[3]), 0.0) && allOk;
	allOk = compare_float16_t(float(var[4]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[5]), 9.0) && allOk;
	allOk = compare_float16_t(float(var[6]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[7]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[8]), 7.0) && allOk;
	allOk = compare_float16_t(float(var[9]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[10]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[11]), -3.0) && allOk;
	allOk = compare_float16_t(float(var[12]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[13]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[14]), -8.0) && allOk;
	allOk = compare_float16_t(float(var[15]), -2.0) && allOk;
	allOk = compare_float16_t(float(var[16]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[17]), 3.0) && allOk;
	allOk = compare_float16_t(float(var[18]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], 1.0) && allOk;
	allOk = compare_float(block.var[2][0], -4.0) && allOk;
	allOk = compare_float(block.var[2][1], 6.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(1.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-5.0, 1.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-5.0, 1.0));
	block.var[1] = (vec2(1.0, -5.0));
	block.var[2] = (vec2(1.0, -4.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	lowp int var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.var), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (-7);
}
#version 450
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
	highp ivec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.var), ivec3(-4, 5, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (ivec3(5, -5, 0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], 5.0) && allOk;
	allOk = compare_float(block.var[0][2], -8.0) && allOk;
	allOk = compare_float(block.var[0][3], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], -3.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][3], 1.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], 2.0) && allOk;
	allOk = compare_float(block.var[2][2], -7.0) && allOk;
	allOk = compare_float(block.var[2][3], -4.0) && allOk;
	allOk = compare_float(block.var[3][0], 2.0) && allOk;
	allOk = compare_float(block.var[3][1], -6.0) && allOk;
	allOk = compare_float(block.var[3][2], -4.0) && allOk;
	allOk = compare_float(block.var[3][3], -7.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-7.0, 5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(6.0, -3.0, -2.0, 1.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-6.0, 2.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(2.0, -6.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(-7.0, -6.0, -9.0, 9.0, -9.0, 8.0, 8.0, -8.0, 3.0, -3.0, 5.0, -9.0, -3.0, 2.0, 0.0, -1.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
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
	allOk = compare_mat4x3(block.var, mat4x3(-2.0, 1.0, 2.0, 1.0, -6.0, -9.0, 7.0, 0.0, -3.0, -2.0, -3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(2.0, -6.0, -3.0, 1.0, -1.0, 0.0, 4.0, -4.0, -6.0, 0.0, 2.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_float(block.var[0][0], -8.0) && allOk;
	allOk = compare_float(block.var[0][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], 4.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-8.0, 5.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(4.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0] = (vec2(-8.0, 0.0));
	block.var[1] = (vec2(-3.0, -8.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_float(block.var[0][0], -2.0) && allOk;
	allOk = compare_float(block.var[0][1], 8.0) && allOk;
	allOk = compare_float(block.var[0][2], -8.0) && allOk;
	allOk = compare_float(block.var[1][0], 1.0) && allOk;
	allOk = compare_float(block.var[1][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][2], -5.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-2.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(1.0, 4.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0] = (vec3(-3.0, 1.0, -6.0));
	block.var[1] = (vec3(-5.0, -7.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_mat2x4(block.var, mat2x4(-3.0, 1.0, -9.0, 3.0, -3.0, -9.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-4.0);
	block.var = (mat2x4(-7.0, 5.0, -2.0, 2.0, -1.0, -3.0, -3.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], 9.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], 0.0) && allOk;
	allOk = compare_float(block.var[2][0], 5.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-5.0, 0.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var = (mat3x2(9.0, -6.0, 5.0, -9.0, -7.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_float(block.var[0][0], 9.0) && allOk;
	allOk = compare_float(block.var[0][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[2][0], 9.0) && allOk;
	allOk = compare_float(block.var[2][1], 1.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-5.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0] = (vec2(0.0, 8.0));
	block.var[1] = (vec2(-7.0, -2.0));
	block.var[2] = (vec2(8.0, 2.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat3x4(block.var, mat3x4(8.0, 9.0, 9.0, 9.0, 9.0, -1.0, -9.0, 9.0, 7.0, 9.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var = (mat3x4(9.0, 2.0, 7.0, -6.0, -9.0, 2.0, -3.0, 1.0, 4.0, 3.0, 2.0, -3.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(7.0, 4.0, -4.0));
	block.var[0][1] = (vec3(-6.0, 3.0, -3.0));
	block.var[0][2] = (vec3(9.0, -2.0, 3.0));
	block.var[0][3] = (vec3(9.0, -9.0, 7.0));
	block.var[1][0] = (vec3(5.0, 1.0, -9.0));
	block.var[1][1] = (vec3(-1.0, -2.0, 6.0));
	block.var[1][2] = (vec3(-4.0, 6.0, 4.0));
	block.var[1][3] = (vec3(-8.0, 7.0, 3.0));
	block.var[2][0] = (vec3(-4.0, -9.0, 8.0));
	block.var[2][1] = (vec3(9.0, 2.0, 2.0));
	block.var[2][2] = (vec3(9.0, -7.0, 3.0));
	block.var[2][3] = (vec3(8.0, 2.0, 4.0));
}
#version 450
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
	highp ivec4 var[3];
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
	allOk = compare_ivec4((block.var[0]), ivec4(9, -5, 6, 3)) && allOk;
	allOk = compare_ivec4((block.var[1]), ivec4(4, 2, -3, -3)) && allOk;
	allOk = compare_ivec4((block.var[2]), ivec4(-3, -5, -5, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5);
	block.var[0] = (ivec4(-9, 5, -6, -2));
	block.var[1] = (ivec4(-4, 1, -9, 7));
	block.var[2] = (ivec4(3, 6, 8, 6));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2(block.var[0], mat2(-7.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(8.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-3.0, -8.0, -6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0][0] = (vec2(-2.0, 4.0));
	block.var[0][1] = (vec2(-3.0, 1.0));
	block.var[1][0] = (vec2(2.0, -4.0));
	block.var[1][1] = (vec2(-3.0, -1.0));
	block.var[2][0] = (vec2(-4.0, 3.0));
	block.var[2][1] = (vec2(1.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_mat2x4(block.var[0], mat2x4(-2.0, 1.0, -1.0, 0.0, 3.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(1.0, 1.0, 2.0, -9.0, -1.0, 3.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(2.0, -6.0, 0.0, -3.0, 1.0, -8.0, 2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0] = (vec4(-1.0, -8.0, 7.0, 5.0));
	block.var[0][1] = (vec4(1.0, 7.0, 1.0, -7.0));
	block.var[1][0] = (vec4(7.0, -4.0, 8.0, -2.0));
	block.var[1][1] = (vec4(2.0, -1.0, 4.0, 2.0));
	block.var[2][0] = (vec4(1.0, 0.0, -4.0, 1.0));
	block.var[2][1] = (vec4(5.0, -2.0, 1.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(0.0, -5.0, -8.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(8.0, 5.0, -3.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(-6.0, -2.0, 1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(1.0, 7.0, 8.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(-8.0, -9.0, -2.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(-5.0, -5.0, 6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(7.0, 0.0, 2.0, 4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(4.0, -9.0, 5.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(1.0, 5.0, -6.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(-8.0, -8.0, 8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(-5.0, 9.0, -6.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(4.0, 2.0, 6.0, 8.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(-3.0, 7.0, -7.0, -6.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(-6.0, -9.0, -2.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(8.0, -6.0, -6.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(9.0, -9.0, 3.0, -4.0, -3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(-7.0, -8.0, 7.0));
	block.var[0][1] = (vec3(-6.0, -3.0, -4.0));
	block.var[1][0] = (vec3(3.0, -8.0, -9.0));
	block.var[1][1] = (vec3(-2.0, 5.0, 6.0));
	block.var[2][0] = (vec3(6.0, -5.0, -7.0));
	block.var[2][1] = (vec3(1.0, 1.0, -3.0));
	block.var[3][0] = (vec3(9.0, -7.0, 2.0));
	block.var[3][1] = (vec3(5.0, -4.0, 6.0));
	block.var[4][0] = (vec3(-3.0, -8.0, 6.0));
	block.var[4][1] = (vec3(8.0, 2.0, 4.0));
	block.var[5][0] = (vec3(0.0, 8.0, 0.0));
	block.var[5][1] = (vec3(-2.0, 1.0, -3.0));
	block.var[6][0] = (vec3(-6.0, 3.0, 9.0));
	block.var[6][1] = (vec3(3.0, -2.0, -9.0));
	block.var[7][0] = (vec3(-7.0, -8.0, -6.0));
	block.var[7][1] = (vec3(-7.0, 2.0, -3.0));
	block.var[8][0] = (vec3(1.0, -1.0, 8.0));
	block.var[8][1] = (vec3(7.0, -2.0, -6.0));
	block.var[9][0] = (vec3(-1.0, -1.0, -5.0));
	block.var[9][1] = (vec3(-1.0, 1.0, -1.0));
	block.var[10][0] = (vec3(5.0, 5.0, -6.0));
	block.var[10][1] = (vec3(6.0, 7.0, -2.0));
	block.var[11][0] = (vec3(-5.0, -7.0, -1.0));
	block.var[11][1] = (vec3(4.0, -3.0, -7.0));
	block.var[12][0] = (vec3(5.0, 5.0, -4.0));
	block.var[12][1] = (vec3(1.0, -9.0, 1.0));
	block.var[13][0] = (vec3(3.0, 0.0, -6.0));
	block.var[13][1] = (vec3(5.0, -6.0, -6.0));
	block.var[14][0] = (vec3(7.0, 1.0, -9.0));
	block.var[14][1] = (vec3(7.0, -8.0, -1.0));
	block.var[15][0] = (vec3(5.0, -3.0, 9.0));
	block.var[15][1] = (vec3(-6.0, 4.0, -4.0));
	block.var[16][0] = (vec3(2.0, 5.0, 0.0));
	block.var[16][1] = (vec3(1.0, -8.0, 0.0));
	block.var[17][0] = (vec3(7.0, -2.0, -7.0));
	block.var[17][1] = (vec3(-6.0, -5.0, 3.0));
	block.var[18][0] = (vec3(1.0, -4.0, 2.0));
	block.var[18][1] = (vec3(0.0, 1.0, -8.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(3.0, -1.0, -8.0, -1.0, -7.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(0.0, -8.0, -7.0, 7.0, 3.0, 7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(-7.0, 7.0, -7.0, -4.0, -2.0, -5.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(3.0, -9.0, 6.0, -8.0, 0.0, 5.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(-2.0, 0.0, 9.0, -8.0, 0.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(9.0, 1.0, 2.0, -6.0, -9.0, -9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(-8.0, 9.0, -5.0, -6.0, -1.0, 1.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(6.0, -2.0));
	block.var[0][1] = (vec2(2.0, 8.0));
	block.var[0][2] = (vec2(-5.0, 3.0));
	block.var[0][3] = (vec2(-1.0, -7.0));
	block.var[1][0] = (vec2(4.0, 2.0));
	block.var[1][1] = (vec2(-4.0, 8.0));
	block.var[1][2] = (vec2(3.0, 8.0));
	block.var[1][3] = (vec2(-1.0, 6.0));
	block.var[2][0] = (vec2(-8.0, 2.0));
	block.var[2][1] = (vec2(-5.0, 5.0));
	block.var[2][2] = (vec2(-4.0, -9.0));
	block.var[2][3] = (vec2(0.0, 4.0));
	block.var[3][0] = (vec2(8.0, 2.0));
	block.var[3][1] = (vec2(-3.0, 2.0));
	block.var[3][2] = (vec2(-4.0, -4.0));
	block.var[3][3] = (vec2(2.0, -8.0));
	block.var[4][0] = (vec2(-4.0, 8.0));
	block.var[4][1] = (vec2(5.0, 7.0));
	block.var[4][2] = (vec2(-4.0, 6.0));
	block.var[4][3] = (vec2(8.0, 4.0));
	block.var[5][0] = (vec2(-9.0, -7.0));
	block.var[5][1] = (vec2(7.0, -5.0));
	block.var[5][2] = (vec2(1.0, -9.0));
	block.var[5][3] = (vec2(9.0, 5.0));
	block.var[6][0] = (vec2(7.0, 3.0));
	block.var[6][1] = (vec2(3.0, 3.0));
	block.var[6][2] = (vec2(-5.0, -9.0));
	block.var[6][3] = (vec2(2.0, 9.0));
	block.var[7][0] = (vec2(3.0, 8.0));
	block.var[7][1] = (vec2(3.0, -4.0));
	block.var[7][2] = (vec2(6.0, 1.0));
	block.var[7][3] = (vec2(-3.0, 1.0));
	block.var[8][0] = (vec2(-5.0, -2.0));
	block.var[8][1] = (vec2(7.0, 8.0));
	block.var[8][2] = (vec2(4.0, 7.0));
	block.var[8][3] = (vec2(-1.0, -8.0));
	block.var[9][0] = (vec2(-6.0, -6.0));
	block.var[9][1] = (vec2(-4.0, -2.0));
	block.var[9][2] = (vec2(3.0, 8.0));
	block.var[9][3] = (vec2(4.0, 4.0));
	block.var[10][0] = (vec2(-7.0, -6.0));
	block.var[10][1] = (vec2(8.0, -6.0));
	block.var[10][2] = (vec2(8.0, -3.0));
	block.var[10][3] = (vec2(-7.0, 0.0));
	block.var[11][0] = (vec2(-9.0, 2.0));
	block.var[11][1] = (vec2(-9.0, 7.0));
	block.var[11][2] = (vec2(-2.0, 2.0));
	block.var[11][3] = (vec2(-6.0, -1.0));
	block.var[12][0] = (vec2(1.0, 7.0));
	block.var[12][1] = (vec2(0.0, -4.0));
	block.var[12][2] = (vec2(-1.0, 5.0));
	block.var[12][3] = (vec2(9.0, -8.0));
	block.var[13][0] = (vec2(-3.0, 8.0));
	block.var[13][1] = (vec2(-1.0, 7.0));
	block.var[13][2] = (vec2(5.0, -7.0));
	block.var[13][3] = (vec2(8.0, 0.0));
	block.var[14][0] = (vec2(-5.0, 7.0));
	block.var[14][1] = (vec2(8.0, 9.0));
	block.var[14][2] = (vec2(8.0, 9.0));
	block.var[14][3] = (vec2(1.0, 9.0));
	block.var[15][0] = (vec2(-9.0, 8.0));
	block.var[15][1] = (vec2(-2.0, 9.0));
	block.var[15][2] = (vec2(6.0, 6.0));
	block.var[15][3] = (vec2(3.0, -5.0));
	block.var[16][0] = (vec2(1.0, -4.0));
	block.var[16][1] = (vec2(-5.0, 7.0));
	block.var[16][2] = (vec2(-8.0, 7.0));
	block.var[16][3] = (vec2(-1.0, -1.0));
	block.var[17][0] = (vec2(-2.0, -7.0));
	block.var[17][1] = (vec2(4.0, -8.0));
	block.var[17][2] = (vec2(2.0, 4.0));
	block.var[17][3] = (vec2(3.0, 1.0));
	block.var[18][0] = (vec2(7.0, 8.0));
	block.var[18][1] = (vec2(2.0, -9.0));
	block.var[18][2] = (vec2(-8.0, -9.0));
	block.var[18][3] = (vec2(-1.0, -3.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(8.0, -9.0, 9.0, -6.0, -8.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(3.0, 6.0, -4.0, 1.0, 5.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(2.0, -9.0, 8.0, 9.0, 2.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(-6.0, 7.0, 6.0, 4.0, 1.0, -8.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(7.0, 6.0, -2.0, -3.0, 3.0, 9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(3.0, -3.0, 6.0, -6.0, -5.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(0.0, 7.0, -8.0, 7.0, 2.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(5.0, -3.0, 1.0, -3.0, -2.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(-6.0, 2.0, 4.0, 7.0, -8.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(-4.0, 3.0, 2.0, -4.0, -2.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(-7.0, 1.0, 1.0, 6.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(0.0, 8.0, -2.0, 7.0, 8.0, -1.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(-5.0, 5.0, 2.0, -9.0, -1.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(-9.0, -9.0, 4.0, 4.0, 6.0, -7.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(-2.0, -4.0, 4.0, 7.0, 4.0, 9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(-8.0, 0.0, -3.0, -4.0, 4.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(7.0, 6.0, -7.0, 5.0, 0.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(7.0, -5.0, 3.0, -8.0, 1.0, -3.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(6.0, 8.0, 7.0, 0.0, -5.0, 3.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(4.0, -9.0));
	block.var[0][1] = (vec2(-2.0, 8.0));
	block.var[0][2] = (vec2(-4.0, 4.0));
	block.var[0][3] = (vec2(9.0, 5.0));
	block.var[1][0] = (vec2(-2.0, 4.0));
	block.var[1][1] = (vec2(6.0, -8.0));
	block.var[1][2] = (vec2(-5.0, -1.0));
	block.var[1][3] = (vec2(9.0, 0.0));
	block.var[2][0] = (vec2(5.0, -2.0));
	block.var[2][1] = (vec2(4.0, -5.0));
	block.var[2][2] = (vec2(-2.0, -4.0));
	block.var[2][3] = (vec2(6.0, 4.0));
	block.var[3][0] = (vec2(5.0, 5.0));
	block.var[3][1] = (vec2(-6.0, -5.0));
	block.var[3][2] = (vec2(7.0, -6.0));
	block.var[3][3] = (vec2(8.0, 5.0));
	block.var[4][0] = (vec2(5.0, -5.0));
	block.var[4][1] = (vec2(-6.0, -3.0));
	block.var[4][2] = (vec2(-1.0, -1.0));
	block.var[4][3] = (vec2(-2.0, 6.0));
	block.var[5][0] = (vec2(-1.0, -8.0));
	block.var[5][1] = (vec2(-5.0, 5.0));
	block.var[5][2] = (vec2(5.0, 9.0));
	block.var[5][3] = (vec2(-7.0, 0.0));
	block.var[6][0] = (vec2(6.0, 4.0));
	block.var[6][1] = (vec2(5.0, 2.0));
	block.var[6][2] = (vec2(6.0, -4.0));
	block.var[6][3] = (vec2(-4.0, 8.0));
	block.var[7][0] = (vec2(5.0, -1.0));
	block.var[7][1] = (vec2(7.0, 0.0));
	block.var[7][2] = (vec2(-7.0, -4.0));
	block.var[7][3] = (vec2(1.0, -1.0));
	block.var[8][0] = (vec2(7.0, -6.0));
	block.var[8][1] = (vec2(9.0, -9.0));
	block.var[8][2] = (vec2(7.0, -8.0));
	block.var[8][3] = (vec2(5.0, -4.0));
	block.var[9][0] = (vec2(4.0, 3.0));
	block.var[9][1] = (vec2(9.0, 1.0));
	block.var[9][2] = (vec2(-6.0, -3.0));
	block.var[9][3] = (vec2(-7.0, 9.0));
	block.var[10][0] = (vec2(3.0, 5.0));
	block.var[10][1] = (vec2(3.0, -7.0));
	block.var[10][2] = (vec2(0.0, 6.0));
	block.var[10][3] = (vec2(-8.0, -2.0));
	block.var[11][0] = (vec2(7.0, -6.0));
	block.var[11][1] = (vec2(2.0, -2.0));
	block.var[11][2] = (vec2(8.0, 8.0));
	block.var[11][3] = (vec2(1.0, -3.0));
	block.var[12][0] = (vec2(-8.0, 0.0));
	block.var[12][1] = (vec2(-4.0, 6.0));
	block.var[12][2] = (vec2(-7.0, 4.0));
	block.var[12][3] = (vec2(-6.0, -5.0));
	block.var[13][0] = (vec2(-2.0, 7.0));
	block.var[13][1] = (vec2(-3.0, 0.0));
	block.var[13][2] = (vec2(-8.0, -9.0));
	block.var[13][3] = (vec2(6.0, 0.0));
	block.var[14][0] = (vec2(6.0, -7.0));
	block.var[14][1] = (vec2(2.0, 3.0));
	block.var[14][2] = (vec2(-4.0, -6.0));
	block.var[14][3] = (vec2(5.0, -1.0));
	block.var[15][0] = (vec2(-8.0, 7.0));
	block.var[15][1] = (vec2(0.0, 0.0));
	block.var[15][2] = (vec2(-7.0, -3.0));
	block.var[15][3] = (vec2(-7.0, -3.0));
	block.var[16][0] = (vec2(2.0, 6.0));
	block.var[16][1] = (vec2(3.0, 3.0));
	block.var[16][2] = (vec2(-8.0, -2.0));
	block.var[16][3] = (vec2(-4.0, 0.0));
	block.var[17][0] = (vec2(2.0, 5.0));
	block.var[17][1] = (vec2(2.0, 3.0));
	block.var[17][2] = (vec2(-3.0, 2.0));
	block.var[17][3] = (vec2(4.0, 1.0));
	block.var[18][0] = (vec2(6.0, 5.0));
	block.var[18][1] = (vec2(3.0, 5.0));
	block.var[18][2] = (vec2(2.0, 5.0));
	block.var[18][3] = (vec2(-8.0, 8.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(-4.0, -7.0, 7.0, -5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(3.0, -3.0, 0.0, 8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(6.0, 2.0, -1.0, -6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(-9.0, -5.0, -9.0, 1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(-7.0, -4.0, 0.0, 2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(-7.0, 4.0, 9.0, 8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(0.0, -9.0, -1.0, 9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(5.0, -5.0, -1.0, -9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(-3.0, 1.0, 7.0, -9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(-1.0, 1.0, 9.0, 7.0, 0.0, 9.0, -1.0, -1.0, -7.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(5.0, 7.0, -6.0, -7.0, 6.0, -5.0, -4.0, -1.0, 8.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(-2.0, -5.0, -2.0, -2.0, 9.0, 9.0, -6.0, 0.0, -5.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(8.0, -9.0, 6.0, -7.0, 6.0, 5.0, -5.0, -1.0, 5.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(8.0, 3.0, -1.0, 2.0, 5.0, -8.0, 0.0, -6.0, 4.0, 6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(8.0, 4.0, -1.0, -5.0, 0.0, -6.0, 3.0, 7.0, -8.0, -4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(6.0, -3.0, 0.0, -6.0, -3.0, -6.0, 8.0, 4.0, 2.0, 4.0, -2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	block.var[1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	block.var[2] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
	block.var[3] = (mat4x3(9.0, -7.0, -4.0, -3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0));
	block.var[4] = (mat4x3(9.0, 0.0, 0.0, 7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0));
	block.var[5] = (mat4x3(-4.0, 1.0, 3.0, -5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0));
	block.var[6] = (mat4x3(-8.0, -3.0, -8.0, -5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0));
	block.var[7] = (mat4x3(8.0, -8.0, -9.0, 9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0));
	block.var[8] = (mat4x3(-8.0, 9.0, 8.0, -9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0));
	block.var[9] = (mat4x3(8.0, -3.0, -6.0, 2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0));
	block.var[10] = (mat4x3(1.0, -6.0, -5.0, -5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0));
	block.var[11] = (mat4x3(-4.0, 8.0, 5.0, -4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0));
	block.var[12] = (mat4x3(4.0, 9.0, 7.0, 5.0, 7.0, -2.0, -4.0, -2.0, 3.0, -6.0, 0.0, -7.0));
	block.var[13] = (mat4x3(9.0, -6.0, -9.0, 5.0, -1.0, -2.0, 4.0, 7.0, 2.0, 8.0, -7.0, 9.0));
	block.var[14] = (mat4x3(7.0, 3.0, 4.0, 9.0, 8.0, -1.0, -6.0, -4.0, 5.0, -8.0, -4.0, 1.0));
	block.var[15] = (mat4x3(-1.0, 6.0, 7.0, -9.0, 0.0, 8.0, -4.0, 2.0, 0.0, 3.0, -3.0, 1.0));
	block.var[16] = (mat4x3(7.0, 7.0, -6.0, 0.0, 1.0, 7.0, 2.0, 8.0, -2.0, -5.0, 8.0, 3.0));
	block.var[17] = (mat4x3(-1.0, -5.0, -8.0, 1.0, 4.0, 0.0, 2.0, -3.0, 8.0, -5.0, -9.0, 4.0));
	block.var[18] = (mat4x3(5.0, -9.0, 3.0, -6.0, -1.0, 2.0, 6.0, -2.0, 0.0, 5.0, -5.0, -5.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(-3.0, 4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(-6.0, -2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(0.0, -2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(-2.0, -2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(1.0, -7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(-2.0, -9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(1.0, 6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-3.0, -6.0, 8.0, 7.0));
	block.var[0][1] = (vec4(-8.0, 6.0, 1.0, -6.0));
	block.var[0][2] = (vec4(6.0, 0.0, -6.0, 3.0));
	block.var[0][3] = (vec4(3.0, 3.0, -3.0, 2.0));
	block.var[1][0] = (vec4(-8.0, 9.0, -6.0, 6.0));
	block.var[1][1] = (vec4(1.0, 9.0, -7.0, 4.0));
	block.var[1][2] = (vec4(-5.0, 5.0, -6.0, 5.0));
	block.var[1][3] = (vec4(7.0, 7.0, -5.0, -9.0));
	block.var[2][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	block.var[2][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	block.var[2][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	block.var[2][3] = (vec4(0.0, -7.0, 7.0, 8.0));
	block.var[3][0] = (vec4(-6.0, -6.0, -1.0, 6.0));
	block.var[3][1] = (vec4(3.0, 5.0, -8.0, 3.0));
	block.var[3][2] = (vec4(1.0, -1.0, 3.0, -5.0));
	block.var[3][3] = (vec4(4.0, -4.0, 3.0, 4.0));
	block.var[4][0] = (vec4(-4.0, -8.0, 4.0, 5.0));
	block.var[4][1] = (vec4(-5.0, 0.0, -3.0, -4.0));
	block.var[4][2] = (vec4(5.0, -4.0, -7.0, 4.0));
	block.var[4][3] = (vec4(-3.0, 9.0, 3.0, -4.0));
	block.var[5][0] = (vec4(-3.0, -9.0, 6.0, -3.0));
	block.var[5][1] = (vec4(-6.0, -1.0, 8.0, 3.0));
	block.var[5][2] = (vec4(-2.0, 9.0, -2.0, -3.0));
	block.var[5][3] = (vec4(-8.0, 3.0, -8.0, 5.0));
	block.var[6][0] = (vec4(7.0, -2.0, -7.0, 3.0));
	block.var[6][1] = (vec4(8.0, -7.0, -6.0, 4.0));
	block.var[6][2] = (vec4(-4.0, 6.0, -2.0, -7.0));
	block.var[6][3] = (vec4(7.0, 8.0, -8.0, -2.0));
	block.var[7][0] = (vec4(-8.0, 3.0, 9.0, 3.0));
	block.var[7][1] = (vec4(1.0, -3.0, -5.0, -8.0));
	block.var[7][2] = (vec4(-7.0, 5.0, -1.0, -6.0));
	block.var[7][3] = (vec4(8.0, -8.0, 4.0, 8.0));
	block.var[8][0] = (vec4(6.0, -5.0, 4.0, -3.0));
	block.var[8][1] = (vec4(-1.0, -8.0, 3.0, 5.0));
	block.var[8][2] = (vec4(0.0, 7.0, 6.0, -4.0));
	block.var[8][3] = (vec4(1.0, 4.0, 3.0, 6.0));
	block.var[9][0] = (vec4(-3.0, -8.0, -6.0, 5.0));
	block.var[9][1] = (vec4(-9.0, -3.0, 0.0, -1.0));
	block.var[9][2] = (vec4(-5.0, 9.0, -8.0, -9.0));
	block.var[9][3] = (vec4(-1.0, 2.0, 5.0, 6.0));
	block.var[10][0] = (vec4(2.0, 3.0, 8.0, 8.0));
	block.var[10][1] = (vec4(-7.0, -1.0, 5.0, -3.0));
	block.var[10][2] = (vec4(5.0, -3.0, -4.0, 6.0));
	block.var[10][3] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[11][0] = (vec4(7.0, -3.0, -8.0, 1.0));
	block.var[11][1] = (vec4(1.0, 2.0, 3.0, 1.0));
	block.var[11][2] = (vec4(5.0, -2.0, 2.0, -2.0));
	block.var[11][3] = (vec4(-9.0, -1.0, 2.0, -1.0));
	block.var[12][0] = (vec4(8.0, -9.0, 9.0, 7.0));
	block.var[12][1] = (vec4(-9.0, 5.0, 1.0, -4.0));
	block.var[12][2] = (vec4(-1.0, -2.0, 1.0, 5.0));
	block.var[12][3] = (vec4(-1.0, -5.0, 7.0, -6.0));
	block.var[13][0] = (vec4(1.0, 0.0, 9.0, -3.0));
	block.var[13][1] = (vec4(7.0, 0.0, -6.0, -7.0));
	block.var[13][2] = (vec4(-8.0, 1.0, -2.0, 9.0));
	block.var[13][3] = (vec4(0.0, -2.0, 6.0, -1.0));
	block.var[14][0] = (vec4(-5.0, -1.0, -3.0, 5.0));
	block.var[14][1] = (vec4(-7.0, 4.0, 5.0, -9.0));
	block.var[14][2] = (vec4(-1.0, 0.0, 8.0, 8.0));
	block.var[14][3] = (vec4(-3.0, 4.0, -4.0, -4.0));
	block.var[15][0] = (vec4(5.0, 8.0, -8.0, -1.0));
	block.var[15][1] = (vec4(-7.0, 8.0, 4.0, -1.0));
	block.var[15][2] = (vec4(-1.0, -9.0, 3.0, 2.0));
	block.var[15][3] = (vec4(4.0, -2.0, 7.0, 5.0));
	block.var[16][0] = (vec4(0.0, -5.0, 2.0, 2.0));
	block.var[16][1] = (vec4(4.0, 4.0, -9.0, 3.0));
	block.var[16][2] = (vec4(1.0, 0.0, 5.0, -8.0));
	block.var[16][3] = (vec4(-3.0, -3.0, 3.0, -6.0));
	block.var[17][0] = (vec4(-5.0, 9.0, 0.0, -6.0));
	block.var[17][1] = (vec4(-2.0, -4.0, 3.0, 1.0));
	block.var[17][2] = (vec4(4.0, 1.0, -3.0, 6.0));
	block.var[17][3] = (vec4(-2.0, -7.0, -7.0, 9.0));
	block.var[18][0] = (vec4(-2.0, -6.0, -2.0, -5.0));
	block.var[18][1] = (vec4(-9.0, 4.0, 4.0, -5.0));
	block.var[18][2] = (vec4(-1.0, -1.0, 0.0, -7.0));
	block.var[18][3] = (vec4(5.0, 7.0, -3.0, -7.0));
}
#version 450
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
	int8_t var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.var[0][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[0][1]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[0][2]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[1][0]), 1) && allOk;
	allOk = compare_int8_t(int(block.var[1][1]), 6) && allOk;
	allOk = compare_int8_t(int(block.var[1][2]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[2][0]), 5) && allOk;
	allOk = compare_int8_t(int(block.var[2][1]), 2) && allOk;
	allOk = compare_int8_t(int(block.var[2][2]), 0) && allOk;
	allOk = compare_int8_t(int(block.var[3][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[3][1]), 4294967287) && allOk;
	allOk = compare_int8_t(int(block.var[3][2]), 4294967289) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = int8_t(4294967290);
	block.var[0][1] = int8_t(4294967294);
	block.var[0][2] = int8_t(3);
	block.var[1][0] = int8_t(4294967288);
	block.var[1][1] = int8_t(1);
	block.var[1][2] = int8_t(2);
	block.var[2][0] = int8_t(4294967288);
	block.var[2][1] = int8_t(4294967294);
	block.var[2][2] = int8_t(7);
	block.var[3][0] = int8_t(9);
	block.var[3][1] = int8_t(0);
	block.var[3][2] = int8_t(4294967292);
}
#version 450
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
	i8vec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(block.var[0][0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][2]), ivec3(7, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][0]), ivec3(5, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][1]), ivec3(9, 0, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][2]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][0]), ivec3(4294967289, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][1]), ivec3(8, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][2]), ivec3(2, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][0]), ivec3(1, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][1]), ivec3(9, 7, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3][2]), ivec3(2, 4294967294, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = i8vec3(ivec3(4294967292, 0, 0));
	block.var[0][1] = i8vec3(ivec3(7, 9, 4294967290));
	block.var[0][2] = i8vec3(ivec3(4294967288, 9, 4294967288));
	block.var[1][0] = i8vec3(ivec3(4294967293, 3, 4294967295));
	block.var[1][1] = i8vec3(ivec3(9, 7, 5));
	block.var[1][2] = i8vec3(ivec3(5, 4294967293, 6));
	block.var[2][0] = i8vec3(ivec3(4294967293, 4294967295, 3));
	block.var[2][1] = i8vec3(ivec3(5, 4294967292, 4294967295));
	block.var[2][2] = i8vec3(ivec3(4294967293, 8, 4294967290));
	block.var[3][0] = i8vec3(ivec3(3, 7, 4));
	block.var[3][1] = i8vec3(ivec3(4294967292, 8, 8));
	block.var[3][2] = i8vec3(ivec3(4294967294, 8, 1));
}
#version 450
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
	highp ivec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((block.var[0][0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((block.var[0][1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((block.var[0][2]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((block.var[1][0]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((block.var[1][1]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((block.var[1][2]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((block.var[2][0]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((block.var[2][1]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((block.var[2][2]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((block.var[3][0]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((block.var[3][1]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((block.var[3][2]), ivec4(-3, 1, 3, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (ivec4(5, -9, 5, -6));
	block.var[0][1] = (ivec4(-2, -4, 1, -9));
	block.var[0][2] = (ivec4(7, 3, 6, 8));
	block.var[1][0] = (ivec4(6, -4, 6, -7));
	block.var[1][1] = (ivec4(9, -8, -9, 0));
	block.var[1][2] = (ivec4(5, -7, 2, 9));
	block.var[2][0] = (ivec4(6, 5, 4, 0));
	block.var[2][1] = (ivec4(5, 9, 0, 0));
	block.var[2][2] = (ivec4(-6, 4, 4, 2));
	block.var[3][0] = (ivec4(9, 7, 5, 5));
	block.var[3][1] = (ivec4(3, -3, -9, -8));
	block.var[3][2] = (ivec4(-6, 3, 2, 0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	block.var[0][1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	block.var[0][2] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
	block.var[1][0] = (mat3x4(-5.0, -5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0));
	block.var[1][1] = (mat3x4(-5.0, 5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0));
	block.var[1][2] = (mat3x4(-9.0, -1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0));
	block.var[2][0] = (mat3x4(-4.0, 2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0));
	block.var[2][1] = (mat3x4(9.0, -2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0));
	block.var[2][2] = (mat3x4(-6.0, 5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0));
	block.var[3][0] = (mat3x4(9.0, 2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0));
	block.var[3][1] = (mat3x4(-1.0, 4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0));
	block.var[3][2] = (mat3x4(-9.0, 1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0));
}
#version 450
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
	uint8_t var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.padding), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][1]), 3u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][1]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][2]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][2]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][1]), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][2]), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint8_t(9u);
	block.var[0][0] = uint8_t(5u);
	block.var[0][1] = uint8_t(2u);
	block.var[0][2] = uint8_t(6u);
	block.var[1][0] = uint8_t(7u);
	block.var[1][1] = uint8_t(5u);
	block.var[1][2] = uint8_t(8u);
	block.var[2][0] = uint8_t(4u);
	block.var[2][1] = uint8_t(2u);
	block.var[2][2] = uint8_t(6u);
	block.var[3][0] = uint8_t(0u);
	block.var[3][1] = uint8_t(1u);
	block.var[3][2] = uint8_t(6u);
}
#version 450
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
	highp uvec4 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((block.var[0][0][0]), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[0][0][1]), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[0][0][2]), uvec4(3u, 6u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[0][1][0]), uvec4(8u, 5u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[0][1][1]), uvec4(3u, 6u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[0][1][2]), uvec4(4u, 0u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((block.var[1][0][0]), uvec4(2u, 3u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((block.var[1][0][1]), uvec4(0u, 7u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((block.var[1][0][2]), uvec4(2u, 8u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[1][1][0]), uvec4(6u, 2u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[1][1][1]), uvec4(5u, 8u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[1][1][2]), uvec4(9u, 8u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((block.var[2][0][0]), uvec4(7u, 3u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[2][0][1]), uvec4(8u, 7u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[2][0][2]), uvec4(5u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[2][1][0]), uvec4(9u, 6u, 7u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[2][1][1]), uvec4(5u, 5u, 7u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[2][1][2]), uvec4(1u, 6u, 5u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[3][0][0]), uvec4(1u, 6u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[3][0][1]), uvec4(7u, 9u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((block.var[3][0][2]), uvec4(5u, 7u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[3][1][0]), uvec4(8u, 0u, 6u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[3][1][1]), uvec4(9u, 4u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((block.var[3][1][2]), uvec4(2u, 3u, 8u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (uvec4(2u, 7u, 2u, 9u));
	block.var[0][0][1] = (uvec4(7u, 9u, 5u, 1u));
	block.var[0][0][2] = (uvec4(3u, 4u, 4u, 2u));
	block.var[0][1][0] = (uvec4(6u, 1u, 9u, 4u));
	block.var[0][1][1] = (uvec4(5u, 7u, 7u, 0u));
	block.var[0][1][2] = (uvec4(2u, 5u, 1u, 3u));
	block.var[1][0][0] = (uvec4(0u, 5u, 6u, 2u));
	block.var[1][0][1] = (uvec4(9u, 5u, 7u, 7u));
	block.var[1][0][2] = (uvec4(0u, 3u, 8u, 1u));
	block.var[1][1][0] = (uvec4(9u, 6u, 1u, 2u));
	block.var[1][1][1] = (uvec4(0u, 0u, 8u, 4u));
	block.var[1][1][2] = (uvec4(9u, 5u, 7u, 1u));
	block.var[2][0][0] = (uvec4(4u, 9u, 1u, 3u));
	block.var[2][0][1] = (uvec4(8u, 8u, 8u, 1u));
	block.var[2][0][2] = (uvec4(7u, 5u, 4u, 8u));
	block.var[2][1][0] = (uvec4(2u, 0u, 0u, 4u));
	block.var[2][1][1] = (uvec4(4u, 2u, 5u, 9u));
	block.var[2][1][2] = (uvec4(6u, 9u, 6u, 2u));
	block.var[3][0][0] = (uvec4(6u, 6u, 0u, 9u));
	block.var[3][0][1] = (uvec4(7u, 2u, 3u, 0u));
	block.var[3][0][2] = (uvec4(4u, 4u, 8u, 5u));
	block.var[3][1][0] = (uvec4(3u, 6u, 1u, 7u));
	block.var[3][1][1] = (uvec4(5u, 6u, 4u, 8u));
	block.var[3][1][2] = (uvec4(6u, 3u, 2u, 5u));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(2.0, -3.0, -1.0, -7.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(1.0, -2.0, -2.0, -2.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(0.0, -1.0, 1.0, 9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(8.0, -7.0, 1.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(4.0, -3.0, -4.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(8.0, 4.0, 1.0, 2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-9.0, 7.0, -7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(7.0, 4.0, 0.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-3.0, 3.0, -7.0, -9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(6.0, 6.0, -8.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-9.0, -8.0, -5.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(-7.0, -9.0, 9.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(7.0, 5.0, -6.0, -4.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-5.0, -3.0, -9.0, 2.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(5.0, 2.0, 7.0, -1.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(8.0, -7.0, 7.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(2.0, -1.0, 5.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-7.0, -5.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(9.0, 7.0, -8.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(-9.0, -8.0, 9.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(7.0, -7.0, -2.0, 2.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-2.0, 8.0));
	block.var[0][0][0][1] = (vec2(1.0, 8.0));
	block.var[0][0][0][2] = (vec2(-7.0, 5.0));
	block.var[0][0][1][0] = (vec2(2.0, 0.0));
	block.var[0][0][1][1] = (vec2(-3.0, 1.0));
	block.var[0][0][1][2] = (vec2(2.0, -5.0));
	block.var[0][0][2][0] = (vec2(6.0, 3.0));
	block.var[0][0][2][1] = (vec2(6.0, 5.0));
	block.var[0][0][2][2] = (vec2(-5.0, 9.0));
	block.var[0][1][0][0] = (vec2(2.0, -2.0));
	block.var[0][1][0][1] = (vec2(-2.0, -8.0));
	block.var[0][1][0][2] = (vec2(7.0, -7.0));
	block.var[0][1][1][0] = (vec2(-1.0, 6.0));
	block.var[0][1][1][1] = (vec2(-8.0, 4.0));
	block.var[0][1][1][2] = (vec2(-5.0, 3.0));
	block.var[0][1][2][0] = (vec2(-9.0, -8.0));
	block.var[0][1][2][1] = (vec2(8.0, -9.0));
	block.var[0][1][2][2] = (vec2(-1.0, 1.0));
	block.var[1][0][0][0] = (vec2(-8.0, 9.0));
	block.var[1][0][0][1] = (vec2(3.0, -3.0));
	block.var[1][0][0][2] = (vec2(3.0, -5.0));
	block.var[1][0][1][0] = (vec2(7.0, -8.0));
	block.var[1][0][1][1] = (vec2(3.0, 1.0));
	block.var[1][0][1][2] = (vec2(-2.0, 1.0));
	block.var[1][0][2][0] = (vec2(4.0, -9.0));
	block.var[1][0][2][1] = (vec2(3.0, 6.0));
	block.var[1][0][2][2] = (vec2(7.0, 1.0));
	block.var[1][1][0][0] = (vec2(0.0, 2.0));
	block.var[1][1][0][1] = (vec2(-1.0, -9.0));
	block.var[1][1][0][2] = (vec2(3.0, 4.0));
	block.var[1][1][1][0] = (vec2(6.0, -1.0));
	block.var[1][1][1][1] = (vec2(-4.0, -4.0));
	block.var[1][1][1][2] = (vec2(0.0, -6.0));
	block.var[1][1][2][0] = (vec2(5.0, -8.0));
	block.var[1][1][2][1] = (vec2(6.0, -8.0));
	block.var[1][1][2][2] = (vec2(-5.0, -8.0));
	block.var[2][0][0][0] = (vec2(9.0, -9.0));
	block.var[2][0][0][1] = (vec2(0.0, -6.0));
	block.var[2][0][0][2] = (vec2(-7.0, 7.0));
	block.var[2][0][1][0] = (vec2(-8.0, 7.0));
	block.var[2][0][1][1] = (vec2(9.0, 6.0));
	block.var[2][0][1][2] = (vec2(-1.0, 0.0));
	block.var[2][0][2][0] = (vec2(-3.0, 6.0));
	block.var[2][0][2][1] = (vec2(-1.0, -6.0));
	block.var[2][0][2][2] = (vec2(-1.0, -3.0));
	block.var[2][1][0][0] = (vec2(4.0, -9.0));
	block.var[2][1][0][1] = (vec2(-4.0, 4.0));
	block.var[2][1][0][2] = (vec2(5.0, 3.0));
	block.var[2][1][1][0] = (vec2(-3.0, -5.0));
	block.var[2][1][1][1] = (vec2(5.0, 1.0));
	block.var[2][1][1][2] = (vec2(3.0, -3.0));
	block.var[2][1][2][0] = (vec2(-1.0, -6.0));
	block.var[2][1][2][1] = (vec2(-6.0, 8.0));
	block.var[2][1][2][2] = (vec2(-3.0, 7.0));
	block.var[3][0][0][0] = (vec2(0.0, -1.0));
	block.var[3][0][0][1] = (vec2(4.0, -9.0));
	block.var[3][0][0][2] = (vec2(1.0, 1.0));
	block.var[3][0][1][0] = (vec2(-9.0, 7.0));
	block.var[3][0][1][1] = (vec2(0.0, 4.0));
	block.var[3][0][1][2] = (vec2(-3.0, -3.0));
	block.var[3][0][2][0] = (vec2(6.0, 8.0));
	block.var[3][0][2][1] = (vec2(-7.0, 5.0));
	block.var[3][0][2][2] = (vec2(-6.0, -5.0));
	block.var[3][1][0][0] = (vec2(-6.0, 6.0));
	block.var[3][1][0][1] = (vec2(6.0, 7.0));
	block.var[3][1][0][2] = (vec2(3.0, -9.0));
	block.var[3][1][1][0] = (vec2(-4.0, -6.0));
	block.var[3][1][1][1] = (vec2(-6.0, 2.0));
	block.var[3][1][1][2] = (vec2(6.0, -3.0));
	block.var[3][1][2][0] = (vec2(-1.0, -9.0));
	block.var[3][1][2][1] = (vec2(8.0, -4.0));
	block.var[3][1][2][2] = (vec2(-9.0, -4.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(5.0, -6.0, -5.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-5.0, -6.0, -8.0, 6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(2.0, -8.0, 9.0, -8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-1.0, 7.0, 3.0, 8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(6.0, -7.0, 7.0, 5.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(9.0, 0.0, 2.0, -5.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(5.0, 0.0, 4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-1.0, -1.0, -2.0, -8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(-8.0, -6.0, 0.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-5.0, 6.0, -3.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(9.0, -6.0, -8.0, -7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-2.0, -1.0, 1.0, 6.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(-1.0, 7.0, -4.0, 3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-5.0, -2.0, 0.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(-7.0, -4.0, 1.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(1.0, -2.0, -2.0, -9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(8.0, 2.0, -1.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(-6.0, 0.0, 6.0, 9.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(-8.0, -7.0, -1.0, -4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(7.0, 9.0, 8.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(8.0, -3.0, 8.0, -5.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(1.0, 8.0, 6.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(2.0, 5.0, 4.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(-7.0, -1.0, -1.0, -7.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	block.var[0][0][1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	block.var[0][0][2] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
	block.var[0][1][0] = (mat3x2(4.0, -9.0, -8.0, 7.0, -5.0, -1.0));
	block.var[0][1][1] = (mat3x2(-7.0, 4.0, -2.0, -6.0, -5.0, 6.0));
	block.var[0][1][2] = (mat3x2(-3.0, -7.0, 9.0, 9.0, -8.0, 0.0));
	block.var[1][0][0] = (mat3x2(0.0, 6.0, -5.0, 4.0, -2.0, 0.0));
	block.var[1][0][1] = (mat3x2(-3.0, -3.0, -2.0, 9.0, -2.0, -7.0));
	block.var[1][0][2] = (mat3x2(-9.0, -2.0, -8.0, 4.0, 3.0, 8.0));
	block.var[1][1][0] = (mat3x2(6.0, -3.0, 9.0, -2.0, -5.0, -4.0));
	block.var[1][1][1] = (mat3x2(-4.0, 6.0, -7.0, 5.0, -1.0, 5.0));
	block.var[1][1][2] = (mat3x2(4.0, -7.0, -3.0, 6.0, -8.0, 2.0));
	block.var[2][0][0] = (mat3x2(7.0, 9.0, -5.0, 9.0, -1.0, 4.0));
	block.var[2][0][1] = (mat3x2(6.0, -4.0, -6.0, 0.0, 7.0, -2.0));
	block.var[2][0][2] = (mat3x2(-1.0, -9.0, 8.0, -6.0, -9.0, 5.0));
	block.var[2][1][0] = (mat3x2(-3.0, -4.0, -7.0, 0.0, 8.0, 4.0));
	block.var[2][1][1] = (mat3x2(-8.0, -5.0, -1.0, -5.0, 2.0, -6.0));
	block.var[2][1][2] = (mat3x2(3.0, 4.0, 5.0, 1.0, -7.0, 1.0));
	block.var[3][0][0] = (mat3x2(2.0, -9.0, 9.0, 4.0, -4.0, 9.0));
	block.var[3][0][1] = (mat3x2(3.0, 3.0, 1.0, -4.0, 0.0, -7.0));
	block.var[3][0][2] = (mat3x2(-4.0, 7.0, 7.0, -1.0, -2.0, 6.0));
	block.var[3][1][0] = (mat3x2(2.0, -7.0, -1.0, -4.0, 8.0, 1.0));
	block.var[3][1][1] = (mat3x2(-8.0, 2.0, 7.0, 8.0, -5.0, -3.0));
	block.var[3][1][2] = (mat3x2(8.0, -6.0, 3.0, -2.0, 7.0, -4.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_mat4(block.var[0][0][0], mat4(-3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0, -2.0, -9.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0, 0.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0, 4.0, 2.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(-3.0, -1.0, -8.0, -7.0, -8.0, 4.0, 2.0, -4.0, -5.0, 1.0, 5.0, 2.0, -9.0, 8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(7.0, 8.0, -4.0, -9.0, -8.0, -4.0, 6.0, 7.0, -4.0, -5.0, -1.0, 4.0, -2.0, -2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(-8.0, 9.0, 4.0, -3.0, -1.0, -3.0, 5.0, -1.0, 3.0, 9.0, 6.0, -5.0, 8.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0, -1.0, 7.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0, 0.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0, -3.0, -4.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-5.0, 5.0, 6.0, 9.0, -7.0, -2.0, 5.0, 7.0, -2.0, 8.0, 1.0, -1.0, 9.0, -8.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(8.0, 6.0, 9.0, 5.0, 3.0, 4.0, -8.0, -4.0, -5.0, 0.0, -6.0, 3.0, 7.0, 1.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(8.0, -4.0, -7.0, 1.0, -3.0, 9.0, -9.0, -1.0, 7.0, -1.0, 9.0, 9.0, 9.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0, -6.0, 6.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0, -3.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(-1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0, -1.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(7.0, 9.0, 6.0, -6.0, 2.0, 8.0, 2.0, 3.0, -8.0, 7.0, 6.0, 0.0, 1.0, -4.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-9.0, 4.0, -7.0, 5.0, 5.0, 3.0, 8.0, -1.0, 6.0, 3.0, 1.0, -9.0, 3.0, -1.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(0.0, -7.0, -5.0, -8.0, 2.0, 0.0, 4.0, 9.0, -3.0, 8.0, -7.0, 7.0, 5.0, 1.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0, -4.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0, 2.0, 5.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(-6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0, -5.0, 3.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-1.0, -9.0, 1.0, -2.0, 4.0, -2.0, 2.0, -5.0, 6.0, -6.0, -8.0, -1.0, -3.0, -9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(-1.0, 8.0, 9.0, 8.0, 5.0, 6.0, -9.0, 1.0, 9.0, 8.0, 6.0, 0.0, 4.0, 9.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(6.0, -4.0, -5.0, -4.0, -9.0, -8.0, 9.0, 4.0, 2.0, 5.0, -8.0, 3.0, 7.0, -9.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0][0][0] = (mat4(7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0, 8.0, 6.0, 5.0, -7.0));
	block.var[0][0][1] = (mat4(2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0, -6.0, -1.0, 8.0, 8.0));
	block.var[0][0][2] = (mat4(9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0, -2.0, 0.0, -2.0, -3.0));
	block.var[0][1][0] = (mat4(5.0, 6.0, -9.0, 8.0, -2.0, -3.0, -2.0, -2.0, -4.0, -1.0, -7.0, -8.0, -5.0, 0.0, -7.0, 6.0));
	block.var[0][1][1] = (mat4(2.0, 4.0, -8.0, -9.0, -9.0, -5.0, -7.0, 1.0, 9.0, 1.0, 5.0, -3.0, 2.0, 6.0, -7.0, 7.0));
	block.var[0][1][2] = (mat4(0.0, -2.0, -3.0, -6.0, -6.0, -6.0, 6.0, -6.0, -6.0, 9.0, 8.0, -5.0, 8.0, 7.0, -3.0, 4.0));
	block.var[1][0][0] = (mat4(-1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0, 1.0, -5.0, 0.0, 4.0));
	block.var[1][0][1] = (mat4(5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0, 7.0, 2.0, 2.0, -6.0));
	block.var[1][0][2] = (mat4(-1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0, 0.0, -6.0, 3.0, 7.0));
	block.var[1][1][0] = (mat4(-4.0, 5.0, -8.0, 5.0, -8.0, 9.0, 3.0, 9.0, 3.0, -3.0, -8.0, -6.0, -4.0, 4.0, 7.0, 2.0));
	block.var[1][1][1] = (mat4(4.0, -1.0, 2.0, 1.0, 2.0, 6.0, -9.0, -1.0, -5.0, -1.0, -7.0, 9.0, 4.0, -9.0, 6.0, 6.0));
	block.var[1][1][2] = (mat4(6.0, 8.0, -3.0, -9.0, 7.0, 6.0, -5.0, 9.0, -5.0, 0.0, -9.0, 3.0, -6.0, -2.0, -7.0, -6.0));
	block.var[2][0][0] = (mat4(3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0, 9.0, -3.0, -6.0, 3.0));
	block.var[2][0][1] = (mat4(-1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0, -3.0, 1.0, 4.0, -6.0));
	block.var[2][0][2] = (mat4(-4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0, -5.0, 3.0, -8.0, -5.0));
	block.var[2][1][0] = (mat4(6.0, 8.0, -4.0, 1.0, -6.0, 4.0, -2.0, 2.0, -3.0, -4.0, 3.0, -5.0, -4.0, 9.0, 8.0, 2.0));
	block.var[2][1][1] = (mat4(2.0, -1.0, 9.0, 2.0, 9.0, -4.0, 4.0, -1.0, -3.0, -4.0, 0.0, -3.0, 9.0, -7.0, -6.0, 8.0));
	block.var[2][1][2] = (mat4(9.0, -8.0, -2.0, -9.0, -5.0, -3.0, 0.0, 0.0, 1.0, 1.0, -4.0, 4.0, -4.0, -1.0, -5.0, -9.0));
	block.var[3][0][0] = (mat4(-7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0, 2.0, 1.0, 1.0, -4.0));
	block.var[3][0][1] = (mat4(4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0, -3.0, 2.0, -2.0, 6.0));
	block.var[3][0][2] = (mat4(-1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0, -9.0, 7.0, 7.0, 4.0));
	block.var[3][1][0] = (mat4(2.0, -6.0, -1.0, 5.0, -4.0, -6.0, -8.0, 7.0, 4.0, -2.0, -4.0, -1.0, -9.0, 4.0, 8.0, 1.0));
	block.var[3][1][1] = (mat4(5.0, 9.0, 3.0, -9.0, -6.0, -4.0, 4.0, 7.0, 6.0, -1.0, -7.0, -5.0, 7.0, 5.0, 2.0, 0.0));
	block.var[3][1][2] = (mat4(3.0, -1.0, 9.0, -1.0, 3.0, 3.0, 5.0, 7.0, 7.0, -8.0, -9.0, -5.0, 9.0, 4.0, 7.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-6.0, 5.0, -5.0, 8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(3.0, 9.0, -4.0, 0.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(5.0, 5.0, -9.0, 2.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-9.0, 2.0, -9.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-1.0, 0.0, -6.0, 8.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(0.0, 4.0, 4.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(4.0, 4.0, -4.0, -1.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(-7.0, -1.0, 6.0, 8.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(-8.0, 9.0, 5.0, 9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(-7.0, -4.0, 1.0, -1.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-5.0, -8.0, 1.0, 6.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(2.0, -2.0, -7.0, 1.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-2.0, 6.0, 6.0, 9.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(3.0, 0.0, 3.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(-8.0, 9.0, -3.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(6.0, 6.0, 0.0, -9.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(7.0, 3.0, 6.0, 1.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(9.0, -9.0, 4.0, 2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(-8.0, 9.0, 2.0, -9.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(-9.0, -4.0, -1.0, -1.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(-5.0, 9.0, -8.0, -1.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(0.0, 0.0, -5.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(5.0, 9.0, 4.0, 8.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(3.0, -2.0, 2.0, -1.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0][0][0] = (mat2x3(-1.0, 8.0, -5.0, -3.0, 4.0, -4.0));
	block.var[0][0][1] = (mat2x3(1.0, -5.0, 6.0, -8.0, -3.0, 0.0));
	block.var[0][0][2] = (mat2x3(2.0, -1.0, -7.0, 4.0, 6.0, 6.0));
	block.var[0][1][0] = (mat2x3(3.0, 8.0, -7.0, -7.0, 4.0, -1.0));
	block.var[0][1][1] = (mat2x3(6.0, -5.0, 4.0, -2.0, 2.0, -8.0));
	block.var[0][1][2] = (mat2x3(7.0, -5.0, -1.0, 0.0, -4.0, 4.0));
	block.var[1][0][0] = (mat2x3(-3.0, 0.0, 5.0, 9.0, 2.0, -9.0));
	block.var[1][0][1] = (mat2x3(9.0, -7.0, 2.0, 6.0, -3.0, 8.0));
	block.var[1][0][2] = (mat2x3(-9.0, 7.0, -1.0, -3.0, 7.0, -4.0));
	block.var[1][1][0] = (mat2x3(-4.0, 7.0, 8.0, -6.0, -1.0, -1.0));
	block.var[1][1][1] = (mat2x3(-3.0, -5.0, 8.0, 4.0, -9.0, 5.0));
	block.var[1][1][2] = (mat2x3(8.0, 6.0, 4.0, -4.0, -4.0, -9.0));
	block.var[2][0][0] = (mat2x3(-1.0, -5.0, 7.0, -3.0, -6.0, 1.0));
	block.var[2][0][1] = (mat2x3(3.0, 3.0, 1.0, 9.0, -7.0, -4.0));
	block.var[2][0][2] = (mat2x3(-1.0, -4.0, 1.0, -9.0, 4.0, -7.0));
	block.var[2][1][0] = (mat2x3(3.0, 6.0, -8.0, -9.0, 0.0, -7.0));
	block.var[2][1][1] = (mat2x3(-6.0, -7.0, -9.0, -4.0, 3.0, -9.0));
	block.var[2][1][2] = (mat2x3(7.0, 8.0, -9.0, 8.0, -8.0, 0.0));
	block.var[3][0][0] = (mat2x3(-6.0, -1.0, -1.0, 0.0, -4.0, 5.0));
	block.var[3][0][1] = (mat2x3(-6.0, -9.0, -6.0, -5.0, 0.0, -2.0));
	block.var[3][0][2] = (mat2x3(-6.0, 3.0, -3.0, -1.0, -6.0, -1.0));
	block.var[3][1][0] = (mat2x3(3.0, 8.0, -4.0, -8.0, -9.0, 6.0));
	block.var[3][1][1] = (mat2x3(5.0, 7.0, -4.0, -9.0, -1.0, 0.0));
	block.var[3][1][2] = (mat2x3(-2.0, -6.0, -1.0, -7.0, -9.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-7.0, 8.0, 7.0, -6.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(-2.0, 1.0, -7.0, -8.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(7.0, 2.0, -2.0, -3.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-5.0, -4.0, 2.0, -8.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(2.0, 2.0, 4.0, 1.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(-4.0, -2.0, -2.0, -2.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(5.0, 9.0, -2.0, -6.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(7.0, 9.0, 5.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(4.0, -6.0, -4.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(-2.0, -1.0, 3.0, 0.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-7.0, -9.0, -5.0, 1.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(5.0, 6.0, -4.0, -6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(9.0, 8.0, -5.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(-3.0, -8.0, 0.0, -2.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(9.0, 4.0, -4.0, -7.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-4.0, 0.0, -8.0, 6.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(3.0, 6.0, 5.0, 8.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(3.0, -2.0, 7.0, 1.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(-8.0, 0.0, -2.0, 3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(2.0, 2.0, 8.0, 5.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(9.0, -3.0, -8.0, 0.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(7.0, 6.0, 0.0, -4.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(-8.0, 4.0, -4.0, 4.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(-6.0, 5.0, -2.0, -8.0, -1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0][0][0] = (mat2x3(6.0, 9.0, 9.0, -8.0, 7.0, 5.0));
	block.var[0][0][1] = (mat2x3(-1.0, -9.0, 0.0, 8.0, 1.0, -7.0));
	block.var[0][0][2] = (mat2x3(2.0, 4.0, -8.0, 4.0, 4.0, -4.0));
	block.var[0][1][0] = (mat2x3(0.0, -8.0, 1.0, -2.0, -5.0, 6.0));
	block.var[0][1][1] = (mat2x3(6.0, 2.0, 0.0, 4.0, -7.0, 1.0));
	block.var[0][1][2] = (mat2x3(-6.0, 8.0, 1.0, -5.0, 1.0, -7.0));
	block.var[1][0][0] = (mat2x3(3.0, 7.0, -5.0, -6.0, 7.0, 3.0));
	block.var[1][0][1] = (mat2x3(8.0, -7.0, -7.0, -6.0, 2.0, -8.0));
	block.var[1][0][2] = (mat2x3(8.0, -7.0, -2.0, 5.0, 7.0, 4.0));
	block.var[1][1][0] = (mat2x3(-4.0, -4.0, -5.0, 3.0, 3.0, 1.0));
	block.var[1][1][1] = (mat2x3(0.0, 9.0, 1.0, -8.0, -1.0, 9.0));
	block.var[1][1][2] = (mat2x3(5.0, -3.0, -9.0, -8.0, 3.0, -1.0));
	block.var[2][0][0] = (mat2x3(-7.0, -7.0, 6.0, -8.0, -8.0, 7.0));
	block.var[2][0][1] = (mat2x3(-8.0, 4.0, 7.0, 0.0, 3.0, 9.0));
	block.var[2][0][2] = (mat2x3(4.0, 7.0, 4.0, -7.0, 6.0, 1.0));
	block.var[2][1][0] = (mat2x3(6.0, -1.0, 2.0, -2.0, -5.0, -9.0));
	block.var[2][1][1] = (mat2x3(4.0, -7.0, -5.0, -1.0, -3.0, -4.0));
	block.var[2][1][2] = (mat2x3(1.0, -4.0, 7.0, 3.0, 7.0, 2.0));
	block.var[3][0][0] = (mat2x3(3.0, 2.0, -1.0, -8.0, -8.0, 2.0));
	block.var[3][0][1] = (mat2x3(9.0, -3.0, -1.0, -2.0, -1.0, -1.0));
	block.var[3][0][2] = (mat2x3(8.0, 1.0, -6.0, -9.0, -3.0, -1.0));
	block.var[3][1][0] = (mat2x3(-9.0, -2.0, -7.0, 2.0, -7.0, -4.0));
	block.var[3][1][1] = (mat2x3(-8.0, 9.0, 3.0, -1.0, 7.0, -9.0));
	block.var[3][1][2] = (mat2x3(4.0, -2.0, -8.0, 3.0, 0.0, 7.0));
}
#version 450
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
	int16_t var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.padding), -5) && allOk;
	allOk = compare_int16_t(int(block.var[0][0][0]), 1) && allOk;
	allOk = compare_int16_t(int(block.var[0][0][1]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[0][0][2]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[0][1][0]), 5) && allOk;
	allOk = compare_int16_t(int(block.var[0][1][1]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[0][1][2]), -3) && allOk;
	allOk = compare_int16_t(int(block.var[1][0][0]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[1][0][1]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[1][0][2]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[1][1][0]), -1) && allOk;
	allOk = compare_int16_t(int(block.var[1][1][1]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[1][1][2]), 1) && allOk;
	allOk = compare_int16_t(int(block.var[2][0][0]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[2][0][1]), 3) && allOk;
	allOk = compare_int16_t(int(block.var[2][0][2]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[2][1][0]), -9) && allOk;
	allOk = compare_int16_t(int(block.var[2][1][1]), -7) && allOk;
	allOk = compare_int16_t(int(block.var[2][1][2]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[3][0][0]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[3][0][1]), -7) && allOk;
	allOk = compare_int16_t(int(block.var[3][0][2]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[3][1][0]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[3][1][1]), 0) && allOk;
	allOk = compare_int16_t(int(block.var[3][1][2]), 5) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int16_t(6);
	block.var[0][0][0] = int16_t(8);
	block.var[0][0][1] = int16_t(-2);
	block.var[0][0][2] = int16_t(-4);
	block.var[0][1][0] = int16_t(9);
	block.var[0][1][1] = int16_t(6);
	block.var[0][1][2] = int16_t(2);
	block.var[1][0][0] = int16_t(-3);
	block.var[1][0][1] = int16_t(9);
	block.var[1][0][2] = int16_t(-5);
	block.var[1][1][0] = int16_t(3);
	block.var[1][1][1] = int16_t(7);
	block.var[1][1][2] = int16_t(7);
	block.var[2][0][0] = int16_t(-8);
	block.var[2][0][1] = int16_t(-3);
	block.var[2][0][2] = int16_t(2);
	block.var[2][1][0] = int16_t(7);
	block.var[2][1][1] = int16_t(1);
	block.var[2][1][2] = int16_t(-9);
	block.var[3][0][0] = int16_t(-1);
	block.var[3][0][1] = int16_t(4);
	block.var[3][0][2] = int16_t(3);
	block.var[3][1][0] = int16_t(-3);
	block.var[3][1][1] = int16_t(0);
	block.var[3][1][2] = int16_t(-9);
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(-8.0, 1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-9.0, 9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(8.0, 5.0, 9.0, 6.0, -3.0, 4.0, 6.0, -8.0, -9.0, -2.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(1.0, 7.0, -6.0, 3.0, 2.0, 9.0, -9.0, 1.0, 0.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(-8.0, -4.0, 5.0, -8.0, -2.0, -1.0, -3.0, 5.0, 7.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(0.0, 0.0, -6.0, 6.0, -6.0, -9.0, 8.0, 2.0, 6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-5.0, 7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-5.0, -8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(8.0, 4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(1.0, 0.0, 9.0, -2.0, -2.0, 1.0, 8.0, 0.0, 0.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(9.0, -5.0, 2.0, 8.0, -5.0, -3.0, -6.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(-2.0, 4.0, -9.0, -3.0, -4.0, 1.0, -6.0, -1.0, -7.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(-5.0, -5.0, 3.0, 2.0, 1.0, -9.0, 5.0, -2.0, -9.0, 4.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-9.0, 6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-9.0, 7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(7.0, -3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(9.0, 2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(2.0, 0.0, -2.0, -7.0, 6.0, -9.0, 9.0, -6.0, 3.0, -2.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(-5.0, 4.0, 0.0, 2.0, 9.0, 7.0, -3.0, 3.0, 5.0, 2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-2.0, 4.0, -7.0, -4.0, 3.0, 6.0, 0.0, -2.0, -7.0, 2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(-8.0, 6.0, -6.0, 2.0, 7.0, 0.0, 4.0, -6.0, 5.0, 3.0, -8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	block.var[0][0][0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	block.var[0][0][0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	block.var[0][0][1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	block.var[0][0][1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	block.var[0][0][1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	block.var[0][1][0][0] = (vec4(-3.0, -3.0, 3.0, -7.0));
	block.var[0][1][0][1] = (vec4(2.0, 8.0, -4.0, 1.0));
	block.var[0][1][0][2] = (vec4(-1.0, 6.0, -4.0, 7.0));
	block.var[0][1][1][0] = (vec4(5.0, -8.0, -2.0, 6.0));
	block.var[0][1][1][1] = (vec4(-2.0, 8.0, -2.0, 2.0));
	block.var[0][1][1][2] = (vec4(3.0, 7.0, 0.0, 2.0));
	block.var[0][2][0][0] = (vec4(0.0, 7.0, 3.0, -7.0));
	block.var[0][2][0][1] = (vec4(-7.0, 7.0, -4.0, -5.0));
	block.var[0][2][0][2] = (vec4(-8.0, -8.0, -7.0, 4.0));
	block.var[0][2][1][0] = (vec4(6.0, -3.0, 8.0, -1.0));
	block.var[0][2][1][1] = (vec4(-4.0, 8.0, 8.0, 1.0));
	block.var[0][2][1][2] = (vec4(-8.0, -7.0, 5.0, -9.0));
	block.var[0][3][0][0] = (vec4(3.0, 0.0, -5.0, -4.0));
	block.var[0][3][0][1] = (vec4(-9.0, -4.0, 0.0, -5.0));
	block.var[0][3][0][2] = (vec4(-9.0, -9.0, 6.0, -4.0));
	block.var[0][3][1][0] = (vec4(-7.0, 0.0, 8.0, -6.0));
	block.var[0][3][1][1] = (vec4(-3.0, 8.0, 9.0, 3.0));
	block.var[0][3][1][2] = (vec4(7.0, -2.0, -6.0, -6.0));
	block.var[1][0][0][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	block.var[1][0][0][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	block.var[1][0][0][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
	block.var[1][0][1][0] = (vec4(8.0, -2.0, 1.0, 1.0));
	block.var[1][0][1][1] = (vec4(-6.0, -1.0, -9.0, 6.0));
	block.var[1][0][1][2] = (vec4(7.0, -1.0, 1.0, -8.0));
	block.var[1][1][0][0] = (vec4(3.0, 9.0, 8.0, 5.0));
	block.var[1][1][0][1] = (vec4(2.0, -3.0, -7.0, 2.0));
	block.var[1][1][0][2] = (vec4(-1.0, 1.0, -4.0, -1.0));
	block.var[1][1][1][0] = (vec4(-6.0, -4.0, -1.0, -3.0));
	block.var[1][1][1][1] = (vec4(-8.0, 5.0, -4.0, -9.0));
	block.var[1][1][1][2] = (vec4(8.0, 3.0, -8.0, 0.0));
	block.var[1][2][0][0] = (vec4(1.0, -8.0, 2.0, -2.0));
	block.var[1][2][0][1] = (vec4(-8.0, -9.0, 1.0, -3.0));
	block.var[1][2][0][2] = (vec4(-4.0, 3.0, -9.0, 6.0));
	block.var[1][2][1][0] = (vec4(-8.0, 3.0, -5.0, 6.0));
	block.var[1][2][1][1] = (vec4(9.0, 2.0, -1.0, 8.0));
	block.var[1][2][1][2] = (vec4(-2.0, 5.0, -2.0, 6.0));
	block.var[1][3][0][0] = (vec4(6.0, -9.0, 2.0, 0.0));
	block.var[1][3][0][1] = (vec4(9.0, 5.0, 5.0, 7.0));
	block.var[1][3][0][2] = (vec4(8.0, 2.0, 1.0, -1.0));
	block.var[1][3][1][0] = (vec4(-4.0, 6.0, -3.0, 4.0));
	block.var[1][3][1][1] = (vec4(9.0, 0.0, -2.0, -7.0));
	block.var[1][3][1][2] = (vec4(4.0, 7.0, 8.0, 6.0));
	block.var[2][0][0][0] = (vec4(6.0, 8.0, -2.0, 7.0));
	block.var[2][0][0][1] = (vec4(1.0, -6.0, -3.0, 9.0));
	block.var[2][0][0][2] = (vec4(1.0, -6.0, 1.0, -6.0));
	block.var[2][0][1][0] = (vec4(3.0, -1.0, 5.0, -2.0));
	block.var[2][0][1][1] = (vec4(7.0, -1.0, -2.0, -3.0));
	block.var[2][0][1][2] = (vec4(-6.0, 4.0, -4.0, -1.0));
	block.var[2][1][0][0] = (vec4(7.0, -2.0, 0.0, 8.0));
	block.var[2][1][0][1] = (vec4(-9.0, 2.0, -3.0, -7.0));
	block.var[2][1][0][2] = (vec4(-5.0, 3.0, 9.0, -6.0));
	block.var[2][1][1][0] = (vec4(-7.0, -8.0, -8.0, -7.0));
	block.var[2][1][1][1] = (vec4(-9.0, 2.0, 4.0, -7.0));
	block.var[2][1][1][2] = (vec4(8.0, -7.0, 4.0, -8.0));
	block.var[2][2][0][0] = (vec4(1.0, 2.0, 8.0, -3.0));
	block.var[2][2][0][1] = (vec4(6.0, -3.0, -8.0, 2.0));
	block.var[2][2][0][2] = (vec4(-6.0, -8.0, 3.0, 3.0));
	block.var[2][2][1][0] = (vec4(0.0, 9.0, 4.0, -8.0));
	block.var[2][2][1][1] = (vec4(-7.0, 6.0, -4.0, -8.0));
	block.var[2][2][1][2] = (vec4(2.0, 9.0, 1.0, 0.0));
	block.var[2][3][0][0] = (vec4(-1.0, -3.0, 7.0, 5.0));
	block.var[2][3][0][1] = (vec4(-4.0, -6.0, 0.0, -2.0));
	block.var[2][3][0][2] = (vec4(-6.0, 2.0, 3.0, 4.0));
	block.var[2][3][1][0] = (vec4(-6.0, -1.0, 1.0, -2.0));
	block.var[2][3][1][1] = (vec4(2.0, -6.0, -2.0, 3.0));
	block.var[2][3][1][2] = (vec4(-8.0, 4.0, -4.0, 7.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(7.0, -9.0, 0.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(5.0, 3.0, 9.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(1.0, -3.0, -1.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(-2.0, 8.0, 1.0, 6.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(-3.0, -8.0, -3.0, 7.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(9.0, 0.0, 2.0, 6.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(-6.0, 8.0, -3.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(5.0, -3.0, 6.0, 8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(9.0, 5.0, 6.0, 7.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(2.0, 5.0, 0.0, -6.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(9.0, 7.0, -7.0, 4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(4.0, 6.0, 0.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(9.0, 6.0, -6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(6.0, -2.0, -7.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(7.0, -3.0, 2.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(1.0, 9.0, 5.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(1.0, 6.0, -5.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(3.0, 7.0, 0.0, -3.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(9.0, 5.0, -9.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(9.0, 2.0, -4.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(7.0, -7.0, 9.0, 2.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(0.0, 5.0, 5.0));
	block.var[0][0][0][1] = (vec3(0.0, -7.0, 8.0));
	block.var[0][0][1][0] = (vec3(-7.0, -4.0, 6.0));
	block.var[0][0][1][1] = (vec3(1.0, 3.0, 2.0));
	block.var[0][1][0][0] = (vec3(4.0, -1.0, 7.0));
	block.var[0][1][0][1] = (vec3(9.0, -2.0, -4.0));
	block.var[0][1][1][0] = (vec3(8.0, -4.0, 2.0));
	block.var[0][1][1][1] = (vec3(5.0, -1.0, -3.0));
	block.var[0][2][0][0] = (vec3(8.0, 7.0, -1.0));
	block.var[0][2][0][1] = (vec3(-6.0, 1.0, -2.0));
	block.var[0][2][1][0] = (vec3(8.0, -6.0, -8.0));
	block.var[0][2][1][1] = (vec3(9.0, -5.0, 5.0));
	block.var[0][3][0][0] = (vec3(5.0, -5.0, 1.0));
	block.var[0][3][0][1] = (vec3(9.0, 2.0, -6.0));
	block.var[0][3][1][0] = (vec3(-1.0, -6.0, 5.0));
	block.var[0][3][1][1] = (vec3(8.0, -5.0, -8.0));
	block.var[1][0][0][0] = (vec3(-6.0, 5.0, 2.0));
	block.var[1][0][0][1] = (vec3(1.0, 8.0, -8.0));
	block.var[1][0][1][0] = (vec3(2.0, -7.0, 5.0));
	block.var[1][0][1][1] = (vec3(-4.0, -6.0, -9.0));
	block.var[1][1][0][0] = (vec3(3.0, -2.0, -8.0));
	block.var[1][1][0][1] = (vec3(6.0, 0.0, 9.0));
	block.var[1][1][1][0] = (vec3(1.0, -5.0, -1.0));
	block.var[1][1][1][1] = (vec3(-6.0, -6.0, 3.0));
	block.var[1][2][0][0] = (vec3(-8.0, 1.0, -3.0));
	block.var[1][2][0][1] = (vec3(-4.0, -5.0, 1.0));
	block.var[1][2][1][0] = (vec3(4.0, -2.0, -5.0));
	block.var[1][2][1][1] = (vec3(-9.0, -8.0, -5.0));
	block.var[1][3][0][0] = (vec3(-6.0, -6.0, 5.0));
	block.var[1][3][0][1] = (vec3(-4.0, 8.0, -9.0));
	block.var[1][3][1][0] = (vec3(0.0, 5.0, -4.0));
	block.var[1][3][1][1] = (vec3(5.0, 2.0, 5.0));
	block.var[2][0][0][0] = (vec3(3.0, 0.0, -7.0));
	block.var[2][0][0][1] = (vec3(2.0, -4.0, 1.0));
	block.var[2][0][1][0] = (vec3(-2.0, -2.0, -5.0));
	block.var[2][0][1][1] = (vec3(2.0, 5.0, 4.0));
	block.var[2][1][0][0] = (vec3(1.0, -8.0, -5.0));
	block.var[2][1][0][1] = (vec3(8.0, 5.0, 8.0));
	block.var[2][1][1][0] = (vec3(5.0, 5.0, 7.0));
	block.var[2][1][1][1] = (vec3(-9.0, 8.0, 0.0));
	block.var[2][2][0][0] = (vec3(5.0, 9.0, 6.0));
	block.var[2][2][0][1] = (vec3(7.0, 5.0, 7.0));
	block.var[2][2][1][0] = (vec3(0.0, 9.0, -4.0));
	block.var[2][2][1][1] = (vec3(7.0, -3.0, 7.0));
	block.var[2][3][0][0] = (vec3(-4.0, 5.0, 5.0));
	block.var[2][3][0][1] = (vec3(-4.0, 4.0, 8.0));
	block.var[2][3][1][0] = (vec3(2.0, 8.0, 3.0));
	block.var[2][3][1][1] = (vec3(-1.0, -1.0, 6.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(-2.0, -6.0, 4.0, 4.0, 5.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(-3.0, 4.0, 3.0, -2.0, -5.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(1.0, -7.0, -5.0, 9.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(-7.0, 7.0, 2.0, 7.0, -3.0, -8.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-3.0, 4.0, -5.0, -8.0, 5.0, -3.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(3.0, 4.0, -7.0, 4.0, -9.0, 4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(-4.0, -2.0, 8.0, 3.0, -2.0, 8.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(1.0, -7.0, -1.0, 4.0, 4.0, -5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(-7.0, 4.0, -9.0, -9.0, -6.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(-6.0, 6.0, -7.0, -6.0, -7.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(-2.0, 0.0, -5.0, -8.0, -4.0, -9.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(1.0, 9.0, -1.0, 7.0, -9.0, -1.0, -4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	block.var[0][0][1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	block.var[0][1][0] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	block.var[0][1][1] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	block.var[0][2][0] = (mat4x2(4.0, 9.0, -8.0, 5.0, 3.0, 3.0, -4.0, 8.0));
	block.var[0][2][1] = (mat4x2(-7.0, 2.0, 2.0, -4.0, 6.0, -1.0, 1.0, 1.0));
	block.var[0][3][0] = (mat4x2(8.0, -7.0, 4.0, 5.0, -8.0, -6.0, -7.0, 1.0));
	block.var[0][3][1] = (mat4x2(1.0, 6.0, -8.0, -5.0, -6.0, 2.0, -9.0, 0.0));
	block.var[1][0][0] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	block.var[1][0][1] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	block.var[1][1][0] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	block.var[1][1][1] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	block.var[1][2][0] = (mat4x2(-9.0, 7.0, 9.0, -1.0, 3.0, -9.0, 2.0, -2.0));
	block.var[1][2][1] = (mat4x2(4.0, 1.0, 2.0, 3.0, 5.0, -3.0, -8.0, -1.0));
	block.var[1][3][0] = (mat4x2(-6.0, 4.0, 2.0, 8.0, 2.0, 4.0, -9.0, 9.0));
	block.var[1][3][1] = (mat4x2(5.0, -4.0, 5.0, 4.0, -8.0, -6.0, 4.0, 0.0));
	block.var[2][0][0] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	block.var[2][0][1] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	block.var[2][1][0] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	block.var[2][1][1] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
	block.var[2][2][0] = (mat4x2(2.0, 6.0, -3.0, 8.0, 3.0, -4.0, 8.0, 5.0));
	block.var[2][2][1] = (mat4x2(-4.0, 6.0, 7.0, -3.0, 1.0, 9.0, 7.0, 4.0));
	block.var[2][3][0] = (mat4x2(7.0, -2.0, 3.0, -5.0, -4.0, 1.0, -3.0, 6.0));
	block.var[2][3][1] = (mat4x2(-3.0, -1.0, 4.0, -1.0, -1.0, -7.0, -7.0, 6.0));
}
#version 450
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
	highp ivec4 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((block.var[0][0][0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((block.var[0][0][1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((block.var[0][1][0]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((block.var[0][1][1]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((block.var[0][2][0]), ivec4(-7, 2, 6, -5)) && allOk;
	allOk = compare_ivec4((block.var[0][2][1]), ivec4(1, 5, 7, 9)) && allOk;
	allOk = compare_ivec4((block.var[0][3][0]), ivec4(8, -5, 1, -2)) && allOk;
	allOk = compare_ivec4((block.var[0][3][1]), ivec4(2, 9, -9, -7)) && allOk;
	allOk = compare_ivec4((block.var[1][0][0]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((block.var[1][0][1]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((block.var[1][1][0]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((block.var[1][1][1]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((block.var[1][2][0]), ivec4(-6, 4, 0, 9)) && allOk;
	allOk = compare_ivec4((block.var[1][2][1]), ivec4(-3, 6, -6, -6)) && allOk;
	allOk = compare_ivec4((block.var[1][3][0]), ivec4(-5, -2, 6, 4)) && allOk;
	allOk = compare_ivec4((block.var[1][3][1]), ivec4(-1, 1, 1, 5)) && allOk;
	allOk = compare_ivec4((block.var[2][0][0]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((block.var[2][0][1]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((block.var[2][1][0]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((block.var[2][1][1]), ivec4(-3, 1, 3, 1)) && allOk;
	allOk = compare_ivec4((block.var[2][2][0]), ivec4(1, -6, -3, 5)) && allOk;
	allOk = compare_ivec4((block.var[2][2][1]), ivec4(9, -7, -1, -9)) && allOk;
	allOk = compare_ivec4((block.var[2][3][0]), ivec4(1, -9, 2, -2)) && allOk;
	allOk = compare_ivec4((block.var[2][3][1]), ivec4(-5, -8, 8, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (ivec4(5, -9, 5, -6));
	block.var[0][0][1] = (ivec4(-2, -4, 1, -9));
	block.var[0][1][0] = (ivec4(6, 5, 4, 0));
	block.var[0][1][1] = (ivec4(5, 9, 0, 0));
	block.var[0][2][0] = (ivec4(7, 1, -4, 4));
	block.var[0][2][1] = (ivec4(-2, 5, -8, 0));
	block.var[0][3][0] = (ivec4(6, 8, -7, -2));
	block.var[0][3][1] = (ivec4(9, -9, -5, -6));
	block.var[1][0][0] = (ivec4(7, 3, 6, 8));
	block.var[1][0][1] = (ivec4(6, -4, 6, -7));
	block.var[1][1][0] = (ivec4(-6, 4, 4, 2));
	block.var[1][1][1] = (ivec4(9, 7, 5, 5));
	block.var[1][2][0] = (ivec4(8, -9, -8, -3));
	block.var[1][2][1] = (ivec4(3, -9, -5, -4));
	block.var[1][3][0] = (ivec4(-5, -7, -9, -3));
	block.var[1][3][1] = (ivec4(-2, -1, -9, 9));
	block.var[2][0][0] = (ivec4(9, -8, -9, 0));
	block.var[2][0][1] = (ivec4(5, -7, 2, 9));
	block.var[2][1][0] = (ivec4(3, -3, -9, -8));
	block.var[2][1][1] = (ivec4(-6, 3, 2, 0));
	block.var[2][2][0] = (ivec4(-8, 8, -3, 2));
	block.var[2][2][1] = (ivec4(-2, -6, 4, -5));
	block.var[2][3][0] = (ivec4(-5, 1, 9, -8));
	block.var[2][3][1] = (ivec4(0, 5, -8, -8));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(5.0, 9.0, -5.0, -4.0, 8.0, 3.0, -4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(5.0, 6.0, -6.0, -5.0, 4.0, 8.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(2.0, -7.0, 1.0, -7.0, -9.0, 5.0, 3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(4.0, -6.0, -5.0, -8.0, 3.0, -6.0, 3.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(-6.0, 8.0, 9.0, 6.0, -6.0, -2.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(-4.0, -8.0, -2.0, -5.0, -4.0, 2.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(-6.0, 0.0, 3.0, 6.0, -8.0, 1.0, -6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(3.0, -6.0, -3.0, -4.0, 8.0, 1.0, -8.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(-3.0, 9.0, 1.0, -4.0, -5.0, -5.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(6.0, -5.0, -2.0, 1.0, -4.0, 8.0, 3.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(-3.0, 1.0, -5.0, 4.0, -6.0, 6.0, 1.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(5.0, 0.0, 0.0, -4.0, 5.0, -5.0, 4.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	block.var[0][0][1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	block.var[0][1][0] = (mat3(3.0, 5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0));
	block.var[0][1][1] = (mat3(0.0, -4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0));
	block.var[0][2][0] = (mat3(-1.0, -3.0, 0.0, -4.0, -7.0, -5.0, 9.0, -1.0, -7.0));
	block.var[0][2][1] = (mat3(5.0, -8.0, 9.0, -7.0, 9.0, -8.0, -5.0, 9.0, 2.0));
	block.var[0][3][0] = (mat3(-6.0, -1.0, 0.0, -3.0, 8.0, -1.0, 6.0, 0.0, -6.0));
	block.var[0][3][1] = (mat3(9.0, 2.0, 4.0, 2.0, 8.0, -1.0, 0.0, -8.0, -9.0));
	block.var[1][0][0] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
	block.var[1][0][1] = (mat3(2.0, 1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0));
	block.var[1][1][0] = (mat3(9.0, 7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0));
	block.var[1][1][1] = (mat3(-6.0, -7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0));
	block.var[1][2][0] = (mat3(1.0, 9.0, -9.0, -1.0, 3.0, -5.0, -4.0, -9.0, -8.0));
	block.var[1][2][1] = (mat3(-9.0, 2.0, -4.0, -6.0, -2.0, 6.0, 4.0, 3.0, 0.0));
	block.var[1][3][0] = (mat3(-3.0, -9.0, 2.0, -3.0, 0.0, -5.0, -7.0, 7.0, -2.0));
	block.var[1][3][1] = (mat3(-8.0, 6.0, -6.0, 7.0, -9.0, -1.0, -7.0, 3.0, -2.0));
	block.var[2][0][0] = (mat3(-6.0, -8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0));
	block.var[2][0][1] = (mat3(2.0, -3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0));
	block.var[2][1][0] = (mat3(2.0, 4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0));
	block.var[2][1][1] = (mat3(-8.0, 3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0));
	block.var[2][2][0] = (mat3(-1.0, -8.0, -2.0, -5.0, 5.0, -8.0, -3.0, 4.0, -4.0));
	block.var[2][2][1] = (mat3(-5.0, 2.0, 5.0, 6.0, 7.0, 9.0, 1.0, -2.0, -9.0));
	block.var[2][3][0] = (mat3(6.0, -4.0, 4.0, 1.0, -6.0, -5.0, 0.0, 0.0, -2.0));
	block.var[2][3][1] = (mat3(2.0, -2.0, 2.0, 5.0, 1.0, -4.0, 3.0, 5.0, -2.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-5, 6, -9)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(7.0, 0.0, -9.0, 5.0, 4.0, -3.0, -2.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(0.0, -9.0, -6.0, -1.0, 8.0, -2.0, -1.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(4.0, 2.0, -4.0, 4.0, 7.0, -6.0, -1.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(2.0, 8.0, 8.0, -9.0, 0.0, 7.0, 3.0, 5.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(1.0, -9.0, 2.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(7, -5, -1)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-7.0, -7.0, 5.0, -5.0, -2.0, -2.0, -3.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-1.0, -7.0, 9.0, -2.0, -1.0, -1.0, 7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-9.0, -8.0, 3.0, 0.0, 3.0, -1.0, 1.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(6.0, 3.0, -4.0, -6.0, 6.0, -6.0, -1.0, 3.0, -7.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(0.0, 5.0, -3.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-6, -7, -5)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-8.0, 6.0, 7.0, -3.0, -7.0, 0.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(0.0, -8.0, -1.0, -5.0, 0.0, 8.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-2.0, 8.0, 4.0, 1.0, 5.0, -1.0, 9.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-9.0, 0.0, 4.0, 6.0, 7.0, -9.0, -1.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-9.0, -8.0, 0.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(3, -4, 1));
	block[0].s.b[0][0] = (vec3(7.0, -2.0, 8.0));
	block[0].s.b[0][1] = (vec3(-4.0, -3.0, 2.0));
	block[0].s.b[0][2] = (vec3(-3.0, -9.0, 7.0));
	block[0].s.b[1][0] = (vec3(5.0, -5.0, 3.0));
	block[0].s.b[1][1] = (vec3(0.0, -9.0, 3.0));
	block[0].s.b[1][2] = (vec3(8.0, 8.0, -7.0));
	block[0].s.b[2][0] = (vec3(-3.0, 2.0, -6.0));
	block[0].s.b[2][1] = (vec3(3.0, 0.0, -1.0));
	block[0].s.b[2][2] = (vec3(-5.0, 7.0, 3.0));
	block[0].s.b[3][0] = (vec3(2.0, -6.0, 8.0));
	block[0].s.b[3][1] = (vec3(7.0, 8.0, -7.0));
	block[0].s.b[3][2] = (vec3(8.0, -1.0, 0.0));
	block[0].s.c = (vec4(7.0, 2.0, 2.0, -3.0));
	block[1].s.a = (ivec3(-7, 7, 3));
	block[1].s.b[0][0] = (vec3(8.0, 1.0, 8.0));
	block[1].s.b[0][1] = (vec3(-1.0, -6.0, -7.0));
	block[1].s.b[0][2] = (vec3(7.0, 5.0, -6.0));
	block[1].s.b[1][0] = (vec3(7.0, -3.0, 6.0));
	block[1].s.b[1][1] = (vec3(0.0, -6.0, -3.0));
	block[1].s.b[1][2] = (vec3(-3.0, 7.0, -4.0));
	block[1].s.b[2][0] = (vec3(5.0, -2.0, 3.0));
	block[1].s.b[2][1] = (vec3(-3.0, 7.0, 2.0));
	block[1].s.b[2][2] = (vec3(-4.0, 4.0, 4.0));
	block[1].s.b[3][0] = (vec3(-4.0, 2.0, -4.0));
	block[1].s.b[3][1] = (vec3(9.0, 0.0, -7.0));
	block[1].s.b[3][2] = (vec3(-5.0, 0.0, 7.0));
	block[1].s.c = (vec4(-6.0, 5.0, -5.0, 4.0));
	block[2].s.a = (ivec3(-5, -5, 7));
	block[2].s.b[0][0] = (vec3(5.0, -1.0, 3.0));
	block[2].s.b[0][1] = (vec3(-9.0, 0.0, 7.0));
	block[2].s.b[0][2] = (vec3(-3.0, 8.0, -3.0));
	block[2].s.b[1][0] = (vec3(-9.0, -2.0, 1.0));
	block[2].s.b[1][1] = (vec3(-8.0, 3.0, 6.0));
	block[2].s.b[1][2] = (vec3(-9.0, -9.0, -9.0));
	block[2].s.b[2][0] = (vec3(-7.0, 0.0, 1.0));
	block[2].s.b[2][1] = (vec3(-5.0, -6.0, 4.0));
	block[2].s.b[2][2] = (vec3(-9.0, 8.0, 5.0));
	block[2].s.b[3][0] = (vec3(9.0, 4.0, 8.0));
	block[2].s.b[3][1] = (vec3(-4.0, 9.0, -4.0));
	block[2].s.b[3][2] = (vec3(4.0, -7.0, 2.0));
	block[2].s.c = (vec4(-6.0, 9.0, 6.0, -1.0));
}
#version 450
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
layout(scalar, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block[0].s.a), ivec3(9, 1, 9)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-3.0, 1.0, 7.0, 4.0, 2.0, 5.0, 8.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(8.0, -5.0, -3.0, 1.0, -6.0, -1.0, 8.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(5.0, -5.0, 5.0, -9.0, 1.0, -1.0, 7.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-3.0, 2.0, -1.0, -9.0, -9.0, -8.0, 2.0, -4.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(3.0, -2.0, -4.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(1, 3, -6)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-6.0, 2.0, 3.0, -2.0, -4.0, -8.0, -4.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-2.0, 2.0, 8.0, 1.0, 4.0, 6.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-5.0, -4.0, -2.0, 9.0, -2.0, 4.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-5.0, -1.0, -9.0, -3.0, 7.0, 1.0, 9.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-2.0, 5.0, -4.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-2, 8, 9)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-1.0, -8.0, -5.0, 4.0, -8.0, -8.0, 0.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-6.0, -2.0, 1.0, 7.0, 6.0, 3.0, -9.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(1.0, 3.0, -8.0, -8.0, -4.0, 5.0, 0.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(0.0, -4.0, -6.0, 1.0, 2.0, -4.0, 0.0, 0.0, -4.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(8.0, 0.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(6, 6, -3));
	block[0].s.b[0][0] = (vec3(-9.0, 3.0, -7.0));
	block[0].s.b[0][1] = (vec3(-7.0, 9.0, -9.0));
	block[0].s.b[0][2] = (vec3(-7.0, 6.0, 9.0));
	block[0].s.b[1][0] = (vec3(4.0, -9.0, 3.0));
	block[0].s.b[1][1] = (vec3(9.0, 4.0, 0.0));
	block[0].s.b[1][2] = (vec3(2.0, -1.0, -8.0));
	block[0].s.b[2][0] = (vec3(5.0, 4.0, 0.0));
	block[0].s.b[2][1] = (vec3(4.0, 7.0, -7.0));
	block[0].s.b[2][2] = (vec3(-9.0, 8.0, -3.0));
	block[0].s.b[3][0] = (vec3(3.0, -3.0, -8.0));
	block[0].s.b[3][1] = (vec3(5.0, -8.0, 7.0));
	block[0].s.b[3][2] = (vec3(-5.0, 8.0, -3.0));
	block[0].s.c = (vec4(9.0, -9.0, -7.0, 3.0));
	block[1].s.a = (ivec3(5, 7, 3));
	block[1].s.b[0][0] = (vec3(6.0, 3.0, 5.0));
	block[1].s.b[0][1] = (vec3(3.0, -4.0, 1.0));
	block[1].s.b[0][2] = (vec3(-3.0, -4.0, -6.0));
	block[1].s.b[1][0] = (vec3(3.0, 2.0, -2.0));
	block[1].s.b[1][1] = (vec3(6.0, 6.0, 8.0));
	block[1].s.b[1][2] = (vec3(5.0, -2.0, 3.0));
	block[1].s.b[2][0] = (vec3(-9.0, 0.0, 8.0));
	block[1].s.b[2][1] = (vec3(2.0, -8.0, -4.0));
	block[1].s.b[2][2] = (vec3(4.0, 1.0, 5.0));
	block[1].s.b[3][0] = (vec3(-6.0, -6.0, -4.0));
	block[1].s.b[3][1] = (vec3(-4.0, -6.0, -1.0));
	block[1].s.b[3][2] = (vec3(7.0, 7.0, -8.0));
	block[1].s.c = (vec4(-6.0, -2.0, 3.0, -3.0));
	block[2].s.a = (ivec3(8, 2, -9));
	block[2].s.b[0][0] = (vec3(9.0, 0.0, 4.0));
	block[2].s.b[0][1] = (vec3(-9.0, -3.0, 6.0));
	block[2].s.b[0][2] = (vec3(-6.0, -9.0, 5.0));
	block[2].s.b[1][0] = (vec3(4.0, -4.0, -2.0));
	block[2].s.b[1][1] = (vec3(-8.0, -9.0, 5.0));
	block[2].s.b[1][2] = (vec3(5.0, 1.0, 8.0));
	block[2].s.b[2][0] = (vec3(3.0, 7.0, 1.0));
	block[2].s.b[2][1] = (vec3(0.0, 6.0, -4.0));
	block[2].s.b[2][2] = (vec3(3.0, 7.0, 4.0));
	block[2].s.b[3][0] = (vec3(2.0, 8.0, -7.0));
	block[2].s.b[3][1] = (vec3(-5.0, -7.0, 9.0));
	block[2].s.b[3][2] = (vec3(8.0, 2.0, -5.0));
	block[2].s.c = (vec4(1.0, 8.0, -1.0, -5.0));
}
#version 450
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
layout(scalar, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block[0].s[0].a), ivec3(1, 9, -3)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(-6.0, 1.0, 8.0, -5.0, -3.0, 1.0, -6.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(2.0, -1.0, 5.0, -5.0, 5.0, -9.0, 1.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(-7.0, -4.0, -3.0, 2.0, -1.0, -9.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(-4.0, 7.0, 3.0, -2.0, -4.0, 4.0, 1.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(-6.0, 1.0, 2.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(1, 7, 4)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(-6.0, 2.0, 3.0, -2.0, -4.0, -8.0, -4.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(-2.0, 2.0, 8.0, 1.0, 4.0, 6.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(-5.0, -4.0, -2.0, 9.0, -2.0, 4.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(-5.0, -1.0, -9.0, -3.0, 7.0, 1.0, 9.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(0.0, 0.0, -4.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(2, 5, 8)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(-2.0, 5.0, -4.0, -9.0, -2.0, 8.0, 9.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(-5.0, 4.0, -8.0, -8.0, 0.0, -2.0, -2.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(1.0, 7.0, 6.0, 3.0, -9.0, -4.0, 9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(-8.0, -8.0, -4.0, 5.0, 0.0, -5.0, 2.0, 0.0, -4.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(0.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(8, -6, 0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(-2.0, 2.0, 0.0, 9.0, 3.0, -1.0, -1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(6.0, 4.0, 7.0, -7.0, -8.0, 7.0, 5.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(5.0, 9.0, 9.0, 0.0, 0.0, -5.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(0.0, -1.0, -1.0, 3.0, 2.0, -3.0, 2.0, -2.0, 7.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(-2.0, 7.0, 2.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(8, -8, 9)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(-4.0, -7.0, 4.0, 2.0, -1.0, -6.0, 5.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(-4.0, -9.0, 0.0, 2.0, -6.0, 6.0, 8.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(-8.0, -4.0, -2.0, -2.0, 4.0, 6.0, -2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(2.0, -6.0, 7.0, -6.0, -2.0, 1.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(-8.0, 7.0, 3.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(0, 0, -3)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(0.0, -7.0, -5.0, 2.0, 1.0, 7.0, -9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(-5.0, -8.0, -5.0, 6.0, -5.0, 0.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(-6.0, 4.0, 1.0, -8.0, 2.0, -5.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(-3.0, 6.0, 8.0, -6.0, -6.0, -2.0, 6.0, 3.0, 4.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(9.0, 0.0, -3.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(-9, -1, 8)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(9.0, -8.0, -4.0, 7.0, 5.0, -2.0, 4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(-7.0, -4.0, 2.0, -4.0, 5.0, -8.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(-7.0, 3.0, 7.0, -7.0, 6.0, -8.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(3.0, 2.0, 6.0, -2.0, 9.0, 9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(-7.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(-9, -9, 8)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(-6.0, -6.0, -3.0, 1.0, 1.0, 3.0, 0.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(-5.0, -7.0, 0.0, -2.0, -8.0, -7.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(-2.0, -2.0, -7.0, -8.0, -6.0, -8.0, -8.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(7.0, 2.0, 1.0, 0.0, 0.0, -6.0, 6.0, -5.0, -4.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(0.0, -5.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(-5, -4, 4)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(7.0, 5.0, 1.0, 4.0, -7.0, -3.0, 8.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(-9.0, -3.0, -6.0, 1.0, 2.0, 5.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(-5.0, -7.0, 7.0, -1.0, 2.0, -5.0, -7.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(-1.0, 1.0, 1.0, 4.0, -6.0, -4.0, 5.0, -9.0, -9.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(4.0, -5.0, 2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(6, -3, -9));
	block[0].s[0].b[0][0] = (vec3(6.0, 9.0, 4.0));
	block[0].s[0].b[0][1] = (vec3(-9.0, 3.0, 9.0));
	block[0].s[0].b[0][2] = (vec3(4.0, 0.0, 2.0));
	block[0].s[0].b[1][0] = (vec3(-1.0, -8.0, 5.0));
	block[0].s[0].b[1][1] = (vec3(4.0, 0.0, 4.0));
	block[0].s[0].b[1][2] = (vec3(7.0, -7.0, -9.0));
	block[0].s[0].b[2][0] = (vec3(8.0, -3.0, 3.0));
	block[0].s[0].b[2][1] = (vec3(-3.0, -8.0, 5.0));
	block[0].s[0].b[2][2] = (vec3(-8.0, 7.0, -5.0));
	block[0].s[0].b[3][0] = (vec3(8.0, -3.0, 9.0));
	block[0].s[0].b[3][1] = (vec3(-9.0, -7.0, 3.0));
	block[0].s[0].b[3][2] = (vec3(5.0, 7.0, 3.0));
	block[0].s[0].c = (vec4(-7.0, -5.0, -7.0, 9.0));
	block[0].s[1].a = (ivec3(3, -7, -7));
	block[0].s[1].b[0][0] = (vec3(6.0, 3.0, 5.0));
	block[0].s[1].b[0][1] = (vec3(3.0, -4.0, 1.0));
	block[0].s[1].b[0][2] = (vec3(-3.0, -4.0, -6.0));
	block[0].s[1].b[1][0] = (vec3(3.0, 2.0, -2.0));
	block[0].s[1].b[1][1] = (vec3(6.0, 6.0, 8.0));
	block[0].s[1].b[1][2] = (vec3(5.0, -2.0, 3.0));
	block[0].s[1].b[2][0] = (vec3(-9.0, 0.0, 8.0));
	block[0].s[1].b[2][1] = (vec3(2.0, -8.0, -4.0));
	block[0].s[1].b[2][2] = (vec3(4.0, 1.0, 5.0));
	block[0].s[1].b[3][0] = (vec3(-6.0, -6.0, -4.0));
	block[0].s[1].b[3][1] = (vec3(-4.0, -6.0, -1.0));
	block[0].s[1].b[3][2] = (vec3(7.0, 7.0, -8.0));
	block[0].s[1].c = (vec4(8.0, 2.0, -5.0, 1.0));
	block[0].s[2].a = (ivec3(9, -9, -7));
	block[0].s[2].b[0][0] = (vec3(-6.0, -2.0, 3.0));
	block[0].s[2].b[0][1] = (vec3(-3.0, 8.0, 2.0));
	block[0].s[2].b[0][2] = (vec3(-9.0, 9.0, 0.0));
	block[0].s[2].b[1][0] = (vec3(4.0, -9.0, -3.0));
	block[0].s[2].b[1][1] = (vec3(6.0, -6.0, -9.0));
	block[0].s[2].b[1][2] = (vec3(5.0, 4.0, -4.0));
	block[0].s[2].b[2][0] = (vec3(-2.0, -8.0, -9.0));
	block[0].s[2].b[2][1] = (vec3(5.0, 5.0, 1.0));
	block[0].s[2].b[2][2] = (vec3(8.0, 3.0, 7.0));
	block[0].s[2].b[3][0] = (vec3(1.0, 0.0, 6.0));
	block[0].s[2].b[3][1] = (vec3(-4.0, 3.0, 7.0));
	block[0].s[2].b[3][2] = (vec3(4.0, 2.0, 8.0));
	block[0].s[2].c = (vec4(8.0, -1.0, -5.0, 5.0));
	block[0].v = (vec4(-5.0, 7.0, 8.0, -4.0));
	block[1].s[0].a = (ivec3(2, 1, 6));
	block[1].s[0].b[0][0] = (vec3(-2.0, 5.0, 0.0));
	block[1].s[0].b[0][1] = (vec3(9.0, 1.0, -5.0));
	block[1].s[0].b[0][2] = (vec3(-9.0, -3.0, -4.0));
	block[1].s[0].b[1][0] = (vec3(4.0, -5.0, 5.0));
	block[1].s[0].b[1][1] = (vec3(-8.0, -7.0, 9.0));
	block[1].s[0].b[1][2] = (vec3(8.0, -5.0, 4.0));
	block[1].s[0].b[2][0] = (vec3(-1.0, -9.0, 3.0));
	block[1].s[0].b[2][1] = (vec3(-8.0, 7.0, 2.0));
	block[1].s[0].b[2][2] = (vec3(-4.0, 5.0, 1.0));
	block[1].s[0].b[3][0] = (vec3(7.0, -8.0, -4.0));
	block[1].s[0].b[3][1] = (vec3(-8.0, -7.0, -5.0));
	block[1].s[0].b[3][2] = (vec3(-6.0, 5.0, -1.0));
	block[1].s[0].c = (vec4(-1.0, -9.0, 3.0, 8.0));
	block[1].s[1].a = (ivec3(5, -6, -7));
	block[1].s[1].b[0][0] = (vec3(-9.0, 3.0, -5.0));
	block[1].s[1].b[0][1] = (vec3(-2.0, -5.0, -4.0));
	block[1].s[1].b[0][2] = (vec3(3.0, 3.0, 7.0));
	block[1].s[1].b[1][0] = (vec3(5.0, 1.0, 5.0));
	block[1].s[1].b[1][1] = (vec3(-9.0, 6.0, 0.0));
	block[1].s[1].b[1][2] = (vec3(-3.0, -5.0, 5.0));
	block[1].s[1].b[2][0] = (vec3(-5.0, 7.0, -7.0));
	block[1].s[1].b[2][1] = (vec3(9.0, -9.0, 1.0));
	block[1].s[1].b[2][2] = (vec3(-9.0, 9.0, 7.0));
	block[1].s[1].b[3][0] = (vec3(6.0, -2.0, -1.0));
	block[1].s[1].b[3][1] = (vec3(-4.0, 1.0, 3.0));
	block[1].s[1].b[3][2] = (vec3(-5.0, 4.0, -5.0));
	block[1].s[1].c = (vec4(9.0, 1.0, -7.0, 9.0));
	block[1].s[2].a = (ivec3(-2, 4, 8));
	block[1].s[2].b[0][0] = (vec3(-4.0, 6.0, 9.0));
	block[1].s[2].b[0][1] = (vec3(-6.0, -6.0, -8.0));
	block[1].s[2].b[0][2] = (vec3(3.0, 8.0, 0.0));
	block[1].s[2].b[1][0] = (vec3(-2.0, -1.0, 3.0));
	block[1].s[2].b[1][1] = (vec3(7.0, 7.0, -4.0));
	block[1].s[2].b[1][2] = (vec3(-4.0, 0.0, -9.0));
	block[1].s[2].b[2][0] = (vec3(5.0, 3.0, -9.0));
	block[1].s[2].b[2][1] = (vec3(5.0, -8.0, -2.0));
	block[1].s[2].b[2][2] = (vec3(-7.0, -9.0, 6.0));
	block[1].s[2].b[3][0] = (vec3(6.0, 0.0, 6.0));
	block[1].s[2].b[3][1] = (vec3(2.0, 4.0, -4.0));
	block[1].s[2].b[3][2] = (vec3(-5.0, 4.0, -9.0));
	block[1].s[2].c = (vec4(-4.0, 5.0, -6.0, -6.0));
	block[1].v = (vec4(-5.0, -6.0, 6.0, 7.0));
	block[2].s[0].a = (ivec3(-9, 9, -1));
	block[2].s[0].b[0][0] = (vec3(-7.0, 1.0, 0.0));
	block[2].s[0].b[0][1] = (vec3(-4.0, 0.0, 8.0));
	block[2].s[0].b[0][2] = (vec3(-6.0, 9.0, -4.0));
	block[2].s[0].b[1][0] = (vec3(0.0, 8.0, 8.0));
	block[2].s[0].b[1][1] = (vec3(4.0, 9.0, 3.0));
	block[2].s[0].b[1][2] = (vec3(4.0, -3.0, 0.0));
	block[2].s[0].b[2][0] = (vec3(8.0, 3.0, 8.0));
	block[2].s[0].b[2][1] = (vec3(-8.0, -7.0, 9.0));
	block[2].s[0].b[2][2] = (vec3(-8.0, -3.0, 8.0));
	block[2].s[0].b[3][0] = (vec3(8.0, -4.0, -8.0));
	block[2].s[0].b[3][1] = (vec3(4.0, 6.0, -1.0));
	block[2].s[0].b[3][2] = (vec3(9.0, 6.0, 7.0));
	block[2].s[0].c = (vec4(-6.0, 1.0, 3.0, -2.0));
	block[2].s[1].a = (ivec3(5, -4, -5));
	block[2].s[1].b[0][0] = (vec3(-1.0, 1.0, 5.0));
	block[2].s[1].b[0][1] = (vec3(7.0, -8.0, -7.0));
	block[2].s[1].b[0][2] = (vec3(-9.0, 2.0, -6.0));
	block[2].s[1].b[1][0] = (vec3(-7.0, 5.0, -5.0));
	block[2].s[1].b[1][1] = (vec3(9.0, 0.0, 6.0));
	block[2].s[1].b[1][2] = (vec3(9.0, -6.0, -4.0));
	block[2].s[1].b[2][0] = (vec3(-8.0, -4.0, 4.0));
	block[2].s[1].b[2][1] = (vec3(-9.0, 3.0, -4.0));
	block[2].s[1].b[2][2] = (vec3(5.0, -7.0, 6.0));
	block[2].s[1].b[3][0] = (vec3(-1.0, -2.0, 1.0));
	block[2].s[1].b[3][1] = (vec3(-7.0, -3.0, 1.0));
	block[2].s[1].b[3][2] = (vec3(8.0, 0.0, -8.0));
	block[2].s[1].c = (vec4(-2.0, -4.0, 9.0, -1.0));
	block[2].s[2].a = (ivec3(3, 3, -4));
	block[2].s[2].b[0][0] = (vec3(9.0, -9.0, -1.0));
	block[2].s[2].b[0][1] = (vec3(-2.0, 5.0, 3.0));
	block[2].s[2].b[0][2] = (vec3(8.0, 2.0, -4.0));
	block[2].s[2].b[1][0] = (vec3(8.0, 7.0, -5.0));
	block[2].s[2].b[1][1] = (vec3(1.0, 6.0, -9.0));
	block[2].s[2].b[1][2] = (vec3(-6.0, -1.0, 8.0));
	block[2].s[2].b[2][0] = (vec3(-9.0, 8.0, -5.0));
	block[2].s[2].b[2][1] = (vec3(-6.0, -4.0, 3.0));
	block[2].s[2].b[2][2] = (vec3(-4.0, -3.0, 7.0));
	block[2].s[2].b[3][0] = (vec3(-4.0, 2.0, 5.0));
	block[2].s[2].b[3][1] = (vec3(-3.0, -6.0, 2.0));
	block[2].s[2].b[3][2] = (vec3(-8.0, 0.0, -4.0));
	block[2].s[2].c = (vec4(-7.0, -1.0, 5.0, 6.0));
	block[2].v = (vec4(-5.0, 7.0, -4.0, -6.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-9, 2, 6)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-5.0, 4.0, -2.0, -6.0, -7.0, 7.0, 9.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(4.0, -1.0, -5.0, -7.0, 6.0, -8.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-5.0, -7.0, -8.0, -5.0, -6.0, -9.0, -2.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-7.0, 1.0, -6.0, -8.0, -2.0, 6.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(-3.0, -7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(-1.0, -9.0, 9.0, 4.0, -3.0, 2.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(0, -2, 3)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(-2.0, 5.0, -2.0, 8.0, 8.0, 8.0, 0.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(0.0, 2.0, -4.0, 3.0, -5.0, 5.0, -8.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(9.0, -4.0, -5.0, 7.0, 0.0, -6.0, 3.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(4.0, -5.0, 1.0, -5.0, -7.0, -1.0, -6.0, 0.0, 4.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(-3.0, 1.0, -6.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(-9, 8, -4)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-2.0, 4.0, 1.0, -8.0, -1.0, -9.0, -2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-6.0, 8.0, 1.0, -8.0, 8.0, -4.0, -6.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(0.0, 7.0, -4.0, 9.0, 3.0, 5.0, -3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(6.0, -5.0, -1.0, 6.0, -1.0, 8.0, 9.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-6.0, 7.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(-9.0, -3.0, 9.0, -9.0, 2.0, 7.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(2, -4, 8)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(8.0, -3.0, -9.0, -7.0, -3.0, -8.0, -5.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(8.0, 5.0, -3.0, -4.0, 4.0, -7.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(9.0, 2.0, -6.0, -6.0, 0.0, -5.0, 6.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(7.0, 8.0, -3.0, -5.0, -3.0, 8.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(4.0, -2.0, -3.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(8, 6, -5)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(6.0, 0.0, -2.0, -4.0, 9.0, -4.0, 0.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(3.0, -3.0, -5.0, 4.0, 5.0, 6.0, 1.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-2.0, 3.0, -3.0, 4.0, 3.0, -6.0, -9.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(9.0, -1.0, 4.0, 5.0, 5.0, 2.0, -6.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(2.0, 1.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(-7.0, -8.0, -4.0, -9.0, -8.0, -4.0, -2.0, 3.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(0, 9, 8)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(-7.0, -5.0, 1.0, 3.0, 6.0, 5.0, -4.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(-9.0, 2.0, 7.0, 7.0, 7.0, -9.0, -7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(5.0, 9.0, 5.0, -3.0, 0.0, -6.0, -7.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(6.0, 1.0, 8.0, -7.0, 6.0, 8.0, 6.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(7.0, 6.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a = (mat3(1.0, 1.0, -6.0, -2.0, 7.0, 6.0, -6.0, -9.0, 1.0));
	block[0].t.b.a = (ivec3(-1, -9, 2));
	block[0].t.b.b[0] = (mat3(-4.0, -8.0, -2.0, 3.0, -7.0, 2.0, -2.0, -8.0, 0.0));
	block[0].t.b.b[1] = (mat3(-4.0, 6.0, -7.0, 8.0, 0.0, -9.0, -1.0, -3.0, -4.0));
	block[0].t.b.b[2] = (mat3(0.0, -6.0, -6.0, 5.0, -7.0, 3.0, 3.0, 5.0, 0.0));
	block[0].t.b.b[3] = (mat3(5.0, -3.0, -5.0, 0.0, -8.0, 4.0, 0.0, 0.0, -2.0));
	block[0].t.b.c = (vec4(-3.0, 9.0, 6.0, 6.0));
	block[0].u = (2u);
	block[1].t.a = (mat3(4.0, -2.0, -2.0, 3.0, -9.0, 4.0, -6.0, 5.0, 0.0));
	block[1].t.b.a = (ivec3(-1, -8, -2));
	block[1].t.b.b[0] = (mat3(-6.0, 5.0, -5.0, 6.0, -1.0, -9.0, 5.0, 7.0, -1.0));
	block[1].t.b.b[1] = (mat3(-7.0, -5.0, 2.0, 9.0, -1.0, -5.0, 7.0, -7.0, 2.0));
	block[1].t.b.b[2] = (mat3(7.0, -3.0, 1.0, 0.0, 8.0, 3.0, 6.0, -8.0, -5.0));
	block[1].t.b.b[3] = (mat3(0.0, -8.0, 7.0, -7.0, -2.0, 9.0, 4.0, 8.0, 2.0));
	block[1].t.b.c = (vec4(-6.0, -2.0, 9.0, -3.0));
	block[1].u = (7u);
	block[2].t.a = (mat3(-8.0, 0.0, -9.0, -1.0, -7.0, -5.0, -5.0, -4.0, 5.0));
	block[2].t.b.a = (ivec3(-2, -3, -7));
	block[2].t.b.b[0] = (mat3(-4.0, 5.0, 9.0, 7.0, 5.0, 4.0, -8.0, -8.0, 1.0));
	block[2].t.b.b[1] = (mat3(9.0, -3.0, -3.0, -2.0, 5.0, 5.0, 2.0, -2.0, -7.0));
	block[2].t.b.b[2] = (mat3(2.0, 8.0, 6.0, 4.0, -8.0, 3.0, 6.0, -5.0, 4.0));
	block[2].t.b.b[3] = (mat3(0.0, -4.0, -4.0, 4.0, 5.0, -8.0, -9.0, -6.0, -4.0));
	block[2].t.b.c = (vec4(9.0, -7.0, 0.0, 7.0));
	block[2].u = (1u);
}
#version 450
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
	bvec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((block[0].var), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block[1].var), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block[2].var), bvec4(false, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (bvec4(true, true, true, false));
	block[1].var = (bvec4(true, false, false, false));
	block[2].var = (bvec4(false, true, true, true));
}
#version 450
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
	highp mat3x2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(block[0].var, mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(-4.0, -6.0));
	block[0].var[1] = (vec2(1.0, -3.0));
	block[0].var[2] = (vec2(-1.0, -9.0));
	block[1].var[0] = (vec2(3.0, -2.0));
	block[1].var[1] = (vec2(5.0, -8.0));
	block[1].var[2] = (vec2(2.0, -9.0));
	block[2].var[0] = (vec2(1.0, -5.0));
	block[2].var[1] = (vec2(0.0, -2.0));
	block[2].var[2] = (vec2(2.0, -1.0));
}
#version 450
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
	highp mat3x2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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

layout(std140, buffer_reference) buffer Block
{
	float16_t var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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
	allOk = compare_float((block[0].padding), -6.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -4.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-8.0, -3.0, -9.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-1.0, 8.0, 8.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(3.0, -6.0, -4.0)) && allOk;
	allOk = compare_float((block[1].padding), 1.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 9.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 1.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-1.0, -1.0, -1.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(5.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(3.0, 0.0, 1.0)) && allOk;
	allOk = compare_float((block[2].padding), 3.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 7.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 5.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(4.0, 0.0, -2.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-7.0, 1.0, 7.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(1.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (8.0);
	block[0].var[0] = (vec3(6.0, 2.0, -9.0));
	block[0].var[1] = (vec3(-8.0, 5.0, 2.0));
	block[0].var[2] = (vec3(3.0, 9.0, 3.0));
	block[1].padding = (2.0);
	block[1].var[0] = (vec3(5.0, 8.0, 8.0));
	block[1].var[1] = (vec3(-3.0, -4.0, -5.0));
	block[1].var[2] = (vec3(-9.0, -5.0, 3.0));
	block[2].padding = (-7.0);
	block[2].var[0] = (vec3(-3.0, -3.0, -8.0));
	block[2].var[1] = (vec3(-5.0, -4.0, 8.0));
	block[2].var[2] = (vec3(5.0, 3.0, -3.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 6.0) && allOk;
	allOk = compare_mat4(block[0].var, mat4(-1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0, 9.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_float((block[1].padding), 5.0) && allOk;
	allOk = compare_mat4(block[1].var, mat4(-8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0, 2.0, 9.0, 5.0, -3.0, 3.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_float((block[2].padding), 1.0) && allOk;
	allOk = compare_mat4(block[2].var, mat4(-2.0, 1.0, -3.0, -4.0, 5.0, 8.0, -1.0, 4.0, 4.0, 3.0, -8.0, 4.0, -1.0, 7.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (0.0);
	block[0].var[0] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block[0].var[1] = (vec4(0.0, 4.0, -1.0, -5.0));
	block[0].var[2] = (vec4(4.0, 0.0, -6.0, -6.0));
	block[0].var[3] = (vec4(-7.0, -8.0, 3.0, -6.0));
	block[1].padding = (2.0);
	block[1].var[0] = (vec4(1.0, -4.0, 3.0, 5.0));
	block[1].var[1] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block[1].var[2] = (vec4(3.0, 9.0, -6.0, 1.0));
	block[1].var[3] = (vec4(5.0, 4.0, -7.0, -9.0));
	block[2].padding = (-2.0);
	block[2].var[0] = (vec4(-5.0, 8.0, 8.0, -7.0));
	block[2].var[1] = (vec4(6.0, 0.0, 8.0, 4.0));
	block[2].var[2] = (vec4(0.0, 8.0, 4.0, 4.0));
	block[2].var[3] = (vec4(-5.0, -6.0, -8.0, 6.0));
}
#version 450
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
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockA[0].a), -8.0) && allOk;
	allOk = compare_float((blockA[1].a), -7.0) && allOk;
	allOk = compare_float((blockA[2].a), -5.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(-2.0, 2.0, 2.0, -4.0, -8.0, 7.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(9, 7)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(8, 9)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(1, -6)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(1, -1)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(0.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_uint((blockB[1].b.a), 2u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(-8.0, 0.0, -4.0, 0.0, 7.0, 5.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(-4, -5)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(9, 5)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(3, -1)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(8, -2)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(-9.0, -3.0, 4.0, -8.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_uint((blockB[2].b.a), 8u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(-2.0, 6.0, 6.0, -2.0, 7.0, 9.0, 8.0, 4.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(0, -7)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(4, -1)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(-3, 5)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(0.0, 3.0, -1.0, 9.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-4.0);
	blockA[0].b.a = (mat3(-7.0, -8.0, 3.0, 7.0, 5.0, 6.0, 5.0, 4.0, 6.0));
	blockA[0].b.b[0] = (ivec2(-7, 9));
	blockA[0].b.b[1] = (ivec2(0, 5));
	blockA[0].b.b[2] = (ivec2(7, 9));
	blockA[0].b.b[3] = (ivec2(3, -5));
	blockA[0].b.c = (vec4(-5.0, 4.0, 3.0, -2.0));
	blockA[1].a = (2.0);
	blockA[1].b.a = (mat3(1.0, -8.0, -8.0, -4.0, 4.0, 0.0, -5.0, 2.0, 0.0));
	blockA[1].b.b[0] = (ivec2(7, 9));
	blockA[1].b.b[1] = (ivec2(-3, -5));
	blockA[1].b.b[2] = (ivec2(3, 6));
	blockA[1].b.b[3] = (ivec2(3, 5));
	blockA[1].b.c = (vec4(4.0, 3.0, -6.0, 8.0));
	blockA[2].a = (8.0);
	blockA[2].b.a = (mat3(-6.0, -3.0, -8.0, 9.0, -8.0, 6.0, 2.0, -2.0, 4.0));
	blockA[2].b.b[0] = (ivec2(-6, 6));
	blockA[2].b.b[1] = (ivec2(-4, -1));
	blockA[2].b.b[2] = (ivec2(3, 0));
	blockA[2].b.b[3] = (ivec2(-7, -3));
	blockA[2].b.c = (vec4(7.0, -6.0, 8.0, -3.0));
	blockB[0].a = (mat2(3.0, 2.0, -9.0, -5.0));
	blockB[0].b.a = (0u);
	blockB[0].b.b.a = (mat3(-3.0, -1.0, -2.0, 5.0, -1.0, 0.0, -2.0, -1.0, 4.0));
	blockB[0].b.b.b[0] = (ivec2(8, -2));
	blockB[0].b.b.b[1] = (ivec2(-4, 9));
	blockB[0].b.b.b[2] = (ivec2(-5, -5));
	blockB[0].b.b.b[3] = (ivec2(-5, 4));
	blockB[0].b.b.c = (vec4(-7.0, 5.0, 6.0, 7.0));
	blockB[0].b.c = (bvec4(true, false, true, false));
	blockB[0].d = (false);
	blockB[1].a = (mat2(-1.0, -8.0, 8.0, -5.0));
	blockB[1].b.a = (7u);
	blockB[1].b.b.a = (mat3(-2.0, -1.0, 2.0, -6.0, 6.0, -1.0, 3.0, 6.0, 2.0));
	blockB[1].b.b.b[0] = (ivec2(0, 8));
	blockB[1].b.b.b[1] = (ivec2(3, 0));
	blockB[1].b.b.b[2] = (ivec2(3, -6));
	blockB[1].b.b.b[3] = (ivec2(5, 3));
	blockB[1].b.b.c = (vec4(-6.0, -4.0, -7.0, -1.0));
	blockB[1].b.c = (bvec4(true, false, false, true));
	blockB[1].d = (false);
	blockB[2].a = (mat2(7.0, 9.0, -1.0, -7.0));
	blockB[2].b.a = (9u);
	blockB[2].b.b.a = (mat3(-6.0, -5.0, 2.0, 2.0, 1.0, 4.0, -8.0, -3.0, -1.0));
	blockB[2].b.b.b[0] = (ivec2(-4, 5));
	blockB[2].b.b.b[1] = (ivec2(6, 0));
	blockB[2].b.b.b[2] = (ivec2(4, 9));
	blockB[2].b.b.b[3] = (ivec2(2, -9));
	blockB[2].b.b.c = (vec4(6.0, 7.0, 1.0, 3.0));
	blockB[2].b.c = (bvec4(false, false, false, true));
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
layout(scalar, buffer_reference) buffer BlockA
{
	highp float a;
	S b;
	lowp uvec3 c;
};
layout(scalar, buffer_reference) buffer BlockB
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
	allOk = compare_float((blockA.a), -4.0) && allOk;
	allOk = compare_uint((blockB.b.a), 6u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(-8.0, 2.0, 1.0, 5.0, -2.0, -9.0, 7.0, 4.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(7, 7)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(8, 9)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(9, -2)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(-1, -7)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(-7.0, 6.0, 9.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (0.0);
	blockA.b.a = (mat3(7.0, -4.0, -7.0, 3.0, 2.0, 8.0, 2.0, -9.0, 5.0));
	blockA.b.b[0] = (ivec2(-5, 3));
	blockA.b.b[1] = (ivec2(-9, 6));
	blockA.b.b[2] = (ivec2(9, 2));
	blockA.b.b[3] = (ivec2(-1, -2));
	blockA.b.c = (vec4(5.0, 9.0, -5.0, -8.0));
	blockB.a = (mat2(0.0, 9.0, -1.0, 1.0));
	blockB.b.a = (5u);
	blockB.b.b.a = (mat3(9.0, 7.0, 8.0, -1.0, 0.0, 7.0, -1.0, -6.0, -7.0));
	blockB.b.b.b[0] = (ivec2(7, 6));
	blockB.b.b.b[1] = (ivec2(8, 2));
	blockB.b.b.b[2] = (ivec2(-4, 5));
	blockB.b.b.b[3] = (ivec2(4, 1));
	blockB.b.b.c = (vec4(-4.0, -8.0, 4.0, -2.0));
	blockB.b.c = (bvec4(true, true, false, false));
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

layout(std430, buffer_reference) buffer BlockB
{
	highp float a;
	bool b;
	bool c;
	highp float d;
};
layout(std430, buffer_reference) buffer BlockC
{
	bool e;
	mediump float f;
	lowp uint g;
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp float h;
	lowp int i;
	mediump uint j;
};
layout(std430, buffer_reference) buffer BlockE
{
	highp float k;
	lowp uint l;
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
	allOk = compare_bool((blockB.c), true) && allOk;
	allOk = compare_float((blockC.f), -5.0) && allOk;
	allOk = compare_float((blockD.h), -6.0) && allOk;
	allOk = compare_uint((blockD.j), 3u) && allOk;
	allOk = compare_float((blockE.k), 6.0) && allOk;
	allOk = compare_uint((blockE.l), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (true);
	blockB.c = (false);
	blockC.f = (9.0);
	blockC.g = (8u);
	blockD.h = (4.0);
	blockD.j = (7u);
	blockE.k = (7.0);
	blockE.l = (8u);
}
#version 450
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
	lowp uvec3 a;
	lowp ivec4 b;
};
layout(std140, buffer_reference) buffer BlockC
{
	highp uvec2 c[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(5u, 7u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.c[0]), uvec2(0u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c[0] = (uvec2(0u, 8u));
}
#version 450
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
	lowp vec2 e[2];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp int f;
	highp vec3 g;
	mediump mat3 h;
	mediump mat2x3 i;
	mediump mat2 j;
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(0.0, -6.0)) && allOk;
	allOk = compare_mat4(blockB.b, mat4(9.0, -5.0, 0.0, 3.0, 7.0, -1.0, -8.0, 2.0, 8.0, -2.0, -2.0, 4.0, -7.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_int((blockC.f), 8) && allOk;
	allOk = compare_mat3(blockC.h, mat3(2.0, 3.0, -7.0, 2.0, -6.0, 9.0, -2.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4(-9.0, 0.0, 9.0, 2.0, -6.0, 6.0, -6.0, 3.0, 5.0, -8.0, -7.0, -8.0, 3.0, -6.0, -9.0, 9.0));
	blockB.e[0] = (vec2(0.0, -4.0));
	blockB.e[1] = (vec2(2.0, 1.0));
	blockC.f = (2);
	blockC.g = (vec3(9.0, -3.0, -2.0));
	blockC.i = (mat2x3(-5.0, -3.0, 8.0, -3.0, 0.0, -9.0));
	blockC.j = (mat2(2.0, 1.0, -4.0, 8.0));
}
#version 450
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
	highp mat2x3 mB;
	highp mat4x2 mC;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	lowp ivec4 a;
	lowp vec2 b;
	mediump uvec4 c;
	mediump vec4 d;
	lowp vec3 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump mat3x4 f;
	sA g[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(-9, 9, 2, 0)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec4((blockB.d), vec4(1.0, -6.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockC.f, mat3x4(1.0, 5.0, -5.0, -8.0, -7.0, 7.0, -5.0, 8.0, -5.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockC.g[0].mA, mat3x2(-3.0, 5.0, 0.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockC.g[0].mB, mat2x3(8.0, -4.0, -1.0, 6.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[0].mC, mat4x2(8.0, 0.0, -4.0, -6.0, -1.0, 5.0, 1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-9, -3, 8, 0));
	blockB.b = (vec2(-3.0, 9.0));
	blockB.c = (uvec4(2u, 2u, 9u, 4u));
	blockC.f = (mat3x4(-1.0, 7.0, -9.0, -3.0, -1.0, 6.0, -2.0, -4.0, 9.0, -4.0, 2.0, -4.0));
	blockC.g[0].mA = (mat3x2(4.0, -8.0, -4.0, 1.0, -4.0, -4.0));
	blockC.g[0].mB = (mat2x3(-7.0, -1.0, 9.0, -8.0, 6.0, 2.0));
	blockC.g[0].mC = (mat4x2(-1.0, 0.0, 2.0, -2.0, -1.0, 3.0, 0.0, -8.0));
}
#version 450
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
layout(std430, row_major, buffer_reference) buffer BlockB
{
	highp mat4x2 a;
	highp uvec2 b[1];
	lowp mat2 c;
	sA d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.c, mat2(-6.0, -6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockB.d.mA, mat2x3(-1.0, 8.0, 6.0, 4.0, -1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(6.0, -7.0, 0.0, -3.0, 5.0, -7.0, 1.0, 9.0));
	blockB.b[0] = (uvec2(3u, 1u));
	blockB.d.mA = (mat2x3(4.0, -5.0, -6.0, -2.0, 5.0, 3.0));
}
#version 450
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
	highp uvec3 a;
	lowp ivec3 b;
	highp int c[7];
	mediump mat4x3 d[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp mat3x4 e;
	highp mat2x3 f[2];
	bool g;
	highp mat4 h;
	lowp ivec2 i[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_int((blockB.c[0]), -4) && allOk;
	allOk = compare_int((blockB.c[1]), -2) && allOk;
	allOk = compare_int((blockB.c[2]), -2) && allOk;
	allOk = compare_int((blockB.c[3]), -4) && allOk;
	allOk = compare_int((blockB.c[4]), 8) && allOk;
	allOk = compare_int((blockB.c[5]), 1) && allOk;
	allOk = compare_int((blockB.c[6]), 8) && allOk;
	allOk = compare_mat3x4(blockC.e, mat3x4(7.0, -1.0, 7.0, 2.0, 2.0, -3.0, 9.0, 6.0, 4.0, 4.0, 7.0, 2.0)) && allOk;
	allOk = compare_bool((blockC.g), false) && allOk;
	allOk = compare_ivec2((blockC.i[0]), ivec2(8, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec3(-4, 7, 7));
	blockB.c[0] = (4);
	blockB.c[1] = (-9);
	blockB.c[2] = (-6);
	blockB.c[3] = (5);
	blockB.c[4] = (-7);
	blockB.c[5] = (1);
	blockB.c[6] = (9);
	blockB.d[0] = (mat4x3(-4.0, 5.0, 9.0, -9.0, 1.0, -9.0, -8.0, 3.0, 4.0, 5.0, -6.0, -3.0));
	blockB.d[1] = (mat4x3(-3.0, 5.0, -6.0, 6.0, -1.0, 4.0, -2.0, -4.0, -3.0, -2.0, -9.0, -9.0));
	blockB.d[2] = (mat4x3(-1.0, 9.0, -3.0, -4.0, 1.0, 4.0, 0.0, -3.0, -4.0, -7.0, -7.0, 4.0));
	blockB.d[3] = (mat4x3(-5.0, 3.0, -8.0, -7.0, 2.0, 6.0, 1.0, -6.0, -1.0, -7.0, 8.0, 7.0));
	blockB.d[4] = (mat4x3(-5.0, 1.0, 6.0, 0.0, 8.0, -4.0, -1.0, -3.0, -5.0, 0.0, 5.0, -3.0));
	blockC.f[0] = (mat2x3(-6.0, 0.0, 1.0, -2.0, -1.0, -4.0));
	blockC.f[1] = (mat2x3(4.0, -4.0, -4.0, -2.0, -7.0, -6.0));
	blockC.g = (true);
	blockC.h = (mat4(0.0, -5.0, -5.0, 4.0, -3.0, 5.0, -1.0, 0.0, -2.0, 0.0, -2.0, 4.0, -9.0, 4.0, -4.0, 4.0));
	blockC.i[0] = (ivec2(-2, 8));
}
#version 450
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
	highp ivec2 mA[6];
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	bvec3 a;
	mediump mat4x3 b;
	mediump ivec4 c;
	bool d;
	lowp mat3 e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	mediump mat3x2 f;
	bool g;
	mediump mat2 h;
	mediump vec3 i[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	lowp mat2x3 j;
	sA k;
	lowp mat4x2 l;
	lowp mat4x3 m;
	mediump uvec2 n[];
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	mediump vec4 o;
	highp uvec2 p[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(-1.0, 2.0, -6.0, -2.0, 3.0, -3.0, 6.0, -6.0, -1.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_ivec4((blockB.c), ivec4(8, -1, 6, 5)) && allOk;
	allOk = compare_mat2(blockC.h, mat2(2.0, 2.0, 4.0, -9.0)) && allOk;
	allOk = compare_vec3((blockC.i[0]), vec3(7.0, -3.0, 1.0)) && allOk;
	allOk = compare_vec3((blockC.i[1]), vec3(7.0, -2.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockD.k.mA[0]), ivec2(-3, 2)) && allOk;
	allOk = compare_ivec2((blockD.k.mA[1]), ivec2(-3, -9)) && allOk;
	allOk = compare_ivec2((blockD.k.mA[2]), ivec2(-5, 8)) && allOk;
	allOk = compare_ivec2((blockD.k.mA[3]), ivec2(2, -7)) && allOk;
	allOk = compare_ivec2((blockD.k.mA[4]), ivec2(-9, -1)) && allOk;
	allOk = compare_ivec2((blockD.k.mA[5]), ivec2(-5, 4)) && allOk;
	allOk = compare_uvec2((blockD.n[0]), uvec2(8u, 2u)) && allOk;
	allOk = compare_uvec2((blockD.n[1]), uvec2(5u, 4u)) && allOk;
	allOk = compare_uvec2((blockD.n[2]), uvec2(9u, 0u)) && allOk;
	allOk = compare_vec4((blockE.o), vec4(-5.0, 6.0, 4.0, 5.0)) && allOk;
	allOk = compare_uvec2((blockE.p[0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_uvec2((blockE.p[1]), uvec2(5u, 4u)) && allOk;
	allOk = compare_uvec2((blockE.p[2]), uvec2(2u, 6u)) && allOk;
	allOk = compare_uvec2((blockE.p[3]), uvec2(1u, 5u)) && allOk;
	allOk = compare_uvec2((blockE.p[4]), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec2((blockE.p[5]), uvec2(0u, 5u)) && allOk;
	allOk = compare_uvec2((blockE.p[6]), uvec2(9u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (ivec4(5, -6, 3, -5));
	blockB.e[0] = (mat3(-9.0, -1.0, 7.0, 3.0, 6.0, -1.0, -9.0, 2.0, -6.0));
	blockB.e[1] = (mat3(3.0, -9.0, 3.0, 1.0, 8.0, -9.0, -4.0, -7.0, 3.0));
	blockB.e[2] = (mat3(5.0, -5.0, -6.0, -9.0, -2.0, 4.0, 9.0, -2.0, 9.0));
	blockB.e[3] = (mat3(-2.0, 6.0, 5.0, -6.0, 8.0, 6.0, 3.0, -7.0, -4.0));
	blockB.e[4] = (mat3(7.0, 0.0, 5.0, 6.0, -8.0, 8.0, 5.0, 8.0, 6.0));
	blockB.e[5] = (mat3(1.0, 5.0, 0.0, 5.0, 4.0, -9.0, -8.0, -7.0, -7.0));
	blockB.e[6] = (mat3(-6.0, 4.0, -4.0, 0.0, 3.0, 4.0, 2.0, -1.0, 8.0));
	blockB.e[7] = (mat3(6.0, -7.0, -7.0, -5.0, 2.0, 8.0, -9.0, 6.0, 2.0));
	blockC.f = (mat3x2(5.0, -2.0, 5.0, 6.0, -6.0, 0.0));
	blockC.g = (false);
	blockC.i[0] = (vec3(-8.0, -7.0, -5.0));
	blockC.i[1] = (vec3(6.0, -3.0, -6.0));
	blockD.j = (mat2x3(8.0, 5.0, 2.0, 4.0, -5.0, 9.0));
	blockD.k.mA[0] = (ivec2(7, 3));
	blockD.k.mA[1] = (ivec2(-9, 3));
	blockD.k.mA[2] = (ivec2(4, 5));
	blockD.k.mA[3] = (ivec2(8, 6));
	blockD.k.mA[4] = (ivec2(-3, 9));
	blockD.k.mA[5] = (ivec2(4, -1));
	blockD.m = (mat4x3(1.0, 1.0, -1.0, 3.0, 6.0, 9.0, -9.0, 8.0, 6.0, 9.0, 3.0, 6.0));
	blockE.o = (vec4(2.0, 1.0, -8.0, 8.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, buffer_reference) readonly buffer BlockB
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
	allOk = compare_uvec4((blockB.a[0]), uvec4(1u, 3u, 0u, 2u)) && allOk;
	allOk = compare_uvec4((blockB.a[1]), uvec4(9u, 2u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.a[2]), uvec4(4u, 4u, 7u, 0u)) && allOk;
	allOk = compare_uvec4((blockB.a[3]), uvec4(6u, 1u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.a[4]), uvec4(0u, 7u, 8u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp vec2 a;
	i16vec2 b;
	f16vec4 c[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	bvec2 d;
	mediump vec4 e;
	bvec3 f[8];
};
layout(std140, buffer_reference) buffer BlockD
{
	i16vec3 g;
	f16vec4 h;
	lowp uvec3 i;
	i16vec3 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(2.0, -8.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.b), ivec2(-4, 7)) && allOk;
	allOk = compare_bvec2((blockC.d), bvec2(true, false)) && allOk;
	allOk = compare_vec4((blockC.e), vec4(1.0, -7.0, 7.0, 5.0)) && allOk;
	allOk = compare_bvec3((blockC.f[0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockC.f[1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockC.f[2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockC.f[3]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockC.f[4]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockC.f[5]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockC.f[6]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockC.f[7]), bvec3(true, true, false)) && allOk;
	allOk = compare_f16vec4(vec4(blockD.h), vec4(9.0, 1.0, 5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(8.0, -2.0));
	blockB.c[0] = f16vec4(vec4(6.0, 0.0, 9.0, 5.0));
	blockB.c[1] = f16vec4(vec4(4.0, 8.0, 6.0, 7.0));
	blockC.f[0] = (bvec3(true, true, false));
	blockC.f[1] = (bvec3(false, false, true));
	blockC.f[2] = (bvec3(false, true, false));
	blockC.f[3] = (bvec3(true, true, true));
	blockC.f[4] = (bvec3(false, false, false));
	blockC.f[5] = (bvec3(false, true, true));
	blockC.f[6] = (bvec3(true, false, false));
	blockC.f[7] = (bvec3(false, false, false));
	blockD.h = f16vec4(vec4(-3.0, -4.0, 4.0, 9.0));
	blockD.i = (uvec3(6u, 4u, 7u));
}
#version 450
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
	highp uvec3 b;
	highp mat3x4 c;
	lowp mat4 d;
	mediump mat3x2 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	int16_t f;
	i16vec2 g[];
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump uint h;
	highp mat4x2 i;
	highp mat3 j;
	float16_t k[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	i16vec2 l;
	f16vec3 m;
	int16_t n[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.b), uvec3(5u, 4u, 9u)) && allOk;
	allOk = compare_mat4(blockB.d, mat4(3.0, 5.0, -1.0, -6.0, 7.0, -9.0, -1.0, 8.0, 5.0, -2.0, -5.0, -7.0, -6.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_int16_t(int(blockC.f), 3) && allOk;
	allOk = compare_uint((blockD.h), 2u) && allOk;
	allOk = compare_mat4x2(blockD.i, mat4x2(5.0, 8.0, -5.0, 7.0, 4.0, -1.0, -2.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.m), vec3(2.0, 5.0, 1.0)) && allOk;
	allOk = compare_int16_t(int(blockE.n[0]), -3) && allOk;
	allOk = compare_int16_t(int(blockE.n[1]), -9) && allOk;
	allOk = compare_int16_t(int(blockE.n[2]), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec3(5u, 4u, 8u));
	blockB.c = (mat3x4(-2.0, -6.0, 4.0, 6.0, 7.0, -5.0, -6.0, 4.0, -7.0, -9.0, 2.0, 6.0));
	blockC.f = int16_t(9);
	blockC.g[0] = i16vec2(ivec2(9, -2));
	blockC.g[1] = i16vec2(ivec2(2, -6));
	blockC.g[2] = i16vec2(ivec2(0, -6));
	blockC.g[3] = i16vec2(ivec2(-6, -4));
	blockD.h = (1u);
	blockD.j = (mat3(2.0, -1.0, 7.0, -1.0, 3.0, 2.0, -8.0, 9.0, -3.0));
	blockD.k[0] = float16_t(8.0);
	blockD.k[1] = float16_t(-7.0);
	blockD.k[2] = float16_t(-9.0);
	blockD.k[3] = float16_t(-5.0);
	blockD.k[4] = float16_t(9.0);
	blockD.k[5] = float16_t(0.0);
	blockE.l = i16vec2(ivec2(-7, 7));
	blockE.m = f16vec3(vec3(7.0, 3.0, -6.0));
}
#version 450
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
	bool a;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp mat4 b;
	highp uvec4 c;
	mediump mat3x4 d;
	lowp mat4x2 e[1];
	bvec4 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockC.c), uvec4(6u, 8u, 1u, 6u)) && allOk;
	allOk = compare_mat3x4(blockC.d, mat3x4(-1.0, 8.0, 8.0, 2.0, 9.0, 4.0, -6.0, -5.0, -5.0, -9.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockC.e[0], mat4x2(3.0, -2.0, -5.0, -4.0, -3.0, 4.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockC.b = (mat4(5.0, -8.0, 6.0, 9.0, 5.0, 3.0, 1.0, -3.0, -3.0, -9.0, 9.0, 6.0, -5.0, 2.0, -5.0, 7.0));
	blockC.c = (uvec4(8u, 0u, 1u, 8u));
	blockC.e[0] = (mat4x2(-3.0, -6.0, 2.0, 4.0, 4.0, -5.0, 4.0, -2.0));
	blockC.f[0] = (bvec4(true, true, true, false));
}
#version 450
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
	mediump ivec4 mA;
	highp mat4x3 mB;
	u16vec3 mC;
	f16vec2 mD;
};
struct sB
{
	mediump ivec3 mA;
	lowp uvec2 mB;
	sA mC;
	mediump mat4 mD;
};
struct sC
{
	highp mat3 mA;
	i16vec2 mB;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	f16vec4 a;
	sB b;
	sC c;
	i16vec3 d[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp uvec2 e;
	mediump mat3x2 f;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a), vec4(-7.0, 3.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(blockB.c.mA, mat3(6.0, -4.0, 8.0, -4.0, -1.0, -9.0, -5.0, 5.0, -5.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.c.mB), ivec2(-4, -6)) && allOk;
	allOk = compare_mat3x2(blockC.f, mat3x2(3.0, 9.0, -4.0, -3.0, -7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec4(vec4(-6.0, -2.0, 3.0, -5.0));
	blockB.b.mA = (ivec3(-4, 5, -9));
	blockB.b.mB = (uvec2(5u, 8u));
	blockB.b.mC.mA = (ivec4(9, 5, -4, -9));
	blockB.b.mC.mB = (mat4x3(-3.0, 7.0, 3.0, 2.0, -7.0, 1.0, 3.0, 2.0, -7.0, 4.0, 9.0, -8.0));
	blockB.b.mC.mC = u16vec3(uvec3(9u, 5u, 1u));
	blockB.b.mC.mD = f16vec2(vec2(4.0, 1.0));
	blockB.b.mD = (mat4(-8.0, -8.0, -1.0, -5.0, 7.0, -5.0, -3.0, -8.0, 6.0, -4.0, -9.0, 8.0, -8.0, -5.0, 1.0, 4.0));
	blockB.d[0] = i16vec3(ivec3(-2, -9, -9));
	blockB.d[1] = i16vec3(ivec3(7, 3, -9));
	blockB.d[2] = i16vec3(ivec3(1, -8, -6));
	blockB.d[3] = i16vec3(ivec3(-7, 3, -6));
	blockB.d[4] = i16vec3(ivec3(6, 6, 0));
	blockC.e = (uvec2(1u, 4u));
	blockC.f = (mat3x2(-8.0, -9.0, -9.0, -7.0, 9.0, -7.0));
}
#version 450
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
	lowp vec4 mA;
	i16vec2 mB;
	lowp uvec4 mC;
};
struct sB
{
	highp mat4x2 mA;
};
struct sC
{
	highp float mA;
	mediump mat2 mB[3];
	sA mC;
	sB mD;
};
struct sD
{
	bvec3 mA;
	f16vec3 mB;
};
struct sE
{
	sD mA;
	lowp float mB[8];
	lowp mat4x3 mC;
};
layout(std140, buffer_reference) buffer BlockB
{
	mediump mat4x2 a;
	lowp mat3x2 b;
	float16_t c;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	sC d;
	sE e;
	lowp uint f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB[0].a, mat4x2(1.0, -8.0, 7.0, -4.0, -9.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockB[1].a, mat4x2(-7.0, 3.0, 0.0, 0.0, 5.0, -8.0, 9.0, 3.0)) && allOk;
	allOk = compare_bvec3((blockC[0].e.mA.mA), bvec3(true, true, false)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[0].e.mA.mB), vec3(2.0, 3.0, 7.0)) && allOk;
	allOk = compare_float((blockC[0].e.mB[0]), -6.0) && allOk;
	allOk = compare_float((blockC[0].e.mB[1]), 7.0) && allOk;
	allOk = compare_float((blockC[0].e.mB[2]), 4.0) && allOk;
	allOk = compare_float((blockC[0].e.mB[3]), -9.0) && allOk;
	allOk = compare_float((blockC[0].e.mB[4]), -6.0) && allOk;
	allOk = compare_float((blockC[0].e.mB[5]), 7.0) && allOk;
	allOk = compare_float((blockC[0].e.mB[6]), -2.0) && allOk;
	allOk = compare_float((blockC[0].e.mB[7]), 3.0) && allOk;
	allOk = compare_mat4x3(blockC[0].e.mC, mat4x3(6.0, 9.0, -1.0, -4.0, 5.0, -9.0, -8.0, 7.0, 8.0, 5.0, -4.0, 7.0)) && allOk;
	allOk = compare_uint((blockC[0].f[0]), 0u) && allOk;
	allOk = compare_uint((blockC[0].f[1]), 4u) && allOk;
	allOk = compare_uint((blockC[0].f[2]), 6u) && allOk;
	allOk = compare_uint((blockC[0].f[3]), 2u) && allOk;
	allOk = compare_uint((blockC[0].f[4]), 8u) && allOk;
	allOk = compare_uint((blockC[0].f[5]), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat4x2(-7.0, 9.0, 6.0, -4.0, -9.0, -3.0, 2.0, -5.0));
	blockB[0].b = (mat3x2(1.0, -9.0, -8.0, 5.0, -1.0, -9.0));
	blockB[0].c = float16_t(-4.0);
	blockB[1].a = (mat4x2(4.0, -6.0, 9.0, -1.0, -2.0, -3.0, 5.0, 6.0));
	blockB[1].b = (mat3x2(0.0, 6.0, 1.0, 8.0, -4.0, -4.0));
	blockB[1].c = float16_t(-4.0);
	blockC[0].e.mA.mA = (bvec3(true, true, true));
	blockC[0].e.mA.mB = f16vec3(vec3(5.0, -6.0, -1.0));
	blockC[0].e.mB[0] = (-9.0);
	blockC[0].e.mB[1] = (-4.0);
	blockC[0].e.mB[2] = (-6.0);
	blockC[0].e.mB[3] = (9.0);
	blockC[0].e.mB[4] = (6.0);
	blockC[0].e.mB[5] = (-8.0);
	blockC[0].e.mB[6] = (-8.0);
	blockC[0].e.mB[7] = (8.0);
	blockC[0].e.mC = (mat4x3(6.0, 0.0, -7.0, -6.0, -9.0, -7.0, 1.0, 2.0, 3.0, -7.0, -5.0, 6.0));
	blockC[0].f[0] = (1u);
	blockC[0].f[1] = (5u);
	blockC[0].f[2] = (9u);
	blockC[0].f[3] = (0u);
	blockC[0].f[4] = (7u);
	blockC[0].f[5] = (1u);
}
#version 450
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
	lowp ivec2 mA;
	mediump vec3 mB;
	mediump float mC;
};
struct sB
{
	highp mat3x4 mA;
	highp vec4 mB[2];
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	sA a;
	lowp uvec4 b;
	sB c;
	i16vec2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a.mA), ivec2(-1, -5)) && allOk;
	allOk = compare_vec3((blockB.a.mB), vec3(-9.0, -9.0, -9.0)) && allOk;
	allOk = compare_float((blockB.a.mC), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec4(5u, 5u, 3u, 9u));
	blockB.c.mA = (mat3x4(9.0, 4.0, 7.0, -7.0, 1.0, -7.0, -4.0, 9.0, -6.0, 9.0, -8.0, 7.0));
	blockB.c.mB[0] = (vec4(-4.0, -2.0, -4.0, 8.0));
	blockB.c.mB[1] = (vec4(-7.0, 8.0, -4.0, -3.0));
	blockB.d[0] = i16vec2(ivec2(-3, 9));
	blockB.d[1] = i16vec2(ivec2(-8, 0));
	blockB.d[2] = i16vec2(ivec2(-4, -2));
}
#version 450
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
	f16vec3 mA;
	lowp ivec4 mB;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	mediump uvec2 a;
	int16_t b;
	f16vec4 c;
	float16_t d;
	mediump mat3x2 e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	mediump ivec3 f;
	highp mat4x2 g;
	mediump ivec4 h[];
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockD
{
	sA i;
	bvec4 j[];
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.b), 5) && allOk;
	allOk = compare_mat3x2(blockB.e[0], mat3x2(-7.0, -1.0, 3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[1], mat3x2(4.0, 2.0, -1.0, 3.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[2], mat3x2(1.0, 9.0, 2.0, 4.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[3], mat3x2(-6.0, 0.0, -6.0, -6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[4], mat3x2(-7.0, -6.0, 8.0, -8.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[5], mat3x2(0.0, 0.0, -1.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[6], mat3x2(2.0, -2.0, 2.0, -4.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockC.g, mat4x2(9.0, -1.0, -3.0, -4.0, 9.0, 1.0, 7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(9u, 0u));
	blockB.b = int16_t(-1);
	blockB.c = f16vec4(vec4(-5.0, -1.0, 5.0, 8.0));
	blockB.e[0] = (mat3x2(6.0, 7.0, 4.0, 3.0, 9.0, 4.0));
	blockB.e[1] = (mat3x2(4.0, -4.0, -8.0, -3.0, -5.0, -2.0));
	blockB.e[2] = (mat3x2(7.0, -6.0, -3.0, 2.0, -2.0, 3.0));
	blockB.e[3] = (mat3x2(-8.0, -4.0, -3.0, -5.0, 5.0, -9.0));
	blockB.e[4] = (mat3x2(3.0, -8.0, 6.0, 5.0, -4.0, 3.0));
	blockB.e[5] = (mat3x2(-2.0, 1.0, 9.0, 7.0, 0.0, -6.0));
	blockB.e[6] = (mat3x2(5.0, 3.0, -2.0, 9.0, -3.0, 9.0));
	blockC.f = (ivec3(7, -9, 1));
	blockC.g = (mat4x2(2.0, 2.0, -8.0, 8.0, -9.0, 4.0, 2.0, 4.0));
}
#version 450
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
	mediump uvec3 a;
	mediump mat3x4 b;
	mediump mat4x2 c;
	i16vec2 d;
	i16vec2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[nonuniformEXT(0)].a), uvec3(4u, 0u, 4u)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(0)].c, mat4x2(7.0, -8.0, 1.0, 5.0, -5.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(1)].a), uvec3(5u, 6u, 9u)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(1)].c, mat4x2(0.0, -4.0, -6.0, -1.0, 5.0, 1.0, -5.0, -8.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(2)].a), uvec3(6u, 7u, 9u)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(2)].c, mat4x2(7.0, -2.0, -9.0, -5.0, -6.0, 4.0, -9.0, -7.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(3)].a), uvec3(9u, 1u, 9u)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(3)].c, mat4x2(-1.0, 7.0, 2.0, 7.0, 7.0, -3.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (mat3x4(0.0, -3.0, 9.0, -5.0, 2.0, 1.0, 8.0, 6.0, 2.0, 9.0, 8.0, 5.0));
	blockB[nonuniformEXT(0)].c = (mat4x2(-5.0, 8.0, -1.0, 7.0, -9.0, -3.0, -1.0, 6.0));
	blockB[nonuniformEXT(0)].e = i16vec2(ivec2(9, -4));
	blockB[nonuniformEXT(1)].b = (mat3x4(-8.0, -4.0, 1.0, -4.0, -4.0, -7.0, -1.0, 9.0, -8.0, 6.0, 2.0, -1.0));
	blockB[nonuniformEXT(1)].c = (mat4x2(0.0, 2.0, -2.0, -1.0, 3.0, 0.0, -8.0, 9.0));
	blockB[nonuniformEXT(1)].e = i16vec2(ivec2(-2, -3));
	blockB[nonuniformEXT(2)].b = (mat3x4(4.0, -6.0, -5.0, -3.0, -5.0, 6.0, 6.0, -1.0, -3.0, -7.0, -3.0, -6.0));
	blockB[nonuniformEXT(2)].c = (mat4x2(-2.0, 0.0, -2.0, -3.0, -8.0, 1.0, 8.0, -6.0));
	blockB[nonuniformEXT(2)].e = i16vec2(ivec2(6, -6));
	blockB[nonuniformEXT(3)].b = (mat3x4(-8.0, 9.0, 5.0, -6.0, -6.0, -1.0, -6.0, -2.0, 3.0, -4.0, 7.0, -6.0));
	blockB[nonuniformEXT(3)].c = (mat4x2(-9.0, -3.0, 1.0, 8.0, 7.0, -9.0, 6.0, -4.0));
	blockB[nonuniformEXT(3)].e = i16vec2(ivec2(5, -1));
}
#version 450
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
	layout(offset = 0) i16vec3 a;
	layout(offset = 16) lowp mat3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockB[nonuniformEXT(0)].a), ivec3(0, 7, 4)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[nonuniformEXT(1)].a), ivec3(-1, -9, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (mat3(-5.0, 8.0, -6.0, -1.0, -8.0, -8.0, -6.0, 1.0, -2.0));
	blockB[nonuniformEXT(1)].b = (mat3(-5.0, 8.0, 3.0, -1.0, 7.0, -2.0, -7.0, -4.0, -2.0));
}
#version 450
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
	lowp vec3 a;
	mediump ivec2 b;
	uint8_t c;
	mediump uvec4 d;
};
layout(std430, buffer_reference) buffer BlockC
{
	int8_t e;
	mediump vec2 f[1];
	lowp ivec2 g[1];
	highp uvec4 h;
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp int i;
	u8vec4 j;
	i8vec2 k;
};
layout(std140, buffer_reference) buffer BlockE
{
	i8vec4 l;
	u8vec4 m;
	u8vec4 n;
	mediump int o;
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(1.0, -3.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(7, -5)) && allOk;
	allOk = compare_uvec4((blockB.d), uvec4(5u, 0u, 3u, 8u)) && allOk;
	allOk = compare_int8_t(int(blockC.e), 5) && allOk;
	allOk = compare_ivec2((blockC.g[0]), ivec2(8, 8)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.j), uvec4(9u, 6u, 1u, 3u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockE.l), ivec4(4294967288, 4294967287, 0, 4294967295)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.m), uvec4(6u, 7u, 3u, 8u)) && allOk;
	allOk = compare_int((blockE.o), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec2(-7, 6));
	blockB.d = (uvec4(4u, 1u, 7u, 5u));
	blockC.e = int8_t(5);
	blockC.f[0] = (vec2(7.0, 9.0));
	blockC.g[0] = (ivec2(-2, 6));
	blockC.h = (uvec4(3u, 7u, 5u, 0u));
	blockD.i = (-3);
	blockD.j = u8vec4(uvec4(5u, 7u, 8u, 3u));
	blockD.k = i8vec2(ivec2(5, 2));
	blockE.m = u8vec4(uvec4(3u, 4u, 8u, 9u));
	blockE.n = u8vec4(uvec4(0u, 2u, 2u, 2u));
	blockE.o = (-7);
}
#version 450
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
	u8vec4 a;
	highp mat4x3 b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp mat2x3 c;
	bvec2 d;
	bvec2 e;
	bvec2 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.a), uvec4(7u, 1u, 2u, 9u)) && allOk;
	allOk = compare_mat2x3(blockC.c, mat2x3(-4.0, 8.0, -7.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_bvec2((blockC.e), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC.f[0]), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat4x3(0.0, 5.0, 9.0, -5.0, 4.0, 7.0, -1.0, 6.0, 5.0, 8.0, 6.0, 2.0));
	blockC.c = (mat2x3(-7.0, -2.0, -4.0, -2.0, 4.0, -2.0));
	blockC.e = (bvec2(true, false));
}
#version 450
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
	mediump mat4x2 b;
	highp mat3x2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.b, mat4x2(4.0, 3.0, -8.0, 3.0, -5.0, -4.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[0], mat3x2(-2.0, -3.0, 6.0, -6.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-7.0);
}
#version 450
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
	int8_t mB;
	bool mC;
};
struct sB
{
	highp uvec4 mA;
	highp mat3x2 mB;
	highp mat3x4 mC;
};
layout(std140, buffer_reference) buffer BlockB
{
	highp vec4 a;
	lowp ivec3 b;
	uint8_t c[1];
	lowp int d;
	highp mat2x3 e;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp int f;
	sA g;
	u8vec2 h[1];
	sB i[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.b), ivec3(1, -7, 1)) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[0]), 6u) && allOk;
	allOk = compare_mat2x3(blockB.e, mat2x3(7.0, 9.0, -8.0, 2.0, 9.0, 6.0)) && allOk;
	allOk = compare_int((blockC.f), -5) && allOk;
	allOk = compare_mat2x3(blockC.g.mA, mat2x3(7.0, 3.0, -3.0, 7.0, 4.0, -2.0)) && allOk;
	allOk = compare_int8_t(int(blockC.g.mB), 9) && allOk;
	allOk = compare_bool((blockC.g.mC), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(2.0, 7.0, -5.0, -4.0));
	blockB.b = (ivec3(-8, -5, 0));
	blockB.c[0] = uint8_t(0u);
	blockC.f = (8);
	blockC.g.mA = (mat2x3(8.0, 0.0, 8.0, -6.0, 5.0, 1.0));
	blockC.g.mB = int8_t(7);
	blockC.g.mC = (false);
}
#version 450
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
	i8vec4 a;
	mediump mat4x3 b;
	i8vec2 c;
	bool d;
};
layout(std430, buffer_reference) buffer BlockC
{
	i8vec2 e;
	int8_t f;
	highp mat4x2 g;
	lowp mat2x3 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB[0].b, mat4x3(-4.0, -5.0, 9.0, -4.0, -6.0, -1.0, -1.0, -2.0, 1.0, 6.0, 5.0, 7.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[0].c), ivec2(4294967294, 4294967292)) && allOk;
	allOk = compare_mat4x3(blockB[1].b, mat4x3(8.0, 0.0, 9.0, -1.0, -1.0, -7.0, 7.0, -4.0, -3.0, 1.0, -4.0, -9.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[1].c), ivec2(1, 4294967292)) && allOk;
	allOk = compare_mat4x3(blockB[2].b, mat4x3(3.0, -5.0, -1.0, -5.0, -1.0, -9.0, -6.0, -9.0, -8.0, 6.0, -2.0, 3.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[2].c), ivec2(7, 2)) && allOk;
	allOk = compare_int8_t(int(blockC.f), 4) && allOk;
	allOk = compare_mat2x3(blockC.h[0], mat2x3(-8.0, -3.0, 8.0, -7.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockC.h[1], mat2x3(2.0, 4.0, 7.0, 4.0, -6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (mat4x3(-6.0, 6.0, -6.0, 3.0, -7.0, 8.0, 5.0, -6.0, -7.0, -2.0, 2.0, 3.0));
	blockB[0].c = i8vec2(ivec2(4294967295, 4));
	blockB[1].b = (mat4x3(8.0, 2.0, -9.0, 0.0, 4.0, 3.0, -1.0, -6.0, -4.0, -5.0, 3.0, -5.0));
	blockB[1].c = i8vec2(ivec2(6, 4294967290));
	blockB[2].b = (mat4x3(2.0, -2.0, 8.0, -1.0, -1.0, 1.0, 7.0, 8.0, 7.0, 0.0, -5.0, 6.0));
	blockB[2].c = i8vec2(ivec2(5, 4294967290));
	blockC.e = i8vec2(ivec2(6, 6));
	blockC.f = int8_t(4294967290);
	blockC.g = (mat4x2(3.0, 2.0, -4.0, 5.0, -9.0, 5.0, -9.0, -5.0));
	blockC.h[0] = (mat2x3(-1.0, -8.0, -7.0, 8.0, 2.0, 8.0));
	blockC.h[1] = (mat2x3(-1.0, -1.0, 3.0, -6.0, 6.0, -1.0));
}
#version 450
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
	highp uvec3 a[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	mediump uvec3 b;
	mediump mat4x3 c[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	mediump vec4 d;
	mediump uvec3 e;
	i8vec3 f;
	mediump mat3 g[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	highp mat3x2 h;
	mediump mat4x3 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a[0]), uvec3(5u, 7u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[1]), uvec3(1u, 4u, 1u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[2]), uvec3(3u, 0u, 5u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[3]), uvec3(9u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[4]), uvec3(9u, 1u, 8u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[5]), uvec3(4u, 5u, 0u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[6]), uvec3(8u, 1u, 4u)) && allOk;
	allOk = compare_uvec3((blockC.b), uvec3(8u, 1u, 0u)) && allOk;
	allOk = compare_mat4x3(blockC.c[0], mat4x3(5.0, 1.0, -8.0, 3.0, 8.0, -3.0, 9.0, -8.0, -1.0, -5.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockC.c[1], mat4x3(-9.0, 7.0, 8.0, 7.0, -6.0, 5.0, 1.0, 0.0, 9.0, -4.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockC.c[2], mat4x3(2.0, -7.0, 8.0, 2.0, 7.0, 3.0, 3.0, -3.0, -1.0, 3.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockE.h, mat3x2(-8.0, 7.0, 9.0, -8.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockE.i[0], mat4x3(-1.0, -9.0, -3.0, 4.0, -9.0, 8.0, 5.0, 8.0, 2.0, 7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockE.i[1], mat4x3(-5.0, -7.0, 2.0, -3.0, 0.0, 3.0, 3.0, 2.0, 2.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockE.i[2], mat4x3(9.0, 6.0, -3.0, 3.0, -9.0, 4.0, 4.0, 2.0, -2.0, -4.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockE.i[3], mat4x3(-7.0, 3.0, -6.0, -7.0, -7.0, 8.0, -4.0, -6.0, -9.0, 4.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockE.i[4], mat4x3(-7.0, -6.0, 0.0, 6.0, 4.0, 9.0, -9.0, 1.0, -2.0, 8.0, -3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (uvec3(7u, 4u, 8u));
	blockB[0].a[1] = (uvec3(3u, 7u, 9u));
	blockB[0].a[2] = (uvec3(2u, 0u, 8u));
	blockB[0].a[3] = (uvec3(7u, 1u, 0u));
	blockB[0].a[4] = (uvec3(8u, 2u, 7u));
	blockB[0].a[5] = (uvec3(5u, 4u, 4u));
	blockB[0].a[6] = (uvec3(2u, 5u, 8u));
	blockC.b = (uvec3(6u, 1u, 4u));
	blockC.c[0] = (mat4x3(0.0, 5.0, -4.0, 6.0, -5.0, -9.0, -5.0, -2.0, -5.0, 5.0, -4.0, 4.0));
	blockC.c[1] = (mat4x3(-3.0, 4.0, -6.0, -8.0, 4.0, -2.0, -8.0, -3.0, -6.0, 9.0, 8.0, -9.0));
	blockC.c[2] = (mat4x3(2.0, 6.0, -5.0, 6.0, 0.0, -4.0, -9.0, -2.0, -9.0, -4.0, -5.0, 7.0));
	blockD.d = (vec4(-1.0, -8.0, 9.0, 2.0));
	blockD.f = i8vec3(ivec3(0, 4294967292, 9));
	blockD.g[0] = (mat3(0.0, -4.0, 2.0, -5.0, 6.0, 7.0, 8.0, -6.0, 8.0));
	blockE.i[0] = (mat4x3(1.0, 6.0, -9.0, -8.0, -7.0, -4.0, 1.0, 0.0, 1.0, -8.0, 1.0, 6.0));
	blockE.i[1] = (mat4x3(0.0, -6.0, -7.0, 2.0, -2.0, -1.0, 3.0, 4.0, 9.0, 6.0, 9.0, -3.0));
	blockE.i[2] = (mat4x3(-1.0, 9.0, -2.0, 7.0, -8.0, 2.0, -6.0, 6.0, 1.0, 1.0, -5.0, 7.0));
	blockE.i[3] = (mat4x3(-9.0, 3.0, 2.0, 9.0, -5.0, 7.0, -8.0, -6.0, -8.0, 6.0, 4.0, -9.0));
	blockE.i[4] = (mat4x3(-7.0, -5.0, 0.0, 0.0, -2.0, -5.0, -7.0, -8.0, -3.0, 8.0, 5.0, -8.0));
}
#version 450
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
	layout(offset = 16) lowp uvec4 b;
	layout(offset = 32) bvec4 c;
	layout(offset = 48) mediump uint d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp int e;
	layout(offset = 4) highp uint f;
	layout(offset = 8) bvec2 g;
	layout(offset = 16) bvec4 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.c), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uint((blockB.d), 4u) && allOk;
	allOk = compare_int((blockC.e), 1) && allOk;
	allOk = compare_uint((blockC.f), 3u) && allOk;
	allOk = compare_bvec2((blockC.g), bvec2(true, false)) && allOk;
	allOk = compare_bvec4((blockC.h), bvec4(true, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(-5.0, -3.0));
	blockB.b = (uvec4(0u, 6u, 8u, 2u));
	blockB.c = (bvec4(true, false, false, false));
	blockB.d = (9u);
	blockC.e = (-7);
	blockC.g = (bvec2(false, true));
}
#version 450
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
	layout(offset = 8) i8vec3 b;
	layout(offset = 11) u8vec3 c;
	layout(offset = 16) mediump ivec3 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) u8vec4 e;
	layout(offset = 4) uint8_t f;
	layout(offset = 5) i8vec2 g;
	layout(offset = 7) u8vec3 h;
	layout(offset = 16) mediump uvec2 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB.b), ivec3(5, 4294967288, 2)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.e), uvec4(3u, 0u, 5u, 5u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.g), ivec2(4294967294, 6)) && allOk;
	allOk = compare_uvec2((blockC.i), uvec2(0u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b = i8vec3(ivec3(4294967295, 3, 4294967289));
	blockB.c = u8vec3(uvec3(8u, 8u, 1u));
	blockB.d = (ivec3(6, -9, -2));
	blockC.e = u8vec4(uvec4(0u, 4u, 0u, 0u));
	blockC.f = uint8_t(6u);
	blockC.g = i8vec2(ivec2(3, 4294967294));
	blockC.h = u8vec3(uvec3(9u, 9u, 4u));
	blockC.i = (uvec2(0u, 7u));
}
#version 450
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
	layout(offset = 0) highp ivec2 a;
	layout(offset = 8) highp uint b;
	layout(offset = 16) bvec4 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(3, 7)) && allOk;
	allOk = compare_uint((blockB.b), 7u) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(true, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(1, -4));
	blockB.b = (0u);
}
#version 450
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
	mediump vec4 a;
	lowp ivec3 b;
	uint8_t c;
	lowp uvec3 d[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	lowp uvec4 e;
	i8vec2 f;
	mediump vec2 g;
	int8_t h;
	lowp ivec3 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.d[0]), uvec3(8u, 7u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.d[1]), uvec3(3u, 9u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.d[2]), uvec3(0u, 5u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.d[3]), uvec3(5u, 0u, 6u)) && allOk;
	allOk = compare_uvec3((blockB.d[4]), uvec3(2u, 5u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.d[5]), uvec3(0u, 0u, 8u)) && allOk;
	allOk = compare_uvec3((blockB.d[6]), uvec3(3u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.d[7]), uvec3(1u, 0u, 7u)) && allOk;
	allOk = compare_vec2((blockC.g), vec2(-4.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(0.0, -7.0, 3.0, 9.0));
	blockB.b = (ivec3(-1, 3, -7));
	blockC.e = (uvec4(3u, 7u, 3u, 8u));
	blockC.g = (vec2(-8.0, -3.0));
	blockC.i[0] = (ivec3(6, -1, -5));
	blockC.i[1] = (ivec3(-7, 0, 5));
	blockC.i[2] = (ivec3(-9, -3, -1));
	blockC.i[3] = (ivec3(0, -3, 0));
	blockC.i[4] = (ivec3(-4, -8, -2));
	blockC.i[5] = (ivec3(2, -6, 3));
}
