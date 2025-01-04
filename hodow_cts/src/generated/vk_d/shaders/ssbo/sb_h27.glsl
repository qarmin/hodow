#version 450
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

layout(std140, column_major, binding = 1) buffer Block
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

	var[0] = (vec4(6.0, -1.0, -2.0, -5.0));
	var[1] = (vec4(5.0, -2.0, -8.0, -2.0));
	var[2] = (vec4(3.0, 1.0, -9.0, 1.0));
	var[3] = (vec4(0.0, 3.0, 9.0, 7.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(-2.0, -6.0, 9.0, 2.0, 2.0, -8.0, -2.0, 7.0, -4.0, -6.0, 3.0, 2.0, 9.0, -2.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4(-7.0, 6.0, 4.0, 9.0, 8.0, 9.0, 2.0, 6.0, -6.0, 7.0, 1.0, -7.0, 1.0, 4.0, 4.0, -2.0));
}
#version 450
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

	var = (mat2x3(-3.0, -5.0, -2.0, -1.0, -6.0, 1.0));
}
#version 450
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

	var = (mat3x2(3.0, 5.0, 4.0, -6.0, -4.0, -1.0));
}
#version 450
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
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 5u) && allOk;
	allOk = compare_uvec3((var), uvec3(4u, 7u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5u);
	var = (uvec3(3u, 8u, 9u));
}
#version 450
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
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], -7.0) && allOk;
	allOk = compare_float(var[2][0], 5.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], 8.0) && allOk;
	allOk = compare_vec3(var[0], vec3(9.0, -7.0, 8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(9.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(5.0, 9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (9.0);
	var[0] = (vec3(3.0, 2.0, 5.0));
	var[1] = (vec3(0.0, -9.0, -5.0));
	var[2] = (vec3(-3.0, 2.0, -7.0));
}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[0][2], 3.0) && allOk;
	allOk = compare_float(var[0][3], 1.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[1][2], -6.0) && allOk;
	allOk = compare_float(var[1][3], -7.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], -5.0) && allOk;
	allOk = compare_float(var[2][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(4.0, -3.0, 3.0, 1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(4.0, -4.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-6.0, 9.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var = (mat3x4(4.0, 6.0, -1.0, -1.0, 2.0, -8.0, 8.0, 1.0, 3.0, 3.0, 2.0, -5.0));
}
#version 450
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
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(-9.0, -8.0, 7.0, 8.0, 8.0, -3.0, 3.0, -4.0, -1.0, 5.0, 5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var = (mat4x3(-5.0, 2.0, 8.0, -5.0, -9.0, -5.0, 9.0, 3.0, -6.0, 0.0, 3.0, 6.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[0][2], -3.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_float(var[2][0], -8.0) && allOk;
	allOk = compare_float(var[2][1], -1.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[3][0], 2.0) && allOk;
	allOk = compare_float(var[3][1], 5.0) && allOk;
	allOk = compare_float(var[3][2], -3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-8.0, -5.0, -3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(2.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-8.0, -1.0, 6.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(2.0, 5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0] = (vec3(-5.0, 0.0, -1.0));
	var[1] = (vec3(-1.0, 6.0, -4.0));
	var[2] = (vec3(-1.0, -8.0, 6.0));
	var[3] = (vec3(-3.0, -4.0, -8.0));
}
#version 450
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

	var[0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	var[1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	var[2] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
}
#version 450
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

	var[0] = (ivec2(-6, 8));
	var[1] = (ivec2(3, -1));
	var[2] = (ivec2(-5, -2));
}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2(var[0], mat2(7.0, 0.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(-3.0, 5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-9.0, -4.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0] = (mat2(-4.0, -2.0, 1.0, 1.0));
	var[1] = (mat2(-1.0, -3.0, -4.0, -8.0));
	var[2] = (mat2(-6.0, -2.0, 5.0, 8.0));
}
#version 450
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

	var[0] = (uvec2(6u, 1u));
	var[1] = (uvec2(8u, 1u));
	var[2] = (uvec2(7u, 4u));
	var[3] = (uvec2(6u, 6u));
	var[4] = (uvec2(5u, 8u));
	var[5] = (uvec2(4u, 7u));
	var[6] = (uvec2(8u, 4u));
	var[7] = (uvec2(6u, 3u));
	var[8] = (uvec2(6u, 0u));
	var[9] = (uvec2(3u, 5u));
	var[10] = (uvec2(2u, 4u));
	var[11] = (uvec2(7u, 8u));
	var[12] = (uvec2(6u, 2u));
	var[13] = (uvec2(6u, 0u));
	var[14] = (uvec2(3u, 2u));
	var[15] = (uvec2(5u, 1u));
	var[16] = (uvec2(7u, 2u));
	var[17] = (uvec2(3u, 6u));
	var[18] = (uvec2(0u, 1u));
}
#version 450
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
	highp mat2 var[];
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
	allOk = compare_mat2(var[3], mat2(0.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(-4.0, -1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(-1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(-7.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(-9.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(-4.0, -9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(-9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(-9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(-2.0, -4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(4.0, -3.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-5.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(8.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(1.0, 1.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(-6.0, 1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(7.0, -2.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(-3.0, 3.0));
	var[0][1] = (vec2(4.0, 4.0));
	var[1][0] = (vec2(9.0, -9.0));
	var[1][1] = (vec2(-5.0, 8.0));
	var[2][0] = (vec2(0.0, 4.0));
	var[2][1] = (vec2(2.0, -4.0));
	var[3][0] = (vec2(-3.0, 3.0));
	var[3][1] = (vec2(-8.0, -7.0));
	var[4][0] = (vec2(-7.0, -6.0));
	var[4][1] = (vec2(-2.0, 1.0));
	var[5][0] = (vec2(-4.0, 3.0));
	var[5][1] = (vec2(0.0, 7.0));
	var[6][0] = (vec2(-7.0, -5.0));
	var[6][1] = (vec2(6.0, -6.0));
	var[7][0] = (vec2(-4.0, 0.0));
	var[7][1] = (vec2(2.0, 3.0));
	var[8][0] = (vec2(-2.0, -4.0));
	var[8][1] = (vec2(-1.0, 1.0));
	var[9][0] = (vec2(8.0, -9.0));
	var[9][1] = (vec2(8.0, -6.0));
	var[10][0] = (vec2(7.0, -2.0));
	var[10][1] = (vec2(1.0, -2.0));
	var[11][0] = (vec2(-7.0, -6.0));
	var[11][1] = (vec2(8.0, -4.0));
	var[12][0] = (vec2(-3.0, -8.0));
	var[12][1] = (vec2(-4.0, -7.0));
	var[13][0] = (vec2(-9.0, 5.0));
	var[13][1] = (vec2(5.0, -6.0));
	var[14][0] = (vec2(4.0, -1.0));
	var[14][1] = (vec2(-3.0, -8.0));
	var[15][0] = (vec2(1.0, -2.0));
	var[15][1] = (vec2(-6.0, -3.0));
	var[16][0] = (vec2(-5.0, 4.0));
	var[16][1] = (vec2(-7.0, -6.0));
	var[17][0] = (vec2(1.0, -9.0));
	var[17][1] = (vec2(7.0, -1.0));
	var[18][0] = (vec2(-6.0, -1.0));
	var[18][1] = (vec2(9.0, -5.0));
}
#version 450
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
	highp mat2x3 var[];
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
	allOk = compare_mat2x3(var[3], mat2x3(8.0, -6.0, -1.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(-5.0, -2.0, 2.0, -7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(3.0, 5.0, 2.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(-1.0, 9.0, -7.0, -1.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(6.0, -9.0, -4.0, 2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(6.0, 0.0, -9.0, -8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(0.0, 1.0, -9.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(-4.0, 5.0, -3.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(9.0, 8.0, 8.0, 5.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(0.0, -2.0, -7.0, 9.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(-6.0, 8.0, -1.0, 3.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(-5.0, -2.0, 3.0, -9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(4.0, 7.0, 0.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(4.0, 4.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(2.0, 4.0, 7.0, 9.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(7.0, 5.0, -9.0, -8.0, 9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	var[1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	var[2] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
	var[3] = (mat2x3(9.0, 3.0, 8.0, 4.0, 4.0, 2.0));
	var[4] = (mat2x3(4.0, -1.0, -6.0, -5.0, 9.0, 7.0));
	var[5] = (mat2x3(-1.0, -3.0, -1.0, 6.0, 4.0, 8.0));
	var[6] = (mat2x3(-2.0, -1.0, 6.0, 5.0, -8.0, 8.0));
	var[7] = (mat2x3(-3.0, 5.0, -8.0, -9.0, 9.0, 7.0));
	var[8] = (mat2x3(-3.0, -1.0, -2.0, 6.0, 2.0, -6.0));
	var[9] = (mat2x3(-7.0, 6.0, 7.0, -8.0, 5.0, -5.0));
	var[10] = (mat2x3(5.0, -1.0, 8.0, -7.0, -3.0, -4.0));
	var[11] = (mat2x3(-5.0, 3.0, -8.0, 9.0, -8.0, 3.0));
	var[12] = (mat2x3(-1.0, -9.0, 3.0, -5.0, 2.0, 6.0));
	var[13] = (mat2x3(5.0, 8.0, 1.0, 0.0, 1.0, -3.0));
	var[14] = (mat2x3(-5.0, -7.0, -6.0, -7.0, -8.0, -4.0));
	var[15] = (mat2x3(-9.0, 8.0, 1.0, -7.0, 4.0, 8.0));
	var[16] = (mat2x3(3.0, -9.0, 6.0, 7.0, 2.0, -8.0));
	var[17] = (mat2x3(0.0, -7.0, -7.0, -2.0, 8.0, -5.0));
	var[18] = (mat2x3(-2.0, 1.0, -5.0, -3.0, -5.0, -9.0));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat4x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(-4.0, -7.0, 7.0, -5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(3.0, -3.0, 0.0, 8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(6.0, 2.0, -1.0, -6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(-9.0, -5.0, -9.0, 1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(-7.0, -4.0, 0.0, 2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(-7.0, 4.0, 9.0, 8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(0.0, -9.0, -1.0, 9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(5.0, -5.0, -1.0, -9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(-3.0, 1.0, 7.0, -9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(-1.0, 1.0, 9.0, 7.0, 0.0, 9.0, -1.0, -1.0, -7.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(5.0, 7.0, -6.0, -7.0, 6.0, -5.0, -4.0, -1.0, 8.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(-2.0, -5.0, -2.0, -2.0, 9.0, 9.0, -6.0, 0.0, -5.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(8.0, -9.0, 6.0, -7.0, 6.0, 5.0, -5.0, -1.0, 5.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(8.0, 3.0, -1.0, 2.0, 5.0, -8.0, 0.0, -6.0, 4.0, 6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(8.0, 4.0, -1.0, -5.0, 0.0, -6.0, 3.0, 7.0, -8.0, -4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(6.0, -3.0, 0.0, -6.0, -3.0, -6.0, 8.0, 4.0, 2.0, 4.0, -2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	var[1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	var[2] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
	var[3] = (mat4x3(9.0, -7.0, -4.0, -3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0));
	var[4] = (mat4x3(9.0, 0.0, 0.0, 7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0));
	var[5] = (mat4x3(-4.0, 1.0, 3.0, -5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0));
	var[6] = (mat4x3(-8.0, -3.0, -8.0, -5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0));
	var[7] = (mat4x3(8.0, -8.0, -9.0, 9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0));
	var[8] = (mat4x3(-8.0, 9.0, 8.0, -9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0));
	var[9] = (mat4x3(8.0, -3.0, -6.0, 2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0));
	var[10] = (mat4x3(1.0, -6.0, -5.0, -5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0));
	var[11] = (mat4x3(-4.0, 8.0, 5.0, -4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0));
	var[12] = (mat4x3(4.0, 9.0, 7.0, 5.0, 7.0, -2.0, -4.0, -2.0, 3.0, -6.0, 0.0, -7.0));
	var[13] = (mat4x3(9.0, -6.0, -9.0, 5.0, -1.0, -2.0, 4.0, 7.0, 2.0, 8.0, -7.0, 9.0));
	var[14] = (mat4x3(7.0, 3.0, 4.0, 9.0, 8.0, -1.0, -6.0, -4.0, 5.0, -8.0, -4.0, 1.0));
	var[15] = (mat4x3(-1.0, 6.0, 7.0, -9.0, 0.0, 8.0, -4.0, 2.0, 0.0, 3.0, -3.0, 1.0));
	var[16] = (mat4x3(7.0, 7.0, -6.0, 0.0, 1.0, 7.0, 2.0, 8.0, -2.0, -5.0, 8.0, 3.0));
	var[17] = (mat4x3(-1.0, -5.0, -8.0, 1.0, 4.0, 0.0, 2.0, -3.0, 8.0, -5.0, -9.0, 4.0));
	var[18] = (mat4x3(5.0, -9.0, 3.0, -6.0, -1.0, 2.0, 6.0, -2.0, 0.0, 5.0, -5.0, -5.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(2.0, -7.0, 8.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(5.0, -2.0, 1.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(6.0, 7.0, 2.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[3], mat2x3(-5.0, 5.0, 9.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(9.0, 7.0, 9.0, 5.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(1.0, 4.0, -6.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(-9.0, 9.0, 8.0, -5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(9.0, -3.0, -8.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(-8.0, 9.0, 4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(-4.0, -8.0, 0.0, -2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(-3.0, 2.0, 2.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(-3.0, 9.0, -3.0, -8.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(7.0, -5.0, -4.0, 2.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(0.0, 2.0, 2.0, 4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(-7.0, -4.0, -2.0, -2.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(4.0, -2.0, -1.0, 3.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(6.0, -7.0, -9.0, -5.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(-1.0, 5.0, 6.0, -4.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(-7.0, -4.0, 0.0, -8.0, 6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	var[1] = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	var[2] = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
	var[3] = (mat2x3(-4.0, 3.0, 7.0, -5.0, -6.0, 7.0));
	var[4] = (mat2x3(3.0, 8.0, -7.0, -7.0, -6.0, 2.0));
	var[5] = (mat2x3(-8.0, 8.0, -7.0, -2.0, 5.0, 7.0));
	var[6] = (mat2x3(4.0, -7.0, -7.0, 6.0, -8.0, -8.0));
	var[7] = (mat2x3(7.0, -8.0, 4.0, 7.0, 0.0, 3.0));
	var[8] = (mat2x3(9.0, 4.0, 7.0, 4.0, -7.0, 6.0));
	var[9] = (mat2x3(1.0, 3.0, 2.0, -1.0, -8.0, -8.0));
	var[10] = (mat2x3(2.0, 9.0, -3.0, -1.0, -2.0, -1.0));
	var[11] = (mat2x3(-1.0, 8.0, 1.0, -6.0, -9.0, -3.0));
	var[12] = (mat2x3(-1.0, 0.0, -8.0, 1.0, -2.0, -5.0));
	var[13] = (mat2x3(6.0, 6.0, 2.0, 0.0, 4.0, -7.0));
	var[14] = (mat2x3(1.0, -6.0, 8.0, 1.0, -5.0, 1.0));
	var[15] = (mat2x3(-7.0, -4.0, -4.0, -5.0, 3.0, 3.0));
	var[16] = (mat2x3(1.0, 0.0, 9.0, 1.0, -8.0, -1.0));
	var[17] = (mat2x3(9.0, 5.0, -3.0, -9.0, -8.0, 3.0));
	var[18] = (mat2x3(-1.0, 6.0, -1.0, 2.0, -2.0, -5.0));
}
#version 450
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
	allOk = compare_mat3(var[0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(3.0, -6.0, -6.0, 5.0, 5.0, -8.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(-6.0, 3.0, -5.0, 0.0, 5.0, 8.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-1.0, 4.0, -4.0, 9.0, 2.0, 5.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(1.0, -6.0, -4.0, 8.0, -1.0, -9.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(3.0, 8.0, -3.0, -7.0, 6.0, -6.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-9.0, -1.0, -4.0, -4.0, -4.0, 9.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(4.0, -5.0, 6.0, 7.0, -8.0, 2.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(9.0, 7.0, 4.0, 2.0, 8.0, 1.0, -9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(0.0, -6.0, 9.0, 7.0, 3.0, 2.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(6.0, 7.0, -1.0, 8.0, 1.0, 1.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(-5.0, -4.0, -5.0, -1.0, 5.0, 1.0, 5.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(4.0, -8.0, -9.0, 5.0, 9.0, 1.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(7.0, 6.0, -5.0, -8.0, -5.0, 4.0, -8.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(0.0, -8.0, 3.0, -4.0, -5.0, 7.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(5.0, -3.0, 3.0, 7.0, 2.0, 8.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(8.0, 2.0, -2.0, -2.0, 0.0, 9.0, 3.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	var[1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	var[2] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
	var[3] = (mat3(-4.0, 3.0, -8.0, -9.0, 9.0, -7.0, -1.0, -9.0, -9.0));
	var[4] = (mat3(-2.0, 7.0, -3.0, 2.0, -6.0, -7.0, 4.0, 8.0, -8.0));
	var[5] = (mat3(6.0, 1.0, 9.0, 7.0, -9.0, 5.0, -9.0, 9.0, 1.0));
	var[6] = (mat3(8.0, 7.0, -7.0, -4.0, 7.0, -5.0, 8.0, 3.0, -4.0));
	var[7] = (mat3(-5.0, 6.0, -1.0, 6.0, -8.0, 1.0, 7.0, 5.0, 7.0));
	var[8] = (mat3(1.0, 7.0, -1.0, -8.0, 9.0, -2.0, 7.0, 9.0, -5.0));
	var[9] = (mat3(8.0, 7.0, 6.0, -6.0, -1.0, -2.0, 9.0, 6.0, 0.0));
	var[10] = (mat3(-4.0, -3.0, -6.0, -5.0, -8.0, -6.0, 5.0, -5.0, 2.0));
	var[11] = (mat3(7.0, 5.0, -4.0, 7.0, 9.0, -8.0, -9.0, 8.0, -9.0));
	var[12] = (mat3(8.0, 0.0, -7.0, 0.0, -7.0, 5.0, -5.0, -2.0, -9.0));
	var[13] = (mat3(6.0, 5.0, 8.0, 2.0, 5.0, -8.0, 2.0, -9.0, -7.0));
	var[14] = (mat3(-8.0, 3.0, -4.0, 9.0, 2.0, 0.0, -3.0, -6.0, 4.0));
	var[15] = (mat3(6.0, -6.0, 5.0, -5.0, -5.0, -9.0, -4.0, -5.0, 7.0));
	var[16] = (mat3(-7.0, 5.0, 9.0, 0.0, -7.0, 7.0, 9.0, 9.0, 9.0));
	var[17] = (mat3(7.0, -1.0, 7.0, -4.0, 1.0, -3.0, 8.0, 0.0, 4.0));
	var[18] = (mat3(-1.0, 1.0, 8.0, 9.0, 5.0, -2.0, -6.0, -8.0, -3.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	highp ivec2 var[4][3];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var[0][0]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((var[0][1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((var[0][2]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((var[1][0]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((var[1][1]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((var[1][2]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((var[2][0]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((var[2][1]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((var[2][2]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((var[3][0]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((var[3][1]), ivec2(-8, 3)) && allOk;
	allOk = compare_ivec2((var[3][2]), ivec2(7, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (ivec2(-6, 8));
	var[0][1] = (ivec2(3, -1));
	var[0][2] = (ivec2(-5, -2));
	var[1][0] = (ivec2(0, -2));
	var[1][1] = (ivec2(5, 2));
	var[1][2] = (ivec2(-8, 4));
	var[2][0] = (ivec2(-6, -4));
	var[2][1] = (ivec2(3, -2));
	var[2][2] = (ivec2(5, -7));
	var[3][0] = (ivec2(-3, 4));
	var[3][1] = (ivec2(1, 6));
	var[3][2] = (ivec2(8, 7));
}
#version 450
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
	uint8_t var[4][3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(var[0][0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[0][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[0][2]), 3u) && allOk;
	allOk = compare_uint8_t(uint(var[1][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[1][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[1][2]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[2][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[2][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[2][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[3][0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[3][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[3][2]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = uint8_t(9u);
	var[0][1] = uint8_t(5u);
	var[0][2] = uint8_t(2u);
	var[1][0] = uint8_t(6u);
	var[1][1] = uint8_t(7u);
	var[1][2] = uint8_t(5u);
	var[2][0] = uint8_t(8u);
	var[2][1] = uint8_t(4u);
	var[2][2] = uint8_t(2u);
	var[3][0] = uint8_t(6u);
	var[3][1] = uint8_t(0u);
	var[3][2] = uint8_t(1u);
}
#version 450
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
	highp ivec4 var[4][3];
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var[0][0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((var[0][1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((var[0][2]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((var[1][0]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((var[1][1]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((var[1][2]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((var[2][0]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((var[2][1]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((var[2][2]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((var[3][0]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((var[3][1]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((var[3][2]), ivec4(-3, 1, 3, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (ivec4(5, -9, 5, -6));
	var[0][1] = (ivec4(-2, -4, 1, -9));
	var[0][2] = (ivec4(7, 3, 6, 8));
	var[1][0] = (ivec4(6, -4, 6, -7));
	var[1][1] = (ivec4(9, -8, -9, 0));
	var[1][2] = (ivec4(5, -7, 2, 9));
	var[2][0] = (ivec4(6, 5, 4, 0));
	var[2][1] = (ivec4(5, 9, 0, 0));
	var[2][2] = (ivec4(-6, 4, 4, 2));
	var[3][0] = (ivec4(9, 7, 5, 5));
	var[3][1] = (ivec4(3, -3, -9, -8));
	var[3][2] = (ivec4(-6, 3, 2, 0));
}
#version 450
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
	allOk = compare_mat2(var[0][0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(0.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(-4.0, -1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(-1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(-7.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(-9.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(-4.0, -9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(-9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(-9.0, 2.0, -7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(-3.0, 3.0));
	var[0][0][1] = (vec2(4.0, 4.0));
	var[0][1][0] = (vec2(9.0, -9.0));
	var[0][1][1] = (vec2(-5.0, 8.0));
	var[0][2][0] = (vec2(0.0, 4.0));
	var[0][2][1] = (vec2(2.0, -4.0));
	var[1][0][0] = (vec2(-3.0, 3.0));
	var[1][0][1] = (vec2(-8.0, -7.0));
	var[1][1][0] = (vec2(-7.0, -6.0));
	var[1][1][1] = (vec2(-2.0, 1.0));
	var[1][2][0] = (vec2(-4.0, 3.0));
	var[1][2][1] = (vec2(0.0, 7.0));
	var[2][0][0] = (vec2(-7.0, -5.0));
	var[2][0][1] = (vec2(6.0, -6.0));
	var[2][1][0] = (vec2(-4.0, 0.0));
	var[2][1][1] = (vec2(2.0, 3.0));
	var[2][2][0] = (vec2(-2.0, -4.0));
	var[2][2][1] = (vec2(-1.0, 1.0));
	var[3][0][0] = (vec2(8.0, -9.0));
	var[3][0][1] = (vec2(8.0, -6.0));
	var[3][1][0] = (vec2(7.0, -2.0));
	var[3][1][1] = (vec2(1.0, -2.0));
	var[3][2][0] = (vec2(-7.0, -6.0));
	var[3][2][1] = (vec2(8.0, -4.0));
}
#version 450
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
	i16vec4 var[4][3];
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(var[0][0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][2]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][0]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][1]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][2]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][0]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][1]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][2]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][0]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][1]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][2]), ivec4(4, 8, -6, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = i16vec4(ivec4(-4, -8, -4, 9));
	var[0][1] = i16vec4(ivec4(2, 7, -4, 4));
	var[0][2] = i16vec4(ivec4(8, 9, 5, 1));
	var[1][0] = i16vec4(ivec4(-3, 3, 8, 7));
	var[1][1] = i16vec4(ivec4(2, 6, -9, 9));
	var[1][2] = i16vec4(ivec4(-2, 4, -8, -7));
	var[2][0] = i16vec4(ivec4(-9, -1, -8, -1));
	var[2][1] = i16vec4(ivec4(-1, -6, 5, 2));
	var[2][2] = i16vec4(ivec4(-3, 8, -7, -2));
	var[3][0] = i16vec4(ivec4(9, 7, 6, -9));
	var[3][1] = i16vec4(ivec4(5, -3, 8, 5));
	var[3][2] = i16vec4(ivec4(-6, -9, -6, 2));
}
#version 450
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
	highp uvec2 var[4][3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 6u) && allOk;
	allOk = compare_uvec2((var[0][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((var[0][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((var[0][2]), uvec2(7u, 9u)) && allOk;
	allOk = compare_uvec2((var[1][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((var[1][1]), uvec2(9u, 8u)) && allOk;
	allOk = compare_uvec2((var[1][2]), uvec2(4u, 0u)) && allOk;
	allOk = compare_uvec2((var[2][0]), uvec2(2u, 2u)) && allOk;
	allOk = compare_uvec2((var[2][1]), uvec2(9u, 8u)) && allOk;
	allOk = compare_uvec2((var[2][2]), uvec2(4u, 1u)) && allOk;
	allOk = compare_uvec2((var[3][0]), uvec2(4u, 7u)) && allOk;
	allOk = compare_uvec2((var[3][1]), uvec2(1u, 8u)) && allOk;
	allOk = compare_uvec2((var[3][2]), uvec2(8u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6u);
	var[0][0] = (uvec2(1u, 8u));
	var[0][1] = (uvec2(1u, 7u));
	var[0][2] = (uvec2(4u, 6u));
	var[1][0] = (uvec2(6u, 5u));
	var[1][1] = (uvec2(8u, 4u));
	var[1][2] = (uvec2(7u, 8u));
	var[2][0] = (uvec2(4u, 6u));
	var[2][1] = (uvec2(3u, 6u));
	var[2][2] = (uvec2(0u, 3u));
	var[3][0] = (uvec2(5u, 2u));
	var[3][1] = (uvec2(4u, 7u));
	var[3][2] = (uvec2(8u, 6u));
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat3x2(var[0][0], mat3x2(-4.0, -6.0, 5.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(5.0, 9.0, -1.0, 4.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(-2.0, -3.0, 2.0, 7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(-4.0, -9.0, 9.0, -2.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(4.0, -7.0, -7.0, 3.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(1.0, 4.0, 8.0, -2.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(4.0, 3.0, -8.0, -2.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(-7.0, -6.0, 9.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(0.0, -6.0, 7.0, -4.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(5.0, -6.0, -3.0, 6.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(8.0, 9.0, -3.0, 8.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-9.0, -6.0, -9.0, 5.0, 9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0] = (mat3x2(-1.0, 2.0, -8.0, -4.0, 9.0, 6.0));
	var[0][1] = (mat3x2(8.0, 5.0, -7.0, -7.0, 0.0, 5.0));
	var[0][2] = (mat3x2(8.0, 1.0, -4.0, 1.0, 3.0, 0.0));
	var[1][0] = (mat3x2(-6.0, -9.0, 0.0, 8.0, 7.0, 7.0));
	var[1][1] = (mat3x2(-7.0, 8.0, -7.0, -8.0, 9.0, -5.0));
	var[1][2] = (mat3x2(-9.0, -9.0, -4.0, 7.0, 7.0, 3.0));
	var[2][0] = (mat3x2(-9.0, -7.0, 4.0, -8.0, -2.0, 9.0));
	var[2][1] = (mat3x2(-1.0, 9.0, 7.0, 0.0, 3.0, -6.0));
	var[2][2] = (mat3x2(5.0, -8.0, 1.0, 9.0, 5.0, -4.0));
	var[3][0] = (mat3x2(-3.0, -2.0, 3.0, -1.0, 1.0, -9.0));
	var[3][1] = (mat3x2(4.0, 5.0, -3.0, 8.0, 4.0, 8.0));
	var[3][2] = (mat3x2(-4.0, -8.0, 7.0, -4.0, 9.0, -6.0));
}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat4x2(var[0][0], mat4x2(1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(-2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(-9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(-4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(-8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0][0][0] = (vec2(-2.0, 2.0));
	var[0][0][1] = (vec2(8.0, -5.0));
	var[0][0][2] = (vec2(3.0, -1.0));
	var[0][0][3] = (vec2(-7.0, 4.0));
	var[0][1][0] = (vec2(2.0, -4.0));
	var[0][1][1] = (vec2(8.0, 3.0));
	var[0][1][2] = (vec2(8.0, -1.0));
	var[0][1][3] = (vec2(6.0, -8.0));
	var[0][2][0] = (vec2(2.0, -5.0));
	var[0][2][1] = (vec2(5.0, -4.0));
	var[0][2][2] = (vec2(-9.0, 0.0));
	var[0][2][3] = (vec2(4.0, 8.0));
	var[1][0][0] = (vec2(2.0, -3.0));
	var[1][0][1] = (vec2(2.0, -4.0));
	var[1][0][2] = (vec2(-4.0, 2.0));
	var[1][0][3] = (vec2(-8.0, -4.0));
	var[1][1][0] = (vec2(8.0, 5.0));
	var[1][1][1] = (vec2(7.0, -4.0));
	var[1][1][2] = (vec2(6.0, 8.0));
	var[1][1][3] = (vec2(4.0, -9.0));
	var[1][2][0] = (vec2(-7.0, 7.0));
	var[1][2][1] = (vec2(-5.0, 1.0));
	var[1][2][2] = (vec2(-9.0, 9.0));
	var[1][2][3] = (vec2(5.0, 7.0));
	var[2][0][0] = (vec2(3.0, 3.0));
	var[2][0][1] = (vec2(3.0, -5.0));
	var[2][0][2] = (vec2(-9.0, 2.0));
	var[2][0][3] = (vec2(9.0, 3.0));
	var[2][1][0] = (vec2(8.0, 3.0));
	var[2][1][1] = (vec2(-4.0, 6.0));
	var[2][1][2] = (vec2(1.0, -3.0));
	var[2][1][3] = (vec2(1.0, -5.0));
	var[2][2][0] = (vec2(-2.0, 7.0));
	var[2][2][1] = (vec2(8.0, 4.0));
	var[2][2][2] = (vec2(7.0, -1.0));
	var[2][2][3] = (vec2(-8.0, -6.0));
	var[3][0][0] = (vec2(-6.0, -4.0));
	var[3][0][1] = (vec2(-2.0, 3.0));
	var[3][0][2] = (vec2(8.0, 4.0));
	var[3][0][3] = (vec2(4.0, -7.0));
	var[3][1][0] = (vec2(-6.0, 8.0));
	var[3][1][1] = (vec2(-6.0, 8.0));
	var[3][1][2] = (vec2(-3.0, -7.0));
	var[3][1][3] = (vec2(0.0, -9.0));
	var[3][2][0] = (vec2(2.0, -9.0));
	var[3][2][1] = (vec2(7.0, -2.0));
	var[3][2][2] = (vec2(2.0, -6.0));
	var[3][2][3] = (vec2(-1.0, 1.0));
}
#version 450
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
	allOk = compare_mat4(var[0][0][0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(-3.0, 6.0, 6.0, -1.0, -2.0, -7.0, 1.0, 0.0, -5.0, 3.0, -7.0, 2.0, 6.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(5.0, -4.0, -3.0, 9.0, -8.0, -9.0, 2.0, 5.0, -3.0, -3.0, -4.0, 9.0, -2.0, -8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(-9.0, 0.0, 3.0, 0.0, 6.0, -5.0, 8.0, 6.0, -3.0, -9.0, -1.0, 2.0, 3.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(8.0, -5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(8.0, 7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(-7.0, 4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(9.0, -8.0, -7.0, -1.0, -3.0, 9.0, -4.0, -9.0, 3.0, -3.0, -7.0, -7.0, 3.0, 1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(3.0, 0.0, 5.0, -1.0, 2.0, 2.0, -2.0, 3.0, -9.0, 7.0, 0.0, -8.0, -4.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(-2.0, 8.0, -8.0, -3.0, 0.0, -5.0, 4.0, -3.0, -1.0, -8.0, 4.0, -2.0, -7.0, 0.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-7.0, -9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(5.0, -2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(-6.0, 8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(1.0, 5.0, -7.0, -8.0, 2.0, 4.0, -9.0, -7.0, -4.0, 6.0, -7.0, 0.0, 5.0, 3.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-1.0, 9.0, 7.0, 3.0, 6.0, 4.0, -2.0, 2.0, -4.0, 0.0, -3.0, 6.0, -6.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(5.0, 7.0, -3.0, 4.0, 0.0, 8.0, -1.0, -4.0, 0.0, -5.0, 3.0, -8.0, -7.0, 5.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(6.0, 4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(4.0, -6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(-4.0, -7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-6.0, 7.0, -2.0, 2.0, 4.0, 7.0, -2.0, 9.0, -2.0, -5.0, 2.0, -7.0, 7.0, -5.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(-6.0, -6.0, -9.0, 2.0, 9.0, 6.0, -9.0, -1.0, -3.0, -9.0, -4.0, 4.0, -8.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(-3.0, -1.0, 6.0, -9.0, 6.0, -3.0, -5.0, 3.0, 8.0, -8.0, -6.0, 6.0, -1.0, 4.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	var[0][0][1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	var[0][0][2] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
	var[0][1][0] = (mat4(5.0, 1.0, 7.0, 8.0, 0.0, -3.0, 8.0, 5.0, -2.0, -2.0, -1.0, -2.0, 4.0, -6.0, 1.0, 5.0));
	var[0][1][1] = (mat4(-1.0, 8.0, 6.0, 8.0, -7.0, -4.0, -5.0, -8.0, 5.0, 0.0, 7.0, -8.0, 8.0, -2.0, 6.0, 5.0));
	var[0][1][2] = (mat4(2.0, 8.0, -1.0, 1.0, -9.0, -1.0, 9.0, -4.0, 9.0, 4.0, -2.0, 9.0, 6.0, 7.0, 1.0, 3.0));
	var[1][0][0] = (mat4(2.0, 3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0));
	var[1][0][1] = (mat4(-4.0, -1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0));
	var[1][0][2] = (mat4(-5.0, -1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0));
	var[1][1][0] = (mat4(-7.0, -5.0, 2.0, -5.0, 8.0, -5.0, -6.0, 3.0, -5.0, -8.0, 1.0, -1.0, 1.0, 2.0, -5.0, 3.0));
	var[1][1][1] = (mat4(7.0, 2.0, 8.0, -4.0, -1.0, 2.0, 4.0, 1.0, 9.0, 7.0, -6.0, 7.0, 7.0, -5.0, 0.0, 3.0));
	var[1][1][2] = (mat4(-4.0, -1.0, -2.0, -3.0, 6.0, 2.0, 7.0, 0.0, 3.0, 4.0, -4.0, 2.0, 8.0, -4.0, 7.0, -4.0));
	var[2][0][0] = (mat4(3.0, 6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0));
	var[2][0][1] = (mat4(1.0, 2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0));
	var[2][0][2] = (mat4(2.0, 4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0));
	var[2][1][0] = (mat4(-2.0, -1.0, 8.0, 8.0, -9.0, 9.0, 6.0, -1.0, 3.0, -9.0, -4.0, -6.0, -2.0, 6.0, -7.0, 3.0));
	var[2][1][1] = (mat4(9.0, -7.0, 6.0, 8.0, -2.0, -6.0, -5.0, 5.0, -8.0, -5.0, 8.0, 4.0, 2.0, 2.0, 4.0, -9.0));
	var[2][1][2] = (mat4(-5.0, -6.0, 9.0, -7.0, 8.0, -4.0, 0.0, -3.0, -1.0, 7.0, 1.0, -5.0, 8.0, 4.0, -7.0, 8.0));
	var[3][0][0] = (mat4(8.0, 9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0));
	var[3][0][1] = (mat4(-8.0, 6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0));
	var[3][0][2] = (mat4(-2.0, 0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0));
	var[3][1][0] = (mat4(7.0, 1.0, 8.0, -1.0, 2.0, -4.0, 3.0, 6.0, -2.0, 9.0, 0.0, 2.0, -1.0, -5.0, 2.0, -6.0));
	var[3][1][1] = (mat4(4.0, 2.0, -1.0, 5.0, 7.0, 1.0, -8.0, 4.0, 2.0, -3.0, -2.0, 1.0, -5.0, -8.0, 3.0, -8.0));
	var[3][1][2] = (mat4(-8.0, 9.0, 1.0, 7.0, -4.0, 3.0, -8.0, 6.0, 8.0, -5.0, -3.0, 2.0, 4.0, -5.0, -3.0, 8.0));
}
#version 450
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
	highp mat3x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-7.0, -8.0, -1.0, 5.0, 6.0, -6.0, -4.0, 9.0, -5.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-9.0, 3.0, 1.0, 8.0, 7.0, 0.0, 7.0, 9.0, -1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(3.0, 8.0, 0.0, -6.0, -6.0, -1.0, -2.0, 5.0, 1.0, -3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-3.0, 1.0, 4.0, 2.0, -2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(6.0, -6.0, -8.0, 8.0, 4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(2.0, 8.0, -9.0, 0.0, 3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(0.0, 8.0, -9.0, 6.0, -5.0, 3.0, -8.0, -1.0, -9.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-8.0, 8.0, -1.0, 9.0, 1.0, -5.0, -4.0, 3.0, 5.0, 7.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(-2.0, 6.0, 5.0, 9.0, 2.0, -3.0, 3.0, 8.0, 8.0, 6.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-9.0, -9.0, 1.0, 6.0, -2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-6.0, 1.0, -4.0, 2.0, 9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(-6.0, 5.0, 3.0, -1.0, 6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-5.0, -7.0, 0.0, -4.0, 1.0, 2.0, -2.0, -3.0, -4.0, 2.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(6.0, -3.0, 9.0, 7.0, -4.0, -2.0, 6.0, 5.0, 2.0, -2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(0.0, -8.0, -2.0, 7.0, 5.0, -6.0, 9.0, 6.0, 4.0, -4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(-8.0, 6.0, 7.0, -3.0, -3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(-9.0, 1.0, 2.0, 0.0, -3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(4.0, 8.0, -1.0, 7.0, 0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(-2.0, 8.0, -4.0, 7.0, 4.0, 5.0, 1.0, -1.0, 3.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(-6.0, 1.0, -9.0, 0.0, -5.0, 8.0, -9.0, 1.0, -2.0, -2.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(-7.0, -6.0, -7.0, 6.0, 0.0, -6.0, 7.0, 3.0, 0.0, -7.0, 7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	var[0][0][1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	var[0][0][2] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
	var[0][1][0] = (mat3x4(-5.0, -6.0, -9.0, -2.0, 3.0, 0.0, 8.0, 5.0, 9.0, 8.0, 5.0, -4.0));
	var[0][1][1] = (mat3x4(5.0, 8.0, 3.0, -2.0, -6.0, -3.0, 3.0, 3.0, 0.0, 9.0, -9.0, 4.0));
	var[0][1][2] = (mat3x4(-8.0, -7.0, 4.0, -2.0, -9.0, -4.0, -3.0, -8.0, 7.0, 8.0, -1.0, -7.0));
	var[1][0][0] = (mat3x4(-9.0, 1.0, -3.0, -5.0, -5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0));
	var[1][0][1] = (mat3x4(-4.0, 4.0, 3.0, 8.0, -8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0));
	var[1][0][2] = (mat3x4(-9.0, -3.0, 7.0, -7.0, -6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0));
	var[1][1][0] = (mat3x4(0.0, -4.0, 5.0, 2.0, 2.0, -3.0, 7.0, -3.0, 7.0, 0.0, -2.0, 0.0));
	var[1][1][1] = (mat3x4(-3.0, 7.0, -2.0, 4.0, -6.0, -3.0, 4.0, -8.0, 7.0, -3.0, -5.0, -5.0));
	var[1][1][2] = (mat3x4(-6.0, -2.0, 3.0, 6.0, 7.0, 1.0, -6.0, 7.0, -9.0, 5.0, 5.0, 3.0));
	var[2][0][0] = (mat3x4(3.0, 1.0, -4.0, -8.0, -9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0));
	var[2][0][1] = (mat3x4(1.0, -1.0, -1.0, -7.0, -9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0));
	var[2][0][2] = (mat3x4(9.0, 2.0, -4.0, -9.0, -7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0));
	var[2][1][0] = (mat3x4(2.0, -3.0, -5.0, 8.0, -5.0, 3.0, 2.0, 1.0, 4.0, -5.0, -7.0, -9.0));
	var[2][1][1] = (mat3x4(5.0, 1.0, 4.0, 9.0, -7.0, -7.0, -7.0, 9.0, -4.0, 1.0, 3.0, 5.0));
	var[2][1][2] = (mat3x4(-6.0, 6.0, 7.0, 7.0, -3.0, -3.0, -7.0, -3.0, 5.0, -8.0, 3.0, 3.0));
	var[3][0][0] = (mat3x4(4.0, -5.0, 0.0, -5.0, -7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0));
	var[3][0][1] = (mat3x4(-9.0, 0.0, 8.0, 4.0, -9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0));
	var[3][0][2] = (mat3x4(6.0, -3.0, -7.0, -8.0, 6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0));
	var[3][1][0] = (mat3x4(-9.0, 1.0, 5.0, 5.0, -5.0, 8.0, 4.0, -4.0, 9.0, -2.0, 1.0, -8.0));
	var[3][1][1] = (mat3x4(-2.0, 9.0, 3.0, 9.0, 9.0, -1.0, -9.0, 3.0, -9.0, 2.0, 2.0, -6.0));
	var[3][1][2] = (mat3x4(-9.0, 4.0, 0.0, 2.0, 4.0, -2.0, 9.0, -7.0, 4.0, -5.0, 3.0, -2.0));
}
#version 450
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
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(0.0, -5.0, 8.0, -6.0, -1.0, -7.0, 0.0, 3.0, -2.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-4.0, -5.0, 4.0, 2.0, -5.0, -5.0, -9.0, 2.0, -7.0, 9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(2.0, 0.0, -4.0, 6.0, 3.0, -2.0, -9.0, 8.0, -8.0, 8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-7.0, -2.0, 9.0, -3.0, 9.0, -8.0, 1.0, -7.0, -8.0, -9.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-2.0, 9.0, -3.0, -1.0, -8.0, 5.0, 9.0, -3.0, 7.0, 2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(0.0, 7.0, -2.0, 1.0, 7.0, 1.0, -5.0, 4.0, 4.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(0.0, -3.0, -6.0, 4.0, -8.0, -1.0, 9.0, 9.0, 2.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(-7.0, 4.0, 7.0, 7.0, 0.0, -9.0, -8.0, -1.0, -6.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(8.0, -2.0, 1.0, 8.0, 4.0, 6.0, -6.0, -5.0, 1.0, -7.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(5.0, 1.0, 1.0, -6.0, 0.0, -8.0, -7.0, 3.0, 3.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(-2.0, -2.0, 3.0, -6.0, -5.0, -1.0, 2.0, -4.0, -8.0, -7.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(-3.0, -9.0, 3.0, 8.0, 3.0, 7.0, 9.0, 3.0, -3.0, 7.0, -8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	var[0][0][0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	var[0][0][0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	var[0][0][1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	var[0][0][1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	var[0][0][1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	var[0][0][2][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	var[0][0][2][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	var[0][0][2][2] = (vec4(0.0, 4.0, 1.0, -9.0));
	var[0][1][0][0] = (vec4(7.0, 5.0, 1.0, 8.0));
	var[0][1][0][1] = (vec4(-4.0, 6.0, -3.0, -6.0));
	var[0][1][0][2] = (vec4(2.0, -9.0, -8.0, 6.0));
	var[0][1][1][0] = (vec4(-7.0, 0.0, 5.0, 8.0));
	var[0][1][1][1] = (vec4(9.0, 8.0, -6.0, -2.0));
	var[0][1][1][2] = (vec4(9.0, -5.0, 4.0, -4.0));
	var[0][1][2][0] = (vec4(-5.0, -1.0, -2.0, -8.0));
	var[0][1][2][1] = (vec4(-2.0, 5.0, -5.0, 9.0));
	var[0][1][2][2] = (vec4(7.0, -5.0, -3.0, 0.0));
	var[1][0][0][0] = (vec4(3.0, -3.0, 5.0, 9.0));
	var[1][0][0][1] = (vec4(4.0, -2.0, -3.0, -6.0));
	var[1][0][0][2] = (vec4(8.0, 9.0, -9.0, -5.0));
	var[1][0][1][0] = (vec4(3.0, 4.0, -1.0, -5.0));
	var[1][0][1][1] = (vec4(9.0, -2.0, 4.0, -9.0));
	var[1][0][1][2] = (vec4(1.0, -8.0, -2.0, 1.0));
	var[1][0][2][0] = (vec4(-8.0, -2.0, 9.0, 8.0));
	var[1][0][2][1] = (vec4(-5.0, -8.0, -2.0, 7.0));
	var[1][0][2][2] = (vec4(-3.0, -9.0, 0.0, -9.0));
	var[1][1][0][0] = (vec4(-5.0, -6.0, 7.0, 0.0));
	var[1][1][0][1] = (vec4(7.0, -8.0, -6.0, 0.0));
	var[1][1][0][2] = (vec4(7.0, -9.0, 2.0, 3.0));
	var[1][1][1][0] = (vec4(6.0, -9.0, -7.0, 6.0));
	var[1][1][1][1] = (vec4(0.0, 2.0, 9.0, -1.0));
	var[1][1][1][2] = (vec4(3.0, -4.0, 9.0, -2.0));
	var[1][1][2][0] = (vec4(-4.0, 6.0, 1.0, -2.0));
	var[1][1][2][1] = (vec4(-4.0, 3.0, 1.0, -1.0));
	var[1][1][2][2] = (vec4(9.0, -4.0, -1.0, 3.0));
	var[2][0][0][0] = (vec4(7.0, 4.0, -2.0, -4.0));
	var[2][0][0][1] = (vec4(6.0, -9.0, -7.0, 3.0));
	var[2][0][0][2] = (vec4(-3.0, -6.0, -1.0, 0.0));
	var[2][0][1][0] = (vec4(2.0, 3.0, -1.0, 9.0));
	var[2][0][1][1] = (vec4(-3.0, -9.0, -1.0, 0.0));
	var[2][0][1][2] = (vec4(-9.0, 1.0, 6.0, 5.0));
	var[2][0][2][0] = (vec4(-8.0, 4.0, -8.0, 5.0));
	var[2][0][2][1] = (vec4(4.0, 3.0, -7.0, 5.0));
	var[2][0][2][2] = (vec4(-4.0, 7.0, 2.0, -6.0));
	var[2][1][0][0] = (vec4(-1.0, -1.0, -9.0, -5.0));
	var[2][1][0][1] = (vec4(6.0, 2.0, -2.0, 8.0));
	var[2][1][0][2] = (vec4(9.0, 2.0, -4.0, 7.0));
	var[2][1][1][0] = (vec4(-8.0, -7.0, 8.0, -8.0));
	var[2][1][1][1] = (vec4(-5.0, 2.0, -3.0, 5.0));
	var[2][1][1][2] = (vec4(-3.0, -2.0, -5.0, 3.0));
	var[2][1][2][0] = (vec4(-3.0, 8.0, -3.0, -6.0));
	var[2][1][2][1] = (vec4(-4.0, 6.0, -2.0, -2.0));
	var[2][1][2][2] = (vec4(-4.0, -3.0, -1.0, -3.0));
	var[3][0][0][0] = (vec4(-2.0, 4.0, -9.0, -3.0));
	var[3][0][0][1] = (vec4(7.0, 5.0, -1.0, 1.0));
	var[3][0][0][2] = (vec4(6.0, -2.0, -5.0, 9.0));
	var[3][0][1][0] = (vec4(-6.0, 2.0, 5.0, -5.0));
	var[3][0][1][1] = (vec4(2.0, 4.0, -3.0, 1.0));
	var[3][0][1][2] = (vec4(9.0, -1.0, -1.0, -1.0));
	var[3][0][2][0] = (vec4(7.0, -4.0, -7.0, -3.0));
	var[3][0][2][1] = (vec4(9.0, -7.0, -5.0, -9.0));
	var[3][0][2][2] = (vec4(3.0, 9.0, 2.0, -5.0));
	var[3][1][0][0] = (vec4(7.0, 9.0, -4.0, 8.0));
	var[3][1][0][1] = (vec4(-6.0, 4.0, -4.0, -8.0));
	var[3][1][0][2] = (vec4(1.0, 2.0, 2.0, -4.0));
	var[3][1][1][0] = (vec4(-1.0, -9.0, 2.0, 6.0));
	var[3][1][1][1] = (vec4(5.0, 9.0, 3.0, -7.0));
	var[3][1][1][2] = (vec4(7.0, -8.0, -1.0, -8.0));
	var[3][1][2][0] = (vec4(3.0, -4.0, 6.0, -5.0));
	var[3][1][2][1] = (vec4(-5.0, 3.0, 5.0, -2.0));
	var[3][1][2][2] = (vec4(-3.0, 2.0, 1.0, 6.0));
}
#version 450
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
	i8vec2 var[4][2][3];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(var[0][0][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][0][1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][0][2]), ivec2(0, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1][0]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1][1]), ivec2(2, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1][2]), ivec2(4294967290, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0][1]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0][2]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1][0]), ivec2(5, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1][1]), ivec2(8, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1][2]), ivec2(4294967294, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0][0]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0][1]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0][2]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1][0]), ivec2(7, 4294967292)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1][1]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1][2]), ivec2(2, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][0][0]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][0][1]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][0][2]), ivec2(3, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][1][0]), ivec2(0, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][1][1]), ivec2(4294967289, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][1][2]), ivec2(7, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i8vec2(ivec2(0, 8));
	var[0][0][1] = i8vec2(ivec2(4294967292, 9));
	var[0][0][2] = i8vec2(ivec2(4294967294, 4294967295));
	var[0][1][0] = i8vec2(ivec2(4294967293, 0));
	var[0][1][1] = i8vec2(ivec2(3, 4294967291));
	var[0][1][2] = i8vec2(ivec2(4294967295, 4294967292));
	var[1][0][0] = i8vec2(ivec2(8, 4294967290));
	var[1][0][1] = i8vec2(ivec2(8, 4294967289));
	var[1][0][2] = i8vec2(ivec2(7, 4294967294));
	var[1][1][0] = i8vec2(ivec2(5, 4294967292));
	var[1][1][1] = i8vec2(ivec2(4294967291, 4));
	var[1][1][2] = i8vec2(ivec2(0, 4294967293));
	var[2][0][0] = i8vec2(ivec2(4294967293, 4294967293));
	var[2][0][1] = i8vec2(ivec2(4294967290, 3));
	var[2][0][2] = i8vec2(ivec2(4294967295, 8));
	var[2][1][0] = i8vec2(ivec2(4294967292, 4294967292));
	var[2][1][1] = i8vec2(ivec2(3, 4294967294));
	var[2][1][2] = i8vec2(ivec2(8, 4));
	var[3][0][0] = i8vec2(ivec2(5, 8));
	var[3][0][1] = i8vec2(ivec2(4294967293, 4294967292));
	var[3][0][2] = i8vec2(ivec2(4294967287, 6));
	var[3][1][0] = i8vec2(ivec2(8, 6));
	var[3][1][1] = i8vec2(ivec2(5, 4294967294));
	var[3][1][2] = i8vec2(ivec2(4294967288, 4294967292));
}
#version 450
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
	highp mat4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(8.0, 1.0, -9.0, 5.0, -9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-9.0, 9.0, -6.0, -5.0, 7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(4.0, 9.0, -7.0, -4.0, 6.0, 6.0, 9.0, 9.0, 7.0, 3.0, 6.0, 1.0, 5.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(6.0, 7.0, 4.0, 7.0, 0.0, 3.0, -7.0, -8.0, -9.0, 1.0, 4.0, 2.0, 0.0, -6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(-1.0, 4.0, -8.0, -2.0, 4.0, 0.0, -4.0, -1.0, 4.0, -5.0, -8.0, 0.0, 8.0, 4.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(2.0, -8.0, 8.0, -6.0, -1.0, -8.0, 9.0, 7.0, 4.0, -2.0, -7.0, 3.0, -9.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-5.0, 6.0, 6.0, 7.0, -2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(9.0, 3.0, -9.0, 0.0, -6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(0.0, -3.0, -3.0, 1.0, -4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(-7.0, 7.0, -7.0, 6.0, 6.0, -7.0, 3.0, -2.0, -8.0, 6.0, 5.0, 8.0, 5.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(1.0, -3.0, -5.0, -3.0, 4.0, 2.0, -1.0, 8.0, -6.0, 2.0, 6.0, 6.0, 5.0, 4.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(6.0, -4.0, -3.0, -9.0, -3.0, 1.0, -4.0, -5.0, 3.0, -9.0, 9.0, -1.0, -6.0, 8.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-7.0, 8.0, 6.0, 5.0, 7.0, 6.0, 2.0, 2.0, 3.0, -2.0, -1.0, 2.0, 5.0, 3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-9.0, -5.0, -8.0, -7.0, -2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-1.0, -8.0, -9.0, 2.0, 0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(8.0, 7.0, -4.0, 9.0, -4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(6.0, -1.0, 8.0, -1.0, 3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(6.0, -2.0, -6.0, 6.0, -1.0, 9.0, 7.0, 9.0, 5.0, -5.0, -5.0, 8.0, -5.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(-8.0, -6.0, 5.0, -5.0, 7.0, -6.0, -4.0, 7.0, 5.0, -4.0, -1.0, 2.0, 6.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(8.0, 6.0, 8.0, 2.0, -4.0, 2.0, 7.0, 7.0, 6.0, 6.0, 7.0, -3.0, 6.0, -1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(2.0, -5.0, 8.0, -7.0, -1.0, -5.0, -9.0, 8.0, -6.0, 4.0, 3.0, 9.0, 3.0, -1.0, 0.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	var[0][0][1] = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	var[0][1][0] = (mat4(3.0, -8.0, 9.0, 8.0, 0.0, 3.0, 7.0, 6.0, 4.0, 6.0, 8.0, -9.0, 5.0, 9.0, -4.0, -4.0));
	var[0][1][1] = (mat4(1.0, 0.0, -1.0, 1.0, 7.0, 1.0, -7.0, -6.0, -9.0, 6.0, -5.0, -8.0, 1.0, -3.0, 3.0, 4.0));
	var[0][2][0] = (mat4(-8.0, 4.0, 7.0, 8.0, 2.0, -8.0, -3.0, 3.0, -4.0, 1.0, 2.0, 3.0, -1.0, 1.0, 8.0, -3.0));
	var[0][2][1] = (mat4(0.0, 5.0, -3.0, -5.0, 2.0, 8.0, 7.0, 5.0, 3.0, 8.0, 4.0, -1.0, 5.0, -1.0, -3.0, 5.0));
	var[0][3][0] = (mat4(-6.0, 6.0, 8.0, 4.0, 1.0, 3.0, 4.0, -7.0, -9.0, -3.0, 3.0, -1.0, 8.0, 6.0, 3.0, 3.0));
	var[0][3][1] = (mat4(-8.0, 1.0, -8.0, -4.0, 4.0, -4.0, -8.0, 9.0, 7.0, 7.0, -3.0, -6.0, 5.0, -5.0, -1.0, 7.0));
	var[1][0][0] = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
	var[1][0][1] = (mat4(6.0, -6.0, 8.0, 6.0, 6.0, 3.0, 3.0, 2.0, -4.0, 4.0, 2.0, -3.0, -7.0, -8.0, -6.0, 1.0));
	var[1][1][0] = (mat4(-4.0, 2.0, 6.0, -8.0, 2.0, -4.0, 9.0, -7.0, -6.0, 4.0, 4.0, -2.0, -6.0, 1.0, 2.0, -7.0));
	var[1][1][1] = (mat4(-2.0, 7.0, 4.0, 1.0, 4.0, -4.0, 2.0, 4.0, 2.0, -1.0, -8.0, 0.0, -9.0, 2.0, 8.0, 9.0));
	var[1][2][0] = (mat4(-7.0, 1.0, 5.0, -4.0, 9.0, -1.0, 0.0, 8.0, -3.0, 4.0, 5.0, -5.0, 1.0, -8.0, -1.0, 3.0));
	var[1][2][1] = (mat4(9.0, -4.0, -2.0, 7.0, 1.0, -8.0, 4.0, 2.0, 8.0, 3.0, -2.0, -6.0, 2.0, -7.0, 1.0, 0.0));
	var[1][3][0] = (mat4(9.0, 7.0, -2.0, -4.0, 8.0, 2.0, -9.0, 3.0, -4.0, 5.0, 1.0, -7.0, 4.0, 7.0, 6.0, -4.0));
	var[1][3][1] = (mat4(3.0, 4.0, 2.0, 1.0, -9.0, -3.0, -4.0, 6.0, 9.0, 3.0, 8.0, -1.0, -7.0, -5.0, -3.0, 0.0));
	var[2][0][0] = (mat4(-4.0, -6.0, -2.0, -5.0, -2.0, -9.0, 0.0, 3.0, 9.0, 2.0, -5.0, 5.0, 1.0, 9.0, -1.0, 0.0));
	var[2][0][1] = (mat4(-4.0, 8.0, 6.0, -2.0, 1.0, -1.0, -7.0, -1.0, -1.0, 3.0, -8.0, 4.0, 8.0, 4.0, -3.0, -8.0));
	var[2][1][0] = (mat4(-1.0, -7.0, -2.0, -1.0, 7.0, 1.0, -8.0, -8.0, -3.0, -2.0, 5.0, 7.0, -2.0, -8.0, 8.0, -6.0));
	var[2][1][1] = (mat4(4.0, 3.0, -2.0, -4.0, -1.0, -3.0, -8.0, 3.0, -3.0, 8.0, 1.0, -4.0, -9.0, -7.0, 3.0, 6.0));
	var[2][2][0] = (mat4(5.0, 9.0, 8.0, 8.0, -3.0, 9.0, 9.0, 8.0, 9.0, 7.0, 5.0, 1.0, -6.0, -4.0, -4.0, 4.0));
	var[2][2][1] = (mat4(1.0, 4.0, 7.0, 6.0, -1.0, 2.0, 2.0, 4.0, -1.0, -9.0, 4.0, 4.0, 1.0, -7.0, 7.0, -7.0));
	var[2][3][0] = (mat4(3.0, -6.0, -2.0, 7.0, -7.0, 8.0, -5.0, -9.0, 7.0, 9.0, 7.0, -5.0, -8.0, -4.0, 1.0, -8.0));
	var[2][3][1] = (mat4(-5.0, -6.0, 4.0, 9.0, 2.0, -4.0, 1.0, -3.0, -5.0, -5.0, 1.0, -7.0, 7.0, -1.0, -5.0, 5.0));
}
#version 450
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
	highp mat2x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(1.0, 7.0, 8.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-8.0, -9.0, -2.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(-8.0, -8.0, 8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(-5.0, 9.0, -6.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(9.0, -9.0, 3.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(-6.0, 0.0, -2.0, 2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(0.0, -5.0, -8.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-5.0, -5.0, 6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(7.0, 0.0, 2.0, 4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(4.0, 2.0, 6.0, 8.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(-3.0, 7.0, -7.0, -6.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(-1.0, -5.0, 0.0, -2.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(1.0, -6.0, -2.0, -1.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(8.0, 5.0, -3.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(-6.0, -2.0, 1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(4.0, -9.0, 5.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(1.0, 5.0, -6.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(-6.0, -9.0, -2.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(8.0, -6.0, -6.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(-2.0, 3.0, 0.0, -6.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(0.0, 5.0, 8.0, -1.0, 9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(-7.0, -8.0, 7.0));
	var[0][0][0][1] = (vec3(-6.0, -3.0, -4.0));
	var[0][0][1][0] = (vec3(3.0, -8.0, -9.0));
	var[0][0][1][1] = (vec3(-2.0, 5.0, 6.0));
	var[0][1][0][0] = (vec3(-6.0, 3.0, 9.0));
	var[0][1][0][1] = (vec3(3.0, -2.0, -9.0));
	var[0][1][1][0] = (vec3(-7.0, -8.0, -6.0));
	var[0][1][1][1] = (vec3(-7.0, 2.0, -3.0));
	var[0][2][0][0] = (vec3(5.0, 5.0, -4.0));
	var[0][2][0][1] = (vec3(1.0, -9.0, 1.0));
	var[0][2][1][0] = (vec3(3.0, 0.0, -6.0));
	var[0][2][1][1] = (vec3(5.0, -6.0, -6.0));
	var[0][3][0][0] = (vec3(1.0, -4.0, 2.0));
	var[0][3][0][1] = (vec3(0.0, 1.0, -8.0));
	var[0][3][1][0] = (vec3(-3.0, -9.0, 6.0));
	var[0][3][1][1] = (vec3(-3.0, 6.0, 6.0));
	var[1][0][0][0] = (vec3(6.0, -5.0, -7.0));
	var[1][0][0][1] = (vec3(1.0, 1.0, -3.0));
	var[1][0][1][0] = (vec3(9.0, -7.0, 2.0));
	var[1][0][1][1] = (vec3(5.0, -4.0, 6.0));
	var[1][1][0][0] = (vec3(1.0, -1.0, 8.0));
	var[1][1][0][1] = (vec3(7.0, -2.0, -6.0));
	var[1][1][1][0] = (vec3(-1.0, -1.0, -5.0));
	var[1][1][1][1] = (vec3(-1.0, 1.0, -1.0));
	var[1][2][0][0] = (vec3(7.0, 1.0, -9.0));
	var[1][2][0][1] = (vec3(7.0, -8.0, -1.0));
	var[1][2][1][0] = (vec3(5.0, -3.0, 9.0));
	var[1][2][1][1] = (vec3(-6.0, 4.0, -4.0));
	var[1][3][0][0] = (vec3(-6.0, 1.0, 4.0));
	var[1][3][0][1] = (vec3(7.0, 9.0, -9.0));
	var[1][3][1][0] = (vec3(-1.0, -8.0, 8.0));
	var[1][3][1][1] = (vec3(7.0, 1.0, -4.0));
	var[2][0][0][0] = (vec3(-3.0, -8.0, 6.0));
	var[2][0][0][1] = (vec3(8.0, 2.0, 4.0));
	var[2][0][1][0] = (vec3(0.0, 8.0, 0.0));
	var[2][0][1][1] = (vec3(-2.0, 1.0, -3.0));
	var[2][1][0][0] = (vec3(5.0, 5.0, -6.0));
	var[2][1][0][1] = (vec3(6.0, 7.0, -2.0));
	var[2][1][1][0] = (vec3(-5.0, -7.0, -1.0));
	var[2][1][1][1] = (vec3(4.0, -3.0, -7.0));
	var[2][2][0][0] = (vec3(2.0, 5.0, 0.0));
	var[2][2][0][1] = (vec3(1.0, -8.0, 0.0));
	var[2][2][1][0] = (vec3(7.0, -2.0, -7.0));
	var[2][2][1][1] = (vec3(-6.0, -5.0, 3.0));
	var[2][3][0][0] = (vec3(-3.0, 5.0, -5.0));
	var[2][3][0][1] = (vec3(4.0, 1.0, 9.0));
	var[2][3][1][0] = (vec3(3.0, -8.0, 6.0));
	var[2][3][1][1] = (vec3(-7.0, -7.0, -1.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(3.0, -1.0, -8.0, -1.0, -7.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(0.0, -8.0, -7.0, 7.0, 3.0, 7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(-8.0, 9.0, -5.0, -6.0, -1.0, 1.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(8.0, -1.0, -7.0, -7.0, -9.0, -4.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(-7.0, 7.0, -7.0, -4.0, -2.0, -5.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(3.0, -9.0, 6.0, -8.0, 0.0, 5.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(-6.0, -7.0, -8.0, 6.0, -7.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(8.0, -2.0, 9.0, -6.0, 5.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(-2.0, 0.0, 9.0, -8.0, 0.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(9.0, 1.0, 2.0, -6.0, -9.0, -9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(-3.0, -3.0, 0.0, -2.0, -5.0, 8.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(-5.0, -9.0, 3.0, 5.0, 2.0, -2.0, -7.0, 6.0)) && allOk;
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
	var[0][1][0][0] = (vec2(7.0, 3.0));
	var[0][1][0][1] = (vec2(3.0, 3.0));
	var[0][1][0][2] = (vec2(-5.0, -9.0));
	var[0][1][0][3] = (vec2(2.0, 9.0));
	var[0][1][1][0] = (vec2(3.0, 8.0));
	var[0][1][1][1] = (vec2(3.0, -4.0));
	var[0][1][1][2] = (vec2(6.0, 1.0));
	var[0][1][1][3] = (vec2(-3.0, 1.0));
	var[0][2][0][0] = (vec2(1.0, 7.0));
	var[0][2][0][1] = (vec2(0.0, -4.0));
	var[0][2][0][2] = (vec2(-1.0, 5.0));
	var[0][2][0][3] = (vec2(9.0, -8.0));
	var[0][2][1][0] = (vec2(-3.0, 8.0));
	var[0][2][1][1] = (vec2(-1.0, 7.0));
	var[0][2][1][2] = (vec2(5.0, -7.0));
	var[0][2][1][3] = (vec2(8.0, 0.0));
	var[0][3][0][0] = (vec2(7.0, 8.0));
	var[0][3][0][1] = (vec2(2.0, -9.0));
	var[0][3][0][2] = (vec2(-8.0, -9.0));
	var[0][3][0][3] = (vec2(-1.0, -3.0));
	var[0][3][1][0] = (vec2(-2.0, -1.0));
	var[0][3][1][1] = (vec2(1.0, -1.0));
	var[0][3][1][2] = (vec2(-5.0, -6.0));
	var[0][3][1][3] = (vec2(-8.0, 7.0));
	var[1][0][0][0] = (vec2(-8.0, 2.0));
	var[1][0][0][1] = (vec2(-5.0, 5.0));
	var[1][0][0][2] = (vec2(-4.0, -9.0));
	var[1][0][0][3] = (vec2(0.0, 4.0));
	var[1][0][1][0] = (vec2(8.0, 2.0));
	var[1][0][1][1] = (vec2(-3.0, 2.0));
	var[1][0][1][2] = (vec2(-4.0, -4.0));
	var[1][0][1][3] = (vec2(2.0, -8.0));
	var[1][1][0][0] = (vec2(-5.0, -2.0));
	var[1][1][0][1] = (vec2(7.0, 8.0));
	var[1][1][0][2] = (vec2(4.0, 7.0));
	var[1][1][0][3] = (vec2(-1.0, -8.0));
	var[1][1][1][0] = (vec2(-6.0, -6.0));
	var[1][1][1][1] = (vec2(-4.0, -2.0));
	var[1][1][1][2] = (vec2(3.0, 8.0));
	var[1][1][1][3] = (vec2(4.0, 4.0));
	var[1][2][0][0] = (vec2(-5.0, 7.0));
	var[1][2][0][1] = (vec2(8.0, 9.0));
	var[1][2][0][2] = (vec2(8.0, 9.0));
	var[1][2][0][3] = (vec2(1.0, 9.0));
	var[1][2][1][0] = (vec2(-9.0, 8.0));
	var[1][2][1][1] = (vec2(-2.0, 9.0));
	var[1][2][1][2] = (vec2(6.0, 6.0));
	var[1][2][1][3] = (vec2(3.0, -5.0));
	var[1][3][0][0] = (vec2(2.0, 0.0));
	var[1][3][0][1] = (vec2(-7.0, -6.0));
	var[1][3][0][2] = (vec2(6.0, 1.0));
	var[1][3][0][3] = (vec2(8.0, 9.0));
	var[1][3][1][0] = (vec2(9.0, -8.0));
	var[1][3][1][1] = (vec2(-6.0, -7.0));
	var[1][3][1][2] = (vec2(-5.0, 0.0));
	var[1][3][1][3] = (vec2(-3.0, 1.0));
	var[2][0][0][0] = (vec2(-4.0, 8.0));
	var[2][0][0][1] = (vec2(5.0, 7.0));
	var[2][0][0][2] = (vec2(-4.0, 6.0));
	var[2][0][0][3] = (vec2(8.0, 4.0));
	var[2][0][1][0] = (vec2(-9.0, -7.0));
	var[2][0][1][1] = (vec2(7.0, -5.0));
	var[2][0][1][2] = (vec2(1.0, -9.0));
	var[2][0][1][3] = (vec2(9.0, 5.0));
	var[2][1][0][0] = (vec2(-7.0, -6.0));
	var[2][1][0][1] = (vec2(8.0, -6.0));
	var[2][1][0][2] = (vec2(8.0, -3.0));
	var[2][1][0][3] = (vec2(-7.0, 0.0));
	var[2][1][1][0] = (vec2(-9.0, 2.0));
	var[2][1][1][1] = (vec2(-9.0, 7.0));
	var[2][1][1][2] = (vec2(-2.0, 2.0));
	var[2][1][1][3] = (vec2(-6.0, -1.0));
	var[2][2][0][0] = (vec2(1.0, -4.0));
	var[2][2][0][1] = (vec2(-5.0, 7.0));
	var[2][2][0][2] = (vec2(-8.0, 7.0));
	var[2][2][0][3] = (vec2(-1.0, -1.0));
	var[2][2][1][0] = (vec2(-2.0, -7.0));
	var[2][2][1][1] = (vec2(4.0, -8.0));
	var[2][2][1][2] = (vec2(2.0, 4.0));
	var[2][2][1][3] = (vec2(3.0, 1.0));
	var[2][3][0][0] = (vec2(-1.0, -6.0));
	var[2][3][0][1] = (vec2(1.0, 1.0));
	var[2][3][0][2] = (vec2(-7.0, -8.0));
	var[2][3][0][3] = (vec2(-5.0, 5.0));
	var[2][3][1][0] = (vec2(4.0, -9.0));
	var[2][3][1][1] = (vec2(-6.0, -7.0));
	var[2][3][1][2] = (vec2(-8.0, 8.0));
	var[2][3][1][3] = (vec2(-3.0, 6.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	highp mat4x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(6.0, -1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(-5.0, -9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(6.0, -3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(7.0, 8.0, 7.0, 3.0, 8.0, -3.0, -9.0, -6.0, 2.0, 0.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(2.0, -1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(7.0, 1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(4.0, -8.0, 4.0, 1.0, 8.0, -2.0, 5.0, -4.0, -7.0, -4.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(-9.0, 7.0, -5.0, 5.0, -6.0, -9.0, -8.0, 4.0, 1.0, 0.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(2.0, 9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(9.0, 6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(-5.0, 3.0, -9.0, 7.0, -8.0, -8.0, 4.0, -3.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(2.0, -3.0, 2.0, -8.0, 3.0, -8.0, 3.0, 0.0, -9.0, 0.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	var[0][0][1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	var[0][1][0] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	var[0][1][1] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	var[0][2][0] = (mat4x3(-2.0, 7.0, -6.0, -4.0, -2.0, 0.0, 4.0, -2.0, 6.0, -6.0, -5.0, -8.0));
	var[0][2][1] = (mat4x3(-1.0, 2.0, 4.0, 2.0, -2.0, 9.0, 0.0, -4.0, 6.0, -7.0, -4.0, 2.0));
	var[0][3][0] = (mat4x3(2.0, 6.0, 9.0, -5.0, -9.0, -9.0, 5.0, 6.0, 4.0, 6.0, -3.0, 1.0));
	var[0][3][1] = (mat4x3(3.0, -1.0, 9.0, -2.0, 9.0, 6.0, -9.0, 4.0, 3.0, -7.0, -3.0, 3.0));
	var[1][0][0] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	var[1][0][1] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	var[1][1][0] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	var[1][1][1] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	var[1][2][0] = (mat4x3(1.0, 2.0, -9.0, -3.0, 6.0, -9.0, 8.0, 2.0, 1.0, -8.0, 3.0, 2.0));
	var[1][2][1] = (mat4x3(1.0, 4.0, 9.0, -7.0, -5.0, 2.0, -8.0, 0.0, 0.0, -4.0, 9.0, 5.0));
	var[1][3][0] = (mat4x3(-7.0, 9.0, 6.0, -6.0, 1.0, 1.0, -3.0, -1.0, 8.0, -2.0, 3.0, -3.0));
	var[1][3][1] = (mat4x3(-5.0, 4.0, 0.0, -9.0, 9.0, -1.0, 0.0, -9.0, -3.0, 6.0, -2.0, 0.0));
	var[2][0][0] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	var[2][0][1] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	var[2][1][0] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	var[2][1][1] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
	var[2][2][0] = (mat4x3(-2.0, -9.0, 6.0, -9.0, -4.0, -7.0, 9.0, -5.0, 3.0, 5.0, -1.0, -4.0));
	var[2][2][1] = (mat4x3(1.0, -1.0, -8.0, 4.0, 4.0, 4.0, -3.0, 4.0, 0.0, 0.0, -7.0, -1.0));
	var[2][3][0] = (mat4x3(-5.0, -9.0, 2.0, -1.0, 4.0, 0.0, -4.0, 1.0, 3.0, -9.0, -5.0, -6.0));
	var[2][3][1] = (mat4x3(7.0, -4.0, 3.0, 0.0, -2.0, -5.0, -8.0, 3.0, 5.0, -1.0, 3.0, 5.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(5, -4, -3)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(4.0, 9.0, 7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(8.0, 0.0, 8.0, 8.0, -4.0, 8.0, -8.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-2.0, -3.0, -7.0, 4.0, -8.0, 8.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(2.0, 1.0, 6.0, 1.0, 5.0, -8.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(6.0, -3.0, -8.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(9, 7, 8)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-1.0, 2.0, -4.0, -3.0, -8.0, 8.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-5.0, -5.0, 7.0, -5.0, 5.0, -6.0, -7.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(2.0, 1.0, -7.0, 9.0, 0.0, 4.0, -1.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(4.0, -5.0, -9.0, -3.0, -1.0, -2.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-7.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-3, -2, -2)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(0.0, -2.0, 9.0, -7.0, 6.0, 4.0, -2.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-5.0, 1.0, 9.0, 3.0, -3.0, 8.0, -1.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-5.0, 6.0, 5.0, 1.0, -2.0, -5.0, 2.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-8.0, 8.0, -8.0, 9.0, 7.0, 4.0, -5.0, 0.0, 1.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-4.0, -6.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-3, -5, 3));
	block[0].s.b[0][0] = (vec3(-2.0, -9.0, -6.0));
	block[0].s.b[0][1] = (vec3(1.0, -4.0, 0.0));
	block[0].s.b[0][2] = (vec3(4.0, 4.0, -7.0));
	block[0].s.b[1][0] = (vec3(-8.0, -9.0, 6.0));
	block[0].s.b[1][1] = (vec3(4.0, -6.0, 2.0));
	block[0].s.b[1][2] = (vec3(5.0, 5.0, 1.0));
	block[0].s.b[2][0] = (vec3(-1.0, -6.0, -4.0));
	block[0].s.b[2][1] = (vec3(5.0, 0.0, 5.0));
	block[0].s.b[2][2] = (vec3(-3.0, 0.0, 5.0));
	block[0].s.b[3][0] = (vec3(-1.0, 1.0, -7.0));
	block[0].s.b[3][1] = (vec3(-7.0, 8.0, -2.0));
	block[0].s.b[3][2] = (vec3(-9.0, 5.0, 6.0));
	block[0].s.c = (vec4(6.0, -9.0, -4.0, 6.0));
	block[1].s.a = (ivec3(-3, 7, 5));
	block[1].s.b[0][0] = (vec3(-4.0, 7.0, -2.0));
	block[1].s.b[0][1] = (vec3(8.0, 4.0, 8.0));
	block[1].s.b[0][2] = (vec3(-5.0, -8.0, 6.0));
	block[1].s.b[1][0] = (vec3(-5.0, -9.0, -5.0));
	block[1].s.b[1][1] = (vec3(-7.0, 2.0, 0.0));
	block[1].s.b[1][2] = (vec3(0.0, 0.0, 1.0));
	block[1].s.b[2][0] = (vec3(-9.0, 0.0, 7.0));
	block[1].s.b[2][1] = (vec3(9.0, -3.0, 5.0));
	block[1].s.b[2][2] = (vec3(9.0, 5.0, -1.0));
	block[1].s.b[3][0] = (vec3(-7.0, -8.0, 1.0));
	block[1].s.b[3][1] = (vec3(8.0, -7.0, 8.0));
	block[1].s.b[3][2] = (vec3(1.0, 8.0, 0.0));
	block[1].s.c = (vec4(-4.0, -7.0, -3.0, 1.0));
	block[2].s.a = (ivec3(-1, -2, 2));
	block[2].s.b[0][0] = (vec3(2.0, -2.0, 3.0));
	block[2].s.b[0][1] = (vec3(-9.0, 7.0, -7.0));
	block[2].s.b[0][2] = (vec3(-7.0, 7.0, 0.0));
	block[2].s.b[1][0] = (vec3(-2.0, -9.0, -1.0));
	block[2].s.b[1][1] = (vec3(-8.0, 2.0, -1.0));
	block[2].s.b[1][2] = (vec3(7.0, -9.0, 3.0));
	block[2].s.b[2][0] = (vec3(9.0, -1.0, 8.0));
	block[2].s.b[2][1] = (vec3(-5.0, -9.0, 4.0));
	block[2].s.b[2][2] = (vec3(-4.0, 0.0, 8.0));
	block[2].s.b[3][0] = (vec3(9.0, 1.0, -5.0));
	block[2].s.b[3][1] = (vec3(0.0, 0.0, 4.0));
	block[2].s.b[3][2] = (vec3(0.0, 9.0, 6.0));
	block[2].s.c = (vec4(8.0, 8.0, -7.0, 3.0));
}
#version 450
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
	allOk = compare_ivec3((s[0].a), ivec3(-7, 2, -2)) && allOk;
	allOk = compare_mat3(s[0].b[0], mat3(-4.0, -9.0, 4.0, -1.0, -8.0, 8.0, 0.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat3(s[0].b[1], mat3(0.0, -7.0, 7.0, -5.0, 1.0, -5.0, 1.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3(s[0].b[2], mat3(-1.0, 4.0, 1.0, -3.0, 5.0, -5.0, -7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3(s[0].b[3], mat3(-8.0, -4.0, -3.0, 6.0, 1.0, 1.0, 0.0, 6.0, -9.0)) && allOk;
	allOk = compare_vec4((s[0].c), vec4(6.0, 3.0, -2.0, -8.0)) && allOk;
	allOk = compare_ivec3((s[1].a), ivec3(9, 6, 2)) && allOk;
	allOk = compare_mat3(s[1].b[0], mat3(-3.0, 2.0, 5.0, -4.0, -1.0, 9.0, 4.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3(s[1].b[1], mat3(2.0, 4.0, 9.0, -7.0, -5.0, -9.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3(s[1].b[2], mat3(7.0, 0.0, -3.0, -9.0, -8.0, -8.0, 5.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3(s[1].b[3], mat3(3.0, -6.0, 0.0, 0.0, 4.0, -4.0, 9.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((s[1].c), vec4(3.0, -3.0, 8.0, -1.0)) && allOk;
	allOk = compare_ivec3((s[2].a), ivec3(2, -9, -7)) && allOk;
	allOk = compare_mat3(s[2].b[0], mat3(-2.0, 4.0, 5.0, 5.0, -3.0, 9.0, -1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat3(s[2].b[1], mat3(6.0, 1.0, -4.0, 6.0, 4.0, -4.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(s[2].b[2], mat3(-8.0, -2.0, -9.0, 9.0, 9.0, -2.0, 3.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3(s[2].b[3], mat3(-9.0, -6.0, -7.0, 4.0, -1.0, 4.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4((s[2].c), vec4(-3.0, 5.0, -5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s[0].a = (ivec3(8, -7, -9));
	s[0].b[0] = (mat3(-3.0, 7.0, -9.0, 8.0, -2.0, 5.0, 1.0, 6.0, 4.0));
	s[0].b[1] = (mat3(-5.0, -1.0, -2.0, 5.0, 3.0, -3.0, -2.0, -9.0, 9.0));
	s[0].b[2] = (mat3(9.0, -6.0, -5.0, 0.0, 4.0, 6.0, 5.0, -6.0, -8.0));
	s[0].b[3] = (mat3(4.0, -6.0, -1.0, 8.0, -1.0, 6.0, -2.0, 7.0, -9.0));
	s[0].c = (vec4(-6.0, 3.0, 3.0, -5.0));
	s[1].a = (ivec3(5, 2, 9));
	s[1].b[0] = (mat3(-6.0, -6.0, 3.0, -3.0, 8.0, 4.0, -6.0, -1.0, -8.0));
	s[1].b[1] = (mat3(0.0, 9.0, 7.0, -5.0, 9.0, -6.0, -7.0, -7.0, -2.0));
	s[1].b[2] = (mat3(2.0, 3.0, -5.0, -7.0, -2.0, 8.0, -6.0, 3.0, -7.0));
	s[1].b[3] = (mat3(3.0, -6.0, -7.0, -2.0, 2.0, 2.0, -7.0, 6.0, -2.0));
	s[1].c = (vec4(-2.0, 1.0, -9.0, -4.0));
	s[2].a = (ivec3(-9, -9, 0));
	s[2].b[0] = (mat3(5.0, 8.0, -8.0, 8.0, 3.0, 4.0, 6.0, -6.0, 0.0));
	s[2].b[1] = (mat3(1.0, 0.0, -7.0, -5.0, 3.0, 7.0, -8.0, -7.0, 3.0));
	s[2].b[2] = (mat3(9.0, -5.0, -2.0, 2.0, 2.0, 3.0, -6.0, -5.0, -7.0));
	s[2].b[3] = (mat3(-7.0, -4.0, 2.0, -6.0, -9.0, -3.0, -7.0, -8.0, -5.0));
	s[2].c = (vec4(-8.0, 1.0, -1.0, -7.0));
	v = (vec4(8.0, -5.0, 4.0, -7.0));
}
#version 450
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
	allOk = compare_mat3(block[0].t[0].a, mat3(4.0, -8.0, -3.0, 3.0, -9.0, -1.0, 3.0, 8.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(-4, -1, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(0, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(-7, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(-9, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(-2, 7)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(2.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(5, 0, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(-6, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(1, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(-1, -5)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-7.0, -1.0, 9.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(1, -1, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(-3, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(0, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(3, 8)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-1.0, -3.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(-6.0, 9.0, 6.0, 2.0, -9.0, 6.0, -1.0, -7.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(-6, 3, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(5, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(9, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(-4, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(-9, -2)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(9.0, 2.0, -2.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(-8, 2, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(6, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(2, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(-4, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(7, -4)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(8.0, 9.0, 1.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(3, 3, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(0, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(3, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(9, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(-1, -4)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(0.0, -4.0, 0.0, 7.0)) && allOk;
	allOk = compare_uint((block[0].u), 6u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(-4.0, 2.0, 6.0, 7.0, 4.0, -5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(-2, -2, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(4, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(0, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(4, -1)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(1.0, 7.0, 6.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(-9, 8, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(9, -5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(0, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(3, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(-4, 5)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(9.0, -1.0, 0.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(-7, -1, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(6, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(-5, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(-4, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(0, 3)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(1.0, 1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(-9.0, -2.0, 5.0, 5.0, 5.0, -5.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(6, -2, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(-3, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(0, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(-1, 9)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(-8.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(-1, 8, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(9, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(-7, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(-4, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(0, 6)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(-1.0, 1.0, 5.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(3, -3, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(3, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(-9, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(-1, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(2, 9)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(8.0, -3.0, 8.0, -1.0)) && allOk;
	allOk = compare_uint((block[1].u), 6u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(1.0, -3.0, 9.0, 0.0, -8.0, -8.0, -9.0, 3.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(-2, -3, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(-3, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(0, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(6, 0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(4.0, 9.0, 5.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(-8, 2, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(-1, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(1, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-7, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(2, 5)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(8.0, -2.0, 3.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(-6, 7, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(2, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(2, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(-6, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(8, 8)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(7.0, -1.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(-9.0, 4.0, 4.0, -4.0, -5.0, 4.0, 9.0, 1.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(-4, 0, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(-2, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(2, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(-5, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(8, 9)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(2.0, 1.0, 7.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(6, -1, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(9, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(0, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(-7, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(3, 2)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(4.0, 5.0, -1.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(-3, 1, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(7, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(1, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(-3, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(-3, 7)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(2.0, -5.0, 4.0, -9.0)) && allOk;
	allOk = compare_uint((block[2].u), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-4, -7, -8));
	block[0].s.b[0] = (ivec2(3, 7));
	block[0].s.b[1] = (ivec2(5, 6));
	block[0].s.b[2] = (ivec2(5, 4));
	block[0].s.b[3] = (ivec2(6, -7));
	block[0].s.c = (vec4(9.0, 0.0, 5.0, 7.0));
	block[0].u = (4u);
	block[1].s.a = (ivec3(6, 2, 0));
	block[1].s.b[0] = (ivec2(8, 3));
	block[1].s.b[1] = (ivec2(0, 3));
	block[1].s.b[2] = (ivec2(-6, 5));
	block[1].s.b[3] = (ivec2(3, -6));
	block[1].s.c = (vec4(-4.0, -7.0, -1.0, 4.0));
	block[1].u = (3u);
	block[2].s.a = (ivec3(7, 7, 6));
	block[2].s.b[0] = (ivec2(9, 6));
	block[2].s.b[1] = (ivec2(-3, -8));
	block[2].s.b[2] = (ivec2(2, 5));
	block[2].s.b[3] = (ivec2(-5, -6));
	block[2].s.c = (vec4(1.0, 4.0, -1.0, -8.0));
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
	mediump ivec2 b[4];
	highp vec4 c;
};
struct T
{
	mediump mat3 a;
	S b[3];
};
layout(std430, binding = 1) buffer Block
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
	allOk = compare_mat3(block[0].t[0].a, mat3(5.0, 0.0, -7.0, 3.0, 0.0, -2.0, 3.0, 5.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(-3, 5, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(-6, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(5, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(-8, -8)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(5.0, -5.0, 8.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(-3, -9, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(7, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(-9, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(9, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(-1, 2)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-9.0, 1.0, 2.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(-1, -3, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(5, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(-4, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(8, -6)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(0.0, -6.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(-2.0, -1.0, 5.0, -4.0, -8.0, 1.0, 5.0, 3.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(9, -1, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(8, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(2, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(8, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(-7, -4)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(4.0, -2.0, -7.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(0, 0, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(-7, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(-2, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(-2, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(-9, -3)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(3.0, -4.0, -5.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(0, 3, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(3, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(-9, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(-9, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(8, -4)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-3.0, -6.0, 8.0, -2.0)) && allOk;
	allOk = compare_uint((block[0].u), 8u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(5.0, -5.0, 5.0, -3.0, -2.0, -9.0, 9.0, -1.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(9, -4, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(3, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(5, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(-3, -3)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(5.0, 0.0, 7.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(7, -7, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(-2, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(-7, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(-2, -9)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-9.0, -4.0, -5.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(-6, 1, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(-4, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(-7, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(-1, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(8, -8)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(2.0, -3.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(3.0, -3.0, 9.0, 6.0, -7.0, 0.0, 2.0, 5.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(0, -1, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(5, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(1, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(-5, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(4, -7)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(0.0, -1.0, 2.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(-6, -4, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(-5, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(1, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(6, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(9, 8)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(5.0, 6.0, 2.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(9, 3, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(-7, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(-4, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(-1, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(0, -8)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(-3.0, 9.0, -7.0, -7.0)) && allOk;
	allOk = compare_uint((block[1].u), 6u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(3.0, -4.0, -8.0, -6.0, -6.0, 5.0, 8.0, 4.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(7, 1, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(3, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(-2, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(0, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(7, -8)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-6.0, -3.0, 8.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(-6, 6, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(-9, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(1, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-9, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(-7, -1)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(5.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(1, -9, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(6, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(-5, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(9, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(1, -9)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(0.0, -8.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(-5.0, 4.0, -2.0, 1.0, -1.0, 6.0, 2.0, -7.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(-2, -2, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(5, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(-8, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(-6, -6)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(5.0, -6.0, -8.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(0, 9, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(7, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(8, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(-4, -6)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(-9.0, 8.0, -8.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(7, 3, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(2, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(5, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(3, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(-5, 4)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(-7.0, -9.0, -3.0, 1.0)) && allOk;
	allOk = compare_uint((block[2].u), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-3, -4, 7));
	block[0].s.b[0] = (ivec2(5, 3));
	block[0].s.b[1] = (ivec2(-9, -1));
	block[0].s.b[2] = (ivec2(5, 9));
	block[0].s.b[3] = (ivec2(-5, 5));
	block[0].s.c = (vec4(7.0, -1.0, -8.0, -6.0));
	block[0].u = (8u);
	block[1].s.a = (ivec3(4, -6, -4));
	block[1].s.b[0] = (ivec2(9, 1));
	block[1].s.b[1] = (ivec2(0, 7));
	block[1].s.b[2] = (ivec2(-2, 1));
	block[1].s.b[3] = (ivec2(-6, 2));
	block[1].s.c = (vec4(6.0, -8.0, 4.0, -9.0));
	block[1].u = (9u);
	block[2].s.a = (ivec3(-6, 1, -8));
	block[2].s.b[0] = (ivec2(-2, -7));
	block[2].s.b[1] = (ivec2(5, 6));
	block[2].s.b[2] = (ivec2(-6, 5));
	block[2].s.b[3] = (ivec2(-1, 7));
	block[2].s.c = (vec4(-4.0, 4.0, 9.0, 8.0));
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
	allOk = compare_uvec2((s[0].a), uvec2(3u, 0u)) && allOk;
	allOk = compare_mat2x4(s[0].b[0], mat2x4(8.0, -2.0, 4.0, 8.0, -7.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[1], mat2x4(-9.0, 2.0, -8.0, 9.0, 0.0, 9.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[2], mat2x4(1.0, 7.0, 6.0, -9.0, 1.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[3], mat2x4(-2.0, -1.0, 8.0, -9.0, 2.0, -2.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec3((s[0].c), vec3(9.0, 6.0, -9.0)) && allOk;
	allOk = compare_uvec2((s[1].a), uvec2(4u, 2u)) && allOk;
	allOk = compare_mat2x4(s[1].b[0], mat2x4(-3.0, -2.0, 6.0, 9.0, 6.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[1], mat2x4(-6.0, -4.0, -9.0, -8.0, -4.0, -8.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[2], mat2x4(-1.0, 7.0, -9.0, -8.0, -4.0, -5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[3], mat2x4(5.0, -9.0, -8.0, 2.0, 3.0, 4.0, -4.0, 2.0)) && allOk;
	allOk = compare_vec3((s[1].c), vec3(3.0, 9.0, 7.0)) && allOk;
	allOk = compare_uvec2((s[2].a), uvec2(5u, 8u)) && allOk;
	allOk = compare_mat2x4(s[2].b[0], mat2x4(-6.0, 3.0, -8.0, 4.0, 5.0, 6.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[1], mat2x4(-9.0, -4.0, -9.0, -8.0, -2.0, -8.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[2], mat2x4(-5.0, 7.0, 2.0, -5.0, 3.0, -9.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[3], mat2x4(9.0, -7.0, 5.0, -9.0, -6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_vec3((s[2].c), vec3(-7.0, 8.0, 6.0)) && allOk;
	allOk = compare_uvec2((s[3].a), uvec2(8u, 4u)) && allOk;
	allOk = compare_mat2x4(s[3].b[0], mat2x4(-9.0, 6.0, 5.0, -9.0, -3.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[1], mat2x4(6.0, 6.0, 2.0, -2.0, -7.0, -6.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[2], mat2x4(3.0, -6.0, 3.0, -2.0, 2.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[3], mat2x4(-7.0, 8.0, -8.0, -2.0, 5.0, -8.0, -1.0, -9.0)) && allOk;
	allOk = compare_vec3((s[3].c), vec3(-9.0, -6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (9u);
	s[0].a = (uvec2(9u, 2u));
	s[0].b[0] = (mat2x4(-6.0, -4.0, 3.0, -6.0, -4.0, -4.0, -3.0, -6.0));
	s[0].b[1] = (mat2x4(0.0, -2.0, -1.0, -2.0, -2.0, -8.0, 7.0, -6.0));
	s[0].b[2] = (mat2x4(9.0, -2.0, -5.0, 7.0, -9.0, -9.0, 8.0, 1.0));
	s[0].b[3] = (mat2x4(9.0, -5.0, -4.0, 1.0, -6.0, 7.0, 8.0, -2.0));
	s[0].c = (vec3(7.0, -8.0, -3.0));
	s[1].a = (uvec2(1u, 6u));
	s[1].b[0] = (mat2x4(0.0, 7.0, 6.0, -5.0, 3.0, -7.0, 0.0, -5.0));
	s[1].b[1] = (mat2x4(0.0, 7.0, 8.0, 4.0, 8.0, 8.0, -5.0, 2.0));
	s[1].b[2] = (mat2x4(-2.0, 7.0, 2.0, -2.0, 0.0, -8.0, 5.0, 3.0));
	s[1].b[3] = (mat2x4(-5.0, 1.0, -7.0, -3.0, 2.0, -6.0, -6.0, -5.0));
	s[1].c = (vec3(-8.0, 2.0, -8.0));
	s[2].a = (uvec2(0u, 9u));
	s[2].b[0] = (mat2x4(-6.0, 9.0, -8.0, -1.0, 8.0, 1.0, -1.0, -9.0));
	s[2].b[1] = (mat2x4(-6.0, -8.0, -7.0, -3.0, 1.0, -4.0, 3.0, 5.0));
	s[2].b[2] = (mat2x4(7.0, -1.0, 7.0, 1.0, -2.0, 8.0, 5.0, 5.0));
	s[2].b[3] = (mat2x4(-4.0, 3.0, -2.0, -3.0, -3.0, -3.0, 7.0, 8.0));
	s[2].c = (vec3(-5.0, -4.0, -8.0));
	s[3].a = (uvec2(7u, 9u));
	s[3].b[0] = (mat2x4(-5.0, -3.0, 5.0, 6.0, 1.0, -7.0, -8.0, 6.0));
	s[3].b[1] = (mat2x4(-4.0, 0.0, -8.0, 7.0, -3.0, 1.0, 6.0, 9.0));
	s[3].b[2] = (mat2x4(-7.0, 0.0, 1.0, 5.0, -4.0, 7.0, 5.0, 5.0));
	s[3].b[3] = (mat2x4(-3.0, -4.0, -4.0, -4.0, 5.0, 3.0, -6.0, -5.0));
	s[3].c = (vec3(-2.0, 2.0, 8.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -9.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(2.0, 5.0, 1.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(7.0, -5.0, -9.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 2.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(3.0, 6.0, -3.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(8.0, 9.0, 2.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 2.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-5.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-5.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(1.0, -1.0, 1.0));
	block[0].var[1] = (vec3(-3.0, 9.0, -8.0));
	block[1].var[0] = (vec3(-5.0, 6.0, 6.0));
	block[1].var[1] = (vec3(3.0, -3.0, 7.0));
	block[2].var[0] = (vec3(-9.0, -2.0, -7.0));
	block[2].var[1] = (vec3(7.0, 0.0, -8.0));
}
#version 450
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
	allOk = compare_mat2x4(block[0].var, mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	block[1].var = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	block[2].var = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
}
#version 450
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
	highp mat4x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 1.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-5.0, -2.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-4.0, 7.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-9.0, -9.0)) && allOk;
	allOk = compare_vec2(block[0].var[3], vec2(-9.0, 1.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -2.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -5.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-5.0, -9.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(-2.0, -2.0)) && allOk;
	allOk = compare_vec2(block[1].var[3], vec2(2.0, -5.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 0.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -9.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-3.0, -8.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-8.0, 1.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(3.0, 0.0)) && allOk;
	allOk = compare_vec2(block[2].var[3], vec2(-3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	block[1].var = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	block[2].var = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
}
#version 450
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
	u8vec4 var;
} block[3];

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

layout(std140, binding = 1) buffer BlockB
{
	mediump ivec3 a[1];
	highp uvec2 b;
	mediump float c;
	highp vec2 d;
	bvec2 e;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	bool f;
	mediump uvec3 g;
	bvec2 h;
	highp ivec3 i;
	highp float j;
};
layout(std430, binding = 3) buffer BlockD
{
	bvec2 k;
	highp float l;
	lowp vec4 m;
	mediump uvec3 n;
	lowp uint o;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a[0]), ivec3(6, 8, 8)) && allOk;
	allOk = compare_float((blockB.c), -5.0) && allOk;
	allOk = compare_vec2((blockB.d), vec2(9.0, -4.0)) && allOk;
	allOk = compare_uvec3((g), uvec3(3u, 8u, 2u)) && allOk;
	allOk = compare_ivec3((i), ivec3(8, 3, 0)) && allOk;
	allOk = compare_bvec2((k), bvec2(false, true)) && allOk;
	allOk = compare_uvec3((n), uvec3(8u, 6u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec2(6u, 8u));
	blockB.c = (6.0);
	blockB.d = (vec2(-6.0, 3.0));
	h = (bvec2(false, true));
	j = (-7.0);
	l = (2.0);
	m = (vec4(-9.0, 0.0, 4.0, 3.0));
	n = (uvec3(4u, 0u, 5u));
	o = (5u);
}
#version 450
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
	highp vec3 a;
} blockB;
layout(std140, binding = 2) readonly buffer BlockC
{
	lowp vec2 b[1];
	lowp ivec3 c;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockC.b[0]), vec2(2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(5.0, -5.0, 3.0));
}
#version 450
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
	mediump ivec2 a[1];
};
layout(std430, binding = 2) buffer BlockC
{
	highp uint b[1];
	lowp uvec3 c;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	lowp ivec2 d[1];
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	bvec2 e;
	bvec3 f;
	lowp vec3 g;
	highp uvec2 h;
	bvec4 i[1];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockC.b[0]), 3u) && allOk;
	allOk = compare_uvec3((blockC.c), uvec3(0u, 8u, 2u)) && allOk;
	allOk = compare_bvec2((blockE.e), bvec2(false, true)) && allOk;
	allOk = compare_bvec3((blockE.f), bvec3(false, false, true)) && allOk;
	allOk = compare_uvec2((blockE.h), uvec2(9u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (ivec2(5, 7));
	blockC.c = (uvec3(4u, 5u, 7u));
	blockD.d[0] = (ivec2(-1, -3));
	blockE.e = (bvec2(false, false));
	blockE.f = (bvec3(true, false, false));
	blockE.g = (vec3(4.0, 9.0, 1.0));
	blockE.h = (uvec2(2u, 9u));
	blockE.i[0] = (bvec4(false, false, true, false));
}
#version 450
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
	lowp ivec4 b;
	highp uvec4 c;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	mediump mat3x4 d;
	highp mat3 e;
	highp ivec2 f;
	lowp float g;
} blockC;
layout(std140, binding = 3) readonly buffer BlockD
{
	bool h;
	mediump mat3x4 i;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -2.0) && allOk;
	allOk = compare_mat3x4(blockC.d, mat3x4(-2.0, -3.0, 6.0, -6.0, 9.0, -2.0, 5.0, -6.0, -3.0, 0.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3(blockC.e, mat3(2.0, 4.0, 8.0, 8.0, 0.0, 1.0, 4.0, -9.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockC.f), ivec2(7, 2)) && allOk;
	allOk = compare_float((blockC.g), -8.0) && allOk;
	allOk = compare_bool((h), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-7.0);
	blockB.b = (ivec4(3, -9, -7, -4));
	blockC.d = (mat3x4(3.0, -7.0, -4.0, 0.0, -7.0, -9.0, -8.0, -4.0, -7.0, 2.0, -5.0, -9.0));
	blockC.e = (mat3(9.0, -1.0, 9.0, 4.0, 1.0, -8.0, -2.0, -5.0, -9.0));
	blockC.f = (ivec2(-7, 0));
}
#version 450
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
	mediump mat3 a;
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	mediump ivec3 b;
	bool c[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	lowp uint d;
	lowp mat2x3 e;
	lowp int f;
	mediump mat3 g;
	bool h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((c[0]), true) && allOk;
	allOk = compare_uint((d), 2u) && allOk;
	allOk = compare_int((f), 1) && allOk;
	allOk = compare_mat3(g, mat3(6.0, 7.0, -7.0, -5.0, -5.0, 0.0, 2.0, 4.0, -9.0)) && allOk;
	allOk = compare_bool((h[0]), false) && allOk;
	allOk = compare_bool((h[1]), false) && allOk;
	allOk = compare_bool((h[2]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	c[0] = (true);
	d = (4u);
	e = (mat2x3(3.0, -7.0, 3.0, 2.0, 1.0, 2.0));
	g = (mat3(4.0, -1.0, 4.0, 9.0, 3.0, 1.0, -8.0, -1.0, -8.0));
	h[0] = (false);
	h[1] = (false);
	h[2] = (false);
}
#version 450
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
	highp ivec2 mA;
	highp vec4 mB;
	lowp ivec4 mC;
	lowp float mD[4];
};
struct sB
{
	sA mA;
	mediump mat3 mB;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	mediump uvec4 a;
	mediump mat4x3 b;
	highp mat3x2 c[3];
	highp vec4 d[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	bvec3 e;
	bool f;
	sB g[];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(3u, 0u, 3u, 0u)) && allOk;
	allOk = compare_vec4((blockB.d[0]), vec4(3.0, -5.0, -3.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB.d[1]), vec4(-2.0, -4.0, 4.0, -6.0)) && allOk;
	allOk = compare_vec4((blockB.d[2]), vec4(-3.0, 5.0, -2.0, 4.0)) && allOk;
	allOk = compare_bvec3((blockC[0].e), bvec3(false, true, false)) && allOk;
	allOk = compare_bool((blockC[0].f), false) && allOk;
	allOk = compare_ivec2((blockC[0].g[0].mA.mA), ivec2(-3, 0)) && allOk;
	allOk = compare_vec4((blockC[0].g[0].mA.mB), vec4(-1.0, 2.0, 7.0, 8.0)) && allOk;
	allOk = compare_ivec4((blockC[0].g[0].mA.mC), ivec4(-4, -7, -3, 0)) && allOk;
	allOk = compare_float((blockC[0].g[0].mA.mD[0]), -4.0) && allOk;
	allOk = compare_float((blockC[0].g[0].mA.mD[1]), 0.0) && allOk;
	allOk = compare_float((blockC[0].g[0].mA.mD[2]), 7.0) && allOk;
	allOk = compare_float((blockC[0].g[0].mA.mD[3]), -6.0) && allOk;
	allOk = compare_mat3(blockC[0].g[0].mB, mat3(-2.0, 5.0, 5.0, -2.0, 5.0, 8.0, -4.0, -6.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockC[0].g[1].mA.mA), ivec2(-9, 9)) && allOk;
	allOk = compare_vec4((blockC[0].g[1].mA.mB), vec4(6.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_ivec4((blockC[0].g[1].mA.mC), ivec4(-3, 2, 2, -3)) && allOk;
	allOk = compare_float((blockC[0].g[1].mA.mD[0]), -9.0) && allOk;
	allOk = compare_float((blockC[0].g[1].mA.mD[1]), 5.0) && allOk;
	allOk = compare_float((blockC[0].g[1].mA.mD[2]), -7.0) && allOk;
	allOk = compare_float((blockC[0].g[1].mA.mD[3]), 4.0) && allOk;
	allOk = compare_mat3(blockC[0].g[1].mB, mat3(-3.0, -4.0, -2.0, -5.0, 1.0, 8.0, -7.0, -9.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockC[0].g[2].mA.mA), ivec2(8, -5)) && allOk;
	allOk = compare_vec4((blockC[0].g[2].mA.mB), vec4(-3.0, 7.0, 5.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockC[0].g[2].mA.mC), ivec4(-6, 1, 4, 9)) && allOk;
	allOk = compare_float((blockC[0].g[2].mA.mD[0]), -9.0) && allOk;
	allOk = compare_float((blockC[0].g[2].mA.mD[1]), -4.0) && allOk;
	allOk = compare_float((blockC[0].g[2].mA.mD[2]), -2.0) && allOk;
	allOk = compare_float((blockC[0].g[2].mA.mD[3]), 2.0) && allOk;
	allOk = compare_mat3(blockC[0].g[2].mB, mat3(-2.0, -6.0, 3.0, 7.0, 3.0, -7.0, -5.0, 3.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockC[0].g[3].mA.mA), ivec2(8, -4)) && allOk;
	allOk = compare_vec4((blockC[0].g[3].mA.mB), vec4(4.0, -8.0, -1.0, 2.0)) && allOk;
	allOk = compare_ivec4((blockC[0].g[3].mA.mC), ivec4(-7, 4, 6, 5)) && allOk;
	allOk = compare_float((blockC[0].g[3].mA.mD[0]), 2.0) && allOk;
	allOk = compare_float((blockC[0].g[3].mA.mD[1]), 9.0) && allOk;
	allOk = compare_float((blockC[0].g[3].mA.mD[2]), -6.0) && allOk;
	allOk = compare_float((blockC[0].g[3].mA.mD[3]), 8.0) && allOk;
	allOk = compare_mat3(blockC[0].g[3].mB, mat3(7.0, -2.0, 7.0, -8.0, -3.0, 9.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_ivec2((blockC[0].g[4].mA.mA), ivec2(-9, 6)) && allOk;
	allOk = compare_vec4((blockC[0].g[4].mA.mB), vec4(-5.0, 6.0, 2.0, -7.0)) && allOk;
	allOk = compare_ivec4((blockC[0].g[4].mA.mC), ivec4(7, -4, 9, -3)) && allOk;
	allOk = compare_float((blockC[0].g[4].mA.mD[0]), -3.0) && allOk;
	allOk = compare_float((blockC[0].g[4].mA.mD[1]), 7.0) && allOk;
	allOk = compare_float((blockC[0].g[4].mA.mD[2]), 9.0) && allOk;
	allOk = compare_float((blockC[0].g[4].mA.mD[3]), -4.0) && allOk;
	allOk = compare_mat3(blockC[0].g[4].mB, mat3(-9.0, -9.0, 5.0, 5.0, -7.0, 5.0, 2.0, -5.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockC[0].g[5].mA.mA), ivec2(6, 8)) && allOk;
	allOk = compare_vec4((blockC[0].g[5].mA.mB), vec4(-6.0, 2.0, 7.0, -8.0)) && allOk;
	allOk = compare_ivec4((blockC[0].g[5].mA.mC), ivec4(-4, -3, -6, 7)) && allOk;
	allOk = compare_float((blockC[0].g[5].mA.mD[0]), 6.0) && allOk;
	allOk = compare_float((blockC[0].g[5].mA.mD[1]), -7.0) && allOk;
	allOk = compare_float((blockC[0].g[5].mA.mD[2]), 0.0) && allOk;
	allOk = compare_float((blockC[0].g[5].mA.mD[3]), -8.0) && allOk;
	allOk = compare_mat3(blockC[0].g[5].mB, mat3(-9.0, 8.0, 0.0, -5.0, 7.0, 6.0, -2.0, 4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(7u, 9u, 4u, 8u));
	blockB.b = (mat4x3(-3.0, -9.0, 9.0, -5.0, 2.0, -5.0, -8.0, 6.0, 9.0, 3.0, 1.0, -3.0));
	blockC[0].g[0].mA.mA = (ivec2(2, -9));
	blockC[0].g[0].mA.mB = (vec4(3.0, 7.0, -2.0, -7.0));
	blockC[0].g[0].mA.mC = (ivec4(-1, 4, -7, 7));
	blockC[0].g[0].mA.mD[0] = (3.0);
	blockC[0].g[0].mA.mD[1] = (4.0);
	blockC[0].g[0].mA.mD[2] = (8.0);
	blockC[0].g[0].mA.mD[3] = (-6.0);
	blockC[0].g[0].mB = (mat3(-2.0, 0.0, 6.0, 2.0, -8.0, -6.0, 1.0, -6.0, 3.0));
	blockC[0].g[1].mA.mA = (ivec2(-2, -7));
	blockC[0].g[1].mA.mB = (vec4(-7.0, -5.0, 3.0, 8.0));
	blockC[0].g[1].mA.mC = (ivec4(8, -3, 5, -2));
	blockC[0].g[1].mA.mD[0] = (-3.0);
	blockC[0].g[1].mA.mD[1] = (6.0);
	blockC[0].g[1].mA.mD[2] = (8.0);
	blockC[0].g[1].mA.mD[3] = (-8.0);
	blockC[0].g[1].mB = (mat3(-6.0, -1.0, 2.0, -2.0, 0.0, 5.0, 9.0, 2.0, -7.0));
	blockC[0].g[2].mA.mA = (ivec2(8, 8));
	blockC[0].g[2].mA.mB = (vec4(6.0, -1.0, -8.0, -7.0));
	blockC[0].g[2].mA.mC = (ivec4(6, 7, -8, -1));
	blockC[0].g[2].mA.mD[0] = (-6.0);
	blockC[0].g[2].mA.mD[1] = (-3.0);
	blockC[0].g[2].mA.mD[2] = (2.0);
	blockC[0].g[2].mA.mD[3] = (-3.0);
	blockC[0].g[2].mB = (mat3(6.0, 9.0, 3.0, 1.0, -3.0, -1.0, 7.0, -5.0, 7.0));
	blockC[0].g[3].mA.mA = (ivec2(8, 7));
	blockC[0].g[3].mA.mB = (vec4(3.0, 8.0, 1.0, 4.0));
	blockC[0].g[3].mA.mC = (ivec4(4, 4, -2, 3));
	blockC[0].g[3].mA.mD[0] = (-5.0);
	blockC[0].g[3].mA.mD[1] = (-2.0);
	blockC[0].g[3].mA.mD[2] = (9.0);
	blockC[0].g[3].mA.mD[3] = (5.0);
	blockC[0].g[3].mB = (mat3(9.0, 8.0, -6.0, -9.0, -2.0, -5.0, 7.0, 3.0, 1.0));
	blockC[0].g[4].mA.mA = (ivec2(9, -6));
	blockC[0].g[4].mA.mB = (vec4(-7.0, -3.0, 7.0, 0.0));
	blockC[0].g[4].mA.mC = (ivec4(-2, -4, 1, -1));
	blockC[0].g[4].mA.mD[0] = (5.0);
	blockC[0].g[4].mA.mD[1] = (3.0);
	blockC[0].g[4].mA.mD[2] = (6.0);
	blockC[0].g[4].mA.mD[3] = (-4.0);
	blockC[0].g[4].mB = (mat3(-9.0, -8.0, -2.0, 9.0, 1.0, 4.0, 4.0, 6.0, 4.0));
	blockC[0].g[5].mA.mA = (ivec2(-3, -1));
	blockC[0].g[5].mA.mB = (vec4(-9.0, 0.0, -8.0, 2.0));
	blockC[0].g[5].mA.mC = (ivec4(-6, -4, 9, -2));
	blockC[0].g[5].mA.mD[0] = (-9.0);
	blockC[0].g[5].mA.mD[1] = (1.0);
	blockC[0].g[5].mA.mD[2] = (3.0);
	blockC[0].g[5].mA.mD[3] = (-8.0);
	blockC[0].g[5].mB = (mat3(-7.0, -8.0, 0.0, 9.0, -4.0, 6.0, 1.0, -7.0, 2.0));
}
#version 450
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
	highp ivec4 mB;
};
struct sB
{
	mediump uvec4 mA;
	mediump uint mB;
	highp vec4 mC;
	lowp int mD[2];
};
struct sC
{
	highp ivec3 mA[5];
	lowp vec2 mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	sA a;
	sB b;
	sC c[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a.mA, mat3x2(7.0, 4.0, 2.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockB.a.mB), ivec4(5, -4, 9, 0)) && allOk;
	allOk = compare_ivec3((blockB.c[0].mA[0]), ivec3(-4, 2, -5)) && allOk;
	allOk = compare_ivec3((blockB.c[0].mA[1]), ivec3(-3, -4, 3)) && allOk;
	allOk = compare_ivec3((blockB.c[0].mA[2]), ivec3(-7, 1, -4)) && allOk;
	allOk = compare_ivec3((blockB.c[0].mA[3]), ivec3(-3, 5, 3)) && allOk;
	allOk = compare_ivec3((blockB.c[0].mA[4]), ivec3(0, 3, 1)) && allOk;
	allOk = compare_vec2((blockB.c[0].mB), vec2(-3.0, -2.0)) && allOk;
	allOk = compare_ivec3((blockB.c[1].mA[0]), ivec3(7, -8, -9)) && allOk;
	allOk = compare_ivec3((blockB.c[1].mA[1]), ivec3(-5, 8, -2)) && allOk;
	allOk = compare_ivec3((blockB.c[1].mA[2]), ivec3(-9, -8, 7)) && allOk;
	allOk = compare_ivec3((blockB.c[1].mA[3]), ivec3(-4, -9, -8)) && allOk;
	allOk = compare_ivec3((blockB.c[1].mA[4]), ivec3(0, -4, 5)) && allOk;
	allOk = compare_vec2((blockB.c[1].mB), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_ivec3((blockB.c[2].mA[0]), ivec3(-4, 6, 5)) && allOk;
	allOk = compare_ivec3((blockB.c[2].mA[1]), ivec3(-5, -4, 5)) && allOk;
	allOk = compare_ivec3((blockB.c[2].mA[2]), ivec3(-6, -7, -1)) && allOk;
	allOk = compare_ivec3((blockB.c[2].mA[3]), ivec3(4, 8, -3)) && allOk;
	allOk = compare_ivec3((blockB.c[2].mA[4]), ivec3(-5, -8, 3)) && allOk;
	allOk = compare_vec2((blockB.c[2].mB), vec2(8.0, 1.0)) && allOk;
	allOk = compare_ivec3((blockB.c[3].mA[0]), ivec3(3, 5, 3)) && allOk;
	allOk = compare_ivec3((blockB.c[3].mA[1]), ivec3(-8, 9, 9)) && allOk;
	allOk = compare_ivec3((blockB.c[3].mA[2]), ivec3(0, -9, 0)) && allOk;
	allOk = compare_ivec3((blockB.c[3].mA[3]), ivec3(-2, -6, 1)) && allOk;
	allOk = compare_ivec3((blockB.c[3].mA[4]), ivec3(-3, -8, -1)) && allOk;
	allOk = compare_vec2((blockB.c[3].mB), vec2(5.0, -1.0)) && allOk;
	allOk = compare_ivec3((blockB.c[4].mA[0]), ivec3(-1, 9, 6)) && allOk;
	allOk = compare_ivec3((blockB.c[4].mA[1]), ivec3(-4, 6, -1)) && allOk;
	allOk = compare_ivec3((blockB.c[4].mA[2]), ivec3(2, 9, 8)) && allOk;
	allOk = compare_ivec3((blockB.c[4].mA[3]), ivec3(-1, 6, 8)) && allOk;
	allOk = compare_ivec3((blockB.c[4].mA[4]), ivec3(-2, 9, -9)) && allOk;
	allOk = compare_vec2((blockB.c[4].mB), vec2(6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b.mA = (uvec4(1u, 0u, 2u, 7u));
	blockB.b.mB = (4u);
	blockB.b.mC = (vec4(4.0, 5.0, 8.0, 2.0));
	blockB.b.mD[0] = (-6);
	blockB.b.mD[1] = (4);
	blockB.c[0].mA[0] = (ivec3(-5, -5, -9));
	blockB.c[0].mA[1] = (ivec3(-7, 7, -8));
	blockB.c[0].mA[2] = (ivec3(8, -9, 1));
	blockB.c[0].mA[3] = (ivec3(1, 7, 4));
	blockB.c[0].mA[4] = (ivec3(5, 4, 8));
	blockB.c[0].mB = (vec2(1.0, -4.0));
	blockB.c[1].mA[0] = (ivec3(-7, 0, 5));
	blockB.c[1].mA[1] = (ivec3(7, -8, -8));
	blockB.c[1].mA[2] = (ivec3(1, 1, 2));
	blockB.c[1].mA[3] = (ivec3(-5, -9, 6));
	blockB.c[1].mA[4] = (ivec3(-9, 0, 1));
	blockB.c[1].mB = (vec2(4.0, -3.0));
	blockB.c[2].mA[0] = (ivec3(-7, -8, 4));
	blockB.c[2].mA[1] = (ivec3(2, -4, -3));
	blockB.c[2].mA[2] = (ivec3(-5, -5, -2));
	blockB.c[2].mA[3] = (ivec3(-6, 5, -5));
	blockB.c[2].mA[4] = (ivec3(-9, -8, 2));
	blockB.c[2].mB = (vec2(-9.0, -3.0));
	blockB.c[3].mA[0] = (ivec3(-9, 9, -4));
	blockB.c[3].mA[1] = (ivec3(-1, -8, -4));
	blockB.c[3].mA[2] = (ivec3(-5, 0, 3));
	blockB.c[3].mA[3] = (ivec3(4, -4, 7));
	blockB.c[3].mA[4] = (ivec3(-6, 6, -2));
	blockB.c[3].mB = (vec2(0.0, -7.0));
	blockB.c[4].mA[0] = (ivec3(0, 4, 5));
	blockB.c[4].mA[1] = (ivec3(7, -5, -1));
	blockB.c[4].mA[2] = (ivec3(-2, 6, 7));
	blockB.c[4].mA[3] = (ivec3(7, 3, 4));
	blockB.c[4].mA[4] = (ivec3(-8, -4, 3));
	blockB.c[4].mB = (vec2(7.0, -6.0));
}
#version 450
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
	layout(offset = 0) highp float a;
	layout(offset = 4) highp float b;
} blockB[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[0].a), 6.0) && allOk;
	allOk = compare_float((blockB[0].b), -7.0) && allOk;
	allOk = compare_float((blockB[1].a), 7.0) && allOk;
	allOk = compare_float((blockB[1].b), 7.0) && allOk;
	allOk = compare_float((blockB[2].a), 8.0) && allOk;
	allOk = compare_float((blockB[2].b), 4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (-6.0);
	blockB[1].a = (6.0);
	blockB[2].a = (-4.0);
}
#version 450
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
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump vec2 b;
	layout(offset = 16) mediump vec4 c;
	layout(offset = 32) lowp uint d;
	layout(offset = 36) lowp ivec3 e;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp uvec3 f;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) highp uvec2 g[1];
	layout(offset = 16) bvec3 h;
	layout(offset = 32) highp uvec3 i;
	layout(offset = 44) mediump uint j[1];
} blockE[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockC.c), vec4(-2.0, -3.0, 0.0, 8.0)) && allOk;
	allOk = compare_uint((blockC.d), 2u) && allOk;
	allOk = compare_ivec3((blockC.e), ivec3(2, 2, -4)) && allOk;
	allOk = compare_uvec3((blockD.f), uvec3(2u, 8u, 6u)) && allOk;
	allOk = compare_uint((blockE[0].j[0]), 7u) && allOk;
	allOk = compare_uint((blockE[1].j[0]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec3(-4, -1, -9));
	blockC.b = (vec2(-6.0, -5.0));
	blockC.c = (vec4(2.0, 1.0, -5.0, -6.0));
	blockC.d = (3u);
	blockC.e = (ivec3(0, -1, 3));
	blockD.f = (uvec3(8u, 7u, 8u));
	blockE[0].g[0] = (uvec2(6u, 9u));
	blockE[0].h = (bvec3(false, true, false));
	blockE[0].i = (uvec3(7u, 5u, 0u));
	blockE[0].j[0] = (6u);
	blockE[1].g[0] = (uvec2(6u, 2u));
	blockE[1].h = (bvec3(true, true, false));
	blockE[1].i = (uvec3(1u, 3u, 3u));
	blockE[1].j[0] = (3u);
}
#version 450
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
	layout(offset = 16) lowp vec2 b;
	layout(offset = 24) bool c;
	layout(offset = 32) lowp uvec3 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump uvec3 e;
	layout(offset = 16) highp vec3 f;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp ivec2 g;
	layout(offset = 8) highp uint h;
	layout(offset = 12) bool i;
	layout(offset = 16) bvec4 j[1];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(1u, 6u, 8u, 3u)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(2.0, 8.0)) && allOk;
	allOk = compare_bool((blockB.c), true) && allOk;
	allOk = compare_uvec3((blockB.d), uvec3(4u, 0u, 7u)) && allOk;
	allOk = compare_uvec3((blockC.e), uvec3(8u, 1u, 8u)) && allOk;
	allOk = compare_bool((blockD.i), false) && allOk;
	allOk = compare_bvec4((blockD.j[0]), bvec4(false, true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(1u, 6u, 9u, 6u));
	blockB.b = (vec2(-4.0, 6.0));
	blockB.c = (false);
	blockB.d = (uvec3(4u, 4u, 1u));
	blockC.f = (vec3(1.0, -3.0, 3.0));
	blockD.g = (ivec2(4, 2));
	blockD.h = (7u);
	blockD.i = (false);
	blockD.j[0] = (bvec4(true, true, true, true));
}
#version 450
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
	highp vec3 a;
	highp mat4x3 b[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	bvec4 c[8];
	highp vec3 d[];
};
layout(scalar, row_major, binding = 3) buffer BlockD
{
	mediump mat4 e;
	mediump vec4 f;
	mediump ivec4 g;
	mediump vec4 h[];
} blockD;
layout(scalar, binding = 4) buffer BlockE
{
	lowp vec2 i;
	mediump int j;
	highp mat2x3 k[2][4];
	lowp ivec3 l;
	bvec3 m[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(-7.0, 3.0, 4.0)) && allOk;
	allOk = compare_bvec4((c[0]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((c[1]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((c[2]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((c[3]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((c[4]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((c[5]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((c[6]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((c[7]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_vec3((d[0]), vec3(9.0, -8.0, -3.0)) && allOk;
	allOk = compare_vec3((d[1]), vec3(-1.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec3((d[2]), vec3(-7.0, 3.0, 7.0)) && allOk;
	allOk = compare_vec3((d[3]), vec3(0.0, 7.0, 4.0)) && allOk;
	allOk = compare_vec3((d[4]), vec3(2.0, -9.0, 9.0)) && allOk;
	allOk = compare_vec3((d[5]), vec3(3.0, -7.0, -1.0)) && allOk;
	allOk = compare_vec3((d[6]), vec3(-1.0, 8.0, -3.0)) && allOk;
	allOk = compare_vec3((d[7]), vec3(5.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(blockD.e, mat4(-4.0, 8.0, 2.0, -1.0, -4.0, -1.0, -2.0, -3.0, -7.0, -3.0, -5.0, -2.0, 3.0, -7.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec4((blockD.f), vec4(4.0, 8.0, -7.0, -6.0)) && allOk;
	allOk = compare_vec4((blockD.h[0]), vec4(-5.0, -7.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec4((blockD.h[1]), vec4(-2.0, 8.0, 7.0, 6.0)) && allOk;
	allOk = compare_vec4((blockD.h[2]), vec4(-2.0, 1.0, -9.0, 9.0)) && allOk;
	allOk = compare_vec4((blockD.h[3]), vec4(3.0, -2.0, -9.0, 2.0)) && allOk;
	allOk = compare_vec4((blockD.h[4]), vec4(4.0, -1.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec2((blockE.i), vec2(1.0, 1.0)) && allOk;
	allOk = compare_int((blockE.j), 3) && allOk;
	allOk = compare_mat2x3(blockE.k[0][0], mat2x3(8.0, 5.0, -7.0, -8.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockE.k[0][1], mat2x3(2.0, 8.0, -5.0, 7.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockE.k[0][2], mat2x3(7.0, -8.0, 8.0, 7.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockE.k[0][3], mat2x3(1.0, 5.0, -6.0, -1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockE.k[1][0], mat2x3(1.0, -6.0, 8.0, -6.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockE.k[1][1], mat2x3(-4.0, -4.0, -6.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockE.k[1][2], mat2x3(9.0, -7.0, 2.0, 6.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockE.k[1][3], mat2x3(2.0, 7.0, -3.0, 7.0, -2.0, -6.0)) && allOk;
	allOk = compare_bvec3((blockE.m[0]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockE.m[1]), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(0.0, -2.0, -1.0));
	blockB.b[0] = (mat4x3(6.0, 7.0, 4.0, -7.0, -8.0, -7.0, 2.0, -1.0, -1.0, -8.0, -1.0, -5.0));
	blockB.b[1] = (mat4x3(0.0, -6.0, 0.0, -8.0, -7.0, -2.0, -4.0, 5.0, 4.0, 5.0, 6.0, 2.0));
	blockB.b[2] = (mat4x3(5.0, 2.0, -7.0, 1.0, -1.0, -8.0, 4.0, 5.0, 6.0, -9.0, -9.0, 8.0));
	blockB.b[3] = (mat4x3(4.0, -7.0, -7.0, -9.0, -8.0, 8.0, 6.0, -7.0, -6.0, -4.0, 5.0, -9.0));
	blockB.b[4] = (mat4x3(8.0, -9.0, 2.0, -2.0, 5.0, 9.0, 3.0, 0.0, 6.0, -2.0, -4.0, 5.0));
	c[0] = (bvec4(true, false, false, true));
	c[1] = (bvec4(false, false, false, false));
	c[2] = (bvec4(true, true, true, true));
	c[3] = (bvec4(false, true, false, false));
	c[4] = (bvec4(true, false, true, true));
	c[5] = (bvec4(false, true, true, false));
	c[6] = (bvec4(false, true, true, true));
	c[7] = (bvec4(false, true, false, false));
	d[0] = (vec3(9.0, 1.0, -4.0));
	d[1] = (vec3(-7.0, 0.0, 8.0));
	d[2] = (vec3(-3.0, -1.0, 5.0));
	d[3] = (vec3(2.0, -3.0, 1.0));
	d[4] = (vec3(8.0, 1.0, -3.0));
	d[5] = (vec3(5.0, 6.0, -3.0));
	d[6] = (vec3(-3.0, -1.0, -4.0));
	d[7] = (vec3(-1.0, 1.0, 3.0));
	blockD.e = (mat4(8.0, 1.0, 3.0, 3.0, 4.0, -8.0, -4.0, 7.0, -7.0, -4.0, -7.0, -9.0, 4.0, -8.0, 7.0, 5.0));
	blockD.g = (ivec4(-5, -5, -3, -2));
	blockD.h[0] = (vec4(-8.0, 5.0, -2.0, -8.0));
	blockD.h[1] = (vec4(-5.0, -9.0, -6.0, 1.0));
	blockD.h[2] = (vec4(9.0, -4.0, -6.0, -8.0));
	blockD.h[3] = (vec4(-7.0, -2.0, -2.0, -9.0));
	blockD.h[4] = (vec4(8.0, 4.0, 7.0, 3.0));
	blockE.i = (vec2(3.0, 6.0));
	blockE.j = (-1);
	blockE.k[0][0] = (mat2x3(0.0, 5.0, -1.0, 7.0, -9.0, 7.0));
	blockE.k[0][1] = (mat2x3(-8.0, -8.0, -1.0, 3.0, -5.0, -1.0));
	blockE.k[0][2] = (mat2x3(6.0, 6.0, -4.0, -7.0, -5.0, -1.0));
	blockE.k[0][3] = (mat2x3(-1.0, 0.0, 1.0, -4.0, 8.0, 3.0));
	blockE.k[1][0] = (mat2x3(8.0, -6.0, 5.0, 4.0, -5.0, -2.0));
	blockE.k[1][1] = (mat2x3(1.0, 3.0, -3.0, -7.0, -5.0, 5.0));
	blockE.k[1][2] = (mat2x3(3.0, 9.0, 8.0, -9.0, 6.0, 2.0));
	blockE.k[1][3] = (mat2x3(-5.0, 8.0, 2.0, -5.0, 2.0, -5.0));
}
#version 450
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
	highp uvec3 mB;
};
struct sB
{
	highp ivec2 mA;
	lowp uvec4 mB;
	lowp mat4x3 mC;
	lowp uvec2 mD[5];
};
struct sC
{
	highp int mA;
	bvec3 mB;
	sB mC;
};
struct sD
{
	highp vec4 mA;
	highp mat3x4 mB;
	bvec3 mC;
	highp vec4 mD;
};
struct sE
{
	bool mA;
	mediump uvec3 mB;
	highp uvec3 mC;
};
struct sF
{
	mediump mat4x2 mA;
};
layout(scalar, binding = 1) buffer BlockB
{
	sA a;
	mediump mat3x4 b;
	lowp mat3x2 c;
	highp mat2 d;
	mediump uint e[];
} blockB[2];
layout(scalar, binding = 2) buffer BlockC
{
	highp mat4x2 f;
	sC g;
	bvec4 h;
	mediump vec3 i;
	bvec2 j;
} blockC;
layout(scalar, column_major, binding = 3) buffer BlockD
{
	mediump mat2x3 k;
	lowp uint l;
	highp mat3x4 m;
	mediump int n;
	highp mat4x2 o[][2];
};
layout(scalar, binding = 4) buffer BlockE
{
	sD p;
	highp uvec3 q;
	sE r;
	sF s[];
} blockE[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
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
	allOk = compare_mat3x2(blockB[0].c, mat3x2(-8.0, -7.0, -1.0, -8.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(blockB[0].d, mat2(9.0, -6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB[1].c, mat3x2(-3.0, -3.0, 9.0, -8.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2(blockB[1].d, mat2(7.0, 5.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(k, mat2x3(2.0, 6.0, 6.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(m, mat3x4(2.0, -5.0, 2.0, 1.0, -2.0, 1.0, -9.0, 4.0, -8.0, -6.0, -9.0, 6.0)) && allOk;
	allOk = compare_int((n), 7) && allOk;
	allOk = compare_vec4((blockE[0].p.mA), vec4(5.0, -8.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].p.mB, mat3x4(3.0, 2.0, 3.0, 6.0, 5.0, -3.0, 0.0, 1.0, -4.0, -9.0, -2.0, -2.0)) && allOk;
	allOk = compare_bvec3((blockE[0].p.mC), bvec3(true, false, true)) && allOk;
	allOk = compare_vec4((blockE[0].p.mD), vec4(2.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_bool((blockE[0].r.mA), true) && allOk;
	allOk = compare_uvec3((blockE[0].r.mB), uvec3(1u, 4u, 4u)) && allOk;
	allOk = compare_uvec3((blockE[0].r.mC), uvec3(8u, 9u, 3u)) && allOk;
	allOk = compare_vec4((blockE[1].p.mA), vec4(2.0, 8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockE[1].p.mB, mat3x4(7.0, 7.0, -6.0, 2.0, 5.0, 7.0, -8.0, 0.0, 0.0, 6.0, -1.0, 0.0)) && allOk;
	allOk = compare_bvec3((blockE[1].p.mC), bvec3(true, false, true)) && allOk;
	allOk = compare_vec4((blockE[1].p.mD), vec4(0.0, -8.0, -8.0, 4.0)) && allOk;
	allOk = compare_bool((blockE[1].r.mA), false) && allOk;
	allOk = compare_uvec3((blockE[1].r.mB), uvec3(7u, 0u, 4u)) && allOk;
	allOk = compare_uvec3((blockE[1].r.mC), uvec3(6u, 9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (mat3x4(-8.0, 2.0, -8.0, -7.0, 8.0, 6.0, -7.0, -7.0, -7.0, 3.0, -9.0, 9.0));
	blockB[0].c = (mat3x2(6.0, -5.0, -8.0, 5.0, 5.0, -5.0));
	blockB[0].d = (mat2(6.0, 6.0, -8.0, -7.0));
	blockB[1].b = (mat3x4(-5.0, 7.0, -1.0, 8.0, 3.0, 8.0, 7.0, 2.0, 9.0, 7.0, 4.0, -7.0));
	blockB[1].c = (mat3x2(7.0, -4.0, 7.0, 2.0, -2.0, 7.0));
	blockB[1].d = (mat2(6.0, 6.0, 5.0, 0.0));
	blockC.h = (bvec4(false, true, false, true));
	blockC.i = (vec3(7.0, -6.0, 1.0));
	m = (mat3x4(6.0, 1.0, -6.0, 1.0, -4.0, -8.0, 3.0, -8.0, 5.0, -8.0, -9.0, -7.0));
	n = (4);
	o[0][0] = (mat4x2(-4.0, 0.0, -5.0, 8.0, 6.0, 0.0, 0.0, -1.0));
	o[0][1] = (mat4x2(5.0, 3.0, -5.0, 3.0, -5.0, 9.0, 6.0, 4.0));
	o[1][0] = (mat4x2(9.0, 4.0, -7.0, 7.0, 3.0, 7.0, 7.0, -6.0));
	o[1][1] = (mat4x2(-4.0, 0.0, -7.0, -6.0, 6.0, -3.0, -7.0, -3.0));
	blockE[0].p.mA = (vec4(-1.0, -6.0, -6.0, -5.0));
	blockE[0].p.mB = (mat3x4(-5.0, 1.0, -7.0, -4.0, 1.0, 7.0, -5.0, 7.0, -7.0, 3.0, -9.0, -7.0));
	blockE[0].p.mC = (bvec3(false, true, false));
	blockE[0].p.mD = (vec4(-3.0, -5.0, -4.0, 7.0));
	blockE[0].q = (uvec3(4u, 3u, 9u));
	blockE[0].r.mA = (false);
	blockE[0].r.mB = (uvec3(2u, 1u, 7u));
	blockE[0].r.mC = (uvec3(4u, 5u, 3u));
	blockE[1].p.mA = (vec4(-9.0, 9.0, 4.0, 3.0));
	blockE[1].p.mB = (mat3x4(7.0, -8.0, 2.0, 1.0, -4.0, 1.0, 9.0, -4.0, 5.0, 3.0, 0.0, -6.0));
	blockE[1].p.mC = (bvec3(true, false, false));
	blockE[1].p.mD = (vec4(7.0, -3.0, 2.0, 3.0));
	blockE[1].q = (uvec3(7u, 5u, 5u));
	blockE[1].r.mA = (true);
	blockE[1].r.mB = (uvec3(9u, 0u, 8u));
	blockE[1].r.mC = (uvec3(0u, 2u, 3u));
}
#version 450
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
	highp vec3 mA;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	highp mat3x4 a;
	mediump mat4x3 b[5];
	sA c;
	mediump mat3 d[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.c.mA), vec3(7.0, 4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(-8.0, 9.0, -9.0, -3.0, 7.0, 4.0, -4.0, -6.0, -5.0, 0.0, -9.0, -6.0));
	blockB.b[0] = (mat4x3(-7.0, -1.0, -2.0, -9.0, 9.0, -9.0, -4.0, 4.0, 7.0, -8.0, 4.0, -5.0));
	blockB.b[1] = (mat4x3(7.0, -8.0, -1.0, 4.0, -9.0, 6.0, -6.0, 1.0, 6.0, -3.0, -3.0, -7.0));
	blockB.b[2] = (mat4x3(8.0, 8.0, 8.0, -6.0, -2.0, 4.0, -2.0, 6.0, 1.0, -2.0, 7.0, 6.0));
	blockB.b[3] = (mat4x3(-5.0, -7.0, -4.0, 4.0, -4.0, 6.0, -7.0, -2.0, 7.0, -4.0, -5.0, -5.0));
	blockB.b[4] = (mat4x3(-7.0, -8.0, 0.0, -5.0, -7.0, -8.0, 2.0, 2.0, -1.0, -7.0, -2.0, -4.0));
	blockB.c.mA = (vec3(-2.0, 2.0, 8.0));
}
#version 450
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
	lowp mat4x3 a;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB[nonuniformEXT(0)].a, mat4x3(6.0, 6.0, -6.0, -3.0, -1.0, -9.0, 5.0, -7.0, -9.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(1)].a, mat4x3(8.0, -8.0, -6.0, -2.0, 9.0, -2.0, -2.0, 1.0, 1.0, 7.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(2)].a, mat4x3(-5.0, 8.0, 4.0, -9.0, 8.0, -6.0, 8.0, 2.0, -5.0, 9.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4x3(-5.0, 9.0, 5.0, 5.0, -3.0, -5.0, -8.0, 3.0, -9.0, 2.0, 6.0, 1.0));
	blockB[nonuniformEXT(1)].a = (mat4x3(9.0, -5.0, 9.0, -3.0, 6.0, 7.0, -9.0, -6.0, -1.0, 3.0, 5.0, 3.0));
	blockB[nonuniformEXT(2)].a = (mat4x3(9.0, 8.0, -4.0, -8.0, -5.0, -1.0, 2.0, 0.0, 5.0, 3.0, -3.0, 2.0));
}
#version 450
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
	mediump mat3x2 b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4x2(-1.0, -4.0, 2.0, -1.0, 2.0, 2.0, -5.0, 7.0));
	blockB[nonuniformEXT(0)].b = (mat3x2(-5.0, 5.0, -3.0, 4.0, -8.0, 9.0));
	blockB[nonuniformEXT(1)].a = (mat4x2(-2.0, 5.0, -1.0, 9.0, 2.0, 3.0, -2.0, 9.0));
	blockB[nonuniformEXT(1)].b = (mat3x2(-6.0, 3.0, 5.0, 5.0, 9.0, 3.0));
	blockB[nonuniformEXT(2)].a = (mat4x2(-9.0, -1.0, -5.0, -8.0, 3.0, 0.0, -6.0, -8.0));
	blockB[nonuniformEXT(2)].b = (mat3x2(-3.0, 8.0, 2.0, -4.0, 6.0, 9.0));
	blockB[nonuniformEXT(3)].a = (mat4x2(9.0, -1.0, -2.0, 8.0, 7.0, -5.0, -2.0, -3.0));
	blockB[nonuniformEXT(3)].b = (mat3x2(-4.0, 3.0, 1.0, -2.0, -3.0, -9.0));
}
#version 450
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
	mediump int a;
	bool b;
	uint16_t c;
	float16_t d;
};
layout(std430, binding = 2) buffer BlockC
{
	mediump uint e;
};
layout(std430, binding = 3) buffer BlockD
{
	lowp uint f[1];
	mediump uint g;
	mediump float h;
	int16_t i;
	float16_t j[1];
};
layout(std140, binding = 4) buffer BlockE
{
	int16_t k[1];
	int16_t l;
	bool m;
	float16_t n;
	float16_t o;
} blockE;

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
	allOk = compare_int((a), 2) && allOk;
	allOk = compare_float16_t(float(d), 7.0) && allOk;
	allOk = compare_uint((g), 6u) && allOk;
	allOk = compare_int16_t(int(blockE.k[0]), 5) && allOk;
    if (allOk)
        ac_numPassed++;

	c = uint16_t(5u);
	d = float16_t(6.0);
	e = (5u);
	f[0] = (3u);
	g = (8u);
	i = int16_t(8);
	blockE.l = int16_t(-5);
	blockE.m = (false);
	blockE.n = float16_t(-2.0);
	blockE.o = float16_t(7.0);
}
#version 450
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
	highp float a[1];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

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
	u16vec3 a;
	mediump uvec3 b[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	bvec3 c;
	mediump mat4 d;
	i16vec4 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	c = (bvec3(false, false, true));
	e = i16vec4(ivec4(4, -8, -4, 1));
}
#version 450
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
	f16vec4 a;
	bvec3 b;
	i16vec3 c;
	highp mat3x2 d[][7];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	float16_t e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(a), vec4(2.0, -8.0, -4.0, 7.0)) && allOk;
	allOk = compare_bvec3((b), bvec3(true, false, false)) && allOk;
	allOk = compare_i16vec3(ivec3(c), ivec3(-6, 4, 5)) && allOk;
	allOk = compare_mat3x2(d[0][0], mat3x2(6.0, 8.0, -6.0, 1.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(d[0][1], mat3x2(7.0, 5.0, 5.0, -9.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3x2(d[0][2], mat3x2(6.0, -7.0, 2.0, -8.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x2(d[0][3], mat3x2(-9.0, 3.0, 1.0, 6.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3x2(d[0][4], mat3x2(8.0, 6.0, 6.0, 7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(d[0][5], mat3x2(8.0, -1.0, -9.0, -8.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(d[0][6], mat3x2(7.0, -1.0, -8.0, 1.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(d[1][0], mat3x2(-7.0, 6.0, -7.0, 7.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(d[1][1], mat3x2(9.0, 3.0, 1.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x2(d[1][2], mat3x2(6.0, 1.0, 9.0, -3.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3x2(d[1][3], mat3x2(-1.0, -2.0, -9.0, -1.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3x2(d[1][4], mat3x2(3.0, 8.0, 2.0, 6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3x2(d[1][5], mat3x2(2.0, 5.0, 3.0, 9.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(d[1][6], mat3x2(7.0, -9.0, -5.0, -4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x2(d[2][0], mat3x2(-2.0, -2.0, 6.0, 1.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(d[2][1], mat3x2(2.0, 5.0, 4.0, -7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x2(d[2][2], mat3x2(0.0, -5.0, 0.0, 3.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3x2(d[2][3], mat3x2(6.0, 0.0, -6.0, -4.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(d[2][4], mat3x2(4.0, -4.0, 4.0, 4.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3x2(d[2][5], mat3x2(6.0, 6.0, -5.0, 9.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat3x2(d[2][6], mat3x2(8.0, -5.0, 4.0, -5.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x2(d[3][0], mat3x2(-1.0, -9.0, -9.0, -9.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(d[3][1], mat3x2(-6.0, -1.0, 0.0, 4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(d[3][2], mat3x2(-9.0, 7.0, 9.0, -6.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3x2(d[3][3], mat3x2(-5.0, 8.0, 2.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(d[3][4], mat3x2(-8.0, 6.0, 6.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x2(d[3][5], mat3x2(9.0, -7.0, 9.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3x2(d[3][6], mat3x2(-5.0, -6.0, 8.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(d[4][0], mat3x2(6.0, 2.0, 7.0, -7.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(d[4][1], mat3x2(2.0, 2.0, 5.0, 2.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x2(d[4][2], mat3x2(1.0, 9.0, -9.0, 9.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(d[4][3], mat3x2(0.0, -1.0, 0.0, 3.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(d[4][4], mat3x2(6.0, -7.0, -5.0, -1.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3x2(d[4][5], mat3x2(5.0, -5.0, 6.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(d[4][6], mat3x2(1.0, 5.0, 0.0, 4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x2(d[5][0], mat3x2(-6.0, 8.0, -9.0, 6.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(d[5][1], mat3x2(1.0, 3.0, 7.0, 6.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(d[5][2], mat3x2(-4.0, -9.0, -4.0, 2.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(d[5][3], mat3x2(9.0, -5.0, 0.0, 9.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(d[5][4], mat3x2(1.0, 1.0, 3.0, 7.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(d[5][5], mat3x2(0.0, -2.0, -9.0, -1.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(d[5][6], mat3x2(6.0, -3.0, -5.0, 9.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3x2(d[6][0], mat3x2(9.0, -2.0, -4.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(d[6][1], mat3x2(0.0, -7.0, -2.0, -1.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x2(d[6][2], mat3x2(-6.0, 9.0, 8.0, 2.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(d[6][3], mat3x2(-8.0, -9.0, -2.0, 1.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3x2(d[6][4], mat3x2(0.0, 8.0, 0.0, 0.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x2(d[6][5], mat3x2(-2.0, 9.0, 3.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3x2(d[6][6], mat3x2(-4.0, 9.0, 9.0, -5.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x2(d[7][0], mat3x2(-6.0, -7.0, -1.0, 7.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x2(d[7][1], mat3x2(-7.0, 9.0, -9.0, -8.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat3x2(d[7][2], mat3x2(-6.0, -5.0, -4.0, -6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(d[7][3], mat3x2(2.0, 6.0, -8.0, 5.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(d[7][4], mat3x2(5.0, 4.0, 2.0, -9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x2(d[7][5], mat3x2(3.0, -8.0, 2.0, -1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(d[7][6], mat3x2(-8.0, -4.0, -5.0, -9.0, 2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = f16vec4(vec4(8.0, -2.0, -1.0, -6.0));
	b = (bvec3(false, false, false));
	c = i16vec3(ivec3(5, 4, 8));
	d[0][0] = (mat3x2(6.0, 5.0, 7.0, -2.0, -5.0, 7.0));
	d[0][1] = (mat3x2(4.0, 9.0, 7.0, -4.0, 0.0, -5.0));
	d[0][2] = (mat3x2(4.0, -6.0, 9.0, -2.0, -7.0, -4.0));
	d[0][3] = (mat3x2(8.0, 6.0, -6.0, -3.0, -4.0, -6.0));
	d[0][4] = (mat3x2(8.0, -1.0, -6.0, 4.0, -7.0, -7.0));
	d[0][5] = (mat3x2(2.0, -6.0, -1.0, 5.0, 4.0, -5.0));
	d[0][6] = (mat3x2(-1.0, -7.0, -2.0, 8.0, -3.0, -6.0));
	d[1][0] = (mat3x2(7.0, -3.0, 9.0, -4.0, 8.0, 4.0));
	d[1][1] = (mat3x2(9.0, 2.0, 0.0, -3.0, 1.0, -9.0));
	d[1][2] = (mat3x2(-9.0, -8.0, 0.0, 4.0, -6.0, -1.0));
	d[1][3] = (mat3x2(-8.0, 0.0, -9.0, 9.0, 0.0, -9.0));
	d[1][4] = (mat3x2(4.0, 6.0, 7.0, -5.0, 6.0, -4.0));
	d[1][5] = (mat3x2(3.0, 0.0, -5.0, -5.0, -2.0, 2.0));
	d[1][6] = (mat3x2(9.0, -2.0, -4.0, -5.0, 4.0, 4.0));
	d[2][0] = (mat3x2(-1.0, -9.0, 3.0, -7.0, 8.0, -2.0));
	d[2][1] = (mat3x2(-2.0, 8.0, -1.0, -5.0, -6.0, -3.0));
	d[2][2] = (mat3x2(5.0, -8.0, 9.0, -9.0, -5.0, 9.0));
	d[2][3] = (mat3x2(5.0, 3.0, 1.0, -7.0, -7.0, -4.0));
	d[2][4] = (mat3x2(-6.0, -1.0, 5.0, 0.0, 3.0, 4.0));
	d[2][5] = (mat3x2(4.0, 8.0, -4.0, 7.0, -3.0, -6.0));
	d[2][6] = (mat3x2(1.0, 2.0, 1.0, 2.0, 6.0, -3.0));
	d[3][0] = (mat3x2(-5.0, -7.0, 3.0, 6.0, 0.0, 3.0));
	d[3][1] = (mat3x2(2.0, -5.0, -2.0, -9.0, 8.0, -5.0));
	d[3][2] = (mat3x2(2.0, -1.0, 4.0, 4.0, 3.0, -5.0));
	d[3][3] = (mat3x2(-4.0, -5.0, 3.0, 2.0, -9.0, -3.0));
	d[3][4] = (mat3x2(-9.0, -2.0, -1.0, -3.0, 4.0, -7.0));
	d[3][5] = (mat3x2(-6.0, -9.0, -8.0, 8.0, -2.0, -8.0));
	d[3][6] = (mat3x2(-2.0, -6.0, 4.0, -6.0, 0.0, -1.0));
	d[4][0] = (mat3x2(-6.0, -8.0, -8.0, -8.0, -8.0, -1.0));
	d[4][1] = (mat3x2(-7.0, -2.0, 0.0, 5.0, -4.0, -2.0));
	d[4][2] = (mat3x2(6.0, -7.0, -8.0, 2.0, -4.0, 7.0));
	d[4][3] = (mat3x2(-3.0, -7.0, -5.0, 6.0, 2.0, -5.0));
	d[4][4] = (mat3x2(0.0, 9.0, -3.0, 1.0, 5.0, 2.0));
	d[4][5] = (mat3x2(-1.0, 2.0, 7.0, 6.0, -8.0, -8.0));
	d[4][6] = (mat3x2(2.0, 0.0, -8.0, 5.0, 2.0, -9.0));
	d[5][0] = (mat3x2(-7.0, 5.0, 1.0, -1.0, -9.0, -2.0));
	d[5][1] = (mat3x2(4.0, 9.0, 8.0, -7.0, 1.0, 6.0));
	d[5][2] = (mat3x2(-7.0, 0.0, -2.0, -2.0, 3.0, 7.0));
	d[5][3] = (mat3x2(6.0, 3.0, 2.0, 3.0, -4.0, -7.0));
	d[5][4] = (mat3x2(-4.0, 7.0, 3.0, 2.0, 3.0, 0.0));
	d[5][5] = (mat3x2(-4.0, -9.0, 7.0, 8.0, -8.0, 3.0));
	d[5][6] = (mat3x2(8.0, 5.0, 1.0, 7.0, -4.0, -7.0));
	d[6][0] = (mat3x2(-5.0, 5.0, -3.0, -2.0, -3.0, -3.0));
	d[6][1] = (mat3x2(-3.0, -4.0, 6.0, -7.0, 1.0, 4.0));
	d[6][2] = (mat3x2(5.0, -5.0, 6.0, 1.0, 2.0, 2.0));
	d[6][3] = (mat3x2(-2.0, 1.0, 3.0, -7.0, -7.0, 5.0));
	d[6][4] = (mat3x2(6.0, -4.0, -4.0, 4.0, 3.0, -9.0));
	d[6][5] = (mat3x2(-7.0, -9.0, 8.0, 9.0, 1.0, -3.0));
	d[6][6] = (mat3x2(-6.0, 4.0, -5.0, 3.0, 3.0, -4.0));
	d[7][0] = (mat3x2(3.0, 0.0, 3.0, -7.0, -9.0, 4.0));
	d[7][1] = (mat3x2(-3.0, 5.0, 9.0, 2.0, 9.0, -3.0));
	d[7][2] = (mat3x2(3.0, -5.0, 9.0, 8.0, -1.0, 9.0));
	d[7][3] = (mat3x2(-1.0, 7.0, -3.0, -1.0, -9.0, -7.0));
	d[7][4] = (mat3x2(6.0, 1.0, -2.0, -9.0, -1.0, 8.0));
	d[7][5] = (mat3x2(-7.0, 8.0, -1.0, 4.0, 2.0, 9.0));
	d[7][6] = (mat3x2(4.0, 6.0, -5.0, -4.0, 4.0, -9.0));
	e[0] = float16_t(-9.0);
	e[1] = float16_t(-8.0);
}
#version 450
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
	mediump vec3 a;
	u16vec3 b[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	i16vec4 c;
	lowp ivec3 d;
	highp mat3 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB.b[0]), uvec3(1u, 6u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.b[1]), uvec3(7u, 4u, 7u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.b[2]), uvec3(2u, 8u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.b[3]), uvec3(0u, 3u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.b[4]), uvec3(7u, 4u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.b[5]), uvec3(4u, 8u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.b[6]), uvec3(0u, 4u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.b[7]), uvec3(2u, 4u, 3u)) && allOk;
	allOk = compare_ivec3((d), ivec3(-2, -8, 6)) && allOk;
	allOk = compare_mat3(e[0], mat3(-3.0, -8.0, -7.0, -2.0, -8.0, -1.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3(e[1], mat3(-6.0, -8.0, 0.0, 3.0, -8.0, -3.0, -6.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(e[2], mat3(9.0, 0.0, -4.0, -9.0, 6.0, -3.0, 9.0, 7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(-7.0, 4.0, -4.0));
	blockB.b[0] = u16vec3(uvec3(4u, 6u, 5u));
	blockB.b[1] = u16vec3(uvec3(3u, 5u, 1u));
	blockB.b[2] = u16vec3(uvec3(6u, 6u, 4u));
	blockB.b[3] = u16vec3(uvec3(4u, 1u, 9u));
	blockB.b[4] = u16vec3(uvec3(5u, 2u, 7u));
	blockB.b[5] = u16vec3(uvec3(8u, 7u, 5u));
	blockB.b[6] = u16vec3(uvec3(4u, 6u, 8u));
	blockB.b[7] = u16vec3(uvec3(0u, 2u, 3u));
	d = (ivec3(2, 8, 0));
	e[0] = (mat3(6.0, 5.0, 6.0, -3.0, -8.0, 8.0, -8.0, -6.0, -5.0));
	e[1] = (mat3(0.0, 0.0, 2.0, -1.0, -4.0, -3.0, 0.0, 5.0, -3.0));
	e[2] = (mat3(7.0, 4.0, 0.0, -3.0, -8.0, -4.0, -1.0, -5.0, 1.0));
}
#version 450
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
	highp mat2x3 mB;
};
struct sB
{
	mediump ivec4 mA;
	i16vec4 mB;
	sA mC;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	sB a;
	i16vec3 b;
	highp vec3 c;
	f16vec4 d[6];
	bool e[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	i16vec2 f;
};
layout(std430, column_major, binding = 3) readonly buffer BlockD
{
	bvec3 g[];
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a.mA), ivec4(1, 2, 2, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.a.mB), ivec4(-1, -3, 2, -3)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.a.mC.mA), ivec3(-9, 2, -1)) && allOk;
	allOk = compare_mat2x3(blockB.a.mC.mB, mat2x3(-3.0, -9.0, -8.0, 0.0, -6.0, -5.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.b), ivec3(-1, -3, 5)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(3.0, -3.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[0]), vec4(-7.0, 1.0, 9.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[1]), vec4(8.0, 7.0, 2.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[2]), vec4(3.0, -3.0, 2.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[3]), vec4(2.0, -1.0, 5.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[4]), vec4(7.0, -6.0, 2.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d[5]), vec4(-7.0, 4.0, -9.0, 3.0)) && allOk;
	allOk = compare_i16vec2(ivec2(f), ivec2(-7, -1)) && allOk;
	allOk = compare_bvec3((blockD[0].g[0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockD[0].g[1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockD[0].g[2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockD[0].g[3]), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (ivec4(-8, -4, -7, 2));
	blockB.a.mB = i16vec4(ivec4(-2, 1, 6, -8));
	blockB.a.mC.mA = i16vec3(ivec3(6, -1, -9));
	blockB.a.mC.mB = (mat2x3(3.0, -6.0, 4.0, -7.0, 6.0, -5.0));
	blockB.b = i16vec3(ivec3(-4, 8, -7));
	blockB.c = (vec3(4.0, -3.0, -3.0));
	blockB.d[0] = f16vec4(vec4(5.0, 6.0, 7.0, -8.0));
	blockB.d[1] = f16vec4(vec4(3.0, 9.0, 9.0, 5.0));
	blockB.d[2] = f16vec4(vec4(6.0, 5.0, -3.0, -9.0));
	blockB.d[3] = f16vec4(vec4(7.0, -2.0, -9.0, 9.0));
	blockB.d[4] = f16vec4(vec4(0.0, -6.0, -7.0, 1.0));
	blockB.d[5] = f16vec4(vec4(-2.0, 8.0, -2.0, 4.0));
	f = i16vec2(ivec2(-7, -3));
}
#version 450
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
};
struct sB
{
	f16vec3 mA;
	mediump mat4 mB;
	mediump vec4 mC;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	lowp mat3x4 a;
	sA b;
	bvec3 c;
	mediump vec3 d[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	sB e;
	lowp mat2 f[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	u16vec4 g[];
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	f16vec4 h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a, mat3x4(2.0, 3.0, 7.0, 9.0, 7.0, 0.0, -2.0, 1.0, -9.0, -7.0, 3.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(b.mA), vec2(-2.0, 0.0)) && allOk;
	allOk = compare_bvec3((c), bvec3(true, false, true)) && allOk;
	allOk = compare_f16vec3(vec3(e.mA), vec3(-9.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4(e.mB, mat4(-7.0, 8.0, 3.0, 9.0, 7.0, 9.0, 7.0, 3.0, -3.0, 8.0, 1.0, -8.0, -3.0, -3.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec4((e.mC), vec4(3.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2(f[0], mat2(9.0, -4.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2(f[1], mat2(2.0, 3.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat2(f[2], mat2(-9.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2(f[3], mat2(1.0, -7.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2(f[4], mat2(4.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(f[5], mat2(9.0, -1.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2(f[6], mat2(-7.0, -2.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2(f[7], mat2(5.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.g[0]), uvec4(8u, 3u, 5u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.g[1]), uvec4(0u, 7u, 3u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.g[2]), uvec4(8u, 4u, 4u, 2u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.g[3]), uvec4(4u, 8u, 7u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x4(8.0, 5.0, -1.0, 5.0, 9.0, -4.0, 9.0, -8.0, -5.0, 2.0, -3.0, -2.0));
	b.mA = f16vec2(vec2(4.0, 1.0));
	c = (bvec3(true, true, true));
	e.mA = f16vec3(vec3(-6.0, -5.0, -4.0));
	e.mB = (mat4(-2.0, 8.0, -7.0, 4.0, 0.0, 7.0, 2.0, -4.0, 1.0, 6.0, -2.0, 5.0, 7.0, -9.0, -4.0, 7.0));
	e.mC = (vec4(-9.0, 7.0, 7.0, -8.0));
	f[0] = (mat2(5.0, -2.0, -3.0, -9.0));
	f[1] = (mat2(7.0, -4.0, -6.0, 3.0));
	f[2] = (mat2(-7.0, -4.0, 2.0, -4.0));
	f[3] = (mat2(-3.0, 3.0, 2.0, 0.0));
	f[4] = (mat2(8.0, 8.0, -2.0, -6.0));
	f[5] = (mat2(7.0, 1.0, 9.0, -1.0));
	f[6] = (mat2(-8.0, 1.0, 0.0, -2.0));
	f[7] = (mat2(-8.0, 7.0, -6.0, -5.0));
	blockD.g[0] = u16vec4(uvec4(2u, 7u, 3u, 8u));
	blockD.g[1] = u16vec4(uvec4(8u, 6u, 9u, 8u));
	blockD.g[2] = u16vec4(uvec4(4u, 5u, 4u, 6u));
	blockD.g[3] = u16vec4(uvec4(9u, 0u, 3u, 6u));
	h = f16vec4(vec4(-7.0, 9.0, -9.0, 7.0));
}
#version 450
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
	highp vec3 mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	mediump mat4x2 a[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	float16_t b;
	i16vec4 c[6][7];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	uint16_t d;
	u16vec4 e;
	int16_t f;
	sA g[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(b), -1.0) && allOk;
	allOk = compare_int16_t(int(blockD.f), -6) && allOk;
	allOk = compare_mat2x3(blockD.g[0].mA, mat2x3(-9.0, -6.0, 3.0, 2.0, -4.0, 1.0)) && allOk;
	allOk = compare_vec3((blockD.g[0].mB), vec3(-9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockD.g[1].mA, mat2x3(-5.0, -2.0, -7.0, 5.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec3((blockD.g[1].mB), vec3(-5.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockD.g[2].mA, mat2x3(3.0, 8.0, -2.0, -7.0, 5.0, -2.0)) && allOk;
	allOk = compare_vec3((blockD.g[2].mB), vec3(1.0, 9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x2(0.0, 2.0, -7.0, -7.0, 3.0, 4.0, -2.0, 6.0));
	b = float16_t(-8.0);
	blockD.d = uint16_t(8u);
	blockD.e = u16vec4(uvec4(1u, 9u, 7u, 5u));
	blockD.f = int16_t(-8);
	blockD.g[0].mA = (mat2x3(-5.0, -4.0, 1.0, 0.0, 3.0, -5.0));
	blockD.g[0].mB = (vec3(-2.0, -8.0, 0.0));
	blockD.g[1].mA = (mat2x3(-1.0, 9.0, 3.0, -5.0, 1.0, 8.0));
	blockD.g[1].mB = (vec3(-4.0, 7.0, -7.0));
	blockD.g[2].mA = (mat2x3(8.0, -6.0, -4.0, 8.0, -6.0, -1.0));
	blockD.g[2].mB = (vec3(9.0, 9.0, 7.0));
}
#version 450
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
	mediump vec4 mA;
	mediump ivec2 mB;
	highp mat3x4 mC;
	mediump vec3 mD;
};
struct sB
{
	sA mA;
	lowp mat4x2 mB;
	highp mat4 mC;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	mediump mat2x3 a[5];
	bvec2 b;
	sB c[6];
	i16vec3 d;
	highp int e[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	u16vec3 f;
	lowp mat3x4 g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a[0], mat2x3(1.0, 2.0, 2.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[1], mat2x3(2.0, -3.0, -9.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[2], mat2x3(-9.0, -8.0, 0.0, -6.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[3], mat2x3(-3.0, 5.0, 3.0, -3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockB.a[4], mat2x3(1.0, 9.0, -2.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec4((blockB.c[0].mA.mA), vec4(2.0, 4.0, 2.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockB.c[0].mA.mB), ivec2(-7, -1)) && allOk;
	allOk = compare_mat3x4(blockB.c[0].mA.mC, mat3x4(4.0, 5.0, 0.0, 6.0, 4.0, 5.0, -7.0, 2.0, -2.0, -4.0, 5.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB.c[0].mA.mD), vec3(8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[0].mB, mat4x2(8.0, -9.0, -1.0, -9.0, -2.0, 4.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(blockB.c[0].mC, mat4(-7.0, -9.0, 8.0, 6.0, 0.0, 7.0, 1.0, 4.0, 2.0, 3.0, 3.0, -3.0, -4.0, -8.0, 6.0, -3.0)) && allOk;
	allOk = compare_vec4((blockB.c[1].mA.mA), vec4(5.0, -5.0, 7.0, -6.0)) && allOk;
	allOk = compare_ivec2((blockB.c[1].mA.mB), ivec2(1, 0)) && allOk;
	allOk = compare_mat3x4(blockB.c[1].mA.mC, mat3x4(3.0, 1.0, -6.0, 9.0, -2.0, -6.0, -5.0, -5.0, -4.0, -5.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c[1].mA.mD), vec3(6.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[1].mB, mat4x2(6.0, 7.0, -2.0, 8.0, 5.0, -2.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(blockB.c[1].mC, mat4(1.0, 4.0, -7.0, -7.0, -9.0, 5.0, 7.0, -3.0, 5.0, -9.0, 3.0, -9.0, 3.0, -3.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec4((blockB.c[2].mA.mA), vec4(2.0, -9.0, -7.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB.c[2].mA.mB), ivec2(-6, -1)) && allOk;
	allOk = compare_mat3x4(blockB.c[2].mA.mC, mat3x4(6.0, -1.0, 5.0, 6.0, 8.0, -3.0, -3.0, -1.0, 4.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_vec3((blockB.c[2].mA.mD), vec3(4.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[2].mB, mat4x2(4.0, 7.0, -8.0, 1.0, 1.0, 6.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4(blockB.c[2].mC, mat4(3.0, -6.0, 0.0, -2.0, -4.0, -6.0, 6.0, 4.0, 7.0, 2.0, 8.0, 2.0, 2.0, -8.0, 3.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB.c[3].mA.mA), vec4(-9.0, 3.0, 0.0, -6.0)) && allOk;
	allOk = compare_ivec2((blockB.c[3].mA.mB), ivec2(7, -1)) && allOk;
	allOk = compare_mat3x4(blockB.c[3].mA.mC, mat3x4(8.0, 7.0, -4.0, -6.0, 5.0, 1.0, -8.0, -7.0, 4.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec3((blockB.c[3].mA.mD), vec3(5.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[3].mB, mat4x2(1.0, 8.0, 0.0, -4.0, 1.0, -8.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4(blockB.c[3].mC, mat4(7.0, -9.0, -3.0, -9.0, -9.0, 7.0, 9.0, 0.0, -7.0, -1.0, 5.0, 5.0, -1.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_vec4((blockB.c[4].mA.mA), vec4(-4.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockB.c[4].mA.mB), ivec2(2, -8)) && allOk;
	allOk = compare_mat3x4(blockB.c[4].mA.mC, mat3x4(7.0, -6.0, 1.0, 5.0, -2.0, 2.0, -6.0, 7.0, -3.0, -5.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.c[4].mA.mD), vec3(-1.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[4].mB, mat4x2(-8.0, -8.0, 6.0, -3.0, 1.0, -5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(blockB.c[4].mC, mat4(-8.0, -1.0, -2.0, 7.0, 7.0, -7.0, 8.0, 7.0, 6.0, 6.0, -5.0, 6.0, 9.0, 0.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec4((blockB.c[5].mA.mA), vec4(7.0, -1.0, -5.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockB.c[5].mA.mB), ivec2(-5, 1)) && allOk;
	allOk = compare_mat3x4(blockB.c[5].mA.mC, mat3x4(-3.0, 7.0, 5.0, -2.0, 8.0, -9.0, -3.0, -8.0, -6.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c[5].mA.mD), vec3(-1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockB.c[5].mB, mat4x2(3.0, 9.0, -6.0, -5.0, 0.0, 4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4(blockB.c[5].mC, mat4(7.0, 3.0, -5.0, -8.0, -4.0, 1.0, -1.0, 3.0, 2.0, 4.0, -9.0, 8.0, -9.0, -9.0, 6.0, -7.0)) && allOk;
	allOk = compare_u16vec3(uvec3(f), uvec3(8u, 2u, 9u)) && allOk;
	allOk = compare_mat3x4(g[0], mat3x4(-2.0, 9.0, 8.0, -2.0, 3.0, -6.0, -1.0, -5.0, -5.0, 6.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(g[1], mat3x4(-5.0, 6.0, -7.0, -5.0, -9.0, -7.0, -7.0, 1.0, -4.0, 1.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat2x3(-8.0, -4.0, -7.0, 2.0, -2.0, 1.0));
	blockB.a[1] = (mat2x3(6.0, -8.0, 6.0, -1.0, -9.0, 3.0));
	blockB.a[2] = (mat2x3(-6.0, 4.0, -7.0, 6.0, -5.0, -4.0));
	blockB.a[3] = (mat2x3(8.0, -7.0, 4.0, -3.0, -3.0, 5.0));
	blockB.a[4] = (mat2x3(6.0, 7.0, -8.0, 3.0, 9.0, 9.0));
	blockB.b = (bvec2(true, false));
	g[0] = (mat3x4(5.0, -6.0, -8.0, -1.0, 0.0, 0.0, 9.0, -7.0, -3.0, -6.0, -7.0, 0.0));
	g[1] = (mat3x4(-5.0, 1.0, 8.0, 4.0, 3.0, -2.0, 2.0, 7.0, -7.0, -3.0, 8.0, -7.0));
}
#version 450
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
	layout(offset = 0) mediump float a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp uint b;
	layout(offset = 4) i16vec3 c;
	layout(offset = 10) int16_t d;
	layout(offset = 12) float16_t e;
} blockC[3];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec4 f[1];
	layout(offset = 16) int16_t g[1];
	layout(offset = 20) mediump vec2 h;
	layout(offset = 32) bvec4 i;
} blockD[2];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) bvec2 j;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((a), 0.0) && allOk;
	allOk = compare_int16_t(int(blockC[0].d), 5) && allOk;
	allOk = compare_int16_t(int(blockC[1].d), 4) && allOk;
	allOk = compare_int16_t(int(blockC[2].d), 8) && allOk;
	allOk = compare_bvec4((blockD[0].f[0]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_int16_t(int(blockD[0].g[0]), -5) && allOk;
	allOk = compare_vec2((blockD[0].h), vec2(-4.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockD[1].f[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_int16_t(int(blockD[1].g[0]), 1) && allOk;
	allOk = compare_vec2((blockD[1].h), vec2(3.0, -9.0)) && allOk;
	allOk = compare_bvec2((blockE.j), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (6.0);
	blockC[0].b = (7u);
	blockC[0].c = i16vec3(ivec3(0, 3, -7));
	blockC[0].d = int16_t(6);
	blockC[0].e = float16_t(-7.0);
	blockC[1].b = (7u);
	blockC[1].c = i16vec3(ivec3(-8, -4, -6));
	blockC[1].d = int16_t(3);
	blockC[1].e = float16_t(-2.0);
	blockC[2].b = (2u);
	blockC[2].c = i16vec3(ivec3(-2, 6, 7));
	blockC[2].d = int16_t(-5);
	blockC[2].e = float16_t(-5.0);
	blockD[0].f[0] = (bvec4(false, false, true, true));
	blockD[0].h = (vec2(-2.0, -7.0));
	blockD[0].i = (bvec4(true, true, false, true));
	blockD[1].f[0] = (bvec4(false, true, true, true));
	blockD[1].h = (vec2(4.0, 2.0));
	blockD[1].i = (bvec4(true, false, true, true));
	blockE.j = (bvec2(false, false));
}
#version 450
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
	layout(offset = 0) f16vec4 a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) uint16_t b;
	layout(offset = 4) highp int c[1];
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) u16vec4 d;
	layout(offset = 8) bool e;
	layout(offset = 16) lowp ivec4 f;
	layout(offset = 32) i16vec3 g;
	layout(offset = 40) bool h;
} blockD[3];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) highp vec3 i;
	layout(offset = 16) lowp vec4 j;
	layout(offset = 32) lowp uvec4 k;
	layout(offset = 48) f16vec4 l;
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(a), vec4(-9.0, 1.0, 0.0, -9.0)) && allOk;
	allOk = compare_uint16_t(uint(blockC.b), 6u) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[0].d), uvec4(4u, 1u, 2u, 5u)) && allOk;
	allOk = compare_bool((blockD[0].e), false) && allOk;
	allOk = compare_i16vec3(ivec3(blockD[0].g), ivec3(-2, 4, 3)) && allOk;
	allOk = compare_bool((blockD[0].h), false) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[1].d), uvec4(3u, 8u, 4u, 3u)) && allOk;
	allOk = compare_bool((blockD[1].e), true) && allOk;
	allOk = compare_i16vec3(ivec3(blockD[1].g), ivec3(6, -1, 0)) && allOk;
	allOk = compare_bool((blockD[1].h), true) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[2].d), uvec4(0u, 5u, 4u, 9u)) && allOk;
	allOk = compare_bool((blockD[2].e), true) && allOk;
	allOk = compare_i16vec3(ivec3(blockD[2].g), ivec3(-4, -6, 4)) && allOk;
	allOk = compare_bool((blockD[2].h), false) && allOk;
	allOk = compare_vec3((blockE[0].i), vec3(-6.0, -4.0, 6.0)) && allOk;
	allOk = compare_uvec4((blockE[0].k), uvec4(0u, 1u, 1u, 7u)) && allOk;
	allOk = compare_f16vec4(vec4(blockE[0].l), vec4(-6.0, -1.0, 7.0, 8.0)) && allOk;
	allOk = compare_vec3((blockE[1].i), vec3(7.0, -1.0, 6.0)) && allOk;
	allOk = compare_uvec4((blockE[1].k), uvec4(2u, 2u, 4u, 4u)) && allOk;
	allOk = compare_f16vec4(vec4(blockE[1].l), vec4(2.0, 3.0, 4.0, 7.0)) && allOk;
	allOk = compare_vec3((blockE[2].i), vec3(2.0, -3.0, 5.0)) && allOk;
	allOk = compare_uvec4((blockE[2].k), uvec4(1u, 4u, 1u, 0u)) && allOk;
	allOk = compare_f16vec4(vec4(blockE[2].l), vec4(-7.0, 4.0, -5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = f16vec4(vec4(-4.0, 7.0, 8.0, 2.0));
	blockC.b = uint16_t(9u);
	blockC.c[0] = (-4);
	blockD[0].d = u16vec4(uvec4(0u, 9u, 2u, 0u));
	blockD[0].e = (true);
	blockD[0].f = (ivec4(6, 8, 3, -4));
	blockD[0].h = (false);
	blockD[1].d = u16vec4(uvec4(6u, 8u, 9u, 0u));
	blockD[1].e = (true);
	blockD[1].f = (ivec4(3, 0, -9, 3));
	blockD[1].h = (true);
	blockD[2].d = u16vec4(uvec4(8u, 3u, 7u, 0u));
	blockD[2].e = (false);
	blockD[2].f = (ivec4(1, 8, -1, 7));
	blockD[2].h = (false);
	blockE[0].i = (vec3(-9.0, -8.0, 7.0));
	blockE[0].j = (vec4(-8.0, 6.0, -3.0, 9.0));
	blockE[0].l = f16vec4(vec4(0.0, 4.0, -4.0, -6.0));
	blockE[1].i = (vec3(5.0, 0.0, -4.0));
	blockE[1].j = (vec4(-2.0, -6.0, -9.0, -7.0));
	blockE[1].l = f16vec4(vec4(-8.0, -4.0, -4.0, -3.0));
	blockE[2].i = (vec3(4.0, 8.0, 3.0));
	blockE[2].j = (vec4(8.0, 8.0, -6.0, 9.0));
	blockE[2].l = f16vec4(vec4(-6.0, -3.0, 4.0, 8.0));
}
#version 450
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
	layout(offset = 16) bvec4 b;
	layout(offset = 32) int16_t c;
	layout(offset = 36) lowp ivec3 d;
	layout(offset = 48) u16vec2 e;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp ivec4 f;
} blockC;

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(3, 8)) && allOk;
	allOk = compare_bvec4((blockB.b), bvec4(false, false, false, true)) && allOk;
	allOk = compare_ivec3((blockB.d), ivec3(-6, 7, 9)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.e), uvec2(6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(-5, -4));
	blockB.b = (bvec4(true, false, true, false));
	blockB.c = int16_t(3);
	blockB.d = (ivec3(-6, -4, -5));
	blockB.e = u16vec2(uvec2(8u, 8u));
	blockC.f = (ivec4(-3, 1, 9, -5));
}
#version 450
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
	lowp mat3x4 a;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

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

layout(scalar, binding = 1) buffer BlockB
{
	u16vec4 a[];
} blockB;

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = u16vec4(uvec4(9u, 1u, 7u, 1u));
	blockB.a[1] = u16vec4(uvec4(4u, 6u, 3u, 3u));
	blockB.a[2] = u16vec4(uvec4(3u, 2u, 8u, 5u));
	blockB.a[3] = u16vec4(uvec4(4u, 7u, 1u, 1u));
	blockB.a[4] = u16vec4(uvec4(3u, 8u, 9u, 2u));
	blockB.a[5] = u16vec4(uvec4(4u, 4u, 9u, 2u));
	blockB.a[6] = u16vec4(uvec4(1u, 4u, 9u, 6u));
	blockB.a[7] = u16vec4(uvec4(5u, 8u, 7u, 1u));
}
#version 450
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
	i16vec4 a;
	lowp uvec4 b[1];
	lowp mat3x2 c;
	float16_t d;
	bvec3 e[1];
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB[nonuniformEXT(0)].a), ivec4(1, -5, -9, -5)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(0)].e[0]), bvec3(true, false, true)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[nonuniformEXT(1)].a), ivec4(4, -2, 9, 2)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(1)].e[0]), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b[0] = (uvec4(0u, 4u, 9u, 0u));
	blockB[nonuniformEXT(0)].c = (mat3x2(-7.0, 5.0, 3.0, 4.0, 7.0, 8.0));
	blockB[nonuniformEXT(0)].e[0] = (bvec3(true, true, false));
	blockB[nonuniformEXT(1)].b[0] = (uvec4(9u, 8u, 7u, 8u));
	blockB[nonuniformEXT(1)].c = (mat3x2(7.0, -9.0, -5.0, 5.0, 3.0, 7.0));
	blockB[nonuniformEXT(1)].e[0] = (bvec3(true, true, false));
}
#version 450
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
	bool a;
	highp float b;
	mediump float c;
};
layout(std430, binding = 2) buffer BlockC
{
	uint8_t d;
	highp int e;
	mediump uint f;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	uint8_t g[1];
	highp uint h;
	bool i;
	bool j;
	mediump int k;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((a), true) && allOk;
	allOk = compare_float((b), 0.0) && allOk;
	allOk = compare_float((c), -9.0) && allOk;
	allOk = compare_uint8_t(uint(blockC.d), 3u) && allOk;
	allOk = compare_uint((blockC.f), 8u) && allOk;
	allOk = compare_uint8_t(uint(g[0]), 1u) && allOk;
	allOk = compare_bool((j), false) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (true);
	b = (-3.0);
	blockC.d = uint8_t(5u);
	blockC.e = (7);
	blockC.f = (5u);
	h = (5u);
	j = (false);
	k = (-6);
}
#version 450
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
	u8vec4 a[1];
	lowp ivec3 b;
	highp ivec2 c;
	mediump uvec3 d;
	i8vec3 e;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	mediump uvec3 f;
	mediump float g;
	bvec4 h;
	bvec3 i[1];
	u8vec4 j;
};
layout(std430, binding = 3) buffer BlockD
{
	bool k;
	mediump ivec4 l;
	highp ivec3 m;
	u8vec4 n;
	i8vec3 o;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.a[0]), uvec4(0u, 2u, 0u, 4u)) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(-4, -6)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e), ivec3(1, 6, 5)) && allOk;
	allOk = compare_uvec3((f), uvec3(2u, 3u, 1u)) && allOk;
	allOk = compare_float((g), -9.0) && allOk;
	allOk = compare_u8vec4(uvec4(j), uvec4(6u, 2u, 0u, 8u)) && allOk;
	allOk = compare_ivec4((l), ivec4(0, 2, 0, 6)) && allOk;
	allOk = compare_ivec3((m), ivec3(2, 3, -5)) && allOk;
	allOk = compare_i8vec3(ivec3(o), ivec3(4294967290, 4294967287, 4294967288)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = u8vec4(uvec4(4u, 1u, 0u, 6u));
	blockB.c = (ivec2(3, -7));
	blockB.d = (uvec3(5u, 9u, 9u));
	f = (uvec3(8u, 7u, 9u));
	j = u8vec4(uvec4(0u, 5u, 5u, 4u));
	k = (true);
	l = (ivec4(-6, -2, -8, 5));
	m = (ivec3(-4, 8, -5));
}
#version 450
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
	uint8_t a;
	i8vec4 b[1];
	lowp uvec2 c;
	bool d;
};
layout(std140, binding = 2) buffer BlockC
{
	highp vec4 e;
	i8vec2 f;
	i8vec2 g;
	bvec2 h;
	mediump int i;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	mediump uvec2 j;
};
layout(std430, binding = 4) buffer BlockE
{
	u8vec3 k;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(b[0]), ivec4(6, 4294967290, 4294967293, 4294967295)) && allOk;
	allOk = compare_uvec2((c), uvec2(5u, 4u)) && allOk;
	allOk = compare_bool((d), true) && allOk;
	allOk = compare_vec4((blockC.e), vec4(8.0, -4.0, -8.0, 8.0)) && allOk;
	allOk = compare_uvec2((j), uvec2(6u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(k), uvec3(2u, 6u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = uint8_t(7u);
	blockC.e = (vec4(-9.0, 2.0, 6.0, 1.0));
	blockC.g = i8vec2(ivec2(9, 4294967293));
	j = (uvec2(0u, 1u));
	k = u8vec3(uvec3(8u, 6u, 0u));
}
#version 450
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
	highp float a;
	u8vec3 b[1];
};
layout(std430, binding = 2) buffer BlockC
{
	u8vec2 c;
	lowp vec4 d;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(b[0]), uvec3(4u, 2u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.c), uvec2(9u, 2u)) && allOk;
	allOk = compare_vec4((blockC.d), vec4(-4.0, -5.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (-7.0);
	b[0] = u8vec3(uvec3(1u, 0u, 4u));
	blockC.c = u8vec2(uvec2(9u, 4u));
}
#version 450
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
	i8vec3 a;
	highp float b;
	u8vec4 c;
	u8vec4 d;
};
layout(std140, binding = 2) buffer BlockC
{
	mediump ivec4 e;
	i8vec3 f;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	mediump uvec4 g;
	lowp int h;
	uint8_t i;
	int8_t j;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((b), -9.0) && allOk;
	allOk = compare_u8vec4(uvec4(c), uvec4(2u, 4u, 4u, 0u)) && allOk;
	allOk = compare_ivec4((blockC.e), ivec4(-2, 6, 3, -6)) && allOk;
	allOk = compare_uvec4((blockD.g), uvec4(5u, 3u, 1u, 8u)) && allOk;
	allOk = compare_int((blockD.h), -6) && allOk;
	allOk = compare_uint8_t(uint(blockD.i), 5u) && allOk;
	allOk = compare_int8_t(int(blockD.j), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i8vec3(ivec3(4294967295, 4294967292, 2));
	b = (-1.0);
	c = u8vec4(uvec4(3u, 2u, 5u, 2u));
	blockC.e = (ivec4(-8, 9, -2, 5));
	blockD.h = (3);
	blockD.i = uint8_t(2u);
	blockD.j = int8_t(5);
}
#version 450
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
	highp mat3x4 a;
	highp mat4x3 b;
	bvec2 c;
	highp mat4x3 d;
	highp vec2 e;
};
layout(std140, binding = 2) buffer BlockC
{
	mediump ivec4 f;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	lowp mat4x3 g;
	lowp mat3 h;
	mediump float i;
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	bvec2 j;
	lowp mat4x2 k;
	mediump mat4x3 l[2];
	highp int m;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a, mat3x4(6.0, 8.0, 8.0, 0.0, -4.0, -5.0, 9.0, -4.0, -6.0, -1.0, -1.0, -2.0)) && allOk;
	allOk = compare_bvec2((c), bvec2(true, true)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(-1.0, -7.0, 7.0, -4.0, -3.0, 1.0, -4.0, -9.0, 1.0, -4.0, 0.0, 2.0)) && allOk;
	allOk = compare_vec2((e), vec2(0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockD.g, mat4x3(-5.0, -1.0, -9.0, -6.0, -9.0, -8.0, 6.0, -2.0, 3.0, 7.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(blockD.h, mat3(-2.0, -5.0, 4.0, 8.0, -9.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_float((blockD.i), -9.0) && allOk;
	allOk = compare_bvec2((j), bvec2(false, true)) && allOk;
	allOk = compare_mat4x2(k, mat4x2(8.0, -7.0, 9.0, -9.0, 2.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4x3(l[0], mat4x3(-6.0, -8.0, 5.0, -7.0, 8.0, -2.0, 6.0, 2.0, -9.0, -5.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x3(l[1], mat4x3(-7.0, -4.0, -9.0, 7.0, 6.0, 9.0, 8.0, -8.0, 8.0, 4.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x4(-5.0, -3.0, -2.0, 0.0, -6.0, 6.0, -6.0, 3.0, -7.0, 8.0, 5.0, -6.0));
	d = (mat4x3(3.0, -1.0, -6.0, -4.0, -5.0, 3.0, -5.0, 6.0, -6.0, -2.0, -8.0, 5.0));
	e = (vec2(-4.0, 8.0));
	blockC.f = (ivec4(-5, 2, -2, 8));
	blockD.g = (mat4x3(-1.0, -1.0, 1.0, 7.0, 8.0, 7.0, 0.0, -5.0, 6.0, 5.0, -6.0, -6.0));
	blockD.i = (-9.0);
	k = (mat4x2(-8.0, -7.0, 8.0, 2.0, 8.0, -1.0, -1.0, 3.0));
}
#version 450
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
	highp mat4x3 b[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp ivec2 c;
	mediump mat4x3 d[1];
	u8vec3 e;
	i8vec3 f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((c), ivec2(3, -4)) && allOk;
	allOk = compare_u8vec3(uvec3(e), uvec3(9u, 7u, 4u)) && allOk;
	allOk = compare_i8vec3(ivec3(f), ivec3(4294967290, 4294967294, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec2(true, true));
	b[0] = (mat4x3(0.0, 5.0, 9.0, -5.0, 4.0, 7.0, -1.0, 6.0, 5.0, 8.0, 6.0, 2.0));
	c = (ivec2(-7, -2));
	d[0] = (mat4x3(-4.0, -2.0, 4.0, -2.0, 3.0, 0.0, -8.0, 6.0, -7.0, 4.0, 6.0, -2.0));
	f = i8vec3(ivec3(9, 4294967294, 3));
}
#version 450
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
	highp mat4x2 mB;
};
struct sB
{
	mediump vec3 mA;
	sA mB;
	highp mat2 mC;
	highp mat3x2 mD;
};
struct sC
{
	i8vec3 mA;
};
struct sD
{
	sC mA;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	highp ivec4 a[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp uvec2 b;
	sB c;
	i8vec2 d;
	sD e;
	bvec4 f[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((a[0]), ivec4(2, 5, 9, -9)) && allOk;
	allOk = compare_uvec2((blockC.b), uvec2(2u, 4u)) && allOk;
	allOk = compare_vec3((blockC.c.mA), vec3(4.0, 5.0, 3.0)) && allOk;
	allOk = compare_ivec3((blockC.c.mB.mA), ivec3(7, 5, 1)) && allOk;
	allOk = compare_mat4x2(blockC.c.mB.mB, mat4x2(-2.0, 6.0, 3.0, -6.0, -9.0, -9.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat2(blockC.c.mC, mat2(8.0, -6.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockC.c.mD, mat3x2(-8.0, 9.0, -9.0, 8.0, -6.0, -5.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d), ivec2(4294967287, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.e.mA.mA), ivec3(4294967291, 3, 0)) && allOk;
	allOk = compare_bvec4((blockC.f[0]), bvec4(true, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (ivec4(-1, -4, 2, -1));
	blockC.b = (uvec2(3u, 2u));
	blockC.c.mA = (vec3(-5.0, 7.0, -5.0));
	blockC.c.mB.mA = (ivec3(5, -3, 4));
	blockC.c.mB.mB = (mat4x2(-8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0, 3.0));
	blockC.c.mC = (mat2(-2.0, 9.0, -6.0, 3.0));
	blockC.c.mD = (mat3x2(5.0, 5.0, 9.0, 3.0, -9.0, -1.0));
	blockC.d = i8vec2(ivec2(4294967291, 4294967288));
	blockC.e.mA.mA = i8vec3(ivec3(3, 0, 4294967290));
	blockC.f[0] = (bvec4(false, false, false, true));
}
#version 450
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
	int8_t mA;
};
struct sB
{
	u8vec2 mA;
};
struct sC
{
	i8vec2 mA;
	highp float mB;
	bvec2 mC;
	bool mD;
};
layout(std140, binding = 1) buffer BlockB
{
	lowp float a;
	sA b;
	mediump mat2x3 c[];
} blockB[1];
layout(std430, binding = 2) buffer BlockC
{
	bool d;
	sB e;
	lowp ivec2 f;
	mediump ivec2 g[];
};
layout(std140, binding = 3) readonly buffer BlockD
{
	bool h;
	sC i;
	u8vec3 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[0].a), -5.0) && allOk;
	allOk = compare_int8_t(int(blockB[0].b.mA), 4294967287) && allOk;
	allOk = compare_bool((d), false) && allOk;
	allOk = compare_u8vec2(uvec2(e.mA), uvec2(2u, 8u)) && allOk;
	allOk = compare_ivec2((f), ivec2(-3, 2)) && allOk;
	allOk = compare_bool((h), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].c[0] = (mat2x3(-4.0, -7.0, -3.0, -9.0, 1.0, 2.0));
	d = (true);
	e.mA = u8vec2(uvec2(6u, 4u));
	f = (ivec2(-5, -9));
	g[0] = (ivec2(-9, -7));
}
#version 450
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
	layout(offset = 4) highp vec2 b;
	layout(offset = 12) i8vec4 c;
	layout(offset = 16) mediump float d;
} blockB;
layout(binding = 2) readonly buffer BlockC
{
	layout(offset = 0) i8vec2 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.a), 4u) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.c), ivec4(7, 4294967295, 0, 4294967289)) && allOk;
	allOk = compare_float((blockB.d), -4.0) && allOk;
	allOk = compare_i8vec2(ivec2(e), ivec2(2, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec2(-6.0, -2.0));
	blockB.c = i8vec4(ivec4(5, 1, 4294967290, 4294967291));
	blockB.d = (-1.0);
}
#version 450
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
	layout(offset = 4) lowp ivec3 b;
	layout(offset = 16) highp uvec3 c;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i8vec4 d;
	layout(offset = 4) mediump uint e;
	layout(offset = 16) bvec3 f;
	layout(offset = 28) i8vec4 g[1];
} blockC;

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(a), ivec4(2, 0, 3, 9)) && allOk;
	allOk = compare_ivec3((b), ivec3(0, 2, 4)) && allOk;
	allOk = compare_uvec3((c), uvec3(7u, 0u, 1u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d), ivec4(1, 4294967288, 9, 8)) && allOk;
	allOk = compare_uint((blockC.e), 9u) && allOk;
	allOk = compare_bvec3((blockC.f), bvec3(true, true, true)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.g[0]), ivec4(4294967293, 6, 5, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i8vec4(ivec4(2, 4294967288, 4294967294, 4));
	b = (ivec3(9, 4, -3));
	blockC.d = i8vec4(ivec4(9, 4294967292, 4294967287, 0));
	blockC.e = (9u);
	blockC.f = (bvec3(true, true, false));
	blockC.g[0] = i8vec4(ivec4(4294967295, 8, 4294967293, 4294967293));
}
#version 450
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
	u8vec4 mA;
	i8vec3 mB;
};
struct sB
{
	mediump ivec3 mA;
	sA mB;
};
struct sC
{
	highp mat4 mA;
	i8vec3 mB;
	lowp ivec2 mC;
	mediump vec4 mD;
};
struct sD
{
	highp ivec3 mA[4];
	i8vec3 mB;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	i8vec4 a;
	bvec2 b;
	sB c;
	sC d[];
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	lowp mat2x3 e;
	bvec3 f;
	bool g;
	sD h[];
} blockC[2];
layout(scalar, binding = 3) buffer BlockD
{
	bvec2 i;
	mediump mat4x3 j[];
} blockD[2];
layout(scalar, binding = 4) buffer BlockE
{
	highp int k;
	highp vec2 l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockD[0].j[0], mat4x3(-9.0, -3.0, 8.0, 4.0, 8.0, -7.0, -1.0, -9.0, 4.0, 9.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].j[1], mat4x3(9.0, -3.0, 4.0, -3.0, 9.0, -1.0, -2.0, -8.0, -1.0, -3.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].j[2], mat4x3(-1.0, 7.0, 6.0, 0.0, 7.0, 6.0, -2.0, -4.0, 0.0, 8.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].j[3], mat4x3(-3.0, 5.0, 2.0, 9.0, 4.0, -8.0, -1.0, 1.0, 0.0, 9.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].j[4], mat4x3(-4.0, 5.0, 9.0, 7.0, -8.0, -3.0, 7.0, -9.0, -8.0, 7.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].j[5], mat4x3(3.0, 8.0, 1.0, -8.0, 1.0, -3.0, 9.0, 3.0, -5.0, 4.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].j[6], mat4x3(-3.0, -4.0, -5.0, -2.0, 3.0, 0.0, -7.0, 2.0, 4.0, 3.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].j[7], mat4x3(-3.0, 1.0, -5.0, 7.0, -2.0, -2.0, 7.0, 5.0, 3.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].j[0], mat4x3(7.0, -4.0, 7.0, -5.0, -2.0, 6.0, -8.0, -8.0, -9.0, 2.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].j[1], mat4x3(6.0, -2.0, 3.0, -8.0, 0.0, -3.0, 4.0, -6.0, 9.0, 9.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].j[2], mat4x3(-7.0, 6.0, 7.0, -5.0, 2.0, -8.0, -1.0, 4.0, 8.0, -2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].j[3], mat4x3(-5.0, 1.0, -6.0, -6.0, -8.0, -1.0, -4.0, 8.0, 7.0, 5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].j[4], mat4x3(3.0, 1.0, -1.0, 0.0, 2.0, -6.0, 5.0, -8.0, -3.0, -9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].j[5], mat4x3(3.0, 9.0, 0.0, -6.0, 6.0, 2.0, 9.0, 6.0, 1.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].j[6], mat4x3(3.0, -3.0, 0.0, 1.0, 8.0, -9.0, 3.0, 7.0, -3.0, -2.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].j[7], mat4x3(0.0, 5.0, -8.0, -1.0, 9.0, -3.0, 3.0, -2.0, -3.0, 2.0, 7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec2(false, true));
	blockB.c.mA = (ivec3(-4, 0, -8));
	blockB.c.mB.mA = u8vec4(uvec4(3u, 8u, 5u, 1u));
	blockB.c.mB.mB = i8vec3(ivec3(3, 4294967288, 4294967288));
	blockC[0].e = (mat2x3(-2.0, -7.0, 0.0, 8.0, -7.0, 0.0));
	blockC[0].f = (bvec3(false, true, false));
	blockC[0].g = (true);
	blockC[0].h[0].mA[0] = (ivec3(5, -1, 5));
	blockC[0].h[0].mA[1] = (ivec3(-5, -4, 9));
	blockC[0].h[0].mA[2] = (ivec3(7, -6, -8));
	blockC[0].h[0].mA[3] = (ivec3(-4, -1, 5));
	blockC[0].h[0].mB = i8vec3(ivec3(4294967294, 4294967287, 2));
	blockC[0].h[1].mA[0] = (ivec3(-7, -6, 8));
	blockC[0].h[1].mA[1] = (ivec3(-7, -3, 2));
	blockC[0].h[1].mA[2] = (ivec3(6, -8, -1));
	blockC[0].h[1].mA[3] = (ivec3(7, 7, 6));
	blockC[0].h[1].mB = i8vec3(ivec3(9, 4294967287, 4294967295));
	blockC[1].e = (mat2x3(0.0, -1.0, -2.0, -7.0, 8.0, 3.0));
	blockC[1].f = (bvec3(false, true, true));
	blockC[1].g = (true);
	blockC[1].h[0].mA[0] = (ivec3(6, 0, -3));
	blockC[1].h[0].mA[1] = (ivec3(-7, -3, -1));
	blockC[1].h[0].mA[2] = (ivec3(-3, -7, 1));
	blockC[1].h[0].mA[3] = (ivec3(-6, 6, 6));
	blockC[1].h[0].mB = i8vec3(ivec3(4294967292, 3, 4294967291));
	blockC[1].h[1].mA[0] = (ivec3(3, -4, -9));
	blockC[1].h[1].mA[1] = (ivec3(3, 2, -8));
	blockC[1].h[1].mA[2] = (ivec3(8, 1, 7));
	blockC[1].h[1].mA[3] = (ivec3(5, 0, 4));
	blockC[1].h[1].mB = i8vec3(ivec3(4294967295, 4294967294, 0));
	blockC[1].h[2].mA[0] = (ivec3(6, -9, -9));
	blockC[1].h[2].mA[1] = (ivec3(6, 5, -5));
	blockC[1].h[2].mA[2] = (ivec3(7, -7, 2));
	blockC[1].h[2].mA[3] = (ivec3(7, -9, 0));
	blockC[1].h[2].mB = i8vec3(ivec3(3, 4294967291, 4294967291));
	blockC[1].h[3].mA[0] = (ivec3(6, -9, -9));
	blockC[1].h[3].mA[1] = (ivec3(3, -2, 4));
	blockC[1].h[3].mA[2] = (ivec3(-5, 2, -2));
	blockC[1].h[3].mA[3] = (ivec3(-2, -2, 7));
	blockC[1].h[3].mB = i8vec3(ivec3(4294967287, 3, 4294967293));
	blockC[1].h[4].mA[0] = (ivec3(7, -5, 9));
	blockC[1].h[4].mA[1] = (ivec3(-6, 3, -4));
	blockC[1].h[4].mA[2] = (ivec3(-4, -6, 3));
	blockC[1].h[4].mA[3] = (ivec3(-3, 7, -5));
	blockC[1].h[4].mB = i8vec3(ivec3(4294967288, 1, 9));
	blockC[1].h[5].mA[0] = (ivec3(3, -7, -8));
	blockC[1].h[5].mA[1] = (ivec3(2, 0, -9));
	blockC[1].h[5].mA[2] = (ivec3(1, 1, 8));
	blockC[1].h[5].mA[3] = (ivec3(3, 2, 2));
	blockC[1].h[5].mB = i8vec3(ivec3(6, 4294967287, 4294967287));
	blockC[1].h[6].mA[0] = (ivec3(-8, -3, 0));
	blockC[1].h[6].mA[1] = (ivec3(1, -1, -3));
	blockC[1].h[6].mA[2] = (ivec3(1, 2, -3));
	blockC[1].h[6].mA[3] = (ivec3(-2, 2, -3));
	blockC[1].h[6].mB = i8vec3(ivec3(3, 4294967290, 2));
	blockD[0].i = (bvec2(true, false));
	blockD[0].j[0] = (mat4x3(-9.0, 8.0, -4.0, -1.0, -7.0, -2.0, -5.0, -6.0, 1.0, 9.0, 2.0, 5.0));
	blockD[0].j[1] = (mat4x3(9.0, -6.0, 2.0, -9.0, 5.0, 5.0, -8.0, 0.0, -2.0, -5.0, -2.0, -5.0));
	blockD[0].j[2] = (mat4x3(-7.0, -7.0, 8.0, -1.0, -1.0, 3.0, 7.0, 1.0, 9.0, -4.0, -8.0, -2.0));
	blockD[0].j[3] = (mat4x3(0.0, 9.0, 9.0, -1.0, 2.0, -8.0, 7.0, -4.0, -3.0, 6.0, 5.0, -9.0));
	blockD[0].j[4] = (mat4x3(6.0, -2.0, 8.0, 4.0, 5.0, 2.0, -5.0, -6.0, 4.0, 5.0, 1.0, -8.0));
	blockD[0].j[5] = (mat4x3(-8.0, -8.0, -8.0, 8.0, -2.0, -9.0, -6.0, -4.0, 4.0, 1.0, -9.0, 5.0));
	blockD[0].j[6] = (mat4x3(-2.0, 7.0, -4.0, -3.0, 4.0, 1.0, 3.0, -1.0, -9.0, -1.0, -8.0, -3.0));
	blockD[0].j[7] = (mat4x3(-7.0, -8.0, 9.0, 2.0, -5.0, 2.0, 2.0, 5.0, -6.0, 7.0, 3.0, -6.0));
	blockD[1].i = (bvec2(true, false));
	blockD[1].j[0] = (mat4x3(4.0, 4.0, 3.0, 3.0, 5.0, 5.0, -5.0, 7.0, -9.0, 4.0, -8.0, -7.0));
	blockD[1].j[1] = (mat4x3(7.0, -7.0, -6.0, 5.0, -8.0, -8.0, -2.0, 7.0, 1.0, -6.0, 7.0, -1.0));
	blockD[1].j[2] = (mat4x3(-2.0, -2.0, 6.0, 0.0, 4.0, 2.0, -3.0, -9.0, 2.0, -7.0, 1.0, 6.0));
	blockD[1].j[3] = (mat4x3(-9.0, -7.0, 1.0, -7.0, -4.0, -6.0, -5.0, 3.0, 2.0, -6.0, -2.0, -1.0));
	blockD[1].j[4] = (mat4x3(0.0, -6.0, 9.0, 3.0, 6.0, -8.0, 7.0, -6.0, 2.0, -4.0, -9.0, -4.0));
	blockD[1].j[5] = (mat4x3(-6.0, 8.0, 3.0, 7.0, -4.0, -9.0, 6.0, 6.0, -8.0, 6.0, 3.0, -4.0));
	blockD[1].j[6] = (mat4x3(1.0, 9.0, 0.0, -5.0, 7.0, 3.0, 7.0, -5.0, 9.0, 6.0, -7.0, 9.0));
	blockD[1].j[7] = (mat4x3(-1.0, 5.0, -6.0, 4.0, -3.0, 1.0, 4.0, -5.0, -5.0, 5.0, 7.0, -2.0));
	k = (4);
}
#version 450
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
	i8vec2 a;
	bool b;
	u8vec2 c[];
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(a), ivec2(5, 7)) && allOk;
	allOk = compare_bool((b), false) && allOk;
	allOk = compare_u8vec2(uvec2(c[0]), uvec2(2u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(c[1]), uvec2(2u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(c[2]), uvec2(3u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(c[3]), uvec2(5u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(c[4]), uvec2(1u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i8vec2(ivec2(4294967292, 4294967288));
	c[0] = u8vec2(uvec2(9u, 5u));
	c[1] = u8vec2(uvec2(3u, 6u));
	c[2] = u8vec2(uvec2(1u, 7u));
	c[3] = u8vec2(uvec2(0u, 1u));
	c[4] = u8vec2(uvec2(8u, 5u));
}
#version 450
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
	u8vec2 a;
	lowp mat4x2 b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (mat4x2(2.0, -1.0, 2.0, 2.0, -5.0, 7.0, -5.0, 5.0));
	blockB[nonuniformEXT(1)].b = (mat4x2(-8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0, 3.0));
	blockB[nonuniformEXT(2)].b = (mat4x2(-6.0, 3.0, 5.0, 5.0, 9.0, 3.0, -9.0, -1.0));
	blockB[nonuniformEXT(3)].b = (mat4x2(3.0, 0.0, -6.0, -8.0, -3.0, 8.0, 2.0, -4.0));
}
#version 450
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

}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(6.0, -8.0, -3.0, 3.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], 3.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var), vec4(8.0, -4.0, -9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], -2.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_vec2(var[0], vec2(6.0, -2.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	uint16_t var;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(var), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(7.0, 8.0, -7.0, -8.0, -2.0, -1.0, 7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(-4.0, -2.0, 8.0, 8.0, 0.0, -3.0, -1.0, -2.0, 0.0, 6.0, -6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	i16vec2 var[3];
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(var[0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2]), ivec2(-4, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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
	allOk = compare_mat2(block.var, mat2(-6.0, 7.0, 5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(2.0, 1.0, -7.0, -9.0));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(1.0, 7.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(-1.0, 0.0, -7.0, 5.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], 8.0) && allOk;
	allOk = compare_float(block.var[0][2], 7.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][2], 7.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-3.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(3.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(1.0, 6.0, 9.0));
	block.var[1] = (vec3(-7.0, -7.0, -7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[2][0], 2.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-3.0, -3.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-2.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-4.0, 3.0));
	block.var[1] = (vec2(-8.0, -8.0));
	block.var[2] = (vec2(-6.0, 2.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -5.0) && allOk;
	allOk = compare_float(block.var[0][1], 5.0) && allOk;
	allOk = compare_float(block.var[0][2], -5.0) && allOk;
	allOk = compare_float(block.var[0][3], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], -6.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][2], 3.0) && allOk;
	allOk = compare_float(block.var[1][3], -6.0) && allOk;
	allOk = compare_float(block.var[2][0], -3.0) && allOk;
	allOk = compare_float(block.var[2][1], 7.0) && allOk;
	allOk = compare_float(block.var[2][2], -8.0) && allOk;
	allOk = compare_float(block.var[2][3], 4.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-5.0, 5.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-6.0, -1.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-3.0, 7.0, -8.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-3.0, -8.0, -4.0, -6.0));
	block.var[1] = (vec4(8.0, -1.0, 9.0, -1.0));
	block.var[2] = (vec4(1.0, 3.0, -5.0, 5.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(6.0, 3.0, -5.0, -5.0, -3.0, 3.0, -1.0, 2.0, 2.0, -2.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(5.0, 3.0, -6.0, 0.0, -5.0, -3.0, 7.0, -5.0, -3.0, 6.0, 8.0, 7.0));
}
#version 450
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
	int16_t var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.var), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = int16_t(6);
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	mediump uvec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((block.var), uvec3(8u, 5u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec3(6u, 0u, 5u));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[2][0], 2.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-3.0, -3.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-2.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-4.0, 3.0));
	block.var[1] = (vec2(-8.0, -8.0));
	block.var[2] = (vec2(-6.0, 2.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(2.0, 0.0, 2.0, 1.0, -5.0, 7.0, -3.0, -5.0, 8.0, -5.0, 8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(4.0, -7.0, 1.0, -4.0, 5.0, 4.0, 1.0, 1.0, 1.0, 8.0, 9.0, 5.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], 0.0) && allOk;
	allOk = compare_float(block.var[0][2], -9.0) && allOk;
	allOk = compare_float(block.var[1][0], -9.0) && allOk;
	allOk = compare_float(block.var[1][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][2], 5.0) && allOk;
	allOk = compare_float(block.var[2][0], 3.0) && allOk;
	allOk = compare_float(block.var[2][1], -9.0) && allOk;
	allOk = compare_float(block.var[2][2], -4.0) && allOk;
	allOk = compare_float(block.var[3][0], -8.0) && allOk;
	allOk = compare_float(block.var[3][1], -7.0) && allOk;
	allOk = compare_float(block.var[3][2], 2.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-3.0, 0.0, -9.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-9.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(3.0, -9.0, -4.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-8.0, -7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-1.0, 0.0, 6.0));
	block.var[1] = (vec3(-6.0, -6.0, -2.0));
	block.var[2] = (vec3(5.0, 4.0, -9.0));
	block.var[3] = (vec3(-4.0, -2.0, 2.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat3x4(block.var, mat3x4(-3.0, 1.0, 4.0, -6.0, 6.0, 8.0, -7.0, -4.0, -8.0, -2.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var = (mat3x4(1.0, -5.0, 8.0, 0.0, 5.0, 6.0, 6.0, 8.0, -8.0, -6.0, -7.0, 0.0));
}
#version 450
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
	u8vec2 var;
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
	allOk = compare_u8vec2(uvec2(block.var), uvec2(0u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint8_t(7u);
	block.var = u8vec2(uvec2(7u, 9u));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(3.0, 1.0, -4.0, -2.0));
	block.var[1] = (mat2(1.0, -4.0, -1.0, -3.0));
	block.var[2] = (mat2(-8.0, 5.0, -6.0, -2.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
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
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	block.var[1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	block.var[2] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(2.0, -7.0, 8.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(5.0, -2.0, 1.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(6.0, 7.0, 2.0, -2.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	block.var[1] = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	block.var[2] = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(4.0, 5.0, -6.0));
	block.var[0][1] = (vec3(0.0, -8.0, -2.0));
	block.var[1][0] = (vec3(8.0, 8.0, 0.0));
	block.var[1][1] = (vec3(3.0, -6.0, -6.0));
	block.var[2][0] = (vec3(-1.0, 2.0, -9.0));
	block.var[2][1] = (vec3(1.0, 3.0, 2.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	block.var[1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	block.var[2] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
}
#version 450
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
	i8vec4 var[3];
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
    if (allOk)
        ac_numPassed++;

	block.var[0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	block.var[1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	block.var[2] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat2x3(block.var[0], mat2x3(-3.0, -7.0, 1.0, -1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(7.0, -9.0, 1.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-9.0, 1.0, -7.0, -5.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0] = (mat2x3(-7.0, 9.0, -3.0, 0.0, 7.0, 1.0));
	block.var[1] = (mat2x3(-4.0, 1.0, 9.0, 6.0, -4.0, -1.0));
	block.var[2] = (mat2x3(-8.0, 4.0, 7.0, 8.0, 0.0, 9.0));
}
#version 450
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
	highp uvec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block.var[0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[2]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[3]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[4]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[5]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[6]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[7]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[8]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[9]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[10]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[11]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[12]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[13]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[14]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[15]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[16]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[17]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[18]), uvec2(8u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (uvec2(6u, 1u));
	block.var[1] = (uvec2(8u, 1u));
	block.var[2] = (uvec2(7u, 4u));
	block.var[3] = (uvec2(6u, 6u));
	block.var[4] = (uvec2(5u, 8u));
	block.var[5] = (uvec2(4u, 7u));
	block.var[6] = (uvec2(8u, 4u));
	block.var[7] = (uvec2(6u, 3u));
	block.var[8] = (uvec2(6u, 0u));
	block.var[9] = (uvec2(3u, 5u));
	block.var[10] = (uvec2(2u, 4u));
	block.var[11] = (uvec2(7u, 8u));
	block.var[12] = (uvec2(6u, 2u));
	block.var[13] = (uvec2(6u, 0u));
	block.var[14] = (uvec2(3u, 2u));
	block.var[15] = (uvec2(5u, 1u));
	block.var[16] = (uvec2(7u, 2u));
	block.var[17] = (uvec2(3u, 6u));
	block.var[18] = (uvec2(0u, 1u));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(7.0, -4.0, -4.0, -6.0, 9.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(-2.0, 5.0, 6.0, 4.0, -6.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(-5.0, 9.0, -4.0, -6.0, 4.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(-4.0, 9.0, -1.0, -6.0, 5.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(-7.0, -7.0, -9.0, 9.0, 5.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(-6.0, -5.0, -7.0, -3.0, 6.0, -7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(7.0, -9.0, -5.0, -3.0, -6.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(-4.0, -9.0, 9.0, -7.0, -6.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(8.0, 6.0, 7.0, -6.0, 0.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(7.0, -5.0, 4.0, -9.0, 5.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(2.0, 9.0, -6.0, -6.0, 2.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(-6.0, 9.0, -3.0, -1.0, 3.0, 8.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(-7.0, -7.0, -6.0, 2.0, 3.0, -7.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(8.0, -4.0, 1.0, 3.0, 4.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(6.0, -4.0, -6.0, 6.0, -8.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(1.0, 0.0, 3.0, -4.0, -6.0, 5.0, -1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	block.var[1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	block.var[2] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	block.var[3] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	block.var[4] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	block.var[5] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	block.var[6] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	block.var[7] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	block.var[8] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	block.var[9] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	block.var[10] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	block.var[11] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
	block.var[12] = (mat4x2(9.0, -8.0, 1.0, 3.0, 1.0, -5.0, -5.0, -5.0));
	block.var[13] = (mat4x2(2.0, -5.0, 1.0, 5.0, -5.0, 1.0, -2.0, -4.0));
	block.var[14] = (mat4x2(0.0, -1.0, -2.0, 7.0, 1.0, -5.0, -2.0, -9.0));
	block.var[15] = (mat4x2(-1.0, -5.0, -2.0, 4.0, 6.0, 1.0, -4.0, 9.0));
	block.var[16] = (mat4x2(3.0, -5.0, -9.0, -6.0, -1.0, 2.0, -9.0, 3.0));
	block.var[17] = (mat4x2(-9.0, 2.0, -3.0, -1.0, -3.0, -6.0, -9.0, 9.0));
	block.var[18] = (mat4x2(1.0, -8.0, 1.0, -6.0, 0.0, -2.0, 2.0, -8.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(-5.0, 7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(-9.0, 6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(-9.0, 7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(-8.0, 1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(-9.0, 9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(-5.0, -8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(8.0, 4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(7.0, -3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(9.0, 2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(8.0, 5.0, 9.0, 6.0, -3.0, 4.0, 6.0, -8.0, -9.0, -2.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(1.0, 7.0, -6.0, 3.0, 2.0, 9.0, -9.0, 1.0, 0.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(1.0, 0.0, 9.0, -2.0, -2.0, 1.0, 8.0, 0.0, 0.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(9.0, -5.0, 2.0, 8.0, -5.0, -3.0, -6.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(2.0, 0.0, -2.0, -7.0, 6.0, -9.0, 9.0, -6.0, 3.0, -2.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(-5.0, 4.0, 0.0, 2.0, 9.0, 7.0, -3.0, 3.0, 5.0, 2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(-8.0, -4.0, 5.0, -8.0, -2.0, -1.0, -3.0, 5.0, 7.0, -7.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	block.var[0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	block.var[0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	block.var[1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	block.var[1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	block.var[1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	block.var[2][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	block.var[2][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	block.var[2][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
	block.var[3][0] = (vec4(8.0, -2.0, 1.0, 1.0));
	block.var[3][1] = (vec4(-6.0, -1.0, -9.0, 6.0));
	block.var[3][2] = (vec4(7.0, -1.0, 1.0, -8.0));
	block.var[4][0] = (vec4(6.0, 8.0, -2.0, 7.0));
	block.var[4][1] = (vec4(1.0, -6.0, -3.0, 9.0));
	block.var[4][2] = (vec4(1.0, -6.0, 1.0, -6.0));
	block.var[5][0] = (vec4(3.0, -1.0, 5.0, -2.0));
	block.var[5][1] = (vec4(7.0, -1.0, -2.0, -3.0));
	block.var[5][2] = (vec4(-6.0, 4.0, -4.0, -1.0));
	block.var[6][0] = (vec4(-3.0, -3.0, 3.0, -7.0));
	block.var[6][1] = (vec4(2.0, 8.0, -4.0, 1.0));
	block.var[6][2] = (vec4(-1.0, 6.0, -4.0, 7.0));
	block.var[7][0] = (vec4(5.0, -8.0, -2.0, 6.0));
	block.var[7][1] = (vec4(-2.0, 8.0, -2.0, 2.0));
	block.var[7][2] = (vec4(3.0, 7.0, 0.0, 2.0));
	block.var[8][0] = (vec4(3.0, 9.0, 8.0, 5.0));
	block.var[8][1] = (vec4(2.0, -3.0, -7.0, 2.0));
	block.var[8][2] = (vec4(-1.0, 1.0, -4.0, -1.0));
	block.var[9][0] = (vec4(-6.0, -4.0, -1.0, -3.0));
	block.var[9][1] = (vec4(-8.0, 5.0, -4.0, -9.0));
	block.var[9][2] = (vec4(8.0, 3.0, -8.0, 0.0));
	block.var[10][0] = (vec4(7.0, -2.0, 0.0, 8.0));
	block.var[10][1] = (vec4(-9.0, 2.0, -3.0, -7.0));
	block.var[10][2] = (vec4(-5.0, 3.0, 9.0, -6.0));
	block.var[11][0] = (vec4(-7.0, -8.0, -8.0, -7.0));
	block.var[11][1] = (vec4(-9.0, 2.0, 4.0, -7.0));
	block.var[11][2] = (vec4(8.0, -7.0, 4.0, -8.0));
	block.var[12][0] = (vec4(0.0, 7.0, 3.0, -7.0));
	block.var[12][1] = (vec4(-7.0, 7.0, -4.0, -5.0));
	block.var[12][2] = (vec4(-8.0, -8.0, -7.0, 4.0));
	block.var[13][0] = (vec4(6.0, -3.0, 8.0, -1.0));
	block.var[13][1] = (vec4(-4.0, 8.0, 8.0, 1.0));
	block.var[13][2] = (vec4(-8.0, -7.0, 5.0, -9.0));
	block.var[14][0] = (vec4(1.0, -8.0, 2.0, -2.0));
	block.var[14][1] = (vec4(-8.0, -9.0, 1.0, -3.0));
	block.var[14][2] = (vec4(-4.0, 3.0, -9.0, 6.0));
	block.var[15][0] = (vec4(-8.0, 3.0, -5.0, 6.0));
	block.var[15][1] = (vec4(9.0, 2.0, -1.0, 8.0));
	block.var[15][2] = (vec4(-2.0, 5.0, -2.0, 6.0));
	block.var[16][0] = (vec4(1.0, 2.0, 8.0, -3.0));
	block.var[16][1] = (vec4(6.0, -3.0, -8.0, 2.0));
	block.var[16][2] = (vec4(-6.0, -8.0, 3.0, 3.0));
	block.var[17][0] = (vec4(0.0, 9.0, 4.0, -8.0));
	block.var[17][1] = (vec4(-7.0, 6.0, -4.0, -8.0));
	block.var[17][2] = (vec4(2.0, 9.0, 1.0, 0.0));
	block.var[18][0] = (vec4(3.0, 0.0, -5.0, -4.0));
	block.var[18][1] = (vec4(-9.0, -4.0, 0.0, -5.0));
	block.var[18][2] = (vec4(-9.0, -9.0, 6.0, -4.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-5.0, 3.0, -2.0, -8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(1.0, -5.0, -5.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(-2.0, 0.0, 7.0, 6.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(3.0, 6.0, -5.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(9.0, 2.0, 6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(-7.0, -2.0, -4.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(3.0, 9.0, 1.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-9.0, -2.0, 6.0, 8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(5.0, -2.0, 0.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(6.0, 8.0, -4.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(6.0, 6.0, -9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(5.0, -3.0, 6.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-2.0, -7.0, 9.0, 9.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(0.0, -6.0, -7.0, 2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(3.0, 6.0, -6.0, -5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(-9.0, -2.0, -3.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(0.0, 2.0, -1.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(-9.0, -7.0, 7.0, 0.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(7.0, 0.0, -9.0, 4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(-9.0, 8.0, 7.0, -9.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(-9.0, 3.0, 1.0, -2.0, 9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	block.var[0][0][1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	block.var[0][0][2] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
	block.var[0][1][0] = (mat2x3(-9.0, 1.0, 2.0, -3.0, 0.0, -3.0));
	block.var[0][1][1] = (mat2x3(-2.0, 3.0, -2.0, 5.0, -6.0, -7.0));
	block.var[0][1][2] = (mat2x3(-7.0, 3.0, -4.0, -6.0, -2.0, 6.0));
	block.var[1][0][0] = (mat2x3(7.0, -4.0, 4.0, -5.0, -1.0, 0.0));
	block.var[1][0][1] = (mat2x3(2.0, -5.0, 6.0, 7.0, -2.0, 4.0));
	block.var[1][0][2] = (mat2x3(-3.0, 7.0, 6.0, -3.0, -2.0, -6.0));
	block.var[1][1][0] = (mat2x3(-7.0, -3.0, 3.0, -9.0, 3.0, 8.0));
	block.var[1][1][1] = (mat2x3(-1.0, 7.0, 4.0, -9.0, -7.0, 2.0));
	block.var[1][1][2] = (mat2x3(1.0, -7.0, -2.0, 5.0, -6.0, -6.0));
	block.var[2][0][0] = (mat2x3(7.0, -3.0, 2.0, 8.0, -1.0, 2.0));
	block.var[2][0][1] = (mat2x3(2.0, -9.0, 3.0, 1.0, -7.0, -7.0));
	block.var[2][0][2] = (mat2x3(3.0, -3.0, -5.0, 4.0, -6.0, 8.0));
	block.var[2][1][0] = (mat2x3(-1.0, -2.0, 6.0, 9.0, 1.0, -6.0));
	block.var[2][1][1] = (mat2x3(6.0, 6.0, 5.0, 3.0, 4.0, 7.0));
	block.var[2][1][2] = (mat2x3(0.0, 9.0, -5.0, 3.0, -7.0, 1.0));
	block.var[3][0][0] = (mat2x3(7.0, -9.0, 2.0, -8.0, 9.0, 9.0));
	block.var[3][0][1] = (mat2x3(3.0, 5.0, 8.0, 5.0, -7.0, 6.0));
	block.var[3][0][2] = (mat2x3(3.0, 6.0, 6.0, 1.0, 2.0, -7.0));
	block.var[3][1][0] = (mat2x3(0.0, 6.0, 0.0, 6.0, 4.0, -1.0));
	block.var[3][1][1] = (mat2x3(-2.0, 2.0, 3.0, 8.0, 3.0, -5.0));
	block.var[3][1][2] = (mat2x3(1.0, -6.0, -1.0, 5.0, 9.0, -6.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(8.0, -7.0, 1.0, -9.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(3.0, 8.0, -5.0, -1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(9.0, -5.0, 0.0, 0.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-2.0, -1.0, 3.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(5.0, 8.0, 1.0, -7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(0.0, 9.0, -1.0, -8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(-8.0, -1.0, 3.0, -7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-7.0, 6.0, -9.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(-7.0, 1.0, 7.0, 2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-6.0, 9.0, 9.0, -2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(8.0, -6.0, -2.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(-2.0, -9.0, -1.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(5.0, -9.0, 5.0, 6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(4.0, 1.0, -5.0, 7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(6.0, 2.0, -9.0, 9.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(-5.0, -9.0, -3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(-9.0, -1.0, -9.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(-6.0, -1.0, 7.0, -5.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(4.0, -5.0, 0.0, 0.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(6.0, 8.0, 9.0, 5.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(-6.0, -1.0, -9.0, 3.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	block.var[0][0][1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	block.var[0][0][2] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
	block.var[0][1][0] = (mat2x3(-1.0, -7.0, 4.0, 3.0, 8.0, -7.0));
	block.var[0][1][1] = (mat2x3(-1.0, -2.0, 2.0, 6.0, -5.0, 4.0));
	block.var[0][1][2] = (mat2x3(-8.0, 0.0, -4.0, 7.0, -5.0, -1.0));
	block.var[1][0][0] = (mat2x3(6.0, 9.0, 2.0, -3.0, 0.0, 5.0));
	block.var[1][0][1] = (mat2x3(-9.0, 6.0, -3.0, 9.0, -7.0, 2.0));
	block.var[1][0][2] = (mat2x3(8.0, -3.0, 7.0, -9.0, 7.0, -1.0));
	block.var[1][1][0] = (mat2x3(4.0, -6.0, -1.0, -4.0, 7.0, 8.0));
	block.var[1][1][1] = (mat2x3(-1.0, 4.0, -9.0, -3.0, -5.0, 8.0));
	block.var[1][1][2] = (mat2x3(5.0, -4.0, -4.0, 8.0, 6.0, 4.0));
	block.var[2][0][0] = (mat2x3(-4.0, -3.0, -6.0, -1.0, -5.0, 7.0));
	block.var[2][0][1] = (mat2x3(1.0, 9.0, -7.0, 3.0, 3.0, 1.0));
	block.var[2][0][2] = (mat2x3(-4.0, -9.0, 4.0, -1.0, -4.0, 1.0));
	block.var[2][1][0] = (mat2x3(-9.0, -9.0, 0.0, 3.0, 6.0, -8.0));
	block.var[2][1][1] = (mat2x3(-7.0, -4.0, 3.0, -6.0, -7.0, -9.0));
	block.var[2][1][2] = (mat2x3(-9.0, 8.0, -8.0, 7.0, 8.0, -9.0));
	block.var[3][0][0] = (mat2x3(-7.0, 0.0, -4.0, -6.0, -1.0, -1.0));
	block.var[3][0][1] = (mat2x3(5.0, -5.0, 0.0, -6.0, -9.0, -6.0));
	block.var[3][0][2] = (mat2x3(-2.0, -1.0, -6.0, -6.0, 3.0, -3.0));
	block.var[3][1][0] = (mat2x3(0.0, -8.0, -9.0, 3.0, 8.0, -4.0));
	block.var[3][1][1] = (mat2x3(6.0, -9.0, -1.0, 5.0, 7.0, -4.0));
	block.var[3][1][2] = (mat2x3(0.0, -7.0, -9.0, -2.0, -6.0, -1.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(5.0, 2.0, -1.0, 6.0, -6.0, 4.0, 2.0, 5.0, 9.0, 7.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-2.0, -5.0, 0.0, 0.0, 2.0, 5.0, 8.0, -5.0, 7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(-7.0, -9.0, 9.0, 1.0, -6.0, 3.0, 9.0, 6.0, -4.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(3.0, 2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(4.0, -6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(7.0, 9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(0.0, -4.0, 4.0, -6.0, 0.0, -7.0, -2.0, 2.0, 1.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-4.0, -6.0, -6.0, 3.0, -4.0, 7.0, -9.0, 0.0, 4.0, 0.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(-7.0, -8.0, -8.0, -8.0, 9.0, 7.0, -9.0, -6.0, -2.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(2.0, 6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(2.0, 6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(1.0, 9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-2.0, -9.0, 2.0, -8.0, -3.0, 1.0, -5.0, 1.0, 3.0, 1.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(3.0, -7.0, -4.0, -9.0, 6.0, 5.0, 0.0, -1.0, -4.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(-9.0, 4.0, 0.0, -9.0, 6.0, -2.0, -9.0, 9.0, 1.0, 8.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(-1.0, 0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(-8.0, -3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(-5.0, -2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(-4.0, -7.0, 1.0, 0.0, 6.0, -8.0, 9.0, -2.0, 3.0, 4.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(-6.0, 3.0, 7.0, 1.0, -9.0, -5.0, 4.0, 9.0, 4.0, -7.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(-8.0, -4.0, -3.0, -5.0, -2.0, -8.0, 2.0, -1.0, 4.0, 7.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	block.var[0][0][1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	block.var[0][0][2] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
	block.var[0][1][0] = (mat3x4(-7.0, 8.0, 5.0, -1.0, 0.0, 6.0, 7.0, -1.0, 3.0, 5.0, -7.0, 2.0));
	block.var[0][1][1] = (mat3x4(9.0, -2.0, -7.0, -4.0, 7.0, 9.0, 9.0, -2.0, -7.0, -3.0, 9.0, 9.0));
	block.var[0][1][2] = (mat3x4(4.0, -7.0, 5.0, -1.0, -8.0, -1.0, -1.0, 1.0, -1.0, 6.0, 6.0, 9.0));
	block.var[1][0][0] = (mat3x4(-9.0, 4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0));
	block.var[1][0][1] = (mat3x4(3.0, 1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0));
	block.var[1][0][2] = (mat3x4(1.0, 5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0));
	block.var[1][1][0] = (mat3x4(3.0, 1.0, 7.0, 6.0, 8.0, 1.0, 8.0, -5.0, -5.0, -9.0, -1.0, -9.0));
	block.var[1][1][1] = (mat3x4(-1.0, 6.0, 3.0, -9.0, -4.0, -5.0, 2.0, -2.0, -2.0, -2.0, -2.0, 2.0));
	block.var[1][1][2] = (mat3x4(-7.0, -4.0, 6.0, -9.0, 6.0, -3.0, -9.0, 6.0, 3.0, 2.0, -5.0, -9.0));
	block.var[2][0][0] = (mat3x4(-2.0, -7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0));
	block.var[2][0][1] = (mat3x4(-8.0, 8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0));
	block.var[2][0][2] = (mat3x4(6.0, -1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0));
	block.var[2][1][0] = (mat3x4(-5.0, 9.0, -5.0, 5.0, -4.0, 7.0, 7.0, -1.0, -9.0, 8.0, 2.0, -5.0));
	block.var[2][1][1] = (mat3x4(-4.0, 4.0, -6.0, 7.0, 7.0, 0.0, -4.0, -5.0, 3.0, -2.0, -4.0, -9.0));
	block.var[2][1][2] = (mat3x4(9.0, 0.0, -3.0, -8.0, 1.0, -4.0, 4.0, 3.0, 4.0, -8.0, 6.0, 7.0));
	block.var[3][0][0] = (mat3x4(5.0, 5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0));
	block.var[3][0][1] = (mat3x4(-4.0, 7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0));
	block.var[3][0][2] = (mat3x4(-1.0, 3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0));
	block.var[3][1][0] = (mat3x4(-6.0, -3.0, 9.0, 1.0, -6.0, 0.0, -9.0, -9.0, -2.0, -6.0, 0.0, 2.0));
	block.var[3][1][1] = (mat3x4(-4.0, 1.0, 0.0, -2.0, 8.0, 2.0, 9.0, 3.0, -5.0, -2.0, -4.0, 0.0));
	block.var[3][1][2] = (mat3x4(-3.0, -7.0, -4.0, 2.0, 1.0, -7.0, 2.0, 9.0, 1.0, -1.0, -2.0, 3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat3(block.var[0][0][0], mat3(1.0, -5.0, -1.0, 3.0, 7.0, 4.0, 7.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(7.0, -6.0, -4.0, 7.0, -1.0, -5.0, -8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(-3.0, 1.0, -3.0, -8.0, 8.0, 8.0, 2.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(8.0, 1.0, 1.0, 0.0, 9.0, 1.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-1.0, 5.0, 1.0, 5.0, -6.0, 3.0, -4.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(5.0, 9.0, 1.0, -5.0, -2.0, -1.0, -8.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(5.0, 5.0, -8.0, -1.0, 3.0, 1.0, -6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(0.0, 5.0, 8.0, -9.0, -8.0, -9.0, 3.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(9.0, 2.0, 5.0, 5.0, 5.0, -4.0, 4.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-8.0, -5.0, 4.0, -8.0, 6.0, 8.0, 6.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(-4.0, -5.0, 7.0, -7.0, -5.0, 8.0, -8.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(7.0, 2.0, 8.0, 6.0, 9.0, -7.0, -3.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(8.0, -1.0, -9.0, -1.0, 0.0, 2.0, -6.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-7.0, 6.0, -6.0, 9.0, 2.0, 4.0, 8.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-4.0, -4.0, 9.0, 6.0, 6.0, 4.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-2.0, 0.0, 9.0, 3.0, -1.0, -5.0, 2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(2.0, -3.0, 1.0, 2.0, -8.0, -3.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(-4.0, -1.0, -9.0, -6.0, 4.0, 3.0, 0.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(7.0, -8.0, 2.0, 4.0, -2.0, -7.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(2.0, 8.0, 1.0, -9.0, 8.0, 6.0, 7.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(7.0, 3.0, 2.0, -6.0, 6.0, 0.0, -6.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(4.0, 3.0, 4.0, -1.0, 9.0, 1.0, 7.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(-1.0, 5.0, -5.0, 9.0, -6.0, -2.0, 3.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(-3.0, -9.0, 2.0, 5.0, 0.0, 9.0, 8.0, -8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0][0] = (mat3(7.0, 5.0, 2.0, 9.0, -1.0, -9.0, -7.0, 1.0, 6.0));
	block.var[0][0][1] = (mat3(-1.0, -8.0, -8.0, 0.0, 9.0, 1.0, -5.0, 8.0, 1.0));
	block.var[0][0][2] = (mat3(-6.0, -1.0, 9.0, -6.0, 0.0, 5.0, -4.0, 5.0, -4.0));
	block.var[0][1][0] = (mat3(0.0, -7.0, 5.0, -5.0, -2.0, -9.0, 0.0, -7.0, 6.0));
	block.var[0][1][1] = (mat3(2.0, 5.0, -8.0, 2.0, -9.0, -7.0, 5.0, 8.0, -8.0));
	block.var[0][1][2] = (mat3(9.0, 2.0, 0.0, -3.0, -6.0, 4.0, 3.0, -4.0, 6.0));
	block.var[1][0][0] = (mat3(-9.0, 9.0, -7.0, -1.0, -9.0, -9.0, 3.0, -8.0, -2.0));
	block.var[1][0][1] = (mat3(2.0, -6.0, -7.0, 4.0, 8.0, -8.0, 7.0, -3.0, 6.0));
	block.var[1][0][2] = (mat3(7.0, -9.0, 5.0, -9.0, 9.0, 1.0, 1.0, 9.0, 8.0));
	block.var[1][1][0] = (mat3(-5.0, -5.0, -9.0, -4.0, -5.0, 7.0, -6.0, 5.0, -7.0));
	block.var[1][1][1] = (mat3(0.0, -7.0, 7.0, 9.0, 9.0, 9.0, 5.0, 9.0, 7.0));
	block.var[1][1][2] = (mat3(-4.0, 1.0, -3.0, 8.0, 0.0, 4.0, -1.0, 7.0, -1.0));
	block.var[2][0][0] = (mat3(-4.0, 7.0, -5.0, 8.0, 3.0, -4.0, 7.0, -7.0, -5.0));
	block.var[2][0][1] = (mat3(6.0, -8.0, 1.0, 7.0, 5.0, 7.0, 6.0, -1.0, 1.0));
	block.var[2][0][2] = (mat3(-8.0, 9.0, -2.0, 7.0, 9.0, -5.0, 7.0, -1.0, 8.0));
	block.var[2][1][0] = (mat3(9.0, 5.0, -2.0, -6.0, -8.0, -3.0, 1.0, 8.0, -7.0));
	block.var[2][1][1] = (mat3(-8.0, -8.0, -9.0, -8.0, -9.0, 0.0, 4.0, 8.0, 5.0));
	block.var[2][1][2] = (mat3(-1.0, 0.0, -6.0, -7.0, -9.0, -2.0, 9.0, 0.0, 7.0));
	block.var[3][0][0] = (mat3(-6.0, -1.0, -2.0, 9.0, 6.0, 0.0, 7.0, 6.0, -4.0));
	block.var[3][0][1] = (mat3(-5.0, -8.0, -6.0, 5.0, -5.0, 2.0, -3.0, -6.0, 7.0));
	block.var[3][0][2] = (mat3(7.0, 9.0, -8.0, -9.0, 8.0, -9.0, 5.0, -4.0, 8.0));
	block.var[3][1][0] = (mat3(3.0, -7.0, 4.0, 9.0, 3.0, -8.0, 9.0, -3.0, -1.0));
	block.var[3][1][1] = (mat3(0.0, -8.0, -5.0, 6.0, 2.0, 6.0, 2.0, 8.0, -5.0));
	block.var[3][1][2] = (mat3(8.0, 9.0, -2.0, 3.0, 4.0, 1.0, 0.0, 1.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(7.0, -5.0, -9.0, 5.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(8.0, 9.0, 2.0, 6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(-5.0, -8.0, 2.0, -2.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(8.0, 5.0, -8.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-1.0, -5.0, 5.0, 5.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(9.0, 2.0, 2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(8.0, -5.0, 6.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(2.0, 2.0, -8.0, 3.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(-7.0, 0.0, 7.0, 6.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(9.0, -4.0, -5.0, -3.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(6.0, 7.0, -5.0, 2.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(7.0, 0.0, 0.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-8.0, 7.0, -3.0, 5.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(-4.0, 6.0, 2.0, 0.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(-2.0, 0.0, 8.0, -6.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-9.0, -7.0, -3.0, -9.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-1.0, -3.0, -3.0, -6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(5.0, -7.0, 2.0, -4.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(5.0, -9.0, -6.0, -1.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(4.0, -7.0, 6.0, 3.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(0.0, 3.0, -9.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(-1.0, 9.0, -2.0, -8.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(-2.0, 1.0, 8.0, 8.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(-5.0, 4.0, -9.0, 8.0, 5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0][0][0][0] = (vec3(-3.0, 9.0, -8.0));
	block.var[0][0][0][1] = (vec3(-1.0, 1.0, -5.0));
	block.var[0][0][1][0] = (vec3(3.0, -3.0, 7.0));
	block.var[0][0][1][1] = (vec3(6.0, 6.0, -9.0));
	block.var[0][0][2][0] = (vec3(7.0, 0.0, -8.0));
	block.var[0][0][2][1] = (vec3(-2.0, -7.0, 0.0));
	block.var[0][1][0][0] = (vec3(5.0, 6.0, -3.0));
	block.var[0][1][0][1] = (vec3(9.0, -7.0, -6.0));
	block.var[0][1][1][0] = (vec3(7.0, 9.0, -2.0));
	block.var[0][1][1][1] = (vec3(0.0, -3.0, -7.0));
	block.var[0][1][2][0] = (vec3(8.0, -6.0, 8.0));
	block.var[0][1][2][1] = (vec3(6.0, -7.0, 4.0));
	block.var[1][0][0][0] = (vec3(-2.0, 4.0, -8.0));
	block.var[1][0][0][1] = (vec3(-5.0, 5.0, -3.0));
	block.var[1][0][1][0] = (vec3(-3.0, -1.0, -9.0));
	block.var[1][0][1][1] = (vec3(-4.0, 7.0, 2.0));
	block.var[1][0][2][0] = (vec3(-4.0, 8.0, 2.0));
	block.var[1][0][2][1] = (vec3(-3.0, 6.0, 6.0));
	block.var[1][1][0][0] = (vec3(4.0, 5.0, 5.0));
	block.var[1][1][0][1] = (vec3(-8.0, 4.0, 2.0));
	block.var[1][1][1][0] = (vec3(-4.0, -4.0, -1.0));
	block.var[1][1][1][1] = (vec3(3.0, 6.0, -3.0));
	block.var[1][1][2][0] = (vec3(6.0, 2.0, 2.0));
	block.var[1][1][2][1] = (vec3(-1.0, -1.0, 5.0));
	block.var[2][0][0][0] = (vec3(3.0, 4.0, -6.0));
	block.var[2][0][0][1] = (vec3(-2.0, 0.0, 3.0));
	block.var[2][0][1][0] = (vec3(4.0, -8.0, 0.0));
	block.var[2][0][1][1] = (vec3(-6.0, 2.0, -3.0));
	block.var[2][0][2][0] = (vec3(-6.0, -8.0, 8.0));
	block.var[2][0][2][1] = (vec3(3.0, 5.0, 4.0));
	block.var[2][1][0][0] = (vec3(7.0, -7.0, 5.0));
	block.var[2][1][0][1] = (vec3(-2.0, -1.0, -3.0));
	block.var[2][1][1][0] = (vec3(6.0, -5.0, -2.0));
	block.var[2][1][1][1] = (vec3(6.0, 7.0, 2.0));
	block.var[2][1][2][0] = (vec3(-3.0, 6.0, -3.0));
	block.var[2][1][2][1] = (vec3(-1.0, 2.0, -2.0));
	block.var[3][0][0][0] = (vec3(-6.0, 7.0, -3.0));
	block.var[3][0][0][1] = (vec3(-9.0, -1.0, 2.0));
	block.var[3][0][1][0] = (vec3(-3.0, -5.0, 9.0));
	block.var[3][0][1][1] = (vec3(-2.0, 4.0, -8.0));
	block.var[3][0][2][0] = (vec3(2.0, 0.0, 5.0));
	block.var[3][0][2][1] = (vec3(-1.0, 7.0, 0.0));
	block.var[3][1][0][0] = (vec3(2.0, -7.0, -2.0));
	block.var[3][1][0][1] = (vec3(0.0, -6.0, 1.0));
	block.var[3][1][1][0] = (vec3(7.0, 3.0, 1.0));
	block.var[3][1][1][1] = (vec3(-8.0, -3.0, 2.0));
	block.var[3][1][2][0] = (vec3(-8.0, -7.0, 0.0));
	block.var[3][1][2][1] = (vec3(-8.0, 6.0, -3.0));
}
#version 450
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
	f16vec3 var[4][2][3];
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
	allOk = compare_f16vec3(vec3(block.var[0][0][0]), vec3(1.0, 9.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][0][1]), vec3(7.0, -5.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][0][2]), vec3(2.0, -4.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][1][0]), vec3(-7.0, -9.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][1][1]), vec3(6.0, -2.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][1][2]), vec3(1.0, 9.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][0][0]), vec3(4.0, 5.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][0][1]), vec3(1.0, 1.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][0][2]), vec3(2.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][1][0]), vec3(4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][1][1]), vec3(-7.0, -8.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][1][2]), vec3(-8.0, 1.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][0][0]), vec3(-2.0, -4.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][0][1]), vec3(-7.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][0][2]), vec3(-2.0, -2.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][1][0]), vec3(2.0, 0.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][1][1]), vec3(2.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][1][2]), vec3(-8.0, 7.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][0][0]), vec3(6.0, -1.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][0][1]), vec3(-4.0, 6.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][0][2]), vec3(6.0, 4.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][1][0]), vec3(7.0, 5.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][1][1]), vec3(-9.0, -6.0, 0.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][1][2]), vec3(-3.0, 2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = float16_t(3.0);
	block.var[0][0][0] = f16vec3(vec3(3.0, 7.0, -3.0));
	block.var[0][0][1] = f16vec3(vec3(-5.0, -9.0, -1.0));
	block.var[0][0][2] = f16vec3(vec3(0.0, 6.0, 5.0));
	block.var[0][1][0] = f16vec3(vec3(6.0, -6.0, -3.0));
	block.var[0][1][1] = f16vec3(vec3(1.0, -5.0, 6.0));
	block.var[0][1][2] = f16vec3(vec3(9.0, 7.0, 2.0));
	block.var[1][0][0] = f16vec3(vec3(-7.0, 2.0, 9.0));
	block.var[1][0][1] = f16vec3(vec3(1.0, -5.0, -5.0));
	block.var[1][0][2] = f16vec3(vec3(5.0, 2.0, -5.0));
	block.var[1][1][0] = f16vec3(vec3(5.0, 3.0, 9.0));
	block.var[1][1][1] = f16vec3(vec3(-8.0, 2.0, -7.0));
	block.var[1][1][2] = f16vec3(vec3(-8.0, -3.0, 2.0));
	block.var[2][0][0] = f16vec3(vec3(-4.0, 6.0, -3.0));
	block.var[2][0][1] = f16vec3(vec3(-7.0, -4.0, -4.0));
	block.var[2][0][2] = f16vec3(vec3(5.0, 0.0, -6.0));
	block.var[2][1][0] = f16vec3(vec3(-5.0, -9.0, -8.0));
	block.var[2][1][1] = f16vec3(vec3(4.0, 1.0, -9.0));
	block.var[2][1][2] = f16vec3(vec3(-5.0, 5.0, -3.0));
	block.var[3][0][0] = f16vec3(vec3(4.0, -1.0, -2.0));
	block.var[3][0][1] = f16vec3(vec3(3.0, -8.0, -4.0));
	block.var[3][0][2] = f16vec3(vec3(-2.0, 4.0, 6.0));
	block.var[3][1][0] = f16vec3(vec3(-6.0, 0.0, -3.0));
	block.var[3][1][1] = f16vec3(vec3(9.0, -1.0, -9.0));
	block.var[3][1][2] = f16vec3(vec3(0.0, -5.0, -2.0));
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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

layout(std140, buffer_reference) buffer Block
{
	u16vec4 var[][4][2];
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
	allOk = compare_u16vec4(uvec4(block.var[0][1][0]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1][1]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][2][0]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][2][1]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][3][0]), uvec4(2u, 6u, 2u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][3][1]), uvec4(3u, 7u, 0u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0][0]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0][1]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1][0]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1][1]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][2][0]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][2][1]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][3][0]), uvec4(6u, 4u, 5u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][3][1]), uvec4(6u, 4u, 0u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0][0]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0][1]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1][0]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1][1]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][2][0]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][2][1]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][3][0]), uvec4(2u, 9u, 7u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][3][1]), uvec4(8u, 1u, 6u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	block.var[0][0][1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	block.var[0][1][0] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	block.var[0][1][1] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	block.var[0][2][0] = u16vec4(uvec4(6u, 9u, 4u, 2u));
	block.var[0][2][1] = u16vec4(uvec4(9u, 7u, 6u, 2u));
	block.var[0][3][0] = u16vec4(uvec4(7u, 8u, 2u, 8u));
	block.var[0][3][1] = u16vec4(uvec4(0u, 3u, 6u, 3u));
	block.var[1][0][0] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	block.var[1][0][1] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	block.var[1][1][0] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	block.var[1][1][1] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	block.var[1][2][0] = u16vec4(uvec4(8u, 4u, 6u, 2u));
	block.var[1][2][1] = u16vec4(uvec4(2u, 1u, 0u, 1u));
	block.var[1][3][0] = u16vec4(uvec4(4u, 0u, 8u, 2u));
	block.var[1][3][1] = u16vec4(uvec4(3u, 0u, 4u, 2u));
	block.var[2][0][0] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	block.var[2][0][1] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	block.var[2][1][0] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	block.var[2][1][1] = u16vec4(uvec4(1u, 8u, 4u, 7u));
	block.var[2][2][0] = u16vec4(uvec4(9u, 9u, 4u, 6u));
	block.var[2][2][1] = u16vec4(uvec4(4u, 4u, 2u, 8u));
	block.var[2][3][0] = u16vec4(uvec4(4u, 7u, 1u, 9u));
	block.var[2][3][1] = u16vec4(uvec4(5u, 6u, 9u, 9u));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(4, -5, -6)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(8.0, -8.0, 8.0, 0.0, 4.0, 5.0, 3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(2.0, -8.0, 0.0, 6.0, 0.0, 9.0, 1.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(2.0, -8.0, 4.0, 8.0, 5.0, 8.0, 7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(1.0, -3.0, -2.0, 0.0, 6.0, -9.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(4.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(7.0, -4.0, 7.0, 6.0, -2.0, -3.0, 6.0, -6.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(6, -3, -1)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(4.0, -2.0, 1.0, -5.0, -9.0, 3.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(8.0, -3.0, -5.0, -3.0, -5.0, 4.0, 0.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(-4.0, -2.0, -9.0, -5.0, -6.0, -7.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(6.0, 4.0, -7.0, -1.0, 8.0, 5.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(0.0, 8.0, -6.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(-3, 5, 9)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(4.0, 1.0, 3.0, 4.0, -9.0, -8.0, 1.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-3.0, -2.0, -2.0, -1.0, -7.0, -5.0, -7.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(0.0, 9.0, 3.0, 7.0, -7.0, -7.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-4.0, -6.0, -6.0, 1.0, 8.0, 1.0, 9.0, -6.0, 7.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(8.0, -5.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(2.0, -8.0, -5.0, 2.0, 5.0, -8.0, -3.0, -9.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(9, -6, -8)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(9.0, 8.0, -8.0, -7.0, -6.0, -9.0, 1.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(-3.0, 5.0, -8.0, 0.0, 0.0, 6.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(0.0, -4.0, 9.0, -2.0, 8.0, -1.0, -9.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(-3.0, -2.0, 4.0, 5.0, 7.0, -6.0, -6.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(-9.0, -9.0, 2.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(6, 8, -6)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-8.0, -5.0, -5.0, -6.0, -4.0, 8.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(3.0, 1.0, 0.0, 3.0, 6.0, -1.0, -5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-1.0, 4.0, 3.0, 2.0, 5.0, -8.0, -3.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-9.0, 1.0, -3.0, -2.0, -2.0, -7.0, -3.0, -3.0, 0.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(4.0, -2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(6.0, 5.0, -2.0, -1.0, 5.0, -6.0, 5.0, 6.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(0, 8, 0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(-1.0, 4.0, -2.0, -2.0, 3.0, -8.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(1.0, -6.0, 9.0, -2.0, 9.0, 8.0, 2.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(1.0, -1.0, -1.0, -4.0, 7.0, -8.0, -2.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(-4.0, 6.0, -3.0, -3.0, 0.0, 4.0, 0.0, -6.0, 4.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(-1.0, -9.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a[0] = (vec3(0.0, 7.0, -3.0));
	block[0].t.a[1] = (vec3(-1.0, -7.0, -2.0));
	block[0].t.a[2] = (vec3(5.0, -1.0, 8.0));
	block[0].t.b.a = (ivec3(0, 1, 9));
	block[0].t.b.b[0][0] = (vec3(-4.0, 3.0, -2.0));
	block[0].t.b.b[0][1] = (vec3(-5.0, 6.0, -9.0));
	block[0].t.b.b[0][2] = (vec3(-8.0, 4.0, -6.0));
	block[0].t.b.b[1][0] = (vec3(-8.0, -5.0, -2.0));
	block[0].t.b.b[1][1] = (vec3(8.0, 8.0, -2.0));
	block[0].t.b.b[1][2] = (vec3(4.0, 7.0, 2.0));
	block[0].t.b.b[2][0] = (vec3(-8.0, -6.0, -4.0));
	block[0].t.b.b[2][1] = (vec3(0.0, 2.0, 9.0));
	block[0].t.b.b[2][2] = (vec3(-8.0, 2.0, 2.0));
	block[0].t.b.b[3][0] = (vec3(1.0, -4.0, -7.0));
	block[0].t.b.b[3][1] = (vec3(-3.0, 1.0, 2.0));
	block[0].t.b.b[3][2] = (vec3(9.0, 1.0, 5.0));
	block[0].t.b.c = (vec4(1.0, -5.0, 8.0, -2.0));
	block[0].u = (6u);
	block[1].t.a[0] = (vec3(8.0, -7.0, -2.0));
	block[1].t.a[1] = (vec3(7.0, -3.0, 6.0));
	block[1].t.a[2] = (vec3(-5.0, -1.0, 7.0));
	block[1].t.b.a = (ivec3(4, -2, 7));
	block[1].t.b.b[0][0] = (vec3(6.0, -3.0, -9.0));
	block[1].t.b.b[0][1] = (vec3(9.0, -3.0, 8.0));
	block[1].t.b.b[0][2] = (vec3(-9.0, 6.0, 8.0));
	block[1].t.b.b[1][0] = (vec3(5.0, 1.0, -8.0));
	block[1].t.b.b[1][1] = (vec3(4.0, -8.0, -5.0));
	block[1].t.b.b[1][2] = (vec3(5.0, -2.0, -7.0));
	block[1].t.b.b[2][0] = (vec3(7.0, 4.0, -2.0));
	block[1].t.b.b[2][1] = (vec3(-4.0, 4.0, 5.0));
	block[1].t.b.b[2][2] = (vec3(-8.0, 5.0, -9.0));
	block[1].t.b.b[3][0] = (vec3(-6.0, -9.0, -5.0));
	block[1].t.b.b[3][1] = (vec3(1.0, 5.0, 2.0));
	block[1].t.b.b[3][2] = (vec3(1.0, 0.0, 6.0));
	block[1].t.b.c = (vec4(4.0, -8.0, -1.0, 6.0));
	block[1].u = (9u);
	block[2].t.a[0] = (vec3(-1.0, -9.0, -9.0));
	block[2].t.a[1] = (vec3(-9.0, -9.0, 4.0));
	block[2].t.a[2] = (vec3(-5.0, -2.0, 2.0));
	block[2].t.b.a = (ivec3(-7, -3, -5));
	block[2].t.b.b[0][0] = (vec3(8.0, 9.0, 8.0));
	block[2].t.b.b[0][1] = (vec3(-7.0, -1.0, -1.0));
	block[2].t.b.b[0][2] = (vec3(-8.0, 7.0, -6.0));
	block[2].t.b.b[1][0] = (vec3(-9.0, -9.0, 2.0));
	block[2].t.b.b[1][1] = (vec3(-5.0, -4.0, -2.0));
	block[2].t.b.b[1][2] = (vec3(7.0, 1.0, 1.0));
	block[2].t.b.b[2][0] = (vec3(3.0, -7.0, 1.0));
	block[2].t.b.b[2][1] = (vec3(-3.0, -8.0, -7.0));
	block[2].t.b.b[2][2] = (vec3(-5.0, 1.0, 6.0));
	block[2].t.b.b[3][0] = (vec3(-1.0, 2.0, 7.0));
	block[2].t.b.b[3][1] = (vec3(-4.0, 6.0, 3.0));
	block[2].t.b.b[3][2] = (vec3(1.0, 8.0, 9.0));
	block[2].t.b.c = (vec4(7.0, -9.0, 2.0, -8.0));
	block[2].u = (0u);
}
#version 450
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
	allOk = compare_uint((block[0].u), 1u) && allOk;
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(-3.0, 9.0, -9.0, -8.0, -6.0, -4.0, 6.0, 6.0, -4.0, 1.0, -9.0, -8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(5.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(-3.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(-2.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(-1.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-3.0, -9.0, -3.0, 6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(8u, 5u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(4.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(-4.0, -2.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-3.0, -9.0, -2.0, -9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(3u, 7u, 3u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(5.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(-3.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(-9.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(9.0, -3.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-8.0, 6.0, 1.0, 0.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), 3) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(5.0, -7.0, -9.0, 6.0, 5.0, 3.0, -7.0, 2.0, -7.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(5u, 2u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(-4.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(6.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(-9.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(1.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(0.0, 3.0, 2.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(4u, 7u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(-9.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(-9.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(-9.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(6.0, 2.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(4.0, -3.0, 1.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(0u, 1u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(-1.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(-8.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(7.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(9.0, 1.0, 0.0, 9.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), -7) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(4.0, -5.0, 8.0, -2.0, 4.0, -4.0, -3.0, -9.0, -3.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(9u, 8u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(7.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(-5.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(2.0, -5.0, 9.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(5u, 2u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(-5.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(-2.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(-5.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(-8.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(5u, 2u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(5.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(-8.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(-5.0, 8.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(-1.0, -6.0, 3.0, 3.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), -5) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(9.0, -2.0, 5.0, -3.0, -4.0, 9.0, 1.0, 8.0, -8.0, -8.0, 1.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(4u, 3u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(-2.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(-8.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(-7.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(-3.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(0u, 7u, 3u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(-6.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(-2.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(-1.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(2.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(-7.0, -6.0, 6.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(2u, 6u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(9.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(9.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), 4) && allOk;
	allOk = compare_uint((block[1].u), 3u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(-8.0, 0.0, -2.0, 4.0, -9.0, -1.0, -5.0, 3.0, -5.0, 4.0, 5.0, -7.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(7u, 2u, 8u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(3.0, -5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(-7.0, 9.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(-6.0, 9.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(4.0, 7.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(8.0, 7.0, 0.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(7u, 6u, 2u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(5.0, -2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(1.0, -9.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(-8.0, -1.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(6.0, -9.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(3.0, 2.0, -7.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(3u, 3u, 6u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(5.0, 1.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(-2.0, -8.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(8.0, -4.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(3.0, 9.0, -5.0, 4.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), -1) && allOk;
	allOk = compare_uint((block[2].u), 7u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(-8.0, -7.0, -8.0, 0.0, -8.0, 7.0, -5.0, -8.0, 1.0, 3.0, -4.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(6u, 3u, 4u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(-5.0, -5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(5.0, -2.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(6.0, -5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(6.0, -5.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-4.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(7u, 1u, 9u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(9.0, -9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(-5.0, 1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(-3.0, 9.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(5.0, 2.0, 2.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(6u, 2u, 1u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(-7.0, 8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(-5.0, 5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(-7.0, -1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(6.0, 5.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(5.0, -7.0, 8.0, -7.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), 4) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(8u, 9u, 5u));
	block[0].s.b[0] = (vec2(3.0, -5.0));
	block[0].s.b[1] = (vec2(3.0, -3.0));
	block[0].s.b[2] = (vec2(5.0, -6.0));
	block[0].s.b[3] = (vec2(-6.0, -1.0));
	block[0].s.c = (vec4(-4.0, -1.0, -5.0, -1.0));
	block[0].u = (9u);
	block[1].s.a = (uvec3(4u, 7u, 4u));
	block[1].s.b[0] = (vec2(1.0, -3.0));
	block[1].s.b[1] = (vec2(8.0, 1.0));
	block[1].s.b[2] = (vec2(-3.0, 3.0));
	block[1].s.b[3] = (vec2(3.0, 1.0));
	block[1].s.c = (vec4(5.0, -9.0, 7.0, 8.0));
	block[1].u = (9u);
	block[2].s.a = (uvec3(4u, 3u, 8u));
	block[2].s.b[0] = (vec2(-2.0, 8.0));
	block[2].s.b[1] = (vec2(-7.0, -6.0));
	block[2].s.b[2] = (vec2(7.0, 0.0));
	block[2].s.b[3] = (vec2(7.0, 3.0));
	block[2].s.c = (vec4(1.0, -5.0, -5.0, 3.0));
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
layout(scalar, buffer_reference) buffer Block
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
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(5.0, 1.0, 8.0, 3.0, -8.0, 5.0, 3.0, -2.0, 2.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(5u, 0u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(2.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(5.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-8.0, -6.0, -2.0, 6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(7u, 9u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(9.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(0.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(5.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(6u, 6u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(2.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(9.0, 4.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-2.0, 1.0, -2.0, 2.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), 4) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(7.0, 1.0, -6.0, -4.0, -1.0, -9.0, 3.0, 4.0, 5.0, -6.0, -2.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(9u, 5u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(-3.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(4.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(-4.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(2.0, 7.0, 3.0, -1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(3u, 9u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(3.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(3.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(-1.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(-4.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(1.0, -7.0, 7.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(5u, 1u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(7.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(2.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(-8.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(8.0, -4.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(6.0, -3.0, -4.0, 7.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), -8) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(7.0, 4.0, 2.0, -3.0, -2.0, -2.0, 3.0, -5.0, 2.0, 1.0, -3.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(0u, 8u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(9.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(-5.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(3.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(-3.0, 0.0, -6.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(8u, 2u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(-4.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(2.0, -2.0, 8.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(0u, 1u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(0.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(0.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(3.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), -4) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(-9.0, 0.0, 9.0, -7.0, -1.0, 5.0, 8.0, -3.0, 4.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(2u, 2u, 8u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(-2.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(1.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(-7.0, -2.0, 6.0, -9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(-6.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(9.0, 6.0, 3.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(8u, 6u, 3u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(-2.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(-2.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(-4.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(-9.0, -2.0, 7.0, 1.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), -4) && allOk;
	allOk = compare_uint((block[1].u), 3u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(2.0, -1.0, -2.0, 4.0, 0.0, -8.0, -4.0, 0.0, 1.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(7u, 9u, 1u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(4.0, 8.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(-5.0, -7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-3.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(5u, 3u, 6u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(9.0, -5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(4.0, -3.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-6.0, 4.0, 5.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(0u, 3u, 0u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(-2.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(7.0, -7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(5.0, -5.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(8.0, -5.0, 5.0, -1.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), -7) && allOk;
	allOk = compare_uint((block[2].u), 0u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(-2.0, -5.0, 4.0, -4.0, -3.0, 4.0, 4.0, -3.0, -7.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(7u, 5u, 0u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(2.0, -6.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(7.0, 3.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-2.0, 8.0, 2.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(1u, 2u, 9u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(-7.0, -3.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(6.0, 5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(1.0, -1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(7.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(7.0, -3.0, 0.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(5u, 6u, 6u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(7.0, -3.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(-6.0, -6.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(6.0, 1.0, -7.0, -8.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(4u, 6u, 4u));
	block[0].s.b[0] = (vec2(-4.0, 1.0));
	block[0].s.b[1] = (vec2(2.0, -2.0));
	block[0].s.b[2] = (vec2(8.0, 7.0));
	block[0].s.b[3] = (vec2(2.0, -4.0));
	block[0].s.c = (vec4(3.0, -4.0, 6.0, 7.0));
	block[0].u = (5u);
	block[1].s.a = (uvec3(4u, 6u, 7u));
	block[1].s.b[0] = (vec2(5.0, 4.0));
	block[1].s.b[1] = (vec2(-9.0, -7.0));
	block[1].s.b[2] = (vec2(-9.0, -2.0));
	block[1].s.b[3] = (vec2(9.0, -6.0));
	block[1].s.c = (vec4(-3.0, 6.0, 3.0, -8.0));
	block[1].u = (9u);
	block[2].s.a = (uvec3(2u, 5u, 4u));
	block[2].s.b[0] = (vec2(-9.0, -5.0));
	block[2].s.b[1] = (vec2(2.0, 4.0));
	block[2].s.b[2] = (vec2(-4.0, 1.0));
	block[2].s.b[3] = (vec2(-2.0, -2.0));
	block[2].s.c = (vec4(4.0, 0.0, -6.0, 6.0));
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat2(block[0].var, mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block[1].var, mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(block[2].var, mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(-2.0, 1.0));
	block[0].var[1] = (vec2(-7.0, -1.0));
	block[1].var[0] = (vec2(5.0, -3.0));
	block[1].var[1] = (vec2(4.0, 8.0));
	block[2].var[0] = (vec2(-2.0, -6.0));
	block[2].var[1] = (vec2(-5.0, -1.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -8.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(6.0, -4.0, 9.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-9.0, 3.0, 9.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(6.0, -9.0, -8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -7.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 1.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(8.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-6.0, -8.0, -7.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-4.0, 6.0, 1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -5.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 8.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-4.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-8.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(-4.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(2.0, -4.0, 9.0));
	block[0].var[1] = (vec3(-4.0, 2.0, 5.0));
	block[0].var[2] = (vec3(5.0, -9.0, -5.0));
	block[1].var[0] = (vec3(3.0, 1.0, 8.0));
	block[1].var[1] = (vec3(6.0, 9.0, -8.0));
	block[1].var[2] = (vec3(-1.0, 5.0, 1.0));
	block[2].var[0] = (vec3(6.0, -5.0, -4.0));
	block[2].var[1] = (vec3(-8.0, -8.0, -2.0));
	block[2].var[2] = (vec3(9.0, -4.0, 4.0));
}
#version 450
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
	uint16_t var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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

layout(std430, column_major, buffer_reference) buffer Block
{
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
	allOk = compare_mat3x4(block[0].var, mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	block[0].var[1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	block[0].var[2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	block[1].var[0] = (vec4(2.0, 6.0, 9.0, -2.0));
	block[1].var[1] = (vec4(7.0, 9.0, 0.0, 0.0));
	block[1].var[2] = (vec4(8.0, -3.0, 0.0, 3.0));
	block[2].var[0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	block[2].var[1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	block[2].var[2] = (vec4(-8.0, 5.0, -1.0, 9.0));
}
#version 450
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
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockA[0].a), -7.0) && allOk;
	allOk = compare_mat2(blockA[0].c, mat2(-4.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_float((blockA[1].a), 2.0) && allOk;
	allOk = compare_mat2(blockA[1].c, mat2(-1.0, 9.0, 2.0, -7.0)) && allOk;
	allOk = compare_float((blockA[2].a), -1.0) && allOk;
	allOk = compare_mat2(blockA[2].c, mat2(8.0, 3.0, -8.0, 5.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-4, -1)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(2, 1)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(8, 4)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-5.0);
	blockA[1].a = (7.0);
	blockA[2].a = (-6.0);
	blockB[0].a = (mat3(9.0, -5.0, -2.0, -9.0, -6.0, 4.0, 2.0, 2.0, -6.0));
	blockB[0].d = (true);
	blockB[1].a = (mat3(8.0, 8.0, -8.0, -2.0, 7.0, -9.0, 6.0, 6.0, -9.0));
	blockB[1].d = (false);
	blockB[2].a = (mat3(-7.0, -1.0, 5.0, -4.0, -9.0, -7.0, -6.0, -3.0, 8.0));
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

layout(std140, column_major, buffer_reference) buffer BlockB
{
	bvec2 a;
	highp mat4 b;
	highp ivec2 c;
	lowp mat3 d;
	mediump uvec3 e;
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	highp vec4 f;
	highp mat2 g;
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_mat4(blockB.b, mat4(-7.0, -9.0, 5.0, -4.0, -9.0, 8.0, 6.0, -2.0, -6.0, 4.0, -6.0, -3.0, 2.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_uvec3((blockB.e), uvec3(5u, 3u, 6u)) && allOk;
	allOk = compare_mat2(blockC.g, mat2(0.0, 1.0, 8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4(-9.0, -8.0, 0.0, 8.0, 0.0, 8.0, 7.0, 1.0, 2.0, -5.0, 9.0, -6.0, -3.0, 9.0, 4.0, 0.0));
	blockB.c = (ivec2(4, 5));
	blockB.e = (uvec3(3u, 0u, 0u));
}
#version 450
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
	highp float mB;
};
struct sB
{
	mediump mat3 mA;
	mediump ivec3 mB;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	mediump ivec2 a;
	lowp mat2x3 b;
	lowp vec2 c[4];
	lowp mat3x4 d;
	lowp vec2 e[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockC
{
	sA f[];
};
layout(std430, buffer_reference) readonly buffer BlockD
{
	sB g[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(0, -6)) && allOk;
	allOk = compare_mat2x3(blockB.b, mat2x3(9.0, 0.0, 7.0, -5.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB.c[0]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((blockB.c[1]), vec2(8.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB.c[2]), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB.c[3]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockB.d, mat3x4(-1.0, -6.0, 4.0, -7.0, 1.0, 3.0, 1.0, 2.0, -1.0, -7.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec2((blockB.e[0]), vec2(-2.0, 8.0)) && allOk;
	allOk = compare_vec2((blockB.e[1]), vec2(0.0, 2.0)) && allOk;
	allOk = compare_mat3(blockD[0].g[0].mA, mat3(7.0, 6.0, 3.0, -8.0, -8.0, 0.0, 6.0, 7.0, 2.0)) && allOk;
	allOk = compare_ivec3((blockD[0].g[0].mB), ivec3(-5, -6, -9)) && allOk;
	allOk = compare_mat3(blockD[0].g[1].mA, mat3(-4.0, -9.0, -8.0, 2.0, -3.0, 6.0, 1.0, 7.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockD[0].g[1].mB), ivec3(1, 2, 2)) && allOk;
	allOk = compare_mat3(blockD[0].g[2].mA, mat3(-4.0, -7.0, 9.0, 8.0, 4.0, -3.0, 0.0, -9.0, 7.0)) && allOk;
	allOk = compare_ivec3((blockD[0].g[2].mB), ivec3(1, -5, 9)) && allOk;
	allOk = compare_mat3(blockD[0].g[3].mA, mat3(-9.0, 8.0, -2.0, -2.0, 0.0, -1.0, 4.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec3((blockD[0].g[3].mB), ivec3(-6, -1, -4)) && allOk;
	allOk = compare_mat3(blockD[0].g[4].mA, mat3(-6.0, 5.0, 9.0, 7.0, 7.0, -4.0, 1.0, 1.0, -2.0)) && allOk;
	allOk = compare_ivec3((blockD[0].g[4].mB), ivec3(4, 6, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(6, 3));
	blockB.d = (mat3x4(-9.0, 9.0, -4.0, 2.0, 9.0, 8.0, 0.0, 1.0, -9.0, -1.0, -4.0, 2.0));
}
#version 450
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
	mediump uint a;
	lowp vec3 b[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockC
{
	lowp uvec3 c;
	highp mat4 d;
	lowp ivec2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 0u) && allOk;
	allOk = compare_vec3((blockB.b[0]), vec3(0.0, -7.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.b[1]), vec3(0.0, -2.0, -6.0)) && allOk;
	allOk = compare_vec3((blockB.b[2]), vec3(9.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4(blockC[0].d, mat4(-8.0, 0.0, 4.0, -5.0, 4.0, 6.0, 2.0, -9.0, -5.0, 0.0, 0.0, -3.0, 6.0, 8.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (vec3(-4.0, 7.0, 9.0));
	blockB.b[1] = (vec3(0.0, 9.0, -5.0));
	blockB.b[2] = (vec3(-3.0, 3.0, 5.0));
}
#version 450
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
	mediump mat4x2 mB;
	lowp vec2 mC;
};
struct sB
{
	highp int mA;
	mediump mat3x2 mB;
	mediump mat3x4 mC;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	lowp vec4 a;
	mediump uint b;
	lowp vec3 c[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp vec3 d;
	sA e;
	sB f;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp mat4 g;
	highp uvec3 h;
	lowp uint i;
	lowp uint j;
	bvec2 k[][4];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	highp ivec2 l;
	highp float m[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.c[0]), vec3(7.0, 6.0, -9.0)) && allOk;
	allOk = compare_vec3((blockC.d), vec3(6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(blockD.g, mat4(-8.0, -2.0, 3.0, -6.0, -6.0, 3.0, -9.0, 8.0, 8.0, -7.0, 8.0, 9.0, 9.0, -5.0, 5.0, 3.0)) && allOk;
	allOk = compare_uvec3((blockD.h), uvec3(5u, 9u, 3u)) && allOk;
	allOk = compare_uint((blockD.i), 3u) && allOk;
	allOk = compare_uint((blockD.j), 1u) && allOk;
	allOk = compare_bvec2((blockD.k[0][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.k[0][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD.k[0][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD.k[0][3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.k[1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.k[1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD.k[1][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD.k[1][3]), bvec2(false, true)) && allOk;
	allOk = compare_ivec2((blockE.l), ivec2(5, -9)) && allOk;
	allOk = compare_float((blockE.m[0]), -8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(0.0, -2.0, -1.0, 6.0));
	blockB.b = (3u);
	blockB.c[0] = (vec3(4.0, -7.0, -8.0));
	blockC.d = (vec3(-7.0, 2.0, -1.0));
	blockC.e.mA = (mat4x2(-1.0, 0.0, -8.0, -6.0, -1.0, 0.0, -5.0, -8.0));
	blockC.e.mB = (mat4x2(-7.0, 4.0, -2.0, 5.0, -4.0, 6.0, 5.0, 2.0));
	blockC.e.mC = (vec2(5.0, 2.0));
	blockC.f.mA = (-7);
	blockC.f.mB = (mat3x2(1.0, 4.0, -1.0, 5.0, -8.0, 6.0));
	blockC.f.mC = (mat3x4(-9.0, 4.0, -9.0, 6.0, -9.0, -7.0, -8.0, -7.0, 8.0, -7.0, 8.0, -6.0));
	blockD.g = (mat4(-4.0, 5.0, -9.0, 8.0, -9.0, 2.0, -2.0, 5.0, 9.0, 3.0, 0.0, 6.0, -2.0, -4.0, 5.0, 1.0));
	blockD.h = (uvec3(1u, 3u, 4u));
	blockD.i = (7u);
	blockE.m[0] = (-7.0);
}
#version 450
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
	bvec3 a;
	mediump uint b;
	highp vec4 c;
	bvec3 d;
	bvec2 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	mediump int f;
	lowp ivec2 g;
	highp mat4x2 h[];
};
layout(std140, buffer_reference) readonly buffer BlockD
{
	mediump mat4x3 i;
	highp mat4x3 j[];
};
layout(std140, buffer_reference) buffer BlockE
{
	bvec4 k[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.b), 9u) && allOk;
	allOk = compare_vec4((blockB.c), vec4(1.0, 9.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockD.i, mat4x3(-6.0, -2.0, 2.0, -1.0, 1.0, -1.0, -8.0, -9.0, 2.0, -6.0, 9.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockE[0].k[0]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((blockE[0].k[1]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockE[0].k[2]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockE[0].k[3]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockE[0].k[4]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockE[1].k[0]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockE[1].k[1]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockE[1].k[2]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockE[1].k[3]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((blockE[2].k[0]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockE[2].k[1]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockE[2].k[2]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((blockE[2].k[3]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockE[2].k[4]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockE[2].k[5]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockE[2].k[6]), bvec4(false, false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, false, true));
	blockB.b = (6u);
	blockB.c = (vec4(4.0, 6.0, -5.0, -5.0));
	blockB.d = (bvec3(true, true, true));
	blockC.f = (-8);
	blockC.g = (ivec2(5, -2));
	blockE[0].k[0] = (bvec4(false, true, true, false));
	blockE[0].k[1] = (bvec4(true, false, true, false));
	blockE[0].k[2] = (bvec4(false, true, true, false));
	blockE[0].k[3] = (bvec4(true, false, false, true));
	blockE[0].k[4] = (bvec4(true, false, true, true));
	blockE[1].k[0] = (bvec4(false, true, true, false));
	blockE[1].k[1] = (bvec4(true, false, true, true));
	blockE[1].k[2] = (bvec4(true, true, true, false));
	blockE[1].k[3] = (bvec4(true, false, true, true));
	blockE[2].k[0] = (bvec4(false, false, true, false));
	blockE[2].k[1] = (bvec4(false, false, false, false));
	blockE[2].k[2] = (bvec4(false, false, false, false));
	blockE[2].k[3] = (bvec4(false, true, false, false));
	blockE[2].k[4] = (bvec4(true, false, false, true));
	blockE[2].k[5] = (bvec4(true, false, false, true));
	blockE[2].k[6] = (bvec4(true, false, false, false));
}
#version 450
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
	layout(offset = 8) bool b;
	layout(offset = 16) lowp uvec3 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_bvec4((blockC[0].d), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((blockC[1].d), bvec4(false, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b = (true);
	blockB.c = (uvec3(2u, 4u, 2u));
	blockC[0].d = (bvec4(true, true, true, false));
	blockC[1].d = (bvec4(false, false, false, true));
}
#version 450
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
	lowp ivec4 mA;
};
struct sC
{
	mediump ivec4 mA;
	sB mB;
	bvec4 mC;
};
struct sD
{
	bvec3 mA;
};
struct sE
{
	highp ivec4 mA;
	highp mat3x2 mB;
	lowp mat4x2 mC[1];
};
struct sF
{
	mediump mat2 mA;
	highp vec2 mB;
	sE mC;
	lowp mat3x4 mD;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	sA a;
	highp int b[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	lowp int c;
	lowp vec3 d[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	mediump uvec4 e;
	mediump ivec4 f;
	sC g;
	sD h[];
};
layout(scalar, buffer_reference) readonly buffer BlockE
{
	bvec2 i;
	sF j;
	bvec3 k;
	highp vec3 l[];
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[0].a.mA), 4) && allOk;
	allOk = compare_int((blockC.c), 2) && allOk;
	allOk = compare_vec3((blockC.d[0]), vec3(-9.0, -1.0, -4.0)) && allOk;
	allOk = compare_uvec4((blockD.e), uvec4(0u, 9u, 2u, 8u)) && allOk;
	allOk = compare_bvec3((blockD.h[0].mA), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockD.h[1].mA), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockD.h[2].mA), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockD.h[3].mA), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockD.h[4].mA), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec2((blockE.i), bvec2(true, true)) && allOk;
	allOk = compare_mat2(blockE.j.mA, mat2(-7.0, -8.0, -9.0, 5.0)) && allOk;
	allOk = compare_vec2((blockE.j.mB), vec2(-7.0, 4.0)) && allOk;
	allOk = compare_ivec4((blockE.j.mC.mA), ivec4(-5, -3, -7, -8)) && allOk;
	allOk = compare_mat3x2(blockE.j.mC.mB, mat3x2(8.0, 2.0, 3.0, 4.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockE.j.mC.mC[0], mat4x2(-8.0, -3.0, 9.0, -8.0, 1.0, 6.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockE.j.mD, mat3x4(2.0, 5.0, -1.0, -3.0, 4.0, -7.0, -2.0, -9.0, 1.0, -2.0, -9.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (1);
	blockB[0].b[1] = (-7);
	blockB[0].b[2] = (-7);
	blockB[0].b[3] = (-9);
	blockB[0].b[4] = (8);
	blockB[0].b[5] = (2);
	blockB[0].b[6] = (5);
	blockC.c = (3);
	blockC.d[0] = (vec3(-7.0, -9.0, 5.0));
	blockD.e = (uvec4(3u, 6u, 0u, 1u));
	blockD.g.mA = (ivec4(-5, -9, 5, -7));
	blockD.g.mB.mA = (ivec4(4, -2, -2, 3));
	blockD.g.mC = (bvec4(true, true, true, true));
}
#version 450
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
	lowp float mA;
	lowp uvec3 mB;
};
struct sB
{
	highp mat3x4 mA[3];
};
struct sC
{
	highp uvec2 mA;
	highp mat4 mB;
	sA mC;
	sB mD;
};
layout(scalar, buffer_reference) buffer BlockB
{
	highp mat3x4 a;
	bvec3 b;
	mediump uvec2 c;
	highp mat4x3 d;
	mediump mat4 e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	sC f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.b), bvec3(false, false, false)) && allOk;
	allOk = compare_mat4x3(blockB.d, mat4x3(-2.0, 4.0, 5.0, -8.0, 3.0, 6.0, -4.0, -1.0, 2.0, -5.0, -2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(-5.0, -4.0, 8.0, -4.0, 1.0, -5.0, 1.0, -5.0, 3.0, -6.0, -4.0, -5.0));
	blockB.b = (bvec3(false, true, true));
	blockB.c = (uvec2(4u, 7u));
	blockC.f[0].mA = (uvec2(6u, 9u));
	blockC.f[0].mB = (mat4(2.0, 1.0, -2.0, 8.0, 1.0, -7.0, 3.0, -8.0, 4.0, -9.0, -7.0, -6.0, 3.0, -6.0, 2.0, -9.0));
	blockC.f[0].mC.mA = (1.0);
	blockC.f[0].mC.mB = (uvec3(2u, 5u, 7u));
	blockC.f[0].mD.mA[0] = (mat3x4(6.0, 8.0, -1.0, 4.0, 0.0, -6.0, -8.0, 8.0, -8.0, 9.0, -8.0, 3.0));
	blockC.f[0].mD.mA[1] = (mat3x4(7.0, 0.0, -8.0, 9.0, -1.0, 2.0, 8.0, -5.0, 6.0, -1.0, 4.0, -1.0));
	blockC.f[0].mD.mA[2] = (mat3x4(-5.0, -6.0, -7.0, -4.0, -6.0, 7.0, 3.0, -6.0, -5.0, 8.0, -9.0, -9.0));
	blockC.f[1].mA = (uvec2(5u, 8u));
	blockC.f[1].mB = (mat4(6.0, -2.0, 8.0, -7.0, 6.0, -2.0, 6.0, 3.0, -7.0, 5.0, -2.0, 1.0, 9.0, 1.0, -4.0, 0.0));
	blockC.f[1].mC.mA = (-5.0);
	blockC.f[1].mC.mB = (uvec3(3u, 2u, 3u));
	blockC.f[1].mD.mA[0] = (mat3x4(-4.0, -6.0, 4.0, 3.0, -2.0, 9.0, -2.0, -6.0, -6.0, -2.0, 3.0, -5.0));
	blockC.f[1].mD.mA[1] = (mat3x4(2.0, 2.0, -6.0, 8.0, 3.0, -1.0, -4.0, -8.0, 2.0, -1.0, -7.0, 8.0));
	blockC.f[1].mD.mA[2] = (mat3x4(-8.0, -6.0, -1.0, 3.0, 4.0, -6.0, 9.0, 8.0, 9.0, -7.0, -2.0, 5.0));
	blockC.f[2].mA = (uvec2(3u, 6u));
	blockC.f[2].mB = (mat4(2.0, 7.0, -7.0, 8.0, 6.0, 7.0, -4.0, -1.0, 7.0, 4.0, 2.0, -5.0, -4.0, -2.0, 6.0, 2.0));
	blockC.f[2].mC.mA = (2.0);
	blockC.f[2].mC.mB = (uvec3(8u, 8u, 7u));
	blockC.f[2].mD.mA[0] = (mat3x4(2.0, 8.0, 7.0, 0.0, -2.0, 2.0, 9.0, 9.0, 8.0, -6.0, -8.0, -1.0));
	blockC.f[2].mD.mA[1] = (mat3x4(-7.0, -1.0, -2.0, 0.0, -4.0, -5.0, -7.0, 9.0, 5.0, 6.0, -6.0, 3.0));
	blockC.f[2].mD.mA[2] = (mat3x4(1.0, 1.0, 3.0, 3.0, -9.0, 1.0, 4.0, 1.0, -1.0, -9.0, -7.0, -5.0));
	blockC.f[3].mA = (uvec2(8u, 1u));
	blockC.f[3].mB = (mat4(1.0, 0.0, -1.0, 1.0, 1.0, 0.0, -6.0, 1.0, 0.0, 6.0, -2.0, 7.0, 0.0, -1.0, -6.0, 6.0));
	blockC.f[3].mC.mA = (-1.0);
	blockC.f[3].mC.mB = (uvec3(8u, 1u, 9u));
	blockC.f[3].mD.mA[0] = (mat3x4(8.0, 1.0, -2.0, 3.0, 6.0, -2.0, 5.0, 2.0, 7.0, -1.0, -7.0, 2.0));
	blockC.f[3].mD.mA[1] = (mat3x4(-3.0, -4.0, -1.0, -4.0, -3.0, 0.0, -2.0, -3.0, 5.0, -8.0, -6.0, -9.0));
	blockC.f[3].mD.mA[2] = (mat3x4(-9.0, -8.0, 4.0, -9.0, 0.0, -9.0, 9.0, 2.0, -7.0, -6.0, 4.0, -3.0));
	blockC.f[4].mA = (uvec2(9u, 5u));
	blockC.f[4].mB = (mat4(-1.0, -2.0, -3.0, -3.0, -3.0, 2.0, -4.0, -2.0, 7.0, -5.0, 1.0, 4.0, -6.0, -1.0, -6.0, 0.0));
	blockC.f[4].mC.mA = (-4.0);
	blockC.f[4].mC.mB = (uvec3(8u, 1u, 9u));
	blockC.f[4].mD.mA[0] = (mat3x4(6.0, -4.0, 3.0, -4.0, -3.0, 6.0, 4.0, 1.0, -2.0, -9.0, -5.0, 6.0));
	blockC.f[4].mD.mA[1] = (mat3x4(-1.0, -9.0, 5.0, 3.0, -9.0, -7.0, -4.0, 5.0, -4.0, 6.0, 8.0, -2.0));
	blockC.f[4].mD.mA[2] = (mat3x4(1.0, 8.0, 4.0, 1.0, -8.0, -5.0, 3.0, -4.0, 4.0, 8.0, -5.0, 0.0));
	blockC.f[5].mA = (uvec2(1u, 1u));
	blockC.f[5].mB = (mat4(0.0, 8.0, -8.0, 9.0, -1.0, -6.0, 1.0, -8.0, 9.0, -4.0, 2.0, -1.0, -1.0, -7.0, 4.0, -6.0));
	blockC.f[5].mC.mA = (-7.0);
	blockC.f[5].mC.mB = (uvec3(7u, 8u, 1u));
	blockC.f[5].mD.mA[0] = (mat3x4(9.0, -8.0, 6.0, -7.0, 8.0, -8.0, -5.0, -1.0, 2.0, -6.0, 0.0, 4.0));
	blockC.f[5].mD.mA[1] = (mat3x4(-1.0, 0.0, -1.0, -9.0, -5.0, -6.0, 0.0, 1.0, -6.0, -8.0, 9.0, 2.0));
	blockC.f[5].mD.mA[2] = (mat3x4(-2.0, -8.0, -1.0, 6.0, 7.0, -5.0, -4.0, 1.0, -9.0, 9.0, 1.0, -5.0));
}
#version 450
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
	highp ivec2 b;
	highp mat4 c;
	lowp mat4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].b), ivec2(-9, 8)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(0)].d, mat4(1.0, 3.0, -9.0, -4.0, 3.0, 9.0, 1.0, 3.0, -9.0, -5.0, 9.0, -7.0, -8.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].b), ivec2(-4, 4)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(1)].d, mat4(4.0, -7.0, 6.0, 8.0, 0.0, -7.0, -8.0, -7.0, -3.0, 3.0, 2.0, -8.0, -1.0, -7.0, 0.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4(6.0, -1.0, 0.0, 3.0, -7.0, 6.0, -7.0, 6.0, -8.0, -4.0, -6.0, 3.0, -2.0, 5.0, -2.0, 6.0));
	blockB[nonuniformEXT(0)].b = (ivec2(7, -5));
	blockB[nonuniformEXT(0)].c = (mat4(-5.0, -2.0, -2.0, 7.0, -2.0, 1.0, 3.0, -9.0, -2.0, -7.0, 9.0, -9.0, 4.0, -1.0, 8.0, 4.0));
	blockB[nonuniformEXT(0)].d = (mat4(-4.0, 0.0, 7.0, 6.0, 5.0, 3.0, 3.0, -4.0, -6.0, 4.0, 2.0, -6.0, 7.0, -8.0, 5.0, 6.0));
	blockB[nonuniformEXT(1)].a = (mat4(8.0, 9.0, 0.0, -7.0, -6.0, -3.0, 8.0, 1.0, -3.0, 0.0, 7.0, -5.0, -5.0, 7.0, 8.0, -6.0));
	blockB[nonuniformEXT(1)].b = (ivec2(1, 8));
	blockB[nonuniformEXT(1)].c = (mat4(-5.0, 4.0, 8.0, 5.0, -5.0, -7.0, -3.0, -6.0, 4.0, -9.0, 5.0, 1.0, -9.0, 6.0, -7.0, -8.0));
	blockB[nonuniformEXT(1)].d = (mat4(-2.0, 6.0, 4.0, -3.0, 4.0, 9.0, -8.0, -8.0, 5.0, -9.0, -3.0, -3.0, -3.0, -1.0, -6.0, 6.0));
}
#version 450
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
	layout(offset = 0) mediump int a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[nonuniformEXT(0)].a), -4) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(1)].a), 6) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(2)].a), 6) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(3)].a), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (9);
	blockB[nonuniformEXT(1)].a = (-7);
	blockB[nonuniformEXT(2)].a = (-5);
	blockB[nonuniformEXT(3)].a = (-9);
}
#version 450
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
	highp vec3 mA;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	f16vec4 a;
	u16vec3 b;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp mat3 c[1];
	sA d;
	i16vec4 e;
	highp uvec2 f;
	bvec3 g[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	lowp mat4x3 h[1];
	f16vec2 i;
	lowp mat3x4 j;
	highp vec2 k[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockE
{
	highp mat3 l[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a), vec4(1.0, -3.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3(blockC.c[0], mat3(-8.0, 2.0, -6.0, 5.0, -7.0, 2.0, 8.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec3((blockC.d.mA), vec3(-8.0, 7.0, -1.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.e), ivec4(2, 2, 6, 1)) && allOk;
	allOk = compare_mat4x3(blockD.h[0], mat4x3(-1.0, -1.0, 5.0, 4.0, 0.0, -1.0, -2.0, -9.0, 1.0, 0.0, 8.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockD.i), vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2((blockD.k[0]), vec2(0.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec4(vec4(9.0, -2.0, -3.0, -7.0));
	blockC.c[0] = (mat3(7.0, 6.0, -4.0, 5.0, 7.0, 9.0, -2.0, 6.0, 4.0));
	blockC.d.mA = (vec3(0.0, 7.0, 5.0));
	blockC.e = i16vec4(ivec4(-3, 1, 0, -8));
	blockC.f = (uvec2(3u, 2u));
	blockC.g[0] = (bvec3(true, true, false));
	blockD.h[0] = (mat4x3(6.0, 3.0, 9.0, -8.0, 1.0, 4.0, -5.0, 0.0, -7.0, -1.0, 7.0, 9.0));
	blockD.i = f16vec2(vec2(5.0, -4.0));
	blockD.j = (mat3x4(-6.0, 0.0, -8.0, -2.0, 5.0, -8.0, 0.0, -6.0, 9.0, 3.0, -2.0, 9.0));
	blockD.k[0] = (vec2(-1.0, 8.0));
}
#version 450
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
	highp float mB;
};
struct sB
{
	highp mat3 mA;
};
layout(std430, buffer_reference) buffer BlockB
{
	sA a;
	sB b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.b[0].mA, mat3(-4.0, -6.0, -2.0, 8.0, 4.0, -4.0, -9.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3(blockB.b[1].mA, mat3(9.0, -3.0, -8.0, 6.0, 0.0, -1.0, -3.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0].mA = (mat3(-7.0, -4.0, -4.0, -6.0, -5.0, -2.0, 4.0, -2.0, 5.0));
	blockB.b[1].mA = (mat3(-9.0, -3.0, -1.0, -9.0, 1.0, 1.0, 7.0, 8.0, 9.0));
}
#version 450
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
	mediump ivec2 mA;
	mediump mat2x3 mB;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	bvec2 a;
	bvec2 b;
	mediump vec2 c;
	mediump mat3x4 d;
	mediump ivec3 e[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	sA f[2];
	mediump mat2 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(false, true)) && allOk;
	allOk = compare_vec2((blockB.c), vec2(4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB.d, mat3x4(-8.0, -7.0, 1.0, -4.0, -1.0, 3.0, 9.0, 1.0, 4.0, 8.0, 5.0, -4.0)) && allOk;
	allOk = compare_ivec3((blockB.e[0]), ivec3(-4, -3, 1)) && allOk;
	allOk = compare_ivec2((blockC[0].f[0].mA), ivec2(5, 6)) && allOk;
	allOk = compare_mat2x3(blockC[0].f[0].mB, mat2x3(1.0, 1.0, 6.0, -3.0, 6.0, 6.0)) && allOk;
	allOk = compare_ivec2((blockC[0].f[1].mA), ivec2(9, 0)) && allOk;
	allOk = compare_mat2x3(blockC[0].f[1].mB, mat2x3(-8.0, 6.0, 1.0, 6.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2(blockC[0].g[0], mat2(6.0, 0.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2(blockC[0].g[1], mat2(2.0, 9.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2(blockC[0].g[2], mat2(9.0, -9.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2(blockC[0].g[3], mat2(5.0, 3.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2(blockC[0].g[4], mat2(-6.0, 9.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2(blockC[0].g[5], mat2(5.0, 6.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(blockC[0].g[6], mat2(-9.0, 8.0, -5.0, 5.0)) && allOk;
	allOk = compare_ivec2((blockC[1].f[0].mA), ivec2(-4, -1)) && allOk;
	allOk = compare_mat2x3(blockC[1].f[0].mB, mat2x3(-7.0, 4.0, 0.0, 1.0, -2.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockC[1].f[1].mA), ivec2(-8, 4)) && allOk;
	allOk = compare_mat2x3(blockC[1].f[1].mB, mat2x3(-3.0, 2.0, 2.0, -7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2(blockC[1].g[0], mat2(-6.0, 2.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat2(blockC[1].g[1], mat2(9.0, 9.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat2(blockC[1].g[2], mat2(2.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2(blockC[1].g[3], mat2(-5.0, 9.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2(blockC[1].g[4], mat2(-8.0, 4.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat2(blockC[1].g[5], mat2(-7.0, 7.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(blockC[1].g[6], mat2(9.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2(blockC[1].g[7], mat2(0.0, 3.0, -2.0, 2.0)) && allOk;
	allOk = compare_ivec2((blockC[2].f[0].mA), ivec2(-6, -2)) && allOk;
	allOk = compare_mat2x3(blockC[2].f[0].mB, mat2x3(-3.0, -6.0, -1.0, 1.0, 5.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockC[2].f[1].mA), ivec2(1, 6)) && allOk;
	allOk = compare_mat2x3(blockC[2].f[1].mB, mat2x3(-6.0, 1.0, 4.0, -9.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2(blockC[2].g[0], mat2(6.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat2(blockC[2].g[1], mat2(5.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2(blockC[2].g[2], mat2(3.0, -2.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2(blockC[2].g[3], mat2(-7.0, -1.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat2(blockC[2].g[4], mat2(-6.0, 6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(blockC[2].g[5], mat2(-3.0, 4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat2(blockC[2].g[6], mat2(0.0, -4.0, -6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b = (bvec2(true, false));
	blockB.c = (vec2(2.0, -4.0));
	blockB.d = (mat3x4(-1.0, 0.0, -5.0, 0.0, -9.0, 6.0, 2.0, 4.0, 0.0, -6.0, 3.0, -4.0));
	blockB.e[0] = (ivec3(-4, 1, -6));
	blockC[0].f[0].mA = (ivec2(2, -1));
	blockC[0].f[0].mB = (mat2x3(-7.0, -8.0, -1.0, 8.0, 1.0, -6.0));
	blockC[0].f[1].mA = (ivec2(4, -4));
	blockC[0].f[1].mB = (mat2x3(-3.0, 0.0, -5.0, 2.0, -6.0, -6.0));
	blockC[1].f[0].mA = (ivec2(-1, -8));
	blockC[1].f[0].mB = (mat2x3(4.0, -4.0, -9.0, -3.0, 9.0, -8.0));
	blockC[1].f[1].mA = (ivec2(0, -8));
	blockC[1].f[1].mB = (mat2x3(8.0, 2.0, 8.0, 1.0, -6.0, -9.0));
	blockC[2].f[0].mA = (ivec2(3, -9));
	blockC[2].f[0].mB = (mat2x3(3.0, -5.0, -6.0, -6.0, 9.0, -9.0));
	blockC[2].f[1].mA = (ivec2(4, 8));
	blockC[2].f[1].mB = (mat2x3(-2.0, -9.0, 6.0, -4.0, -8.0, 3.0));
}
#version 450
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
	highp mat3 mB;
	u16vec3 mC;
	highp mat4x3 mD;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	sA a;
	mediump int b[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	highp ivec2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b[0]), 7) && allOk;
	allOk = compare_int((blockB.b[1]), -8) && allOk;
	allOk = compare_int((blockB.b[2]), 9) && allOk;
	allOk = compare_int((blockB.b[3]), 7) && allOk;
	allOk = compare_int((blockB.b[4]), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (vec3(-7.0, 4.0, -4.0));
	blockB.a.mB = (mat3(-7.0, -3.0, -9.0, 1.0, 2.0, 8.0, -2.0, 5.0, -7.0));
	blockB.a.mC = u16vec3(uvec3(4u, 1u, 9u));
	blockB.a.mD = (mat4x3(-7.0, 3.0, 1.0, 2.0, -4.0, -6.0, 7.0, 1.0, 9.0, 1.0, 3.0, 9.0));
	blockC.c[0] = (ivec2(8, 0));
	blockC.c[1] = (ivec2(6, 5));
	blockC.c[2] = (ivec2(6, -3));
	blockC.c[3] = (ivec2(-8, 8));
	blockC.c[4] = (ivec2(-8, -6));
}
#version 450
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
	highp uint a;
	u16vec4 b[7];
	u16vec2 c;
	mediump ivec2 d;
	mediump mat4x3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.b[0]), uvec4(7u, 4u, 7u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b[1]), uvec4(3u, 5u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b[2]), uvec4(8u, 7u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b[3]), uvec4(7u, 1u, 2u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b[4]), uvec4(2u, 1u, 5u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b[5]), uvec4(6u, 1u, 3u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b[6]), uvec4(4u, 8u, 4u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.c), uvec2(4u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = u16vec4(uvec4(2u, 5u, 7u, 0u));
	blockB.b[1] = u16vec4(uvec4(7u, 4u, 1u, 7u));
	blockB.b[2] = u16vec4(uvec4(5u, 0u, 0u, 6u));
	blockB.b[3] = u16vec4(uvec4(2u, 6u, 3u, 7u));
	blockB.b[4] = u16vec4(uvec4(5u, 0u, 9u, 5u));
	blockB.b[5] = u16vec4(uvec4(7u, 8u, 3u, 2u));
	blockB.b[6] = u16vec4(uvec4(2u, 8u, 3u, 3u));
}
#version 450
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
	lowp ivec2 mB;
};
struct sB
{
	f16vec4 mA;
	mediump mat3x2 mB;
	mediump vec4 mC;
	sA mD;
};
layout(scalar, buffer_reference) buffer BlockB
{
	lowp uvec4 a;
	mediump uvec2 b[4];
	sB c[][3];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	mediump ivec2 d[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	f16vec3 e[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	bool f;
	highp vec2 g[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(9u, 4u, 4u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.b[0]), uvec2(5u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.b[1]), uvec2(0u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.b[2]), uvec2(1u, 1u)) && allOk;
	allOk = compare_uvec2((blockB.b[3]), uvec2(1u, 1u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c[0][0].mA), vec4(2.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[0][0].mB, mat3x2(7.0, 9.0, -8.0, 5.0, -3.0, -3.0)) && allOk;
	allOk = compare_vec4((blockB.c[0][0].mC), vec4(6.0, 7.0, -7.0, 1.0)) && allOk;
	allOk = compare_bool((blockB.c[0][0].mD.mA), true) && allOk;
	allOk = compare_ivec2((blockB.c[0][0].mD.mB), ivec2(-1, 7)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c[0][1].mA), vec4(2.0, 5.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[0][1].mB, mat3x2(-8.0, 4.0, 9.0, -2.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB.c[0][1].mC), vec4(0.0, 9.0, 5.0, 1.0)) && allOk;
	allOk = compare_bool((blockB.c[0][1].mD.mA), false) && allOk;
	allOk = compare_ivec2((blockB.c[0][1].mD.mB), ivec2(-4, 8)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c[0][2].mA), vec4(-5.0, -3.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[0][2].mB, mat3x2(-6.0, -1.0, -9.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec4((blockB.c[0][2].mC), vec4(-9.0, -7.0, 1.0, 1.0)) && allOk;
	allOk = compare_bool((blockB.c[0][2].mD.mA), true) && allOk;
	allOk = compare_ivec2((blockB.c[0][2].mD.mB), ivec2(-9, 4)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c[1][0].mA), vec4(-3.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[1][0].mB, mat3x2(-9.0, 8.0, -7.0, 3.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec4((blockB.c[1][0].mC), vec4(6.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_bool((blockB.c[1][0].mD.mA), true) && allOk;
	allOk = compare_ivec2((blockB.c[1][0].mD.mB), ivec2(8, 4)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c[1][1].mA), vec4(5.0, -8.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[1][1].mB, mat3x2(0.0, 3.0, 4.0, 1.0, 0.0, -4.0)) && allOk;
	allOk = compare_vec4((blockB.c[1][1].mC), vec4(9.0, -6.0, -3.0, 5.0)) && allOk;
	allOk = compare_bool((blockB.c[1][1].mD.mA), false) && allOk;
	allOk = compare_ivec2((blockB.c[1][1].mD.mB), ivec2(2, 2)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c[1][2].mA), vec4(-9.0, -2.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[1][2].mB, mat3x2(-2.0, -3.0, -3.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec4((blockB.c[1][2].mC), vec4(5.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_bool((blockB.c[1][2].mD.mA), false) && allOk;
	allOk = compare_ivec2((blockB.c[1][2].mD.mB), ivec2(-4, 0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c[2][0].mA), vec4(9.0, -6.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[2][0].mB, mat3x2(8.0, 9.0, -9.0, -6.0, 4.0, 1.0)) && allOk;
	allOk = compare_vec4((blockB.c[2][0].mC), vec4(9.0, -1.0, -8.0, 6.0)) && allOk;
	allOk = compare_bool((blockB.c[2][0].mD.mA), true) && allOk;
	allOk = compare_ivec2((blockB.c[2][0].mD.mB), ivec2(5, -4)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c[2][1].mA), vec4(-2.0, -8.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[2][1].mB, mat3x2(4.0, 6.0, -8.0, 1.0, -3.0, -3.0)) && allOk;
	allOk = compare_vec4((blockB.c[2][1].mC), vec4(-9.0, -9.0, 6.0, 2.0)) && allOk;
	allOk = compare_bool((blockB.c[2][1].mD.mA), false) && allOk;
	allOk = compare_ivec2((blockB.c[2][1].mD.mB), ivec2(-6, 8)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c[2][2].mA), vec4(-2.0, -2.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[2][2].mB, mat3x2(-2.0, 6.0, -7.0, -6.0, 0.0, 7.0)) && allOk;
	allOk = compare_vec4((blockB.c[2][2].mC), vec4(-9.0, -9.0, 1.0, 9.0)) && allOk;
	allOk = compare_bool((blockB.c[2][2].mD.mA), false) && allOk;
	allOk = compare_ivec2((blockB.c[2][2].mD.mB), ivec2(-5, -8)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c[3][0].mA), vec4(2.0, 1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[3][0].mB, mat3x2(-4.0, -1.0, 5.0, -9.0, 5.0, 4.0)) && allOk;
	allOk = compare_vec4((blockB.c[3][0].mC), vec4(1.0, 2.0, -7.0, 1.0)) && allOk;
	allOk = compare_bool((blockB.c[3][0].mD.mA), false) && allOk;
	allOk = compare_ivec2((blockB.c[3][0].mD.mB), ivec2(4, -8)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c[3][1].mA), vec4(8.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[3][1].mB, mat3x2(1.0, -6.0, 2.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_vec4((blockB.c[3][1].mC), vec4(8.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_bool((blockB.c[3][1].mD.mA), false) && allOk;
	allOk = compare_ivec2((blockB.c[3][1].mD.mB), ivec2(8, -1)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c[3][2].mA), vec4(-6.0, -9.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[3][2].mB, mat3x2(0.0, 2.0, -6.0, 5.0, 6.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB.c[3][2].mC), vec4(0.0, -6.0, 9.0, -9.0)) && allOk;
	allOk = compare_bool((blockB.c[3][2].mD.mA), true) && allOk;
	allOk = compare_ivec2((blockB.c[3][2].mD.mB), ivec2(4, 2)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c[4][0].mA), vec4(7.0, 9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[4][0].mB, mat3x2(7.0, -8.0, 9.0, -9.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec4((blockB.c[4][0].mC), vec4(-8.0, 5.0, 3.0, -1.0)) && allOk;
	allOk = compare_bool((blockB.c[4][0].mD.mA), false) && allOk;
	allOk = compare_ivec2((blockB.c[4][0].mD.mB), ivec2(-4, -9)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c[4][1].mA), vec4(-5.0, -6.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[4][1].mB, mat3x2(7.0, 9.0, 9.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB.c[4][1].mC), vec4(1.0, -1.0, -2.0, 8.0)) && allOk;
	allOk = compare_bool((blockB.c[4][1].mD.mA), false) && allOk;
	allOk = compare_ivec2((blockB.c[4][1].mD.mB), ivec2(-3, 9)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c[4][2].mA), vec4(-4.0, 7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[4][2].mB, mat3x2(-5.0, 2.0, -2.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_vec4((blockB.c[4][2].mC), vec4(-7.0, -3.0, -1.0, -4.0)) && allOk;
	allOk = compare_bool((blockB.c[4][2].mD.mA), true) && allOk;
	allOk = compare_ivec2((blockB.c[4][2].mD.mB), ivec2(-6, -2)) && allOk;
	allOk = compare_ivec2((blockC.d[0]), ivec2(-2, 1)) && allOk;
	allOk = compare_ivec2((blockC.d[1]), ivec2(6, 0)) && allOk;
	allOk = compare_ivec2((blockC.d[2]), ivec2(-1, -4)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.e[0]), vec3(1.0, -2.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.e[1]), vec3(-6.0, 3.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.e[2]), vec3(2.0, -6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0][0].mA = f16vec4(vec4(8.0, -3.0, -6.0, 3.0));
	blockB.c[0][0].mB = (mat3x2(6.0, 2.0, -4.0, -9.0, -5.0, -9.0));
	blockB.c[0][0].mC = (vec4(4.0, 7.0, 6.0, -9.0));
	blockB.c[0][0].mD.mA = (false);
	blockB.c[0][0].mD.mB = (ivec2(5, 9));
	blockB.c[0][1].mA = f16vec4(vec4(1.0, -9.0, 7.0, -3.0));
	blockB.c[0][1].mB = (mat3x2(-9.0, 2.0, 0.0, 0.0, -3.0, -8.0));
	blockB.c[0][1].mC = (vec4(3.0, 1.0, -7.0, 7.0));
	blockB.c[0][1].mD.mA = (false);
	blockB.c[0][1].mD.mB = (ivec2(8, -2));
	blockB.c[0][2].mA = f16vec4(vec4(-5.0, 6.0, 0.0, 5.0));
	blockB.c[0][2].mB = (mat3x2(5.0, 5.0, 4.0, -2.0, 4.0, -1.0));
	blockB.c[0][2].mC = (vec4(6.0, 7.0, -1.0, -8.0));
	blockB.c[0][2].mD.mA = (true);
	blockB.c[0][2].mD.mB = (ivec2(2, -7));
	blockB.c[1][0].mA = f16vec4(vec4(6.0, 1.0, -3.0, 6.0));
	blockB.c[1][0].mB = (mat3x2(-6.0, -3.0, -5.0, 9.0, 9.0, 7.0));
	blockB.c[1][0].mC = (vec4(8.0, 8.0, -4.0, -5.0));
	blockB.c[1][0].mD.mA = (false);
	blockB.c[1][0].mD.mB = (ivec2(-3, 6));
	blockB.c[1][1].mA = f16vec4(vec4(8.0, -2.0, -4.0, -7.0));
	blockB.c[1][1].mB = (mat3x2(2.0, -3.0, -3.0, -1.0, -5.0, 8.0));
	blockB.c[1][1].mC = (vec4(4.0, -5.0, 9.0, 2.0));
	blockB.c[1][1].mD.mA = (false);
	blockB.c[1][1].mD.mB = (ivec2(5, 5));
	blockB.c[1][2].mA = f16vec4(vec4(-6.0, 6.0, 4.0, -1.0));
	blockB.c[1][2].mB = (mat3x2(3.0, -2.0, -7.0, 4.0, 0.0, 8.0));
	blockB.c[1][2].mC = (vec4(5.0, 8.0, -6.0, -5.0));
	blockB.c[1][2].mD.mA = (false);
	blockB.c[1][2].mD.mB = (ivec2(-9, 3));
	blockB.c[2][0].mA = f16vec4(vec4(9.0, -9.0, 2.0, -4.0));
	blockB.c[2][0].mB = (mat3x2(-9.0, 9.0, 5.0, 8.0, 4.0, 8.0));
	blockB.c[2][0].mC = (vec4(-1.0, 2.0, 6.0, -3.0));
	blockB.c[2][0].mD.mA = (false);
	blockB.c[2][0].mD.mB = (ivec2(6, -2));
	blockB.c[2][1].mA = f16vec4(vec4(-8.0, -2.0, 8.0, -3.0));
	blockB.c[2][1].mB = (mat3x2(1.0, -1.0, -1.0, 4.0, 3.0, 5.0));
	blockB.c[2][1].mC = (vec4(8.0, -6.0, -5.0, -4.0));
	blockB.c[2][1].mD.mA = (false);
	blockB.c[2][1].mD.mB = (ivec2(8, -3));
	blockB.c[2][2].mA = f16vec4(vec4(-7.0, 6.0, -5.0, -1.0));
	blockB.c[2][2].mB = (mat3x2(9.0, 2.0, -9.0, -1.0, -7.0, 7.0));
	blockB.c[2][2].mC = (vec4(6.0, 2.0, 4.0, -5.0));
	blockB.c[2][2].mD.mA = (true);
	blockB.c[2][2].mD.mB = (ivec2(4, 0));
	blockB.c[3][0].mA = f16vec4(vec4(-7.0, 9.0, 2.0, -9.0));
	blockB.c[3][0].mB = (mat3x2(5.0, -7.0, 7.0, 6.0, -2.0, 5.0));
	blockB.c[3][0].mC = (vec4(-9.0, -2.0, 2.0, 0.0));
	blockB.c[3][0].mD.mA = (false);
	blockB.c[3][0].mD.mB = (ivec2(4, 8));
	blockB.c[3][1].mA = f16vec4(vec4(4.0, 0.0, 1.0, -1.0));
	blockB.c[3][1].mB = (mat3x2(-4.0, -6.0, 9.0, -2.0, -2.0, -5.0));
	blockB.c[3][1].mC = (vec4(-7.0, 3.0, -1.0, -3.0));
	blockB.c[3][1].mD.mA = (true);
	blockB.c[3][1].mD.mB = (ivec2(1, -6));
	blockB.c[3][2].mA = f16vec4(vec4(4.0, -6.0, -5.0, -8.0));
	blockB.c[3][2].mB = (mat3x2(4.0, 5.0, -5.0, 1.0, -7.0, 5.0));
	blockB.c[3][2].mC = (vec4(8.0, -4.0, 0.0, -7.0));
	blockB.c[3][2].mD.mA = (false);
	blockB.c[3][2].mD.mB = (ivec2(5, 4));
	blockB.c[4][0].mA = f16vec4(vec4(3.0, -5.0, 4.0, -4.0));
	blockB.c[4][0].mB = (mat3x2(9.0, -6.0, 4.0, -8.0, -5.0, -8.0));
	blockB.c[4][0].mC = (vec4(5.0, -3.0, 8.0, 6.0));
	blockB.c[4][0].mD.mA = (false);
	blockB.c[4][0].mD.mB = (ivec2(-6, 0));
	blockB.c[4][1].mA = f16vec4(vec4(-3.0, 9.0, 7.0, 1.0));
	blockB.c[4][1].mB = (mat3x2(-2.0, 4.0, 0.0, 9.0, 1.0, 0.0));
	blockB.c[4][1].mC = (vec4(-1.0, -7.0, 4.0, 2.0));
	blockB.c[4][1].mD.mA = (false);
	blockB.c[4][1].mD.mB = (ivec2(8, -2));
	blockB.c[4][2].mA = f16vec4(vec4(-7.0, -3.0, 3.0, -1.0));
	blockB.c[4][2].mB = (mat3x2(3.0, -2.0, 2.0, -4.0, -3.0, 4.0));
	blockB.c[4][2].mC = (vec4(-7.0, -3.0, 7.0, -8.0));
	blockB.c[4][2].mD.mA = (false);
	blockB.c[4][2].mD.mB = (ivec2(4, 3));
	blockC.d[0] = (ivec2(8, 0));
	blockC.d[1] = (ivec2(-5, -8));
	blockC.d[2] = (ivec2(7, -3));
	blockD.e[0] = f16vec3(vec3(-5.0, -2.0, 1.0));
	blockD.e[1] = f16vec3(vec3(-7.0, 1.0, 7.0));
	blockD.e[2] = f16vec3(vec3(-8.0, -9.0, -4.0));
	blockE.g[0] = (vec2(4.0, -6.0));
	blockE.g[1] = (vec2(5.0, -1.0));
	blockE.g[2] = (vec2(-1.0, 0.0));
	blockE.g[3] = (vec2(-3.0, -5.0));
	blockE.g[4] = (vec2(-6.0, 1.0));
	blockE.g[5] = (vec2(-8.0, 2.0));
	blockE.g[6] = (vec2(-8.0, -2.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(column_major, buffer_reference) readonly buffer BlockB
{
	layout(offset = 0) u16vec4 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(0)].a), uvec4(2u, 3u, 7u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(1)].a), uvec4(3u, 2u, 4u, 7u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(2)].a), uvec4(0u, 3u, 2u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(3)].a), uvec4(4u, 6u, 4u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4x3 a;
	u16vec2 b;
	u16vec3 c;
	lowp uvec2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB[nonuniformEXT(0)].c), uvec3(2u, 6u, 4u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].d), uvec2(5u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB[nonuniformEXT(1)].c), uvec3(3u, 1u, 6u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].d), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB[nonuniformEXT(2)].c), uvec3(1u, 8u, 4u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(2)].d), uvec2(2u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = u16vec2(uvec2(7u, 8u));
	blockB[nonuniformEXT(0)].c = u16vec3(uvec3(3u, 0u, 5u));
	blockB[nonuniformEXT(1)].b = u16vec2(uvec2(1u, 4u));
	blockB[nonuniformEXT(1)].c = u16vec3(uvec3(6u, 0u, 8u));
	blockB[nonuniformEXT(2)].b = u16vec2(uvec2(9u, 5u));
	blockB[nonuniformEXT(2)].c = u16vec3(uvec3(7u, 6u, 6u));
}
#version 450
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
	bvec2 a;
	uint16_t b[1];
	highp int c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[nonuniformEXT(0)].c), -1) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(1)].c), -5) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(2)].c), -4) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b[0] = uint16_t(2u);
	blockB[nonuniformEXT(0)].c = (-4);
	blockB[nonuniformEXT(1)].b[0] = uint16_t(1u);
	blockB[nonuniformEXT(1)].c = (5);
	blockB[nonuniformEXT(2)].b[0] = uint16_t(4u);
	blockB[nonuniformEXT(2)].c = (3);
}
#version 450
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
	layout(offset = 0) f16vec4 a;
	layout(offset = 8) i16vec3 b;
	layout(offset = 16) highp uvec4 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(0)].a), vec4(-4.0, 4.0, -6.0, -2.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[nonuniformEXT(0)].b), ivec3(-1, -2, 6)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(0)].c), uvec4(6u, 1u, 8u, 9u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(1)].a), vec4(-4.0, -6.0, -3.0, -1.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[nonuniformEXT(1)].b), ivec3(4, 8, -1)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(1)].c), uvec4(0u, 5u, 1u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = f16vec4(vec4(6.0, 0.0, 5.0, 1.0));
	blockB[nonuniformEXT(0)].c = (uvec4(3u, 3u, 1u, 6u));
	blockB[nonuniformEXT(1)].a = f16vec4(vec4(-8.0, -9.0, 5.0, 4.0));
	blockB[nonuniformEXT(1)].c = (uvec4(9u, 4u, 1u, 4u));
}
#version 450
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
	mediump ivec4 a;
	mediump uint b;
	i8vec4 c[];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump mat4 d;
	highp mat4x2 e;
	bvec2 f;
	mediump ivec3 g;
	i8vec4 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.c[0]), ivec4(4294967295, 4, 1, 4294967288)) && allOk;
	allOk = compare_mat4(blockC.d, mat4(-1.0, 4.0, -7.0, 3.0, 8.0, 1.0, 9.0, 5.0, -4.0, 1.0, -4.0, -4.0, -3.0, 1.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockC.e, mat4x2(9.0, 0.0, 1.0, -3.0, 1.0, 6.0, 6.0, 6.0)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(true, true)) && allOk;
	allOk = compare_ivec3((blockC.g), ivec3(1, 4, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(9, 7, 5, -2));
	blockB.b = (4u);
	blockB.c[0] = i8vec4(ivec4(4294967290, 1, 2, 4294967292));
	blockC.e = (mat4x2(-1.0, 4.0, -4.0, -7.0, 8.0, -8.0, 1.0, -1.0));
	blockC.f = (bvec2(true, true));
	blockC.g = (ivec3(-6, -5, -6));
	blockC.h[0] = i8vec4(ivec4(6, 4294967289, 0, 4294967287));
}
#version 450
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
	lowp mat2x3 mB;
};
struct sB
{
	sA mA;
	highp mat4x3 mB;
	mediump int mC;
};
layout(std430, buffer_reference) buffer BlockB
{
	highp mat3x4 a;
	bool b;
	highp mat4 c;
	lowp ivec2 d[7];
	highp ivec4 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp mat3 f;
	lowp uvec2 g;
	lowp mat2 h[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	sB i;
	bvec4 j[7];
	lowp mat4x2 k[][2];
};
layout(std140, buffer_reference) buffer BlockE
{
	highp ivec4 l;
	highp mat3 m;
	highp int n[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a, mat3x4(1.0, -6.0, -5.0, 7.0, 2.0, -1.0, 4.0, 1.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_ivec4((blockB.e[0]), ivec4(2, -1, 9, -9)) && allOk;
	allOk = compare_ivec4((blockB.e[1]), ivec4(9, 3, -9, 3)) && allOk;
	allOk = compare_ivec4((blockB.e[2]), ivec4(5, 2, 3, 1)) && allOk;
	allOk = compare_ivec4((blockB.e[3]), ivec4(-6, -5, 9, 1)) && allOk;
	allOk = compare_ivec4((blockB.e[4]), ivec4(5, -7, 6, -1)) && allOk;
	allOk = compare_ivec4((blockB.e[5]), ivec4(-9, -5, 8, 5)) && allOk;
	allOk = compare_mat3(blockC.f, mat3(-4.0, -1.0, -8.0, 4.0, -7.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_uvec2((blockC.g), uvec2(2u, 7u)) && allOk;
	allOk = compare_bvec4((blockD.j[0]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((blockD.j[1]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockD.j[2]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockD.j[3]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockD.j[4]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockD.j[5]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockD.j[6]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_mat4x2(blockD.k[0][0], mat4x2(-9.0, 5.0, -8.0, -4.0, -2.0, 3.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[0][1], mat4x2(-7.0, 5.0, -7.0, 5.0, 5.0, 6.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[1][0], mat4x2(0.0, 5.0, -1.0, 1.0, 2.0, 7.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[1][1], mat4x2(3.0, 4.0, 8.0, 4.0, -8.0, 6.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[2][0], mat4x2(2.0, -5.0, 6.0, -5.0, -3.0, -3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[2][1], mat4x2(7.0, 4.0, 8.0, -2.0, -2.0, 9.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[3][0], mat4x2(-3.0, -9.0, -1.0, -3.0, 5.0, -3.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[3][1], mat4x2(-7.0, 3.0, 4.0, -1.0, -8.0, 6.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[4][0], mat4x2(-9.0, -8.0, -6.0, 9.0, 7.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[4][1], mat4x2(7.0, 0.0, -6.0, -4.0, -6.0, -5.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[5][0], mat4x2(0.0, 7.0, -4.0, 1.0, -5.0, 7.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[5][1], mat4x2(5.0, 6.0, -9.0, 1.0, 5.0, -2.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(blockE.m, mat3(7.0, -7.0, -9.0, -4.0, -9.0, 2.0, 5.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (false);
	blockB.c = (mat4(6.0, -6.0, -5.0, 2.0, 3.0, 0.0, 4.0, -4.0, -4.0, 1.0, -6.0, 2.0, -1.0, 4.0, -4.0, -7.0));
	blockB.e[0] = (ivec4(-9, -1, -1, 4));
	blockB.e[1] = (ivec4(-2, -5, 5, 3));
	blockB.e[2] = (ivec4(0, 9, -5, -3));
	blockB.e[3] = (ivec4(3, -7, 0, -2));
	blockB.e[4] = (ivec4(-2, 7, -9, -8));
	blockB.e[5] = (ivec4(3, 5, 5, -1));
	blockC.f = (mat3(7.0, -1.0, -8.0, 0.0, -8.0, 4.0, -3.0, -4.0, 9.0));
	blockC.h[0] = (mat2(8.0, 1.0, 2.0, -6.0));
	blockC.h[1] = (mat2(8.0, -9.0, 7.0, -1.0));
	blockC.h[2] = (mat2(3.0, -8.0, 3.0, 9.0));
	blockC.h[3] = (mat2(6.0, -4.0, 0.0, -9.0));
	blockC.h[4] = (mat2(3.0, 5.0, 0.0, -7.0));
	blockC.h[5] = (mat2(1.0, 0.0, 0.0, -4.0));
	blockC.h[6] = (mat2(5.0, -3.0, 2.0, 1.0));
	blockC.h[7] = (mat2(8.0, -6.0, 2.0, -5.0));
	blockD.i.mA.mA = (ivec4(6, 2, 0, -4));
	blockD.i.mA.mB = (mat2x3(7.0, 3.0, 4.0, -3.0, -9.0, 8.0));
	blockD.i.mB = (mat4x3(3.0, -6.0, -9.0, -6.0, -9.0, -8.0, -5.0, -2.0, 6.0, 9.0, -4.0, 3.0));
	blockD.i.mC = (-1);
	blockD.j[0] = (bvec4(true, true, false, false));
	blockD.j[1] = (bvec4(true, false, false, true));
	blockD.j[2] = (bvec4(false, false, true, true));
	blockD.j[3] = (bvec4(false, false, false, false));
	blockD.j[4] = (bvec4(false, false, true, true));
	blockD.j[5] = (bvec4(false, false, true, false));
	blockD.j[6] = (bvec4(true, true, true, false));
	blockD.k[0][0] = (mat4x2(2.0, 0.0, 6.0, -6.0, 8.0, -9.0, 1.0, 2.0));
	blockD.k[0][1] = (mat4x2(-2.0, 0.0, 4.0, -6.0, 1.0, -4.0, -3.0, 4.0));
	blockD.k[1][0] = (mat4x2(2.0, 7.0, -1.0, 5.0, -4.0, -3.0, 2.0, 8.0));
	blockD.k[1][1] = (mat4x2(-3.0, 7.0, 7.0, -7.0, 6.0, 4.0, -9.0, -8.0));
	blockD.k[2][0] = (mat4x2(1.0, -7.0, 5.0, 9.0, 1.0, -7.0, 5.0, -8.0));
	blockD.k[2][1] = (mat4x2(8.0, -9.0, -6.0, -2.0, -5.0, 2.0, -8.0, 3.0));
	blockD.k[3][0] = (mat4x2(-4.0, -4.0, -1.0, 9.0, 2.0, -3.0, 4.0, -8.0));
	blockD.k[3][1] = (mat4x2(2.0, -2.0, 1.0, -2.0, -2.0, -4.0, 6.0, -3.0));
	blockD.k[4][0] = (mat4x2(6.0, 0.0, 7.0, 2.0, 9.0, -3.0, -6.0, 7.0));
	blockD.k[4][1] = (mat4x2(3.0, 0.0, -6.0, -9.0, -4.0, 7.0, 2.0, 4.0));
	blockD.k[5][0] = (mat4x2(-8.0, -6.0, -7.0, 4.0, 8.0, -1.0, -5.0, 5.0));
	blockD.k[5][1] = (mat4x2(5.0, 6.0, 4.0, -3.0, 7.0, -8.0, -7.0, 4.0));
	blockE.m = (mat3(6.0, 9.0, 5.0, 4.0, 3.0, 5.0, -5.0, 2.0, 5.0));
	blockE.n[0] = (-2);
	blockE.n[1] = (-9);
}
#version 450
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
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	lowp uvec3 a;
	sA b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(9u, 7u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b[0].mA), uvec3(1u, 4u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b[1].mA), uvec3(6u, 0u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b[2].mA), uvec3(1u, 3u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b[3].mA), uvec3(2u, 6u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b[4].mA), uvec3(2u, 4u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b[5].mA), uvec3(1u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b[6].mA), uvec3(4u, 0u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(9u, 4u, 4u));
	blockB.b[0].mA = u8vec3(uvec3(5u, 8u, 5u));
	blockB.b[1].mA = u8vec3(uvec3(3u, 8u, 3u));
	blockB.b[2].mA = u8vec3(uvec3(7u, 7u, 5u));
	blockB.b[3].mA = u8vec3(uvec3(8u, 3u, 0u));
	blockB.b[4].mA = u8vec3(uvec3(7u, 1u, 3u));
	blockB.b[5].mA = u8vec3(uvec3(9u, 6u, 4u));
	blockB.b[6].mA = u8vec3(uvec3(7u, 4u, 6u));
}
#version 450
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
	layout(offset = 0) i8vec4 a;
	layout(offset = 16) bvec4 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bool c;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump int d;
};
layout(buffer_reference) readonly buffer BlockE
{
	layout(offset = 0) i8vec2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB[0].a), ivec4(2, 4294967288, 4294967292, 7)) && allOk;
	allOk = compare_bvec4((blockB[0].b), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bool((blockC.c), false) && allOk;
	allOk = compare_i8vec2(ivec2(blockE.e), ivec2(4294967290, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i8vec4(ivec4(8, 4294967294, 4294967295, 4294967290));
	blockB[0].b = (bvec4(false, false, false, false));
	blockC.c = (false);
	blockD.d = (8);
}
#version 450
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
	layout(offset = 0) lowp vec3 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp ivec2 b;
	layout(offset = 16) lowp uvec3 c;
	layout(offset = 32) mediump uvec2 d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec2 e;
	layout(offset = 16) bvec4 f;
	layout(offset = 32) u8vec3 g;
	layout(offset = 36) mediump uvec3 h;
	layout(offset = 48) highp ivec2 i[1];
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) i8vec3 j;
	layout(offset = 3) u8vec2 k;
	layout(offset = 16) mediump vec4 l;
	layout(offset = 32) bool m;
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(-9.0, 1.0, 0.0)) && allOk;
	allOk = compare_uvec2((blockC.d), uvec2(2u, 5u)) && allOk;
	allOk = compare_bvec2((blockD.e), bvec2(false, false)) && allOk;
	allOk = compare_bvec4((blockD.f), bvec4(false, true, false, false)) && allOk;
	allOk = compare_ivec2((blockD.i[0]), ivec2(7, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.j), ivec3(4, 4294967290, 4294967288)) && allOk;
	allOk = compare_vec4((blockE.l), vec4(-1.0, 0.0, 3.0, 4.0)) && allOk;
	allOk = compare_bool((blockE.m), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (ivec2(2, 0));
	blockC.c = (uvec3(7u, 0u, 9u));
	blockD.f = (bvec4(false, false, true, false));
	blockD.g = u8vec3(uvec3(9u, 6u, 8u));
	blockD.h = (uvec3(9u, 0u, 5u));
	blockD.i[0] = (ivec2(-9, 3));
	blockE.j = i8vec3(ivec3(0, 4294967287, 3));
	blockE.k = u8vec2(uvec2(4u, 1u));
	blockE.l = (vec4(5.0, -6.0, 3.0, -9.0));
	blockE.m = (false);
}
#version 450
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
	highp vec2 a;
	bvec3 b;
	highp uvec4 c[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	bvec3 d;
	u8vec4 e;
	lowp float f[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	highp uvec4 g;
	i8vec4 h[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	lowp vec4 i;
	u8vec2 j;
	mediump ivec3 k[];
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-4.0, -3.0)) && allOk;
	allOk = compare_uvec4((blockB.c[0]), uvec4(0u, 9u, 0u, 8u)) && allOk;
	allOk = compare_uvec4((blockB.c[1]), uvec4(1u, 9u, 0u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.c[2]), uvec4(4u, 5u, 3u, 3u)) && allOk;
	allOk = compare_uvec4((blockB.c[3]), uvec4(5u, 4u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((blockB.c[4]), uvec4(8u, 7u, 6u, 5u)) && allOk;
	allOk = compare_bvec3((blockC.d), bvec3(false, false, false)) && allOk;
	allOk = compare_ivec3((blockE.k[0]), ivec3(-5, 9, -8)) && allOk;
	allOk = compare_ivec3((blockE.k[1]), ivec3(6, 4, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(2.0, 9.0));
	blockB.b = (bvec3(true, false, true));
	blockB.c[0] = (uvec4(8u, 5u, 2u, 1u));
	blockB.c[1] = (uvec4(6u, 6u, 1u, 9u));
	blockB.c[2] = (uvec4(6u, 4u, 4u, 2u));
	blockB.c[3] = (uvec4(5u, 1u, 3u, 1u));
	blockB.c[4] = (uvec4(4u, 2u, 6u, 9u));
	blockC.d = (bvec3(true, true, false));
	blockD.g = (uvec4(8u, 2u, 5u, 0u));
	blockD.h[0] = i8vec4(ivec4(4294967290, 4294967293, 0, 4294967293));
	blockD.h[1] = i8vec4(ivec4(5, 3, 4294967288, 4294967294));
	blockD.h[2] = i8vec4(ivec4(4294967294, 4294967290, 2, 0));
	blockE.j = u8vec2(uvec2(8u, 2u));
	blockE.k[0] = (ivec3(1, 8, -2));
	blockE.k[1] = (ivec3(7, 1, 3));
}
