#version 450
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

	var = (mat2x3(4.0, 6.0, 6.0, 0.0, -9.0, 3.0));
}
#version 450
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[0][3], 7.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(0.0, -5.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-4.0, 3.0, -2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(-5.0, 7.0, 1.0, 2.0, 2.0, -6.0, -9.0, -1.0));
}
#version 450
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

	var = (mat4x2(-1.0, -4.0, 5.0, 9.0, -4.0, -2.0, 6.0, -6.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(7.0, -5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(-9.0, -8.0, -8.0, 9.0));
}
#version 450
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

	var = (mat4(-6.0, -3.0, -6.0, -5.0, -2.0, 8.0, -6.0, -2.0, -6.0, 7.0, 0.0, -1.0, 4.0, -8.0, 7.0, -1.0));
}
#version 450
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(-1.0, -1.0, 3.0, 5.0, 6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(-9.0, -1.0, -7.0, 6.0, 0.0, -8.0));
}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(6.0, 7.0, 5.0, -7.0, -7.0, -3.0, 8.0, 1.0, 2.0, 8.0, -1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(3.0, -7.0, -8.0, -2.0));
	var[1] = (vec4(6.0, 5.0, 7.0, 1.0));
	var[2] = (vec4(-9.0, -8.0, -7.0, -3.0));
}
#version 450
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
	lowp uvec3 var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 9u) && allOk;
	allOk = compare_uvec3((var), uvec3(0u, 0u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7u);
	var = (uvec3(4u, 8u, 4u));
}
#version 450
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
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-8.0, 5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(4.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0] = (vec2(-8.0, 0.0));
	var[1] = (vec2(-3.0, -8.0));
}
#version 450
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
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat4(var, mat4(-9.0, 1.0, 3.0, -2.0, -4.0, -7.0, -6.0, 1.0, 8.0, 9.0, 8.0, 8.0, 9.0, 8.0, 8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var = (mat4(9.0, 2.0, -9.0, -4.0, -9.0, -7.0, -7.0, -2.0, -7.0, -3.0, -4.0, 1.0, 0.0, -9.0, -3.0, -7.0));
}
#version 450
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(2.0, -5.0, -4.0, 3.0, -7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var[0] = (vec3(-2.0, 5.0, 0.0));
	var[1] = (vec3(0.0, 6.0, -6.0));
}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-9.0, -7.0, -3.0, -8.0, 1.0, 3.0, 0.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var = (mat2x4(-4.0, -4.0, 3.0, -5.0, 0.0, -8.0, -4.0, -1.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(5.0, 9.0, -2.0, -3.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var[0] = (vec2(9.0, -8.0));
	var[1] = (vec2(2.0, 3.0));
	var[2] = (vec2(6.0, 4.0));
}
#version 450
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
	bool var[3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((var[0]), false) && allOk;
	allOk = compare_bool((var[1]), true) && allOk;
	allOk = compare_bool((var[2]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (false);
	var[1] = (false);
	var[2] = (true);
}
#version 450
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
	f16vec4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var[0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	var[1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	var[2] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
}
#version 450
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	var[1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	var[2] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
}
#version 450
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
	allOk = compare_mat3x4(var[0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	var[1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	var[2] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
}
#version 450
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
	uint8_t var[3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(var[0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[2]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = uint8_t(9u);
	var[1] = uint8_t(5u);
	var[2] = uint8_t(2u);
}
#version 450
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
	highp float var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_float((var[0]), -1.0) && allOk;
	allOk = compare_float((var[1]), -6.0) && allOk;
	allOk = compare_float((var[2]), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0] = (4.0);
	var[1] = (6.0);
	var[2] = (7.0);
}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat2(var[0], mat2(3.0, -8.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(5.0, 4.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(2.0, -7.0, 4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0] = (mat2(4.0, 4.0, -1.0, 2.0));
	var[1] = (mat2(-5.0, 1.0, -1.0, -2.0));
	var[2] = (mat2(-9.0, -3.0, -8.0, -6.0));
}
#version 450
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (8.0);
	var[0][0] = (vec4(8.0, -2.0, 8.0, 8.0));
	var[0][1] = (vec4(3.0, 5.0, -5.0, 7.0));
	var[0][2] = (vec4(6.0, -9.0, 3.0, 0.0));
	var[1][0] = (vec4(-3.0, 1.0, -9.0, -9.0));
	var[1][1] = (vec4(-6.0, -5.0, 1.0, 9.0));
	var[1][2] = (vec4(0.0, -9.0, -2.0, -4.0));
	var[2][0] = (vec4(-3.0, -1.0, -6.0, 1.0));
	var[2][1] = (vec4(-2.0, -2.0, -1.0, -7.0));
	var[2][2] = (vec4(8.0, 0.0, -6.0, -1.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	highp mat3x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[3], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-5.0, -1.0, -4.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(1.0, -6.0, -3.0, -3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(1.0, 7.0, 5.0, -5.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(-8.0, -9.0, 7.0, 4.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(8.0, -6.0, -5.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(3.0, 2.0, -1.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(-1.0, 2.0, -7.0, 2.0, -8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	var[1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	var[2] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	var[3] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	var[4] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	var[5] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	var[6] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	var[7] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	var[8] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	var[9] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	var[10] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	var[11] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
	var[12] = (mat3x2(-6.0, -4.0, 8.0, 4.0, 5.0, 4.0));
	var[13] = (mat3x2(8.0, 3.0, 9.0, -4.0, -3.0, -6.0));
	var[14] = (mat3x2(-9.0, 8.0, 6.0, -7.0, 9.0, 2.0));
	var[15] = (mat3x2(-2.0, -3.0, -2.0, -4.0, 5.0, -4.0));
	var[16] = (mat3x2(9.0, -9.0, -9.0, -6.0, 8.0, 1.0));
	var[17] = (mat3x2(4.0, -2.0, 0.0, -9.0, 4.0, -2.0));
	var[18] = (mat3x2(3.0, 2.0, 8.0, -9.0, -3.0, -7.0));
}
#version 450
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

	var[0] = f16vec2(vec2(-2.0, 4.0));
	var[1] = f16vec2(vec2(-2.0, 4.0));
	var[2] = f16vec2(vec2(-1.0, 1.0));
	var[3] = f16vec2(vec2(9.0, 4.0));
	var[4] = f16vec2(vec2(8.0, -8.0));
	var[5] = f16vec2(vec2(1.0, -3.0));
	var[6] = f16vec2(vec2(2.0, 2.0));
	var[7] = f16vec2(vec2(-6.0, 5.0));
	var[8] = f16vec2(vec2(5.0, -7.0));
	var[9] = f16vec2(vec2(3.0, 0.0));
	var[10] = f16vec2(vec2(-2.0, 3.0));
	var[11] = f16vec2(vec2(-6.0, 5.0));
	var[12] = f16vec2(vec2(6.0, 0.0));
	var[13] = f16vec2(vec2(3.0, 5.0));
	var[14] = f16vec2(vec2(9.0, -9.0));
	var[15] = f16vec2(vec2(-6.0, 7.0));
	var[16] = f16vec2(vec2(3.0, -7.0));
	var[17] = f16vec2(vec2(4.0, -5.0));
	var[18] = f16vec2(vec2(7.0, -6.0));
}
#version 450
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

	var[0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	var[1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	var[2] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
	var[3] = (mat4(2.0, 3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0));
	var[4] = (mat4(-4.0, -1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0));
	var[5] = (mat4(-5.0, -1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0));
	var[6] = (mat4(3.0, 6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0));
	var[7] = (mat4(1.0, 2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0));
	var[8] = (mat4(2.0, 4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0));
	var[9] = (mat4(8.0, 9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0));
	var[10] = (mat4(-8.0, 6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0));
	var[11] = (mat4(-2.0, 0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0));
	var[12] = (mat4(5.0, 1.0, 7.0, 8.0, 0.0, -3.0, 8.0, 5.0, -2.0, -2.0, -1.0, -2.0, 4.0, -6.0, 1.0, 5.0));
	var[13] = (mat4(-1.0, 8.0, 6.0, 8.0, -7.0, -4.0, -5.0, -8.0, 5.0, 0.0, 7.0, -8.0, 8.0, -2.0, 6.0, 5.0));
	var[14] = (mat4(2.0, 8.0, -1.0, 1.0, -9.0, -1.0, 9.0, -4.0, 9.0, 4.0, -2.0, 9.0, 6.0, 7.0, 1.0, 3.0));
	var[15] = (mat4(-7.0, -5.0, 2.0, -5.0, 8.0, -5.0, -6.0, 3.0, -5.0, -8.0, 1.0, -1.0, 1.0, 2.0, -5.0, 3.0));
	var[16] = (mat4(7.0, 2.0, 8.0, -4.0, -1.0, 2.0, 4.0, 1.0, 9.0, 7.0, -6.0, 7.0, 7.0, -5.0, 0.0, 3.0));
	var[17] = (mat4(-4.0, -1.0, -2.0, -3.0, 6.0, 2.0, 7.0, 0.0, 3.0, 4.0, -4.0, 2.0, 8.0, -4.0, 7.0, -4.0));
	var[18] = (mat4(-2.0, -1.0, 8.0, 8.0, -9.0, 9.0, 6.0, -1.0, 3.0, -9.0, -4.0, -6.0, -2.0, 6.0, -7.0, 3.0));
}
#version 450
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
	highp mat3x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3], mat3x2(-2.0, -1.0, 5.0, 2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(9.0, -5.0, 7.0, 6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(-1.0, -4.0, 0.0, -2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(7.0, 3.0, -1.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(-8.0, -5.0, 9.0, -3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(-4.0, 6.0, -7.0, 0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(-9.0, 0.0, 9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(-7.0, -5.0, 3.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-3.0, -2.0, 3.0, -8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-4.0, -8.0, -7.0, -9.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(-1.0, -4.0, -4.0, 6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(-8.0, 8.0, -4.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(-3.0, -7.0, -5.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(0.0, -8.0, -1.0, 9.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(-7.0, -9.0, 6.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(0.0, 9.0, -1.0, -2.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(9.0, -4.0));
	var[0][1] = (vec2(-7.0, 8.0));
	var[0][2] = (vec2(-2.0, -9.0));
	var[1][0] = (vec2(-1.0, 7.0));
	var[1][1] = (vec2(-3.0, -3.0));
	var[1][2] = (vec2(-8.0, 2.0));
	var[2][0] = (vec2(-2.0, -1.0));
	var[2][1] = (vec2(-3.0, -3.0));
	var[2][2] = (vec2(-4.0, 5.0));
	var[3][0] = (vec2(9.0, 7.0));
	var[3][1] = (vec2(-4.0, 7.0));
	var[3][2] = (vec2(1.0, 6.0));
	var[4][0] = (vec2(-8.0, 9.0));
	var[4][1] = (vec2(8.0, 1.0));
	var[4][2] = (vec2(6.0, 8.0));
	var[5][0] = (vec2(-1.0, 2.0));
	var[5][1] = (vec2(1.0, -1.0));
	var[5][2] = (vec2(0.0, 3.0));
	var[6][0] = (vec2(-3.0, -2.0));
	var[6][1] = (vec2(-9.0, -8.0));
	var[6][2] = (vec2(-8.0, 4.0));
	var[7][0] = (vec2(-2.0, 9.0));
	var[7][1] = (vec2(-1.0, 3.0));
	var[7][2] = (vec2(-2.0, 9.0));
	var[8][0] = (vec2(-2.0, -4.0));
	var[8][1] = (vec2(-1.0, 9.0));
	var[8][2] = (vec2(-9.0, -4.0));
	var[9][0] = (vec2(-3.0, -2.0));
	var[9][1] = (vec2(7.0, -5.0));
	var[9][2] = (vec2(-5.0, 0.0));
	var[10][0] = (vec2(4.0, -4.0));
	var[10][1] = (vec2(5.0, 5.0));
	var[10][2] = (vec2(2.0, -3.0));
	var[11][0] = (vec2(-5.0, -3.0));
	var[11][1] = (vec2(-7.0, 6.0));
	var[11][2] = (vec2(-6.0, 8.0));
	var[12][0] = (vec2(9.0, 4.0));
	var[12][1] = (vec2(-8.0, -6.0));
	var[12][2] = (vec2(4.0, -6.0));
	var[13][0] = (vec2(-9.0, -3.0));
	var[13][1] = (vec2(8.0, 9.0));
	var[13][2] = (vec2(4.0, -8.0));
	var[14][0] = (vec2(0.0, -4.0));
	var[14][1] = (vec2(6.0, -1.0));
	var[14][2] = (vec2(-7.0, 8.0));
	var[15][0] = (vec2(4.0, 2.0));
	var[15][1] = (vec2(2.0, -3.0));
	var[15][2] = (vec2(1.0, -6.0));
	var[16][0] = (vec2(7.0, 3.0));
	var[16][1] = (vec2(-7.0, 5.0));
	var[16][2] = (vec2(2.0, -9.0));
	var[17][0] = (vec2(-2.0, -8.0));
	var[17][1] = (vec2(-9.0, 5.0));
	var[17][2] = (vec2(-2.0, 1.0));
	var[18][0] = (vec2(2.0, -5.0));
	var[18][1] = (vec2(2.0, 8.0));
	var[18][2] = (vec2(1.0, 5.0));
}
#version 450
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
	allOk = compare_mat3x4(var[0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[3], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(6.0, 7.0, 9.0, 7.0, 0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(7.0, -7.0, 1.0, 0.0, -9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(0.0, 8.0, -8.0, -9.0, 5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(9.0, -4.0, -6.0, 0.0, 0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(5.0, 2.0, -1.0, 1.0, 1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(-5.0, 1.0, 4.0, 5.0, 5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(-2.0, -2.0, 7.0, -9.0, 3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0)) && allOk;
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
	var[3][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	var[3][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	var[3][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	var[4][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	var[4][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	var[4][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	var[5][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	var[5][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	var[5][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	var[6][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	var[6][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	var[6][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	var[7][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	var[7][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	var[7][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	var[8][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	var[8][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	var[8][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	var[9][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	var[9][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	var[9][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	var[10][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	var[10][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	var[10][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	var[11][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	var[11][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	var[11][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
	var[12][0] = (vec4(6.0, 2.0, 8.0, -5.0));
	var[12][1] = (vec4(9.0, 5.0, 9.0, -1.0));
	var[12][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[13][0] = (vec4(0.0, -4.0, 7.0, 1.0));
	var[13][1] = (vec4(4.0, 1.0, 9.0, 9.0));
	var[13][2] = (vec4(-9.0, -5.0, 3.0, 8.0));
	var[14][0] = (vec4(4.0, -1.0, -2.0, 2.0));
	var[14][1] = (vec4(-5.0, 4.0, -2.0, -4.0));
	var[14][2] = (vec4(8.0, -7.0, -1.0, -9.0));
	var[15][0] = (vec4(8.0, 5.0, 3.0, 6.0));
	var[15][1] = (vec4(0.0, 6.0, 0.0, 2.0));
	var[15][2] = (vec4(-1.0, -5.0, -6.0, -4.0));
	var[16][0] = (vec4(-3.0, -5.0, -4.0, -4.0));
	var[16][1] = (vec4(-8.0, -8.0, 1.0, 7.0));
	var[16][2] = (vec4(-6.0, -3.0, -7.0, 1.0));
	var[17][0] = (vec4(-5.0, 5.0, 0.0, 1.0));
	var[17][1] = (vec4(6.0, 2.0, 5.0, 5.0));
	var[17][2] = (vec4(5.0, -1.0, -7.0, -1.0));
	var[18][0] = (vec4(1.0, -1.0, -4.0, 2.0));
	var[18][1] = (vec4(5.0, 8.0, 5.0, -9.0));
	var[18][2] = (vec4(7.0, -9.0, 0.0, -3.0));
}
#version 450
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
	i8vec3 var[];
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(var[0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2]), ivec3(7, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3]), ivec3(5, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[4]), ivec3(9, 0, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(var[5]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[6]), ivec3(4294967289, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[7]), ivec3(8, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[8]), ivec3(2, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(var[9]), ivec3(1, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[10]), ivec3(9, 7, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(var[11]), ivec3(2, 4294967294, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(var[12]), ivec3(7, 1, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[13]), ivec3(4294967294, 5, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(var[14]), ivec3(4294967295, 1, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(var[15]), ivec3(4294967292, 7, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(var[16]), ivec3(4294967290, 4294967291, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[17]), ivec3(9, 4294967290, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(var[18]), ivec3(1, 4294967293, 4294967294)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = i8vec3(ivec3(4294967292, 0, 0));
	var[1] = i8vec3(ivec3(7, 9, 4294967290));
	var[2] = i8vec3(ivec3(4294967288, 9, 4294967288));
	var[3] = i8vec3(ivec3(4294967293, 3, 4294967295));
	var[4] = i8vec3(ivec3(9, 7, 5));
	var[5] = i8vec3(ivec3(5, 4294967293, 6));
	var[6] = i8vec3(ivec3(4294967293, 4294967295, 3));
	var[7] = i8vec3(ivec3(5, 4294967292, 4294967295));
	var[8] = i8vec3(ivec3(4294967293, 8, 4294967290));
	var[9] = i8vec3(ivec3(3, 7, 4));
	var[10] = i8vec3(ivec3(4294967292, 8, 8));
	var[11] = i8vec3(ivec3(4294967294, 8, 1));
	var[12] = i8vec3(ivec3(7, 4294967293, 7));
	var[13] = i8vec3(ivec3(4294967293, 4294967288, 2));
	var[14] = i8vec3(ivec3(4294967287, 4294967295, 4294967293));
	var[15] = i8vec3(ivec3(4294967292, 4294967290, 4294967295));
	var[16] = i8vec3(ivec3(4294967287, 1, 4294967288));
	var[17] = i8vec3(ivec3(4294967291, 8, 6));
	var[18] = i8vec3(ivec3(4294967288, 4, 8));
}
#version 450
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
	f16vec3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(var[0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2]), vec3(4.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3]), vec3(4.0, 4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[4]), vec3(2.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[5]), vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[6]), vec3(1.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[7]), vec3(-7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[8]), vec3(-8.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[9]), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[10]), vec3(-4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[11]), vec3(-8.0, 6.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[12]), vec3(-1.0, -7.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[13]), vec3(2.0, 6.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[14]), vec3(-5.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[15]), vec3(5.0, 4.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[16]), vec3(6.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[17]), vec3(6.0, -8.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[18]), vec3(8.0, 2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = f16vec3(vec3(3.0, 3.0, 7.0));
	var[1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	var[2] = f16vec3(vec3(-1.0, 0.0, 6.0));
	var[3] = f16vec3(vec3(5.0, -7.0, 2.0));
	var[4] = f16vec3(vec3(9.0, 1.0, -5.0));
	var[5] = f16vec3(vec3(-5.0, 5.0, 2.0));
	var[6] = f16vec3(vec3(-5.0, -4.0, 6.0));
	var[7] = f16vec3(vec3(-3.0, -7.0, -4.0));
	var[8] = f16vec3(vec3(-4.0, 5.0, 0.0));
	var[9] = f16vec3(vec3(-6.0, 4.0, -1.0));
	var[10] = f16vec3(vec3(-2.0, 3.0, -8.0));
	var[11] = f16vec3(vec3(-4.0, -2.0, 4.0));
	var[12] = f16vec3(vec3(6.0, 6.0, -6.0));
	var[13] = f16vec3(vec3(-3.0, 1.0, -5.0));
	var[14] = f16vec3(vec3(6.0, 9.0, 7.0));
	var[15] = f16vec3(vec3(2.0, 5.0, 3.0));
	var[16] = f16vec3(vec3(9.0, -8.0, 2.0));
	var[17] = f16vec3(vec3(-7.0, -8.0, -3.0));
	var[18] = f16vec3(vec3(2.0, -5.0, -9.0));
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(-2.0, -1.0, 5.0, 2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(9.0, -5.0, 7.0, 6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(-1.0, -4.0, 0.0, -2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(7.0, 3.0, -1.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(-8.0, -5.0, 9.0, -3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(-4.0, 6.0, -7.0, 0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(-9.0, 0.0, 9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(-7.0, -5.0, 3.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-3.0, -2.0, 3.0, -8.0, 4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(9.0, -4.0));
	var[0][0][1] = (vec2(-7.0, 8.0));
	var[0][0][2] = (vec2(-2.0, -9.0));
	var[0][1][0] = (vec2(-1.0, 7.0));
	var[0][1][1] = (vec2(-3.0, -3.0));
	var[0][1][2] = (vec2(-8.0, 2.0));
	var[0][2][0] = (vec2(-2.0, -1.0));
	var[0][2][1] = (vec2(-3.0, -3.0));
	var[0][2][2] = (vec2(-4.0, 5.0));
	var[1][0][0] = (vec2(9.0, 7.0));
	var[1][0][1] = (vec2(-4.0, 7.0));
	var[1][0][2] = (vec2(1.0, 6.0));
	var[1][1][0] = (vec2(-8.0, 9.0));
	var[1][1][1] = (vec2(8.0, 1.0));
	var[1][1][2] = (vec2(6.0, 8.0));
	var[1][2][0] = (vec2(-1.0, 2.0));
	var[1][2][1] = (vec2(1.0, -1.0));
	var[1][2][2] = (vec2(0.0, 3.0));
	var[2][0][0] = (vec2(-3.0, -2.0));
	var[2][0][1] = (vec2(-9.0, -8.0));
	var[2][0][2] = (vec2(-8.0, 4.0));
	var[2][1][0] = (vec2(-2.0, 9.0));
	var[2][1][1] = (vec2(-1.0, 3.0));
	var[2][1][2] = (vec2(-2.0, 9.0));
	var[2][2][0] = (vec2(-2.0, -4.0));
	var[2][2][1] = (vec2(-1.0, 9.0));
	var[2][2][2] = (vec2(-9.0, -4.0));
	var[3][0][0] = (vec2(-3.0, -2.0));
	var[3][0][1] = (vec2(7.0, -5.0));
	var[3][0][2] = (vec2(-5.0, 0.0));
	var[3][1][0] = (vec2(4.0, -4.0));
	var[3][1][1] = (vec2(5.0, 5.0));
	var[3][1][2] = (vec2(2.0, -3.0));
	var[3][2][0] = (vec2(-5.0, -3.0));
	var[3][2][1] = (vec2(-7.0, 6.0));
	var[3][2][2] = (vec2(-6.0, 8.0));
}
#version 450
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
	allOk = compare_mat3x2(var[0][0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(1.0, 1.0, -3.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(2.0, 8.0, 7.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(-4.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(8.0, -8.0, -7.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(3.0, 9.0, -2.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(-3.0, 9.0, 6.0, 2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(7.0, 1.0, 1.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(2.0, 7.0, -2.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-8.0, -1.0, -7.0, 9.0, 5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	var[0][1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	var[0][2] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
	var[1][0] = (mat3x2(2.0, 1.0, -5.0, 0.0, -3.0, 1.0));
	var[1][1] = (mat3x2(-4.0, 4.0, 5.0, -5.0, -6.0, 3.0));
	var[1][2] = (mat3x2(1.0, -2.0, 3.0, -8.0, -6.0, 2.0));
	var[2][0] = (mat3x2(-5.0, -4.0, -8.0, 9.0, -9.0, -8.0));
	var[2][1] = (mat3x2(8.0, -4.0, 1.0, -1.0, 7.0, 0.0));
	var[2][2] = (mat3x2(1.0, -3.0, 6.0, -4.0, -6.0, -5.0));
	var[3][0] = (mat3x2(-6.0, -4.0, 6.0, 4.0, 2.0, -8.0));
	var[3][1] = (mat3x2(2.0, 1.0, -3.0, -3.0, -5.0, -1.0));
	var[3][2] = (mat3x2(6.0, 9.0, 9.0, 9.0, -4.0, 8.0));
}
#version 450
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
	highp mat2x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(3.0, 9.0, -7.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(6.0, 5.0, -8.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(-2.0, -2.0, 2.0, 9.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-5.0, -3.0, -1.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(9.0, 2.0, -2.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(9.0, -1.0, -8.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(9.0, -9.0, -8.0, -9.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-5.0, -6.0, -2.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(-4.0, -4.0, 3.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(-6.0, -8.0, 0.0, -1.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(-4.0, 8.0, 6.0, -2.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(-8.0, 8.0, 5.0, -5.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(1.0, -1.0, 1.0));
	var[0][0][0][1] = (vec3(-3.0, 9.0, -8.0));
	var[0][0][1][0] = (vec3(-5.0, 6.0, 6.0));
	var[0][0][1][1] = (vec3(3.0, -3.0, 7.0));
	var[0][0][2][0] = (vec3(-9.0, -2.0, -7.0));
	var[0][0][2][1] = (vec3(7.0, 0.0, -8.0));
	var[0][1][0][0] = (vec3(0.0, 9.0, -7.0));
	var[0][1][0][1] = (vec3(5.0, 6.0, -3.0));
	var[0][1][1][0] = (vec3(-6.0, 0.0, -3.0));
	var[0][1][1][1] = (vec3(7.0, 9.0, -2.0));
	var[0][1][2][0] = (vec3(-7.0, 6.0, -7.0));
	var[0][1][2][1] = (vec3(8.0, -6.0, 8.0));
	var[1][0][0][0] = (vec3(0.0, -5.0, 5.0));
	var[1][0][0][1] = (vec3(-2.0, 4.0, -8.0));
	var[1][0][1][0] = (vec3(-3.0, -4.0, 7.0));
	var[1][0][1][1] = (vec3(-3.0, -1.0, -9.0));
	var[1][0][2][0] = (vec3(2.0, -3.0, 6.0));
	var[1][0][2][1] = (vec3(-4.0, 8.0, 2.0));
	var[1][1][0][0] = (vec3(4.0, -8.0, 4.0));
	var[1][1][0][1] = (vec3(4.0, 5.0, 5.0));
	var[1][1][1][0] = (vec3(2.0, 3.0, 6.0));
	var[1][1][1][1] = (vec3(-4.0, -4.0, -1.0));
	var[1][1][2][0] = (vec3(-3.0, -1.0, -1.0));
	var[1][1][2][1] = (vec3(6.0, 2.0, 2.0));
	var[2][0][0][0] = (vec3(6.0, -2.0, 0.0));
	var[2][0][0][1] = (vec3(3.0, 4.0, -6.0));
	var[2][0][1][0] = (vec3(3.0, -6.0, 2.0));
	var[2][0][1][1] = (vec3(4.0, -8.0, 0.0));
	var[2][0][2][0] = (vec3(-3.0, 3.0, 5.0));
	var[2][0][2][1] = (vec3(-6.0, -8.0, 8.0));
	var[2][1][0][0] = (vec3(5.0, -2.0, -1.0));
	var[2][1][0][1] = (vec3(7.0, -7.0, 5.0));
	var[2][1][1][0] = (vec3(-3.0, 6.0, 7.0));
	var[2][1][1][1] = (vec3(6.0, -5.0, -2.0));
	var[2][1][2][0] = (vec3(2.0, -1.0, 2.0));
	var[2][1][2][1] = (vec3(-3.0, 6.0, -3.0));
	var[3][0][0][0] = (vec3(4.0, -9.0, -1.0));
	var[3][0][0][1] = (vec3(-6.0, 7.0, -3.0));
	var[3][0][1][0] = (vec3(2.0, -2.0, 4.0));
	var[3][0][1][1] = (vec3(-3.0, -5.0, 9.0));
	var[3][0][2][0] = (vec3(-8.0, -1.0, 7.0));
	var[3][0][2][1] = (vec3(2.0, 0.0, 5.0));
	var[3][1][0][0] = (vec3(-2.0, 0.0, -6.0));
	var[3][1][0][1] = (vec3(2.0, -7.0, -2.0));
	var[3][1][1][0] = (vec3(1.0, -8.0, -3.0));
	var[3][1][1][1] = (vec3(7.0, 3.0, 1.0));
	var[3][1][2][0] = (vec3(2.0, -8.0, 6.0));
	var[3][1][2][1] = (vec3(-8.0, -7.0, 0.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	highp vec4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var[0][0][0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((var[0][0][1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((var[0][0][2]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((var[0][1][0]), vec4(-1.0, 3.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((var[0][1][1]), vec4(9.0, 1.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4((var[0][1][2]), vec4(0.0, 6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4((var[1][0][0]), vec4(-3.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4((var[1][0][1]), vec4(-1.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[1][0][2]), vec4(7.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[1][1][0]), vec4(6.0, -7.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((var[1][1][1]), vec4(8.0, -6.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec4((var[1][1][2]), vec4(5.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec4((var[2][0][0]), vec4(6.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((var[2][0][1]), vec4(8.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((var[2][0][2]), vec4(-7.0, 2.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((var[2][1][0]), vec4(6.0, -4.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec4((var[2][1][1]), vec4(-2.0, 7.0, -3.0, -4.0)) && allOk;
	allOk = compare_vec4((var[2][1][2]), vec4(-2.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec4((var[3][0][0]), vec4(-1.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((var[3][0][1]), vec4(8.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((var[3][0][2]), vec4(3.0, -4.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4((var[3][1][0]), vec4(3.0, -9.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4((var[3][1][1]), vec4(5.0, -9.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4((var[3][1][2]), vec4(-6.0, -9.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	var[0][0][1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	var[0][0][2] = (vec4(5.0, -9.0, 4.0, -1.0));
	var[0][1][0] = (vec4(1.0, 7.0, 1.0, 1.0));
	var[0][1][1] = (vec4(-7.0, -6.0, -7.0, -4.0));
	var[0][1][2] = (vec4(8.0, -1.0, -6.0, -8.0));
	var[1][0][0] = (vec4(-7.0, -6.0, -2.0, -8.0));
	var[1][0][1] = (vec4(8.0, 7.0, 5.0, 1.0));
	var[1][0][2] = (vec4(-6.0, -5.0, -8.0, 8.0));
	var[1][1][0] = (vec4(9.0, 7.0, -3.0, -8.0));
	var[1][1][1] = (vec4(-3.0, -9.0, 2.0, 1.0));
	var[1][1][2] = (vec4(-7.0, 3.0, -5.0, 8.0));
	var[2][0][0] = (vec4(0.0, 8.0, 4.0, -4.0));
	var[2][0][1] = (vec4(-8.0, -3.0, 9.0, -7.0));
	var[2][0][2] = (vec4(-9.0, 2.0, -6.0, 6.0));
	var[2][1][0] = (vec4(5.0, -4.0, -5.0, 6.0));
	var[2][1][1] = (vec4(0.0, -2.0, -8.0, 7.0));
	var[2][1][2] = (vec4(0.0, -7.0, -2.0, -7.0));
	var[3][0][0] = (vec4(6.0, 2.0, -3.0, 0.0));
	var[3][0][1] = (vec4(-9.0, 8.0, -8.0, 0.0));
	var[3][0][2] = (vec4(2.0, 6.0, 6.0, 1.0));
	var[3][1][0] = (vec4(3.0, -8.0, 1.0, 6.0));
	var[3][1][1] = (vec4(0.0, 5.0, -3.0, -2.0));
	var[3][1][2] = (vec4(-9.0, -7.0, 2.0, -7.0));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-4.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(-2.0, -6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-1.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(4.0, 1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(7.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(3.0, 4.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-5.0, -9.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(-2.0, -8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(0.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-6.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(-9.0, -1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-7.0, 6.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(-4.0, 9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(-9.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(4.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(8.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(9.0, -2.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(-3.0, 0.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(0.0, 1.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(7.0, -3.0));
	var[0][0][0][1] = (vec2(-2.0, 4.0));
	var[0][0][1][0] = (vec2(1.0, -3.0));
	var[0][0][1][1] = (vec2(2.0, -4.0));
	var[0][0][2][0] = (vec2(-1.0, 1.0));
	var[0][0][2][1] = (vec2(-4.0, 3.0));
	var[0][1][0][0] = (vec2(-5.0, 8.0));
	var[0][1][0][1] = (vec2(3.0, 1.0));
	var[0][1][1][0] = (vec2(-9.0, 7.0));
	var[0][1][1][1] = (vec2(7.0, 1.0));
	var[0][1][2][0] = (vec2(-3.0, -9.0));
	var[0][1][2][1] = (vec2(-7.0, 1.0));
	var[1][0][0][0] = (vec2(7.0, -7.0));
	var[1][0][0][1] = (vec2(2.0, 5.0));
	var[1][0][1][0] = (vec2(-8.0, 4.0));
	var[1][0][1][1] = (vec2(8.0, 1.0));
	var[1][0][2][0] = (vec2(4.0, 6.0));
	var[1][0][2][1] = (vec2(-9.0, 9.0));
	var[1][1][0][0] = (vec2(-7.0, 6.0));
	var[1][1][0][1] = (vec2(2.0, -5.0));
	var[1][1][1][0] = (vec2(6.0, -3.0));
	var[1][1][1][1] = (vec2(-5.0, -6.0));
	var[1][1][2][0] = (vec2(-3.0, 7.0));
	var[1][1][2][1] = (vec2(9.0, 6.0));
	var[2][0][0][0] = (vec2(1.0, 5.0));
	var[2][0][0][1] = (vec2(9.0, -6.0));
	var[2][0][1][0] = (vec2(-7.0, 5.0));
	var[2][0][1][1] = (vec2(7.0, 4.0));
	var[2][0][2][0] = (vec2(7.0, -9.0));
	var[2][0][2][1] = (vec2(0.0, 6.0));
	var[2][1][0][0] = (vec2(-8.0, 7.0));
	var[2][1][0][1] = (vec2(0.0, 2.0));
	var[2][1][1][0] = (vec2(-7.0, -7.0));
	var[2][1][1][1] = (vec2(5.0, -3.0));
	var[2][1][2][0] = (vec2(-1.0, -1.0));
	var[2][1][2][1] = (vec2(1.0, 1.0));
	var[3][0][0][0] = (vec2(-1.0, -7.0));
	var[3][0][0][1] = (vec2(-8.0, 4.0));
	var[3][0][1][0] = (vec2(5.0, 6.0));
	var[3][0][1][1] = (vec2(-7.0, 7.0));
	var[3][0][2][0] = (vec2(-1.0, -5.0));
	var[3][0][2][1] = (vec2(9.0, -7.0));
	var[3][1][0][0] = (vec2(7.0, 1.0));
	var[3][1][0][1] = (vec2(2.0, -8.0));
	var[3][1][1][0] = (vec2(-1.0, 1.0));
	var[3][1][1][1] = (vec2(2.0, -4.0));
	var[3][1][2][0] = (vec2(-9.0, -4.0));
	var[3][1][2][1] = (vec2(7.0, 0.0));
}
#version 450
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
	allOk = compare_mat3x4(var[0][0][0], mat3x4(5.0, -7.0, -9.0, 4.0, 5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-9.0, 7.0, -4.0, 5.0, -9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(4.0, 1.0, 3.0, -1.0, -3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-3.0, -7.0, 5.0, 2.0, -5.0, 9.0, -1.0, -1.0, 1.0, -7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(2.0, 0.0, 8.0, -9.0, 5.0, -4.0, 5.0, -7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(3.0, 6.0, -3.0, 3.0, 9.0, -1.0, -3.0, 6.0, -9.0, 9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(5.0, 1.0, -8.0, -9.0, -6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-3.0, 6.0, 3.0, 0.0, -4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(-1.0, 6.0, 5.0, -4.0, -5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-2.0, 8.0, 5.0, -9.0, 0.0, -8.0, 8.0, -8.0, 6.0, -2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-5.0, -3.0, 9.0, 7.0, 1.0, -1.0, -8.0, -6.0, 5.0, 0.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(5.0, -7.0, -3.0, -7.0, 3.0, 9.0, -6.0, -7.0, -4.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(2.0, 3.0, 2.0, 5.0, -4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-3.0, 3.0, -2.0, 6.0, 9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(1.0, -2.0, 4.0, 2.0, 7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(3.0, 5.0, -2.0, -6.0, -7.0, -4.0, 6.0, 5.0, -9.0, 2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(3.0, 3.0, 4.0, -2.0, -8.0, -6.0, -3.0, -8.0, 4.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(3.0, -8.0, -9.0, 5.0, -7.0, 3.0, -2.0, -7.0, 6.0, 6.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(6.0, -8.0, 1.0, 3.0, 2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(-8.0, 4.0, 3.0, 2.0, 2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(2.0, 0.0, -3.0, 3.0, -7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(1.0, -4.0, -8.0, 8.0, -6.0, -1.0, -5.0, -2.0, -6.0, 4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(0.0, 9.0, 4.0, 8.0, 4.0, -1.0, 1.0, -2.0, -5.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(-8.0, -6.0, -8.0, -9.0, -5.0, -1.0, 6.0, 9.0, -6.0, -3.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	var[0][0][1] = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	var[0][0][2] = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
	var[0][1][0] = (mat3x4(-3.0, -3.0, -1.0, -2.0, 7.0, 1.0, 7.0, 0.0, -9.0, 2.0, -2.0, -6.0));
	var[0][1][1] = (mat3x4(4.0, -5.0, -8.0, -9.0, 4.0, 2.0, -1.0, -3.0, 9.0, -6.0, -9.0, -8.0));
	var[0][1][2] = (mat3x4(7.0, 6.0, -3.0, -6.0, -1.0, 2.0, 7.0, -9.0, -3.0, -4.0, -1.0, 0.0));
	var[1][0][0] = (mat3x4(0.0, -2.0, -8.0, -5.0, 0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0));
	var[1][0][1] = (mat3x4(-1.0, 7.0, 7.0, 7.0, 2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0));
	var[1][0][2] = (mat3x4(5.0, 8.0, 9.0, 8.0, 7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0));
	var[1][1][0] = (mat3x4(-7.0, 4.0, 3.0, -4.0, 4.0, 2.0, -4.0, -3.0, 8.0, 9.0, 9.0, 8.0));
	var[1][1][1] = (mat3x4(1.0, 2.0, 5.0, 6.0, 8.0, 4.0, 6.0, -3.0, 6.0, -7.0, 9.0, -9.0));
	var[1][1][2] = (mat3x4(-9.0, -8.0, 4.0, 0.0, -8.0, 2.0, 2.0, -2.0, -7.0, 9.0, 5.0, -9.0));
	var[2][0][0] = (mat3x4(-7.0, -8.0, -2.0, 9.0, -8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0));
	var[2][0][1] = (mat3x4(1.0, 5.0, 7.0, 5.0, -4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0));
	var[2][0][2] = (mat3x4(-1.0, 2.0, 3.0, -5.0, -6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0));
	var[2][1][0] = (mat3x4(-9.0, -9.0, 8.0, -1.0, 9.0, 2.0, -9.0, -3.0, -9.0, -1.0, 3.0, -2.0));
	var[2][1][1] = (mat3x4(4.0, -7.0, 2.0, 7.0, 3.0, -7.0, 7.0, 6.0, 9.0, -4.0, 4.0, 0.0));
	var[2][1][2] = (mat3x4(7.0, -5.0, 6.0, 4.0, 1.0, 6.0, 4.0, 4.0, 3.0, -2.0, 6.0, -9.0));
	var[3][0][0] = (mat3x4(-2.0, 9.0, -8.0, 3.0, -5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0));
	var[3][0][1] = (mat3x4(-3.0, 2.0, 8.0, 3.0, -1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0));
	var[3][0][2] = (mat3x4(-7.0, -5.0, -3.0, 6.0, -7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0));
	var[3][1][0] = (mat3x4(-6.0, 0.0, 0.0, -3.0, -3.0, 7.0, -1.0, 4.0, 4.0, 5.0, 2.0, 5.0));
	var[3][1][1] = (mat3x4(1.0, 9.0, -5.0, -8.0, -5.0, 7.0, -5.0, 0.0, -4.0, 2.0, 3.0, 5.0));
	var[3][1][2] = (mat3x4(4.0, 2.0, 3.0, 5.0, 5.0, -9.0, -8.0, -9.0, -7.0, 8.0, 4.0, -2.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(3.0, -1.0, -8.0, -1.0, -7.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(0.0, -8.0, -7.0, 7.0, 3.0, 7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(-7.0, 7.0, -7.0, -4.0, -2.0, -5.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(3.0, -9.0, 6.0, -8.0, 0.0, 5.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-2.0, 0.0, 9.0, -8.0, 0.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(9.0, 1.0, 2.0, -6.0, -9.0, -9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-8.0, 9.0, -5.0, -6.0, -1.0, 1.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(8.0, -1.0, -7.0, -7.0, -9.0, -4.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(-6.0, -7.0, -8.0, 6.0, -7.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(8.0, -2.0, 9.0, -6.0, 5.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(-3.0, -3.0, 0.0, -2.0, -5.0, 8.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(-5.0, -9.0, 3.0, 5.0, 2.0, -2.0, -7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(6.0, -2.0));
	var[0][0][0][1] = (vec2(2.0, 8.0));
	var[0][0][0][2] = (vec2(-5.0, 3.0));
	var[0][0][0][3] = (vec2(-1.0, -7.0));
	var[0][0][1][0] = (vec2(4.0, 2.0));
	var[0][0][1][1] = (vec2(-4.0, 8.0));
	var[0][0][1][2] = (vec2(3.0, 8.0));
	var[0][0][1][3] = (vec2(-1.0, 6.0));
	var[0][0][2][0] = (vec2(-8.0, 2.0));
	var[0][0][2][1] = (vec2(-5.0, 5.0));
	var[0][0][2][2] = (vec2(-4.0, -9.0));
	var[0][0][2][3] = (vec2(0.0, 4.0));
	var[0][1][0][0] = (vec2(1.0, 7.0));
	var[0][1][0][1] = (vec2(0.0, -4.0));
	var[0][1][0][2] = (vec2(-1.0, 5.0));
	var[0][1][0][3] = (vec2(9.0, -8.0));
	var[0][1][1][0] = (vec2(-3.0, 8.0));
	var[0][1][1][1] = (vec2(-1.0, 7.0));
	var[0][1][1][2] = (vec2(5.0, -7.0));
	var[0][1][1][3] = (vec2(8.0, 0.0));
	var[0][1][2][0] = (vec2(-5.0, 7.0));
	var[0][1][2][1] = (vec2(8.0, 9.0));
	var[0][1][2][2] = (vec2(8.0, 9.0));
	var[0][1][2][3] = (vec2(1.0, 9.0));
	var[1][0][0][0] = (vec2(8.0, 2.0));
	var[1][0][0][1] = (vec2(-3.0, 2.0));
	var[1][0][0][2] = (vec2(-4.0, -4.0));
	var[1][0][0][3] = (vec2(2.0, -8.0));
	var[1][0][1][0] = (vec2(-4.0, 8.0));
	var[1][0][1][1] = (vec2(5.0, 7.0));
	var[1][0][1][2] = (vec2(-4.0, 6.0));
	var[1][0][1][3] = (vec2(8.0, 4.0));
	var[1][0][2][0] = (vec2(-9.0, -7.0));
	var[1][0][2][1] = (vec2(7.0, -5.0));
	var[1][0][2][2] = (vec2(1.0, -9.0));
	var[1][0][2][3] = (vec2(9.0, 5.0));
	var[1][1][0][0] = (vec2(-9.0, 8.0));
	var[1][1][0][1] = (vec2(-2.0, 9.0));
	var[1][1][0][2] = (vec2(6.0, 6.0));
	var[1][1][0][3] = (vec2(3.0, -5.0));
	var[1][1][1][0] = (vec2(1.0, -4.0));
	var[1][1][1][1] = (vec2(-5.0, 7.0));
	var[1][1][1][2] = (vec2(-8.0, 7.0));
	var[1][1][1][3] = (vec2(-1.0, -1.0));
	var[1][1][2][0] = (vec2(-2.0, -7.0));
	var[1][1][2][1] = (vec2(4.0, -8.0));
	var[1][1][2][2] = (vec2(2.0, 4.0));
	var[1][1][2][3] = (vec2(3.0, 1.0));
	var[2][0][0][0] = (vec2(7.0, 3.0));
	var[2][0][0][1] = (vec2(3.0, 3.0));
	var[2][0][0][2] = (vec2(-5.0, -9.0));
	var[2][0][0][3] = (vec2(2.0, 9.0));
	var[2][0][1][0] = (vec2(3.0, 8.0));
	var[2][0][1][1] = (vec2(3.0, -4.0));
	var[2][0][1][2] = (vec2(6.0, 1.0));
	var[2][0][1][3] = (vec2(-3.0, 1.0));
	var[2][0][2][0] = (vec2(-5.0, -2.0));
	var[2][0][2][1] = (vec2(7.0, 8.0));
	var[2][0][2][2] = (vec2(4.0, 7.0));
	var[2][0][2][3] = (vec2(-1.0, -8.0));
	var[2][1][0][0] = (vec2(7.0, 8.0));
	var[2][1][0][1] = (vec2(2.0, -9.0));
	var[2][1][0][2] = (vec2(-8.0, -9.0));
	var[2][1][0][3] = (vec2(-1.0, -3.0));
	var[2][1][1][0] = (vec2(-2.0, -1.0));
	var[2][1][1][1] = (vec2(1.0, -1.0));
	var[2][1][1][2] = (vec2(-5.0, -6.0));
	var[2][1][1][3] = (vec2(-8.0, 7.0));
	var[2][1][2][0] = (vec2(2.0, 0.0));
	var[2][1][2][1] = (vec2(-7.0, -6.0));
	var[2][1][2][2] = (vec2(6.0, 1.0));
	var[2][1][2][3] = (vec2(8.0, 9.0));
	var[3][0][0][0] = (vec2(-6.0, -6.0));
	var[3][0][0][1] = (vec2(-4.0, -2.0));
	var[3][0][0][2] = (vec2(3.0, 8.0));
	var[3][0][0][3] = (vec2(4.0, 4.0));
	var[3][0][1][0] = (vec2(-7.0, -6.0));
	var[3][0][1][1] = (vec2(8.0, -6.0));
	var[3][0][1][2] = (vec2(8.0, -3.0));
	var[3][0][1][3] = (vec2(-7.0, 0.0));
	var[3][0][2][0] = (vec2(-9.0, 2.0));
	var[3][0][2][1] = (vec2(-9.0, 7.0));
	var[3][0][2][2] = (vec2(-2.0, 2.0));
	var[3][0][2][3] = (vec2(-6.0, -1.0));
	var[3][1][0][0] = (vec2(9.0, -8.0));
	var[3][1][0][1] = (vec2(-6.0, -7.0));
	var[3][1][0][2] = (vec2(-5.0, 0.0));
	var[3][1][0][3] = (vec2(-3.0, 1.0));
	var[3][1][1][0] = (vec2(-1.0, -6.0));
	var[3][1][1][1] = (vec2(1.0, 1.0));
	var[3][1][1][2] = (vec2(-7.0, -8.0));
	var[3][1][1][3] = (vec2(-5.0, 5.0));
	var[3][1][2][0] = (vec2(4.0, -9.0));
	var[3][1][2][1] = (vec2(-6.0, -7.0));
	var[3][1][2][2] = (vec2(-8.0, 8.0));
	var[3][1][2][3] = (vec2(-3.0, 6.0));
}
#version 450
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
	highp mat3x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-4.0, -6.0, 5.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(5.0, 9.0, -1.0, 4.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(-2.0, -3.0, 2.0, 7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-1.0, -4.0, 9.0, -1.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-6.0, -3.0, -3.0, 4.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(7.0, 5.0, -5.0, 6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-4.0, -9.0, 9.0, -2.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(4.0, -7.0, -7.0, 3.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(1.0, 4.0, 8.0, -2.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-9.0, 7.0, 4.0, 6.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-6.0, -5.0, -7.0, -8.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(2.0, -1.0, -1.0, 8.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(4.0, 3.0, -8.0, -2.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(-7.0, -6.0, 9.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(0.0, -6.0, 7.0, -4.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(2.0, -7.0, 2.0, -8.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-2.0, 5.0, 6.0, -5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(6.0, -8.0, 8.0, 5.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(5.0, -6.0, -3.0, 6.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(8.0, 9.0, -3.0, 8.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-9.0, -6.0, -9.0, 5.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(5.0, -9.0, 0.0, 7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(-5.0, -4.0, -3.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(7.0, 6.0, 6.0, 3.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0][0] = (mat3x2(-1.0, 2.0, -8.0, -4.0, 9.0, 6.0));
	var[0][0][1] = (mat3x2(8.0, 5.0, -7.0, -7.0, 0.0, 5.0));
	var[0][0][2] = (mat3x2(8.0, 1.0, -4.0, 1.0, 3.0, 0.0));
	var[0][1][0] = (mat3x2(-4.0, 8.0, 4.0, 5.0, 4.0, 8.0));
	var[0][1][1] = (mat3x2(3.0, 9.0, -4.0, -3.0, -6.0, -9.0));
	var[0][1][2] = (mat3x2(8.0, 6.0, -7.0, 9.0, 2.0, -2.0));
	var[1][0][0] = (mat3x2(-6.0, -9.0, 0.0, 8.0, 7.0, 7.0));
	var[1][0][1] = (mat3x2(-7.0, 8.0, -7.0, -8.0, 9.0, -5.0));
	var[1][0][2] = (mat3x2(-9.0, -9.0, -4.0, 7.0, 7.0, 3.0));
	var[1][1][0] = (mat3x2(-3.0, -2.0, -4.0, 5.0, -4.0, 9.0));
	var[1][1][1] = (mat3x2(-9.0, -9.0, -6.0, 8.0, 1.0, 4.0));
	var[1][1][2] = (mat3x2(-2.0, 0.0, -9.0, 4.0, -2.0, 3.0));
	var[2][0][0] = (mat3x2(-9.0, -7.0, 4.0, -8.0, -2.0, 9.0));
	var[2][0][1] = (mat3x2(-1.0, 9.0, 7.0, 0.0, 3.0, -6.0));
	var[2][0][2] = (mat3x2(5.0, -8.0, 1.0, 9.0, 5.0, -4.0));
	var[2][1][0] = (mat3x2(2.0, 8.0, -9.0, -3.0, -7.0, 0.0));
	var[2][1][1] = (mat3x2(-5.0, -2.0, -1.0, -6.0, -9.0, -7.0));
	var[2][1][2] = (mat3x2(8.0, 6.0, 5.0, -3.0, 0.0, 7.0));
	var[3][0][0] = (mat3x2(-3.0, -2.0, 3.0, -1.0, 1.0, -9.0));
	var[3][0][1] = (mat3x2(4.0, 5.0, -3.0, 8.0, 4.0, 8.0));
	var[3][0][2] = (mat3x2(-4.0, -8.0, 7.0, -4.0, 9.0, -6.0));
	var[3][1][0] = (mat3x2(4.0, 0.0, 5.0, 7.0, -2.0, -2.0));
	var[3][1][1] = (mat3x2(8.0, -3.0, 4.0, 5.0, -1.0, -4.0));
	var[3][1][2] = (mat3x2(3.0, 7.0, -8.0, 7.0, 3.0, 0.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	highp mat3x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(-5.0, -1.0, -4.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(1.0, -6.0, -3.0, -3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(-1.0, 2.0, -7.0, 2.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(-2.0, -2.0, 5.0, 6.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(1.0, 7.0, 5.0, -5.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(-8.0, -9.0, 7.0, 4.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(-4.0, 6.0, -8.0, 8.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(-9.0, 5.0, -9.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(8.0, -6.0, -5.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(3.0, 2.0, -1.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(3.0, -5.0, -4.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(-2.0, 7.0, 6.0, 6.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	var[0][0][1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	var[0][1][0] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	var[0][1][1] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	var[0][2][0] = (mat3x2(-6.0, -4.0, 8.0, 4.0, 5.0, 4.0));
	var[0][2][1] = (mat3x2(8.0, 3.0, 9.0, -4.0, -3.0, -6.0));
	var[0][3][0] = (mat3x2(3.0, 2.0, 8.0, -9.0, -3.0, -7.0));
	var[0][3][1] = (mat3x2(0.0, -5.0, -2.0, -1.0, -6.0, -9.0));
	var[1][0][0] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	var[1][0][1] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	var[1][1][0] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	var[1][1][1] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	var[1][2][0] = (mat3x2(-9.0, 8.0, 6.0, -7.0, 9.0, 2.0));
	var[1][2][1] = (mat3x2(-2.0, -3.0, -2.0, -4.0, 5.0, -4.0));
	var[1][3][0] = (mat3x2(-7.0, 8.0, 6.0, 5.0, -3.0, 0.0));
	var[1][3][1] = (mat3x2(7.0, 4.0, 0.0, 5.0, 7.0, -2.0));
	var[2][0][0] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	var[2][0][1] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	var[2][1][0] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	var[2][1][1] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
	var[2][2][0] = (mat3x2(9.0, -9.0, -9.0, -6.0, 8.0, 1.0));
	var[2][2][1] = (mat3x2(4.0, -2.0, 0.0, -9.0, 4.0, -2.0));
	var[2][3][0] = (mat3x2(-2.0, 8.0, -3.0, 4.0, 5.0, -1.0));
	var[2][3][1] = (mat3x2(-4.0, 3.0, 7.0, -8.0, 7.0, 3.0));
}
#version 450
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
	i8vec2 var[][4][2];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(var[0][0][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][0][1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1][0]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1][1]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][2][0]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][2][1]), ivec2(2, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][3][0]), ivec2(7, 4294967292)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][3][1]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0][0]), ivec2(0, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0][1]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1][0]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1][1]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][2][0]), ivec2(4294967290, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][2][1]), ivec2(5, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][3][0]), ivec2(2, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][3][1]), ivec2(0, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0][0]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0][1]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1][0]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1][1]), ivec2(3, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][2][0]), ivec2(8, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][2][1]), ivec2(4294967294, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][3][0]), ivec2(4294967289, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][3][1]), ivec2(7, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i8vec2(ivec2(0, 8));
	var[0][0][1] = i8vec2(ivec2(4294967292, 9));
	var[0][1][0] = i8vec2(ivec2(4294967293, 4294967293));
	var[0][1][1] = i8vec2(ivec2(4294967290, 3));
	var[0][2][0] = i8vec2(ivec2(4294967293, 0));
	var[0][2][1] = i8vec2(ivec2(3, 4294967291));
	var[0][3][0] = i8vec2(ivec2(4294967292, 4294967292));
	var[0][3][1] = i8vec2(ivec2(3, 4294967294));
	var[1][0][0] = i8vec2(ivec2(4294967294, 4294967295));
	var[1][0][1] = i8vec2(ivec2(8, 4294967290));
	var[1][1][0] = i8vec2(ivec2(4294967295, 8));
	var[1][1][1] = i8vec2(ivec2(5, 8));
	var[1][2][0] = i8vec2(ivec2(4294967295, 4294967292));
	var[1][2][1] = i8vec2(ivec2(5, 4294967292));
	var[1][3][0] = i8vec2(ivec2(8, 4));
	var[1][3][1] = i8vec2(ivec2(8, 6));
	var[2][0][0] = i8vec2(ivec2(8, 4294967289));
	var[2][0][1] = i8vec2(ivec2(7, 4294967294));
	var[2][1][0] = i8vec2(ivec2(4294967293, 4294967292));
	var[2][1][1] = i8vec2(ivec2(4294967287, 6));
	var[2][2][0] = i8vec2(ivec2(4294967291, 4));
	var[2][2][1] = i8vec2(ivec2(0, 4294967293));
	var[2][3][0] = i8vec2(ivec2(5, 4294967294));
	var[2][3][1] = i8vec2(ivec2(4294967288, 4294967292));
}
#version 450
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
	allOk = compare_mat3x4(var[0][0][0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(0.0, 6.0, 3.0, 9.0, -3.0, 9.0, 3.0, -5.0, -1.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(-7.0, 6.0, 5.0, -7.0, -2.0, -4.0, 0.0, -8.0, 8.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(-2.0, 9.0, -5.0, -3.0, 3.0, 5.0, 4.0, -7.0, -1.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(-5.0, 1.0, 5.0, -9.0, 3.0, 5.0, 3.0, 8.0, -8.0, -5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(4.0, 4.0, -6.0, -2.0, 7.0, 1.0, -3.0, -2.0, -6.0, -2.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(-6.0, -4.0, 8.0, -5.0, -5.0, 7.0, 3.0, -1.0, 7.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(-9.0, -3.0, -8.0, -8.0, 8.0, 8.0, 3.0, -6.0, -7.0, 4.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(7.0, 0.0, 9.0, -1.0, 2.0, 9.0, -3.0, 7.0, 4.0, -2.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(5.0, -1.0, 4.0, -5.0, -8.0, -7.0, 7.0, -6.0, -4.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(-5.0, 3.0, 9.0, 0.0, 1.0, 3.0, -8.0, -9.0, 5.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-4.0, -4.0, -1.0, -8.0, 9.0, -4.0, -1.0, -5.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(7.0, -1.0, -3.0, -4.0, -4.0, -3.0, 3.0, -7.0, -5.0, 8.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	var[0][0][1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	var[0][1][0] = (mat3x4(-4.0, 2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0));
	var[0][1][1] = (mat3x4(9.0, -2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0));
	var[0][2][0] = (mat3x4(-6.0, 0.0, 1.0, -2.0, 1.0, -4.0, -2.0, -6.0, -7.0, -8.0, 0.0, -8.0));
	var[0][2][1] = (mat3x4(0.0, 2.0, 9.0, -5.0, 9.0, -5.0, -4.0, 0.0, 4.0, 1.0, 0.0, -9.0));
	var[0][3][0] = (mat3x4(-8.0, 0.0, 8.0, -6.0, -2.0, -3.0, 6.0, 4.0, 9.0, -2.0, 4.0, 1.0));
	var[0][3][1] = (mat3x4(-9.0, -5.0, -8.0, 5.0, 4.0, 2.0, 7.0, 1.0, -6.0, 2.0, -6.0, -4.0));
	var[1][0][0] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
	var[1][0][1] = (mat3x4(-5.0, -5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0));
	var[1][1][0] = (mat3x4(-6.0, 5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0));
	var[1][1][1] = (mat3x4(9.0, 2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0));
	var[1][2][0] = (mat3x4(1.0, -1.0, -4.0, 9.0, 7.0, 3.0, 5.0, 1.0, 6.0, 6.0, 2.0, 2.0));
	var[1][2][1] = (mat3x4(8.0, -5.0, -9.0, 8.0, -3.0, -3.0, 9.0, -9.0, 6.0, -4.0, 9.0, 4.0));
	var[1][3][0] = (mat3x4(-3.0, 1.0, -5.0, -9.0, -2.0, 3.0, 0.0, -4.0, 8.0, -3.0, 4.0, 9.0));
	var[1][3][1] = (mat3x4(-6.0, -1.0, 3.0, -9.0, -6.0, -6.0, -3.0, 5.0, 0.0, -9.0, -4.0, 9.0));
	var[2][0][0] = (mat3x4(-5.0, 5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0));
	var[2][0][1] = (mat3x4(-9.0, -1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0));
	var[2][1][0] = (mat3x4(-1.0, 4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0));
	var[2][1][1] = (mat3x4(-9.0, 1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0));
	var[2][2][0] = (mat3x4(-8.0, 4.0, 7.0, 3.0, -1.0, -1.0, 9.0, -9.0, 8.0, -3.0, 9.0, -6.0));
	var[2][2][1] = (mat3x4(-4.0, 6.0, 2.0, 5.0, 3.0, 7.0, 3.0, 4.0, -4.0, 2.0, 0.0, 8.0));
	var[2][3][0] = (mat3x4(-8.0, 6.0, -4.0, -3.0, -4.0, 3.0, 3.0, 4.0, 4.0, 4.0, 3.0, 8.0));
	var[2][3][1] = (mat3x4(-3.0, -6.0, -3.0, 6.0, -9.0, -3.0, -6.0, 9.0, 3.0, -1.0, 6.0, 3.0));
}
#version 450
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
layout(std430, binding = 1) buffer Block
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
	allOk = compare_ivec3((s.a), ivec3(8, 2, -1)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-2.0, 7.0, 2.0, 9.0, 0.0, 5.0, 4.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(-3.0, -2.0, -3.0, -7.0, 7.0, -5.0, -4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(1.0, -5.0, -8.0, -8.0, -8.0, -2.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(8.0, -2.0, -6.0, -6.0, -8.0, 6.0, 9.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(-7.0, -1.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(t.a, mat3(-1.0, -5.0, -4.0, 9.0, 5.0, 0.0, 4.0, -5.0, -7.0)) && allOk;
	allOk = compare_ivec3((t.b.a), ivec3(-7, -6, -8)) && allOk;
	allOk = compare_mat3(t.b.b[0], mat3(-7.0, 2.0, 7.0, -1.0, -5.0, 4.0, 0.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(t.b.b[1], mat3(-5.0, 6.0, 0.0, 4.0, 5.0, 9.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3(t.b.b[2], mat3(8.0, -7.0, -2.0, 4.0, -2.0, 9.0, -8.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3(t.b.b[3], mat3(5.0, 4.0, 9.0, -3.0, 5.0, 3.0, -6.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec4((t.b.c), vec4(6.0, -2.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	t.a[0] = (vec3(-2.0, -2.0, 9.0));
	t.a[1] = (vec3(3.0, -8.0, -5.0));
	t.a[2] = (vec3(2.0, 9.0, 4.0));
	t.b.a = (ivec3(-2, -1, -6));
	t.b.b[0][0] = (vec3(-1.0, 1.0, -4.0));
	t.b.b[0][1] = (vec3(6.0, 5.0, -4.0));
	t.b.b[0][2] = (vec3(4.0, -1.0, 1.0));
	t.b.b[1][0] = (vec3(-5.0, -4.0, -9.0));
	t.b.b[1][1] = (vec3(1.0, -3.0, -1.0));
	t.b.b[1][2] = (vec3(1.0, 2.0, -7.0));
	t.b.b[2][0] = (vec3(-3.0, -9.0, -3.0));
	t.b.b[2][1] = (vec3(0.0, 4.0, 5.0));
	t.b.b[2][2] = (vec3(-8.0, 6.0, 5.0));
	t.b.b[3][0] = (vec3(-3.0, 2.0, 0.0));
	t.b.b[3][1] = (vec3(1.0, 6.0, -2.0));
	t.b.b[3][2] = (vec3(-7.0, 3.0, -6.0));
	t.b.c = (vec4(-2.0, 2.0, 5.0, -9.0));
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
	allOk = compare_uvec2((s[0].a), uvec2(9u, 2u)) && allOk;
	allOk = compare_mat2x4(s[0].b[0], mat2x4(-9.0, 4.0, -1.0, -8.0, 8.0, 0.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[1], mat2x4(0.0, -7.0, 7.0, -5.0, 1.0, -5.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[2], mat2x4(2.0, -1.0, 4.0, 1.0, -3.0, 5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[3], mat2x4(-9.0, -3.0, -8.0, -4.0, -3.0, 6.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3((s[0].c), vec3(-8.0, 4.0, 6.0)) && allOk;
	allOk = compare_uvec2((s[1].a), uvec2(6u, 5u)) && allOk;
	allOk = compare_mat2x4(s[1].b[0], mat2x4(0.0, 6.0, -9.0, -3.0, 2.0, 5.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[1], mat2x4(9.0, 4.0, -3.0, -3.0, 2.0, 4.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[2], mat2x4(-5.0, -9.0, -6.0, 8.0, -6.0, 7.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[3], mat2x4(-9.0, -8.0, -8.0, 5.0, 6.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec3((s[1].c), vec3(4.0, -6.0, 1.0)) && allOk;
	allOk = compare_uvec2((s[2].a), uvec2(7u, 0u)) && allOk;
	allOk = compare_mat2x4(s[2].b[0], mat2x4(0.0, 0.0, 4.0, -4.0, 9.0, -7.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[1], mat2x4(4.0, 5.0, 5.0, -3.0, 9.0, -1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[2], mat2x4(6.0, 1.0, -4.0, 6.0, 4.0, -4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[3], mat2x4(-2.0, -8.0, -2.0, -9.0, 9.0, 9.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec3((s[2].c), vec3(9.0, -5.0, 2.0)) && allOk;
	allOk = compare_uvec2((s[3].a), uvec2(9u, 5u)) && allOk;
	allOk = compare_mat2x4(s[3].b[0], mat2x4(6.0, -3.0, -9.0, -6.0, -7.0, 4.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[1], mat2x4(8.0, -8.0, -4.0, 6.0, 3.0, -2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[2], mat2x4(-3.0, 8.0, -1.0, -3.0, 5.0, -5.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[3], mat2x4(7.0, 2.0, -7.0, -9.0, -4.0, 2.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec3((s[3].c), vec3(-7.0, 2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (2u);
	s[0].a = (uvec2(7u, 3u));
	s[0].b[0] = (mat2x4(7.0, -9.0, 8.0, -2.0, 5.0, 1.0, 6.0, 4.0));
	s[0].b[1] = (mat2x4(-5.0, -1.0, -2.0, 5.0, 3.0, -3.0, -2.0, -9.0));
	s[0].b[2] = (mat2x4(9.0, 9.0, -6.0, -5.0, 0.0, 4.0, 6.0, 5.0));
	s[0].b[3] = (mat2x4(-6.0, -8.0, 4.0, -6.0, -1.0, 8.0, -1.0, 6.0));
	s[0].c = (vec3(-9.0, 0.0, 0.0));
	s[1].a = (uvec2(1u, 3u));
	s[1].b[0] = (mat2x4(-2.0, 7.0, -9.0, -6.0, -6.0, 3.0, -3.0, 8.0));
	s[1].b[1] = (mat2x4(4.0, -6.0, -1.0, -8.0, 0.0, 9.0, 7.0, -5.0));
	s[1].b[2] = (mat2x4(9.0, -6.0, -7.0, -7.0, -2.0, 2.0, 3.0, -5.0));
	s[1].b[3] = (mat2x4(-7.0, -2.0, 8.0, -6.0, 3.0, -7.0, 3.0, -6.0));
	s[1].c = (vec3(-1.0, -8.0, -4.0));
	s[2].a = (uvec2(2u, 1u));
	s[2].b[0] = (mat2x4(-7.0, -2.0, 2.0, 2.0, -7.0, 6.0, -2.0, 5.0));
	s[2].b[1] = (mat2x4(8.0, -8.0, 8.0, 3.0, 4.0, 6.0, -6.0, 0.0));
	s[2].b[2] = (mat2x4(1.0, 0.0, -7.0, -5.0, 3.0, 7.0, -8.0, -7.0));
	s[2].b[3] = (mat2x4(3.0, 9.0, -5.0, -2.0, 2.0, 2.0, 3.0, -6.0));
	s[2].c = (vec3(-2.0, 9.0, -5.0));
	s[3].a = (uvec2(2u, 1u));
	s[3].b[0] = (mat2x4(-5.0, -7.0, -7.0, -4.0, 2.0, -6.0, -9.0, -3.0));
	s[3].b[1] = (mat2x4(-7.0, -8.0, -5.0, -6.0, 3.0, 3.0, -5.0, -2.0));
	s[3].b[2] = (mat2x4(1.0, -9.0, -4.0, -8.0, 1.0, -1.0, -7.0, 8.0));
	s[3].b[3] = (mat2x4(-5.0, 4.0, -7.0, -5.0, 0.0, -5.0, 0.0, 8.0));
	s[3].c = (vec3(-5.0, -3.0, 0.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(8, 0, 4)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(0.0, 6.0, 0.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(8, 7, -6)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(-9.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(5, 3, 3)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(1.0, 4.0, 9.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(1, 1, -3)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(4.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(-1, 2, -8)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-8.0, 4.0, 8.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(-2, 0, 6)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(4.0, -4.0, 7.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(-6, 0, 6)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(-2.0, 1.0, -5.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(8, -3, -5)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(0.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(-3, -1, 4)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(3.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(-3, -5, 4)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-2.0, -9.0, -5.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(4, -7, -1)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(8.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(8, 0, 8)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(-6.0, 7.0, 3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(-9.0, -8.0, 1.0, 8.0));
	block[0].s[0][0].a = (ivec3(-1, 4, -7));
	block[0].s[0][0].c = (vec4(3.0, -4.0, 2.0, 4.0));
	block[0].s[0][1].a = (ivec3(-4, 4, 3));
	block[0].s[0][1].c = (vec4(-9.0, -2.0, -8.0, -7.0));
	block[0].s[1][0].a = (ivec3(5, 5, 1));
	block[0].s[1][0].c = (vec4(9.0, 2.0, -3.0, 1.0));
	block[0].s[1][1].a = (ivec3(-1, 4, -3));
	block[0].s[1][1].c = (vec4(6.0, 8.0, -1.0, 8.0));
	block[0].s[2][0].a = (ivec3(-2, 7, 4));
	block[0].s[2][0].c = (vec4(9.0, 4.0, 9.0, 2.0));
	block[0].s[2][1].a = (ivec3(1, 2, 2));
	block[0].s[2][1].c = (vec4(-2.0, -4.0, 0.0, 7.0));
	block[1].v = (vec4(-1.0, -7.0, -2.0, 5.0));
	block[1].s[0][0].a = (ivec3(-1, 8, 0));
	block[1].s[0][0].c = (vec4(3.0, -2.0, -5.0, 6.0));
	block[1].s[0][1].a = (ivec3(-8, -5, -2));
	block[1].s[0][1].c = (vec4(4.0, 7.0, 2.0, -8.0));
	block[1].s[1][0].a = (ivec3(1, 9, -4));
	block[1].s[1][0].c = (vec4(-9.0, -8.0, 4.0, -6.0));
	block[1].s[1][1].a = (ivec3(8, 8, -2));
	block[1].s[1][1].c = (vec4(-6.0, -4.0, 0.0, 2.0));
	block[2].v = (vec4(-8.0, 2.0, 2.0, 1.0));
	block[2].s[0][0].a = (ivec3(-4, -7, -3));
	block[2].s[0][0].c = (vec4(1.0, 2.0, 9.0, 1.0));
	block[2].s[0][1].a = (ivec3(5, 1, -5));
	block[2].s[0][1].c = (vec4(8.0, -2.0, -7.0, 6.0));
}
#version 450
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
layout(scalar, binding = 1) buffer Block
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
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(-7, -5, 1)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(-4.0, 4.0, -1.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(1, 8, -2)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(8.0, -3.0, 1.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(-9, -1, -9)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(0.0, 6.0, -4.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(-9, -5, 3)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(2.0, 1.0, 8.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(7, -8, 3)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(0.0, -4.0, 6.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(-9, 6, -3)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(-1.0, -3.0, -8.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(0, -7, -5)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(8.0, 0.0, 5.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(5, 1, 9)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(-4.0, 7.0, -9.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(3, 3, 7)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(-2.0, -2.0, -8.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(-9, 9, 2)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-9.0, 0.0, 5.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(3, 7, -4)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(1.0, 1.0, -4.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(-4, -7, -8)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(-8.0, 6.0, 7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(1.0, 0.0, -9.0, -4.0));
	block[0].s[0][0].a = (ivec3(-7, 3, -8));
	block[0].s[0][0].c = (vec4(-4.0, -4.0, -1.0, 1.0));
	block[0].s[0][1].a = (ivec3(6, 9, -6));
	block[0].s[0][1].c = (vec4(-4.0, -7.0, -8.0, -5.0));
	block[0].s[1][0].a = (ivec3(0, -3, -8));
	block[0].s[1][0].c = (vec4(6.0, 1.0, -8.0, -5.0));
	block[0].s[1][1].a = (ivec3(-4, 0, -8));
	block[0].s[1][1].c = (vec4(-4.0, -9.0, 8.0, -1.0));
	block[0].s[2][0].a = (ivec3(9, 4, -7));
	block[0].s[2][0].c = (vec4(-4.0, -6.0, -5.0, 5.0));
	block[0].s[2][1].a = (ivec3(5, 8, 9));
	block[0].s[2][1].c = (vec4(-6.0, 9.0, 2.0, -1.0));
	block[1].v = (vec4(-5.0, -4.0, -8.0, -3.0));
	block[1].s[0][0].a = (ivec3(-6, -8, 5));
	block[1].s[0][0].c = (vec4(9.0, -9.0, -5.0, 7.0));
	block[1].s[0][1].a = (ivec3(3, 9, 1));
	block[1].s[0][1].c = (vec4(8.0, 3.0, 4.0, 7.0));
	block[1].s[1][0].a = (ivec3(5, 5, 0));
	block[1].s[1][0].c = (vec4(-7.0, 8.0, 0.0, -1.0));
	block[1].s[1][1].a = (ivec3(1, -8, 7));
	block[1].s[1][1].c = (vec4(5.0, 6.0, 4.0, 0.0));
	block[2].v = (vec4(-2.0, -7.0, -8.0, 7.0));
	block[2].s[0][0].a = (ivec3(-9, 4, 6));
	block[2].s[0][0].c = (vec4(3.0, 7.0, -6.0, 1.0));
	block[2].s[0][1].a = (ivec3(-5, -4, 0));
	block[2].s[0][1].c = (vec4(-6.0, 9.0, 1.0, 7.0));
}
#version 450
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
	allOk = compare_uint((block[0].u), 0u) && allOk;
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(-8.0, -3.0, 3.0, -9.0, -1.0, 3.0, 8.0, -7.0, -6.0, 9.0, 6.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(8u, 9u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-6.0, 3.0, -8.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(1u, 0u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(8.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-7.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(1u, 5u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(-5.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(-6.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(3.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(5.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-2.0, -4.0, 3.0, 0.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), -3) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(-9.0, 6.0, -1.0, -7.0, 0.0, -4.0, -1.0, -6.0, -6.0, 3.0, -3.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(2u, 6u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(-4.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(-1.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(7.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(9.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(2.0, -1.0, -4.0, -1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(4u, 3u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(7.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(-1.0, 6.0, 2.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(4u, 4u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(3.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(-9.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(3.0, 3.0, 2.0, -9.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), 8) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(1.0, -7.0, 4.0, -9.0, -6.0, -2.0, 7.0, 5.0, -5.0, 9.0, -2.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(0u, 5u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(-6.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(3.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(-3.0, -7.0, -8.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(6u, 1u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(5.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(7.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(5.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(9u, 2u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(1.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(-9.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), -3) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(7.0, -9.0, -2.0, 2.0, -3.0, 5.0, 4.0, 9.0, 2.0, -2.0, -3.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(7u, 7u, 8u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(1.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(8.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(-4.0, 0.0, 7.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(6u, 7u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(-2.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(6.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(7.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(8.0, 4.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(9.0, 1.0, 7.0, 6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(8u, 4u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(-1.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(-9.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(9.0, 1.0, 1.0, -5.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), 8) && allOk;
	allOk = compare_uint((block[1].u), 4u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(4.0, 1.0, -3.0, 9.0, 0.0, -8.0, -8.0, -9.0, 3.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(0u, 9u, 6u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(4.0, 9.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(1.0, 4.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(-2.0, -3.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(0.0, 4.0, -3.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(3u, 7u, 6u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(-6.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(0.0, -2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(2.0, -5.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(9.0, 8.0, 9.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(2u, 2u, 8u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(2.0, 1.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(7.0, 9.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(3.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-1.0, -4.0, -1.0, 3.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), 1) && allOk;
	allOk = compare_uint((block[2].u), 8u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(5.0, -1.0, -8.0, -6.0, 7.0, -9.0, -3.0, 1.0, 4.0, 2.0, 8.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(0u, 6u, 3u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(7.0, 0.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-3.0, 7.0, 7.0, -1.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(3u, 7u, 9u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(-5.0, 4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(-9.0, 8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(7.0, -1.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-8.0, -2.0, -3.0, 3.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(8u, 1u, 3u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(5.0, 2.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(0.0, -7.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(5.0, -5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(-4.0, -6.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(-1.0, -5.0, -5.0, -3.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(9u, 7u, 1u));
	block[0].s.b[0] = (vec2(3.0, 7.0));
	block[0].s.b[1] = (vec2(5.0, 6.0));
	block[0].s.b[2] = (vec2(5.0, 4.0));
	block[0].s.b[3] = (vec2(6.0, -7.0));
	block[0].s.c = (vec4(9.0, 0.0, 5.0, 7.0));
	block[0].u = (0u);
	block[1].s.a = (uvec3(5u, 3u, 7u));
	block[1].s.b[0] = (vec2(7.0, 6.0));
	block[1].s.b[1] = (vec2(9.0, 6.0));
	block[1].s.b[2] = (vec2(-3.0, -8.0));
	block[1].s.b[3] = (vec2(2.0, 5.0));
	block[1].s.c = (vec4(-5.0, -6.0, 1.0, 4.0));
	block[1].u = (0u);
	block[2].s.a = (uvec3(7u, 8u, 8u));
	block[2].s.b[0] = (vec2(-2.0, -4.0));
	block[2].s.b[1] = (vec2(8.0, 7.0));
	block[2].s.b[2] = (vec2(-5.0, 8.0));
	block[2].s.b[3] = (vec2(-5.0, -9.0));
	block[2].s.c = (vec4(-1.0, -5.0, -4.0, -4.0));
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
layout(scalar, binding = 1) buffer Block
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
	allOk = compare_uint((block[0].u), 8u) && allOk;
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(0.0, 6.0, -4.0, -5.0, 0.0, -4.0, 6.0, 9.0, 1.0, 8.0, -2.0, -9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(5u, 4u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(1.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(-9.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-6.0, 0.0, -9.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(9u, 2u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(-4.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(2.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(2.0, -3.0, 2.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(0u, 4u, 8u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(-4.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(3.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(0.0, 4.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(9.0, 9.0, 5.0, 2.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), 2) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(-5.0, 3.0, -9.0, 6.0, -3.0, 8.0, -3.0, 1.0, -5.0, 2.0, 1.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(5u, 6u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(-4.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(-4.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(-4.0, -9.0, 6.0, 3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(0u, 8u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(8.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(-7.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(-6.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(3.0, 8.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(-9.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(-8.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-4.0, 3.0, -4.0, -5.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), -7) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(5.0, -1.0, -3.0, -8.0, -4.0, -8.0, -9.0, -3.0, -1.0, -8.0, 0.0, -7.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(1u, 7u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(-8.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(6.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(-7.0, 8.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(-9.0, -6.0, 7.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(1u, 5u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(3.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(5.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(2.0, 7.0, 9.0, 3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(4u, 2u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(6.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(2.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(-9.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(-1.0, 0.0, -9.0, -2.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), -9) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(-5.0, 3.0, 3.0, 7.0, 8.0, 0.0, 5.0, 0.0, -2.0, -2.0, -8.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(2u, 2u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(-9.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(0.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(-2.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(0.0, 6.0, -2.0, -2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(8u, 3u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(4.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(9.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(-6.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(4.0, -3.0, -5.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(3u, 0u, 8u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(8.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(-3.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(4.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(5.0, -9.0, 0.0, -3.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), 3) && allOk;
	allOk = compare_uint((block[1].u), 0u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(0.0, 4.0, -2.0, 8.0, -7.0, 9.0, -8.0, -4.0, -6.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(9u, 4u, 6u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(6.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(6.0, 1.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-9.0, 2.0, -3.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(2u, 0u, 8u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(2.0, -5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(9.0, -9.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(1.0, 2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(9.0, 3.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-2.0, 1.0, -6.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(4u, 5u, 1u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(-8.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(0.0, 7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(-4.0, 1.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(7.0, 0.0, -5.0, -2.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), 6) && allOk;
	allOk = compare_uint((block[2].u), 0u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(1.0, 7.0, -4.0, -7.0, 0.0, 8.0, 4.0, 0.0, 6.0, -2.0, -6.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(2u, 7u, 3u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(4.0, 8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(-9.0, 6.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(2.0, -8.0, -5.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(2u, 6u, 0u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(9.0, 5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(9.0, 0.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(5.0, -5.0, 2.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(7u, 6u, 7u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(4.0, 3.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(2.0, -6.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(-9.0, 5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(3.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(1u, 5u, 5u));
	block[0].s.b[0] = (vec2(-9.0, -4.0));
	block[0].s.b[1] = (vec2(-7.0, 3.0));
	block[0].s.b[2] = (vec2(-8.0, 0.0));
	block[0].s.b[3] = (vec2(-3.0, -8.0));
	block[0].s.c = (vec4(9.0, 4.0, -7.0, -4.0));
	block[0].u = (9u);
	block[1].s.a = (uvec3(6u, 1u, 3u));
	block[1].s.b[0] = (vec2(7.0, 7.0));
	block[1].s.b[1] = (vec2(7.0, -8.0));
	block[1].s.b[2] = (vec2(2.0, -4.0));
	block[1].s.b[3] = (vec2(-3.0, 0.0));
	block[1].s.c = (vec4(2.0, 4.0, 6.0, -3.0));
	block[1].u = (4u);
	block[2].s.a = (uvec3(1u, 5u, 2u));
	block[2].s.b[0] = (vec2(3.0, -1.0));
	block[2].s.b[1] = (vec2(8.0, 9.0));
	block[2].s.b[2] = (vec2(-9.0, 9.0));
	block[2].s.b[3] = (vec2(0.0, 7.0));
	block[2].s.c = (vec4(-5.0, -9.0, -5.0, 3.0));
	block[2].u = (3u);
}
#version 450
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
	highp ivec3 var;
} block[3];

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].var), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((block[1].var), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((block[2].var), ivec3(3, -1, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (ivec3(-5, 0, -9));
	block[1].var = (ivec3(2, 4, 1));
	block[2].var = (ivec3(6, 6, 2));
}
#version 450
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
	highp mat3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(block[0].var, mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block[1].var, mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].var, mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(3.0, -9.0, 3.0));
	block[0].var[1] = (vec3(2.0, 4.0, 6.0));
	block[0].var[2] = (vec3(2.0, -9.0, 0.0));
	block[1].var[0] = (vec3(-7.0, 3.0, -3.0));
	block[1].var[1] = (vec3(-4.0, -4.0, 5.0));
	block[1].var[2] = (vec3(-4.0, 1.0, -7.0));
	block[2].var[0] = (vec3(7.0, 9.0, -7.0));
	block[2].var[1] = (vec3(8.0, 2.0, 5.0));
	block[2].var[2] = (vec3(-9.0, 7.0, -2.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	highp mat2x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(block[0].var, mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	block[1].var = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	block[2].var = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
}
#version 450
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
	u16vec2 var;
} block[3];

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(block[0].var), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block[1].var), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block[2].var), uvec2(6u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = u16vec2(uvec2(8u, 0u));
	block[1].var = u16vec2(uvec2(6u, 0u));
	block[2].var = u16vec2(uvec2(6u, 9u));
}
#version 450
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
	highp uvec3 var;
} block[3];

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block[0].padding), 9u) && allOk;
	allOk = compare_uvec3((block[0].var), uvec3(6u, 4u, 7u)) && allOk;
	allOk = compare_uint((block[1].padding), 2u) && allOk;
	allOk = compare_uvec3((block[1].var), uvec3(7u, 5u, 0u)) && allOk;
	allOk = compare_uint((block[2].padding), 2u) && allOk;
	allOk = compare_uvec3((block[2].var), uvec3(6u, 8u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (3u);
	block[0].var = (uvec3(5u, 6u, 5u));
	block[1].padding = (4u);
	block[1].var = (uvec3(5u, 4u, 9u));
	block[2].padding = (4u);
	block[2].var = (uvec3(4u, 7u, 7u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, binding = 1) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
} blockA[3];
layout(std140, binding = 2) buffer BlockB
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
	allOk = compare_float((blockA[0].a), 4.0) && allOk;
	allOk = compare_mat2(blockA[0].c, mat2(-8.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_float((blockA[1].a), 5.0) && allOk;
	allOk = compare_mat2(blockA[1].c, mat2(2.0, -8.0, 0.0, 6.0)) && allOk;
	allOk = compare_float((blockA[2].a), 0.0) && allOk;
	allOk = compare_mat2(blockA[2].c, mat2(9.0, 2.0, -8.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(0, 6)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-3, 6)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(-3, -5)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (5.0);
	blockA[1].a = (5.0);
	blockA[2].a = (2.0);
	blockB[0].a[0] = (vec3(9.0, 2.0, -4.0));
	blockB[0].a[1] = (vec3(4.0, 3.0, -1.0));
	blockB[0].a[2] = (vec3(4.0, -3.0, 1.0));
	blockB[0].d = (false);
	blockB[1].a[0] = (vec3(8.0, -1.0, 8.0));
	blockB[1].a[1] = (vec3(-2.0, -4.0, 0.0));
	blockB[1].a[2] = (vec3(7.0, -3.0, -1.0));
	blockB[1].d = (true);
	blockB[2].a[0] = (vec3(-4.0, 3.0, -2.0));
	blockB[2].a[1] = (vec3(-5.0, 6.0, -9.0));
	blockB[2].a[2] = (vec3(-8.0, 4.0, -6.0));
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
	highp vec2 a;
	mediump int b;
	mediump uvec2 c;
	mediump uint d;
};
layout(std430, binding = 2) buffer BlockC
{
	bool e;
	mediump vec4 f;
	bool g;
	highp uvec4 h;
};
layout(std140, binding = 3) readonly buffer BlockD
{
	bvec3 i;
	mediump int j;
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	highp float k;
	highp float l;
	lowp vec2 m;
	bvec3 n;
	highp ivec3 o[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((e), false) && allOk;
	allOk = compare_bool((g), false) && allOk;
	allOk = compare_uvec4((h), uvec4(4u, 1u, 4u, 9u)) && allOk;
	allOk = compare_bvec3((blockD.i), bvec3(false, false, true)) && allOk;
	allOk = compare_int((blockD.j), 1) && allOk;
	allOk = compare_float((k), 7.0) && allOk;
	allOk = compare_vec2((m), vec2(9.0, -5.0)) && allOk;
	allOk = compare_bvec3((n), bvec3(false, false, true)) && allOk;
	allOk = compare_ivec3((o[0]), ivec3(-6, 8, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec2(-5.0, 9.0));
	b = (5);
	c = (uvec2(8u, 7u));
	d = (4u);
	e = (true);
	f = (vec4(-9.0, 2.0, 6.0, 1.0));
	g = (true);
	h = (uvec4(2u, 9u, 6u, 7u));
	l = (-4.0);
	n = (bvec3(false, false, false));
	o[0] = (ivec3(5, 3, -3));
}
#version 450
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
	lowp ivec4 a;
	lowp uint b;
	lowp ivec3 c;
	highp vec2 d;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	mediump uint e;
	mediump vec2 f;
	lowp uvec2 g;
	highp float h;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	highp int i;
	bvec2 j;
	lowp vec2 k;
	mediump ivec2 l;
};
layout(std140, binding = 4) buffer BlockE
{
	bool m;
	lowp ivec2 n;
	lowp uvec2 o;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(2, -3, 2, -4)) && allOk;
	allOk = compare_uint((blockB.b), 1u) && allOk;
	allOk = compare_ivec3((blockB.c), ivec3(6, -2, -5)) && allOk;
	allOk = compare_uint((blockC.e), 9u) && allOk;
	allOk = compare_vec2((blockC.f), vec2(-3.0, 8.0)) && allOk;
	allOk = compare_uvec2((blockC.g), uvec2(9u, 8u)) && allOk;
	allOk = compare_int((i), -4) && allOk;
	allOk = compare_bvec2((j), bvec2(false, true)) && allOk;
	allOk = compare_ivec2((l), ivec2(-3, -7)) && allOk;
	allOk = compare_bool((m), false) && allOk;
	allOk = compare_ivec2((n), ivec2(-1, 9)) && allOk;
	allOk = compare_uvec2((o), uvec2(7u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(8, 7, -2, 6));
	blockB.c = (ivec3(5, 9, -5));
	blockB.d = (vec2(4.0, 7.0));
	blockC.e = (0u);
	blockC.f = (vec2(6.0, 5.0));
	i = (-7);
	k = (vec2(4.0, -2.0));
	m = (true);
	n = (ivec2(-7, 4));
	o = (uvec2(0u, 7u));
}
#version 450
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
	lowp float a;
	lowp int b[1];
};
layout(std430, binding = 2) readonly buffer BlockC
{
	bvec2 c[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((a), -2.0) && allOk;
	allOk = compare_bvec2((c[0]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (-7.0);
	b[0] = (3);
}
#version 450
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
	highp vec2 a;
	bool b;
	mediump mat2 c;
	bvec4 d;
	highp ivec3 e[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	bool f;
	highp mat3x4 g[6];
	lowp vec3 h;
	lowp mat2x3 i;
	mediump ivec2 j;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	mediump ivec3 k[8];
	mediump vec4 l;
	highp vec2 m;
	mediump vec3 n[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockC.g[0], mat3x4(6.0, -7.0, 5.0, -9.0, 3.0, -2.0, 6.0, -2.0, 1.0, -6.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockC.g[1], mat3x4(7.0, 9.0, 1.0, -8.0, 1.0, 6.0, -5.0, 3.0, 6.0, 9.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockC.g[2], mat3x4(-5.0, -3.0, 3.0, 2.0, 1.0, -2.0, 4.0, 2.0, -3.0, 4.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockC.g[3], mat3x4(9.0, 8.0, 9.0, 1.0, -6.0, -7.0, -7.0, 1.0, -6.0, -2.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockC.g[4], mat3x4(1.0, -1.0, -8.0, -9.0, 2.0, -6.0, 9.0, -5.0, 5.0, 8.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockC.g[5], mat3x4(-4.0, 3.0, -3.0, 5.0, -9.0, 6.0, 6.0, -7.0, -5.0, 3.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec3((blockC.h), vec3(2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockC.i, mat2x3(2.0, -6.0, 7.0, -7.0, -2.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockC.j), ivec2(-2, -2)) && allOk;
	allOk = compare_ivec3((blockD.k[0]), ivec3(-9, 3, -6)) && allOk;
	allOk = compare_ivec3((blockD.k[1]), ivec3(8, -1, -3)) && allOk;
	allOk = compare_ivec3((blockD.k[2]), ivec3(-9, -4, -2)) && allOk;
	allOk = compare_ivec3((blockD.k[3]), ivec3(-6, -7, -8)) && allOk;
	allOk = compare_ivec3((blockD.k[4]), ivec3(-5, -5, 9)) && allOk;
	allOk = compare_ivec3((blockD.k[5]), ivec3(0, 0, -8)) && allOk;
	allOk = compare_ivec3((blockD.k[6]), ivec3(5, -6, 0)) && allOk;
	allOk = compare_ivec3((blockD.k[7]), ivec3(-1, -8, -7)) && allOk;
	allOk = compare_vec4((blockD.l), vec4(-4.0, 4.0, 5.0, 0.0)) && allOk;
	allOk = compare_vec2((blockD.m), vec2(-1.0, 8.0)) && allOk;
	allOk = compare_vec3((blockD.n[0]), vec3(8.0, 4.0, -4.0)) && allOk;
	allOk = compare_vec3((blockD.n[1]), vec3(9.0, 9.0, 8.0)) && allOk;
	allOk = compare_vec3((blockD.n[2]), vec3(6.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(-5.0, 4.0));
	blockB.b = (false);
	blockB.c = (mat2(-7.0, -8.0, 8.0, 4.0));
	blockB.d = (bvec4(true, true, true, true));
	blockB.e[0] = (ivec3(0, 9, 3));
	blockB.e[1] = (ivec3(1, -6, 4));
	blockB.e[2] = (ivec3(-4, -6, 9));
	blockC.f = (false);
	blockC.g[0] = (mat3x4(7.0, 7.0, -8.0, 5.0, -2.0, -7.0, -2.0, 5.0, 0.0, -1.0, 5.0, 4.0));
	blockC.g[1] = (mat3x4(-9.0, -1.0, -1.0, 7.0, -1.0, -7.0, 7.0, 4.0, -3.0, 1.0, 6.0, 5.0));
	blockC.g[2] = (mat3x4(8.0, 5.0, -1.0, -1.0, -1.0, 2.0, -8.0, -1.0, -2.0, -8.0, 1.0, -7.0));
	blockC.g[3] = (mat3x4(-3.0, 3.0, -6.0, 1.0, -1.0, -1.0, 1.0, 2.0, -5.0, -4.0, 4.0, 7.0));
	blockC.g[4] = (mat3x4(-2.0, 8.0, -5.0, -9.0, 2.0, 3.0, 1.0, -5.0, -2.0, 5.0, -1.0, 0.0));
	blockC.g[5] = (mat3x4(-2.0, 2.0, -7.0, -7.0, -7.0, 9.0, -6.0, -8.0, 6.0, 5.0, 3.0, 2.0));
	blockC.j = (ivec2(-8, 7));
	blockD.k[0] = (ivec3(3, -6, -5));
	blockD.k[1] = (ivec3(1, 6, 6));
	blockD.k[2] = (ivec3(4, 8, 0));
	blockD.k[3] = (ivec3(-8, 1, -1));
	blockD.k[4] = (ivec3(-7, 5, 9));
	blockD.k[5] = (ivec3(0, -2, 1));
	blockD.k[6] = (ivec3(5, -6, 4));
	blockD.k[7] = (ivec3(-2, 5, -5));
	blockD.l = (vec4(6.0, -3.0, -7.0, 6.0));
	blockD.m = (vec2(8.0, 9.0));
}
#version 450
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
	lowp uvec3 mB;
};
struct sB
{
	mediump float mA;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	mediump vec2 a;
	highp int b;
	highp uint c;
	lowp mat4 d;
};
layout(std140, binding = 2) buffer BlockC
{
	sA e;
	lowp uvec4 f;
	highp int g;
	bool h[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	bvec2 i;
	lowp ivec2 j;
	highp uvec3 k;
	highp vec3 l[];
} blockD;
layout(std430, row_major, binding = 4) buffer BlockE
{
	sB m;
	lowp mat4x2 n[7];
	lowp mat2 o;
	lowp mat4x2 p[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((a), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_mat4(d, mat4(-1.0, 0.0, -3.0, 9.0, -2.0, 0.0, 3.0, -3.0, 2.0, -3.0, 8.0, 8.0, -3.0, 8.0, 5.0, -7.0)) && allOk;
	allOk = compare_bool((h[0]), false) && allOk;
	allOk = compare_bool((h[1]), true) && allOk;
	allOk = compare_bool((h[2]), true) && allOk;
	allOk = compare_bool((h[3]), true) && allOk;
	allOk = compare_bool((h[4]), false) && allOk;
	allOk = compare_bool((h[5]), true) && allOk;
	allOk = compare_bool((h[6]), false) && allOk;
	allOk = compare_bool((h[7]), true) && allOk;
	allOk = compare_ivec2((blockD.j), ivec2(-3, -6)) && allOk;
	allOk = compare_uvec3((blockD.k), uvec3(8u, 7u, 2u)) && allOk;
	allOk = compare_float((m.mA), -8.0) && allOk;
	allOk = compare_mat2(o, mat2(2.0, -3.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x2(p[0], mat4x2(4.0, 7.0, 3.0, -8.0, 1.0, 8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(p[1], mat4x2(0.0, 7.0, -9.0, 2.0, 6.0, 7.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4x2(p[2], mat4x2(-8.0, -9.0, -5.0, -1.0, 7.0, 6.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(p[3], mat4x2(-1.0, 4.0, -7.0, 3.0, 1.0, 2.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(p[4], mat4x2(-8.0, -8.0, -8.0, -1.0, -9.0, 0.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x2(p[5], mat4x2(-1.0, -6.0, -8.0, 2.0, -7.0, -6.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(p[6], mat4x2(-8.0, -9.0, -9.0, -5.0, 6.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(p[7], mat4x2(8.0, 5.0, -4.0, -5.0, 7.0, -4.0, -2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (-4);
	c = (4u);
	g = (2);
	blockD.i = (bvec2(true, true));
	blockD.j = (ivec2(0, 5));
	blockD.k = (uvec3(1u, 4u, 6u));
	m.mA = (-4.0);
	n[0] = (mat4x2(3.0, -5.0, -7.0, 5.0, 1.0, -5.0, -7.0, -6.0));
	n[1] = (mat4x2(-6.0, 9.0, -6.0, -3.0, -3.0, -7.0, 2.0, -9.0));
	n[2] = (mat4x2(8.0, -9.0, 6.0, 0.0, -1.0, 8.0, 6.0, -1.0));
	n[3] = (mat4x2(0.0, 9.0, -2.0, 6.0, -4.0, -2.0, 2.0, 6.0));
	n[4] = (mat4x2(-4.0, -2.0, -5.0, -4.0, -2.0, 8.0, 0.0, 8.0));
	n[5] = (mat4x2(9.0, -7.0, 7.0, -8.0, -3.0, -8.0, -5.0, 1.0));
	n[6] = (mat4x2(6.0, -7.0, 6.0, -9.0, -6.0, -2.0, -4.0, -5.0));
	o = (mat2(1.0, 0.0, 7.0, -3.0));
	p[0] = (mat4x2(5.0, 0.0, -2.0, -5.0, 4.0, -5.0, -4.0, 1.0));
	p[1] = (mat4x2(3.0, 6.0, -8.0, 6.0, -9.0, -9.0, -4.0, -2.0));
	p[2] = (mat4x2(3.0, 6.0, 3.0, 4.0, 5.0, 1.0, 1.0, -4.0));
	p[3] = (mat4x2(1.0, -9.0, 5.0, 8.0, 4.0, -6.0, 4.0, -3.0));
	p[4] = (mat4x2(9.0, -4.0, 3.0, -3.0, -7.0, -9.0, 0.0, -1.0));
	p[5] = (mat4x2(-8.0, -4.0, -1.0, 2.0, 4.0, 2.0, 5.0, 1.0));
	p[6] = (mat4x2(-3.0, 4.0, 4.0, -1.0, 0.0, -4.0, -8.0, -7.0));
	p[7] = (mat4x2(3.0, -4.0, 5.0, 9.0, -1.0, -2.0, -2.0, -5.0));
}
#version 450
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
	mediump uvec3 b;
	highp mat3x2 c;
	highp mat2x3 d;
	highp vec4 e;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.c, mat3x2(4.0, 4.0, 9.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockB.d, mat2x3(8.0, 0.0, 4.0, -4.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec4((blockB.e), vec4(-1.0, 7.0, -5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(6.0, -1.0, 0.0, 3.0, -7.0, 6.0, -7.0, 6.0));
	blockB.b = (uvec3(2u, 4u, 4u));
	blockB.c = (mat3x2(3.0, -2.0, 5.0, -2.0, 6.0, 7.0));
	blockB.d = (mat2x3(-5.0, -5.0, -2.0, -2.0, 7.0, -2.0));
	blockB.e = (vec4(1.0, 3.0, -9.0, -2.0));
}
#version 450
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
	bvec2 mA[2][6];
	bvec3 mB;
};
struct sB
{
	mediump vec4 mA;
};
layout(std140, binding = 1) buffer BlockB
{
	mediump mat4x2 a;
	highp mat3 b;
	lowp mat4 c[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	bool d;
	bvec2 e;
	mediump mat4x2 f[];
} blockC[2];
layout(std140, row_major, binding = 3) buffer BlockD
{
	sA g;
	sB h[];
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(-4.0, 6.0, 6.0, -7.0, -9.0, 5.0, -4.0, -9.0)) && allOk;
	allOk = compare_bvec2((blockC[0].e), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[1].e), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[0].g.mA[0][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[0].g.mA[0][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[0].g.mA[0][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[0].g.mA[0][3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[0].g.mA[0][4]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[0].g.mA[0][5]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[0].g.mA[1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[0].g.mA[1][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[0].g.mA[1][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[0].g.mA[1][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[0].g.mA[1][4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[0].g.mA[1][5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec3((blockD[0].g.mB), bvec3(false, false, false)) && allOk;
	allOk = compare_vec4((blockD[0].h[0].mA), vec4(7.0, 8.0, 9.0, -3.0)) && allOk;
	allOk = compare_bvec2((blockD[1].g.mA[0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[1].g.mA[0][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[1].g.mA[0][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[1].g.mA[0][3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[1].g.mA[0][4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[1].g.mA[0][5]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[1].g.mA[1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[1].g.mA[1][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[1].g.mA[1][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[1].g.mA[1][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[1].g.mA[1][4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[1].g.mA[1][5]), bvec2(false, true)) && allOk;
	allOk = compare_bvec3((blockD[1].g.mB), bvec3(true, true, false)) && allOk;
	allOk = compare_vec4((blockD[1].h[0].mA), vec4(-1.0, -6.0, 3.0, 5.0)) && allOk;
	allOk = compare_vec4((blockD[1].h[1].mA), vec4(-2.0, 5.0, -2.0, 7.0)) && allOk;
	allOk = compare_vec4((blockD[1].h[2].mA), vec4(-6.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_vec4((blockD[1].h[3].mA), vec4(-9.0, -1.0, -3.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD[1].h[4].mA), vec4(-1.0, 9.0, 0.0, -8.0)) && allOk;
	allOk = compare_vec4((blockD[1].h[5].mA), vec4(0.0, -1.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec4((blockD[1].h[6].mA), vec4(-6.0, -2.0, -3.0, 2.0)) && allOk;
	allOk = compare_vec4((blockD[1].h[7].mA), vec4(-7.0, 2.0, 8.0, 0.0)) && allOk;
	allOk = compare_bvec2((blockD[2].g.mA[0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[2].g.mA[0][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[2].g.mA[0][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[2].g.mA[0][3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[2].g.mA[0][4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[2].g.mA[0][5]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[2].g.mA[1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[2].g.mA[1][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[2].g.mA[1][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[2].g.mA[1][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[2].g.mA[1][4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[2].g.mA[1][5]), bvec2(true, false)) && allOk;
	allOk = compare_bvec3((blockD[2].g.mB), bvec3(false, false, true)) && allOk;
	allOk = compare_vec4((blockD[2].h[0].mA), vec4(4.0, 8.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec4((blockD[2].h[1].mA), vec4(0.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec4((blockD[2].h[2].mA), vec4(-4.0, -4.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec4((blockD[2].h[3].mA), vec4(8.0, 6.0, 5.0, -3.0)) && allOk;
	allOk = compare_vec4((blockD[2].h[4].mA), vec4(1.0, -4.0, -6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(9.0, -7.0, -5.0, -9.0, -8.0, 0.0, 8.0, 0.0));
	blockC[0].d = (true);
	blockC[0].e = (bvec2(false, false));
	blockC[0].f[0] = (mat4x2(-2.0, 1.0, 0.0, 2.0, -9.0, 0.0, 7.0, -3.0));
	blockC[0].f[1] = (mat4x2(-5.0, 8.0, 2.0, 2.0, -2.0, -1.0, 4.0, -3.0));
	blockC[0].f[2] = (mat4x2(-1.0, -2.0, 2.0, -3.0, -1.0, -6.0, -4.0, 3.0));
	blockC[0].f[3] = (mat4x2(-8.0, 6.0, 7.0, -3.0, -2.0, -3.0, 0.0, 7.0));
	blockC[0].f[4] = (mat4x2(3.0, -1.0, -9.0, 0.0, 3.0, -4.0, -5.0, 0.0));
	blockC[1].d = (true);
	blockC[1].e = (bvec2(true, false));
	blockC[1].f[0] = (mat4x2(-8.0, 1.0, 1.0, -6.0, -1.0, -1.0, 5.0, -2.0));
	blockC[1].f[1] = (mat4x2(8.0, -2.0, -6.0, -6.0, 6.0, 2.0, 1.0, 4.0));
	blockC[1].f[2] = (mat4x2(7.0, -4.0, -9.0, -5.0, 3.0, 8.0, -5.0, 5.0));
	blockC[1].f[3] = (mat4x2(7.0, -3.0, -7.0, 2.0, -8.0, 1.0, -4.0, -1.0));
	blockC[1].f[4] = (mat4x2(2.0, -3.0, 5.0, 8.0, -4.0, -7.0, 7.0, 1.0));
	blockC[1].f[5] = (mat4x2(-6.0, -3.0, -4.0, 6.0, -4.0, 5.0, 4.0, 1.0));
	blockC[1].f[6] = (mat4x2(-4.0, -8.0, 8.0, 4.0, 6.0, 0.0, 7.0, -2.0));
	blockC[1].f[7] = (mat4x2(-8.0, 3.0, -3.0, -2.0, -7.0, -2.0, -3.0, -5.0));
	blockD[0].g.mA[0][0] = (bvec2(false, false));
	blockD[0].g.mA[0][1] = (bvec2(true, false));
	blockD[0].g.mA[0][2] = (bvec2(false, false));
	blockD[0].g.mA[0][3] = (bvec2(true, false));
	blockD[0].g.mA[0][4] = (bvec2(false, false));
	blockD[0].g.mA[0][5] = (bvec2(false, false));
	blockD[0].g.mA[1][0] = (bvec2(false, true));
	blockD[0].g.mA[1][1] = (bvec2(false, false));
	blockD[0].g.mA[1][2] = (bvec2(false, false));
	blockD[0].g.mA[1][3] = (bvec2(true, true));
	blockD[0].g.mA[1][4] = (bvec2(false, true));
	blockD[0].g.mA[1][5] = (bvec2(true, true));
	blockD[0].g.mB = (bvec3(false, false, false));
	blockD[0].h[0].mA = (vec4(8.0, -5.0, -4.0, -9.0));
	blockD[1].g.mA[0][0] = (bvec2(true, false));
	blockD[1].g.mA[0][1] = (bvec2(true, true));
	blockD[1].g.mA[0][2] = (bvec2(false, true));
	blockD[1].g.mA[0][3] = (bvec2(false, false));
	blockD[1].g.mA[0][4] = (bvec2(false, true));
	blockD[1].g.mA[0][5] = (bvec2(false, true));
	blockD[1].g.mA[1][0] = (bvec2(false, true));
	blockD[1].g.mA[1][1] = (bvec2(false, false));
	blockD[1].g.mA[1][2] = (bvec2(true, true));
	blockD[1].g.mA[1][3] = (bvec2(false, true));
	blockD[1].g.mA[1][4] = (bvec2(false, true));
	blockD[1].g.mA[1][5] = (bvec2(false, false));
	blockD[1].g.mB = (bvec3(true, true, false));
	blockD[1].h[0].mA = (vec4(8.0, -4.0, -2.0, -5.0));
	blockD[1].h[1].mA = (vec4(4.0, 5.0, 3.0, -2.0));
	blockD[1].h[2].mA = (vec4(9.0, -8.0, -6.0, 8.0));
	blockD[1].h[3].mA = (vec4(-6.0, -5.0, 1.0, 2.0));
	blockD[1].h[4].mA = (vec4(3.0, 3.0, 0.0, 7.0));
	blockD[1].h[5].mA = (vec4(2.0, -8.0, -5.0, 0.0));
	blockD[1].h[6].mA = (vec4(1.0, 0.0, 1.0, 9.0));
	blockD[1].h[7].mA = (vec4(5.0, 7.0, 6.0, -5.0));
	blockD[2].g.mA[0][0] = (bvec2(false, true));
	blockD[2].g.mA[0][1] = (bvec2(true, false));
	blockD[2].g.mA[0][2] = (bvec2(false, false));
	blockD[2].g.mA[0][3] = (bvec2(true, false));
	blockD[2].g.mA[0][4] = (bvec2(true, false));
	blockD[2].g.mA[0][5] = (bvec2(false, false));
	blockD[2].g.mA[1][0] = (bvec2(false, false));
	blockD[2].g.mA[1][1] = (bvec2(false, true));
	blockD[2].g.mA[1][2] = (bvec2(true, true));
	blockD[2].g.mA[1][3] = (bvec2(false, false));
	blockD[2].g.mA[1][4] = (bvec2(false, true));
	blockD[2].g.mA[1][5] = (bvec2(true, true));
	blockD[2].g.mB = (bvec3(true, false, true));
	blockD[2].h[0].mA = (vec4(-1.0, -5.0, 5.0, -9.0));
	blockD[2].h[1].mA = (vec4(6.0, -6.0, 8.0, 6.0));
	blockD[2].h[2].mA = (vec4(-2.0, -6.0, 3.0, -8.0));
	blockD[2].h[3].mA = (vec4(7.0, 7.0, -6.0, 4.0));
	blockD[2].h[4].mA = (vec4(-9.0, -9.0, -4.0, -1.0));
}
#version 450
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
layout(std140, column_major, binding = 1) buffer BlockB
{
	sA a;
	bvec3 b;
	mediump vec3 c;
	highp mat3x2 d;
	mediump mat2 e[];
} blockB[1];
layout(std140, binding = 2) buffer BlockC
{
	bvec4 f[];
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[0].b), bvec3(true, true, false)) && allOk;
	allOk = compare_vec3((blockB[0].c), vec3(-1.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockB[0].d, mat3x2(-6.0, 5.0, -7.0, 2.0, 8.0, 8.0)) && allOk;
	allOk = compare_bvec4((blockC[0].f[0]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockC[0].f[1]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC[0].f[2]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC[0].f[3]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC[0].f[4]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockC[1].f[0]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC[1].f[1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockC[1].f[2]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockC[1].f[3]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC[1].f[4]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockC[1].f[5]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((blockC[2].f[0]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC[2].f[1]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC[2].f[2]), bvec4(true, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (bvec3(false, true, true));
	blockB[0].c = (vec3(-8.0, 7.0, 6.0));
	blockB[0].d = (mat3x2(-4.0, 5.0, 7.0, 9.0, -2.0, 6.0));
	blockC[0].f[0] = (bvec4(false, false, true, false));
	blockC[0].f[1] = (bvec4(false, true, false, true));
	blockC[0].f[2] = (bvec4(true, false, true, false));
	blockC[0].f[3] = (bvec4(false, false, false, false));
	blockC[0].f[4] = (bvec4(true, true, false, true));
	blockC[1].f[0] = (bvec4(false, false, true, false));
	blockC[1].f[1] = (bvec4(false, true, false, true));
	blockC[1].f[2] = (bvec4(false, false, true, true));
	blockC[1].f[3] = (bvec4(false, false, true, false));
	blockC[1].f[4] = (bvec4(false, false, false, false));
	blockC[1].f[5] = (bvec4(true, false, true, true));
	blockC[2].f[0] = (bvec4(false, true, false, false));
	blockC[2].f[1] = (bvec4(true, false, false, false));
	blockC[2].f[2] = (bvec4(false, false, true, true));
}
#version 450
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
	mediump mat3x4 mA;
	highp vec4 mB;
	bvec4 mC[7];
};
layout(std140, binding = 1) buffer BlockB
{
	lowp uvec2 a[2];
	sA b;
	bvec4 c;
	lowp mat4x3 d[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	bvec3 e;
	lowp mat4x2 f[][1];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((a[0]), uvec2(5u, 3u)) && allOk;
	allOk = compare_uvec2((a[1]), uvec2(6u, 4u)) && allOk;
	allOk = compare_mat3x4(b.mA, mat3x4(-1.0, 8.0, 8.0, 0.0, -3.0, 5.0, 6.0, 8.0, -8.0, 9.0, -4.0, 9.0)) && allOk;
	allOk = compare_vec4((b.mB), vec4(3.0, -5.0, -8.0, 3.0)) && allOk;
	allOk = compare_bvec4((b.mC[0]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((b.mC[1]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((b.mC[2]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((b.mC[3]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((b.mC[4]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((b.mC[5]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((b.mC[6]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((c), bvec4(false, false, false, true)) && allOk;
	allOk = compare_mat4x3(d[0], mat4x3(8.0, -1.0, 5.0, 6.0, -4.0, 9.0, 0.0, -5.0, -2.0, -7.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(d[1], mat4x3(8.0, -1.0, 4.0, -2.0, -3.0, -4.0, 5.0, 9.0, -4.0, -5.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(d[2], mat4x3(8.0, -6.0, 9.0, -9.0, 5.0, -9.0, -5.0, -6.0, 2.0, 3.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4x3(d[3], mat4x3(-5.0, 5.0, -5.0, -1.0, 1.0, -5.0, -4.0, -1.0, -1.0, 6.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(d[4], mat4x3(-4.0, 3.0, 6.0, 6.0, 0.0, -8.0, 5.0, -6.0, 3.0, -5.0, 9.0, -8.0)) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (uvec2(9u, 2u));
	a[1] = (uvec2(2u, 6u));
	b.mA = (mat3x4(6.0, -9.0, 4.0, 0.0, -5.0, 0.0, -7.0, -6.0, -7.0, 3.0, 9.0, -4.0));
	b.mB = (vec4(1.0, -6.0, 4.0, 6.0));
	b.mC[0] = (bvec4(false, false, true, false));
	b.mC[1] = (bvec4(true, true, true, true));
	b.mC[2] = (bvec4(true, false, false, true));
	b.mC[3] = (bvec4(false, true, true, false));
	b.mC[4] = (bvec4(true, true, true, true));
	b.mC[5] = (bvec4(true, true, true, false));
	b.mC[6] = (bvec4(true, true, false, true));
	c = (bvec4(false, false, false, false));
	d[0] = (mat4x3(1.0, 1.0, 6.0, 7.0, -8.0, 9.0, 4.0, -4.0, 7.0, -5.0, -4.0, 1.0));
	d[1] = (mat4x3(7.0, -3.0, 9.0, 5.0, 5.0, -7.0, 1.0, -3.0, -5.0, 2.0, -2.0, -8.0));
	d[2] = (mat4x3(3.0, 8.0, -9.0, -5.0, -6.0, 7.0, -2.0, -3.0, -4.0, 1.0, 0.0, 2.0));
	d[3] = (mat4x3(0.0, -7.0, 4.0, 5.0, -8.0, 5.0, 7.0, -7.0, 1.0, 1.0, 9.0, 7.0));
	d[4] = (mat4x3(9.0, 5.0, 7.0, -7.0, 7.0, -7.0, -8.0, 0.0, 2.0, 9.0, 7.0, 7.0));
	blockC.f[0][0] = (mat4x2(1.0, -4.0, 9.0, -8.0, -7.0, 1.0, 7.0, -2.0));
	blockC.f[1][0] = (mat4x2(-4.0, -6.0, 6.0, 6.0, -9.0, 8.0, 3.0, 3.0));
	blockC.f[2][0] = (mat4x2(-1.0, 8.0, -6.0, 5.0, 3.0, -5.0, -1.0, -1.0));
	blockC.f[3][0] = (mat4x2(-4.0, 2.0, -4.0, -4.0, -2.0, -9.0, -2.0, 2.0));
}
#version 450
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
	highp mat4x3 mA[2];
};
struct sB
{
	bvec2 mA;
	lowp mat4x3 mB;
	mediump mat2 mC;
	sA mD;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	lowp mat3x2 a;
	lowp mat2 b;
	mediump mat4 c;
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	bvec3 d;
	bvec4 e[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	bvec2 f;
	sB g[];
};
layout(std430, row_major, binding = 4) buffer BlockE
{
	highp vec3 h;
	mediump ivec2 i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(6.0, 1.0, -3.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4(blockB.c, mat4(-4.0, 4.0, 7.0, 4.0, -1.0, -8.0, -8.0, -3.0, -5.0, -3.0, 0.0, 7.0, -5.0, -5.0, 5.0, 6.0)) && allOk;
	allOk = compare_bvec3((blockC.d), bvec3(true, false, false)) && allOk;
	allOk = compare_vec3((h), vec3(8.0, 3.0, 2.0)) && allOk;
	allOk = compare_ivec2((i[0]), ivec2(9, -7)) && allOk;
	allOk = compare_ivec2((i[1]), ivec2(9, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat2(5.0, -3.0, -8.0, 5.0));
	blockC.d = (bvec3(false, true, false));
	blockC.e[0] = (bvec4(true, true, true, true));
	blockC.e[1] = (bvec4(true, false, false, true));
	blockC.e[2] = (bvec4(true, true, false, false));
	g[0].mA = (bvec2(false, true));
	g[0].mB = (mat4x3(-6.0, -3.0, 7.0, 1.0, -7.0, 3.0, -6.0, -9.0, 7.0, -4.0, -1.0, -3.0));
	g[0].mC = (mat2(-9.0, -8.0, 5.0, -1.0));
	g[0].mD.mA[0] = (mat4x3(3.0, 1.0, 2.0, -7.0, -1.0, 6.0, -1.0, -3.0, 3.0, -8.0, 0.0, -9.0));
	g[0].mD.mA[1] = (mat4x3(-2.0, -2.0, 9.0, 8.0, -7.0, 1.0, -3.0, 8.0, 2.0, -4.0, -9.0, 1.0));
	g[1].mA = (bvec2(false, true));
	g[1].mB = (mat4x3(-5.0, -8.0, -7.0, 7.0, -1.0, 8.0, -8.0, 1.0, -3.0, 5.0, -1.0, -4.0));
	g[1].mC = (mat2(-4.0, -5.0, -5.0, -6.0));
	g[1].mD.mA[0] = (mat4x3(4.0, -3.0, -1.0, 4.0, -2.0, 8.0, -7.0, 1.0, -1.0, 7.0, 5.0, 8.0));
	g[1].mD.mA[1] = (mat4x3(7.0, 8.0, -1.0, -2.0, -3.0, 2.0, 3.0, 4.0, 3.0, -9.0, -4.0, -2.0));
	g[2].mA = (bvec2(false, false));
	g[2].mB = (mat4x3(7.0, 0.0, 6.0, 9.0, -7.0, -3.0, -6.0, -9.0, -6.0, 8.0, 3.0, 4.0));
	g[2].mC = (mat2(0.0, 6.0, -3.0, 9.0));
	g[2].mD.mA[0] = (mat4x3(9.0, -2.0, -2.0, -5.0, 4.0, -1.0, 2.0, -5.0, 9.0, -1.0, 2.0, -1.0));
	g[2].mD.mA[1] = (mat4x3(-8.0, 7.0, -6.0, 2.0, -5.0, -6.0, 9.0, -2.0, -8.0, -8.0, -6.0, 6.0));
	g[3].mA = (bvec2(false, false));
	g[3].mB = (mat4x3(-2.0, -9.0, 0.0, 5.0, 0.0, 7.0, -9.0, 4.0, 7.0, -7.0, 6.0, 0.0));
	g[3].mC = (mat2(2.0, 6.0, 7.0, -5.0));
	g[3].mD.mA[0] = (mat4x3(6.0, -5.0, 1.0, -7.0, -9.0, 5.0, 2.0, 4.0, 6.0, -2.0, -7.0, 8.0));
	g[3].mD.mA[1] = (mat4x3(-2.0, 7.0, -3.0, 0.0, 5.0, -4.0, 7.0, 8.0, -5.0, -1.0, -5.0, 0.0));
	g[4].mA = (bvec2(true, true));
	g[4].mB = (mat4x3(-3.0, 5.0, -1.0, -9.0, -3.0, 5.0, 8.0, -4.0, 9.0, 4.0, -5.0, -9.0));
	g[4].mC = (mat2(5.0, -9.0, 4.0, 5.0));
	g[4].mD.mA[0] = (mat4x3(-8.0, -7.0, 1.0, 4.0, 4.0, 7.0, 1.0, 7.0, -4.0, 8.0, 8.0, 9.0));
	g[4].mD.mA[1] = (mat4x3(4.0, 3.0, -4.0, 9.0, 1.0, 8.0, -4.0, -6.0, -9.0, 7.0, 5.0, -2.0));
	g[5].mA = (bvec2(true, true));
	g[5].mB = (mat4x3(6.0, 5.0, 4.0, -3.0, -4.0, 5.0, 3.0, -5.0, -5.0, -2.0, -5.0, -6.0));
	g[5].mC = (mat2(-5.0, -4.0, 2.0, -3.0));
	g[5].mD.mA[0] = (mat4x3(9.0, -1.0, -1.0, 7.0, -5.0, -7.0, 3.0, 7.0, -1.0, -8.0, 0.0, -1.0));
	g[5].mD.mA[1] = (mat4x3(-2.0, 5.0, 7.0, -3.0, -2.0, 2.0, 8.0, 4.0, -8.0, 7.0, 3.0, 0.0));
	h = (vec3(8.0, 1.0, -1.0));
	i[0] = (ivec2(3, -3));
	i[1] = (ivec2(0, -1));
}
#version 450
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
	layout(offset = 12) highp int b;
	layout(offset = 16) mediump uint c;
	layout(offset = 20) highp vec3 d;
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[0].b), -4) && allOk;
	allOk = compare_uint((blockB[0].c), 1u) && allOk;
	allOk = compare_vec3((blockB[0].d), vec3(6.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (ivec3(8, 7, -2));
	blockB[0].b = (6);
	blockB[0].c = (0u);
}
#version 450
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
	highp mat4x2 a;
	lowp uvec4 b;
	highp uvec4 c;
	mediump vec4 d;
	highp float e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((b), uvec4(3u, 8u, 7u, 6u)) && allOk;
	allOk = compare_uvec4((c), uvec4(1u, 7u, 1u, 2u)) && allOk;
	allOk = compare_vec4((d), vec4(-8.0, 7.0, -1.0, 2.0)) && allOk;
	allOk = compare_float((e[0]), 2.0) && allOk;
	allOk = compare_float((e[1]), 6.0) && allOk;
	allOk = compare_float((e[2]), 1.0) && allOk;
	allOk = compare_float((e[3]), 1.0) && allOk;
	allOk = compare_float((e[4]), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4x2(9.0, -2.0, -3.0, -7.0, 6.0, 2.0, -8.0, 7.0));
	c = (uvec4(6u, 2u, 6u, 3u));
	d = (vec4(0.0, 7.0, 5.0, -3.0));
	e[0] = (1.0);
	e[1] = (0.0);
	e[2] = (-8.0);
	e[3] = (-8.0);
	e[4] = (5.0);
}
#version 450
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
	int16_t a[1];
	mediump int b;
	float16_t c;
	lowp uint d;
	int16_t e;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	mediump int f;
	float16_t g;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	int16_t h;
	float16_t i;
	float16_t j;
	mediump float k;
	highp float l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.a[0]), 4) && allOk;
	allOk = compare_float16_t(float(blockB.c), 1.0) && allOk;
	allOk = compare_uint((blockB.d), 0u) && allOk;
	allOk = compare_int16_t(int(blockB.e), 1) && allOk;
	allOk = compare_int16_t(int(h), -4) && allOk;
	allOk = compare_float16_t(float(i), 2.0) && allOk;
	allOk = compare_float16_t(float(j), -9.0) && allOk;
	allOk = compare_float((k), 6.0) && allOk;
	allOk = compare_float((l), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = int16_t(5);
	blockB.b = (7);
	blockB.e = int16_t(1);
	blockC.f = (-2);
	h = int16_t(-3);
	i = float16_t(-9.0);
	k = (-2.0);
	l = (-4.0);
}
#version 450
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
	lowp uvec3 a;
	u16vec3 b;
	mediump vec4 c;
	f16vec3 d[1];
	i16vec3 e[1];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	mediump ivec2 f;
	uint16_t g;
	float16_t h[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.b), uvec3(5u, 3u, 6u)) && allOk;
	allOk = compare_vec4((blockB.c), vec4(1.0, 2.0, 8.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[0]), vec3(9.0, -8.0, 2.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.e[0]), ivec3(9, 6, -5)) && allOk;
	allOk = compare_float16_t(float(h[0]), 7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(5u, 2u, 5u));
	blockB.b = u16vec3(uvec3(7u, 0u, 4u));
	blockB.d[0] = f16vec3(vec3(3.0, 4.0, 7.0));
	blockB.e[0] = i16vec3(ivec3(8, 3, 8));
	g = uint16_t(7u);
	h[0] = float16_t(-6.0);
}
#version 450
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
	bool a;
	float16_t b;
	lowp uvec2 c[];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((c[0]), uvec2(1u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = float16_t(9.0);
	c[0] = (uvec2(0u, 9u));
}
#version 450
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
	mediump uvec2 mB[7];
};
struct sB
{
	highp uvec2 mA;
	lowp int mB;
	highp int mC;
	mediump mat3x2 mD;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	i16vec4 a;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	bool b;
	mediump vec3 c;
	int16_t d[];
};
layout(std430, binding = 3) buffer BlockD
{
	mediump uvec2 e;
	sA f;
	highp ivec3 g;
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	lowp mat4x3 h;
	highp float i;
	sB j;
	int16_t k;
	mediump mat2 l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.a), ivec4(-9, 9, 2, 0)) && allOk;
	allOk = compare_bool((b), true) && allOk;
	allOk = compare_vec3((c), vec3(5.0, -5.0, -2.0)) && allOk;
	allOk = compare_bvec4((blockD.f.mA[0]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((blockD.f.mA[1]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockD.f.mA[2]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((blockD.f.mA[3]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockD.f.mA[4]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_uvec2((blockD.f.mB[0]), uvec2(4u, 1u)) && allOk;
	allOk = compare_uvec2((blockD.f.mB[1]), uvec2(0u, 9u)) && allOk;
	allOk = compare_uvec2((blockD.f.mB[2]), uvec2(1u, 6u)) && allOk;
	allOk = compare_uvec2((blockD.f.mB[3]), uvec2(0u, 8u)) && allOk;
	allOk = compare_uvec2((blockD.f.mB[4]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((blockD.f.mB[5]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((blockD.f.mB[6]), uvec2(1u, 0u)) && allOk;
	allOk = compare_float((i), -9.0) && allOk;
	allOk = compare_uvec2((j.mA), uvec2(3u, 8u)) && allOk;
	allOk = compare_int((j.mB), -7) && allOk;
	allOk = compare_int((j.mC), -6) && allOk;
	allOk = compare_mat3x2(j.mD, mat3x2(-9.0, 2.0, 7.0, 3.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2(l[0], mat2(0.0, 4.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2(l[1], mat2(7.0, -3.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2(l[2], mat2(-5.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2(l[3], mat2(7.0, 7.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec4(ivec4(-9, -3, 8, 0));
	b = (false);
	blockD.f.mA[0] = (bvec4(false, false, false, true));
	blockD.f.mA[1] = (bvec4(false, false, false, false));
	blockD.f.mA[2] = (bvec4(true, false, false, false));
	blockD.f.mA[3] = (bvec4(false, false, false, false));
	blockD.f.mA[4] = (bvec4(true, false, false, false));
	blockD.f.mB[0] = (uvec2(9u, 0u));
	blockD.f.mB[1] = (uvec2(0u, 3u));
	blockD.f.mB[2] = (uvec2(0u, 0u));
	blockD.f.mB[3] = (uvec2(1u, 6u));
	blockD.f.mB[4] = (uvec2(5u, 5u));
	blockD.f.mB[5] = (uvec2(5u, 0u));
	blockD.f.mB[6] = (uvec2(9u, 3u));
	blockD.g = (ivec3(-2, -3, -1));
	i = (-3.0);
	j.mA = (uvec2(4u, 4u));
	j.mB = (0);
	j.mC = (-2);
	j.mD = (mat3x2(-3.0, -8.0, 1.0, 8.0, -6.0, -3.0));
	k = int16_t(1);
	l[0] = (mat2(6.0, -6.0, -9.0, 6.0));
	l[1] = (mat2(8.0, -8.0, 9.0, 5.0));
	l[2] = (mat2(-6.0, -6.0, -1.0, -6.0));
	l[3] = (mat2(-2.0, 3.0, -4.0, 7.0));
}
#version 450
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
	u16vec4 a[3];
	highp uvec2 b[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	bool c;
	lowp mat4 d[][1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.a[0]), uvec4(8u, 9u, 7u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.a[1]), uvec4(2u, 4u, 4u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.a[2]), uvec4(4u, 1u, 7u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.b[0]), uvec2(4u, 7u)) && allOk;
	allOk = compare_uvec2((blockB.b[1]), uvec2(2u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.b[2]), uvec2(5u, 7u)) && allOk;
	allOk = compare_uvec2((blockB.b[3]), uvec2(4u, 5u)) && allOk;
	allOk = compare_bool((c), true) && allOk;
	allOk = compare_mat4(d[0][0], mat4(2.0, -6.0, -8.0, 9.0, -9.0, 8.0, -6.0, -5.0, -9.0, -3.0, -5.0, 3.0, 0.0, 7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(d[1][0], mat4(-4.0, 1.0, 1.0, -4.0, -5.0, -1.0, 2.0, 4.0, -2.0, 2.0, -1.0, 8.0, -8.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(d[2][0], mat4(-1.0, -8.0, -7.0, 4.0, -5.0, 4.0, 7.0, -4.0, 1.0, -1.0, -8.0, 8.0, 0.0, -3.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(d[3][0], mat4(9.0, 0.0, 9.0, -5.0, -9.0, 7.0, -6.0, 1.0, -3.0, -7.0, 1.0, -6.0, -2.0, -6.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4(d[4][0], mat4(-8.0, 1.0, -8.0, -1.0, -6.0, -9.0, -8.0, -2.0, 8.0, 7.0, -2.0, -5.0, 9.0, -8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(d[5][0], mat4(6.0, -8.0, -7.0, 9.0, 9.0, -7.0, -8.0, 4.0, 3.0, -8.0, 9.0, -8.0, -7.0, -2.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat4(d[6][0], mat4(-6.0, 0.0, 8.0, 9.0, -7.0, 9.0, -3.0, -8.0, 8.0, 4.0, -6.0, 2.0, 8.0, 2.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = u16vec4(uvec4(4u, 0u, 2u, 8u));
	blockB.a[1] = u16vec4(uvec4(3u, 2u, 5u, 2u));
	blockB.a[2] = u16vec4(uvec4(5u, 2u, 2u, 1u));
	c = (true);
}
#version 450
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
	lowp uvec2 a[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp ivec4 b[4];
	f16vec2 c[3];
	mediump mat4x3 d;
} blockC[2];
layout(std430, column_major, binding = 3) buffer BlockD
{
	uint16_t e;
	f16vec2 f;
	u16vec2 g[1];
	mediump mat2 h[][5];
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	bvec2 i[2][7];
	highp uvec3 j[][4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a[0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.a[1]), uvec2(0u, 4u)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[0].c[0]), vec2(3.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[0].c[1]), vec2(2.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[0].c[2]), vec2(8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].d, mat4x3(9.0, -1.0, -1.0, -7.0, 7.0, -4.0, -3.0, 1.0, -4.0, -9.0, 1.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[1].c[0]), vec2(3.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[1].c[1]), vec2(2.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[1].c[2]), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].d, mat4x3(4.0, 8.0, -9.0, -8.0, -2.0, -8.0, -2.0, -9.0, 0.0, -8.0, -3.0, 8.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.e), 0u) && allOk;
	allOk = compare_bvec2((i[0][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((i[0][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((i[0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((i[0][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((i[0][4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((i[0][5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((i[0][6]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((i[1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((i[1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((i[1][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((i[1][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((i[1][4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((i[1][5]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((i[1][6]), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec2(4u, 1u));
	blockB.a[1] = (uvec2(0u, 6u));
	blockC[0].b[0] = (ivec4(-6, 6, -6, 3));
	blockC[0].b[1] = (ivec4(-7, 8, 5, -6));
	blockC[0].b[2] = (ivec4(-7, -2, 2, 3));
	blockC[0].b[3] = (ivec4(-1, 4, -4, -6));
	blockC[0].d = (mat4x3(0.0, 4.0, 3.0, -1.0, -6.0, -4.0, -5.0, 3.0, -5.0, 6.0, -6.0, -2.0));
	blockC[1].b[0] = (ivec4(-8, 5, -4, 8));
	blockC[1].b[1] = (ivec4(-5, 2, -2, 8));
	blockC[1].b[2] = (ivec4(-1, -1, 1, 7));
	blockC[1].b[3] = (ivec4(8, 7, 0, -5));
	blockC[1].d = (mat4x3(-6.0, 3.0, 2.0, -4.0, 5.0, -9.0, 5.0, -9.0, -5.0, -1.0, -8.0, -7.0));
	blockD.e = uint16_t(2u);
	blockD.h[0][0] = (mat2(3.0, -6.0, 6.0, -1.0));
	blockD.h[0][1] = (mat2(-9.0, 7.0, 5.0, -7.0));
	blockD.h[0][2] = (mat2(5.0, -3.0, -4.0, -1.0));
	blockD.h[0][3] = (mat2(7.0, -9.0, 2.0, -7.0));
	blockD.h[0][4] = (mat2(1.0, -9.0, -7.0, 3.0));
	blockD.h[1][0] = (mat2(3.0, -2.0, 8.0, 2.0));
	blockD.h[1][1] = (mat2(-1.0, 7.0, -4.0, -2.0));
	blockD.h[1][2] = (mat2(7.0, -7.0, -1.0, 8.0));
	blockD.h[1][3] = (mat2(0.0, 1.0, 0.0, 0.0));
	blockD.h[1][4] = (mat2(4.0, 4.0, 2.0, 7.0));
	i[0][0] = (bvec2(false, false));
	i[0][1] = (bvec2(true, false));
	i[0][2] = (bvec2(true, false));
	i[0][3] = (bvec2(true, true));
	i[0][4] = (bvec2(false, false));
	i[0][5] = (bvec2(false, true));
	i[0][6] = (bvec2(true, false));
	i[1][0] = (bvec2(false, true));
	i[1][1] = (bvec2(true, true));
	i[1][2] = (bvec2(true, true));
	i[1][3] = (bvec2(false, true));
	i[1][4] = (bvec2(true, false));
	i[1][5] = (bvec2(false, false));
	i[1][6] = (bvec2(false, true));
}
#version 450
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
	layout(offset = 16) highp vec3 b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(a), ivec3(6, 6, -6)) && allOk;
	allOk = compare_vec3((b), vec3(-3.0, -1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i16vec3(ivec3(-5, 9, 5));
	b = (vec3(5.0, -3.0, -5.0));
}
#version 450
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
	layout(offset = 0) float16_t a;
	layout(offset = 4) highp vec2 b;
	layout(offset = 12) i16vec2 c;
	layout(offset = 16) float16_t d;
	layout(offset = 20) bvec2 e;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) float16_t f;
	layout(offset = 2) i16vec3 g;
	layout(offset = 8) highp uvec2 h;
	layout(offset = 16) u16vec2 i;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) float16_t j;
	layout(offset = 2) int16_t k;
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(a), -5.0) && allOk;
	allOk = compare_vec2((b), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_i16vec2(ivec2(c), ivec2(-2, 1)) && allOk;
	allOk = compare_float16_t(float(d), 9.0) && allOk;
	allOk = compare_bvec2((e), bvec2(true, false)) && allOk;
	allOk = compare_float16_t(float(blockC.f), -5.0) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.g), ivec3(6, 9, -2)) && allOk;
	allOk = compare_uvec2((blockC.h), uvec2(3u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.i), uvec2(3u, 2u)) && allOk;
	allOk = compare_int16_t(int(blockD[0].k), -3) && allOk;
	allOk = compare_int16_t(int(blockD[1].k), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (vec2(4.0, 1.0));
	c = i16vec2(ivec2(-2, 5));
	d = float16_t(0.0);
	e = (bvec2(true, true));
	blockC.f = float16_t(5.0);
	blockC.g = i16vec3(ivec3(-3, 9, 2));
	blockC.h = (uvec2(1u, 1u));
	blockC.i = u16vec2(uvec2(3u, 0u));
	blockD[0].j = float16_t(-3.0);
	blockD[0].k = int16_t(-6);
	blockD[1].j = float16_t(-2.0);
	blockD[1].k = int16_t(4);
}
#version 450
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
	bvec3 a;
};
layout(std140, row_major, binding = 2) readonly buffer BlockC
{
	lowp mat2 b;
	highp mat4 c[];
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	highp ivec4 d;
	highp mat3x4 e;
	mediump float f;
	u8vec4 g[];
} blockD;
layout(std430, row_major, binding = 4) buffer BlockE
{
	i8vec2 h;
	uint8_t i;
	highp mat2x3 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((a), bvec3(true, false, false)) && allOk;
	allOk = compare_mat2(blockC.b, mat2(2.0, 4.0, -1.0, 1.0)) && allOk;
	allOk = compare_ivec4((blockD.d), ivec4(-3, 7, -3, 9)) && allOk;
	allOk = compare_float((blockD.f), 1.0) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.g[0]), uvec4(2u, 3u, 6u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.g[1]), uvec4(7u, 6u, 1u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.g[2]), uvec4(5u, 3u, 6u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.g[3]), uvec4(0u, 5u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.g[4]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_uint8_t(uint(i), 1u) && allOk;
	allOk = compare_mat2x3(j[0], mat2x3(1.0, 6.0, 4.0, -1.0, -6.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec3(true, true, true));
	blockD.d = (ivec4(8, -6, 2, -5));
	blockD.e = (mat3x4(6.0, -4.0, 3.0, 8.0, 2.0, 7.0, -9.0, 3.0, 0.0, -3.0, 4.0, -6.0));
	blockD.f = (-5.0);
	blockD.g[0] = u8vec4(uvec4(4u, 6u, 2u, 2u));
	blockD.g[1] = u8vec4(uvec4(0u, 1u, 3u, 8u));
	blockD.g[2] = u8vec4(uvec4(2u, 8u, 9u, 2u));
	blockD.g[3] = u8vec4(uvec4(2u, 1u, 5u, 2u));
	blockD.g[4] = u8vec4(uvec4(6u, 1u, 2u, 3u));
	h = i8vec2(ivec2(4294967292, 4294967287));
	i = uint8_t(2u);
}
#version 450
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
	i8vec2 a;
	mediump mat3x4 b;
	mediump mat3x4 c;
	lowp mat4x3 d;
	mediump mat4 e[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	highp mat4x3 f;
	lowp uvec4 g;
	bvec3 h;
	highp uvec2 i;
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	highp mat3 j;
	mediump mat3x4 k;
	mediump ivec3 l[];
} blockD;
layout(std140, row_major, binding = 4) buffer BlockE
{
	bvec2 m;
	bvec2 n;
	highp ivec4 o;
	mediump mat4x2 p;
	highp ivec4 q[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.a), ivec2(2, 4294967293)) && allOk;
	allOk = compare_mat3x4(blockB.b, mat3x4(2.0, -4.0, 4.0, 6.0, -2.0, -5.0, -3.0, -3.0, 1.0, -3.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4(blockB.e[0], mat4(0.0, 6.0, -1.0, -8.0, -3.0, -6.0, 1.0, 7.0, 6.0, -5.0, -9.0, 2.0, 9.0, 7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(blockB.e[1], mat4(2.0, 0.0, -1.0, 1.0, 1.0, 0.0, 9.0, -2.0, -1.0, -4.0, -8.0, 0.0, 6.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(blockB.e[2], mat4(-1.0, 7.0, -2.0, -9.0, -7.0, -2.0, -3.0, -3.0, -9.0, 6.0, 9.0, -7.0, 9.0, -7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockC.f, mat4x3(-4.0, -8.0, -7.0, -2.0, 6.0, -3.0, 7.0, 7.0, 8.0, -8.0, -9.0, 3.0)) && allOk;
	allOk = compare_bvec3((blockC.h), bvec3(true, false, false)) && allOk;
	allOk = compare_mat3(blockD.j, mat3(7.0, 9.0, 2.0, 4.0, 6.0, 3.0, 7.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockD.k, mat3x4(6.0, -3.0, -8.0, 1.0, -7.0, 5.0, 6.0, -3.0, -4.0, 0.0, -7.0, 9.0)) && allOk;
	allOk = compare_ivec3((blockD.l[0]), ivec3(-6, 6, -9)) && allOk;
	allOk = compare_ivec3((blockD.l[1]), ivec3(2, 6, -6)) && allOk;
	allOk = compare_ivec3((blockD.l[2]), ivec3(9, 7, -8)) && allOk;
	allOk = compare_ivec3((blockD.l[3]), ivec3(-4, -3, 5)) && allOk;
	allOk = compare_ivec3((blockD.l[4]), ivec3(3, -3, -5)) && allOk;
	allOk = compare_ivec3((blockD.l[5]), ivec3(1, -5, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3x4(-2.0, 6.0, 0.0, 5.0, 9.0, -5.0, 4.0, 7.0, -1.0, 6.0, 5.0, 8.0));
	blockB.e[0] = (mat4(2.0, 2.0, -6.0, -8.0, -6.0, 4.0, -7.0, -9.0, 7.0, -3.0, -1.0, -2.0, -4.0, 3.0, -1.0, 4.0));
	blockB.e[1] = (mat4(-2.0, 9.0, -2.0, 8.0, -5.0, -8.0, 9.0, 2.0, -2.0, -2.0, 7.0, 3.0, 7.0, 3.0, -1.0, -2.0));
	blockB.e[2] = (mat4(1.0, 2.0, -4.0, 2.0, -8.0, -6.0, 2.0, -5.0, -6.0, -3.0, -2.0, 7.0, -4.0, -1.0, -5.0, -8.0));
	blockC.f = (mat4x3(5.0, 8.0, -8.0, -5.0, 2.0, -9.0, -3.0, -9.0, -2.0, 5.0, 4.0, 2.0));
	blockC.h = (bvec3(false, true, true));
	blockC.i = (uvec2(5u, 4u));
	blockD.j = (mat3(0.0, 0.0, 3.0, 6.0, 5.0, -2.0, -6.0, -3.0, -9.0));
	blockD.k = (mat3x4(-5.0, 7.0, 2.0, -2.0, -3.0, 9.0, 9.0, -3.0, -9.0, 8.0, 7.0, -2.0));
	blockD.l[0] = (ivec3(-5, 8, -4));
	blockD.l[1] = (ivec3(-3, -6, -1));
	blockD.l[2] = (ivec3(-2, -3, 8));
	blockD.l[3] = (ivec3(1, -5, -4));
	blockD.l[4] = (ivec3(-8, 1, 7));
	blockD.l[5] = (ivec3(8, 7, 6));
	m = (bvec2(true, true));
	n = (bvec2(false, true));
	o = (ivec4(6, -1, 8, -9));
	q[0] = (ivec4(-3, -4, -3, -7));
	q[1] = (ivec4(-3, 7, 7, -1));
	q[2] = (ivec4(9, -1, -3, 8));
	q[3] = (ivec4(9, -5, 1, -9));
}
#version 450
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
	i8vec4 b[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	bvec2 c;
	mediump float d;
	lowp ivec3 e;
	i8vec4 f;
	highp mat4 g[];
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	lowp float h;
	bool i;
	bvec2 j[];
};
layout(std140, column_major, binding = 4) buffer BlockE
{
	mediump uvec4 k;
	lowp mat2x3 l;
	highp uvec2 m[];
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a, mat3x4(-2.0, 4.0, 3.0, -8.0, 3.0, -5.0, -4.0, -5.0, -3.0, -2.0, -3.0, 6.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b[0]), ivec4(4294967290, 9, 4294967294, 5)) && allOk;
	allOk = compare_bvec2((blockC.c), bvec2(true, false)) && allOk;
	allOk = compare_float((blockC.d), -6.0) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f), ivec4(8, 8, 0, 1)) && allOk;
	allOk = compare_bool((i), false) && allOk;
	allOk = compare_uvec4((blockE[0].k), uvec4(9u, 7u, 6u, 2u)) && allOk;
	allOk = compare_uvec2((blockE[0].m[0]), uvec2(2u, 3u)) && allOk;
	allOk = compare_uvec4((blockE[1].k), uvec4(4u, 3u, 3u, 7u)) && allOk;
	allOk = compare_uvec2((blockE[1].m[0]), uvec2(1u, 9u)) && allOk;
	allOk = compare_uvec4((blockE[2].k), uvec4(0u, 8u, 9u, 0u)) && allOk;
	allOk = compare_uvec2((blockE[2].m[0]), uvec2(0u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(-7.0, 3.0, -9.0, -7.0, -4.0, -1.0, 9.0, -4.0, -4.0, 3.0, -7.0, -4.0));
	blockB.b[0] = i8vec4(ivec4(0, 4294967289, 4294967287, 4294967288));
	blockC.c = (bvec2(false, true));
	blockC.f = i8vec4(ivec4(9, 4, 1, 4294967288));
	i = (true);
	j[0] = (bvec2(true, false));
	blockE[0].k = (uvec4(9u, 2u, 4u, 1u));
	blockE[0].l = (mat2x3(1.0, 1.0, -2.0, -3.0, 8.0, 2.0));
	blockE[0].m[0] = (uvec2(9u, 0u));
	blockE[1].k = (uvec4(7u, 9u, 0u, 6u));
	blockE[1].l = (mat2x3(3.0, 6.0, -8.0, -8.0, -6.0, 7.0));
	blockE[1].m[0] = (uvec2(5u, 9u));
	blockE[2].k = (uvec4(5u, 5u, 9u, 0u));
	blockE[2].l = (mat2x3(7.0, -7.0, 4.0, -4.0, -8.0, 1.0));
	blockE[2].m[0] = (uvec2(0u, 2u));
}
#version 450
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
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	u8vec2 a;
	int8_t b;
	mediump mat3x2 c;
	bvec2 d[];
};
layout(std140, binding = 2) buffer BlockC
{
	sA e;
	mediump float f;
	bvec3 g;
	mediump mat3x2 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(b), 4294967292) && allOk;
	allOk = compare_mat3x2(c, mat3x2(7.0, -5.0, 4.0, -8.0, 0.0, -6.0)) && allOk;
	allOk = compare_u8vec2(uvec2(e.mA), uvec2(9u, 2u)) && allOk;
	allOk = compare_bvec3((g), bvec3(false, false, false)) && allOk;
	allOk = compare_mat3x2(h[0], mat3x2(5.0, -9.0, -8.0, 6.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x2(h[1], mat3x2(-7.0, -8.0, 9.0, -9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(h[2], mat3x2(3.0, 6.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x2(h[3], mat3x2(6.0, 7.0, 5.0, 8.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec2(uvec2(9u, 4u));
	d[0] = (bvec2(true, true));
	d[1] = (bvec2(false, true));
	f = (0.0);
	g = (bvec3(true, false, false));
	h[0] = (mat3x2(9.0, -7.0, -6.0, -2.0, -4.0, 8.0));
	h[1] = (mat3x2(-6.0, -4.0, 6.0, -3.0, -6.0, 8.0));
	h[2] = (mat3x2(-6.0, -7.0, -1.0, 4.0, -7.0, 2.0));
	h[3] = (mat3x2(-1.0, 4.0, -6.0, 5.0, -5.0, -1.0));
}
#version 450
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
	mediump uvec2 mB[5][3];
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	mediump vec2 a;
	bvec3 b[8];
};
layout(std140, binding = 2) buffer BlockC
{
	i8vec3 c;
	highp mat3 d;
	mediump mat4 e;
	uint8_t f[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	highp ivec2 g;
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	u8vec3 h;
	lowp mat4x3 i;
	sA j;
	i8vec3 k[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((a), vec2(-5.0, 5.0)) && allOk;
	allOk = compare_i8vec3(ivec3(c), ivec3(1, 4294967292, 7)) && allOk;
	allOk = compare_mat4(e, mat4(3.0, 3.0, -7.0, 7.0, -3.0, -3.0, 8.0, 3.0, -1.0, 0.0, -6.0, -5.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_uint8_t(uint(f[0]), 0u) && allOk;
	allOk = compare_ivec2((blockD.g), ivec2(5, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (bvec3(false, true, false));
	b[1] = (bvec3(false, false, true));
	b[2] = (bvec3(false, false, true));
	b[3] = (bvec3(false, false, false));
	b[4] = (bvec3(true, false, true));
	b[5] = (bvec3(false, false, true));
	b[6] = (bvec3(true, false, true));
	b[7] = (bvec3(false, false, true));
	c = i8vec3(ivec3(4, 4294967293, 4294967288));
	e = (mat4(-9.0, 2.0, 6.0, -9.0, -4.0, 6.0, 0.0, -2.0, -5.0, -5.0, -4.0, -9.0, 7.0, -1.0, -8.0, 9.0));
	blockD.g = (ivec2(5, -2));
	blockE.h = u8vec3(uvec3(4u, 3u, 6u));
	blockE.i = (mat4x3(9.0, 0.0, -5.0, 8.0, -4.0, 6.0, -6.0, 2.0, 7.0, 8.0, 7.0, -6.0));
	blockE.j.mA = u8vec2(uvec2(0u, 8u));
	blockE.j.mB[0][0] = (uvec2(8u, 1u));
	blockE.j.mB[0][1] = (uvec2(5u, 1u));
	blockE.j.mB[0][2] = (uvec2(9u, 0u));
	blockE.j.mB[1][0] = (uvec2(4u, 6u));
	blockE.j.mB[1][1] = (uvec2(9u, 7u));
	blockE.j.mB[1][2] = (uvec2(1u, 6u));
	blockE.j.mB[2][0] = (uvec2(6u, 5u));
	blockE.j.mB[2][1] = (uvec2(4u, 2u));
	blockE.j.mB[2][2] = (uvec2(0u, 9u));
	blockE.j.mB[3][0] = (uvec2(3u, 5u));
	blockE.j.mB[3][1] = (uvec2(9u, 1u));
	blockE.j.mB[3][2] = (uvec2(3u, 1u));
	blockE.j.mB[4][0] = (uvec2(9u, 3u));
	blockE.j.mB[4][1] = (uvec2(7u, 9u));
	blockE.j.mB[4][2] = (uvec2(1u, 6u));
}
#version 450
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
	layout(offset = 0) mediump vec3 a;
	layout(offset = 12) mediump uint b;
	layout(offset = 16) highp vec4 c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec4 d;
	layout(offset = 16) u8vec3 e;
	layout(offset = 19) i8vec3 f;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump int g;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) bvec3 h;
	layout(offset = 16) bvec4 i;
	layout(offset = 32) u8vec2 j;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(0.0, -6.0, 9.0)) && allOk;
	allOk = compare_uint((blockB.b), 5u) && allOk;
	allOk = compare_bvec4((d), bvec4(false, false, false, true)) && allOk;
	allOk = compare_u8vec3(uvec3(e), uvec3(0u, 3u, 4u)) && allOk;
	allOk = compare_int((blockD.g), -6) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (2u);
	blockB.c = (vec4(9.0, 2.0, -6.0, 6.0));
	d = (bvec4(false, false, true, false));
	e = u8vec3(uvec3(2u, 6u, 4u));
	f = i8vec3(ivec3(4294967287, 9, 4294967287));
	blockD.g = (9);
	h = (bvec3(false, true, true));
	i = (bvec4(false, false, false, false));
	j = u8vec2(uvec2(7u, 8u));
}
#version 450
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
	layout(offset = 0) u8vec3 a;
	layout(offset = 4) highp uint b;
	layout(offset = 8) bvec2 c;
	layout(offset = 16) u8vec4 d;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(a), uvec3(0u, 2u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(d), uvec4(3u, 0u, 4u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec3(uvec3(2u, 8u, 3u));
	b = (3u);
	c = (bvec2(false, true));
}
#version 450
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
	bvec4 a[];
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	int8_t b;
} blockC[1];
layout(scalar, column_major, binding = 3) buffer BlockD
{
	highp vec4 c;
	u8vec2 d;
	bvec2 e;
	lowp uvec2 f;
	highp uint g[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((a[0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((a[1]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((a[2]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((a[3]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_int8_t(int(blockC[0].b), 3) && allOk;
	allOk = compare_vec4((blockD.c), vec4(2.0, -6.0, 9.0, 2.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.d), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec2((blockD.f), uvec2(8u, 9u)) && allOk;
	allOk = compare_uint((blockD.g[0]), 5u) && allOk;
	allOk = compare_uint((blockD.g[1]), 2u) && allOk;
	allOk = compare_uint((blockD.g[2]), 7u) && allOk;
	allOk = compare_uint((blockD.g[3]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (bvec4(true, false, true, false));
	a[1] = (bvec4(false, false, true, true));
	a[2] = (bvec4(true, false, true, true));
	a[3] = (bvec4(true, false, false, false));
	blockC[0].b = int8_t(6);
	blockD.d = u8vec2(uvec2(5u, 7u));
}
#version 450
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
	mediump uvec3 a[2];
	bvec2 b[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	highp mat2x3 c;
	lowp mat3 d;
	lowp ivec2 e;
	u8vec3 f[];
} blockC[1];
layout(scalar, column_major, binding = 3) buffer BlockD
{
	i8vec4 g[];
} blockD;
layout(scalar, row_major, binding = 4) readonly buffer BlockE
{
	bvec2 h;
	highp uvec4 i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a[0]), uvec3(1u, 2u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.a[1]), uvec3(2u, 3u, 7u)) && allOk;
	allOk = compare_bvec2((blockB.b[0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.b[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.b[2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.b[3]), bvec2(true, true)) && allOk;
	allOk = compare_mat3(blockC[0].d, mat3(9.0, 6.0, 7.0, -8.0, 4.0, -2.0, 8.0, 4.0, 8.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.g[0]), ivec4(4294967288, 2, 9, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.g[1]), ivec4(1, 4294967294, 1, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.g[2]), ivec4(4294967291, 2, 4294967289, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.g[3]), ivec4(5, 4294967294, 6, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.g[4]), ivec4(9, 4294967295, 4294967291, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.g[5]), ivec4(4294967287, 4294967289, 4294967293, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.g[6]), ivec4(9, 4294967287, 4294967295, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.g[7]), ivec4(4294967287, 6, 5, 4294967294)) && allOk;
	allOk = compare_bvec2((h), bvec2(false, false)) && allOk;
	allOk = compare_uvec4((i[0]), uvec4(7u, 6u, 2u, 7u)) && allOk;
	allOk = compare_uvec4((i[1]), uvec4(1u, 1u, 0u, 2u)) && allOk;
	allOk = compare_uvec4((i[2]), uvec4(2u, 5u, 4u, 2u)) && allOk;
	allOk = compare_uvec4((i[3]), uvec4(6u, 2u, 6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec3(7u, 3u, 5u));
	blockB.a[1] = (uvec3(0u, 0u, 3u));
	blockB.b[0] = (bvec2(true, false));
	blockB.b[1] = (bvec2(false, true));
	blockB.b[2] = (bvec2(false, false));
	blockB.b[3] = (bvec2(true, false));
	blockC[0].c = (mat2x3(-6.0, -8.0, -7.0, -9.0, -5.0, 4.0));
	blockC[0].d = (mat3(4.0, 1.0, -2.0, -6.0, -9.0, 8.0, 4.0, 6.0, -3.0));
	blockC[0].e = (ivec2(-4, 3));
	blockC[0].f[0] = u8vec3(uvec3(9u, 8u, 1u));
	blockC[0].f[1] = u8vec3(uvec3(7u, 4u, 6u));
	blockD.g[0] = i8vec4(ivec4(4294967289, 0, 4294967293, 4294967294));
	blockD.g[1] = i8vec4(ivec4(3, 4294967295, 1, 6));
	blockD.g[2] = i8vec4(ivec4(1, 2, 4294967295, 4294967292));
	blockD.g[3] = i8vec4(ivec4(4294967290, 4294967287, 4294967289, 4294967292));
	blockD.g[4] = i8vec4(ivec4(4294967291, 4294967294, 4294967295, 4294967288));
	blockD.g[5] = i8vec4(ivec4(7, 8, 0, 4294967287));
	blockD.g[6] = i8vec4(ivec4(4294967291, 8, 1, 4294967292));
	blockD.g[7] = i8vec4(ivec4(9, 4294967295, 9, 4294967289));
}
#version 450
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
	i8vec4 a;
	lowp mat4 b[][3];
} blockB[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB[0].a), ivec4(6, 4294967289, 7, 7)) && allOk;
	allOk = compare_mat4(blockB[0].b[0][0], mat4(8.0, -4.0, 0.0, 7.0, 4.0, -1.0, 6.0, 8.0, 0.0, 5.0, -8.0, -7.0, 0.0, -6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[0][1], mat4(-1.0, -5.0, 0.0, -2.0, 2.0, -3.0, -7.0, -8.0, -5.0, 3.0, 7.0, -4.0, -5.0, -3.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[0][2], mat4(9.0, -3.0, -1.0, 7.0, -4.0, 1.0, -6.0, -9.0, -6.0, 2.0, 8.0, 6.0, -6.0, 3.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[1][0], mat4(2.0, 7.0, 0.0, -7.0, 2.0, -1.0, 1.0, -3.0, -7.0, -1.0, 3.0, -2.0, -5.0, -9.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[1][1], mat4(-5.0, 4.0, 9.0, 7.0, -2.0, -6.0, 7.0, 7.0, 8.0, -4.0, 0.0, -5.0, -5.0, -9.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[1][2], mat4(-5.0, -8.0, 4.0, 5.0, -3.0, -5.0, -3.0, 8.0, -6.0, -5.0, -1.0, 1.0, -5.0, -9.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[2][0], mat4(5.0, -8.0, 5.0, 8.0, -8.0, -7.0, 9.0, -5.0, 1.0, 1.0, -5.0, -6.0, 3.0, 9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[2][1], mat4(6.0, 8.0, 2.0, -7.0, 6.0, 8.0, -2.0, 4.0, 8.0, 3.0, -2.0, 6.0, 2.0, -1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[2][2], mat4(-3.0, 8.0, -6.0, 9.0, 0.0, -7.0, -4.0, 1.0, 6.0, 0.0, -8.0, 4.0, 4.0, 2.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[3][0], mat4(-9.0, 7.0, 5.0, -4.0, 1.0, -9.0, 3.0, -2.0, 2.0, -4.0, -7.0, -8.0, -4.0, 1.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[3][1], mat4(8.0, -8.0, 2.0, 8.0, 8.0, 0.0, 9.0, -8.0, 8.0, 8.0, 0.0, 3.0, 6.0, 3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[3][2], mat4(5.0, 8.0, 1.0, 7.0, -7.0, 6.0, -2.0, -7.0, 1.0, 0.0, 7.0, -1.0, 1.0, -5.0, -3.0, 6.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[1].a), ivec4(4294967292, 5, 4294967294, 9)) && allOk;
	allOk = compare_mat4(blockB[1].b[0][0], mat4(-8.0, 4.0, 7.0, 0.0, -7.0, -7.0, 4.0, -7.0, 8.0, -7.0, 1.0, -3.0, -9.0, -2.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[0][1], mat4(2.0, -9.0, -9.0, 3.0, -1.0, -1.0, 0.0, 7.0, 3.0, -3.0, -6.0, -2.0, -5.0, -9.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[0][2], mat4(-2.0, -3.0, -4.0, -4.0, -3.0, -9.0, -4.0, 7.0, 3.0, -5.0, 6.0, 0.0, 4.0, -1.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[1][0], mat4(6.0, 4.0, -9.0, 8.0, 8.0, -2.0, -7.0, -2.0, -9.0, 4.0, 2.0, -8.0, 4.0, 5.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[1][1], mat4(3.0, 5.0, 3.0, -7.0, 9.0, 9.0, 4.0, 7.0, 2.0, -1.0, -4.0, -2.0, 3.0, -2.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[1][2], mat4(2.0, -4.0, 5.0, -1.0, -5.0, -4.0, -4.0, 6.0, 2.0, 3.0, 7.0, 1.0, -7.0, 2.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[2][0], mat4(-4.0, 9.0, 4.0, 9.0, -1.0, -7.0, 2.0, -2.0, 2.0, 8.0, -1.0, 8.0, -3.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[2][1], mat4(0.0, 5.0, 5.0, 9.0, 0.0, -9.0, 6.0, -3.0, -2.0, 8.0, 8.0, -1.0, 1.0, 4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[2][2], mat4(-6.0, -5.0, 9.0, -8.0, 3.0, 3.0, 9.0, 8.0, -9.0, -9.0, 4.0, -6.0, 2.0, -6.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[3][0], mat4(-7.0, 0.0, 1.0, 5.0, 7.0, 2.0, 1.0, 9.0, -6.0, -6.0, 0.0, 0.0, -6.0, 8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[3][1], mat4(-2.0, 6.0, -2.0, -9.0, -8.0, -6.0, -2.0, -4.0, -1.0, 8.0, -9.0, 8.0, 2.0, -6.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[3][2], mat4(0.0, 8.0, -1.0, -5.0, 8.0, 4.0, -6.0, -5.0, 5.0, -6.0, 5.0, -5.0, 0.0, 9.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[4][0], mat4(-6.0, 6.0, 3.0, 2.0, 3.0, -8.0, 5.0, -7.0, 7.0, 3.0, 9.0, -1.0, 7.0, 3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[4][1], mat4(-3.0, 7.0, 6.0, -7.0, -8.0, -5.0, 0.0, 7.0, -3.0, -4.0, -6.0, -9.0, -4.0, -7.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[4][2], mat4(-6.0, 0.0, -9.0, -9.0, -1.0, 4.0, 6.0, 8.0, -5.0, -7.0, -2.0, 5.0, 4.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[5][0], mat4(-4.0, -9.0, 4.0, -4.0, -9.0, 9.0, -3.0, 7.0, -9.0, -7.0, 1.0, 4.0, 8.0, 7.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[5][1], mat4(-1.0, -6.0, 2.0, 8.0, -4.0, 2.0, 6.0, -3.0, -3.0, 9.0, -6.0, 6.0, -8.0, -8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat4(blockB[1].b[5][2], mat4(8.0, 4.0, 0.0, -5.0, -9.0, 8.0, -7.0, -4.0, 0.0, 8.0, -5.0, 6.0, -6.0, -9.0, -8.0, 1.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[2].a), ivec4(6, 4294967292, 7, 4294967295)) && allOk;
	allOk = compare_mat4(blockB[2].b[0][0], mat4(7.0, 0.0, 0.0, 4.0, 0.0, 7.0, 0.0, -5.0, 2.0, 2.0, -5.0, -2.0, 6.0, 9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(blockB[2].b[0][1], mat4(7.0, -9.0, -2.0, 0.0, -7.0, -1.0, -5.0, -6.0, 8.0, -2.0, -7.0, -4.0, 7.0, -2.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB[2].b[0][2], mat4(9.0, -6.0, 7.0, 4.0, -2.0, -6.0, 6.0, 7.0, 6.0, -5.0, 0.0, -5.0, 7.0, -6.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4(blockB[2].b[1][0], mat4(-3.0, 0.0, -5.0, -5.0, 4.0, 0.0, 0.0, 3.0, 5.0, 9.0, 2.0, -8.0, 4.0, 4.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4(blockB[2].b[1][1], mat4(-7.0, 0.0, 0.0, -1.0, -9.0, -6.0, 4.0, -2.0, -9.0, 1.0, -8.0, 2.0, -4.0, -8.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(blockB[2].b[1][2], mat4(-7.0, -4.0, 3.0, -9.0, 9.0, -7.0, 5.0, 2.0, -4.0, 9.0, -9.0, -1.0, 4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(blockB[2].b[2][0], mat4(-4.0, 9.0, 1.0, -4.0, 4.0, -2.0, 7.0, -8.0, 2.0, 1.0, 9.0, 0.0, -3.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(blockB[2].b[2][1], mat4(4.0, 2.0, -5.0, 9.0, -7.0, -6.0, -4.0, -5.0, 5.0, 1.0, 8.0, -4.0, 2.0, 4.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4(blockB[2].b[2][2], mat4(3.0, 2.0, 1.0, -3.0, 9.0, -1.0, -1.0, -5.0, -3.0, -8.0, 2.0, 9.0, 6.0, -2.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4(blockB[2].b[3][0], mat4(-8.0, -5.0, -3.0, 2.0, 2.0, -2.0, -3.0, 9.0, -5.0, 4.0, 2.0, 9.0, 5.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(blockB[2].b[3][1], mat4(-1.0, -3.0, 5.0, -9.0, -2.0, -2.0, -8.0, 5.0, -4.0, -2.0, 9.0, -7.0, -4.0, -8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB[2].b[3][2], mat4(-4.0, 0.0, -7.0, -6.0, -5.0, -4.0, 8.0, 9.0, -8.0, 3.0, 2.0, -7.0, 9.0, 7.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4(blockB[2].b[4][0], mat4(-7.0, 4.0, -6.0, -5.0, 0.0, 4.0, 5.0, 3.0, -4.0, -3.0, -3.0, 8.0, 4.0, 5.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(blockB[2].b[4][1], mat4(9.0, 7.0, 2.0, -5.0, -3.0, -6.0, 4.0, 2.0, -8.0, -3.0, 3.0, 7.0, -8.0, 1.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4(blockB[2].b[4][2], mat4(5.0, 0.0, -4.0, 9.0, 7.0, 9.0, 6.0, -1.0, 4.0, 0.0, -6.0, -6.0, -6.0, -9.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i8vec4(ivec4(4294967290, 7, 6, 3));
	blockB[0].b[0][0] = (mat4(-4.0, -4.0, -6.0, 6.0, 2.0, 0.0, -7.0, 7.0, -4.0, 0.0, -4.0, 7.0, 5.0, -4.0, -1.0, 6.0));
	blockB[0].b[0][1] = (mat4(-8.0, 7.0, -6.0, 3.0, 7.0, 1.0, 9.0, 7.0, 7.0, 5.0, 9.0, 6.0, -9.0, 5.0, -9.0, -1.0));
	blockB[0].b[0][2] = (mat4(-9.0, 9.0, 5.0, -1.0, -1.0, -7.0, 7.0, -1.0, -7.0, 0.0, 4.0, 7.0, 2.0, -5.0, -8.0, 3.0));
	blockB[0].b[1][0] = (mat4(7.0, -7.0, 3.0, 5.0, -7.0, -2.0, 6.0, 0.0, -4.0, -4.0, 2.0, -5.0, 1.0, 8.0, 8.0, -9.0));
	blockB[0].b[1][1] = (mat4(-7.0, 9.0, 1.0, -4.0, 7.0, 0.0, 9.0, -5.0, -4.0, 9.0, -8.0, -4.0, 2.0, 4.0, -8.0, 7.0));
	blockB[0].b[1][2] = (mat4(0.0, 6.0, -2.0, 4.0, 4.0, -4.0, 0.0, -3.0, -4.0, 4.0, -4.0, -9.0, -7.0, -1.0, 9.0, 4.0));
	blockB[0].b[2][0] = (mat4(7.0, 7.0, -8.0, 1.0, -9.0, -1.0, 3.0, -7.0, 3.0, 4.0, -8.0, -1.0, -7.0, 3.0, 6.0, 9.0));
	blockB[0].b[2][1] = (mat4(9.0, 3.0, -9.0, -1.0, 6.0, -3.0, -5.0, -9.0, -2.0, 1.0, 9.0, -3.0, 1.0, -6.0, -2.0, 4.0));
	blockB[0].b[2][2] = (mat4(-7.0, -4.0, 6.0, 2.0, -9.0, -7.0, -4.0, 3.0, 0.0, 0.0, 0.0, 6.0, 6.0, -7.0, -2.0, -8.0));
	blockB[0].b[3][0] = (mat4(-8.0, -1.0, 1.0, -9.0, 1.0, -3.0, -7.0, -1.0, 6.0, -2.0, 9.0, 3.0, 8.0, 3.0, -6.0, 4.0));
	blockB[0].b[3][1] = (mat4(3.0, 0.0, 3.0, 8.0, -4.0, 4.0, 3.0, -9.0, -5.0, -3.0, -9.0, 8.0, 2.0, -1.0, 5.0, -5.0));
	blockB[0].b[3][2] = (mat4(0.0, 2.0, 2.0, -1.0, 9.0, -9.0, -6.0, 5.0, 8.0, 5.0, 7.0, 0.0, 5.0, 8.0, -6.0, 6.0));
	blockB[1].a = i8vec4(ivec4(7, 6, 6, 9));
	blockB[1].b[0][0] = (mat4(-2.0, 8.0, -7.0, -7.0, 3.0, -4.0, -6.0, 7.0, -7.0, -1.0, 5.0, 8.0, -2.0, 8.0, 8.0, 0.0));
	blockB[1].b[0][1] = (mat4(-6.0, 9.0, 3.0, -5.0, 4.0, 3.0, -7.0, 5.0, 9.0, 9.0, -4.0, -5.0, -3.0, 7.0, -2.0, 7.0));
	blockB[1].b[0][2] = (mat4(5.0, -6.0, 0.0, -7.0, -1.0, -6.0, 1.0, 8.0, 3.0, -9.0, 5.0, -5.0, -9.0, -9.0, 3.0, -7.0));
	blockB[1].b[1][0] = (mat4(-2.0, -3.0, 6.0, -5.0, 6.0, -7.0, 2.0, 4.0, 0.0, 4.0, -9.0, 0.0, 3.0, -7.0, 2.0, -8.0));
	blockB[1].b[1][1] = (mat4(-4.0, -9.0, -5.0, -6.0, -6.0, 4.0, -5.0, 5.0, 0.0, 8.0, 5.0, 7.0, -5.0, -2.0, -8.0, -3.0));
	blockB[1].b[1][2] = (mat4(6.0, 8.0, 5.0, -4.0, -3.0, 3.0, -4.0, -4.0, -7.0, 0.0, -4.0, 5.0, -4.0, -7.0, 8.0, 7.0));
	blockB[1].b[2][0] = (mat4(-2.0, 0.0, 3.0, -9.0, 7.0, -6.0, 8.0, 8.0, -1.0, -7.0, -5.0, -5.0, -7.0, -3.0, -3.0, -9.0));
	blockB[1].b[2][1] = (mat4(-7.0, -2.0, -5.0, -6.0, 9.0, 0.0, -1.0, 5.0, -2.0, 0.0, 8.0, -9.0, -7.0, -1.0, -6.0, 9.0));
	blockB[1].b[2][2] = (mat4(0.0, -5.0, -9.0, 8.0, -4.0, -7.0, 5.0, -9.0, -3.0, 0.0, -9.0, 9.0, -1.0, -6.0, 8.0, -9.0));
	blockB[1].b[3][0] = (mat4(-6.0, -8.0, -2.0, 7.0, 3.0, -9.0, -1.0, 9.0, 2.0, -9.0, -7.0, 2.0, -5.0, 0.0, -3.0, -5.0));
	blockB[1].b[3][1] = (mat4(-5.0, 5.0, 2.0, 8.0, 8.0, -5.0, 1.0, -8.0, -3.0, 8.0, -4.0, -2.0, -7.0, -6.0, -9.0, -1.0));
	blockB[1].b[3][2] = (mat4(9.0, 3.0, -4.0, 1.0, -8.0, 2.0, 8.0, -9.0, -3.0, -8.0, 1.0, -8.0, 9.0, 2.0, 6.0, 3.0));
	blockB[1].b[4][0] = (mat4(-1.0, 6.0, -2.0, 8.0, -3.0, -7.0, -7.0, 4.0, -7.0, 8.0, 3.0, 9.0, 4.0, -2.0, 3.0, 3.0));
	blockB[1].b[4][1] = (mat4(-8.0, 3.0, 9.0, 4.0, -5.0, 1.0, 7.0, -6.0, 3.0, -9.0, 9.0, -8.0, -8.0, 4.0, -8.0, -2.0));
	blockB[1].b[4][2] = (mat4(9.0, 9.0, 1.0, -5.0, -7.0, 2.0, 0.0, -6.0, -6.0, 3.0, 2.0, 0.0, -3.0, 1.0, -8.0, -7.0));
	blockB[1].b[5][0] = (mat4(-3.0, -9.0, -8.0, -5.0, 8.0, -9.0, 6.0, -6.0, 2.0, 5.0, 9.0, 7.0, -5.0, -1.0, 0.0, -9.0));
	blockB[1].b[5][1] = (mat4(9.0, -9.0, -6.0, 9.0, -6.0, 1.0, 4.0, -7.0, -1.0, 6.0, -5.0, -1.0, 7.0, -9.0, -3.0, 4.0));
	blockB[1].b[5][2] = (mat4(-9.0, -3.0, 7.0, -6.0, 1.0, -3.0, -7.0, 5.0, 4.0, 9.0, 7.0, 4.0, 9.0, -8.0, -7.0, 4.0));
	blockB[2].a = i8vec4(ivec4(2, 4294967292, 1, 4294967295));
	blockB[2].b[0][0] = (mat4(0.0, -2.0, -8.0, 5.0, 0.0, 2.0, -9.0, -5.0, 4.0, 2.0, -1.0, -4.0, 3.0, 0.0, -1.0, -1.0));
	blockB[2].b[0][1] = (mat4(7.0, -1.0, -4.0, 2.0, 1.0, 5.0, -6.0, -9.0, -6.0, -9.0, -8.0, 6.0, 0.0, 9.0, -8.0, 8.0));
	blockB[2].b[0][2] = (mat4(-8.0, -4.0, -3.0, 5.0, -8.0, 7.0, 1.0, 0.0, -7.0, -2.0, -2.0, 5.0, -5.0, -7.0, -2.0, -3.0));
	blockB[2].b[1][0] = (mat4(5.0, -5.0, -8.0, -1.0, -5.0, 4.0, -4.0, -7.0, -3.0, -9.0, 7.0, 0.0, -5.0, 4.0, -7.0, 7.0));
	blockB[2].b[1][1] = (mat4(-5.0, 9.0, 2.0, 4.0, -7.0, 5.0, 2.0, 4.0, 9.0, -6.0, 3.0, -2.0, 5.0, -7.0, -7.0, -3.0));
	blockB[2].b[1][2] = (mat4(-8.0, -3.0, -5.0, -2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 1.0, -9.0, -1.0, 5.0, 6.0, -9.0, 5.0));
	blockB[2].b[2][0] = (mat4(6.0, -5.0, 4.0, 4.0, 6.0, 9.0, -2.0, -4.0, -8.0, 6.0, -7.0, -8.0, -2.0, 9.0, -2.0, 5.0));
	blockB[2].b[2][1] = (mat4(4.0, -8.0, 8.0, 9.0, 8.0, -3.0, 3.0, 1.0, -8.0, -9.0, 7.0, -3.0, 5.0, 9.0, 2.0, -4.0));
	blockB[2].b[2][2] = (mat4(7.0, -6.0, -8.0, 8.0, 9.0, -1.0, 3.0, -2.0, 0.0, -7.0, -4.0, -6.0, 3.0, -5.0, 4.0, 2.0));
	blockB[2].b[3][0] = (mat4(5.0, 8.0, -5.0, 1.0, 1.0, -5.0, -2.0, -8.0, -6.0, 5.0, -8.0, -8.0, 1.0, -6.0, -3.0, -3.0));
	blockB[2].b[3][1] = (mat4(-8.0, 2.0, 3.0, -3.0, -3.0, -1.0, 5.0, -8.0, -3.0, 1.0, -9.0, 7.0, 4.0, 5.0, 4.0, -2.0));
	blockB[2].b[3][2] = (mat4(5.0, -3.0, -6.0, 7.0, -6.0, -3.0, 3.0, 1.0, 9.0, 4.0, 9.0, 3.0, 9.0, 1.0, 2.0, -6.0));
	blockB[2].b[4][0] = (mat4(7.0, 2.0, 9.0, 9.0, 8.0, -2.0, -5.0, 4.0, 8.0, -7.0, -2.0, -7.0, -2.0, 7.0, -5.0, -7.0));
	blockB[2].b[4][1] = (mat4(3.0, 5.0, -5.0, 9.0, 9.0, 8.0, -6.0, 9.0, 5.0, 6.0, -5.0, -1.0, -1.0, -9.0, -9.0, -9.0));
	blockB[2].b[4][2] = (mat4(9.0, -2.0, -6.0, 4.0, 8.0, 6.0, -9.0, 6.0, 4.0, 1.0, -1.0, 2.0, -5.0, 0.0, -7.0, -9.0));
}
#version 450
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
	lowp uvec2 a[];
};
layout(scalar, binding = 2) buffer BlockC
{
	u8vec3 b;
	lowp vec2 c;
	u8vec4 d;
	highp mat4 e;
	lowp vec3 f[][1];
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((a[0]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((a[1]), uvec2(0u, 9u)) && allOk;
	allOk = compare_uvec2((a[2]), uvec2(5u, 9u)) && allOk;
	allOk = compare_uvec2((a[3]), uvec2(9u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[0].b), uvec3(7u, 9u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].d), uvec4(8u, 7u, 2u, 3u)) && allOk;
	allOk = compare_mat4(blockC[0].e, mat4(0.0, -6.0, -2.0, -9.0, -3.0, -2.0, 2.0, -7.0, -6.0, -7.0, -6.0, -7.0, 2.0, -4.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec3((blockC[0].f[0][0]), vec3(-3.0, 7.0, 1.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[1].b), uvec3(1u, 3u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[1].d), uvec4(8u, 0u, 7u, 3u)) && allOk;
	allOk = compare_mat4(blockC[1].e, mat4(4.0, -7.0, -6.0, -5.0, 5.0, 1.0, -9.0, 4.0, -8.0, 2.0, -9.0, 3.0, 0.0, -5.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec3((blockC[1].f[0][0]), vec3(5.0, 9.0, -7.0)) && allOk;
	allOk = compare_vec3((blockC[1].f[1][0]), vec3(4.0, 0.0, -7.0)) && allOk;
	allOk = compare_vec3((blockC[1].f[2][0]), vec3(9.0, 9.0, 5.0)) && allOk;
	allOk = compare_vec3((blockC[1].f[3][0]), vec3(-9.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec3((blockC[1].f[4][0]), vec3(-8.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec3((blockC[1].f[5][0]), vec3(-2.0, 8.0, -5.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[2].b), uvec3(2u, 1u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[2].d), uvec4(7u, 5u, 7u, 8u)) && allOk;
	allOk = compare_mat4(blockC[2].e, mat4(-4.0, 1.0, -7.0, -1.0, 9.0, -1.0, -1.0, -5.0, -8.0, 0.0, 2.0, -9.0, 4.0, -1.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec3((blockC[2].f[0][0]), vec3(-4.0, 2.0, 6.0)) && allOk;
	allOk = compare_vec3((blockC[2].f[1][0]), vec3(1.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec3((blockC[2].f[2][0]), vec3(2.0, -1.0, -3.0)) && allOk;
	allOk = compare_vec3((blockC[2].f[3][0]), vec3(4.0, -9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (uvec2(9u, 2u));
	a[1] = (uvec2(4u, 5u));
	a[2] = (uvec2(7u, 3u));
	a[3] = (uvec2(8u, 1u));
	blockC[0].b = u8vec3(uvec3(6u, 8u, 7u));
	blockC[0].d = u8vec4(uvec4(6u, 1u, 6u, 7u));
	blockC[0].e = (mat4(9.0, 2.0, -7.0, 8.0, 6.0, 4.0, -3.0, -2.0, -6.0, -9.0, 9.0, 9.0, 6.0, -1.0, -6.0, 6.0));
	blockC[0].f[0][0] = (vec3(-3.0, -3.0, -7.0));
	blockC[1].b = u8vec3(uvec3(3u, 6u, 1u));
	blockC[1].d = u8vec4(uvec4(6u, 0u, 5u, 6u));
	blockC[1].e = (mat4(-3.0, -4.0, 4.0, -4.0, -8.0, -6.0, 7.0, -7.0, 9.0, -4.0, -4.0, -5.0, 0.0, 8.0, 2.0, -1.0));
	blockC[1].f[0][0] = (vec3(6.0, -6.0, 3.0));
	blockC[1].f[1][0] = (vec3(-8.0, -5.0, -2.0));
	blockC[1].f[2][0] = (vec3(2.0, 0.0, 7.0));
	blockC[1].f[3][0] = (vec3(7.0, 7.0, 5.0));
	blockC[1].f[4][0] = (vec3(5.0, 0.0, -3.0));
	blockC[1].f[5][0] = (vec3(5.0, 0.0, 2.0));
	blockC[2].b = u8vec3(uvec3(3u, 5u, 9u));
	blockC[2].d = u8vec4(uvec4(3u, 1u, 2u, 6u));
	blockC[2].e = (mat4(-5.0, -7.0, 1.0, -9.0, 3.0, 0.0, 9.0, 2.0, 4.0, 6.0, 8.0, -9.0, -2.0, -6.0, -8.0, -8.0));
	blockC[2].f[0][0] = (vec3(8.0, 0.0, -2.0));
	blockC[2].f[1][0] = (vec3(3.0, 1.0, 9.0));
	blockC[2].f[2][0] = (vec3(-1.0, 1.0, 7.0));
	blockC[2].f[3][0] = (vec3(0.0, 5.0, 8.0));
}
#version 450
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
	highp vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((var), vec3(-5.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(1.0, 7.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, column_major, binding = 1) readonly buffer Block
{
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(-4.0, -4.0, -9.0, 3.0, 1.0, 3.0, -7.0, 3.0, 6.0, 1.0, 2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(6.0, 3.0, -5.0, -5.0, -3.0, 3.0, -1.0, 2.0, 2.0, -2.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(2.0, 8.0, 7.0, -3.0, 5.0, -4.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, binding = 1) readonly buffer Block
{
	float16_t var;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(var), -7.0) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp float var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var), -9.0) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], 3.0) && allOk;
	allOk = compare_float(var[2][0], 4.0) && allOk;
	allOk = compare_float(var[2][1], 1.0) && allOk;
	allOk = compare_float(var[2][2], 2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(0.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(4.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[2][0], -1.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-4.0, 7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(-4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, binding = 1) readonly buffer Block
{
	i8vec3 var[];
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(var[0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2]), ivec3(7, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(var[3]), ivec3(5, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[4]), ivec3(9, 0, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(var[5]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[6]), ivec3(4294967289, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[7]), ivec3(8, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[8]), ivec3(2, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(var[9]), ivec3(1, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[10]), ivec3(9, 7, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(var[11]), ivec3(2, 4294967294, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(var[12]), ivec3(7, 1, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[13]), ivec3(4294967294, 5, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(var[14]), ivec3(4294967295, 1, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(var[15]), ivec3(4294967292, 7, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(var[16]), ivec3(4294967290, 4294967291, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[17]), ivec3(9, 4294967290, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(var[18]), ivec3(1, 4294967293, 4294967294)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

layout(std430, column_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	allOk = compare_mat4(var[0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(4.0, 4.0, 9.0, -7.0, 9.0, 2.0, 3.0, 7.0, 0.0, -9.0, 2.0, -1.0, -8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(0.0, -3.0, -1.0, -1.0, -6.0, 1.0, -8.0, 1.0, 5.0, 0.0, 2.0, -1.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(7.0, 5.0, -2.0, -4.0, 0.0, 1.0, -6.0, -3.0, -1.0, -7.0, -7.0, -6.0, 1.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(8.0, -3.0, 9.0, 6.0, -2.0, -9.0, 4.0, 5.0, 6.0, 4.0, -3.0, -8.0, 6.0, 5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(-2.0, 5.0, 8.0, 4.0, -4.0, 9.0, 3.0, -5.0, 1.0, -6.0, 1.0, -5.0, 8.0, 7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(3.0, 0.0, -3.0, 3.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -9.0, -7.0, 1.0, -5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(0.0, 0.0, -1.0, 0.0, -9.0, 5.0, 4.0, 0.0, -6.0, -7.0, 1.0, -9.0, -4.0, -4.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x4 var[];
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
	allOk = compare_mat2x4(var[3], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(-9.0, 2.0, -4.0, -7.0, -8.0, -5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(0.0, 5.0, 4.0, -5.0, 1.0, -3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-2.0, -8.0, -5.0, -3.0, -6.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(2.0, -8.0, -6.0, -8.0, 7.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(4.0, 5.0, 0.0, 5.0, -4.0, -9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-9.0, 3.0, -9.0, 0.0, 2.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(4.0, -5.0, -6.0, -5.0, 5.0, 1.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	mediump float var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.var), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (2.0);
}
#version 450
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
	lowp uvec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((block.var), uvec4(2u, 4u, 5u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec4(6u, 6u, 2u, 2u));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(-7.0, 4.0, 2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(3.0, -2.0, -7.0, -2.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -9.0) && allOk;
	allOk = compare_float(block.var[0][1], 9.0) && allOk;
	allOk = compare_float(block.var[0][2], 1.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][2], -8.0) && allOk;
	allOk = compare_float(block.var[2][0], -2.0) && allOk;
	allOk = compare_float(block.var[2][1], 8.0) && allOk;
	allOk = compare_float(block.var[2][2], 3.0) && allOk;
	allOk = compare_float(block.var[3][0], 0.0) && allOk;
	allOk = compare_float(block.var[3][1], 5.0) && allOk;
	allOk = compare_float(block.var[3][2], -1.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-9.0, 9.0, 1.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(9.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-2.0, 8.0, 3.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(0.0, 5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-5.0, 8.0, 1.0));
	block.var[1] = (vec3(-5.0, 5.0, 1.0));
	block.var[2] = (vec3(-8.0, -8.0, -7.0));
	block.var[3] = (vec3(-6.0, 1.0, 7.0));
}
#version 450
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
	f16vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(block.var), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
}
#version 450
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
	mediump uvec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block.var), uvec2(3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec2(5u, 3u));
}
#version 450
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
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[0][2], 1.0) && allOk;
	allOk = compare_float(block.var[0][3], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][2], 3.0) && allOk;
	allOk = compare_float(block.var[1][3], -8.0) && allOk;
	allOk = compare_float(block.var[2][0], 2.0) && allOk;
	allOk = compare_float(block.var[2][1], 8.0) && allOk;
	allOk = compare_float(block.var[2][2], 3.0) && allOk;
	allOk = compare_float(block.var[2][3], -6.0) && allOk;
	allOk = compare_float(block.var[3][0], -5.0) && allOk;
	allOk = compare_float(block.var[3][1], -5.0) && allOk;
	allOk = compare_float(block.var[3][2], -8.0) && allOk;
	allOk = compare_float(block.var[3][3], -8.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-7.0, -4.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(2.0, 8.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(2.0, 8.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(-5.0, -5.0, -8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(-5.0, 1.0, -7.0, 4.0, 0.0, 8.0, 8.0, 0.0, 6.0, 7.0, 7.0, -5.0, 7.0, -7.0, 8.0, -5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat2x3(block.var, mat2x3(-1.0, 8.0, -7.0, 7.0, 8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var = (mat2x3(9.0, 4.0, 0.0, -8.0, -2.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_float(block.var[0][0], 2.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], 7.0) && allOk;
	allOk = compare_float(block.var[0][3], 8.0) && allOk;
	allOk = compare_float(block.var[1][0], 5.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][3], -5.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(2.0, -6.0, 7.0, 8.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(5.0, -7.0, 5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8.0);
	block.var[0] = (vec4(7.0, 8.0, 6.0, -6.0));
	block.var[1] = (vec4(-9.0, 0.0, -6.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_float(block.var[0][0], -5.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], 6.0) && allOk;
	allOk = compare_float(block.var[2][0], -7.0) && allOk;
	allOk = compare_float(block.var[2][1], -5.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-5.0, 1.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-4.0, 6.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0] = (vec2(1.0, -5.0));
	block.var[1] = (vec2(1.0, -4.0));
	block.var[2] = (vec2(1.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat3x4(block.var, mat3x4(-7.0, -3.0, 8.0, 1.0, 2.0, 8.0, -1.0, -4.0, 7.0, 5.0, -7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0] = (vec4(6.0, 5.0, 7.0, 1.0));
	block.var[1] = (vec4(-9.0, -8.0, -7.0, -3.0));
	block.var[2] = (vec4(-7.0, -8.0, -2.0, 7.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(-4.0, -9.0, 3.0, 1.0, 3.0, -7.0, 3.0, 6.0, 1.0, 2.0, 6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0] = (vec4(-6.0, -2.0, -1.0, 8.0));
	block.var[1] = (vec4(9.0, 3.0, -1.0, 5.0));
	block.var[2] = (vec4(-9.0, -9.0, 6.0, -3.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	block.var[0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block.var[0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	block.var[0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	block.var[1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	block.var[1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	block.var[1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	block.var[1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block.var[2][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	block.var[2][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	block.var[2][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[2][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	block.var[1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	block.var[2] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
}
#version 450
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
	u8vec2 var[3];
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
    if (allOk)
        ac_numPassed++;

	block.var[0] = u8vec2(uvec2(7u, 7u));
	block.var[1] = u8vec2(uvec2(9u, 6u));
	block.var[2] = u8vec2(uvec2(0u, 2u));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat2x4(block.var[0], mat2x4(8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(-8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0] = (mat2x4(9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0, -1.0));
	block.var[1] = (mat2x4(-4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0, 9.0));
	block.var[2] = (mat2x4(-9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat4x2(block.var[0], mat4x2(-2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0] = (mat4x2(-3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0, 5.0));
	block.var[1] = (mat4x2(-6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0, -5.0));
	block.var[2] = (mat4x2(-1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0, 2.0));
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(9.0, -9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(6.0, -4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(0.0, -5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(-9.0, -1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(1.0, 2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(-8.0, 1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(-7.0, -6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(-5.0, -2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(2.0, -3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(6.0, 0.0, 6.0, 8.0, -9.0, 4.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(-9.0, -1.0, 7.0, 9.0, 0.0, -2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-8.0, 4.0, 8.0, 3.0, -3.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(-9.0, 6.0, -4.0, -8.0, -5.0, -4.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(-8.0, 0.0, 4.0, -6.0, 5.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-1.0, -2.0, 0.0, -7.0, 8.0, -2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(9.0, -3.0, -7.0, 2.0, -4.0, -3.0, -7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	block.var[1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	block.var[2] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
	block.var[3] = (mat2x4(-8.0, -9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0));
	block.var[4] = (mat2x4(-5.0, 8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0));
	block.var[5] = (mat2x4(-6.0, -7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0));
	block.var[6] = (mat2x4(0.0, -6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0));
	block.var[7] = (mat2x4(-5.0, 4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0));
	block.var[8] = (mat2x4(-4.0, -7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0));
	block.var[9] = (mat2x4(-1.0, 7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0));
	block.var[10] = (mat2x4(-5.0, 3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0));
	block.var[11] = (mat2x4(5.0, 7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0));
	block.var[12] = (mat2x4(8.0, 3.0, 0.0, -3.0, 5.0, -4.0, 8.0, -3.0));
	block.var[13] = (mat2x4(7.0, -1.0, 5.0, 0.0, -5.0, 2.0, -3.0, -8.0));
	block.var[14] = (mat2x4(-9.0, 5.0, -6.0, -2.0, 0.0, 0.0, -2.0, -9.0));
	block.var[15] = (mat2x4(3.0, -5.0, -5.0, -6.0, 3.0, 0.0, -2.0, 5.0));
	block.var[16] = (mat2x4(-9.0, -9.0, 4.0, -7.0, -9.0, -2.0, 5.0, 9.0));
	block.var[17] = (mat2x4(0.0, 6.0, -3.0, -4.0, 0.0, -2.0, 8.0, 1.0));
	block.var[18] = (mat2x4(-3.0, -9.0, -7.0, -5.0, -2.0, 8.0, -8.0, -8.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	uint8_t var[];
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
	allOk = compare_uint8_t(uint(block.var[3]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[4]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[5]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[6]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[7]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[8]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[9]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[10]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[11]), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[12]), 6u) && allOk;
	allOk = compare_uint8_t(uint(block.var[13]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[14]), 5u) && allOk;
	allOk = compare_uint8_t(uint(block.var[15]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[16]), 8u) && allOk;
	allOk = compare_uint8_t(uint(block.var[17]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[18]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = uint8_t(9u);
	block.var[1] = uint8_t(5u);
	block.var[2] = uint8_t(2u);
	block.var[3] = uint8_t(6u);
	block.var[4] = uint8_t(7u);
	block.var[5] = uint8_t(5u);
	block.var[6] = uint8_t(8u);
	block.var[7] = uint8_t(4u);
	block.var[8] = uint8_t(2u);
	block.var[9] = uint8_t(6u);
	block.var[10] = uint8_t(0u);
	block.var[11] = uint8_t(1u);
	block.var[12] = uint8_t(6u);
	block.var[13] = uint8_t(0u);
	block.var[14] = uint8_t(5u);
	block.var[15] = uint8_t(4u);
	block.var[16] = uint8_t(1u);
	block.var[17] = uint8_t(3u);
	block.var[18] = uint8_t(0u);
}
#version 450
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
	uint16_t var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.var[0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[4]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[5]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[6]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[7]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[8]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[9]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[10]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[11]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[12]), 7u) && allOk;
	allOk = compare_uint16_t(uint(block.var[13]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[14]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[15]), 7u) && allOk;
	allOk = compare_uint16_t(uint(block.var[16]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[17]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[18]), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = uint16_t(9u);
	block.var[1] = uint16_t(1u);
	block.var[2] = uint16_t(1u);
	block.var[3] = uint16_t(0u);
	block.var[4] = uint16_t(7u);
	block.var[5] = uint16_t(5u);
	block.var[6] = uint16_t(8u);
	block.var[7] = uint16_t(1u);
	block.var[8] = uint16_t(9u);
	block.var[9] = uint16_t(7u);
	block.var[10] = uint16_t(2u);
	block.var[11] = uint16_t(6u);
	block.var[12] = uint16_t(3u);
	block.var[13] = uint16_t(1u);
	block.var[14] = uint16_t(0u);
	block.var[15] = uint16_t(2u);
	block.var[16] = uint16_t(1u);
	block.var[17] = uint16_t(1u);
	block.var[18] = uint16_t(2u);
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3], mat3x2(8.0, -7.0, 1.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[4], mat3x2(4.0, -3.0, -4.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[5], mat3x2(8.0, 4.0, 1.0, 2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[6], mat3x2(6.0, 6.0, -8.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[7], mat3x2(-9.0, -8.0, -5.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[8], mat3x2(-7.0, -9.0, 9.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[9], mat3x2(8.0, -7.0, 7.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[10], mat3x2(2.0, -1.0, 5.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[11], mat3x2(-7.0, -5.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[12], mat3x2(2.0, -3.0, -1.0, -7.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[13], mat3x2(1.0, -2.0, -2.0, -2.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[14], mat3x2(0.0, -1.0, 1.0, 9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[15], mat3x2(-9.0, 7.0, -7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[16], mat3x2(7.0, 4.0, 0.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[17], mat3x2(-3.0, 3.0, -7.0, -9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[18], mat3x2(7.0, 5.0, -6.0, -4.0, 8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(-2.0, 8.0));
	block.var[0][1] = (vec2(1.0, 8.0));
	block.var[0][2] = (vec2(-7.0, 5.0));
	block.var[1][0] = (vec2(2.0, 0.0));
	block.var[1][1] = (vec2(-3.0, 1.0));
	block.var[1][2] = (vec2(2.0, -5.0));
	block.var[2][0] = (vec2(6.0, 3.0));
	block.var[2][1] = (vec2(6.0, 5.0));
	block.var[2][2] = (vec2(-5.0, 9.0));
	block.var[3][0] = (vec2(-8.0, 9.0));
	block.var[3][1] = (vec2(3.0, -3.0));
	block.var[3][2] = (vec2(3.0, -5.0));
	block.var[4][0] = (vec2(7.0, -8.0));
	block.var[4][1] = (vec2(3.0, 1.0));
	block.var[4][2] = (vec2(-2.0, 1.0));
	block.var[5][0] = (vec2(4.0, -9.0));
	block.var[5][1] = (vec2(3.0, 6.0));
	block.var[5][2] = (vec2(7.0, 1.0));
	block.var[6][0] = (vec2(9.0, -9.0));
	block.var[6][1] = (vec2(0.0, -6.0));
	block.var[6][2] = (vec2(-7.0, 7.0));
	block.var[7][0] = (vec2(-8.0, 7.0));
	block.var[7][1] = (vec2(9.0, 6.0));
	block.var[7][2] = (vec2(-1.0, 0.0));
	block.var[8][0] = (vec2(-3.0, 6.0));
	block.var[8][1] = (vec2(-1.0, -6.0));
	block.var[8][2] = (vec2(-1.0, -3.0));
	block.var[9][0] = (vec2(0.0, -1.0));
	block.var[9][1] = (vec2(4.0, -9.0));
	block.var[9][2] = (vec2(1.0, 1.0));
	block.var[10][0] = (vec2(-9.0, 7.0));
	block.var[10][1] = (vec2(0.0, 4.0));
	block.var[10][2] = (vec2(-3.0, -3.0));
	block.var[11][0] = (vec2(6.0, 8.0));
	block.var[11][1] = (vec2(-7.0, 5.0));
	block.var[11][2] = (vec2(-6.0, -5.0));
	block.var[12][0] = (vec2(2.0, -2.0));
	block.var[12][1] = (vec2(-2.0, -8.0));
	block.var[12][2] = (vec2(7.0, -7.0));
	block.var[13][0] = (vec2(-1.0, 6.0));
	block.var[13][1] = (vec2(-8.0, 4.0));
	block.var[13][2] = (vec2(-5.0, 3.0));
	block.var[14][0] = (vec2(-9.0, -8.0));
	block.var[14][1] = (vec2(8.0, -9.0));
	block.var[14][2] = (vec2(-1.0, 1.0));
	block.var[15][0] = (vec2(0.0, 2.0));
	block.var[15][1] = (vec2(-1.0, -9.0));
	block.var[15][2] = (vec2(3.0, 4.0));
	block.var[16][0] = (vec2(6.0, -1.0));
	block.var[16][1] = (vec2(-4.0, -4.0));
	block.var[16][2] = (vec2(0.0, -6.0));
	block.var[17][0] = (vec2(5.0, -8.0));
	block.var[17][1] = (vec2(6.0, -8.0));
	block.var[17][2] = (vec2(-5.0, -8.0));
	block.var[18][0] = (vec2(4.0, -9.0));
	block.var[18][1] = (vec2(-4.0, 4.0));
	block.var[18][2] = (vec2(5.0, 3.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	u16vec4 var[];
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
	allOk = compare_u16vec4(uvec4(block.var[3]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[4]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[5]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[6]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[7]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[8]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[9]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[10]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[11]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[12]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[13]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[14]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[15]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[16]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[17]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[18]), uvec4(2u, 6u, 2u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	block.var[1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	block.var[2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	block.var[3] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	block.var[4] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	block.var[5] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	block.var[6] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	block.var[7] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	block.var[8] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	block.var[9] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	block.var[10] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	block.var[11] = u16vec4(uvec4(1u, 8u, 4u, 7u));
	block.var[12] = u16vec4(uvec4(6u, 9u, 4u, 2u));
	block.var[13] = u16vec4(uvec4(9u, 7u, 6u, 2u));
	block.var[14] = u16vec4(uvec4(8u, 4u, 6u, 2u));
	block.var[15] = u16vec4(uvec4(2u, 1u, 0u, 1u));
	block.var[16] = u16vec4(uvec4(9u, 9u, 4u, 6u));
	block.var[17] = u16vec4(uvec4(4u, 4u, 2u, 8u));
	block.var[18] = u16vec4(uvec4(7u, 8u, 2u, 8u));
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x2(block.var[0][0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(1.0, 1.0, -3.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(2.0, 8.0, 7.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(-4.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(8.0, -8.0, -7.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(3.0, 9.0, -2.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(-3.0, 9.0, 6.0, 2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(7.0, 1.0, 1.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(2.0, 7.0, -2.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-8.0, -1.0, -7.0, 9.0, 5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	block.var[0][1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	block.var[0][2] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
	block.var[1][0] = (mat3x2(2.0, 1.0, -5.0, 0.0, -3.0, 1.0));
	block.var[1][1] = (mat3x2(-4.0, 4.0, 5.0, -5.0, -6.0, 3.0));
	block.var[1][2] = (mat3x2(1.0, -2.0, 3.0, -8.0, -6.0, 2.0));
	block.var[2][0] = (mat3x2(-5.0, -4.0, -8.0, 9.0, -9.0, -8.0));
	block.var[2][1] = (mat3x2(8.0, -4.0, 1.0, -1.0, 7.0, 0.0));
	block.var[2][2] = (mat3x2(1.0, -3.0, 6.0, -4.0, -6.0, -5.0));
	block.var[3][0] = (mat3x2(-6.0, -4.0, 6.0, 4.0, 2.0, -8.0));
	block.var[3][1] = (mat3x2(2.0, 1.0, -3.0, -3.0, -5.0, -1.0));
	block.var[3][2] = (mat3x2(6.0, 9.0, 9.0, 9.0, -4.0, 8.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(-1.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(4.0, 1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(7.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(0.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(-6.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(-9.0, -1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(-9.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(4.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(8.0, -1.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(7.0, -3.0));
	block.var[0][0][1] = (vec2(-2.0, 4.0));
	block.var[0][1][0] = (vec2(1.0, -3.0));
	block.var[0][1][1] = (vec2(2.0, -4.0));
	block.var[0][2][0] = (vec2(-1.0, 1.0));
	block.var[0][2][1] = (vec2(-4.0, 3.0));
	block.var[1][0][0] = (vec2(7.0, -7.0));
	block.var[1][0][1] = (vec2(2.0, 5.0));
	block.var[1][1][0] = (vec2(-8.0, 4.0));
	block.var[1][1][1] = (vec2(8.0, 1.0));
	block.var[1][2][0] = (vec2(4.0, 6.0));
	block.var[1][2][1] = (vec2(-9.0, 9.0));
	block.var[2][0][0] = (vec2(1.0, 5.0));
	block.var[2][0][1] = (vec2(9.0, -6.0));
	block.var[2][1][0] = (vec2(-7.0, 5.0));
	block.var[2][1][1] = (vec2(7.0, 4.0));
	block.var[2][2][0] = (vec2(7.0, -9.0));
	block.var[2][2][1] = (vec2(0.0, 6.0));
	block.var[3][0][0] = (vec2(-1.0, -7.0));
	block.var[3][0][1] = (vec2(-8.0, 4.0));
	block.var[3][1][0] = (vec2(5.0, 6.0));
	block.var[3][1][1] = (vec2(-7.0, 7.0));
	block.var[3][2][0] = (vec2(-1.0, -5.0));
	block.var[3][2][1] = (vec2(9.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat3(block.var[0][0], mat3(-8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(-5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(-7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(-4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(-8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(-3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(-2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(-8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var[0][0] = (mat3(9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0, 8.0));
	block.var[0][1] = (mat3(-8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0, -2.0));
	block.var[0][2] = (mat3(5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0, 2.0));
	block.var[1][0] = (mat3(1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0, -6.0));
	block.var[1][1] = (mat3(-8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0, 2.0));
	block.var[1][2] = (mat3(-3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0, 3.0));
	block.var[2][0] = (mat3(5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0, 0.0));
	block.var[2][1] = (mat3(-4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0, 9.0));
	block.var[2][2] = (mat3(7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0, -6.0));
	block.var[3][0] = (mat3(-7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0, 2.0));
	block.var[3][1] = (mat3(4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0, -8.0));
	block.var[3][2] = (mat3(3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0, -1.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(4.0, -4.0, -2.0, 1.0, 2.0, 6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(8.0, 8.0, -3.0, -7.0, 8.0, -1.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(-4.0, 5.0, -6.0, 5.0, -9.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-9.0, -9.0, 0.0, -2.0, 7.0, 4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(0.0, -7.0, -8.0, 5.0, 7.0, -1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(4.0, 3.0, 5.0, -4.0, 8.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(6.0, 8.0, 5.0, -7.0, -9.0, 6.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(1.0, -1.0, 8.0, 0.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(0.0, 1.0, -7.0, 0.0, -4.0, 9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(-3.0, 5.0, 6.0, 1.0, -2.0, 9.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(2.0, 8.0, -2.0, -7.0, 4.0, -5.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(-1.0, 2.0, 3.0, -6.0, 2.0, 8.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	block.var[0][0][1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	block.var[0][0][2] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	block.var[0][1][0] = (mat4x2(2.0, -6.0, -9.0, 6.0, 2.0, -2.0, 9.0, 8.0));
	block.var[0][1][1] = (mat4x2(8.0, 3.0, -2.0, -8.0, 8.0, 4.0, -3.0, 4.0));
	block.var[0][1][2] = (mat4x2(-5.0, 5.0, 9.0, -8.0, -8.0, -5.0, -4.0, -1.0));
	block.var[1][0][0] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	block.var[1][0][1] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	block.var[1][0][2] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	block.var[1][1][0] = (mat4x2(-1.0, -6.0, 6.0, -3.0, -5.0, 2.0, 6.0, 1.0));
	block.var[1][1][1] = (mat4x2(-9.0, 0.0, -5.0, -9.0, 9.0, 8.0, -6.0, -4.0));
	block.var[1][1][2] = (mat4x2(-4.0, -8.0, 9.0, 7.0, -5.0, -3.0, 3.0, 7.0));
	block.var[2][0][0] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	block.var[2][0][1] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	block.var[2][0][2] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	block.var[2][1][0] = (mat4x2(-1.0, 2.0, 5.0, -9.0, 3.0, 2.0, -5.0, 4.0));
	block.var[2][1][1] = (mat4x2(-2.0, 3.0, -1.0, -4.0, -7.0, 3.0, 1.0, -1.0));
	block.var[2][1][2] = (mat4x2(3.0, 6.0, -6.0, -2.0, -8.0, 0.0, -9.0, -5.0));
	block.var[3][0][0] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	block.var[3][0][1] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	block.var[3][0][2] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
	block.var[3][1][0] = (mat4x2(-9.0, 5.0, -9.0, 2.0, -2.0, -5.0, -3.0, 5.0));
	block.var[3][1][1] = (mat4x2(-8.0, -1.0, 9.0, 1.0, -6.0, 5.0, -5.0, -9.0));
	block.var[3][1][2] = (mat4x2(7.0, 1.0, 0.0, 3.0, 4.0, 8.0, 8.0, -2.0));
}
#version 450
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
	highp mat2 var[4][2][3];
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-8.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(6.0, 6.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-7.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(9.0, -6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(-7.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(0.0, -7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(-9.0, 1.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(4.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(3.0, -4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(-8.0, -4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(5.0, 3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(-5.0, -2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(2.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(2.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(9.0, 6.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(-1.0, 9.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-5.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(-7.0, -3.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(2.0, 4.0, 4.0, -1.0));
	block.var[0][0][1] = (mat2(2.0, -5.0, 1.0, -1.0));
	block.var[0][0][2] = (mat2(-2.0, -9.0, -3.0, -8.0));
	block.var[0][1][0] = (mat2(-5.0, 7.0, -8.0, 6.0));
	block.var[0][1][1] = (mat2(1.0, 0.0, 7.0, -3.0));
	block.var[0][1][2] = (mat2(9.0, -8.0, -6.0, -9.0));
	block.var[1][0][0] = (mat2(-6.0, -7.0, 1.0, -1.0));
	block.var[1][0][1] = (mat2(6.0, 2.0, -7.0, 8.0));
	block.var[1][0][2] = (mat2(-3.0, -2.0, 2.0, -7.0));
	block.var[1][1][0] = (mat2(-6.0, 8.0, 1.0, -2.0));
	block.var[1][1][1] = (mat2(-4.0, -5.0, -4.0, 2.0));
	block.var[1][1][2] = (mat2(4.0, -9.0, 8.0, -9.0));
	block.var[2][0][0] = (mat2(-1.0, -3.0, -7.0, 2.0));
	block.var[2][0][1] = (mat2(-3.0, -6.0, 2.0, 7.0));
	block.var[2][0][2] = (mat2(4.0, -2.0, -7.0, 4.0));
	block.var[2][1][0] = (mat2(-2.0, 2.0, 3.0, -3.0));
	block.var[2][1][1] = (mat2(3.0, 2.0, -9.0, -5.0));
	block.var[2][1][2] = (mat2(-9.0, 7.0, -7.0, 5.0));
	block.var[3][0][0] = (mat2(-7.0, -5.0, -7.0, -5.0));
	block.var[3][0][1] = (mat2(-6.0, 4.0, 6.0, 4.0));
	block.var[3][0][2] = (mat2(2.0, -1.0, 9.0, 6.0));
	block.var[3][1][0] = (mat2(-9.0, -6.0, -9.0, 3.0));
	block.var[3][1][1] = (mat2(4.0, -2.0, 0.0, -7.0));
	block.var[3][1][2] = (mat2(4.0, -2.0, -8.0, 0.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(-3.0, 4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(-6.0, -2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(0.0, -2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-2.0, -2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(1.0, -7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(-2.0, -9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(1.0, 6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-3.0, -8.0, 9.0, 1.0, 3.0, -9.0, 9.0, -2.0, -7.0, 2.0, 9.0, -7.0, -5.0, 5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(-6.0, -4.0, -8.0, -3.0, -3.0, 0.0, 3.0, 9.0, 7.0, 2.0, 4.0, 6.0, -9.0, 8.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-5.0, -2.0, 1.0, -4.0, 8.0, -8.0, -5.0, -7.0, 8.0, -9.0, 4.0, 3.0, 2.0, 9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(4.0, -4.0, 9.0, 3.0, -5.0, -7.0, 0.0, 3.0, -3.0, 6.0, -9.0, 9.0, 9.0, 8.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(9.0, 7.0, -7.0, -6.0, 0.0, -3.0, -2.0, 5.0, 2.0, -1.0, 0.0, -8.0, 1.0, -4.0, -7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-3.0, -6.0, 8.0, 7.0));
	block.var[0][0][0][1] = (vec4(-8.0, 6.0, 1.0, -6.0));
	block.var[0][0][0][2] = (vec4(6.0, 0.0, -6.0, 3.0));
	block.var[0][0][0][3] = (vec4(3.0, 3.0, -3.0, 2.0));
	block.var[0][0][1][0] = (vec4(-8.0, 9.0, -6.0, 6.0));
	block.var[0][0][1][1] = (vec4(1.0, 9.0, -7.0, 4.0));
	block.var[0][0][1][2] = (vec4(-5.0, 5.0, -6.0, 5.0));
	block.var[0][0][1][3] = (vec4(7.0, 7.0, -5.0, -9.0));
	block.var[0][0][2][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	block.var[0][0][2][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	block.var[0][0][2][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	block.var[0][0][2][3] = (vec4(0.0, -7.0, 7.0, 8.0));
	block.var[0][1][0][0] = (vec4(8.0, -9.0, 9.0, 7.0));
	block.var[0][1][0][1] = (vec4(-9.0, 5.0, 1.0, -4.0));
	block.var[0][1][0][2] = (vec4(-1.0, -2.0, 1.0, 5.0));
	block.var[0][1][0][3] = (vec4(-1.0, -5.0, 7.0, -6.0));
	block.var[0][1][1][0] = (vec4(1.0, 0.0, 9.0, -3.0));
	block.var[0][1][1][1] = (vec4(7.0, 0.0, -6.0, -7.0));
	block.var[0][1][1][2] = (vec4(-8.0, 1.0, -2.0, 9.0));
	block.var[0][1][1][3] = (vec4(0.0, -2.0, 6.0, -1.0));
	block.var[0][1][2][0] = (vec4(-5.0, -1.0, -3.0, 5.0));
	block.var[0][1][2][1] = (vec4(-7.0, 4.0, 5.0, -9.0));
	block.var[0][1][2][2] = (vec4(-1.0, 0.0, 8.0, 8.0));
	block.var[0][1][2][3] = (vec4(-3.0, 4.0, -4.0, -4.0));
	block.var[1][0][0][0] = (vec4(-6.0, -6.0, -1.0, 6.0));
	block.var[1][0][0][1] = (vec4(3.0, 5.0, -8.0, 3.0));
	block.var[1][0][0][2] = (vec4(1.0, -1.0, 3.0, -5.0));
	block.var[1][0][0][3] = (vec4(4.0, -4.0, 3.0, 4.0));
	block.var[1][0][1][0] = (vec4(-4.0, -8.0, 4.0, 5.0));
	block.var[1][0][1][1] = (vec4(-5.0, 0.0, -3.0, -4.0));
	block.var[1][0][1][2] = (vec4(5.0, -4.0, -7.0, 4.0));
	block.var[1][0][1][3] = (vec4(-3.0, 9.0, 3.0, -4.0));
	block.var[1][0][2][0] = (vec4(-3.0, -9.0, 6.0, -3.0));
	block.var[1][0][2][1] = (vec4(-6.0, -1.0, 8.0, 3.0));
	block.var[1][0][2][2] = (vec4(-2.0, 9.0, -2.0, -3.0));
	block.var[1][0][2][3] = (vec4(-8.0, 3.0, -8.0, 5.0));
	block.var[1][1][0][0] = (vec4(5.0, 8.0, -8.0, -1.0));
	block.var[1][1][0][1] = (vec4(-7.0, 8.0, 4.0, -1.0));
	block.var[1][1][0][2] = (vec4(-1.0, -9.0, 3.0, 2.0));
	block.var[1][1][0][3] = (vec4(4.0, -2.0, 7.0, 5.0));
	block.var[1][1][1][0] = (vec4(0.0, -5.0, 2.0, 2.0));
	block.var[1][1][1][1] = (vec4(4.0, 4.0, -9.0, 3.0));
	block.var[1][1][1][2] = (vec4(1.0, 0.0, 5.0, -8.0));
	block.var[1][1][1][3] = (vec4(-3.0, -3.0, 3.0, -6.0));
	block.var[1][1][2][0] = (vec4(-5.0, 9.0, 0.0, -6.0));
	block.var[1][1][2][1] = (vec4(-2.0, -4.0, 3.0, 1.0));
	block.var[1][1][2][2] = (vec4(4.0, 1.0, -3.0, 6.0));
	block.var[1][1][2][3] = (vec4(-2.0, -7.0, -7.0, 9.0));
	block.var[2][0][0][0] = (vec4(7.0, -2.0, -7.0, 3.0));
	block.var[2][0][0][1] = (vec4(8.0, -7.0, -6.0, 4.0));
	block.var[2][0][0][2] = (vec4(-4.0, 6.0, -2.0, -7.0));
	block.var[2][0][0][3] = (vec4(7.0, 8.0, -8.0, -2.0));
	block.var[2][0][1][0] = (vec4(-8.0, 3.0, 9.0, 3.0));
	block.var[2][0][1][1] = (vec4(1.0, -3.0, -5.0, -8.0));
	block.var[2][0][1][2] = (vec4(-7.0, 5.0, -1.0, -6.0));
	block.var[2][0][1][3] = (vec4(8.0, -8.0, 4.0, 8.0));
	block.var[2][0][2][0] = (vec4(6.0, -5.0, 4.0, -3.0));
	block.var[2][0][2][1] = (vec4(-1.0, -8.0, 3.0, 5.0));
	block.var[2][0][2][2] = (vec4(0.0, 7.0, 6.0, -4.0));
	block.var[2][0][2][3] = (vec4(1.0, 4.0, 3.0, 6.0));
	block.var[2][1][0][0] = (vec4(-2.0, -6.0, -2.0, -5.0));
	block.var[2][1][0][1] = (vec4(-9.0, 4.0, 4.0, -5.0));
	block.var[2][1][0][2] = (vec4(-1.0, -1.0, 0.0, -7.0));
	block.var[2][1][0][3] = (vec4(5.0, 7.0, -3.0, -7.0));
	block.var[2][1][1][0] = (vec4(9.0, -7.0, 5.0, 1.0));
	block.var[2][1][1][1] = (vec4(-7.0, 4.0, 8.0, -9.0));
	block.var[2][1][1][2] = (vec4(6.0, 2.0, -8.0, 8.0));
	block.var[2][1][1][3] = (vec4(3.0, 6.0, 9.0, 6.0));
	block.var[2][1][2][0] = (vec4(-4.0, -8.0, -1.0, 1.0));
	block.var[2][1][2][1] = (vec4(0.0, 5.0, 8.0, 6.0));
	block.var[2][1][2][2] = (vec4(3.0, 8.0, -7.0, -1.0));
	block.var[2][1][2][3] = (vec4(2.0, 3.0, 7.0, 3.0));
	block.var[3][0][0][0] = (vec4(-3.0, -8.0, -6.0, 5.0));
	block.var[3][0][0][1] = (vec4(-9.0, -3.0, 0.0, -1.0));
	block.var[3][0][0][2] = (vec4(-5.0, 9.0, -8.0, -9.0));
	block.var[3][0][0][3] = (vec4(-1.0, 2.0, 5.0, 6.0));
	block.var[3][0][1][0] = (vec4(2.0, 3.0, 8.0, 8.0));
	block.var[3][0][1][1] = (vec4(-7.0, -1.0, 5.0, -3.0));
	block.var[3][0][1][2] = (vec4(5.0, -3.0, -4.0, 6.0));
	block.var[3][0][1][3] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[3][0][2][0] = (vec4(7.0, -3.0, -8.0, 1.0));
	block.var[3][0][2][1] = (vec4(1.0, 2.0, 3.0, 1.0));
	block.var[3][0][2][2] = (vec4(5.0, -2.0, 2.0, -2.0));
	block.var[3][0][2][3] = (vec4(-9.0, -1.0, 2.0, -1.0));
	block.var[3][1][0][0] = (vec4(-2.0, -1.0, 0.0, -2.0));
	block.var[3][1][0][1] = (vec4(7.0, -6.0, 5.0, 5.0));
	block.var[3][1][0][2] = (vec4(-9.0, -8.0, -5.0, 0.0));
	block.var[3][1][0][3] = (vec4(-2.0, 3.0, 8.0, 4.0));
	block.var[3][1][1][0] = (vec4(-2.0, -3.0, -9.0, 9.0));
	block.var[3][1][1][1] = (vec4(-6.0, -1.0, -3.0, 3.0));
	block.var[3][1][1][2] = (vec4(-7.0, 5.0, -6.0, 8.0));
	block.var[3][1][1][3] = (vec4(0.0, -5.0, 0.0, 4.0));
	block.var[3][1][2][0] = (vec4(-2.0, -9.0, -1.0, -2.0));
	block.var[3][1][2][1] = (vec4(2.0, -4.0, -6.0, -5.0));
	block.var[3][1][2][2] = (vec4(4.0, -4.0, 7.0, 2.0));
	block.var[3][1][2][3] = (vec4(3.0, 2.0, -2.0, -5.0));
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat4(block.var[0][0][0], mat4(-2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0, 8.0, 1.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0, -4.0, -7.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(6.0, 6.0, 9.0, 9.0, 7.0, 3.0, 6.0, 1.0, 5.0, 1.0, 7.0, -7.0, 9.0, -7.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(0.0, 3.0, -7.0, -8.0, -9.0, 1.0, 4.0, 2.0, 0.0, -6.0, 3.0, 9.0, 7.0, 4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(6.0, -7.0, 3.0, -2.0, -8.0, 6.0, 5.0, 8.0, 5.0, 1.0, 8.0, 1.0, 7.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0, 6.0, 6.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0, -5.0, -8.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0, -8.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(4.0, 2.0, -1.0, 8.0, -6.0, 2.0, 6.0, 6.0, 5.0, 4.0, 5.0, 3.0, -3.0, -5.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-1.0, 9.0, 7.0, 9.0, 5.0, -5.0, -5.0, 8.0, -5.0, 7.0, -8.0, 2.0, -2.0, -6.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(7.0, -6.0, -4.0, 7.0, 5.0, -4.0, -1.0, 2.0, 6.0, 9.0, 2.0, 7.0, -6.0, 5.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0, 1.0, -9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0, 9.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(-6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0, 3.0, -9.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(4.0, 0.0, -4.0, -1.0, 4.0, -5.0, -8.0, 0.0, 8.0, 4.0, 5.0, 7.0, 4.0, -8.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-1.0, -8.0, 9.0, 7.0, 4.0, -2.0, -7.0, 3.0, -9.0, -1.0, 9.0, -7.0, -8.0, 8.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(-3.0, 1.0, -4.0, -5.0, 3.0, -9.0, 9.0, -1.0, -6.0, 8.0, 3.0, -3.0, -4.0, -3.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(-4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0, -3.0, -3.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(-4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0, 7.0, -4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0, -1.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(7.0, 6.0, 2.0, 2.0, 3.0, -2.0, -1.0, 2.0, 5.0, 3.0, 5.0, -9.0, 8.0, 6.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(-4.0, 2.0, 7.0, 7.0, 6.0, 6.0, 7.0, -3.0, 6.0, -1.0, -1.0, 4.0, 6.0, 8.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(-1.0, -5.0, -9.0, 8.0, -6.0, 4.0, 3.0, 9.0, 3.0, -1.0, 0.0, -8.0, -5.0, 8.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var[0][0][0] = (mat4(5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0, 6.0, -9.0, 9.0, -6.0));
	block.var[0][0][1] = (mat4(-2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0, 3.0, -2.0, 2.0, -7.0));
	block.var[0][0][2] = (mat4(-4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0, -7.0, 8.0, 1.0, 6.0));
	block.var[0][1][0] = (mat4(2.0, -8.0, -3.0, 3.0, -4.0, 1.0, 2.0, 3.0, -1.0, 1.0, 8.0, -3.0, 4.0, 7.0, 8.0, 0.0));
	block.var[0][1][1] = (mat4(2.0, 8.0, 7.0, 5.0, 3.0, 8.0, 4.0, -1.0, 5.0, -1.0, -3.0, 5.0, 5.0, -3.0, -5.0, -7.0));
	block.var[0][1][2] = (mat4(9.0, -1.0, 0.0, 8.0, -3.0, 4.0, 5.0, -5.0, 1.0, -8.0, -1.0, 3.0, 1.0, 5.0, -4.0, 9.0));
	block.var[1][0][0] = (mat4(6.0, 3.0, 3.0, 2.0, -4.0, 4.0, 2.0, -3.0, -7.0, -8.0, -6.0, 1.0, -6.0, 8.0, 6.0, -4.0));
	block.var[1][0][1] = (mat4(-2.0, -9.0, 0.0, 3.0, 9.0, 2.0, -5.0, 5.0, 1.0, 9.0, -1.0, 0.0, -6.0, -2.0, -5.0, -4.0));
	block.var[1][0][2] = (mat4(1.0, -1.0, -7.0, -1.0, -1.0, 3.0, -8.0, 4.0, 8.0, 4.0, -3.0, -8.0, 8.0, 6.0, -2.0, 3.0));
	block.var[1][1][0] = (mat4(1.0, -8.0, 4.0, 2.0, 8.0, 3.0, -2.0, -6.0, 2.0, -7.0, 1.0, 0.0, -4.0, -2.0, 7.0, 5.0));
	block.var[1][1][1] = (mat4(-3.0, 9.0, 9.0, 8.0, 9.0, 7.0, 5.0, 1.0, -6.0, -4.0, -4.0, 4.0, 9.0, 8.0, 8.0, 1.0));
	block.var[1][1][2] = (mat4(-1.0, 2.0, 2.0, 4.0, -1.0, -9.0, 4.0, 4.0, 1.0, -7.0, 7.0, -7.0, 4.0, 7.0, 6.0, -6.0));
	block.var[2][0][0] = (mat4(0.0, 3.0, 7.0, 6.0, 4.0, 6.0, 8.0, -9.0, 5.0, 9.0, -4.0, -4.0, -8.0, 9.0, 8.0, 1.0));
	block.var[2][0][1] = (mat4(7.0, 1.0, -7.0, -6.0, -9.0, 6.0, -5.0, -8.0, 1.0, -3.0, 3.0, 4.0, 0.0, -1.0, 1.0, -4.0));
	block.var[2][0][2] = (mat4(2.0, -4.0, 9.0, -7.0, -6.0, 4.0, 4.0, -2.0, -6.0, 1.0, 2.0, -7.0, 2.0, 6.0, -8.0, -2.0));
	block.var[2][1][0] = (mat4(1.0, 3.0, 4.0, -7.0, -9.0, -3.0, 3.0, -1.0, 8.0, 6.0, 3.0, 3.0, 6.0, 8.0, 4.0, -8.0));
	block.var[2][1][1] = (mat4(4.0, -4.0, -8.0, 9.0, 7.0, 7.0, -3.0, -6.0, 5.0, -5.0, -1.0, 7.0, 1.0, -8.0, -4.0, 9.0));
	block.var[2][1][2] = (mat4(8.0, 2.0, -9.0, 3.0, -4.0, 5.0, 1.0, -7.0, 4.0, 7.0, 6.0, -4.0, 7.0, -2.0, -4.0, 3.0));
	block.var[3][0][0] = (mat4(4.0, -4.0, 2.0, 4.0, 2.0, -1.0, -8.0, 0.0, -9.0, 2.0, 8.0, 9.0, 7.0, 4.0, 1.0, -1.0));
	block.var[3][0][1] = (mat4(7.0, 1.0, -8.0, -8.0, -3.0, -2.0, 5.0, 7.0, -2.0, -8.0, 8.0, -6.0, -7.0, -2.0, -1.0, 4.0));
	block.var[3][0][2] = (mat4(-1.0, -3.0, -8.0, 3.0, -3.0, 8.0, 1.0, -4.0, -9.0, -7.0, 3.0, 6.0, 3.0, -2.0, -4.0, -8.0));
	block.var[3][1][0] = (mat4(-9.0, -3.0, -4.0, 6.0, 9.0, 3.0, 8.0, -1.0, -7.0, -5.0, -3.0, 0.0, 4.0, 2.0, 1.0, 3.0));
	block.var[3][1][1] = (mat4(-7.0, 8.0, -5.0, -9.0, 7.0, 9.0, 7.0, -5.0, -8.0, -4.0, 1.0, -8.0, -6.0, -2.0, 7.0, -5.0));
	block.var[3][1][2] = (mat4(2.0, -4.0, 1.0, -3.0, -5.0, -5.0, 1.0, -7.0, 7.0, -1.0, -5.0, 5.0, -6.0, 4.0, 9.0, 7.0));
}
#version 450
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
	f16vec4 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.padding), -8.0) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][0][0]), vec4(-9.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][0][1]), vec4(-8.0, -8.0, -3.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][0][2]), vec4(6.0, 1.0, -8.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][1][0]), vec4(-7.0, -3.0, 1.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][1][1]), vec4(0.0, -2.0, -8.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][1][2]), vec4(-5.0, 8.0, 0.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][0][0]), vec4(7.0, 5.0, -6.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][0][1]), vec4(-4.0, -8.0, -4.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][0][2]), vec4(6.0, -4.0, 5.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][1][0]), vec4(7.0, -3.0, -1.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][1][1]), vec4(7.0, 0.0, -6.0, -7.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][1][2]), vec4(6.0, 0.0, -6.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][0][0]), vec4(3.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][0][1]), vec4(-9.0, 0.0, 3.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][0][2]), vec4(-2.0, -4.0, -2.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][1][0]), vec4(0.0, -7.0, 0.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][1][1]), vec4(0.0, 9.0, -9.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][1][2]), vec4(3.0, 4.0, 4.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][0][0]), vec4(-9.0, -6.0, 4.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][0][1]), vec4(5.0, -9.0, 9.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][0][2]), vec4(7.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][1][0]), vec4(-8.0, 6.0, -5.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][1][1]), vec4(-8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][1][2]), vec4(9.0, -3.0, -7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = float16_t(9.0);
	block.var[0][0][0] = f16vec4(vec4(-6.0, 2.0, -8.0, -7.0));
	block.var[0][0][1] = f16vec4(vec4(-4.0, 2.0, -5.0, 9.0));
	block.var[0][0][2] = f16vec4(vec4(1.0, -6.0, 3.0, -1.0));
	block.var[0][1][0] = f16vec4(vec4(3.0, -7.0, -9.0, 6.0));
	block.var[0][1][1] = f16vec4(vec4(-8.0, -8.0, 3.0, 1.0));
	block.var[0][1][2] = f16vec4(vec4(-6.0, -6.0, 9.0, 9.0));
	block.var[1][0][0] = f16vec4(vec4(4.0, -1.0, -8.0, 5.0));
	block.var[1][0][1] = f16vec4(vec4(8.0, 7.0, 0.0, 4.0));
	block.var[1][0][2] = f16vec4(vec4(-5.0, -6.0, -8.0, -6.0));
	block.var[1][1][0] = f16vec4(vec4(-7.0, 7.0, -4.0, -3.0));
	block.var[1][1][1] = f16vec4(vec4(0.0, -5.0, -5.0, -6.0));
	block.var[1][1][2] = f16vec4(vec4(-7.0, -2.0, -8.0, -3.0));
	block.var[2][0][0] = f16vec4(vec4(2.0, -4.0, 8.0, -4.0));
	block.var[2][0][1] = f16vec4(vec4(-1.0, 8.0, 9.0, 0.0));
	block.var[2][0][2] = f16vec4(vec4(0.0, -5.0, 5.0, 7.0));
	block.var[2][1][0] = f16vec4(vec4(-6.0, 7.0, 3.0, -6.0));
	block.var[2][1][1] = f16vec4(vec4(-9.0, -2.0, 7.0, 2.0));
	block.var[2][1][2] = f16vec4(vec4(-6.0, -5.0, 8.0, 6.0));
	block.var[3][0][0] = f16vec4(vec4(-6.0, -7.0, -8.0, -3.0));
	block.var[3][0][1] = f16vec4(vec4(-4.0, -7.0, 0.0, -7.0));
	block.var[3][0][2] = f16vec4(vec4(-2.0, 7.0, -1.0, 8.0));
	block.var[3][1][0] = f16vec4(vec4(1.0, -5.0, 6.0, -5.0));
	block.var[3][1][1] = f16vec4(vec4(-9.0, -6.0, -4.0, -5.0));
	block.var[3][1][2] = f16vec4(vec4(-8.0, 1.0, 2.0, 9.0));
}
#version 450
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
	highp uvec3 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((block.var[0][0][0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[0][0][1]), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[0][1][0]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[0][1][1]), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[0][2][0]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((block.var[0][2][1]), uvec3(5u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[0][3][0]), uvec3(9u, 3u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[0][3][1]), uvec3(5u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[1][0][0]), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_uvec3((block.var[1][0][1]), uvec3(6u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[1][1][0]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[1][1][1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[1][2][0]), uvec3(6u, 6u, 8u)) && allOk;
	allOk = compare_uvec3((block.var[1][2][1]), uvec3(6u, 7u, 9u)) && allOk;
	allOk = compare_uvec3((block.var[1][3][0]), uvec3(2u, 3u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[1][3][1]), uvec3(1u, 4u, 9u)) && allOk;
	allOk = compare_uvec3((block.var[2][0][0]), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((block.var[2][0][1]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[2][1][0]), uvec3(8u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[2][1][1]), uvec3(7u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((block.var[2][2][0]), uvec3(0u, 0u, 6u)) && allOk;
	allOk = compare_uvec3((block.var[2][2][1]), uvec3(0u, 2u, 2u)) && allOk;
	allOk = compare_uvec3((block.var[2][3][0]), uvec3(7u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[2][3][1]), uvec3(7u, 0u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (uvec3(3u, 5u, 6u));
	block.var[0][0][1] = (uvec3(5u, 4u, 5u));
	block.var[0][1][0] = (uvec3(9u, 4u, 3u));
	block.var[0][1][1] = (uvec3(5u, 8u, 0u));
	block.var[0][2][0] = (uvec3(1u, 1u, 6u));
	block.var[0][2][1] = (uvec3(3u, 9u, 4u));
	block.var[0][3][0] = (uvec3(4u, 8u, 7u));
	block.var[0][3][1] = (uvec3(1u, 5u, 2u));
	block.var[1][0][0] = (uvec3(4u, 9u, 4u));
	block.var[1][0][1] = (uvec3(4u, 7u, 7u));
	block.var[1][1][0] = (uvec3(5u, 4u, 6u));
	block.var[1][1][1] = (uvec3(7u, 7u, 5u));
	block.var[1][2][0] = (uvec3(9u, 7u, 9u));
	block.var[1][2][1] = (uvec3(1u, 4u, 6u));
	block.var[1][3][0] = (uvec3(4u, 1u, 2u));
	block.var[1][3][1] = (uvec3(6u, 5u, 3u));
	block.var[2][0][0] = (uvec3(0u, 2u, 9u));
	block.var[2][0][1] = (uvec3(4u, 7u, 8u));
	block.var[2][1][0] = (uvec3(3u, 7u, 0u));
	block.var[2][1][1] = (uvec3(8u, 1u, 2u));
	block.var[2][2][0] = (uvec3(4u, 9u, 3u));
	block.var[2][2][1] = (uvec3(4u, 3u, 5u));
	block.var[2][3][0] = (uvec3(8u, 8u, 7u));
	block.var[2][3][1] = (uvec3(1u, 2u, 5u));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(-3.0, 4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(-6.0, -2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(1.0, 6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(-3.0, -8.0, 9.0, 1.0, 3.0, -9.0, 9.0, -2.0, -7.0, 2.0, 9.0, -7.0, -5.0, 5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(0.0, -2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(-2.0, -2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(-6.0, -4.0, -8.0, -3.0, -3.0, 0.0, 3.0, 9.0, 7.0, 2.0, 4.0, 6.0, -9.0, 8.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(-5.0, -2.0, 1.0, -4.0, 8.0, -8.0, -5.0, -7.0, 8.0, -9.0, 4.0, 3.0, 2.0, 9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(1.0, -7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(-2.0, -9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(4.0, -4.0, 9.0, 3.0, -5.0, -7.0, 0.0, 3.0, -3.0, 6.0, -9.0, 9.0, 9.0, 8.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(9.0, 7.0, -7.0, -6.0, 0.0, -3.0, -2.0, 5.0, 2.0, -1.0, 0.0, -8.0, 1.0, -4.0, -7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-3.0, -6.0, 8.0, 7.0));
	block.var[0][0][0][1] = (vec4(-8.0, 6.0, 1.0, -6.0));
	block.var[0][0][0][2] = (vec4(6.0, 0.0, -6.0, 3.0));
	block.var[0][0][0][3] = (vec4(3.0, 3.0, -3.0, 2.0));
	block.var[0][0][1][0] = (vec4(-8.0, 9.0, -6.0, 6.0));
	block.var[0][0][1][1] = (vec4(1.0, 9.0, -7.0, 4.0));
	block.var[0][0][1][2] = (vec4(-5.0, 5.0, -6.0, 5.0));
	block.var[0][0][1][3] = (vec4(7.0, 7.0, -5.0, -9.0));
	block.var[0][1][0][0] = (vec4(7.0, -2.0, -7.0, 3.0));
	block.var[0][1][0][1] = (vec4(8.0, -7.0, -6.0, 4.0));
	block.var[0][1][0][2] = (vec4(-4.0, 6.0, -2.0, -7.0));
	block.var[0][1][0][3] = (vec4(7.0, 8.0, -8.0, -2.0));
	block.var[0][1][1][0] = (vec4(-8.0, 3.0, 9.0, 3.0));
	block.var[0][1][1][1] = (vec4(1.0, -3.0, -5.0, -8.0));
	block.var[0][1][1][2] = (vec4(-7.0, 5.0, -1.0, -6.0));
	block.var[0][1][1][3] = (vec4(8.0, -8.0, 4.0, 8.0));
	block.var[0][2][0][0] = (vec4(8.0, -9.0, 9.0, 7.0));
	block.var[0][2][0][1] = (vec4(-9.0, 5.0, 1.0, -4.0));
	block.var[0][2][0][2] = (vec4(-1.0, -2.0, 1.0, 5.0));
	block.var[0][2][0][3] = (vec4(-1.0, -5.0, 7.0, -6.0));
	block.var[0][2][1][0] = (vec4(1.0, 0.0, 9.0, -3.0));
	block.var[0][2][1][1] = (vec4(7.0, 0.0, -6.0, -7.0));
	block.var[0][2][1][2] = (vec4(-8.0, 1.0, -2.0, 9.0));
	block.var[0][2][1][3] = (vec4(0.0, -2.0, 6.0, -1.0));
	block.var[0][3][0][0] = (vec4(-2.0, -6.0, -2.0, -5.0));
	block.var[0][3][0][1] = (vec4(-9.0, 4.0, 4.0, -5.0));
	block.var[0][3][0][2] = (vec4(-1.0, -1.0, 0.0, -7.0));
	block.var[0][3][0][3] = (vec4(5.0, 7.0, -3.0, -7.0));
	block.var[0][3][1][0] = (vec4(9.0, -7.0, 5.0, 1.0));
	block.var[0][3][1][1] = (vec4(-7.0, 4.0, 8.0, -9.0));
	block.var[0][3][1][2] = (vec4(6.0, 2.0, -8.0, 8.0));
	block.var[0][3][1][3] = (vec4(3.0, 6.0, 9.0, 6.0));
	block.var[1][0][0][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	block.var[1][0][0][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	block.var[1][0][0][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	block.var[1][0][0][3] = (vec4(0.0, -7.0, 7.0, 8.0));
	block.var[1][0][1][0] = (vec4(-6.0, -6.0, -1.0, 6.0));
	block.var[1][0][1][1] = (vec4(3.0, 5.0, -8.0, 3.0));
	block.var[1][0][1][2] = (vec4(1.0, -1.0, 3.0, -5.0));
	block.var[1][0][1][3] = (vec4(4.0, -4.0, 3.0, 4.0));
	block.var[1][1][0][0] = (vec4(6.0, -5.0, 4.0, -3.0));
	block.var[1][1][0][1] = (vec4(-1.0, -8.0, 3.0, 5.0));
	block.var[1][1][0][2] = (vec4(0.0, 7.0, 6.0, -4.0));
	block.var[1][1][0][3] = (vec4(1.0, 4.0, 3.0, 6.0));
	block.var[1][1][1][0] = (vec4(-3.0, -8.0, -6.0, 5.0));
	block.var[1][1][1][1] = (vec4(-9.0, -3.0, 0.0, -1.0));
	block.var[1][1][1][2] = (vec4(-5.0, 9.0, -8.0, -9.0));
	block.var[1][1][1][3] = (vec4(-1.0, 2.0, 5.0, 6.0));
	block.var[1][2][0][0] = (vec4(-5.0, -1.0, -3.0, 5.0));
	block.var[1][2][0][1] = (vec4(-7.0, 4.0, 5.0, -9.0));
	block.var[1][2][0][2] = (vec4(-1.0, 0.0, 8.0, 8.0));
	block.var[1][2][0][3] = (vec4(-3.0, 4.0, -4.0, -4.0));
	block.var[1][2][1][0] = (vec4(5.0, 8.0, -8.0, -1.0));
	block.var[1][2][1][1] = (vec4(-7.0, 8.0, 4.0, -1.0));
	block.var[1][2][1][2] = (vec4(-1.0, -9.0, 3.0, 2.0));
	block.var[1][2][1][3] = (vec4(4.0, -2.0, 7.0, 5.0));
	block.var[1][3][0][0] = (vec4(-4.0, -8.0, -1.0, 1.0));
	block.var[1][3][0][1] = (vec4(0.0, 5.0, 8.0, 6.0));
	block.var[1][3][0][2] = (vec4(3.0, 8.0, -7.0, -1.0));
	block.var[1][3][0][3] = (vec4(2.0, 3.0, 7.0, 3.0));
	block.var[1][3][1][0] = (vec4(-2.0, -1.0, 0.0, -2.0));
	block.var[1][3][1][1] = (vec4(7.0, -6.0, 5.0, 5.0));
	block.var[1][3][1][2] = (vec4(-9.0, -8.0, -5.0, 0.0));
	block.var[1][3][1][3] = (vec4(-2.0, 3.0, 8.0, 4.0));
	block.var[2][0][0][0] = (vec4(-4.0, -8.0, 4.0, 5.0));
	block.var[2][0][0][1] = (vec4(-5.0, 0.0, -3.0, -4.0));
	block.var[2][0][0][2] = (vec4(5.0, -4.0, -7.0, 4.0));
	block.var[2][0][0][3] = (vec4(-3.0, 9.0, 3.0, -4.0));
	block.var[2][0][1][0] = (vec4(-3.0, -9.0, 6.0, -3.0));
	block.var[2][0][1][1] = (vec4(-6.0, -1.0, 8.0, 3.0));
	block.var[2][0][1][2] = (vec4(-2.0, 9.0, -2.0, -3.0));
	block.var[2][0][1][3] = (vec4(-8.0, 3.0, -8.0, 5.0));
	block.var[2][1][0][0] = (vec4(2.0, 3.0, 8.0, 8.0));
	block.var[2][1][0][1] = (vec4(-7.0, -1.0, 5.0, -3.0));
	block.var[2][1][0][2] = (vec4(5.0, -3.0, -4.0, 6.0));
	block.var[2][1][0][3] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[2][1][1][0] = (vec4(7.0, -3.0, -8.0, 1.0));
	block.var[2][1][1][1] = (vec4(1.0, 2.0, 3.0, 1.0));
	block.var[2][1][1][2] = (vec4(5.0, -2.0, 2.0, -2.0));
	block.var[2][1][1][3] = (vec4(-9.0, -1.0, 2.0, -1.0));
	block.var[2][2][0][0] = (vec4(0.0, -5.0, 2.0, 2.0));
	block.var[2][2][0][1] = (vec4(4.0, 4.0, -9.0, 3.0));
	block.var[2][2][0][2] = (vec4(1.0, 0.0, 5.0, -8.0));
	block.var[2][2][0][3] = (vec4(-3.0, -3.0, 3.0, -6.0));
	block.var[2][2][1][0] = (vec4(-5.0, 9.0, 0.0, -6.0));
	block.var[2][2][1][1] = (vec4(-2.0, -4.0, 3.0, 1.0));
	block.var[2][2][1][2] = (vec4(4.0, 1.0, -3.0, 6.0));
	block.var[2][2][1][3] = (vec4(-2.0, -7.0, -7.0, 9.0));
	block.var[2][3][0][0] = (vec4(-2.0, -3.0, -9.0, 9.0));
	block.var[2][3][0][1] = (vec4(-6.0, -1.0, -3.0, 3.0));
	block.var[2][3][0][2] = (vec4(-7.0, 5.0, -6.0, 8.0));
	block.var[2][3][0][3] = (vec4(0.0, -5.0, 0.0, 4.0));
	block.var[2][3][1][0] = (vec4(-2.0, -9.0, -1.0, -2.0));
	block.var[2][3][1][1] = (vec4(2.0, -4.0, -6.0, -5.0));
	block.var[2][3][1][2] = (vec4(4.0, -4.0, 7.0, 2.0));
	block.var[2][3][1][3] = (vec4(3.0, 2.0, -2.0, -5.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(4.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(3.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(2.0, -1.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(3.0, -2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(-5.0, 8.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(-4.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(-9.0, 2.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(-3.0, 2.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(5.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(1.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(-9.0, 4.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(-5.0, -9.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(3.0, -6.0, 2.0, -8.0));
	block.var[0][0][1] = (mat2(2.0, -5.0, -3.0, 9.0));
	block.var[0][1][0] = (mat2(-2.0, -7.0, -8.0, 6.0));
	block.var[0][1][1] = (mat2(2.0, 3.0, -8.0, 4.0));
	block.var[0][2][0] = (mat2(1.0, -2.0, -9.0, -7.0));
	block.var[0][2][1] = (mat2(2.0, 7.0, 5.0, -3.0));
	block.var[0][3][0] = (mat2(5.0, -6.0, 1.0, 5.0));
	block.var[0][3][1] = (mat2(-4.0, -2.0, 1.0, 6.0));
	block.var[1][0][0] = (mat2(4.0, -9.0, -2.0, -6.0));
	block.var[1][0][1] = (mat2(-2.0, 4.0, -5.0, -1.0));
	block.var[1][1][0] = (mat2(7.0, -3.0, 8.0, -1.0));
	block.var[1][1][1] = (mat2(7.0, -8.0, 5.0, -2.0));
	block.var[1][2][0] = (mat2(-2.0, -3.0, 3.0, -1.0));
	block.var[1][2][1] = (mat2(-2.0, -8.0, 1.0, -1.0));
	block.var[1][3][0] = (mat2(-6.0, -2.0, 3.0, -6.0));
	block.var[1][3][1] = (mat2(-9.0, -4.0, 0.0, -1.0));
	block.var[2][0][0] = (mat2(3.0, 1.0, 6.0, 0.0));
	block.var[2][0][1] = (mat2(-2.0, -5.0, 2.0, 8.0));
	block.var[2][1][0] = (mat2(-5.0, -2.0, -2.0, 1.0));
	block.var[2][1][1] = (mat2(6.0, 0.0, 1.0, 8.0));
	block.var[2][2][0] = (mat2(9.0, -2.0, -3.0, 6.0));
	block.var[2][2][1] = (mat2(2.0, 6.0, -4.0, -6.0));
	block.var[2][3][0] = (mat2(0.0, 7.0, 4.0, 1.0));
	block.var[2][3][1] = (mat2(5.0, -6.0, 5.0, -4.0));
}
#version 450
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

layout(scalar, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-6.0, -5.0, 8.0, 2.0, -2.0, 9.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-1.0, 5.0, 0.0, -4.0, 2.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(9.0, 0.0, -3.0, 4.0, 4.0, -5.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(-8.0, -3.0, 1.0, 8.0, -8.0, 0.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(1.0, 9.0, -9.0, -8.0, 5.0, -5.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(1.0, -8.0, 8.0, 4.0, 5.0, -7.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(1.0, -3.0, -7.0, -4.0, 0.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(2.0, 1.0, 0.0, -1.0, -5.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(3.0, 3.0, 4.0, 8.0, 4.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(-5.0, 5.0, 8.0, -8.0, 4.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(5.0, 9.0, 3.0, -3.0, -8.0, 3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(0.0, 8.0, 4.0, 8.0, -5.0, -2.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(-5.0, 9.0, -7.0, 7.0, 1.0, -9.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-2.0, 4.0, -8.0, 4.0, 9.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(8.0, 0.0, -3.0, 9.0, 5.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-1.0, 0.0, 0.0, -2.0, -1.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(-9.0, 2.0, -8.0, 1.0, 3.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(4.0, -7.0, 1.0, -4.0, 7.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(8.0, -6.0, 1.0, 8.0, 5.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(8.0, 0.0, -5.0, 3.0, 2.0, -6.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(0.0, -5.0, -5.0, 9.0, -4.0, 2.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(2.0, 1.0, 7.0, 1.0));
	block.var[0][0][0][1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	block.var[0][0][1][0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	block.var[0][0][1][1] = (vec4(7.0, -4.0, 8.0, -2.0));
	block.var[0][1][0][0] = (vec4(0.0, -3.0, -2.0, 3.0));
	block.var[0][1][0][1] = (vec4(-6.0, 8.0, -9.0, -3.0));
	block.var[0][1][1][0] = (vec4(-9.0, 3.0, -2.0, 6.0));
	block.var[0][1][1][1] = (vec4(4.0, 7.0, -7.0, 7.0));
	block.var[0][2][0][0] = (vec4(-4.0, 8.0, 5.0, 5.0));
	block.var[0][2][0][1] = (vec4(6.0, 7.0, 9.0, 5.0));
	block.var[0][2][1][0] = (vec4(9.0, 9.0, 2.0, -5.0));
	block.var[0][2][1][1] = (vec4(5.0, 9.0, -6.0, -8.0));
	block.var[0][3][0][0] = (vec4(6.0, -5.0, 0.0, 4.0));
	block.var[0][3][0][1] = (vec4(8.0, -6.0, 8.0, -7.0));
	block.var[0][3][1][0] = (vec4(8.0, 0.0, 1.0, -6.0));
	block.var[0][3][1][1] = (vec4(0.0, 1.0, 1.0, -9.0));
	block.var[1][0][0][0] = (vec4(2.0, 5.0, -2.0, 1.0));
	block.var[1][0][0][1] = (vec4(1.0, 0.0, -4.0, 1.0));
	block.var[1][0][1][0] = (vec4(0.0, 5.0, -3.0, 3.0));
	block.var[1][0][1][1] = (vec4(9.0, -1.0, -7.0, -7.0));
	block.var[1][1][0][0] = (vec4(5.0, 2.0, 7.0, -9.0));
	block.var[1][1][0][1] = (vec4(-4.0, -3.0, -2.0, 4.0));
	block.var[1][1][1][0] = (vec4(-3.0, -8.0, -4.0, 6.0));
	block.var[1][1][1][1] = (vec4(-1.0, -1.0, 6.0, -8.0));
	block.var[1][2][0][0] = (vec4(-2.0, 0.0, 7.0, 4.0));
	block.var[1][2][0][1] = (vec4(8.0, -3.0, -7.0, -6.0));
	block.var[1][2][1][0] = (vec4(-6.0, -1.0, 5.0, -7.0));
	block.var[1][2][1][1] = (vec4(-8.0, -6.0, 3.0, -3.0));
	block.var[1][3][0][0] = (vec4(-6.0, 9.0, 2.0, -5.0));
	block.var[1][3][0][1] = (vec4(-7.0, -6.0, 3.0, -2.0));
	block.var[1][3][1][0] = (vec4(1.0, -8.0, 4.0, -7.0));
	block.var[1][3][1][1] = (vec4(-3.0, 9.0, 4.0, -6.0));
	block.var[2][0][0][0] = (vec4(1.0, 9.0, -1.0, 8.0));
	block.var[2][0][0][1] = (vec4(7.0, 6.0, 7.0, -4.0));
	block.var[2][0][1][0] = (vec4(-4.0, 2.0, -4.0, 6.0));
	block.var[2][0][1][1] = (vec4(4.0, -1.0, -9.0, 3.0));
	block.var[2][1][0][0] = (vec4(-4.0, -2.0, -8.0, 4.0));
	block.var[2][1][0][1] = (vec4(-2.0, 4.0, -8.0, 6.0));
	block.var[2][1][1][0] = (vec4(4.0, -8.0, 8.0, -8.0));
	block.var[2][1][1][1] = (vec4(4.0, 0.0, -9.0, 1.0));
	block.var[2][2][0][0] = (vec4(-4.0, -4.0, 5.0, -9.0));
	block.var[2][2][0][1] = (vec4(-3.0, 0.0, -2.0, 7.0));
	block.var[2][2][1][0] = (vec4(3.0, 3.0, -3.0, 9.0));
	block.var[2][2][1][1] = (vec4(-2.0, 1.0, -8.0, -2.0));
	block.var[2][3][0][0] = (vec4(-7.0, -3.0, 9.0, -8.0));
	block.var[2][3][0][1] = (vec4(1.0, -6.0, 7.0, 1.0));
	block.var[2][3][1][0] = (vec4(5.0, -9.0, 3.0, -2.0));
	block.var[2][3][1][1] = (vec4(-1.0, 1.0, -7.0, 8.0));
}
#version 450
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
	allOk = compare_ivec3((block.s[0].a), ivec3(2, -2, 0)) && allOk;
	allOk = compare_mat3(block.s[0].b[0], mat3(4.0, -2.0, 2.0, 7.0, 3.0, -7.0, -2.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[1], mat3(6.0, 0.0, 9.0, 6.0, 1.0, 8.0, 2.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[2], mat3(-1.0, 5.0, 6.0, 6.0, 0.0, -9.0, -5.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[3], mat3(-5.0, -2.0, 8.0, -4.0, 0.0, -9.0, -5.0, 9.0, 3.0)) && allOk;
	allOk = compare_vec4((block.s[0].c), vec4(-2.0, 1.0, -8.0, 2.0)) && allOk;
	allOk = compare_ivec3((block.s[1].a), ivec3(-3, -4, 0)) && allOk;
	allOk = compare_mat3(block.s[1].b[0], mat3(7.0, 8.0, 6.0, 9.0, -6.0, 1.0, 1.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[1], mat3(-2.0, 8.0, 0.0, 8.0, 4.0, 0.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[2], mat3(6.0, 8.0, 9.0, -9.0, -4.0, 0.0, -4.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[3], mat3(1.0, 2.0, 5.0, -8.0, -4.0, 4.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec4((block.s[1].c), vec4(-9.0, -9.0, -8.0, -1.0)) && allOk;
	allOk = compare_ivec3((block.s[2].a), ivec3(-5, 5, 1)) && allOk;
	allOk = compare_mat3(block.s[2].b[0], mat3(7.0, -7.0, 0.0, 1.0, 9.0, -3.0, -2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[1], mat3(-3.0, 4.0, -1.0, 5.0, -6.0, -3.0, -5.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[2], mat3(4.0, -6.0, -2.0, 8.0, 0.0, 1.0, -2.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[3], mat3(7.0, 1.0, -8.0, 0.0, 5.0, -3.0, -1.0, -7.0, -6.0)) && allOk;
	allOk = compare_vec4((block.s[2].c), vec4(5.0, -3.0, -5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s[0].a = (ivec3(6, 8, 1));
	block.s[0].b[0] = (mat3(-6.0, -6.0, 7.0, 1.0, 8.0, 8.0, 9.0, -7.0, -4.0));
	block.s[0].b[1] = (mat3(0.0, -9.0, -2.0, 7.0, 2.0, 3.0, -7.0, -4.0, 2.0));
	block.s[0].b[2] = (mat3(-2.0, -7.0, 3.0, 5.0, 3.0, 1.0, -6.0, -6.0, -6.0));
	block.s[0].b[3] = (mat3(0.0, -7.0, 4.0, 5.0, -6.0, -8.0, 4.0, -7.0, 5.0));
	block.s[0].c = (vec4(-6.0, 9.0, 0.0, -6.0));
	block.s[1].a = (ivec3(-7, 5, -7));
	block.s[1].b[0] = (mat3(-9.0, 7.0, 8.0, -1.0, -4.0, -3.0, -9.0, -1.0, 4.0));
	block.s[1].b[1] = (mat3(9.0, 3.0, -6.0, -7.0, -3.0, 5.0, 5.0, 3.0, -1.0));
	block.s[1].b[2] = (mat3(6.0, -8.0, -1.0, 2.0, -5.0, 7.0, 7.0, 7.0, -2.0));
	block.s[1].b[3] = (mat3(-7.0, -3.0, -2.0, 6.0, 4.0, 3.0, -2.0, -9.0, -2.0));
	block.s[1].c = (vec4(-2.0, -7.0, 1.0, 3.0));
	block.s[2].a = (ivec3(2, -2, -1));
	block.s[2].b[0] = (mat3(-3.0, -4.0, 6.0, -2.0, 9.0, 3.0, -4.0, 4.0, 4.0));
	block.s[2].b[1] = (mat3(8.0, 5.0, 6.0, -7.0, -7.0, 3.0, -6.0, -8.0, 5.0));
	block.s[2].b[2] = (mat3(4.0, -6.0, 8.0, 7.0, -6.0, 9.0, 3.0, -6.0, 4.0));
	block.s[2].b[3] = (mat3(2.0, -6.0, -2.0, 9.0, -6.0, -4.0, 0.0, 7.0, 9.0));
	block.s[2].c = (vec4(-6.0, 2.0, -6.0, 4.0));
	block.v = (vec4(1.0, -5.0, 8.0, -2.0));
}
#version 450
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
layout(scalar, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block.s[0][0].a), ivec3(-4, 0, -5)) && allOk;
	allOk = compare_vec4((block.s[0][0].c), vec4(3.0, -7.0, -2.0, -2.0)) && allOk;
	allOk = compare_ivec3((block.s[0][1].a), ivec3(-8, -9, -1)) && allOk;
	allOk = compare_vec4((block.s[0][1].c), vec4(-5.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_ivec3((block.s[1][0].a), ivec3(5, 1, 4)) && allOk;
	allOk = compare_vec4((block.s[1][0].c), vec4(0.0, 6.0, 0.0, 9.0)) && allOk;
	allOk = compare_ivec3((block.s[1][1].a), ivec3(5, 6, 6)) && allOk;
	allOk = compare_vec4((block.s[1][1].c), vec4(8.0, -4.0, 0.0, -9.0)) && allOk;
	allOk = compare_ivec3((block.s[2][0].a), ivec3(-2, 2, 7)) && allOk;
	allOk = compare_vec4((block.s[2][0].c), vec4(6.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_ivec3((block.s[2][1].a), ivec3(0, -9, -5)) && allOk;
	allOk = compare_vec4((block.s[2][1].c), vec4(-5.0, 9.0, 3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (vec4(6.0, 8.0, 1.0, -7.0));
	block.s[0][0].a = (ivec3(5, -7, 2));
	block.s[0][0].c = (vec4(8.0, 8.0, 9.0, -7.0));
	block.s[0][1].a = (ivec3(-4, 2, -2));
	block.s[0][1].c = (vec4(-6.0, -6.0, 0.0, -7.0));
	block.s[1][0].a = (ivec3(-2, -1, -6));
	block.s[1][0].c = (vec4(-4.0, 0.0, -9.0, -2.0));
	block.s[1][1].a = (ivec3(-7, 3, 5));
	block.s[1][1].c = (vec4(4.0, 5.0, -6.0, -8.0));
	block.s[2][0].a = (ivec3(-6, 7, 1));
	block.s[2][0].c = (vec4(7.0, 2.0, 3.0, -7.0));
	block.s[2][1].a = (ivec3(3, 1, -6));
	block.s[2][1].c = (vec4(4.0, -7.0, 5.0, -9.0));
}
#version 450
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
	allOk = compare_mat3x2(block[0].var, mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	block[1].var = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	block[2].var = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
}
#version 450
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
	u8vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(block[0].var), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block[1].var), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(block[2].var), uvec4(1u, 4u, 6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = u8vec4(uvec4(9u, 5u, 9u, 4u));
	block[1].var = u8vec4(uvec4(6u, 8u, 7u, 3u));
	block[2].var = u8vec4(uvec4(6u, 7u, 1u, 9u));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 8.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-6.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-8.0, -3.0, -9.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(-1.0, 8.0, 8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -1.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-4.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(1.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-1.0, -1.0, -1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 1.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(9.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(1.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(3.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(8.0, 3.0, 9.0));
	block[0].var[1] = (vec3(6.0, 2.0, -9.0));
	block[0].var[2] = (vec3(-8.0, 5.0, 2.0));
	block[1].var[0] = (vec3(3.0, -3.0, -4.0));
	block[1].var[1] = (vec3(2.0, -9.0, -5.0));
	block[1].var[2] = (vec3(5.0, 8.0, 8.0));
	block[2].var[0] = (vec3(-5.0, -3.0, -3.0));
	block[2].var[1] = (vec3(3.0, -5.0, -4.0));
	block[2].var[2] = (vec3(-7.0, 5.0, 3.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][1], -3.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-7.0, 1.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(9.0, 3.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-9.0, -1.0)) && allOk;
	allOk = compare_vec2(block[0].var[3], vec2(6.0, -3.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -4.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-9.0, 6.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(8.0, 9.0)) && allOk;
	allOk = compare_vec2(block[1].var[3], vec2(1.0, -4.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -2.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(4.0, 1.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-1.0, -5.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(5.0, -9.0)) && allOk;
	allOk = compare_vec2(block[2].var[3], vec2(-7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(6.0, -2.0));
	block[0].var[1] = (vec2(2.0, 8.0));
	block[0].var[2] = (vec2(-5.0, 3.0));
	block[0].var[3] = (vec2(-1.0, -7.0));
	block[1].var[0] = (vec2(4.0, 2.0));
	block[1].var[1] = (vec2(-4.0, 8.0));
	block[1].var[2] = (vec2(3.0, 8.0));
	block[1].var[3] = (vec2(-1.0, 6.0));
	block[2].var[0] = (vec2(-8.0, 2.0));
	block[2].var[1] = (vec2(-5.0, 5.0));
	block[2].var[2] = (vec2(-4.0, -9.0));
	block[2].var[3] = (vec2(0.0, 4.0));
}
#version 450
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
	bvec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block[0].padding), true) && allOk;
	allOk = compare_bvec4((block[0].var), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bool((block[1].padding), true) && allOk;
	allOk = compare_bvec4((block[1].var), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bool((block[2].padding), true) && allOk;
	allOk = compare_bvec4((block[2].var), bvec4(false, true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (true);
	block[0].var = (bvec4(true, true, false, true));
	block[1].padding = (false);
	block[1].var = (bvec4(false, false, false, true));
	block[2].padding = (true);
	block[2].var = (bvec4(true, true, true, true));
}
#version 450
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
    Block block[3];
};

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
	allOk = compare_float((block[0].padding), 2.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 5.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-7.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-6.0, -6.0, 5.0)) && allOk;
	allOk = compare_float((block[1].padding), -2.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 7.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(1.0, -7.0, -8.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(6.0, 6.0, 7.0)) && allOk;
	allOk = compare_float((block[2].padding), 2.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 9.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-2.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-5.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (0.0);
	block[0].var = (mat2x3(6.0, 9.0, 9.0, -8.0, 7.0, 5.0));
	block[1].padding = (-1.0);
	block[1].var = (mat2x3(-9.0, 0.0, 8.0, 1.0, -7.0, 2.0));
	block[2].padding = (4.0);
	block[2].var = (mat2x3(-8.0, 4.0, 4.0, -4.0, 3.0, 7.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -3.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 4.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][3], 8.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-7.0, 8.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(-9.0, 3.0, -6.0, 8.0)) && allOk;
	allOk = compare_float((block[1].padding), -8.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[1].var[0][3], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 1.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-4.0, 9.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(9.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_float((block[2].padding), 8.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 7.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][3], 9.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-6.0, -7.0, 8.0, -4.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(5.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-9.0, 7.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-6.0);
	block[0].var[0] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block[0].var[1] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block[0].var[2] = (vec4(-4.0, 2.0, -3.0, 0.0));
	block[1].padding = (5.0);
	block[1].var[0] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block[1].var[1] = (vec4(6.0, 0.0, 6.0, 3.0));
	block[1].var[2] = (vec4(2.0, 6.0, 6.0, -8.0));
	block[2].padding = (7.0);
	block[2].var[0] = (vec4(-3.0, 6.0, -2.0, 6.0));
	block[2].var[1] = (vec4(-5.0, -5.0, 1.0, -5.0));
	block[2].var[2] = (vec4(-8.0, -3.0, -2.0, 9.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer BlockB
{
	lowp vec3 a;
	lowp vec4 b;
	bvec4 c;
	bvec3 d;
	lowp uint e[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	mediump mat4x3 f;
	highp mat4x3 g;
	highp mat4x3 h;
	lowp ivec3 i[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockD
{
	lowp mat4x3 j[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	bvec3 k;
	lowp mat3x2 l;
	bool m;
	lowp mat3x4 n;
	mediump vec4 o[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(-8.0, -8.0, 0.0)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.d), bvec3(false, true, false)) && allOk;
	allOk = compare_uint((blockB.e[0]), 0u) && allOk;
	allOk = compare_uint((blockB.e[1]), 4u) && allOk;
	allOk = compare_uint((blockB.e[2]), 0u) && allOk;
	allOk = compare_uint((blockB.e[3]), 0u) && allOk;
	allOk = compare_uint((blockB.e[4]), 3u) && allOk;
	allOk = compare_uint((blockB.e[5]), 4u) && allOk;
	allOk = compare_mat4x3(blockC.f, mat4x3(-2.0, -5.0, -7.0, 4.0, 2.0, -4.0, -1.0, -6.0, -7.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockC.g, mat4x3(2.0, 5.0, -9.0, 7.0, 9.0, 2.0, 8.0, -1.0, 3.0, -1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockD.j[0], mat4x3(2.0, 2.0, 9.0, -4.0, 8.0, -2.0, -4.0, -8.0, -4.0, 7.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockD.j[1], mat4x3(6.0, -2.0, -1.0, -2.0, -9.0, 2.0, 2.0, 5.0, 1.0, -3.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockD.j[2], mat4x3(-9.0, -3.0, 3.0, 7.0, -8.0, 7.0, -1.0, 8.0, -1.0, 5.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockD.j[3], mat4x3(-4.0, 9.0, 3.0, -8.0, -7.0, 7.0, -2.0, 7.0, -8.0, 2.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockD.j[4], mat4x3(7.0, -4.0, 2.0, -5.0, -6.0, 1.0, 4.0, -6.0, 3.0, 6.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockD.j[5], mat4x3(0.0, -4.0, -2.0, -8.0, 0.0, 9.0, -4.0, 4.0, 3.0, 3.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockD.j[6], mat4x3(-1.0, -7.0, 0.0, 4.0, 4.0, -9.0, -9.0, -3.0, 1.0, 9.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockD.j[7], mat4x3(1.0, 5.0, 6.0, -4.0, 8.0, -5.0, 5.0, -9.0, 2.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_bvec3((blockE.k), bvec3(true, true, false)) && allOk;
	allOk = compare_mat3x2(blockE.l, mat3x2(-1.0, 9.0, 1.0, 0.0, -4.0, 8.0)) && allOk;
	allOk = compare_vec4((blockE.o[0]), vec4(-3.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_vec4((blockE.o[1]), vec4(2.0, -3.0, 2.0, 6.0)) && allOk;
	allOk = compare_vec4((blockE.o[2]), vec4(4.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_vec4((blockE.o[3]), vec4(-2.0, 6.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(-2.0, -9.0, -3.0));
	blockB.c = (bvec4(true, false, false, true));
	blockB.d = (bvec3(true, true, true));
	blockC.f = (mat4x3(-6.0, -2.0, 7.0, 3.0, -6.0, -1.0, 7.0, -3.0, -5.0, -8.0, 0.0, -8.0));
	blockC.g = (mat4x3(9.0, -4.0, 9.0, 7.0, 0.0, -2.0, -9.0, -3.0, 2.0, -8.0, 9.0, -6.0));
	blockC.h = (mat4x3(0.0, -9.0, 8.0, -6.0, 4.0, -3.0, -6.0, -5.0, -1.0, -4.0, 8.0, 2.0));
	blockC.i[0] = (ivec3(-2, 2, -1));
	blockE.k = (bvec3(false, false, false));
	blockE.l = (mat3x2(-1.0, 9.0, -8.0, -6.0, 3.0, -7.0));
	blockE.m = (true);
	blockE.o[0] = (vec4(-4.0, 0.0, 3.0, 4.0));
	blockE.o[1] = (vec4(-5.0, -9.0, 0.0, -5.0));
	blockE.o[2] = (vec4(9.0, -2.0, 6.0, -8.0));
	blockE.o[3] = (vec4(7.0, 1.0, 2.0, 1.0));
}
#version 450
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
	layout(offset = 0) lowp ivec3 a;
	layout(offset = 16) lowp uvec4 b[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b[0]), uvec4(0u, 4u, 5u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(-5, 9, 5));
	blockB.b[0] = (uvec4(8u, 7u, 4u, 4u));
}
#version 450
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
	layout(offset = 0) mediump vec4 a[1];
	layout(offset = 16) highp uvec4 b;
	layout(offset = 32) mediump uvec3 c;
	layout(offset = 48) mediump uvec3 d;
	layout(offset = 64) lowp uvec2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[0].a[0]), vec4(-7.0, -6.0, -2.0, -9.0)) && allOk;
	allOk = compare_uvec4((blockB[0].b), uvec4(4u, 4u, 1u, 9u)) && allOk;
	allOk = compare_uvec3((blockB[0].d), uvec3(0u, 9u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (vec4(-6.0, -1.0, 8.0, -4.0));
	blockB[0].b = (uvec4(5u, 3u, 7u, 1u));
	blockB[0].c = (uvec3(7u, 5u, 3u));
	blockB[0].d = (uvec3(7u, 0u, 0u));
	blockB[0].e = (uvec2(0u, 7u));
}
#version 450
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
	bvec4 a;
	lowp mat3 b;
	bool c;
	lowp mat4x3 d[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	lowp mat2x3 e;
	bvec4 f;
	highp mat2 g;
	highp vec2 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB[0].c), false) && allOk;
	allOk = compare_bool((blockB[1].c), true) && allOk;
	allOk = compare_bool((blockB[2].c), true) && allOk;
	allOk = compare_mat2(blockC.g, mat2(-8.0, 1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec2((blockC.h[0]), vec2(-3.0, 5.0)) && allOk;
	allOk = compare_vec2((blockC.h[1]), vec2(5.0, 7.0)) && allOk;
	allOk = compare_vec2((blockC.h[2]), vec2(8.0, 9.0)) && allOk;
	allOk = compare_vec2((blockC.h[3]), vec2(3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec4(true, false, true, false));
	blockB[0].b = (mat3(8.0, 3.0, -1.0, 5.0, 0.0, -4.0, 7.0, 8.0, -6.0));
	blockB[0].c = (false);
	blockB[0].d[0] = (mat4x3(0.0, 7.0, 3.0, 5.0, -7.0, 4.0, -9.0, 6.0, 7.0, -2.0, 9.0, 1.0));
	blockB[0].d[1] = (mat4x3(5.0, 2.0, -1.0, -8.0, -5.0, -7.0, 2.0, -1.0, 3.0, -3.0, 7.0, 0.0));
	blockB[0].d[2] = (mat4x3(3.0, 7.0, -9.0, 6.0, -2.0, 1.0, 7.0, 8.0, -8.0, -8.0, -1.0, -2.0));
	blockB[0].d[3] = (mat4x3(4.0, 2.0, 8.0, 9.0, 9.0, -2.0, 8.0, -4.0, -6.0, -5.0, -9.0, -7.0));
	blockB[0].d[4] = (mat4x3(6.0, 5.0, -2.0, -1.0, 6.0, 7.0, -6.0, 9.0, -9.0, 3.0, 4.0, 0.0));
	blockB[0].d[5] = (mat4x3(-6.0, -9.0, 5.0, 0.0, 1.0, -2.0, 3.0, 2.0, -9.0, 0.0, 5.0, 1.0));
	blockB[0].d[6] = (mat4x3(-6.0, -7.0, -8.0, 3.0, -2.0, 0.0, 7.0, 2.0, 3.0, -3.0, 1.0, 6.0));
	blockB[0].d[7] = (mat4x3(6.0, 5.0, 8.0, -4.0, -9.0, -6.0, -2.0, 7.0, 0.0, -6.0, 6.0, -9.0));
	blockB[1].a = (bvec4(true, true, true, false));
	blockB[1].b = (mat3(9.0, -1.0, 6.0, -6.0, -6.0, -2.0, 5.0, 4.0, -7.0));
	blockB[1].c = (false);
	blockB[1].d[0] = (mat4x3(0.0, 9.0, -3.0, -3.0, 9.0, -8.0, 1.0, -1.0, -2.0, 2.0, -5.0, -7.0));
	blockB[1].d[1] = (mat4x3(-9.0, 7.0, 0.0, -3.0, -1.0, -5.0, -6.0, 1.0, -2.0, 5.0, 2.0, -2.0));
	blockB[1].d[2] = (mat4x3(9.0, 5.0, -2.0, -7.0, -1.0, 6.0, 6.0, -5.0, 3.0, 4.0, 6.0, 2.0));
	blockB[1].d[3] = (mat4x3(3.0, 1.0, 7.0, 7.0, -4.0, -8.0, 4.0, 1.0, 0.0, -3.0, 8.0, 8.0));
	blockB[1].d[4] = (mat4x3(3.0, -4.0, 1.0, 0.0, -1.0, -4.0, -4.0, 8.0, 6.0, 2.0, 7.0, -5.0));
	blockB[1].d[5] = (mat4x3(3.0, 8.0, 7.0, 5.0, -6.0, -3.0, 1.0, 2.0, 8.0, -5.0, -9.0, 2.0));
	blockB[2].a = (bvec4(false, true, true, true));
	blockB[2].b = (mat3(-3.0, -8.0, 0.0, -2.0, -3.0, -2.0, -2.0, -3.0, 7.0));
	blockB[2].c = (false);
	blockB[2].d[0] = (mat4x3(-9.0, -7.0, 9.0, -8.0, -3.0, -9.0, 5.0, -1.0, 9.0, 9.0, -1.0, 8.0));
	blockB[2].d[1] = (mat4x3(1.0, -2.0, 4.0, -5.0, -5.0, 0.0, -2.0, -9.0, -9.0, -1.0, -4.0, 3.0));
	blockB[2].d[2] = (mat4x3(-4.0, -3.0, -7.0, 0.0, 3.0, 6.0, 0.0, 3.0, -8.0, -4.0, -2.0, 6.0));
	blockB[2].d[3] = (mat4x3(3.0, 9.0, 9.0, -4.0, 8.0, 2.0, -7.0, 4.0, 8.0, -9.0, 8.0, 0.0));
	blockB[2].d[4] = (mat4x3(-5.0, 2.0, -4.0, 6.0, -8.0, -2.0, 9.0, -6.0, 2.0, 2.0, -7.0, -9.0));
	blockB[2].d[5] = (mat4x3(3.0, 5.0, 7.0, -2.0, -3.0, 2.0, 1.0, -6.0, 6.0, 7.0, 4.0, 8.0));
	blockB[2].d[6] = (mat4x3(-8.0, 0.0, -2.0, 2.0, 9.0, -2.0, -7.0, -2.0, -3.0, -2.0, 9.0, 1.0));
	blockC.e = (mat2x3(1.0, 6.0, 8.0, -2.0, 5.0, 8.0));
	blockC.f = (bvec4(false, true, true, false));
	blockC.g = (mat2(-3.0, 0.0, 0.0, 6.0));
	blockC.h[0] = (vec2(1.0, -9.0));
	blockC.h[1] = (vec2(3.0, 1.0));
	blockC.h[2] = (vec2(-3.0, 1.0));
	blockC.h[3] = (vec2(-5.0, -8.0));
}
#version 450
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
	uint16_t a;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp float b;
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump float c;
	int16_t d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockC.b), -3.0) && allOk;
	allOk = compare_float((blockD.c), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint16_t(7u);
	blockC.b = (7.0);
	blockD.c = (-2.0);
}
#version 450
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
	highp ivec2 a;
	mediump mat3x4 b;
	highp mat3 c;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp mat4x3 d;
	bvec2 e;
	mediump mat3x4 f;
	lowp mat4x2 g;
	mediump uvec2 h;
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	bvec3 i;
	mediump mat2x3 j;
	lowp vec2 k;
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(-2, 4)) && allOk;
	allOk = compare_mat3(blockB.c, mat3(-2.0, 5.0, -6.0, -3.0, 0.0, -6.0, 1.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockC.d, mat4x3(8.0, 8.0, 0.0, 1.0, 4.0, -9.0, 9.0, 7.0, 2.0, -8.0, 7.0, 5.0)) && allOk;
	allOk = compare_bvec2((blockC.e), bvec2(true, true)) && allOk;
	allOk = compare_mat4x2(blockC.g, mat4x2(0.0, -4.0, 4.0, 0.0, 9.0, -5.0, 7.0, -4.0)) && allOk;
	allOk = compare_bvec3((blockD.i), bvec3(false, true, true)) && allOk;
	allOk = compare_vec2((blockD.k), vec2(8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(-7, 3));
	blockC.d = (mat4x3(9.0, 4.0, 1.0, -8.0, -2.0, -5.0, -9.0, -7.0, 0.0, 7.0, -2.0, 9.0));
	blockC.e = (bvec2(true, false));
	blockC.g = (mat4x2(3.0, 6.0, 5.0, 1.0, 1.0, -2.0, -3.0, 8.0));
	blockC.h = (uvec2(3u, 9u));
	blockD.k = (vec2(-5.0, 7.0));
}
#version 450
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
	float16_t b;
	lowp uvec2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.c[0]), uvec2(1u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = float16_t(9.0);
	blockB.c[0] = (uvec2(0u, 9u));
}
#version 450
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
	lowp mat4x2 mB;
	highp mat4x2 mC;
};
layout(std430, buffer_reference) buffer BlockB
{
	highp ivec4 a[7];
	f16vec2 b;
	bvec4 c;
	highp uvec3 d[];
};
layout(std140, buffer_reference) buffer BlockC
{
	highp vec2 e;
	u16vec2 f[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	mediump ivec4 g;
	f16vec2 h;
	sA i;
	mediump ivec2 j;
	i16vec3 k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a[0]), ivec4(1, -6, -5, 7)) && allOk;
	allOk = compare_ivec4((blockB.a[1]), ivec4(2, -1, 4, 1)) && allOk;
	allOk = compare_ivec4((blockB.a[2]), ivec4(-8, -1, 4, -7)) && allOk;
	allOk = compare_ivec4((blockB.a[3]), ivec4(3, 8, 1, 9)) && allOk;
	allOk = compare_ivec4((blockB.a[4]), ivec4(5, -4, 1, -4)) && allOk;
	allOk = compare_ivec4((blockB.a[5]), ivec4(-4, -3, 1, 5)) && allOk;
	allOk = compare_ivec4((blockB.a[6]), ivec4(6, 9, 0, 1)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.b), vec2(-3.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(false, false, false, true)) && allOk;
	allOk = compare_uvec3((blockB.d[0]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_uvec3((blockB.d[1]), uvec3(8u, 1u, 8u)) && allOk;
	allOk = compare_uvec3((blockB.d[2]), uvec3(2u, 2u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.d[3]), uvec3(0u, 1u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.d[4]), uvec3(8u, 2u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.d[5]), uvec3(8u, 9u, 9u)) && allOk;
	allOk = compare_uvec3((blockB.d[6]), uvec3(6u, 0u, 4u)) && allOk;
	allOk = compare_ivec4((blockD.g), ivec4(5, -4, -1, -8)) && allOk;
	allOk = compare_f16vec2(vec2(blockD.h), vec2(4.0, -7.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD.k[0]), ivec3(2, 1, -5)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD.k[1]), ivec3(8, -5, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD.k[2]), ivec3(9, 6, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec4(9, 7, 5, -2));
	blockB.a[1] = (ivec4(9, -6, 1, 2));
	blockB.a[2] = (ivec4(-4, -1, -9, 0));
	blockB.a[3] = (ivec4(0, 6, -6, -5));
	blockB.a[4] = (ivec4(2, 3, 0, 4));
	blockB.a[5] = (ivec4(-4, -4, 1, -6));
	blockB.a[6] = (ivec4(2, -1, 4, -4));
	blockB.b = f16vec2(vec2(-7.0, 8.0));
	blockB.c = (bvec4(true, true, true, false));
	blockC.e = (vec2(-2.0, -2.0));
	blockD.h = f16vec2(vec2(4.0, -3.0));
	blockD.i.mA = (-4.0);
	blockD.i.mB = (mat4x2(9.0, -9.0, -8.0, 8.0, 1.0, 2.0, -6.0, 8.0));
	blockD.i.mC = (mat4x2(-9.0, 7.0, -1.0, 3.0, -8.0, 3.0, 9.0, 6.0));
	blockD.k[0] = i16vec3(ivec3(-9, 3, 5));
	blockD.k[1] = i16vec3(ivec3(0, -7, 1));
	blockD.k[2] = i16vec3(ivec3(0, 0, -4));
}
#version 450
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
	f16vec2 a;
	u16vec3 b;
	mediump mat3 c;
	lowp vec2 d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	i16vec2 e[5];
	lowp vec2 f;
	mediump int g[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	lowp mat3 h;
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	i16vec4 i;
	mediump ivec4 j;
	uint16_t k;
	i16vec3 l;
	lowp mat4 m[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB.a), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_mat3(blockB.c, mat3(-9.0, -2.0, 6.0, 2.0, -6.0, -7.0, -6.0, 0.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB.d[0]), vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec2((blockB.d[1]), vec2(-8.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB.d[2]), vec2(0.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB.d[3]), vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB.d[4]), vec2(8.0, 1.0)) && allOk;
	allOk = compare_vec2((blockB.d[5]), vec2(-7.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB.d[6]), vec2(-4.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB.d[7]), vec2(7.0, -9.0)) && allOk;
	allOk = compare_vec2((blockC.f), vec2(0.0, 7.0)) && allOk;
	allOk = compare_int((blockC.g[0]), -9) && allOk;
	allOk = compare_int((blockC.g[1]), 3) && allOk;
	allOk = compare_int((blockC.g[2]), -8) && allOk;
	allOk = compare_int((blockC.g[3]), 4) && allOk;
	allOk = compare_int((blockC.g[4]), 9) && allOk;
	allOk = compare_mat3(blockD.h, mat3(6.0, 2.0, -7.0, -4.0, -8.0, -4.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE[0].i), ivec4(6, 6, 2, -4)) && allOk;
	allOk = compare_ivec4((blockE[0].j), ivec4(-5, -1, 3, 3)) && allOk;
	allOk = compare_uint16_t(uint(blockE[0].k), 0u) && allOk;
	allOk = compare_i16vec3(ivec3(blockE[0].l), ivec3(0, -5, 0)) && allOk;
	allOk = compare_mat4(blockE[0].m[0], mat4(-9.0, -1.0, 6.0, 9.0, 2.0, -5.0, 5.0, -4.0, 7.0, 2.0, -1.0, 7.0, -3.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4(blockE[0].m[1], mat4(3.0, 4.0, 0.0, -3.0, -7.0, -2.0, -5.0, -9.0, 6.0, 4.0, 2.0, 0.0, 5.0, 8.0, -9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec2(vec2(2.0, 7.0));
	blockB.c = (mat3(4.0, 9.0, -3.0, 2.0, 8.0, -9.0, -7.0, 4.0, 9.0));
	blockB.d[0] = (vec2(7.0, 5.0));
	blockB.d[1] = (vec2(-2.0, -4.0));
	blockB.d[2] = (vec2(-3.0, 8.0));
	blockB.d[3] = (vec2(-7.0, 5.0));
	blockB.d[4] = (vec2(-4.0, -4.0));
	blockB.d[5] = (vec2(-6.0, -1.0));
	blockB.d[6] = (vec2(4.0, 9.0));
	blockB.d[7] = (vec2(8.0, -6.0));
	blockC.f = (vec2(7.0, -2.0));
	blockC.g[0] = (8);
	blockC.g[1] = (7);
	blockC.g[2] = (-3);
	blockC.g[3] = (6);
	blockC.g[4] = (9);
	blockD.h = (mat3(-3.0, 9.0, 3.0, -4.0, -7.0, 6.0, -2.0, 2.0, 5.0));
	blockE[0].j = (ivec4(6, 9, -3, -3));
	blockE[0].l = i16vec3(ivec3(3, 2, -4));
}
#version 450
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
	i8vec4 c;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp mat2x3 d;
	lowp mat3x4 e;
	mediump ivec3 f;
	lowp ivec4 g;
	highp mat3x4 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.b), ivec3(3, -6, -4)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(-2, -5, 0)) && allOk;
	allOk = compare_mat3x4(blockC.h, mat3x4(0.0, -2.0, 5.0, -4.0, -6.0, 7.0, 0.0, 3.0, 4.0, -7.0, 3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(6.0, 0.0, 5.0, 1.0, -7.0, -3.0, -7.0, 9.0, -9.0));
	blockB.b = (ivec3(8, 0, -8));
	blockB.c = i8vec4(ivec4(4294967287, 5, 4, 4294967294));
	blockC.e = (mat3x4(-9.0, 3.0, -9.0, -1.0, 6.0, 2.0, 7.0, -1.0, -6.0, 3.0, 1.0, -4.0));
	blockC.f = (ivec3(-9, 8, -7));
	blockC.h = (mat3x4(-9.0, 9.0, -5.0, -2.0, -2.0, -6.0, 4.0, 9.0, -2.0, -6.0, 3.0, 6.0));
}
#version 450
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
	highp int a[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	u8vec2 b;
	lowp mat2x3 c;
	lowp float d;
	lowp ivec3 e[];
};
layout(std430, buffer_reference) buffer BlockD
{
	highp vec2 f;
	highp int g;
	uint8_t h[];
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a[0]), -7) && allOk;
	allOk = compare_int((blockB.a[1]), 3) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.b), uvec2(1u, 8u)) && allOk;
	allOk = compare_mat2x3(blockC.c, mat2x3(-9.0, -1.0, -9.0, 1.0, -8.0, 6.0)) && allOk;
	allOk = compare_float((blockC.d), -5.0) && allOk;
	allOk = compare_int((blockD.g), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = u8vec2(uvec2(5u, 2u));
	blockC.c = (mat2x3(-4.0, 5.0, -9.0, 8.0, 1.0, 9.0));
	blockD.f = (vec2(-5.0, -3.0));
	blockD.g = (-8);
	blockD.h[0] = uint8_t(4u);
	blockD.h[1] = uint8_t(1u);
	blockD.h[2] = uint8_t(1u);
	blockD.h[3] = uint8_t(6u);
	blockD.h[4] = uint8_t(8u);
	blockD.h[5] = uint8_t(1u);
	blockD.h[6] = uint8_t(1u);
	blockD.h[7] = uint8_t(0u);
}
#version 450
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
	i8vec4 a;
	lowp mat4 b[1];
	lowp mat4 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.b[0], mat4(-1.0, 0.0, -3.0, 9.0, -2.0, 0.0, 3.0, -3.0, 2.0, -3.0, 8.0, 8.0, -3.0, 8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4(blockB.c, mat4(-3.0, -9.0, 5.0, -9.0, 7.0, 4.0, 6.0, 7.0, -8.0, 9.0, 7.0, -2.0, -8.0, 6.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat4(-3.0, -9.0, 1.0, 2.0, 8.0, -2.0, 5.0, -7.0, -5.0, -9.0, -9.0, -7.0, 3.0, 1.0, 2.0, -4.0));
	blockB.c = (mat4(-6.0, 7.0, 1.0, 9.0, 1.0, 3.0, 9.0, 6.0, 4.0, -5.0, -6.0, 2.0, 8.0, 0.0, 6.0, 5.0));
}
#version 450
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
	lowp mat3 a;
	highp mat3x2 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(0.0, 3.0, 3.0, 2.0, 0.0, -3.0, 1.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[0], mat3x2(-7.0, 3.0, 6.0, 2.0, 3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat3x2(2.0, -4.0, -8.0, -4.0, 8.0, 6.0));
}
#version 450
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
	mediump uvec3 mB;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	highp uint a;
	mediump vec4 b[7];
	i8vec4 c;
	highp float d[2];
	uint8_t e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp mat4x2 f;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp ivec4 g;
	sA h;
	lowp mat4x2 i;
	i8vec3 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 7u) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.c), ivec4(4294967292, 4, 1, 4294967290)) && allOk;
	allOk = compare_uint8_t(uint(blockB.e[0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(blockB.e[1]), 7u) && allOk;
	allOk = compare_uint8_t(uint(blockB.e[2]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockB.e[3]), 5u) && allOk;
	allOk = compare_uint8_t(uint(blockB.e[4]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockB.e[5]), 7u) && allOk;
	allOk = compare_ivec4((blockD.g), ivec4(1, 1, 0, 9)) && allOk;
	allOk = compare_mat4x2(blockD.i, mat4x2(0.0, -7.0, 6.0, -1.0, -5.0, 7.0, -2.0, -2.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.j[0]), ivec3(4294967287, 4294967289, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.j[1]), ivec3(4294967293, 4294967293, 4294967287)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.j[2]), ivec3(6, 9, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = i8vec4(ivec4(4294967294, 4294967291, 3, 0));
	blockB.d[0] = (9.0);
	blockB.d[1] = (-2.0);
	blockB.e[0] = uint8_t(2u);
	blockB.e[1] = uint8_t(9u);
	blockB.e[2] = uint8_t(1u);
	blockB.e[3] = uint8_t(3u);
	blockB.e[4] = uint8_t(4u);
	blockB.e[5] = uint8_t(9u);
	blockC[0].f = (mat4x2(-8.0, -6.0, 4.0, -7.0, -9.0, 7.0, -3.0, -1.0));
	blockC[1].f = (mat4x2(-2.0, -4.0, 3.0, -1.0, 4.0, -2.0, 9.0, -2.0));
	blockD.g = (ivec4(8, -5, -8, 9));
	blockD.h.mA = uint8_t(8u);
	blockD.h.mB = (uvec3(9u, 1u, 2u));
	blockD.i = (mat4x2(3.0, -2.0, 7.0, 1.0, 3.0, 2.0, -1.0, -4.0));
	blockD.j[0] = i8vec3(ivec3(2, 4294967288, 4294967290));
	blockD.j[1] = i8vec3(ivec3(2, 4294967291, 4294967290));
	blockD.j[2] = i8vec3(ivec3(4294967293, 4294967294, 7));
}
#version 450
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
	lowp mat3x2 mB;
};
struct sB
{
	sA mA;
	lowp mat3x4 mB;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	mediump vec2 a;
	sB b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	bvec3 c;
	highp uvec4 d[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	highp mat3x4 e;
	u8vec2 f[];
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
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(4.0, -1.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b[0].mA.mA), uvec3(3u, 0u, 8u)) && allOk;
	allOk = compare_mat3x2(blockB.b[0].mA.mB, mat3x2(9.0, 2.0, -6.0, -9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[0].mB, mat3x4(8.0, -5.0, -7.0, -2.0, -9.0, -8.0, -1.0, -7.0, -6.0, 7.0, -1.0, 4.0)) && allOk;
	allOk = compare_bvec3((blockC.c), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(5.0, 7.0));
	blockC.d[0] = (uvec4(1u, 7u, 0u, 5u));
	blockC.d[1] = (uvec4(5u, 5u, 3u, 6u));
	blockC.d[2] = (uvec4(6u, 5u, 7u, 8u));
	blockC.d[3] = (uvec4(4u, 7u, 7u, 1u));
	blockC.d[4] = (uvec4(2u, 7u, 1u, 3u));
	blockC.d[5] = (uvec4(0u, 1u, 0u, 6u));
	blockC.d[6] = (uvec4(3u, 9u, 6u, 7u));
	blockC.d[7] = (uvec4(6u, 5u, 6u, 2u));
	blockD.e = (mat3x4(6.0, -9.0, 9.0, 2.0, 3.0, -2.0, 7.0, 3.0, -7.0, -9.0, 0.0, -4.0));
	blockD.f[0] = u8vec2(uvec2(4u, 0u));
	blockD.f[1] = u8vec2(uvec2(6u, 6u));
	blockD.f[2] = u8vec2(uvec2(3u, 2u));
	blockD.f[3] = u8vec2(uvec2(9u, 5u));
	blockD.f[4] = u8vec2(uvec2(5u, 7u));
}
#version 450
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
	mediump mat3x4 a[2];
	bvec3 b;
	u8vec2 c;
	highp mat4x2 d;
	mediump mat3 e[];
};
layout(scalar, buffer_reference) readonly buffer BlockC
{
	i8vec2 f;
	i8vec3 g;
	i8vec4 h;
	lowp ivec4 i[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	mediump mat2x3 j;
	highp mat3 k;
	lowp mat4 l[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a[0], mat3x4(-5.0, -2.0, 0.0, -5.0, -6.0, 1.0, -3.0, 6.0, -8.0, 9.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[1], mat3x4(-2.0, 1.0, -3.0, -6.0, -9.0, 1.0, -5.0, -5.0, -7.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(true, false, true)) && allOk;
	allOk = compare_mat4x2(blockB.d, mat4x2(-3.0, -6.0, 4.0, 4.0, -2.0, 5.0, 4.0, -4.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.g), ivec3(2, 4294967291, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.h), ivec4(4, 4294967291, 1, 1)) && allOk;
	allOk = compare_ivec4((blockC.i[0]), ivec4(0, -5, 2, -3)) && allOk;
	allOk = compare_ivec4((blockC.i[1]), ivec4(2, -2, 8, 1)) && allOk;
	allOk = compare_ivec4((blockC.i[2]), ivec4(-3, -6, 9, 4)) && allOk;
	allOk = compare_mat3(blockD.k, mat3(-3.0, 5.0, -9.0, 4.0, 4.0, 7.0, -1.0, -9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = u8vec2(uvec2(9u, 3u));
	blockB.d = (mat4x2(8.0, 9.0, 2.0, 7.0, -8.0, -4.0, -6.0, 2.0));
	blockB.e[0] = (mat3(-4.0, -9.0, 9.0, 9.0, 0.0, -9.0, -5.0, 2.0, -7.0));
	blockB.e[1] = (mat3(3.0, 8.0, 7.0, 9.0, 9.0, 9.0, -4.0, -5.0, 2.0));
	blockB.e[2] = (mat3(4.0, 3.0, -9.0, -6.0, 6.0, 8.0, 5.0, -3.0, -5.0));
	blockB.e[3] = (mat3(-8.0, 7.0, 5.0, 4.0, -7.0, 1.0, -7.0, -7.0, 9.0));
	blockB.e[4] = (mat3(7.0, -3.0, 5.0, 3.0, 6.0, 7.0, -1.0, -2.0, -9.0));
	blockB.e[5] = (mat3(-7.0, 3.0, 9.0, -9.0, -9.0, -7.0, 1.0, -1.0, -8.0));
	blockB.e[6] = (mat3(6.0, 9.0, 3.0, 5.0, 4.0, -6.0, -2.0, 8.0, -2.0));
	blockB.e[7] = (mat3(-1.0, 5.0, -6.0, -4.0, -5.0, 7.0, 9.0, 2.0, 7.0));
	blockD.k = (mat3(-9.0, 6.0, -4.0, -4.0, -7.0, -8.0, 9.0, 9.0, 0.0));
	blockD.l[0] = (mat4(5.0, -7.0, 2.0, 8.0, -9.0, -3.0, 5.0, 7.0, -2.0, -6.0, 5.0, -8.0, -3.0, -2.0, -7.0, 5.0));
	blockD.l[1] = (mat4(5.0, 5.0, -5.0, -3.0, 0.0, 7.0, -3.0, 8.0, 7.0, -5.0, -2.0, -4.0, -8.0, -7.0, 6.0, 8.0));
	blockD.l[2] = (mat4(-3.0, 9.0, -6.0, 4.0, 9.0, -7.0, 5.0, 9.0, -6.0, -5.0, -3.0, -6.0, -9.0, 1.0, -9.0, -2.0));
	blockD.l[3] = (mat4(0.0, -4.0, 5.0, 6.0, -1.0, -8.0, 5.0, 9.0, -4.0, -5.0, -5.0, -8.0, -8.0, -1.0, -2.0, -9.0));
	blockD.l[4] = (mat4(-8.0, -7.0, -5.0, 8.0, 5.0, 1.0, -3.0, -1.0, -9.0, -5.0, 1.0, -4.0, 0.0, -9.0, 7.0, 3.0));
	blockD.l[5] = (mat4(9.0, -2.0, 7.0, -2.0, 6.0, -9.0, 3.0, -4.0, 8.0, -5.0, -3.0, -2.0, -6.0, -5.0, -6.0, 3.0));
}
#version 450
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
	highp uvec2 mB;
};
struct sB
{
	mediump mat2 mA;
};
layout(scalar, buffer_reference) buffer BlockB
{
	mediump uvec4 a;
	lowp uint b[7];
	uint8_t c;
	sA d;
	sB e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	bvec3 f;
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	highp float g;
	u8vec2 h;
	lowp mat4x3 i[];
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	mediump vec2 j;
	mediump ivec2 k;
	lowp uvec2 l;
	lowp int m;
	u8vec3 n[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC[3];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB[0].a), uvec4(8u, 7u, 4u, 4u)) && allOk;
	allOk = compare_uint((blockB[0].b[0]), 0u) && allOk;
	allOk = compare_uint((blockB[0].b[1]), 6u) && allOk;
	allOk = compare_uint((blockB[0].b[2]), 5u) && allOk;
	allOk = compare_uint((blockB[0].b[3]), 1u) && allOk;
	allOk = compare_uint((blockB[0].b[4]), 2u) && allOk;
	allOk = compare_uint((blockB[0].b[5]), 9u) && allOk;
	allOk = compare_uint((blockB[0].b[6]), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockB[0].c), 7u) && allOk;
	allOk = compare_uint((blockB[0].d.mA), 1u) && allOk;
	allOk = compare_uvec2((blockB[0].d.mB), uvec2(3u, 4u)) && allOk;
	allOk = compare_bvec3((blockC[0].f), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockC[1].f), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockC[2].f), bvec3(true, false, true)) && allOk;
	allOk = compare_float((blockD.g), 9.0) && allOk;
	allOk = compare_mat4x3(blockD.i[0], mat4x3(-6.0, 7.0, -7.0, -5.0, -2.0, 5.0, 9.0, 7.0, -9.0, -9.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockD.i[1], mat4x3(4.0, 4.0, -7.0, 9.0, 6.0, 1.0, -1.0, 3.0, -9.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockD.i[2], mat4x3(8.0, 2.0, 7.0, -1.0, -9.0, -3.0, 4.0, 9.0, -9.0, 4.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockD.i[3], mat4x3(-1.0, 1.0, 7.0, 6.0, -7.0, -4.0, 7.0, -1.0, -6.0, -7.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockD.i[4], mat4x3(6.0, -1.0, -3.0, -7.0, -7.0, -5.0, 7.0, 3.0, 7.0, -3.0, -4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (uvec4(8u, 0u, 1u, 8u));
	blockB[0].b[0] = (1u);
	blockB[0].b[1] = (9u);
	blockB[0].b[2] = (1u);
	blockB[0].b[3] = (0u);
	blockB[0].b[4] = (6u);
	blockB[0].b[5] = (6u);
	blockB[0].b[6] = (5u);
	blockB[0].d.mA = (8u);
	blockB[0].d.mB = (uvec2(4u, 7u));
	blockB[0].e[0].mA = (mat2(8.0, -2.0, 3.0, -3.0));
	blockB[0].e[1].mA = (mat2(9.0, 0.0, -9.0, 4.0));
	blockB[0].e[2].mA = (mat2(7.0, -9.0, -5.0, 5.0));
	blockB[0].e[3].mA = (mat2(-9.0, 1.0, -9.0, 6.0));
	blockC[0].f = (bvec3(true, false, false));
	blockC[1].f = (bvec3(true, false, true));
	blockC[2].f = (bvec3(false, true, false));
	blockD.g = (-2.0);
	blockD.i[0] = (mat4x3(7.0, -5.0, -2.0, -9.0, -3.0, 9.0, -9.0, 4.0, -4.0, 0.0, -8.0, 4.0));
	blockD.i[1] = (mat4x3(-8.0, 3.0, 6.0, -7.0, 8.0, -1.0, 7.0, -2.0, -3.0, 1.0, -2.0, -3.0));
	blockD.i[2] = (mat4x3(0.0, -4.0, 4.0, -3.0, -8.0, 0.0, 7.0, -6.0, -6.0, 4.0, -1.0, 4.0));
	blockD.i[3] = (mat4x3(-9.0, -2.0, -6.0, 4.0, 2.0, -9.0, 9.0, -2.0, 5.0, -9.0, -2.0, -6.0));
	blockD.i[4] = (mat4x3(-2.0, 9.0, 0.0, -2.0, -3.0, 8.0, 3.0, 5.0, 8.0, -1.0, -2.0, 1.0));
	blockE.k = (ivec2(-9, 5));
	blockE.l = (uvec2(3u, 0u));
	blockE.m = (6);
	blockE.n[0] = u8vec3(uvec3(6u, 2u, 8u));
	blockE.n[1] = u8vec3(uvec3(2u, 8u, 7u));
	blockE.n[2] = u8vec3(uvec3(1u, 5u, 6u));
	blockE.n[3] = u8vec3(uvec3(7u, 0u, 0u));
	blockE.n[4] = u8vec3(uvec3(5u, 4u, 9u));
	blockE.n[5] = u8vec3(uvec3(9u, 0u, 7u));
	blockE.n[6] = u8vec3(uvec3(0u, 4u, 8u));
}
