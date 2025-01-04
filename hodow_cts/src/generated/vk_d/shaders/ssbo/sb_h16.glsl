#version 450
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
	mediump uint var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (0u);
}
#version 450
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
	allOk = compare_mat2x4(var, mat2x4(3.0, 7.0, 8.0, -7.0, -8.0, -2.0, -1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(6.0, -9.0, 1.0, -3.0));
	var[1] = (vec4(4.0, -7.0, 5.0, 6.0));
}
#version 450
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
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(-1.0, -9.0, -8.0, 7.0, 8.0, 8.0, -3.0, 3.0, -4.0, -1.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(4.0, -5.0, 2.0, 8.0, -5.0, -9.0, -5.0, 9.0, 3.0, -6.0, 0.0, 3.0));
}
#version 450
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
	lowp vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((var), vec3(3.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (vec3(-8.0, -5.0, 8.0));
}
#version 450
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
	mediump uint var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (0u);
}
#version 450
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
	allOk = compare_float(var[0][0], 8.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(-1.0, -4.0, -6.0, -5.0));
}
#version 450
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

	var[0] = (vec4(6.0, 3.0, 9.0, -5.0));
	var[1] = (vec4(2.0, 2.0, -6.0, 6.0));
	var[2] = (vec4(8.0, 8.0, 2.0, 0.0));
}
#version 450
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
	u16vec4 var;
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(var), uvec4(6u, 0u, 8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = u16vec4(uvec4(0u, 6u, 9u, 4u));
}
#version 450
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
	lowp int var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (-7);
}
#version 450
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
	highp float var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var[0]), 7.0) && allOk;
	allOk = compare_float((var[1]), -1.0) && allOk;
	allOk = compare_float((var[2]), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (-2.0);
	var[1] = (4.0);
	var[2] = (6.0);
}
#version 450
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
	allOk = compare_mat4(var[0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-9.0, 0.0, -1.0, -4.0));
	var[0][1] = (vec4(-9.0, -4.0, -9.0, -5.0));
	var[0][2] = (vec4(-2.0, 9.0, 0.0, -8.0));
	var[0][3] = (vec4(-6.0, -3.0, -8.0, 3.0));
	var[1][0] = (vec4(4.0, 9.0, 4.0, -3.0));
	var[1][1] = (vec4(7.0, -9.0, 6.0, 5.0));
	var[1][2] = (vec4(6.0, -1.0, -3.0, -3.0));
	var[1][3] = (vec4(-9.0, 3.0, -9.0, 0.0));
	var[2][0] = (vec4(1.0, -4.0, -6.0, 5.0));
	var[2][1] = (vec4(2.0, 1.0, 9.0, -4.0));
	var[2][2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	var[2][3] = (vec4(9.0, 9.0, -5.0, -7.0));
}
#version 450
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
	allOk = compare_mat3x4(var[0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
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
}
#version 450
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat3x2(var[0], mat3x2(0.0, 6.0, 4.0, 7.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(1.0, 7.0, -4.0, 9.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-2.0, -4.0, 6.0, 2.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (9.0);
	var[0][0] = (vec2(-7.0, 8.0));
	var[0][1] = (vec2(-2.0, -9.0));
	var[0][2] = (vec2(-4.0, -1.0));
	var[1][0] = (vec2(-3.0, -3.0));
	var[1][1] = (vec2(-8.0, 2.0));
	var[1][2] = (vec2(7.0, -2.0));
	var[2][0] = (vec2(-3.0, -3.0));
	var[2][1] = (vec2(-4.0, 5.0));
	var[2][2] = (vec2(-1.0, 9.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(1.0, 8.0, 9.0, 7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(-9.0, -9.0, -7.0, -5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(-8.0, -7.0, 9.0, 6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(-5.0, -8.0, -6.0, 4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(-5.0, -1.0, 5.0, 4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(0.0, -6.0, -8.0, -7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(-2.0, 8.0, 2.0, 7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(7.0, 4.0, -4.0));
	var[0][1] = (vec3(-6.0, 3.0, -3.0));
	var[0][2] = (vec3(9.0, -2.0, 3.0));
	var[0][3] = (vec3(9.0, -9.0, 7.0));
	var[1][0] = (vec3(5.0, 1.0, -9.0));
	var[1][1] = (vec3(-1.0, -2.0, 6.0));
	var[1][2] = (vec3(-4.0, 6.0, 4.0));
	var[1][3] = (vec3(-8.0, 7.0, 3.0));
	var[2][0] = (vec3(-4.0, -9.0, 8.0));
	var[2][1] = (vec3(9.0, 2.0, 2.0));
	var[2][2] = (vec3(9.0, -7.0, 3.0));
	var[2][3] = (vec3(8.0, 2.0, 4.0));
	var[3][0] = (vec3(2.0, 4.0, -3.0));
	var[3][1] = (vec3(-8.0, 7.0, 3.0));
	var[3][2] = (vec3(0.0, -8.0, 0.0));
	var[3][3] = (vec3(6.0, -9.0, 0.0));
	var[4][0] = (vec3(-4.0, 5.0, 5.0));
	var[4][1] = (vec3(-7.0, -8.0, -1.0));
	var[4][2] = (vec3(6.0, -3.0, -5.0));
	var[4][3] = (vec3(0.0, 8.0, -8.0));
	var[5][0] = (vec3(-4.0, 4.0, 8.0));
	var[5][1] = (vec3(-4.0, -4.0, -3.0));
	var[5][2] = (vec3(3.0, 3.0, 2.0));
	var[5][3] = (vec3(8.0, -8.0, -6.0));
	var[6][0] = (vec3(9.0, 1.0, -1.0));
	var[6][1] = (vec3(-1.0, 2.0, 4.0));
	var[6][2] = (vec3(4.0, 2.0, 0.0));
	var[6][3] = (vec3(5.0, 6.0, -6.0));
	var[7][0] = (vec3(-3.0, 7.0, -6.0));
	var[7][1] = (vec3(7.0, 9.0, 8.0));
	var[7][2] = (vec3(-9.0, -9.0, -9.0));
	var[7][3] = (vec3(6.0, -7.0, -3.0));
	var[8][0] = (vec3(7.0, -1.0, -4.0));
	var[8][1] = (vec3(-9.0, 0.0, -1.0));
	var[8][2] = (vec3(-7.0, -2.0, -3.0));
	var[8][3] = (vec3(1.0, 4.0, 5.0));
	var[9][0] = (vec3(9.0, 8.0, 7.0));
	var[9][1] = (vec3(5.0, 4.0, 7.0));
	var[9][2] = (vec3(3.0, -3.0, 4.0));
	var[9][3] = (vec3(3.0, -6.0, 5.0));
	var[10][0] = (vec3(-8.0, -4.0, -9.0));
	var[10][1] = (vec3(4.0, 8.0, -3.0));
	var[10][2] = (vec3(-9.0, 7.0, -2.0));
	var[10][3] = (vec3(0.0, -3.0, -3.0));
	var[11][0] = (vec3(4.0, -2.0, -4.0));
	var[11][1] = (vec3(-5.0, -7.0, 1.0));
	var[11][2] = (vec3(-8.0, 1.0, 9.0));
	var[11][3] = (vec3(-8.0, 0.0, -2.0));
	var[12][0] = (vec3(-5.0, 2.0, -4.0));
	var[12][1] = (vec3(-7.0, -3.0, -4.0));
	var[12][2] = (vec3(4.0, -3.0, -8.0));
	var[12][3] = (vec3(-5.0, -1.0, 1.0));
	var[13][0] = (vec3(6.0, -2.0, 8.0));
	var[13][1] = (vec3(-7.0, 1.0, 4.0));
	var[13][2] = (vec3(6.0, 8.0, -5.0));
	var[13][3] = (vec3(1.0, -6.0, 4.0));
	var[14][0] = (vec3(-9.0, 3.0, -3.0));
	var[14][1] = (vec3(0.0, -5.0, -3.0));
	var[14][2] = (vec3(-5.0, -8.0, 3.0));
	var[14][3] = (vec3(3.0, -6.0, 8.0));
	var[15][0] = (vec3(-3.0, 5.0, 6.0));
	var[15][1] = (vec3(5.0, -1.0, 6.0));
	var[15][2] = (vec3(8.0, 7.0, 1.0));
	var[15][3] = (vec3(-5.0, 6.0, -6.0));
	var[16][0] = (vec3(-3.0, -7.0, 7.0));
	var[16][1] = (vec3(-9.0, -3.0, 6.0));
	var[16][2] = (vec3(0.0, -7.0, 3.0));
	var[16][3] = (vec3(2.0, -7.0, 1.0));
	var[17][0] = (vec3(8.0, -1.0, -9.0));
	var[17][1] = (vec3(8.0, 8.0, 2.0));
	var[17][2] = (vec3(7.0, -5.0, -2.0));
	var[17][3] = (vec3(-9.0, 6.0, 2.0));
	var[18][0] = (vec3(-1.0, 7.0, 7.0));
	var[18][1] = (vec3(3.0, -4.0, -1.0));
	var[18][2] = (vec3(-4.0, 5.0, 7.0));
	var[18][3] = (vec3(-5.0, 7.0, 5.0));
}
#version 450
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

	var[0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	var[1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	var[2] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	var[3] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	var[4] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	var[5] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	var[6] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	var[7] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	var[8] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	var[9] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	var[10] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	var[11] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
	var[12] = (mat4x3(-6.0, 9.0, 3.0, 4.0, 2.0, -2.0, -4.0, 3.0, 0.0, 4.0, -2.0, 0.0));
	var[13] = (mat4x3(6.0, -8.0, 4.0, 9.0, 3.0, 0.0, -8.0, -3.0, 5.0, 5.0, 7.0, 7.0));
	var[14] = (mat4x3(-1.0, -4.0, -7.0, -7.0, 7.0, 9.0, -7.0, 3.0, 7.0, -6.0, -6.0, 8.0));
	var[15] = (mat4x3(7.0, -7.0, -8.0, -3.0, 8.0, -1.0, -8.0, 2.0, -9.0, 9.0, 0.0, -7.0));
	var[16] = (mat4x3(-4.0, -2.0, 9.0, 2.0, -9.0, 7.0, 0.0, -4.0, 0.0, -3.0, 4.0, -6.0));
	var[17] = (mat4x3(9.0, -7.0, 9.0, 4.0, -8.0, 9.0, 0.0, -6.0, -6.0, 4.0, 4.0, 3.0));
	var[18] = (mat4x3(-9.0, -6.0, -4.0, -8.0, 0.0, 1.0, -9.0, -8.0, 1.0, 6.0, 3.0, -7.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat3x4 var[];
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
	allOk = compare_mat3x4(var[3], mat3x4(-3.0, 1.0, 4.0, 2.0, -2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(6.0, -6.0, -8.0, 8.0, 4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(2.0, 8.0, -9.0, 0.0, 3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(-9.0, -9.0, 1.0, 6.0, -2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-6.0, 1.0, -4.0, 2.0, 9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(-6.0, 5.0, 3.0, -1.0, 6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(-8.0, 6.0, 7.0, -3.0, -3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(-9.0, 1.0, 2.0, 0.0, -3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(4.0, 8.0, -1.0, 7.0, 0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(-7.0, -8.0, -1.0, 5.0, 6.0, -6.0, -4.0, 9.0, -5.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(-9.0, 3.0, 1.0, 8.0, 7.0, 0.0, 7.0, 9.0, -1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(3.0, 8.0, 0.0, -6.0, -6.0, -1.0, -2.0, 5.0, 1.0, -3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(0.0, 8.0, -9.0, 6.0, -5.0, 3.0, -8.0, -1.0, -9.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(-8.0, 8.0, -1.0, 9.0, 1.0, -5.0, -4.0, 3.0, 5.0, 7.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(-2.0, 6.0, 5.0, 9.0, 2.0, -3.0, 3.0, 8.0, 8.0, 6.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(-5.0, -7.0, 0.0, -4.0, 1.0, 2.0, -2.0, -3.0, -4.0, 2.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	var[1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	var[2] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
	var[3] = (mat3x4(-9.0, 1.0, -3.0, -5.0, -5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0));
	var[4] = (mat3x4(-4.0, 4.0, 3.0, 8.0, -8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0));
	var[5] = (mat3x4(-9.0, -3.0, 7.0, -7.0, -6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0));
	var[6] = (mat3x4(3.0, 1.0, -4.0, -8.0, -9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0));
	var[7] = (mat3x4(1.0, -1.0, -1.0, -7.0, -9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0));
	var[8] = (mat3x4(9.0, 2.0, -4.0, -9.0, -7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0));
	var[9] = (mat3x4(4.0, -5.0, 0.0, -5.0, -7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0));
	var[10] = (mat3x4(-9.0, 0.0, 8.0, 4.0, -9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0));
	var[11] = (mat3x4(6.0, -3.0, -7.0, -8.0, 6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0));
	var[12] = (mat3x4(-5.0, -6.0, -9.0, -2.0, 3.0, 0.0, 8.0, 5.0, 9.0, 8.0, 5.0, -4.0));
	var[13] = (mat3x4(5.0, 8.0, 3.0, -2.0, -6.0, -3.0, 3.0, 3.0, 0.0, 9.0, -9.0, 4.0));
	var[14] = (mat3x4(-8.0, -7.0, 4.0, -2.0, -9.0, -4.0, -3.0, -8.0, 7.0, 8.0, -1.0, -7.0));
	var[15] = (mat3x4(0.0, -4.0, 5.0, 2.0, 2.0, -3.0, 7.0, -3.0, 7.0, 0.0, -2.0, 0.0));
	var[16] = (mat3x4(-3.0, 7.0, -2.0, 4.0, -6.0, -3.0, 4.0, -8.0, 7.0, -3.0, -5.0, -5.0));
	var[17] = (mat3x4(-6.0, -2.0, 3.0, 6.0, 7.0, 1.0, -6.0, 7.0, -9.0, 5.0, 5.0, 3.0));
	var[18] = (mat3x4(2.0, -3.0, -5.0, 8.0, -5.0, 3.0, 2.0, 1.0, 4.0, -5.0, -7.0, -9.0));
}
#version 450
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

	var[0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	var[0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	var[0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	var[1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	var[1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	var[1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	var[2][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	var[2][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	var[2][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
	var[3][0] = (vec4(8.0, -2.0, 1.0, 1.0));
	var[3][1] = (vec4(-6.0, -1.0, -9.0, 6.0));
	var[3][2] = (vec4(7.0, -1.0, 1.0, -8.0));
	var[4][0] = (vec4(6.0, 8.0, -2.0, 7.0));
	var[4][1] = (vec4(1.0, -6.0, -3.0, 9.0));
	var[4][2] = (vec4(1.0, -6.0, 1.0, -6.0));
	var[5][0] = (vec4(3.0, -1.0, 5.0, -2.0));
	var[5][1] = (vec4(7.0, -1.0, -2.0, -3.0));
	var[5][2] = (vec4(-6.0, 4.0, -4.0, -1.0));
	var[6][0] = (vec4(-3.0, -3.0, 3.0, -7.0));
	var[6][1] = (vec4(2.0, 8.0, -4.0, 1.0));
	var[6][2] = (vec4(-1.0, 6.0, -4.0, 7.0));
	var[7][0] = (vec4(5.0, -8.0, -2.0, 6.0));
	var[7][1] = (vec4(-2.0, 8.0, -2.0, 2.0));
	var[7][2] = (vec4(3.0, 7.0, 0.0, 2.0));
	var[8][0] = (vec4(3.0, 9.0, 8.0, 5.0));
	var[8][1] = (vec4(2.0, -3.0, -7.0, 2.0));
	var[8][2] = (vec4(-1.0, 1.0, -4.0, -1.0));
	var[9][0] = (vec4(-6.0, -4.0, -1.0, -3.0));
	var[9][1] = (vec4(-8.0, 5.0, -4.0, -9.0));
	var[9][2] = (vec4(8.0, 3.0, -8.0, 0.0));
	var[10][0] = (vec4(7.0, -2.0, 0.0, 8.0));
	var[10][1] = (vec4(-9.0, 2.0, -3.0, -7.0));
	var[10][2] = (vec4(-5.0, 3.0, 9.0, -6.0));
	var[11][0] = (vec4(-7.0, -8.0, -8.0, -7.0));
	var[11][1] = (vec4(-9.0, 2.0, 4.0, -7.0));
	var[11][2] = (vec4(8.0, -7.0, 4.0, -8.0));
	var[12][0] = (vec4(0.0, 7.0, 3.0, -7.0));
	var[12][1] = (vec4(-7.0, 7.0, -4.0, -5.0));
	var[12][2] = (vec4(-8.0, -8.0, -7.0, 4.0));
	var[13][0] = (vec4(6.0, -3.0, 8.0, -1.0));
	var[13][1] = (vec4(-4.0, 8.0, 8.0, 1.0));
	var[13][2] = (vec4(-8.0, -7.0, 5.0, -9.0));
	var[14][0] = (vec4(1.0, -8.0, 2.0, -2.0));
	var[14][1] = (vec4(-8.0, -9.0, 1.0, -3.0));
	var[14][2] = (vec4(-4.0, 3.0, -9.0, 6.0));
	var[15][0] = (vec4(-8.0, 3.0, -5.0, 6.0));
	var[15][1] = (vec4(9.0, 2.0, -1.0, 8.0));
	var[15][2] = (vec4(-2.0, 5.0, -2.0, 6.0));
	var[16][0] = (vec4(1.0, 2.0, 8.0, -3.0));
	var[16][1] = (vec4(6.0, -3.0, -8.0, 2.0));
	var[16][2] = (vec4(-6.0, -8.0, 3.0, 3.0));
	var[17][0] = (vec4(0.0, 9.0, 4.0, -8.0));
	var[17][1] = (vec4(-7.0, 6.0, -4.0, -8.0));
	var[17][2] = (vec4(2.0, 9.0, 1.0, 0.0));
	var[18][0] = (vec4(3.0, 0.0, -5.0, -4.0));
	var[18][1] = (vec4(-9.0, -4.0, 0.0, -5.0));
	var[18][2] = (vec4(-9.0, -9.0, 6.0, -4.0));
}
#version 450
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

	var[0][0] = (vec2(-4.0, -6.0));
	var[0][1] = (vec2(1.0, -3.0));
	var[0][2] = (vec2(-1.0, -9.0));
	var[1][0] = (vec2(3.0, -2.0));
	var[1][1] = (vec2(5.0, -8.0));
	var[1][2] = (vec2(2.0, -9.0));
	var[2][0] = (vec2(1.0, -5.0));
	var[2][1] = (vec2(0.0, -2.0));
	var[2][2] = (vec2(2.0, -1.0));
	var[3][0] = (vec2(-7.0, 9.0));
	var[3][1] = (vec2(-8.0, 7.0));
	var[3][2] = (vec2(1.0, -9.0));
	var[4][0] = (vec2(-5.0, -5.0));
	var[4][1] = (vec2(9.0, 3.0));
	var[4][2] = (vec2(-3.0, -6.0));
	var[5][0] = (vec2(1.0, 3.0));
	var[5][1] = (vec2(-3.0, -4.0));
	var[5][2] = (vec2(-9.0, 4.0));
	var[6][0] = (vec2(-2.0, -3.0));
	var[6][1] = (vec2(-5.0, 1.0));
	var[6][2] = (vec2(-5.0, 8.0));
	var[7][0] = (vec2(7.0, 8.0));
	var[7][1] = (vec2(-1.0, -3.0));
	var[7][2] = (vec2(-8.0, 5.0));
	var[8][0] = (vec2(6.0, 6.0));
	var[8][1] = (vec2(0.0, -8.0));
	var[8][2] = (vec2(-6.0, -4.0));
	var[9][0] = (vec2(-6.0, -5.0));
	var[9][1] = (vec2(8.0, 5.0));
	var[9][2] = (vec2(-9.0, 0.0));
	var[10][0] = (vec2(6.0, -3.0));
	var[10][1] = (vec2(6.0, 0.0));
	var[10][2] = (vec2(1.0, 6.0));
	var[11][0] = (vec2(4.0, 4.0));
	var[11][1] = (vec2(0.0, -1.0));
	var[11][2] = (vec2(-2.0, 2.0));
	var[12][0] = (vec2(-1.0, -9.0));
	var[12][1] = (vec2(-8.0, 9.0));
	var[12][2] = (vec2(-1.0, -6.0));
	var[13][0] = (vec2(-5.0, 7.0));
	var[13][1] = (vec2(-8.0, -6.0));
	var[13][2] = (vec2(1.0, -5.0));
	var[14][0] = (vec2(-3.0, 8.0));
	var[14][1] = (vec2(-2.0, 3.0));
	var[14][2] = (vec2(-2.0, 5.0));
	var[15][0] = (vec2(7.0, -3.0));
	var[15][1] = (vec2(4.0, 5.0));
	var[15][2] = (vec2(-9.0, 3.0));
	var[16][0] = (vec2(6.0, -1.0));
	var[16][1] = (vec2(-6.0, -5.0));
	var[16][2] = (vec2(7.0, -6.0));
	var[17][0] = (vec2(1.0, 8.0));
	var[17][1] = (vec2(7.0, -1.0));
	var[17][2] = (vec2(2.0, 6.0));
	var[18][0] = (vec2(-6.0, 5.0));
	var[18][1] = (vec2(6.0, -8.0));
	var[18][2] = (vec2(-2.0, -1.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0][0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(0.0, 9.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(-8.0, 3.0, 8.0, -7.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(8.0, 4.0, -2.0, -2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(7.0, -5.0, -3.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(-9.0, -6.0, 5.0, -2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(8.0, 1.0, 8.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(-1.0, -2.0, -9.0, -1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(-5.0, -6.0, -3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(-3.0, -8.0, -9.0, -8.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(4.0, 5.0, -6.0));
	var[0][0][1] = (vec3(0.0, -8.0, -2.0));
	var[0][1][0] = (vec3(8.0, 8.0, 0.0));
	var[0][1][1] = (vec3(3.0, -6.0, -6.0));
	var[0][2][0] = (vec3(-1.0, 2.0, -9.0));
	var[0][2][1] = (vec3(1.0, 3.0, 2.0));
	var[1][0][0] = (vec3(1.0, 5.0, -6.0));
	var[1][0][1] = (vec3(-8.0, -6.0, -5.0));
	var[1][1][0] = (vec3(-9.0, 6.0, -9.0));
	var[1][1][1] = (vec3(0.0, -1.0, -3.0));
	var[1][2][0] = (vec3(-6.0, 9.0, 7.0));
	var[1][2][1] = (vec3(-5.0, -7.0, -2.0));
	var[2][0][0] = (vec3(-1.0, -3.0, 0.0));
	var[2][0][1] = (vec3(3.0, 3.0, 5.0));
	var[2][1][0] = (vec3(-1.0, -1.0, 3.0));
	var[2][1][1] = (vec3(-1.0, -7.0, 7.0));
	var[2][2][0] = (vec3(-6.0, -6.0, -8.0));
	var[2][2][1] = (vec3(2.0, -4.0, -3.0));
	var[3][0][0] = (vec3(-3.0, 4.0, 8.0));
	var[3][0][1] = (vec3(7.0, -2.0, -7.0));
	var[3][1][0] = (vec3(-5.0, 5.0, -5.0));
	var[3][1][1] = (vec3(1.0, -1.0, 7.0));
	var[3][2][0] = (vec3(-5.0, 8.0, -7.0));
	var[3][2][1] = (vec3(-2.0, 4.0, 3.0));
}
#version 450
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
	i8vec4 var[4][3];
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(var[0][0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][2]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][0]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][1]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][2]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][0]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][1]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][2]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][0]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][1]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][2]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	var[0][1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	var[0][2] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	var[1][0] = i8vec4(ivec4(6, 4, 9, 4294967287));
	var[1][1] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	var[1][2] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	var[2][0] = i8vec4(ivec4(8, 5, 4, 5));
	var[2][1] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	var[2][2] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	var[3][0] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	var[3][1] = i8vec4(ivec4(2, 5, 4, 6));
	var[3][2] = i8vec4(ivec4(4294967292, 7, 8, 9));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	var[0][1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	var[0][2] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
	var[1][0] = (mat3x4(-5.0, -5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0));
	var[1][1] = (mat3x4(-5.0, 5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0));
	var[1][2] = (mat3x4(-9.0, -1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0));
	var[2][0] = (mat3x4(-4.0, 2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0));
	var[2][1] = (mat3x4(9.0, -2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0));
	var[2][2] = (mat3x4(-6.0, 5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0));
	var[3][0] = (mat3x4(9.0, 2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0));
	var[3][1] = (mat3x4(-1.0, 4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0));
	var[3][2] = (mat3x4(-9.0, 1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0));
}
#version 450
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
	highp mat4x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(2.0, -4.0));
	var[0][0][1] = (vec2(-5.0, 3.0));
	var[0][0][2] = (vec2(7.0, 1.0));
	var[0][0][3] = (vec2(8.0, -5.0));
	var[0][1][0] = (vec2(7.0, -3.0));
	var[0][1][1] = (vec2(1.0, -6.0));
	var[0][1][2] = (vec2(9.0, -3.0));
	var[0][1][3] = (vec2(1.0, -5.0));
	var[0][2][0] = (vec2(-8.0, 4.0));
	var[0][2][1] = (vec2(5.0, -9.0));
	var[0][2][2] = (vec2(1.0, -5.0));
	var[0][2][3] = (vec2(-4.0, -2.0));
	var[1][0][0] = (vec2(6.0, -1.0));
	var[1][0][1] = (vec2(-7.0, -5.0));
	var[1][0][2] = (vec2(-2.0, -8.0));
	var[1][0][3] = (vec2(1.0, 3.0));
	var[1][1][0] = (vec2(4.0, 2.0));
	var[1][1][1] = (vec2(-9.0, 2.0));
	var[1][1][2] = (vec2(-3.0, 3.0));
	var[1][1][3] = (vec2(0.0, 1.0));
	var[1][2][0] = (vec2(-5.0, -9.0));
	var[1][2][1] = (vec2(2.0, -2.0));
	var[1][2][2] = (vec2(-3.0, 0.0));
	var[1][2][3] = (vec2(9.0, 6.0));
	var[2][0][0] = (vec2(3.0, -4.0));
	var[2][0][1] = (vec2(2.0, -3.0));
	var[2][0][2] = (vec2(6.0, 5.0));
	var[2][0][3] = (vec2(0.0, -2.0));
	var[2][1][0] = (vec2(-3.0, -2.0));
	var[2][1][1] = (vec2(-7.0, 3.0));
	var[2][1][2] = (vec2(-6.0, 2.0));
	var[2][1][3] = (vec2(9.0, 6.0));
	var[2][2][0] = (vec2(-4.0, 4.0));
	var[2][2][1] = (vec2(0.0, -3.0));
	var[2][2][2] = (vec2(-7.0, 0.0));
	var[2][2][3] = (vec2(-9.0, 1.0));
	var[3][0][0] = (vec2(7.0, 2.0));
	var[3][0][1] = (vec2(1.0, 9.0));
	var[3][0][2] = (vec2(-3.0, 3.0));
	var[3][0][3] = (vec2(-7.0, 9.0));
	var[3][1][0] = (vec2(-4.0, -1.0));
	var[3][1][1] = (vec2(3.0, 6.0));
	var[3][1][2] = (vec2(8.0, 3.0));
	var[3][1][3] = (vec2(1.0, 5.0));
	var[3][2][0] = (vec2(7.0, 0.0));
	var[3][2][1] = (vec2(0.0, -2.0));
	var[3][2][2] = (vec2(3.0, -7.0));
	var[3][2][3] = (vec2(-3.0, 1.0));
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat3x2(var[0][0], mat3x2(5.0, 2.0, -5.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(-9.0, 0.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(-2.0, 6.0, -3.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(1.0, -5.0, -2.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(-4.0, -9.0, 2.0, 4.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(1.0, 2.0, 0.0, -6.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(-8.0, 5.0, 8.0, -7.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(-5.0, -4.0, 8.0, 0.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(9.0, -7.0, 8.0, -9.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(7.0, 6.0, -8.0, 4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(5.0, 6.0, -9.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(7.0, 1.0, 5.0, 1.0, -5.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0][0] = (vec2(1.0, 8.0));
	var[0][0][1] = (vec2(-7.0, 5.0));
	var[0][0][2] = (vec2(8.0, 2.0));
	var[0][1][0] = (vec2(-3.0, 1.0));
	var[0][1][1] = (vec2(2.0, -5.0));
	var[0][1][2] = (vec2(0.0, 6.0));
	var[0][2][0] = (vec2(6.0, 5.0));
	var[0][2][1] = (vec2(-5.0, 9.0));
	var[0][2][2] = (vec2(3.0, -8.0));
	var[1][0][0] = (vec2(3.0, -3.0));
	var[1][0][1] = (vec2(3.0, -5.0));
	var[1][0][2] = (vec2(9.0, 7.0));
	var[1][1][0] = (vec2(3.0, 1.0));
	var[1][1][1] = (vec2(-2.0, 1.0));
	var[1][1][2] = (vec2(-8.0, 4.0));
	var[1][2][0] = (vec2(3.0, 6.0));
	var[1][2][1] = (vec2(7.0, 1.0));
	var[1][2][2] = (vec2(-9.0, 9.0));
	var[2][0][0] = (vec2(0.0, -6.0));
	var[2][0][1] = (vec2(-7.0, 7.0));
	var[2][0][2] = (vec2(-9.0, -8.0));
	var[2][1][0] = (vec2(9.0, 6.0));
	var[2][1][1] = (vec2(-1.0, 0.0));
	var[2][1][2] = (vec2(7.0, -3.0));
	var[2][2][0] = (vec2(-1.0, -6.0));
	var[2][2][1] = (vec2(-1.0, -3.0));
	var[2][2][2] = (vec2(6.0, 0.0));
	var[3][0][0] = (vec2(4.0, -9.0));
	var[3][0][1] = (vec2(1.0, 1.0));
	var[3][0][2] = (vec2(-1.0, -9.0));
	var[3][1][0] = (vec2(0.0, 4.0));
	var[3][1][1] = (vec2(-3.0, -3.0));
	var[3][1][2] = (vec2(7.0, 6.0));
	var[3][2][0] = (vec2(-7.0, 5.0));
	var[3][2][1] = (vec2(-6.0, -5.0));
	var[3][2][2] = (vec2(8.0, 2.0));
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat3x2(var[0][0], mat3x2(-4.0, -4.0, -7.0, 2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(-9.0, -1.0, 0.0, -3.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(-5.0, 3.0, -3.0, 6.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(-9.0, 5.0, -4.0, -5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(-5.0, -8.0, -5.0, -1.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(2.0, -6.0, -9.0, 4.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(9.0, 8.0, -4.0, 4.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(5.0, -2.0, -2.0, 2.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(8.0, 6.0, -7.0, -3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(6.0, -9.0, 9.0, 2.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(2.0, 5.0, 8.0, 5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-4.0, 8.0, -3.0, 7.0, -1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-4.0);
	var[0][0] = (mat3x2(-6.0, 1.0, -8.0, 7.0, 6.0, -1.0));
	var[0][1] = (mat3x2(-6.0, 7.0, -4.0, -7.0, 0.0, -7.0));
	var[0][2] = (mat3x2(-2.0, -6.0, -6.0, -4.0, -5.0, -4.0));
	var[1][0] = (mat3x2(4.0, 7.0, 9.0, 7.0, -9.0, 9.0));
	var[1][1] = (mat3x2(-5.0, 6.0, -2.0, 6.0, -1.0, -6.0));
	var[1][2] = (mat3x2(1.0, 5.0, 7.0, 1.0, -8.0, 0.0));
	var[2][0] = (mat3x2(2.0, -7.0, 5.0, 1.0, 0.0, 6.0));
	var[2][1] = (mat3x2(-1.0, -4.0, -5.0, -3.0, 0.0, -8.0));
	var[2][2] = (mat3x2(-1.0, 9.0, -1.0, 7.0, 4.0, -8.0));
	var[3][0] = (mat3x2(6.0, 0.0, 4.0, 4.0, -3.0, -8.0));
	var[3][1] = (mat3x2(-9.0, -4.0, 5.0, 5.0, 8.0, 4.0));
	var[3][2] = (mat3x2(-3.0, 2.0, 8.0, 5.0, 7.0, 9.0));
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat3x4(var[0][0], mat3x4(-8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0, -2.0, -5.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0, 9.0, -2.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0, 8.0, -3.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(-2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0, 1.0, 4.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0, -6.0, -8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0, 8.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(-2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0, -9.0, 1.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0, 1.0, -4.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0, 5.0, 3.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(-3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0, 6.0, 7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(-3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0, 1.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0, 8.0, -1.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0][0] = (mat3x4(-6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0, 6.0, 4.0, -6.0, -9.0));
	var[0][1] = (mat3x4(-4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0, 9.0, -2.0, 3.0, -7.0));
	var[0][2] = (mat3x4(-1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0, 6.0, 0.0, 4.0, -9.0));
	var[1][0] = (mat3x4(-5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0, 1.0, -3.0, -5.0, -4.0));
	var[1][1] = (mat3x4(-8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0, 4.0, 3.0, 8.0, -9.0));
	var[1][2] = (mat3x4(-6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0, -3.0, 7.0, -7.0, 3.0));
	var[2][0] = (mat3x4(-9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0, 1.0, -4.0, -8.0, 1.0));
	var[2][1] = (mat3x4(-9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0, -1.0, -1.0, -7.0, 9.0));
	var[2][2] = (mat3x4(-7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0, 2.0, -4.0, -9.0, 4.0));
	var[3][0] = (mat3x4(-7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0, -5.0, 0.0, -5.0, -9.0));
	var[3][1] = (mat3x4(-9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0, 0.0, 8.0, 4.0, 6.0));
	var[3][2] = (mat3x4(6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0, -3.0, -7.0, -8.0, -5.0));
}
#version 450
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
	highp mat4x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat4x3(var[0][0], mat4x3(0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(-7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(-3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(-9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(-5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(-4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(-7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0][0] = (mat4x3(-7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0, 7.0));
	var[0][1] = (mat4x3(1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0, 5.0));
	var[0][2] = (mat4x3(-7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0, -2.0));
	var[1][0] = (mat4x3(3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0, 7.0));
	var[1][1] = (mat4x3(-4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0, -5.0));
	var[1][2] = (mat4x3(7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0, -6.0));
	var[2][0] = (mat4x3(0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0, 3.0));
	var[2][1] = (mat4x3(8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0, 3.0));
	var[2][2] = (mat4x3(-9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0, 6.0));
	var[3][0] = (mat4x3(-5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0, 8.0));
	var[3][1] = (mat4x3(-5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0, 1.0));
	var[3][2] = (mat4x3(0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0, -6.0));
}
#version 450
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
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-2.0, -1.0, 1.0, 0.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-1.0, -3.0, 9.0, 9.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(6.0, -9.0, 0.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-7.0, 6.0, -9.0, 5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(8.0, -3.0, -5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(-1.0, 3.0, 2.0, -6.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-9.0, 7.0, 0.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-7.0, -4.0, -4.0, 2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(-7.0, -7.0, -2.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(8.0, -3.0, 9.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(2.0, 4.0, 5.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(0.0, 1.0, 8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(1.0, -7.0, 3.0, -9.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-9.0, 8.0, -7.0, 5.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(8.0, -4.0, 2.0, 5.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(-4.0, 8.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(-5.0, -5.0, 2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-7.0, -1.0, -4.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(-2.0, -3.0, -5.0, 2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(-4.0, 8.0, -4.0, -9.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(-7.0, -8.0, -2.0, -7.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	var[0][0][1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	var[0][0][2] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
	var[0][1][0] = (mat3x2(9.0, 9.0, -7.0, 5.0, 9.0, -1.0));
	var[0][1][1] = (mat3x2(1.0, 7.0, 8.0, 8.0, -1.0, 5.0));
	var[0][1][2] = (mat3x2(-7.0, -7.0, 7.0, -7.0, -4.0, 0.0));
	var[1][0][0] = (mat3x2(-4.0, -9.0, 4.0, 7.0, 9.0, 7.0));
	var[1][0][1] = (mat3x2(9.0, -1.0, -5.0, 6.0, -2.0, 6.0));
	var[1][0][2] = (mat3x2(-6.0, -8.0, 1.0, 5.0, 7.0, 1.0));
	var[1][1][0] = (mat3x2(-4.0, -8.0, -1.0, 6.0, -9.0, 7.0));
	var[1][1][1] = (mat3x2(-9.0, 2.0, 5.0, -2.0, 2.0, -7.0));
	var[1][1][2] = (mat3x2(-7.0, 2.0, 5.0, 0.0, 1.0, -6.0));
	var[2][0][0] = (mat3x2(0.0, 0.0, 2.0, -7.0, 5.0, 1.0));
	var[2][0][1] = (mat3x2(6.0, 0.0, -1.0, -4.0, -5.0, -3.0));
	var[2][0][2] = (mat3x2(-8.0, 4.0, -1.0, 9.0, -1.0, 7.0));
	var[2][1][0] = (mat3x2(1.0, -2.0, -7.0, 8.0, -1.0, 1.0));
	var[2][1][1] = (mat3x2(2.0, -3.0, 1.0, -9.0, -8.0, 9.0));
	var[2][1][2] = (mat3x2(-7.0, 8.0, -6.0, -5.0, -8.0, 8.0));
	var[3][0][0] = (mat3x2(-8.0, -3.0, 6.0, 0.0, 4.0, 4.0));
	var[3][0][1] = (mat3x2(-8.0, 8.0, -9.0, -4.0, 5.0, 5.0));
	var[3][0][2] = (mat3x2(4.0, 7.0, -3.0, 2.0, 8.0, 5.0));
	var[3][1][0] = (mat3x2(-5.0, 1.0, 4.0, -7.0, -6.0, -8.0));
	var[3][1][1] = (mat3x2(5.0, -9.0, 2.0, 0.0, -8.0, -6.0));
	var[3][1][2] = (mat3x2(8.0, 7.0, 3.0, 8.0, -8.0, 5.0));
}
#version 450
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
	highp mat3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(9.0, 0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(8.0, -5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(-4.0, 8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(2.0, 1.0, -5.0, 9.0, 0.0, -3.0, 6.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(-1.0, -9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(-6.0, -7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(-5.0, -6.0, 5.0, 4.0, 2.0, -6.0, -6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(9.0, 1.0, -4.0, -3.0, 1.0, -2.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(-4.0, 8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(-2.0, 3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(4.0, -1.0, -3.0, 7.0, -3.0, -5.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(4.0, -4.0, -7.0, 8.0, 2.0, 6.0, -7.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	var[0][0][1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	var[0][1][0] = (mat3(5.0, 4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0));
	var[0][1][1] = (mat3(-3.0, 6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0));
	var[0][2][0] = (mat3(-2.0, 4.0, 1.0, 4.0, 5.0, -8.0, 0.0, 4.0, -7.0));
	var[0][2][1] = (mat3(-3.0, 2.0, 7.0, -9.0, -9.0, -4.0, 6.0, -9.0, 9.0));
	var[0][3][0] = (mat3(0.0, 7.0, -3.0, -5.0, -1.0, 1.0, -7.0, 1.0, -9.0));
	var[0][3][1] = (mat3(0.0, 7.0, 5.0, -6.0, 4.0, -6.0, 2.0, -3.0, 4.0));
	var[1][0][0] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
	var[1][0][1] = (mat3(-9.0, 3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0));
	var[1][1][0] = (mat3(-4.0, -4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0));
	var[1][1][1] = (mat3(-8.0, -8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0));
	var[1][2][0] = (mat3(-6.0, 9.0, 8.0, -8.0, -9.0, -8.0, 2.0, 4.0, 8.0));
	var[1][2][1] = (mat3(-5.0, 6.0, -5.0, 3.0, -2.0, -2.0, -3.0, -3.0, 8.0));
	var[1][3][0] = (mat3(7.0, 6.0, 0.0, -2.0, -9.0, 3.0, 8.0, 9.0, -8.0));
	var[1][3][1] = (mat3(8.0, -8.0, -8.0, -9.0, -1.0, 4.0, 9.0, 9.0, -4.0));
	var[2][0][0] = (mat3(4.0, 7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0));
	var[2][0][1] = (mat3(7.0, -6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0));
	var[2][1][0] = (mat3(-3.0, -8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0));
	var[2][1][1] = (mat3(3.0, -2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0));
	var[2][2][0] = (mat3(1.0, -1.0, -6.0, -7.0, -4.0, -9.0, 9.0, -4.0, -3.0));
	var[2][2][1] = (mat3(8.0, 7.0, -9.0, 3.0, -6.0, 1.0, -4.0, -4.0, 3.0));
	var[2][3][0] = (mat3(0.0, -4.0, -8.0, 9.0, 2.0, 6.0, -7.0, 5.0, -8.0));
	var[2][3][1] = (mat3(-9.0, -6.0, -3.0, 1.0, -9.0, -5.0, 5.0, 4.0, 5.0));
}
#version 450
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
	highp mat3x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-9.0, -9.0, 1.0, 6.0, -2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-6.0, 1.0, -4.0, 2.0, 9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(-7.0, -8.0, -1.0, 5.0, 6.0, -6.0, -4.0, 9.0, -5.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(-9.0, 3.0, 1.0, 8.0, 7.0, 0.0, 7.0, 9.0, -1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(-5.0, -7.0, 0.0, -4.0, 1.0, 2.0, -2.0, -3.0, -4.0, 2.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(6.0, -3.0, 9.0, 7.0, -4.0, -2.0, 6.0, 5.0, 2.0, -2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-3.0, 1.0, 4.0, 2.0, -2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-6.0, 5.0, 3.0, -1.0, 6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-8.0, 6.0, 7.0, -3.0, -3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(3.0, 8.0, 0.0, -6.0, -6.0, -1.0, -2.0, 5.0, 1.0, -3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(0.0, 8.0, -9.0, 6.0, -5.0, 3.0, -8.0, -1.0, -9.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(0.0, -8.0, -2.0, 7.0, 5.0, -6.0, 9.0, 6.0, 4.0, -4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(-2.0, 8.0, -4.0, 7.0, 4.0, 5.0, 1.0, -1.0, 3.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(6.0, -6.0, -8.0, 8.0, 4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(2.0, 8.0, -9.0, 0.0, 3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-9.0, 1.0, 2.0, 0.0, -3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(4.0, 8.0, -1.0, 7.0, 0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(-8.0, 8.0, -1.0, 9.0, 1.0, -5.0, -4.0, 3.0, 5.0, 7.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(-2.0, 6.0, 5.0, 9.0, 2.0, -3.0, 3.0, 8.0, 8.0, 6.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-6.0, 1.0, -9.0, 0.0, -5.0, 8.0, -9.0, 1.0, -2.0, -2.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(-7.0, -6.0, -7.0, 6.0, 0.0, -6.0, 7.0, 3.0, 0.0, -7.0, 7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	var[0][0][1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	var[0][1][0] = (mat3x4(3.0, 1.0, -4.0, -8.0, -9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0));
	var[0][1][1] = (mat3x4(1.0, -1.0, -1.0, -7.0, -9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0));
	var[0][2][0] = (mat3x4(-5.0, -6.0, -9.0, -2.0, 3.0, 0.0, 8.0, 5.0, 9.0, 8.0, 5.0, -4.0));
	var[0][2][1] = (mat3x4(5.0, 8.0, 3.0, -2.0, -6.0, -3.0, 3.0, 3.0, 0.0, 9.0, -9.0, 4.0));
	var[0][3][0] = (mat3x4(2.0, -3.0, -5.0, 8.0, -5.0, 3.0, 2.0, 1.0, 4.0, -5.0, -7.0, -9.0));
	var[0][3][1] = (mat3x4(5.0, 1.0, 4.0, 9.0, -7.0, -7.0, -7.0, 9.0, -4.0, 1.0, 3.0, 5.0));
	var[1][0][0] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
	var[1][0][1] = (mat3x4(-9.0, 1.0, -3.0, -5.0, -5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0));
	var[1][1][0] = (mat3x4(9.0, 2.0, -4.0, -9.0, -7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0));
	var[1][1][1] = (mat3x4(4.0, -5.0, 0.0, -5.0, -7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0));
	var[1][2][0] = (mat3x4(-8.0, -7.0, 4.0, -2.0, -9.0, -4.0, -3.0, -8.0, 7.0, 8.0, -1.0, -7.0));
	var[1][2][1] = (mat3x4(0.0, -4.0, 5.0, 2.0, 2.0, -3.0, 7.0, -3.0, 7.0, 0.0, -2.0, 0.0));
	var[1][3][0] = (mat3x4(-6.0, 6.0, 7.0, 7.0, -3.0, -3.0, -7.0, -3.0, 5.0, -8.0, 3.0, 3.0));
	var[1][3][1] = (mat3x4(-9.0, 1.0, 5.0, 5.0, -5.0, 8.0, 4.0, -4.0, 9.0, -2.0, 1.0, -8.0));
	var[2][0][0] = (mat3x4(-4.0, 4.0, 3.0, 8.0, -8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0));
	var[2][0][1] = (mat3x4(-9.0, -3.0, 7.0, -7.0, -6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0));
	var[2][1][0] = (mat3x4(-9.0, 0.0, 8.0, 4.0, -9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0));
	var[2][1][1] = (mat3x4(6.0, -3.0, -7.0, -8.0, 6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0));
	var[2][2][0] = (mat3x4(-3.0, 7.0, -2.0, 4.0, -6.0, -3.0, 4.0, -8.0, 7.0, -3.0, -5.0, -5.0));
	var[2][2][1] = (mat3x4(-6.0, -2.0, 3.0, 6.0, 7.0, 1.0, -6.0, 7.0, -9.0, 5.0, 5.0, 3.0));
	var[2][3][0] = (mat3x4(-2.0, 9.0, 3.0, 9.0, 9.0, -1.0, -9.0, 3.0, -9.0, 2.0, 2.0, -6.0));
	var[2][3][1] = (mat3x4(-9.0, 4.0, 0.0, 2.0, 4.0, -2.0, 9.0, -7.0, 4.0, -5.0, 3.0, -2.0));
}
#version 450
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
	highp vec4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var[0][0][0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((var[0][0][1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((var[0][1][0]), vec4(6.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((var[0][1][1]), vec4(8.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((var[0][2][0]), vec4(-1.0, 3.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((var[0][2][1]), vec4(9.0, 1.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4((var[0][3][0]), vec4(6.0, -4.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec4((var[0][3][1]), vec4(-2.0, 7.0, -3.0, -4.0)) && allOk;
	allOk = compare_vec4((var[1][0][0]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((var[1][0][1]), vec4(-3.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4((var[1][1][0]), vec4(-7.0, 2.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((var[1][1][1]), vec4(-1.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((var[1][2][0]), vec4(0.0, 6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4((var[1][2][1]), vec4(6.0, -7.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((var[1][3][0]), vec4(-2.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec4((var[1][3][1]), vec4(3.0, -9.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4((var[2][0][0]), vec4(-1.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[2][0][1]), vec4(7.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[2][1][0]), vec4(8.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((var[2][1][1]), vec4(3.0, -4.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4((var[2][2][0]), vec4(8.0, -6.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec4((var[2][2][1]), vec4(5.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec4((var[2][3][0]), vec4(5.0, -9.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4((var[2][3][1]), vec4(-6.0, -9.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	var[0][0][1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	var[0][1][0] = (vec4(0.0, 8.0, 4.0, -4.0));
	var[0][1][1] = (vec4(-8.0, -3.0, 9.0, -7.0));
	var[0][2][0] = (vec4(1.0, 7.0, 1.0, 1.0));
	var[0][2][1] = (vec4(-7.0, -6.0, -7.0, -4.0));
	var[0][3][0] = (vec4(5.0, -4.0, -5.0, 6.0));
	var[0][3][1] = (vec4(0.0, -2.0, -8.0, 7.0));
	var[1][0][0] = (vec4(5.0, -9.0, 4.0, -1.0));
	var[1][0][1] = (vec4(-7.0, -6.0, -2.0, -8.0));
	var[1][1][0] = (vec4(-9.0, 2.0, -6.0, 6.0));
	var[1][1][1] = (vec4(6.0, 2.0, -3.0, 0.0));
	var[1][2][0] = (vec4(8.0, -1.0, -6.0, -8.0));
	var[1][2][1] = (vec4(9.0, 7.0, -3.0, -8.0));
	var[1][3][0] = (vec4(0.0, -7.0, -2.0, -7.0));
	var[1][3][1] = (vec4(3.0, -8.0, 1.0, 6.0));
	var[2][0][0] = (vec4(8.0, 7.0, 5.0, 1.0));
	var[2][0][1] = (vec4(-6.0, -5.0, -8.0, 8.0));
	var[2][1][0] = (vec4(-9.0, 8.0, -8.0, 0.0));
	var[2][1][1] = (vec4(2.0, 6.0, 6.0, 1.0));
	var[2][2][0] = (vec4(-3.0, -9.0, 2.0, 1.0));
	var[2][2][1] = (vec4(-7.0, 3.0, -5.0, 8.0));
	var[2][3][0] = (vec4(0.0, 5.0, -3.0, -2.0));
	var[2][3][1] = (vec4(-9.0, -7.0, 2.0, -7.0));
}
#version 450
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
	highp mat2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(-8.0, 3.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(0.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(3.0, 2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(-9.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(-1.0, 2.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(-8.0, 0.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(-9.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(-8.0, -2.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(-4.0, 3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(-3.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(-1.0, 2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(-6.0, -9.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(-2.0, 1.0));
	var[0][0][0][1] = (vec2(-7.0, -1.0));
	var[0][0][1][0] = (vec2(5.0, -3.0));
	var[0][0][1][1] = (vec2(4.0, 8.0));
	var[0][1][0][0] = (vec2(-4.0, 2.0));
	var[0][1][0][1] = (vec2(-1.0, -4.0));
	var[0][1][1][0] = (vec2(-5.0, -8.0));
	var[0][1][1][1] = (vec2(3.0, -7.0));
	var[0][2][0][0] = (vec2(-7.0, 2.0));
	var[0][2][0][1] = (vec2(-9.0, 3.0));
	var[0][2][1][0] = (vec2(7.0, 9.0));
	var[0][2][1][1] = (vec2(-8.0, 3.0));
	var[0][3][0][0] = (vec2(-4.0, 7.0));
	var[0][3][0][1] = (vec2(4.0, 1.0));
	var[0][3][1][0] = (vec2(-1.0, -7.0));
	var[0][3][1][1] = (vec2(-5.0, 1.0));
	var[1][0][0][0] = (vec2(-2.0, -6.0));
	var[1][0][0][1] = (vec2(-5.0, -1.0));
	var[1][0][1][0] = (vec2(3.0, 4.0));
	var[1][0][1][1] = (vec2(-8.0, 6.0));
	var[1][1][0][0] = (vec2(5.0, 0.0));
	var[1][1][0][1] = (vec2(-4.0, -9.0));
	var[1][1][1][0] = (vec2(9.0, 1.0));
	var[1][1][1][1] = (vec2(7.0, 9.0));
	var[1][2][0][0] = (vec2(-8.0, -9.0));
	var[1][2][0][1] = (vec2(3.0, -5.0));
	var[1][2][1][0] = (vec2(7.0, 8.0));
	var[1][2][1][1] = (vec2(-8.0, 4.0));
	var[1][3][0][0] = (vec2(-1.0, 7.0));
	var[1][3][0][1] = (vec2(0.0, 9.0));
	var[1][3][1][0] = (vec2(-6.0, 1.0));
	var[1][3][1][1] = (vec2(-3.0, 1.0));
	var[2][0][0][0] = (vec2(6.0, -2.0));
	var[2][0][0][1] = (vec2(1.0, 3.0));
	var[2][0][1][0] = (vec2(2.0, 1.0));
	var[2][0][1][1] = (vec2(7.0, -2.0));
	var[2][1][0][0] = (vec2(1.0, 3.0));
	var[2][1][0][1] = (vec2(-3.0, 7.0));
	var[2][1][1][0] = (vec2(1.0, 5.0));
	var[2][1][1][1] = (vec2(4.0, 1.0));
	var[2][2][0][0] = (vec2(-4.0, 7.0));
	var[2][2][0][1] = (vec2(-4.0, -8.0));
	var[2][2][1][0] = (vec2(1.0, 0.0));
	var[2][2][1][1] = (vec2(0.0, -9.0));
	var[2][3][0][0] = (vec2(2.0, -1.0));
	var[2][3][0][1] = (vec2(-3.0, 3.0));
	var[2][3][1][0] = (vec2(-3.0, -6.0));
	var[2][3][1][1] = (vec2(3.0, 2.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0][0][0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-3.0, 0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-1.0, 0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(7.0, -9.0, 1.0, -8.0, -1.0, -4.0, -7.0, -5.0, 8.0, -9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(-5.0, 9.0, 1.0, 3.0, 0.0, -5.0, 3.0, 4.0, -5.0, 1.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(-8.0, 1.0, -1.0, -1.0, -9.0, 7.0, -4.0, 0.0, -7.0, -9.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(5.0, -9.0, 6.0, -3.0, 3.0, -7.0, 3.0, -1.0, 2.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-5.0, -5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(7.0, -1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(2.0, 6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(7.0, -8.0, -6.0, 5.0, -1.0, -9.0, 2.0, -2.0, 6.0, -5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(-9.0, -8.0, -9.0, -3.0, -2.0, 8.0, 4.0, 3.0, -8.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(-9.0, 1.0, 7.0, 0.0, 0.0, -4.0, 3.0, -4.0, -6.0, -7.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(-4.0, -2.0, -1.0, -2.0, -5.0, -7.0, -6.0, 8.0, -9.0, -3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-5.0, 8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(5.0, -4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(2.0, -4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-7.0, -7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(8.0, -3.0, -6.0, 8.0, -2.0, 8.0, 9.0, 0.0, 1.0, -3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(7.0, 0.0, 3.0, 4.0, -5.0, -8.0, 5.0, 0.0, 8.0, 2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(9.0, 8.0, -4.0, -7.0, 9.0, 5.0, -7.0, 3.0, -2.0, -4.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(5.0, 4.0, -4.0, -7.0, 7.0, -2.0, 9.0, 5.0, 1.0, -9.0, 0.0, 2.0)) && allOk;
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
	var[0][1][0][0] = (vec3(2.0, 5.0, 2.0));
	var[0][1][0][1] = (vec3(2.0, 3.0, -2.0));
	var[0][1][0][2] = (vec3(5.0, 4.0, 6.0));
	var[0][1][0][3] = (vec3(-1.0, 5.0, 6.0));
	var[0][1][1][0] = (vec3(1.0, 2.0, -4.0));
	var[0][1][1][1] = (vec3(9.0, -1.0, 6.0));
	var[0][1][1][2] = (vec3(9.0, -1.0, -2.0));
	var[0][1][1][3] = (vec3(-1.0, -8.0, 3.0));
	var[0][2][0][0] = (vec3(-5.0, 3.0, -5.0));
	var[0][2][0][1] = (vec3(-6.0, 6.0, 3.0));
	var[0][2][0][2] = (vec3(-6.0, 0.0, -5.0));
	var[0][2][0][3] = (vec3(-9.0, 8.0, -8.0));
	var[0][2][1][0] = (vec3(-5.0, 2.0, -7.0));
	var[0][2][1][1] = (vec3(-1.0, -2.0, 7.0));
	var[0][2][1][2] = (vec3(4.0, -7.0, 7.0));
	var[0][2][1][3] = (vec3(-3.0, 7.0, 6.0));
	var[0][3][0][0] = (vec3(1.0, -1.0, 8.0));
	var[0][3][0][1] = (vec3(8.0, 3.0, -9.0));
	var[0][3][0][2] = (vec3(1.0, -1.0, -7.0));
	var[0][3][0][3] = (vec3(-1.0, -7.0, -5.0));
	var[0][3][1][0] = (vec3(-5.0, 1.0, 8.0));
	var[0][3][1][1] = (vec3(5.0, 5.0, -8.0));
	var[0][3][1][2] = (vec3(-8.0, 2.0, 8.0));
	var[0][3][1][3] = (vec3(2.0, -8.0, -6.0));
	var[1][0][0][0] = (vec3(-4.0, 5.0, 7.0));
	var[1][0][0][1] = (vec3(9.0, 5.0, -7.0));
	var[1][0][0][2] = (vec3(8.0, 9.0, 0.0));
	var[1][0][0][3] = (vec3(-3.0, 3.0, 0.0));
	var[1][0][1][0] = (vec3(7.0, -8.0, -7.0));
	var[1][0][1][1] = (vec3(2.0, 7.0, 5.0));
	var[1][0][1][2] = (vec3(5.0, -7.0, 0.0));
	var[1][0][1][3] = (vec3(-2.0, 9.0, -7.0));
	var[1][1][0][0] = (vec3(-4.0, 1.0, -4.0));
	var[1][1][0][1] = (vec3(4.0, 2.0, 0.0));
	var[1][1][0][2] = (vec3(1.0, -6.0, 1.0));
	var[1][1][0][3] = (vec3(-7.0, -9.0, 8.0));
	var[1][1][1][0] = (vec3(1.0, 9.0, -4.0));
	var[1][1][1][1] = (vec3(1.0, -5.0, 9.0));
	var[1][1][1][2] = (vec3(2.0, -1.0, -1.0));
	var[1][1][1][3] = (vec3(5.0, 7.0, -4.0));
	var[1][2][0][0] = (vec3(9.0, -2.0, 2.0));
	var[1][2][0][1] = (vec3(-3.0, -6.0, 3.0));
	var[1][2][0][2] = (vec3(7.0, -7.0, -1.0));
	var[1][2][0][3] = (vec3(0.0, 1.0, -3.0));
	var[1][2][1][0] = (vec3(-6.0, 6.0, 2.0));
	var[1][2][1][1] = (vec3(-5.0, 0.0, 4.0));
	var[1][2][1][2] = (vec3(7.0, -6.0, -6.0));
	var[1][2][1][3] = (vec3(3.0, 8.0, 1.0));
	var[1][3][0][0] = (vec3(-9.0, 1.0, 5.0));
	var[1][3][0][1] = (vec3(4.0, 5.0, 1.0));
	var[1][3][0][2] = (vec3(-7.0, 4.0, -5.0));
	var[1][3][0][3] = (vec3(4.0, 8.0, 8.0));
	var[1][3][1][0] = (vec3(-4.0, -2.0, -5.0));
	var[1][3][1][1] = (vec3(-5.0, -9.0, 8.0));
	var[1][3][1][2] = (vec3(4.0, 8.0, 0.0));
	var[1][3][1][3] = (vec3(0.0, 9.0, 5.0));
	var[2][0][0][0] = (vec3(2.0, -9.0, 0.0));
	var[2][0][0][1] = (vec3(9.0, -2.0, -8.0));
	var[2][0][0][2] = (vec3(-9.0, 5.0, 9.0));
	var[2][0][0][3] = (vec3(0.0, 8.0, -9.0));
	var[2][0][1][0] = (vec3(2.0, 1.0, -7.0));
	var[2][0][1][1] = (vec3(-7.0, 8.0, 7.0));
	var[2][0][1][2] = (vec3(8.0, -8.0, -5.0));
	var[2][0][1][3] = (vec3(5.0, 1.0, -3.0));
	var[2][1][0][0] = (vec3(-2.0, 9.0, -4.0));
	var[2][1][0][1] = (vec3(-4.0, 4.0, -1.0));
	var[2][1][0][2] = (vec3(0.0, 7.0, 9.0));
	var[2][1][0][3] = (vec3(-8.0, 3.0, 9.0));
	var[2][1][1][0] = (vec3(-7.0, -1.0, -9.0));
	var[2][1][1][1] = (vec3(-7.0, 3.0, 5.0));
	var[2][1][1][2] = (vec3(-7.0, 1.0, -1.0));
	var[2][1][1][3] = (vec3(-5.0, -7.0, 7.0));
	var[2][2][0][0] = (vec3(-3.0, -1.0, 7.0));
	var[2][2][0][1] = (vec3(-2.0, -7.0, -9.0));
	var[2][2][0][2] = (vec3(-8.0, -1.0, 4.0));
	var[2][2][0][3] = (vec3(0.0, -2.0, -5.0));
	var[2][2][1][0] = (vec3(2.0, -7.0, 3.0));
	var[2][2][1][1] = (vec3(-2.0, 4.0, -6.0));
	var[2][2][1][2] = (vec3(8.0, -7.0, -9.0));
	var[2][2][1][3] = (vec3(-4.0, 5.0, 4.0));
	var[2][3][0][0] = (vec3(-3.0, 8.0, 6.0));
	var[2][3][0][1] = (vec3(7.0, 8.0, -7.0));
	var[2][3][0][2] = (vec3(-3.0, -6.0, -2.0));
	var[2][3][0][3] = (vec3(-6.0, 0.0, -8.0));
	var[2][3][1][0] = (vec3(-6.0, 0.0, 6.0));
	var[2][3][1][1] = (vec3(-1.0, 6.0, -7.0));
	var[2][3][1][2] = (vec3(7.0, 0.0, 1.0));
	var[2][3][1][3] = (vec3(-8.0, 2.0, 7.0));
}
#version 450
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
	highp mat4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(-7.0, -9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(5.0, -2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(-3.0, 6.0, 6.0, -1.0, -2.0, -7.0, 1.0, 0.0, -5.0, 3.0, -7.0, 2.0, 6.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(5.0, -4.0, -3.0, 9.0, -8.0, -9.0, 2.0, 5.0, -3.0, -3.0, -4.0, 9.0, -2.0, -8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(1.0, 5.0, -7.0, -8.0, 2.0, 4.0, -9.0, -7.0, -4.0, 6.0, -7.0, 0.0, 5.0, 3.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(-1.0, 9.0, 7.0, 3.0, 6.0, 4.0, -2.0, 2.0, -4.0, 0.0, -3.0, 6.0, -6.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(8.0, -5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-6.0, 8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(6.0, 4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(-9.0, 0.0, 3.0, 0.0, 6.0, -5.0, 8.0, 6.0, -3.0, -9.0, -1.0, 2.0, 3.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(9.0, -8.0, -7.0, -1.0, -3.0, 9.0, -4.0, -9.0, 3.0, -3.0, -7.0, -7.0, 3.0, 1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(5.0, 7.0, -3.0, 4.0, 0.0, 8.0, -1.0, -4.0, 0.0, -5.0, 3.0, -8.0, -7.0, 5.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-6.0, 7.0, -2.0, 2.0, 4.0, 7.0, -2.0, 9.0, -2.0, -5.0, 2.0, -7.0, 7.0, -5.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(8.0, 7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-7.0, 4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(4.0, -6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-4.0, -7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(3.0, 0.0, 5.0, -1.0, 2.0, 2.0, -2.0, 3.0, -9.0, 7.0, 0.0, -8.0, -4.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(-2.0, 8.0, -8.0, -3.0, 0.0, -5.0, 4.0, -3.0, -1.0, -8.0, 4.0, -2.0, -7.0, 0.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(-6.0, -6.0, -9.0, 2.0, 9.0, 6.0, -9.0, -1.0, -3.0, -9.0, -4.0, 4.0, -8.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(-3.0, -1.0, 6.0, -9.0, 6.0, -3.0, -5.0, 3.0, 8.0, -8.0, -6.0, 6.0, -1.0, 4.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	var[0][0][1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	var[0][1][0] = (mat4(3.0, 6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0));
	var[0][1][1] = (mat4(1.0, 2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0));
	var[0][2][0] = (mat4(5.0, 1.0, 7.0, 8.0, 0.0, -3.0, 8.0, 5.0, -2.0, -2.0, -1.0, -2.0, 4.0, -6.0, 1.0, 5.0));
	var[0][2][1] = (mat4(-1.0, 8.0, 6.0, 8.0, -7.0, -4.0, -5.0, -8.0, 5.0, 0.0, 7.0, -8.0, 8.0, -2.0, 6.0, 5.0));
	var[0][3][0] = (mat4(-2.0, -1.0, 8.0, 8.0, -9.0, 9.0, 6.0, -1.0, 3.0, -9.0, -4.0, -6.0, -2.0, 6.0, -7.0, 3.0));
	var[0][3][1] = (mat4(9.0, -7.0, 6.0, 8.0, -2.0, -6.0, -5.0, 5.0, -8.0, -5.0, 8.0, 4.0, 2.0, 2.0, 4.0, -9.0));
	var[1][0][0] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
	var[1][0][1] = (mat4(2.0, 3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0));
	var[1][1][0] = (mat4(2.0, 4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0));
	var[1][1][1] = (mat4(8.0, 9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0));
	var[1][2][0] = (mat4(2.0, 8.0, -1.0, 1.0, -9.0, -1.0, 9.0, -4.0, 9.0, 4.0, -2.0, 9.0, 6.0, 7.0, 1.0, 3.0));
	var[1][2][1] = (mat4(-7.0, -5.0, 2.0, -5.0, 8.0, -5.0, -6.0, 3.0, -5.0, -8.0, 1.0, -1.0, 1.0, 2.0, -5.0, 3.0));
	var[1][3][0] = (mat4(-5.0, -6.0, 9.0, -7.0, 8.0, -4.0, 0.0, -3.0, -1.0, 7.0, 1.0, -5.0, 8.0, 4.0, -7.0, 8.0));
	var[1][3][1] = (mat4(7.0, 1.0, 8.0, -1.0, 2.0, -4.0, 3.0, 6.0, -2.0, 9.0, 0.0, 2.0, -1.0, -5.0, 2.0, -6.0));
	var[2][0][0] = (mat4(-4.0, -1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0));
	var[2][0][1] = (mat4(-5.0, -1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0));
	var[2][1][0] = (mat4(-8.0, 6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0));
	var[2][1][1] = (mat4(-2.0, 0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0));
	var[2][2][0] = (mat4(7.0, 2.0, 8.0, -4.0, -1.0, 2.0, 4.0, 1.0, 9.0, 7.0, -6.0, 7.0, 7.0, -5.0, 0.0, 3.0));
	var[2][2][1] = (mat4(-4.0, -1.0, -2.0, -3.0, 6.0, 2.0, 7.0, 0.0, 3.0, 4.0, -4.0, 2.0, 8.0, -4.0, 7.0, -4.0));
	var[2][3][0] = (mat4(4.0, 2.0, -1.0, 5.0, 7.0, 1.0, -8.0, 4.0, 2.0, -3.0, -2.0, 1.0, -5.0, -8.0, 3.0, -8.0));
	var[2][3][1] = (mat4(-8.0, 9.0, 1.0, 7.0, -4.0, 3.0, -8.0, 6.0, 8.0, -5.0, -3.0, 2.0, 4.0, -5.0, -3.0, 8.0));
}
#version 450
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
	allOk = compare_ivec3((s[0].a), ivec3(-3, -8, -9)) && allOk;
	allOk = compare_mat3(s[0].b[0], mat3(2.0, 8.0, -2.0, 4.0, 8.0, -7.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3(s[0].b[1], mat3(-9.0, 2.0, -8.0, 9.0, 0.0, 9.0, 7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3(s[0].b[2], mat3(7.0, 6.0, -9.0, 1.0, -4.0, -5.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(s[0].b[3], mat3(8.0, -9.0, 2.0, -2.0, 6.0, 7.0, -3.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec4((s[0].c), vec4(-2.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_ivec3((s[1].a), ivec3(1, 3, -3)) && allOk;
	allOk = compare_mat3(s[1].b[0], mat3(9.0, 6.0, -5.0, -9.0, -5.0, -6.0, -4.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(s[1].b[1], mat3(-4.0, -8.0, 5.0, -9.0, -1.0, 7.0, -9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(s[1].b[2], mat3(-5.0, 6.0, 8.0, 5.0, -9.0, -8.0, 2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat3(s[1].b[3], mat3(-4.0, 2.0, -6.0, 3.0, -8.0, 4.0, 5.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec4((s[1].c), vec4(5.0, 3.0, -6.0, 3.0)) && allOk;
	allOk = compare_ivec3((s[2].a), ivec3(-7, 8, -8)) && allOk;
	allOk = compare_mat3(s[2].b[0], mat3(6.0, -9.0, -4.0, -9.0, -8.0, -2.0, -8.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3(s[2].b[1], mat3(-5.0, 7.0, 2.0, -5.0, 3.0, -9.0, -5.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3(s[2].b[2], mat3(-7.0, 5.0, -9.0, -6.0, -3.0, 3.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(s[2].b[3], mat3(5.0, -9.0, -3.0, 2.0, -5.0, -5.0, 6.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec4((s[2].c), vec4(-2.0, 2.0, 3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s[0].a = (ivec3(-2, 8, 8));
	s[0].b[0] = (mat3(0.0, -6.0, -4.0, 3.0, -6.0, -4.0, -4.0, -3.0, -6.0));
	s[0].b[1] = (mat3(0.0, -2.0, -1.0, -2.0, -2.0, -8.0, 7.0, -6.0, 9.0));
	s[0].b[2] = (mat3(-2.0, -5.0, 7.0, -9.0, -9.0, 8.0, 1.0, 9.0, -5.0));
	s[0].b[3] = (mat3(-4.0, 1.0, -6.0, 7.0, 8.0, -2.0, 0.0, 7.0, 6.0));
	s[0].c = (vec4(7.0, -3.0, 1.0, 6.0));
	s[1].a = (ivec3(-7, 8, -2));
	s[1].b[0] = (mat3(-5.0, 3.0, -7.0, 0.0, -5.0, 0.0, 7.0, 8.0, 4.0));
	s[1].b[1] = (mat3(8.0, 8.0, -5.0, 2.0, -2.0, 7.0, 2.0, -2.0, 0.0));
	s[1].b[2] = (mat3(-8.0, 5.0, 3.0, -5.0, 1.0, -7.0, -3.0, 2.0, -6.0));
	s[1].b[3] = (mat3(-6.0, -5.0, -6.0, 9.0, -8.0, -1.0, 8.0, 1.0, -1.0));
	s[1].c = (vec4(9.0, -7.0, 0.0, 1.0));
	s[2].a = (ivec3(-2, -6, 6));
	s[2].b[0] = (mat3(-9.0, -6.0, -8.0, -7.0, -3.0, 1.0, -4.0, 3.0, 5.0));
	s[2].b[1] = (mat3(7.0, -1.0, 7.0, 1.0, -2.0, 8.0, 5.0, 5.0, -4.0));
	s[2].b[2] = (mat3(3.0, -2.0, -3.0, -3.0, -3.0, 7.0, 8.0, -5.0, -3.0));
	s[2].b[3] = (mat3(5.0, 6.0, 1.0, -7.0, -8.0, 6.0, -4.0, 0.0, -8.0));
	s[2].c = (vec4(5.0, -4.0, 7.0, 5.0));
	v = (vec4(5.0, -3.0, -4.0, -4.0));
}
#version 450
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
	allOk = compare_mat3(t[0].a, mat3(2.0, 4.0, -1.0, 9.0, 0.0, -9.0, 1.0, -2.0, 4.0)) && allOk;
	allOk = compare_ivec3((t[0].b[0].a), ivec3(8, -3, 3)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[0]), ivec2(-7, -3)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[1]), ivec2(4, 4)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[2]), ivec2(-9, -3)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[3]), ivec2(1, 2)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(-8.0, -2.0, 3.0, 1.0)) && allOk;
	allOk = compare_ivec3((t[0].b[1].a), ivec3(2, 0, 7)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[0]), ivec2(-5, 5)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[1]), ivec2(9, 4)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[2]), ivec2(-3, -6)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[3]), ivec2(1, 1)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(-2.0, 1.0, -3.0, 1.0)) && allOk;
	allOk = compare_ivec3((t[0].b[2].a), ivec3(-9, -1, -1)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[0]), ivec2(-2, -3)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[1]), ivec2(4, -9)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[2]), ivec2(4, 6)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[3]), ivec2(-7, 8)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(-3.0, 4.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(t[1].a, mat3(-9.0, 9.0, -4.0, 2.0, 9.0, 7.0, 3.0, -4.0, -7.0)) && allOk;
	allOk = compare_ivec3((t[1].b[0].a), ivec3(0, 1, -6)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[0]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[1]), ivec2(-6, 6)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[2]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[3]), ivec2(-2, -9)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-5.0, -3.0, -2.0, -2.0)) && allOk;
	allOk = compare_ivec3((t[1].b[1].a), ivec3(0, -4, 8)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[0]), ivec2(1, 8)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[1]), ivec2(2, -1)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[2]), ivec2(1, -1)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[3]), ivec2(7, -3)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(9.0, -6.0, -9.0, -2.0)) && allOk;
	allOk = compare_ivec3((t[1].b[2].a), ivec3(2, 2, 2)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[0]), ivec2(-8, 7)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[1]), ivec2(-9, 1)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[2]), ivec2(1, -2)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[3]), ivec2(9, 3)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(1.0, -4.0, 2.0, -2.0)) && allOk;
	allOk = compare_uint((u), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(2, -5, -8));
	s.b[0] = (ivec2(6, -9));
	s.b[1] = (ivec2(-9, -8));
	s.b[2] = (ivec2(0, -1));
	s.b[3] = (ivec2(-9, 2));
	s.c = (vec4(-5.0, 6.0, -6.0, -5.0));
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
	allOk = compare_mat2x3(block[0].var, mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	block[1].var = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	block[2].var = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
}
#version 450
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
	highp mat4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(block[0].var, mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block[1].var, mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block[2].var, mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	block[1].var = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	block[2].var = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 1.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(3.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-3.0, -7.0, 1.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 1.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(7.0, 0.0, -3.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(7.0, -9.0, 1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -7.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-3.0, -5.0, -4.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-9.0, 1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	block[1].var = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	block[2].var = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
}
#version 450
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
	highp mat3x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(block[0].var, mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	block[1].var = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	block[2].var = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 5.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -5.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-6.0, -5.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-1.0, -5.0)) && allOk;
	allOk = compare_float((block[1].padding), -6.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -8.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-8.0, 6.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-3.0, 2.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(2.0, -8.0)) && allOk;
	allOk = compare_float((block[2].padding), 9.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 4.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(6.0, 5.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-1.0);
	block[0].var = (mat3x2(-5.0, -1.0, -8.0, 7.0, 8.0, -4.0));
	block[1].padding = (-8.0);
	block[1].var = (mat3x2(1.0, 5.0, -2.0, 7.0, 4.0, -6.0));
	block[2].padding = (7.0);
	block[2].var = (mat3x2(-6.0, 2.0, 5.0, 0.0, 6.0, -5.0));
}
#version 450
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
} block[3];

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block[0].padding), 6u) && allOk;
	allOk = compare_u16vec4(uvec4(block[0].var), uvec4(0u, 8u, 3u, 8u)) && allOk;
	allOk = compare_uint16_t(uint(block[1].padding), 7u) && allOk;
	allOk = compare_u16vec4(uvec4(block[1].var), uvec4(5u, 4u, 8u, 7u)) && allOk;
	allOk = compare_uint16_t(uint(block[2].padding), 1u) && allOk;
	allOk = compare_u16vec4(uvec4(block[2].var), uvec4(8u, 5u, 0u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = uint16_t(0u);
	block[0].var = u16vec4(uvec4(6u, 9u, 4u, 5u));
	block[1].padding = uint16_t(0u);
	block[1].var = u16vec4(uvec4(1u, 0u, 7u, 6u));
	block[2].padding = uint16_t(5u);
	block[2].var = u16vec4(uvec4(9u, 8u, 3u, 6u));
}
#version 450
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
	f16vec3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block[0].padding), 4.0) && allOk;
	allOk = compare_f16vec3(vec3(block[0].var), vec3(1.0, 9.0, -8.0)) && allOk;
	allOk = compare_float16_t(float(block[1].padding), 7.0) && allOk;
	allOk = compare_f16vec3(vec3(block[1].var), vec3(-5.0, 4.0, 2.0)) && allOk;
	allOk = compare_float16_t(float(block[2].padding), -4.0) && allOk;
	allOk = compare_f16vec3(vec3(block[2].var), vec3(4.0, 4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = float16_t(3.0);
	block[0].var = f16vec3(vec3(3.0, 7.0, -3.0));
	block[1].padding = float16_t(-5.0);
	block[1].var = f16vec3(vec3(-9.0, -1.0, 0.0));
	block[2].padding = float16_t(6.0);
	block[2].var = f16vec3(vec3(5.0, -7.0, 2.0));
}
#version 450
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
	allOk = compare_float((blockA[0].a), -8.0) && allOk;
	allOk = compare_float(blockA[0].c[0][0], -5.0) && allOk;
	allOk = compare_float(blockA[0].c[0][1], 7.0) && allOk;
	allOk = compare_float(blockA[0].c[1][0], -9.0) && allOk;
	allOk = compare_float(blockA[0].c[1][1], -9.0) && allOk;
	allOk = compare_vec2(blockA[0].c[0], vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2(blockA[0].c[1], vec2(-9.0, -9.0)) && allOk;
	allOk = compare_float((blockA[1].a), -8.0) && allOk;
	allOk = compare_float(blockA[1].c[0][0], 2.0) && allOk;
	allOk = compare_float(blockA[1].c[0][1], 3.0) && allOk;
	allOk = compare_float(blockA[1].c[1][0], 1.0) && allOk;
	allOk = compare_float(blockA[1].c[1][1], -1.0) && allOk;
	allOk = compare_vec2(blockA[1].c[0], vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec2(blockA[1].c[1], vec2(1.0, -1.0)) && allOk;
	allOk = compare_float((blockA[2].a), -5.0) && allOk;
	allOk = compare_float(blockA[2].c[0][0], -9.0) && allOk;
	allOk = compare_float(blockA[2].c[0][1], -8.0) && allOk;
	allOk = compare_float(blockA[2].c[1][0], -6.0) && allOk;
	allOk = compare_float(blockA[2].c[1][1], -4.0) && allOk;
	allOk = compare_vec2(blockA[2].c[0], vec2(-9.0, -8.0)) && allOk;
	allOk = compare_vec2(blockA[2].c[1], vec2(-6.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(6, 5)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-9, -3)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(-6, 4)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-7.0);
	blockA[1].a = (-6.0);
	blockA[2].a = (2.0);
	blockB[0].a[0] = (vec3(-1.0, 0.0, 7.0));
	blockB[0].a[1] = (vec3(1.0, -1.0, -4.0));
	blockB[0].a[2] = (vec3(9.0, -6.0, -6.0));
	blockB[0].d = (true);
	blockB[1].a[0] = (vec3(-2.0, 5.0, -6.0));
	blockB[1].a[1] = (vec3(9.0, -5.0, 4.0));
	blockB[1].a[2] = (vec3(2.0, 8.0, -2.0));
	blockB[1].d = (false);
	blockB[2].a[0] = (vec3(9.0, -5.0, 2.0));
	blockB[2].a[1] = (vec3(4.0, -7.0, 7.0));
	blockB[2].a[2] = (vec3(3.0, 9.0, 6.0));
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

layout(binding = 1) buffer BlockA
{
	layout(offset = 0) highp float a;
	layout(offset = 4) lowp uvec3 b;
	layout(offset = 16) mediump mat2 c;
} blockA[3];
layout(binding = 2) buffer BlockB
{
	layout(offset = 0) mediump mat3 a;
	layout(offset = 48) lowp ivec2 b;
	layout(offset = 64) highp vec4 c;
	layout(offset = 80) bool d;
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
	allOk = compare_float((blockA[0].a), 9.0) && allOk;
	allOk = compare_mat2(blockA[0].c, mat2(2.0, -6.0, -8.0, 5.0)) && allOk;
	allOk = compare_float((blockA[1].a), -1.0) && allOk;
	allOk = compare_mat2(blockA[1].c, mat2(3.0, 9.0, -9.0, 1.0)) && allOk;
	allOk = compare_float((blockA[2].a), -6.0) && allOk;
	allOk = compare_mat2(blockA[2].c, mat2(-9.0, 2.0, -1.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-7, 5)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(7, -3)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(6, 7)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-6.0);
	blockA[1].a = (-8.0);
	blockA[2].a = (1.0);
	blockB[0].a[0] = (vec3(6.0, 1.0, -5.0));
	blockB[0].a[1] = (vec3(2.0, -4.0, 0.0));
	blockB[0].a[2] = (vec3(-9.0, -9.0, 0.0));
	blockB[0].d = (false);
	blockB[1].a[0] = (vec3(-2.0, 8.0, -7.0));
	blockB[1].a[1] = (vec3(3.0, -2.0, -9.0));
	blockB[1].a[2] = (vec3(-7.0, 7.0, -8.0));
	blockB[1].d = (false);
	blockB[2].a[0] = (vec3(0.0, -6.0, 0.0));
	blockB[2].a[1] = (vec3(-9.0, 9.0, -3.0));
	blockB[2].a[2] = (vec3(8.0, -6.0, -3.0));
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
	allOk = compare_float((blockA[0].a), 4.0) && allOk;
	allOk = compare_float((blockA[1].a), 5.0) && allOk;
	allOk = compare_float((blockA[2].a), -3.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 7u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(-7.0, 1.0, 7.0, 4.0, 6.0, 4.0, -7.0, -1.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(5, 5)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(-4, 8)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(-6, 7)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(3.0, -3.0, 5.0, 9.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_uint((blockB[1].b.a), 3u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(3.0, 7.0, -7.0, -7.0, 5.0, 5.0, -4.0, -4.0, -6.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(-6, 1)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(8, 1)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(9, -6)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(7, 8)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(-5.0, 7.0, 5.0, 6.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_uint((blockB[2].b.a), 9u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(-4.0, -3.0, 5.0, -8.0, 0.0, 0.0, 6.0, -1.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(6, 0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(-4, 9)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(-2, 8)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(-1, -9)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(7.0, 8.0, -3.0, -2.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (5.0);
	blockA[0].b.a[0] = (vec3(-9.0, -8.0, 1.0));
	blockA[0].b.a[1] = (vec3(8.0, -1.0, 4.0));
	blockA[0].b.a[2] = (vec3(-7.0, 5.0, 5.0));
	blockA[0].b.b[0] = (ivec2(1, -2));
	blockA[0].b.b[1] = (ivec2(7, 4));
	blockA[0].b.b[2] = (ivec2(3, -4));
	blockA[0].b.b[3] = (ivec2(2, 4));
	blockA[0].b.c = (vec4(9.0, 2.0, -3.0, 1.0));
	blockA[1].a = (2.0);
	blockA[1].b.a[0] = (vec3(-4.0, 4.0, 3.0));
	blockA[1].b.a[1] = (vec3(-1.0, 4.0, -3.0));
	blockA[1].b.a[2] = (vec3(1.0, 2.0, 2.0));
	blockA[1].b.b[0] = (ivec2(-9, -2));
	blockA[1].b.b[1] = (ivec2(-8, -7));
	blockA[1].b.b[2] = (ivec2(6, 8));
	blockA[1].b.b[3] = (ivec2(-1, 8));
	blockA[1].b.c = (vec4(-2.0, -4.0, 0.0, 7.0));
	blockA[2].a = (-2.0);
	blockA[2].b.a[0] = (vec3(5.0, -1.0, 8.0));
	blockA[2].b.a[1] = (vec3(0.0, 1.0, 9.0));
	blockA[2].b.a[2] = (vec3(-4.0, 3.0, -2.0));
	blockA[2].b.b[0] = (ivec2(-5, 6));
	blockA[2].b.b[1] = (ivec2(-9, -8));
	blockA[2].b.b[2] = (ivec2(4, -6));
	blockA[2].b.b[3] = (ivec2(-8, -5));
	blockA[2].b.c = (vec4(-2.0, 8.0, 8.0, -2.0));
	blockB[0].a[0] = (vec2(-8.0, -6.0));
	blockB[0].a[1] = (vec2(-4.0, 0.0));
	blockB[0].b.a = (0u);
	blockB[0].b.b.a[0] = (vec3(9.0, -8.0, 2.0));
	blockB[0].b.b.a[1] = (vec3(2.0, 1.0, -4.0));
	blockB[0].b.b.a[2] = (vec3(-7.0, -3.0, 1.0));
	blockB[0].b.b.b[0] = (ivec2(2, 9));
	blockB[0].b.b.b[1] = (ivec2(1, 5));
	blockB[0].b.b.b[2] = (ivec2(1, -5));
	blockB[0].b.b.b[3] = (ivec2(8, -2));
	blockB[0].b.b.c = (vec4(-7.0, 6.0, 2.0, -8.0));
	blockB[0].b.c = (bvec4(true, true, false, true));
	blockB[0].d = (true);
	blockB[1].a[0] = (vec2(-7.0, 0.0));
	blockB[1].a[1] = (vec2(2.0, 2.0));
	blockB[1].b.a = (3u);
	blockB[1].b.b.a[0] = (vec3(4.0, 2.0, -3.0));
	blockB[1].b.b.a[1] = (vec3(-8.0, -4.0, 4.0));
	blockB[1].b.b.a[2] = (vec3(-2.0, -3.0, -9.0));
	blockB[1].b.b.b[0] = (ivec2(5, -2));
	blockB[1].b.b.b[1] = (ivec2(-5, 6));
	blockB[1].b.b.b[2] = (ivec2(-9, -3));
	blockB[1].b.b.b[3] = (ivec2(-6, -7));
	blockB[1].b.b.c = (vec4(3.0, -4.0, 8.0, 2.0));
	blockB[1].b.c = (bvec4(false, true, true, false));
	blockB[1].d = (false);
	blockB[2].a[0] = (vec2(-2.0, 7.0));
	blockB[2].a[1] = (vec2(6.0, -3.0));
	blockB[2].b.a = (9u);
	blockB[2].b.b.a[0] = (vec3(9.0, -3.0, 8.0));
	blockB[2].b.b.a[1] = (vec3(-9.0, 6.0, 8.0));
	blockB[2].b.b.a[2] = (vec3(5.0, 1.0, -8.0));
	blockB[2].b.b.b[0] = (ivec2(4, -8));
	blockB[2].b.b.b[1] = (ivec2(-5, 5));
	blockB[2].b.b.b[2] = (ivec2(-2, -7));
	blockB[2].b.b.b[3] = (ivec2(7, 4));
	blockB[2].b.b.c = (vec4(-2.0, -4.0, 4.0, 5.0));
	blockB[2].b.c = (bvec4(true, false, true, false));
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
	allOk = compare_float((blockA[0].a), -2.0) && allOk;
	allOk = compare_float((blockA[1].a), 7.0) && allOk;
	allOk = compare_float((blockA[2].a), 4.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(-5.0, 6.0, 6.0, 3.0, -7.0, 9.0, 2.0, 5.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(-1, -4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(3, 9)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(3, -6)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(0, 6)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(-9.0, 2.0, 5.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b.a), 9u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(-1.0, 1.0, -4.0, -2.0, 3.0, 6.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(-3, 9)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(8, 0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(4, -1)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(1.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_uint((blockB[2].b.a), 2u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(0.0, -5.0, 4.0, -6.0, -6.0, 1.0, 7.0, -6.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(-5, -8)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(1, -1)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(9, -8)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(9.0, 2.0, -2.0, -7.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (1.0);
	blockA[0].b.a = (mat3(-5.0, 3.0, 4.0, 8.0, -9.0, -3.0, -2.0, -7.0, 1.0));
	blockA[0].b.b[0] = (ivec2(-3, -8));
	blockA[0].b.b[1] = (ivec2(9, 5));
	blockA[0].b.b[2] = (ivec2(0, -1));
	blockA[0].b.b[3] = (ivec2(6, 9));
	blockA[0].b.c = (vec4(-7.0, -2.0, 1.0, -6.0));
	blockA[1].a = (-6.0);
	blockA[1].b.a = (mat3(6.0, 1.0, -8.0, 5.0, -6.0, -4.0, 9.0, 4.0, 0.0));
	blockA[1].b.b[0] = (ivec2(5, 3));
	blockA[1].b.b[1] = (ivec2(-9, -6));
	blockA[1].b.b[2] = (ivec2(-3, -3));
	blockA[1].b.b[3] = (ivec2(-9, 6));
	blockA[1].b.c = (vec4(-5.0, -7.0, 6.0, 3.0));
	blockA[2].a = (8.0);
	blockA[2].b.a = (mat3(5.0, 1.0, 2.0, 4.0, -6.0, -7.0, -6.0, -2.0, 9.0));
	blockA[2].b.b[0] = (ivec2(0, -6));
	blockA[2].b.b[1] = (ivec2(-7, 7));
	blockA[2].b.b[2] = (ivec2(-5, 5));
	blockA[2].b.b[3] = (ivec2(9, 7));
	blockA[2].b.c = (vec4(-2.0, -9.0, -2.0, 6.0));
	blockB[0].a = (mat2(-4.0, 0.0, 2.0, -1.0));
	blockB[0].b.a = (8u);
	blockB[0].b.b.a = (mat3(5.0, 2.0, 4.0, 5.0, 8.0, 6.0, 7.0, 9.0, -1.0));
	blockB[0].b.b.b[0] = (ivec2(5, 5));
	blockB[0].b.b.b[1] = (ivec2(-6, -7));
	blockB[0].b.b.b[2] = (ivec2(-4, 2));
	blockB[0].b.b.b[3] = (ivec2(-1, 5));
	blockB[0].b.b.c = (vec4(-3.0, 3.0, 4.0, 0.0));
	blockB[0].b.c = (bvec4(false, false, false, false));
	blockB[0].d = (false);
	blockB[1].a = (mat2(9.0, 9.0, 1.0, -4.0));
	blockB[1].b.a = (4u);
	blockB[1].b.b.a = (mat3(4.0, -1.0, -6.0, 3.0, 6.0, -1.0, 6.0, 6.0, -7.0));
	blockB[1].b.b.b[0] = (ivec2(7, 2));
	blockB[1].b.b.b[1] = (ivec2(-2, -8));
	blockB[1].b.b.b[2] = (ivec2(6, 6));
	blockB[1].b.b.b[3] = (ivec2(9, -8));
	blockB[1].b.b.c = (vec4(-9.0, -6.0, 3.0, -5.0));
	blockB[1].b.c = (bvec4(false, false, false, false));
	blockB[1].d = (true);
	blockB[2].a = (mat2(-9.0, 3.0, 6.0, 9.0));
	blockB[2].b.a = (7u);
	blockB[2].b.b.a = (mat3(4.0, -9.0, 7.0, -2.0, 1.0, 2.0, -6.0, 2.0, 3.0));
	blockB[2].b.b.b[0] = (ivec2(-3, 8));
	blockB[2].b.b.b[1] = (ivec2(1, 0));
	blockB[2].b.b.b[2] = (ivec2(-1, 8));
	blockB[2].b.b.b[3] = (ivec2(-9, -5));
	blockB[2].b.b.c = (vec4(9.0, 6.0, -1.0, -5.0));
	blockB[2].b.c = (bvec4(false, true, true, false));
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
layout(scalar, binding = 1) buffer BlockA
{
	highp float a;
	S b;
	lowp uvec3 c;
} blockA;
layout(scalar, binding = 2) buffer BlockB
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
	allOk = compare_float((blockA.a), 2.0) && allOk;
	allOk = compare_uint((blockB.b.a), 2u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(6.0, 6.0, 0.0, -9.0, -5.0, -5.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(8, -4)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(-5, 9)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(3, 7)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(8.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-3.0);
	blockA.b.a = (mat3(6.0, 8.0, 1.0, -7.0, 5.0, -7.0, 2.0, -2.0, -1.0));
	blockA.b.b[0] = (ivec2(-6, -6));
	blockA.b.b[1] = (ivec2(7, 1));
	blockA.b.b[2] = (ivec2(8, 8));
	blockA.b.b[3] = (ivec2(9, -7));
	blockA.b.c = (vec4(-4.0, 0.0, -9.0, -2.0));
	blockB.a = (mat2(-7.0, -4.0, 2.0, -2.0));
	blockB.b.a = (9u);
	blockB.b.b.a = (mat3(3.0, 5.0, 3.0, 1.0, -6.0, -6.0, -6.0, 0.0, -7.0));
	blockB.b.b.b[0] = (ivec2(4, 5));
	blockB.b.b.b[1] = (ivec2(-6, -8));
	blockB.b.b.b[2] = (ivec2(4, -7));
	blockB.b.b.b[3] = (ivec2(5, -9));
	blockB.b.b.c = (vec4(7.0, 8.0, -1.0, -4.0));
	blockB.b.c = (bvec4(true, true, false, false));
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
	mediump float a;
	mediump float b;
	lowp int c[1];
	mediump int d;
	bool e[1];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	bool f;
	highp int g;
	lowp int h;
	mediump uint i;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	lowp float j;
	mediump int k;
	mediump int l;
	highp int m;
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	bool n;
	mediump int o[1];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), 0.0) && allOk;
	allOk = compare_float((blockB.b), 2.0) && allOk;
	allOk = compare_int((blockB.c[0]), -8) && allOk;
	allOk = compare_int((blockC.g), -6) && allOk;
	allOk = compare_int((blockC.h), 1) && allOk;
	allOk = compare_uint((blockC.i), 5u) && allOk;
	allOk = compare_int((blockD.l), 4) && allOk;
	allOk = compare_int((blockD.m), 4) && allOk;
	allOk = compare_bool((blockE.n), false) && allOk;
	allOk = compare_int((blockE.o[0]), -9) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6.0);
	blockB.c[0] = (0);
	blockB.d = (3);
	blockB.e[0] = (false);
	blockC.f = (false);
	blockC.i = (2u);
	blockD.k = (-6);
	blockD.l = (3);
	blockD.m = (-2);
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

layout(std430, binding = 1) buffer BlockB
{
	lowp int a;
	mediump float b;
	mediump uint c[1];
	highp float d;
};
layout(std430, binding = 2) buffer BlockC
{
	mediump int e;
	lowp float f;
	lowp float g;
	lowp int h;
};
layout(std140, binding = 3) buffer BlockD
{
	mediump int i;
	mediump float j;
	lowp float k;
	mediump float l;
	highp float m;
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	lowp float n;
	mediump float o;
	bool p;
	lowp float q;
	highp int r;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((a), 2) && allOk;
	allOk = compare_float((g), -5.0) && allOk;
	allOk = compare_int((blockD.i), -6) && allOk;
	allOk = compare_float((blockD.j), 4.0) && allOk;
	allOk = compare_float((blockD.k), 5.0) && allOk;
	allOk = compare_float((blockD.l), 6.0) && allOk;
	allOk = compare_float((blockD.m), -6.0) && allOk;
	allOk = compare_float((n), 1.0) && allOk;
	allOk = compare_float((o), 8.0) && allOk;
	allOk = compare_bool((p), false) && allOk;
	allOk = compare_float((q), -7.0) && allOk;
	allOk = compare_int((r), 7) && allOk;
    if (allOk)
        ac_numPassed++;

	c[0] = (4u);
	d = (-6.0);
	e = (6);
	f = (0.0);
	g = (9.0);
	blockD.i = (4);
	blockD.j = (8.0);
	blockD.k = (6.0);
	blockD.m = (-5.0);
	p = (false);
	q = (4.0);
	r = (7);
}
#version 450
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
	mediump mat3x4 a;
	bvec2 b;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp vec3 c[1];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	bvec3 d;
	highp vec2 e;
	lowp vec3 f;
	mediump mat4 g;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((d), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((f), vec3(2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4(g, mat4(-6.0, 8.0, 5.0, 5.0, -3.0, 3.0, 1.0, -9.0, 7.0, -2.0, 2.0, 9.0, -3.0, 3.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x4(2.0, -4.0, 0.0, 5.0, 7.0, -8.0, 0.0, 3.0, -5.0, -5.0, -7.0, 4.0));
	b = (bvec2(false, false));
	blockC.c[0] = (vec3(3.0, 8.0, 8.0));
	e = (vec2(1.0, 7.0));
	g = (mat4(-7.0, -5.0, 7.0, -9.0, -5.0, 5.0, 3.0, 7.0, -7.0, -6.0, 1.0, 8.0, 8.0, -9.0, -8.0, 4.0));
}
#version 450
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
	lowp mat2 a;
	highp int b;
	bvec3 c;
	highp mat3x4 d[8];
	highp ivec2 e[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	lowp uvec4 f;
	mediump vec2 g;
	lowp uvec4 h[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	mediump uvec4 i;
	bvec4 j;
	mediump ivec2 k;
	highp int l[3];
	lowp mat2x3 m;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b), 7) && allOk;
	allOk = compare_bvec3((blockB.c), bvec3(false, true, false)) && allOk;
	allOk = compare_ivec2((blockB.e[0]), ivec2(1, 8)) && allOk;
	allOk = compare_ivec2((blockB.e[1]), ivec2(0, -3)) && allOk;
	allOk = compare_ivec2((blockB.e[2]), ivec2(-8, 6)) && allOk;
	allOk = compare_ivec2((blockB.e[3]), ivec2(-2, 5)) && allOk;
	allOk = compare_ivec2((blockB.e[4]), ivec2(8, 8)) && allOk;
	allOk = compare_ivec2((blockB.e[5]), ivec2(-5, 4)) && allOk;
	allOk = compare_vec2((g), vec2(4.0, 4.0)) && allOk;
	allOk = compare_uvec4((h[0]), uvec4(1u, 3u, 6u, 9u)) && allOk;
	allOk = compare_uvec4((h[1]), uvec4(6u, 7u, 3u, 2u)) && allOk;
	allOk = compare_uvec4((h[2]), uvec4(8u, 1u, 9u, 0u)) && allOk;
	allOk = compare_uvec4((blockD.i), uvec4(3u, 9u, 2u, 9u)) && allOk;
	allOk = compare_ivec2((blockD.k), ivec2(-1, 5)) && allOk;
	allOk = compare_int((blockD.l[0]), 1) && allOk;
	allOk = compare_int((blockD.l[1]), 3) && allOk;
	allOk = compare_int((blockD.l[2]), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (bvec3(false, true, false));
	blockB.e[0] = (ivec2(-6, 0));
	blockB.e[1] = (ivec2(-5, -7));
	blockB.e[2] = (ivec2(4, -8));
	blockB.e[3] = (ivec2(-7, -7));
	blockB.e[4] = (ivec2(-5, -3));
	blockB.e[5] = (ivec2(-7, -5));
	f = (uvec4(3u, 8u, 8u, 3u));
	g = (vec2(-2.0, -7.0));
	blockD.i = (uvec4(9u, 0u, 3u, 4u));
	blockD.j = (bvec4(true, true, false, false));
	blockD.k = (ivec2(-1, 9));
	blockD.l[0] = (-8);
	blockD.l[1] = (-2);
	blockD.l[2] = (-4);
	blockD.m = (mat2x3(-8.0, 8.0, -7.0, 9.0, 9.0, 8.0));
}
#version 450
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
	lowp mat3 a;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(-5.0, 5.0, -6.0, -9.0, 9.0, -5.0, 7.0, 7.0, 0.0)) && allOk;
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

layout(std430, binding = 1) buffer BlockB
{
	highp mat3x4 a;
	lowp float b;
	mediump mat3x2 c;
	highp uvec4 d[];
} blockB[3];
layout(std430, binding = 2) buffer BlockC
{
	mediump uvec4 e[8];
	mediump mat3x2 f;
	highp mat4 g[][1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[0].a, mat3x4(6.0, 8.0, 8.0, 0.0, -4.0, -5.0, 9.0, -4.0, -6.0, -1.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB[0].c, mat3x2(6.0, 5.0, 7.0, -2.0, -4.0, -9.0)) && allOk;
	allOk = compare_uvec4((blockB[0].d[0]), uvec4(6u, 5u, 3u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[1]), uvec4(2u, 4u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[2]), uvec4(9u, 4u, 9u, 1u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[3]), uvec4(8u, 6u, 2u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[4]), uvec4(8u, 1u, 3u, 5u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[5]), uvec4(4u, 9u, 1u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[6]), uvec4(7u, 2u, 5u, 4u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[7]), uvec4(5u, 2u, 4u, 2u)) && allOk;
	allOk = compare_mat3x4(blockB[1].a, mat3x4(-8.0, 6.0, -2.0, 3.0, 7.0, 2.0, -7.0, -2.0, -5.0, 4.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockB[1].c, mat3x2(-2.0, -8.0, -2.0, -9.0, 0.0, -8.0)) && allOk;
	allOk = compare_uvec4((blockB[1].d[0]), uvec4(5u, 7u, 0u, 2u)) && allOk;
	allOk = compare_uvec4((blockB[1].d[1]), uvec4(5u, 8u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((blockB[1].d[2]), uvec4(6u, 7u, 7u, 1u)) && allOk;
	allOk = compare_uvec4((blockB[1].d[3]), uvec4(3u, 8u, 1u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[1].d[4]), uvec4(2u, 9u, 7u, 8u)) && allOk;
	allOk = compare_uvec4((blockB[1].d[5]), uvec4(7u, 0u, 2u, 7u)) && allOk;
	allOk = compare_uvec4((blockB[1].d[6]), uvec4(3u, 2u, 7u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[1].d[7]), uvec4(7u, 8u, 6u, 9u)) && allOk;
	allOk = compare_mat3x4(blockB[2].a, mat3x4(9.0, -9.0, -6.0, 7.0, 6.0, -4.0, 7.0, -1.0, 3.0, 3.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB[2].c, mat3x2(-7.0, 7.0, 6.0, 5.0, -5.0, -9.0)) && allOk;
	allOk = compare_uvec4((blockB[2].d[0]), uvec4(9u, 8u, 0u, 7u)) && allOk;
	allOk = compare_uvec4((blockB[2].d[1]), uvec4(3u, 7u, 0u, 6u)) && allOk;
	allOk = compare_uvec4((blockB[2].d[2]), uvec4(2u, 9u, 8u, 6u)) && allOk;
	allOk = compare_uvec4((blockB[2].d[3]), uvec4(1u, 3u, 9u, 8u)) && allOk;
	allOk = compare_mat4(g[0][0], mat4(7.0, -5.0, 0.0, -2.0, 3.0, -2.0, -7.0, -6.0, -7.0, -3.0, -8.0, 8.0, 9.0, -1.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4(g[1][0], mat4(5.0, 9.0, -9.0, 5.0, 1.0, 7.0, -6.0, 7.0, -2.0, 6.0, -9.0, -5.0, -4.0, -3.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4(g[2][0], mat4(-9.0, -7.0, -8.0, -4.0, -4.0, -1.0, -6.0, 7.0, -6.0, 3.0, -7.0, 5.0, 8.0, -8.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat4(g[3][0], mat4(8.0, -7.0, 3.0, -2.0, 5.0, -8.0, -9.0, 9.0, 9.0, 5.0, -7.0, 0.0, 2.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4(g[4][0], mat4(-9.0, 0.0, -2.0, 1.0, 1.0, -7.0, 3.0, 5.0, 0.0, 8.0, 4.0, 3.0, 5.0, 2.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat4(g[5][0], mat4(-9.0, 9.0, -7.0, 7.0, -6.0, 1.0, 0.0, 7.0, 4.0, -8.0, 0.0, -8.0, -3.0, 1.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4(g[6][0], mat4(-4.0, -2.0, 7.0, -2.0, -9.0, 3.0, 3.0, -7.0, -9.0, 9.0, 4.0, 5.0, -7.0, 9.0, -5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (-7.0);
	blockB[0].c = (mat3x2(-2.0, 2.0, 3.0, -1.0, 4.0, -4.0));
	blockB[1].b = (-4.0);
	blockB[1].c = (mat3x2(5.0, -9.0, 5.0, -9.0, -5.0, -1.0));
	blockB[2].b = (4.0);
	blockB[2].c = (mat3x2(2.0, 7.0, 2.0, 5.0, 2.0, -5.0));
	f = (mat3x2(-3.0, -7.0, 4.0, -9.0, 4.0, -2.0));
	g[0][0] = (mat4(-1.0, -3.0, 4.0, 6.0, 8.0, 1.0, 9.0, 7.0, 9.0, 9.0, -5.0, -8.0, -1.0, 6.0, 9.0, -1.0));
	g[1][0] = (mat4(-7.0, -2.0, -4.0, 4.0, 7.0, 0.0, 6.0, -8.0, 8.0, -8.0, -5.0, 6.0, -1.0, 1.0, -3.0, 9.0));
	g[2][0] = (mat4(-1.0, 3.0, 1.0, -1.0, 4.0, 2.0, 6.0, -3.0, -3.0, 2.0, 3.0, -4.0, -7.0, 8.0, 8.0, 5.0));
	g[3][0] = (mat4(-6.0, 0.0, 0.0, -1.0, 3.0, -3.0, -2.0, -3.0, -5.0, 0.0, -9.0, -6.0, 5.0, 1.0, 4.0, -6.0));
	g[4][0] = (mat4(0.0, -9.0, -3.0, 8.0, 1.0, -3.0, -5.0, 0.0, -4.0, -7.0, 3.0, 8.0, -5.0, 0.0, -1.0, 7.0));
	g[5][0] = (mat4(2.0, -7.0, 0.0, -9.0, 1.0, -8.0, -5.0, -5.0, 0.0, 3.0, 3.0, -3.0, -6.0, -5.0, 5.0, -3.0));
	g[6][0] = (mat4(9.0, -5.0, -4.0, 8.0, 7.0, -5.0, 3.0, 6.0, 9.0, 3.0, -4.0, 6.0, -4.0, -6.0, 3.0, -5.0));
}
#version 450
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
	bvec2 mA;
	bvec2 mB;
	bvec3 mC;
	mediump vec4 mD;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	lowp vec3 a;
	sA b;
	mediump vec3 c;
	lowp ivec4 d;
	lowp mat4x2 e;
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp mat4x2 f;
	lowp float g;
	highp mat4 h[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((c), vec3(-4.0, 1.0, -4.0)) && allOk;
	allOk = compare_ivec4((d), ivec4(-4, -3, 1, 5)) && allOk;
	allOk = compare_mat4x2(blockC.f, mat4x2(6.0, -8.0, 6.0, 6.0, 5.0, 1.0, 4.0, 6.0)) && allOk;
	allOk = compare_float((blockC.g), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (vec3(3.0, 0.0, 4.0));
	d = (ivec4(-4, -4, 1, -6));
	blockC.f = (mat4x2(-1.0, -6.0, -3.0, 2.0, 0.0, -6.0, -5.0, -6.0));
	blockC.h[0] = (mat4(-7.0, 0.0, -9.0, -1.0, -1.0, 4.0, -2.0, -5.0, 5.0, 3.0, 0.0, 9.0, -5.0, -3.0, 3.0, -7.0));
	blockC.h[1] = (mat4(0.0, -2.0, -2.0, 7.0, -9.0, -8.0, 3.0, 5.0, 5.0, -1.0, 7.0, -1.0, -8.0, 0.0, -8.0, 4.0));
	blockC.h[2] = (mat4(-3.0, -4.0, 9.0, -9.0, -8.0, 8.0, 1.0, 2.0, -6.0, 8.0, -9.0, 7.0, -1.0, 3.0, -8.0, 3.0));
	blockC.h[3] = (mat4(9.0, 6.0, -4.0, 0.0, -9.0, 3.0, 5.0, 0.0, -7.0, 1.0, 0.0, 0.0, -4.0, 5.0, -3.0, 2.0));
	blockC.h[4] = (mat4(1.0, 8.0, -6.0, 2.0, -5.0, 6.0, 2.0, 0.0, -4.0, 7.0, -3.0, 3.0, -9.0, 4.0, 8.0, 3.0));
	blockC.h[5] = (mat4(-6.0, -5.0, 9.0, -6.0, -9.0, -2.0, -4.0, -9.0, -8.0, 6.0, 3.0, -1.0, -7.0, 7.0, -1.0, 0.0));
}
#version 450
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
	highp vec2 mA;
};
layout(std430, binding = 1) buffer BlockB
{
	highp int a;
	lowp mat4 b;
	lowp float c;
	lowp mat4x2 d;
	lowp uvec2 e;
} blockB[3];
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp vec4 f;
	sA g;
	highp int h;
	lowp uvec4 i;
};
layout(std140, binding = 3) buffer BlockD
{
	lowp float j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

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
	allOk = compare_vec4((f), vec4(7.0, 8.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec2((g.mA), vec2(7.0, -1.0)) && allOk;
	allOk = compare_int((h), 8) && allOk;
	allOk = compare_float((j[0]), 1.0) && allOk;
	allOk = compare_float((j[1]), 5.0) && allOk;
	allOk = compare_float((j[2]), -8.0) && allOk;
	allOk = compare_float((j[3]), -2.0) && allOk;
	allOk = compare_float((j[4]), -5.0) && allOk;
	allOk = compare_float((j[5]), 9.0) && allOk;
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
	f = (vec4(1.0, 2.0, 3.0, -7.0));
	g.mA = (vec2(-5.0, 6.0));
	h = (-1);
	i = (uvec4(5u, 9u, 0u, 7u));
	j[0] = (-8.0);
	j[1] = (-1.0);
	j[2] = (-8.0);
	j[3] = (-6.0);
	j[4] = (-5.0);
	j[5] = (-7.0);
}
#version 450
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
	layout(offset = 16) lowp uvec2 b;
	layout(offset = 24) highp float c;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump ivec4 d;
	layout(offset = 16) bvec3 e;
};
layout(binding = 3) readonly buffer BlockD
{
	layout(offset = 0) mediump ivec3 f;
};
layout(binding = 4) readonly buffer BlockE
{
	layout(offset = 0) mediump ivec4 g;
	layout(offset = 16) mediump vec3 h;
} blockE[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((b), uvec2(0u, 9u)) && allOk;
	allOk = compare_float((c), -9.0) && allOk;
	allOk = compare_ivec4((d), ivec4(5, 4, 8, 2)) && allOk;
	allOk = compare_ivec3((f), ivec3(1, -2, -3)) && allOk;
	allOk = compare_ivec4((blockE[0].g), ivec4(-8, 1, -8, 7)) && allOk;
	allOk = compare_vec3((blockE[0].h), vec3(7.0, 9.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockE[1].g), ivec4(-1, -7, 0, 3)) && allOk;
	allOk = compare_vec3((blockE[1].h), vec3(-1.0, 8.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, true, false, true));
	c = (1.0);
	d = (ivec4(-6, 9, 4, 7));
	e = (bvec3(false, false, false));
}
#version 450
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
};
struct sB
{
	sA mA;
	highp uvec4 mB;
};
struct sC
{
	mediump uvec4 mA;
};
struct sD
{
	lowp mat3 mA;
	bvec2 mB;
	mediump mat4 mC;
};
struct sE
{
	highp mat3x4 mA;
};
struct sF
{
	lowp int mA;
	bvec4 mB;
	sD mC;
	sE mD;
};
struct sG
{
	mediump ivec3 mA;
};
layout(scalar, binding = 1) buffer BlockB
{
	bvec2 a[];
};
layout(scalar, binding = 2) buffer BlockC
{
	lowp mat2x3 b;
	sB c;
	mediump ivec4 d;
	lowp mat4 e;
	sC f;
} blockC[2];
layout(scalar, row_major, binding = 3) buffer BlockD
{
	mediump vec4 g;
	highp int h;
	highp vec3 i;
	mediump ivec3 j;
	sF k[];
} blockD;
layout(scalar, row_major, binding = 4) buffer BlockE
{
	mediump mat4 l;
	mediump uvec4 m[3];
	highp mat4 n;
	sG o[];
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((a[0]), bvec2(true, false)) && allOk;
	allOk = compare_vec4((blockC[0].c.mA.mA), vec4(6.0, -2.0, -6.0, 4.0)) && allOk;
	allOk = compare_uvec4((blockC[0].c.mB), uvec4(6u, 4u, 2u, 2u)) && allOk;
	allOk = compare_mat4(blockC[0].e, mat4(5.0, 2.0, -9.0, 0.0, -5.0, 0.0, 1.0, -8.0, 0.0, 3.0, -5.0, 5.0, -7.0, 1.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC[1].c.mA.mA), vec4(-8.0, 3.0, 3.0, 8.0)) && allOk;
	allOk = compare_uvec4((blockC[1].c.mB), uvec4(9u, 2u, 6u, 1u)) && allOk;
	allOk = compare_mat4(blockC[1].e, mat4(9.0, 9.0, 5.0, -2.0, 4.0, 0.0, -7.0, -8.0, 2.0, 4.0, 7.0, -9.0, -3.0, 0.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec4((blockD.g), vec4(1.0, -5.0, 6.0, -8.0)) && allOk;
	allOk = compare_int((blockD.k[0].mA), -1) && allOk;
	allOk = compare_bvec4((blockD.k[0].mB), bvec4(true, true, false, false)) && allOk;
	allOk = compare_mat3(blockD.k[0].mC.mA, mat3(8.0, -7.0, 7.0, 6.0, 7.0, -3.0, -3.0, -9.0, -3.0)) && allOk;
	allOk = compare_bvec2((blockD.k[0].mC.mB), bvec2(true, false)) && allOk;
	allOk = compare_mat4(blockD.k[0].mC.mC, mat4(3.0, -7.0, 3.0, 9.0, 9.0, 9.0, -9.0, 5.0, -5.0, -5.0, 7.0, 3.0, -4.0, -9.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockD.k[0].mD.mA, mat3x4(-5.0, -2.0, 8.0, 4.0, 9.0, -2.0, 9.0, 6.0, -8.0, 7.0, -3.0, -6.0)) && allOk;
	allOk = compare_int((blockD.k[1].mA), -6) && allOk;
	allOk = compare_bvec4((blockD.k[1].mB), bvec4(false, true, false, false)) && allOk;
	allOk = compare_mat3(blockD.k[1].mC.mA, mat3(2.0, -8.0, -6.0, 4.0, 4.0, 3.0, -4.0, 1.0, -5.0)) && allOk;
	allOk = compare_bvec2((blockD.k[1].mC.mB), bvec2(false, true)) && allOk;
	allOk = compare_mat4(blockD.k[1].mC.mC, mat4(-9.0, -3.0, -2.0, -5.0, 4.0, 8.0, 3.0, 6.0, 7.0, -5.0, -7.0, 2.0, -3.0, 9.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockD.k[1].mD.mA, mat3x4(8.0, 8.0, 1.0, -9.0, -6.0, 9.0, -4.0, 9.0, 9.0, 9.0, -5.0, 8.0)) && allOk;
	allOk = compare_int((blockD.k[2].mA), 2) && allOk;
	allOk = compare_bvec4((blockD.k[2].mB), bvec4(true, false, true, false)) && allOk;
	allOk = compare_mat3(blockD.k[2].mC.mA, mat3(2.0, -4.0, 4.0, -4.0, 7.0, -1.0, 2.0, -7.0, -2.0)) && allOk;
	allOk = compare_bvec2((blockD.k[2].mC.mB), bvec2(true, true)) && allOk;
	allOk = compare_mat4(blockD.k[2].mC.mC, mat4(7.0, -4.0, 3.0, 9.0, -2.0, -8.0, 0.0, 7.0, -8.0, -6.0, 6.0, 5.0, 6.0, 2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockD.k[2].mD.mA, mat3x4(7.0, -9.0, -2.0, -4.0, 5.0, -5.0, -2.0, 7.0, -9.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_uvec4((blockE[0].m[0]), uvec4(7u, 6u, 7u, 8u)) && allOk;
	allOk = compare_uvec4((blockE[0].m[1]), uvec4(6u, 7u, 0u, 4u)) && allOk;
	allOk = compare_uvec4((blockE[0].m[2]), uvec4(4u, 2u, 9u, 7u)) && allOk;
	allOk = compare_mat4(blockE[0].n, mat4(-3.0, 0.0, -7.0, -3.0, 0.0, -8.0, 5.0, 2.0, -1.0, 0.0, -6.0, -7.0, 9.0, -1.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (bvec2(true, false));
	blockC[0].b = (mat2x3(-9.0, -8.0, 0.0, 8.0, 0.0, 8.0));
	blockC[0].e = (mat4(-2.0, 4.0, -6.0, 5.0, -4.0, 9.0, 1.0, 4.0, -5.0, 8.0, -5.0, 4.0, -9.0, -1.0, -6.0, 9.0));
	blockC[0].f.mA = (uvec4(3u, 3u, 7u, 4u));
	blockC[1].b = (mat2x3(-2.0, 3.0, 1.0, -6.0, -2.0, 5.0));
	blockC[1].e = (mat4(7.0, -3.0, -5.0, 8.0, 2.0, 2.0, -2.0, -1.0, 4.0, -3.0, -1.0, -2.0, 2.0, -3.0, -1.0, -6.0));
	blockC[1].f.mA = (uvec4(2u, 1u, 2u, 1u));
	blockD.g = (vec4(7.0, -3.0, -2.0, -3.0));
	blockD.h = (0);
	blockD.i = (vec3(7.0, 3.0, -1.0));
	blockD.j = (ivec3(-9, 0, 3));
	blockD.k[0].mA = (-4);
	blockD.k[0].mB = (bvec4(true, true, false, true));
	blockD.k[0].mC.mA = (mat3(1.0, -4.0, 3.0, 4.0, -9.0, 8.0, 7.0, -5.0, -5.0));
	blockD.k[0].mC.mB = (bvec2(false, true));
	blockD.k[0].mC.mC = (mat4(8.0, 7.0, -3.0, -3.0, 4.0, -2.0, -2.0, -5.0, 6.0, -8.0, -7.0, -6.0, 0.0, 3.0, -2.0, -8.0));
	blockD.k[0].mD.mA = (mat3x4(-6.0, -4.0, -5.0, 7.0, 8.0, -9.0, -5.0, -6.0, -5.0, 8.0, -2.0, -3.0));
	blockD.k[1].mA = (-5);
	blockD.k[1].mB = (bvec4(false, true, false, true));
	blockD.k[1].mC.mA = (mat3(5.0, -7.0, 1.0, 7.0, 2.0, -4.0, -3.0, -8.0, -1.0));
	blockD.k[1].mC.mB = (bvec2(true, false));
	blockD.k[1].mC.mC = (mat4(7.0, 0.0, 4.0, -2.0, 5.0, -8.0, -3.0, 8.0, 9.0, -1.0, -3.0, 9.0, -6.0, -7.0, -4.0, 2.0));
	blockD.k[1].mD.mA = (mat3x4(-1.0, -8.0, 6.0, -7.0, -6.0, 7.0, 9.0, 5.0, -8.0, 0.0, -3.0, 4.0));
	blockD.k[2].mA = (0);
	blockD.k[2].mB = (bvec4(false, true, false, true));
	blockD.k[2].mC.mA = (mat3(2.0, 8.0, 7.0, -3.0, -4.0, 1.0, 5.0, -7.0, -6.0));
	blockD.k[2].mC.mB = (bvec2(false, true));
	blockD.k[2].mC.mC = (mat4(-3.0, -7.0, 5.0, 7.0, 7.0, -9.0, 5.0, -4.0, 9.0, 7.0, -2.0, 8.0, 5.0, 3.0, 5.0, -4.0));
	blockD.k[2].mD.mA = (mat3x4(-1.0, 9.0, 8.0, -2.0, 1.0, 5.0, 9.0, -9.0, -6.0, 3.0, 7.0, 9.0));
	blockE[0].m[0] = (uvec4(9u, 4u, 1u, 4u));
	blockE[0].m[1] = (uvec4(8u, 8u, 8u, 0u));
	blockE[0].m[2] = (uvec4(4u, 8u, 7u, 0u));
	blockE[0].n = (mat4(7.0, 0.0, 9.0, -5.0, 2.0, 1.0, 5.0, 4.0, -8.0, 0.0, 7.0, -9.0, -5.0, 1.0, 6.0, 0.0));
	blockE[0].o[0].mA = (ivec3(-6, 9, -4));
	blockE[0].o[1].mA = (ivec3(8, -3, -4));
	blockE[0].o[2].mA = (ivec3(9, 0, -7));
	blockE[0].o[3].mA = (ivec3(-3, 4, 0));
	blockE[0].o[4].mA = (ivec3(3, -5, 4));
	blockE[0].o[5].mA = (ivec3(2, 7, 2));
	blockE[0].o[6].mA = (ivec3(-5, 8, -1));
}
#version 450
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
	lowp int a;
	lowp vec2 b;
	mediump mat3x4 c[][6];
};
layout(scalar, binding = 2) readonly buffer BlockC
{
	lowp float d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((a), 0) && allOk;
	allOk = compare_mat3x4(c[0][0], mat3x4(-7.0, -2.0, -8.0, -8.0, -1.0, 7.0, -3.0, 7.0, -7.0, -5.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat3x4(c[0][1], mat3x4(-6.0, 6.0, -1.0, -9.0, 1.0, -3.0, -8.0, 5.0, 3.0, -4.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(c[0][2], mat3x4(-7.0, -7.0, -5.0, 5.0, 5.0, 8.0, 6.0, 6.0, 2.0, 5.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(c[0][3], mat3x4(-6.0, 8.0, -6.0, -8.0, -1.0, -4.0, -9.0, 0.0, 6.0, 1.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(c[0][4], mat3x4(5.0, -5.0, 1.0, -8.0, 4.0, 1.0, 3.0, -5.0, 1.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(c[0][5], mat3x4(-5.0, -1.0, -6.0, -3.0, 4.0, 3.0, 3.0, -5.0, 3.0, -5.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3x4(c[1][0], mat3x4(0.0, -4.0, -7.0, -6.0, 4.0, -9.0, 8.0, 6.0, -3.0, 5.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(c[1][1], mat3x4(-5.0, 5.0, -1.0, -1.0, 4.0, -9.0, 0.0, 0.0, 1.0, 6.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(c[1][2], mat3x4(4.0, -6.0, 4.0, 6.0, -8.0, -8.0, 5.0, 6.0, 6.0, 2.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3x4(c[1][3], mat3x4(-6.0, 8.0, 8.0, -2.0, 4.0, -1.0, -1.0, -2.0, -9.0, -5.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(c[1][4], mat3x4(8.0, -4.0, -3.0, 1.0, -9.0, 7.0, -6.0, 8.0, 4.0, 2.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x4(c[1][5], mat3x4(-3.0, 5.0, 0.0, -2.0, -1.0, 1.0, -7.0, -1.0, -7.0, -4.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(c[2][0], mat3x4(1.0, 4.0, -4.0, -7.0, -4.0, 2.0, -4.0, 2.0, 3.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(c[2][1], mat3x4(5.0, 1.0, -6.0, 0.0, -1.0, 8.0, 3.0, 6.0, 4.0, -8.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(c[2][2], mat3x4(-9.0, -6.0, 6.0, 5.0, 7.0, -7.0, -9.0, -9.0, 2.0, -1.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(c[2][3], mat3x4(-8.0, -8.0, -2.0, 3.0, -3.0, 1.0, -2.0, -4.0, 2.0, 2.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(c[2][4], mat3x4(3.0, 7.0, -2.0, 8.0, -9.0, -1.0, -8.0, -5.0, -1.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(c[2][5], mat3x4(0.0, 4.0, 8.0, -5.0, -2.0, 0.0, 7.0, 5.0, -2.0, 3.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(c[3][0], mat3x4(-1.0, -5.0, 9.0, 3.0, 0.0, -9.0, 8.0, 1.0, 9.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(c[3][1], mat3x4(6.0, -6.0, -8.0, 1.0, -5.0, 1.0, 8.0, 3.0, -6.0, -9.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(c[3][2], mat3x4(2.0, 2.0, -6.0, 4.0, 8.0, -3.0, 9.0, 4.0, -7.0, 0.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(c[3][3], mat3x4(-1.0, -2.0, 2.0, -7.0, -4.0, 0.0, 3.0, 9.0, -7.0, -4.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x4(c[3][4], mat3x4(-4.0, -2.0, -6.0, -4.0, 3.0, 1.0, 3.0, -9.0, 4.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(c[3][5], mat3x4(-9.0, -7.0, 5.0, -6.0, -7.0, 5.0, 1.0, -5.0, 4.0, 7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(c[4][0], mat3x4(-3.0, 1.0, 2.0, 4.0, -6.0, 9.0, 1.0, 0.0, 0.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat3x4(c[4][1], mat3x4(9.0, 9.0, 4.0, 4.0, -9.0, -5.0, -8.0, -8.0, 5.0, -8.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(c[4][2], mat3x4(7.0, -7.0, -7.0, -3.0, -1.0, 8.0, -2.0, -6.0, -9.0, -6.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(c[4][3], mat3x4(0.0, 3.0, 7.0, -2.0, -3.0, 8.0, 7.0, -1.0, -3.0, 2.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(c[4][4], mat3x4(-6.0, 3.0, 5.0, -9.0, 4.0, 5.0, -9.0, -1.0, 1.0, -8.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(c[4][5], mat3x4(4.0, -9.0, -1.0, -2.0, 9.0, 8.0, 7.0, -8.0, -9.0, 0.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x4(c[5][0], mat3x4(1.0, 2.0, 6.0, 7.0, 2.0, 5.0, -1.0, -8.0, -7.0, 3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(c[5][1], mat3x4(9.0, -8.0, -2.0, 8.0, 4.0, -1.0, -6.0, 9.0, -2.0, -8.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(c[5][2], mat3x4(9.0, 0.0, 4.0, 5.0, 9.0, 8.0, 8.0, -8.0, 5.0, 3.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(c[5][3], mat3x4(-6.0, -1.0, 8.0, -1.0, 4.0, -7.0, 3.0, -9.0, 7.0, 5.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x4(c[5][4], mat3x4(-3.0, 5.0, 9.0, -1.0, 1.0, -8.0, 9.0, 4.0, -3.0, 1.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(c[5][5], mat3x4(-1.0, -6.0, -3.0, 8.0, -7.0, -4.0, 4.0, -9.0, -3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(c[6][0], mat3x4(4.0, 9.0, 0.0, -8.0, 2.0, 9.0, -9.0, 0.0, -1.0, 6.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(c[6][1], mat3x4(-6.0, 6.0, 3.0, 6.0, 6.0, 2.0, 8.0, -4.0, -4.0, 6.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(c[6][2], mat3x4(-9.0, -8.0, -1.0, 6.0, 2.0, 4.0, 8.0, -2.0, 2.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3x4(c[6][3], mat3x4(-9.0, 3.0, 4.0, 5.0, -9.0, 0.0, 4.0, 5.0, 6.0, 4.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(c[6][4], mat3x4(-5.0, 5.0, 2.0, 8.0, 9.0, 1.0, -9.0, 9.0, -6.0, -5.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(c[6][5], mat3x4(6.0, 7.0, -9.0, -5.0, 2.0, 7.0, 0.0, -1.0, 5.0, 8.0, 6.0, 5.0)) && allOk;
	allOk = compare_float((d), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (9);
	b = (vec2(-5.0, 0.0));
}
#version 450
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
	lowp float a;
	int16_t b;
	lowp float c;
	highp uint d[1];
	uint16_t e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(b), 4) && allOk;
	allOk = compare_float((c), -4.0) && allOk;
	allOk = compare_uint((d[0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(e), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (-5.0);
	b = int16_t(4);
	c = (-9.0);
	d[0] = (0u);
	e = uint16_t(7u);
}
#version 450
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
	i16vec3 c;
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	i16vec2 d;
	lowp vec4 e;
	u16vec2 f;
	lowp uint g;
	bool h;
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	i16vec4 i;
	i16vec3 j;
	lowp mat4 k;
	f16vec4 l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -2.0) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.c), ivec3(-2, -3, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(d), ivec2(-6, 9)) && allOk;
	allOk = compare_vec4((e), vec4(-2.0, 5.0, -6.0, -3.0)) && allOk;
	allOk = compare_uint((g), 1u) && allOk;
	allOk = compare_bool((h), false) && allOk;
	allOk = compare_i16vec4(ivec4(i), ivec4(4, 8, 8, 0)) && allOk;
	allOk = compare_f16vec4(vec4(l), vec4(0.0, 1.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4x2(3.0, -1.0, -9.0, 9.0, -7.0, -4.0, -4.0, -4.0));
	d = i16vec2(ivec2(0, -7));
	g = (8u);
	i = i16vec4(ivec4(9, 4, 1, -8));
}
#version 450
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
	mediump uvec3 a[];
} blockB[2];

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

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

layout(std140, binding = 1) buffer BlockB
{
	f16vec3 a[1];
	mediump mat2 b;
	bool c[];
};
layout(std140, binding = 2) buffer BlockC
{
	bvec3 d;
	i16vec3 e;
	bvec3 f;
	mediump mat2 g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(b, mat2(7.0, 2.0, -1.0, 4.0)) && allOk;
	allOk = compare_bool((c[0]), true) && allOk;
	allOk = compare_bvec3((d), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((f), bvec3(false, false, false)) && allOk;
	allOk = compare_mat2(g[0], mat2(-4.0, -4.0, -3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat2(-2.0, 9.0, -6.0, 1.0));
	c[0] = (true);
	d = (bvec3(false, false, true));
	f = (bvec3(false, true, true));
	g[0] = (mat2(-4.0, 1.0, -6.0, 2.0));
}
#version 450
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
	lowp mat3 a;
	mediump float b[2];
	u16vec4 c;
	bool d[];
} blockB[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[0].b[0]), 7.0) && allOk;
	allOk = compare_float((blockB[0].b[1]), 5.0) && allOk;
	allOk = compare_bool((blockB[0].d[0]), false) && allOk;
	allOk = compare_bool((blockB[0].d[1]), true) && allOk;
	allOk = compare_bool((blockB[0].d[2]), true) && allOk;
	allOk = compare_float((blockB[1].b[0]), -5.0) && allOk;
	allOk = compare_float((blockB[1].b[1]), -9.0) && allOk;
	allOk = compare_bool((blockB[1].d[0]), true) && allOk;
	allOk = compare_bool((blockB[1].d[1]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (5.0);
	blockB[0].b[1] = (-3.0);
	blockB[0].c = u16vec4(uvec4(1u, 9u, 0u, 9u));
	blockB[0].d[0] = (true);
	blockB[0].d[1] = (false);
	blockB[0].d[2] = (true);
	blockB[1].b[0] = (-1.0);
	blockB[1].b[1] = (-5.0);
	blockB[1].c = u16vec4(uvec4(0u, 4u, 3u, 9u));
	blockB[1].d[0] = (false);
	blockB[1].d[1] = (false);
}
#version 450
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
	highp mat4x2 mB;
};
layout(std140, binding = 1) buffer BlockB
{
	lowp mat2x3 a;
	mediump mat2x3 b;
	highp mat3x4 c;
	int16_t d[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	bvec2 e;
	sA f;
	lowp float g[];
};
layout(std430, binding = 3) readonly buffer BlockD
{
	i16vec3 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(-8.0, -8.0, 0.0, -9.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockB.b, mat2x3(-4.0, 0.0, -2.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockB.c, mat3x4(1.0, -6.0, 9.0, 8.0, 3.0, 7.0, 5.0, -6.0, 5.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_int16_t(int(blockB.d[0]), -1) && allOk;
	allOk = compare_bool((f.mA), false) && allOk;
	allOk = compare_mat4x2(f.mB, mat4x2(-6.0, -7.0, 8.0, -2.0, -7.0, 2.0, -4.0, 7.0)) && allOk;
	allOk = compare_float((g[0]), 8.0) && allOk;
	allOk = compare_float((g[1]), -1.0) && allOk;
	allOk = compare_float((g[2]), 5.0) && allOk;
	allOk = compare_float((g[3]), 9.0) && allOk;
	allOk = compare_float((g[4]), -1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(-2.0, -9.0, -3.0, -1.0, -2.0, 7.0));
	blockB.b = (mat2x3(-7.0, -6.0, -5.0, -9.0, 4.0, -6.0));
	e = (bvec2(false, false));
	f.mA = (false);
	f.mB = (mat4x2(-8.0, 0.0, -2.0, 7.0, -6.0, -1.0, -3.0, -5.0));
	g[0] = (-8.0);
	g[1] = (9.0);
	g[2] = (7.0);
	g[3] = (-9.0);
	g[4] = (-8.0);
}
#version 450
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
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	lowp vec4 a[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	sA b;
	mediump mat3x4 c[7][3];
	lowp uint d;
	f16vec2 e[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	lowp mat3x4 f;
	uint16_t g;
	uint16_t h;
	lowp uvec4 i[];
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a[0]), vec4(-1.0, 5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3x2(b.mA, mat3x2(5.0, -8.0, 2.0, -9.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(c[0][0], mat3x4(-7.0, 4.0, 0.0, -1.0, 3.0, -2.0, 8.0, -8.0, -2.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3x4(c[0][1], mat3x4(-2.0, 0.0, -2.0, -9.0, -5.0, 1.0, -3.0, 3.0, 7.0, 2.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(c[0][2], mat3x4(1.0, 2.0, -3.0, 7.0, -4.0, -5.0, 3.0, -5.0, 3.0, -4.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(c[1][0], mat3x4(-7.0, -6.0, 0.0, -4.0, 4.0, 5.0, -8.0, -1.0, 6.0, -2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat3x4(c[1][1], mat3x4(-1.0, -8.0, 8.0, 3.0, -7.0, -9.0, -1.0, 2.0, 9.0, 7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(c[1][2], mat3x4(9.0, 5.0, -2.0, 3.0, 9.0, 6.0, 0.0, -1.0, 4.0, -3.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(c[2][0], mat3x4(5.0, -9.0, -4.0, -4.0, -2.0, 3.0, -2.0, 3.0, 8.0, 2.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(c[2][1], mat3x4(3.0, 8.0, 8.0, 0.0, -4.0, 1.0, 7.0, 9.0, -5.0, 8.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(c[2][2], mat3x4(-4.0, 1.0, 3.0, -8.0, 5.0, 7.0, -3.0, 5.0, 1.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(c[3][0], mat3x4(-5.0, 9.0, 1.0, -5.0, -9.0, -3.0, -3.0, 4.0, 2.0, 8.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x4(c[3][1], mat3x4(-8.0, -3.0, 9.0, 0.0, 0.0, -5.0, -9.0, 9.0, 8.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(c[3][2], mat3x4(-4.0, -2.0, -2.0, -3.0, -9.0, 2.0, -1.0, -4.0, 0.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3x4(c[4][0], mat3x4(-9.0, -4.0, 8.0, 9.0, 9.0, -7.0, 1.0, -8.0, 6.0, -7.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x4(c[4][1], mat3x4(-5.0, -7.0, 0.0, 1.0, -4.0, 3.0, -4.0, -7.0, 1.0, -8.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(c[4][2], mat3x4(4.0, 0.0, -7.0, 6.0, 6.0, 3.0, 1.0, -8.0, 6.0, 4.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(c[5][0], mat3x4(2.0, -1.0, 5.0, 4.0, -1.0, 8.0, -4.0, 3.0, 0.0, -1.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(c[5][1], mat3x4(-6.0, 2.0, 0.0, 6.0, 6.0, -7.0, 6.0, 0.0, 4.0, -1.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(c[5][2], mat3x4(-1.0, 1.0, -2.0, 5.0, 6.0, -2.0, -8.0, -3.0, 8.0, 3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3x4(c[6][0], mat3x4(-5.0, 6.0, 1.0, -3.0, -2.0, -9.0, -4.0, -6.0, -1.0, 3.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x4(c[6][1], mat3x4(-8.0, -9.0, -4.0, -7.0, 8.0, -8.0, 4.0, 9.0, -4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(c[6][2], mat3x4(8.0, 7.0, 5.0, 0.0, -8.0, 4.0, 8.0, -2.0, -9.0, -4.0, 0.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(e[0]), vec2(9.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(e[1]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].f, mat3x4(-1.0, -5.0, -4.0, -8.0, 9.0, 2.0, -3.0, 4.0, -1.0, -4.0, 9.0, 6.0)) && allOk;
	allOk = compare_uvec4((blockD[0].i[0]), uvec4(1u, 7u, 4u, 2u)) && allOk;
	allOk = compare_uvec4((blockD[0].i[1]), uvec4(9u, 9u, 4u, 4u)) && allOk;
	allOk = compare_uvec4((blockD[0].i[2]), uvec4(0u, 7u, 4u, 4u)) && allOk;
	allOk = compare_uvec4((blockD[0].i[3]), uvec4(8u, 1u, 0u, 8u)) && allOk;
	allOk = compare_uvec4((blockD[0].i[4]), uvec4(0u, 1u, 2u, 9u)) && allOk;
	allOk = compare_uvec4((blockD[0].i[5]), uvec4(5u, 7u, 4u, 5u)) && allOk;
	allOk = compare_uvec4((blockD[0].i[6]), uvec4(6u, 3u, 7u, 9u)) && allOk;
	allOk = compare_uvec4((blockD[0].i[7]), uvec4(9u, 3u, 7u, 7u)) && allOk;
	allOk = compare_mat3x4(blockD[1].f, mat3x4(0.0, 9.0, -7.0, 1.0, 7.0, -6.0, -6.0, 4.0, 1.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_uvec4((blockD[1].i[0]), uvec4(2u, 6u, 2u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec4(0.0, -7.0, 3.0, 9.0));
	b.mA = (mat3x2(-1.0, 3.0, -7.0, -7.0, 6.0, 0.0));
	c[0][0] = (mat3x4(6.0, -9.0, -2.0, -5.0, -3.0, -5.0, -1.0, 9.0, 3.0, -2.0, -6.0, -4.0));
	c[0][1] = (mat3x4(-4.0, 8.0, -4.0, -8.0, 9.0, 2.0, -7.0, -3.0, 6.0, 3.0, 2.0, 3.0));
	c[0][2] = (mat3x4(6.0, 8.0, 5.0, -5.0, -8.0, -3.0, -8.0, 6.0, -1.0, -5.0, -7.0, 0.0));
	c[1][0] = (mat3x4(5.0, -9.0, -3.0, -1.0, 0.0, -3.0, 0.0, -4.0, -8.0, -2.0, 2.0, -6.0));
	c[1][1] = (mat3x4(3.0, -6.0, 8.0, -7.0, 4.0, -3.0, 2.0, 0.0, 0.0, -3.0, 0.0, -2.0));
	c[1][2] = (mat3x4(3.0, 6.0, -9.0, -1.0, 0.0, -6.0, -7.0, -4.0, 3.0, -4.0, -4.0, 5.0));
	c[2][0] = (mat3x4(-6.0, 0.0, 0.0, 9.0, -2.0, -3.0, 1.0, -9.0, -6.0, -8.0, 9.0, -4.0));
	c[2][1] = (mat3x4(0.0, 6.0, 4.0, 7.0, -5.0, 9.0, 1.0, 5.0, -2.0, -4.0, 9.0, 7.0));
	c[2][2] = (mat3x4(3.0, 8.0, 7.0, 7.0, 3.0, 9.0, 8.0, 7.0, 0.0, 6.0, 5.0, -7.0));
	c[3][0] = (mat3x4(6.0, 1.0, -5.0, -8.0, 6.0, -5.0, -1.0, -2.0, 0.0, 5.0, 2.0, -9.0));
	c[3][1] = (mat3x4(5.0, 7.0, -4.0, -5.0, 3.0, -3.0, -6.0, -1.0, -1.0, 1.0, 1.0, 1.0));
	c[3][2] = (mat3x4(-2.0, 9.0, -4.0, -7.0, -7.0, -1.0, 4.0, 1.0, 2.0, 7.0, -7.0, 4.0));
	c[4][0] = (mat3x4(-6.0, 7.0, -3.0, -5.0, 6.0, 9.0, -8.0, -5.0, 3.0, -6.0, -7.0, 6.0));
	c[4][1] = (mat3x4(6.0, -4.0, 5.0, -3.0, -8.0, -7.0, 2.0, -4.0, -1.0, -2.0, 7.0, 6.0));
	c[4][2] = (mat3x4(3.0, 3.0, 1.0, -1.0, 8.0, 4.0, 5.0, -3.0, 6.0, -9.0, 1.0, 3.0));
	c[5][0] = (mat3x4(-3.0, -3.0, 4.0, 5.0, 2.0, 4.0, -6.0, -8.0, -2.0, -7.0, -7.0, 3.0));
	c[5][1] = (mat3x4(8.0, 7.0, 6.0, 6.0, -5.0, -4.0, 9.0, -4.0, 6.0, 4.0, -7.0, -6.0));
	c[5][2] = (mat3x4(0.0, 4.0, -6.0, -6.0, -2.0, -2.0, 7.0, 7.0, 9.0, 5.0, -1.0, -6.0));
	c[6][0] = (mat3x4(-6.0, -3.0, 7.0, 0.0, 1.0, 1.0, 6.0, -7.0, -3.0, -2.0, -1.0, 3.0));
	c[6][1] = (mat3x4(7.0, 5.0, -6.0, 5.0, 1.0, -1.0, -3.0, 9.0, -1.0, -5.0, -5.0, 2.0));
	c[6][2] = (mat3x4(8.0, 4.0, 6.0, 8.0, 6.0, 5.0, -7.0, 5.0, 0.0, 7.0, -1.0, 5.0));
	e[0] = f16vec2(vec2(9.0, -6.0));
	e[1] = f16vec2(vec2(5.0, 2.0));
	blockD[0].f = (mat3x4(6.0, -1.0, 6.0, -7.0, 4.0, 7.0, -9.0, 6.0, -6.0, -2.0, -5.0, -4.0));
	blockD[0].g = uint16_t(3u);
	blockD[0].h = uint16_t(8u);
	blockD[0].i[0] = (uvec4(7u, 4u, 6u, 5u));
	blockD[0].i[1] = (uvec4(3u, 4u, 6u, 4u));
	blockD[0].i[2] = (uvec4(5u, 3u, 8u, 8u));
	blockD[0].i[3] = (uvec4(5u, 8u, 7u, 4u));
	blockD[0].i[4] = (uvec4(1u, 8u, 0u, 2u));
	blockD[0].i[5] = (uvec4(6u, 2u, 3u, 0u));
	blockD[0].i[6] = (uvec4(5u, 3u, 4u, 1u));
	blockD[0].i[7] = (uvec4(5u, 8u, 4u, 5u));
	blockD[1].f = (mat3x4(9.0, 0.0, 2.0, -7.0, -8.0, 5.0, 3.0, 3.0, 5.0, -5.0, 2.0, 1.0));
	blockD[1].g = uint16_t(8u);
	blockD[1].h = uint16_t(3u);
	blockD[1].i[0] = (uvec4(5u, 7u, 6u, 7u));
}
#version 450
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
	layout(offset = 4) int16_t b;
	layout(offset = 6) i16vec4 c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp uvec3 d;
	layout(offset = 16) i16vec3 e;
	layout(offset = 24) highp uint f[1];
} blockC[1];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp ivec3 g;
	layout(offset = 12) float16_t h;
	layout(offset = 16) i16vec4 i;
	layout(offset = 32) bvec3 j;
	layout(offset = 48) f16vec4 k[1];
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -8.0) && allOk;
	allOk = compare_int16_t(int(blockB.b), 4) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c), ivec4(-4, -9, 0, 6)) && allOk;
	allOk = compare_uvec3((blockC[0].d), uvec3(0u, 5u, 5u)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC[0].e), ivec3(-1, 2, -5)) && allOk;
	allOk = compare_uint((blockC[0].f[0]), 6u) && allOk;
	allOk = compare_float16_t(float(blockD[0].h), 9.0) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[0].i), ivec4(-2, 6, 8, 0)) && allOk;
	allOk = compare_bvec3((blockD[0].j), bvec3(false, true, false)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[0].k[0]), vec4(2.0, 1.0, 3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-9.0);
	blockB.b = int16_t(-9);
	blockB.c = i16vec4(ivec4(8, -8, -4, 0));
	blockC[0].d = (uvec3(9u, 7u, 1u));
	blockC[0].e = i16vec3(ivec3(7, 4, 3));
	blockC[0].f[0] = (5u);
	blockD[0].g = (ivec3(0, 7, -1));
	blockD[0].h = float16_t(-7.0);
	blockD[0].i = i16vec4(ivec4(-8, 6, -8, -5));
	blockD[0].j = (bvec3(true, false, false));
	blockD[0].k[0] = f16vec4(vec4(-8.0, 8.0, -2.0, 4.0));
}
#version 450
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
	i16vec2 mA;
	i16vec4 mB;
	float16_t mC;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	mediump ivec2 a;
	f16vec4 b;
	sA c;
	lowp ivec4 d[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(-4, -3));
	blockB.b = f16vec4(vec4(-2.0, 6.0, -5.0, 6.0));
	blockB.c.mA = i16vec2(ivec2(-3, -4));
	blockB.c.mB = i16vec4(ivec4(-4, -2, -2, 1));
	blockB.c.mC = float16_t(-4.0);
}
#version 450
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
	mediump mat3x2 a;
	mediump ivec3 b;
	u16vec4 c[1];
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB[nonuniformEXT(0)].b), ivec3(5, -4, 9)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(0)].c[0]), uvec4(0u, 3u, 5u, 6u)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(1)].b), ivec3(-4, 2, -4)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(1)].c[0]), uvec4(8u, 9u, 8u, 8u)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(2)].b), ivec3(3, 0, 3)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(2)].c[0]), uvec4(0u, 2u, 0u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat3x2(-1.0, 1.0, -1.0, 8.0, 9.0, -4.0));
	blockB[nonuniformEXT(0)].b = (ivec3(-2, 9, -9));
	blockB[nonuniformEXT(0)].c[0] = u16vec4(uvec4(1u, 1u, 0u, 2u));
	blockB[nonuniformEXT(1)].a = (mat3x2(-3.0, 2.0, 4.0, 5.0, 8.0, 2.0));
	blockB[nonuniformEXT(1)].b = (ivec3(-6, 4, -5));
	blockB[nonuniformEXT(1)].c[0] = u16vec4(uvec4(1u, 7u, 1u, 1u));
	blockB[nonuniformEXT(2)].a = (mat3x2(-8.0, 8.0, -9.0, 1.0, 1.0, 7.0));
	blockB[nonuniformEXT(2)].b = (ivec3(4, 5, 4));
	blockB[nonuniformEXT(2)].c[0] = u16vec4(uvec4(5u, 0u, 4u, 0u));
}
#version 450
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
	highp int a[1];
	mediump float b;
	highp float c;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	uint8_t d;
	uint8_t e;
	lowp float f;
	mediump float g[1];
	uint8_t h;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), -6.0) && allOk;
	allOk = compare_float((blockB.c), -5.0) && allOk;
	allOk = compare_uint8_t(uint(blockC.e), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (9);
	blockB.b = (7.0);
	blockB.c = (5.0);
	blockC.d = uint8_t(7u);
	blockC.f = (-6.0);
	blockC.g[0] = (1.0);
	blockC.h = uint8_t(7u);
}
#version 450
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
	lowp mat4x2 mB;
};
struct sB
{
	highp ivec2 mA;
};
layout(std430, binding = 1) buffer BlockB
{
	lowp uvec3 a;
	highp uvec2 b;
	highp ivec3 c;
	highp vec2 d;
	u8vec2 e;
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	sA f;
	highp mat3 g;
	i8vec2 h[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	sB i;
	int8_t j;
	mediump mat2 k[];
};
layout(std430, column_major, binding = 4) readonly buffer BlockE
{
	mediump mat2x3 l[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(8u, 0u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(0u, 2u)) && allOk;
	allOk = compare_ivec3((blockB.c), ivec3(5, -6, 1)) && allOk;
	allOk = compare_mat3(blockC.g, mat3(-4.0, 3.0, -5.0, -3.0, -1.0, 1.0, 0.0, -3.0, 1.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.h[0]), ivec2(3, 4294967287)) && allOk;
	allOk = compare_ivec2((i.mA), ivec2(-4, 3)) && allOk;
	allOk = compare_int8_t(int(j), 9) && allOk;
	allOk = compare_mat2(k[0], mat2(1.0, 3.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockE.l[0], mat2x3(9.0, -7.0, -8.0, 1.0, 6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec2(6u, 7u));
	blockB.d = (vec2(-8.0, -4.0));
	blockB.e = u8vec2(uvec2(4u, 4u));
	blockC.f.mA = (mat2x3(-2.0, 5.0, -2.0, 6.0, 7.0, -5.0));
	blockC.f.mB = (mat4x2(-5.0, -2.0, -2.0, 7.0, -2.0, 1.0, 3.0, -9.0));
	blockC.g = (mat3(-2.0, -7.0, 9.0, -9.0, 4.0, -1.0, 8.0, 4.0, -4.0));
	blockC.h[0] = i8vec2(ivec2(0, 7));
	i.mA = (ivec2(6, 5));
	j = int8_t(3);
	k[0] = (mat2(3.0, -4.0, -6.0, 4.0));
}
#version 450
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
	mediump vec4 a;
	mediump mat4x2 b;
	highp mat3x2 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(b, mat4x2(3.0, -5.0, -4.0, -5.0, -3.0, -2.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(c[0], mat3x2(-6.0, 9.0, -2.0, 5.0, -6.0, -3.0)) && allOk;
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
	u8vec4 mA;
	lowp int mB;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	sA a;
	int8_t b[];
} blockB[2];

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = u8vec4(uvec4(1u, 5u, 5u, 2u));
	blockB[0].a.mB = (-4);
	blockB[1].a.mA = u8vec4(uvec4(8u, 5u, 8u, 1u));
	blockB[1].a.mB = (5);
}
#version 450
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
	mediump mat4x2 b[5];
	highp vec3 c;
	bvec4 d;
	highp uvec3 e[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	uint8_t f;
	i8vec3 g[];
};
layout(std430, binding = 3) buffer BlockD
{
	highp ivec2 h[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a, mat3x4(6.0, 8.0, 4.0, -9.0, -4.0, 4.0, 0.0, 7.0, 2.0, -8.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[0], mat4x2(-1.0, -5.0, -5.0, 3.0, -8.0, 1.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[1], mat4x2(-5.0, 5.0, -5.0, -4.0, 5.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[2], mat4x2(6.0, -6.0, 5.0, -3.0, 0.0, 4.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[3], mat4x2(-1.0, 6.0, 1.0, -9.0, 3.0, 3.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[4], mat4x2(-3.0, -6.0, 0.0, -4.0, 0.0, 1.0, -3.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(3.0, -3.0, 2.0)) && allOk;
	allOk = compare_uint8_t(uint(f), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat4x2(-6.0, 0.0, -8.0, -3.0, -7.0, 1.0, 0.0, 1.0));
	blockB.b[1] = (mat4x2(-4.0, 2.0, -7.0, -7.0, -3.0, -5.0, -5.0, 5.0));
	blockB.b[2] = (mat4x2(9.0, 9.0, 6.0, 9.0, -5.0, 2.0, -5.0, -6.0));
	blockB.b[3] = (mat4x2(0.0, -5.0, 7.0, 4.0, -1.0, -2.0, -1.0, 3.0));
	blockB.b[4] = (mat4x2(-7.0, -2.0, 6.0, 9.0, -8.0, -3.0, -4.0, 5.0));
	blockB.c = (vec3(-3.0, -2.0, 9.0));
	f = uint8_t(0u);
	g[0] = i8vec3(ivec3(4294967289, 6, 5));
	g[1] = i8vec3(ivec3(1, 2, 4294967290));
	g[2] = i8vec3(ivec3(9, 9, 4294967294));
	g[3] = i8vec3(ivec3(4294967287, 7, 4));
	g[4] = i8vec3(ivec3(0, 8, 1));
	blockD.h[0] = (ivec2(3, 4));
	blockD.h[1] = (ivec2(7, 6));
	blockD.h[2] = (ivec2(2, 9));
	blockD.h[3] = (ivec2(8, -5));
	blockD.h[4] = (ivec2(0, -3));
	blockD.h[5] = (ivec2(7, 0));
	blockD.h[6] = (ivec2(6, -6));
	blockD.h[7] = (ivec2(2, 4));
}
#version 450
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
	layout(offset = 0) bvec2 a;
	layout(offset = 8) bool b[1];
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) u8vec2 c;
	layout(offset = 4) lowp ivec3 d;
	layout(offset = 16) u8vec2 e;
	layout(offset = 18) u8vec4 f;
	layout(offset = 32) mediump ivec3 g;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec2 h[1];
	layout(offset = 16) mediump ivec3 i;
	layout(offset = 28) u8vec3 j;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) int8_t k[1];
	layout(offset = 1) int8_t l;
	layout(offset = 4) mediump vec3 m;
	layout(offset = 16) i8vec2 n;
	layout(offset = 18) i8vec4 o;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.c), uvec2(3u, 7u)) && allOk;
	allOk = compare_ivec3((blockC.d), ivec3(6, 7, -7)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.e), uvec2(4u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.f), uvec4(3u, 6u, 0u, 6u)) && allOk;
	allOk = compare_bvec2((blockD.h[0]), bvec2(true, true)) && allOk;
	allOk = compare_ivec3((blockD.i), ivec3(-2, 0, 8)) && allOk;
	allOk = compare_int8_t(int(blockE.l), 6) && allOk;
	allOk = compare_vec3((blockE.m), vec3(1.0, -7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b[0] = (true);
	blockC.c = u8vec2(uvec2(5u, 7u));
	blockC.d = (ivec3(1, -2, -1));
	blockC.e = u8vec2(uvec2(9u, 2u));
	blockC.g = (ivec3(0, 2, -7));
	blockD.j = u8vec3(uvec3(8u, 8u, 3u));
	blockE.k[0] = int8_t(4294967287);
	blockE.l = int8_t(0);
	blockE.n = i8vec2(ivec2(4294967289, 3));
	blockE.o = i8vec4(ivec4(6, 4294967294, 8, 3));
}
#version 450
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
	layout(offset = 4) lowp uvec2 b;
	layout(offset = 16) highp uvec3 c;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp vec3 d;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp vec3 e;
	layout(offset = 12) u8vec3 f;
	layout(offset = 16) i8vec3 g[1];
	layout(offset = 20) highp ivec2 h;
} blockD[1];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) highp ivec3 i;
	layout(offset = 16) bvec2 j;
	layout(offset = 32) bvec3 k;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((d), vec3(-9.0, 5.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD[0].e), vec3(8.0, 2.0, 8.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[0].f), uvec3(4u, 5u, 3u)) && allOk;
	allOk = compare_ivec3((blockE.i), ivec3(-8, 7, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i8vec2(ivec2(2, 9));
	b = (uvec2(8u, 3u));
	c = (uvec3(2u, 9u, 1u));
	d = (vec3(-7.0, 8.0, 1.0));
	blockD[0].g[0] = i8vec3(ivec3(2, 4294967295, 4294967292));
	blockD[0].h = (ivec2(9, 9));
	blockE.i = (ivec3(-5, 6, 0));
	blockE.j = (bvec2(true, true));
	blockE.k = (bvec3(false, true, false));
}
#version 450
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
	layout(offset = 0) mediump mat3x4 a[1];
	layout(offset = 48) int8_t b;
	layout(offset = 64) mediump mat2x3 c;
	layout(offset = 96) bvec3 d;
	layout(offset = 112) lowp uvec3 e;
} blockB[];

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
#version 450
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
	mediump ivec3 var;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var), ivec3(-9, 4, -3)) && allOk;
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
	highp uvec2 var;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var), uvec2(2u, 8u)) && allOk;
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
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-6.0, 3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-2.0, 9.0)) && allOk;
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(8.0, -6.0, -2.0, 7.0)) && allOk;
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

layout(std140, column_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	allOk = compare_mat2x3(var, mat2x3(-7.0, 2.0, -1.0, 0.0, 6.0, 8.0)) && allOk;
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

}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(-9.0, -8.0, 7.0, 3.0, -2.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
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
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[0][3], -9.0) && allOk;
	allOk = compare_float(var[1][0], 7.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], 5.0) && allOk;
	allOk = compare_float(var[2][0], 3.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], -4.0) && allOk;
	allOk = compare_float(var[2][3], 8.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], -2.0) && allOk;
	allOk = compare_float(var[3][2], -9.0) && allOk;
	allOk = compare_float(var[3][3], -5.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-4.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(7.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(3.0, -6.0, -4.0, 8.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-4.0, -2.0, -9.0, -5.0)) && allOk;
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

}
#version 450
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

layout(std430, binding = 1) readonly buffer Block
{
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(-3.0, -3.0, 1.0, -9.0, 3.0, -3.0, -9.0, -2.0)) && allOk;
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[0][3], 8.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], 2.0) && allOk;
	allOk = compare_float(var[1][3], 2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-3.0, 1.0, -5.0, 8.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(3.0, -9.0, 2.0, 2.0)) && allOk;
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(2.0, -9.0, -3.0, 3.0, -5.0, -2.0)) && allOk;
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
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat4(var, mat4(-4.0, 3.0, -7.0, 3.0, -7.0, -6.0, 6.0, -4.0, 1.0, 8.0, -5.0, 2.0, 3.0, 1.0, 5.0, -8.0)) && allOk;
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(-1.0, 3.0, 5.0, 6.0, 9.0, 7.0)) && allOk;
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(8.0, 4.0, 9.0, -4.0, -1.0, 1.0, 1.0, 3.0)) && allOk;
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[2][0], -5.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[3][0], 4.0) && allOk;
	allOk = compare_float(var[3][1], 1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-5.0, 0.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(4.0, 1.0)) && allOk;
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
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -3.0) && allOk;
	allOk = compare_float(var[3][0], -8.0) && allOk;
	allOk = compare_float(var[3][1], 4.0) && allOk;
	allOk = compare_vec2(var[0], vec2(4.0, -4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(6.0, -6.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(6.0, -3.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-8.0, 4.0)) && allOk;
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
	int16_t padding;
	i16vec3 var;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), 3) && allOk;
	allOk = compare_i16vec3(ivec3(var), ivec3(4, 8, 7)) && allOk;
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
	highp mat3x2 var[3];
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
	u8vec2 var[3];
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(var[0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2]), uvec2(4u, 2u)) && allOk;
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
	int8_t var[3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(var[0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[1]), 3) && allOk;
	allOk = compare_int8_t(int(var[2]), 3) && allOk;
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

}
#version 450
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
	allOk = compare_mat3x4(var[0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
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

}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(0.0, -5.0, 0.0, -1.0, -4.0, 4.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(4.0, 0.0, 2.0, -3.0, -1.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(5.0, 4.0, 9.0, -2.0, -3.0, -4.0, -1.0, -5.0)) && allOk;
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

layout(std140, buffer_reference) buffer Block
{
	mediump vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((block.var), vec3(1.0, 0.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (vec3(6.0, 8.0, -1.0));
}
#version 450
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
    Block block;
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((block.var), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (bvec3(true, true, false));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(-7.0, -9.0, -7.0, -3.0, -8.0, 1.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(3.0, -4.0, -4.0, 3.0, -5.0, 0.0, -8.0, -4.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -1.0) && allOk;
	allOk = compare_float(block.var[0][1], 0.0) && allOk;
	allOk = compare_float(block.var[0][2], 7.0) && allOk;
	allOk = compare_float(block.var[0][3], -6.0) && allOk;
	allOk = compare_float(block.var[1][0], 5.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][2], 0.0) && allOk;
	allOk = compare_float(block.var[1][3], 1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-1.0, 0.0, 7.0, -6.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(5.0, 5.0, 0.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(1.0, -3.0, 7.0, -9.0));
	block.var[1] = (vec4(5.0, 8.0, -8.0, 9.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 4.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[0][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_float(block.var[1][2], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], 7.0) && allOk;
	allOk = compare_float(block.var[2][1], 1.0) && allOk;
	allOk = compare_float(block.var[2][2], -9.0) && allOk;
	allOk = compare_float(block.var[3][0], -6.0) && allOk;
	allOk = compare_float(block.var[3][1], 9.0) && allOk;
	allOk = compare_float(block.var[3][2], -4.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(4.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-5.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(7.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-6.0, 9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(1.0, -9.0, 9.0, 1.0, -8.0, -4.0, -5.0, -7.0, -2.0, -5.0, 4.0, -1.0));
}
#version 450
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
	lowp uint var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.var), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (6u);
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat2x3(block.var, mat2x3(-5.0, 5.0, -3.0, -7.0, 8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var = (mat2x3(1.0, 5.0, -3.0, 1.0, -5.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat2x4(block.var, mat2x4(-3.0, -8.0, 0.0, 2.0, 7.0, -2.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var = (mat2x4(6.0, 2.0, -6.0, 9.0, 7.0, 1.0, -6.0, -3.0));
}
#version 450
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
	u16vec4 var;
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
	allOk = compare_u16vec4(uvec4(block.var), uvec4(0u, 8u, 3u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint16_t(0u);
	block.var = u16vec4(uvec4(6u, 9u, 4u, 5u));
}
#version 450
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
	highp uvec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((block.var[0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[1]), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[2]), uvec3(5u, 0u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (uvec3(3u, 5u, 6u));
	block.var[1] = (uvec3(5u, 4u, 5u));
	block.var[2] = (uvec3(4u, 9u, 4u));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(-3.0, -6.0, 6.0));
	block.var[0][1] = (vec3(1.0, -4.0, -3.0));
	block.var[0][2] = (vec3(-3.0, 3.0, -2.0));
	block.var[0][3] = (vec3(-7.0, 1.0, -5.0));
	block.var[1][0] = (vec3(-1.0, -5.0, 7.0));
	block.var[1][1] = (vec3(1.0, -2.0, -4.0));
	block.var[1][2] = (vec3(-4.0, -6.0, 5.0));
	block.var[1][3] = (vec3(-2.0, 6.0, -9.0));
	block.var[2][0] = (vec3(5.0, -5.0, 7.0));
	block.var[2][1] = (vec3(-4.0, 8.0, -3.0));
	block.var[2][2] = (vec3(-2.0, 0.0, 8.0));
	block.var[2][3] = (vec3(-2.0, 6.0, -3.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	block.var[1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	block.var[2] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat4x3(block.var[0], mat4x3(9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0, 1.0, 9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0][0] = (vec3(-7.0, 2.0, 3.0));
	block.var[0][1] = (vec3(1.0, -2.0, -1.0));
	block.var[0][2] = (vec3(-5.0, -1.0, 9.0));
	block.var[0][3] = (vec3(3.0, -7.0, 8.0));
	block.var[1][0] = (vec3(4.0, 9.0, -6.0));
	block.var[1][1] = (vec3(7.0, 6.0, -5.0));
	block.var[1][2] = (vec3(2.0, 6.0, 3.0));
	block.var[1][3] = (vec3(-4.0, 3.0, 2.0));
	block.var[2][0] = (vec3(-3.0, -3.0, -7.0));
	block.var[2][1] = (vec3(-5.0, 3.0, 4.0));
	block.var[2][2] = (vec3(-4.0, -2.0, 8.0));
	block.var[2][3] = (vec3(7.0, -1.0, -1.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[4], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[5], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[6], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[7], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[8], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[9], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[10], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[11], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[12], mat3x2(-5.0, -1.0, -4.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[13], mat3x2(1.0, -6.0, -3.0, -3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[14], mat3x2(1.0, 7.0, 5.0, -5.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[15], mat3x2(-8.0, -9.0, 7.0, 4.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[16], mat3x2(8.0, -6.0, -5.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[17], mat3x2(3.0, 2.0, -1.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[18], mat3x2(-1.0, 2.0, -7.0, 2.0, -8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	block.var[1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	block.var[2] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	block.var[3] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	block.var[4] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	block.var[5] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	block.var[6] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	block.var[7] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	block.var[8] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	block.var[9] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	block.var[10] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	block.var[11] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
	block.var[12] = (mat3x2(-6.0, -4.0, 8.0, 4.0, 5.0, 4.0));
	block.var[13] = (mat3x2(8.0, 3.0, 9.0, -4.0, -3.0, -6.0));
	block.var[14] = (mat3x2(-9.0, 8.0, 6.0, -7.0, 9.0, 2.0));
	block.var[15] = (mat3x2(-2.0, -3.0, -2.0, -4.0, 5.0, -4.0));
	block.var[16] = (mat3x2(9.0, -9.0, -9.0, -6.0, 8.0, 1.0));
	block.var[17] = (mat3x2(4.0, -2.0, 0.0, -9.0, 4.0, -2.0));
	block.var[18] = (mat3x2(3.0, 2.0, 8.0, -9.0, -3.0, -7.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(-5.0, 6.0, 6.0, 7.0, -2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(-9.0, -5.0, -8.0, -7.0, -2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(-1.0, -8.0, -9.0, 2.0, 0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(8.0, 1.0, -9.0, 5.0, -9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(-9.0, 9.0, -6.0, -5.0, 7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(9.0, 3.0, -9.0, 0.0, -6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(0.0, -3.0, -3.0, 1.0, -4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(8.0, 7.0, -4.0, 9.0, -4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(6.0, -1.0, 8.0, -1.0, 3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(4.0, 9.0, -7.0, -4.0, 6.0, 6.0, 9.0, 9.0, 7.0, 3.0, 6.0, 1.0, 5.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(6.0, 7.0, 4.0, 7.0, 0.0, 3.0, -7.0, -8.0, -9.0, 1.0, 4.0, 2.0, 0.0, -6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(-7.0, 7.0, -7.0, 6.0, 6.0, -7.0, 3.0, -2.0, -8.0, 6.0, 5.0, 8.0, 5.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(1.0, -3.0, -5.0, -3.0, 4.0, 2.0, -1.0, 8.0, -6.0, 2.0, 6.0, 6.0, 5.0, 4.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(6.0, -2.0, -6.0, 6.0, -1.0, 9.0, 7.0, 9.0, 5.0, -5.0, -5.0, 8.0, -5.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(-8.0, -6.0, 5.0, -5.0, 7.0, -6.0, -4.0, 7.0, 5.0, -4.0, -1.0, 2.0, 6.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(-1.0, 4.0, -8.0, -2.0, 4.0, 0.0, -4.0, -1.0, 4.0, -5.0, -8.0, 0.0, 8.0, 4.0, 5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	block.var[1] = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	block.var[2] = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
	block.var[3] = (mat4(6.0, -6.0, 8.0, 6.0, 6.0, 3.0, 3.0, 2.0, -4.0, 4.0, 2.0, -3.0, -7.0, -8.0, -6.0, 1.0));
	block.var[4] = (mat4(-4.0, -6.0, -2.0, -5.0, -2.0, -9.0, 0.0, 3.0, 9.0, 2.0, -5.0, 5.0, 1.0, 9.0, -1.0, 0.0));
	block.var[5] = (mat4(-4.0, 8.0, 6.0, -2.0, 1.0, -1.0, -7.0, -1.0, -1.0, 3.0, -8.0, 4.0, 8.0, 4.0, -3.0, -8.0));
	block.var[6] = (mat4(3.0, -8.0, 9.0, 8.0, 0.0, 3.0, 7.0, 6.0, 4.0, 6.0, 8.0, -9.0, 5.0, 9.0, -4.0, -4.0));
	block.var[7] = (mat4(1.0, 0.0, -1.0, 1.0, 7.0, 1.0, -7.0, -6.0, -9.0, 6.0, -5.0, -8.0, 1.0, -3.0, 3.0, 4.0));
	block.var[8] = (mat4(-4.0, 2.0, 6.0, -8.0, 2.0, -4.0, 9.0, -7.0, -6.0, 4.0, 4.0, -2.0, -6.0, 1.0, 2.0, -7.0));
	block.var[9] = (mat4(-2.0, 7.0, 4.0, 1.0, 4.0, -4.0, 2.0, 4.0, 2.0, -1.0, -8.0, 0.0, -9.0, 2.0, 8.0, 9.0));
	block.var[10] = (mat4(-1.0, -7.0, -2.0, -1.0, 7.0, 1.0, -8.0, -8.0, -3.0, -2.0, 5.0, 7.0, -2.0, -8.0, 8.0, -6.0));
	block.var[11] = (mat4(4.0, 3.0, -2.0, -4.0, -1.0, -3.0, -8.0, 3.0, -3.0, 8.0, 1.0, -4.0, -9.0, -7.0, 3.0, 6.0));
	block.var[12] = (mat4(-8.0, 4.0, 7.0, 8.0, 2.0, -8.0, -3.0, 3.0, -4.0, 1.0, 2.0, 3.0, -1.0, 1.0, 8.0, -3.0));
	block.var[13] = (mat4(0.0, 5.0, -3.0, -5.0, 2.0, 8.0, 7.0, 5.0, 3.0, 8.0, 4.0, -1.0, 5.0, -1.0, -3.0, 5.0));
	block.var[14] = (mat4(-7.0, 1.0, 5.0, -4.0, 9.0, -1.0, 0.0, 8.0, -3.0, 4.0, 5.0, -5.0, 1.0, -8.0, -1.0, 3.0));
	block.var[15] = (mat4(9.0, -4.0, -2.0, 7.0, 1.0, -8.0, 4.0, 2.0, 8.0, 3.0, -2.0, -6.0, 2.0, -7.0, 1.0, 0.0));
	block.var[16] = (mat4(5.0, 9.0, 8.0, 8.0, -3.0, 9.0, 9.0, 8.0, 9.0, 7.0, 5.0, 1.0, -6.0, -4.0, -4.0, 4.0));
	block.var[17] = (mat4(1.0, 4.0, 7.0, 6.0, -1.0, 2.0, 2.0, 4.0, -1.0, -9.0, 4.0, 4.0, 1.0, -7.0, 7.0, -7.0));
	block.var[18] = (mat4(-6.0, 6.0, 8.0, 4.0, 1.0, 3.0, 4.0, -7.0, -9.0, -3.0, 3.0, -1.0, 8.0, 6.0, 3.0, 3.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(-9.0, 2.0, -4.0, -7.0, -8.0, -5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(0.0, 5.0, 4.0, -5.0, 1.0, -3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-2.0, -8.0, -5.0, -3.0, -6.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(2.0, -8.0, -6.0, -8.0, 7.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(4.0, 5.0, 0.0, 5.0, -4.0, -9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-9.0, 3.0, -9.0, 0.0, 2.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(4.0, -5.0, -6.0, -5.0, 5.0, 1.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	block.var[1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	block.var[2] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
	block.var[3] = (mat2x4(-7.0, -4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0));
	block.var[4] = (mat2x4(0.0, -4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0));
	block.var[5] = (mat2x4(3.0, -8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0));
	block.var[6] = (mat2x4(4.0, -7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0));
	block.var[7] = (mat2x4(-2.0, 1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0));
	block.var[8] = (mat2x4(-8.0, 7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0));
	block.var[9] = (mat2x4(2.0, 9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0));
	block.var[10] = (mat2x4(5.0, -9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0));
	block.var[11] = (mat2x4(-6.0, -9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0));
	block.var[12] = (mat2x4(7.0, -5.0, -6.0, -8.0, -5.0, 3.0, -4.0, -5.0));
	block.var[13] = (mat2x4(-3.0, -5.0, 7.0, -7.0, 7.0, 8.0, 6.0, 7.0));
	block.var[14] = (mat2x4(-8.0, 2.0, 0.0, 3.0, 7.0, 9.0, 3.0, 0.0));
	block.var[15] = (mat2x4(-9.0, 1.0, -3.0, 3.0, 2.0, 9.0, -5.0, 3.0));
	block.var[16] = (mat2x4(4.0, 1.0, 6.0, 5.0, 6.0, -8.0, 9.0, -8.0));
	block.var[17] = (mat2x4(-6.0, -7.0, 0.0, -1.0, -3.0, -5.0, -4.0, 3.0));
	block.var[18] = (mat2x4(-7.0, -3.0, -2.0, -2.0, -6.0, -7.0, 1.0, 6.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(4.0, 7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(-6.0, 0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-1.0, 7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(-7.0, 9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(6.0, -8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-1.0, -3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(-2.0, -2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	block.var[0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	block.var[1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	block.var[1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	block.var[2][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	block.var[2][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	block.var[3][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	block.var[3][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	block.var[4][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	block.var[4][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	block.var[5][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	block.var[5][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	block.var[6][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	block.var[6][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	block.var[7][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	block.var[7][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	block.var[8][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	block.var[8][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	block.var[9][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	block.var[9][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	block.var[10][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	block.var[10][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	block.var[11][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	block.var[11][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
	block.var[12][0] = (vec4(-7.0, 4.0, -9.0, 1.0));
	block.var[12][1] = (vec4(0.0, -5.0, 6.0, -3.0));
	block.var[13][0] = (vec4(-9.0, -4.0, 8.0, -1.0));
	block.var[13][1] = (vec4(7.0, -1.0, -9.0, -2.0));
	block.var[14][0] = (vec4(-9.0, -6.0, -1.0, -3.0));
	block.var[14][1] = (vec4(6.0, -6.0, 2.0, 1.0));
	block.var[15][0] = (vec4(-3.0, -3.0, -5.0, -1.0));
	block.var[15][1] = (vec4(4.0, 0.0, -9.0, -1.0));
	block.var[16][0] = (vec4(1.0, -2.0, 4.0, -4.0));
	block.var[16][1] = (vec4(3.0, -9.0, 0.0, -4.0));
	block.var[17][0] = (vec4(-7.0, 7.0, 9.0, -2.0));
	block.var[17][1] = (vec4(5.0, -3.0, -5.0, 5.0));
	block.var[18][0] = (vec4(-2.0, 4.0, 0.0, -2.0));
	block.var[18][1] = (vec4(9.0, -8.0, 7.0, 0.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
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
	allOk = compare_mat4(block.var[0][0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	block.var[0][1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	block.var[0][2] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
	block.var[1][0] = (mat4(-1.0, 9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0));
	block.var[1][1] = (mat4(5.0, 6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0));
	block.var[1][2] = (mat4(7.0, -1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0));
	block.var[2][0] = (mat4(4.0, -8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0));
	block.var[2][1] = (mat4(-9.0, -2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0));
	block.var[2][2] = (mat4(5.0, -2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0));
	block.var[3][0] = (mat4(-2.0, -6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0));
	block.var[3][1] = (mat4(-9.0, -3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0));
	block.var[3][2] = (mat4(6.0, 9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0));
}
#version 450
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
	highp uvec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.padding), 9u) && allOk;
	allOk = compare_uvec3((block.var[0][0]), uvec3(6u, 4u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[0][1]), uvec3(2u, 7u, 5u)) && allOk;
	allOk = compare_uvec3((block.var[0][2]), uvec3(0u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((block.var[1][0]), uvec3(8u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[1][1]), uvec3(5u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[1][2]), uvec3(2u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((block.var[2][0]), uvec3(1u, 7u, 1u)) && allOk;
	allOk = compare_uvec3((block.var[2][1]), uvec3(5u, 4u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[2][2]), uvec3(4u, 3u, 1u)) && allOk;
	allOk = compare_uvec3((block.var[3][0]), uvec3(4u, 3u, 8u)) && allOk;
	allOk = compare_uvec3((block.var[3][1]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[3][2]), uvec3(2u, 6u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3u);
	block.var[0][0] = (uvec3(5u, 6u, 5u));
	block.var[0][1] = (uvec3(4u, 5u, 4u));
	block.var[0][2] = (uvec3(9u, 4u, 4u));
	block.var[1][0] = (uvec3(7u, 7u, 0u));
	block.var[1][1] = (uvec3(2u, 9u, 4u));
	block.var[1][2] = (uvec3(7u, 8u, 9u));
	block.var[2][0] = (uvec3(4u, 3u, 5u));
	block.var[2][1] = (uvec3(8u, 0u, 5u));
	block.var[2][2] = (uvec3(4u, 6u, 7u));
	block.var[3][0] = (uvec3(7u, 5u, 3u));
	block.var[3][1] = (uvec3(7u, 0u, 8u));
	block.var[3][2] = (uvec3(1u, 2u, 1u));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0], mat2(7.0, 0.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(-3.0, 5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(-9.0, -4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(-7.0, -1.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(-7.0, -5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(6.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(-3.0, 0.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(-3.0, 8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(-9.0, -7.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(5.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(-3.0, -8.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(2.0, -9.0, 1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0][0] = (mat2(-4.0, -2.0, 1.0, 1.0));
	block.var[0][1] = (mat2(-1.0, -3.0, -4.0, -8.0));
	block.var[0][2] = (mat2(-6.0, -2.0, 5.0, 8.0));
	block.var[1][0] = (mat2(0.0, -2.0, -5.0, -1.0));
	block.var[1][1] = (mat2(4.0, -4.0, -6.0, 9.0));
	block.var[1][2] = (mat2(-9.0, 0.0, 7.0, 2.0));
	block.var[2][0] = (mat2(9.0, 6.0, -5.0, 5.0));
	block.var[2][1] = (mat2(-5.0, -7.0, 8.0, -2.0));
	block.var[2][2] = (mat2(-1.0, 8.0, -9.0, -7.0));
	block.var[3][0] = (mat2(-9.0, 3.0, 5.0, -3.0));
	block.var[3][1] = (mat2(-2.0, -9.0, -1.0, 5.0));
	block.var[3][2] = (mat2(-2.0, 4.0, 8.0, 8.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0], mat3x4(3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(-8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(-3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(-1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(-9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(-4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(-4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(-5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-8.0);
	block.var[0][0] = (mat3x4(-6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0, 3.0));
	block.var[0][1] = (mat3x4(-2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0, 1.0));
	block.var[0][2] = (mat3x4(-1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0, -6.0));
	block.var[1][0] = (mat3x4(7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0, 7.0));
	block.var[1][1] = (mat3x4(-8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0, -1.0));
	block.var[1][2] = (mat3x4(2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0, 6.0));
	block.var[2][0] = (mat3x4(6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0, 3.0));
	block.var[2][1] = (mat3x4(-3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0, 9.0));
	block.var[2][2] = (mat3x4(4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0, 5.0));
	block.var[3][0] = (mat3x4(0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0, 0.0));
	block.var[3][1] = (mat3x4(-3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0, 5.0));
	block.var[3][2] = (mat3x4(7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0, 9.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat4x3(block.var[0][0], mat4x3(9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(-8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0, 1.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0, 7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(-8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(-3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0, 3.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(-6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0, -7.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(-2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0, -8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0, 2.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0, 4.0, 6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0][0][0] = (vec3(-7.0, 2.0, 3.0));
	block.var[0][0][1] = (vec3(1.0, -2.0, -1.0));
	block.var[0][0][2] = (vec3(-5.0, -1.0, 9.0));
	block.var[0][0][3] = (vec3(3.0, -7.0, 8.0));
	block.var[0][1][0] = (vec3(4.0, 9.0, -6.0));
	block.var[0][1][1] = (vec3(7.0, 6.0, -5.0));
	block.var[0][1][2] = (vec3(2.0, 6.0, 3.0));
	block.var[0][1][3] = (vec3(-4.0, 3.0, 2.0));
	block.var[0][2][0] = (vec3(-3.0, -3.0, -7.0));
	block.var[0][2][1] = (vec3(-5.0, 3.0, 4.0));
	block.var[0][2][2] = (vec3(-4.0, -2.0, 8.0));
	block.var[0][2][3] = (vec3(7.0, -1.0, -1.0));
	block.var[1][0][0] = (vec3(-4.0, -7.0, -7.0));
	block.var[1][0][1] = (vec3(8.0, 4.0, -6.0));
	block.var[1][0][2] = (vec3(6.0, 0.0, 1.0));
	block.var[1][0][3] = (vec3(-8.0, 8.0, 7.0));
	block.var[1][1][0] = (vec3(9.0, 9.0, -6.0));
	block.var[1][1][1] = (vec3(0.0, 1.0, 1.0));
	block.var[1][1][2] = (vec3(2.0, 7.0, 2.0));
	block.var[1][1][3] = (vec3(-1.0, -8.0, -3.0));
	block.var[1][2][0] = (vec3(3.0, -1.0, -1.0));
	block.var[1][2][1] = (vec3(-2.0, 9.0, -5.0));
	block.var[1][2][2] = (vec3(8.0, -6.0, -5.0));
	block.var[1][2][3] = (vec3(-6.0, 5.0, -9.0));
	block.var[2][0][0] = (vec3(5.0, 6.0, -7.0));
	block.var[2][0][1] = (vec3(-8.0, 1.0, 8.0));
	block.var[2][0][2] = (vec3(1.0, 6.0, -1.0));
	block.var[2][0][3] = (vec3(3.0, -2.0, -5.0));
	block.var[2][1][0] = (vec3(5.0, -3.0, 2.0));
	block.var[2][1][1] = (vec3(-5.0, 2.0, -2.0));
	block.var[2][1][2] = (vec3(-7.0, -9.0, -1.0));
	block.var[2][1][3] = (vec3(0.0, -6.0, -2.0));
	block.var[2][2][0] = (vec3(-9.0, -4.0, 9.0));
	block.var[2][2][1] = (vec3(4.0, -4.0, 5.0));
	block.var[2][2][2] = (vec3(7.0, 1.0, 7.0));
	block.var[2][2][3] = (vec3(-3.0, -7.0, -9.0));
	block.var[3][0][0] = (vec3(4.0, 0.0, 0.0));
	block.var[3][0][1] = (vec3(0.0, -3.0, 3.0));
	block.var[3][0][2] = (vec3(1.0, 8.0, 0.0));
	block.var[3][0][3] = (vec3(5.0, 4.0, -2.0));
	block.var[3][1][0] = (vec3(-8.0, 7.0, -9.0));
	block.var[3][1][1] = (vec3(3.0, -2.0, -3.0));
	block.var[3][1][2] = (vec3(-5.0, 1.0, -4.0));
	block.var[3][1][3] = (vec3(9.0, -8.0, 5.0));
	block.var[3][2][0] = (vec3(3.0, 7.0, -3.0));
	block.var[3][2][1] = (vec3(-2.0, 2.0, -9.0));
	block.var[3][2][2] = (vec3(0.0, 9.0, 5.0));
	block.var[3][2][3] = (vec3(5.0, 8.0, -5.0));
}
#version 450
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
	allOk = compare_float((block.padding), 7.0) && allOk;
	allOk = compare_mat4x3(block.var[0][0], mat4x3(3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0, -2.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(-4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0, -5.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0, 1.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(-5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0, -2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0, 8.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(-9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0, 0.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0, 6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0, -3.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0, -2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0, -7.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0, -9.0, -8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0][0][0] = (vec3(-6.0, 3.0, -3.0));
	block.var[0][0][1] = (vec3(9.0, -2.0, 3.0));
	block.var[0][0][2] = (vec3(9.0, -9.0, 7.0));
	block.var[0][0][3] = (vec3(4.0, -4.0, 5.0));
	block.var[0][1][0] = (vec3(-1.0, -2.0, 6.0));
	block.var[0][1][1] = (vec3(-4.0, 6.0, 4.0));
	block.var[0][1][2] = (vec3(-8.0, 7.0, 3.0));
	block.var[0][1][3] = (vec3(1.0, -9.0, -4.0));
	block.var[0][2][0] = (vec3(9.0, 2.0, 2.0));
	block.var[0][2][1] = (vec3(9.0, -7.0, 3.0));
	block.var[0][2][2] = (vec3(8.0, 2.0, 4.0));
	block.var[0][2][3] = (vec3(-9.0, 8.0, 2.0));
	block.var[1][0][0] = (vec3(-8.0, 7.0, 3.0));
	block.var[1][0][1] = (vec3(0.0, -8.0, 0.0));
	block.var[1][0][2] = (vec3(6.0, -9.0, 0.0));
	block.var[1][0][3] = (vec3(4.0, -3.0, -4.0));
	block.var[1][1][0] = (vec3(-7.0, -8.0, -1.0));
	block.var[1][1][1] = (vec3(6.0, -3.0, -5.0));
	block.var[1][1][2] = (vec3(0.0, 8.0, -8.0));
	block.var[1][1][3] = (vec3(5.0, 5.0, -4.0));
	block.var[1][2][0] = (vec3(-4.0, -4.0, -3.0));
	block.var[1][2][1] = (vec3(3.0, 3.0, 2.0));
	block.var[1][2][2] = (vec3(8.0, -8.0, -6.0));
	block.var[1][2][3] = (vec3(4.0, 8.0, 9.0));
	block.var[2][0][0] = (vec3(-1.0, 2.0, 4.0));
	block.var[2][0][1] = (vec3(4.0, 2.0, 0.0));
	block.var[2][0][2] = (vec3(5.0, 6.0, -6.0));
	block.var[2][0][3] = (vec3(1.0, -1.0, -3.0));
	block.var[2][1][0] = (vec3(7.0, 9.0, 8.0));
	block.var[2][1][1] = (vec3(-9.0, -9.0, -9.0));
	block.var[2][1][2] = (vec3(6.0, -7.0, -3.0));
	block.var[2][1][3] = (vec3(7.0, -6.0, 7.0));
	block.var[2][2][0] = (vec3(-9.0, 0.0, -1.0));
	block.var[2][2][1] = (vec3(-7.0, -2.0, -3.0));
	block.var[2][2][2] = (vec3(1.0, 4.0, 5.0));
	block.var[2][2][3] = (vec3(-1.0, -4.0, 9.0));
	block.var[3][0][0] = (vec3(5.0, 4.0, 7.0));
	block.var[3][0][1] = (vec3(3.0, -3.0, 4.0));
	block.var[3][0][2] = (vec3(3.0, -6.0, 5.0));
	block.var[3][0][3] = (vec3(8.0, 7.0, -8.0));
	block.var[3][1][0] = (vec3(4.0, 8.0, -3.0));
	block.var[3][1][1] = (vec3(-9.0, 7.0, -2.0));
	block.var[3][1][2] = (vec3(0.0, -3.0, -3.0));
	block.var[3][1][3] = (vec3(-4.0, -9.0, 4.0));
	block.var[3][2][0] = (vec3(-5.0, -7.0, 1.0));
	block.var[3][2][1] = (vec3(-8.0, 1.0, 9.0));
	block.var[3][2][2] = (vec3(-8.0, 0.0, -2.0));
	block.var[3][2][3] = (vec3(-2.0, -4.0, -5.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(8.0, -2.0, 5.0, 8.0, 5.0, -1.0, 2.0, -4.0, -9.0, -5.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-2.0, 7.0, -4.0, 9.0, 4.0, -1.0, -2.0, -8.0, 7.0, 9.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(6.0, 1.0, 9.0, 3.0, -6.0, -4.0, 9.0, 3.0, -7.0, -3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-7.0, -7.0, 7.0, 2.0, -5.0, 3.0, 2.0, 0.0, 8.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-8.0, 6.0, 2.0, -5.0, -7.0, -7.0, -4.0, -9.0, 7.0, 3.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(-7.0, 7.0, 6.0, 3.0, 4.0, 5.0, -2.0, 3.0, 8.0, -7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(2.0, -4.0, -5.0, 2.0, -6.0, -3.0, -7.0, 2.0, 6.0, 4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(7.0, 2.0, -9.0, -6.0, -7.0, -2.0, -2.0, 6.0, -5.0, -9.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(-4.0, 1.0, -3.0, -3.0, -1.0, -5.0, -5.0, 7.0, -9.0, 6.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(0.0, 7.0, 1.0, -2.0, 9.0, -5.0, -3.0, 1.0, -6.0, 6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(9.0, 8.0, 5.0, 4.0, 7.0, -1.0, 6.0, -6.0, 2.0, 8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(0.0, 6.0, -8.0, -4.0, -8.0, 8.0, -5.0, 7.0, 3.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(8.0, -3.0, 5.0, 4.0, -3.0, 7.0, -7.0, -8.0, -9.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(7.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0, -9.0, -7.0, -1.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(8.0, -5.0, 6.0, -8.0, 6.0, 3.0, 6.0, -5.0, 9.0, -1.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(6.0, -3.0, 0.0, -3.0, 2.0, -8.0, 6.0, 5.0, -2.0, 2.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(-7.0, 4.0, 5.0, -8.0, -1.0, -2.0, -8.0, -4.0, 2.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(4.0, -1.0, 3.0, 3.0, -3.0, 4.0, -6.0, -5.0, 1.0, 4.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(6.0, 3.0, -8.0, -6.0, -6.0, 0.0, 4.0, -1.0, 4.0, -5.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(6.0, 9.0, -3.0, 5.0, 2.0, -6.0, -7.0, -3.0, -2.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(-5.0, 7.0, 5.0, -4.0, 6.0, 1.0, -7.0, 9.0, 2.0, -1.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	block.var[0][0][1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	block.var[0][0][2] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
	block.var[0][1][0] = (mat4x3(-2.0, 3.0, 9.0, 9.0, -7.0, 4.0, 4.0, 8.0, 7.0, -7.0, 2.0, 2.0));
	block.var[0][1][1] = (mat4x3(-2.0, -1.0, -7.0, 6.0, 7.0, -7.0, 6.0, 0.0, 2.0, -3.0, -6.0, -4.0));
	block.var[0][1][2] = (mat4x3(5.0, -5.0, 1.0, 9.0, 0.0, 3.0, 6.0, -8.0, 7.0, -6.0, 0.0, -2.0));
	block.var[1][0][0] = (mat4x3(-6.0, -5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0));
	block.var[1][0][1] = (mat4x3(-6.0, 5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0));
	block.var[1][0][2] = (mat4x3(-7.0, -2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0));
	block.var[1][1][0] = (mat4x3(3.0, 0.0, 5.0, 8.0, 6.0, -4.0, 7.0, 1.0, 1.0, 5.0, -3.0, -3.0));
	block.var[1][1][1] = (mat4x3(5.0, -3.0, -4.0, -9.0, 2.0, 9.0, -3.0, 1.0, -8.0, -8.0, 0.0, 9.0));
	block.var[1][1][2] = (mat4x3(-8.0, 9.0, -9.0, 4.0, -4.0, 3.0, -4.0, -1.0, -6.0, -7.0, 7.0, 6.0));
	block.var[2][0][0] = (mat4x3(-9.0, -7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0));
	block.var[2][0][1] = (mat4x3(-8.0, -4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0));
	block.var[2][0][2] = (mat4x3(-3.0, -7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0));
	block.var[2][1][0] = (mat4x3(-6.0, 5.0, 8.0, 3.0, -8.0, 8.0, -6.0, -2.0, 5.0, 6.0, 4.0, 8.0));
	block.var[2][1][1] = (mat4x3(-9.0, 0.0, -2.0, -2.0, 9.0, 5.0, 0.0, -8.0, -1.0, 0.0, -6.0, 6.0));
	block.var[2][1][2] = (mat4x3(-4.0, 1.0, -2.0, -8.0, -6.0, 8.0, 0.0, 0.0, -5.0, 8.0, -1.0, -7.0));
	block.var[3][0][0] = (mat4x3(3.0, -8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0));
	block.var[3][0][1] = (mat4x3(-6.0, -9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0));
	block.var[3][0][2] = (mat4x3(-1.0, -9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0));
	block.var[3][1][0] = (mat4x3(-2.0, -2.0, 5.0, -5.0, -4.0, -9.0, -9.0, 1.0, -1.0, -8.0, 2.0, -9.0));
	block.var[3][1][1] = (mat4x3(-2.0, 3.0, 5.0, -9.0, -2.0, -6.0, 8.0, 6.0, 6.0, -9.0, 2.0, 5.0));
	block.var[3][1][2] = (mat4x3(-7.0, -4.0, -5.0, -3.0, 0.0, 4.0, 0.0, -4.0, -9.0, -5.0, -6.0, -2.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(2.0, -1.0, 6.0, -6.0, 4.0, 2.0, 5.0, 9.0, 7.0, -3.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-5.0, 0.0, 0.0, 2.0, 5.0, 8.0, -5.0, 7.0, 5.0, -3.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(-9.0, 9.0, 1.0, -6.0, 3.0, 9.0, 6.0, -4.0, -6.0, 6.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-4.0, 4.0, -6.0, 0.0, -7.0, -2.0, 2.0, 1.0, 2.0, 5.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-6.0, -6.0, 3.0, -4.0, 7.0, -9.0, 0.0, 4.0, 0.0, 7.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(-8.0, -8.0, -8.0, 9.0, 7.0, -9.0, -6.0, -2.0, 3.0, 5.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-9.0, 2.0, -8.0, -3.0, 1.0, -5.0, 1.0, 3.0, 1.0, 5.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-7.0, -4.0, -9.0, 6.0, 5.0, 0.0, -1.0, -4.0, -3.0, 7.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(4.0, 0.0, -9.0, 6.0, -2.0, -9.0, 9.0, 1.0, 8.0, 8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(-3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(-2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(-7.0, 1.0, 0.0, 6.0, -8.0, 9.0, -2.0, 3.0, 4.0, -3.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(3.0, 7.0, 1.0, -9.0, -5.0, 4.0, 9.0, 4.0, -7.0, 5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(-4.0, -3.0, -5.0, -2.0, -8.0, 2.0, -1.0, 4.0, 7.0, 5.0, 5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0][0][0] = (mat3x4(0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0, 8.0));
	block.var[0][0][1] = (mat3x4(1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0, 8.0));
	block.var[0][0][2] = (mat3x4(-2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0, -9.0));
	block.var[0][1][0] = (mat3x4(8.0, 5.0, -1.0, 0.0, 6.0, 7.0, -1.0, 3.0, 5.0, -7.0, 2.0, 9.0));
	block.var[0][1][1] = (mat3x4(-2.0, -7.0, -4.0, 7.0, 9.0, 9.0, -2.0, -7.0, -3.0, 9.0, 9.0, 4.0));
	block.var[0][1][2] = (mat3x4(-7.0, 5.0, -1.0, -8.0, -1.0, -1.0, 1.0, -1.0, 6.0, 6.0, 9.0, 3.0));
	block.var[1][0][0] = (mat3x4(4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0, 3.0));
	block.var[1][0][1] = (mat3x4(1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0, 1.0));
	block.var[1][0][2] = (mat3x4(5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0, -2.0));
	block.var[1][1][0] = (mat3x4(1.0, 7.0, 6.0, 8.0, 1.0, 8.0, -5.0, -5.0, -9.0, -1.0, -9.0, -1.0));
	block.var[1][1][1] = (mat3x4(6.0, 3.0, -9.0, -4.0, -5.0, 2.0, -2.0, -2.0, -2.0, -2.0, 2.0, -7.0));
	block.var[1][1][2] = (mat3x4(-4.0, 6.0, -9.0, 6.0, -3.0, -9.0, 6.0, 3.0, 2.0, -5.0, -9.0, -5.0));
	block.var[2][0][0] = (mat3x4(-7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0, -8.0));
	block.var[2][0][1] = (mat3x4(8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0, 6.0));
	block.var[2][0][2] = (mat3x4(-1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0, 5.0));
	block.var[2][1][0] = (mat3x4(9.0, -5.0, 5.0, -4.0, 7.0, 7.0, -1.0, -9.0, 8.0, 2.0, -5.0, -4.0));
	block.var[2][1][1] = (mat3x4(4.0, -6.0, 7.0, 7.0, 0.0, -4.0, -5.0, 3.0, -2.0, -4.0, -9.0, 9.0));
	block.var[2][1][2] = (mat3x4(0.0, -3.0, -8.0, 1.0, -4.0, 4.0, 3.0, 4.0, -8.0, 6.0, 7.0, -6.0));
	block.var[3][0][0] = (mat3x4(5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0, -4.0));
	block.var[3][0][1] = (mat3x4(7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0, -1.0));
	block.var[3][0][2] = (mat3x4(3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0, -7.0));
	block.var[3][1][0] = (mat3x4(-3.0, 9.0, 1.0, -6.0, 0.0, -9.0, -9.0, -2.0, -6.0, 0.0, 2.0, -4.0));
	block.var[3][1][1] = (mat3x4(1.0, 0.0, -2.0, 8.0, 2.0, 9.0, 3.0, -5.0, -2.0, -4.0, 0.0, -3.0));
	block.var[3][1][2] = (mat3x4(-7.0, -4.0, 2.0, 1.0, -7.0, 2.0, 9.0, 1.0, -1.0, -2.0, 3.0, -7.0));
}
#version 450
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
	highp float var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.var[0][0][0]), 7.0) && allOk;
	allOk = compare_float((block.var[0][0][1]), -1.0) && allOk;
	allOk = compare_float((block.var[0][1][0]), 4.0) && allOk;
	allOk = compare_float((block.var[0][1][1]), 2.0) && allOk;
	allOk = compare_float((block.var[0][2][0]), 1.0) && allOk;
	allOk = compare_float((block.var[0][2][1]), -3.0) && allOk;
	allOk = compare_float((block.var[0][3][0]), -4.0) && allOk;
	allOk = compare_float((block.var[0][3][1]), -5.0) && allOk;
	allOk = compare_float((block.var[1][0][0]), -6.0) && allOk;
	allOk = compare_float((block.var[1][0][1]), 0.0) && allOk;
	allOk = compare_float((block.var[1][1][0]), -1.0) && allOk;
	allOk = compare_float((block.var[1][1][1]), -6.0) && allOk;
	allOk = compare_float((block.var[1][2][0]), -7.0) && allOk;
	allOk = compare_float((block.var[1][2][1]), 8.0) && allOk;
	allOk = compare_float((block.var[1][3][0]), 9.0) && allOk;
	allOk = compare_float((block.var[1][3][1]), 7.0) && allOk;
	allOk = compare_float((block.var[2][0][0]), -7.0) && allOk;
	allOk = compare_float((block.var[2][0][1]), 5.0) && allOk;
	allOk = compare_float((block.var[2][1][0]), -2.0) && allOk;
	allOk = compare_float((block.var[2][1][1]), -1.0) && allOk;
	allOk = compare_float((block.var[2][2][0]), -9.0) && allOk;
	allOk = compare_float((block.var[2][2][1]), -4.0) && allOk;
	allOk = compare_float((block.var[2][3][0]), -7.0) && allOk;
	allOk = compare_float((block.var[2][3][1]), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (-2.0);
	block.var[0][0][1] = (4.0);
	block.var[0][1][0] = (-8.0);
	block.var[0][1][1] = (9.0);
	block.var[0][2][0] = (-6.0);
	block.var[0][2][1] = (-9.0);
	block.var[0][3][0] = (5.0);
	block.var[0][3][1] = (4.0);
	block.var[1][0][0] = (6.0);
	block.var[1][0][1] = (7.0);
	block.var[1][1][0] = (-5.0);
	block.var[1][1][1] = (8.0);
	block.var[1][2][0] = (-4.0);
	block.var[1][2][1] = (3.0);
	block.var[1][3][0] = (-8.0);
	block.var[1][3][1] = (5.0);
	block.var[2][0][0] = (-4.0);
	block.var[2][0][1] = (5.0);
	block.var[2][1][0] = (-5.0);
	block.var[2][1][1] = (6.0);
	block.var[2][2][0] = (7.0);
	block.var[2][2][1] = (6.0);
	block.var[2][3][0] = (8.0);
	block.var[2][3][1] = (9.0);
}
#version 450
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
	highp int var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.var[0][0][0]), 6) && allOk;
	allOk = compare_int((block.var[0][0][1]), 0) && allOk;
	allOk = compare_int((block.var[0][1][0]), 8) && allOk;
	allOk = compare_int((block.var[0][1][1]), -9) && allOk;
	allOk = compare_int((block.var[0][2][0]), 5) && allOk;
	allOk = compare_int((block.var[0][2][1]), -3) && allOk;
	allOk = compare_int((block.var[0][3][0]), 3) && allOk;
	allOk = compare_int((block.var[0][3][1]), -1) && allOk;
	allOk = compare_int((block.var[1][0][0]), 9) && allOk;
	allOk = compare_int((block.var[1][0][1]), -6) && allOk;
	allOk = compare_int((block.var[1][1][0]), -1) && allOk;
	allOk = compare_int((block.var[1][1][1]), 0) && allOk;
	allOk = compare_int((block.var[1][2][0]), 4) && allOk;
	allOk = compare_int((block.var[1][2][1]), 4) && allOk;
	allOk = compare_int((block.var[1][3][0]), -9) && allOk;
	allOk = compare_int((block.var[1][3][1]), -7) && allOk;
	allOk = compare_int((block.var[2][0][0]), -9) && allOk;
	allOk = compare_int((block.var[2][0][1]), -8) && allOk;
	allOk = compare_int((block.var[2][1][0]), -9) && allOk;
	allOk = compare_int((block.var[2][1][1]), 5) && allOk;
	allOk = compare_int((block.var[2][2][0]), -9) && allOk;
	allOk = compare_int((block.var[2][2][1]), -9) && allOk;
	allOk = compare_int((block.var[2][3][0]), 9) && allOk;
	allOk = compare_int((block.var[2][3][1]), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (8);
	block.var[0][0][1] = (2);
	block.var[0][1][0] = (-8);
	block.var[0][1][1] = (6);
	block.var[0][2][0] = (-4);
	block.var[0][2][1] = (9);
	block.var[0][3][0] = (-3);
	block.var[0][3][1] = (-3);
	block.var[1][0][0] = (-5);
	block.var[1][0][1] = (0);
	block.var[1][1][0] = (-6);
	block.var[1][1][1] = (6);
	block.var[1][2][0] = (-8);
	block.var[1][2][1] = (4);
	block.var[1][3][0] = (6);
	block.var[1][3][1] = (-2);
	block.var[2][0][0] = (-7);
	block.var[2][0][1] = (-7);
	block.var[2][1][0] = (-5);
	block.var[2][1][1] = (5);
	block.var[2][2][0] = (-4);
	block.var[2][2][1] = (5);
	block.var[2][3][0] = (5);
	block.var[2][3][1] = (7);
}
#version 450
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
	i8vec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(block.var[0][0][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][0][1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][1][0]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][1][1]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][2][0]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][2][1]), ivec2(2, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][3][0]), ivec2(7, 4294967292)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][3][1]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][0][0]), ivec2(0, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][0][1]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][1][0]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][1][1]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][2][0]), ivec2(4294967290, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][2][1]), ivec2(5, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][3][0]), ivec2(2, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][3][1]), ivec2(0, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][0][0]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][0][1]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][1][0]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][1][1]), ivec2(3, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][2][0]), ivec2(8, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][2][1]), ivec2(4294967294, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][3][0]), ivec2(4294967289, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][3][1]), ivec2(7, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i8vec2(ivec2(0, 8));
	block.var[0][0][1] = i8vec2(ivec2(4294967292, 9));
	block.var[0][1][0] = i8vec2(ivec2(4294967293, 4294967293));
	block.var[0][1][1] = i8vec2(ivec2(4294967290, 3));
	block.var[0][2][0] = i8vec2(ivec2(4294967293, 0));
	block.var[0][2][1] = i8vec2(ivec2(3, 4294967291));
	block.var[0][3][0] = i8vec2(ivec2(4294967292, 4294967292));
	block.var[0][3][1] = i8vec2(ivec2(3, 4294967294));
	block.var[1][0][0] = i8vec2(ivec2(4294967294, 4294967295));
	block.var[1][0][1] = i8vec2(ivec2(8, 4294967290));
	block.var[1][1][0] = i8vec2(ivec2(4294967295, 8));
	block.var[1][1][1] = i8vec2(ivec2(5, 8));
	block.var[1][2][0] = i8vec2(ivec2(4294967295, 4294967292));
	block.var[1][2][1] = i8vec2(ivec2(5, 4294967292));
	block.var[1][3][0] = i8vec2(ivec2(8, 4));
	block.var[1][3][1] = i8vec2(ivec2(8, 6));
	block.var[2][0][0] = i8vec2(ivec2(8, 4294967289));
	block.var[2][0][1] = i8vec2(ivec2(7, 4294967294));
	block.var[2][1][0] = i8vec2(ivec2(4294967293, 4294967292));
	block.var[2][1][1] = i8vec2(ivec2(4294967287, 6));
	block.var[2][2][0] = i8vec2(ivec2(4294967291, 4));
	block.var[2][2][1] = i8vec2(ivec2(0, 4294967293));
	block.var[2][3][0] = i8vec2(ivec2(5, 4294967294));
	block.var[2][3][1] = i8vec2(ivec2(4294967288, 4294967292));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(4.0, 4.0, 9.0, -7.0, 9.0, 2.0, 3.0, 7.0, 0.0, -9.0, 2.0, -1.0, -8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(0.0, -3.0, -1.0, -1.0, -6.0, 1.0, -8.0, 1.0, 5.0, 0.0, 2.0, -1.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(0.0, 0.0, -1.0, 0.0, -9.0, 5.0, 4.0, 0.0, -6.0, -7.0, 1.0, -9.0, -4.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(0.0, 5.0, -7.0, -5.0, 9.0, 2.0, -2.0, 5.0, 8.0, -7.0, 9.0, 9.0, -8.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(7.0, 5.0, -2.0, -4.0, 0.0, 1.0, -6.0, -3.0, -1.0, -7.0, -7.0, -6.0, 1.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(8.0, -3.0, 9.0, 6.0, -2.0, -9.0, 4.0, 5.0, 6.0, 4.0, -3.0, -8.0, 6.0, 5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(5.0, 3.0, 5.0, -5.0, 6.0, 3.0, 0.0, -9.0, -1.0, 0.0, -8.0, 3.0, 4.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(-6.0, -9.0, -8.0, -2.0, -6.0, -8.0, 8.0, 4.0, 4.0, 1.0, 5.0, 0.0, -1.0, 4.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(-2.0, 5.0, 8.0, 4.0, -4.0, 9.0, 3.0, -5.0, 1.0, -6.0, 1.0, -5.0, 8.0, 7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(3.0, 0.0, -3.0, 3.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -9.0, -7.0, 1.0, -5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(-2.0, 2.0, 9.0, 7.0, -2.0, -6.0, -3.0, -7.0, 1.0, 2.0, -3.0, 0.0, -5.0, 5.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(3.0, 5.0, 2.0, -6.0, 9.0, 7.0, 4.0, 4.0, 5.0, 8.0, 4.0, -9.0, 3.0, -7.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	block.var[0][0][0][1] = (vec4(2.0, -4.0, 3.0, -5.0));
	block.var[0][0][0][2] = (vec4(2.0, 3.0, 8.0, 8.0));
	block.var[0][0][0][3] = (vec4(3.0, 0.0, -4.0, -1.0));
	block.var[0][0][1][0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	block.var[0][0][1][1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	block.var[0][0][1][2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	block.var[0][0][1][3] = (vec4(6.0, -9.0, -1.0, -5.0));
	block.var[0][1][0][0] = (vec4(-4.0, -3.0, 4.0, -8.0));
	block.var[0][1][0][1] = (vec4(-2.0, 0.0, -8.0, 2.0));
	block.var[0][1][0][2] = (vec4(-3.0, -5.0, 3.0, -2.0));
	block.var[0][1][0][3] = (vec4(-9.0, -8.0, -3.0, 5.0));
	block.var[0][1][1][0] = (vec4(-9.0, 6.0, -6.0, 7.0));
	block.var[0][1][1][1] = (vec4(-8.0, 2.0, 7.0, -5.0));
	block.var[0][1][1][2] = (vec4(0.0, -4.0, -7.0, 6.0));
	block.var[0][1][1][3] = (vec4(0.0, 0.0, 4.0, -5.0));
	block.var[0][2][0][0] = (vec4(-3.0, 9.0, 5.0, -2.0));
	block.var[0][2][0][1] = (vec4(-7.0, 3.0, 3.0, 1.0));
	block.var[0][2][0][2] = (vec4(-7.0, -9.0, -5.0, -7.0));
	block.var[0][2][0][3] = (vec4(-7.0, -8.0, -2.0, -8.0));
	block.var[0][2][1][0] = (vec4(3.0, 7.0, 3.0, 7.0));
	block.var[0][2][1][1] = (vec4(-8.0, 9.0, -9.0, -9.0));
	block.var[0][2][1][2] = (vec4(3.0, -4.0, -8.0, 3.0));
	block.var[0][2][1][3] = (vec4(9.0, -7.0, -5.0, -5.0));
	block.var[0][3][0][0] = (vec4(-2.0, -9.0, -3.0, -3.0));
	block.var[0][3][0][1] = (vec4(-3.0, 0.0, -7.0, 1.0));
	block.var[0][3][0][2] = (vec4(6.0, -1.0, 3.0, 4.0));
	block.var[0][3][0][3] = (vec4(8.0, 7.0, 7.0, -9.0));
	block.var[0][3][1][0] = (vec4(-9.0, 3.0, 5.0, 7.0));
	block.var[0][3][1][1] = (vec4(3.0, -6.0, -1.0, -5.0));
	block.var[0][3][1][2] = (vec4(9.0, -7.0, 9.0, -7.0));
	block.var[0][3][1][3] = (vec4(7.0, 5.0, -8.0, 6.0));
	block.var[1][0][0][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	block.var[1][0][0][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	block.var[1][0][0][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	block.var[1][0][0][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
	block.var[1][0][1][0] = (vec4(-3.0, 2.0, 9.0, -4.0));
	block.var[1][0][1][1] = (vec4(2.0, 9.0, -9.0, -2.0));
	block.var[1][0][1][2] = (vec4(-1.0, 1.0, -9.0, 0.0));
	block.var[1][0][1][3] = (vec4(-7.0, 7.0, -3.0, -9.0));
	block.var[1][1][0][0] = (vec4(-1.0, -9.0, -7.0, 5.0));
	block.var[1][1][0][1] = (vec4(3.0, 9.0, -8.0, -6.0));
	block.var[1][1][0][2] = (vec4(-3.0, 6.0, -9.0, 4.0));
	block.var[1][1][0][3] = (vec4(6.0, -6.0, -6.0, -2.0));
	block.var[1][1][1][0] = (vec4(-8.0, -3.0, -8.0, 5.0));
	block.var[1][1][1][1] = (vec4(6.0, -9.0, -7.0, -7.0));
	block.var[1][1][1][2] = (vec4(6.0, 1.0, 0.0, -3.0));
	block.var[1][1][1][3] = (vec4(4.0, 1.0, -7.0, 4.0));
	block.var[1][2][0][0] = (vec4(2.0, 2.0, -3.0, 9.0));
	block.var[1][2][0][1] = (vec4(0.0, -6.0, 7.0, 1.0));
	block.var[1][2][0][2] = (vec4(-1.0, 2.0, -7.0, 2.0));
	block.var[1][2][0][3] = (vec4(-1.0, -6.0, -8.0, 1.0));
	block.var[1][2][1][0] = (vec4(1.0, -4.0, -6.0, -4.0));
	block.var[1][2][1][1] = (vec4(-9.0, 0.0, -2.0, 6.0));
	block.var[1][2][1][2] = (vec4(3.0, 3.0, 4.0, -6.0));
	block.var[1][2][1][3] = (vec4(-7.0, 9.0, -1.0, 6.0));
	block.var[1][3][0][0] = (vec4(1.0, 7.0, -7.0, -7.0));
	block.var[1][3][0][1] = (vec4(-9.0, -7.0, -8.0, 7.0));
	block.var[1][3][0][2] = (vec4(5.0, -2.0, 5.0, -4.0));
	block.var[1][3][0][3] = (vec4(-8.0, 0.0, 0.0, 7.0));
	block.var[1][3][1][0] = (vec4(-9.0, 2.0, -4.0, 0.0));
	block.var[1][3][1][1] = (vec4(-5.0, -8.0, -8.0, 2.0));
	block.var[1][3][1][2] = (vec4(9.0, -9.0, -6.0, 5.0));
	block.var[1][3][1][3] = (vec4(0.0, 9.0, 6.0, 5.0));
	block.var[2][0][0][0] = (vec4(-1.0, 0.0, 7.0, 7.0));
	block.var[2][0][0][1] = (vec4(-5.0, -2.0, -6.0, 0.0));
	block.var[2][0][0][2] = (vec4(-2.0, 1.0, -2.0, 4.0));
	block.var[2][0][0][3] = (vec4(4.0, 0.0, 0.0, -2.0));
	block.var[2][0][1][0] = (vec4(4.0, 7.0, -5.0, -3.0));
	block.var[2][0][1][1] = (vec4(9.0, 1.0, 5.0, 5.0));
	block.var[2][0][1][2] = (vec4(9.0, -4.0, -6.0, 8.0));
	block.var[2][0][1][3] = (vec4(1.0, -5.0, 5.0, -3.0));
	block.var[2][1][0][0] = (vec4(6.0, 4.0, 3.0, -5.0));
	block.var[2][1][0][1] = (vec4(-8.0, 0.0, -2.0, 7.0));
	block.var[2][1][0][2] = (vec4(5.0, -1.0, -3.0, -2.0));
	block.var[2][1][0][3] = (vec4(-6.0, -9.0, -3.0, 5.0));
	block.var[2][1][1][0] = (vec4(8.0, 7.0, -4.0, 1.0));
	block.var[2][1][1][1] = (vec4(6.0, -9.0, 8.0, 3.0));
	block.var[2][1][1][2] = (vec4(-6.0, -7.0, 7.0, -1.0));
	block.var[2][1][1][3] = (vec4(-7.0, 6.0, -5.0, 9.0));
	block.var[2][2][0][0] = (vec4(-8.0, -1.0, 0.0, -8.0));
	block.var[2][2][0][1] = (vec4(3.0, -1.0, 9.0, -7.0));
	block.var[2][2][0][2] = (vec4(-4.0, 7.0, 9.0, -5.0));
	block.var[2][2][0][3] = (vec4(2.0, -8.0, 7.0, 8.0));
	block.var[2][2][1][0] = (vec4(1.0, -8.0, -3.0, -8.0));
	block.var[2][2][1][1] = (vec4(-8.0, -6.0, -2.0, -9.0));
	block.var[2][2][1][2] = (vec4(-4.0, 4.0, -9.0, -5.0));
	block.var[2][2][1][3] = (vec4(-2.0, 9.0, -7.0, -6.0));
	block.var[2][3][0][0] = (vec4(-2.0, -9.0, 6.0, -7.0));
	block.var[2][3][0][1] = (vec4(5.0, 4.0, 2.0, -6.0));
	block.var[2][3][0][2] = (vec4(-8.0, -7.0, 4.0, 1.0));
	block.var[2][3][0][3] = (vec4(1.0, 1.0, 6.0, 2.0));
	block.var[2][3][1][0] = (vec4(-7.0, 8.0, -8.0, 4.0));
	block.var[2][3][1][1] = (vec4(2.0, 3.0, -3.0, -2.0));
	block.var[2][3][1][2] = (vec4(9.0, 1.0, -8.0, 2.0));
	block.var[2][3][1][3] = (vec4(2.0, -1.0, -9.0, 9.0));
}
#version 450
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
	u16vec3 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(block.var[0][0][0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][0][1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][1][0]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][1][1]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][2][0]), uvec3(9u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][2][1]), uvec3(9u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][3][0]), uvec3(6u, 1u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][3][1]), uvec3(5u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][0][0]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][0][1]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][1][0]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][1][1]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][2][0]), uvec3(8u, 5u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][2][1]), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][3][0]), uvec3(8u, 8u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][3][1]), uvec3(8u, 7u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][0][0]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][0][1]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][1][0]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][1][1]), uvec3(3u, 6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][2][0]), uvec3(8u, 0u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][2][1]), uvec3(2u, 3u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][3][0]), uvec3(1u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][3][1]), uvec3(3u, 7u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u16vec3(uvec3(1u, 2u, 6u));
	block.var[0][0][1] = u16vec3(uvec3(8u, 3u, 3u));
	block.var[0][1][0] = u16vec3(uvec3(4u, 7u, 0u));
	block.var[0][1][1] = u16vec3(uvec3(4u, 2u, 1u));
	block.var[0][2][0] = u16vec3(uvec3(1u, 3u, 3u));
	block.var[0][2][1] = u16vec3(uvec3(0u, 2u, 2u));
	block.var[0][3][0] = u16vec3(uvec3(6u, 1u, 7u));
	block.var[0][3][1] = u16vec3(uvec3(6u, 2u, 5u));
	block.var[1][0][0] = u16vec3(uvec3(4u, 4u, 9u));
	block.var[1][0][1] = u16vec3(uvec3(7u, 5u, 4u));
	block.var[1][1][0] = u16vec3(uvec3(0u, 2u, 8u));
	block.var[1][1][1] = u16vec3(uvec3(0u, 7u, 0u));
	block.var[1][2][0] = u16vec3(uvec3(7u, 9u, 1u));
	block.var[1][2][1] = u16vec3(uvec3(2u, 8u, 7u));
	block.var[1][3][0] = u16vec3(uvec3(3u, 6u, 4u));
	block.var[1][3][1] = u16vec3(uvec3(6u, 5u, 2u));
	block.var[2][0][0] = u16vec3(uvec3(5u, 6u, 5u));
	block.var[2][0][1] = u16vec3(uvec3(7u, 0u, 6u));
	block.var[2][1][0] = u16vec3(uvec3(2u, 8u, 7u));
	block.var[2][1][1] = u16vec3(uvec3(1u, 2u, 8u));
	block.var[2][2][0] = u16vec3(uvec3(9u, 6u, 3u));
	block.var[2][2][1] = u16vec3(uvec3(2u, 0u, 6u));
	block.var[2][3][0] = u16vec3(uvec3(3u, 1u, 1u));
	block.var[2][3][1] = u16vec3(uvec3(7u, 8u, 8u));
}
#version 450
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
	u8vec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(block.var[0][0][0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][0][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][1][0]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][1][1]), uvec2(6u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][2][0]), uvec2(8u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][2][1]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][3][0]), uvec2(6u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][3][1]), uvec2(5u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][0][0]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][0][1]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][1][0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][1][1]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][2][0]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][2][1]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][3][0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][3][1]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][0][0]), uvec2(9u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][0][1]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][1][0]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][1][1]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][2][0]), uvec2(2u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][2][1]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][3][0]), uvec2(7u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][3][1]), uvec2(3u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u8vec2(uvec2(7u, 7u));
	block.var[0][0][1] = u8vec2(uvec2(9u, 6u));
	block.var[0][1][0] = u8vec2(uvec2(2u, 7u));
	block.var[0][1][1] = u8vec2(uvec2(4u, 4u));
	block.var[0][2][0] = u8vec2(uvec2(1u, 8u));
	block.var[0][2][1] = u8vec2(uvec2(4u, 0u));
	block.var[0][3][0] = u8vec2(uvec2(7u, 4u));
	block.var[0][3][1] = u8vec2(uvec2(0u, 1u));
	block.var[1][0][0] = u8vec2(uvec2(0u, 2u));
	block.var[1][0][1] = u8vec2(uvec2(1u, 1u));
	block.var[1][1][0] = u8vec2(uvec2(7u, 2u));
	block.var[1][1][1] = u8vec2(uvec2(4u, 5u));
	block.var[1][2][0] = u8vec2(uvec2(2u, 7u));
	block.var[1][2][1] = u8vec2(uvec2(2u, 0u));
	block.var[1][3][0] = u8vec2(uvec2(2u, 3u));
	block.var[1][3][1] = u8vec2(uvec2(5u, 4u));
	block.var[2][0][0] = u8vec2(uvec2(0u, 8u));
	block.var[2][0][1] = u8vec2(uvec2(8u, 5u));
	block.var[2][1][0] = u8vec2(uvec2(0u, 2u));
	block.var[2][1][1] = u8vec2(uvec2(1u, 8u));
	block.var[2][2][0] = u8vec2(uvec2(2u, 5u));
	block.var[2][2][1] = u8vec2(uvec2(3u, 4u));
	block.var[2][3][0] = u8vec2(uvec2(4u, 2u));
	block.var[2][3][1] = u8vec2(uvec2(1u, 9u));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
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

layout(std430, buffer_reference) buffer Block
{
	highp float var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].var), 7.0) && allOk;
	allOk = compare_float((block[1].var), -1.0) && allOk;
	allOk = compare_float((block[2].var), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (-2.0);
	block[1].var = (4.0);
	block[2].var = (6.0);
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(block[0].var, mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(6.0, 9.0));
	block[0].var[1] = (vec2(-4.0, -4.0));
	block[0].var[2] = (vec2(2.0, 0.0));
	block[0].var[3] = (vec2(-7.0, 3.0));
	block[1].var[0] = (vec2(9.0, -6.0));
	block[1].var[1] = (vec2(8.0, -9.0));
	block[1].var[2] = (vec2(-9.0, -6.0));
	block[1].var[3] = (vec2(-4.0, -6.0));
	block[2].var[0] = (vec2(-8.0, 5.0));
	block[2].var[1] = (vec2(6.0, -8.0));
	block[2].var[2] = (vec2(-8.0, 3.0));
	block[2].var[3] = (vec2(2.0, 8.0));
}
#version 450
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
	u16vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block[0].padding), 1u) && allOk;
	allOk = compare_u16vec3(uvec3(block[0].var), uvec3(0u, 5u, 9u)) && allOk;
	allOk = compare_uint16_t(uint(block[1].padding), 0u) && allOk;
	allOk = compare_u16vec3(uvec3(block[1].var), uvec3(0u, 7u, 1u)) && allOk;
	allOk = compare_uint16_t(uint(block[2].padding), 1u) && allOk;
	allOk = compare_u16vec3(uvec3(block[2].var), uvec3(0u, 4u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = uint16_t(1u);
	block[0].var = u16vec3(uvec3(2u, 6u, 8u));
	block[1].padding = uint16_t(3u);
	block[1].var = u16vec3(uvec3(3u, 4u, 4u));
	block[2].padding = uint16_t(9u);
	block[2].var = u16vec3(uvec3(7u, 5u, 4u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, buffer_reference) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
};
layout(std140, buffer_reference) buffer BlockB
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
	allOk = compare_float((blockA[0].a), -8.0) && allOk;
	allOk = compare_float(blockA[0].c[0][0], -5.0) && allOk;
	allOk = compare_float(blockA[0].c[0][1], 7.0) && allOk;
	allOk = compare_float(blockA[0].c[1][0], -9.0) && allOk;
	allOk = compare_float(blockA[0].c[1][1], -9.0) && allOk;
	allOk = compare_vec2(blockA[0].c[0], vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2(blockA[0].c[1], vec2(-9.0, -9.0)) && allOk;
	allOk = compare_float((blockA[1].a), -8.0) && allOk;
	allOk = compare_float(blockA[1].c[0][0], 2.0) && allOk;
	allOk = compare_float(blockA[1].c[0][1], 3.0) && allOk;
	allOk = compare_float(blockA[1].c[1][0], 1.0) && allOk;
	allOk = compare_float(blockA[1].c[1][1], -1.0) && allOk;
	allOk = compare_vec2(blockA[1].c[0], vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec2(blockA[1].c[1], vec2(1.0, -1.0)) && allOk;
	allOk = compare_float((blockA[2].a), -5.0) && allOk;
	allOk = compare_float(blockA[2].c[0][0], -9.0) && allOk;
	allOk = compare_float(blockA[2].c[0][1], -8.0) && allOk;
	allOk = compare_float(blockA[2].c[1][0], -6.0) && allOk;
	allOk = compare_float(blockA[2].c[1][1], -4.0) && allOk;
	allOk = compare_vec2(blockA[2].c[0], vec2(-9.0, -8.0)) && allOk;
	allOk = compare_vec2(blockA[2].c[1], vec2(-6.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(6, 5)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-9, -3)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(-6, 4)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-7.0);
	blockA[1].a = (-6.0);
	blockA[2].a = (2.0);
	blockB[0].a[0] = (vec3(-1.0, 0.0, 7.0));
	blockB[0].a[1] = (vec3(1.0, -1.0, -4.0));
	blockB[0].a[2] = (vec3(9.0, -6.0, -6.0));
	blockB[0].d = (true);
	blockB[1].a[0] = (vec3(-2.0, 5.0, -6.0));
	blockB[1].a[1] = (vec3(9.0, -5.0, 4.0));
	blockB[1].a[2] = (vec3(2.0, 8.0, -2.0));
	blockB[1].d = (false);
	blockB[2].a[0] = (vec3(9.0, -5.0, 2.0));
	blockB[2].a[1] = (vec3(4.0, -7.0, 7.0));
	blockB[2].a[2] = (vec3(3.0, 9.0, 6.0));
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

layout(std430, row_major, buffer_reference) buffer BlockB
{
	mediump float a;
	highp int b;
	bvec3 c;
	highp mat3x4 d[8];
	highp ivec2 e[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uvec2 f;
	lowp mat4 g;
	bool h[];
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump mat2 i;
	mediump mat2 j[4];
	mediump ivec2 k[6];
	mediump mat3x2 l[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b), 2) && allOk;
	allOk = compare_bvec3((blockB.c), bvec3(false, false, false)) && allOk;
	allOk = compare_ivec2((blockB.e[0]), ivec2(4, -3)) && allOk;
	allOk = compare_ivec2((blockB.e[1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((blockB.e[2]), ivec2(1, 8)) && allOk;
	allOk = compare_ivec2((blockB.e[3]), ivec2(0, -3)) && allOk;
	allOk = compare_ivec2((blockB.e[4]), ivec2(-8, 6)) && allOk;
	allOk = compare_ivec2((blockB.e[5]), ivec2(-2, 5)) && allOk;
	allOk = compare_mat4(blockC.g, mat4(-5.0, 4.0, 9.0, -1.0, -4.0, 2.0, 4.0, 4.0, 0.0, 7.0, 4.0, 8.0, -9.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2(blockD.j[0], mat2(-4.0, 5.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2(blockD.j[1], mat2(5.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2(blockD.j[2], mat2(-7.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2(blockD.j[3], mat2(1.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockD.k[0]), ivec2(-1, -2)) && allOk;
	allOk = compare_ivec2((blockD.k[1]), ivec2(9, 6)) && allOk;
	allOk = compare_ivec2((blockD.k[2]), ivec2(9, -6)) && allOk;
	allOk = compare_ivec2((blockD.k[3]), ivec2(5, 2)) && allOk;
	allOk = compare_ivec2((blockD.k[4]), ivec2(-5, 9)) && allOk;
	allOk = compare_ivec2((blockD.k[5]), ivec2(2, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6.0);
	blockB.c = (bvec3(true, false, false));
	blockB.e[0] = (ivec2(8, 5));
	blockB.e[1] = (ivec2(-7, -6));
	blockB.e[2] = (ivec2(0, -5));
	blockB.e[3] = (ivec2(-7, 4));
	blockB.e[4] = (ivec2(-8, -7));
	blockB.e[5] = (ivec2(-7, -5));
	blockC.f = (uvec2(8u, 6u));
	blockC.g = (mat4(-5.0, 3.0, -1.0, -5.0, -9.0, -2.0, -7.0, -6.0, 9.0, 4.0, 1.0, -6.0, 8.0, 6.0, -1.0, -4.0));
	blockD.i = (mat2(-3.0, 8.0, -5.0, -6.0));
	blockD.k[0] = (ivec2(6, -7));
	blockD.k[1] = (ivec2(-3, -2));
	blockD.k[2] = (ivec2(-5, -9));
	blockD.k[3] = (ivec2(6, -3));
	blockD.k[4] = (ivec2(-7, -8));
	blockD.k[5] = (ivec2(3, -4));
	blockD.l[0] = (mat3x2(2.0, 9.0, 7.0, -9.0, -7.0, -2.0));
	blockD.l[1] = (mat3x2(6.0, -3.0, -6.0, 2.0, 2.0, 3.0));
	blockD.l[2] = (mat3x2(-9.0, -6.0, 0.0, 3.0, -5.0, -2.0));
	blockD.l[3] = (mat3x2(2.0, -5.0, 5.0, 0.0, 5.0, 6.0));
	blockD.l[4] = (mat3x2(9.0, -4.0, 1.0, 4.0, -7.0, -7.0));
	blockD.l[5] = (mat3x2(8.0, 7.0, -5.0, 7.0, -3.0, 5.0));
	blockD.l[6] = (mat3x2(-7.0, 6.0, 1.0, -6.0, 0.0, 8.0));
}
#version 450
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
	lowp mat4 b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	bvec4 c;
	highp mat3x2 d;
	mediump vec2 e;
	highp uint f[1];
	highp mat3x4 g[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	mediump mat3x4 h;
	bool i;
	bvec2 j[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.b[0], mat4(-5.0, -1.0, -2.0, -2.0, 0.0, -8.0, -2.0, -1.0, 3.0, 2.0, 4.0, 1.0, 7.0, 8.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockC.d, mat3x2(-6.0, 8.0, -7.0, -2.0, 2.0, 8.0)) && allOk;
	allOk = compare_vec2((blockC.e), vec2(0.0, 2.0)) && allOk;
	allOk = compare_uint((blockC.f[0]), 3u) && allOk;
	allOk = compare_mat3x4(blockD.h, mat3x4(0.0, 6.0, 7.0, 2.0, -4.0, -9.0, -8.0, 2.0, -3.0, 6.0, 1.0, 7.0)) && allOk;
	allOk = compare_bool((blockD.i), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(6.0, 3.0, -9.0));
	blockB.b[0] = (mat4(0.0, 6.0, -8.0, -6.0, 9.0, -6.0, -7.0, -9.0, 2.0, 3.0, -8.0, 9.0, -6.0, 5.0, 3.0, -9.0));
	blockC.c = (bvec4(false, false, true, true));
	blockC.g[0] = (mat3x4(-3.0, 0.0, -5.0, 0.0, 2.0, 2.0, -3.0, 8.0, 0.0, -8.0, -3.0, -9.0));
	blockD.j[0] = (bvec2(true, true));
}
#version 450
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
	highp mat3x2 a[1];
	highp int b;
	highp mat3x2 c;
	mediump uvec3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB[0].a[0], mat3x2(2.0, 7.0, -8.0, 4.0, -4.0, 0.0)) && allOk;
	allOk = compare_int((blockB[0].b), -5) && allOk;
	allOk = compare_uvec3((blockB[0].d[0]), uvec3(6u, 9u, 2u)) && allOk;
	allOk = compare_mat3x2(blockB[1].a[0], mat3x2(-7.0, 8.0, 7.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_int((blockB[1].b), -8) && allOk;
	allOk = compare_uvec3((blockB[1].d[0]), uvec3(3u, 7u, 9u)) && allOk;
	allOk = compare_mat3x2(blockB[2].a[0], mat3x2(3.0, 8.0, 6.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_int((blockB[2].b), 6) && allOk;
	allOk = compare_uvec3((blockB[2].d[0]), uvec3(0u, 1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (mat3x2(8.0, -6.0, -2.0, 6.0, -1.0, 0.0));
	blockB[0].b = (9);
	blockB[0].c = (mat3x2(5.0, 6.0, 4.0, 7.0, 8.0, -5.0));
	blockB[0].d[0] = (uvec3(3u, 0u, 7u));
	blockB[1].a[0] = (mat3x2(4.0, 9.0, 7.0, -4.0, 0.0, -5.0));
	blockB[1].b = (4);
	blockB[1].c = (mat3x2(9.0, -2.0, -7.0, -4.0, -6.0, 8.0));
	blockB[1].d[0] = (uvec3(5u, 4u, 6u));
	blockB[2].a[0] = (mat3x2(-3.0, -6.0, -6.0, -7.0, 8.0, -1.0));
	blockB[2].b = (4);
	blockB[2].c = (mat3x2(-7.0, 4.0, 2.0, -6.0, -1.0, 5.0));
	blockB[2].d[0] = (uvec3(2u, 0u, 0u));
}
#version 450
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
	layout(offset = 0) mediump ivec4 a;
	layout(offset = 16) highp vec3 b[1];
	layout(offset = 32) bvec4 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bool d;
	layout(offset = 4) bvec3 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) highp vec3 f;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) bool g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(-4, -3, 9, 4)) && allOk;
	allOk = compare_vec3((blockB.b[0]), vec3(3.0, -2.0, 6.0)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bool((blockC.d), false) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(true, false, false)) && allOk;
	allOk = compare_vec3((blockD.f), vec3(-2.0, -3.0, -8.0)) && allOk;
	allOk = compare_bool((blockE.g), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(2, 9, -1, -2));
	blockB.c = (bvec4(true, true, true, false));
	blockC.d = (false);
	blockC.e = (bvec3(false, false, false));
	blockD.f = (vec3(-4.0, 9.0, 9.0));
	blockE.g = (false);
}
#version 450
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
	mediump vec4 a;
	bvec3 b;
	mediump int c;
	lowp mat4x3 d;
	bvec4 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-8.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockB.d, mat4x3(0.0, 1.0, -1.0, -9.0, -2.0, -8.0, 1.0, -8.0, -7.0, 8.0, -6.0, 7.0)) && allOk;
	allOk = compare_bvec4((blockB.e[0]), bvec4(false, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(1.0, 1.0, -4.0, 1.0));
	blockB.b = (bvec3(true, true, false));
	blockB.c = (0);
	blockB.d = (mat4x3(-9.0, -1.0, -3.0, -6.0, -4.0, 6.0, 3.0, -7.0, 5.0, 4.0, -8.0, -2.0));
}
#version 450
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
	highp uvec4 a[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (uvec4(7u, 4u, 8u, 3u));
	blockB[nonuniformEXT(1)].a[0] = (uvec4(7u, 9u, 2u, 0u));
}
#version 450
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
	mediump vec2 a[1];
	lowp ivec3 b;
	bvec4 c[1];
	mediump ivec2 d;
	mediump uvec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

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

layout(std430, column_major, buffer_reference) buffer BlockB
{
	highp vec3 a;
	highp mat2x3 b;
	bvec2 c;
	mediump mat4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB[nonuniformEXT(0)].b, mat2x3(3.0, 7.0, -3.0, 2.0, -1.0, 9.0)) && allOk;
	allOk = compare_bvec2((blockB[nonuniformEXT(0)].c), bvec2(true, false)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(1)].b, mat2x3(2.0, 6.0, 8.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_bvec2((blockB[nonuniformEXT(1)].c), bvec2(true, true)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(2)].b, mat2x3(-2.0, 0.0, -7.0, 2.0, 9.0, -1.0)) && allOk;
	allOk = compare_bvec2((blockB[nonuniformEXT(2)].c), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec3(-7.0, -2.0, 8.0));
	blockB[nonuniformEXT(0)].d = (mat4(-8.0, -8.0, -8.0, -4.0, 2.0, -8.0, -2.0, 1.0, 7.0, 6.0, -3.0, -9.0, 6.0, 6.0, -6.0, -5.0));
	blockB[nonuniformEXT(1)].a = (vec3(-4.0, -2.0, -5.0));
	blockB[nonuniformEXT(1)].d = (mat4(5.0, 9.0, -9.0, 3.0, 3.0, 8.0, 4.0, 3.0, 6.0, -3.0, -5.0, 5.0, 0.0, -2.0, 2.0, 1.0));
	blockB[nonuniformEXT(2)].a = (vec3(0.0, 8.0, 7.0));
	blockB[nonuniformEXT(2)].d = (mat4(7.0, -5.0, 1.0, 9.0, -6.0, -5.0, 6.0, 9.0, -1.0, 4.0, -3.0, -6.0, 1.0, 0.0, -9.0, -2.0));
}
#version 450
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
	highp vec3 a;
	i16vec4 b;
	lowp ivec3 c[1];
	mediump vec3 d;
	highp ivec3 e;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump uint f;
	lowp uvec3 g;
	i16vec4 h;
	float16_t i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.b), ivec4(7, 4, 1, 9)) && allOk;
	allOk = compare_ivec3((blockB.c[0]), ivec3(3, -5, -8)) && allOk;
	allOk = compare_vec3((blockB.d), vec3(-6.0, 0.0, 7.0)) && allOk;
	allOk = compare_ivec3((blockB.e), ivec3(-1, -1, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.h), ivec4(-7, -4, -7, -7)) && allOk;
	allOk = compare_float16_t(float(blockC.i), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(-5.0, 4.0, -9.0));
	blockB.b = i16vec4(ivec4(-7, -8, 8, 4));
	blockB.d = (vec3(-7.0, 5.0, 2.0));
	blockB.e = (ivec3(-4, -8, 0));
	blockC.i = float16_t(3.0);
}
#version 450
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
	lowp uvec3 a;
	u16vec3 b[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	bvec2 c;
	highp vec2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_bvec2((blockC.c), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(5u, 2u, 5u));
	blockC.c = (bvec2(false, false));
	blockC.d[0] = (vec2(-7.0, -5.0));
}
#version 450
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
	u16vec4 a;
	lowp vec2 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.a), uvec4(4u, 9u, 6u, 3u)) && allOk;
	allOk = compare_vec2((blockB.b[0]), vec2(0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(8u, 6u, 1u, 3u));
}
#version 450
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
	i16vec2 a;
	lowp mat4x3 b;
	highp vec3 c;
	highp mat3x2 d[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp mat2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.a), ivec2(2, -8)) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(-4.0, 7.0, 4.0, 0.0, -5.0, -8.0, -6.0, 4.0, 5.0, 6.0, -6.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[0], mat3x2(7.0, 5.0, 8.0, 5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[1], mat3x2(6.0, 2.0, 3.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[2], mat3x2(-9.0, 1.0, 1.0, 3.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[3], mat3x2(8.0, 6.0, -4.0, 6.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[4], mat3x2(8.0, -9.0, -5.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[5], mat3x2(7.0, -8.0, 5.0, -1.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[6], mat3x2(-7.0, -7.0, 7.0, 6.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[7], mat3x2(9.0, 1.0, 5.0, 3.0, -6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec2(ivec2(8, -2));
	blockB.c = (vec3(-2.0, 7.0, 4.0));
	blockB.d[0] = (mat3x2(7.0, 0.0, 9.0, -4.0, -5.0, 4.0));
	blockB.d[1] = (mat3x2(9.0, -7.0, -6.0, -2.0, -4.0, 8.0));
	blockB.d[2] = (mat3x2(-6.0, -4.0, 6.0, -3.0, -6.0, 8.0));
	blockB.d[3] = (mat3x2(-6.0, -7.0, -1.0, 4.0, -7.0, 2.0));
	blockB.d[4] = (mat3x2(-1.0, 4.0, -6.0, 5.0, -5.0, -1.0));
	blockB.d[5] = (mat3x2(-2.0, -3.0, -7.0, 8.0, -6.0, 7.0));
	blockB.d[6] = (mat3x2(9.0, 8.0, -3.0, -4.0, 4.0, 9.0));
	blockB.d[7] = (mat3x2(0.0, 1.0, 2.0, -3.0, -9.0, -9.0));
	blockC.e[0] = (mat2(0.0, -6.0, -8.0, 4.0));
	blockC.e[1] = (mat2(-1.0, -8.0, -9.0, 0.0));
	blockC.e[2] = (mat2(0.0, 9.0, -9.0, 4.0));
	blockC.e[3] = (mat2(7.0, 6.0, 6.0, -5.0));
}
#version 450
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
	lowp ivec3 mB;
};
struct sB
{
	f16vec4 mA;
};
struct sC
{
	mediump uvec2 mA;
	sB mB;
	u16vec2 mC;
	bool mD;
};
struct sD
{
	mediump mat3x2 mA;
	mediump int mB;
};
layout(std140, buffer_reference) buffer BlockB
{
	sA a;
	bvec2 b;
	highp mat3 c[1];
	sC d;
	sD e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[0].b), bvec2(true, true)) && allOk;
	allOk = compare_mat3x2(blockB[0].e.mA, mat3x2(8.0, 2.0, -5.0, 9.0, 3.0, -5.0)) && allOk;
	allOk = compare_int((blockB[0].e.mB), -3) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (ivec4(-5, 9, 5, 5));
	blockB[0].a.mB = (ivec3(-3, -5, -8));
	blockB[0].b = (bvec2(false, true));
	blockB[0].c[0] = (mat3(6.0, 1.0, 9.0, -5.0, 9.0, -3.0, 6.0, 7.0, -9.0));
	blockB[0].d.mA = (uvec2(0u, 1u));
	blockB[0].d.mB.mA = f16vec4(vec4(3.0, 5.0, 3.0, 9.0));
	blockB[0].d.mC = u16vec2(uvec2(5u, 3u));
	blockB[0].d.mD = (true);
	blockB[0].e.mA = (mat3x2(-1.0, 2.0, 0.0, 5.0, 3.0, -3.0));
	blockB[0].e.mB = (2);
}
#version 450
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
	layout(offset = 16) lowp vec4 b;
	layout(offset = 32) int16_t c;
	layout(offset = 36) bvec3 d;
	layout(offset = 48) mediump vec3 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) uint16_t f;
	layout(offset = 4) bvec2 g;
	layout(offset = 16) bvec4 h;
	layout(offset = 32) lowp uint i;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec4 j;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) i16vec4 k;
	layout(offset = 8) f16vec2 l;
	layout(offset = 16) i16vec4 m;
	layout(offset = 24) highp uint n;
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
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b), vec4(1.0, -2.0, -8.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockB.d), bvec3(true, true, true)) && allOk;
	allOk = compare_vec3((blockB.e), vec3(-4.0, 7.0, -1.0)) && allOk;
	allOk = compare_bvec2((blockC.g), bvec2(false, false)) && allOk;
	allOk = compare_uint((blockC.i), 2u) && allOk;
	allOk = compare_bvec4((blockD.j), bvec4(true, true, false, true)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.k), ivec4(8, -2, 1, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.m), ivec4(2, 7, 0, -1)) && allOk;
	allOk = compare_uint((blockE.n), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockB.b = (vec4(9.0, 5.0, 9.0, 5.0));
	blockB.c = int16_t(-5);
	blockB.d = (bvec3(true, false, true));
	blockB.e = (vec3(2.0, 7.0, 9.0));
	blockC.f = uint16_t(2u);
	blockC.h = (bvec4(false, true, true, false));
	blockC.i = (9u);
	blockD.j = (bvec4(false, true, true, false));
	blockE.k = i16vec4(ivec4(1, -3, -4, -9));
	blockE.l = f16vec2(vec2(-2.0, 1.0));
	blockE.n = (2u);
}
#version 450
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
	layout(offset = 0) float16_t b;
	layout(offset = 4) highp int c[1];
	layout(offset = 16) mediump uvec4 d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) u16vec2 e;
	layout(offset = 4) lowp ivec3 f;
	layout(offset = 16) uint16_t g[1];
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) i16vec2 h;
	layout(offset = 4) lowp vec3 i;
	layout(offset = 16) int16_t j;
	layout(offset = 32) lowp uvec4 k;
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-9.0, 1.0)) && allOk;
	allOk = compare_float16_t(float(blockC[0].b), 0.0) && allOk;
	allOk = compare_int((blockC[0].c[0]), -9) && allOk;
	allOk = compare_uvec4((blockC[0].d), uvec4(6u, 5u, 4u, 1u)) && allOk;
	allOk = compare_float16_t(float(blockC[1].b), -1.0) && allOk;
	allOk = compare_int((blockC[1].c[0]), 1) && allOk;
	allOk = compare_uvec4((blockC[1].d), uvec4(9u, 1u, 8u, 4u)) && allOk;
	allOk = compare_float16_t(float(blockC[2].b), -1.0) && allOk;
	allOk = compare_int((blockC[2].c[0]), -2) && allOk;
	allOk = compare_uvec4((blockC[2].d), uvec4(5u, 3u, 4u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.e), uvec2(8u, 4u)) && allOk;
	allOk = compare_ivec3((blockD.f), ivec3(6, 7, 7)) && allOk;
	allOk = compare_vec3((blockE.i), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_uvec4((blockE.k), uvec4(0u, 1u, 0u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(-4.0, 7.0));
	blockC[0].b = float16_t(8.0);
	blockC[0].c[0] = (2);
	blockC[0].d = (uvec4(9u, 7u, 0u, 9u));
	blockC[1].b = float16_t(6.0);
	blockC[1].c[0] = (-8);
	blockC[1].d = (uvec4(9u, 3u, 2u, 5u));
	blockC[2].b = float16_t(3.0);
	blockC[2].c[0] = (-4);
	blockC[2].d = (uvec4(5u, 5u, 4u, 9u));
	blockD.g[0] = uint16_t(2u);
	blockE.h = i16vec2(ivec2(3, 0));
	blockE.i = (vec3(-9.0, 3.0, -5.0));
	blockE.j = int16_t(4);
}
#version 450
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
	highp mat2 a[2];
	bool b[3];
	bvec2 c;
	lowp mat4x2 d;
	highp vec2 e[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	mediump mat2 f;
	mediump ivec4 g;
	lowp ivec3 h[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	float16_t i;
	uint16_t j;
	bvec2 k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a[0], mat2(-5.0, -8.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat2(blockB.a[1], mat2(1.0, 0.0, 9.0, -3.0)) && allOk;
	allOk = compare_bool((blockB.b[0]), false) && allOk;
	allOk = compare_bool((blockB.b[1]), true) && allOk;
	allOk = compare_bool((blockB.b[2]), false) && allOk;
	allOk = compare_mat4x2(blockB.d, mat4x2(1.0, -5.0, 1.0, 1.0, 9.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_vec2((blockB.e[0]), vec2(9.0, -5.0)) && allOk;
	allOk = compare_vec2((blockB.e[1]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB.e[2]), vec2(-5.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB.e[3]), vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB.e[4]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB.e[5]), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB.e[6]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB.e[7]), vec2(5.0, -4.0)) && allOk;
	allOk = compare_mat2(blockC.f, mat2(9.0, 9.0, 1.0, -9.0)) && allOk;
	allOk = compare_ivec4((blockC.g), ivec4(-1, -8, -5, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat2(-4.0, 1.0, 4.0, -2.0));
	blockB.a[1] = (mat2(5.0, -5.0, 0.0, 4.0));
	blockB.b[0] = (true);
	blockB.b[1] = (false);
	blockB.b[2] = (false);
	blockB.d = (mat4x2(-7.0, -6.0, -6.0, -2.0, 8.0, 4.0, -3.0, 2.0));
	blockB.e[0] = (vec2(4.0, 6.0));
	blockB.e[1] = (vec2(-4.0, 2.0));
	blockB.e[2] = (vec2(-2.0, -3.0));
	blockB.e[3] = (vec2(-1.0, 5.0));
	blockB.e[4] = (vec2(3.0, 8.0));
	blockB.e[5] = (vec2(2.0, -8.0));
	blockB.e[6] = (vec2(-6.0, 9.0));
	blockB.e[7] = (vec2(7.0, -4.0));
	blockC.f = (mat2(2.0, -4.0, 9.0, -5.0));
	blockD.i = float16_t(-6.0);
	blockD.j = uint16_t(3u);
	blockD.k[0] = (bvec2(false, false));
	blockD.k[1] = (bvec2(true, false));
	blockD.k[2] = (bvec2(true, true));
	blockD.k[3] = (bvec2(true, false));
	blockD.k[4] = (bvec2(true, true));
}
#version 450
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
	mediump uint a;
	highp float b;
	highp uint c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockB.b = (-4.0);
	blockB.c = (8u);
}
#version 450
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
	i8vec3 b;
	int8_t c;
	i8vec3 d;
	bvec4 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(4.0, -1.0, 1.0, 6.0, 1.0, 9.0, -6.0, -4.0, 2.0, -9.0, 6.0, 8.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b), ivec3(4294967287, 4294967290, 4294967291)) && allOk;
	allOk = compare_int8_t(int(blockB.c), 4294967288) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.d), ivec3(7, 4294967289, 4294967295)) && allOk;
	allOk = compare_bvec4((blockB.e[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockB.e[1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockB.e[2]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockB.e[3]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockB.e[4]), bvec4(true, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = int8_t(9);
	blockB.d = i8vec3(ivec3(1, 2, 4294967290));
}
#version 450
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
	mediump uvec2 mB;
	mediump mat2x3 mC;
	highp uvec2 mD;
};
struct sB
{
	highp uint mA;
	i8vec4 mB;
};
struct sC
{
	mediump mat4 mA;
	sB mB;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	i8vec3 a;
	i8vec3 b;
	sA c[];
};
layout(std430, buffer_reference) buffer BlockC
{
	sC d;
	lowp vec3 e;
	i8vec2 f;
	highp mat2x3 g;
	lowp mat4 h[];
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
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB.a), ivec3(4294967291, 5, 4294967290)) && allOk;
	allOk = compare_bvec4((blockB.c[0].mA), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uvec2((blockB.c[0].mB), uvec2(1u, 8u)) && allOk;
	allOk = compare_mat2x3(blockB.c[0].mC, mat2x3(2.0, 7.0, -1.0, -4.0, 7.0, 3.0)) && allOk;
	allOk = compare_uvec2((blockB.c[0].mD), uvec2(8u, 1u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.f), ivec2(4294967293, 2)) && allOk;
	allOk = compare_mat4(blockC.h[0], mat4(-3.0, 8.0, 3.0, -1.0, 0.0, -6.0, -5.0, -3.0, -5.0, 2.0, -9.0, 0.0, 5.0, -4.0, 4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec3(ivec3(3, 4294967292, 2));
	blockC.d.mA = (mat4(3.0, -2.0, 9.0, 0.0, 6.0, -5.0, 5.0, 5.0, -5.0, -2.0, -4.0, -4.0, -9.0, -5.0, 4.0, -3.0));
	blockC.d.mB.mA = (8u);
	blockC.d.mB.mB = i8vec4(ivec4(4294967288, 9, 4, 4));
	blockC.f = i8vec2(ivec2(4294967294, 4294967290));
	blockC.g = (mat2x3(-9.0, 2.0, 6.0, -9.0, -4.0, 6.0));
	blockC.h[0] = (mat4(0.0, -2.0, -5.0, -5.0, -4.0, -9.0, 7.0, -1.0, -8.0, 9.0, 2.0, 5.0, -2.0, -5.0, 0.0, -4.0));
}
#version 450
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
};
struct sB
{
	highp ivec4 mA[1];
	mediump float mB;
	int8_t mC[7];
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	mediump mat4x2 a[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	highp uvec3 b;
	i8vec4 c;
	highp mat3x4 d;
	highp ivec3 e;
	sA f[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	u8vec2 g;
	mediump uvec4 h;
	lowp vec2 i;
	sB j[];
};
layout(scalar, row_major, buffer_reference) buffer BlockE
{
	u8vec2 k;
	mediump ivec4 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a[0], mat4x2(4.0, 7.0, -6.0, 0.0, -2.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_uvec3((blockC[0].b), uvec3(4u, 4u, 4u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[0].c), ivec4(3, 5, 4294967289, 4)) && allOk;
	allOk = compare_mat3x4(blockC[0].d, mat3x4(5.0, -2.0, 3.0, 8.0, -1.0, -8.0, 7.0, -3.0, 0.0, 2.0, -4.0, 3.0)) && allOk;
	allOk = compare_ivec3((blockC[0].e), ivec3(4, 2, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[0].f[0].mA), ivec4(3, 4294967287, 4294967294, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[0].f[1].mA), ivec4(6, 8, 3, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[0].f[2].mA), ivec4(4294967287, 4294967292, 4294967294, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[0].f[3].mA), ivec4(4294967290, 4, 4294967287, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[0].f[4].mA), ivec4(1, 9, 4294967293, 6)) && allOk;
	allOk = compare_uvec3((blockC[1].b), uvec3(6u, 2u, 6u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[1].c), ivec4(4294967293, 1, 4294967293, 4294967289)) && allOk;
	allOk = compare_mat3x4(blockC[1].d, mat3x4(4.0, 1.0, -6.0, -4.0, -9.0, -2.0, -5.0, 1.0, -6.0, -2.0, 7.0, -5.0)) && allOk;
	allOk = compare_ivec3((blockC[1].e), ivec3(3, 9, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[1].f[0].mA), ivec4(7, 9, 1, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[1].f[1].mA), ivec4(8, 4294967288, 4294967294, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[1].f[2].mA), ivec4(4294967291, 5, 7, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[1].f[3].mA), ivec4(4294967290, 3, 6, 2)) && allOk;
	allOk = compare_uvec3((blockC[2].b), uvec3(1u, 8u, 1u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[2].c), ivec4(4294967291, 4294967288, 1, 4294967288)) && allOk;
	allOk = compare_mat3x4(blockC[2].d, mat3x4(8.0, 3.0, -5.0, 5.0, 6.0, 7.0, 9.0, -5.0, -5.0, 0.0, -9.0, -3.0)) && allOk;
	allOk = compare_ivec3((blockC[2].e), ivec3(1, 4, -3)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[2].f[0].mA), ivec4(5, 3, 6, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[2].f[1].mA), ivec4(4294967292, 4294967294, 4294967294, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[2].f[2].mA), ivec4(7, 3, 4, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[2].f[3].mA), ivec4(8, 4294967287, 1, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[2].f[4].mA), ivec4(8, 1, 8, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[2].f[5].mA), ivec4(4294967289, 7, 7, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[2].f[6].mA), ivec4(4294967295, 4294967288, 3, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[2].f[7].mA), ivec4(4294967287, 6, 4294967292, 5)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.g), uvec2(4u, 1u)) && allOk;
	allOk = compare_vec2((blockD.i), vec2(-5.0, 9.0)) && allOk;
	allOk = compare_ivec4((blockD.j[0].mA[0]), ivec4(-7, -8, 6, -6)) && allOk;
	allOk = compare_float((blockD.j[0].mB), -6.0) && allOk;
	allOk = compare_int8_t(int(blockD.j[0].mC[0]), 2) && allOk;
	allOk = compare_int8_t(int(blockD.j[0].mC[1]), 4294967293) && allOk;
	allOk = compare_int8_t(int(blockD.j[0].mC[2]), 1) && allOk;
	allOk = compare_int8_t(int(blockD.j[0].mC[3]), 4) && allOk;
	allOk = compare_int8_t(int(blockD.j[0].mC[4]), 4294967293) && allOk;
	allOk = compare_int8_t(int(blockD.j[0].mC[5]), 4294967290) && allOk;
	allOk = compare_int8_t(int(blockD.j[0].mC[6]), 9) && allOk;
	allOk = compare_ivec4((blockD.j[1].mA[0]), ivec4(2, 6, -4, -7)) && allOk;
	allOk = compare_float((blockD.j[1].mB), -2.0) && allOk;
	allOk = compare_int8_t(int(blockD.j[1].mC[0]), 4294967287) && allOk;
	allOk = compare_int8_t(int(blockD.j[1].mC[1]), 4294967292) && allOk;
	allOk = compare_int8_t(int(blockD.j[1].mC[2]), 0) && allOk;
	allOk = compare_int8_t(int(blockD.j[1].mC[3]), 5) && allOk;
	allOk = compare_int8_t(int(blockD.j[1].mC[4]), 4294967289) && allOk;
	allOk = compare_int8_t(int(blockD.j[1].mC[5]), 6) && allOk;
	allOk = compare_int8_t(int(blockD.j[1].mC[6]), 1) && allOk;
	allOk = compare_ivec4((blockD.j[2].mA[0]), ivec4(-7, -6, 7, 0)) && allOk;
	allOk = compare_float((blockD.j[2].mB), -7.0) && allOk;
	allOk = compare_int8_t(int(blockD.j[2].mC[0]), 4294967293) && allOk;
	allOk = compare_int8_t(int(blockD.j[2].mC[1]), 4294967289) && allOk;
	allOk = compare_int8_t(int(blockD.j[2].mC[2]), 4294967288) && allOk;
	allOk = compare_int8_t(int(blockD.j[2].mC[3]), 1) && allOk;
	allOk = compare_int8_t(int(blockD.j[2].mC[4]), 3) && allOk;
	allOk = compare_int8_t(int(blockD.j[2].mC[5]), 4294967287) && allOk;
	allOk = compare_int8_t(int(blockD.j[2].mC[6]), 4294967288) && allOk;
	allOk = compare_ivec4((blockD.j[3].mA[0]), ivec4(-2, 8, 9, 3)) && allOk;
	allOk = compare_float((blockD.j[3].mB), -1.0) && allOk;
	allOk = compare_int8_t(int(blockD.j[3].mC[0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(blockD.j[3].mC[1]), 0) && allOk;
	allOk = compare_int8_t(int(blockD.j[3].mC[2]), 4294967292) && allOk;
	allOk = compare_int8_t(int(blockD.j[3].mC[3]), 4294967294) && allOk;
	allOk = compare_int8_t(int(blockD.j[3].mC[4]), 3) && allOk;
	allOk = compare_int8_t(int(blockD.j[3].mC[5]), 9) && allOk;
	allOk = compare_int8_t(int(blockD.j[3].mC[6]), 4294967293) && allOk;
	allOk = compare_ivec4((blockD.j[4].mA[0]), ivec4(-2, -4, 6, 6)) && allOk;
	allOk = compare_float((blockD.j[4].mB), 6.0) && allOk;
	allOk = compare_int8_t(int(blockD.j[4].mC[0]), 4294967295) && allOk;
	allOk = compare_int8_t(int(blockD.j[4].mC[1]), 0) && allOk;
	allOk = compare_int8_t(int(blockD.j[4].mC[2]), 4294967292) && allOk;
	allOk = compare_int8_t(int(blockD.j[4].mC[3]), 4294967289) && allOk;
	allOk = compare_int8_t(int(blockD.j[4].mC[4]), 2) && allOk;
	allOk = compare_int8_t(int(blockD.j[4].mC[5]), 4294967290) && allOk;
	allOk = compare_int8_t(int(blockD.j[4].mC[6]), 4294967295) && allOk;
	allOk = compare_u8vec2(uvec2(blockE.k), uvec2(0u, 3u)) && allOk;
	allOk = compare_ivec4((blockE.l[0]), ivec4(5, 1, -3, 3)) && allOk;
	allOk = compare_ivec4((blockE.l[1]), ivec4(-5, 8, 9, 9)) && allOk;
	allOk = compare_ivec4((blockE.l[2]), ivec4(2, -9, 6, 3)) && allOk;
	allOk = compare_ivec4((blockE.l[3]), ivec4(-1, 7, 8, 3)) && allOk;
	allOk = compare_ivec4((blockE.l[4]), ivec4(1, -5, -7, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x2(9.0, 2.0, 5.0, 0.0, -3.0, 0.0, -2.0, 1.0));
	blockC[0].b = (uvec3(2u, 8u, 4u));
	blockC[0].c = i8vec4(ivec4(0, 3, 4294967287, 4294967288));
	blockC[0].f[0].mA = i8vec4(ivec4(4294967294, 4294967291, 4294967292, 4294967291));
	blockC[0].f[1].mA = i8vec4(ivec4(4294967294, 1, 4294967293, 8));
	blockC[0].f[2].mA = i8vec4(ivec4(0, 1, 4294967293, 4));
	blockC[0].f[3].mA = i8vec4(ivec4(4294967295, 5, 8, 6));
	blockC[0].f[4].mA = i8vec4(ivec4(4294967295, 4294967292, 4294967293, 4294967289));
	blockC[1].b = (uvec3(5u, 2u, 9u));
	blockC[1].c = i8vec4(ivec4(1, 0, 4294967292, 4294967293));
	blockC[1].f[0].mA = i8vec4(ivec4(1, 7, 4294967289, 3));
	blockC[1].f[1].mA = i8vec4(ivec4(7, 4294967291, 4294967288, 4294967291));
	blockC[1].f[2].mA = i8vec4(ivec4(7, 4294967291, 8, 5));
	blockC[1].f[3].mA = i8vec4(ivec4(4294967289, 4294967288, 4294967287, 4294967292));
	blockC[2].b = (uvec3(6u, 2u, 7u));
	blockC[2].c = i8vec4(ivec4(5, 4294967293, 4294967294, 7));
	blockC[2].f[0].mA = i8vec4(ivec4(4294967287, 4294967287, 1, 0));
	blockC[2].f[1].mA = i8vec4(ivec4(6, 4294967293, 5, 4294967289));
	blockC[2].f[2].mA = i8vec4(ivec4(4294967294, 4294967294, 1, 4294967293));
	blockC[2].f[3].mA = i8vec4(ivec4(2, 4294967287, 8, 9));
	blockC[2].f[4].mA = i8vec4(ivec4(1, 4294967289, 4294967289, 4294967293));
	blockC[2].f[5].mA = i8vec4(ivec4(7, 4294967293, 4, 4294967293));
	blockC[2].f[6].mA = i8vec4(ivec4(5, 6, 5, 4294967289));
	blockC[2].f[7].mA = i8vec4(ivec4(4294967292, 4294967288, 5, 1));
	blockD.g = u8vec2(uvec2(2u, 3u));
	blockD.i = (vec2(1.0, 7.0));
	blockD.j[0].mA[0] = (ivec4(1, -6, -9, -8));
	blockD.j[0].mB = (0.0);
	blockD.j[0].mC[0] = int8_t(4);
	blockD.j[0].mC[1] = int8_t(4294967290);
	blockD.j[0].mC[2] = int8_t(1);
	blockD.j[0].mC[3] = int8_t(4294967293);
	blockD.j[0].mC[4] = int8_t(4294967293);
	blockD.j[0].mC[5] = int8_t(3);
	blockD.j[0].mC[6] = int8_t(8);
	blockD.j[1].mA[0] = (ivec4(0, 5, 5, -4));
	blockD.j[1].mB = (-6.0);
	blockD.j[1].mC[0] = int8_t(4294967295);
	blockD.j[1].mC[1] = int8_t(4294967292);
	blockD.j[1].mC[2] = int8_t(2);
	blockD.j[1].mC[3] = int8_t(4294967295);
	blockD.j[1].mC[4] = int8_t(4);
	blockD.j[1].mC[5] = int8_t(7);
	blockD.j[1].mC[6] = int8_t(2);
	blockD.j[2].mA[0] = (ivec4(3, 6, -4, -8));
	blockD.j[2].mB = (-3.0);
	blockD.j[2].mC[0] = int8_t(3);
	blockD.j[2].mC[1] = int8_t(9);
	blockD.j[2].mC[2] = int8_t(7);
	blockD.j[2].mC[3] = int8_t(1);
	blockD.j[2].mC[4] = int8_t(4294967295);
	blockD.j[2].mC[5] = int8_t(4294967294);
	blockD.j[2].mC[6] = int8_t(4294967295);
	blockD.j[3].mA[0] = (ivec4(-8, -9, -1, -4));
	blockD.j[3].mB = (-1.0);
	blockD.j[3].mC[0] = int8_t(8);
	blockD.j[3].mC[1] = int8_t(4294967291);
	blockD.j[3].mC[2] = int8_t(4294967291);
	blockD.j[3].mC[3] = int8_t(4294967287);
	blockD.j[3].mC[4] = int8_t(4);
	blockD.j[3].mC[5] = int8_t(4294967292);
	blockD.j[3].mC[6] = int8_t(4294967293);
	blockD.j[4].mA[0] = (ivec4(7, 4, 5, 0));
	blockD.j[4].mB = (-9.0);
	blockD.j[4].mC[0] = int8_t(9);
	blockD.j[4].mC[1] = int8_t(4294967289);
	blockD.j[4].mC[2] = int8_t(1);
	blockD.j[4].mC[3] = int8_t(4294967287);
	blockD.j[4].mC[4] = int8_t(4294967292);
	blockD.j[4].mC[5] = int8_t(5);
	blockD.j[4].mC[6] = int8_t(8);
	blockE.l[0] = (ivec4(-6, -3, -2, -1));
	blockE.l[1] = (ivec4(1, 7, -9, 7));
	blockE.l[2] = (ivec4(6, -1, -5, 1));
	blockE.l[3] = (ivec4(-1, -1, -9, 4));
	blockE.l[4] = (ivec4(-6, -2, -2, 5));
}
#version 450
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
	lowp mat3 mA;
};
struct sB
{
	mediump mat3x4 mA[3];
	mediump mat3 mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	highp uint a;
	sA b[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	u8vec2 c;
	lowp uvec3 d[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	sB e;
	mediump uint f;
	bool g[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	mediump vec3 h;
	highp mat4 i;
	lowp ivec3 j;
	lowp mat2 k;
	lowp mat3 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
    BlockE blockE[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 3u) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[0].c), uvec2(1u, 8u)) && allOk;
	allOk = compare_uvec3((blockC[0].d[0]), uvec3(7u, 8u, 1u)) && allOk;
	allOk = compare_uvec3((blockC[0].d[1]), uvec3(2u, 6u, 8u)) && allOk;
	allOk = compare_uvec3((blockC[0].d[2]), uvec3(4u, 0u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[1].c), uvec2(6u, 8u)) && allOk;
	allOk = compare_uvec3((blockC[1].d[0]), uvec3(7u, 9u, 5u)) && allOk;
	allOk = compare_uvec3((blockC[1].d[1]), uvec3(1u, 4u, 8u)) && allOk;
	allOk = compare_uvec3((blockC[1].d[2]), uvec3(9u, 8u, 5u)) && allOk;
	allOk = compare_uvec3((blockC[1].d[3]), uvec3(5u, 2u, 9u)) && allOk;
	allOk = compare_uvec3((blockC[1].d[4]), uvec3(0u, 5u, 7u)) && allOk;
	allOk = compare_uvec3((blockC[1].d[5]), uvec3(6u, 9u, 7u)) && allOk;
	allOk = compare_uvec3((blockC[1].d[6]), uvec3(2u, 6u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[2].c), uvec2(7u, 9u)) && allOk;
	allOk = compare_uvec3((blockC[2].d[0]), uvec3(8u, 3u, 0u)) && allOk;
	allOk = compare_uvec3((blockC[2].d[1]), uvec3(7u, 6u, 5u)) && allOk;
	allOk = compare_uvec3((blockC[2].d[2]), uvec3(0u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((blockC[2].d[3]), uvec3(2u, 7u, 7u)) && allOk;
	allOk = compare_uvec3((blockC[2].d[4]), uvec3(5u, 6u, 5u)) && allOk;
	allOk = compare_uvec3((blockC[2].d[5]), uvec3(6u, 9u, 4u)) && allOk;
	allOk = compare_uvec3((blockC[2].d[6]), uvec3(6u, 4u, 5u)) && allOk;
	allOk = compare_uvec3((blockC[2].d[7]), uvec3(8u, 6u, 2u)) && allOk;
	allOk = compare_mat3x4(blockD.e.mA[0], mat3x4(5.0, 1.0, -6.0, -8.0, 2.0, 1.0, 9.0, 7.0, 5.0, -7.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockD.e.mA[1], mat3x4(3.0, 7.0, 5.0, 5.0, 3.0, 6.0, 4.0, -5.0, -2.0, -9.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockD.e.mA[2], mat3x4(6.0, 5.0, 0.0, -8.0, -7.0, -2.0, -3.0, -5.0, 8.0, 1.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(blockD.e.mB, mat3(-1.0, -5.0, 7.0, -3.0, -1.0, -7.0, 8.0, 5.0, 6.0)) && allOk;
	allOk = compare_uint((blockD.f), 1u) && allOk;
	allOk = compare_bool((blockD.g[0]), true) && allOk;
	allOk = compare_bool((blockD.g[1]), false) && allOk;
	allOk = compare_bool((blockD.g[2]), false) && allOk;
	allOk = compare_bool((blockD.g[3]), true) && allOk;
	allOk = compare_bool((blockD.g[4]), true) && allOk;
	allOk = compare_bool((blockD.g[5]), false) && allOk;
	allOk = compare_bool((blockD.g[6]), false) && allOk;
	allOk = compare_mat3(blockE[0].l[0], mat3(5.0, -2.0, -4.0, -9.0, 1.0, 2.0, 5.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3(blockE[0].l[1], mat3(4.0, 4.0, -5.0, -6.0, 0.0, 8.0, 5.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3(blockE[1].l[0], mat3(3.0, -8.0, 6.0, -8.0, 9.0, 0.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(blockE[1].l[1], mat3(9.0, -1.0, 6.0, 9.0, -1.0, -3.0, -4.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat3(blockE[1].l[2], mat3(-8.0, 8.0, 6.0, -7.0, 3.0, -1.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(blockE[1].l[3], mat3(4.0, 6.0, 1.0, -5.0, 2.0, -9.0, 8.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(blockE[1].l[4], mat3(0.0, 7.0, 9.0, 4.0, 6.0, -1.0, 8.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (9u);
	blockC[0].c = u8vec2(uvec2(4u, 3u));
	blockC[0].d[0] = (uvec3(6u, 3u, 0u));
	blockC[0].d[1] = (uvec3(2u, 1u, 8u));
	blockC[0].d[2] = (uvec3(2u, 0u, 8u));
	blockC[1].c = u8vec2(uvec2(4u, 8u));
	blockC[1].d[0] = (uvec3(4u, 8u, 0u));
	blockC[1].d[1] = (uvec3(8u, 9u, 9u));
	blockC[1].d[2] = (uvec3(2u, 1u, 9u));
	blockC[1].d[3] = (uvec3(3u, 0u, 5u));
	blockC[1].d[4] = (uvec3(5u, 2u, 7u));
	blockC[1].d[5] = (uvec3(8u, 5u, 5u));
	blockC[1].d[6] = (uvec3(2u, 9u, 3u));
	blockC[2].c = u8vec2(uvec2(4u, 5u));
	blockC[2].d[0] = (uvec3(4u, 7u, 2u));
	blockC[2].d[1] = (uvec3(1u, 9u, 4u));
	blockC[2].d[2] = (uvec3(9u, 7u, 9u));
	blockC[2].d[3] = (uvec3(8u, 6u, 6u));
	blockC[2].d[4] = (uvec3(7u, 8u, 2u));
	blockC[2].d[5] = (uvec3(1u, 8u, 5u));
	blockC[2].d[6] = (uvec3(6u, 6u, 5u));
	blockC[2].d[7] = (uvec3(2u, 5u, 7u));
	blockD.e.mA[0] = (mat3x4(-7.0, -1.0, -7.0, -8.0, -5.0, -9.0, 6.0, 1.0, 9.0, 9.0, 9.0, 0.0));
	blockD.e.mA[1] = (mat3x4(4.0, 2.0, 5.0, -5.0, 8.0, 8.0, 3.0, 3.0, 9.0, 5.0, -5.0, -6.0));
	blockD.e.mA[2] = (mat3x4(9.0, -1.0, -2.0, 4.0, 2.0, -6.0, -6.0, 5.0, 9.0, -5.0, 0.0, 9.0));
	blockD.e.mB = (mat3(-3.0, 6.0, -9.0, -3.0, -5.0, -5.0, 4.0, 5.0, 7.0));
	blockD.f = (1u);
	blockD.g[0] = (false);
	blockD.g[1] = (false);
	blockD.g[2] = (true);
	blockD.g[3] = (true);
	blockD.g[4] = (true);
	blockD.g[5] = (true);
	blockD.g[6] = (true);
	blockE[0].h = (vec3(1.0, 9.0, 3.0));
	blockE[0].l[0] = (mat3(5.0, 6.0, -4.0, -4.0, 2.0, -9.0, 9.0, 1.0, 4.0));
	blockE[0].l[1] = (mat3(-2.0, 9.0, 3.0, -3.0, 7.0, 1.0, -8.0, 6.0, 4.0));
	blockE[1].h = (vec3(8.0, -1.0, -4.0));
	blockE[1].l[0] = (mat3(3.0, 6.0, 9.0, -8.0, 7.0, 6.0, -6.0, -9.0, 5.0));
	blockE[1].l[1] = (mat3(-6.0, -8.0, 7.0, 6.0, -1.0, 7.0, -8.0, -3.0, 1.0));
	blockE[1].l[2] = (mat3(6.0, 5.0, -7.0, -2.0, 0.0, 7.0, 1.0, -7.0, 2.0));
	blockE[1].l[3] = (mat3(3.0, 4.0, 2.0, 6.0, 5.0, 1.0, 8.0, 6.0, -9.0));
	blockE[1].l[4] = (mat3(-8.0, -8.0, -5.0, 1.0, 9.0, 5.0, -6.0, 9.0, -5.0));
}
