#version 450
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
	mediump uvec3 var;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var), uvec3(8u, 5u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (uvec3(6u, 0u, 5u));
}
#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(-4.0, 6.0, 7.0, 6.0, -1.0, -6.0, -5.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(-9.0, 1.0, -5.0, 3.0, -5.0, 8.0, 0.0, 9.0, -8.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -4.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(1.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(5.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(3.0, 0.0, 3.0, 5.0, 3.0, -5.0));
}
#version 450
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

	var[0] = (vec4(-3.0, 9.0, -6.0, 8.0));
	var[1] = (vec4(-2.0, 6.0, 9.0, -3.0));
	var[2] = (vec4(9.0, 2.0, -9.0, -9.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], -3.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_float(var[2][0], 4.0) && allOk;
	allOk = compare_float(var[2][1], -7.0) && allOk;
	allOk = compare_float(var[2][2], -5.0) && allOk;
	allOk = compare_float(var[3][0], -6.0) && allOk;
	allOk = compare_float(var[3][1], 7.0) && allOk;
	allOk = compare_float(var[3][2], 5.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-4.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-4.0, 6.0, -8.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(4.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-6.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(3.0, 8.0, 0.0, 6.0, 1.0, 4.0, -1.0, 4.0, 5.0, 9.0, 6.0, 5.0));
}
#version 450
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
	lowp uvec3 var;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var), uvec3(9u, 0u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (uvec3(7u, 4u, 8u));
}
#version 450
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

	var = (mat3(-1.0, 7.0, 7.0, -3.0, -9.0, 7.0, 9.0, -5.0, 5.0));
}
#version 450
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

	var = (mat2x3(6.0, -5.0, 9.0, 0.0, 5.0, 3.0));
}
#version 450
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

	var = (mat3x4(-6.0, -1.0, 0.0, -8.0, 5.0, 7.0, -2.0, -2.0, -1.0, -7.0, -3.0, -4.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(8.0, -8.0, -2.0, -5.0, 4.0, 3.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(-3.0, 7.0, -8.0, 4.0, -9.0, 2.0, -7.0, -3.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	bool var;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((var), false) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (false);
}
#version 450
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
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat3(var, mat3(9.0, -7.0, 0.0, -4.0, -9.0, 1.0, -9.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0] = (vec3(-9.0, -8.0, 0.0));
	var[1] = (vec3(3.0, 2.0, 6.0));
	var[2] = (vec3(2.0, 0.0, -1.0));
}
#version 450
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_float(var[0][0], 8.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(8.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(6.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var = (mat2x3(0.0, -9.0, 3.0, 6.0, 6.0, -3.0));
}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[2][0], 9.0) && allOk;
	allOk = compare_float(var[2][1], 7.0) && allOk;
	allOk = compare_float(var[3][0], -1.0) && allOk;
	allOk = compare_float(var[3][1], -4.0) && allOk;
	allOk = compare_vec2(var[0], vec2(3.0, 0.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-6.0, -7.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(9.0, 7.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var = (mat4x2(-5.0, 1.0, -6.0, -1.0, -4.0, -5.0, 3.0, 5.0));
}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(-6.0, -8.0, -3.0, 7.0, -7.0, 8.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var[0] = (vec2(-3.0, 5.0));
	var[1] = (vec2(-2.0, -4.0));
	var[2] = (vec2(1.0, -8.0));
	var[3] = (vec2(5.0, -8.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	var[1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	var[2] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	highp mat2x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3], mat2x3(0.0, 9.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(-8.0, 3.0, 8.0, -7.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(8.0, 4.0, -2.0, -2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(7.0, -5.0, -3.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(-9.0, -6.0, 5.0, -2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(8.0, 1.0, 8.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(-1.0, -2.0, -9.0, -1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(-5.0, -6.0, -3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(-3.0, -8.0, -9.0, -8.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(1.0, -6.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(-3.0, 6.0, -4.0, -1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(2.0, -1.0, -8.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(-7.0, 5.0, -9.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(3.0, -4.0, 0.0, -3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(-4.0, -2.0, 6.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(0.0, 0.0, 5.0, 6.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(4.0, 5.0, -6.0));
	var[0][1] = (vec3(0.0, -8.0, -2.0));
	var[1][0] = (vec3(8.0, 8.0, 0.0));
	var[1][1] = (vec3(3.0, -6.0, -6.0));
	var[2][0] = (vec3(-1.0, 2.0, -9.0));
	var[2][1] = (vec3(1.0, 3.0, 2.0));
	var[3][0] = (vec3(1.0, 5.0, -6.0));
	var[3][1] = (vec3(-8.0, -6.0, -5.0));
	var[4][0] = (vec3(-9.0, 6.0, -9.0));
	var[4][1] = (vec3(0.0, -1.0, -3.0));
	var[5][0] = (vec3(-6.0, 9.0, 7.0));
	var[5][1] = (vec3(-5.0, -7.0, -2.0));
	var[6][0] = (vec3(-1.0, -3.0, 0.0));
	var[6][1] = (vec3(3.0, 3.0, 5.0));
	var[7][0] = (vec3(-1.0, -1.0, 3.0));
	var[7][1] = (vec3(-1.0, -7.0, 7.0));
	var[8][0] = (vec3(-6.0, -6.0, -8.0));
	var[8][1] = (vec3(2.0, -4.0, -3.0));
	var[9][0] = (vec3(-3.0, 4.0, 8.0));
	var[9][1] = (vec3(7.0, -2.0, -7.0));
	var[10][0] = (vec3(-5.0, 5.0, -5.0));
	var[10][1] = (vec3(1.0, -1.0, 7.0));
	var[11][0] = (vec3(-5.0, 8.0, -7.0));
	var[11][1] = (vec3(-2.0, 4.0, 3.0));
	var[12][0] = (vec3(-7.0, 8.0, -3.0));
	var[12][1] = (vec3(3.0, 8.0, 1.0));
	var[13][0] = (vec3(3.0, 6.0, 2.0));
	var[13][1] = (vec3(9.0, -2.0, -9.0));
	var[14][0] = (vec3(-9.0, 6.0, -2.0));
	var[14][1] = (vec3(-3.0, -8.0, -5.0));
	var[15][0] = (vec3(-2.0, -5.0, 0.0));
	var[15][1] = (vec3(-9.0, -9.0, -9.0));
	var[16][0] = (vec3(-9.0, -3.0, -1.0));
	var[16][1] = (vec3(7.0, 1.0, 1.0));
	var[17][0] = (vec3(4.0, -2.0, 7.0));
	var[17][1] = (vec3(0.0, 1.0, 9.0));
	var[18][0] = (vec3(-4.0, 0.0, -1.0));
	var[18][1] = (vec3(8.0, 9.0, -4.0));
}
#version 450
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

	var[0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	var[1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	var[2] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
	var[3] = (mat3x4(-9.0, 4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0));
	var[4] = (mat3x4(3.0, 1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0));
	var[5] = (mat3x4(1.0, 5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0));
	var[6] = (mat3x4(-2.0, -7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0));
	var[7] = (mat3x4(-8.0, 8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0));
	var[8] = (mat3x4(6.0, -1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0));
	var[9] = (mat3x4(5.0, 5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0));
	var[10] = (mat3x4(-4.0, 7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0));
	var[11] = (mat3x4(-1.0, 3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0));
	var[12] = (mat3x4(-7.0, 8.0, 5.0, -1.0, 0.0, 6.0, 7.0, -1.0, 3.0, 5.0, -7.0, 2.0));
	var[13] = (mat3x4(9.0, -2.0, -7.0, -4.0, 7.0, 9.0, 9.0, -2.0, -7.0, -3.0, 9.0, 9.0));
	var[14] = (mat3x4(4.0, -7.0, 5.0, -1.0, -8.0, -1.0, -1.0, 1.0, -1.0, 6.0, 6.0, 9.0));
	var[15] = (mat3x4(3.0, 1.0, 7.0, 6.0, 8.0, 1.0, 8.0, -5.0, -5.0, -9.0, -1.0, -9.0));
	var[16] = (mat3x4(-1.0, 6.0, 3.0, -9.0, -4.0, -5.0, 2.0, -2.0, -2.0, -2.0, -2.0, 2.0));
	var[17] = (mat3x4(-7.0, -4.0, 6.0, -9.0, 6.0, -3.0, -9.0, 6.0, 3.0, 2.0, -5.0, -9.0));
	var[18] = (mat3x4(-5.0, 9.0, -5.0, 5.0, -4.0, 7.0, 7.0, -1.0, -9.0, 8.0, 2.0, -5.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	u16vec4 var[4][3];
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(var[0][0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][0]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][1]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][2]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][0]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][1]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][2]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][0]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][1]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][2]), uvec4(7u, 0u, 8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	var[0][1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	var[0][2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	var[1][0] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	var[1][1] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	var[1][2] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	var[2][0] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	var[2][1] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	var[2][2] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	var[3][0] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	var[3][1] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	var[3][2] = u16vec4(uvec4(1u, 8u, 4u, 7u));
}
#version 450
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
	bvec2 var[4][3];
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((var[0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[1][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[2][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[2][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[2][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[3][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][2]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (bvec2(true, false));
	var[0][1] = (bvec2(true, true));
	var[0][2] = (bvec2(false, false));
	var[1][0] = (bvec2(false, false));
	var[1][1] = (bvec2(false, true));
	var[1][2] = (bvec2(true, true));
	var[2][0] = (bvec2(false, false));
	var[2][1] = (bvec2(false, true));
	var[2][2] = (bvec2(true, true));
	var[3][0] = (bvec2(false, false));
	var[3][1] = (bvec2(true, false));
	var[3][2] = (bvec2(true, false));
}
#version 450
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
	allOk = compare_mat2x3(var[0][0], mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(-6.0, 8.0, -3.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(6.0, -2.0, -7.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(7.0, -3.0, 2.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(7.0, -9.0, 0.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(5.0, 3.0, 9.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(5.0, -3.0, 6.0, 8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(9.0, 5.0, 6.0, 7.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(1.0, 9.0, 5.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(1.0, 6.0, -5.0, 7.0, -3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(0.0, 5.0, 5.0));
	var[0][0][1] = (vec3(0.0, -7.0, 8.0));
	var[0][1][0] = (vec3(-7.0, -4.0, 6.0));
	var[0][1][1] = (vec3(1.0, 3.0, 2.0));
	var[0][2][0] = (vec3(-6.0, 5.0, 2.0));
	var[0][2][1] = (vec3(1.0, 8.0, -8.0));
	var[1][0][0] = (vec3(2.0, -7.0, 5.0));
	var[1][0][1] = (vec3(-4.0, -6.0, -9.0));
	var[1][1][0] = (vec3(3.0, 0.0, -7.0));
	var[1][1][1] = (vec3(2.0, -4.0, 1.0));
	var[1][2][0] = (vec3(-2.0, -2.0, -5.0));
	var[1][2][1] = (vec3(2.0, 5.0, 4.0));
	var[2][0][0] = (vec3(4.0, -1.0, 7.0));
	var[2][0][1] = (vec3(9.0, -2.0, -4.0));
	var[2][1][0] = (vec3(8.0, -4.0, 2.0));
	var[2][1][1] = (vec3(5.0, -1.0, -3.0));
	var[2][2][0] = (vec3(3.0, -2.0, -8.0));
	var[2][2][1] = (vec3(6.0, 0.0, 9.0));
	var[3][0][0] = (vec3(1.0, -5.0, -1.0));
	var[3][0][1] = (vec3(-6.0, -6.0, 3.0));
	var[3][1][0] = (vec3(1.0, -8.0, -5.0));
	var[3][1][1] = (vec3(8.0, 5.0, 8.0));
	var[3][2][0] = (vec3(5.0, 5.0, 7.0));
	var[3][2][1] = (vec3(-9.0, 8.0, 0.0));
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat4(var[0][0], mat4(-3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0, -2.0, -9.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0, 0.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0, 4.0, 2.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0, -1.0, 7.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0, 0.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0, -3.0, -4.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(-2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0, -6.0, 6.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0, -3.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(-1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0, -1.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0, -4.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0, 2.0, 5.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(-6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0, -5.0, 3.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0][0] = (mat4(7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0, 8.0, 6.0, 5.0, -7.0));
	var[0][1] = (mat4(2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0, -6.0, -1.0, 8.0, 8.0));
	var[0][2] = (mat4(9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0, -2.0, 0.0, -2.0, -3.0));
	var[1][0] = (mat4(-1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0, 1.0, -5.0, 0.0, 4.0));
	var[1][1] = (mat4(5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0, 7.0, 2.0, 2.0, -6.0));
	var[1][2] = (mat4(-1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0, 0.0, -6.0, 3.0, 7.0));
	var[2][0] = (mat4(3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0, 9.0, -3.0, -6.0, 3.0));
	var[2][1] = (mat4(-1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0, -3.0, 1.0, 4.0, -6.0));
	var[2][2] = (mat4(-4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0, -5.0, 3.0, -8.0, -5.0));
	var[3][0] = (mat4(-7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0, 2.0, 1.0, 1.0, -4.0));
	var[3][1] = (mat4(4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0, -3.0, 2.0, -2.0, 6.0));
	var[3][2] = (mat4(-1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0, -9.0, 7.0, 7.0, 4.0));
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4(var[0][0], mat4(8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(-3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(-2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(-3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(-1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(-2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(-4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(-9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var[0][0][0] = (vec4(-2.0, 7.0, -7.0, 2.0));
	var[0][0][1] = (vec4(-4.0, 3.0, -5.0, 2.0));
	var[0][0][2] = (vec4(3.0, 8.0, 8.0, 3.0));
	var[0][0][3] = (vec4(0.0, -4.0, -1.0, -3.0));
	var[0][1][0] = (vec4(0.0, 8.0, 1.0, -8.0));
	var[0][1][1] = (vec4(9.0, 2.0, 7.0, -2.0));
	var[0][1][2] = (vec4(-7.0, -9.0, 1.0, 6.0));
	var[0][1][3] = (vec4(-9.0, -1.0, -5.0, -6.0));
	var[0][2][0] = (vec4(-3.0, 7.0, -1.0, 0.0));
	var[0][2][1] = (vec4(-1.0, -2.0, 1.0, -3.0));
	var[0][2][2] = (vec4(-1.0, -4.0, 7.0, -3.0));
	var[0][2][3] = (vec4(1.0, 1.0, -9.0, -3.0));
	var[1][0][0] = (vec4(2.0, 9.0, -4.0, 2.0));
	var[1][0][1] = (vec4(9.0, -9.0, -2.0, -1.0));
	var[1][0][2] = (vec4(1.0, -9.0, 0.0, -7.0));
	var[1][0][3] = (vec4(7.0, -3.0, -9.0, -1.0));
	var[1][1][0] = (vec4(0.0, 7.0, 7.0, -5.0));
	var[1][1][1] = (vec4(-2.0, -6.0, 0.0, -2.0));
	var[1][1][2] = (vec4(1.0, -2.0, 4.0, 4.0));
	var[1][1][3] = (vec4(0.0, 0.0, -2.0, 4.0));
	var[1][2][0] = (vec4(7.0, -5.0, -3.0, 9.0));
	var[1][2][1] = (vec4(1.0, 5.0, 5.0, 9.0));
	var[1][2][2] = (vec4(-4.0, -6.0, 8.0, 1.0));
	var[1][2][3] = (vec4(-5.0, 5.0, -3.0, -4.0));
	var[2][0][0] = (vec4(-3.0, 4.0, -8.0, -2.0));
	var[2][0][1] = (vec4(0.0, -8.0, 2.0, -3.0));
	var[2][0][2] = (vec4(-5.0, 3.0, -2.0, -9.0));
	var[2][0][3] = (vec4(-8.0, -3.0, 5.0, -9.0));
	var[2][1][0] = (vec4(6.0, -6.0, 7.0, -8.0));
	var[2][1][1] = (vec4(2.0, 7.0, -5.0, 0.0));
	var[2][1][2] = (vec4(-4.0, -7.0, 6.0, 0.0));
	var[2][1][3] = (vec4(0.0, 4.0, -5.0, -1.0));
	var[2][2][0] = (vec4(-9.0, -7.0, 5.0, 3.0));
	var[2][2][1] = (vec4(9.0, -8.0, -6.0, -3.0));
	var[2][2][2] = (vec4(6.0, -9.0, 4.0, 6.0));
	var[2][2][3] = (vec4(-6.0, -6.0, -2.0, -8.0));
	var[3][0][0] = (vec4(-3.0, -8.0, 5.0, 6.0));
	var[3][0][1] = (vec4(-9.0, -7.0, -7.0, 6.0));
	var[3][0][2] = (vec4(1.0, 0.0, -3.0, 4.0));
	var[3][0][3] = (vec4(1.0, -7.0, 4.0, 6.0));
	var[3][1][0] = (vec4(4.0, 3.0, -5.0, -8.0));
	var[3][1][1] = (vec4(0.0, -2.0, 7.0, 5.0));
	var[3][1][2] = (vec4(-1.0, -3.0, -2.0, -6.0));
	var[3][1][3] = (vec4(-9.0, -3.0, 5.0, 8.0));
	var[3][2][0] = (vec4(7.0, -4.0, 1.0, 6.0));
	var[3][2][1] = (vec4(-9.0, 8.0, 3.0, -6.0));
	var[3][2][2] = (vec4(-7.0, 7.0, -1.0, -7.0));
	var[3][2][3] = (vec4(6.0, -5.0, 9.0, -3.0));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-8.0, 3.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(0.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(-1.0, 2.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-8.0, 0.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-4.0, 3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(-3.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(3.0, 2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-9.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(-9.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(-8.0, -2.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(-1.0, 2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(-6.0, -9.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(-2.0, 1.0));
	var[0][0][0][1] = (vec2(-7.0, -1.0));
	var[0][0][1][0] = (vec2(5.0, -3.0));
	var[0][0][1][1] = (vec2(4.0, 8.0));
	var[0][0][2][0] = (vec2(-2.0, -6.0));
	var[0][0][2][1] = (vec2(-5.0, -1.0));
	var[0][1][0][0] = (vec2(-7.0, 2.0));
	var[0][1][0][1] = (vec2(-9.0, 3.0));
	var[0][1][1][0] = (vec2(7.0, 9.0));
	var[0][1][1][1] = (vec2(-8.0, 3.0));
	var[0][1][2][0] = (vec2(-8.0, -9.0));
	var[0][1][2][1] = (vec2(3.0, -5.0));
	var[1][0][0][0] = (vec2(3.0, 4.0));
	var[1][0][0][1] = (vec2(-8.0, 6.0));
	var[1][0][1][0] = (vec2(6.0, -2.0));
	var[1][0][1][1] = (vec2(1.0, 3.0));
	var[1][0][2][0] = (vec2(2.0, 1.0));
	var[1][0][2][1] = (vec2(7.0, -2.0));
	var[1][1][0][0] = (vec2(7.0, 8.0));
	var[1][1][0][1] = (vec2(-8.0, 4.0));
	var[1][1][1][0] = (vec2(-4.0, 7.0));
	var[1][1][1][1] = (vec2(-4.0, -8.0));
	var[1][1][2][0] = (vec2(1.0, 0.0));
	var[1][1][2][1] = (vec2(0.0, -9.0));
	var[2][0][0][0] = (vec2(-4.0, 2.0));
	var[2][0][0][1] = (vec2(-1.0, -4.0));
	var[2][0][1][0] = (vec2(-5.0, -8.0));
	var[2][0][1][1] = (vec2(3.0, -7.0));
	var[2][0][2][0] = (vec2(5.0, 0.0));
	var[2][0][2][1] = (vec2(-4.0, -9.0));
	var[2][1][0][0] = (vec2(-4.0, 7.0));
	var[2][1][0][1] = (vec2(4.0, 1.0));
	var[2][1][1][0] = (vec2(-1.0, -7.0));
	var[2][1][1][1] = (vec2(-5.0, 1.0));
	var[2][1][2][0] = (vec2(-1.0, 7.0));
	var[2][1][2][1] = (vec2(0.0, 9.0));
	var[3][0][0][0] = (vec2(9.0, 1.0));
	var[3][0][0][1] = (vec2(7.0, 9.0));
	var[3][0][1][0] = (vec2(1.0, 3.0));
	var[3][0][1][1] = (vec2(-3.0, 7.0));
	var[3][0][2][0] = (vec2(1.0, 5.0));
	var[3][0][2][1] = (vec2(4.0, 1.0));
	var[3][1][0][0] = (vec2(-6.0, 1.0));
	var[3][1][0][1] = (vec2(-3.0, 1.0));
	var[3][1][1][0] = (vec2(2.0, -1.0));
	var[3][1][1][1] = (vec2(-3.0, 3.0));
	var[3][1][2][0] = (vec2(-3.0, -6.0));
	var[3][1][2][1] = (vec2(3.0, 2.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	i8vec3 var[4][2][3];
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(var[0][0][0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][0][1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][0][2]), ivec3(7, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][1][0]), ivec3(7, 1, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][1][1]), ivec3(4294967294, 5, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][1][2]), ivec3(4294967295, 1, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][0][0]), ivec3(5, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][0][1]), ivec3(9, 0, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][0][2]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][1][0]), ivec3(4294967292, 7, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][1][1]), ivec3(4294967290, 4294967291, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][1][2]), ivec3(9, 4294967290, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][0][0]), ivec3(4294967289, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][0][1]), ivec3(8, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][0][2]), ivec3(2, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][1][0]), ivec3(1, 4294967293, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][1][1]), ivec3(4294967289, 4294967289, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][1][2]), ivec3(3, 4294967288, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][0][0]), ivec3(1, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][0][1]), ivec3(9, 7, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][0][2]), ivec3(2, 4294967294, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][1][0]), ivec3(3, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][1][1]), ivec3(4294967292, 3, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3][1][2]), ivec3(4294967295, 4294967291, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i8vec3(ivec3(4294967292, 0, 0));
	var[0][0][1] = i8vec3(ivec3(7, 9, 4294967290));
	var[0][0][2] = i8vec3(ivec3(4294967288, 9, 4294967288));
	var[0][1][0] = i8vec3(ivec3(7, 4294967293, 7));
	var[0][1][1] = i8vec3(ivec3(4294967293, 4294967288, 2));
	var[0][1][2] = i8vec3(ivec3(4294967287, 4294967295, 4294967293));
	var[1][0][0] = i8vec3(ivec3(4294967293, 3, 4294967295));
	var[1][0][1] = i8vec3(ivec3(9, 7, 5));
	var[1][0][2] = i8vec3(ivec3(5, 4294967293, 6));
	var[1][1][0] = i8vec3(ivec3(4294967292, 4294967290, 4294967295));
	var[1][1][1] = i8vec3(ivec3(4294967287, 1, 4294967288));
	var[1][1][2] = i8vec3(ivec3(4294967291, 8, 6));
	var[2][0][0] = i8vec3(ivec3(4294967293, 4294967295, 3));
	var[2][0][1] = i8vec3(ivec3(5, 4294967292, 4294967295));
	var[2][0][2] = i8vec3(ivec3(4294967293, 8, 4294967290));
	var[2][1][0] = i8vec3(ivec3(4294967288, 4, 8));
	var[2][1][1] = i8vec3(ivec3(4294967288, 4294967293, 1));
	var[2][1][2] = i8vec3(ivec3(4294967290, 4294967289, 6));
	var[3][0][0] = i8vec3(ivec3(3, 7, 4));
	var[3][0][1] = i8vec3(ivec3(4294967292, 8, 8));
	var[3][0][2] = i8vec3(ivec3(4294967294, 8, 1));
	var[3][1][0] = i8vec3(ivec3(4294967295, 4294967289, 1));
	var[3][1][1] = i8vec3(ivec3(4294967292, 4294967295, 4294967292));
	var[3][1][2] = i8vec3(ivec3(4294967287, 1, 8));
}
#version 450
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
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(6.0, 7.0, 9.0, 7.0, 0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(7.0, -7.0, 1.0, 0.0, -9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(-2.0, -2.0, 7.0, -9.0, 3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(-9.0, 0.0, -2.0, -3.0, 4.0, -7.0, 8.0, -2.0, -7.0, -1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(0.0, 8.0, -8.0, -9.0, 5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(9.0, -4.0, -6.0, 0.0, 0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(6.0, 7.0, 1.0, 5.0, 4.0, 9.0, 5.0, 4.0, 9.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(1.0, 0.0, -7.0, -4.0, -3.0, 3.0, -7.0, 4.0, 1.0, 0.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(5.0, 2.0, -1.0, 1.0, 1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(-5.0, 1.0, 4.0, 5.0, 5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-1.0, 9.0, 4.0, -7.0, -2.0, 8.0, 8.0, 5.0, 3.0, -7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(-8.0, -3.0, 1.0, -8.0, -6.0, 9.0, 2.0, 4.0, 4.0, 1.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	var[0][0][0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	var[0][0][0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	var[0][0][1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	var[0][0][1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	var[0][0][1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	var[0][1][0][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	var[0][1][0][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	var[0][1][0][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	var[0][1][1][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	var[0][1][1][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	var[0][1][1][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	var[0][2][0][0] = (vec4(6.0, 2.0, 8.0, -5.0));
	var[0][2][0][1] = (vec4(9.0, 5.0, 9.0, -1.0));
	var[0][2][0][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[0][2][1][0] = (vec4(0.0, -4.0, 7.0, 1.0));
	var[0][2][1][1] = (vec4(4.0, 1.0, 9.0, 9.0));
	var[0][2][1][2] = (vec4(-9.0, -5.0, 3.0, 8.0));
	var[0][3][0][0] = (vec4(1.0, -1.0, -4.0, 2.0));
	var[0][3][0][1] = (vec4(5.0, 8.0, 5.0, -9.0));
	var[0][3][0][2] = (vec4(7.0, -9.0, 0.0, -3.0));
	var[0][3][1][0] = (vec4(-6.0, 6.0, -6.0, -5.0));
	var[0][3][1][1] = (vec4(5.0, 3.0, 4.0, 8.0));
	var[0][3][1][2] = (vec4(7.0, 0.0, -5.0, -6.0));
	var[1][0][0][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	var[1][0][0][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	var[1][0][0][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	var[1][0][1][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	var[1][0][1][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	var[1][0][1][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	var[1][1][0][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	var[1][1][0][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	var[1][1][0][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	var[1][1][1][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	var[1][1][1][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	var[1][1][1][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	var[1][2][0][0] = (vec4(4.0, -1.0, -2.0, 2.0));
	var[1][2][0][1] = (vec4(-5.0, 4.0, -2.0, -4.0));
	var[1][2][0][2] = (vec4(8.0, -7.0, -1.0, -9.0));
	var[1][2][1][0] = (vec4(8.0, 5.0, 3.0, 6.0));
	var[1][2][1][1] = (vec4(0.0, 6.0, 0.0, 2.0));
	var[1][2][1][2] = (vec4(-1.0, -5.0, -6.0, -4.0));
	var[1][3][0][0] = (vec4(5.0, 0.0, 8.0, 4.0));
	var[1][3][0][1] = (vec4(3.0, -1.0, -7.0, 0.0));
	var[1][3][0][2] = (vec4(-1.0, 6.0, -6.0, 1.0));
	var[1][3][1][0] = (vec4(0.0, 8.0, 0.0, 9.0));
	var[1][3][1][1] = (vec4(-6.0, 8.0, -5.0, -1.0));
	var[1][3][1][2] = (vec4(0.0, 6.0, -9.0, 9.0));
	var[2][0][0][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	var[2][0][0][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	var[2][0][0][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	var[2][0][1][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	var[2][0][1][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	var[2][0][1][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	var[2][1][0][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	var[2][1][0][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	var[2][1][0][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	var[2][1][1][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	var[2][1][1][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	var[2][1][1][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
	var[2][2][0][0] = (vec4(-3.0, -5.0, -4.0, -4.0));
	var[2][2][0][1] = (vec4(-8.0, -8.0, 1.0, 7.0));
	var[2][2][0][2] = (vec4(-6.0, -3.0, -7.0, 1.0));
	var[2][2][1][0] = (vec4(-5.0, 5.0, 0.0, 1.0));
	var[2][2][1][1] = (vec4(6.0, 2.0, 5.0, 5.0));
	var[2][2][1][2] = (vec4(5.0, -1.0, -7.0, -1.0));
	var[2][3][0][0] = (vec4(8.0, -2.0, -5.0, 0.0));
	var[2][3][0][1] = (vec4(1.0, 4.0, -3.0, -6.0));
	var[2][3][0][2] = (vec4(2.0, -2.0, -2.0, 3.0));
	var[2][3][1][0] = (vec4(-5.0, -4.0, -6.0, 2.0));
	var[2][3][1][1] = (vec4(-6.0, 0.0, 1.0, 9.0));
	var[2][3][1][2] = (vec4(2.0, 5.0, -8.0, 5.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	i16vec4 var[][4][2];
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(var[0][0][0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][0][1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][1][0]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][1][1]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][2][0]), ivec4(3, -5, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][2][1]), ivec4(6, 3, 6, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][3][0]), ivec4(4, -6, 5, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][3][1]), ivec4(5, -2, 3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][0][0]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][0][1]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][1][0]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][1][1]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][2][0]), ivec4(9, -8, -9, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][2][1]), ivec4(-9, -3, -3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][3][0]), ivec4(0, 5, -8, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][3][1]), ivec4(-6, 7, 7, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][0][0]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][0][1]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][1][0]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][1][1]), ivec4(4, 8, -6, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][2][0]), ivec4(-7, -4, 3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][2][1]), ivec4(-4, 5, -2, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][3][0]), ivec4(-5, 7, 3, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][3][1]), ivec4(-4, 7, 8, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i16vec4(ivec4(-4, -8, -4, 9));
	var[0][0][1] = i16vec4(ivec4(2, 7, -4, 4));
	var[0][1][0] = i16vec4(ivec4(-9, -1, -8, -1));
	var[0][1][1] = i16vec4(ivec4(-1, -6, 5, 2));
	var[0][2][0] = i16vec4(ivec4(7, -1, 8, -5));
	var[0][2][1] = i16vec4(ivec4(-9, -6, -2, -2));
	var[0][3][0] = i16vec4(ivec4(7, 6, 4, -1));
	var[0][3][1] = i16vec4(ivec4(8, 3, 4, 5));
	var[1][0][0] = i16vec4(ivec4(8, 9, 5, 1));
	var[1][0][1] = i16vec4(ivec4(-3, 3, 8, 7));
	var[1][1][0] = i16vec4(ivec4(-3, 8, -7, -2));
	var[1][1][1] = i16vec4(ivec4(9, 7, 6, -9));
	var[1][2][0] = i16vec4(ivec4(-3, 8, 7, -4));
	var[1][2][1] = i16vec4(ivec4(-2, 0, 6, -2));
	var[1][3][0] = i16vec4(ivec4(-3, 5, -8, -5));
	var[1][3][1] = i16vec4(ivec4(9, 3, -3, 9));
	var[2][0][0] = i16vec4(ivec4(2, 6, -9, 9));
	var[2][0][1] = i16vec4(ivec4(-2, 4, -8, -7));
	var[2][1][0] = i16vec4(ivec4(5, -3, 8, 5));
	var[2][1][1] = i16vec4(ivec4(-6, -9, -6, 2));
	var[2][2][0] = i16vec4(ivec4(6, -5, -6, -3));
	var[2][2][1] = i16vec4(ivec4(4, -4, -4, 9));
	var[2][3][0] = i16vec4(ivec4(1, -5, 8, -2));
	var[2][3][1] = i16vec4(ivec4(7, -6, -6, 0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	highp uvec3 var[][4][2];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var[0][0][0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((var[0][0][1]), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((var[0][1][0]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((var[0][1][1]), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((var[0][2][0]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((var[0][2][1]), uvec3(5u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((var[0][3][0]), uvec3(9u, 3u, 7u)) && allOk;
	allOk = compare_uvec3((var[0][3][1]), uvec3(5u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[1][0][0]), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_uvec3((var[1][0][1]), uvec3(6u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((var[1][1][0]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[1][1][1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[1][2][0]), uvec3(6u, 6u, 8u)) && allOk;
	allOk = compare_uvec3((var[1][2][1]), uvec3(6u, 7u, 9u)) && allOk;
	allOk = compare_uvec3((var[1][3][0]), uvec3(2u, 3u, 3u)) && allOk;
	allOk = compare_uvec3((var[1][3][1]), uvec3(1u, 4u, 9u)) && allOk;
	allOk = compare_uvec3((var[2][0][0]), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((var[2][0][1]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((var[2][1][0]), uvec3(8u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((var[2][1][1]), uvec3(7u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((var[2][2][0]), uvec3(0u, 0u, 6u)) && allOk;
	allOk = compare_uvec3((var[2][2][1]), uvec3(0u, 2u, 2u)) && allOk;
	allOk = compare_uvec3((var[2][3][0]), uvec3(7u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((var[2][3][1]), uvec3(7u, 0u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (uvec3(3u, 5u, 6u));
	var[0][0][1] = (uvec3(5u, 4u, 5u));
	var[0][1][0] = (uvec3(9u, 4u, 3u));
	var[0][1][1] = (uvec3(5u, 8u, 0u));
	var[0][2][0] = (uvec3(1u, 1u, 6u));
	var[0][2][1] = (uvec3(3u, 9u, 4u));
	var[0][3][0] = (uvec3(4u, 8u, 7u));
	var[0][3][1] = (uvec3(1u, 5u, 2u));
	var[1][0][0] = (uvec3(4u, 9u, 4u));
	var[1][0][1] = (uvec3(4u, 7u, 7u));
	var[1][1][0] = (uvec3(5u, 4u, 6u));
	var[1][1][1] = (uvec3(7u, 7u, 5u));
	var[1][2][0] = (uvec3(9u, 7u, 9u));
	var[1][2][1] = (uvec3(1u, 4u, 6u));
	var[1][3][0] = (uvec3(4u, 1u, 2u));
	var[1][3][1] = (uvec3(6u, 5u, 3u));
	var[2][0][0] = (uvec3(0u, 2u, 9u));
	var[2][0][1] = (uvec3(4u, 7u, 8u));
	var[2][1][0] = (uvec3(3u, 7u, 0u));
	var[2][1][1] = (uvec3(8u, 1u, 2u));
	var[2][2][0] = (uvec3(4u, 9u, 3u));
	var[2][2][1] = (uvec3(4u, 3u, 5u));
	var[2][3][0] = (uvec3(8u, 8u, 7u));
	var[2][3][1] = (uvec3(1u, 2u, 5u));
}
#version 450
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
	S s;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s.a), ivec3(4, -5, -6)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(8.0, -8.0, 8.0, 0.0, 4.0, 5.0, 3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(2.0, -8.0, 0.0, 6.0, 0.0, 9.0, 1.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(2.0, -8.0, 4.0, 8.0, 5.0, 8.0, 7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(1.0, -3.0, -2.0, 0.0, 6.0, -9.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(4.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(4, -4, 7)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-4.0, 7.0, 6.0, -2.0, -3.0, 6.0, -6.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-3.0, -1.0, 4.0, -2.0, 1.0, -5.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(3.0, 0.0, 8.0, -3.0, -5.0, -3.0, -5.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-9.0, -2.0, -4.0, -2.0, -9.0, -5.0, -6.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(7.0, 4.0, 6.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-7, -1, 8)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(5.0, 5.0, -4.0, 8.0, 0.0, 8.0, -6.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-3.0, 5.0, 9.0, 4.0, 1.0, 3.0, 4.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(1.0, -2.0, -6.0, -3.0, -2.0, -2.0, -1.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-7.0, 6.0, -9.0, 0.0, 9.0, 3.0, 7.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(5.0, 5.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(5, -9, -8));
	block[0].s.b[0][0] = (vec3(1.0, 8.0, -1.0));
	block[0].s.b[0][1] = (vec3(4.0, -7.0, 5.0));
	block[0].s.b[0][2] = (vec3(5.0, 1.0, -2.0));
	block[0].s.b[1][0] = (vec3(7.0, 4.0, 3.0));
	block[0].s.b[1][1] = (vec3(-4.0, 2.0, 4.0));
	block[0].s.b[1][2] = (vec3(9.0, 2.0, -3.0));
	block[0].s.b[2][0] = (vec3(1.0, 9.0, 4.0));
	block[0].s.b[2][1] = (vec3(9.0, 2.0, -4.0));
	block[0].s.b[2][2] = (vec3(4.0, 3.0, -1.0));
	block[0].s.b[3][0] = (vec3(4.0, -3.0, 1.0));
	block[0].s.b[3][1] = (vec3(2.0, 2.0, -9.0));
	block[0].s.b[3][2] = (vec3(-2.0, -8.0, -7.0));
	block[0].s.c = (vec4(6.0, 8.0, -1.0, 8.0));
	block[1].s.a = (ivec3(-2, -4, 0));
	block[1].s.b[0][0] = (vec3(7.0, -3.0, -1.0));
	block[1].s.b[0][1] = (vec3(-7.0, -2.0, 5.0));
	block[1].s.b[0][2] = (vec3(-1.0, 8.0, 0.0));
	block[1].s.b[1][0] = (vec3(1.0, 9.0, -4.0));
	block[1].s.b[1][1] = (vec3(3.0, -2.0, -5.0));
	block[1].s.b[1][2] = (vec3(6.0, -9.0, -8.0));
	block[1].s.b[2][0] = (vec3(4.0, -6.0, -8.0));
	block[1].s.b[2][1] = (vec3(-5.0, -2.0, 8.0));
	block[1].s.b[2][2] = (vec3(8.0, -2.0, 4.0));
	block[1].s.b[3][0] = (vec3(7.0, 2.0, -8.0));
	block[1].s.b[3][1] = (vec3(-6.0, -4.0, 0.0));
	block[1].s.b[3][2] = (vec3(2.0, 9.0, -8.0));
	block[1].s.c = (vec4(2.0, 2.0, 1.0, -4.0));
	block[2].s.a = (ivec3(-7, -3, 1));
	block[2].s.b[0][0] = (vec3(2.0, 9.0, 1.0));
	block[2].s.b[0][1] = (vec3(5.0, 1.0, -5.0));
	block[2].s.b[0][2] = (vec3(8.0, -2.0, -7.0));
	block[2].s.b[1][0] = (vec3(6.0, 2.0, -8.0));
	block[2].s.b[1][1] = (vec3(-1.0, -9.0, -8.0));
	block[2].s.b[1][2] = (vec3(-2.0, 5.0, 7.0));
	block[2].s.b[2][0] = (vec3(3.0, 2.0, -9.0));
	block[2].s.b[2][1] = (vec3(-2.0, 0.0, 6.0));
	block[2].s.b[2][2] = (vec3(4.0, -3.0, 3.0));
	block[2].s.b[3][0] = (vec3(-7.0, 0.0, 2.0));
	block[2].s.b[3][1] = (vec3(2.0, 2.0, 4.0));
	block[2].s.b[3][2] = (vec3(2.0, -3.0, -8.0));
	block[2].s.c = (vec4(-4.0, 4.0, -2.0, -3.0));
}
#version 450
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
	bvec3 a;
	highp mat2 b;
	mediump mat2 c;
	lowp int d;
	lowp mat3x2 e;
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp mat3 f;
	lowp uvec4 g[1];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	mediump mat4 h;
	bvec4 i;
	mediump mat4x3 j;
	mediump int k;
} blockD;
layout(std430, row_major, binding = 4) buffer BlockE
{
	mediump mat3x2 l[1];
	mediump uvec3 m;
	lowp mat3x4 n;
	lowp uvec3 o[1];
	lowp vec4 p;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(b, mat2(-5.0, 9.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(e, mat3x2(5.0, 7.0, -2.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3(f, mat3(3.0, 1.0, 9.0, 0.0, 8.0, -1.0, 2.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat4(blockD.h, mat4(1.0, -4.0, 6.0, -1.0, -4.0, 0.0, 2.0, -5.0, -9.0, 2.0, 3.0, -1.0, 1.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_bvec4((blockD.i), bvec4(true, true, true, false)) && allOk;
	allOk = compare_mat4x3(blockD.j, mat4x3(2.0, 4.0, -2.0, -7.0, 8.0, -8.0, -2.0, -9.0, -2.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_int((blockD.k), 0) && allOk;
	allOk = compare_mat3x2(l[0], mat3x2(-8.0, -7.0, -3.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_uvec3((m), uvec3(8u, 7u, 5u)) && allOk;
	allOk = compare_mat3x4(n, mat3x4(4.0, 5.0, -2.0, -9.0, -6.0, -7.0, 6.0, -5.0, -8.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_uvec3((o[0]), uvec3(7u, 0u, 2u)) && allOk;
	allOk = compare_vec4((p), vec4(-9.0, 7.0, 6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec3(true, true, true));
	b = (mat2(-6.0, 3.0, -7.0, 8.0));
	c = (mat2(5.0, -6.0, -7.0, -2.0));
	d = (2);
	e = (mat3x2(3.0, -1.0, 4.0, -4.0, -6.0, -7.0));
	f = (mat3(-7.0, 2.0, 4.0, -4.0, -9.0, 3.0, 8.0, 0.0, -1.0));
	g[0] = (uvec4(0u, 5u, 5u, 4u));
	blockD.h = (mat4(-5.0, -8.0, -5.0, -1.0, 6.0, 5.0, 2.0, -1.0, -6.0, -4.0, -2.0, 1.0, -2.0, 8.0, 8.0, 7.0));
	blockD.i = (bvec4(false, true, true, false));
	blockD.j = (mat4x3(-6.0, -6.0, 5.0, -6.0, 3.0, -9.0, 6.0, 2.0, 5.0, 6.0, -4.0, -9.0));
	blockD.k = (-5);
	l[0] = (mat3x2(-1.0, 8.0, -8.0, 2.0, -7.0, 8.0));
	m = (uvec3(0u, 6u, 4u));
	n = (mat3x4(-6.0, -9.0, -7.0, -4.0, 6.0, 7.0, 5.0, -1.0, -1.0, 5.0, -3.0, 7.0));
	o[0] = (uvec3(1u, 0u, 2u));
	p = (vec4(1.0, -9.0, -7.0, 3.0));
}
#version 450
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
	mediump mat2x3 a;
	highp mat3x4 b;
	mediump mat3x4 c;
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	mediump mat3x4 d;
	mediump ivec3 e;
	lowp vec3 f;
	mediump uvec3 g;
	highp ivec3 h;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	highp mat4x2 i;
	highp mat2x3 j;
	bvec2 k;
	highp uint l;
	lowp mat2x3 m;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(-5.0, 5.0, -6.0, -9.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB.b, mat3x4(7.0, 7.0, 0.0, 5.0, -7.0, -5.0, -2.0, -1.0, 5.0, 2.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB.c, mat3x4(7.0, -1.0, 3.0, -2.0, -1.0, -5.0, 5.0, 3.0, 9.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockC.e), ivec3(0, 6, 8)) && allOk;
	allOk = compare_vec3((blockC.f), vec3(5.0, 9.0, -3.0)) && allOk;
	allOk = compare_ivec3((blockC.h), ivec3(3, -7, 7)) && allOk;
	allOk = compare_mat2x3(j, mat2x3(-3.0, -5.0, 2.0, -9.0, 0.0, 5.0)) && allOk;
	allOk = compare_bvec2((k), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(3.0, -4.0, 2.0, 2.0, 4.0, 9.0));
	blockB.b = (mat3x4(-2.0, -4.0, -9.0, -2.0, 0.0, 9.0, 8.0, -5.0, 4.0, -6.0, -8.0, -5.0));
	blockB.c = (mat3x4(0.0, 4.0, 7.0, 3.0, -2.0, 9.0, 0.0, 6.0, -5.0, 5.0, 5.0, -5.0));
	blockC.f = (vec3(-2.0, -6.0, -9.0));
	blockC.g = (uvec3(3u, 5u, 7u));
	blockC.h = (ivec3(-4, 6, 0));
	i = (mat4x2(-2.0, -5.0, -5.0, -4.0, -9.0, 7.0, -1.0, -8.0));
	l = (3u);
	m = (mat2x3(8.0, -4.0, 6.0, -6.0, 2.0, 7.0));
}
#version 450
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
	mediump uint mB;
	mediump mat3 mC;
	highp vec4 mD;
};
struct sB
{
	sA mA;
	mediump uvec3 mB;
	lowp mat3x2 mC;
	lowp mat3 mD;
};
layout(std140, column_major, binding = 1) readonly buffer BlockB
{
	mediump mat3x4 a[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	sB b;
	highp mat4x3 c;
	bool d[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp mat3 e;
	highp vec3 f;
	highp vec2 g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a[0], mat3x4(0.0, 3.0, 3.0, 2.0, 0.0, -3.0, 1.0, -5.0, -2.0, -7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat3x4(a[1], mat3x4(2.0, 3.0, 3.0, 3.0, 5.0, -5.0, -2.0, -6.0, 6.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockC.b.mA.mA), ivec2(-9, 9)) && allOk;
	allOk = compare_uint((blockC.b.mA.mB), 9u) && allOk;
	allOk = compare_mat3(blockC.b.mA.mC, mat3(2.0, 4.0, -4.0, -4.0, 1.0, 9.0, -1.0, 6.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.b.mA.mD), vec4(-2.0, -2.0, 1.0, 7.0)) && allOk;
	allOk = compare_uvec3((blockC.b.mB), uvec3(3u, 3u, 3u)) && allOk;
	allOk = compare_mat3x2(blockC.b.mC, mat3x2(1.0, 9.0, -8.0, -7.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3(blockC.b.mD, mat3(6.0, 6.0, 1.0, 3.0, 4.0, 1.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_bool((blockC.d[0]), false) && allOk;
	allOk = compare_bool((blockC.d[1]), true) && allOk;
	allOk = compare_mat3(e, mat3(-7.0, 0.0, 4.0, 7.0, 2.0, 5.0, -3.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec2((g[0]), vec2(5.0, 7.0)) && allOk;
	allOk = compare_vec2((g[1]), vec2(0.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b.mA.mA = (ivec2(1, 7));
	blockC.b.mA.mB = (3u);
	blockC.b.mA.mC = (mat3(-8.0, -6.0, 4.0, 8.0, -8.0, 4.0, 6.0, -9.0, 5.0));
	blockC.b.mA.mD = (vec4(6.0, 1.0, 3.0, 0.0));
	blockC.b.mB = (uvec3(7u, 1u, 6u));
	blockC.b.mC = (mat3x2(-6.0, 3.0, 2.0, 7.0, 2.0, -9.0));
	blockC.b.mD = (mat3(1.0, -9.0, 6.0, 2.0, -1.0, 2.0, -5.0, -8.0, -7.0));
	e = (mat3(-2.0, 6.0, 0.0, -7.0, 3.0, -7.0, -1.0, -5.0, 1.0));
	f = (vec3(4.0, -3.0, 4.0));
	g[0] = (vec2(5.0, 0.0));
	g[1] = (vec2(7.0, -5.0));
}
#version 450
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
	lowp mat4 a[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(a[0], mat4(1.0, 2.0, -8.0, 3.0, -6.0, -1.0, -1.0, 8.0, -5.0, 4.0, 4.0, 1.0, 7.0, 1.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4(a[1], mat4(5.0, -4.0, 6.0, -3.0, -4.0, -3.0, 9.0, 1.0, 1.0, 1.0, 0.0, 6.0, -4.0, 5.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4(a[2], mat4(6.0, 5.0, -4.0, -1.0, -8.0, 1.0, 0.0, 9.0, 6.0, 4.0, 1.0, -9.0, 6.0, 6.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4(a[3], mat4(3.0, 2.0, -5.0, -7.0, -9.0, 3.0, 9.0, 6.0, 3.0, 1.0, 1.0, -1.0, 5.0, -6.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4(a[4], mat4(-5.0, -1.0, 1.0, -1.0, 8.0, -8.0, 4.0, -3.0, 5.0, 4.0, -2.0, -7.0, -4.0, -7.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat4(a[5], mat4(3.0, 8.0, -2.0, 1.0, 2.0, 2.0, 9.0, -5.0, 6.0, -5.0, 9.0, 8.0, -6.0, 9.0, 2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat4(9.0, 9.0, -4.0, 0.0, 7.0, -6.0, -1.0, 6.0, 5.0, 1.0, -9.0, -6.0, -2.0, 2.0, 0.0, -5.0));
	a[1] = (mat4(2.0, -4.0, 2.0, -7.0, 3.0, -4.0, -1.0, 8.0, 0.0, 1.0, 4.0, -8.0, 4.0, -6.0, -4.0, 1.0));
	a[2] = (mat4(-1.0, 0.0, 6.0, -1.0, -6.0, -6.0, -7.0, -1.0, -3.0, -5.0, 0.0, 4.0, 2.0, -6.0, -9.0, -2.0));
	a[3] = (mat4(-5.0, 9.0, -7.0, 7.0, 5.0, -5.0, 0.0, -9.0, 3.0, -3.0, -2.0, -8.0, 0.0, 3.0, -2.0, 3.0));
	a[4] = (mat4(5.0, -1.0, 4.0, -9.0, 5.0, -8.0, -3.0, -8.0, -1.0, 0.0, -4.0, 8.0, 7.0, -8.0, 9.0, 1.0));
	a[5] = (mat4(2.0, 7.0, 3.0, 0.0, -6.0, -1.0, 9.0, -9.0, 8.0, 3.0, 6.0, 3.0, -9.0, -8.0, -4.0, 5.0));
}
#version 450
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
	bvec3 mB;
	lowp vec4 mC;
};
layout(std430, row_major, binding = 1) readonly buffer BlockB
{
	mediump mat3x2 a[4];
	mediump mat3 b[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	sA c[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	mediump vec4 d;
	lowp mat3x4 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a[0], mat3x2(1.0, 7.0, -3.0, -5.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[1], mat3x2(-1.0, -6.0, -8.0, 5.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[2], mat3x2(2.0, 6.0, 8.0, -8.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.a[3], mat3x2(-1.0, 6.0, 2.0, 1.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3(blockB.b[0], mat3(1.0, -9.0, -1.0, 6.0, 0.0, 5.0, -8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(blockB.b[1], mat3(0.0, -9.0, 8.0, -1.0, 1.0, 0.0, -2.0, 0.0, 5.0)) && allOk;
	allOk = compare_uint((blockC.c[0].mA), 9u) && allOk;
	allOk = compare_bvec3((blockC.c[0].mB), bvec3(false, false, false)) && allOk;
	allOk = compare_vec4((blockC.c[0].mC), vec4(-4.0, 5.0, 1.0, -9.0)) && allOk;
	allOk = compare_uint((blockC.c[1].mA), 2u) && allOk;
	allOk = compare_bvec3((blockC.c[1].mB), bvec3(true, true, true)) && allOk;
	allOk = compare_vec4((blockC.c[1].mC), vec4(8.0, 9.0, -6.0, -3.0)) && allOk;
	allOk = compare_uint((blockC.c[2].mA), 6u) && allOk;
	allOk = compare_bvec3((blockC.c[2].mB), bvec3(false, true, false)) && allOk;
	allOk = compare_vec4((blockC.c[2].mC), vec4(-4.0, 9.0, 9.0, 1.0)) && allOk;
	allOk = compare_uint((blockC.c[3].mA), 6u) && allOk;
	allOk = compare_bvec3((blockC.c[3].mB), bvec3(true, false, false)) && allOk;
	allOk = compare_vec4((blockC.c[3].mC), vec4(5.0, 9.0, 5.0, -7.0)) && allOk;
	allOk = compare_vec4((d), vec4(-3.0, -9.0, 5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c[0].mA = (5u);
	blockC.c[0].mB = (bvec3(false, false, false));
	blockC.c[0].mC = (vec4(3.0, 8.0, 9.0, 3.0));
	blockC.c[1].mA = (5u);
	blockC.c[1].mB = (bvec3(true, false, false));
	blockC.c[1].mC = (vec4(-9.0, 6.0, 7.0, 3.0));
	blockC.c[2].mA = (9u);
	blockC.c[2].mB = (bvec3(true, false, true));
	blockC.c[2].mC = (vec4(2.0, -5.0, 6.0, 3.0));
	blockC.c[3].mA = (3u);
	blockC.c[3].mB = (bvec3(true, false, true));
	blockC.c[3].mC = (vec4(-9.0, 6.0, 8.0, 1.0));
	d = (vec4(-3.0, -2.0, -8.0, 1.0));
}
#version 450
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
	highp ivec2 mB;
	lowp vec4 mC[6];
};
struct sB
{
	lowp int mA;
	sA mB;
	highp ivec3 mC;
	mediump mat4 mD;
};
layout(std140, binding = 1) buffer BlockB
{
	mediump mat3 a[];
} blockB[2];
layout(std430, column_major, binding = 2) buffer BlockC
{
	sB b[];
} blockC[1];
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp mat2 c;
	lowp mat4x3 d;
	bool e;
	mediump ivec2 f;
} blockD[2];
layout(std140, row_major, binding = 4) buffer BlockE
{
	bool g[7];
	mediump mat2 h;
	lowp mat3x2 i;
	highp uvec3 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockC[0].b[0].mA), -1) && allOk;
	allOk = compare_uvec4((blockC[0].b[0].mB.mA), uvec4(9u, 4u, 6u, 8u)) && allOk;
	allOk = compare_ivec2((blockC[0].b[0].mB.mB), ivec2(7, 1)) && allOk;
	allOk = compare_vec4((blockC[0].b[0].mB.mC[0]), vec4(-3.0, 6.0, 8.0, -6.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[0].mB.mC[1]), vec4(-8.0, 8.0, 4.0, 5.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[0].mB.mC[2]), vec4(-2.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[0].mB.mC[3]), vec4(-9.0, 6.0, 8.0, -4.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[0].mB.mC[4]), vec4(-1.0, -5.0, 4.0, -3.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[0].mB.mC[5]), vec4(-2.0, -3.0, 9.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockC[0].b[0].mC), ivec3(4, -4, 0)) && allOk;
	allOk = compare_mat4(blockC[0].b[0].mD, mat4(1.0, -4.0, 0.0, -5.0, 0.0, -2.0, 2.0, -5.0, -8.0, -6.0, -9.0, 1.0, 2.0, -1.0, 9.0, 3.0)) && allOk;
	allOk = compare_int((blockC[0].b[1].mA), 4) && allOk;
	allOk = compare_uvec4((blockC[0].b[1].mB.mA), uvec4(4u, 1u, 5u, 1u)) && allOk;
	allOk = compare_ivec2((blockC[0].b[1].mB.mB), ivec2(5, -6)) && allOk;
	allOk = compare_vec4((blockC[0].b[1].mB.mC[0]), vec4(6.0, 4.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[1].mB.mC[1]), vec4(-4.0, 6.0, -3.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[1].mB.mC[2]), vec4(5.0, -7.0, -4.0, -1.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[1].mB.mC[3]), vec4(-5.0, 4.0, 8.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[1].mB.mC[4]), vec4(4.0, 3.0, 5.0, 6.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[1].mB.mC[5]), vec4(1.0, 9.0, 9.0, -3.0)) && allOk;
	allOk = compare_ivec3((blockC[0].b[1].mC), ivec3(2, 4, -5)) && allOk;
	allOk = compare_mat4(blockC[0].b[1].mD, mat4(-1.0, 5.0, 7.0, 6.0, -8.0, 9.0, -8.0, 7.0, 6.0, -5.0, 5.0, 6.0, -2.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_int((blockC[0].b[2].mA), -9) && allOk;
	allOk = compare_uvec4((blockC[0].b[2].mB.mA), uvec4(9u, 1u, 7u, 0u)) && allOk;
	allOk = compare_ivec2((blockC[0].b[2].mB.mB), ivec2(-1, 3)) && allOk;
	allOk = compare_vec4((blockC[0].b[2].mB.mC[0]), vec4(8.0, 6.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[2].mB.mC[1]), vec4(5.0, 1.0, 9.0, 5.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[2].mB.mC[2]), vec4(0.0, -8.0, -5.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[2].mB.mC[3]), vec4(-2.0, 2.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[2].mB.mC[4]), vec4(8.0, 0.0, 2.0, -1.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[2].mB.mC[5]), vec4(-2.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_ivec3((blockC[0].b[2].mC), ivec3(1, -3, -2)) && allOk;
	allOk = compare_mat4(blockC[0].b[2].mD, mat4(8.0, -5.0, 0.0, -2.0, -5.0, -4.0, 6.0, 9.0, -1.0, 7.0, 2.0, 8.0, -6.0, -5.0, 2.0, 5.0)) && allOk;
	allOk = compare_int((blockC[0].b[3].mA), 3) && allOk;
	allOk = compare_uvec4((blockC[0].b[3].mB.mA), uvec4(6u, 2u, 2u, 3u)) && allOk;
	allOk = compare_ivec2((blockC[0].b[3].mB.mB), ivec2(-9, -3)) && allOk;
	allOk = compare_vec4((blockC[0].b[3].mB.mC[0]), vec4(6.0, -8.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[3].mB.mC[1]), vec4(-9.0, 7.0, 4.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[3].mB.mC[2]), vec4(-5.0, -9.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[3].mB.mC[3]), vec4(9.0, -1.0, 9.0, -3.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[3].mB.mC[4]), vec4(5.0, -8.0, 7.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[3].mB.mC[5]), vec4(4.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_ivec3((blockC[0].b[3].mC), ivec3(-8, 5, 6)) && allOk;
	allOk = compare_mat4(blockC[0].b[3].mD, mat4(-8.0, 9.0, 7.0, -3.0, -4.0, 8.0, -7.0, 9.0, 8.0, 5.0, -3.0, 8.0, 6.0, 7.0, -7.0, -7.0)) && allOk;
	allOk = compare_int((blockC[0].b[4].mA), -6) && allOk;
	allOk = compare_uvec4((blockC[0].b[4].mB.mA), uvec4(9u, 0u, 5u, 7u)) && allOk;
	allOk = compare_ivec2((blockC[0].b[4].mB.mB), ivec2(7, 3)) && allOk;
	allOk = compare_vec4((blockC[0].b[4].mB.mC[0]), vec4(-4.0, 7.0, 8.0, -3.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[4].mB.mC[1]), vec4(1.0, 1.0, -2.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[4].mB.mC[2]), vec4(-1.0, -9.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[4].mB.mC[3]), vec4(-3.0, -2.0, -5.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[4].mB.mC[4]), vec4(-9.0, 8.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[4].mB.mC[5]), vec4(1.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_ivec3((blockC[0].b[4].mC), ivec3(7, -8, -4)) && allOk;
	allOk = compare_mat4(blockC[0].b[4].mD, mat4(5.0, -8.0, -2.0, -6.0, 7.0, 5.0, 9.0, -3.0, 1.0, -9.0, -4.0, 7.0, 3.0, -9.0, -9.0, -1.0)) && allOk;
	allOk = compare_int((blockC[0].b[5].mA), 5) && allOk;
	allOk = compare_uvec4((blockC[0].b[5].mB.mA), uvec4(4u, 8u, 9u, 0u)) && allOk;
	allOk = compare_ivec2((blockC[0].b[5].mB.mB), ivec2(-2, 6)) && allOk;
	allOk = compare_vec4((blockC[0].b[5].mB.mC[0]), vec4(-3.0, -6.0, 2.0, -4.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[5].mB.mC[1]), vec4(-7.0, 9.0, -4.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[5].mB.mC[2]), vec4(-2.0, -7.0, -4.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[5].mB.mC[3]), vec4(-5.0, -3.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[5].mB.mC[4]), vec4(-9.0, 0.0, 5.0, 5.0)) && allOk;
	allOk = compare_vec4((blockC[0].b[5].mB.mC[5]), vec4(3.0, 3.0, -8.0, 4.0)) && allOk;
	allOk = compare_ivec3((blockC[0].b[5].mC), ivec3(6, -6, -6)) && allOk;
	allOk = compare_mat4(blockC[0].b[5].mD, mat4(8.0, 0.0, 0.0, 5.0, 8.0, 3.0, -1.0, 9.0, 9.0, -9.0, -5.0, -3.0, 9.0, 0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].d, mat4x3(0.0, -8.0, 3.0, -8.0, -8.0, -3.0, -5.0, -8.0, -2.0, -4.0, -5.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockD[0].f), ivec2(-8, 4)) && allOk;
	allOk = compare_mat4x3(blockD[1].d, mat4x3(-7.0, -9.0, 4.0, -4.0, -9.0, 5.0, 0.0, 8.0, 7.0, 8.0, -7.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockD[1].f), ivec2(-3, 5)) && allOk;
	allOk = compare_mat3x2(i, mat3x2(1.0, -9.0, -4.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_uvec3((j[0]), uvec3(8u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((j[1]), uvec3(9u, 6u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (mat3(6.0, 3.0, -9.0, 0.0, 9.0, 2.0, -6.0, 6.0, -6.0));
	blockB[0].a[1] = (mat3(3.0, 5.0, -8.0, -7.0, -8.0, 3.0, -6.0, -9.0, 9.0));
	blockB[0].a[2] = (mat3(-9.0, 9.0, 8.0, -1.0, -4.0, 0.0, -4.0, 2.0, 1.0));
	blockB[0].a[3] = (mat3(2.0, 9.0, -3.0, -2.0, -6.0, -2.0, 5.0, -3.0, 2.0));
	blockB[0].a[4] = (mat3(0.0, 0.0, 2.0, -8.0, -5.0, -3.0, -3.0, 0.0, 8.0));
	blockB[1].a[0] = (mat3(-9.0, 2.0, -4.0, 1.0, 8.0, 7.0, -4.0, -3.0, -2.0));
	blockB[1].a[1] = (mat3(7.0, -9.0, 3.0, 8.0, 2.0, 4.0, -8.0, -4.0, -3.0));
	blockB[1].a[2] = (mat3(-8.0, 8.0, -8.0, 3.0, -1.0, 4.0, 4.0, -4.0, 9.0));
	blockC[0].b[0].mA = (8);
	blockC[0].b[0].mB.mA = (uvec4(7u, 3u, 8u, 4u));
	blockC[0].b[0].mB.mB = (ivec2(4, -2));
	blockC[0].b[0].mB.mC[0] = (vec4(-1.0, -8.0, -5.0, -8.0));
	blockC[0].b[0].mB.mC[1] = (vec4(6.0, -9.0, -8.0, -2.0));
	blockC[0].b[0].mB.mC[2] = (vec4(-3.0, -5.0, -3.0, -7.0));
	blockC[0].b[0].mB.mC[3] = (vec4(-7.0, -7.0, 0.0, 7.0));
	blockC[0].b[0].mB.mC[4] = (vec4(2.0, 3.0, 9.0, 9.0));
	blockC[0].b[0].mB.mC[5] = (vec4(2.0, -9.0, -8.0, -1.0));
	blockC[0].b[0].mC = (ivec3(1, 5, -1));
	blockC[0].b[0].mD = (mat4(6.0, -2.0, -6.0, -8.0, 8.0, 5.0, 8.0, 1.0, 2.0, -7.0, 5.0, -7.0, 6.0, 5.0, 6.0, -4.0));
	blockC[0].b[1].mA = (-7);
	blockC[0].b[1].mB.mA = (uvec4(1u, 5u, 4u, 5u));
	blockC[0].b[1].mB.mB = (ivec2(-6, -1));
	blockC[0].b[1].mB.mC[0] = (vec4(1.0, -8.0, 1.0, -6.0));
	blockC[0].b[1].mB.mC[1] = (vec4(1.0, 6.0, 1.0, 8.0));
	blockC[0].b[1].mB.mC[2] = (vec4(-9.0, 3.0, 4.0, -6.0));
	blockC[0].b[1].mB.mC[3] = (vec4(9.0, -1.0, -2.0, 5.0));
	blockC[0].b[1].mB.mC[4] = (vec4(-6.0, -9.0, 4.0, -8.0));
	blockC[0].b[1].mB.mC[5] = (vec4(7.0, 4.0, 3.0, 3.0));
	blockC[0].b[1].mC = (ivec3(4, 6, 2));
	blockC[0].b[1].mD = (mat4(3.0, -6.0, 1.0, -4.0, -9.0, 2.0, 9.0, 4.0, 7.0, 9.0, -2.0, 6.0, -9.0, 5.0, 8.0, 7.0));
	blockC[0].b[2].mA = (-1);
	blockC[0].b[2].mB.mA = (uvec4(4u, 5u, 0u, 0u));
	blockC[0].b[2].mB.mB = (ivec2(3, -7));
	blockC[0].b[2].mB.mC[0] = (vec4(-9.0, -2.0, -6.0, 4.0));
	blockC[0].b[2].mB.mC[1] = (vec4(-5.0, 2.0, 9.0, 8.0));
	blockC[0].b[2].mB.mC[2] = (vec4(8.0, 5.0, 0.0, 7.0));
	blockC[0].b[2].mB.mC[3] = (vec4(6.0, -3.0, -1.0, 1.0));
	blockC[0].b[2].mB.mC[4] = (vec4(4.0, -1.0, 4.0, 6.0));
	blockC[0].b[2].mB.mC[5] = (vec4(-3.0, -8.0, -1.0, -4.0));
	blockC[0].b[2].mC = (ivec3(6, 1, 5));
	blockC[0].b[2].mD = (mat4(0.0, -5.0, 9.0, 2.0, 1.0, 9.0, 3.0, -1.0, 6.0, -6.0, -4.0, -5.0, -7.0, 8.0, -9.0, -8.0));
	blockC[0].b[3].mA = (-7);
	blockC[0].b[3].mB.mA = (uvec4(8u, 5u, 6u, 2u));
	blockC[0].b[3].mB.mB = (ivec2(-2, -4));
	blockC[0].b[3].mB.mC[0] = (vec4(3.0, 9.0, -5.0, -4.0));
	blockC[0].b[3].mB.mC[1] = (vec4(7.0, -1.0, 0.0, 8.0));
	blockC[0].b[3].mB.mC[2] = (vec4(6.0, 4.0, -4.0, 4.0));
	blockC[0].b[3].mB.mC[3] = (vec4(7.0, -1.0, 5.0, -1.0));
	blockC[0].b[3].mB.mC[4] = (vec4(1.0, 3.0, -2.0, 1.0));
	blockC[0].b[3].mB.mC[5] = (vec4(7.0, -7.0, -6.0, 3.0));
	blockC[0].b[3].mC = (ivec3(1, 1, 9));
	blockC[0].b[3].mD = (mat4(4.0, -5.0, 9.0, -3.0, -7.0, 8.0, -3.0, 3.0, 4.0, -9.0, 8.0, -6.0, 0.0, -2.0, -2.0, 8.0));
	blockC[0].b[4].mA = (2);
	blockC[0].b[4].mB.mA = (uvec4(1u, 4u, 7u, 3u));
	blockC[0].b[4].mB.mB = (ivec2(9, 3));
	blockC[0].b[4].mB.mC[0] = (vec4(6.0, 3.0, -6.0, 2.0));
	blockC[0].b[4].mB.mC[1] = (vec4(9.0, -9.0, -8.0, 4.0));
	blockC[0].b[4].mB.mC[2] = (vec4(-2.0, -3.0, -3.0, -4.0));
	blockC[0].b[4].mB.mC[3] = (vec4(5.0, -4.0, -9.0, 7.0));
	blockC[0].b[4].mB.mC[4] = (vec4(7.0, -9.0, -1.0, -4.0));
	blockC[0].b[4].mB.mC[5] = (vec4(8.0, 2.0, 2.0, 1.0));
	blockC[0].b[4].mC = (ivec3(-8, 2, -5));
	blockC[0].b[4].mD = (mat4(4.0, 4.0, 9.0, 9.0, 2.0, -4.0, 0.0, 8.0, 6.0, -8.0, 6.0, 1.0, 1.0, 8.0, 6.0, -6.0));
	blockC[0].b[5].mA = (-7);
	blockC[0].b[5].mB.mA = (uvec4(0u, 5u, 6u, 6u));
	blockC[0].b[5].mB.mB = (ivec2(7, 8));
	blockC[0].b[5].mB.mC[0] = (vec4(3.0, -5.0, -2.0, 1.0));
	blockC[0].b[5].mB.mC[1] = (vec4(-5.0, -5.0, -9.0, 6.0));
	blockC[0].b[5].mB.mC[2] = (vec4(0.0, 3.0, -7.0, -8.0));
	blockC[0].b[5].mB.mC[3] = (vec4(5.0, 2.0, -9.0, 9.0));
	blockC[0].b[5].mB.mC[4] = (vec4(-3.0, 5.0, -5.0, -1.0));
	blockC[0].b[5].mB.mC[5] = (vec4(7.0, -6.0, 4.0, 6.0));
	blockC[0].b[5].mC = (ivec3(-7, 6, 1));
	blockC[0].b[5].mD = (mat4(2.0, 0.0, -5.0, -8.0, -4.0, -6.0, -7.0, -3.0, 2.0, -5.0, -7.0, 9.0, 9.0, 9.0, 0.0, -7.0));
	blockD[0].c = (mat2(-8.0, -5.0, 5.0, -7.0));
	blockD[0].d = (mat4x3(-2.0, -6.0, 4.0, 3.0, 3.0, 5.0, 2.0, 0.0, -2.0, 0.0, -1.0, -6.0));
	blockD[0].e = (true);
	blockD[0].f = (ivec2(-8, 0));
	blockD[1].c = (mat2(-4.0, -4.0, -3.0, -3.0));
	blockD[1].d = (mat4x3(-5.0, -3.0, 0.0, 4.0, 0.0, -4.0, 1.0, -5.0, -3.0, 5.0, -5.0, 8.0));
	blockD[1].e = (true);
	blockD[1].f = (ivec2(-9, -4));
	g[0] = (true);
	g[1] = (true);
	g[2] = (true);
	g[3] = (true);
	g[4] = (true);
	g[5] = (false);
	g[6] = (true);
	i = (mat3x2(1.0, 8.0, 3.0, 7.0, 5.0, -1.0));
	j[0] = (uvec3(8u, 7u, 6u));
	j[1] = (uvec3(0u, 0u, 4u));
}
#version 450
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
	highp uint mB;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	bvec3 a[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	sA b;
	mediump uvec4 c;
	lowp vec3 d;
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	highp mat4x3 e;
	bool f[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((d), vec3(4.0, -8.0, 0.0)) && allOk;
	allOk = compare_bool((blockD.f[0]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (bvec3(true, true, true));
	blockB.a[1] = (bvec3(true, false, false));
	b.mA = (mat3(-3.0, -5.0, 7.0, -3.0, -4.0, 3.0, -5.0, -1.0, -5.0));
	b.mB = (2u);
	c = (uvec4(3u, 8u, 0u, 0u));
	d = (vec3(8.0, 8.0, -2.0));
	blockD.e = (mat4x3(-7.0, -2.0, 7.0, -6.0, 6.0, 9.0, 5.0, 8.0, -9.0, -2.0, -3.0, -8.0));
	blockD.f[0] = (false);
}
#version 450
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
	layout(offset = 0) highp ivec3 a;
	layout(offset = 16) bvec3 b;
	layout(offset = 32) highp ivec2 c;
	layout(offset = 40) highp uint d;
	layout(offset = 44) mediump float e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((d), 0u) && allOk;
	allOk = compare_float((e), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec3(-6, -9, 9));
	b = (bvec3(false, true, true));
	c = (ivec2(-5, 0));
	d = (9u);
	e = (-6.0);
}
#version 450
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
	layout(offset = 16) lowp ivec3 b;
	layout(offset = 32) lowp uvec2 c;
	layout(offset = 40) bvec2 d;
	layout(offset = 48) bvec2 e;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp float f;
	layout(offset = 4) highp ivec2 g;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec3 h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(3, 4)) && allOk;
	allOk = compare_ivec3((blockB.b), ivec3(-3, 6, -1)) && allOk;
	allOk = compare_uvec2((blockB.c), uvec2(0u, 8u)) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(true, true)) && allOk;
	allOk = compare_float((blockC.f), 9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(3, -9));
	blockB.b = (ivec3(1, -1, -7));
	blockB.c = (uvec2(8u, 2u));
	blockB.e = (bvec2(false, false));
	blockC.g = (ivec2(1, -2));
	h = (bvec3(true, false, true));
}
#version 450
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
	layout(offset = 0) highp int a;
	layout(offset = 4) mediump uvec2 b;
	layout(offset = 16) lowp ivec4 c;
	layout(offset = 32) bvec4 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump ivec2 e;
	layout(offset = 16) bvec3 f;
	layout(offset = 32) mediump uvec2 g;
} blockC[1];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec4 h;
	layout(offset = 16) lowp uvec2 i;
	layout(offset = 24) mediump vec2 j;
	layout(offset = 32) lowp int k;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.b), uvec2(0u, 7u)) && allOk;
	allOk = compare_ivec4((blockB.c), ivec4(0, -5, -3, 9)) && allOk;
	allOk = compare_bvec4((blockB.d), bvec4(false, true, false, false)) && allOk;
	allOk = compare_ivec2((blockC[0].e), ivec2(-4, 2)) && allOk;
	allOk = compare_bvec3((blockC[0].f), bvec3(false, false, true)) && allOk;
	allOk = compare_vec2((blockD.j), vec2(7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-2);
	blockB.b = (uvec2(1u, 5u));
	blockB.c = (ivec4(-4, 6, 4, 8));
	blockC[0].e = (ivec2(0, 0));
	blockC[0].f = (bvec3(false, true, false));
	blockC[0].g = (uvec2(0u, 3u));
	blockD.h = (bvec4(true, true, false, false));
	blockD.i = (uvec2(8u, 9u));
	blockD.j = (vec2(8.0, 8.0));
	blockD.k = (7);
}
#version 450
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
	lowp mat3x4 a;
	mediump mat4 b;
	highp vec4 c;
	lowp uvec3 d[];
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	lowp vec4 e;
	highp mat3x2 f;
} blockC;
layout(scalar, binding = 3) readonly buffer BlockD
{
	mediump mat4x3 g[1];
} blockD;
layout(scalar, row_major, binding = 4) buffer BlockE
{
	bool h;
	highp mat3x4 i;
	mediump uvec3 j;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a, mat3x4(8.0, -2.0, -2.0, 7.0, -8.0, -7.0, 4.0, 0.0, -5.0, 9.0, 3.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB.c), vec4(6.0, 1.0, 3.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockB.d[0]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((blockB.d[1]), uvec3(1u, 8u, 1u)) && allOk;
	allOk = compare_uvec3((blockB.d[2]), uvec3(0u, 3u, 8u)) && allOk;
	allOk = compare_uvec3((blockB.d[3]), uvec3(0u, 3u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.d[4]), uvec3(5u, 8u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.d[5]), uvec3(7u, 3u, 5u)) && allOk;
	allOk = compare_vec4((blockC.e), vec4(4.0, -6.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockE.i, mat3x4(-1.0, -9.0, 8.0, -8.0, 9.0, 4.0, 7.0, -9.0, 0.0, -7.0, 2.0, -6.0)) && allOk;
	allOk = compare_uvec3((blockE.j), uvec3(3u, 0u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(-8.0, -5.0, 7.0, 4.0, 4.0, 8.0, 1.0, -4.0, 0.0, -8.0, 6.0, -7.0));
	blockB.b = (mat4(7.0, 4.0, 3.0, -8.0, -8.0, -7.0, 7.0, -9.0, -8.0, 7.0, 4.0, 4.0, 3.0, -9.0, -9.0, -3.0));
	blockB.d[0] = (uvec3(1u, 7u, 3u));
	blockB.d[1] = (uvec3(3u, 8u, 0u));
	blockB.d[2] = (uvec3(5u, 6u, 1u));
	blockB.d[3] = (uvec3(5u, 0u, 5u));
	blockB.d[4] = (uvec3(9u, 4u, 6u));
	blockB.d[5] = (uvec3(4u, 4u, 1u));
	blockC.e = (vec4(-3.0, 3.0, -7.0, -2.0));
	blockC.f = (mat3x2(8.0, 5.0, 8.0, 9.0, 9.0, 3.0));
	blockE.h = (false);
}
#version 450
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
	lowp uvec2 a[];
};
layout(scalar, row_major, binding = 2) readonly buffer BlockC
{
	highp mat4x2 b;
};
layout(scalar, row_major, binding = 3) buffer BlockD
{
	highp ivec2 c;
	mediump uvec2 d;
	highp vec4 e;
	lowp ivec2 f;
	highp mat3x4 g[];
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((a[0]), uvec2(8u, 2u)) && allOk;
	allOk = compare_ivec2((blockD[0].c), ivec2(-4, -3)) && allOk;
	allOk = compare_ivec2((blockD[0].f), ivec2(2, -4)) && allOk;
	allOk = compare_mat3x4(blockD[0].g[0], mat3x4(0.0, 9.0, 1.0, 7.0, 7.0, -6.0, 5.0, -5.0, -2.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockD[1].c), ivec2(-7, -4)) && allOk;
	allOk = compare_ivec2((blockD[1].f), ivec2(7, 4)) && allOk;
	allOk = compare_mat3x4(blockD[1].g[0], mat3x4(-1.0, 9.0, -7.0, -3.0, 3.0, -8.0, 6.0, -3.0, -3.0, 3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g[1], mat3x4(6.0, 0.0, 3.0, 4.0, -2.0, -1.0, 4.0, 3.0, 9.0, 5.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g[2], mat3x4(3.0, -6.0, 3.0, -3.0, -3.0, -7.0, -6.0, 8.0, -2.0, -7.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g[3], mat3x4(5.0, 4.0, 2.0, 4.0, -6.0, 8.0, -2.0, -4.0, 3.0, 8.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g[4], mat3x4(2.0, 8.0, 0.0, -6.0, -5.0, -3.0, -6.0, 4.0, -2.0, 8.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g[5], mat3x4(-4.0, -6.0, 8.0, -2.0, -7.0, -9.0, 9.0, 1.0, 5.0, -2.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g[6], mat3x4(9.0, 2.0, -6.0, -1.0, 7.0, -7.0, -9.0, 0.0, 0.0, -5.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g[7], mat3x4(-9.0, 9.0, -5.0, -5.0, -6.0, 4.0, -4.0, 3.0, 9.0, -4.0, 2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (uvec2(4u, 5u));
	blockD[0].c = (ivec2(-2, 8));
	blockD[0].e = (vec4(7.0, 1.0, -9.0, 4.0));
	blockD[0].f = (ivec2(5, 9));
	blockD[1].c = (ivec2(9, -6));
	blockD[1].e = (vec4(9.0, 1.0, 6.0, 6.0));
	blockD[1].f = (ivec2(-1, 6));
}
#version 450
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
	lowp uvec2 a;
	highp int b;
	i16vec3 c;
	bvec3 d;
	bool e;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	highp ivec4 f;
	lowp vec3 g;
};
layout(std430, binding = 3) buffer BlockD
{
	u16vec3 h;
	lowp vec3 i;
	bvec4 j;
};
layout(std140, binding = 4) buffer BlockE
{
	highp vec4 k;
	lowp int l;
	highp ivec2 m;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(3u, 1u)) && allOk;
	allOk = compare_bool((blockB.e), false) && allOk;
	allOk = compare_vec3((g), vec3(-2.0, -8.0, -6.0)) && allOk;
	allOk = compare_u16vec3(uvec3(h), uvec3(8u, 6u, 8u)) && allOk;
	allOk = compare_vec4((blockE.k), vec4(5.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockE.m), ivec2(8, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(5u, 4u));
	blockB.b = (-4);
	blockB.d = (bvec3(true, false, false));
	blockB.e = (true);
	f = (ivec4(3, 4, -1, -4));
	g = (vec3(-7.0, -8.0, -3.0));
	i = (vec3(-1.0, -4.0, -8.0));
	j = (bvec4(false, false, true, true));
	blockE.l = (-7);
}
#version 450
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
	lowp vec3 a;
	mediump uvec3 b;
	lowp vec3 c;
	highp mat4x3 d;
	mediump vec3 e;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	bvec2 f;
	highp mat3x4 g;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((b), uvec3(1u, 4u, 0u)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(4.0, 5.0, 6.0, -6.0, 1.0, 8.0, 1.0, -7.0, 7.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_vec3((e), vec3(-9.0, -8.0, 6.0)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(true, false)) && allOk;
	allOk = compare_mat3x4(blockC.g, mat3x4(-8.0, 1.0, 6.0, 6.0, 9.0, 1.0, -3.0, -4.0, -9.0, 3.0, 8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec3(8.0, -2.0, -1.0));
	b = (uvec3(5u, 8u, 5u));
	c = (vec3(9.0, 5.0, 4.0));
	e = (vec3(-5.0, 4.0, 9.0));
	blockC.f = (bvec2(false, true));
}
#version 450
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
	u16vec2 b;
	f16vec2 c;
	float16_t d;
	highp mat4 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(b), uvec2(3u, 7u)) && allOk;
	allOk = compare_f16vec2(vec2(c), vec2(-4.0, 0.0)) && allOk;
	allOk = compare_mat4(e, mat4(-5.0, -6.0, 7.0, -9.0, 1.0, 9.0, 5.0, -2.0, 5.0, 8.0, -6.0, 4.0, 1.0, 3.0, 5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(-2.0, -9.0, -3.0, -1.0));
	b = u16vec2(uvec2(5u, 6u));
}
#version 450
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
	mediump float a;
	mediump ivec3 b;
	int16_t c;
	i16vec2 d[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	u16vec4 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.b), ivec3(3, -2, 9)) && allOk;
	allOk = compare_int16_t(int(blockB.c), -9) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.d[0]), ivec2(-1, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.d[1]), ivec2(1, -8)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.d[2]), ivec2(6, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.d[3]), ivec2(-8, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.d[4]), ivec2(7, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.d[5]), ivec2(7, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.d[6]), ivec2(8, -1)) && allOk;
	allOk = compare_u16vec4(uvec4(e[0]), uvec4(4u, 9u, 9u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(e[1]), uvec4(9u, 8u, 8u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(e[2]), uvec4(0u, 3u, 6u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-6.0);
	blockB.b = (ivec3(-2, 3, -5));
	blockB.d[0] = i16vec2(ivec2(5, -9));
	blockB.d[1] = i16vec2(ivec2(8, 1));
	blockB.d[2] = i16vec2(ivec2(9, 5));
	blockB.d[3] = i16vec2(ivec2(-4, -9));
	blockB.d[4] = i16vec2(ivec2(-3, 7));
	blockB.d[5] = i16vec2(ivec2(3, 2));
	blockB.d[6] = i16vec2(ivec2(-7, 1));
	e[0] = u16vec4(uvec4(0u, 2u, 7u, 5u));
	e[1] = u16vec4(uvec4(9u, 5u, 9u, 5u));
	e[2] = u16vec4(uvec4(1u, 2u, 4u, 3u));
}
#version 450
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
	lowp uvec4 mB;
};
layout(std140, column_major, binding = 1) readonly buffer BlockB
{
	mediump uvec3 a[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	uint16_t b;
	int16_t c;
	highp vec2 d[];
} blockC[2];
layout(std430, binding = 3) buffer BlockD
{
	bool e;
	bvec4 f;
	float16_t g[];
};
layout(std430, binding = 4) buffer BlockE
{
	highp ivec2 h;
	f16vec3 i;
	bvec3 j;
	sA k;
	mediump ivec3 l[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a[0]), uvec3(2u, 0u, 3u)) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].b), 0u) && allOk;
	allOk = compare_int16_t(int(blockC[0].c), 1) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].b), 1u) && allOk;
	allOk = compare_int16_t(int(blockC[1].c), 2) && allOk;
	allOk = compare_float16_t(float(g[0]), -1.0) && allOk;
	allOk = compare_bvec3((blockE.j), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockE.k.mA), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec4((blockE.k.mB), uvec4(5u, 4u, 8u, 3u)) && allOk;
	allOk = compare_ivec3((blockE.l[0]), ivec3(-3, -4, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].d[0] = (vec2(-2.0, -1.0));
	blockC[1].d[0] = (vec2(-9.0, -2.0));
	e = (true);
	f = (bvec4(false, false, true, false));
	g[0] = float16_t(-6.0);
	blockE.h = (ivec2(5, 9));
	blockE.k.mA = (bvec3(false, true, true));
	blockE.k.mB = (uvec4(3u, 6u, 6u, 5u));
}
#version 450
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
	lowp uvec2 a;
	i16vec3 b;
	i16vec4 c;
	lowp ivec3 d;
	u16vec3 e[];
} blockB;

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(5u, 4u)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.b), ivec3(8, 2, 4)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.e[0]), uvec3(5u, 5u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.e[1]), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.e[2]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.e[3]), uvec3(4u, 4u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.e[4]), uvec3(4u, 0u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.e[5]), uvec3(9u, 7u, 7u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.e[6]), uvec3(2u, 7u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.e[7]), uvec3(6u, 5u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(3u, 1u));
	blockB.c = i16vec4(ivec4(-7, 4, 6, -8));
}
#version 450
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
	lowp mat3x4 mB;
};
struct sB
{
	mediump uvec3 mA;
	mediump mat3x4 mB;
	sA mC;
	bool mD;
};
layout(std140, binding = 1) buffer BlockB
{
	highp mat4x2 a;
	mediump mat3 b;
	bvec2 c[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump uint d;
	lowp mat4x2 e[];
} blockC[3];
layout(std430, row_major, binding = 3) buffer BlockD
{
	mediump mat2x3 f;
	sB g;
	mediump mat4x3 h;
	lowp mat4x3 i[];
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(b, mat3(-8.0, 6.0, -5.0, -8.0, 2.0, 7.0, -7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].e[0], mat4x2(1.0, 7.0, 6.0, -5.0, -5.0, 4.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].e[1], mat4x2(0.0, 0.0, -9.0, -6.0, -3.0, -3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].e[2], mat4x2(8.0, 9.0, -5.0, 6.0, 8.0, -2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].e[3], mat4x2(1.0, -4.0, 6.0, -1.0, -4.0, -9.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].e[4], mat4x2(5.0, -4.0, -5.0, 8.0, -4.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].e[5], mat4x2(2.0, 8.0, 9.0, 0.0, 1.0, -6.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].e[0], mat4x2(7.0, 3.0, -9.0, 9.0, -1.0, -4.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].e[1], mat4x2(-7.0, -7.0, 9.0, -1.0, 3.0, 8.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].e[2], mat4x2(1.0, 1.0, 8.0, 3.0, 4.0, 5.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].e[3], mat4x2(7.0, -1.0, 0.0, 3.0, -7.0, -2.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].e[4], mat4x2(-5.0, -4.0, 6.0, -6.0, -6.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].e[5], mat4x2(2.0, -9.0, -5.0, 8.0, 7.0, 1.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockC[2].e[0], mat4x2(-4.0, -4.0, -4.0, -1.0, 5.0, 6.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockC[2].e[1], mat4x2(1.0, -6.0, 4.0, -3.0, 5.0, 3.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockC[2].e[2], mat4x2(-4.0, -1.0, 8.0, 8.0, -9.0, -3.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockD[0].f, mat2x3(5.0, -9.0, -5.0, -9.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].h, mat4x3(-5.0, -1.0, -8.0, 7.0, 9.0, -7.0, 3.0, 5.0, -5.0, 8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockD[1].f, mat2x3(-1.0, -9.0, 3.0, 1.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].h, mat4x3(0.0, -7.0, -7.0, -7.0, -4.0, 3.0, -3.0, -1.0, -9.0, -6.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockD[2].f, mat2x3(1.0, -1.0, -2.0, -5.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockD[2].h, mat4x3(-2.0, 1.0, 3.0, 9.0, -3.0, -3.0, 3.0, -2.0, -2.0, 4.0, -1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	c[0] = (bvec2(true, false));
	blockC[0].d = (2u);
	blockC[0].e[0] = (mat4x2(-7.0, -1.0, 4.0, 3.0, 9.0, -1.0, -8.0, 4.0));
	blockC[0].e[1] = (mat4x2(1.0, -5.0, -8.0, 7.0, -8.0, -5.0, -1.0, -3.0));
	blockC[0].e[2] = (mat4x2(-8.0, 8.0, 6.0, -8.0, -4.0, -5.0, -9.0, 1.0));
	blockC[0].e[3] = (mat4x2(4.0, 8.0, 3.0, 5.0, -9.0, 8.0, -3.0, 1.0));
	blockC[0].e[4] = (mat4x2(8.0, -2.0, 9.0, -9.0, 2.0, -9.0, 7.0, 7.0));
	blockC[0].e[5] = (mat4x2(3.0, -6.0, -9.0, -7.0, 1.0, 3.0, -8.0, -6.0));
	blockC[1].d = (0u);
	blockC[1].e[0] = (mat4x2(6.0, -8.0, 0.0, -9.0, -2.0, -9.0, 8.0, -7.0));
	blockC[1].e[1] = (mat4x2(9.0, 4.0, -7.0, -4.0, -8.0, 4.0, 7.0, -1.0));
	blockC[1].e[2] = (mat4x2(7.0, -7.0, -1.0, -7.0, 4.0, 1.0, -8.0, 4.0));
	blockC[1].e[3] = (mat4x2(-1.0, -3.0, -7.0, -4.0, 1.0, -6.0, 2.0, -3.0));
	blockC[1].e[4] = (mat4x2(1.0, -9.0, 8.0, 9.0, 2.0, -5.0, 1.0, 1.0));
	blockC[1].e[5] = (mat4x2(6.0, -5.0, -9.0, -8.0, 5.0, 4.0, -2.0, 7.0));
	blockC[2].d = (7u);
	blockC[2].e[0] = (mat4x2(5.0, 3.0, 5.0, -7.0, -9.0, 9.0, 3.0, 5.0));
	blockC[2].e[1] = (mat4x2(3.0, 8.0, 3.0, -5.0, -7.0, 3.0, 2.0, 2.0));
	blockC[2].e[2] = (mat4x2(7.0, 2.0, -3.0, 8.0, -5.0, 3.0, -2.0, 9.0));
	blockD[0].g.mA = (uvec3(6u, 4u, 0u));
	blockD[0].g.mB = (mat3x4(-3.0, -7.0, 2.0, -2.0, -1.0, 2.0, -5.0, 9.0, -7.0, -8.0, -9.0, -4.0));
	blockD[0].g.mC.mA = i16vec3(ivec3(-7, 5, 8));
	blockD[0].g.mC.mB = (mat3x4(2.0, 7.0, 1.0, -1.0, -6.0, -4.0, 0.0, 7.0, 0.0, 5.0, 4.0, 6.0));
	blockD[0].g.mD = (false);
	blockD[0].h = (mat4x3(-6.0, -3.0, 8.0, -7.0, 9.0, -3.0, 5.0, 2.0, 5.0, -1.0, 7.0, 9.0));
	blockD[0].i[0] = (mat4x3(-3.0, -2.0, 0.0, 1.0, -5.0, 7.0, 8.0, -1.0, 7.0, 6.0, -2.0, 4.0));
	blockD[0].i[1] = (mat4x3(-1.0, -6.0, 9.0, 4.0, 4.0, 9.0, 9.0, -9.0, -6.0, 3.0, 3.0, 6.0));
	blockD[0].i[2] = (mat4x3(4.0, -4.0, 2.0, -2.0, 3.0, -2.0, -4.0, 5.0, -7.0, 8.0, -8.0, 6.0));
	blockD[0].i[3] = (mat4x3(-1.0, 3.0, 1.0, -7.0, -5.0, 3.0, 6.0, 2.0, -7.0, -1.0, 9.0, 8.0));
	blockD[0].i[4] = (mat4x3(7.0, -8.0, -5.0, -5.0, -4.0, -5.0, 3.0, -2.0, -8.0, 3.0, 5.0, 0.0));
	blockD[0].i[5] = (mat4x3(9.0, -5.0, -6.0, -4.0, 9.0, 8.0, -2.0, 1.0, 2.0, 8.0, -7.0, -7.0));
	blockD[1].g.mA = (uvec3(6u, 9u, 7u));
	blockD[1].g.mB = (mat3x4(-7.0, -8.0, -9.0, -8.0, -7.0, -1.0, -2.0, -1.0, -5.0, -9.0, 1.0, 2.0));
	blockD[1].g.mC.mA = i16vec3(ivec3(3, -7, -5));
	blockD[1].g.mC.mB = (mat3x4(-8.0, 7.0, -1.0, -8.0, -4.0, -3.0, 9.0, 7.0, -2.0, -1.0, -9.0, 2.0));
	blockD[1].g.mD = (false);
	blockD[1].h = (mat4x3(-7.0, 9.0, -4.0, -1.0, -8.0, 1.0, 8.0, -2.0, -1.0, -1.0, 3.0, 0.0));
	blockD[1].i[0] = (mat4x3(-7.0, -6.0, -1.0, 6.0, -5.0, 8.0, -1.0, 6.0, -4.0, -7.0, -8.0, 1.0));
	blockD[1].i[1] = (mat4x3(-5.0, 5.0, 7.0, -8.0, -6.0, 3.0, 4.0, 9.0, -2.0, 5.0, 4.0, 1.0));
	blockD[1].i[2] = (mat4x3(-6.0, -8.0, 7.0, 5.0, -6.0, -5.0, 9.0, 1.0, -7.0, 2.0, 3.0, 0.0));
	blockD[1].i[3] = (mat4x3(-8.0, 5.0, -5.0, 1.0, 9.0, 1.0, 2.0, -2.0, 1.0, 0.0, -6.0, -2.0));
	blockD[1].i[4] = (mat4x3(-4.0, -3.0, -2.0, -7.0, 1.0, -7.0, -4.0, -6.0, -4.0, 9.0, -5.0, -2.0));
	blockD[1].i[5] = (mat4x3(0.0, 6.0, 0.0, -7.0, 4.0, -6.0, -2.0, -4.0, 3.0, 6.0, -8.0, -7.0));
	blockD[2].g.mA = (uvec3(2u, 3u, 7u));
	blockD[2].g.mB = (mat3x4(-8.0, 0.0, -5.0, 2.0, -8.0, 2.0, 0.0, -8.0, 9.0, -5.0, 3.0, -3.0));
	blockD[2].g.mC.mA = i16vec3(ivec3(-1, -6, 9));
	blockD[2].g.mC.mB = (mat3x4(4.0, -8.0, -1.0, 8.0, -1.0, 1.0, -3.0, 5.0, -4.0, -8.0, -9.0, 1.0));
	blockD[2].g.mD = (false);
	blockD[2].h = (mat4x3(9.0, 2.0, -9.0, -7.0, 4.0, -7.0, -2.0, -5.0, -2.0, -5.0, 2.0, -7.0));
	blockD[2].i[0] = (mat4x3(-4.0, -4.0, 8.0, -2.0, 1.0, -6.0, 5.0, -4.0, 2.0, -5.0, -8.0, 3.0));
	blockD[2].i[1] = (mat4x3(-3.0, -7.0, 8.0, -6.0, -6.0, -1.0, 4.0, 5.0, -1.0, -9.0, -8.0, -2.0));
	blockD[2].i[2] = (mat4x3(2.0, -3.0, 0.0, 3.0, -9.0, -1.0, -5.0, 1.0, 4.0, 7.0, -2.0, 6.0));
	blockD[2].i[3] = (mat4x3(-8.0, 3.0, 9.0, -7.0, -4.0, 6.0, 4.0, -6.0, 7.0, -3.0, -8.0, -9.0));
	blockD[2].i[4] = (mat4x3(8.0, 8.0, 2.0, -7.0, 4.0, -7.0, -8.0, -4.0, 0.0, 1.0, -3.0, 1.0));
	blockD[2].i[5] = (mat4x3(1.0, -2.0, 6.0, -5.0, -7.0, -2.0, -9.0, -5.0, -3.0, 8.0, -5.0, 4.0));
}
#version 450
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
	lowp ivec3 a;
	bool b[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	highp mat3x4 c[4];
	bvec3 d;
	mediump ivec3 e;
	lowp float f;
	mediump float g[];
};
layout(std140, binding = 3) buffer BlockD
{
	bvec2 h;
	mediump mat4 i;
	i16vec4 j;
	highp mat3x2 k[];
};
layout(std430, binding = 4) buffer BlockE
{
	lowp mat2 l;
	bvec4 m[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b[0]), true) && allOk;
	allOk = compare_bool((blockB.b[1]), true) && allOk;
	allOk = compare_bool((blockB.b[2]), false) && allOk;
	allOk = compare_bool((blockB.b[3]), true) && allOk;
	allOk = compare_bool((blockB.b[4]), false) && allOk;
	allOk = compare_bool((blockB.b[5]), false) && allOk;
	allOk = compare_bool((blockB.b[6]), true) && allOk;
	allOk = compare_bool((blockB.b[7]), false) && allOk;
	allOk = compare_ivec3((e), ivec3(-7, 6, 1)) && allOk;
	allOk = compare_float((f), 4.0) && allOk;
	allOk = compare_float((g[0]), 4.0) && allOk;
	allOk = compare_float((g[1]), 8.0) && allOk;
	allOk = compare_float((g[2]), -5.0) && allOk;
	allOk = compare_float((g[3]), -1.0) && allOk;
	allOk = compare_float((g[4]), 9.0) && allOk;
	allOk = compare_float((g[5]), 0.0) && allOk;
	allOk = compare_i16vec4(ivec4(j), ivec4(5, -6, 7, -1)) && allOk;
	allOk = compare_mat2(l, mat2(3.0, -4.0, -1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	c[0] = (mat3x4(-8.0, -8.0, -7.0, 7.0, -9.0, -8.0, 7.0, 4.0, 4.0, 3.0, -9.0, -9.0));
	c[1] = (mat3x4(-3.0, 8.0, 7.0, 9.0, -7.0, -7.0, 4.0, -1.0, 6.0, 3.0, -8.0, 6.0));
	c[2] = (mat3x4(-7.0, 4.0, -2.0, 1.0, -1.0, -2.0, 0.0, -6.0, -7.0, 1.0, -7.0, -3.0));
	c[3] = (mat3x4(3.0, -7.0, -2.0, 8.0, 5.0, 8.0, 9.0, 9.0, 3.0, 4.0, 4.0, 1.0));
	d = (bvec3(true, false, true));
	e = (ivec3(8, 2, 9));
	f = (-2.0);
	h = (bvec2(false, false));
	j = i16vec4(ivec4(-9, -1, 9, 4));
	k[0] = (mat3x2(0.0, 7.0, 9.0, -6.0, -6.0, -8.0));
	k[1] = (mat3x2(-5.0, 8.0, 8.0, 0.0, -8.0, 3.0));
	k[2] = (mat3x2(-2.0, 2.0, 4.0, 5.0, 4.0, -1.0));
	k[3] = (mat3x2(8.0, 8.0, -3.0, -6.0, 1.0, 1.0));
	k[4] = (mat3x2(-5.0, -3.0, 6.0, -8.0, 2.0, -1.0));
	k[5] = (mat3x2(-6.0, -8.0, 0.0, -7.0, 3.0, 6.0));
	k[6] = (mat3x2(3.0, -8.0, -7.0, -9.0, 3.0, 2.0));
	k[7] = (mat3x2(-1.0, -3.0, -1.0, -6.0, -3.0, 6.0));
	l = (mat2(-8.0, 9.0, -6.0, 6.0));
	m[0] = (bvec4(false, false, true, false));
	m[1] = (bvec4(true, false, false, true));
	m[2] = (bvec4(false, true, false, false));
}
#version 450
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
	bool mA[8];
	mediump uvec2 mB;
};
struct sB
{
	highp mat3x2 mA;
	mediump ivec3 mB;
};
struct sC
{
	uint16_t mA;
	highp uvec3 mB;
	i16vec4 mC;
	sB mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	mediump float a;
};
layout(scalar, binding = 2) buffer BlockC
{
	sA b;
	uint16_t c;
	lowp vec3 d;
	lowp mat2x3 e[][2];
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	lowp uvec4 f;
	bvec2 g;
	lowp mat4x2 h;
	sC i;
} blockD;
layout(scalar, binding = 4) buffer BlockE
{
	bvec3 j[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockC.b.mA[0]), false) && allOk;
	allOk = compare_bool((blockC.b.mA[1]), true) && allOk;
	allOk = compare_bool((blockC.b.mA[2]), true) && allOk;
	allOk = compare_bool((blockC.b.mA[3]), false) && allOk;
	allOk = compare_bool((blockC.b.mA[4]), false) && allOk;
	allOk = compare_bool((blockC.b.mA[5]), false) && allOk;
	allOk = compare_bool((blockC.b.mA[6]), true) && allOk;
	allOk = compare_bool((blockC.b.mA[7]), false) && allOk;
	allOk = compare_uvec2((blockC.b.mB), uvec2(8u, 4u)) && allOk;
	allOk = compare_uint16_t(uint(blockC.c), 0u) && allOk;
	allOk = compare_vec3((blockC.d), vec3(-2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockC.e[0][0], mat2x3(5.0, 6.0, -7.0, -4.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockC.e[0][1], mat2x3(7.0, 4.0, -6.0, -8.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockC.e[1][0], mat2x3(-1.0, 0.0, 3.0, 4.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockC.e[1][1], mat2x3(9.0, 2.0, -3.0, 4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockC.e[2][0], mat2x3(-7.0, -7.0, -4.0, -6.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockC.e[2][1], mat2x3(-6.0, -4.0, 6.0, -8.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockC.e[3][0], mat2x3(-1.0, -5.0, 6.0, 1.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockC.e[3][1], mat2x3(-1.0, 7.0, 8.0, 7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockC.e[4][0], mat2x3(-2.0, -2.0, -9.0, 2.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockC.e[4][1], mat2x3(0.0, 4.0, 2.0, 3.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockC.e[5][0], mat2x3(2.0, -3.0, 5.0, 0.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockC.e[5][1], mat2x3(-2.0, -1.0, -2.0, 5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockC.e[6][0], mat2x3(4.0, -5.0, -3.0, -1.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockC.e[6][1], mat2x3(0.0, -7.0, 8.0, 9.0, -4.0, 5.0)) && allOk;
	allOk = compare_uvec4((blockD.f), uvec4(2u, 2u, 2u, 1u)) && allOk;
	allOk = compare_bvec2((blockD.g), bvec2(true, false)) && allOk;
	allOk = compare_uint16_t(uint(blockD.i.mA), 3u) && allOk;
	allOk = compare_uvec3((blockD.i.mB), uvec3(2u, 2u, 2u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.i.mC), ivec4(5, 0, -6, 0)) && allOk;
	allOk = compare_mat3x2(blockD.i.mD.mA, mat3x2(-7.0, 0.0, 8.0, -3.0, 2.0, 7.0)) && allOk;
	allOk = compare_ivec3((blockD.i.mD.mB), ivec3(2, 2, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (-4.0);
	blockC.b.mA[0] = (true);
	blockC.b.mA[1] = (false);
	blockC.b.mA[2] = (false);
	blockC.b.mA[3] = (false);
	blockC.b.mA[4] = (false);
	blockC.b.mA[5] = (true);
	blockC.b.mA[6] = (true);
	blockC.b.mA[7] = (true);
	blockC.b.mB = (uvec2(5u, 1u));
	blockC.d = (vec3(-7.0, -2.0, -8.0));
	blockC.e[0][0] = (mat2x3(-4.0, 4.0, -6.0, -2.0, 3.0, 9.0));
	blockC.e[0][1] = (mat2x3(-9.0, 3.0, 0.0, -9.0, 3.0, -5.0));
	blockC.e[1][0] = (mat2x3(4.0, 5.0, -6.0, 3.0, -9.0, -9.0));
	blockC.e[1][1] = (mat2x3(-1.0, -1.0, -8.0, 1.0, 8.0, -1.0));
	blockC.e[2][0] = (mat2x3(7.0, 6.0, 5.0, 2.0, 9.0, -9.0));
	blockC.e[2][1] = (mat2x3(-8.0, 7.0, -8.0, 6.0, -3.0, 9.0));
	blockC.e[3][0] = (mat2x3(4.0, 9.0, 0.0, -7.0, 0.0, 4.0));
	blockC.e[3][1] = (mat2x3(-4.0, -6.0, 5.0, 0.0, -4.0, -2.0));
	blockC.e[4][0] = (mat2x3(-6.0, -9.0, -7.0, 9.0, -6.0, 6.0));
	blockC.e[4][1] = (mat2x3(1.0, -8.0, -4.0, -4.0, -3.0, 4.0));
	blockC.e[5][0] = (mat2x3(8.0, 3.0, 8.0, 8.0, -6.0, 9.0));
	blockC.e[5][1] = (mat2x3(7.0, 9.0, 1.0, -2.0, -6.0, -3.0));
	blockC.e[6][0] = (mat2x3(4.0, 8.0, -3.0, 3.0, 3.0, 2.0));
	blockC.e[6][1] = (mat2x3(2.0, 3.0, 6.0, -1.0, -9.0, -9.0));
	blockD.f = (uvec4(4u, 8u, 1u, 0u));
	blockD.h = (mat4x2(5.0, 7.0, 8.0, 0.0, 8.0, 6.0, 4.0, -6.0));
	blockD.i.mA = uint16_t(6u);
	blockD.i.mB = (uvec3(0u, 6u, 6u));
	blockD.i.mC = i16vec4(ivec4(4, -7, -5, 3));
	blockD.i.mD.mA = (mat3x2(-3.0, -1.0, 3.0, 9.0, 2.0, -1.0));
	blockD.i.mD.mB = (ivec3(-9, 3, 8));
	blockE.j[0] = (bvec3(false, true, true));
	blockE.j[1] = (bvec3(true, false, false));
	blockE.j[2] = (bvec3(true, false, false));
	blockE.j[3] = (bvec3(false, false, false));
	blockE.j[4] = (bvec3(false, true, true));
	blockE.j[5] = (bvec3(false, false, false));
	blockE.j[6] = (bvec3(false, true, false));
}
#version 450
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
	mediump int a;
	mediump vec3 b;
	mediump vec4 c[];
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	u16vec4 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((a), 0) && allOk;
	allOk = compare_vec3((b), vec3(-6.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (9);
	b = (vec3(-5.0, 0.0, 1.0));
	c[0] = (vec4(-9.0, -8.0, 5.0, 8.0));
	c[1] = (vec4(-8.0, -3.0, -3.0, 1.0));
	c[2] = (vec4(5.0, -4.0, -8.0, -9.0));
	c[3] = (vec4(2.0, -1.0, 5.0, 2.0));
	c[4] = (vec4(1.0, -6.0, -9.0, 0.0));
	c[5] = (vec4(-4.0, -9.0, -9.0, -1.0));
	d[0] = u16vec4(uvec4(8u, 6u, 9u, 8u));
	d[1] = u16vec4(uvec4(9u, 9u, 0u, 4u));
	d[2] = u16vec4(uvec4(4u, 7u, 8u, 5u));
	d[3] = u16vec4(uvec4(5u, 3u, 9u, 5u));
	d[4] = u16vec4(uvec4(1u, 2u, 3u, 3u));
}
#version 450
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
	mediump ivec2 b;
	uint8_t c;
	mediump uvec4 d;
};
layout(std430, binding = 2) buffer BlockC
{
	mediump uvec3 e;
	lowp uvec4 f[1];
	highp uvec3 g;
	uint8_t h;
};
layout(std140, binding = 3) buffer BlockD
{
	highp uvec4 i;
	lowp float j;
	highp vec3 k;
	lowp int l;
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	i8vec2 m;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((b), ivec2(-5, 2)) && allOk;
	allOk = compare_uvec4((d), uvec4(0u, 3u, 8u, 7u)) && allOk;
	allOk = compare_uvec3((e), uvec3(6u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((f[0]), uvec4(1u, 2u, 9u, 2u)) && allOk;
	allOk = compare_uvec3((g), uvec3(1u, 5u, 9u)) && allOk;
	allOk = compare_vec3((blockD.k), vec3(-9.0, 0.0, -1.0)) && allOk;
	allOk = compare_int((blockD.l), -1) && allOk;
	allOk = compare_i8vec2(ivec2(m), ivec2(5, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec4(9, -2, -3, -7));
	b = (ivec2(6, 2));
	d = (uvec4(1u, 7u, 5u, 0u));
	e = (uvec3(0u, 6u, 2u));
	f[0] = (uvec4(6u, 3u, 7u, 5u));
	g = (uvec3(0u, 9u, 5u));
	h = uint8_t(7u);
	blockD.i = (uvec4(8u, 3u, 2u, 2u));
	blockD.k = (vec3(6.0, -9.0, 7.0));
	m = i8vec2(ivec2(3, 9));
}
#version 450
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
	u8vec2 a;
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	bvec3 b;
	mediump vec4 c;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	highp vec4 d;
	bvec4 e;
	lowp vec3 f;
};
layout(std140, binding = 4) buffer BlockE
{
	i8vec4 g;
	mediump mat3 h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockC.c), vec4(4.0, 1.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec3((f), vec3(1.0, -4.0, -4.0)) && allOk;
	allOk = compare_i8vec4(ivec4(g), ivec4(4294967293, 1, 5, 6)) && allOk;
	allOk = compare_mat3(h, mat3(9.0, 0.0, 1.0, -3.0, 1.0, 6.0, 6.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (vec4(2.0, -4.0, -1.0, -9.0));
	e = (bvec4(true, true, true, false));
	f = (vec3(1.0, -6.0, 2.0));
	g = i8vec4(ivec4(4294967295, 4, 4294967292, 4294967289));
	h = (mat3(8.0, -8.0, 1.0, -1.0, -6.0, -3.0, 2.0, 0.0, -6.0));
}
#version 450
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
	lowp uvec4 a[];
} blockB[2];

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB[0].a[0]), uvec4(0u, 2u, 0u, 4u)) && allOk;
	allOk = compare_uvec4((blockB[1].a[0]), uvec4(4u, 0u, 9u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	u8vec2 b[];
} blockB[2];
layout(std430, column_major, binding = 2) readonly buffer BlockC
{
	highp mat3x4 c;
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	mediump int d;
	i8vec4 e[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[0].a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[0].b[0]), uvec2(4u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[0].b[1]), uvec2(2u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[0].b[2]), uvec2(9u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[0].b[3]), uvec2(4u, 1u)) && allOk;
	allOk = compare_bvec4((blockB[1].a), bvec4(false, true, false, true)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[1].b[0]), uvec2(1u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[1].b[1]), uvec2(2u, 2u)) && allOk;
	allOk = compare_int((blockD.d), -3) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.e[0]), ivec4(0, 4294967294, 4294967292, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.e[1]), ivec4(4294967290, 4294967293, 5, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.e[2]), ivec4(4, 4294967292, 8, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.e[3]), ivec4(4294967292, 4294967290, 4294967293, 0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.e[4]), ivec4(4294967287, 9, 8, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.e[5]), ivec4(8, 4294967292, 4294967287, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.e[6]), ivec4(6, 8, 4294967295, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.e[7]), ivec4(7, 8, 6, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec4(true, false, true, false));
	blockB[0].b[0] = u8vec2(uvec2(4u, 2u));
	blockB[0].b[1] = u8vec2(uvec2(4u, 5u));
	blockB[0].b[2] = u8vec2(uvec2(4u, 9u));
	blockB[0].b[3] = u8vec2(uvec2(7u, 2u));
	blockB[1].a = (bvec4(false, false, false, false));
	blockB[1].b[0] = u8vec2(uvec2(8u, 0u));
	blockB[1].b[1] = u8vec2(uvec2(1u, 8u));
	blockD.d = (-3);
	blockD.e[0] = i8vec4(ivec4(2, 4, 4, 4294967290));
	blockD.e[1] = i8vec4(ivec4(4, 4294967291, 4294967294, 4294967292));
	blockD.e[2] = i8vec4(ivec4(4294967291, 7, 6, 4294967287));
	blockD.e[3] = i8vec4(ivec4(0, 4294967289, 2, 1));
	blockD.e[4] = i8vec4(ivec4(9, 2, 4294967287, 4294967294));
	blockD.e[5] = i8vec4(ivec4(4294967289, 8, 8, 8));
	blockD.e[6] = i8vec4(ivec4(7, 9, 4294967290, 4294967293));
	blockD.e[7] = i8vec4(ivec4(4294967295, 3, 7, 4294967294));
}
#version 450
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
	lowp mat3x4 a;
	i8vec2 b;
	lowp mat3x2 c;
} blockB[2];
layout(std140, column_major, binding = 2) buffer BlockC
{
	mediump uvec4 d;
	highp mat2x3 e;
	highp mat4x2 f;
	bvec3 g[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockC.d), uvec4(9u, 9u, 5u, 6u)) && allOk;
	allOk = compare_mat2x3(blockC.e, mat2x3(-1.0, -8.0, -4.0, -6.0, 7.0, -1.0)) && allOk;
	allOk = compare_bvec3((blockC.g[0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockC.g[1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockC.g[2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockC.g[3]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockC.g[4]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockC.g[5]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockC.g[6]), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = i8vec2(ivec2(4294967295, 4294967287));
	blockB[1].b = i8vec2(ivec2(4294967291, 4294967287));
	blockC.e = (mat2x3(1.0, 6.0, 7.0, -7.0, 2.0, -1.0));
	blockC.g[0] = (bvec3(false, false, false));
	blockC.g[1] = (bvec3(true, true, true));
	blockC.g[2] = (bvec3(true, false, true));
	blockC.g[3] = (bvec3(true, true, false));
	blockC.g[4] = (bvec3(true, false, false));
	blockC.g[5] = (bvec3(false, false, false));
	blockC.g[6] = (bvec3(true, false, false));
}
#version 450
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
	allOk = compare_mat2(var, mat2(-9.0, 9.0, 2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(-5.0, 5.0, 6.0, -3.0, 3.0, 8.0, -6.0, 6.0, 4.0, 6.0, 4.0, 6.0, 4.0, 5.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[0][3], 9.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], -1.0) && allOk;
	allOk = compare_float(var[2][0], 8.0) && allOk;
	allOk = compare_float(var[2][1], 4.0) && allOk;
	allOk = compare_float(var[2][2], -5.0) && allOk;
	allOk = compare_float(var[2][3], 2.0) && allOk;
	allOk = compare_float(var[3][0], 8.0) && allOk;
	allOk = compare_float(var[3][1], -3.0) && allOk;
	allOk = compare_float(var[3][2], 7.0) && allOk;
	allOk = compare_float(var[3][3], -1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-4.0, -4.0, 5.0, 9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-7.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(8.0, 4.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(8.0, -3.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4(var, mat4(-9.0, -5.0, -6.0, -1.0, 3.0, -5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, -4.0, -9.0, 4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, binding = 1) readonly buffer Block
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

}
#version 450
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

}
#version 450
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

}
#version 450
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(3.0, -4.0, 1.0, -6.0, 0.0, 0.0, -1.0, -6.0, -3.0, 1.0, 1.0, 9.0, 6.0, 8.0, 9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -4.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[1][2], -3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(0.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(8.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -4.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(1.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(5.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x4(var, mat3x4(-1.0, 2.0, -7.0, 9.0, -8.0, 7.0, -7.0, -6.0, -6.0, 1.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], -7.0) && allOk;
	allOk = compare_float(var[3][0], 9.0) && allOk;
	allOk = compare_float(var[3][1], 7.0) && allOk;
	allOk = compare_vec2(var[0], vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(3.0, 0.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-6.0, -7.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[0][2], 9.0) && allOk;
	allOk = compare_float(var[0][3], -9.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_float(var[1][2], 4.0) && allOk;
	allOk = compare_float(var[1][3], 0.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-3.0, 2.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-6.0, 9.0, 4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(-6.0, -8.0, -3.0, 7.0, -7.0, 8.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	float16_t var[3];
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(var[0]), -7.0) && allOk;
	allOk = compare_float16_t(float(var[1]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[2]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(-7.0, -8.0, 1.0, -7.0, 8.0, 3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(3.0, -9.0, -2.0, -1.0, 3.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(-2.0, 8.0, -6.0, 4.0, 6.0, -4.0, 4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	int8_t padding;
	int8_t var[3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[0]), 3) && allOk;
	allOk = compare_int8_t(int(var[1]), 3) && allOk;
	allOk = compare_int8_t(int(var[2]), 1) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2 var[];
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
	allOk = compare_mat2(var[3], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(-9.0, 4.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(-8.0, 5.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-9.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(-5.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(1.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(-9.0, 9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(2.0, -4.0, -2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[3], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-5.0, -6.0, -9.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(1.0, 6.0, 2.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(-4.0, -2.0, -2.0, 0.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(5.0, -5.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(7.0, -4.0, -4.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(-8.0, 6.0, 4.0, 2.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(9.0, 7.0, 3.0, 7.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], 5.0) && allOk;
	allOk = compare_float(block.var[0][2], -7.0) && allOk;
	allOk = compare_float(block.var[0][3], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], -6.0) && allOk;
	allOk = compare_float(block.var[1][2], 7.0) && allOk;
	allOk = compare_float(block.var[1][3], 8.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-6.0, 5.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(2.0, -6.0, 7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(8.0, -9.0, 0.0, -6.0));
	block.var[1] = (vec4(7.0, 8.0, 6.0, -6.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(-6.0, -6.0, -8.0, -2.0, -6.0, -3.0, 8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(2.0, -2.0, -6.0, 0.0, -7.0, 7.0, -9.0, 0.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(8.0, -8.0, -2.0, -6.0, -3.0, 1.0, 4.0, -6.0, 6.0, 8.0, -7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(6.0, -8.0, -6.0, -7.0, 1.0, -5.0, 8.0, 0.0, 5.0, 6.0, 6.0, 8.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(5.0, -7.0, -1.0, -7.0, -8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(4.0, 9.0, -4.0));
	block.var[1] = (vec3(1.0, 8.0, 1.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -9.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], -9.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[2][0], -4.0) && allOk;
	allOk = compare_float(block.var[2][1], -2.0) && allOk;
	allOk = compare_float(block.var[2][2], -9.0) && allOk;
	allOk = compare_float(block.var[3][0], -7.0) && allOk;
	allOk = compare_float(block.var[3][1], 0.0) && allOk;
	allOk = compare_float(block.var[3][2], -6.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-9.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(9.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-4.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-7.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-9.0, 6.0, -2.0));
	block.var[1] = (vec3(-9.0, 9.0, -9.0));
	block.var[2] = (vec3(6.0, 9.0, -6.0));
	block.var[3] = (vec3(-2.0, 0.0, -9.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_vec3((block.var), vec3(4.0, -9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-8.0);
	block.var = (vec3(-5.0, 8.0, 9.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -1.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[0][2], 9.0) && allOk;
	allOk = compare_float(block.var[0][3], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], 7.0) && allOk;
	allOk = compare_float(block.var[1][2], -1.0) && allOk;
	allOk = compare_float(block.var[1][3], 4.0) && allOk;
	allOk = compare_float(block.var[2][0], -2.0) && allOk;
	allOk = compare_float(block.var[2][1], 9.0) && allOk;
	allOk = compare_float(block.var[2][2], 9.0) && allOk;
	allOk = compare_float(block.var[2][3], 7.0) && allOk;
	allOk = compare_float(block.var[3][0], -5.0) && allOk;
	allOk = compare_float(block.var[3][1], 0.0) && allOk;
	allOk = compare_float(block.var[3][2], -6.0) && allOk;
	allOk = compare_float(block.var[3][3], -3.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-1.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-5.0, 7.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-2.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(-5.0, 0.0, -6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var = (mat4(-3.0, -8.0, 1.0, 3.0, -4.0, -4.0, -4.0, -6.0, -6.0, 9.0, 1.0, 1.0, 3.0, 2.0, -6.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat2x4(block.var, mat2x4(5.0, -4.0, 1.0, -2.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (9.0);
	block.var = (mat2x4(-7.0, -2.0, 1.0, 7.0, 1.0, 1.0, 9.0, -6.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat3x2(block.var, mat3x2(-9.0, -5.0, 4.0, 9.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var = (mat3x2(7.0, -6.0, -3.0, -3.0, 0.0, 9.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat4x2(block.var, mat4x2(9.0, -7.0, -8.0, 6.0, -6.0, -5.0, 4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var = (mat4x2(5.0, 0.0, 9.0, -7.0, -5.0, 2.0, -3.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_mat4x3(block.var, mat4x3(-5.0, 5.0, 3.0, -1.0, -9.0, -4.0, 8.0, -4.0, -1.0, 3.0, 8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var = (mat4x3(7.0, -4.0, 4.0, 2.0, -9.0, -3.0, 8.0, -4.0, -5.0, -4.0, 6.0, 4.0));
}
#version 450
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
	f16vec2 var;
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
	allOk = compare_f16vec2(vec2(block.var), vec2(-3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = float16_t(-2.0);
	block.var = f16vec2(vec2(4.0, -2.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	block.var[0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	block.var[0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	block.var[1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	block.var[1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	block.var[1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	block.var[2][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	block.var[2][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	block.var[2][2] = (vec4(0.0, 4.0, 1.0, -9.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	block.var[1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	block.var[2] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat4x2(block.var[0], mat4x2(1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0] = (mat4x2(-8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0, 5.0));
	block.var[1] = (mat4x2(8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0, -6.0));
	block.var[2] = (mat4x2(-9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0, 8.0));
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat3(block.var[0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(3.0, 7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(4.0, 9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(-9.0, -9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(-2.0, -1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(-4.0, 9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(6.0, -4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(0.0, 5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(-3.0, -7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(8.0, 4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(1.0, 8.0, -5.0, -5.0, -8.0, -4.0, -7.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(-5.0, -8.0, 6.0, 4.0, -3.0, 9.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(-2.0, 7.0, -4.0, 4.0, -4.0, 1.0, 6.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(2.0, -6.0, 4.0, -6.0, 8.0, 1.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(6.0, 5.0, 5.0, -1.0, -9.0, -7.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(0.0, -7.0, 0.0, -4.0, 1.0, -7.0, 1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(2.0, -4.0, -2.0, -7.0, 2.0, -2.0, 9.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(2.0, -4.0, 9.0));
	block.var[0][1] = (vec3(-4.0, 2.0, 5.0));
	block.var[0][2] = (vec3(5.0, -9.0, -5.0));
	block.var[1][0] = (vec3(3.0, 1.0, 8.0));
	block.var[1][1] = (vec3(6.0, 9.0, -8.0));
	block.var[1][2] = (vec3(-1.0, 5.0, 1.0));
	block.var[2][0] = (vec3(6.0, -5.0, -4.0));
	block.var[2][1] = (vec3(-8.0, -8.0, -2.0));
	block.var[2][2] = (vec3(9.0, -4.0, 4.0));
	block.var[3][0] = (vec3(4.0, -1.0, 5.0));
	block.var[3][1] = (vec3(-1.0, 0.0, 9.0));
	block.var[3][2] = (vec3(7.0, 7.0, 5.0));
	block.var[4][0] = (vec3(8.0, -6.0, -1.0));
	block.var[4][1] = (vec3(-1.0, -2.0, -5.0));
	block.var[4][2] = (vec3(-5.0, 6.0, -3.0));
	block.var[5][0] = (vec3(-4.0, -6.0, 2.0));
	block.var[5][1] = (vec3(3.0, -1.0, 2.0));
	block.var[5][2] = (vec3(-3.0, 4.0, 1.0));
	block.var[6][0] = (vec3(9.0, -3.0, -9.0));
	block.var[6][1] = (vec3(6.0, -1.0, -6.0));
	block.var[6][2] = (vec3(6.0, 2.0, -5.0));
	block.var[7][0] = (vec3(-1.0, -2.0, 2.0));
	block.var[7][1] = (vec3(9.0, 1.0, -8.0));
	block.var[7][2] = (vec3(6.0, -1.0, 7.0));
	block.var[8][0] = (vec3(4.0, 2.0, -8.0));
	block.var[8][1] = (vec3(0.0, 3.0, 9.0));
	block.var[8][2] = (vec3(9.0, -8.0, -4.0));
	block.var[9][0] = (vec3(-8.0, 3.0, 4.0));
	block.var[9][1] = (vec3(-4.0, 4.0, 1.0));
	block.var[9][2] = (vec3(0.0, 4.0, 5.0));
	block.var[10][0] = (vec3(-9.0, -4.0, 2.0));
	block.var[10][1] = (vec3(-6.0, 8.0, 3.0));
	block.var[10][2] = (vec3(2.0, 0.0, -1.0));
	block.var[11][0] = (vec3(7.0, 1.0, 3.0));
	block.var[11][1] = (vec3(5.0, 1.0, -6.0));
	block.var[11][2] = (vec3(2.0, -5.0, 4.0));
	block.var[12][0] = (vec3(-9.0, -8.0, 2.0));
	block.var[12][1] = (vec3(-6.0, 9.0, -7.0));
	block.var[12][2] = (vec3(9.0, 6.0, 1.0));
	block.var[13][0] = (vec3(-4.0, 8.0, -7.0));
	block.var[13][1] = (vec3(1.0, 0.0, 4.0));
	block.var[13][2] = (vec3(-6.0, -3.0, 3.0));
	block.var[14][0] = (vec3(-5.0, -6.0, 5.0));
	block.var[14][1] = (vec3(4.0, 3.0, -2.0));
	block.var[14][2] = (vec3(-6.0, -4.0, -1.0));
	block.var[15][0] = (vec3(4.0, 4.0, -6.0));
	block.var[15][1] = (vec3(0.0, 2.0, -5.0));
	block.var[15][2] = (vec3(5.0, 8.0, -2.0));
	block.var[16][0] = (vec3(3.0, -1.0, 7.0));
	block.var[16][1] = (vec3(-9.0, -9.0, -8.0));
	block.var[16][2] = (vec3(9.0, -9.0, -5.0));
	block.var[17][0] = (vec3(1.0, -2.0, 1.0));
	block.var[17][1] = (vec3(-8.0, -4.0, -3.0));
	block.var[17][2] = (vec3(3.0, -4.0, -3.0));
	block.var[18][0] = (vec3(-5.0, 7.0, 5.0));
	block.var[18][1] = (vec3(-2.0, -2.0, 8.0));
	block.var[18][2] = (vec3(-3.0, 1.0, 7.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(4.0, 9.0, 6.0, -4.0, -3.0, 3.0, -3.0, 5.0, -3.0, 6.0, -9.0, 2.0, 5.0, 7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(-5.0, -3.0, 7.0, -5.0, -5.0, -7.0, -9.0, 5.0, 3.0, -1.0, 9.0, -3.0, 4.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(-6.0, -7.0, -9.0, 4.0, 6.0, -4.0, 2.0, -1.0, 9.0, 3.0, -3.0, 3.0, -6.0, 5.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(-8.0, -6.0, 5.0, 0.0, -1.0, -7.0, 4.0, 2.0, -1.0, -9.0, 6.0, 4.0, -9.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(-3.0, 8.0, -5.0, 2.0, -2.0, -2.0, 9.0, 4.0, 0.0, 3.0, -5.0, 4.0, 0.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(7.0, -4.0, 0.0, -2.0, -9.0, -9.0, 0.0, -9.0, 7.0, 9.0, -9.0, -9.0, -8.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(-9.0, 0.0, -3.0, -3.0, -4.0, -6.0, -9.0, 9.0, 8.0, 6.0, 3.0, -2.0, 1.0, 5.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	block.var[1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	block.var[2] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
	block.var[3] = (mat4(-1.0, 9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0));
	block.var[4] = (mat4(5.0, 6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0));
	block.var[5] = (mat4(7.0, -1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0));
	block.var[6] = (mat4(4.0, -8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0));
	block.var[7] = (mat4(-9.0, -2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0));
	block.var[8] = (mat4(5.0, -2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0));
	block.var[9] = (mat4(-2.0, -6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0));
	block.var[10] = (mat4(-9.0, -3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0));
	block.var[11] = (mat4(6.0, 9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0));
	block.var[12] = (mat4(5.0, 4.0, 4.0, 1.0, 7.0, -5.0, 1.0, 7.0, 8.0, 8.0, 5.0, 4.0, 9.0, -4.0, 9.0, 7.0));
	block.var[13] = (mat4(8.0, 7.0, -8.0, 1.0, -7.0, 7.0, 0.0, -2.0, 1.0, -8.0, -2.0, 8.0, -8.0, 9.0, -6.0, -1.0));
	block.var[14] = (mat4(-3.0, -5.0, -4.0, -7.0, -9.0, -6.0, -8.0, 6.0, -1.0, 8.0, 0.0, -8.0, -4.0, 4.0, 8.0, -5.0));
	block.var[15] = (mat4(-4.0, -9.0, 6.0, 9.0, -4.0, -2.0, -8.0, -8.0, 4.0, 7.0, 3.0, 6.0, -4.0, -3.0, -4.0, 6.0));
	block.var[16] = (mat4(7.0, 4.0, 4.0, 3.0, -8.0, -4.0, -4.0, 7.0, -3.0, -4.0, 4.0, -6.0, 2.0, 8.0, 4.0, -7.0));
	block.var[17] = (mat4(1.0, 1.0, 6.0, 3.0, 8.0, 2.0, -7.0, 7.0, 9.0, -8.0, 9.0, 0.0, 8.0, 4.0, 8.0, 2.0));
	block.var[18] = (mat4(4.0, 2.0, -9.0, 1.0, 5.0, -7.0, -4.0, -2.0, -7.0, -5.0, 1.0, -6.0, -8.0, 6.0, -2.0, 4.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	bvec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((block.var[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[6]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[7]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[8]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[9]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[10]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[11]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[12]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[13]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[14]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[15]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[16]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[17]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[18]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (bvec2(true, false));
	block.var[1] = (bvec2(true, true));
	block.var[2] = (bvec2(false, false));
	block.var[3] = (bvec2(false, false));
	block.var[4] = (bvec2(false, true));
	block.var[5] = (bvec2(true, true));
	block.var[6] = (bvec2(false, false));
	block.var[7] = (bvec2(false, true));
	block.var[8] = (bvec2(true, true));
	block.var[9] = (bvec2(false, false));
	block.var[10] = (bvec2(true, false));
	block.var[11] = (bvec2(true, false));
	block.var[12] = (bvec2(false, true));
	block.var[13] = (bvec2(true, true));
	block.var[14] = (bvec2(false, false));
	block.var[15] = (bvec2(true, true));
	block.var[16] = (bvec2(true, false));
	block.var[17] = (bvec2(false, false));
	block.var[18] = (bvec2(true, false));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(0.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(-4.0, -1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(-1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(-7.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(-9.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(-4.0, -9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(-9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(-9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(-2.0, -4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(4.0, -3.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(-5.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(8.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(1.0, 1.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(-6.0, 1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(7.0, -2.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(-3.0, 3.0));
	block.var[0][1] = (vec2(4.0, 4.0));
	block.var[1][0] = (vec2(9.0, -9.0));
	block.var[1][1] = (vec2(-5.0, 8.0));
	block.var[2][0] = (vec2(0.0, 4.0));
	block.var[2][1] = (vec2(2.0, -4.0));
	block.var[3][0] = (vec2(-3.0, 3.0));
	block.var[3][1] = (vec2(-8.0, -7.0));
	block.var[4][0] = (vec2(-7.0, -6.0));
	block.var[4][1] = (vec2(-2.0, 1.0));
	block.var[5][0] = (vec2(-4.0, 3.0));
	block.var[5][1] = (vec2(0.0, 7.0));
	block.var[6][0] = (vec2(-7.0, -5.0));
	block.var[6][1] = (vec2(6.0, -6.0));
	block.var[7][0] = (vec2(-4.0, 0.0));
	block.var[7][1] = (vec2(2.0, 3.0));
	block.var[8][0] = (vec2(-2.0, -4.0));
	block.var[8][1] = (vec2(-1.0, 1.0));
	block.var[9][0] = (vec2(8.0, -9.0));
	block.var[9][1] = (vec2(8.0, -6.0));
	block.var[10][0] = (vec2(7.0, -2.0));
	block.var[10][1] = (vec2(1.0, -2.0));
	block.var[11][0] = (vec2(-7.0, -6.0));
	block.var[11][1] = (vec2(8.0, -4.0));
	block.var[12][0] = (vec2(-3.0, -8.0));
	block.var[12][1] = (vec2(-4.0, -7.0));
	block.var[13][0] = (vec2(-9.0, 5.0));
	block.var[13][1] = (vec2(5.0, -6.0));
	block.var[14][0] = (vec2(4.0, -1.0));
	block.var[14][1] = (vec2(-3.0, -8.0));
	block.var[15][0] = (vec2(1.0, -2.0));
	block.var[15][1] = (vec2(-6.0, -3.0));
	block.var[16][0] = (vec2(-5.0, 4.0));
	block.var[16][1] = (vec2(-7.0, -6.0));
	block.var[17][0] = (vec2(1.0, -9.0));
	block.var[17][1] = (vec2(7.0, -1.0));
	block.var[18][0] = (vec2(-6.0, -1.0));
	block.var[18][1] = (vec2(9.0, -5.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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

layout(std430, buffer_reference) buffer Block
{
	u8vec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(block.var[0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[4]), uvec2(9u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[5]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[6]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[7]), uvec2(6u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[8]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[9]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[10]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[11]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[12]), uvec2(8u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[13]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[14]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[15]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[16]), uvec2(2u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[17]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[18]), uvec2(6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u8vec2(uvec2(7u, 7u));
	block.var[1] = u8vec2(uvec2(9u, 6u));
	block.var[2] = u8vec2(uvec2(0u, 2u));
	block.var[3] = u8vec2(uvec2(1u, 1u));
	block.var[4] = u8vec2(uvec2(0u, 8u));
	block.var[5] = u8vec2(uvec2(8u, 5u));
	block.var[6] = u8vec2(uvec2(2u, 7u));
	block.var[7] = u8vec2(uvec2(4u, 4u));
	block.var[8] = u8vec2(uvec2(7u, 2u));
	block.var[9] = u8vec2(uvec2(4u, 5u));
	block.var[10] = u8vec2(uvec2(0u, 2u));
	block.var[11] = u8vec2(uvec2(1u, 8u));
	block.var[12] = u8vec2(uvec2(1u, 8u));
	block.var[13] = u8vec2(uvec2(4u, 0u));
	block.var[14] = u8vec2(uvec2(2u, 7u));
	block.var[15] = u8vec2(uvec2(2u, 0u));
	block.var[16] = u8vec2(uvec2(2u, 5u));
	block.var[17] = u8vec2(uvec2(3u, 4u));
	block.var[18] = u8vec2(uvec2(7u, 4u));
}
#version 450
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
	float16_t var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.var[0]), -7.0) && allOk;
	allOk = compare_float16_t(float(block.var[1]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[2]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[3]), 0.0) && allOk;
	allOk = compare_float16_t(float(block.var[4]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[5]), 9.0) && allOk;
	allOk = compare_float16_t(float(block.var[6]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[7]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[8]), 7.0) && allOk;
	allOk = compare_float16_t(float(block.var[9]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[10]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[11]), -3.0) && allOk;
	allOk = compare_float16_t(float(block.var[12]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[13]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[14]), -8.0) && allOk;
	allOk = compare_float16_t(float(block.var[15]), -2.0) && allOk;
	allOk = compare_float16_t(float(block.var[16]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[17]), 3.0) && allOk;
	allOk = compare_float16_t(float(block.var[18]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = float16_t(-8.0);
	block.var[1] = float16_t(9.0);
	block.var[2] = float16_t(-2.0);
	block.var[3] = float16_t(7.0);
	block.var[4] = float16_t(8.0);
	block.var[5] = float16_t(-9.0);
	block.var[6] = float16_t(2.0);
	block.var[7] = float16_t(-8.0);
	block.var[8] = float16_t(-1.0);
	block.var[9] = float16_t(6.0);
	block.var[10] = float16_t(-7.0);
	block.var[11] = float16_t(-5.0);
	block.var[12] = float16_t(8.0);
	block.var[13] = float16_t(-3.0);
	block.var[14] = float16_t(6.0);
	block.var[15] = float16_t(-3.0);
	block.var[16] = float16_t(-8.0);
	block.var[17] = float16_t(1.0);
	block.var[18] = float16_t(3.0);
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(4.0, 9.0, 6.0, -4.0, -3.0, 3.0, -3.0, 5.0, -3.0, 6.0, -9.0, 2.0, 5.0, 7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(-5.0, -3.0, 7.0, -5.0, -5.0, -7.0, -9.0, 5.0, 3.0, -1.0, 9.0, -3.0, 4.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(-6.0, -7.0, -9.0, 4.0, 6.0, -4.0, 2.0, -1.0, 9.0, 3.0, -3.0, 3.0, -6.0, 5.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(-8.0, -6.0, 5.0, 0.0, -1.0, -7.0, 4.0, 2.0, -1.0, -9.0, 6.0, 4.0, -9.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(-3.0, 8.0, -5.0, 2.0, -2.0, -2.0, 9.0, 4.0, 0.0, 3.0, -5.0, 4.0, 0.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(7.0, -4.0, 0.0, -2.0, -9.0, -9.0, 0.0, -9.0, 7.0, 9.0, -9.0, -9.0, -8.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(-9.0, 0.0, -3.0, -3.0, -4.0, -6.0, -9.0, 9.0, 8.0, 6.0, 3.0, -2.0, 1.0, 5.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	block.var[1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	block.var[2] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
	block.var[3] = (mat4(-1.0, 9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0));
	block.var[4] = (mat4(5.0, 6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0));
	block.var[5] = (mat4(7.0, -1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0));
	block.var[6] = (mat4(4.0, -8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0));
	block.var[7] = (mat4(-9.0, -2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0));
	block.var[8] = (mat4(5.0, -2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0));
	block.var[9] = (mat4(-2.0, -6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0));
	block.var[10] = (mat4(-9.0, -3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0));
	block.var[11] = (mat4(6.0, 9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0));
	block.var[12] = (mat4(5.0, 4.0, 4.0, 1.0, 7.0, -5.0, 1.0, 7.0, 8.0, 8.0, 5.0, 4.0, 9.0, -4.0, 9.0, 7.0));
	block.var[13] = (mat4(8.0, 7.0, -8.0, 1.0, -7.0, 7.0, 0.0, -2.0, 1.0, -8.0, -2.0, 8.0, -8.0, 9.0, -6.0, -1.0));
	block.var[14] = (mat4(-3.0, -5.0, -4.0, -7.0, -9.0, -6.0, -8.0, 6.0, -1.0, 8.0, 0.0, -8.0, -4.0, 4.0, 8.0, -5.0));
	block.var[15] = (mat4(-4.0, -9.0, 6.0, 9.0, -4.0, -2.0, -8.0, -8.0, 4.0, 7.0, 3.0, 6.0, -4.0, -3.0, -4.0, 6.0));
	block.var[16] = (mat4(7.0, 4.0, 4.0, 3.0, -8.0, -4.0, -4.0, 7.0, -3.0, -4.0, 4.0, -6.0, 2.0, 8.0, 4.0, -7.0));
	block.var[17] = (mat4(1.0, 1.0, 6.0, 3.0, 8.0, 2.0, -7.0, 7.0, 9.0, -8.0, 9.0, 0.0, 8.0, 4.0, 8.0, 2.0));
	block.var[18] = (mat4(4.0, 2.0, -9.0, 1.0, 5.0, -7.0, -4.0, -2.0, -7.0, -5.0, 1.0, -6.0, -8.0, 6.0, -2.0, 4.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(-4.0, -1.0, 7.0, 7.0, 0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(5.0, 0.0, 8.0, -9.0, 0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(-4.0, -3.0, -4.0, -7.0, 4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(9.0, -6.0, 6.0, 6.0, -2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(-4.0, -3.0, -8.0, 5.0, 8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(5.0, -1.0, 6.0, 0.0, -1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(0.0, -4.0, 0.0, 2.0, 5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(9.0, 2.0, 5.0, -7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(-9.0, -5.0, 3.0, -4.0, -6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(2.0, -9.0, 8.0, -3.0, -3.0, -1.0, -8.0, -7.0, -8.0, 4.0, 2.0, -4.0, -5.0, 1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(6.0, -2.0, -2.0, -9.0, 7.0, 8.0, -4.0, -9.0, -8.0, -4.0, 6.0, 7.0, -4.0, -5.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(3.0, 8.0, 3.0, 9.0, -8.0, 9.0, 4.0, -3.0, -1.0, -3.0, 5.0, -1.0, 3.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(-7.0, 9.0, -8.0, -7.0, -5.0, 5.0, 6.0, 9.0, -7.0, -2.0, 5.0, 7.0, -2.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(3.0, 7.0, 1.0, -2.0, 8.0, 6.0, 9.0, 5.0, 3.0, 4.0, -8.0, -4.0, -5.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(-3.0, 9.0, 7.0, -3.0, 8.0, -4.0, -7.0, 1.0, -3.0, 9.0, -9.0, -1.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(8.0, 1.0, -4.0, 3.0, 7.0, 9.0, 6.0, -6.0, 2.0, 8.0, 2.0, 3.0, -8.0, 7.0, 6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	block.var[1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	block.var[2] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
	block.var[3] = (mat4(-3.0, 1.0, -5.0, 0.0, -1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0));
	block.var[4] = (mat4(4.0, 7.0, 2.0, 2.0, 5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0));
	block.var[5] = (mat4(-6.0, 0.0, -6.0, 3.0, -1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0));
	block.var[6] = (mat4(7.0, 9.0, -3.0, -6.0, 3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0));
	block.var[7] = (mat4(3.0, -3.0, 1.0, 4.0, -1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0));
	block.var[8] = (mat4(-6.0, -5.0, 3.0, -8.0, -4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0));
	block.var[9] = (mat4(-5.0, 2.0, 1.0, 1.0, -7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0));
	block.var[10] = (mat4(-4.0, -3.0, 2.0, -2.0, 4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0));
	block.var[11] = (mat4(6.0, -9.0, 7.0, 7.0, -1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0));
	block.var[12] = (mat4(4.0, -5.0, 0.0, -7.0, 5.0, 6.0, -9.0, 8.0, -2.0, -3.0, -2.0, -2.0, -4.0, -1.0, -7.0, -8.0));
	block.var[13] = (mat4(6.0, 2.0, 6.0, -7.0, 2.0, 4.0, -8.0, -9.0, -9.0, -5.0, -7.0, 1.0, 9.0, 1.0, 5.0, -3.0));
	block.var[14] = (mat4(7.0, 8.0, 7.0, -3.0, 0.0, -2.0, -3.0, -6.0, -6.0, -6.0, 6.0, -6.0, -6.0, 9.0, 8.0, -5.0));
	block.var[15] = (mat4(4.0, -4.0, 4.0, 7.0, -4.0, 5.0, -8.0, 5.0, -8.0, 9.0, 3.0, 9.0, 3.0, -3.0, -8.0, -6.0));
	block.var[16] = (mat4(2.0, 4.0, -9.0, 6.0, 4.0, -1.0, 2.0, 1.0, 2.0, 6.0, -9.0, -1.0, -5.0, -1.0, -7.0, 9.0));
	block.var[17] = (mat4(6.0, -6.0, -2.0, -7.0, 6.0, 8.0, -3.0, -9.0, 7.0, 6.0, -5.0, 9.0, -5.0, 0.0, -9.0, 3.0));
	block.var[18] = (mat4(-6.0, -4.0, 9.0, 8.0, 6.0, 8.0, -4.0, 1.0, -6.0, 4.0, -2.0, 2.0, -3.0, -4.0, 3.0, -5.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(2.0, -7.0, 8.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(5.0, -2.0, 1.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(6.0, 7.0, 2.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(-5.0, 5.0, 9.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(9.0, 7.0, 9.0, 5.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(1.0, 4.0, -6.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(-9.0, 9.0, 8.0, -5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(9.0, -3.0, -8.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(-8.0, 9.0, 4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(-4.0, -8.0, 0.0, -2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(-3.0, 2.0, 2.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(-3.0, 9.0, -3.0, -8.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(7.0, -5.0, -4.0, 2.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(0.0, 2.0, 2.0, 4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(-7.0, -4.0, -2.0, -2.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(4.0, -2.0, -1.0, 3.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(6.0, -7.0, -9.0, -5.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(-1.0, 5.0, 6.0, -4.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(-7.0, -4.0, 0.0, -8.0, 6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	block.var[1] = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	block.var[2] = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
	block.var[3] = (mat2x3(-4.0, 3.0, 7.0, -5.0, -6.0, 7.0));
	block.var[4] = (mat2x3(3.0, 8.0, -7.0, -7.0, -6.0, 2.0));
	block.var[5] = (mat2x3(-8.0, 8.0, -7.0, -2.0, 5.0, 7.0));
	block.var[6] = (mat2x3(4.0, -7.0, -7.0, 6.0, -8.0, -8.0));
	block.var[7] = (mat2x3(7.0, -8.0, 4.0, 7.0, 0.0, 3.0));
	block.var[8] = (mat2x3(9.0, 4.0, 7.0, 4.0, -7.0, 6.0));
	block.var[9] = (mat2x3(1.0, 3.0, 2.0, -1.0, -8.0, -8.0));
	block.var[10] = (mat2x3(2.0, 9.0, -3.0, -1.0, -2.0, -1.0));
	block.var[11] = (mat2x3(-1.0, 8.0, 1.0, -6.0, -9.0, -3.0));
	block.var[12] = (mat2x3(-1.0, 0.0, -8.0, 1.0, -2.0, -5.0));
	block.var[13] = (mat2x3(6.0, 6.0, 2.0, 0.0, 4.0, -7.0));
	block.var[14] = (mat2x3(1.0, -6.0, 8.0, 1.0, -5.0, 1.0));
	block.var[15] = (mat2x3(-7.0, -4.0, -4.0, -5.0, 3.0, 3.0));
	block.var[16] = (mat2x3(1.0, 0.0, 9.0, 1.0, -8.0, -1.0));
	block.var[17] = (mat2x3(9.0, 5.0, -3.0, -9.0, -8.0, 3.0));
	block.var[18] = (mat2x3(-1.0, 6.0, -1.0, 2.0, -2.0, -5.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(-6.0, 3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(-9.0, -3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(-1.0, 1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(8.0, 8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(1.0, 4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(0.0, 7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(1.0, 5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(2.0, -4.0));
	block.var[0][1] = (vec2(-5.0, 3.0));
	block.var[0][2] = (vec2(7.0, 1.0));
	block.var[0][3] = (vec2(8.0, -5.0));
	block.var[1][0] = (vec2(7.0, -3.0));
	block.var[1][1] = (vec2(1.0, -6.0));
	block.var[1][2] = (vec2(9.0, -3.0));
	block.var[1][3] = (vec2(1.0, -5.0));
	block.var[2][0] = (vec2(-8.0, 4.0));
	block.var[2][1] = (vec2(5.0, -9.0));
	block.var[2][2] = (vec2(1.0, -5.0));
	block.var[2][3] = (vec2(-4.0, -2.0));
	block.var[3][0] = (vec2(6.0, -1.0));
	block.var[3][1] = (vec2(-7.0, -5.0));
	block.var[3][2] = (vec2(-2.0, -8.0));
	block.var[3][3] = (vec2(1.0, 3.0));
	block.var[4][0] = (vec2(4.0, 2.0));
	block.var[4][1] = (vec2(-9.0, 2.0));
	block.var[4][2] = (vec2(-3.0, 3.0));
	block.var[4][3] = (vec2(0.0, 1.0));
	block.var[5][0] = (vec2(-5.0, -9.0));
	block.var[5][1] = (vec2(2.0, -2.0));
	block.var[5][2] = (vec2(-3.0, 0.0));
	block.var[5][3] = (vec2(9.0, 6.0));
	block.var[6][0] = (vec2(3.0, -4.0));
	block.var[6][1] = (vec2(2.0, -3.0));
	block.var[6][2] = (vec2(6.0, 5.0));
	block.var[6][3] = (vec2(0.0, -2.0));
	block.var[7][0] = (vec2(-3.0, -2.0));
	block.var[7][1] = (vec2(-7.0, 3.0));
	block.var[7][2] = (vec2(-6.0, 2.0));
	block.var[7][3] = (vec2(9.0, 6.0));
	block.var[8][0] = (vec2(-4.0, 4.0));
	block.var[8][1] = (vec2(0.0, -3.0));
	block.var[8][2] = (vec2(-7.0, 0.0));
	block.var[8][3] = (vec2(-9.0, 1.0));
	block.var[9][0] = (vec2(7.0, 2.0));
	block.var[9][1] = (vec2(1.0, 9.0));
	block.var[9][2] = (vec2(-3.0, 3.0));
	block.var[9][3] = (vec2(-7.0, 9.0));
	block.var[10][0] = (vec2(-4.0, -1.0));
	block.var[10][1] = (vec2(3.0, 6.0));
	block.var[10][2] = (vec2(8.0, 3.0));
	block.var[10][3] = (vec2(1.0, 5.0));
	block.var[11][0] = (vec2(7.0, 0.0));
	block.var[11][1] = (vec2(0.0, -2.0));
	block.var[11][2] = (vec2(3.0, -7.0));
	block.var[11][3] = (vec2(-3.0, 1.0));
	block.var[12][0] = (vec2(4.0, 2.0));
	block.var[12][1] = (vec2(-4.0, 1.0));
	block.var[12][2] = (vec2(5.0, -7.0));
	block.var[12][3] = (vec2(5.0, 5.0));
	block.var[13][0] = (vec2(-5.0, 1.0));
	block.var[13][1] = (vec2(-7.0, -3.0));
	block.var[13][2] = (vec2(-1.0, 1.0));
	block.var[13][3] = (vec2(4.0, 7.0));
	block.var[14][0] = (vec2(-9.0, 1.0));
	block.var[14][1] = (vec2(-6.0, 7.0));
	block.var[14][2] = (vec2(8.0, -7.0));
	block.var[14][3] = (vec2(2.0, 1.0));
	block.var[15][0] = (vec2(-7.0, 4.0));
	block.var[15][1] = (vec2(-4.0, 4.0));
	block.var[15][2] = (vec2(0.0, 7.0));
	block.var[15][3] = (vec2(7.0, -1.0));
	block.var[16][0] = (vec2(0.0, -2.0));
	block.var[16][1] = (vec2(-8.0, 2.0));
	block.var[16][2] = (vec2(8.0, -1.0));
	block.var[16][3] = (vec2(5.0, 2.0));
	block.var[17][0] = (vec2(4.0, 1.0));
	block.var[17][1] = (vec2(-6.0, 7.0));
	block.var[17][2] = (vec2(-7.0, 1.0));
	block.var[17][3] = (vec2(2.0, -4.0));
	block.var[18][0] = (vec2(-8.0, -5.0));
	block.var[18][1] = (vec2(8.0, -8.0));
	block.var[18][2] = (vec2(7.0, -2.0));
	block.var[18][3] = (vec2(-7.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(6.0, 9.0));
	block.var[0][0][1] = (vec2(-4.0, -4.0));
	block.var[0][0][2] = (vec2(2.0, 0.0));
	block.var[0][0][3] = (vec2(-7.0, 3.0));
	block.var[0][1][0] = (vec2(9.0, -6.0));
	block.var[0][1][1] = (vec2(8.0, -9.0));
	block.var[0][1][2] = (vec2(-9.0, -6.0));
	block.var[0][1][3] = (vec2(-4.0, -6.0));
	block.var[0][2][0] = (vec2(-8.0, 5.0));
	block.var[0][2][1] = (vec2(6.0, -8.0));
	block.var[0][2][2] = (vec2(-8.0, 3.0));
	block.var[0][2][3] = (vec2(2.0, 8.0));
	block.var[1][0][0] = (vec2(-8.0, -1.0));
	block.var[1][0][1] = (vec2(-3.0, 0.0));
	block.var[1][0][2] = (vec2(7.0, 5.0));
	block.var[1][0][3] = (vec2(-8.0, 5.0));
	block.var[1][1][0] = (vec2(7.0, 8.0));
	block.var[1][1][1] = (vec2(4.0, -2.0));
	block.var[1][1][2] = (vec2(4.0, -2.0));
	block.var[1][1][3] = (vec2(-2.0, 9.0));
	block.var[1][2][0] = (vec2(4.0, -4.0));
	block.var[1][2][1] = (vec2(-5.0, -5.0));
	block.var[1][2][2] = (vec2(-6.0, 8.0));
	block.var[1][2][3] = (vec2(9.0, -5.0));
	block.var[2][0][0] = (vec2(-2.0, 1.0));
	block.var[2][0][1] = (vec2(6.0, -2.0));
	block.var[2][0][2] = (vec2(2.0, -5.0));
	block.var[2][0][3] = (vec2(3.0, -3.0));
	block.var[2][1][0] = (vec2(-6.0, -4.0));
	block.var[2][1][1] = (vec2(-6.0, -7.0));
	block.var[2][1][2] = (vec2(9.0, 1.0));
	block.var[2][1][3] = (vec2(-4.0, 3.0));
	block.var[2][2][0] = (vec2(7.0, -9.0));
	block.var[2][2][1] = (vec2(7.0, -4.0));
	block.var[2][2][2] = (vec2(8.0, -2.0));
	block.var[2][2][3] = (vec2(9.0, 0.0));
	block.var[3][0][0] = (vec2(-9.0, 7.0));
	block.var[3][0][1] = (vec2(1.0, 4.0));
	block.var[3][0][2] = (vec2(-7.0, 9.0));
	block.var[3][0][3] = (vec2(-5.0, 2.0));
	block.var[3][1][0] = (vec2(-9.0, -3.0));
	block.var[3][1][1] = (vec2(-8.0, 5.0));
	block.var[3][1][2] = (vec2(-2.0, -8.0));
	block.var[3][1][3] = (vec2(7.0, -6.0));
	block.var[3][2][0] = (vec2(-7.0, 1.0));
	block.var[3][2][1] = (vec2(-3.0, 7.0));
	block.var[3][2][2] = (vec2(6.0, -5.0));
	block.var[3][2][3] = (vec2(9.0, -2.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat4(block.var[0][0], mat4(-1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0, 9.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0, 2.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(-4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0, 5.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0, 1.0, -4.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(-6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0, -4.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0, 7.0, -4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(-5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0, -5.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(-5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0, 4.0, 5.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(-4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0, 0.0, -4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(-3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0, 5.0, -5.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(-6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0, 1.0, 2.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0, 8.0, 8.0, 7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0][0][0] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block.var[0][0][1] = (vec4(0.0, 4.0, -1.0, -5.0));
	block.var[0][0][2] = (vec4(4.0, 0.0, -6.0, -6.0));
	block.var[0][0][3] = (vec4(-7.0, -8.0, 3.0, -6.0));
	block.var[0][1][0] = (vec4(2.0, 5.0, 4.0, -7.0));
	block.var[0][1][1] = (vec4(1.0, -4.0, 3.0, 5.0));
	block.var[0][1][2] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block.var[0][1][3] = (vec4(3.0, 9.0, -6.0, 1.0));
	block.var[0][2][0] = (vec4(-9.0, 0.0, 8.0, 4.0));
	block.var[0][2][1] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[0][2][2] = (vec4(-5.0, 8.0, 8.0, -7.0));
	block.var[0][2][3] = (vec4(6.0, 0.0, 8.0, 4.0));
	block.var[1][0][0] = (vec4(4.0, -5.0, 4.0, -7.0));
	block.var[1][0][1] = (vec4(6.0, -1.0, 4.0, 5.0));
	block.var[1][0][2] = (vec4(-7.0, 7.0, 7.0, -6.0));
	block.var[1][0][3] = (vec4(-5.0, 7.0, 9.0, -8.0));
	block.var[1][1][0] = (vec4(5.0, -7.0, 8.0, -7.0));
	block.var[1][1][1] = (vec4(2.0, -8.0, 8.0, -7.0));
	block.var[1][1][2] = (vec4(6.0, -4.0, -6.0, -2.0));
	block.var[1][1][3] = (vec4(9.0, -5.0, 0.0, 7.0));
	block.var[1][2][0] = (vec4(7.0, -4.0, -9.0, 0.0));
	block.var[1][2][1] = (vec4(6.0, -3.0, 3.0, 6.0));
	block.var[1][2][2] = (vec4(3.0, -4.0, 8.0, -2.0));
	block.var[1][2][3] = (vec4(-2.0, -9.0, 2.0, -7.0));
	block.var[2][0][0] = (vec4(-6.0, -7.0, -3.0, -9.0));
	block.var[2][0][1] = (vec4(9.0, -1.0, -3.0, -5.0));
	block.var[2][0][2] = (vec4(8.0, 1.0, -1.0, -3.0));
	block.var[2][0][3] = (vec4(3.0, -4.0, -1.0, -4.0));
	block.var[2][1][0] = (vec4(-9.0, -3.0, 8.0, 4.0));
	block.var[2][1][1] = (vec4(2.0, 2.0, 2.0, -1.0));
	block.var[2][1][2] = (vec4(0.0, -1.0, -1.0, 4.0));
	block.var[2][1][3] = (vec4(-2.0, -3.0, 5.0, 1.0));
	block.var[2][2][0] = (vec4(5.0, -5.0, 9.0, 2.0));
	block.var[2][2][1] = (vec4(6.0, -2.0, 5.0, 3.0));
	block.var[2][2][2] = (vec4(-7.0, 0.0, 4.0, 3.0));
	block.var[2][2][3] = (vec4(1.0, 4.0, -2.0, 2.0));
	block.var[3][0][0] = (vec4(-5.0, 0.0, -9.0, -7.0));
	block.var[3][0][1] = (vec4(2.0, 7.0, -9.0, 7.0));
	block.var[3][0][2] = (vec4(-2.0, -5.0, 4.0, 3.0));
	block.var[3][0][3] = (vec4(-7.0, 5.0, 7.0, 6.0));
	block.var[3][1][0] = (vec4(8.0, -4.0, -4.0, 4.0));
	block.var[3][1][1] = (vec4(-9.0, -3.0, 0.0, -3.0));
	block.var[3][1][2] = (vec4(0.0, 8.0, -3.0, 6.0));
	block.var[3][1][3] = (vec4(3.0, 8.0, 9.0, -8.0));
	block.var[3][2][0] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[3][2][1] = (vec4(-1.0, 8.0, 9.0, 6.0));
	block.var[3][2][2] = (vec4(8.0, -7.0, 0.0, -8.0));
	block.var[3][2][3] = (vec4(-5.0, 6.0, -7.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat4x2(block.var[0][0], mat4x2(5.0, 7.0, 1.0, -5.0, 5.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(-7.0, -4.0, 7.0, 7.0, 5.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(-9.0, -7.0, -1.0, 8.0, 0.0, 4.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(-5.0, -3.0, 4.0, 7.0, -4.0, -5.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(9.0, 2.0, -1.0, -1.0, 7.0, 2.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(4.0, 4.0, 9.0, -9.0, -2.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(5.0, -8.0, 2.0, 3.0, 3.0, 2.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(-8.0, -3.0, -1.0, 4.0, -8.0, -4.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(-7.0, 1.0, 0.0, -9.0, -6.0, 6.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(-8.0, 5.0, -3.0, 8.0, 6.0, -4.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(5.0, -2.0, -8.0, -1.0, 4.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(1.0, 5.0, -3.0, -4.0, 7.0, -7.0, 5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0][0][0] = (vec2(-4.0, -4.0));
	block.var[0][0][1] = (vec2(2.0, 0.0));
	block.var[0][0][2] = (vec2(-7.0, 3.0));
	block.var[0][0][3] = (vec2(9.0, 9.0));
	block.var[0][1][0] = (vec2(8.0, -9.0));
	block.var[0][1][1] = (vec2(-9.0, -6.0));
	block.var[0][1][2] = (vec2(-4.0, -6.0));
	block.var[0][1][3] = (vec2(-6.0, -8.0));
	block.var[0][2][0] = (vec2(6.0, -8.0));
	block.var[0][2][1] = (vec2(-8.0, 3.0));
	block.var[0][2][2] = (vec2(2.0, 8.0));
	block.var[0][2][3] = (vec2(5.0, -8.0));
	block.var[1][0][0] = (vec2(-3.0, 0.0));
	block.var[1][0][1] = (vec2(7.0, 5.0));
	block.var[1][0][2] = (vec2(-8.0, 5.0));
	block.var[1][0][3] = (vec2(-1.0, 7.0));
	block.var[1][1][0] = (vec2(4.0, -2.0));
	block.var[1][1][1] = (vec2(4.0, -2.0));
	block.var[1][1][2] = (vec2(-2.0, 9.0));
	block.var[1][1][3] = (vec2(8.0, 4.0));
	block.var[1][2][0] = (vec2(-5.0, -5.0));
	block.var[1][2][1] = (vec2(-6.0, 8.0));
	block.var[1][2][2] = (vec2(9.0, -5.0));
	block.var[1][2][3] = (vec2(-4.0, -2.0));
	block.var[2][0][0] = (vec2(6.0, -2.0));
	block.var[2][0][1] = (vec2(2.0, -5.0));
	block.var[2][0][2] = (vec2(3.0, -3.0));
	block.var[2][0][3] = (vec2(1.0, -6.0));
	block.var[2][1][0] = (vec2(-6.0, -7.0));
	block.var[2][1][1] = (vec2(9.0, 1.0));
	block.var[2][1][2] = (vec2(-4.0, 3.0));
	block.var[2][1][3] = (vec2(-4.0, 7.0));
	block.var[2][2][0] = (vec2(7.0, -4.0));
	block.var[2][2][1] = (vec2(8.0, -2.0));
	block.var[2][2][2] = (vec2(9.0, 0.0));
	block.var[2][2][3] = (vec2(-9.0, -9.0));
	block.var[3][0][0] = (vec2(1.0, 4.0));
	block.var[3][0][1] = (vec2(-7.0, 9.0));
	block.var[3][0][2] = (vec2(-5.0, 2.0));
	block.var[3][0][3] = (vec2(7.0, -9.0));
	block.var[3][1][0] = (vec2(-8.0, 5.0));
	block.var[3][1][1] = (vec2(-2.0, -8.0));
	block.var[3][1][2] = (vec2(7.0, -6.0));
	block.var[3][1][3] = (vec2(-3.0, -7.0));
	block.var[3][2][0] = (vec2(-3.0, 7.0));
	block.var[3][2][1] = (vec2(6.0, -5.0));
	block.var[3][2][2] = (vec2(9.0, -2.0));
	block.var[3][2][3] = (vec2(1.0, -9.0));
}
#version 450
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
	f16vec2 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(block.var[0][0][0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][0][1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][0][2]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][1][0]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][1][1]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][1][2]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0][0]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0][1]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0][2]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1][0]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1][1]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1][2]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0][0]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0][1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0][2]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1][0]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1][1]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1][2]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][0][0]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][0][1]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][0][2]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][1][0]), vec2(-3.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][1][1]), vec2(0.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][1][2]), vec2(3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = f16vec2(vec2(-2.0, 4.0));
	block.var[0][0][1] = f16vec2(vec2(-2.0, 4.0));
	block.var[0][0][2] = f16vec2(vec2(-1.0, 1.0));
	block.var[0][1][0] = f16vec2(vec2(6.0, 0.0));
	block.var[0][1][1] = f16vec2(vec2(3.0, 5.0));
	block.var[0][1][2] = f16vec2(vec2(9.0, -9.0));
	block.var[1][0][0] = f16vec2(vec2(9.0, 4.0));
	block.var[1][0][1] = f16vec2(vec2(8.0, -8.0));
	block.var[1][0][2] = f16vec2(vec2(1.0, -3.0));
	block.var[1][1][0] = f16vec2(vec2(-6.0, 7.0));
	block.var[1][1][1] = f16vec2(vec2(3.0, -7.0));
	block.var[1][1][2] = f16vec2(vec2(4.0, -5.0));
	block.var[2][0][0] = f16vec2(vec2(2.0, 2.0));
	block.var[2][0][1] = f16vec2(vec2(-6.0, 5.0));
	block.var[2][0][2] = f16vec2(vec2(5.0, -7.0));
	block.var[2][1][0] = f16vec2(vec2(7.0, -6.0));
	block.var[2][1][1] = f16vec2(vec2(-2.0, -4.0));
	block.var[2][1][2] = f16vec2(vec2(5.0, -2.0));
	block.var[3][0][0] = f16vec2(vec2(3.0, 0.0));
	block.var[3][0][1] = f16vec2(vec2(-2.0, 3.0));
	block.var[3][0][2] = f16vec2(vec2(-6.0, 5.0));
	block.var[3][1][0] = f16vec2(vec2(5.0, 2.0));
	block.var[3][1][1] = f16vec2(vec2(8.0, -7.0));
	block.var[3][1][2] = f16vec2(vec2(3.0, -7.0));
}
#version 450
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
	f16vec3 var[4][2][3];
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
	allOk = compare_f16vec3(vec3(block.var[0][0][2]), vec3(4.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][1][0]), vec3(-1.0, -7.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][1][1]), vec3(2.0, 6.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][1][2]), vec3(-5.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][0][0]), vec3(4.0, 4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][0][1]), vec3(2.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][0][2]), vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][1][0]), vec3(5.0, 4.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][1][1]), vec3(6.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][1][2]), vec3(6.0, -8.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][0][0]), vec3(1.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][0][1]), vec3(-7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][0][2]), vec3(-8.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][1][0]), vec3(8.0, 2.0, 0.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][1][1]), vec3(-1.0, 2.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][1][2]), vec3(-4.0, -8.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][0][0]), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][0][1]), vec3(-4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][0][2]), vec3(-8.0, 6.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][1][0]), vec3(5.0, 7.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][1][1]), vec3(6.0, -9.0, -6.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][1][2]), vec3(0.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = f16vec3(vec3(3.0, 3.0, 7.0));
	block.var[0][0][1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	block.var[0][0][2] = f16vec3(vec3(-1.0, 0.0, 6.0));
	block.var[0][1][0] = f16vec3(vec3(6.0, 6.0, -6.0));
	block.var[0][1][1] = f16vec3(vec3(-3.0, 1.0, -5.0));
	block.var[0][1][2] = f16vec3(vec3(6.0, 9.0, 7.0));
	block.var[1][0][0] = f16vec3(vec3(5.0, -7.0, 2.0));
	block.var[1][0][1] = f16vec3(vec3(9.0, 1.0, -5.0));
	block.var[1][0][2] = f16vec3(vec3(-5.0, 5.0, 2.0));
	block.var[1][1][0] = f16vec3(vec3(2.0, 5.0, 3.0));
	block.var[1][1][1] = f16vec3(vec3(9.0, -8.0, 2.0));
	block.var[1][1][2] = f16vec3(vec3(-7.0, -8.0, -3.0));
	block.var[2][0][0] = f16vec3(vec3(-5.0, -4.0, 6.0));
	block.var[2][0][1] = f16vec3(vec3(-3.0, -7.0, -4.0));
	block.var[2][0][2] = f16vec3(vec3(-4.0, 5.0, 0.0));
	block.var[2][1][0] = f16vec3(vec3(2.0, -5.0, -9.0));
	block.var[2][1][1] = f16vec3(vec3(-8.0, 4.0, 1.0));
	block.var[2][1][2] = f16vec3(vec3(-9.0, -5.0, 5.0));
	block.var[3][0][0] = f16vec3(vec3(-6.0, 4.0, -1.0));
	block.var[3][0][1] = f16vec3(vec3(-2.0, 3.0, -8.0));
	block.var[3][0][2] = f16vec3(vec3(-4.0, -2.0, 4.0));
	block.var[3][1][0] = f16vec3(vec3(-3.0, -6.0, 0.0));
	block.var[3][1][1] = f16vec3(vec3(-3.0, 9.0, -1.0));
	block.var[3][1][2] = f16vec3(vec3(-9.0, 0.0, -5.0));
}
#version 450
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
	highp ivec4 var[4][2][3];
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
	allOk = compare_ivec4((block.var[0][0][2]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((block.var[0][1][0]), ivec4(-7, 2, 6, -5)) && allOk;
	allOk = compare_ivec4((block.var[0][1][1]), ivec4(1, 5, 7, 9)) && allOk;
	allOk = compare_ivec4((block.var[0][1][2]), ivec4(-6, 4, 0, 9)) && allOk;
	allOk = compare_ivec4((block.var[1][0][0]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((block.var[1][0][1]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((block.var[1][0][2]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((block.var[1][1][0]), ivec4(-3, 6, -6, -6)) && allOk;
	allOk = compare_ivec4((block.var[1][1][1]), ivec4(1, -6, -3, 5)) && allOk;
	allOk = compare_ivec4((block.var[1][1][2]), ivec4(9, -7, -1, -9)) && allOk;
	allOk = compare_ivec4((block.var[2][0][0]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((block.var[2][0][1]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((block.var[2][0][2]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((block.var[2][1][0]), ivec4(8, -5, 1, -2)) && allOk;
	allOk = compare_ivec4((block.var[2][1][1]), ivec4(2, 9, -9, -7)) && allOk;
	allOk = compare_ivec4((block.var[2][1][2]), ivec4(-5, -2, 6, 4)) && allOk;
	allOk = compare_ivec4((block.var[3][0][0]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((block.var[3][0][1]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((block.var[3][0][2]), ivec4(-3, 1, 3, 1)) && allOk;
	allOk = compare_ivec4((block.var[3][1][0]), ivec4(-1, 1, 1, 5)) && allOk;
	allOk = compare_ivec4((block.var[3][1][1]), ivec4(1, -9, 2, -2)) && allOk;
	allOk = compare_ivec4((block.var[3][1][2]), ivec4(-5, -8, 8, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (ivec4(5, -9, 5, -6));
	block.var[0][0][1] = (ivec4(-2, -4, 1, -9));
	block.var[0][0][2] = (ivec4(7, 3, 6, 8));
	block.var[0][1][0] = (ivec4(7, 1, -4, 4));
	block.var[0][1][1] = (ivec4(-2, 5, -8, 0));
	block.var[0][1][2] = (ivec4(8, -9, -8, -3));
	block.var[1][0][0] = (ivec4(6, -4, 6, -7));
	block.var[1][0][1] = (ivec4(9, -8, -9, 0));
	block.var[1][0][2] = (ivec4(5, -7, 2, 9));
	block.var[1][1][0] = (ivec4(3, -9, -5, -4));
	block.var[1][1][1] = (ivec4(-8, 8, -3, 2));
	block.var[1][1][2] = (ivec4(-2, -6, 4, -5));
	block.var[2][0][0] = (ivec4(6, 5, 4, 0));
	block.var[2][0][1] = (ivec4(5, 9, 0, 0));
	block.var[2][0][2] = (ivec4(-6, 4, 4, 2));
	block.var[2][1][0] = (ivec4(6, 8, -7, -2));
	block.var[2][1][1] = (ivec4(9, -9, -5, -6));
	block.var[2][1][2] = (ivec4(-5, -7, -9, -3));
	block.var[3][0][0] = (ivec4(9, 7, 5, 5));
	block.var[3][0][1] = (ivec4(3, -3, -9, -8));
	block.var[3][0][2] = (ivec4(-6, 3, 2, 0));
	block.var[3][1][0] = (ivec4(-2, -1, -9, 9));
	block.var[3][1][1] = (ivec4(-5, 1, 9, -8));
	block.var[3][1][2] = (ivec4(0, 5, -8, -8));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(6.0, -1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-5.0, -9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(2.0, -1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(7.0, 1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(2.0, 9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(9.0, 6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(6.0, -3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(7.0, 8.0, 7.0, 3.0, 8.0, -3.0, -9.0, -6.0, 2.0, 0.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(4.0, -8.0, 4.0, 1.0, 8.0, -2.0, 5.0, -4.0, -7.0, -4.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(-9.0, 7.0, -5.0, 5.0, -6.0, -9.0, -8.0, 4.0, 1.0, 0.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(-5.0, 3.0, -9.0, 7.0, -8.0, -8.0, 4.0, -3.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(2.0, -3.0, 2.0, -8.0, 3.0, -8.0, 3.0, 0.0, -9.0, 0.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	block.var[0][0][1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	block.var[0][0][2] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	block.var[0][1][0] = (mat4x3(-2.0, 7.0, -6.0, -4.0, -2.0, 0.0, 4.0, -2.0, 6.0, -6.0, -5.0, -8.0));
	block.var[0][1][1] = (mat4x3(-1.0, 2.0, 4.0, 2.0, -2.0, 9.0, 0.0, -4.0, 6.0, -7.0, -4.0, 2.0));
	block.var[0][1][2] = (mat4x3(1.0, 2.0, -9.0, -3.0, 6.0, -9.0, 8.0, 2.0, 1.0, -8.0, 3.0, 2.0));
	block.var[1][0][0] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	block.var[1][0][1] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	block.var[1][0][2] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	block.var[1][1][0] = (mat4x3(1.0, 4.0, 9.0, -7.0, -5.0, 2.0, -8.0, 0.0, 0.0, -4.0, 9.0, 5.0));
	block.var[1][1][1] = (mat4x3(-2.0, -9.0, 6.0, -9.0, -4.0, -7.0, 9.0, -5.0, 3.0, 5.0, -1.0, -4.0));
	block.var[1][1][2] = (mat4x3(1.0, -1.0, -8.0, 4.0, 4.0, 4.0, -3.0, 4.0, 0.0, 0.0, -7.0, -1.0));
	block.var[2][0][0] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	block.var[2][0][1] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	block.var[2][0][2] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	block.var[2][1][0] = (mat4x3(2.0, 6.0, 9.0, -5.0, -9.0, -9.0, 5.0, 6.0, 4.0, 6.0, -3.0, 1.0));
	block.var[2][1][1] = (mat4x3(3.0, -1.0, 9.0, -2.0, 9.0, 6.0, -9.0, 4.0, 3.0, -7.0, -3.0, 3.0));
	block.var[2][1][2] = (mat4x3(-7.0, 9.0, 6.0, -6.0, 1.0, 1.0, -3.0, -1.0, 8.0, -2.0, 3.0, -3.0));
	block.var[3][0][0] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	block.var[3][0][1] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	block.var[3][0][2] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
	block.var[3][1][0] = (mat4x3(-5.0, 4.0, 0.0, -9.0, 9.0, -1.0, 0.0, -9.0, -3.0, 6.0, -2.0, 0.0));
	block.var[3][1][1] = (mat4x3(-5.0, -9.0, 2.0, -1.0, 4.0, 0.0, -4.0, 1.0, 3.0, -9.0, -5.0, -6.0));
	block.var[3][1][2] = (mat4x3(7.0, -4.0, 3.0, 0.0, -2.0, -5.0, -8.0, 3.0, 5.0, -1.0, 3.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(6.0, 3.0, 9.0, -3.0, 9.0, 3.0, -5.0, -1.0, 6.0, -8.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(6.0, 5.0, -7.0, -2.0, -4.0, 0.0, -8.0, 8.0, 9.0, 9.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(4.0, -6.0, -2.0, 7.0, 1.0, -3.0, -2.0, -6.0, -2.0, 8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-4.0, 8.0, -5.0, -5.0, 7.0, 3.0, -1.0, 7.0, -4.0, -4.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-1.0, 4.0, -5.0, -8.0, -7.0, 7.0, -6.0, -4.0, 6.0, 6.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(3.0, 9.0, 0.0, 1.0, 3.0, -8.0, -9.0, 5.0, 8.0, 0.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(-8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(9.0, -5.0, -3.0, 3.0, 5.0, 4.0, -7.0, -1.0, 4.0, -9.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(1.0, 5.0, -9.0, 3.0, 5.0, 3.0, 8.0, -8.0, -5.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(-3.0, -8.0, -8.0, 8.0, 8.0, 3.0, -6.0, -7.0, 4.0, -2.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(-4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(-3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(-8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(0.0, 9.0, -1.0, 2.0, 9.0, -3.0, 7.0, 4.0, -2.0, -7.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(-4.0, -1.0, -8.0, 9.0, -4.0, -1.0, -5.0, -8.0, -3.0, 6.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(-1.0, -3.0, -4.0, -4.0, -3.0, 3.0, -7.0, -5.0, 8.0, 1.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0][0][0] = (mat3x4(-9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0, -5.0));
	block.var[0][0][1] = (mat3x4(-1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0, -3.0));
	block.var[0][0][2] = (mat3x4(-3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0, -5.0));
	block.var[0][1][0] = (mat3x4(0.0, 1.0, -2.0, 1.0, -4.0, -2.0, -6.0, -7.0, -8.0, 0.0, -8.0, 0.0));
	block.var[0][1][1] = (mat3x4(2.0, 9.0, -5.0, 9.0, -5.0, -4.0, 0.0, 4.0, 1.0, 0.0, -9.0, 1.0));
	block.var[0][1][2] = (mat3x4(-1.0, -4.0, 9.0, 7.0, 3.0, 5.0, 1.0, 6.0, 6.0, 2.0, 2.0, 8.0));
	block.var[1][0][0] = (mat3x4(-5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0, -5.0));
	block.var[1][0][1] = (mat3x4(5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0, -9.0));
	block.var[1][0][2] = (mat3x4(-1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0, -4.0));
	block.var[1][1][0] = (mat3x4(-5.0, -9.0, 8.0, -3.0, -3.0, 9.0, -9.0, 6.0, -4.0, 9.0, 4.0, -8.0));
	block.var[1][1][1] = (mat3x4(4.0, 7.0, 3.0, -1.0, -1.0, 9.0, -9.0, 8.0, -3.0, 9.0, -6.0, -4.0));
	block.var[1][1][2] = (mat3x4(6.0, 2.0, 5.0, 3.0, 7.0, 3.0, 4.0, -4.0, 2.0, 0.0, 8.0, -8.0));
	block.var[2][0][0] = (mat3x4(2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0, 9.0));
	block.var[2][0][1] = (mat3x4(-2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0, -6.0));
	block.var[2][0][2] = (mat3x4(5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0, 9.0));
	block.var[2][1][0] = (mat3x4(0.0, 8.0, -6.0, -2.0, -3.0, 6.0, 4.0, 9.0, -2.0, 4.0, 1.0, -9.0));
	block.var[2][1][1] = (mat3x4(-5.0, -8.0, 5.0, 4.0, 2.0, 7.0, 1.0, -6.0, 2.0, -6.0, -4.0, -3.0));
	block.var[2][1][2] = (mat3x4(1.0, -5.0, -9.0, -2.0, 3.0, 0.0, -4.0, 8.0, -3.0, 4.0, 9.0, -6.0));
	block.var[3][0][0] = (mat3x4(2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0, -1.0));
	block.var[3][0][1] = (mat3x4(4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0, -9.0));
	block.var[3][0][2] = (mat3x4(1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0, -6.0));
	block.var[3][1][0] = (mat3x4(-1.0, 3.0, -9.0, -6.0, -6.0, -3.0, 5.0, 0.0, -9.0, -4.0, 9.0, -8.0));
	block.var[3][1][1] = (mat3x4(6.0, -4.0, -3.0, -4.0, 3.0, 3.0, 4.0, 4.0, 4.0, 3.0, 8.0, -3.0));
	block.var[3][1][2] = (mat3x4(-6.0, -3.0, 6.0, -9.0, -3.0, -6.0, 9.0, 3.0, -1.0, 6.0, 3.0, 0.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
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

struct S
{
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c;
};
layout(std140, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block[0].s.a), ivec3(4, -5, -6)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(8.0, -8.0, 8.0, 0.0, 4.0, 5.0, 3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(2.0, -8.0, 0.0, 6.0, 0.0, 9.0, 1.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(2.0, -8.0, 4.0, 8.0, 5.0, 8.0, 7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(1.0, -3.0, -2.0, 0.0, 6.0, -9.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(4.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(4, -4, 7)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-4.0, 7.0, 6.0, -2.0, -3.0, 6.0, -6.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-3.0, -1.0, 4.0, -2.0, 1.0, -5.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(3.0, 0.0, 8.0, -3.0, -5.0, -3.0, -5.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-9.0, -2.0, -4.0, -2.0, -9.0, -5.0, -6.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(7.0, 4.0, 6.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-7, -1, 8)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(5.0, 5.0, -4.0, 8.0, 0.0, 8.0, -6.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-3.0, 5.0, 9.0, 4.0, 1.0, 3.0, 4.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(1.0, -2.0, -6.0, -3.0, -2.0, -2.0, -1.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-7.0, 6.0, -9.0, 0.0, 9.0, 3.0, 7.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(5.0, 5.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(5, -9, -8));
	block[0].s.b[0][0] = (vec3(1.0, 8.0, -1.0));
	block[0].s.b[0][1] = (vec3(4.0, -7.0, 5.0));
	block[0].s.b[0][2] = (vec3(5.0, 1.0, -2.0));
	block[0].s.b[1][0] = (vec3(7.0, 4.0, 3.0));
	block[0].s.b[1][1] = (vec3(-4.0, 2.0, 4.0));
	block[0].s.b[1][2] = (vec3(9.0, 2.0, -3.0));
	block[0].s.b[2][0] = (vec3(1.0, 9.0, 4.0));
	block[0].s.b[2][1] = (vec3(9.0, 2.0, -4.0));
	block[0].s.b[2][2] = (vec3(4.0, 3.0, -1.0));
	block[0].s.b[3][0] = (vec3(4.0, -3.0, 1.0));
	block[0].s.b[3][1] = (vec3(2.0, 2.0, -9.0));
	block[0].s.b[3][2] = (vec3(-2.0, -8.0, -7.0));
	block[0].s.c = (vec4(6.0, 8.0, -1.0, 8.0));
	block[1].s.a = (ivec3(-2, -4, 0));
	block[1].s.b[0][0] = (vec3(7.0, -3.0, -1.0));
	block[1].s.b[0][1] = (vec3(-7.0, -2.0, 5.0));
	block[1].s.b[0][2] = (vec3(-1.0, 8.0, 0.0));
	block[1].s.b[1][0] = (vec3(1.0, 9.0, -4.0));
	block[1].s.b[1][1] = (vec3(3.0, -2.0, -5.0));
	block[1].s.b[1][2] = (vec3(6.0, -9.0, -8.0));
	block[1].s.b[2][0] = (vec3(4.0, -6.0, -8.0));
	block[1].s.b[2][1] = (vec3(-5.0, -2.0, 8.0));
	block[1].s.b[2][2] = (vec3(8.0, -2.0, 4.0));
	block[1].s.b[3][0] = (vec3(7.0, 2.0, -8.0));
	block[1].s.b[3][1] = (vec3(-6.0, -4.0, 0.0));
	block[1].s.b[3][2] = (vec3(2.0, 9.0, -8.0));
	block[1].s.c = (vec4(2.0, 2.0, 1.0, -4.0));
	block[2].s.a = (ivec3(-7, -3, 1));
	block[2].s.b[0][0] = (vec3(2.0, 9.0, 1.0));
	block[2].s.b[0][1] = (vec3(5.0, 1.0, -5.0));
	block[2].s.b[0][2] = (vec3(8.0, -2.0, -7.0));
	block[2].s.b[1][0] = (vec3(6.0, 2.0, -8.0));
	block[2].s.b[1][1] = (vec3(-1.0, -9.0, -8.0));
	block[2].s.b[1][2] = (vec3(-2.0, 5.0, 7.0));
	block[2].s.b[2][0] = (vec3(3.0, 2.0, -9.0));
	block[2].s.b[2][1] = (vec3(-2.0, 0.0, 6.0));
	block[2].s.b[2][2] = (vec3(4.0, -3.0, 3.0));
	block[2].s.b[3][0] = (vec3(-7.0, 0.0, 2.0));
	block[2].s.b[3][1] = (vec3(2.0, 2.0, 4.0));
	block[2].s.b[3][2] = (vec3(2.0, -3.0, -8.0));
	block[2].s.c = (vec4(-4.0, 4.0, -2.0, -3.0));
}
#version 450
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
	allOk = compare_ivec3((block.s[0].a), ivec3(-5, 3, -2)) && allOk;
	allOk = compare_mat3(block.s[0].b[0], mat3(9.0, 8.0, 2.0, -7.0, -2.0, -2.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[1], mat3(7.0, 5.0, -8.0, -8.0, -3.0, 0.0, -4.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[2], mat3(-6.0, 4.0, -9.0, 3.0, -7.0, -4.0, -4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[3], mat3(-1.0, -3.0, -4.0, -8.0, -7.0, -8.0, -6.0, 3.0, -4.0)) && allOk;
	allOk = compare_vec4((block.s[0].c), vec4(-4.0, -3.0, -8.0, 5.0)) && allOk;
	allOk = compare_ivec3((block.s[1].a), ivec3(-7, 6, -3)) && allOk;
	allOk = compare_mat3(block.s[1].b[0], mat3(1.0, 1.0, -7.0, 9.0, -9.0, 5.0, 5.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[1], mat3(-1.0, -5.0, -6.0, 0.0, -7.0, 8.0, -3.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[2], mat3(8.0, 7.0, 1.0, -6.0, 3.0, 0.0, -6.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[3], mat3(-8.0, 1.0, -6.0, -6.0, -4.0, 9.0, 2.0, -1.0, 8.0)) && allOk;
	allOk = compare_vec4((block.s[1].c), vec4(3.0, 6.0, -9.0, 9.0)) && allOk;
	allOk = compare_ivec3((block.s[2].a), ivec3(7, 5, -8)) && allOk;
	allOk = compare_mat3(block.s[2].b[0], mat3(1.0, 7.0, -5.0, -5.0, -6.0, 2.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[1], mat3(-5.0, 7.0, -1.0, 6.0, 7.0, 5.0, 6.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[2], mat3(4.0, 1.0, -6.0, 4.0, -1.0, -9.0, -3.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[3], mat3(-6.0, -9.0, -1.0, 1.0, -8.0, -1.0, -6.0, -3.0, -6.0)) && allOk;
	allOk = compare_vec4((block.s[2].c), vec4(7.0, -1.0, 6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s[0].a = (ivec3(-9, 6, -6));
	block.s[0].b[0][0] = (vec3(2.0, 2.0, -5.0));
	block.s[0].b[0][1] = (vec3(0.0, -7.0, 9.0));
	block.s[0].b[0][2] = (vec3(9.0, -1.0, -4.0));
	block.s[0].b[1][0] = (vec3(4.0, -4.0, 9.0));
	block.s[0].b[1][1] = (vec3(8.0, 0.0, -8.0));
	block.s[0].b[1][2] = (vec3(-7.0, -1.0, -1.0));
	block.s[0].b[2][0] = (vec3(-7.0, -3.0, 6.0));
	block.s[0].b[2][1] = (vec3(-5.0, 4.0, -9.0));
	block.s[0].b[2][2] = (vec3(3.0, -6.0, 1.0));
	block.s[0].b[3][0] = (vec3(-5.0, 9.0, 1.0));
	block.s[0].b[3][1] = (vec3(4.0, -5.0, -1.0));
	block.s[0].b[3][2] = (vec3(8.0, -9.0, 7.0));
	block.s[0].c = (vec4(-2.0, 6.0, 4.0, -2.0));
	block.s[1].a = (ivec3(-2, 4, -5));
	block.s[1].b[0][0] = (vec3(-4.0, 3.0, 9.0));
	block.s[1].b[0][1] = (vec3(8.0, 5.0, -9.0));
	block.s[1].b[0][2] = (vec3(2.0, -5.0, 0.0));
	block.s[1].b[1][0] = (vec3(2.0, -3.0, -6.0));
	block.s[1].b[1][1] = (vec3(-9.0, -6.0, 6.0));
	block.s[1].b[1][2] = (vec3(-3.0, -5.0, 5.0));
	block.s[1].b[2][0] = (vec3(-2.0, -5.0, 7.0));
	block.s[1].b[2][1] = (vec3(-7.0, 5.0, -1.0));
	block.s[1].b[2][2] = (vec3(3.0, -5.0, 1.0));
	block.s[1].b[3][0] = (vec3(-5.0, -7.0, -4.0));
	block.s[1].b[3][1] = (vec3(-7.0, -4.0, -3.0));
	block.s[1].b[3][2] = (vec3(-4.0, 7.0, 2.0));
	block.s[1].c = (vec4(-6.0, 7.0, -1.0, 7.0));
	block.s[2].a = (ivec3(-9, -7, -1));
	block.s[2].b[0][0] = (vec3(-3.0, 2.0, 2.0));
	block.s[2].b[0][1] = (vec3(1.0, 2.0, -7.0));
	block.s[2].b[0][2] = (vec3(-6.0, -8.0, 6.0));
	block.s[2].b[1][0] = (vec3(3.0, 0.0, 5.0));
	block.s[2].b[1][1] = (vec3(-9.0, 2.0, -3.0));
	block.s[2].b[1][2] = (vec3(-7.0, -2.0, 8.0));
	block.s[2].b[2][0] = (vec3(6.0, -2.0, -3.0));
	block.s[2].b[2][1] = (vec3(2.0, 4.0, -7.0));
	block.s[2].b[2][2] = (vec3(7.0, -7.0, -7.0));
	block.s[2].b[3][0] = (vec3(-8.0, 5.0, 5.0));
	block.s[2].b[3][1] = (vec3(-1.0, -2.0, -1.0));
	block.s[2].b[3][2] = (vec3(-8.0, -9.0, 2.0));
	block.s[2].c = (vec4(0.0, -6.0, -8.0, 8.0));
	block.v = (vec4(9.0, -6.0, -9.0, -9.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-5, 6, -9)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(7.0, 0.0, -9.0, 5.0, 4.0, -3.0, -2.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(0.0, -9.0, -6.0, -1.0, 8.0, -2.0, -1.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(4.0, 2.0, -4.0, 4.0, 7.0, -6.0, -1.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(2.0, 8.0, 8.0, -9.0, 0.0, 7.0, 3.0, 5.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(1.0, -9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(-1.0, -7.0, -7.0, 5.0, -5.0, -2.0, -2.0, -3.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(8, -1, -7)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(9.0, -2.0, -1.0, -1.0, 7.0, 3.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(3.0, 0.0, 3.0, -1.0, 1.0, 6.0, -9.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(-4.0, -6.0, 6.0, -6.0, -1.0, 3.0, -7.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(-3.0, 6.0, -6.0, -7.0, -5.0, -8.0, 6.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(-7.0, 0.0, 6.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(0, -8, -1)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-5.0, 0.0, 8.0, -2.0, -4.0, 5.0, -2.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(1.0, 5.0, -1.0, 9.0, -3.0, 2.0, -9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(6.0, 7.0, -9.0, -1.0, 3.0, -3.0, -9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-7.0, 4.0, 0.0, 1.0, 7.0, -3.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(9.0, 4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(-3.0, 4.0, 7.0, 1.0, -9.0, -1.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(8, 9, -2)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(6.0, 4.0, 9.0, -4.0, 8.0, -2.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(8.0, -5.0, 1.0, 0.0, -4.0, 5.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(6.0, -7.0, 2.0, 2.0, 1.0, -5.0, -9.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(-7.0, -8.0, 1.0, -6.0, 6.0, 2.0, -6.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(-5.0, 4.0, 7.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-9, 9, 8)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-2.0, 0.0, -7.0, -2.0, 5.0, -4.0, -1.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-2.0, -4.0, -5.0, -8.0, 6.0, 3.0, -8.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-5.0, 5.0, 4.0, 3.0, 1.0, -2.0, 7.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(0.0, -1.0, 6.0, -6.0, -8.0, 0.0, -7.0, 1.0, -8.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-9.0, -9.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(-2.0, 1.0, 4.0, 8.0, 6.0, -1.0, -7.0, -4.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(4, -3, 5)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(2.0, -2.0, -5.0, 9.0, -3.0, -8.0, 7.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(7.0, 9.0, -1.0, -3.0, 5.0, -4.0, -6.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(-3.0, -4.0, -8.0, 8.0, -9.0, -3.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(-2.0, 5.0, 0.0, -2.0, 5.0, -6.0, -4.0, 4.0, 5.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(2.0, 6.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a[0] = (vec3(3.0, 8.0, 1.0));
	block[0].t.a[1] = (vec3(8.0, -1.0, -6.0));
	block[0].t.a[2] = (vec3(-7.0, 7.0, 5.0));
	block[0].t.b.a = (ivec3(-6, 7, -3));
	block[0].t.b.b[0][0] = (vec3(6.0, 0.0, -6.0));
	block[0].t.b.b[0][1] = (vec3(-3.0, -3.0, 7.0));
	block[0].t.b.b[0][2] = (vec3(-4.0, 5.0, -2.0));
	block[0].t.b.b[1][0] = (vec3(3.0, -3.0, 7.0));
	block[0].t.b.b[1][1] = (vec3(2.0, -4.0, 4.0));
	block[0].t.b.b[1][2] = (vec3(4.0, -4.0, 2.0));
	block[0].t.b.b[2][0] = (vec3(-4.0, 9.0, 0.0));
	block[0].t.b.b[2][1] = (vec3(-7.0, -5.0, 0.0));
	block[0].t.b.b[2][2] = (vec3(7.0, -6.0, 5.0));
	block[0].t.b.b[3][0] = (vec3(-5.0, 4.0, -5.0));
	block[0].t.b.b[3][1] = (vec3(-5.0, 7.0, 5.0));
	block[0].t.b.b[3][2] = (vec3(-1.0, 3.0, -9.0));
	block[0].t.b.c = (vec4(0.0, 7.0, -3.0, 8.0));
	block[0].u = (7u);
	block[1].t.a[0] = (vec3(5.0, 5.0, -2.0));
	block[1].t.a[1] = (vec3(8.0, -1.0, -5.0));
	block[1].t.a[2] = (vec3(8.0, -7.0, 7.0));
	block[1].t.b.a = (ivec3(-6, -9, -1));
	block[1].t.b.b[0][0] = (vec3(2.0, 2.0, 4.0));
	block[1].t.b.b[0][1] = (vec3(9.0, -9.0, 1.0));
	block[1].t.b.b[0][2] = (vec3(1.0, 7.0, 5.0));
	block[1].t.b.b[1][0] = (vec3(-8.0, -7.0, -8.0));
	block[1].t.b.b[1][1] = (vec3(6.0, 6.0, 5.0));
	block[1].t.b.b[1][2] = (vec3(7.0, 5.0, 5.0));
	block[1].t.b.b[2][0] = (vec3(3.0, 3.0, 3.0));
	block[1].t.b.b[2][1] = (vec3(8.0, 4.0, -6.0));
	block[1].t.b.b[2][2] = (vec3(-3.0, -9.0, -2.0));
	block[1].t.b.b[3][0] = (vec3(8.0, -7.0, -8.0));
	block[1].t.b.b[3][1] = (vec3(3.0, -9.0, 7.0));
	block[1].t.b.b[3][2] = (vec3(3.0, -3.0, -6.0));
	block[1].t.b.c = (vec4(2.0, 4.0, -4.0, -5.0));
	block[1].u = (4u);
	block[2].t.a[0] = (vec3(0.0, -4.0, -4.0));
	block[2].t.a[1] = (vec3(-6.0, -4.0, -1.0));
	block[2].t.a[2] = (vec3(2.0, -3.0, 6.0));
	block[2].t.b.a = (ivec3(8, -1, 3));
	block[2].t.b.b[0][0] = (vec3(-6.0, 6.0, -2.0));
	block[2].t.b.b[0][1] = (vec3(-3.0, -9.0, -8.0));
	block[2].t.b.b[0][2] = (vec3(-2.0, 5.0, 6.0));
	block[2].t.b.b[1][0] = (vec3(9.0, 0.0, 3.0));
	block[2].t.b.b[1][1] = (vec3(0.0, 0.0, 4.0));
	block[2].t.b.b[1][2] = (vec3(-3.0, 6.0, 1.0));
	block[2].t.b.b[2][0] = (vec3(3.0, -3.0, -4.0));
	block[2].t.b.b[2][1] = (vec3(5.0, 1.0, 0.0));
	block[2].t.b.b[2][2] = (vec3(-4.0, -1.0, -4.0));
	block[2].t.b.b[3][0] = (vec3(6.0, -1.0, 4.0));
	block[2].t.b.b[3][1] = (vec3(6.0, 5.0, -4.0));
	block[2].t.b.b[3][2] = (vec3(-9.0, 1.0, 5.0));
	block[2].t.b.c = (vec4(9.0, -2.0, -2.0, -1.0));
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
	allOk = compare_uvec2((block.s[0].a), uvec2(8u, 5u)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[0], mat2x4(-2.0, 2.0, 7.0, 3.0, -7.0, -2.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[1], mat2x4(6.0, 0.0, 9.0, 6.0, 1.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[2], mat2x4(-9.0, -1.0, 5.0, 6.0, 6.0, 0.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[3], mat2x4(-5.0, -9.0, -5.0, -2.0, 8.0, -4.0, 0.0, -9.0)) && allOk;
	allOk = compare_vec3((block.s[0].c), vec3(-8.0, -2.0, -4.0)) && allOk;
	allOk = compare_uvec2((block.s[1].a), uvec2(1u, 1u)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[0], mat2x4(-5.0, 9.0, 3.0, 7.0, 8.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[1], mat2x4(1.0, 1.0, 8.0, -9.0, -2.0, 8.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[2], mat2x4(4.0, 0.0, -9.0, 5.0, 8.0, 6.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[3], mat2x4(-9.0, -4.0, 0.0, -4.0, -6.0, 1.0, 1.0, 2.0)) && allOk;
	allOk = compare_vec3((block.s[1].c), vec3(-6.0, -8.0, 7.0)) && allOk;
	allOk = compare_uvec2((block.s[2].a), uvec2(0u, 5u)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[0], mat2x4(5.0, -8.0, -4.0, 4.0, -3.0, -2.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[1], mat2x4(-7.0, 0.0, 1.0, 9.0, -3.0, -2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[2], mat2x4(-3.0, 4.0, -1.0, 5.0, -6.0, -3.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[3], mat2x4(-1.0, 4.0, -6.0, -2.0, 8.0, 0.0, 1.0, -2.0)) && allOk;
	allOk = compare_vec3((block.s[2].c), vec3(-8.0, 6.0, -5.0)) && allOk;
	allOk = compare_uvec2((block.s[3].a), uvec2(5u, 4u)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[0], mat2x4(8.0, -1.0, 7.0, 1.0, -8.0, 0.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[1], mat2x4(-1.0, -7.0, -6.0, -2.0, 1.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[2], mat2x4(-9.0, -8.0, -1.0, 5.0, -3.0, -5.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[3], mat2x4(4.0, 6.0, 4.0, 6.0, -6.0, -9.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec3((block.s[3].c), vec3(7.0, 3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (3u);
	block.s[0].a = (uvec2(2u, 6u));
	block.s[0].b[0] = (mat2x4(-6.0, 7.0, 1.0, 8.0, 8.0, 9.0, -7.0, -4.0));
	block.s[0].b[1] = (mat2x4(0.0, -9.0, -2.0, 7.0, 2.0, 3.0, -7.0, -4.0));
	block.s[0].b[2] = (mat2x4(2.0, -2.0, -7.0, 3.0, 5.0, 3.0, 1.0, -6.0));
	block.s[0].b[3] = (mat2x4(-6.0, -6.0, 0.0, -7.0, 4.0, 5.0, -6.0, -8.0));
	block.s[0].c = (vec3(-5.0, 9.0, 9.0));
	block.s[1].a = (uvec2(6u, 0u));
	block.s[1].b[0] = (mat2x4(4.0, -7.0, 5.0, -9.0, 7.0, 8.0, -1.0, -4.0));
	block.s[1].b[1] = (mat2x4(-3.0, -9.0, -1.0, 4.0, 9.0, 3.0, -6.0, -7.0));
	block.s[1].b[2] = (mat2x4(-3.0, 5.0, 5.0, 3.0, -1.0, 6.0, -8.0, -1.0));
	block.s[1].b[3] = (mat2x4(2.0, -5.0, 7.0, 7.0, 7.0, -2.0, -7.0, -3.0));
	block.s[1].c = (vec3(8.0, 4.0, 4.0));
	block.s[2].a = (uvec2(6u, 0u));
	block.s[2].b[0] = (mat2x4(-2.0, 6.0, 4.0, 3.0, -2.0, -9.0, -2.0, -3.0));
	block.s[2].b[1] = (mat2x4(-4.0, 6.0, -2.0, 9.0, 3.0, -4.0, 4.0, 4.0));
	block.s[2].b[2] = (mat2x4(8.0, 5.0, 6.0, -7.0, -7.0, 3.0, -6.0, -8.0));
	block.s[2].b[3] = (mat2x4(5.0, 4.0, -6.0, 8.0, 7.0, -6.0, 9.0, 3.0));
	block.s[2].c = (vec3(-6.0, -3.0, -4.0));
	block.s[3].a = (uvec2(2u, 6u));
	block.s[3].b[0] = (mat2x4(-6.0, 4.0, 2.0, -6.0, -2.0, 9.0, -6.0, -4.0));
	block.s[3].b[1] = (mat2x4(0.0, 7.0, 9.0, -6.0, 9.0, 0.0, -6.0, -2.0));
	block.s[3].b[2] = (mat2x4(-7.0, 1.0, 3.0, -6.0, 2.0, -6.0, 4.0, 1.0));
	block.s[3].b[3] = (mat2x4(-5.0, 8.0, -2.0, 0.0, -6.0, -7.0, -2.0, 3.0));
	block.s[3].c = (vec3(-8.0, 8.0, 0.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(7, 0, 8)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(8.0, 8.0, -4.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(8, 0, 9)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(-8.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(-5, -9, -4)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(-8.0, 9.0, 0.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(1, 2, 1)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(6.0, -3.0, -8.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(3, 8, 0)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-3.0, -7.0, 4.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(6, 1, 5)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(9.0, 7.0, 8.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(6, 9, -8)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(-5.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(-7, 9, 0)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(-8.0, 4.0, -5.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(-5, -5, 7)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(1.0, 0.0, 2.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(4, -1, 1)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-3.0, -1.0, -2.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(-6, -3, -2)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(-2.0, 0.0, -2.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(-7, 6, 4)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(-2.0, -3.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(-5.0, 3.0, -2.0, -9.0));
	block[0].s[0][0].a = (ivec3(-6, 1, -4));
	block[0].s[0][0].c = (vec4(6.0, 4.0, -6.0, 2.0));
	block[0].s[0][1].a = (ivec3(5, -3, 0));
	block[0].s[0][1].c = (vec4(-2.0, -9.0, 5.0, 6.0));
	block[0].s[1][0].a = (ivec3(0, 4, 4));
	block[0].s[1][0].c = (vec4(5.0, 5.0, 1.0, -1.0));
	block[0].s[1][1].a = (ivec3(5, -1, 1));
	block[0].s[1][1].c = (vec4(6.0, -9.0, -4.0, 6.0));
	block[0].s[2][0].a = (ivec3(-7, -8, -9));
	block[0].s[2][0].c = (vec4(-6.0, -4.0, 5.0, 0.0));
	block[0].s[2][1].a = (ivec3(-7, -7, 8));
	block[0].s[2][1].c = (vec4(-3.0, 7.0, 5.0, -4.0));
	block[1].v = (vec4(-2.0, 8.0, 4.0, 8.0));
	block[1].s[0][0].a = (ivec3(-5, -8, 6));
	block[1].s[0][0].c = (vec4(-7.0, 2.0, 0.0, 0.0));
	block[1].s[0][1].a = (ivec3(7, 9, -3));
	block[1].s[0][1].c = (vec4(-1.0, -7.0, -8.0, 1.0));
	block[1].s[1][0].a = (ivec3(-5, -9, -5));
	block[1].s[1][0].c = (vec4(0.0, 1.0, -9.0, 0.0));
	block[1].s[1][1].a = (ivec3(5, 9, 5));
	block[1].s[1][1].c = (vec4(8.0, -7.0, 8.0, 1.0));
	block[2].v = (vec4(0.0, -4.0, -7.0, -3.0));
	block[2].s[0][0].a = (ivec3(1, -1, -2));
	block[2].s[0][0].c = (vec4(2.0, 2.0, -2.0, 3.0));
	block[2].s[0][1].a = (ivec3(-9, 7, -7));
	block[2].s[0][1].c = (vec4(-7.0, 7.0, 0.0, -2.0));
}
#version 450
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
	bvec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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

layout(std430, buffer_reference) buffer Block
{
	highp uvec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_float(block[0].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 9.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-2.0, 4.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -6.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(6.0, 4.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 4.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(1.0, -7.0, 0.0, 6.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-6.0, 9.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	block[1].var = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	block[2].var = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
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
	allOk = compare_float((block[0].padding), 8.0) && allOk;
	allOk = compare_mat4x2(block[0].var, mat4x2(1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0, 8.0)) && allOk;
	allOk = compare_float((block[1].padding), -6.0) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(-5.0, 7.0, -8.0, -2.0, 5.0, -8.0, 9.0, 4.0)) && allOk;
	allOk = compare_float((block[2].padding), 4.0) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(4.0, 3.0, -6.0, -6.0, 8.0, 3.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-9.0);
	block[0].var = (mat4x2(-8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0, 5.0));
	block[1].padding = (8.0);
	block[1].var = (mat4x2(8.0, 8.0, 6.0, -3.0, -6.0, -4.0, -6.0, -9.0));
	block[2].padding = (1.0);
	block[2].var = (mat4x2(-1.0, 8.0, -7.0, 5.0, -3.0, 8.0, 7.0, 6.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, buffer_reference) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
};
layout(std430, buffer_reference) buffer BlockB
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
	allOk = compare_float((blockA.a), 8.0) && allOk;
	allOk = compare_float(blockA.c[0][0], 7.0) && allOk;
	allOk = compare_float(blockA.c[0][1], 2.0) && allOk;
	allOk = compare_float(blockA.c[1][0], 9.0) && allOk;
	allOk = compare_float(blockA.c[1][1], 0.0) && allOk;
	allOk = compare_vec2(blockA.c[0], vec2(7.0, 2.0)) && allOk;
	allOk = compare_vec2(blockA.c[1], vec2(9.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-5, -4)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-1.0);
	blockB.a[0] = (vec3(8.0, 1.0, 4.0));
	blockB.a[1] = (vec3(-5.0, 1.0, 8.0));
	blockB.a[2] = (vec3(-2.0, -1.0, -5.0));
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
	mediump float a;
	highp int b;
	highp float c;
	lowp int d;
	highp uint e;
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp float f;
	lowp float g;
	lowp float h;
	bool i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b), 7) && allOk;
	allOk = compare_int((blockB.d), 3) && allOk;
	allOk = compare_float((blockC.f), -7.0) && allOk;
	allOk = compare_float((blockC.g), 7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (8.0);
	blockB.d = (5);
	blockC.f = (2.0);
}
#version 450
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
	mediump float f[3];
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
	allOk = compare_float((blockD.f[1]), 7.0) && allOk;
	allOk = compare_float((blockD.f[2]), 4.0) && allOk;
	allOk = compare_ivec2((blockE.g), ivec2(6, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(-7.0, -3.0, 4.0, -9.0, -4.0, 1.0, -7.0, 2.0));
	blockB.b = (true);
	blockB.c = (6u);
	blockC.d = (uvec4(4u, 4u, 1u, 9u));
	blockD.f[0] = (1.0);
	blockD.f[1] = (3.0);
	blockD.f[2] = (9.0);
	blockE.g = (ivec2(6, 4));
}
#version 450
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
	mediump vec3 a;
	bvec3 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp mat2x3 c;
	lowp vec3 d;
	mediump ivec2 e;
	bvec2 f;
	lowp float g[];
};
layout(std430, column_major, buffer_reference) readonly buffer BlockD
{
	mediump vec4 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(-8.0, -2.0, 9.0)) && allOk;
	allOk = compare_vec3((blockC[0].d), vec3(9.0, -6.0, 5.0)) && allOk;
	allOk = compare_bvec2((blockC[0].f), bvec2(true, false)) && allOk;
	allOk = compare_float((blockC[0].g[0]), 3.0) && allOk;
	allOk = compare_float((blockC[0].g[1]), 3.0) && allOk;
	allOk = compare_float((blockC[0].g[2]), -9.0) && allOk;
	allOk = compare_float((blockC[0].g[3]), 4.0) && allOk;
	allOk = compare_float((blockC[0].g[4]), 8.0) && allOk;
	allOk = compare_float((blockC[0].g[5]), 5.0) && allOk;
	allOk = compare_vec4((blockD.h[0]), vec4(-4.0, 3.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec4((blockD.h[1]), vec4(-2.0, -5.0, -9.0, -7.0)) && allOk;
	allOk = compare_vec4((blockD.h[2]), vec4(6.0, -3.0, 6.0, 4.0)) && allOk;
	allOk = compare_vec4((blockD.h[3]), vec4(1.0, -3.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.h[4]), vec4(-4.0, -7.0, 5.0, -1.0)) && allOk;
	allOk = compare_vec4((blockD.h[5]), vec4(6.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec4((blockD.h[6]), vec4(1.0, -2.0, -3.0, -5.0)) && allOk;
	allOk = compare_vec4((blockD.h[7]), vec4(-7.0, 4.0, -2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(1.0, 1.0, -4.0));
	blockB.b[0] = (bvec3(false, true, true));
	blockB.b[1] = (bvec3(false, false, true));
	blockB.b[2] = (bvec3(false, true, true));
	blockC[0].c = (mat2x3(-8.0, -3.0, 6.0, 5.0, -2.0, -1.0));
	blockC[0].d = (vec3(-4.0, -8.0, 2.0));
	blockC[0].e = (ivec2(0, 3));
	blockC[0].f = (bvec2(false, true));
	blockC[0].g[0] = (-2.0);
	blockC[0].g[1] = (0.0);
	blockC[0].g[2] = (2.0);
	blockC[0].g[3] = (6.0);
	blockC[0].g[4] = (-7.0);
	blockC[0].g[5] = (3.0);
}
#version 450
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
	highp int b[1];
	lowp uint c;
	highp mat4x3 d[];
};
layout(std140, buffer_reference) buffer BlockC
{
	highp ivec3 e[];
};
layout(std140, buffer_reference) readonly buffer BlockD
{
	mediump vec2 f;
	lowp uvec3 g[6];
	lowp ivec4 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b[0]), 3) && allOk;
	allOk = compare_ivec4((blockD.h), ivec4(5, 7, 6, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (3);
	blockB.d[0] = (mat4x3(7.0, -3.0, 4.0, 3.0, -9.0, 5.0, 2.0, 0.0, 4.0, 2.0, -9.0, -8.0));
	blockB.d[1] = (mat4x3(9.0, -6.0, -4.0, 5.0, -4.0, -6.0, -4.0, -2.0, -8.0, 5.0, -4.0, -5.0));
	blockB.d[2] = (mat4x3(-9.0, -2.0, 8.0, 0.0, -1.0, 1.0, 4.0, -4.0, -1.0, -7.0, 1.0, -5.0));
	blockC.e[0] = (ivec3(2, 6, 8));
	blockC.e[1] = (ivec3(-7, 5, 3));
	blockC.e[2] = (ivec3(-6, 1, 5));
	blockC.e[3] = (ivec3(-2, -6, -6));
	blockC.e[4] = (ivec3(-1, 7, -7));
}
#version 450
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
	layout(offset = 0) highp vec4 b;
	layout(offset = 16) lowp vec2 c;
	layout(offset = 32) lowp uvec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[0].a), 4u) && allOk;
	allOk = compare_uint((blockB[1].a), 3u) && allOk;
	allOk = compare_uint((blockB[2].a), 5u) && allOk;
	allOk = compare_vec2((blockC[0].c), vec2(-2.0, 3.0)) && allOk;
	allOk = compare_vec2((blockC[1].c), vec2(-6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (4u);
	blockB[1].a = (4u);
	blockB[2].a = (9u);
	blockC[0].b = (vec4(5.0, -4.0, 2.0, -1.0));
	blockC[0].c = (vec2(9.0, -3.0));
	blockC[0].d = (uvec4(6u, 5u, 3u, 9u));
	blockC[1].b = (vec4(1.0, -2.0, -8.0, -6.0));
	blockC[1].c = (vec2(9.0, 4.0));
	blockC[1].d = (uvec4(6u, 3u, 2u, 2u));
}
#version 450
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
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp float b;
	layout(offset = 4) mediump int c;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp vec3 d[1];
	layout(offset = 16) bvec4 e;
	layout(offset = 32) mediump uvec4 f;
	layout(offset = 48) lowp uvec4 g;
	layout(offset = 64) lowp uvec2 h;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) bvec3 i;
	layout(offset = 16) bvec2 j;
	layout(offset = 24) highp vec2 k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD[3];
    BlockE blockE[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-4.0, 6.0, 6.0, -7.0)) && allOk;
	allOk = compare_float((blockC[0].b), -9.0) && allOk;
	allOk = compare_float((blockC[1].b), -4.0) && allOk;
	allOk = compare_float((blockC[2].b), 8.0) && allOk;
	allOk = compare_uvec4((blockD[0].f), uvec4(4u, 1u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((blockD[0].g), uvec4(9u, 6u, 0u, 1u)) && allOk;
	allOk = compare_uvec4((blockD[1].f), uvec4(0u, 3u, 4u, 9u)) && allOk;
	allOk = compare_uvec4((blockD[1].g), uvec4(9u, 1u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((blockD[2].f), uvec4(0u, 3u, 2u, 3u)) && allOk;
	allOk = compare_uvec4((blockD[2].g), uvec4(3u, 8u, 9u, 7u)) && allOk;
	allOk = compare_bvec3((blockE[0].i), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec2((blockE[0].j), bvec2(true, true)) && allOk;
	allOk = compare_vec2((blockE[0].k), vec2(-1.0, 1.0)) && allOk;
	allOk = compare_bvec3((blockE[1].i), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec2((blockE[1].j), bvec2(true, false)) && allOk;
	allOk = compare_vec2((blockE[1].k), vec2(5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(9.0, -7.0, -5.0, -9.0));
	blockC[0].b = (-8.0);
	blockC[0].c = (0);
	blockC[1].b = (8.0);
	blockC[1].c = (0);
	blockC[2].b = (8.0);
	blockC[2].c = (7);
	blockD[0].d[0] = (vec3(1.0, 2.0, -5.0));
	blockD[0].e = (bvec4(true, true, true, false));
	blockD[0].g = (uvec4(9u, 6u, 9u, 7u));
	blockD[0].h = (uvec2(2u, 5u));
	blockD[1].d[0] = (vec3(8.0, -5.0, 4.0));
	blockD[1].e = (bvec4(true, false, false, false));
	blockD[1].g = (uvec4(1u, 4u, 8u, 4u));
	blockD[1].h = (uvec2(3u, 1u));
	blockD[2].d[0] = (vec3(4.0, 7.0, -1.0));
	blockD[2].e = (bvec4(false, false, true, true));
	blockD[2].g = (uvec4(1u, 5u, 5u, 3u));
	blockD[2].h = (uvec2(2u, 5u));
	blockE[0].i = (bvec3(true, true, true));
	blockE[0].j = (bvec2(false, false));
	blockE[0].k = (vec2(-4.0, 3.0));
	blockE[1].i = (bvec3(true, true, false));
	blockE[1].j = (bvec2(false, false));
	blockE[1].k = (vec2(7.0, 3.0));
}
#version 450
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
	layout(offset = 0) lowp uvec4 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump ivec3 b;
	layout(offset = 12) lowp int c;
	layout(offset = 16) lowp vec4 d;
	layout(offset = 32) mediump ivec4 e;
	layout(offset = 48) highp ivec3 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(7u, 1u, 0u, 9u)) && allOk;
	allOk = compare_ivec3((blockC.b), ivec3(-3, -3, 0)) && allOk;
	allOk = compare_int((blockC.c), -3) && allOk;
	allOk = compare_vec4((blockC.d), vec4(2.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec4((blockC.e), ivec4(-5, -8, 9, 0)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(8, 0, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(9u, 2u, 4u, 5u));
	blockC.b = (ivec3(0, 6, -1));
	blockC.c = (1);
	blockC.e = (ivec4(2, 6, 4, -3));
	blockC.f = (ivec3(-3, 9, 2));
}
#version 450
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
	bvec2 mA;
	mediump vec4 mB;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	mediump vec2 a;
	bvec4 b;
	mediump mat4x3 c[][3];
};
layout(scalar, buffer_reference) buffer BlockC
{
	highp uint d;
	sA e;
	sB f;
	highp uvec4 g[3];
	highp uint h[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uint((blockC.d), 6u) && allOk;
	allOk = compare_uvec4((blockC.g[0]), uvec4(9u, 3u, 8u, 6u)) && allOk;
	allOk = compare_uvec4((blockC.g[1]), uvec4(6u, 6u, 3u, 9u)) && allOk;
	allOk = compare_uvec4((blockC.g[2]), uvec4(7u, 1u, 6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec4(true, true, true, true));
	blockC.d = (2u);
	blockC.e.mA = (mat4(4.0, -7.0, -2.0, 3.0, -1.0, -3.0, -5.0, -5.0, 8.0, -4.0, 0.0, 3.0, 5.0, 8.0, 8.0, 7.0));
	blockC.f.mA = (bvec2(true, true));
	blockC.f.mB = (vec4(7.0, -1.0, 9.0, -2.0));
	blockC.h[0] = (8u);
	blockC.h[1] = (3u);
	blockC.h[2] = (9u);
	blockC.h[3] = (3u);
	blockC.h[4] = (1u);
	blockC.h[5] = (1u);
}
#version 450
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
	highp uint mA;
	lowp mat3 mB;
	lowp vec3 mC;
	highp ivec4 mD;
};
struct sB
{
	highp vec4 mA;
	mediump float mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	highp mat3 a;
	highp ivec4 b[2];
	lowp uvec4 c;
	bvec3 d[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	mediump float e;
	mediump mat4x3 f;
	lowp uvec2 g;
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockD
{
	mediump float h[];
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	mediump mat2x3 i;
	sA j;
	sB k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(-8.0, 7.0, -3.0, 6.0, 5.0, -9.0, -2.0, 6.0, 2.0)) && allOk;
	allOk = compare_ivec4((blockB.b[0]), ivec4(-6, -7, -6, 0)) && allOk;
	allOk = compare_ivec4((blockB.b[1]), ivec4(-2, 5, 6, -8)) && allOk;
	allOk = compare_bvec3((blockB.d[0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.d[1]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.d[2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.d[3]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.d[4]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.d[5]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.d[6]), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec2((blockC.g), uvec2(1u, 0u)) && allOk;
	allOk = compare_mat2x3(blockE[0].i, mat2x3(2.0, -5.0, 5.0, -4.0, 7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (uvec4(1u, 3u, 0u, 4u));
	blockB.d[0] = (bvec3(false, false, true));
	blockB.d[1] = (bvec3(true, false, true));
	blockB.d[2] = (bvec3(false, false, true));
	blockB.d[3] = (bvec3(true, false, false));
	blockB.d[4] = (bvec3(false, true, true));
	blockB.d[5] = (bvec3(true, false, false));
	blockB.d[6] = (bvec3(true, true, true));
	blockC.e = (-2.0);
	blockC.g = (uvec2(9u, 1u));
	blockE[0].i = (mat2x3(0.0, -9.0, -4.0, -3.0, 0.0, -1.0));
	blockE[0].j.mA = (0u);
	blockE[0].j.mB = (mat3(8.0, 3.0, -3.0, 8.0, -6.0, 2.0, 1.0, -8.0, 3.0));
	blockE[0].j.mC = (vec3(3.0, -5.0, 2.0));
	blockE[0].j.mD = (ivec4(-4, -1, -4, 2));
	blockE[0].k[0].mA = (vec4(-3.0, 2.0, -5.0, 4.0));
	blockE[0].k[0].mB = (-2.0);
	blockE[0].k[1].mA = (vec4(-6.0, -1.0, 0.0, -6.0));
	blockE[0].k[1].mB = (-5.0);
	blockE[0].k[2].mA = (vec4(-1.0, 8.0, 3.0, 6.0));
	blockE[0].k[2].mB = (8.0);
}
#version 450
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
	mediump ivec2 a;
	mediump uvec3 b;
	lowp vec2 c;
	highp float d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	lowp float e;
	lowp ivec3 f;
	highp float g[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	highp mat2 h;
	lowp float i[][6];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(2, 5)) && allOk;
	allOk = compare_uvec3((blockB.b), uvec3(8u, 3u, 1u)) && allOk;
	allOk = compare_vec2((blockB.c), vec2(8.0, -8.0)) && allOk;
	allOk = compare_float((blockC.e), -1.0) && allOk;
	allOk = compare_mat2(blockD.h, mat2(9.0, -1.0, -9.0, -5.0)) && allOk;
	allOk = compare_float((blockD.i[0][0]), -1.0) && allOk;
	allOk = compare_float((blockD.i[0][1]), 9.0) && allOk;
	allOk = compare_float((blockD.i[0][2]), -8.0) && allOk;
	allOk = compare_float((blockD.i[0][3]), -5.0) && allOk;
	allOk = compare_float((blockD.i[0][4]), 7.0) && allOk;
	allOk = compare_float((blockD.i[0][5]), -9.0) && allOk;
	allOk = compare_float((blockD.i[1][0]), -8.0) && allOk;
	allOk = compare_float((blockD.i[1][1]), 1.0) && allOk;
	allOk = compare_float((blockD.i[1][2]), 7.0) && allOk;
	allOk = compare_float((blockD.i[1][3]), 8.0) && allOk;
	allOk = compare_float((blockD.i[1][4]), -8.0) && allOk;
	allOk = compare_float((blockD.i[1][5]), 5.0) && allOk;
	allOk = compare_float((blockD.i[2][0]), 0.0) && allOk;
	allOk = compare_float((blockD.i[2][1]), -6.0) && allOk;
	allOk = compare_float((blockD.i[2][2]), -4.0) && allOk;
	allOk = compare_float((blockD.i[2][3]), 5.0) && allOk;
	allOk = compare_float((blockD.i[2][4]), -1.0) && allOk;
	allOk = compare_float((blockD.i[2][5]), -8.0) && allOk;
	allOk = compare_float((blockD.i[3][0]), 7.0) && allOk;
	allOk = compare_float((blockD.i[3][1]), -7.0) && allOk;
	allOk = compare_float((blockD.i[3][2]), 8.0) && allOk;
	allOk = compare_float((blockD.i[3][3]), -3.0) && allOk;
	allOk = compare_float((blockD.i[3][4]), 5.0) && allOk;
	allOk = compare_float((blockD.i[3][5]), -8.0) && allOk;
	allOk = compare_float((blockD.i[4][0]), 1.0) && allOk;
	allOk = compare_float((blockD.i[4][1]), 7.0) && allOk;
	allOk = compare_float((blockD.i[4][2]), 9.0) && allOk;
	allOk = compare_float((blockD.i[4][3]), -5.0) && allOk;
	allOk = compare_float((blockD.i[4][4]), 5.0) && allOk;
	allOk = compare_float((blockD.i[4][5]), -7.0) && allOk;
	allOk = compare_float((blockD.i[5][0]), -9.0) && allOk;
	allOk = compare_float((blockD.i[5][1]), 9.0) && allOk;
	allOk = compare_float((blockD.i[5][2]), -3.0) && allOk;
	allOk = compare_float((blockD.i[5][3]), 8.0) && allOk;
	allOk = compare_float((blockD.i[5][4]), 8.0) && allOk;
	allOk = compare_float((blockD.i[5][5]), -5.0) && allOk;
	allOk = compare_float((blockD.i[6][0]), -9.0) && allOk;
	allOk = compare_float((blockD.i[6][1]), -9.0) && allOk;
	allOk = compare_float((blockD.i[6][2]), 3.0) && allOk;
	allOk = compare_float((blockD.i[6][3]), -3.0) && allOk;
	allOk = compare_float((blockD.i[6][4]), 8.0) && allOk;
	allOk = compare_float((blockD.i[6][5]), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(8, 3));
	blockB.c = (vec2(6.0, -5.0));
	blockC.e = (1.0);
	blockD.h = (mat2(7.0, -1.0, 6.0, -5.0));
	blockD.i[0][0] = (-8.0);
	blockD.i[0][1] = (2.0);
	blockD.i[0][2] = (5.0);
	blockD.i[0][3] = (-4.0);
	blockD.i[0][4] = (-3.0);
	blockD.i[0][5] = (4.0);
	blockD.i[1][0] = (-6.0);
	blockD.i[1][1] = (9.0);
	blockD.i[1][2] = (4.0);
	blockD.i[1][3] = (1.0);
	blockD.i[1][4] = (-3.0);
	blockD.i[1][5] = (5.0);
	blockD.i[2][0] = (-7.0);
	blockD.i[2][1] = (3.0);
	blockD.i[2][2] = (-4.0);
	blockD.i[2][3] = (4.0);
	blockD.i[2][4] = (-1.0);
	blockD.i[2][5] = (-1.0);
	blockD.i[3][0] = (-7.0);
	blockD.i[3][1] = (-2.0);
	blockD.i[3][2] = (-6.0);
	blockD.i[3][3] = (-5.0);
	blockD.i[3][4] = (0.0);
	blockD.i[3][5] = (-4.0);
	blockD.i[4][0] = (-3.0);
	blockD.i[4][1] = (5.0);
	blockD.i[4][2] = (6.0);
	blockD.i[4][3] = (-2.0);
	blockD.i[4][4] = (2.0);
	blockD.i[4][5] = (8.0);
	blockD.i[5][0] = (8.0);
	blockD.i[5][1] = (7.0);
	blockD.i[5][2] = (-8.0);
	blockD.i[5][3] = (0.0);
	blockD.i[5][4] = (8.0);
	blockD.i[5][5] = (7.0);
	blockD.i[6][0] = (-9.0);
	blockD.i[6][1] = (1.0);
	blockD.i[6][2] = (-9.0);
	blockD.i[6][3] = (-8.0);
	blockD.i[6][4] = (-4.0);
	blockD.i[6][5] = (1.0);
}
#version 450
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
	mediump vec4 a[1];
	lowp ivec2 b;
	lowp ivec2 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[nonuniformEXT(0)].a[0]), vec4(-8.0, 9.0, 9.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].b), ivec2(-4, -4)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].c), ivec2(-6, -2)) && allOk;
	allOk = compare_vec4((blockB[nonuniformEXT(1)].a[0]), vec4(8.0, 4.0, -4.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].b), ivec2(-9, -7)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].c), ivec2(9, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (vec4(4.0, 0.0, 9.0, 4.0));
	blockB[nonuniformEXT(0)].b = (ivec2(1, -7));
	blockB[nonuniformEXT(1)].a[0] = (vec4(-6.0, -5.0, -2.0, 4.0));
	blockB[nonuniformEXT(1)].b = (ivec2(-2, 5));
}
#version 450
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
	u16vec2 a;
	lowp mat4x2 b;
	int16_t c;
	u16vec2 d;
	mediump vec4 e;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	u16vec2 f;
	highp uvec2 g;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	f16vec4 h;
};
layout(std430, buffer_reference) buffer BlockE
{
	mediump uvec3 i;
	mediump uvec2 j;
	u16vec2 k;
	float16_t l;
	highp uint m;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(blockB.a), uvec2(0u, 2u)) && allOk;
	allOk = compare_mat4x2(blockB.b, mat4x2(8.0, 9.0, 0.0, -4.0, -4.0, -6.0, -5.0, -1.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.f), uvec2(1u, 5u)) && allOk;
	allOk = compare_uvec2((blockC.g), uvec2(6u, 5u)) && allOk;
	allOk = compare_f16vec4(vec4(blockD.h), vec4(0.0, 2.0, 1.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockE.i), uvec3(8u, 0u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockE.k), uvec2(1u, 8u)) && allOk;
	allOk = compare_float16_t(float(blockE.l), -3.0) && allOk;
	allOk = compare_uint((blockE.m), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec2(uvec2(4u, 1u));
	blockB.b = (mat4x2(-2.0, -6.0, 0.0, 3.0, -6.0, -7.0, 6.0, 8.0));
	blockB.c = int16_t(5);
	blockB.d = u16vec2(uvec2(9u, 4u));
	blockB.e = (vec4(-2.0, 2.0, 3.0, -1.0));
	blockC.f = u16vec2(uvec2(9u, 9u));
	blockD.h = f16vec4(vec4(-7.0, -4.0, 8.0, 2.0));
	blockE.i = (uvec3(6u, 1u, 9u));
	blockE.k = u16vec2(uvec2(0u, 5u));
	blockE.l = float16_t(-5.0);
}
#version 450
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
	i16vec3 a;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	f16vec4 b;
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	uint16_t c;
	u16vec2 d;
	mediump uint e;
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	lowp mat4x3 f;
	f16vec2 g;
	f16vec4 h;
	mediump float i;
	mediump uvec4 j;
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
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockC.b), vec4(2.0, 4.0, 0.0, -2.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.d), uvec2(8u, 4u)) && allOk;
	allOk = compare_uint((blockD.e), 2u) && allOk;
	allOk = compare_mat4x3(blockE.f, mat4x3(9.0, -2.0, -9.0, 2.0, 0.0, -9.0, 0.0, -9.0, 7.0, 0.0, -2.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE.g), vec2(2.0, 4.0)) && allOk;
	allOk = compare_float((blockE.i), 9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = f16vec4(vec4(-2.0, 2.0, -7.0, 4.0));
	blockD.c = uint16_t(1u);
	blockD.d = u16vec2(uvec2(3u, 2u));
	blockD.e = (6u);
	blockE.f = (mat4x3(3.0, -3.0, -1.0, 6.0, 9.0, 5.0, -6.0, -1.0, -2.0, 2.0, -3.0, -9.0));
	blockE.h = f16vec4(vec4(5.0, -5.0, -2.0, -2.0));
	blockE.i = (8.0);
	blockE.j = (uvec4(1u, 3u, 2u, 9u));
}
#version 450
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
	int16_t a[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	f16vec2 b;
	bvec2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.a[0]), 4) && allOk;
	allOk = compare_f16vec2(vec2(blockC.b), vec2(-1.0, 1.0)) && allOk;
	allOk = compare_bvec2((blockC.c[0]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = int16_t(5);
	blockC.b = f16vec2(vec2(7.0, -9.0));
}
#version 450
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
	f16vec2 a;
	u16vec2 b;
	u16vec3 c[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump uvec2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB.a), vec2(-5.0, 5.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.b), uvec2(3u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.c[0]), uvec3(4u, 1u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec2(vec2(3.0, -4.0));
	blockB.b = u16vec2(uvec2(8u, 3u));
	blockB.c[0] = u16vec3(uvec3(7u, 9u, 2u));
	blockC.d[0] = (uvec2(0u, 8u));
}
#version 450
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
	bvec2 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	layout(offset = 8) u16vec3 b;
	layout(offset = 16) bvec4 c;
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) uint16_t d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) i16vec3 e;
	layout(offset = 8) mediump ivec2 f;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) u16vec3 g;
	layout(offset = 6) u16vec2 h;
	layout(offset = 16) lowp ivec4 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
    BlockE blockE;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB.b), uvec3(4u, 0u, 0u)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(true, false, false, true)) && allOk;
	allOk = compare_uint16_t(uint(blockC.d), 7u) && allOk;
	allOk = compare_i16vec3(ivec3(blockD[0].e), ivec3(-1, -2, -1)) && allOk;
	allOk = compare_ivec2((blockD[0].f), ivec2(1, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD[1].e), ivec3(-3, -8, 1)) && allOk;
	allOk = compare_ivec2((blockD[1].f), ivec2(-8, 7)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.g), uvec3(6u, 5u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockE.h), uvec2(6u, 2u)) && allOk;
	allOk = compare_ivec4((blockE.i), ivec4(0, 3, -1, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b = u16vec3(uvec3(2u, 9u, 1u));
	blockB.c = (bvec4(true, true, true, false));
	blockD[0].e = i16vec3(ivec3(5, 2, -1));
	blockD[0].f = (ivec2(-4, 9));
	blockD[1].e = i16vec3(ivec3(9, -5, 6));
	blockD[1].f = (ivec2(0, -7));
	blockE.g = u16vec3(uvec3(6u, 9u, 8u));
	blockE.h = u16vec2(uvec2(1u, 2u));
}
#version 450
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
	float16_t a;
	bvec4 b;
	lowp uint c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(0)].a), -8.0) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].b), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(0)].c), 8u) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(1)].a), 0.0) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].b), bvec4(false, true, false, false)) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(1)].c), 8u) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(2)].a), 9.0) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(2)].b), bvec4(false, true, true, true)) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(2)].c), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].c = (8u);
	blockB[nonuniformEXT(1)].c = (2u);
	blockB[nonuniformEXT(2)].c = (8u);
}
#version 450
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
	u8vec4 a;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp mat4x2 b;
	u8vec4 c[1];
	u8vec4 d;
	highp uint e;
	highp int f;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	lowp vec4 g;
};
layout(std430, buffer_reference) buffer BlockE
{
	highp mat4 h;
	lowp ivec3 i;
	lowp float j;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockC.c[0]), uvec4(5u, 5u, 6u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.d), uvec4(7u, 2u, 9u, 1u)) && allOk;
	allOk = compare_uint((blockC.e), 2u) && allOk;
	allOk = compare_int((blockC.f), -2) && allOk;
	allOk = compare_float((blockE.j), 5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat4x2(2.0, -7.0, 4.0, 6.0, -8.0, 8.0, -3.0, 3.0));
	blockC.c[0] = u8vec4(uvec4(9u, 6u, 0u, 2u));
	blockD.g = (vec4(-9.0, -5.0, 3.0, 5.0));
	blockE.h = (mat4(-5.0, -2.0, -2.0, 8.0, -3.0, -3.0, -8.0, 1.0, -3.0, -1.0, 3.0, 7.0, -4.0, -5.0, -1.0, -3.0));
}
#version 450
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
	highp ivec3 b;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp mat3 c[1];
	i8vec3 d;
	lowp mat4 e;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	highp mat4x2 f;
	highp uvec4 g;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.b), ivec3(2, 0, 5)) && allOk;
	allOk = compare_mat3(blockC.c[0], mat3(5.0, 5.0, -5.0, -2.0, -9.0, 1.0, -6.0, -8.0, -5.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.d), ivec3(9, 7, 4294967288)) && allOk;
	allOk = compare_uvec4((blockD.g), uvec4(3u, 9u, 5u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = (ivec3(8, 0, -3));
	blockC.d = i8vec3(ivec3(5, 4294967291, 8));
	blockC.e = (mat4(-1.0, 7.0, -9.0, -3.0, -1.0, 6.0, -2.0, -4.0, 9.0, -4.0, 2.0, -4.0, 4.0, -8.0, -4.0, 1.0));
	blockD.f = (mat4x2(-4.0, -4.0, -7.0, -1.0, 9.0, -8.0, 6.0, 2.0));
	blockD.g = (uvec4(3u, 0u, 0u, 1u));
}
#version 450
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
	u8vec4 a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp ivec3 b;
	bvec2 c;
	highp vec2 d[];
};
layout(std430, buffer_reference) buffer BlockD
{
	highp ivec3 e;
	highp float f;
	lowp uvec4 g[6];
	highp mat2 h[];
};
layout(std140, buffer_reference) buffer BlockE
{
	highp uvec3 i;
	lowp mat2 j[];
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockC.b), ivec3(8, 9, 0)) && allOk;
	allOk = compare_bvec2((blockC.c), bvec2(false, true)) && allOk;
	allOk = compare_ivec3((blockD.e), ivec3(7, -1, -3)) && allOk;
	allOk = compare_float((blockD.f), 5.0) && allOk;
	allOk = compare_mat2(blockD.h[0], mat2(-8.0, -6.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat2(blockD.h[1], mat2(0.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(blockD.h[2], mat2(1.0, 5.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2(blockD.h[3], mat2(4.0, 6.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2(blockD.h[4], mat2(3.0, -1.0, -2.0, 9.0)) && allOk;
	allOk = compare_uvec3((blockE.i), uvec3(2u, 6u, 2u)) && allOk;
	allOk = compare_mat2(blockE.j[0], mat2(-1.0, -1.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2(blockE.j[1], mat2(4.0, -8.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(blockE.j[2], mat2(6.0, 0.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(blockE.j[3], mat2(-2.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat2(blockE.j[4], mat2(-1.0, -9.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2(blockE.j[5], mat2(4.0, 8.0, -4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (ivec3(-2, 8, -3));
	blockC.d[0] = (vec2(-1.0, 3.0));
	blockC.d[1] = (vec2(7.0, -4.0));
	blockC.d[2] = (vec2(-5.0, -1.0));
	blockC.d[3] = (vec2(-3.0, 1.0));
	blockD.e = (ivec3(-9, 8, 9));
	blockE.i = (uvec3(1u, 7u, 5u));
}
#version 450
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
	highp ivec3 b[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp mat3 c;
	i8vec3 d[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp mat3x2 e;
	highp mat4x2 f;
	highp uvec4 g;
	highp uvec3 h;
	highp mat3 i;
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.b[0]), ivec3(2, 0, 5)) && allOk;
	allOk = compare_ivec3((blockB.b[1]), ivec3(5, 5, -5)) && allOk;
	allOk = compare_ivec3((blockB.b[2]), ivec3(-2, -9, 1)) && allOk;
	allOk = compare_ivec3((blockB.b[3]), ivec3(-6, -8, -5)) && allOk;
	allOk = compare_ivec3((blockB.b[4]), ivec3(9, 7, -8)) && allOk;
	allOk = compare_ivec3((blockB.b[5]), ivec3(1, 5, -5)) && allOk;
	allOk = compare_ivec3((blockB.b[6]), ivec3(-8, -7, 7)) && allOk;
	allOk = compare_ivec3((blockB.b[7]), ivec3(-5, 8, -5)) && allOk;
	allOk = compare_mat3(blockC.c, mat3(7.0, -8.0, -4.0, -3.0, 5.0, 0.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.d[0]), ivec3(8, 4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.d[1]), ivec3(6, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.d[2]), ivec3(8, 0, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.d[3]), ivec3(4294967290, 4294967295, 5)) && allOk;
	allOk = compare_uvec4((blockD.g), uvec4(4u, 6u, 3u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b[0] = (ivec3(8, 0, -3));
	blockB.b[1] = (ivec3(9, -5, 2));
	blockB.b[2] = (ivec3(1, 8, 6));
	blockB.b[3] = (ivec3(2, 9, 8));
	blockB.b[4] = (ivec3(5, -5, 8));
	blockB.b[5] = (ivec3(-1, 7, -9));
	blockB.b[6] = (ivec3(-3, -1, 6));
	blockB.b[7] = (ivec3(-2, -4, 9));
	blockC.d[0] = i8vec3(ivec3(4294967289, 4294967295, 9));
	blockC.d[1] = i8vec3(ivec3(4294967288, 6, 2));
	blockC.d[2] = i8vec3(ivec3(4294967295, 0, 2));
	blockC.d[3] = i8vec3(ivec3(4294967294, 4294967295, 3));
	blockD.f = (mat4x2(-3.0, -1.0, 2.0, -5.0, 4.0, -6.0, -5.0, -3.0));
	blockD.g = (uvec4(3u, 7u, 1u, 6u));
}
#version 450
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
	mediump mat3 a;
	mediump ivec3 b;
	i8vec4 c[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp mat2 d;
	mediump mat3 e;
	lowp mat2 f[7];
	mediump uvec2 g;
	lowp mat3 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.b), ivec3(3, -6, -4)) && allOk;
	allOk = compare_mat2(blockC.d, mat2(-8.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3(blockC.e, mat3(-5.0, -8.0, -9.0, -3.0, 7.0, -4.0, 4.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat2(blockC.f[0], mat2(0.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2(blockC.f[1], mat2(1.0, 1.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(blockC.f[2], mat2(0.0, 5.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2(blockC.f[3], mat2(-6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat2(blockC.f[4], mat2(4.0, 3.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(blockC.f[5], mat2(-3.0, 7.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(blockC.f[6], mat2(7.0, 9.0, -2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(6.0, 0.0, 5.0, 1.0, -7.0, -3.0, -7.0, 9.0, -9.0));
	blockB.b = (ivec3(8, 0, -8));
	blockB.c[0] = i8vec4(ivec4(4294967287, 5, 4, 4294967294));
	blockB.c[1] = i8vec4(ivec4(4294967291, 5, 4294967290, 3));
	blockC.e = (mat3(-9.0, 2.0, -6.0, -1.0, 7.0, 3.0, 6.0, -1.0, 1.0));
	blockC.f[0] = (mat2(-4.0, 8.0, -9.0, -7.0));
	blockC.f[1] = (mat2(3.0, 3.0, -9.0, 5.0));
	blockC.f[2] = (mat2(-9.0, -5.0, 9.0, -2.0));
	blockC.f[3] = (mat2(-2.0, 4.0, -6.0, 9.0));
	blockC.f[4] = (mat2(-2.0, 3.0, -6.0, 6.0));
	blockC.f[5] = (mat2(8.0, 5.0, -7.0, 6.0));
	blockC.f[6] = (mat2(-4.0, 6.0, 7.0, 5.0));
	blockC.g = (uvec2(5u, 5u));
}
#version 450
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
	i8vec4 mA;
	mediump mat2 mB;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	sA a;
	i8vec4 b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp int c;
	mediump vec4 d;
	int8_t e[1];
	i8vec3 f;
	lowp mat4x2 g[];
};
layout(std140, buffer_reference) buffer BlockD
{
	highp mat2 h;
	highp float i;
	mediump int j[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(blockC.e[0]), 8) && allOk;
	allOk = compare_mat4x2(blockC.g[0], mat4x2(4.0, -1.0, -3.0, 9.0, -7.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_float((blockD.i), -2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = i8vec4(ivec4(4, 7, 4294967295, 6));
	blockC.d = (vec4(8.0, 6.0, 2.0, -7.0));
	blockC.e[0] = int8_t(4294967294);
	blockC.g[0] = (mat4x2(-2.0, 6.0, 3.0, -7.0, 0.0, 4.0, -8.0, 6.0));
	blockD.h = (mat2(-2.0, -5.0, 3.0, 0.0));
	blockD.j[0] = (-2);
}
#version 450
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
	highp uvec2 a;
	mediump vec2 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b), vec2(9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(9u, 2u));
	blockB.b = (vec2(-3.0, -7.0));
}
#version 450
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
	highp int mB;
};
struct sB
{
	mediump mat3x4 mA;
	highp mat2 mB;
	mediump ivec3 mC;
	i8vec2 mD;
};
struct sC
{
	u8vec2 mA;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	sA a;
	uint8_t b;
	mediump vec4 c;
	bool d;
	highp uvec2 e[];
};
layout(std430, buffer_reference) buffer BlockC
{
	sB f;
	highp float g;
	lowp mat4 h[1];
	sC i[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	bool j;
	mediump mat2 k;
};
layout(std140, buffer_reference) buffer BlockE
{
	lowp uvec2 l;
	mediump mat2x3 m;
	i8vec3 n;
	lowp vec3 o[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a.mA, mat2(6.0, 6.0, -6.0, -3.0)) && allOk;
	allOk = compare_int((blockB.a.mB), -1) && allOk;
	allOk = compare_uint8_t(uint(blockB.b), 5u) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
	allOk = compare_float((blockC.g), -5.0) && allOk;
	allOk = compare_mat4(blockC.h[0], mat4(-3.0, 0.0, -2.0, -4.0, 4.0, -6.0, -3.0, 5.0, -2.0, 4.0, -4.0, 8.0, -5.0, -4.0, -6.0, -3.0)) && allOk;
	allOk = compare_bool((blockD.j), false) && allOk;
	allOk = compare_mat2(blockD.k, mat2(8.0, 8.0, -5.0, -4.0)) && allOk;
	allOk = compare_uvec2((blockE.l), uvec2(7u, 4u)) && allOk;
	allOk = compare_mat2x3(blockE.m, mat2x3(6.0, 8.0, -1.0, 2.0, 7.0, 8.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.n), ivec3(6, 7, 4294967289)) && allOk;
	allOk = compare_vec3((blockE.o[0]), vec3(0.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (vec4(-8.0, 3.0, -9.0, 2.0));
	blockB.d = (true);
	blockB.e[0] = (uvec2(7u, 2u));
	blockC.f.mA = (mat3x4(9.0, -3.0, 6.0, 7.0, -9.0, -6.0, -1.0, 3.0, 5.0, 3.0, 9.0, 8.0));
	blockC.f.mB = (mat2(-4.0, -8.0, -5.0, -1.0));
	blockC.f.mC = (ivec3(2, 0, 5));
	blockC.f.mD = i8vec2(ivec2(3, 4294967293));
	blockC.g = (2.0);
	blockC.h[0] = (mat4(4.0, 4.0, -6.0, 4.0, -5.0, -2.0, -4.0, -5.0, 7.0, 6.0, -9.0, 0.0, -7.0, 2.0, 1.0, 9.0));
	blockC.i[0].mA = u8vec2(uvec2(4u, 0u));
	blockD.j = (false);
	blockE.l = (uvec2(6u, 5u));
	blockE.n = i8vec3(ivec3(4294967289, 4294967289, 4294967291));
}
#version 450
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
	mediump mat4 mB;
	u8vec4 mC;
};
layout(std430, buffer_reference) buffer BlockB
{
	lowp vec4 a;
	mediump mat2x3 b;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	bvec3 c;
	lowp uvec2 d[1];
	mediump mat2 e;
	mediump mat3x2 f;
	u8vec4 g;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	highp ivec3 h;
	bool i;
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	i8vec3 j;
	highp uint k;
	sA l;
	lowp float m;
	int8_t n[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-5.0, 5.0, -6.0, -9.0)) && allOk;
	allOk = compare_bvec3((blockC.c), bvec3(false, true, true)) && allOk;
	allOk = compare_mat3x2(blockC.f, mat3x2(-2.0, 5.0, -1.0, 3.0, -5.0, 9.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.j), ivec3(8, 5, 9)) && allOk;
	allOk = compare_ivec3((blockE.l.mA), ivec3(2, 2, 3)) && allOk;
	allOk = compare_mat4(blockE.l.mB, mat4(3.0, -3.0, 0.0, -5.0, -7.0, 8.0, -6.0, 2.0, 7.0, 3.0, -5.0, -9.0, -3.0, -1.0, -3.0, 0.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.l.mC), uvec4(4u, 9u, 4u, 1u)) && allOk;
	allOk = compare_float((blockE.m), -1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(3.0, -4.0, 2.0, 2.0));
	blockC.d[0] = (uvec2(7u, 5u));
	blockC.e = (mat2(-8.0, 0.0, -5.0, 4.0));
	blockC.f = (mat3x2(7.0, 9.0, 3.0, 0.0, -2.0, 6.0));
	blockC.g = u8vec4(uvec4(2u, 6u, 0u, 5u));
	blockD[0].h = (ivec3(-2, -4, -4));
	blockD[0].i = (true);
	blockD[1].h = (ivec3(4, -3, -8));
	blockD[1].i = (true);
	blockD[2].h = (ivec3(4, 4, -3));
	blockD[2].i = (false);
	blockE.l.mA = (ivec3(2, 6, -9));
	blockE.l.mB = (mat4(-4.0, -5.0, 7.0, 2.0, 6.0, -5.0, -1.0, 5.0, 0.0, -4.0, -8.0, -2.0, -2.0, -9.0, 9.0, -5.0));
	blockE.l.mC = u8vec4(uvec4(3u, 6u, 0u, 3u));
	blockE.n[0] = int8_t(8);
	blockE.n[1] = int8_t(4294967292);
	blockE.n[2] = int8_t(6);
	blockE.n[3] = int8_t(4294967290);
	blockE.n[4] = int8_t(2);
	blockE.n[5] = int8_t(7);
	blockE.n[6] = int8_t(8);
	blockE.n[7] = int8_t(7);
}
#version 450
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
	u8vec2 mB;
	lowp uint mC;
};
struct sB
{
	sA mA;
};
layout(std140, buffer_reference) buffer BlockB
{
	mediump ivec3 a[2];
	u8vec4 b;
	sB c;
	mediump mat3x2 d;
	i8vec4 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB[0].a[0]), ivec3(-5, -9, -7)) && allOk;
	allOk = compare_ivec3((blockB[0].a[1]), ivec3(9, -1, 0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].b), uvec4(7u, 4u, 7u, 2u)) && allOk;
	allOk = compare_mat3x2(blockB[0].d, mat3x2(8.0, 5.0, -7.0, -3.0, -9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (ivec3(-7, 4, -4));
	blockB[0].a[1] = (ivec3(-7, -3, -9));
	blockB[0].b = u8vec4(uvec4(3u, 5u, 1u, 6u));
	blockB[0].d = (mat3x2(1.0, 2.0, -4.0, -6.0, 7.0, 1.0));
}
#version 450
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
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	sA a[];
};
layout(std430, buffer_reference) buffer BlockC
{
	u8vec4 b;
	lowp mat4x2 c;
	lowp vec3 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a[0].mA), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.a[1].mA), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockB.a[2].mA), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.a[3].mA), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.a[4].mA), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockB.a[5].mA), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockB.a[6].mA), bvec3(true, false, true)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.b), uvec4(0u, 3u, 8u, 8u)) && allOk;
	allOk = compare_mat4x2(blockC.c, mat4x2(-4.0, 3.0, -1.0, 4.0, -2.0, -5.0, -9.0, -7.0)) && allOk;
	allOk = compare_vec3((blockC.d), vec3(6.0, -3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA = (bvec3(true, true, true));
	blockB.a[1].mA = (bvec3(true, false, false));
	blockB.a[2].mA = (bvec3(true, false, true));
	blockB.a[3].mA = (bvec3(true, false, true));
	blockB.a[4].mA = (bvec3(false, true, true));
	blockB.a[5].mA = (bvec3(false, false, true));
	blockB.a[6].mA = (bvec3(true, false, false));
	blockC.b = u8vec4(uvec4(6u, 2u, 4u, 6u));
	blockC.c = (mat4x2(9.0, 8.0, 1.0, 7.0, -9.0, 2.0, 7.0, 0.0));
	blockC.d = (vec3(-8.0, -4.0, -2.0));
}
#version 450
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
	mediump mat4x3 a;
	highp ivec4 b;
	lowp vec3 c;
	lowp vec4 d;
	mediump mat4x2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

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

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) lowp vec2 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump uvec4 b[1];
	layout(offset = 16) highp uvec2 c[1];
	layout(offset = 24) lowp uvec2 d;
	layout(offset = 32) i8vec4 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump uint f[1];
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) highp vec2 g;
	layout(offset = 8) u8vec4 h;
	layout(offset = 12) u8vec4 i;
	layout(offset = 16) mediump ivec2 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockC.b[0]), uvec4(9u, 2u, 2u, 1u)) && allOk;
	allOk = compare_uvec2((blockC.c[0]), uvec2(7u, 8u)) && allOk;
	allOk = compare_uvec2((blockC.d), uvec2(4u, 4u)) && allOk;
	allOk = compare_uint((blockD.f[0]), 7u) && allOk;
	allOk = compare_vec2((blockE.g), vec2(-4.0, 7.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.h), uvec4(6u, 2u, 2u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.i), uvec4(9u, 3u, 8u, 7u)) && allOk;
	allOk = compare_ivec2((blockE.j), ivec2(-4, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(-3.0, -9.0));
	blockC.c[0] = (uvec2(2u, 1u));
	blockC.d = (uvec2(7u, 4u));
	blockC.e = i8vec4(ivec4(2, 2, 4, 9));
	blockD.f[0] = (0u);
	blockE.g = (vec2(-6.0, -7.0));
	blockE.i = u8vec4(uvec4(1u, 5u, 5u, 2u));
}
#version 450
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
	lowp ivec4 mA;
	u8vec2 mB;
	lowp mat2x3 mC;
};
struct sB
{
	sA mA;
	mediump mat3 mB;
	highp uvec2 mC;
};
struct sC
{
	bool mA;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	sB a;
};
layout(scalar, buffer_reference) buffer BlockC
{
	lowp vec4 b;
	uint8_t c[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	u8vec2 d;
	lowp mat3x4 e[4];
	highp uvec2 f;
	i8vec2 g;
	i8vec4 h;
};
layout(scalar, buffer_reference) buffer BlockE
{
	highp float i;
	sC j;
	bvec2 k;
	uint8_t l;
	highp uint m[6];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a.mA.mA), ivec4(7, -7, 0, -3)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.a.mA.mB), uvec2(3u, 4u)) && allOk;
	allOk = compare_mat2x3(blockB.a.mA.mC, mat2x3(3.0, 5.0, 0.0, 9.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3(blockB.a.mB, mat3(8.0, -8.0, -1.0, 7.0, -4.0, 6.0, -8.0, 8.0, -1.0)) && allOk;
	allOk = compare_uvec2((blockB.a.mC), uvec2(8u, 4u)) && allOk;
	allOk = compare_vec4((blockC.b), vec4(4.0, 6.0, 0.0, 6.0)) && allOk;
	allOk = compare_uint8_t(uint(blockC.c[0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(blockC.c[1]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockC.c[2]), 3u) && allOk;
	allOk = compare_uint8_t(uint(blockC.c[3]), 9u) && allOk;
	allOk = compare_uint8_t(uint(blockC.c[4]), 7u) && allOk;
	allOk = compare_uint8_t(uint(blockC.c[5]), 2u) && allOk;
	allOk = compare_uint8_t(uint(blockC.c[6]), 5u) && allOk;
	allOk = compare_uint8_t(uint(blockC.c[7]), 9u) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.d), uvec2(1u, 0u)) && allOk;
	allOk = compare_uvec2((blockD.f), uvec2(2u, 1u)) && allOk;
	allOk = compare_uint8_t(uint(blockE.l), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA.mA = (ivec4(5, 6, 1, -5));
	blockB.a.mA.mB = u8vec2(uvec2(6u, 0u));
	blockB.a.mA.mC = (mat2x3(4.0, 4.0, -5.0, -2.0, 5.0, 7.0));
	blockB.a.mB = (mat3(4.0, -3.0, -2.0, 5.0, 1.0, -2.0, 9.0, 7.0, -2.0));
	blockB.a.mC = (uvec2(4u, 5u));
	blockC.b = (vec4(9.0, 0.0, 5.0, 1.0));
	blockC.c[0] = uint8_t(1u);
	blockC.c[1] = uint8_t(2u);
	blockC.c[2] = uint8_t(8u);
	blockC.c[3] = uint8_t(5u);
	blockC.c[4] = uint8_t(7u);
	blockC.c[5] = uint8_t(9u);
	blockC.c[6] = uint8_t(7u);
	blockC.c[7] = uint8_t(5u);
	blockD.f = (uvec2(0u, 7u));
	blockD.g = i8vec2(ivec2(4294967289, 7));
	blockE.l = uint8_t(1u);
	blockE.m[0] = (2u);
	blockE.m[1] = (6u);
	blockE.m[2] = (3u);
	blockE.m[3] = (6u);
	blockE.m[4] = (1u);
	blockE.m[5] = (7u);
}
#version 450
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
	highp uvec3 a;
	uint8_t b;
	u8vec4 c;
	u8vec4 d;
	lowp mat4x2 e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	i8vec3 f[1];
	bool g;
	lowp ivec2 h;
	uint8_t i;
	i8vec4 j[][2];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	lowp mat3x4 k;
	i8vec2 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.b), 9u) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.d), uvec4(2u, 0u, 3u, 8u)) && allOk;
	allOk = compare_mat4x2(blockB.e[0], mat4x2(-6.0, -6.0, 4.0, 2.0, -1.0, 3.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockB.e[1], mat4x2(1.0, 9.0, 2.0, 4.0, -6.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockB.e[2], mat4x2(-6.0, -6.0, -2.0, -7.0, -7.0, -6.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockB.e[3], mat4x2(6.0, -1.0, 0.0, 0.0, -1.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockB.e[4], mat4x2(2.0, -2.0, 2.0, -4.0, 0.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockB.e[5], mat4x2(-8.0, 9.0, -3.0, 9.0, 7.0, -1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockB.e[6], mat4x2(4.0, -5.0, 8.0, 9.0, 2.0, -5.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockB.e[7], mat4x2(5.0, 4.0, -5.0, 3.0, -6.0, -6.0, 2.0, 8.0)) && allOk;
	allOk = compare_bool((blockC.g), true) && allOk;
	allOk = compare_ivec2((blockC.h), ivec2(6, -8)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.j[0][0]), ivec4(4294967287, 3, 4294967295, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.j[0][1]), ivec4(0, 7, 2, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.j[1][0]), ivec4(4294967290, 4294967287, 4294967293, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.j[1][1]), ivec4(4294967289, 2, 4294967291, 0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.j[2][0]), ivec4(7, 0, 4294967295, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.j[2][1]), ivec4(8, 2, 9, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.j[3][0]), ivec4(4294967290, 6, 4, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.j[3][1]), ivec4(6, 4294967295, 4294967287, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.j[4][0]), ivec4(4294967290, 4294967294, 2, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.j[4][1]), ivec4(3, 9, 4294967290, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.j[5][0]), ivec4(1, 4, 4, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.j[5][1]), ivec4(7, 1, 7, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.l[0]), ivec2(2, 4294967295)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.l[1]), ivec2(9, 4294967291)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.l[2]), ivec2(5, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.l[3]), ivec2(4294967290, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.l[4]), ivec2(6, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.l[5]), ivec2(7, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.e[0] = (mat4x2(9.0, 4.0, 4.0, -4.0, -8.0, -3.0, -5.0, -2.0));
	blockB.e[1] = (mat4x2(7.0, -6.0, -3.0, 2.0, -2.0, 3.0, -8.0, -4.0));
	blockB.e[2] = (mat4x2(-3.0, -5.0, 5.0, -9.0, 3.0, -8.0, 6.0, 5.0));
	blockB.e[3] = (mat4x2(-4.0, 3.0, -2.0, 1.0, 9.0, 7.0, 0.0, -6.0));
	blockB.e[4] = (mat4x2(5.0, 3.0, -2.0, 9.0, -3.0, 9.0, 7.0, -9.0));
	blockB.e[5] = (mat4x2(1.0, 2.0, -8.0, -9.0, 2.0, 2.0, 8.0, 4.0));
	blockB.e[6] = (mat4x2(4.0, 7.0, -3.0, -2.0, 6.0, -9.0, 9.0, -9.0));
	blockB.e[7] = (mat4x2(8.0, 4.0, 0.0, -1.0, -8.0, 7.0, 1.0, 9.0));
	blockC.f[0] = i8vec3(ivec3(1, 4294967291, 4294967294));
	blockC.g = (false);
	blockC.h = (ivec2(-2, 0));
	blockC.i = uint8_t(7u);
	blockD.l[0] = i8vec2(ivec2(3, 5));
	blockD.l[1] = i8vec2(ivec2(4, 2));
	blockD.l[2] = i8vec2(ivec2(4294967292, 2));
	blockD.l[3] = i8vec2(ivec2(4294967295, 4294967291));
	blockD.l[4] = i8vec2(ivec2(4294967293, 2));
	blockD.l[5] = i8vec2(ivec2(4294967290, 4294967289));
}
#version 450
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
	mediump uint a[3];
	mediump uvec4 b;
	i8vec4 c[][2];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.c[0][0]), ivec4(5, 2, 4294967293, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.c[0][1]), ivec4(8, 0, 3, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.c[1][0]), ivec4(2, 2, 4294967289, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.c[1][1]), ivec4(4294967294, 1, 4294967291, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.c[2][0]), ivec4(4294967290, 4294967294, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.c[2][1]), ivec4(4294967288, 4294967290, 4294967290, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.c[3][0]), ivec4(4294967291, 4294967292, 4294967288, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.c[3][1]), ivec4(4294967292, 4294967295, 9, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.c[4][0]), ivec4(7, 4294967287, 4294967292, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.c[4][1]), ivec4(7, 1, 3, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.c[5][0]), ivec4(4294967290, 2, 6, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.c[5][1]), ivec4(2, 1, 4294967288, 4294967292)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	i8vec2 a[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	mediump mat4x3 b;
	i8vec4 c;
	lowp mat3x2 d[][6];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB[0].a[0]), ivec2(4294967293, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[0].a[1]), ivec2(4294967288, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[0].a[2]), ivec2(5, 5)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[0].a[3]), ivec2(4294967292, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[0].a[4]), ivec2(4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[0].a[5]), ivec2(3, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = i8vec2(ivec2(4294967291, 5));
	blockB[0].a[1] = i8vec2(ivec2(4294967293, 3));
	blockB[0].a[2] = i8vec2(ivec2(2, 7));
	blockB[0].a[3] = i8vec2(ivec2(5, 9));
	blockB[0].a[4] = i8vec2(ivec2(4294967288, 4294967293));
	blockB[0].a[5] = i8vec2(ivec2(9, 6));
	blockC.b = (mat4x3(7.0, -4.0, -9.0, 3.0, 2.0, -2.0, -7.0, 7.0, 5.0, 0.0, -3.0, 4.0));
	blockC.d[0][0] = (mat3x2(2.0, -5.0, 2.0, 4.0, -8.0, 2.0));
	blockC.d[0][1] = (mat3x2(2.0, -7.0, -3.0, -3.0, -1.0, 8.0));
	blockC.d[0][2] = (mat3x2(-9.0, 6.0, -3.0, -5.0, 0.0, 3.0));
	blockC.d[0][3] = (mat3x2(4.0, 1.0, -9.0, 8.0, -5.0, -6.0));
	blockC.d[0][4] = (mat3x2(9.0, -9.0, 4.0, 4.0, -8.0, -8.0));
	blockC.d[0][5] = (mat3x2(3.0, 1.0, -4.0, 9.0, 6.0, -2.0));
	blockC.d[1][0] = (mat3x2(-2.0, 3.0, -5.0, 9.0, 9.0, -9.0));
	blockC.d[1][1] = (mat3x2(6.0, 0.0, -8.0, -8.0, 1.0, 3.0));
	blockC.d[1][2] = (mat3x2(-4.0, -2.0, -6.0, 7.0, 9.0, 5.0));
	blockC.d[1][3] = (mat3x2(-3.0, 7.0, -9.0, 9.0, 2.0, -8.0));
	blockC.d[1][4] = (mat3x2(7.0, -6.0, -8.0, 3.0, -6.0, 5.0));
	blockC.d[1][5] = (mat3x2(3.0, 4.0, 6.0, 0.0, -4.0, -2.0));
	blockC.d[2][0] = (mat3x2(-4.0, -9.0, 5.0, 0.0, -2.0, -4.0));
	blockC.d[2][1] = (mat3x2(3.0, 6.0, -8.0, 8.0, -4.0, 5.0));
	blockC.d[2][2] = (mat3x2(-3.0, -3.0, -2.0, -2.0, 8.0, -5.0));
	blockC.d[2][3] = (mat3x2(-2.0, 0.0, 4.0, -8.0, -8.0, -6.0));
	blockC.d[2][4] = (mat3x2(9.0, -5.0, 0.0, 5.0, 9.0, 1.0));
	blockC.d[2][5] = (mat3x2(-1.0, -4.0, 3.0, 2.0, 3.0, -8.0));
}
#version 450
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
	mediump vec2 a;
	mediump mat4 b;
	i8vec4 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].a), vec2(-8.0, -8.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(0)].c), ivec4(5, 4294967290, 5, 4294967287)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].a), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(1)].c), ivec4(4294967295, 5, 4294967287, 2)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].a), vec2(3.0, 2.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(2)].c), ivec4(2, 9, 4294967292, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec2(-2.0, -9.0));
	blockB[nonuniformEXT(0)].b = (mat4(-3.0, -1.0, -2.0, 7.0, -7.0, -6.0, -5.0, -9.0, 4.0, -6.0, 2.0, 6.0, 4.0, 6.0, -5.0, 2.0));
	blockB[nonuniformEXT(0)].c = i8vec4(ivec4(4294967287, 4294967288, 3, 6));
	blockB[nonuniformEXT(1)].a = (vec2(-6.0, 5.0));
	blockB[nonuniformEXT(1)].b = (mat4(6.0, -6.0, 3.0, 7.0, -8.0, -2.0, -6.0, -3.0, 0.0, 7.0, -1.0, -5.0, -8.0, 9.0, 7.0, -9.0));
	blockB[nonuniformEXT(1)].c = i8vec4(ivec4(4294967288, 4294967292, 0, 4294967293));
	blockB[nonuniformEXT(2)].a = (vec2(9.0, 9.0));
	blockB[nonuniformEXT(2)].b = (mat4(-2.0, 2.0, -6.0, 0.0, -6.0, -6.0, -4.0, -9.0, 4.0, -5.0, 8.0, 8.0, -3.0, -1.0, 2.0, -2.0));
	blockB[nonuniformEXT(2)].c = i8vec4(ivec4(2, 4294967295, 7, 4294967295));
}
#version 450
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
	layout(offset = 0) mediump mat3x4 a[1];
	layout(offset = 48) int8_t b;
	layout(offset = 64) mediump mat2x3 c;
	layout(offset = 96) bvec3 d;
	layout(offset = 112) lowp uvec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].a[0], mat3x4(1.0, 3.0, 9.0, -6.0, 1.0, -2.0, -8.0, -7.0, -4.0, -2.0, -4.0, -5.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(0)].d), bvec3(false, false, false)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].a[0], mat3x4(6.0, 7.0, -4.0, -4.0, 3.0, -2.0, -9.0, 9.0, -3.0, -9.0, -5.0, 8.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(1)].d), bvec3(true, false, true)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(2)].a[0], mat3x4(-1.0, -1.0, -6.0, 3.0, 9.0, 1.0, 6.0, 2.0, -4.0, 5.0, 7.0, 4.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(2)].d), bvec3(false, false, true)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(3)].a[0], mat3x4(-1.0, -7.0, 2.0, -1.0, 2.0, 7.0, -8.0, -3.0, 7.0, -1.0, 6.0, 0.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(3)].d), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (mat3x4(-1.0, -1.0, -1.0, 9.0, 5.0, 9.0, 5.0, -5.0, -6.0, -5.0, 9.0, 0.0));
	blockB[nonuniformEXT(0)].b = int8_t(6);
	blockB[nonuniformEXT(0)].c = (mat2x3(2.0, 7.0, 9.0, -4.0, -5.0, -1.0));
	blockB[nonuniformEXT(0)].d = (bvec3(false, false, true));
	blockB[nonuniformEXT(1)].a[0] = (mat3x4(3.0, 7.0, 6.0, 3.0, -4.0, -1.0, 6.0, 1.0, -3.0, -4.0, -9.0, -2.0));
	blockB[nonuniformEXT(1)].b = int8_t(1);
	blockB[nonuniformEXT(1)].c = (mat2x3(-8.0, 3.0, -8.0, 0.0, 2.0, 4.0));
	blockB[nonuniformEXT(1)].d = (bvec3(true, true, true));
	blockB[nonuniformEXT(2)].a[0] = (mat3x4(-6.0, 8.0, 1.0, -5.0, -1.0, -4.0, 5.0, 2.0, -9.0, 2.0, 2.0, 1.0));
	blockB[nonuniformEXT(2)].b = int8_t(4);
	blockB[nonuniformEXT(2)].c = (mat2x3(0.0, 7.0, 2.0, 0.0, -4.0, 0.0));
	blockB[nonuniformEXT(2)].d = (bvec3(true, true, true));
	blockB[nonuniformEXT(3)].a[0] = (mat3x4(4.0, 3.0, -3.0, 9.0, 7.0, -5.0, -9.0, 8.0, 5.0, -8.0, 2.0, 3.0));
	blockB[nonuniformEXT(3)].b = int8_t(4294967291);
	blockB[nonuniformEXT(3)].c = (mat2x3(2.0, -3.0, -6.0, 1.0, 5.0, -4.0));
	blockB[nonuniformEXT(3)].d = (bvec3(false, false, true));
}
