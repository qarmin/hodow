#version 450
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
	mediump uvec4 var;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var), uvec4(1u, 4u, 9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (uvec4(5u, 0u, 1u, 3u));
}
#version 450
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
	allOk = compare_mat2(var, mat2(6.0, 4.0, 9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(5.0, -5.0));
	var[1] = (vec2(-3.0, 5.0));
}
#version 450
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(7.0, -3.0, -9.0, -7.0, 4.0, 5.0, 2.0, -6.0, -8.0, -1.0, -2.0, -5.0, -8.0, -7.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(3.0, 9.0, 2.0, 1.0));
	var[1] = (vec4(-5.0, -7.0, 8.0, -8.0));
	var[2] = (vec4(7.0, 0.0, -3.0, 1.0));
	var[3] = (vec4(-5.0, 0.0, 5.0, -8.0));
}
#version 450
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
	allOk = compare_mat2x3(var, mat2x3(5.0, 3.0, -9.0, 3.0, -3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(0.0, -4.0, -4.0, 3.0, -2.0, 8.0));
}
#version 450
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

	var[0] = (vec2(-7.0, 5.0));
	var[1] = (vec2(-3.0, 5.0));
	var[2] = (vec2(-2.0, -4.0));
	var[3] = (vec2(1.0, -8.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[1][0], 1.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_float(var[2][0], 5.0) && allOk;
	allOk = compare_float(var[2][1], -7.0) && allOk;
	allOk = compare_float(var[3][0], 1.0) && allOk;
	allOk = compare_float(var[3][1], -5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-3.0, -6.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(-5.0, 5.0, 7.0, -1.0, -3.0, 6.0, 9.0, -7.0));
}
#version 450
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
	u16vec2 var;
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(var), uvec2(8u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = u16vec2(uvec2(8u, 0u));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(-6.0, -3.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(-2.0, -9.0));
	var[1] = (vec2(5.0, 8.0));
}
#version 450
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

	var = (mat2x3(-9.0, 1.0, -5.0, 1.0, 5.0, -3.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 5.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], 1.0) && allOk;
	allOk = compare_float(var[0][3], 8.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 5.0) && allOk;
	allOk = compare_float(var[1][3], -5.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], -3.0) && allOk;
	allOk = compare_float(var[2][2], 3.0) && allOk;
	allOk = compare_float(var[2][3], 1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(5.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-7.0, -7.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-6.0, -3.0, 3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(-3.0, 0.0, -2.0, -2.0, -2.0, 6.0, 2.0, 9.0, -5.0, -2.0, -8.0, -8.0));
}
#version 450
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
	allOk = compare_mat4x2(var, mat4x2(-2.0, -5.0, -2.0, 4.0, -3.0, -4.0, 2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(-6.0, -9.0, 0.0, -8.0, -8.0, 5.0, -8.0, 3.0));
}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_float(var[2][0], -3.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[3][0], -7.0) && allOk;
	allOk = compare_float(var[3][1], 1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-6.0, 6.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-3.0, -8.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(-5.0, 9.0));
	var[1] = (vec2(-3.0, -1.0));
	var[2] = (vec2(1.0, 9.0));
	var[3] = (vec2(-7.0, -4.0));
}
#version 450
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
	lowp uvec4 var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 2u) && allOk;
	allOk = compare_uvec4((var), uvec4(4u, 5u, 5u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6u);
	var = (uvec4(6u, 2u, 2u, 3u));
}
#version 450
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], -4.0) && allOk;
	allOk = compare_float(var[0][3], -3.0) && allOk;
	allOk = compare_float(var[1][0], -9.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], -9.0) && allOk;
	allOk = compare_float(var[1][3], 4.0) && allOk;
	allOk = compare_float(var[2][0], 7.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[2][3], -4.0) && allOk;
	allOk = compare_float(var[3][0], 3.0) && allOk;
	allOk = compare_float(var[3][1], -6.0) && allOk;
	allOk = compare_float(var[3][2], -3.0) && allOk;
	allOk = compare_float(var[3][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-4.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-9.0, 5.0, -9.0, 4.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(7.0, -6.0, -9.0, -4.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(3.0, -6.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0] = (vec4(5.0, -7.0, 4.0, -8.0));
	var[1] = (vec4(-8.0, 0.0, -6.0, 9.0));
	var[2] = (vec4(-2.0, 0.0, -8.0, 3.0));
	var[3] = (vec4(9.0, -1.0, -5.0, -8.0));
}
#version 450
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
	allOk = compare_mat2x3(var, mat2x3(2.0, 7.0, 0.0, -3.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0] = (vec3(7.0, 8.0, -1.0));
	var[1] = (vec3(5.0, -2.0, -6.0));
}
#version 450
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
	allOk = compare_mat4(var[0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	var[1] = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	var[2] = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(2.0, 1.0, 7.0, 1.0));
	var[0][1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	var[1][0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	var[1][1] = (vec4(7.0, -4.0, 8.0, -2.0));
	var[2][0] = (vec4(2.0, 5.0, -2.0, 1.0));
	var[2][1] = (vec4(1.0, 0.0, -4.0, 1.0));
}
#version 450
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

	var[0] = u8vec2(uvec2(7u, 7u));
	var[1] = u8vec2(uvec2(9u, 6u));
	var[2] = u8vec2(uvec2(0u, 2u));
}
#version 450
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
	highp vec3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_vec3((var[0]), vec3(9.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec3((var[1]), vec3(5.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec3((var[2]), vec3(-1.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var[0] = (vec3(4.0, 7.0, 8.0));
	var[1] = (vec3(-2.0, 7.0, -5.0));
	var[2] = (vec3(-7.0, 9.0, 6.0));
}
#version 450
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
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0] = (mat3x4(0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0, 8.0));
	var[1] = (mat3x4(1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0, 8.0));
	var[2] = (mat3x4(-2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0, -9.0));
}
#version 450
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
	i8vec2 var[3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967288) && allOk;
	allOk = compare_i8vec2(ivec2(var[0]), ivec2(4294967293, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1]), ivec2(9, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2]), ivec2(1, 4294967288)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int8_t(0);
	var[0] = i8vec2(ivec2(8, 4294967292));
	var[1] = i8vec2(ivec2(9, 4294967294));
	var[2] = i8vec2(ivec2(4294967295, 8));
}
#version 450
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
	bvec2 var[];
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((var[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[6]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[7]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[8]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[9]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[10]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[11]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[12]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[13]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[14]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[15]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[16]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[17]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[18]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (bvec2(true, false));
	var[1] = (bvec2(true, true));
	var[2] = (bvec2(false, false));
	var[3] = (bvec2(false, false));
	var[4] = (bvec2(false, true));
	var[5] = (bvec2(true, true));
	var[6] = (bvec2(false, false));
	var[7] = (bvec2(false, true));
	var[8] = (bvec2(true, true));
	var[9] = (bvec2(false, false));
	var[10] = (bvec2(true, false));
	var[11] = (bvec2(true, false));
	var[12] = (bvec2(false, true));
	var[13] = (bvec2(true, true));
	var[14] = (bvec2(false, false));
	var[15] = (bvec2(true, true));
	var[16] = (bvec2(true, false));
	var[17] = (bvec2(false, false));
	var[18] = (bvec2(true, false));
}
#version 450
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
	highp mat4x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(6.0, -1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(-5.0, -9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(2.0, -1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(7.0, 1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(2.0, 9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(9.0, 6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(6.0, -3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	var[1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	var[2] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	var[3] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	var[4] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	var[5] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	var[6] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	var[7] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	var[8] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	var[9] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	var[10] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	var[11] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
	var[12] = (mat4x3(-2.0, 7.0, -6.0, -4.0, -2.0, 0.0, 4.0, -2.0, 6.0, -6.0, -5.0, -8.0));
	var[13] = (mat4x3(-1.0, 2.0, 4.0, 2.0, -2.0, 9.0, 0.0, -4.0, 6.0, -7.0, -4.0, 2.0));
	var[14] = (mat4x3(1.0, 2.0, -9.0, -3.0, 6.0, -9.0, 8.0, 2.0, 1.0, -8.0, 3.0, 2.0));
	var[15] = (mat4x3(1.0, 4.0, 9.0, -7.0, -5.0, 2.0, -8.0, 0.0, 0.0, -4.0, 9.0, 5.0));
	var[16] = (mat4x3(-2.0, -9.0, 6.0, -9.0, -4.0, -7.0, 9.0, -5.0, 3.0, 5.0, -1.0, -4.0));
	var[17] = (mat4x3(1.0, -1.0, -8.0, 4.0, 4.0, 4.0, -3.0, 4.0, 0.0, 0.0, -7.0, -1.0));
	var[18] = (mat4x3(2.0, 6.0, 9.0, -5.0, -9.0, -9.0, 5.0, 6.0, 4.0, 6.0, -3.0, 1.0));
}
#version 450
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
	allOk = compare_mat4(var[0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(-3.0, 8.0, -3.0, -7.0, -4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(3.0, -9.0, -5.0, 9.0, -5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(6.0, -4.0, -9.0, 2.0, 1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(5.0, -7.0, -8.0, -6.0, 7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(-6.0, -8.0, 2.0, -5.0, 0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(-1.0, 5.0, 8.0, -3.0, -9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(-3.0, 3.0, 3.0, -3.0, -6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(-8.0, -8.0, 8.0, -1.0, -8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(8.0, 8.0, -7.0, -5.0, 0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(1.0, 6.0, -6.0, 7.0, 9.0, 3.0, 0.0, 7.0, 0.0, 9.0, -9.0, 1.0, 4.0, -9.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(7.0, 7.0, -6.0, -6.0, 8.0, -2.0, 4.0, -6.0, 7.0, -4.0, -8.0, -2.0, -2.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(0.0, -2.0, -9.0, 6.0, -2.0, -1.0, 8.0, 5.0, 1.0, 7.0, 0.0, -1.0, 1.0, -2.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(-9.0, -7.0, 3.0, -8.0, 8.0, 3.0, 6.0, -3.0, 8.0, -1.0, 8.0, 0.0, 5.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(0.0, 6.0, -8.0, -6.0, 7.0, 9.0, 7.0, -8.0, 2.0, 6.0, 0.0, 5.0, -8.0, 5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(0.0, 8.0, 3.0, 5.0, -1.0, 7.0, -5.0, 0.0, -3.0, -6.0, -8.0, -6.0, 6.0, -3.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(0.0, 3.0, 3.0, 8.0, 3.0, 7.0, -3.0, 1.0, -8.0, 3.0, 7.0, -3.0, 7.0, 5.0, -7.0, -8.0)) && allOk;
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
	var[3][0] = (vec4(-9.0, 5.0, 8.0, 6.0));
	var[3][1] = (vec4(4.0, 6.0, -1.0, -7.0));
	var[3][2] = (vec4(7.0, 8.0, 5.0, -1.0));
	var[3][3] = (vec4(8.0, 2.0, -8.0, 0.0));
	var[4][0] = (vec4(-9.0, -1.0, -5.0, 7.0));
	var[4][1] = (vec4(3.0, 1.0, 2.0, 2.0));
	var[4][2] = (vec4(-3.0, -7.0, 1.0, 0.0));
	var[4][3] = (vec4(9.0, 5.0, -2.0, 6.0));
	var[5][0] = (vec4(-9.0, 1.0, 2.0, -3.0));
	var[5][1] = (vec4(-2.0, -2.0, -8.0, -4.0));
	var[5][2] = (vec4(7.0, -4.0, -1.0, 2.0));
	var[5][3] = (vec4(7.0, 7.0, 2.0, 8.0));
	var[6][0] = (vec4(-5.0, 9.0, 9.0, 4.0));
	var[6][1] = (vec4(6.0, -2.0, -1.0, -2.0));
	var[6][2] = (vec4(0.0, 5.0, -4.0, 5.0));
	var[6][3] = (vec4(8.0, -8.0, 9.0, -3.0));
	var[7][0] = (vec4(4.0, -8.0, -1.0, 0.0));
	var[7][1] = (vec4(-3.0, -4.0, -7.0, 1.0));
	var[7][2] = (vec4(4.0, -2.0, 1.0, -8.0));
	var[7][3] = (vec4(-8.0, 5.0, 4.0, 7.0));
	var[8][0] = (vec4(7.0, -2.0, -6.0, 9.0));
	var[8][1] = (vec4(-7.0, -5.0, 2.0, 2.0));
	var[8][2] = (vec4(4.0, 8.0, 4.0, -9.0));
	var[8][3] = (vec4(0.0, -9.0, 0.0, 0.0));
	var[9][0] = (vec4(9.0, -1.0, -1.0, -3.0));
	var[9][1] = (vec4(-9.0, -6.0, -8.0, 4.0));
	var[9][2] = (vec4(-6.0, 9.0, -8.0, 3.0));
	var[9][3] = (vec4(0.0, 1.0, -1.0, -7.0));
	var[10][0] = (vec4(-9.0, -4.0, 4.0, 6.0));
	var[10][1] = (vec4(4.0, 9.0, 4.0, -4.0));
	var[10][2] = (vec4(3.0, -1.0, 2.0, 8.0));
	var[10][3] = (vec4(-3.0, -6.0, -4.0, 0.0));
	var[11][0] = (vec4(2.0, -1.0, 1.0, -1.0));
	var[11][1] = (vec4(8.0, 5.0, 3.0, 0.0));
	var[11][2] = (vec4(-2.0, 0.0, 7.0, -5.0));
	var[11][3] = (vec4(6.0, 0.0, 6.0, -6.0));
	var[12][0] = (vec4(-1.0, -6.0, -8.0, -9.0));
	var[12][1] = (vec4(0.0, 3.0, 6.0, -1.0));
	var[12][2] = (vec4(4.0, 6.0, 8.0, 1.0));
	var[12][3] = (vec4(9.0, -4.0, 7.0, 7.0));
	var[13][0] = (vec4(2.0, -1.0, -8.0, 9.0));
	var[13][1] = (vec4(-1.0, 7.0, -4.0, 2.0));
	var[13][2] = (vec4(9.0, 2.0, -2.0, -1.0));
	var[13][3] = (vec4(7.0, 3.0, -6.0, 0.0));
	var[14][0] = (vec4(-7.0, -8.0, -7.0, 8.0));
	var[14][1] = (vec4(5.0, 7.0, -3.0, -2.0));
	var[14][2] = (vec4(9.0, -5.0, -2.0, -2.0));
	var[14][3] = (vec4(2.0, 4.0, -1.0, 9.0));
	var[15][0] = (vec4(3.0, 3.0, 4.0, -8.0));
	var[15][1] = (vec4(-3.0, -9.0, 9.0, -7.0));
	var[15][2] = (vec4(-7.0, 9.0, -4.0, 0.0));
	var[15][3] = (vec4(-4.0, -3.0, 0.0, 6.0));
	var[16][0] = (vec4(-5.0, -7.0, 3.0, -9.0));
	var[16][1] = (vec4(4.0, 5.0, 0.0, -6.0));
	var[16][2] = (vec4(7.0, 4.0, 1.0, 9.0));
	var[16][3] = (vec4(-8.0, 8.0, 7.0, 4.0));
	var[17][0] = (vec4(-1.0, 5.0, 9.0, -2.0));
	var[17][1] = (vec4(-5.0, -8.0, 2.0, -5.0));
	var[17][2] = (vec4(3.0, -8.0, -1.0, -5.0));
	var[17][3] = (vec4(-6.0, -2.0, 3.0, 0.0));
	var[18][0] = (vec4(1.0, -3.0, -1.0, 9.0));
	var[18][1] = (vec4(-4.0, -5.0, 6.0, 9.0));
	var[18][2] = (vec4(-5.0, -7.0, 1.0, 2.0));
	var[18][3] = (vec4(-7.0, 2.0, -8.0, 9.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	i16vec2 var[];
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(var[0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2]), ivec2(-4, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3]), ivec2(-1, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[4]), ivec2(-1, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(var[5]), ivec2(-1, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(var[6]), ivec2(-6, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[7]), ivec2(-5, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[8]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(var[9]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[10]), ivec2(6, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[11]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[12]), ivec2(-1, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[13]), ivec2(0, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(var[14]), ivec2(-2, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[15]), ivec2(1, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(var[16]), ivec2(-5, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(var[17]), ivec2(-8, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[18]), ivec2(-2, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = i16vec2(ivec2(6, -2));
	var[1] = i16vec2(ivec2(-2, -8));
	var[2] = i16vec2(ivec2(3, 5));
	var[3] = i16vec2(ivec2(-9, -9));
	var[4] = i16vec2(ivec2(-4, -3));
	var[5] = i16vec2(ivec2(-2, 6));
	var[6] = i16vec2(ivec2(0, -1));
	var[7] = i16vec2(ivec2(3, -9));
	var[8] = i16vec2(ivec2(9, -6));
	var[9] = i16vec2(ivec2(-1, -7));
	var[10] = i16vec2(ivec2(-1, -6));
	var[11] = i16vec2(ivec2(6, 5));
	var[12] = i16vec2(ivec2(6, 9));
	var[13] = i16vec2(ivec2(0, 9));
	var[14] = i16vec2(ivec2(0, 5));
	var[15] = i16vec2(ivec2(9, -8));
	var[16] = i16vec2(ivec2(4, 6));
	var[17] = i16vec2(ivec2(-9, -9));
	var[18] = i16vec2(ivec2(4, 1));
}
#version 450
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
	highp uvec4 var[];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var[0]), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((var[1]), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((var[2]), uvec4(3u, 6u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((var[3]), uvec4(2u, 3u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((var[4]), uvec4(0u, 7u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((var[5]), uvec4(2u, 8u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((var[6]), uvec4(7u, 3u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((var[7]), uvec4(8u, 7u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((var[8]), uvec4(5u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((var[9]), uvec4(1u, 6u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((var[10]), uvec4(7u, 9u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((var[11]), uvec4(5u, 7u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((var[12]), uvec4(8u, 5u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((var[13]), uvec4(3u, 6u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((var[14]), uvec4(4u, 0u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((var[15]), uvec4(6u, 2u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((var[16]), uvec4(5u, 8u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((var[17]), uvec4(9u, 8u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((var[18]), uvec4(9u, 6u, 7u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (uvec4(2u, 7u, 2u, 9u));
	var[1] = (uvec4(7u, 9u, 5u, 1u));
	var[2] = (uvec4(3u, 4u, 4u, 2u));
	var[3] = (uvec4(0u, 5u, 6u, 2u));
	var[4] = (uvec4(9u, 5u, 7u, 7u));
	var[5] = (uvec4(0u, 3u, 8u, 1u));
	var[6] = (uvec4(4u, 9u, 1u, 3u));
	var[7] = (uvec4(8u, 8u, 8u, 1u));
	var[8] = (uvec4(7u, 5u, 4u, 8u));
	var[9] = (uvec4(6u, 6u, 0u, 9u));
	var[10] = (uvec4(7u, 2u, 3u, 0u));
	var[11] = (uvec4(4u, 4u, 8u, 5u));
	var[12] = (uvec4(6u, 1u, 9u, 4u));
	var[13] = (uvec4(5u, 7u, 7u, 0u));
	var[14] = (uvec4(2u, 5u, 1u, 3u));
	var[15] = (uvec4(9u, 6u, 1u, 2u));
	var[16] = (uvec4(0u, 0u, 8u, 4u));
	var[17] = (uvec4(9u, 5u, 7u, 1u));
	var[18] = (uvec4(2u, 0u, 0u, 4u));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	var[0][1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	var[0][2] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	var[1][0] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	var[1][1] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	var[1][2] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	var[2][0] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	var[2][1] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	var[2][2] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	var[3][0] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	var[3][1] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	var[3][2] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
}
#version 450
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
	u8vec2 var[4][3];
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(var[0][0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][2]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][0]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][1]), uvec2(9u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][2]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][0]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][1]), uvec2(6u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][2]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][1]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][2]), uvec2(3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = u8vec2(uvec2(7u, 7u));
	var[0][1] = u8vec2(uvec2(9u, 6u));
	var[0][2] = u8vec2(uvec2(0u, 2u));
	var[1][0] = u8vec2(uvec2(1u, 1u));
	var[1][1] = u8vec2(uvec2(0u, 8u));
	var[1][2] = u8vec2(uvec2(8u, 5u));
	var[2][0] = u8vec2(uvec2(2u, 7u));
	var[2][1] = u8vec2(uvec2(4u, 4u));
	var[2][2] = u8vec2(uvec2(7u, 2u));
	var[3][0] = u8vec2(uvec2(4u, 5u));
	var[3][1] = u8vec2(uvec2(0u, 2u));
	var[3][2] = u8vec2(uvec2(1u, 8u));
}
#version 450
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
	f16vec3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(var[0][0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][2]), vec3(4.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][0]), vec3(4.0, 4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][1]), vec3(2.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][2]), vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][0]), vec3(1.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][1]), vec3(-7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][2]), vec3(-8.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][0]), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][1]), vec3(-4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][2]), vec3(-8.0, 6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = f16vec3(vec3(3.0, 3.0, 7.0));
	var[0][1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	var[0][2] = f16vec3(vec3(-1.0, 0.0, 6.0));
	var[1][0] = f16vec3(vec3(5.0, -7.0, 2.0));
	var[1][1] = f16vec3(vec3(9.0, 1.0, -5.0));
	var[1][2] = f16vec3(vec3(-5.0, 5.0, 2.0));
	var[2][0] = f16vec3(vec3(-5.0, -4.0, 6.0));
	var[2][1] = f16vec3(vec3(-3.0, -7.0, -4.0));
	var[2][2] = f16vec3(vec3(-4.0, 5.0, 0.0));
	var[3][0] = f16vec3(vec3(-6.0, 4.0, -1.0));
	var[3][1] = f16vec3(vec3(-2.0, 3.0, -8.0));
	var[3][2] = f16vec3(vec3(-4.0, -2.0, 4.0));
}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2x4(var[0][0], mat2x4(-1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(-6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(-4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0][0][0] = (vec4(-6.0, -9.0, -3.0, 5.0));
	var[0][0][1] = (vec4(1.0, -7.0, 1.0, -7.0));
	var[0][1][0] = (vec4(-4.0, 1.0, 9.0, -1.0));
	var[0][1][1] = (vec4(-2.0, 2.0, 4.0, -1.0));
	var[0][2][0] = (vec4(-9.0, -6.0, 6.0, -7.0));
	var[0][2][1] = (vec4(5.0, 8.0, 4.0, -8.0));
	var[1][0][0] = (vec4(1.0, 8.0, -9.0, -7.0));
	var[1][0][1] = (vec4(-8.0, 4.0, -2.0, 5.0));
	var[1][1][0] = (vec4(5.0, -2.0, 2.0, -6.0));
	var[1][1][1] = (vec4(0.0, 8.0, 8.0, -6.0));
	var[1][2][0] = (vec4(-5.0, 0.0, 5.0, -1.0));
	var[1][2][1] = (vec4(2.0, 3.0, 0.0, 1.0));
	var[2][0][0] = (vec4(-8.0, 7.0, 2.0, 5.0));
	var[2][0][1] = (vec4(-8.0, 3.0, 8.0, 1.0));
	var[2][1][0] = (vec4(5.0, 3.0, -5.0, 5.0));
	var[2][1][1] = (vec4(-8.0, 3.0, 1.0, 3.0));
	var[2][2][0] = (vec4(9.0, -9.0, -1.0, 5.0));
	var[2][2][1] = (vec4(7.0, 6.0, 7.0, 7.0));
	var[3][0][0] = (vec4(-3.0, 4.0, 4.0, -9.0));
	var[3][0][1] = (vec4(-1.0, -2.0, -1.0, -1.0));
	var[3][1][0] = (vec4(7.0, -2.0, 3.0, 7.0));
	var[3][1][1] = (vec4(-2.0, -4.0, -8.0, 2.0));
	var[3][2][0] = (vec4(7.0, 2.0, -9.0, -2.0));
	var[3][2][1] = (vec4(-1.0, 1.0, -4.0, -7.0));
}
#version 450
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
	i8vec4 var[4][3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967293) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][0]), ivec4(4294967289, 4294967295, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][1]), ivec4(4294967288, 4294967292, 4294967287, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][2]), ivec4(3, 4294967290, 4294967293, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][0]), ivec4(4294967292, 4294967291, 4294967289, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][1]), ivec4(4294967288, 8, 4294967295, 0)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][2]), ivec4(3, 4294967294, 4294967294, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][0]), ivec4(4294967295, 4294967292, 6, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][1]), ivec4(5, 4294967289, 4294967293, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][2]), ivec4(2, 2, 4, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][0]), ivec4(9, 4294967287, 1, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][1]), ivec4(4294967290, 4294967289, 4294967287, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][2]), ivec4(4294967288, 9, 2, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int8_t(4294967294);
	var[0][0] = i8vec4(ivec4(4294967292, 4294967290, 4294967289, 4294967291));
	var[0][1] = i8vec4(ivec4(4294967291, 4, 4294967290, 4294967295));
	var[0][2] = i8vec4(ivec4(4294967287, 4294967293, 8, 6));
	var[1][0] = i8vec4(ivec4(4, 9, 4294967287, 4294967295));
	var[1][1] = i8vec4(ivec4(4294967292, 4294967287, 3, 9));
	var[1][2] = i8vec4(ivec4(4294967288, 4294967290, 4294967287, 8));
	var[2][0] = i8vec4(ivec4(5, 4, 5, 5));
	var[2][1] = i8vec4(ivec4(4294967289, 4294967287, 4294967294, 4294967291));
	var[2][2] = i8vec4(ivec4(4294967291, 4, 5, 4294967293));
	var[3][0] = i8vec4(ivec4(4294967294, 4294967289, 4294967291, 2));
	var[3][1] = i8vec4(ivec4(5, 4, 6, 4294967292));
	var[3][2] = i8vec4(ivec4(7, 8, 9, 3));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	highp mat3x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(3.0, 8.0, 5.0, 9.0, 4.0, 6.0, 7.0, 0.0, 4.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(8.0, -7.0, -1.0, 4.0, -8.0, -5.0, 3.0, 6.0, 4.0, -1.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(6.0, -2.0, -4.0, 2.0, -1.0, -5.0, -1.0, -2.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(8.0, -1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-3.0, -9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(-2.0, -4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-9.0, 3.0, 2.0, 5.0, -9.0, -1.0, -7.0, 5.0, -3.0, -9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(7.0, 3.0, 5.0, 9.0, -3.0, -2.0, -1.0, 5.0, -5.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(2.0, 0.0, -7.0, 6.0, 9.0, -6.0, -1.0, 6.0, 6.0, 4.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-9.0, -4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-1.0, 9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(-2.0, 2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(8.0, 9.0, 2.0, 2.0, 6.0, -3.0, 4.0, -7.0, 0.0, 1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(-9.0, -7.0, -8.0, -4.0, 8.0, 2.0, 3.0, 0.0, -9.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(3.0, -4.0, -8.0, 9.0, -6.0, -5.0, 4.0, -7.0, 8.0, -7.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(0.0, 2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(4.0, 1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(8.0, -5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(8.0, 1.0, 3.0, 3.0, 6.0, 0.0, -6.0, 2.0, -5.0, 9.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(1.0, 4.0, 2.0, -6.0, 2.0, 3.0, -5.0, 6.0, 7.0, 7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(7.0, -2.0, -5.0, 2.0, -9.0, -4.0, 9.0, -9.0, -8.0, 1.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	var[0][0][1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	var[0][0][2] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
	var[0][1][0] = (mat3x4(9.0, -2.0, 8.0, -4.0, 8.0, 4.0, 3.0, -3.0, 3.0, -5.0, 7.0, -8.0));
	var[0][1][1] = (mat3x4(5.0, -3.0, 8.0, 6.0, 1.0, 6.0, -2.0, -6.0, 0.0, 1.0, 3.0, 3.0));
	var[0][1][2] = (mat3x4(-3.0, 0.0, -3.0, 5.0, -4.0, -5.0, 1.0, -5.0, -5.0, 0.0, 0.0, -6.0));
	var[1][0][0] = (mat3x4(-6.0, 7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0));
	var[1][0][1] = (mat3x4(7.0, -8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0));
	var[1][0][2] = (mat3x4(-1.0, 2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0));
	var[1][1][0] = (mat3x4(4.0, 6.0, -7.0, 7.0, 3.0, 6.0, 4.0, -7.0, 8.0, -1.0, 3.0, 3.0));
	var[1][1][1] = (mat3x4(-1.0, 0.0, -1.0, 5.0, 3.0, -9.0, 6.0, 8.0, -9.0, -5.0, -1.0, 1.0));
	var[1][1][2] = (mat3x4(-1.0, -4.0, 7.0, 7.0, 5.0, -7.0, 1.0, 3.0, 6.0, 3.0, -3.0, -9.0));
	var[2][0][0] = (mat3x4(6.0, 6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0));
	var[2][0][1] = (mat3x4(3.0, -3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0));
	var[2][0][2] = (mat3x4(9.0, 4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0));
	var[2][1][0] = (mat3x4(3.0, -7.0, -1.0, 2.0, -7.0, -9.0, 4.0, 1.0, -9.0, 4.0, 5.0, -1.0));
	var[2][1][1] = (mat3x4(-3.0, -8.0, 4.0, 4.0, -5.0, 6.0, 7.0, 6.0, 5.0, 2.0, 2.0, -5.0));
	var[2][1][2] = (mat3x4(8.0, -2.0, -8.0, -1.0, -5.0, -1.0, -6.0, 3.0, 7.0, -8.0, -6.0, -9.0));
	var[3][0][0] = (mat3x4(5.0, 0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0));
	var[3][0][1] = (mat3x4(0.0, -3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0));
	var[3][0][2] = (mat3x4(5.0, 7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0));
	var[3][1][0] = (mat3x4(-5.0, -1.0, 4.0, 9.0, -9.0, -3.0, -8.0, -1.0, 5.0, 9.0, -6.0, 2.0));
	var[3][1][1] = (mat3x4(-6.0, 6.0, -6.0, 7.0, 6.0, -6.0, 8.0, 9.0, 6.0, 0.0, 7.0, 8.0));
	var[3][1][2] = (mat3x4(7.0, -9.0, -9.0, -4.0, 2.0, 7.0, 9.0, -8.0, -5.0, 6.0, 2.0, -3.0));
}
#version 450
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
	bool var[4][2][3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), false) && allOk;
	allOk = compare_bool((var[0][0][0]), true) && allOk;
	allOk = compare_bool((var[0][0][1]), true) && allOk;
	allOk = compare_bool((var[0][0][2]), false) && allOk;
	allOk = compare_bool((var[0][1][0]), false) && allOk;
	allOk = compare_bool((var[0][1][1]), true) && allOk;
	allOk = compare_bool((var[0][1][2]), true) && allOk;
	allOk = compare_bool((var[1][0][0]), false) && allOk;
	allOk = compare_bool((var[1][0][1]), true) && allOk;
	allOk = compare_bool((var[1][0][2]), true) && allOk;
	allOk = compare_bool((var[1][1][0]), false) && allOk;
	allOk = compare_bool((var[1][1][1]), true) && allOk;
	allOk = compare_bool((var[1][1][2]), false) && allOk;
	allOk = compare_bool((var[2][0][0]), false) && allOk;
	allOk = compare_bool((var[2][0][1]), false) && allOk;
	allOk = compare_bool((var[2][0][2]), false) && allOk;
	allOk = compare_bool((var[2][1][0]), false) && allOk;
	allOk = compare_bool((var[2][1][1]), false) && allOk;
	allOk = compare_bool((var[2][1][2]), true) && allOk;
	allOk = compare_bool((var[3][0][0]), false) && allOk;
	allOk = compare_bool((var[3][0][1]), true) && allOk;
	allOk = compare_bool((var[3][0][2]), true) && allOk;
	allOk = compare_bool((var[3][1][0]), false) && allOk;
	allOk = compare_bool((var[3][1][1]), false) && allOk;
	allOk = compare_bool((var[3][1][2]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (false);
	var[0][0][0] = (false);
	var[0][0][1] = (true);
	var[0][0][2] = (true);
	var[0][1][0] = (false);
	var[0][1][1] = (true);
	var[0][1][2] = (false);
	var[1][0][0] = (false);
	var[1][0][1] = (false);
	var[1][0][2] = (true);
	var[1][1][0] = (true);
	var[1][1][1] = (false);
	var[1][1][2] = (true);
	var[2][0][0] = (true);
	var[2][0][1] = (true);
	var[2][0][2] = (true);
	var[2][1][0] = (true);
	var[2][1][1] = (true);
	var[2][1][2] = (true);
	var[3][0][0] = (false);
	var[3][0][1] = (false);
	var[3][0][2] = (false);
	var[3][1][0] = (true);
	var[3][1][1] = (false);
	var[3][1][2] = (true);
}
#version 450
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
	bvec4 var[4][2][3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), true) && allOk;
	allOk = compare_bvec4((var[0][0][0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[0][0][1]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((var[0][0][2]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((var[0][1][0]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[0][1][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[0][1][2]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((var[1][0][0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[1][0][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[1][0][2]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[1][1][0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((var[1][1][1]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((var[1][1][2]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((var[2][0][0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[2][0][1]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((var[2][0][2]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((var[2][1][0]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((var[2][1][1]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((var[2][1][2]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((var[3][0][0]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((var[3][0][1]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((var[3][0][2]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((var[3][1][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[3][1][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[3][1][2]), bvec4(true, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (true);
	var[0][0][0] = (bvec4(true, true, false, true));
	var[0][0][1] = (bvec4(false, false, false, false));
	var[0][0][2] = (bvec4(true, true, true, true));
	var[0][1][0] = (bvec4(true, false, true, true));
	var[0][1][1] = (bvec4(true, true, false, false));
	var[0][1][2] = (bvec4(true, false, false, true));
	var[1][0][0] = (bvec4(true, true, false, true));
	var[1][0][1] = (bvec4(false, true, false, true));
	var[1][0][2] = (bvec4(false, false, true, false));
	var[1][1][0] = (bvec4(false, false, true, true));
	var[1][1][1] = (bvec4(true, true, false, true));
	var[1][1][2] = (bvec4(false, false, false, false));
	var[2][0][0] = (bvec4(true, true, false, true));
	var[2][0][1] = (bvec4(true, true, false, false));
	var[2][0][2] = (bvec4(false, true, true, true));
	var[2][1][0] = (bvec4(false, true, true, false));
	var[2][1][1] = (bvec4(false, true, false, true));
	var[2][1][2] = (bvec4(false, false, true, true));
	var[3][0][0] = (bvec4(false, true, false, true));
	var[3][0][1] = (bvec4(true, true, true, false));
	var[3][0][2] = (bvec4(true, false, true, false));
	var[3][1][0] = (bvec4(false, true, false, false));
	var[3][1][1] = (bvec4(true, false, true, false));
	var[3][1][2] = (bvec4(true, true, true, true));
}
#version 450
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
	highp mat2x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(0.0, -9.0, 8.0, -4.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(-1.0, -3.0, -1.0, 7.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(9.0, 0.0, 0.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-3.0, -1.0, -4.0, -2.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(8.0, 1.0, 6.0, 5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(5.0, 0.0, -6.0, 1.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(8.0, -3.0, 7.0, 3.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(-2.0, -7.0, -8.0, 8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(-3.0, 2.0, 8.0, -4.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(7.0, -7.0, 4.0, 1.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(7.0, 0.0, -3.0, 3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(5.0, -9.0, 3.0, -2.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-9.0, 0.0, -9.0, -8.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(3.0, 9.0, 1.0, 6.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(-3.0, 6.0, 8.0, -6.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-8.0, -3.0, 7.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(0.0, 2.0, 6.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(6.0, 0.0, 9.0, 9.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(5.0, 6.0, 7.0, -1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(9.0, 5.0, 1.0, 3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(6.0, -5.0, 7.0, -3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(6.0, -6.0, -7.0, -2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(2.0, -4.0, -6.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(-7.0, 9.0, 2.0, -8.0, 6.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0][0][0][0] = (vec3(5.0, 5.0, 0.0));
	var[0][0][0][1] = (vec3(-7.0, 8.0, -7.0));
	var[0][0][1][0] = (vec3(-4.0, 6.0, 1.0));
	var[0][0][1][1] = (vec3(3.0, 2.0, -6.0));
	var[0][0][2][0] = (vec3(5.0, 2.0, 1.0));
	var[0][0][2][1] = (vec3(8.0, -8.0, 2.0));
	var[0][1][0][0] = (vec3(7.0, -1.0, -6.0));
	var[0][1][0][1] = (vec3(1.0, -2.0, 8.0));
	var[0][1][1][0] = (vec3(-6.0, -8.0, 9.0));
	var[0][1][1][1] = (vec3(-5.0, 5.0, -8.0));
	var[0][1][2][0] = (vec3(1.0, -3.0, -4.0));
	var[0][1][2][1] = (vec3(-5.0, 1.0, 4.0));
	var[1][0][0][0] = (vec3(-7.0, 5.0, -4.0));
	var[1][0][0][1] = (vec3(-6.0, -9.0, 3.0));
	var[1][0][1][0] = (vec3(0.0, -7.0, 2.0));
	var[1][0][1][1] = (vec3(-4.0, 1.0, -2.0));
	var[1][0][2][0] = (vec3(-2.0, -5.0, 2.0));
	var[1][0][2][1] = (vec3(5.0, 4.0, 4.0));
	var[1][1][0][0] = (vec3(-2.0, -5.0, -9.0));
	var[1][1][0][1] = (vec3(-8.0, -5.0, 5.0));
	var[1][1][1][0] = (vec3(9.0, 6.0, 7.0));
	var[1][1][1][1] = (vec3(5.0, 7.0, 0.0));
	var[1][1][2][0] = (vec3(9.0, -4.0, 7.0));
	var[1][1][2][1] = (vec3(-3.0, 7.0, 5.0));
	var[2][0][0][0] = (vec3(-1.0, 7.0, 9.0));
	var[2][0][0][1] = (vec3(-2.0, -4.0, 8.0));
	var[2][0][1][0] = (vec3(-4.0, 2.0, 5.0));
	var[2][0][1][1] = (vec3(-1.0, -3.0, 3.0));
	var[2][0][2][0] = (vec3(-2.0, -8.0, 6.0));
	var[2][0][2][1] = (vec3(0.0, 9.0, 1.0));
	var[2][1][0][0] = (vec3(-5.0, 1.0, 9.0));
	var[2][1][0][1] = (vec3(2.0, -6.0, -1.0));
	var[2][1][1][0] = (vec3(-6.0, 5.0, 8.0));
	var[2][1][1][1] = (vec3(-5.0, -8.0, -6.0));
	var[2][1][2][0] = (vec3(-6.0, 5.0, -4.0));
	var[2][1][2][1] = (vec3(8.0, -9.0, 0.0));
	var[3][0][0][0] = (vec3(-5.0, -1.0, -6.0));
	var[3][0][0][1] = (vec3(-6.0, 3.0, 1.0));
	var[3][0][1][0] = (vec3(-8.0, -5.0, 8.0));
	var[3][0][1][1] = (vec3(5.0, 8.0, 5.0));
	var[3][0][2][0] = (vec3(5.0, 7.0, -9.0));
	var[3][0][2][1] = (vec3(8.0, 0.0, 8.0));
	var[3][1][0][0] = (vec3(5.0, -4.0, 5.0));
	var[3][1][0][1] = (vec3(2.0, 5.0, -4.0));
	var[3][1][1][0] = (vec3(5.0, 5.0, -4.0));
	var[3][1][1][1] = (vec3(4.0, 8.0, 2.0));
	var[3][1][2][0] = (vec3(8.0, 3.0, -1.0));
	var[3][1][2][1] = (vec3(-1.0, 6.0, 3.0));
}
#version 450
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
	highp mat2x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-7.0, -8.0, 1.0, -7.0, 8.0, 3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(3.0, -9.0, -2.0, -1.0, 3.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(-2.0, 8.0, -6.0, 4.0, 6.0, -4.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(2.0, -7.0, 6.0, 2.0, -3.0, 5.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-6.0, -7.0, -3.0, 7.0, -1.0, 2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(1.0, 3.0, -7.0, -7.0, -8.0, -7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(2.0, -7.0, -5.0, 3.0, -1.0, -1.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(8.0, -7.0, 1.0, -3.0, -9.0, 1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(2.0, 5.0, 6.0, -5.0, -1.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(6.0, -3.0, -5.0, 6.0, -4.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-8.0, 1.0, -1.0, -9.0, 2.0, 8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(3.0, 9.0, 9.0, -2.0, 2.0, 7.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(0.0, -1.0, -8.0, 6.0, 2.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-3.0, -4.0, -5.0, 2.0, -2.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(2.0, 3.0, 5.0, 4.0, -7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-3.0, 8.0, -4.0, 2.0, 6.0, 2.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(7.0, -7.0, 9.0, -2.0, -6.0, -3.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(3.0, -8.0, -1.0, -6.0, 5.0, 0.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(-7.0, 7.0, 2.0, -8.0, 0.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(-1.0, -7.0, 8.0, 8.0, -7.0, -5.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(9.0, -7.0, -6.0, 1.0, 0.0, -6.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(-8.0, -4.0, -5.0, 8.0, -5.0, -2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(-2.0, 6.0, 9.0, 6.0, 0.0, 3.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(3.0, -5.0, 5.0, 0.0, -9.0, -8.0, 5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0][0][0] = (mat2x4(5.0, -4.0, -9.0, -9.0, 9.0, 1.0, 2.0, 5.0));
	var[0][0][1] = (mat2x4(5.0, -1.0, -3.0, -2.0, -4.0, -4.0, 8.0, 8.0));
	var[0][0][2] = (mat2x4(3.0, 1.0, -6.0, 2.0, 2.0, 5.0, 4.0, -3.0));
	var[0][1][0] = (mat2x4(-4.0, 2.0, -4.0, 0.0, -2.0, 7.0, -7.0, 7.0));
	var[0][1][1] = (mat2x4(-2.0, 2.0, -8.0, 5.0, -5.0, 6.0, -6.0, 6.0));
	var[0][1][2] = (mat2x4(7.0, 9.0, 1.0, -3.0, 8.0, -2.0, 0.0, 5.0));
	var[1][0][0] = (mat2x4(-6.0, -3.0, -2.0, -9.0, 4.0, 7.0, -8.0, -6.0));
	var[1][0][1] = (mat2x4(2.0, 7.0, 4.0, -7.0, 7.0, 6.0, -2.0, -8.0));
	var[1][0][2] = (mat2x4(-9.0, -3.0, 5.0, -6.0, 4.0, 3.0, -6.0, -5.0));
	var[1][1][0] = (mat2x4(-1.0, -6.0, -3.0, -3.0, 2.0, 9.0, 1.0, 7.0));
	var[1][1][1] = (mat2x4(-9.0, 4.0, 0.0, 1.0, 4.0, 1.0, -9.0, -8.0));
	var[1][1][2] = (mat2x4(-4.0, -4.0, -4.0, 1.0, 4.0, 7.0, -7.0, -9.0));
	var[2][0][0] = (mat2x4(-9.0, 1.0, -2.0, -6.0, 8.0, 2.0, 0.0, 0.0));
	var[2][0][1] = (mat2x4(-1.0, -3.0, -3.0, -9.0, 6.0, 7.0, -2.0, 7.0));
	var[2][0][2] = (mat2x4(-1.0, 9.0, 0.0, 7.0, -5.0, 9.0, -1.0, 6.0));
	var[2][1][0] = (mat2x4(6.0, 4.0, 8.0, -7.0, 3.0, 6.0, -5.0, -4.0));
	var[2][1][1] = (mat2x4(-5.0, 5.0, -9.0, 9.0, -8.0, -2.0, 8.0, 5.0));
	var[2][1][2] = (mat2x4(5.0, -6.0, 9.0, 8.0, 0.0, -8.0, -5.0, -9.0));
	var[3][0][0] = (mat2x4(1.0, -8.0, -4.0, -9.0, -8.0, -2.0, 3.0, -7.0));
	var[3][0][1] = (mat2x4(5.0, 7.0, 7.0, -3.0, 0.0, -8.0, -1.0, 1.0));
	var[3][0][2] = (mat2x4(-3.0, 0.0, -4.0, 5.0, -9.0, 2.0, -9.0, 8.0));
	var[3][1][0] = (mat2x4(7.0, 3.0, 3.0, -2.0, -9.0, -2.0, -6.0, 4.0));
	var[3][1][1] = (mat2x4(-3.0, 9.0, -3.0, 0.0, -3.0, -6.0, 4.0, 4.0));
	var[3][1][2] = (mat2x4(-8.0, 7.0, -1.0, -7.0, 4.0, -6.0, 7.0, 9.0));
}
#version 450
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
	highp mat3x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-5.0, -1.0, 5.0, 3.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-5.0, -1.0, -7.0, 3.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(7.0, 0.0, 5.0, 0.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-1.0, -9.0, 4.0, 2.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(6.0, 2.0, 9.0, 9.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(7.0, 5.0, -3.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-5.0, -4.0, 5.0, 8.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(-6.0, -8.0, -7.0, 9.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(3.0, 6.0, 9.0, 1.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-8.0, 5.0, 4.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-9.0, 0.0, 9.0, -6.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(-7.0, -7.0, -4.0, -7.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(-8.0, -9.0, 9.0, -1.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(8.0, -1.0, -4.0, -2.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(8.0, 8.0, -5.0, -5.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(8.0, 5.0, 5.0, -7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(5.0, 8.0, 9.0, 1.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(4.0, 6.0, 3.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(8.0, -3.0, -8.0, -5.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(7.0, 5.0, -3.0, 8.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-3.0, -1.0, -1.0, -3.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(-9.0, -1.0, 8.0, 0.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(-8.0, -1.0, 6.0, 5.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(-6.0, 1.0, -9.0, 2.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-4.0);
	var[0][0][0][0] = (vec2(-6.0, 1.0));
	var[0][0][0][1] = (vec2(-3.0, -1.0));
	var[0][0][0][2] = (vec2(-9.0, 3.0));
	var[0][0][1][0] = (vec2(-2.0, 5.0));
	var[0][0][1][1] = (vec2(-8.0, 2.0));
	var[0][0][1][2] = (vec2(-9.0, 1.0));
	var[0][0][2][0] = (vec2(-5.0, 0.0));
	var[0][0][2][1] = (vec2(-2.0, 2.0));
	var[0][0][2][2] = (vec2(-1.0, -7.0));
	var[0][1][0][0] = (vec2(-9.0, -8.0));
	var[0][1][0][1] = (vec2(9.0, -1.0));
	var[0][1][0][2] = (vec2(-6.0, -5.0));
	var[0][1][1][0] = (vec2(7.0, -8.0));
	var[0][1][1][1] = (vec2(-6.0, 1.0));
	var[0][1][1][2] = (vec2(-5.0, -3.0));
	var[0][1][2][0] = (vec2(8.0, -2.0));
	var[0][1][2][1] = (vec2(3.0, -2.0));
	var[0][1][2][2] = (vec2(5.0, 7.0));
	var[1][0][0][0] = (vec2(9.0, -8.0));
	var[1][0][0][1] = (vec2(7.0, 1.0));
	var[1][0][0][2] = (vec2(-9.0, -5.0));
	var[1][0][1][0] = (vec2(-5.0, 9.0));
	var[1][0][1][1] = (vec2(3.0, -3.0));
	var[1][0][1][2] = (vec2(-6.0, 1.0));
	var[1][0][2][0] = (vec2(3.0, -3.0));
	var[1][0][2][1] = (vec2(-4.0, -9.0));
	var[1][0][2][2] = (vec2(4.0, -2.0));
	var[1][1][0][0] = (vec2(-3.0, 4.0));
	var[1][1][0][1] = (vec2(5.0, -9.0));
	var[1][1][0][2] = (vec2(3.0, 6.0));
	var[1][1][1][0] = (vec2(-1.0, -6.0));
	var[1][1][1][1] = (vec2(-5.0, 7.0));
	var[1][1][1][2] = (vec2(-6.0, 1.0));
	var[1][1][2][0] = (vec2(8.0, 7.0));
	var[1][1][2][1] = (vec2(-1.0, 2.0));
	var[1][1][2][2] = (vec2(6.0, -6.0));
	var[2][0][0][0] = (vec2(-3.0, -5.0));
	var[2][0][0][1] = (vec2(1.0, -5.0));
	var[2][0][0][2] = (vec2(8.0, 7.0));
	var[2][0][1][0] = (vec2(8.0, -1.0));
	var[2][0][1][1] = (vec2(-3.0, -8.0));
	var[2][0][1][2] = (vec2(5.0, 6.0));
	var[2][0][2][0] = (vec2(6.0, 0.0));
	var[2][0][2][1] = (vec2(-8.0, -6.0));
	var[2][0][2][2] = (vec2(-4.0, -6.0));
	var[2][1][0][0] = (vec2(5.0, 6.0));
	var[2][1][0][1] = (vec2(-8.0, -2.0));
	var[2][1][0][2] = (vec2(-1.0, -3.0));
	var[2][1][1][0] = (vec2(-3.0, -5.0));
	var[2][1][1][1] = (vec2(8.0, 8.0));
	var[2][1][1][2] = (vec2(-7.0, -6.0));
	var[2][1][2][0] = (vec2(6.0, -9.0));
	var[2][1][2][1] = (vec2(5.0, -5.0));
	var[2][1][2][2] = (vec2(8.0, 4.0));
	var[3][0][0][0] = (vec2(-5.0, 8.0));
	var[3][0][0][1] = (vec2(5.0, -9.0));
	var[3][0][0][2] = (vec2(0.0, 6.0));
	var[3][0][1][0] = (vec2(-3.0, 6.0));
	var[3][0][1][1] = (vec2(0.0, 1.0));
	var[3][0][1][2] = (vec2(6.0, 4.0));
	var[3][0][2][0] = (vec2(4.0, 0.0));
	var[3][0][2][1] = (vec2(-1.0, -2.0));
	var[3][0][2][2] = (vec2(2.0, -1.0));
	var[3][1][0][0] = (vec2(-5.0, 1.0));
	var[3][1][0][1] = (vec2(4.0, 8.0));
	var[3][1][0][2] = (vec2(1.0, 8.0));
	var[3][1][1][0] = (vec2(-4.0, -6.0));
	var[3][1][1][1] = (vec2(2.0, -5.0));
	var[3][1][1][2] = (vec2(-5.0, -4.0));
	var[3][1][2][0] = (vec2(1.0, 2.0));
	var[3][1][2][1] = (vec2(4.0, -6.0));
	var[3][1][2][2] = (vec2(8.0, -6.0));
}
#version 450
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
	allOk = compare_mat3(var[0][0][0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(5.0, 9.0, -5.0, -4.0, 8.0, 3.0, -4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(5.0, 6.0, -6.0, -5.0, 4.0, 8.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(2.0, -7.0, 1.0, -7.0, -9.0, 5.0, 3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(4.0, -6.0, -5.0, -8.0, 3.0, -6.0, 3.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(-6.0, 8.0, 9.0, 6.0, -6.0, -2.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(-4.0, -8.0, -2.0, -5.0, -4.0, 2.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(-6.0, 0.0, 3.0, 6.0, -8.0, 1.0, -6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(3.0, -6.0, -3.0, -4.0, 8.0, 1.0, -8.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(-3.0, 9.0, 1.0, -4.0, -5.0, -5.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(6.0, -5.0, -2.0, 1.0, -4.0, 8.0, 3.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(-3.0, 1.0, -5.0, 4.0, -6.0, 6.0, 1.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(5.0, 0.0, 0.0, -4.0, 5.0, -5.0, 4.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	var[0][0][1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	var[0][1][0] = (mat3(3.0, 5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0));
	var[0][1][1] = (mat3(0.0, -4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0));
	var[0][2][0] = (mat3(-1.0, -3.0, 0.0, -4.0, -7.0, -5.0, 9.0, -1.0, -7.0));
	var[0][2][1] = (mat3(5.0, -8.0, 9.0, -7.0, 9.0, -8.0, -5.0, 9.0, 2.0));
	var[0][3][0] = (mat3(-6.0, -1.0, 0.0, -3.0, 8.0, -1.0, 6.0, 0.0, -6.0));
	var[0][3][1] = (mat3(9.0, 2.0, 4.0, 2.0, 8.0, -1.0, 0.0, -8.0, -9.0));
	var[1][0][0] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
	var[1][0][1] = (mat3(2.0, 1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0));
	var[1][1][0] = (mat3(9.0, 7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0));
	var[1][1][1] = (mat3(-6.0, -7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0));
	var[1][2][0] = (mat3(1.0, 9.0, -9.0, -1.0, 3.0, -5.0, -4.0, -9.0, -8.0));
	var[1][2][1] = (mat3(-9.0, 2.0, -4.0, -6.0, -2.0, 6.0, 4.0, 3.0, 0.0));
	var[1][3][0] = (mat3(-3.0, -9.0, 2.0, -3.0, 0.0, -5.0, -7.0, 7.0, -2.0));
	var[1][3][1] = (mat3(-8.0, 6.0, -6.0, 7.0, -9.0, -1.0, -7.0, 3.0, -2.0));
	var[2][0][0] = (mat3(-6.0, -8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0));
	var[2][0][1] = (mat3(2.0, -3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0));
	var[2][1][0] = (mat3(2.0, 4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0));
	var[2][1][1] = (mat3(-8.0, 3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0));
	var[2][2][0] = (mat3(-1.0, -8.0, -2.0, -5.0, 5.0, -8.0, -3.0, 4.0, -4.0));
	var[2][2][1] = (mat3(-5.0, 2.0, 5.0, 6.0, 7.0, 9.0, 1.0, -2.0, -9.0));
	var[2][3][0] = (mat3(6.0, -4.0, 4.0, 1.0, -6.0, -5.0, 0.0, 0.0, -2.0));
	var[2][3][1] = (mat3(2.0, -2.0, 2.0, 5.0, 1.0, -4.0, 3.0, 5.0, -2.0));
}
#version 450
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
	allOk = compare_mat4(var[0][0][0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(5.0, -7.0, -8.0, -6.0, 7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-6.0, -8.0, 2.0, -5.0, 0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(1.0, 6.0, -6.0, 7.0, 9.0, 3.0, 0.0, 7.0, 0.0, 9.0, -9.0, 1.0, 4.0, -9.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(7.0, 7.0, -6.0, -6.0, 8.0, -2.0, 4.0, -6.0, 7.0, -4.0, -8.0, -2.0, -2.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(0.0, 3.0, 3.0, 8.0, 3.0, 7.0, -3.0, 1.0, -8.0, 3.0, 7.0, -3.0, 7.0, 5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(3.0, -1.0, 1.0, 1.0, -3.0, 9.0, 9.0, -5.0, 5.0, -1.0, 6.0, -1.0, -4.0, -9.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-3.0, 8.0, -3.0, -7.0, -4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-1.0, 5.0, 8.0, -3.0, -9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-3.0, 3.0, 3.0, -3.0, -6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(0.0, -2.0, -9.0, 6.0, -2.0, -1.0, 8.0, 5.0, 1.0, 7.0, 0.0, -1.0, 1.0, -2.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(-9.0, -7.0, 3.0, -8.0, 8.0, 3.0, 6.0, -3.0, 8.0, -1.0, 8.0, 0.0, 5.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(-2.0, -9.0, 2.0, 5.0, 5.0, 4.0, 1.0, 4.0, -7.0, -4.0, -2.0, -8.0, -7.0, 9.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-9.0, 1.0, 7.0, -3.0, -8.0, 7.0, 0.0, 6.0, -9.0, -5.0, 9.0, -7.0, 6.0, -9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(3.0, -9.0, -5.0, 9.0, -5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(6.0, -4.0, -9.0, 2.0, 1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(-8.0, -8.0, 8.0, -1.0, -8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(8.0, 8.0, -7.0, -5.0, 0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(0.0, 6.0, -8.0, -6.0, 7.0, 9.0, 7.0, -8.0, 2.0, 6.0, 0.0, 5.0, -8.0, 5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(0.0, 8.0, 3.0, 5.0, -1.0, 7.0, -5.0, 0.0, -3.0, -6.0, -8.0, -6.0, 6.0, -3.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(-3.0, -7.0, -9.0, 0.0, 6.0, 2.0, -6.0, -9.0, -4.0, -6.0, 3.0, 4.0, 7.0, 1.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(-6.0, 7.0, 3.0, 2.0, 4.0, 8.0, 8.0, -3.0, -8.0, -1.0, -7.0, -6.0, 7.0, -3.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-9.0, 0.0, -1.0, -4.0));
	var[0][0][0][1] = (vec4(-9.0, -4.0, -9.0, -5.0));
	var[0][0][0][2] = (vec4(-2.0, 9.0, 0.0, -8.0));
	var[0][0][0][3] = (vec4(-6.0, -3.0, -8.0, 3.0));
	var[0][0][1][0] = (vec4(4.0, 9.0, 4.0, -3.0));
	var[0][0][1][1] = (vec4(7.0, -9.0, 6.0, 5.0));
	var[0][0][1][2] = (vec4(6.0, -1.0, -3.0, -3.0));
	var[0][0][1][3] = (vec4(-9.0, 3.0, -9.0, 0.0));
	var[0][1][0][0] = (vec4(-5.0, 9.0, 9.0, 4.0));
	var[0][1][0][1] = (vec4(6.0, -2.0, -1.0, -2.0));
	var[0][1][0][2] = (vec4(0.0, 5.0, -4.0, 5.0));
	var[0][1][0][3] = (vec4(8.0, -8.0, 9.0, -3.0));
	var[0][1][1][0] = (vec4(4.0, -8.0, -1.0, 0.0));
	var[0][1][1][1] = (vec4(-3.0, -4.0, -7.0, 1.0));
	var[0][1][1][2] = (vec4(4.0, -2.0, 1.0, -8.0));
	var[0][1][1][3] = (vec4(-8.0, 5.0, 4.0, 7.0));
	var[0][2][0][0] = (vec4(-1.0, -6.0, -8.0, -9.0));
	var[0][2][0][1] = (vec4(0.0, 3.0, 6.0, -1.0));
	var[0][2][0][2] = (vec4(4.0, 6.0, 8.0, 1.0));
	var[0][2][0][3] = (vec4(9.0, -4.0, 7.0, 7.0));
	var[0][2][1][0] = (vec4(2.0, -1.0, -8.0, 9.0));
	var[0][2][1][1] = (vec4(-1.0, 7.0, -4.0, 2.0));
	var[0][2][1][2] = (vec4(9.0, 2.0, -2.0, -1.0));
	var[0][2][1][3] = (vec4(7.0, 3.0, -6.0, 0.0));
	var[0][3][0][0] = (vec4(1.0, -3.0, -1.0, 9.0));
	var[0][3][0][1] = (vec4(-4.0, -5.0, 6.0, 9.0));
	var[0][3][0][2] = (vec4(-5.0, -7.0, 1.0, 2.0));
	var[0][3][0][3] = (vec4(-7.0, 2.0, -8.0, 9.0));
	var[0][3][1][0] = (vec4(-1.0, 2.0, 4.0, 1.0));
	var[0][3][1][1] = (vec4(5.0, -8.0, -7.0, 3.0));
	var[0][3][1][2] = (vec4(-5.0, 2.0, 5.0, 7.0));
	var[0][3][1][3] = (vec4(-9.0, 2.0, -7.0, 9.0));
	var[1][0][0][0] = (vec4(1.0, -4.0, -6.0, 5.0));
	var[1][0][0][1] = (vec4(2.0, 1.0, 9.0, -4.0));
	var[1][0][0][2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	var[1][0][0][3] = (vec4(9.0, 9.0, -5.0, -7.0));
	var[1][0][1][0] = (vec4(-9.0, 5.0, 8.0, 6.0));
	var[1][0][1][1] = (vec4(4.0, 6.0, -1.0, -7.0));
	var[1][0][1][2] = (vec4(7.0, 8.0, 5.0, -1.0));
	var[1][0][1][3] = (vec4(8.0, 2.0, -8.0, 0.0));
	var[1][1][0][0] = (vec4(7.0, -2.0, -6.0, 9.0));
	var[1][1][0][1] = (vec4(-7.0, -5.0, 2.0, 2.0));
	var[1][1][0][2] = (vec4(4.0, 8.0, 4.0, -9.0));
	var[1][1][0][3] = (vec4(0.0, -9.0, 0.0, 0.0));
	var[1][1][1][0] = (vec4(9.0, -1.0, -1.0, -3.0));
	var[1][1][1][1] = (vec4(-9.0, -6.0, -8.0, 4.0));
	var[1][1][1][2] = (vec4(-6.0, 9.0, -8.0, 3.0));
	var[1][1][1][3] = (vec4(0.0, 1.0, -1.0, -7.0));
	var[1][2][0][0] = (vec4(-7.0, -8.0, -7.0, 8.0));
	var[1][2][0][1] = (vec4(5.0, 7.0, -3.0, -2.0));
	var[1][2][0][2] = (vec4(9.0, -5.0, -2.0, -2.0));
	var[1][2][0][3] = (vec4(2.0, 4.0, -1.0, 9.0));
	var[1][2][1][0] = (vec4(3.0, 3.0, 4.0, -8.0));
	var[1][2][1][1] = (vec4(-3.0, -9.0, 9.0, -7.0));
	var[1][2][1][2] = (vec4(-7.0, 9.0, -4.0, 0.0));
	var[1][2][1][3] = (vec4(-4.0, -3.0, 0.0, 6.0));
	var[1][3][0][0] = (vec4(-7.0, 5.0, -6.0, -3.0));
	var[1][3][0][1] = (vec4(6.0, -2.0, 9.0, 1.0));
	var[1][3][0][2] = (vec4(0.0, -3.0, -6.0, -8.0));
	var[1][3][0][3] = (vec4(-4.0, 0.0, -2.0, 0.0));
	var[1][3][1][0] = (vec4(-8.0, 9.0, 5.0, 6.0));
	var[1][3][1][1] = (vec4(-9.0, 1.0, 2.0, 8.0));
	var[1][3][1][2] = (vec4(2.0, 9.0, 8.0, 5.0));
	var[1][3][1][3] = (vec4(-8.0, 4.0, -3.0, -4.0));
	var[2][0][0][0] = (vec4(-9.0, -1.0, -5.0, 7.0));
	var[2][0][0][1] = (vec4(3.0, 1.0, 2.0, 2.0));
	var[2][0][0][2] = (vec4(-3.0, -7.0, 1.0, 0.0));
	var[2][0][0][3] = (vec4(9.0, 5.0, -2.0, 6.0));
	var[2][0][1][0] = (vec4(-9.0, 1.0, 2.0, -3.0));
	var[2][0][1][1] = (vec4(-2.0, -2.0, -8.0, -4.0));
	var[2][0][1][2] = (vec4(7.0, -4.0, -1.0, 2.0));
	var[2][0][1][3] = (vec4(7.0, 7.0, 2.0, 8.0));
	var[2][1][0][0] = (vec4(-9.0, -4.0, 4.0, 6.0));
	var[2][1][0][1] = (vec4(4.0, 9.0, 4.0, -4.0));
	var[2][1][0][2] = (vec4(3.0, -1.0, 2.0, 8.0));
	var[2][1][0][3] = (vec4(-3.0, -6.0, -4.0, 0.0));
	var[2][1][1][0] = (vec4(2.0, -1.0, 1.0, -1.0));
	var[2][1][1][1] = (vec4(8.0, 5.0, 3.0, 0.0));
	var[2][1][1][2] = (vec4(-2.0, 0.0, 7.0, -5.0));
	var[2][1][1][3] = (vec4(6.0, 0.0, 6.0, -6.0));
	var[2][2][0][0] = (vec4(-5.0, -7.0, 3.0, -9.0));
	var[2][2][0][1] = (vec4(4.0, 5.0, 0.0, -6.0));
	var[2][2][0][2] = (vec4(7.0, 4.0, 1.0, 9.0));
	var[2][2][0][3] = (vec4(-8.0, 8.0, 7.0, 4.0));
	var[2][2][1][0] = (vec4(-1.0, 5.0, 9.0, -2.0));
	var[2][2][1][1] = (vec4(-5.0, -8.0, 2.0, -5.0));
	var[2][2][1][2] = (vec4(3.0, -8.0, -1.0, -5.0));
	var[2][2][1][3] = (vec4(-6.0, -2.0, 3.0, 0.0));
	var[2][3][0][0] = (vec4(-5.0, -3.0, 4.0, -1.0));
	var[2][3][0][1] = (vec4(5.0, -5.0, 4.0, 2.0));
	var[2][3][0][2] = (vec4(-4.0, -6.0, -2.0, 5.0));
	var[2][3][0][3] = (vec4(-1.0, -4.0, 1.0, 6.0));
	var[2][3][1][0] = (vec4(-1.0, 0.0, 3.0, -1.0));
	var[2][3][1][1] = (vec4(9.0, 4.0, 8.0, 0.0));
	var[2][3][1][2] = (vec4(0.0, -3.0, -3.0, 1.0));
	var[2][3][1][3] = (vec4(4.0, 6.0, -3.0, -5.0));
}
#version 450
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
	allOk = compare_mat4(var[0][0][0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(4.0, 4.0, 9.0, -7.0, 9.0, 2.0, 3.0, 7.0, 0.0, -9.0, 2.0, -1.0, -8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(0.0, -3.0, -1.0, -1.0, -6.0, 1.0, -8.0, 1.0, 5.0, 0.0, 2.0, -1.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(0.0, 0.0, -1.0, 0.0, -9.0, 5.0, 4.0, 0.0, -6.0, -7.0, 1.0, -9.0, -4.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(0.0, 5.0, -7.0, -5.0, 9.0, 2.0, -2.0, 5.0, 8.0, -7.0, 9.0, 9.0, -8.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(7.0, 5.0, -2.0, -4.0, 0.0, 1.0, -6.0, -3.0, -1.0, -7.0, -7.0, -6.0, 1.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(8.0, -3.0, 9.0, 6.0, -2.0, -9.0, 4.0, 5.0, 6.0, 4.0, -3.0, -8.0, 6.0, 5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(5.0, 3.0, 5.0, -5.0, 6.0, 3.0, 0.0, -9.0, -1.0, 0.0, -8.0, 3.0, 4.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-6.0, -9.0, -8.0, -2.0, -6.0, -8.0, 8.0, 4.0, 4.0, 1.0, 5.0, 0.0, -1.0, 4.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(-2.0, 5.0, 8.0, 4.0, -4.0, 9.0, 3.0, -5.0, 1.0, -6.0, 1.0, -5.0, 8.0, 7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(3.0, 0.0, -3.0, 3.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -9.0, -7.0, 1.0, -5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(-2.0, 2.0, 9.0, 7.0, -2.0, -6.0, -3.0, -7.0, 1.0, 2.0, -3.0, 0.0, -5.0, 5.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(3.0, 5.0, 2.0, -6.0, 9.0, 7.0, 4.0, 4.0, 5.0, 8.0, 4.0, -9.0, 3.0, -7.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	var[0][0][0][1] = (vec4(2.0, -4.0, 3.0, -5.0));
	var[0][0][0][2] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[0][0][0][3] = (vec4(3.0, 0.0, -4.0, -1.0));
	var[0][0][1][0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	var[0][0][1][1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	var[0][0][1][2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	var[0][0][1][3] = (vec4(6.0, -9.0, -1.0, -5.0));
	var[0][1][0][0] = (vec4(-4.0, -3.0, 4.0, -8.0));
	var[0][1][0][1] = (vec4(-2.0, 0.0, -8.0, 2.0));
	var[0][1][0][2] = (vec4(-3.0, -5.0, 3.0, -2.0));
	var[0][1][0][3] = (vec4(-9.0, -8.0, -3.0, 5.0));
	var[0][1][1][0] = (vec4(-9.0, 6.0, -6.0, 7.0));
	var[0][1][1][1] = (vec4(-8.0, 2.0, 7.0, -5.0));
	var[0][1][1][2] = (vec4(0.0, -4.0, -7.0, 6.0));
	var[0][1][1][3] = (vec4(0.0, 0.0, 4.0, -5.0));
	var[0][2][0][0] = (vec4(-3.0, 9.0, 5.0, -2.0));
	var[0][2][0][1] = (vec4(-7.0, 3.0, 3.0, 1.0));
	var[0][2][0][2] = (vec4(-7.0, -9.0, -5.0, -7.0));
	var[0][2][0][3] = (vec4(-7.0, -8.0, -2.0, -8.0));
	var[0][2][1][0] = (vec4(3.0, 7.0, 3.0, 7.0));
	var[0][2][1][1] = (vec4(-8.0, 9.0, -9.0, -9.0));
	var[0][2][1][2] = (vec4(3.0, -4.0, -8.0, 3.0));
	var[0][2][1][3] = (vec4(9.0, -7.0, -5.0, -5.0));
	var[0][3][0][0] = (vec4(-2.0, -9.0, -3.0, -3.0));
	var[0][3][0][1] = (vec4(-3.0, 0.0, -7.0, 1.0));
	var[0][3][0][2] = (vec4(6.0, -1.0, 3.0, 4.0));
	var[0][3][0][3] = (vec4(8.0, 7.0, 7.0, -9.0));
	var[0][3][1][0] = (vec4(-9.0, 3.0, 5.0, 7.0));
	var[0][3][1][1] = (vec4(3.0, -6.0, -1.0, -5.0));
	var[0][3][1][2] = (vec4(9.0, -7.0, 9.0, -7.0));
	var[0][3][1][3] = (vec4(7.0, 5.0, -8.0, 6.0));
	var[1][0][0][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	var[1][0][0][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	var[1][0][0][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	var[1][0][0][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
	var[1][0][1][0] = (vec4(-3.0, 2.0, 9.0, -4.0));
	var[1][0][1][1] = (vec4(2.0, 9.0, -9.0, -2.0));
	var[1][0][1][2] = (vec4(-1.0, 1.0, -9.0, 0.0));
	var[1][0][1][3] = (vec4(-7.0, 7.0, -3.0, -9.0));
	var[1][1][0][0] = (vec4(-1.0, -9.0, -7.0, 5.0));
	var[1][1][0][1] = (vec4(3.0, 9.0, -8.0, -6.0));
	var[1][1][0][2] = (vec4(-3.0, 6.0, -9.0, 4.0));
	var[1][1][0][3] = (vec4(6.0, -6.0, -6.0, -2.0));
	var[1][1][1][0] = (vec4(-8.0, -3.0, -8.0, 5.0));
	var[1][1][1][1] = (vec4(6.0, -9.0, -7.0, -7.0));
	var[1][1][1][2] = (vec4(6.0, 1.0, 0.0, -3.0));
	var[1][1][1][3] = (vec4(4.0, 1.0, -7.0, 4.0));
	var[1][2][0][0] = (vec4(2.0, 2.0, -3.0, 9.0));
	var[1][2][0][1] = (vec4(0.0, -6.0, 7.0, 1.0));
	var[1][2][0][2] = (vec4(-1.0, 2.0, -7.0, 2.0));
	var[1][2][0][3] = (vec4(-1.0, -6.0, -8.0, 1.0));
	var[1][2][1][0] = (vec4(1.0, -4.0, -6.0, -4.0));
	var[1][2][1][1] = (vec4(-9.0, 0.0, -2.0, 6.0));
	var[1][2][1][2] = (vec4(3.0, 3.0, 4.0, -6.0));
	var[1][2][1][3] = (vec4(-7.0, 9.0, -1.0, 6.0));
	var[1][3][0][0] = (vec4(1.0, 7.0, -7.0, -7.0));
	var[1][3][0][1] = (vec4(-9.0, -7.0, -8.0, 7.0));
	var[1][3][0][2] = (vec4(5.0, -2.0, 5.0, -4.0));
	var[1][3][0][3] = (vec4(-8.0, 0.0, 0.0, 7.0));
	var[1][3][1][0] = (vec4(-9.0, 2.0, -4.0, 0.0));
	var[1][3][1][1] = (vec4(-5.0, -8.0, -8.0, 2.0));
	var[1][3][1][2] = (vec4(9.0, -9.0, -6.0, 5.0));
	var[1][3][1][3] = (vec4(0.0, 9.0, 6.0, 5.0));
	var[2][0][0][0] = (vec4(-1.0, 0.0, 7.0, 7.0));
	var[2][0][0][1] = (vec4(-5.0, -2.0, -6.0, 0.0));
	var[2][0][0][2] = (vec4(-2.0, 1.0, -2.0, 4.0));
	var[2][0][0][3] = (vec4(4.0, 0.0, 0.0, -2.0));
	var[2][0][1][0] = (vec4(4.0, 7.0, -5.0, -3.0));
	var[2][0][1][1] = (vec4(9.0, 1.0, 5.0, 5.0));
	var[2][0][1][2] = (vec4(9.0, -4.0, -6.0, 8.0));
	var[2][0][1][3] = (vec4(1.0, -5.0, 5.0, -3.0));
	var[2][1][0][0] = (vec4(6.0, 4.0, 3.0, -5.0));
	var[2][1][0][1] = (vec4(-8.0, 0.0, -2.0, 7.0));
	var[2][1][0][2] = (vec4(5.0, -1.0, -3.0, -2.0));
	var[2][1][0][3] = (vec4(-6.0, -9.0, -3.0, 5.0));
	var[2][1][1][0] = (vec4(8.0, 7.0, -4.0, 1.0));
	var[2][1][1][1] = (vec4(6.0, -9.0, 8.0, 3.0));
	var[2][1][1][2] = (vec4(-6.0, -7.0, 7.0, -1.0));
	var[2][1][1][3] = (vec4(-7.0, 6.0, -5.0, 9.0));
	var[2][2][0][0] = (vec4(-8.0, -1.0, 0.0, -8.0));
	var[2][2][0][1] = (vec4(3.0, -1.0, 9.0, -7.0));
	var[2][2][0][2] = (vec4(-4.0, 7.0, 9.0, -5.0));
	var[2][2][0][3] = (vec4(2.0, -8.0, 7.0, 8.0));
	var[2][2][1][0] = (vec4(1.0, -8.0, -3.0, -8.0));
	var[2][2][1][1] = (vec4(-8.0, -6.0, -2.0, -9.0));
	var[2][2][1][2] = (vec4(-4.0, 4.0, -9.0, -5.0));
	var[2][2][1][3] = (vec4(-2.0, 9.0, -7.0, -6.0));
	var[2][3][0][0] = (vec4(-2.0, -9.0, 6.0, -7.0));
	var[2][3][0][1] = (vec4(5.0, 4.0, 2.0, -6.0));
	var[2][3][0][2] = (vec4(-8.0, -7.0, 4.0, 1.0));
	var[2][3][0][3] = (vec4(1.0, 1.0, 6.0, 2.0));
	var[2][3][1][0] = (vec4(-7.0, 8.0, -8.0, 4.0));
	var[2][3][1][1] = (vec4(2.0, 3.0, -3.0, -2.0));
	var[2][3][1][2] = (vec4(9.0, 1.0, -8.0, 2.0));
	var[2][3][1][3] = (vec4(2.0, -1.0, -9.0, 9.0));
}
#version 450
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
	allOk = compare_mat4(var[0][0][0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(4.0, 4.0, 9.0, -7.0, 9.0, 2.0, 3.0, 7.0, 0.0, -9.0, 2.0, -1.0, -8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(0.0, -3.0, -1.0, -1.0, -6.0, 1.0, -8.0, 1.0, 5.0, 0.0, 2.0, -1.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(0.0, 0.0, -1.0, 0.0, -9.0, 5.0, 4.0, 0.0, -6.0, -7.0, 1.0, -9.0, -4.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(0.0, 5.0, -7.0, -5.0, 9.0, 2.0, -2.0, 5.0, 8.0, -7.0, 9.0, 9.0, -8.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(7.0, 5.0, -2.0, -4.0, 0.0, 1.0, -6.0, -3.0, -1.0, -7.0, -7.0, -6.0, 1.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(8.0, -3.0, 9.0, 6.0, -2.0, -9.0, 4.0, 5.0, 6.0, 4.0, -3.0, -8.0, 6.0, 5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(5.0, 3.0, 5.0, -5.0, 6.0, 3.0, 0.0, -9.0, -1.0, 0.0, -8.0, 3.0, 4.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-6.0, -9.0, -8.0, -2.0, -6.0, -8.0, 8.0, 4.0, 4.0, 1.0, 5.0, 0.0, -1.0, 4.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(-2.0, 5.0, 8.0, 4.0, -4.0, 9.0, 3.0, -5.0, 1.0, -6.0, 1.0, -5.0, 8.0, 7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(3.0, 0.0, -3.0, 3.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -9.0, -7.0, 1.0, -5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(-2.0, 2.0, 9.0, 7.0, -2.0, -6.0, -3.0, -7.0, 1.0, 2.0, -3.0, 0.0, -5.0, 5.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(3.0, 5.0, 2.0, -6.0, 9.0, 7.0, 4.0, 4.0, 5.0, 8.0, 4.0, -9.0, 3.0, -7.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	var[0][0][0][1] = (vec4(2.0, -4.0, 3.0, -5.0));
	var[0][0][0][2] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[0][0][0][3] = (vec4(3.0, 0.0, -4.0, -1.0));
	var[0][0][1][0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	var[0][0][1][1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	var[0][0][1][2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	var[0][0][1][3] = (vec4(6.0, -9.0, -1.0, -5.0));
	var[0][1][0][0] = (vec4(-4.0, -3.0, 4.0, -8.0));
	var[0][1][0][1] = (vec4(-2.0, 0.0, -8.0, 2.0));
	var[0][1][0][2] = (vec4(-3.0, -5.0, 3.0, -2.0));
	var[0][1][0][3] = (vec4(-9.0, -8.0, -3.0, 5.0));
	var[0][1][1][0] = (vec4(-9.0, 6.0, -6.0, 7.0));
	var[0][1][1][1] = (vec4(-8.0, 2.0, 7.0, -5.0));
	var[0][1][1][2] = (vec4(0.0, -4.0, -7.0, 6.0));
	var[0][1][1][3] = (vec4(0.0, 0.0, 4.0, -5.0));
	var[0][2][0][0] = (vec4(-3.0, 9.0, 5.0, -2.0));
	var[0][2][0][1] = (vec4(-7.0, 3.0, 3.0, 1.0));
	var[0][2][0][2] = (vec4(-7.0, -9.0, -5.0, -7.0));
	var[0][2][0][3] = (vec4(-7.0, -8.0, -2.0, -8.0));
	var[0][2][1][0] = (vec4(3.0, 7.0, 3.0, 7.0));
	var[0][2][1][1] = (vec4(-8.0, 9.0, -9.0, -9.0));
	var[0][2][1][2] = (vec4(3.0, -4.0, -8.0, 3.0));
	var[0][2][1][3] = (vec4(9.0, -7.0, -5.0, -5.0));
	var[0][3][0][0] = (vec4(-2.0, -9.0, -3.0, -3.0));
	var[0][3][0][1] = (vec4(-3.0, 0.0, -7.0, 1.0));
	var[0][3][0][2] = (vec4(6.0, -1.0, 3.0, 4.0));
	var[0][3][0][3] = (vec4(8.0, 7.0, 7.0, -9.0));
	var[0][3][1][0] = (vec4(-9.0, 3.0, 5.0, 7.0));
	var[0][3][1][1] = (vec4(3.0, -6.0, -1.0, -5.0));
	var[0][3][1][2] = (vec4(9.0, -7.0, 9.0, -7.0));
	var[0][3][1][3] = (vec4(7.0, 5.0, -8.0, 6.0));
	var[1][0][0][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	var[1][0][0][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	var[1][0][0][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	var[1][0][0][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
	var[1][0][1][0] = (vec4(-3.0, 2.0, 9.0, -4.0));
	var[1][0][1][1] = (vec4(2.0, 9.0, -9.0, -2.0));
	var[1][0][1][2] = (vec4(-1.0, 1.0, -9.0, 0.0));
	var[1][0][1][3] = (vec4(-7.0, 7.0, -3.0, -9.0));
	var[1][1][0][0] = (vec4(-1.0, -9.0, -7.0, 5.0));
	var[1][1][0][1] = (vec4(3.0, 9.0, -8.0, -6.0));
	var[1][1][0][2] = (vec4(-3.0, 6.0, -9.0, 4.0));
	var[1][1][0][3] = (vec4(6.0, -6.0, -6.0, -2.0));
	var[1][1][1][0] = (vec4(-8.0, -3.0, -8.0, 5.0));
	var[1][1][1][1] = (vec4(6.0, -9.0, -7.0, -7.0));
	var[1][1][1][2] = (vec4(6.0, 1.0, 0.0, -3.0));
	var[1][1][1][3] = (vec4(4.0, 1.0, -7.0, 4.0));
	var[1][2][0][0] = (vec4(2.0, 2.0, -3.0, 9.0));
	var[1][2][0][1] = (vec4(0.0, -6.0, 7.0, 1.0));
	var[1][2][0][2] = (vec4(-1.0, 2.0, -7.0, 2.0));
	var[1][2][0][3] = (vec4(-1.0, -6.0, -8.0, 1.0));
	var[1][2][1][0] = (vec4(1.0, -4.0, -6.0, -4.0));
	var[1][2][1][1] = (vec4(-9.0, 0.0, -2.0, 6.0));
	var[1][2][1][2] = (vec4(3.0, 3.0, 4.0, -6.0));
	var[1][2][1][3] = (vec4(-7.0, 9.0, -1.0, 6.0));
	var[1][3][0][0] = (vec4(1.0, 7.0, -7.0, -7.0));
	var[1][3][0][1] = (vec4(-9.0, -7.0, -8.0, 7.0));
	var[1][3][0][2] = (vec4(5.0, -2.0, 5.0, -4.0));
	var[1][3][0][3] = (vec4(-8.0, 0.0, 0.0, 7.0));
	var[1][3][1][0] = (vec4(-9.0, 2.0, -4.0, 0.0));
	var[1][3][1][1] = (vec4(-5.0, -8.0, -8.0, 2.0));
	var[1][3][1][2] = (vec4(9.0, -9.0, -6.0, 5.0));
	var[1][3][1][3] = (vec4(0.0, 9.0, 6.0, 5.0));
	var[2][0][0][0] = (vec4(-1.0, 0.0, 7.0, 7.0));
	var[2][0][0][1] = (vec4(-5.0, -2.0, -6.0, 0.0));
	var[2][0][0][2] = (vec4(-2.0, 1.0, -2.0, 4.0));
	var[2][0][0][3] = (vec4(4.0, 0.0, 0.0, -2.0));
	var[2][0][1][0] = (vec4(4.0, 7.0, -5.0, -3.0));
	var[2][0][1][1] = (vec4(9.0, 1.0, 5.0, 5.0));
	var[2][0][1][2] = (vec4(9.0, -4.0, -6.0, 8.0));
	var[2][0][1][3] = (vec4(1.0, -5.0, 5.0, -3.0));
	var[2][1][0][0] = (vec4(6.0, 4.0, 3.0, -5.0));
	var[2][1][0][1] = (vec4(-8.0, 0.0, -2.0, 7.0));
	var[2][1][0][2] = (vec4(5.0, -1.0, -3.0, -2.0));
	var[2][1][0][3] = (vec4(-6.0, -9.0, -3.0, 5.0));
	var[2][1][1][0] = (vec4(8.0, 7.0, -4.0, 1.0));
	var[2][1][1][1] = (vec4(6.0, -9.0, 8.0, 3.0));
	var[2][1][1][2] = (vec4(-6.0, -7.0, 7.0, -1.0));
	var[2][1][1][3] = (vec4(-7.0, 6.0, -5.0, 9.0));
	var[2][2][0][0] = (vec4(-8.0, -1.0, 0.0, -8.0));
	var[2][2][0][1] = (vec4(3.0, -1.0, 9.0, -7.0));
	var[2][2][0][2] = (vec4(-4.0, 7.0, 9.0, -5.0));
	var[2][2][0][3] = (vec4(2.0, -8.0, 7.0, 8.0));
	var[2][2][1][0] = (vec4(1.0, -8.0, -3.0, -8.0));
	var[2][2][1][1] = (vec4(-8.0, -6.0, -2.0, -9.0));
	var[2][2][1][2] = (vec4(-4.0, 4.0, -9.0, -5.0));
	var[2][2][1][3] = (vec4(-2.0, 9.0, -7.0, -6.0));
	var[2][3][0][0] = (vec4(-2.0, -9.0, 6.0, -7.0));
	var[2][3][0][1] = (vec4(5.0, 4.0, 2.0, -6.0));
	var[2][3][0][2] = (vec4(-8.0, -7.0, 4.0, 1.0));
	var[2][3][0][3] = (vec4(1.0, 1.0, 6.0, 2.0));
	var[2][3][1][0] = (vec4(-7.0, 8.0, -8.0, 4.0));
	var[2][3][1][1] = (vec4(2.0, 3.0, -3.0, -2.0));
	var[2][3][1][2] = (vec4(9.0, 1.0, -8.0, 2.0));
	var[2][3][1][3] = (vec4(2.0, -1.0, -9.0, 9.0));
}
#version 450
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
	highp mat2x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(2.0, -7.0, 8.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(5.0, -2.0, 1.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-9.0, 9.0, 8.0, -5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(9.0, -3.0, -8.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(7.0, -5.0, -4.0, 2.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(0.0, 2.0, 2.0, 4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(-7.0, -4.0, 0.0, -8.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(-6.0, 3.0, 6.0, 5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(6.0, 7.0, 2.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(-5.0, 5.0, 9.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-8.0, 9.0, 4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-4.0, -8.0, 0.0, -2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(-7.0, -4.0, -2.0, -2.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(4.0, -2.0, -1.0, 3.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(-3.0, 3.0, -2.0, 7.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(0.0, 7.0, 6.0, 0.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(9.0, 7.0, 9.0, 5.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(1.0, 4.0, -6.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-3.0, 2.0, 2.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-3.0, 9.0, -3.0, -8.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(6.0, -7.0, -9.0, -5.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(-1.0, 5.0, 6.0, -4.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(-3.0, -8.0, 4.0, -4.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(-8.0, -6.0, 5.0, -2.0, -8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	var[0][0][1] = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	var[0][1][0] = (mat2x3(4.0, -7.0, -7.0, 6.0, -8.0, -8.0));
	var[0][1][1] = (mat2x3(7.0, -8.0, 4.0, 7.0, 0.0, 3.0));
	var[0][2][0] = (mat2x3(-1.0, 0.0, -8.0, 1.0, -2.0, -5.0));
	var[0][2][1] = (mat2x3(6.0, 6.0, 2.0, 0.0, 4.0, -7.0));
	var[0][3][0] = (mat2x3(-1.0, 6.0, -1.0, 2.0, -2.0, -5.0));
	var[0][3][1] = (mat2x3(-9.0, 4.0, -7.0, -5.0, -1.0, -3.0));
	var[1][0][0] = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
	var[1][0][1] = (mat2x3(-4.0, 3.0, 7.0, -5.0, -6.0, 7.0));
	var[1][1][0] = (mat2x3(9.0, 4.0, 7.0, 4.0, -7.0, 6.0));
	var[1][1][1] = (mat2x3(1.0, 3.0, 2.0, -1.0, -8.0, -8.0));
	var[1][2][0] = (mat2x3(1.0, -6.0, 8.0, 1.0, -5.0, 1.0));
	var[1][2][1] = (mat2x3(-7.0, -4.0, -4.0, -5.0, 3.0, 3.0));
	var[1][3][0] = (mat2x3(-4.0, 1.0, -4.0, 7.0, 3.0, 7.0));
	var[1][3][1] = (mat2x3(2.0, -9.0, -2.0, -7.0, 2.0, -7.0));
	var[2][0][0] = (mat2x3(3.0, 8.0, -7.0, -7.0, -6.0, 2.0));
	var[2][0][1] = (mat2x3(-8.0, 8.0, -7.0, -2.0, 5.0, 7.0));
	var[2][1][0] = (mat2x3(2.0, 9.0, -3.0, -1.0, -2.0, -1.0));
	var[2][1][1] = (mat2x3(-1.0, 8.0, 1.0, -6.0, -9.0, -3.0));
	var[2][2][0] = (mat2x3(1.0, 0.0, 9.0, 1.0, -8.0, -1.0));
	var[2][2][1] = (mat2x3(9.0, 5.0, -3.0, -9.0, -8.0, 3.0));
	var[2][3][0] = (mat2x3(-4.0, -8.0, 9.0, 3.0, -1.0, 7.0));
	var[2][3][1] = (mat2x3(-9.0, 4.0, -2.0, -8.0, 3.0, 0.0));
}
#version 450
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

layout(scalar, column_major, binding = 1) buffer Block
{
	highp mat3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(5.0, 9.0, -5.0, -4.0, 8.0, 3.0, -4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(5.0, 6.0, -6.0, -5.0, 4.0, 8.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(2.0, -7.0, 1.0, -7.0, -9.0, 5.0, 3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(4.0, -6.0, -5.0, -8.0, 3.0, -6.0, 3.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(-6.0, 8.0, 9.0, 6.0, -6.0, -2.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(-4.0, -8.0, -2.0, -5.0, -4.0, 2.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(-6.0, 0.0, 3.0, 6.0, -8.0, 1.0, -6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(3.0, -6.0, -3.0, -4.0, 8.0, 1.0, -8.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(-3.0, 9.0, 1.0, -4.0, -5.0, -5.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(6.0, -5.0, -2.0, 1.0, -4.0, 8.0, 3.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(-3.0, 1.0, -5.0, 4.0, -6.0, 6.0, 1.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(5.0, 0.0, 0.0, -4.0, 5.0, -5.0, 4.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	var[0][0][1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	var[0][1][0] = (mat3(3.0, 5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0));
	var[0][1][1] = (mat3(0.0, -4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0));
	var[0][2][0] = (mat3(-1.0, -3.0, 0.0, -4.0, -7.0, -5.0, 9.0, -1.0, -7.0));
	var[0][2][1] = (mat3(5.0, -8.0, 9.0, -7.0, 9.0, -8.0, -5.0, 9.0, 2.0));
	var[0][3][0] = (mat3(-6.0, -1.0, 0.0, -3.0, 8.0, -1.0, 6.0, 0.0, -6.0));
	var[0][3][1] = (mat3(9.0, 2.0, 4.0, 2.0, 8.0, -1.0, 0.0, -8.0, -9.0));
	var[1][0][0] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
	var[1][0][1] = (mat3(2.0, 1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0));
	var[1][1][0] = (mat3(9.0, 7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0));
	var[1][1][1] = (mat3(-6.0, -7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0));
	var[1][2][0] = (mat3(1.0, 9.0, -9.0, -1.0, 3.0, -5.0, -4.0, -9.0, -8.0));
	var[1][2][1] = (mat3(-9.0, 2.0, -4.0, -6.0, -2.0, 6.0, 4.0, 3.0, 0.0));
	var[1][3][0] = (mat3(-3.0, -9.0, 2.0, -3.0, 0.0, -5.0, -7.0, 7.0, -2.0));
	var[1][3][1] = (mat3(-8.0, 6.0, -6.0, 7.0, -9.0, -1.0, -7.0, 3.0, -2.0));
	var[2][0][0] = (mat3(-6.0, -8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0));
	var[2][0][1] = (mat3(2.0, -3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0));
	var[2][1][0] = (mat3(2.0, 4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0));
	var[2][1][1] = (mat3(-8.0, 3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0));
	var[2][2][0] = (mat3(-1.0, -8.0, -2.0, -5.0, 5.0, -8.0, -3.0, 4.0, -4.0));
	var[2][2][1] = (mat3(-5.0, 2.0, 5.0, 6.0, 7.0, 9.0, 1.0, -2.0, -9.0));
	var[2][3][0] = (mat3(6.0, -4.0, 4.0, 1.0, -6.0, -5.0, 0.0, 0.0, -2.0));
	var[2][3][1] = (mat3(2.0, -2.0, 2.0, 5.0, 1.0, -4.0, 3.0, 5.0, -2.0));
}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(-5, -1, -9)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-2.0, 6.0, -3.0, -6.0, -2.0, -6.0, 3.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(0.0, -9.0, 8.0, -9.0, 9.0, 3.0, 6.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(6.0, -1.0, 9.0, -2.0, -7.0, -8.0, 2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(-2.0, 0.0, -2.0, 7.0, -7.0, 6.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(4.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(t.a, mat3(-5.0, 7.0, -4.0, 0.0, -9.0, 8.0, 2.0, 1.0, 1.0)) && allOk;
	allOk = compare_ivec3((t.b.a), ivec3(8, 4, 1)) && allOk;
	allOk = compare_mat3(t.b.b[0], mat3(5.0, -8.0, 5.0, -2.0, 5.0, -9.0, -5.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3(t.b.b[1], mat3(3.0, -7.0, 6.0, -7.0, 4.0, 3.0, -3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(t.b.b[2], mat3(-6.0, -7.0, 5.0, -5.0, -2.0, -1.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3(t.b.b[3], mat3(-3.0, -5.0, 9.0, 1.0, -2.0, -6.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_vec4((t.b.c), vec4(9.0, -5.0, -8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	t.a[0] = (vec3(-7.0, -7.0, 1.0));
	t.a[1] = (vec3(-6.0, 2.0, 3.0));
	t.a[2] = (vec3(5.0, -2.0, 0.0));
	t.b.a = (ivec3(7, -8, -5));
	t.b.b[0][0] = (vec3(-4.0, -4.0, 0.0));
	t.b.b[0][1] = (vec3(6.0, -5.0, -2.0));
	t.b.b[0][2] = (vec3(-4.0, -3.0, 6.0));
	t.b.b[1][0] = (vec3(8.0, 4.0, -8.0));
	t.b.b[1][1] = (vec3(-8.0, -4.0, -1.0));
	t.b.b[1][2] = (vec3(5.0, 4.0, 6.0));
	t.b.b[2][0] = (vec3(-3.0, 7.0, -3.0));
	t.b.b[2][1] = (vec3(7.0, -2.0, 3.0));
	t.b.b[2][2] = (vec3(9.0, -7.0, -6.0));
	t.b.b[3][0] = (vec3(1.0, 6.0, -4.0));
	t.b.b[3][1] = (vec3(-7.0, -8.0, 2.0));
	t.b.b[3][2] = (vec3(5.0, 7.0, -2.0));
	t.b.c = (vec4(6.0, -1.0, -6.0, -4.0));
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
	allOk = compare_mat3(t[0].a, mat3(1.0, 2.0, 0.0, -7.0, 7.0, -5.0, 1.0, -5.0, 1.0)) && allOk;
	allOk = compare_ivec3((t[0].b[0].a), ivec3(-9, -3, -8)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[0]), ivec2(1, 1)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[1]), ivec2(0, 6)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[2]), ivec2(-9, -3)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[3]), ivec2(2, 5)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(9.0, -7.0, -5.0, -9.0)) && allOk;
	allOk = compare_ivec3((t[0].b[1].a), ivec3(0, -3, -9)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[0]), ivec2(6, 6)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[1]), ivec2(3, -6)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[2]), ivec2(0, 0)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[3]), ivec2(4, -4)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(9.0, -1.0, -6.0, 5.0)) && allOk;
	allOk = compare_ivec3((t[0].b[2].a), ivec3(4, -4, -2)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[0]), ivec2(-2, -9)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[1]), ivec2(9, 9)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[2]), ivec2(-2, 3)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[3]), ivec2(6, -3)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(-4.0, 6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(t[1].a, mat3(6.0, 2.0, -1.0, 4.0, 1.0, -3.0, 5.0, -5.0, -7.0)) && allOk;
	allOk = compare_ivec3((t[1].b[0].a), ivec3(-4, -3, 6)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[0]), ivec2(-4, -1)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[1]), ivec2(9, 4)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[2]), ivec2(-3, -3)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[3]), ivec2(2, 4)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-6.0, 8.0, -6.0, 7.0)) && allOk;
	allOk = compare_ivec3((t[1].b[1].a), ivec3(-8, -8, 5)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[0]), ivec2(9, -7)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[1]), ivec2(0, -2)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[2]), ivec2(4, 5)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[3]), ivec2(5, -3)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(6.0, 1.0, -4.0, 6.0)) && allOk;
	allOk = compare_ivec3((t[1].b[2].a), ivec3(2, -2, -8)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[0]), ivec2(-9, -6)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[1]), ivec2(-7, 4)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[2]), ivec2(-1, 4)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[3]), ivec2(8, -8)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(-8.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_uint((u), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(-8, 8, -7));
	s.b[0] = (ivec2(-9, 5));
	s.b[1] = (ivec2(2, 9));
	s.b[2] = (ivec2(-9, -9));
	s.b[3] = (ivec2(0, -3));
	s.c = (vec4(7.0, -9.0, 8.0, -2.0));
	u = (1u);
}
#version 450
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
	allOk = compare_mat3(block[0].t[0].a, mat3(8.0, -8.0, 9.0, 0.0, -2.0, -3.0, -7.0, 4.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(-8, -9, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(-8, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(9, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(8, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(2, -4)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(7.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(1, -7, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(1, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(4, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(-9, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(-1, -2)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-2.0, -2.0, 0.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(-2, -3, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(3, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(8, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(-9, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(-5, 6)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(8.0, -8.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(8.0, 0.0, 9.0, 1.0, 2.0, 1.0, 6.0, 1.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(5, 6, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(-3, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(8, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(9, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(-5, -5)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(-7.0, 1.0, 0.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(0, 4, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(-9, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(-7, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(-6, -3)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(9.0, -7.0, 6.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(-5, 1, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(5, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(-2, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(2, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(-5, -8)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(4.0, -5.0, 0.0, 1.0)) && allOk;
	allOk = compare_uint((block[0].u), 2u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(1.0, -6.0, -6.0, 5.0, -4.0, 4.0, 8.0, 5.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(9, -9, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(7, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(-6, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(-2, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(4, 6)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-8.0, 6.0, 4.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(-8, 8, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(1, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(8, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(2, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(-6, -6)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-3.0, 1.0, 9.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(7, -7, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(0, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(-4, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(3, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(0, 6)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-4.0, -2.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(-8.0, 3.0, -8.0, -2.0, 1.0, -6.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(-2, -5, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(-7, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(1, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(-1, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(-5, -9)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(-1.0, 0.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(5, 5, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(-7, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(3, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(7, 4)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(-1.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(1, -6, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(-7, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(4, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(4, 3)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(-2.0, 9.0, -4.0, -3.0)) && allOk;
	allOk = compare_uint((block[1].u), 6u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(3.0, -9.0, 6.0, 5.0, 5.0, 4.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(2, 9, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(-2, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(1, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(-6, 3)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-5.0, -8.0, 0.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(-6, -2, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(7, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(-8, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-5, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(6, 6)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(9.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(-6, -6, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(-4, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(2, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(2, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(-2, 1)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(5.0, 1.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(-2.0, 6.0, 1.0, -7.0, 8.0, -3.0, -6.0, 9.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(-5, -6, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(-8, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(-7, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(7, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(7, 2)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(7.0, 5.0, -6.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(6, -6, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(-5, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(9, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(-3, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(-4, 0)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(1.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(-1, 7, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(3, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(-3, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(-7, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(-8, 0)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(9.0, -7.0, 8.0, 2.0)) && allOk;
	allOk = compare_uint((block[2].u), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-3, -5, 3));
	block[0].s.b[0] = (ivec2(-2, -9));
	block[0].s.b[1] = (ivec2(-6, 1));
	block[0].s.b[2] = (ivec2(-4, 0));
	block[0].s.b[3] = (ivec2(4, 4));
	block[0].s.c = (vec4(-7.0, -8.0, -9.0, 6.0));
	block[0].u = (6u);
	block[1].s.a = (ivec3(8, -7, 3));
	block[1].s.b[0] = (ivec2(1, 6));
	block[1].s.b[1] = (ivec2(-9, -3));
	block[1].s.b[2] = (ivec2(1, 5));
	block[1].s.b[3] = (ivec2(-2, 4));
	block[1].s.c = (vec4(-1.0, 0.0, 3.0, -2.0));
	block[1].u = (5u);
	block[2].s.a = (ivec3(-9, -5, -2));
	block[2].s.b[0] = (ivec2(5, 2));
	block[2].s.b[1] = (ivec2(9, -3));
	block[2].s.b[2] = (ivec2(8, -1));
	block[2].s.b[3] = (ivec2(3, 4));
	block[2].s.c = (vec4(5.0, 3.0, 1.0, 6.0));
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
	allOk = compare_mat3(block[0].t[0].a, mat3(-8.0, 0.0, 6.0, -4.0, -5.0, 0.0, -4.0, 6.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(8, -3, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(8, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(-1, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(-8, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(-8, -9)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(7.0, 8.0, 0.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(1, 5, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(2, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(7, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(0, 5)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-4.0, 1.0, 1.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(-8, 6, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(3, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(3, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(-8, -9)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(3.0, -9.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(1.0, 8.0, -2.0, -9.0, -5.0, 3.0, -9.0, 6.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(-5, 2, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(-8, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(-7, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(3, 3)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(0.0, -2.0, -2.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(9, -9, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(-8, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(6, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(6, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(3, 7)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(0.0, -4.0, -7.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(2, -8, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(5, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(-9, 6)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(1.0, 0.0, 6.0, -2.0)) && allOk;
	allOk = compare_uint((block[0].u), 4u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(-6.0, -6.0, 0.0, 8.0, 7.0, -7.0, 7.0, -6.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(-4, 4, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(-2, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(-3, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(-4, -9)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-3.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(2, 8, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(3, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(-1, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(-8, 0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-6.0, -6.0, -1.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(-7, 8, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(-7, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(0, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(9, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(2, -4)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-9.0, 0.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(3.0, 8.0, 6.0, -4.0, 3.0, 6.0, 5.0, -3.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(9, 4, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(5, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(4, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(7, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(3, 4)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(-1.0, 3.0, 0.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(-7, 3, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(4, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(-9, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(-4, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(-8, -5)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(8.0, 2.0, -2.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(-3, -4, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(3, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(-5, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(-2, 5)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(-7.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_uint((block[1].u), 7u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(4.0, -2.0, 8.0, -7.0, 9.0, -8.0, -4.0, -6.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(2, -8, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(-3, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(-2, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(-5, 9)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-5.0, 7.0, -9.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(0, 7, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(-5, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(6, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-7, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(-8, 5)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(7.0, 5.0, -5.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(-7, 0, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(4, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(-9, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(4, 8)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(-5.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(-7.0, 0.0, -8.0, -1.0, 2.0, 6.0, 6.0, 6.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(4, -9, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(-9, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(2, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(3, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(1, -6)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(-7.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(1, 7, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(6, -7)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(3.0, 1.0, 7.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(4, 0, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(-9, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(-5, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(1, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(2, -8)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(2.0, 9.0, 5.0, 2.0)) && allOk;
	allOk = compare_uint((block[2].u), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-3, 1, 0));
	block[0].s.b[0] = (ivec2(-9, -4));
	block[0].s.b[1] = (ivec2(-7, 3));
	block[0].s.b[2] = (ivec2(-8, 0));
	block[0].s.b[3] = (ivec2(-3, -8));
	block[0].s.c = (vec4(9.0, 4.0, -7.0, -4.0));
	block[0].u = (5u);
	block[1].s.a = (ivec3(-8, 2, 2));
	block[1].s.b[0] = (ivec2(0, -4));
	block[1].s.b[1] = (ivec2(-7, 6));
	block[1].s.b[2] = (ivec2(5, 2));
	block[1].s.b[3] = (ivec2(-9, 5));
	block[1].s.c = (vec4(-5.0, 0.0, -3.0, 0.0));
	block[1].u = (1u);
	block[2].s.a = (ivec3(0, 7, 7));
	block[2].s.b[0] = (ivec2(7, -8));
	block[2].s.b[1] = (ivec2(2, -4));
	block[2].s.b[2] = (ivec2(-3, 0));
	block[2].s.b[3] = (ivec2(2, 4));
	block[2].s.c = (vec4(6.0, -3.0, 0.0, 2.0));
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
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(-4, 9, -5)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(2.0, -7.0, -1.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(2, 4, 5)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(-9.0, 3.0, 4.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(2, 9, -6)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(5.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(6, 7, 1)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(-6.0, -2.0, -3.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(9, -1, 9)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-8.0, 5.0, 3.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(-6, -4, -1)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(4.0, 2.0, -3.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(-3, 0, -9)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(-1.0, 5.0, 8.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(-1, 8, 4)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(-1.0, -4.0, 5.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(0, 9, -7)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(4.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(6, -1, 3)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-2.0, 7.0, 9.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(3, -3, 8)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(4.0, -3.0, 9.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(-4, 7, -4)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(-1.0, 9.0, -8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(2.0, -1.0, -4.0, 1.0));
	block[0].s[0][0].a = (ivec3(2, -2, 8));
	block[0].s[0][0].c = (vec4(7.0, -1.0, -6.0, -4.0));
	block[0].s[0][1].a = (ivec3(-2, -9, -6));
	block[0].s[0][1].c = (vec4(9.0, 8.0, -6.0, -2.0));
	block[0].s[1][0].a = (ivec3(7, 2, -4));
	block[0].s[1][0].c = (vec4(-8.0, -2.0, 7.0, -4.0));
	block[0].s[1][1].a = (ivec3(4, 2, 2));
	block[0].s[1][1].c = (vec4(-5.0, 2.0, 8.0, 8.0));
	block[0].s[2][0].a = (ivec3(3, -4, 6));
	block[0].s[2][0].c = (vec4(-9.0, 1.0, 9.0, -5.0));
	block[0].s[2][1].a = (ivec3(-6, -5, 3));
	block[0].s[2][1].c = (vec4(-8.0, -2.0, 7.0, -9.0));
	block[1].v = (vec4(6.0, -9.0, 1.0, 7.0));
	block[1].s[0][0].a = (ivec3(7, -2, -3));
	block[1].s[0][0].c = (vec4(-1.0, 5.0, -4.0, -9.0));
	block[1].s[0][1].a = (ivec3(-5, 0, 5));
	block[1].s[0][1].c = (vec4(-4.0, 7.0, -6.0, -7.0));
	block[1].s[1][0].a = (ivec3(-4, -7, -7));
	block[1].s[1][0].c = (vec4(-7.0, -6.0, -3.0, 8.0));
	block[1].s[1][1].a = (ivec3(4, -2, -1));
	block[1].s[1][1].c = (vec4(3.0, -4.0, -3.0, 4.0));
	block[2].v = (vec4(6.0, 8.0, -5.0, -9.0));
	block[2].s[0][0].a = (ivec3(-7, -1, -4));
	block[2].s[0][0].c = (vec4(3.0, -1.0, -1.0, 3.0));
	block[2].s[0][1].a = (ivec3(-7, -6, -3));
	block[2].s[0][1].c = (vec4(2.0, 3.0, 7.0, 8.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 3.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(8.0, -9.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(9.0, -6.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2(block[0].var[3], vec2(2.0, 3.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 5.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(3.0, 6.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-4.0, 1.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(5.0, 2.0)) && allOk;
	allOk = compare_vec2(block[1].var[3], vec2(-6.0, 5.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 9.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(2.0, -9.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(8.0, 9.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(2.0, -7.0)) && allOk;
	allOk = compare_vec2(block[2].var[3], vec2(-8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(4.0, -9.0));
	block[0].var[1] = (vec2(-2.0, 8.0));
	block[0].var[2] = (vec2(-4.0, 4.0));
	block[0].var[3] = (vec2(9.0, 5.0));
	block[1].var[0] = (vec2(-2.0, 4.0));
	block[1].var[1] = (vec2(6.0, -8.0));
	block[1].var[2] = (vec2(-5.0, -1.0));
	block[1].var[3] = (vec2(9.0, 0.0));
	block[2].var[0] = (vec2(5.0, -2.0));
	block[2].var[1] = (vec2(4.0, -5.0));
	block[2].var[2] = (vec2(-2.0, -4.0));
	block[2].var[3] = (vec2(6.0, 4.0));
}
#version 450
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
	highp mat2x4 var;
} block[3];

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

layout(binding = 1) buffer BlockA
{
	layout(offset = 0) highp float a;
	layout(offset = 4) lowp uvec3 b;
	layout(offset = 16) mediump mat2 c;
} blockA;
layout(binding = 2) buffer BlockB
{
	layout(offset = 0) mediump mat3 a;
	layout(offset = 48) lowp ivec2 b;
	layout(offset = 64) highp vec4 c;
	layout(offset = 80) bool d;
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
	allOk = compare_float((blockA.a), 1.0) && allOk;
	allOk = compare_float(blockA.c[0][0], 9.0) && allOk;
	allOk = compare_float(blockA.c[0][1], 9.0) && allOk;
	allOk = compare_float(blockA.c[1][0], -6.0) && allOk;
	allOk = compare_float(blockA.c[1][1], -9.0) && allOk;
	allOk = compare_vec2(blockA.c[0], vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec2(blockA.c[1], vec2(-6.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-5, -8)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (1.0);
	blockB.a = (mat3(8.0, -2.0, -7.0, 0.0, -5.0, -3.0, 1.0, 7.0, -6.0));
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
	allOk = compare_float((blockA[0].a), -6.0) && allOk;
	allOk = compare_float(blockA[0].c[0][0], -2.0) && allOk;
	allOk = compare_float(blockA[0].c[0][1], 3.0) && allOk;
	allOk = compare_float(blockA[0].c[1][0], -5.0) && allOk;
	allOk = compare_float(blockA[0].c[1][1], -3.0) && allOk;
	allOk = compare_vec2(blockA[0].c[0], vec2(-2.0, 3.0)) && allOk;
	allOk = compare_vec2(blockA[0].c[1], vec2(-5.0, -3.0)) && allOk;
	allOk = compare_float((blockA[1].a), 5.0) && allOk;
	allOk = compare_float(blockA[1].c[0][0], -5.0) && allOk;
	allOk = compare_float(blockA[1].c[0][1], -7.0) && allOk;
	allOk = compare_float(blockA[1].c[1][0], -1.0) && allOk;
	allOk = compare_float(blockA[1].c[1][1], 7.0) && allOk;
	allOk = compare_vec2(blockA[1].c[0], vec2(-5.0, -7.0)) && allOk;
	allOk = compare_vec2(blockA[1].c[1], vec2(-1.0, 7.0)) && allOk;
	allOk = compare_float((blockA[2].a), -2.0) && allOk;
	allOk = compare_float(blockA[2].c[0][0], -9.0) && allOk;
	allOk = compare_float(blockA[2].c[0][1], -5.0) && allOk;
	allOk = compare_float(blockA[2].c[1][0], 9.0) && allOk;
	allOk = compare_float(blockA[2].c[1][1], -5.0) && allOk;
	allOk = compare_vec2(blockA[2].c[0], vec2(-9.0, -5.0)) && allOk;
	allOk = compare_vec2(blockA[2].c[1], vec2(9.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-5, 4)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-5, -1)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(-5, 9)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (7.0);
	blockA[1].a = (9.0);
	blockA[2].a = (-4.0);
	blockB[0].a = (mat3(1.0, 8.0, 8.0, -7.0, 3.0, -6.0, -4.0, 8.0, -3.0));
	blockB[0].d = (true);
	blockB[1].a = (mat3(-5.0, -9.0, -7.0, -5.0, -5.0, 9.0, -9.0, 1.0, 8.0));
	blockB[1].d = (false);
	blockB[2].a = (mat3(0.0, -3.0, 4.0, 5.0, -9.0, 3.0, 0.0, -2.0, 4.0));
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
	highp mat4x3 a;
	lowp mat3x2 b;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	mediump mat3x4 c[6];
	highp mat3x4 d[];
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	mediump mat3x4 e[2];
	mediump ivec3 f;
	lowp uvec3 g;
	lowp ivec4 h;
	lowp mat4 i[];
} blockD;
layout(std140, column_major, binding = 4) readonly buffer BlockE
{
	mediump float j[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockC.c[0], mat3x4(-2.0, 1.0, 1.0, 7.0, -1.0, 9.0, -5.0, 8.0, 4.0, -9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockC.c[1], mat3x4(8.0, 2.0, -5.0, 9.0, 3.0, -5.0, -3.0, 0.0, -2.0, -4.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockC.c[2], mat3x4(-3.0, 5.0, -2.0, 4.0, -4.0, 8.0, -5.0, -4.0, -6.0, -3.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockC.c[3], mat3x4(9.0, 8.0, -5.0, 8.0, -4.0, -9.0, 6.0, 6.0, 8.0, -1.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockC.c[4], mat3x4(8.0, 6.0, 7.0, -7.0, 0.0, -3.0, 7.0, 5.0, -5.0, 4.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockC.c[5], mat3x4(2.0, -5.0, 6.0, 2.0, -7.0, -6.0, 2.0, 7.0, -8.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD.e[0], mat3x4(-2.0, 9.0, -7.0, 0.0, 4.0, -2.0, -9.0, 9.0, 8.0, -3.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockD.e[1], mat3x4(-1.0, -2.0, 2.0, 2.0, 7.0, -6.0, -4.0, 6.0, 8.0, 4.0, 1.0, -7.0)) && allOk;
	allOk = compare_ivec3((blockD.f), ivec3(-9, 6, -5)) && allOk;
	allOk = compare_ivec4((blockD.h), ivec4(-7, -4, -8, 7)) && allOk;
	allOk = compare_mat4(blockD.i[0], mat4(5.0, 5.0, 7.0, -3.0, 6.0, 8.0, -4.0, 6.0, -2.0, 6.0, -4.0, -5.0, 3.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4(blockD.i[1], mat4(3.0, 4.0, -8.0, 9.0, 5.0, -9.0, -5.0, 0.0, 9.0, -3.0, -5.0, 3.0, -5.0, 1.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(blockD.i[2], mat4(3.0, 5.0, 2.0, -7.0, -7.0, -3.0, -3.0, 7.0, 7.0, -8.0, -2.0, -4.0, 0.0, 6.0, 1.0, -2.0)) && allOk;
	allOk = compare_float((blockE.j[0]), -6.0) && allOk;
	allOk = compare_float((blockE.j[1]), 0.0) && allOk;
	allOk = compare_float((blockE.j[2]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat3x2(9.0, -5.0, 9.0, -3.0, 6.0, 7.0));
	blockC.c[0] = (mat3x4(-9.0, -6.0, -1.0, 3.0, 5.0, 3.0, 9.0, 8.0, -4.0, -8.0, -5.0, -1.0));
	blockC.c[1] = (mat3x4(2.0, 0.0, 5.0, 3.0, -3.0, 2.0, 4.0, 4.0, -6.0, 4.0, -5.0, -2.0));
	blockC.c[2] = (mat3x4(-4.0, -5.0, 7.0, 6.0, -9.0, 0.0, -7.0, 2.0, 1.0, 9.0, 2.0, -9.0));
	blockC.c[3] = (mat3x4(-2.0, -7.0, 8.0, 8.0, 8.0, 7.0, 9.0, -6.0, -3.0, -1.0, 3.0, 7.0));
	blockC.c[4] = (mat3x4(-2.0, -7.0, -7.0, -5.0, 3.0, 8.0, 6.0, -1.0, -8.0, -7.0, 3.0, 8.0));
	blockC.c[5] = (mat3x4(1.0, 4.0, -7.0, -3.0, 7.0, 0.0, -9.0, 0.0, -8.0, 2.0, -1.0, 4.0));
	blockC.d[0] = (mat3x4(-7.0, 7.0, 8.0, -3.0, 5.0, -2.0, 6.0, 7.0, -8.0, -1.0, 4.0, 4.0));
	blockC.d[1] = (mat3x4(-2.0, 3.0, -2.0, -4.0, 1.0, -1.0, -6.0, -4.0, 9.0, -2.0, 3.0, 4.0));
	blockC.d[2] = (mat3x4(8.0, -6.0, -3.0, 6.0, 8.0, -8.0, -6.0, -3.0, 2.0, -3.0, -5.0, -2.0));
	blockC.d[3] = (mat3x4(9.0, 5.0, 5.0, 3.0, 6.0, -4.0, -9.0, 1.0, 3.0, -8.0, -2.0, 0.0));
	blockC.d[4] = (mat3x4(6.0, 2.0, -8.0, -6.0, 1.0, -6.0, 3.0, -6.0, -1.0, 2.0, -2.0, 0.0));
	blockC.d[5] = (mat3x4(5.0, 9.0, 2.0, -7.0, 6.0, 9.0, 3.0, 1.0, -3.0, -1.0, 7.0, -5.0));
	blockC.d[6] = (mat3x4(7.0, 9.0, 8.0, -6.0, -9.0, -2.0, -5.0, 7.0, 3.0, 1.0, -9.0, -8.0));
	blockC.d[7] = (mat3x4(-2.0, 9.0, 1.0, 4.0, 4.0, 6.0, 4.0, -7.0, -8.0, 0.0, 9.0, -4.0));
	blockD.e[0] = (mat3x4(6.0, 2.0, 8.0, -4.0, 1.0, 5.0, -3.0, 6.0, -7.0, -9.0, 9.0, -8.0));
	blockD.e[1] = (mat3x4(-8.0, -3.0, -9.0, 0.0, -9.0, 4.0, 5.0, -7.0, 6.0, -1.0, -5.0, 4.0));
	blockD.f = (ivec3(-6, -3, 1));
	blockD.i[0] = (mat4(9.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -5.0, 3.0, -7.0, 7.0, 9.0, -5.0, -8.0, 6.0, -4.0));
	blockD.i[1] = (mat4(1.0, -9.0, -3.0, 5.0, 0.0, -8.0, 1.0, 3.0, -9.0, 3.0, 7.0, -2.0, 0.0, 8.0, 8.0, -4.0));
	blockD.i[2] = (mat4(9.0, 9.0, -4.0, -1.0, 8.0, 6.0, -4.0, -1.0, 7.0, 5.0, 9.0, -1.0, -6.0, -6.0, 6.0, -5.0));
}
#version 450
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
	lowp mat4 mB;
	bvec3 mC;
	bool mD;
};
struct sB
{
	highp uint mA;
};
struct sC
{
	highp uvec3 mA;
	lowp mat4 mB;
	mediump uvec4 mC;
	mediump uvec3 mD;
};
layout(std430, binding = 1) buffer BlockB
{
	mediump vec2 a[1];
	bool b;
	lowp ivec2 c;
	highp uvec4 d;
	sA e[];
};
layout(std140, binding = 2) buffer BlockC
{
	sB f;
	sC g;
	mediump mat4x2 h;
	bvec4 i;
	bvec3 j;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((a[0]), vec2(6.0, 8.0)) && allOk;
	allOk = compare_bool((b), true) && allOk;
	allOk = compare_uvec4((d), uvec4(9u, 3u, 5u, 6u)) && allOk;
	allOk = compare_ivec3((e[0].mA), ivec3(-1, -2, 1)) && allOk;
	allOk = compare_mat4(e[0].mB, mat4(6.0, 5.0, 7.0, -2.0, -4.0, -9.0, 8.0, 3.0, 0.0, 2.0, 1.0, 8.0, 0.0, 9.0, -1.0, -1.0)) && allOk;
	allOk = compare_bvec3((e[0].mC), bvec3(true, true, false)) && allOk;
	allOk = compare_bool((e[0].mD), false) && allOk;
	allOk = compare_mat4x2(blockC.h, mat4x2(-9.0, -8.0, -2.0, -8.0, -2.0, -9.0, 0.0, -8.0)) && allOk;
	allOk = compare_bvec4((blockC.i), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec3((blockC.j), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (true);
	c = (ivec2(-6, 6));
	d = (uvec4(2u, 8u, 6u, 5u));
	e[0].mA = (ivec3(5, -6, -7));
	e[0].mB = (mat4(-2.0, 2.0, 3.0, -1.0, 4.0, -4.0, -6.0, -7.0, -7.0, -4.0, 8.0, 2.0, -9.0, 0.0, 4.0, 3.0));
	e[0].mC = (bvec3(false, true, false));
	e[0].mD = (true);
	blockC.h = (mat4x2(2.0, -4.0, 5.0, -9.0, 5.0, -9.0, -5.0, -1.0));
	blockC.i = (bvec4(true, false, true, true));
}
#version 450
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
	mediump vec2 a;
	highp ivec2 b;
	mediump mat3x4 c;
	lowp uint d;
	lowp vec4 e[][4];
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[0].b), ivec2(0, -3)) && allOk;
	allOk = compare_mat3x4(blockB[0].c, mat3x4(7.0, 2.0, 3.0, 9.0, 5.0, 7.0, 0.0, -9.0, 8.0, 7.0, -8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec2(5.0, 6.0));
	blockB[0].c = (mat3x4(7.0, -4.0, 4.0, -2.0, 4.0, 5.0, -5.0, 7.0, 4.0, 5.0, 9.0, -3.0));
	blockB[0].d = (1u);
}
#version 450
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
	layout(offset = 0) highp vec3 a;
	layout(offset = 12) lowp int b[1];
	layout(offset = 16) bvec2 c;
	layout(offset = 32) mediump uvec4 d;
	layout(offset = 48) highp uvec2 e;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp float f;
	layout(offset = 4) bool g;
	layout(offset = 8) lowp float h;
	layout(offset = 16) bvec3 i;
	layout(offset = 32) lowp vec2 j;
};
layout(binding = 3) readonly buffer BlockD
{
	layout(offset = 0) mediump ivec2 k;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((a), vec3(0.0, 3.0, 3.0)) && allOk;
	allOk = compare_bvec2((c), bvec2(false, true)) && allOk;
	allOk = compare_uvec4((d), uvec4(0u, 0u, 8u, 1u)) && allOk;
	allOk = compare_float((f), 3.0) && allOk;
	allOk = compare_bool((g), false) && allOk;
	allOk = compare_vec2((j), vec2(6.0, -8.0)) && allOk;
	allOk = compare_ivec2((k), ivec2(7, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (9);
	c = (bvec2(true, true));
	e = (uvec2(7u, 8u));
	g = (true);
	h = (-4.0);
	i = (bvec3(false, false, false));
}
#version 450
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
	layout(offset = 16) lowp uvec4 b;
	layout(offset = 32) mediump vec3 c;
	layout(offset = 48) bvec3 d[1];
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bool e;
	layout(offset = 4) mediump vec3 f;
	layout(offset = 16) mediump vec3 g;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.c), vec3(9.0, -5.0, 0.0)) && allOk;
	allOk = compare_bvec3((blockB.d[0]), bvec3(false, true, true)) && allOk;
	allOk = compare_bool((e), true) && allOk;
	allOk = compare_vec3((f), vec3(2.0, -6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (0.0);
	blockB.b = (uvec4(5u, 3u, 2u, 2u));
	e = (true);
	f = (vec3(4.0, -5.0, -3.0));
	g = (vec3(-4.0, 6.0, 5.0));
}
#version 450
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
	highp uvec4 a;
	highp mat2x3 b;
	mediump mat3x2 c;
	mediump ivec3 d[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	mediump ivec4 e;
	lowp mat2x3 f;
	mediump vec4 g;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(8u, 2u, 7u, 1u)) && allOk;
	allOk = compare_mat2x3(blockB.b, mat2x3(-4.0, -6.0, 8.0, -4.0, -2.0, 4.0)) && allOk;
	allOk = compare_ivec3((blockB.d[0]), ivec3(-8, 6, 0)) && allOk;
	allOk = compare_ivec3((blockB.d[1]), ivec3(-1, -3, 0)) && allOk;
	allOk = compare_ivec3((blockB.d[2]), ivec3(-1, -7, -7)) && allOk;
	allOk = compare_ivec3((blockB.d[3]), ivec3(6, 9, -1)) && allOk;
	allOk = compare_ivec3((blockB.d[4]), ivec3(-1, 6, 1)) && allOk;
	allOk = compare_mat2x3(blockC.f, mat2x3(8.0, -2.0, 4.0, 0.0, -1.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC.g), vec4(-8.0, -9.0, 5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(9u, 2u, 1u, 0u));
	blockB.c = (mat3x2(-2.0, 5.0, 4.0, -9.0, -2.0, -3.0));
	blockB.d[0] = (ivec3(-1, -9, 1));
	blockB.d[1] = (ivec3(1, 7, 8));
	blockB.d[2] = (ivec3(9, -7, -1));
	blockB.d[3] = (ivec3(-6, 5, 6));
	blockB.d[4] = (ivec3(5, 6, -6));
	blockC.e = (ivec4(-9, 3, -7, -4));
	blockC.f = (mat2x3(-6.0, -5.0, 3.0, -9.0, -6.0, -3.0));
	blockC.g = (vec4(-7.0, -1.0, -5.0, 6.0));
}
#version 450
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
	mediump mat4x2 mA;
	mediump vec3 mB;
	lowp int mC;
	highp uint mD;
};
struct sB
{
	highp mat4 mA;
	mediump uvec3 mB;
};
layout(scalar, binding = 1) buffer BlockB
{
	highp float a;
	highp uvec3 b;
	mediump int c;
	sA d;
	bvec2 e[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	bvec4 f;
	mediump vec3 g;
	bvec2 h;
	mediump mat3 i[];
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	mediump mat3x2 j;
	lowp mat4x2 k;
	highp uint l;
	sB m[][6];
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), 3.0) && allOk;
	allOk = compare_uvec3((blockB.b), uvec3(8u, 3u, 4u)) && allOk;
	allOk = compare_int((blockB.c), -1) && allOk;
	allOk = compare_bvec2((blockB.e[0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.e[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.e[2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.e[3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.e[4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.e[5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.e[6]), bvec2(false, true)) && allOk;
	allOk = compare_bvec4((blockC.f), bvec4(false, false, true, false)) && allOk;
	allOk = compare_vec3((blockC.g), vec3(-2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat3(blockC.i[0], mat3(-4.0, -5.0, 4.0, 9.0, -5.0, -7.0, -6.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(blockC.i[1], mat3(-2.0, 4.0, -9.0, -8.0, 4.0, 8.0, 4.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3(blockC.i[2], mat3(7.0, 1.0, -9.0, -1.0, 9.0, 4.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(blockC.i[3], mat3(8.0, -2.0, 6.0, 4.0, -6.0, 5.0, 0.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockD[0].j, mat3x2(-1.0, 9.0, 1.0, -4.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].k, mat4x2(1.0, 1.0, -4.0, -7.0, 5.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_uint((blockD[0].l), 7u) && allOk;
	allOk = compare_mat3x2(blockD[1].j, mat3x2(6.0, -8.0, 1.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].k, mat4x2(8.0, 1.0, 4.0, 2.0, 8.0, 1.0, 6.0, 2.0)) && allOk;
	allOk = compare_uint((blockD[1].l), 4u) && allOk;
	allOk = compare_mat3x2(blockD[2].j, mat3x2(0.0, -3.0, -7.0, 1.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockD[2].k, mat4x2(-4.0, 0.0, -5.0, -3.0, -5.0, 6.0, -7.0, 5.0)) && allOk;
	allOk = compare_uint((blockD[2].l), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d.mA = (mat4x2(-8.0, 2.0, 1.0, 3.0, 5.0, -2.0, 1.0, -2.0));
	blockB.d.mB = (vec3(3.0, 1.0, -2.0));
	blockB.d.mC = (3);
	blockB.d.mD = (0u);
	blockB.e[0] = (bvec2(false, true));
	blockB.e[1] = (bvec2(true, false));
	blockB.e[2] = (bvec2(true, false));
	blockB.e[3] = (bvec2(true, true));
	blockB.e[4] = (bvec2(false, true));
	blockB.e[5] = (bvec2(true, true));
	blockB.e[6] = (bvec2(true, false));
	blockC.f = (bvec4(false, false, false, true));
	blockC.g = (vec3(6.0, -4.0, -3.0));
	blockC.h = (bvec2(false, true));
	blockD[0].j = (mat3x2(-5.0, -6.0, -4.0, -3.0, -9.0, -8.0));
	blockD[0].l = (4u);
	blockD[1].j = (mat3x2(7.0, -4.0, 1.0, 3.0, 0.0, -7.0));
	blockD[1].l = (5u);
	blockD[2].j = (mat3x2(-1.0, -2.0, -6.0, 9.0, 6.0, 2.0));
	blockD[2].l = (8u);
}
#version 450
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
	float16_t a;
	uint16_t b;
	bool c;
	lowp float d;
	highp uint e;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	highp uint f;
	bool g;
	bool h;
	uint16_t i;
	uint16_t j;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	int16_t k[1];
	float16_t l;
	mediump uint m;
	uint16_t n;
};
layout(std140, binding = 4) buffer BlockE
{
	float16_t o;
	highp int p;
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
	allOk = compare_float16_t(float(blockB.a), -4.0) && allOk;
	allOk = compare_uint16_t(uint(blockB.b), 7u) && allOk;
	allOk = compare_bool((blockB.c), false) && allOk;
	allOk = compare_float((blockB.d), -2.0) && allOk;
	allOk = compare_uint((blockC.f), 5u) && allOk;
	allOk = compare_bool((blockC.g), true) && allOk;
	allOk = compare_bool((blockC.h), false) && allOk;
	allOk = compare_uint16_t(uint(blockC.i), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockC.j), 9u) && allOk;
	allOk = compare_int16_t(int(k[0]), -4) && allOk;
	allOk = compare_float16_t(float(l), -6.0) && allOk;
	allOk = compare_uint((m), 8u) && allOk;
	allOk = compare_uint16_t(uint(n), 8u) && allOk;
	allOk = compare_int((blockE.p), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(6.0);
	blockB.b = uint16_t(4u);
	blockB.c = (false);
	blockB.e = (8u);
	blockC.g = (false);
	blockC.i = uint16_t(3u);
	blockC.j = uint16_t(1u);
	k[0] = int16_t(0);
	m = (9u);
	n = uint16_t(6u);
	blockE.p = (-2);
}
#version 450
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
	u16vec2 a;
	u16vec4 b[1];
	mediump mat3 c;
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	i16vec2 d;
	i16vec4 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(a), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(b[0]), uvec4(0u, 1u, 6u, 9u)) && allOk;
	allOk = compare_mat3(c, mat3(-3.0, 9.0, -2.0, 0.0, 3.0, -3.0, 2.0, -3.0, 8.0)) && allOk;
	allOk = compare_i16vec2(ivec2(d), ivec2(8, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u16vec2(uvec2(7u, 5u));
	b[0] = u16vec4(uvec4(2u, 4u, 6u, 5u));
	c = (mat3(1.0, 2.0, 8.0, -2.0, 5.0, -7.0, -5.0, -9.0, -9.0));
	d = i16vec2(ivec2(-7, 3));
}
#version 450
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
	lowp mat3x2 mA[7];
	int16_t mB;
};
struct sB
{
	lowp mat3x4 mA;
};
struct sC
{
	i16vec2 mA;
	f16vec3 mB;
	highp float mC;
	u16vec4 mD;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	mediump uvec3 a;
	lowp ivec4 b;
	sA c;
	lowp vec4 d;
	highp mat4x3 e[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp mat3x2 f;
	lowp mat2x3 g;
	sB h;
	sC i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(c.mA[0], mat3x2(-8.0, 5.0, 2.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(c.mA[1], mat3x2(8.0, -8.0, 8.0, 7.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(c.mA[2], mat3x2(2.0, 1.0, 2.0, 1.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x2(c.mA[3], mat3x2(6.0, 0.0, -8.0, -1.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat3x2(c.mA[4], mat3x2(5.0, -1.0, 4.0, -2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x2(c.mA[5], mat3x2(1.0, 0.0, 0.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(c.mA[6], mat3x2(6.0, -7.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_int16_t(int(c.mB), 5) && allOk;
	allOk = compare_vec4((d), vec4(1.0, -4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x3(e[0], mat4x3(-4.0, -5.0, -1.0, 0.0, -1.0, -4.0, 0.0, -9.0, 5.0, 8.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat3x2(f, mat3x2(-9.0, 8.0, 9.0, -6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(g, mat2x3(9.0, 9.0, 1.0, 5.0, 9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec3(9u, 2u, 5u));
	b = (ivec4(-7, 6, 2, -8));
	c.mA[0] = (mat3x2(7.0, 5.0, 6.0, 7.0, -4.0, 9.0));
	c.mA[1] = (mat3x2(-2.0, 0.0, 6.0, 7.0, 4.0, 5.0));
	c.mA[2] = (mat3x2(-3.0, -8.0, 1.0, -8.0, 0.0, 5.0));
	c.mA[3] = (mat3x2(2.0, -9.0, 6.0, 7.0, 6.0, 6.0));
	c.mA[4] = (mat3x2(3.0, 1.0, 9.0, 4.0, -8.0, -5.0));
	c.mA[5] = (mat3x2(0.0, 7.0, -7.0, 9.0, -1.0, 5.0));
	c.mA[6] = (mat3x2(-4.0, -8.0, -6.0, -2.0, 0.0, 5.0));
	c.mB = int16_t(-8);
	d = (vec4(0.0, -6.0, 9.0, 3.0));
	f = (mat3x2(3.0, -9.0, 6.0, 7.0, 3.0, 2.0));
	g = (mat2x3(-5.0, 6.0, 3.0, -9.0, 6.0, 8.0));
	h.mA = (mat3x4(1.0, -3.0, -2.0, -8.0, 1.0, -4.0, -7.0, 7.0, 9.0, 9.0, -1.0, -1.0));
	i[0].mA = i16vec2(ivec2(0, -6));
	i[0].mB = f16vec3(vec3(-6.0, 7.0, 9.0));
	i[0].mC = (0.0);
	i[0].mD = u16vec4(uvec4(3u, 3u, 8u, 3u));
}
#version 450
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
	i16vec4 mA;
	i16vec3 mB;
};
struct sB
{
	i16vec4 mA;
	sA mB;
	f16vec2 mC;
	lowp mat3x2 mD;
};
struct sC
{
	i16vec4 mA;
	highp mat3x4 mB;
	lowp mat4x2 mC;
};
struct sD
{
	mediump uvec3 mA;
};
struct sE
{
	int16_t mA;
	mediump ivec3 mB;
	sD mC;
	lowp float mD;
};
layout(std140, binding = 1) buffer BlockB
{
	sB a;
	highp mat3 b;
	sC c[3];
	bvec4 d;
	sE e[];
} blockB[3];
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump uvec4 f;
	bvec2 g[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	mediump mat3x2 h[2];
	u16vec2 i;
	highp ivec3 j[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB[0].b, mat3(-6.0, 7.0, 5.0, 4.0, 0.0, 0.0, 9.0, 1.0, -3.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].c[0].mA), ivec4(-7, 3, -8, 9)) && allOk;
	allOk = compare_mat3x4(blockB[0].c[0].mB, mat3x4(6.0, -3.0, -6.0, -4.0, 2.0, -7.0, 7.0, 4.0, -3.0, 6.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].c[0].mC, mat4x2(-3.0, 7.0, -3.0, 7.0, -3.0, 2.0, -5.0, 5.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].c[1].mA), ivec4(3, 1, -2, 9)) && allOk;
	allOk = compare_mat3x4(blockB[0].c[1].mB, mat3x4(9.0, 3.0, 2.0, -8.0, -7.0, -6.0, -6.0, -3.0, 4.0, -2.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].c[1].mC, mat4x2(9.0, -8.0, -8.0, 3.0, 2.0, -2.0, 9.0, 3.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].c[2].mA), ivec4(6, -3, 8, -9)) && allOk;
	allOk = compare_mat3x4(blockB[0].c[2].mB, mat3x4(-6.0, -2.0, 2.0, -1.0, 8.0, -8.0, -2.0, -7.0, -1.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].c[2].mC, mat4x2(-3.0, -8.0, -5.0, -1.0, 4.0, -8.0, -4.0, 2.0)) && allOk;
	allOk = compare_int16_t(int(blockB[0].e[0].mA), 9) && allOk;
	allOk = compare_ivec3((blockB[0].e[0].mB), ivec3(-2, 9, 2)) && allOk;
	allOk = compare_uvec3((blockB[0].e[0].mC.mA), uvec3(4u, 5u, 2u)) && allOk;
	allOk = compare_float((blockB[0].e[0].mD), -6.0) && allOk;
	allOk = compare_int16_t(int(blockB[0].e[1].mA), 0) && allOk;
	allOk = compare_ivec3((blockB[0].e[1].mB), ivec3(4, 8, -8)) && allOk;
	allOk = compare_uvec3((blockB[0].e[1].mC.mA), uvec3(4u, 3u, 7u)) && allOk;
	allOk = compare_float((blockB[0].e[1].mD), -4.0) && allOk;
	allOk = compare_mat3(blockB[1].b, mat3(4.0, 3.0, 1.0, -3.0, 4.0, -6.0, -9.0, -8.0, -1.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].c[0].mA), ivec4(-8, 5, 7, 6)) && allOk;
	allOk = compare_mat3x4(blockB[1].c[0].mB, mat3x4(9.0, 4.0, 8.0, 9.0, 8.0, 4.0, 5.0, -9.0, -7.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockB[1].c[0].mC, mat4x2(-2.0, -5.0, -9.0, 3.0, -7.0, -2.0, -9.0, 9.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].c[1].mA), ivec4(6, 6, -5, 7)) && allOk;
	allOk = compare_mat3x4(blockB[1].c[1].mB, mat3x4(-4.0, 9.0, 1.0, 7.0, 7.0, 8.0, -6.0, 7.0, 8.0, 4.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockB[1].c[1].mC, mat4x2(-2.0, 6.0, 8.0, -9.0, 2.0, 3.0, 0.0, 1.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].c[2].mA), ivec4(-5, 0, 1, -8)) && allOk;
	allOk = compare_mat3x4(blockB[1].c[2].mB, mat3x4(0.0, -7.0, 9.0, 6.0, -1.0, 8.0, -2.0, -3.0, 4.0, 2.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockB[1].c[2].mC, mat4x2(-6.0, -8.0, -5.0, -1.0, 9.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_int16_t(int(blockB[1].e[0].mA), 9) && allOk;
	allOk = compare_ivec3((blockB[1].e[0].mB), ivec3(-8, 2, 1)) && allOk;
	allOk = compare_uvec3((blockB[1].e[0].mC.mA), uvec3(3u, 7u, 0u)) && allOk;
	allOk = compare_float((blockB[1].e[0].mD), 8.0) && allOk;
	allOk = compare_int16_t(int(blockB[1].e[1].mA), -4) && allOk;
	allOk = compare_ivec3((blockB[1].e[1].mB), ivec3(8, -2, -8)) && allOk;
	allOk = compare_uvec3((blockB[1].e[1].mC.mA), uvec3(5u, 8u, 4u)) && allOk;
	allOk = compare_float((blockB[1].e[1].mD), 3.0) && allOk;
	allOk = compare_mat3(blockB[2].b, mat3(5.0, 5.0, 9.0, 7.0, 3.0, 9.0, -9.0, -6.0, -1.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[2].c[0].mA), ivec4(2, 4, -6, 9)) && allOk;
	allOk = compare_mat3x4(blockB[2].c[0].mB, mat3x4(-6.0, 4.0, 0.0, -4.0, -6.0, -7.0, -4.0, 1.0, 1.0, -6.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].c[0].mC, mat4x2(1.0, 6.0, 0.0, 3.0, 7.0, 8.0, 0.0, 3.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[2].c[1].mA), ivec4(7, 2, 5, 9)) && allOk;
	allOk = compare_mat3x4(blockB[2].c[1].mB, mat3x4(9.0, -7.0, 9.0, 0.0, 3.0, 0.0, 6.0, -1.0, 5.0, 6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].c[1].mC, mat4x2(5.0, -8.0, -4.0, 7.0, -6.0, -9.0, -8.0, 0.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[2].c[2].mA), ivec4(-6, -4, 9, -4)) && allOk;
	allOk = compare_mat3x4(blockB[2].c[2].mB, mat3x4(5.0, 4.0, -5.0, 8.0, 8.0, 5.0, 3.0, -8.0, 0.0, 7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].c[2].mC, mat4x2(3.0, -8.0, 1.0, -3.0, -4.0, 6.0, 5.0, 3.0)) && allOk;
	allOk = compare_int16_t(int(blockB[2].e[0].mA), 0) && allOk;
	allOk = compare_ivec3((blockB[2].e[0].mB), ivec3(8, 4, 9)) && allOk;
	allOk = compare_uvec3((blockB[2].e[0].mC.mA), uvec3(5u, 4u, 9u)) && allOk;
	allOk = compare_float((blockB[2].e[0].mD), 8.0) && allOk;
	allOk = compare_int16_t(int(blockB[2].e[1].mA), -3) && allOk;
	allOk = compare_ivec3((blockB[2].e[1].mB), ivec3(9, -2, 9)) && allOk;
	allOk = compare_uvec3((blockB[2].e[1].mC.mA), uvec3(4u, 6u, 8u)) && allOk;
	allOk = compare_float((blockB[2].e[1].mD), -8.0) && allOk;
	allOk = compare_int16_t(int(blockB[2].e[2].mA), -4) && allOk;
	allOk = compare_ivec3((blockB[2].e[2].mB), ivec3(0, 6, -2)) && allOk;
	allOk = compare_uvec3((blockB[2].e[2].mC.mA), uvec3(6u, 5u, 8u)) && allOk;
	allOk = compare_float((blockB[2].e[2].mD), 9.0) && allOk;
	allOk = compare_int16_t(int(blockB[2].e[3].mA), 9) && allOk;
	allOk = compare_ivec3((blockB[2].e[3].mB), ivec3(3, -7, 1)) && allOk;
	allOk = compare_uvec3((blockB[2].e[3].mC.mA), uvec3(3u, 6u, 8u)) && allOk;
	allOk = compare_float((blockB[2].e[3].mD), -9.0) && allOk;
	allOk = compare_int16_t(int(blockB[2].e[4].mA), 0) && allOk;
	allOk = compare_ivec3((blockB[2].e[4].mB), ivec3(3, -7, -8)) && allOk;
	allOk = compare_uvec3((blockB[2].e[4].mC.mA), uvec3(1u, 5u, 7u)) && allOk;
	allOk = compare_float((blockB[2].e[4].mD), 2.0) && allOk;
	allOk = compare_uvec4((blockC.f), uvec4(1u, 3u, 1u, 2u)) && allOk;
	allOk = compare_mat3x2(blockD.h[0], mat3x2(3.0, 9.0, 3.0, -6.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockD.h[1], mat3x2(-9.0, 0.0, 8.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.i), uvec2(8u, 2u)) && allOk;
	allOk = compare_ivec3((blockD.j[0]), ivec3(-4, 8, 5)) && allOk;
	allOk = compare_ivec3((blockD.j[1]), ivec3(4, -6, 1)) && allOk;
	allOk = compare_ivec3((blockD.j[2]), ivec3(9, -4, 3)) && allOk;
	allOk = compare_ivec3((blockD.j[3]), ivec3(-2, 9, 2)) && allOk;
	allOk = compare_ivec3((blockD.j[4]), ivec3(0, 1, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (mat3(7.0, -2.0, -7.0, -4.0, -2.0, 0.0, -2.0, -6.0, 1.0));
	blockB[0].c[0].mA = i16vec4(ivec4(-1, -5, 4, -5));
	blockB[0].c[0].mB = (mat3x4(8.0, 3.0, 1.0, 2.0, -5.0, 2.0, 9.0, 3.0, -6.0, -6.0, -8.0, 5.0));
	blockB[0].c[0].mC = (mat4x2(3.0, 8.0, -2.0, -2.0, -9.0, -8.0, 5.0, 0.0));
	blockB[0].c[1].mA = i16vec4(ivec4(-8, -3, -5, 0));
	blockB[0].c[1].mB = (mat3x4(-8.0, 4.0, -1.0, -9.0, -7.0, 3.0, 7.0, -2.0, -8.0, 9.0, 0.0, -8.0));
	blockB[0].c[1].mC = (mat4x2(-9.0, 5.0, -7.0, -7.0, 5.0, 7.0, 7.0, 9.0));
	blockB[0].c[2].mA = i16vec4(ivec4(-9, -5, -5, 3));
	blockB[0].c[2].mB = (mat3x4(-2.0, -5.0, -7.0, 8.0, 0.0, 8.0, 6.0, 1.0, 1.0, 9.0, 8.0, 4.0));
	blockB[0].c[2].mC = (mat4x2(-4.0, 7.0, 9.0, 7.0, 7.0, 5.0, 2.0, -7.0));
	blockB[0].d = (bvec4(true, false, false, false));
	blockB[1].b = (mat3(-4.0, 9.0, 6.0, -2.0, 8.0, 1.0, -2.0, 5.0, 0.0));
	blockB[1].c[0].mA = i16vec4(ivec4(-3, -1, 0, -5));
	blockB[1].c[0].mB = (mat3x4(-2.0, 2.0, 4.0, 5.0, 5.0, 6.0, -1.0, 2.0, 3.0, 9.0, 1.0, -1.0));
	blockB[1].c[0].mC = (mat4x2(2.0, -8.0, -1.0, 7.0, 6.0, 6.0, -1.0, 0.0));
	blockB[1].c[1].mA = i16vec4(ivec4(3, -2, -9, 2));
	blockB[1].c[1].mB = (mat3x4(2.0, 4.0, 3.0, 9.0, 8.0, 9.0, 4.0, -4.0, -8.0, 4.0, 1.0, 5.0));
	blockB[1].c[1].mC = (mat4x2(7.0, -2.0, -1.0, 2.0, -3.0, -7.0, -1.0, 4.0));
	blockB[1].c[2].mA = i16vec4(ivec4(-4, 4, -1, 6));
	blockB[1].c[2].mB = (mat3x4(-4.0, -8.0, 7.0, -6.0, 7.0, 6.0, 4.0, -1.0, 7.0, 9.0, 7.0, -4.0));
	blockB[1].c[2].mC = (mat4x2(3.0, -9.0, -4.0, 3.0, 5.0, -5.0, 4.0, -4.0));
	blockB[1].d = (bvec4(true, true, false, true));
	blockB[2].b = (mat3(-2.0, 2.0, 9.0, 5.0, 2.0, 9.0, 3.0, -6.0, -8.0));
	blockB[2].c[0].mA = i16vec4(ivec4(-8, 6, -8, -3));
	blockB[2].c[0].mB = (mat3x4(6.0, 0.0, 6.0, -3.0, -7.0, -9.0, 3.0, -2.0, -1.0, 2.0, 8.0, 6.0));
	blockB[2].c[0].mC = (mat4x2(8.0, -6.0, 6.0, -9.0, -7.0, -5.0, -6.0, -6.0));
	blockB[2].c[1].mA = i16vec4(ivec4(2, 2, 9, 0));
	blockB[2].c[1].mB = (mat3x4(-1.0, -7.0, -2.0, -4.0, 5.0, 7.0, 6.0, -2.0, 6.0, -2.0, 9.0, 6.0));
	blockB[2].c[1].mC = (mat4x2(-4.0, 1.0, -3.0, -5.0, 1.0, -8.0, 6.0, -9.0));
	blockB[2].c[2].mA = i16vec4(ivec4(8, 4, -8, 0));
	blockB[2].c[2].mB = (mat3x4(4.0, 8.0, 3.0, 1.0, -1.0, -9.0, 9.0, 4.0, -2.0, -6.0, -7.0, 6.0));
	blockB[2].c[2].mC = (mat4x2(-9.0, 7.0, 5.0, -2.0, -1.0, 1.0, -1.0, 9.0));
	blockB[2].d = (bvec4(false, true, true, true));
	blockC.f = (uvec4(1u, 2u, 8u, 4u));
	blockD.h[0] = (mat3x2(4.0, -9.0, 6.0, -3.0, -2.0, -3.0));
	blockD.h[1] = (mat3x2(-2.0, -2.0, -6.0, -9.0, -6.0, 1.0));
	blockD.i = u16vec2(uvec2(5u, 9u));
	blockD.j[0] = (ivec3(-1, 9, 5));
	blockD.j[1] = (ivec3(-8, -8, 1));
	blockD.j[2] = (ivec3(-4, 0, 5));
	blockD.j[3] = (ivec3(-5, -3, -6));
	blockD.j[4] = (ivec3(7, 3, 8));
}
#version 450
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
	int16_t mB;
};
struct sB
{
	i16vec4 mA;
	highp vec2 mB;
	uint16_t mC;
};
layout(scalar, column_major, binding = 1) readonly buffer BlockB
{
	lowp mat3x4 a[];
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	sA b;
	highp mat2 c;
	lowp uint d[];
} blockC[3];
layout(scalar, column_major, binding = 3) buffer BlockD
{
	highp vec3 e;
	lowp mat3 f;
	lowp vec4 g;
	highp mat4 h[];
} blockD;
layout(scalar, row_major, binding = 4) buffer BlockE
{
	sB i;
	highp vec3 j[7];
	highp uint k[5];
	mediump vec2 l[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockC[0].b.mA), vec4(-7.0, -8.0, -5.0, 0.0)) && allOk;
	allOk = compare_int16_t(int(blockC[0].b.mB), 1) && allOk;
	allOk = compare_mat2(blockC[0].c, mat2(-4.0, 2.0, -9.0, -4.0)) && allOk;
	allOk = compare_uint((blockC[0].d[0]), 4u) && allOk;
	allOk = compare_uint((blockC[0].d[1]), 5u) && allOk;
	allOk = compare_uint((blockC[0].d[2]), 5u) && allOk;
	allOk = compare_uint((blockC[0].d[3]), 6u) && allOk;
	allOk = compare_uint((blockC[0].d[4]), 1u) && allOk;
	allOk = compare_uint((blockC[0].d[5]), 2u) && allOk;
	allOk = compare_vec4((blockC[1].b.mA), vec4(8.0, 0.0, -7.0, -8.0)) && allOk;
	allOk = compare_int16_t(int(blockC[1].b.mB), -7) && allOk;
	allOk = compare_mat2(blockC[1].c, mat2(-3.0, 2.0, 3.0, -8.0)) && allOk;
	allOk = compare_uint((blockC[1].d[0]), 3u) && allOk;
	allOk = compare_uint((blockC[1].d[1]), 9u) && allOk;
	allOk = compare_uint((blockC[1].d[2]), 3u) && allOk;
	allOk = compare_uint((blockC[1].d[3]), 3u) && allOk;
	allOk = compare_uint((blockC[1].d[4]), 2u) && allOk;
	allOk = compare_uint((blockC[1].d[5]), 0u) && allOk;
	allOk = compare_vec4((blockC[2].b.mA), vec4(-3.0, 7.0, -5.0, 1.0)) && allOk;
	allOk = compare_int16_t(int(blockC[2].b.mB), 8) && allOk;
	allOk = compare_mat2(blockC[2].c, mat2(0.0, -8.0, -3.0, 6.0)) && allOk;
	allOk = compare_uint((blockC[2].d[0]), 2u) && allOk;
	allOk = compare_uint((blockC[2].d[1]), 9u) && allOk;
	allOk = compare_uint((blockC[2].d[2]), 7u) && allOk;
	allOk = compare_uint((blockC[2].d[3]), 2u) && allOk;
	allOk = compare_uint((blockC[2].d[4]), 6u) && allOk;
	allOk = compare_uint((blockC[2].d[5]), 9u) && allOk;
	allOk = compare_vec3((blockD.e), vec3(9.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4(blockD.h[0], mat4(5.0, 0.0, 4.0, 9.0, 5.0, 4.0, 0.0, 9.0, -4.0, 5.0, 2.0, -1.0, 5.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec3((blockE.j[0]), vec3(-5.0, -1.0, -2.0)) && allOk;
	allOk = compare_vec3((blockE.j[1]), vec3(9.0, 6.0, 9.0)) && allOk;
	allOk = compare_vec3((blockE.j[2]), vec3(-6.0, 5.0, 2.0)) && allOk;
	allOk = compare_vec3((blockE.j[3]), vec3(-5.0, 9.0, 2.0)) && allOk;
	allOk = compare_vec3((blockE.j[4]), vec3(6.0, 7.0, 6.0)) && allOk;
	allOk = compare_vec3((blockE.j[5]), vec3(9.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec3((blockE.j[6]), vec3(-1.0, -1.0, 6.0)) && allOk;
	allOk = compare_uint((blockE.k[0]), 7u) && allOk;
	allOk = compare_uint((blockE.k[1]), 4u) && allOk;
	allOk = compare_uint((blockE.k[2]), 9u) && allOk;
	allOk = compare_uint((blockE.k[3]), 9u) && allOk;
	allOk = compare_uint((blockE.k[4]), 4u) && allOk;
	allOk = compare_vec2((blockE.l[0]), vec2(5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b.mA = (vec4(-5.0, -7.0, -3.0, -6.0));
	blockC[0].b.mB = int16_t(4);
	blockC[0].d[0] = (9u);
	blockC[0].d[1] = (4u);
	blockC[0].d[2] = (0u);
	blockC[0].d[3] = (1u);
	blockC[0].d[4] = (8u);
	blockC[0].d[5] = (4u);
	blockC[1].b.mA = (vec4(-3.0, 4.0, 9.0, -8.0));
	blockC[1].b.mB = int16_t(-8);
	blockC[1].d[0] = (0u);
	blockC[1].d[1] = (7u);
	blockC[1].d[2] = (3u);
	blockC[1].d[3] = (0u);
	blockC[1].d[4] = (5u);
	blockC[1].d[5] = (9u);
	blockC[2].b.mA = (vec4(8.0, 5.0, -7.0, -6.0));
	blockC[2].b.mB = int16_t(0);
	blockC[2].d[0] = (2u);
	blockC[2].d[1] = (9u);
	blockC[2].d[2] = (1u);
	blockC[2].d[3] = (8u);
	blockC[2].d[4] = (6u);
	blockC[2].d[5] = (9u);
	blockD.e = (vec3(3.0, -1.0, -5.0));
	blockD.f = (mat3(-9.0, -2.0, -7.0, -6.0, 9.0, 4.0, 1.0, -6.0, 8.0));
	blockD.g = (vec4(6.0, -1.0, -4.0, -9.0));
	blockD.h[0] = (mat4(-4.0, -7.0, 9.0, 0.0, -3.0, 8.0, -5.0, -6.0, 2.0, -1.0, -9.0, -6.0, -1.0, 9.0, -8.0, -2.0));
	blockE.j[0] = (vec3(-6.0, 6.0, -7.0));
	blockE.j[1] = (vec3(-3.0, -2.0, -5.0));
	blockE.j[2] = (vec3(-9.0, 6.0, -3.0));
	blockE.j[3] = (vec3(-7.0, -8.0, 3.0));
	blockE.j[4] = (vec3(-4.0, 2.0, 9.0));
	blockE.j[5] = (vec3(7.0, -9.0, -7.0));
	blockE.j[6] = (vec3(-2.0, 6.0, -3.0));
	blockE.k[0] = (6u);
	blockE.k[1] = (3u);
	blockE.k[2] = (9u);
	blockE.k[3] = (3u);
	blockE.k[4] = (7u);
	blockE.l[0] = (vec2(-6.0, 0.0));
}
#version 450
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
	f16vec3 mB;
	highp mat2 mC;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	mediump uvec3 a;
	bvec2 b[7];
	mediump int c;
	highp mat3x2 d;
} blockB[3];
layout(scalar, column_major, binding = 2) buffer BlockC
{
	mediump int e[5];
	sA f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a), uvec3(9u, 6u, 1u)) && allOk;
	allOk = compare_int((blockB[0].c), 2) && allOk;
	allOk = compare_uvec3((blockB[1].a), uvec3(3u, 9u, 2u)) && allOk;
	allOk = compare_int((blockB[1].c), 1) && allOk;
	allOk = compare_uvec3((blockB[2].a), uvec3(8u, 9u, 5u)) && allOk;
	allOk = compare_int((blockB[2].c), 5) && allOk;
	allOk = compare_int((e[0]), -3) && allOk;
	allOk = compare_int((e[1]), 1) && allOk;
	allOk = compare_int((e[2]), 3) && allOk;
	allOk = compare_int((e[3]), -2) && allOk;
	allOk = compare_int((e[4]), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (uvec3(1u, 0u, 1u));
	blockB[0].b[0] = (bvec2(true, true));
	blockB[0].b[1] = (bvec2(false, false));
	blockB[0].b[2] = (bvec2(true, true));
	blockB[0].b[3] = (bvec2(false, false));
	blockB[0].b[4] = (bvec2(false, true));
	blockB[0].b[5] = (bvec2(false, true));
	blockB[0].b[6] = (bvec2(true, true));
	blockB[0].d = (mat3x2(8.0, -7.0, -8.0, -3.0, -8.0, -9.0));
	blockB[1].a = (uvec3(8u, 7u, 0u));
	blockB[1].b[0] = (bvec2(false, false));
	blockB[1].b[1] = (bvec2(true, false));
	blockB[1].b[2] = (bvec2(false, false));
	blockB[1].b[3] = (bvec2(false, true));
	blockB[1].b[4] = (bvec2(true, false));
	blockB[1].b[5] = (bvec2(false, false));
	blockB[1].b[6] = (bvec2(false, false));
	blockB[1].d = (mat3x2(7.0, 6.0, -5.0, -3.0, -5.0, 5.0));
	blockB[2].a = (uvec3(5u, 4u, 2u));
	blockB[2].b[0] = (bvec2(false, true));
	blockB[2].b[1] = (bvec2(false, false));
	blockB[2].b[2] = (bvec2(false, true));
	blockB[2].b[3] = (bvec2(true, true));
	blockB[2].b[4] = (bvec2(false, true));
	blockB[2].b[5] = (bvec2(true, true));
	blockB[2].b[6] = (bvec2(false, false));
	blockB[2].d = (mat3x2(4.0, -9.0, -4.0, -7.0, -3.0, 6.0));
	e[0] = (-5);
	e[1] = (5);
	e[2] = (8);
	e[3] = (1);
	e[4] = (-9);
	f[0].mA = (uvec4(0u, 5u, 6u, 4u));
	f[0].mB = f16vec3(vec3(-7.0, 8.0, 0.0));
	f[0].mC = (mat2(1.0, 0.0, -2.0, 9.0));
	f[1].mA = (uvec4(8u, 9u, 3u, 8u));
	f[1].mB = f16vec3(vec3(-9.0, -2.0, 2.0));
	f[1].mC = (mat2(5.0, 2.0, 0.0, -2.0));
	f[2].mA = (uvec4(0u, 6u, 7u, 8u));
	f[2].mB = f16vec3(vec3(1.0, 0.0, 3.0));
	f[2].mC = (mat2(-9.0, -3.0, 8.0, -8.0));
	f[3].mA = (uvec4(6u, 9u, 9u, 4u));
	f[3].mB = f16vec3(vec3(8.0, 0.0, -7.0));
	f[3].mC = (mat2(-3.0, -4.0, 3.0, 4.0));
	f[4].mA = (uvec4(4u, 3u, 9u, 4u));
	f[4].mB = f16vec3(vec3(-6.0, 8.0, 4.0));
	f[4].mC = (mat2(-1.0, -6.0, -6.0, -3.0));
	f[5].mA = (uvec4(4u, 6u, 4u, 6u));
	f[5].mB = f16vec3(vec3(-3.0, 3.0, 9.0));
	f[5].mC = (mat2(-9.0, 4.0, -1.0, 1.0));
	f[6].mA = (uvec4(7u, 1u, 8u, 0u));
	f[6].mB = f16vec3(vec3(5.0, 1.0, 0.0));
	f[6].mC = (mat2(-4.0, 0.0, -2.0, -5.0));
}
#version 450
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
	highp vec2 mB;
	mediump ivec4 mC[4];
	mediump ivec2 mD;
};
struct sB
{
	highp vec3 mA;
};
struct sC
{
	u16vec3 mA;
	mediump int mB;
};
layout(scalar, binding = 1) buffer BlockB
{
	lowp vec4 a;
	bool b;
	sA c;
	i16vec4 d;
	mediump int e[];
} blockB[2];
layout(scalar, row_major, binding = 2) buffer BlockC
{
	mediump uvec4 f;
	uint16_t g;
	lowp mat2x3 h;
	highp ivec3 i;
	sB j[];
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	mediump mat4x3 k;
	bvec4 l;
	sC m[4];
	mediump mat3x4 n;
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
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[0].a), vec4(3.0, -6.0, -6.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[0].c.mA), vec3(-2.0, 6.0, 3.0)) && allOk;
	allOk = compare_vec2((blockB[0].c.mB), vec2(5.0, 9.0)) && allOk;
	allOk = compare_ivec4((blockB[0].c.mC[0]), ivec4(0, -4, -3, -1)) && allOk;
	allOk = compare_ivec4((blockB[0].c.mC[1]), ivec4(8, -9, 1, 8)) && allOk;
	allOk = compare_ivec4((blockB[0].c.mC[2]), ivec4(-4, 4, 1, -2)) && allOk;
	allOk = compare_ivec4((blockB[0].c.mC[3]), ivec4(-6, -3, 8, -3)) && allOk;
	allOk = compare_ivec2((blockB[0].c.mD), ivec2(-3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].d), ivec4(3, -2, -8, -7)) && allOk;
	allOk = compare_int((blockB[0].e[0]), 2) && allOk;
	allOk = compare_int((blockB[0].e[1]), -2) && allOk;
	allOk = compare_int((blockB[0].e[2]), 2) && allOk;
	allOk = compare_int((blockB[0].e[3]), 7) && allOk;
	allOk = compare_int((blockB[0].e[4]), 0) && allOk;
	allOk = compare_vec4((blockB[1].a), vec4(1.0, -5.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[1].c.mA), vec3(-8.0, -8.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB[1].c.mB), vec2(-7.0, 2.0)) && allOk;
	allOk = compare_ivec4((blockB[1].c.mC[0]), ivec4(-3, -9, -1, -5)) && allOk;
	allOk = compare_ivec4((blockB[1].c.mC[1]), ivec4(9, -2, 4, 9)) && allOk;
	allOk = compare_ivec4((blockB[1].c.mC[2]), ivec4(0, 8, 3, -2)) && allOk;
	allOk = compare_ivec4((blockB[1].c.mC[3]), ivec4(-2, 9, -6, 8)) && allOk;
	allOk = compare_ivec2((blockB[1].c.mD), ivec2(7, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].d), ivec4(-6, -2, 2, -3)) && allOk;
	allOk = compare_int((blockB[1].e[0]), -9) && allOk;
	allOk = compare_int((blockB[1].e[1]), -4) && allOk;
	allOk = compare_uvec4((blockC.f), uvec4(3u, 7u, 6u, 1u)) && allOk;
	allOk = compare_uint16_t(uint(blockC.g), 0u) && allOk;
	allOk = compare_mat2x3(blockC.h, mat2x3(5.0, -1.0, 6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_ivec3((blockC.i), ivec3(-5, -1, 9)) && allOk;
	allOk = compare_vec3((blockC.j[0].mA), vec3(-9.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(k, mat4x3(-6.0, -2.0, -3.0, -7.0, -3.0, 9.0, -4.0, -4.0, 4.0, -8.0, 0.0, 3.0)) && allOk;
	allOk = compare_bvec4((l), bvec4(true, false, true, true)) && allOk;
	allOk = compare_mat3x4(n, mat3x4(5.0, 6.0, -3.0, -8.0, -7.0, -4.0, 5.0, -8.0, -3.0, 5.0, -5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec4(-5.0, 8.0, 2.0, -3.0));
	blockB[0].b = (false);
	blockB[0].c.mA = f16vec3(vec3(1.0, -9.0, 4.0));
	blockB[0].c.mB = (vec2(3.0, 3.0));
	blockB[0].c.mC[0] = (ivec4(-7, -5, -1, -4));
	blockB[0].c.mC[1] = (ivec4(-4, 4, -8, 5));
	blockB[0].c.mC[2] = (ivec4(3, -1, 7, 7));
	blockB[0].c.mC[3] = (ivec4(-7, 1, 4, 4));
	blockB[0].c.mD = (ivec2(-7, -1));
	blockB[0].d = i16vec4(ivec4(0, -2, -1, 0));
	blockB[1].a = (vec4(6.0, -4.0, -3.0, -1.0));
	blockB[1].b = (true);
	blockB[1].c.mA = f16vec3(vec3(9.0, -9.0, 2.0));
	blockB[1].c.mB = (vec2(4.0, -9.0));
	blockB[1].c.mC[0] = (ivec4(-7, -2, -6, 4));
	blockB[1].c.mC[1] = (ivec4(-5, -7, 6, 6));
	blockB[1].c.mC[2] = (ivec4(-1, -4, -7, -7));
	blockB[1].c.mC[3] = (ivec4(6, 7, -1, -1));
	blockB[1].c.mD = (ivec2(1, 8));
	blockB[1].d = i16vec4(ivec4(-9, 5, -5, 7));
	blockC.g = uint16_t(5u);
	blockC.i = (ivec3(-1, 7, 0));
	k = (mat4x3(2.0, -7.0, 6.0, -2.0, -6.0, 8.0, 6.0, -9.0, 2.0, 7.0, -2.0, 2.0));
	l = (bvec4(false, false, false, true));
	m[0].mA = u16vec3(uvec3(2u, 2u, 6u));
	m[0].mB = (4);
	m[1].mA = u16vec3(uvec3(4u, 8u, 5u));
	m[1].mB = (5);
	m[2].mA = u16vec3(uvec3(3u, 0u, 7u));
	m[2].mB = (6);
	m[3].mA = u16vec3(uvec3(0u, 7u, 0u));
	m[3].mB = (-9);
	n = (mat3x4(0.0, -4.0, -3.0, 6.0, -9.0, 8.0, -2.0, -1.0, 8.0, -1.0, -2.0, -3.0));
}
#version 450
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
	i8vec2 a;
	highp mat3x2 b;
	bvec3 c;
	bvec2 d;
	bvec2 e;
};
layout(std430, binding = 2) buffer BlockC
{
	u8vec4 f;
	highp ivec3 g;
	bool h;
	u8vec3 i;
	mediump mat3x2 j;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(b, mat3x2(6.0, 5.0, -7.0, -4.0, -9.0, -9.0)) && allOk;
	allOk = compare_bvec3((c), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec2((d), bvec2(true, false)) && allOk;
	allOk = compare_u8vec4(uvec4(f), uvec4(4u, 1u, 1u, 7u)) && allOk;
	allOk = compare_ivec3((g), ivec3(-9, 0, -5)) && allOk;
	allOk = compare_bool((h), false) && allOk;
	allOk = compare_mat3x2(j, mat3x2(3.0, -5.0, 5.0, -7.0, 1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i8vec2(ivec2(9, 4294967289));
	e = (bvec2(true, false));
	f = u8vec4(uvec4(8u, 2u, 8u, 1u));
	g = (ivec3(5, -4, 9));
	h = (true);
	i = u8vec3(uvec3(5u, 3u, 0u));
}
#version 450
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
	bvec3 a;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	u8vec2 b;
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	highp vec3 c;
	uint8_t d;
	mediump uvec2 e;
};
layout(std140, column_major, binding = 4) buffer BlockE
{
	bool f;
	highp ivec4 g;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((a), bvec3(true, true, false)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.b), uvec2(8u, 3u)) && allOk;
	allOk = compare_vec3((c), vec3(6.0, -1.0, 5.0)) && allOk;
	allOk = compare_uint8_t(uint(d), 2u) && allOk;
	allOk = compare_bool((blockE.f), true) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec3(true, true, true));
	blockC.b = u8vec2(uvec2(2u, 1u));
	d = uint8_t(7u);
	e = (uvec2(9u, 6u));
	blockE.f = (true);
	blockE.g = (ivec4(5, -6, -1, -2));
}
#version 450
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
	highp uvec2 b;
	lowp ivec4 c[];
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((a), true) && allOk;
	allOk = compare_uvec2((b), uvec2(7u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	c[0] = (ivec4(1, -7, -4, -4));
}
#version 450
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
	highp mat4 a;
	lowp mat2x3 b;
	mediump int c[3];
	i8vec2 d[3];
	u8vec3 e[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp ivec3 f;
	highp vec2 g[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	u8vec3 h;
	highp ivec2 i;
	highp uvec2 j;
	lowp mat2 k[];
};

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
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.b, mat2x3(7.0, -3.0, 4.0, 3.0, 7.0, -2.0)) && allOk;
	allOk = compare_ivec3((f), ivec3(-3, -9, -6)) && allOk;
	allOk = compare_ivec2((i), ivec2(1, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = (7);
	blockB.c[1] = (-1);
	blockB.c[2] = (-9);
	blockB.d[0] = i8vec2(ivec2(4294967294, 4294967289));
	blockB.d[1] = i8vec2(ivec2(4294967291, 7));
	blockB.d[2] = i8vec2(ivec2(4294967287, 4294967291));
	blockB.e[0] = u8vec3(uvec3(5u, 8u, 0u));
	blockB.e[1] = u8vec3(uvec3(6u, 2u, 3u));
	blockB.e[2] = u8vec3(uvec3(4u, 4u, 7u));
	blockB.e[3] = u8vec3(uvec3(3u, 4u, 2u));
	blockB.e[4] = u8vec3(uvec3(7u, 4u, 6u));
	blockB.e[5] = u8vec3(uvec3(2u, 9u, 5u));
	blockB.e[6] = u8vec3(uvec3(3u, 9u, 3u));
	blockB.e[7] = u8vec3(uvec3(9u, 8u, 0u));
	f = (ivec3(-2, 2, -5));
	h = u8vec3(uvec3(1u, 6u, 6u));
	i = (ivec2(3, 4));
	j = (uvec2(3u, 6u));
	k[0] = (mat2(4.0, -4.0, -6.0, -8.0));
	k[1] = (mat2(6.0, 3.0, -6.0, -9.0));
	k[2] = (mat2(-6.0, 9.0, 1.0, -7.0));
	k[3] = (mat2(2.0, 9.0, 5.0, 3.0));
}
#version 450
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
struct sB
{
	mediump float mA;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	mediump ivec4 a;
	sA b[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	sB c[1];
	u8vec2 d;
	u8vec2 e;
	highp mat2 f[];
};
layout(std430, binding = 3) buffer BlockD
{
	highp uint g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(4, -1, 1, 6)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b[0].mA), uvec3(8u, 2u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b[1].mA), uvec3(1u, 5u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b[2].mA), uvec3(0u, 7u, 6u)) && allOk;
	allOk = compare_float((c[0].mA), -6.0) && allOk;
	allOk = compare_u8vec2(uvec2(d), uvec2(5u, 2u)) && allOk;
	allOk = compare_mat2(f[0], mat2(-1.0, -1.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(f[1], mat2(4.0, 6.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(f[2], mat2(8.0, 3.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(5, 7, -9, -6));
	blockB.b[0].mA = u8vec3(uvec3(5u, 7u, 9u));
	blockB.b[1].mA = u8vec3(uvec3(5u, 9u, 4u));
	blockB.b[2].mA = u8vec3(uvec3(8u, 6u, 7u));
	c[0].mA = (3.0);
	f[0] = (mat2(-6.0, 5.0, 9.0, 2.0));
	f[1] = (mat2(-1.0, -7.0, 3.0, -7.0));
	f[2] = (mat2(-5.0, 7.0, 5.0, 5.0));
	g[0] = (0u);
	g[1] = (5u);
}
#version 450
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
	layout(offset = 0) u8vec4 a;
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp vec2 b;
	layout(offset = 8) lowp int c;
	layout(offset = 12) u8vec2 d;
	layout(offset = 16) highp uint e;
	layout(offset = 20) mediump uvec2 f;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) u8vec2 g;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockC.c), -7) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.d), uvec2(2u, 5u)) && allOk;
	allOk = compare_uint((blockC.e), 6u) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(3u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(g), uvec2(8u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = u8vec4(uvec4(4u, 3u, 5u, 0u));
	blockC.b = (vec2(4.0, 5.0));
	blockC.c = (-7);
	blockC.d = u8vec2(uvec2(4u, 3u));
	blockC.e = (2u);
	blockC.f = (uvec2(5u, 1u));
	g = u8vec2(uvec2(2u, 7u));
}
#version 450
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
	lowp mat2 mA[6];
	lowp uint mB;
	lowp uvec4 mC;
};
struct sB
{
	sA mA;
};
layout(scalar, binding = 1) buffer BlockB
{
	highp mat4x2 a;
	bvec3 b;
	u8vec4 c;
	mediump vec3 d;
} blockB[1];
layout(scalar, row_major, binding = 2) buffer BlockC
{
	int8_t e;
	lowp vec2 f;
};
layout(scalar, column_major, binding = 3) buffer BlockD
{
	bvec2 g;
	mediump mat4x2 h;
	sB i;
	mediump uvec4 j;
	bvec3 k[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[0].b), bvec3(true, true, true)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].c), uvec4(8u, 5u, 7u, 0u)) && allOk;
	allOk = compare_vec3((blockB[0].d), vec3(5.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockD.h, mat4x2(-6.0, -5.0, -2.0, -4.0, 6.0, 5.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2(blockD.i.mA.mA[0], mat2(-7.0, 2.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2(blockD.i.mA.mA[1], mat2(6.0, 8.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat2(blockD.i.mA.mA[2], mat2(6.0, -1.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(blockD.i.mA.mA[3], mat2(-6.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2(blockD.i.mA.mA[4], mat2(4.0, 8.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2(blockD.i.mA.mA[5], mat2(-7.0, -3.0, -3.0, -3.0)) && allOk;
	allOk = compare_uint((blockD.i.mA.mB), 4u) && allOk;
	allOk = compare_uvec4((blockD.i.mA.mC), uvec4(6u, 8u, 8u, 1u)) && allOk;
	allOk = compare_bvec3((blockD.k[0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockD.k[1]), bvec3(false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (bvec3(false, true, true));
	e = int8_t(4294967289);
	f = (vec2(8.0, -6.0));
	blockD.h = (mat4x2(0.0, 7.0, 0.0, -3.0, 9.0, 6.0, -4.0, -8.0));
	blockD.i.mA.mA[0] = (mat2(5.0, -9.0, 6.0, -6.0));
	blockD.i.mA.mA[1] = (mat2(-2.0, 6.0, -5.0, 6.0));
	blockD.i.mA.mA[2] = (mat2(6.0, -3.0, 7.0, -3.0));
	blockD.i.mA.mA[3] = (mat2(-2.0, 5.0, -2.0, 7.0));
	blockD.i.mA.mA[4] = (mat2(-9.0, -9.0, 6.0, 3.0));
	blockD.i.mA.mA[5] = (mat2(9.0, -1.0, -6.0, 2.0));
	blockD.i.mA.mB = (9u);
	blockD.i.mA.mC = (uvec4(9u, 0u, 2u, 3u));
	blockD.j = (uvec4(1u, 2u, 3u, 2u));
}
#version 450
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
	mediump ivec3 mB;
	mediump mat3 mC;
};
struct sB
{
	highp float mA;
};
layout(scalar, binding = 1) buffer BlockB
{
	mediump mat4x2 a;
	sA b;
	highp int c;
	sB d;
	highp ivec3 e[];
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	lowp mat4 f;
	mediump float g;
	uint8_t h;
	mediump mat4 i;
	bvec4 j[];
} blockC[3];
layout(scalar, column_major, binding = 3) buffer BlockD
{
	bvec3 k;
	lowp mat4x2 l;
	i8vec4 m;
	lowp uvec4 n[][8];
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b.mA), vec2(8.0, -7.0)) && allOk;
	allOk = compare_ivec3((blockB.b.mB), ivec3(9, 9, 9)) && allOk;
	allOk = compare_mat3(blockB.b.mC, mat3(-8.0, 9.0, -9.0, 9.0, 6.0, -4.0, -9.0, -2.0, 2.0)) && allOk;
	allOk = compare_int((blockB.c), -8) && allOk;
	allOk = compare_float((blockB.d.mA), 4.0) && allOk;
	allOk = compare_ivec3((blockB.e[0]), ivec3(-1, 3, 5)) && allOk;
	allOk = compare_ivec3((blockB.e[1]), ivec3(-4, 0, 4)) && allOk;
	allOk = compare_ivec3((blockB.e[2]), ivec3(0, -1, -4)) && allOk;
	allOk = compare_ivec3((blockB.e[3]), ivec3(2, 0, 4)) && allOk;
	allOk = compare_mat4(blockC[0].f, mat4(-5.0, -1.0, 0.0, 6.0, -3.0, -2.0, 4.0, 1.0, 9.0, -2.0, 8.0, -4.0, 9.0, -6.0, -5.0, -5.0)) && allOk;
	allOk = compare_float((blockC[0].g), -6.0) && allOk;
	allOk = compare_mat4(blockC[0].i, mat4(-7.0, 3.0, -2.0, -8.0, 4.0, 4.0, 4.0, -7.0, -9.0, 8.0, 3.0, 7.0, -1.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(blockC[1].f, mat4(1.0, 1.0, -4.0, -7.0, 5.0, -5.0, 0.0, 0.0, 4.0, -5.0, -8.0, 4.0, 5.0, 7.0, 4.0, 6.0)) && allOk;
	allOk = compare_float((blockC[1].g), -2.0) && allOk;
	allOk = compare_mat4(blockC[1].i, mat4(4.0, 6.0, 6.0, 1.0, -7.0, 9.0, 8.0, 7.0, 9.0, -4.0, 8.0, 1.0, 7.0, 9.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4(blockC[2].f, mat4(0.0, -5.0, -5.0, -4.0, 9.0, 2.0, 4.0, -4.0, -5.0, 3.0, 0.0, 9.0, -6.0, 4.0, 4.0, 5.0)) && allOk;
	allOk = compare_float((blockC[2].g), 6.0) && allOk;
	allOk = compare_mat4(blockC[2].i, mat4(8.0, -7.0, -5.0, 7.0, -7.0, 8.0, 8.0, -7.0, 4.0, 6.0, 6.0, -9.0, -3.0, 9.0, 2.0, 5.0)) && allOk;
	allOk = compare_bvec3((blockD[0].k), bvec3(true, false, true)) && allOk;
	allOk = compare_mat4x2(blockD[0].l, mat4x2(-5.0, -8.0, 9.0, -3.0, -2.0, 1.0, 7.0, -3.0)) && allOk;
	allOk = compare_uvec4((blockD[0].n[0][0]), uvec4(1u, 2u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((blockD[0].n[0][1]), uvec4(9u, 0u, 3u, 4u)) && allOk;
	allOk = compare_uvec4((blockD[0].n[0][2]), uvec4(3u, 6u, 4u, 0u)) && allOk;
	allOk = compare_uvec4((blockD[0].n[0][3]), uvec4(5u, 9u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((blockD[0].n[0][4]), uvec4(6u, 9u, 7u, 0u)) && allOk;
	allOk = compare_uvec4((blockD[0].n[0][5]), uvec4(3u, 9u, 7u, 1u)) && allOk;
	allOk = compare_uvec4((blockD[0].n[0][6]), uvec4(1u, 2u, 1u, 8u)) && allOk;
	allOk = compare_uvec4((blockD[0].n[0][7]), uvec4(9u, 9u, 0u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b.mA = (vec2(3.0, 5.0));
	blockB.b.mB = (ivec3(-2, 1, -2));
	blockB.b.mC = (mat3(3.0, 1.0, -2.0, 3.0, -4.0, 1.0, -1.0, 3.0, 2.0));
	blockB.c = (-3);
	blockB.e[0] = (ivec3(-8, 9, 2));
	blockB.e[1] = (ivec3(-5, 1, 6));
	blockB.e[2] = (ivec3(9, 4, 8));
	blockB.e[3] = (ivec3(-3, -8, 4));
	blockC[0].g = (0.0);
	blockC[0].h = uint8_t(0u);
	blockC[0].j[0] = (bvec4(false, true, true, false));
	blockC[0].j[1] = (bvec4(true, true, true, false));
	blockC[0].j[2] = (bvec4(true, true, false, false));
	blockC[1].g = (2.0);
	blockC[1].h = uint8_t(5u);
	blockC[1].j[0] = (bvec4(true, true, false, true));
	blockC[1].j[1] = (bvec4(false, true, false, false));
	blockC[1].j[2] = (bvec4(true, true, false, false));
	blockC[1].j[3] = (bvec4(false, false, false, false));
	blockC[1].j[4] = (bvec4(true, false, true, true));
	blockC[1].j[5] = (bvec4(true, true, false, false));
	blockC[2].g = (2.0);
	blockC[2].h = uint8_t(3u);
	blockC[2].j[0] = (bvec4(true, true, false, false));
	blockC[2].j[1] = (bvec4(true, false, true, false));
	blockC[2].j[2] = (bvec4(false, true, false, true));
	blockC[2].j[3] = (bvec4(true, true, false, true));
	blockC[2].j[4] = (bvec4(false, false, true, false));
	blockC[2].j[5] = (bvec4(false, false, true, false));
	blockC[2].j[6] = (bvec4(true, true, false, true));
	blockC[2].j[7] = (bvec4(true, true, true, true));
	blockD[0].k = (bvec3(true, true, true));
	blockD[0].l = (mat4x2(-8.0, -7.0, 6.0, -4.0, 7.0, -4.0, 4.0, -6.0));
	blockD[0].m = i8vec4(ivec4(6, 4, 4294967288, 7));
	blockD[0].n[0][0] = (uvec4(0u, 8u, 6u, 5u));
	blockD[0].n[0][1] = (uvec4(3u, 4u, 0u, 0u));
	blockD[0].n[0][2] = (uvec4(7u, 7u, 7u, 1u));
	blockD[0].n[0][3] = (uvec4(4u, 2u, 2u, 9u));
	blockD[0].n[0][4] = (uvec4(5u, 2u, 4u, 8u));
	blockD[0].n[0][5] = (uvec4(2u, 4u, 0u, 5u));
	blockD[0].n[0][6] = (uvec4(9u, 2u, 9u, 4u));
	blockD[0].n[0][7] = (uvec4(3u, 5u, 3u, 2u));
}
#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-8.0, -6.0)) && allOk;
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

}
#version 450
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

}
#version 450
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
	mediump float var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var), -6.0) && allOk;
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
	lowp vec2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var), vec2(-9.0, -3.0)) && allOk;
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
	lowp int var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var), 3) && allOk;
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

layout(std430, row_major, binding = 1) readonly buffer Block
{
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(-2.0, -5.0, -2.0, 4.0, -3.0, -4.0, 2.0, -8.0)) && allOk;
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
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], -6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(4.0, 0.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(2.0, -9.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-6.0, 9.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-5.0, -6.0)) && allOk;
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
	mediump ivec2 var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), -2) && allOk;
	allOk = compare_ivec2((var), ivec2(5, 3)) && allOk;
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[0][3], -4.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], -2.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 3.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[2][3], -2.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], 0.0) && allOk;
	allOk = compare_float(var[3][2], 1.0) && allOk;
	allOk = compare_float(var[3][3], 5.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-2.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(5.0, 8.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-9.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-5.0, 0.0, 1.0, 5.0)) && allOk;
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_float(var[0][0], 8.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[0][2], -3.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-6.0, -4.0, 6.0)) && allOk;
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(-2.0, 2.0, -8.0, -6.0, -2.0, -3.0)) && allOk;
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
	highp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[0][3], -7.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], 0.0) && allOk;
	allOk = compare_float(var[1][3], -6.0) && allOk;
	allOk = compare_float(var[2][0], 1.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[2][3], 0.0) && allOk;
	allOk = compare_vec4(var[0], vec4(0.0, -7.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-1.0, 5.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(1.0, -2.0, -9.0, 0.0)) && allOk;
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(9.0, -9.0, 3.0, 0.0, 7.0, -1.0, -3.0, -8.0)) && allOk;
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(-8.0, -2.0, -5.0, 4.0, 3.0, -8.0, 9.0, 0.0)) && allOk;
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], 9.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[1][2], 9.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], 1.0) && allOk;
	allOk = compare_float(var[3][0], 8.0) && allOk;
	allOk = compare_float(var[3][1], 1.0) && allOk;
	allOk = compare_float(var[3][2], 2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-7.0, -6.0, 9.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, -4.0, 9.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(6.0, -6.0, 1.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(8.0, 1.0, 2.0)) && allOk;
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
	i8vec3 var;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967295) && allOk;
	allOk = compare_i8vec3(ivec3(var), ivec3(4294967290, 1, 4294967293)) && allOk;
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

}
#version 450
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

}
#version 450
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

}
#version 450
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
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(-8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0, -2.0, -5.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0, 9.0, -2.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0, 8.0, -3.0, 3.0, -3.0)) && allOk;
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
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_mat4x3(var[0], mat4x3(3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0, -2.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0, -5.0, 4.0, -7.0)) && allOk;
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

}
#version 450
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

layout(std430, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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
layout(std430, binding = 1) readonly buffer Block
{
	S s;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((s.a), ivec3(-4, -5, 3)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-2.0, -7.0, 6.0, -3.0, 7.0, 5.0, -8.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(2.0, -7.0, -2.0, -2.0, -2.0, 1.0, -4.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(-8.0, -8.0, -3.0, 0.0, -4.0, 9.0, 1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(-9.0, 3.0, -7.0, -4.0, -4.0, -1.0, 6.0, -1.0, -3.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(-4.0, -8.0, -7.0, -8.0)) && allOk;
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

struct S
{
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c;
};
layout(scalar, binding = 1) readonly buffer Block
{
	S s;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((s.a), ivec3(2, 2, -2)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(0.0, -3.0, -4.0, 0.0, -5.0, 5.0, 1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(2.0, 7.0, 3.0, -7.0, -2.0, -2.0, 0.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(9.0, 6.0, 1.0, 8.0, 2.0, -8.0, -9.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(6.0, 6.0, 0.0, -9.0, -5.0, -5.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(8.0, -4.0, 0.0, -9.0)) && allOk;
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
	highp mat3 var;
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
	allOk = compare_float(block.var[0][0], 8.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], 6.0) && allOk;
	allOk = compare_float(block.var[1][0], 7.0) && allOk;
	allOk = compare_float(block.var[1][1], 7.0) && allOk;
	allOk = compare_float(block.var[1][2], 1.0) && allOk;
	allOk = compare_float(block.var[2][0], -8.0) && allOk;
	allOk = compare_float(block.var[2][1], -2.0) && allOk;
	allOk = compare_float(block.var[2][2], 3.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(8.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(7.0, 7.0, 1.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-8.0, -2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(9.0, 3.0, -1.0, -3.0, -3.0, 5.0, -5.0, 2.0, -7.0));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(0.0, -6.0, -5.0, 0.0, 1.0, 3.0, -2.0, 5.0, -5.0, -6.0, 2.0, -1.0, 0.0, -3.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-6.0, -5.0, -2.0, -2.0));
	block.var[1] = (vec4(-5.0, -9.0, -5.0, 1.0));
	block.var[2] = (vec4(4.0, 1.0, -2.0, -6.0));
	block.var[3] = (vec4(-7.0, -7.0, -1.0, 5.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(0.0, 2.0, -5.0, -4.0, 3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-6.0, -2.0, 5.0));
	block.var[1] = (vec3(0.0, 0.0, 6.0));
}
#version 450
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
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.var), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = uint16_t(9u);
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(2.0, 8.0, 7.0, -3.0, 5.0, -4.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(9.0, 1.0, 1.0, 9.0, -7.0, -2.0, 1.0, 7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 8.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], 9.0) && allOk;
	allOk = compare_float(block.var[0][3], 4.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], 2.0) && allOk;
	allOk = compare_float(block.var[1][2], 9.0) && allOk;
	allOk = compare_float(block.var[1][3], -9.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(8.0, -6.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-3.0, 2.0, 9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(0.0, 1.0, 1.0, 2.0, -2.0, -8.0, -1.0, 8.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(2.0, -9.0, -3.0, 3.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-9.0, 0.0, 7.0, 6.0, 0.0, 3.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][2], -7.0) && allOk;
	allOk = compare_float(block.var[2][0], 1.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], -2.0) && allOk;
	allOk = compare_float(block.var[3][0], 7.0) && allOk;
	allOk = compare_float(block.var[3][1], 2.0) && allOk;
	allOk = compare_float(block.var[3][2], -6.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-4.0, -6.0, -1.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(3.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(1.0, -6.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(7.0, 2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(-9.0, -4.0, -9.0, -4.0, 5.0, -3.0, -8.0, 5.0, -3.0, -8.0, 2.0, -9.0));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(8.0, 2.0, -3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0] = (vec2(5.0, 8.0));
	block.var[1] = (vec2(-9.0, 8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], -8.0) && allOk;
	allOk = compare_float(block.var[1][0], -6.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var = (mat2(4.0, -1.0, 3.0, 9.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat4(block.var, mat4(6.0, -1.0, -4.0, 5.0, 5.0, -8.0, 7.0, -8.0, 5.0, 4.0, 0.0, 6.0, 5.0, 1.0, -2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var = (mat4(-3.0, -4.0, 6.0, 6.0, 2.0, 2.0, 7.0, -7.0, 5.0, -2.0, 0.0, 8.0, -9.0, -5.0, 2.0, 2.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_float(block.var[0][0], -5.0) && allOk;
	allOk = compare_float(block.var[0][1], -9.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[0][3], 2.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][2], 2.0) && allOk;
	allOk = compare_float(block.var[1][3], 3.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-5.0, -9.0, -2.0, 2.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-5.0, 5.0, 2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0] = (vec4(-7.0, -8.0, 7.0, -1.0));
	block.var[1] = (vec4(0.0, 6.0, -3.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat3x2(block.var, mat3x2(6.0, -4.0, 0.0, -4.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var = (mat3x2(6.0, -1.0, 9.0, 4.0, 5.0, -4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_float(block.var[0][0], 4.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][0], 6.0) && allOk;
	allOk = compare_float(block.var[2][1], -3.0) && allOk;
	allOk = compare_float(block.var[3][0], -8.0) && allOk;
	allOk = compare_float(block.var[3][1], 4.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(4.0, -4.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(6.0, -6.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(6.0, -3.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-8.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0] = (vec2(9.0, -6.0));
	block.var[1] = (vec2(6.0, -1.0));
	block.var[2] = (vec2(8.0, 1.0));
	block.var[3] = (vec2(3.0, 0.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_float(block.var[2][0], 0.0) && allOk;
	allOk = compare_float(block.var[2][1], -8.0) && allOk;
	allOk = compare_float(block.var[3][0], -5.0) && allOk;
	allOk = compare_float(block.var[3][1], -9.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-3.0, -3.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-5.0, -9.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(0.0, -8.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0] = (vec2(-4.0, -2.0));
	block.var[1] = (vec2(-1.0, -7.0));
	block.var[2] = (vec2(8.0, -4.0));
	block.var[3] = (vec2(6.0, -1.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(8.0, -9.0, 9.0, -6.0, -8.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(3.0, 6.0, -4.0, 1.0, 5.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(2.0, -9.0, 8.0, 9.0, 2.0, -7.0, -8.0, 9.0)) && allOk;
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
}
#version 450
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
	highp ivec2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((block.var[0]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((block.var[1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((block.var[2]), ivec2(-8, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (ivec2(-6, 8));
	block.var[1] = (ivec2(3, -1));
	block.var[2] = (ivec2(-5, -2));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat4x3(block.var[0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	block.var[1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	block.var[2] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_mat4x2(block.var[0], mat4x2(-3.0, -5.0, -5.0, -4.0, 8.0, -3.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-8.0, 9.0, -7.0, -5.0, -5.0, -5.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(3.0, -7.0, 5.0, 3.0, 9.0, -8.0, 8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0] = (mat4x2(1.0, 5.0, 0.0, 6.0, 3.0, 6.0, 9.0, -5.0));
	block.var[1] = (mat4x2(8.0, -6.0, 1.0, -3.0, 2.0, 4.0, -7.0, 8.0));
	block.var[2] = (mat4x2(6.0, 6.0, 1.0, -9.0, 9.0, -3.0, -2.0, 2.0));
}
#version 450
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_mat4x3(block.var[0], mat4x3(5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0, -9.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0, 0.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0] = (mat4x3(4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0, 9.0, 6.0, -8.0));
	block.var[1] = (mat4x3(9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0, -2.0, 9.0, 6.0));
	block.var[2] = (mat4x3(9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0, 8.0, 8.0, -7.0));
}
#version 450
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
	f16vec4 var[3];
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
	allOk = compare_f16vec4(vec4(block.var[0]), vec4(-9.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1]), vec4(-8.0, -8.0, -3.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2]), vec4(6.0, 1.0, -8.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = float16_t(9.0);
	block.var[0] = f16vec4(vec4(-6.0, 2.0, -8.0, -7.0));
	block.var[1] = f16vec4(vec4(-4.0, 2.0, -5.0, 9.0));
	block.var[2] = f16vec4(vec4(1.0, -6.0, 3.0, -1.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	highp float var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.var[0][0]), 7.0) && allOk;
	allOk = compare_float((block.var[0][1]), -1.0) && allOk;
	allOk = compare_float((block.var[0][2]), -6.0) && allOk;
	allOk = compare_float((block.var[1][0]), 0.0) && allOk;
	allOk = compare_float((block.var[1][1]), -7.0) && allOk;
	allOk = compare_float((block.var[1][2]), 5.0) && allOk;
	allOk = compare_float((block.var[2][0]), 4.0) && allOk;
	allOk = compare_float((block.var[2][1]), 2.0) && allOk;
	allOk = compare_float((block.var[2][2]), -1.0) && allOk;
	allOk = compare_float((block.var[3][0]), -6.0) && allOk;
	allOk = compare_float((block.var[3][1]), -2.0) && allOk;
	allOk = compare_float((block.var[3][2]), -1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (-2.0);
	block.var[0][1] = (4.0);
	block.var[0][2] = (6.0);
	block.var[1][0] = (7.0);
	block.var[1][1] = (-4.0);
	block.var[1][2] = (5.0);
	block.var[2][0] = (-8.0);
	block.var[2][1] = (9.0);
	block.var[2][2] = (-5.0);
	block.var[3][0] = (8.0);
	block.var[3][1] = (-5.0);
	block.var[3][2] = (6.0);
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	block.var[0][0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	block.var[0][1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	block.var[0][1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	block.var[0][2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	block.var[0][2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	block.var[1][0][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	block.var[1][0][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	block.var[1][1][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	block.var[1][1][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	block.var[1][2][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	block.var[1][2][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	block.var[2][0][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	block.var[2][0][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	block.var[2][1][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	block.var[2][1][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	block.var[2][2][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	block.var[2][2][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	block.var[3][0][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	block.var[3][0][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	block.var[3][1][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	block.var[3][1][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	block.var[3][2][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	block.var[3][2][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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

layout(std430, buffer_reference) buffer Block
{
	i16vec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(block.var[0][0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][2]), ivec2(-4, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][0]), ivec2(-1, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][1]), ivec2(-1, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][2]), ivec2(-1, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][0]), ivec2(-6, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][1]), ivec2(-5, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][2]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][0]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][1]), ivec2(6, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][2]), ivec2(1, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = i16vec2(ivec2(6, -2));
	block.var[0][1] = i16vec2(ivec2(-2, -8));
	block.var[0][2] = i16vec2(ivec2(3, 5));
	block.var[1][0] = i16vec2(ivec2(-9, -9));
	block.var[1][1] = i16vec2(ivec2(-4, -3));
	block.var[1][2] = i16vec2(ivec2(-2, 6));
	block.var[2][0] = i16vec2(ivec2(0, -1));
	block.var[2][1] = i16vec2(ivec2(3, -9));
	block.var[2][2] = i16vec2(ivec2(9, -6));
	block.var[3][0] = i16vec2(ivec2(-1, -7));
	block.var[3][1] = i16vec2(ivec2(-1, -6));
	block.var[3][2] = i16vec2(ivec2(6, 5));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2(block.var[0][0], mat2(-7.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(8.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(-3.0, -8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(9.0, 7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(-6.0, -3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(0.0, -8.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(-8.0, 0.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(7.0, -4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(-3.0, 6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(-8.0, -7.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(9.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(-6.0, -6.0, -1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0][0][0] = (vec2(-2.0, 4.0));
	block.var[0][0][1] = (vec2(-3.0, 1.0));
	block.var[0][1][0] = (vec2(2.0, -4.0));
	block.var[0][1][1] = (vec2(-3.0, -1.0));
	block.var[0][2][0] = (vec2(-4.0, 3.0));
	block.var[0][2][1] = (vec2(1.0, 7.0));
	block.var[1][0][0] = (vec2(2.0, 5.0));
	block.var[1][0][1] = (vec2(-7.0, -8.0));
	block.var[1][1][0] = (vec2(8.0, 1.0));
	block.var[1][1][1] = (vec2(4.0, 4.0));
	block.var[1][2][0] = (vec2(-9.0, 9.0));
	block.var[1][2][1] = (vec2(6.0, 1.0));
	block.var[2][0][0] = (vec2(9.0, -6.0));
	block.var[2][0][1] = (vec2(5.0, -7.0));
	block.var[2][1][0] = (vec2(7.0, 4.0));
	block.var[2][1][1] = (vec2(5.0, 7.0));
	block.var[2][2][0] = (vec2(0.0, 6.0));
	block.var[2][2][1] = (vec2(-9.0, -1.0));
	block.var[3][0][0] = (vec2(-8.0, 4.0));
	block.var[3][0][1] = (vec2(-7.0, 5.0));
	block.var[3][1][0] = (vec2(-7.0, 7.0));
	block.var[3][1][1] = (vec2(6.0, -1.0));
	block.var[3][2][0] = (vec2(9.0, -7.0));
	block.var[3][2][1] = (vec2(-5.0, -5.0));
}
#version 450
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
	uint8_t var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.var[0][0][0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][0][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][0][2]), 3u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][1][0]), 6u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][1][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][1][2]), 5u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][0][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][0][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][0][2]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][1][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][1][1]), 8u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][1][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][0][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][0][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][0][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][1][0]), 3u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][1][1]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][1][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][0][0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][0][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][0][2]), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][1][0]), 0u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][1][1]), 6u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][1][2]), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = uint8_t(9u);
	block.var[0][0][1] = uint8_t(5u);
	block.var[0][0][2] = uint8_t(2u);
	block.var[0][1][0] = uint8_t(6u);
	block.var[0][1][1] = uint8_t(0u);
	block.var[0][1][2] = uint8_t(5u);
	block.var[1][0][0] = uint8_t(6u);
	block.var[1][0][1] = uint8_t(7u);
	block.var[1][0][2] = uint8_t(5u);
	block.var[1][1][0] = uint8_t(4u);
	block.var[1][1][1] = uint8_t(1u);
	block.var[1][1][2] = uint8_t(3u);
	block.var[2][0][0] = uint8_t(8u);
	block.var[2][0][1] = uint8_t(4u);
	block.var[2][0][2] = uint8_t(2u);
	block.var[2][1][0] = uint8_t(0u);
	block.var[2][1][1] = uint8_t(3u);
	block.var[2][1][2] = uint8_t(3u);
	block.var[3][0][0] = uint8_t(6u);
	block.var[3][0][1] = uint8_t(0u);
	block.var[3][0][2] = uint8_t(1u);
	block.var[3][1][0] = uint8_t(3u);
	block.var[3][1][1] = uint8_t(3u);
	block.var[3][1][2] = uint8_t(3u);
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(1.0, 3.0, -2.0, -3.0, -6.0, 5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(8.0, -1.0, 5.0, 7.0, -6.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-6.0, 4.0, 9.0, -5.0, -9.0, 7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-9.0, 8.0, -3.0, 8.0, -9.0, -6.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-6.0, -1.0, -6.0, -5.0, -3.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-1.0, -8.0, -4.0, 8.0, -6.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-4.0, 9.0, 9.0, 0.0, 9.0, -4.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(-9.0, 6.0, 5.0, 1.0, 2.0, 1.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(-1.0, 0.0, -9.0, 6.0, 9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(9.0, -3.0, -8.0, 7.0, 2.0, -5.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(0.0, 5.0, 8.0, -5.0, 9.0, 4.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(1.0, 5.0, 6.0, -2.0, 0.0, -8.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	block.var[0][0][1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	block.var[0][0][2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
	block.var[0][1][0] = (mat2x4(1.0, -7.0, -5.0, 8.0, 7.0, 5.0, -9.0, 8.0));
	block.var[0][1][1] = (mat2x4(-9.0, -3.0, 4.0, 1.0, 7.0, 5.0, -2.0, 7.0));
	block.var[0][1][2] = (mat2x4(5.0, 2.0, 3.0, -3.0, -1.0, 8.0, 4.0, -9.0));
	block.var[1][0][0] = (mat2x4(-6.0, 1.0, 7.0, -9.0, 7.0, -5.0, -1.0, -8.0));
	block.var[1][0][1] = (mat2x4(-2.0, -6.0, -6.0, 6.0, 6.0, -7.0, 6.0, 9.0));
	block.var[1][0][2] = (mat2x4(3.0, 9.0, 4.0, -6.0, 7.0, -1.0, 9.0, 5.0));
	block.var[1][1][0] = (mat2x4(2.0, 5.0, 5.0, -9.0, -7.0, 9.0, 4.0, -1.0));
	block.var[1][1][1] = (mat2x4(7.0, 7.0, -4.0, 6.0, 0.0, -9.0, 5.0, -7.0));
	block.var[1][1][2] = (mat2x4(-4.0, 5.0, -1.0, 5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[2][0][0] = (mat2x4(-7.0, 0.0, -8.0, 2.0, -6.0, -5.0, 9.0, 2.0));
	block.var[2][0][1] = (mat2x4(2.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 2.0));
	block.var[2][0][2] = (mat2x4(4.0, 2.0, 8.0, -5.0, -9.0, -1.0, 6.0, -2.0));
	block.var[2][1][0] = (mat2x4(8.0, 2.0, 5.0, 5.0, 6.0, -6.0, 6.0, -3.0));
	block.var[2][1][1] = (mat2x4(1.0, 8.0, 2.0, 3.0, 2.0, -5.0, 3.0, 3.0));
	block.var[2][1][2] = (mat2x4(-4.0, -9.0, -5.0, -3.0, 6.0, 8.0, 8.0, 7.0));
	block.var[3][0][0] = (mat2x4(4.0, 1.0, -1.0, -1.0, 7.0, 0.0, 6.0, 9.0));
	block.var[3][0][1] = (mat2x4(5.0, 9.0, -6.0, -6.0, -2.0, -9.0, 9.0, 3.0));
	block.var[3][0][2] = (mat2x4(2.0, 4.0, -3.0, 6.0, 6.0, 9.0, 1.0, 5.0));
	block.var[3][1][0] = (mat2x4(-3.0, -4.0, -9.0, -1.0, -5.0, -2.0, 3.0, 1.0));
	block.var[3][1][1] = (mat2x4(-1.0, 9.0, -7.0, 4.0, -9.0, 0.0, -7.0, 1.0));
	block.var[3][1][2] = (mat2x4(9.0, -7.0, -5.0, 9.0, -5.0, 3.0, -8.0, 6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2(block.var[0][0][0], mat2(-7.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(8.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(-3.0, -8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(9.0, -1.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-3.0, -6.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(0.0, -2.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(9.0, 7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-6.0, -3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(0.0, -8.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(2.0, 9.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(7.0, -9.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(7.0, -2.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-8.0, 0.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(7.0, -4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(-3.0, 6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(-8.0, 8.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(6.0, 5.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(1.0, -6.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(-8.0, -7.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(9.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(-6.0, -6.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(4.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-5.0, 2.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(-2.0, 7.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0][0][0][0] = (vec2(-2.0, 4.0));
	block.var[0][0][0][1] = (vec2(-3.0, 1.0));
	block.var[0][0][1][0] = (vec2(2.0, -4.0));
	block.var[0][0][1][1] = (vec2(-3.0, -1.0));
	block.var[0][0][2][0] = (vec2(-4.0, 3.0));
	block.var[0][0][2][1] = (vec2(1.0, 7.0));
	block.var[0][1][0][0] = (vec2(3.0, 1.0));
	block.var[0][1][0][1] = (vec2(8.0, -9.0));
	block.var[0][1][1][0] = (vec2(7.0, 1.0));
	block.var[0][1][1][1] = (vec2(7.0, -3.0));
	block.var[0][1][2][0] = (vec2(-7.0, 1.0));
	block.var[0][1][2][1] = (vec2(-9.0, -7.0));
	block.var[1][0][0][0] = (vec2(2.0, 5.0));
	block.var[1][0][0][1] = (vec2(-7.0, -8.0));
	block.var[1][0][1][0] = (vec2(8.0, 1.0));
	block.var[1][0][1][1] = (vec2(4.0, 4.0));
	block.var[1][0][2][0] = (vec2(-9.0, 9.0));
	block.var[1][0][2][1] = (vec2(6.0, 1.0));
	block.var[1][1][0][0] = (vec2(2.0, -5.0));
	block.var[1][1][0][1] = (vec2(6.0, 6.0));
	block.var[1][1][1][0] = (vec2(-5.0, -6.0));
	block.var[1][1][1][1] = (vec2(-3.0, -3.0));
	block.var[1][1][2][0] = (vec2(9.0, 6.0));
	block.var[1][1][2][1] = (vec2(7.0, -8.0));
	block.var[2][0][0][0] = (vec2(9.0, -6.0));
	block.var[2][0][0][1] = (vec2(5.0, -7.0));
	block.var[2][0][1][0] = (vec2(7.0, 4.0));
	block.var[2][0][1][1] = (vec2(5.0, 7.0));
	block.var[2][0][2][0] = (vec2(0.0, 6.0));
	block.var[2][0][2][1] = (vec2(-9.0, -1.0));
	block.var[2][1][0][0] = (vec2(0.0, 2.0));
	block.var[2][1][0][1] = (vec2(7.0, -7.0));
	block.var[2][1][1][0] = (vec2(5.0, -3.0));
	block.var[2][1][1][1] = (vec2(-7.0, -1.0));
	block.var[2][1][2][0] = (vec2(1.0, 1.0));
	block.var[2][1][2][1] = (vec2(-1.0, 7.0));
	block.var[3][0][0][0] = (vec2(-8.0, 4.0));
	block.var[3][0][0][1] = (vec2(-7.0, 5.0));
	block.var[3][0][1][0] = (vec2(-7.0, 7.0));
	block.var[3][0][1][1] = (vec2(6.0, -1.0));
	block.var[3][0][2][0] = (vec2(9.0, -7.0));
	block.var[3][0][2][1] = (vec2(-5.0, -5.0));
	block.var[3][1][0][0] = (vec2(2.0, -8.0));
	block.var[3][1][0][1] = (vec2(1.0, -1.0));
	block.var[3][1][1][0] = (vec2(2.0, -4.0));
	block.var[3][1][1][1] = (vec2(1.0, -9.0));
	block.var[3][1][2][0] = (vec2(7.0, 0.0));
	block.var[3][1][2][1] = (vec2(-4.0, -3.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(-8.0, 7.0, 2.0, -7.0, 4.0, -2.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-1.0, 2.0, 0.0, -9.0, -9.0, 6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(-7.0, 8.0, -6.0, -9.0, -8.0, 8.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(-6.0, 0.0, -3.0, 9.0, 7.0, -8.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(3.0, 4.0, -4.0, -1.0, -7.0, -1.0, 4.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(1.0, 1.0, 3.0, -6.0, -4.0, -2.0, -6.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-6.0, 4.0, -3.0, -2.0, 3.0, 7.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-4.0, -3.0, -3.0, 4.0, -6.0, -6.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(4.0, 6.0, -3.0, 5.0, -4.0, -6.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(-8.0, 9.0, 0.0, -7.0, 1.0, -2.0, 3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(6.0, 6.0, -4.0, 4.0, -2.0, 6.0, 2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(2.0, 3.0, 1.0, 8.0, 9.0, -4.0, -2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(4.0, -9.0, 6.0, -1.0, 0.0, -2.0, 4.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-1.0, 1.0, -9.0, 4.0, 6.0, 8.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(3.0, 0.0, -4.0, 8.0, 3.0, 9.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(8.0, -1.0, -4.0, -2.0, 4.0, -8.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(9.0, 6.0, 8.0, -7.0, 4.0, -8.0, 4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(2.0, 9.0, 6.0, -8.0, -6.0, -3.0, -4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(-5.0, -8.0, 6.0, 2.0, 5.0, -6.0, 7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(-8.0, 3.0, -2.0, 1.0, 3.0, -1.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(-2.0, -4.0, -1.0, 1.0, -1.0, -8.0, -9.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	block.var[0][0][1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[0][1][0] = (mat3(5.0, 8.0, -1.0, 8.0, 9.0, 6.0, -1.0, 5.0, -2.0));
	block.var[0][1][1] = (mat3(1.0, 4.0, -8.0, 8.0, 1.0, 2.0, 4.0, -7.0, 3.0));
	block.var[0][2][0] = (mat3(-9.0, 2.0, -8.0, 1.0, -5.0, 5.0, 8.0, -6.0, 7.0));
	block.var[0][2][1] = (mat3(-1.0, 7.0, -7.0, 7.0, 5.0, -9.0, 5.0, 3.0, -1.0));
	block.var[0][3][0] = (mat3(-7.0, 7.0, -5.0, 5.0, 0.0, 7.0, -8.0, -5.0, 8.0));
	block.var[0][3][1] = (mat3(4.0, -8.0, -8.0, 3.0, -2.0, 4.0, 8.0, -1.0, -5.0));
	block.var[1][0][0] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
	block.var[1][0][1] = (mat3(-5.0, 4.0, 9.0, -2.0, -6.0, 2.0, -1.0, 0.0, 2.0));
	block.var[1][1][0] = (mat3(-1.0, -5.0, 2.0, 2.0, -1.0, -7.0, 7.0, -8.0, -6.0));
	block.var[1][1][1] = (mat3(5.0, -9.0, 2.0, 2.0, -9.0, -9.0, -2.0, 1.0, 8.0));
	block.var[1][2][0] = (mat3(6.0, -3.0, 9.0, 7.0, 0.0, 2.0, 8.0, -5.0, -9.0));
	block.var[1][2][1] = (mat3(-3.0, 0.0, 7.0, -7.0, 1.0, -6.0, -4.0, 1.0, -9.0));
	block.var[1][3][0] = (mat3(-5.0, -1.0, -1.0, 4.0, 9.0, 2.0, -2.0, -7.0, 2.0));
	block.var[1][3][1] = (mat3(-5.0, -3.0, -3.0, 1.0, -3.0, -9.0, 5.0, 7.0, 7.0));
	block.var[2][0][0] = (mat3(9.0, -5.0, 7.0, 6.0, 8.0, 4.0, 5.0, -2.0, -5.0));
	block.var[2][0][1] = (mat3(7.0, -1.0, 1.0, -3.0, -8.0, 1.0, -4.0, 7.0, 1.0));
	block.var[2][1][0] = (mat3(-4.0, 8.0, -5.0, 5.0, -2.0, 2.0, 3.0, 3.0, -8.0));
	block.var[2][1][1] = (mat3(0.0, 2.0, 6.0, 2.0, -5.0, -9.0, 4.0, 6.0, -3.0));
	block.var[2][2][0] = (mat3(6.0, 9.0, 8.0, 5.0, 8.0, 1.0, 6.0, 4.0, -4.0));
	block.var[2][2][1] = (mat3(9.0, -4.0, 1.0, -5.0, 8.0, -3.0, 4.0, -9.0, -8.0));
	block.var[2][3][0] = (mat3(6.0, 3.0, -3.0, 2.0, 0.0, 2.0, -1.0, 4.0, 2.0));
	block.var[2][3][1] = (mat3(2.0, 3.0, 2.0, -9.0, 3.0, 4.0, -6.0, -3.0, -9.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(5.0, -7.0, -7.0, -6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(2.0, 5.0, 2.0, 0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(8.0, 3.0, -4.0, -1.0, -1.0, 6.0, 4.0, -5.0, 5.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(-2.0, -4.0, 7.0, -7.0, -5.0, 7.0, 0.0, 0.0, -1.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(-4.0, -2.0, -6.0, -6.0, -1.0, -4.0, 1.0, 5.0, -2.0, 2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(-7.0, 4.0, -9.0, 9.0, -7.0, -9.0, -7.0, -1.0, 9.0, -4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(1.0, 7.0, -4.0, 6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-9.0, -1.0, -2.0, -2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(-5.0, -8.0, 7.0, 3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(8.0, 9.0, 4.0, 2.0, 6.0, 1.0, -3.0, 0.0, 1.0, -6.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(0.0, 9.0, 4.0, -6.0, 8.0, 9.0, 3.0, -5.0, -8.0, 4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(4.0, -3.0, 2.0, 1.0, -6.0, 3.0, 7.0, -1.0, 0.0, 8.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(-9.0, -9.0, -9.0, 3.0, 7.0, 2.0, 9.0, 2.0, 9.0, 2.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(5.0, 4.0, 8.0, -8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(6.0, 3.0, 0.0, -3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(5.0, 2.0, 7.0, 6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-7.0, 4.0, 6.0, 2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(7.0, -4.0, -1.0, -2.0, 6.0, 7.0, 5.0, -4.0, 3.0, 1.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(4.0, -5.0, 9.0, 5.0, 6.0, 2.0, 5.0, 5.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(1.0, 3.0, -2.0, 4.0, 1.0, 2.0, 5.0, -9.0, -7.0, 3.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(-5.0, 3.0, 3.0, 2.0, -4.0, 4.0, -8.0, -3.0, 4.0, 4.0, 0.0, -8.0)) && allOk;
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
	block.var[0][1][0][0] = (vec3(-9.0, 3.0, -2.0));
	block.var[0][1][0][1] = (vec3(5.0, 6.0, -7.0));
	block.var[0][1][0][2] = (vec3(-8.0, 1.0, 8.0));
	block.var[0][1][0][3] = (vec3(1.0, 6.0, -1.0));
	block.var[0][1][1][0] = (vec3(-5.0, 0.0, -6.0));
	block.var[0][1][1][1] = (vec3(5.0, -3.0, 2.0));
	block.var[0][1][1][2] = (vec3(-5.0, 2.0, -2.0));
	block.var[0][1][1][3] = (vec3(-7.0, -9.0, -1.0));
	block.var[0][2][0][0] = (vec3(-5.0, 5.0, -2.0));
	block.var[0][2][0][1] = (vec3(1.0, -7.0, -9.0));
	block.var[0][2][0][2] = (vec3(4.0, -9.0, 8.0));
	block.var[0][2][0][3] = (vec3(2.0, 5.0, -4.0));
	block.var[0][2][1][0] = (vec3(-9.0, -9.0, 5.0));
	block.var[0][2][1][1] = (vec3(-3.0, 6.0, -3.0));
	block.var[0][2][1][2] = (vec3(7.0, -9.0, -4.0));
	block.var[0][2][1][3] = (vec3(9.0, 6.0, 2.0));
	block.var[0][3][0][0] = (vec3(-1.0, -5.0, 2.0));
	block.var[0][3][0][1] = (vec3(4.0, 7.0, -4.0));
	block.var[0][3][0][2] = (vec3(6.0, 2.0, -4.0));
	block.var[0][3][0][3] = (vec3(8.0, -8.0, -1.0));
	block.var[0][3][1][0] = (vec3(-8.0, -9.0, 2.0));
	block.var[0][3][1][1] = (vec3(-8.0, -2.0, -1.0));
	block.var[0][3][1][2] = (vec3(-4.0, 5.0, 4.0));
	block.var[0][3][1][3] = (vec3(-6.0, -1.0, 7.0));
	block.var[1][0][0][0] = (vec3(2.0, 7.0, -1.0));
	block.var[1][0][0][1] = (vec3(-3.0, -3.0, -7.0));
	block.var[1][0][0][2] = (vec3(-5.0, 3.0, 4.0));
	block.var[1][0][0][3] = (vec3(-4.0, -2.0, 8.0));
	block.var[1][0][1][0] = (vec3(-1.0, -8.0, 8.0));
	block.var[1][0][1][1] = (vec3(-4.0, -7.0, -7.0));
	block.var[1][0][1][2] = (vec3(8.0, 4.0, -6.0));
	block.var[1][0][1][3] = (vec3(6.0, 0.0, 1.0));
	block.var[1][1][0][0] = (vec3(-2.0, -3.0, -7.0));
	block.var[1][1][0][1] = (vec3(-9.0, -4.0, 9.0));
	block.var[1][1][0][2] = (vec3(4.0, -4.0, 5.0));
	block.var[1][1][0][3] = (vec3(7.0, 1.0, 7.0));
	block.var[1][1][1][0] = (vec3(-9.0, 5.0, 4.0));
	block.var[1][1][1][1] = (vec3(4.0, 0.0, 0.0));
	block.var[1][1][1][2] = (vec3(0.0, -3.0, 3.0));
	block.var[1][1][1][3] = (vec3(1.0, 8.0, 0.0));
	block.var[1][2][0][0] = (vec3(-3.0, -5.0, 2.0));
	block.var[1][2][0][1] = (vec3(-9.0, 5.0, -6.0));
	block.var[1][2][0][2] = (vec3(5.0, -7.0, -9.0));
	block.var[1][2][0][3] = (vec3(0.0, 9.0, 9.0));
	block.var[1][2][1][0] = (vec3(-9.0, 5.0, 5.0));
	block.var[1][2][1][1] = (vec3(-2.0, 7.0, 7.0));
	block.var[1][2][1][2] = (vec3(-2.0, 7.0, -9.0));
	block.var[1][2][1][3] = (vec3(5.0, 5.0, -4.0));
	block.var[1][3][0][0] = (vec3(1.0, -1.0, 9.0));
	block.var[1][3][0][1] = (vec3(-9.0, 4.0, 7.0));
	block.var[1][3][0][2] = (vec3(-5.0, -9.0, 1.0));
	block.var[1][3][0][3] = (vec3(-1.0, 2.0, -5.0));
	block.var[1][3][1][0] = (vec3(3.0, 6.0, 7.0));
	block.var[1][3][1][1] = (vec3(4.0, -5.0, 8.0));
	block.var[1][3][1][2] = (vec3(4.0, 6.0, 1.0));
	block.var[1][3][1][3] = (vec3(-4.0, 5.0, -7.0));
	block.var[2][0][0][0] = (vec3(7.0, -1.0, -8.0));
	block.var[2][0][0][1] = (vec3(9.0, 9.0, -6.0));
	block.var[2][0][0][2] = (vec3(0.0, 1.0, 1.0));
	block.var[2][0][0][3] = (vec3(2.0, 7.0, 2.0));
	block.var[2][0][1][0] = (vec3(-3.0, -6.0, 5.0));
	block.var[2][0][1][1] = (vec3(3.0, -1.0, -1.0));
	block.var[2][0][1][2] = (vec3(-2.0, 9.0, -5.0));
	block.var[2][0][1][3] = (vec3(8.0, -6.0, -5.0));
	block.var[2][1][0][0] = (vec3(-2.0, 9.0, -8.0));
	block.var[2][1][0][1] = (vec3(-8.0, 7.0, -9.0));
	block.var[2][1][0][2] = (vec3(3.0, -2.0, -3.0));
	block.var[2][1][0][3] = (vec3(-5.0, 1.0, -4.0));
	block.var[2][1][1][0] = (vec3(5.0, 5.0, 8.0));
	block.var[2][1][1][1] = (vec3(3.0, 7.0, -3.0));
	block.var[2][1][1][2] = (vec3(-2.0, 2.0, -9.0));
	block.var[2][1][1][3] = (vec3(0.0, 9.0, 5.0));
	block.var[2][2][0][0] = (vec3(6.0, -3.0, 7.0));
	block.var[2][2][0][1] = (vec3(-3.0, 1.0, -7.0));
	block.var[2][2][0][2] = (vec3(-1.0, 0.0, -9.0));
	block.var[2][2][0][3] = (vec3(0.0, -4.0, 9.0));
	block.var[2][2][1][0] = (vec3(-6.0, -5.0, 7.0));
	block.var[2][2][1][1] = (vec3(6.0, 1.0, -2.0));
	block.var[2][2][1][2] = (vec3(2.0, 8.0, 9.0));
	block.var[2][2][1][3] = (vec3(2.0, -8.0, -9.0));
	block.var[2][3][0][0] = (vec3(-2.0, -3.0, -9.0));
	block.var[2][3][0][1] = (vec3(5.0, -8.0, -5.0));
	block.var[2][3][0][2] = (vec3(-7.0, -4.0, -3.0));
	block.var[2][3][0][3] = (vec3(-1.0, 8.0, -8.0));
	block.var[2][3][1][0] = (vec3(-2.0, -6.0, 6.0));
	block.var[2][3][1][1] = (vec3(-3.0, -2.0, -8.0));
	block.var[2][3][1][2] = (vec3(-3.0, -2.0, -2.0));
	block.var[2][3][1][3] = (vec3(-9.0, 4.0, 7.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-5.0, -1.0, -4.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(1.0, -6.0, -3.0, -3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(-1.0, 2.0, -7.0, 2.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(-2.0, -2.0, 5.0, 6.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(1.0, 7.0, 5.0, -5.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(-8.0, -9.0, 7.0, 4.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(-4.0, 6.0, -8.0, 8.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(-9.0, 5.0, -9.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(8.0, -6.0, -5.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(3.0, 2.0, -1.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(3.0, -5.0, -4.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(-2.0, 7.0, 6.0, 6.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	block.var[0][0][1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	block.var[0][1][0] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	block.var[0][1][1] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	block.var[0][2][0] = (mat3x2(-6.0, -4.0, 8.0, 4.0, 5.0, 4.0));
	block.var[0][2][1] = (mat3x2(8.0, 3.0, 9.0, -4.0, -3.0, -6.0));
	block.var[0][3][0] = (mat3x2(3.0, 2.0, 8.0, -9.0, -3.0, -7.0));
	block.var[0][3][1] = (mat3x2(0.0, -5.0, -2.0, -1.0, -6.0, -9.0));
	block.var[1][0][0] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	block.var[1][0][1] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	block.var[1][1][0] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	block.var[1][1][1] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	block.var[1][2][0] = (mat3x2(-9.0, 8.0, 6.0, -7.0, 9.0, 2.0));
	block.var[1][2][1] = (mat3x2(-2.0, -3.0, -2.0, -4.0, 5.0, -4.0));
	block.var[1][3][0] = (mat3x2(-7.0, 8.0, 6.0, 5.0, -3.0, 0.0));
	block.var[1][3][1] = (mat3x2(7.0, 4.0, 0.0, 5.0, 7.0, -2.0));
	block.var[2][0][0] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	block.var[2][0][1] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	block.var[2][1][0] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	block.var[2][1][1] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
	block.var[2][2][0] = (mat3x2(9.0, -9.0, -9.0, -6.0, 8.0, 1.0));
	block.var[2][2][1] = (mat3x2(4.0, -2.0, 0.0, -9.0, 4.0, -2.0));
	block.var[2][3][0] = (mat3x2(-2.0, 8.0, -3.0, 4.0, 5.0, -1.0));
	block.var[2][3][1] = (mat3x2(-4.0, 3.0, 7.0, -8.0, 7.0, 3.0));
}
#version 450
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
	f16vec2 var[][4][2];
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
	allOk = compare_f16vec2(vec2(block.var[0][1][0]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][1][1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][2][0]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][2][1]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][3][0]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][3][1]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0][0]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0][1]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1][0]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1][1]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][2][0]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][2][1]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][3][0]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][3][1]), vec2(-3.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0][0]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0][1]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1][0]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1][1]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][2][0]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][2][1]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][3][0]), vec2(0.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][3][1]), vec2(3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = f16vec2(vec2(-2.0, 4.0));
	block.var[0][0][1] = f16vec2(vec2(-2.0, 4.0));
	block.var[0][1][0] = f16vec2(vec2(2.0, 2.0));
	block.var[0][1][1] = f16vec2(vec2(-6.0, 5.0));
	block.var[0][2][0] = f16vec2(vec2(6.0, 0.0));
	block.var[0][2][1] = f16vec2(vec2(3.0, 5.0));
	block.var[0][3][0] = f16vec2(vec2(7.0, -6.0));
	block.var[0][3][1] = f16vec2(vec2(-2.0, -4.0));
	block.var[1][0][0] = f16vec2(vec2(-1.0, 1.0));
	block.var[1][0][1] = f16vec2(vec2(9.0, 4.0));
	block.var[1][1][0] = f16vec2(vec2(5.0, -7.0));
	block.var[1][1][1] = f16vec2(vec2(3.0, 0.0));
	block.var[1][2][0] = f16vec2(vec2(9.0, -9.0));
	block.var[1][2][1] = f16vec2(vec2(-6.0, 7.0));
	block.var[1][3][0] = f16vec2(vec2(5.0, -2.0));
	block.var[1][3][1] = f16vec2(vec2(5.0, 2.0));
	block.var[2][0][0] = f16vec2(vec2(8.0, -8.0));
	block.var[2][0][1] = f16vec2(vec2(1.0, -3.0));
	block.var[2][1][0] = f16vec2(vec2(-2.0, 3.0));
	block.var[2][1][1] = f16vec2(vec2(-6.0, 5.0));
	block.var[2][2][0] = f16vec2(vec2(3.0, -7.0));
	block.var[2][2][1] = f16vec2(vec2(4.0, -5.0));
	block.var[2][3][0] = f16vec2(vec2(8.0, -7.0));
	block.var[2][3][1] = f16vec2(vec2(3.0, -7.0));
}
#version 450
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
	highp uvec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block.var[0][0][0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[0][0][1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[0][1][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[0][1][1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[0][2][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[0][2][1]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[0][3][0]), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[0][3][1]), uvec2(7u, 3u)) && allOk;
	allOk = compare_uvec2((block.var[1][0][0]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[1][0][1]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[1][1][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[1][1][1]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[1][2][0]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[1][2][1]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[1][3][0]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[1][3][1]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[2][0][0]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[2][0][1]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[2][1][0]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[2][1][1]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[2][2][0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[2][2][1]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[2][3][0]), uvec2(4u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[2][3][1]), uvec2(8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (uvec2(6u, 1u));
	block.var[0][0][1] = (uvec2(8u, 1u));
	block.var[0][1][0] = (uvec2(8u, 4u));
	block.var[0][1][1] = (uvec2(6u, 3u));
	block.var[0][2][0] = (uvec2(6u, 2u));
	block.var[0][2][1] = (uvec2(6u, 0u));
	block.var[0][3][0] = (uvec2(0u, 1u));
	block.var[0][3][1] = (uvec2(2u, 6u));
	block.var[1][0][0] = (uvec2(7u, 4u));
	block.var[1][0][1] = (uvec2(6u, 6u));
	block.var[1][1][0] = (uvec2(6u, 0u));
	block.var[1][1][1] = (uvec2(3u, 5u));
	block.var[1][2][0] = (uvec2(3u, 2u));
	block.var[1][2][1] = (uvec2(5u, 1u));
	block.var[1][3][0] = (uvec2(9u, 1u));
	block.var[1][3][1] = (uvec2(4u, 6u));
	block.var[2][0][0] = (uvec2(5u, 8u));
	block.var[2][0][1] = (uvec2(4u, 7u));
	block.var[2][1][0] = (uvec2(2u, 4u));
	block.var[2][1][1] = (uvec2(7u, 8u));
	block.var[2][2][0] = (uvec2(7u, 2u));
	block.var[2][2][1] = (uvec2(3u, 6u));
	block.var[2][3][0] = (uvec2(4u, 2u));
	block.var[2][3][1] = (uvec2(7u, 5u));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(-2.0, -1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-4.0, 9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(1.0, 8.0, -5.0, -5.0, -8.0, -4.0, -7.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(-5.0, -8.0, 6.0, 4.0, -3.0, 9.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(2.0, -4.0, -2.0, -7.0, 2.0, -2.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(3.0, -2.0, 5.0, -3.0, 7.0, -5.0, 2.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(3.0, 7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(6.0, -4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(0.0, 5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(-2.0, 7.0, -4.0, 4.0, -4.0, 1.0, 6.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(2.0, -6.0, 4.0, -6.0, 8.0, 1.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(2.0, 2.0, 8.0, -3.0, -7.0, -9.0, -7.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(-6.0, 7.0, -4.0, 4.0, 5.0, 3.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(4.0, 9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-9.0, -9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-3.0, -7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(8.0, 4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(6.0, 5.0, 5.0, -1.0, -9.0, -7.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(0.0, -7.0, 0.0, -4.0, 1.0, -7.0, 1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(5.0, -9.0, 6.0, -4.0, -2.0, -4.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(0.0, -9.0, 2.0, -6.0, 6.0, 7.0, 8.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(2.0, -4.0, 9.0));
	block.var[0][0][0][1] = (vec3(-4.0, 2.0, 5.0));
	block.var[0][0][0][2] = (vec3(5.0, -9.0, -5.0));
	block.var[0][0][1][0] = (vec3(3.0, 1.0, 8.0));
	block.var[0][0][1][1] = (vec3(6.0, 9.0, -8.0));
	block.var[0][0][1][2] = (vec3(-1.0, 5.0, 1.0));
	block.var[0][1][0][0] = (vec3(9.0, -3.0, -9.0));
	block.var[0][1][0][1] = (vec3(6.0, -1.0, -6.0));
	block.var[0][1][0][2] = (vec3(6.0, 2.0, -5.0));
	block.var[0][1][1][0] = (vec3(-1.0, -2.0, 2.0));
	block.var[0][1][1][1] = (vec3(9.0, 1.0, -8.0));
	block.var[0][1][1][2] = (vec3(6.0, -1.0, 7.0));
	block.var[0][2][0][0] = (vec3(-9.0, -8.0, 2.0));
	block.var[0][2][0][1] = (vec3(-6.0, 9.0, -7.0));
	block.var[0][2][0][2] = (vec3(9.0, 6.0, 1.0));
	block.var[0][2][1][0] = (vec3(-4.0, 8.0, -7.0));
	block.var[0][2][1][1] = (vec3(1.0, 0.0, 4.0));
	block.var[0][2][1][2] = (vec3(-6.0, -3.0, 3.0));
	block.var[0][3][0][0] = (vec3(-5.0, 7.0, 5.0));
	block.var[0][3][0][1] = (vec3(-2.0, -2.0, 8.0));
	block.var[0][3][0][2] = (vec3(-3.0, 1.0, 7.0));
	block.var[0][3][1][0] = (vec3(-9.0, 8.0, 7.0));
	block.var[0][3][1][1] = (vec3(2.0, 2.0, -5.0));
	block.var[0][3][1][2] = (vec3(-8.0, -5.0, 6.0));
	block.var[1][0][0][0] = (vec3(6.0, -5.0, -4.0));
	block.var[1][0][0][1] = (vec3(-8.0, -8.0, -2.0));
	block.var[1][0][0][2] = (vec3(9.0, -4.0, 4.0));
	block.var[1][0][1][0] = (vec3(4.0, -1.0, 5.0));
	block.var[1][0][1][1] = (vec3(-1.0, 0.0, 9.0));
	block.var[1][0][1][2] = (vec3(7.0, 7.0, 5.0));
	block.var[1][1][0][0] = (vec3(4.0, 2.0, -8.0));
	block.var[1][1][0][1] = (vec3(0.0, 3.0, 9.0));
	block.var[1][1][0][2] = (vec3(9.0, -8.0, -4.0));
	block.var[1][1][1][0] = (vec3(-8.0, 3.0, 4.0));
	block.var[1][1][1][1] = (vec3(-4.0, 4.0, 1.0));
	block.var[1][1][1][2] = (vec3(0.0, 4.0, 5.0));
	block.var[1][2][0][0] = (vec3(-5.0, -6.0, 5.0));
	block.var[1][2][0][1] = (vec3(4.0, 3.0, -2.0));
	block.var[1][2][0][2] = (vec3(-6.0, -4.0, -1.0));
	block.var[1][2][1][0] = (vec3(4.0, 4.0, -6.0));
	block.var[1][2][1][1] = (vec3(0.0, 2.0, -5.0));
	block.var[1][2][1][2] = (vec3(5.0, 8.0, -2.0));
	block.var[1][3][0][0] = (vec3(4.0, 1.0, 9.0));
	block.var[1][3][0][1] = (vec3(5.0, -6.0, 7.0));
	block.var[1][3][0][2] = (vec3(-7.0, -2.0, -6.0));
	block.var[1][3][1][0] = (vec3(0.0, -9.0, 7.0));
	block.var[1][3][1][1] = (vec3(-2.0, 0.0, 5.0));
	block.var[1][3][1][2] = (vec3(8.0, 8.0, -1.0));
	block.var[2][0][0][0] = (vec3(8.0, -6.0, -1.0));
	block.var[2][0][0][1] = (vec3(-1.0, -2.0, -5.0));
	block.var[2][0][0][2] = (vec3(-5.0, 6.0, -3.0));
	block.var[2][0][1][0] = (vec3(-4.0, -6.0, 2.0));
	block.var[2][0][1][1] = (vec3(3.0, -1.0, 2.0));
	block.var[2][0][1][2] = (vec3(-3.0, 4.0, 1.0));
	block.var[2][1][0][0] = (vec3(-9.0, -4.0, 2.0));
	block.var[2][1][0][1] = (vec3(-6.0, 8.0, 3.0));
	block.var[2][1][0][2] = (vec3(2.0, 0.0, -1.0));
	block.var[2][1][1][0] = (vec3(7.0, 1.0, 3.0));
	block.var[2][1][1][1] = (vec3(5.0, 1.0, -6.0));
	block.var[2][1][1][2] = (vec3(2.0, -5.0, 4.0));
	block.var[2][2][0][0] = (vec3(3.0, -1.0, 7.0));
	block.var[2][2][0][1] = (vec3(-9.0, -9.0, -8.0));
	block.var[2][2][0][2] = (vec3(9.0, -9.0, -5.0));
	block.var[2][2][1][0] = (vec3(1.0, -2.0, 1.0));
	block.var[2][2][1][1] = (vec3(-8.0, -4.0, -3.0));
	block.var[2][2][1][2] = (vec3(3.0, -4.0, -3.0));
	block.var[2][3][0][0] = (vec3(-4.0, 3.0, 5.0));
	block.var[2][3][0][1] = (vec3(-9.0, 8.0, -7.0));
	block.var[2][3][0][2] = (vec3(7.0, -3.0, 4.0));
	block.var[2][3][1][0] = (vec3(-6.0, 3.0, 6.0));
	block.var[2][3][1][1] = (vec3(-9.0, 9.0, 3.0));
	block.var[2][3][1][2] = (vec3(8.0, 8.0, -2.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(5.0, -7.0, -7.0, -6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(2.0, 5.0, 2.0, 0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(8.0, 3.0, -4.0, -1.0, -1.0, 6.0, 4.0, -5.0, 5.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(-2.0, -4.0, 7.0, -7.0, -5.0, 7.0, 0.0, 0.0, -1.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(-4.0, -2.0, -6.0, -6.0, -1.0, -4.0, 1.0, 5.0, -2.0, 2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(-7.0, 4.0, -9.0, 9.0, -7.0, -9.0, -7.0, -1.0, 9.0, -4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(1.0, 7.0, -4.0, 6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-9.0, -1.0, -2.0, -2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(-5.0, -8.0, 7.0, 3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(8.0, 9.0, 4.0, 2.0, 6.0, 1.0, -3.0, 0.0, 1.0, -6.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(0.0, 9.0, 4.0, -6.0, 8.0, 9.0, 3.0, -5.0, -8.0, 4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(4.0, -3.0, 2.0, 1.0, -6.0, 3.0, 7.0, -1.0, 0.0, 8.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(-9.0, -9.0, -9.0, 3.0, 7.0, 2.0, 9.0, 2.0, 9.0, 2.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(5.0, 4.0, 8.0, -8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(6.0, 3.0, 0.0, -3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(5.0, 2.0, 7.0, 6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-7.0, 4.0, 6.0, 2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(7.0, -4.0, -1.0, -2.0, 6.0, 7.0, 5.0, -4.0, 3.0, 1.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(4.0, -5.0, 9.0, 5.0, 6.0, 2.0, 5.0, 5.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(1.0, 3.0, -2.0, 4.0, 1.0, 2.0, 5.0, -9.0, -7.0, 3.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(-5.0, 3.0, 3.0, 2.0, -4.0, 4.0, -8.0, -3.0, 4.0, 4.0, 0.0, -8.0)) && allOk;
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
	block.var[0][1][0][0] = (vec3(-9.0, 3.0, -2.0));
	block.var[0][1][0][1] = (vec3(5.0, 6.0, -7.0));
	block.var[0][1][0][2] = (vec3(-8.0, 1.0, 8.0));
	block.var[0][1][0][3] = (vec3(1.0, 6.0, -1.0));
	block.var[0][1][1][0] = (vec3(-5.0, 0.0, -6.0));
	block.var[0][1][1][1] = (vec3(5.0, -3.0, 2.0));
	block.var[0][1][1][2] = (vec3(-5.0, 2.0, -2.0));
	block.var[0][1][1][3] = (vec3(-7.0, -9.0, -1.0));
	block.var[0][2][0][0] = (vec3(-5.0, 5.0, -2.0));
	block.var[0][2][0][1] = (vec3(1.0, -7.0, -9.0));
	block.var[0][2][0][2] = (vec3(4.0, -9.0, 8.0));
	block.var[0][2][0][3] = (vec3(2.0, 5.0, -4.0));
	block.var[0][2][1][0] = (vec3(-9.0, -9.0, 5.0));
	block.var[0][2][1][1] = (vec3(-3.0, 6.0, -3.0));
	block.var[0][2][1][2] = (vec3(7.0, -9.0, -4.0));
	block.var[0][2][1][3] = (vec3(9.0, 6.0, 2.0));
	block.var[0][3][0][0] = (vec3(-1.0, -5.0, 2.0));
	block.var[0][3][0][1] = (vec3(4.0, 7.0, -4.0));
	block.var[0][3][0][2] = (vec3(6.0, 2.0, -4.0));
	block.var[0][3][0][3] = (vec3(8.0, -8.0, -1.0));
	block.var[0][3][1][0] = (vec3(-8.0, -9.0, 2.0));
	block.var[0][3][1][1] = (vec3(-8.0, -2.0, -1.0));
	block.var[0][3][1][2] = (vec3(-4.0, 5.0, 4.0));
	block.var[0][3][1][3] = (vec3(-6.0, -1.0, 7.0));
	block.var[1][0][0][0] = (vec3(2.0, 7.0, -1.0));
	block.var[1][0][0][1] = (vec3(-3.0, -3.0, -7.0));
	block.var[1][0][0][2] = (vec3(-5.0, 3.0, 4.0));
	block.var[1][0][0][3] = (vec3(-4.0, -2.0, 8.0));
	block.var[1][0][1][0] = (vec3(-1.0, -8.0, 8.0));
	block.var[1][0][1][1] = (vec3(-4.0, -7.0, -7.0));
	block.var[1][0][1][2] = (vec3(8.0, 4.0, -6.0));
	block.var[1][0][1][3] = (vec3(6.0, 0.0, 1.0));
	block.var[1][1][0][0] = (vec3(-2.0, -3.0, -7.0));
	block.var[1][1][0][1] = (vec3(-9.0, -4.0, 9.0));
	block.var[1][1][0][2] = (vec3(4.0, -4.0, 5.0));
	block.var[1][1][0][3] = (vec3(7.0, 1.0, 7.0));
	block.var[1][1][1][0] = (vec3(-9.0, 5.0, 4.0));
	block.var[1][1][1][1] = (vec3(4.0, 0.0, 0.0));
	block.var[1][1][1][2] = (vec3(0.0, -3.0, 3.0));
	block.var[1][1][1][3] = (vec3(1.0, 8.0, 0.0));
	block.var[1][2][0][0] = (vec3(-3.0, -5.0, 2.0));
	block.var[1][2][0][1] = (vec3(-9.0, 5.0, -6.0));
	block.var[1][2][0][2] = (vec3(5.0, -7.0, -9.0));
	block.var[1][2][0][3] = (vec3(0.0, 9.0, 9.0));
	block.var[1][2][1][0] = (vec3(-9.0, 5.0, 5.0));
	block.var[1][2][1][1] = (vec3(-2.0, 7.0, 7.0));
	block.var[1][2][1][2] = (vec3(-2.0, 7.0, -9.0));
	block.var[1][2][1][3] = (vec3(5.0, 5.0, -4.0));
	block.var[1][3][0][0] = (vec3(1.0, -1.0, 9.0));
	block.var[1][3][0][1] = (vec3(-9.0, 4.0, 7.0));
	block.var[1][3][0][2] = (vec3(-5.0, -9.0, 1.0));
	block.var[1][3][0][3] = (vec3(-1.0, 2.0, -5.0));
	block.var[1][3][1][0] = (vec3(3.0, 6.0, 7.0));
	block.var[1][3][1][1] = (vec3(4.0, -5.0, 8.0));
	block.var[1][3][1][2] = (vec3(4.0, 6.0, 1.0));
	block.var[1][3][1][3] = (vec3(-4.0, 5.0, -7.0));
	block.var[2][0][0][0] = (vec3(7.0, -1.0, -8.0));
	block.var[2][0][0][1] = (vec3(9.0, 9.0, -6.0));
	block.var[2][0][0][2] = (vec3(0.0, 1.0, 1.0));
	block.var[2][0][0][3] = (vec3(2.0, 7.0, 2.0));
	block.var[2][0][1][0] = (vec3(-3.0, -6.0, 5.0));
	block.var[2][0][1][1] = (vec3(3.0, -1.0, -1.0));
	block.var[2][0][1][2] = (vec3(-2.0, 9.0, -5.0));
	block.var[2][0][1][3] = (vec3(8.0, -6.0, -5.0));
	block.var[2][1][0][0] = (vec3(-2.0, 9.0, -8.0));
	block.var[2][1][0][1] = (vec3(-8.0, 7.0, -9.0));
	block.var[2][1][0][2] = (vec3(3.0, -2.0, -3.0));
	block.var[2][1][0][3] = (vec3(-5.0, 1.0, -4.0));
	block.var[2][1][1][0] = (vec3(5.0, 5.0, 8.0));
	block.var[2][1][1][1] = (vec3(3.0, 7.0, -3.0));
	block.var[2][1][1][2] = (vec3(-2.0, 2.0, -9.0));
	block.var[2][1][1][3] = (vec3(0.0, 9.0, 5.0));
	block.var[2][2][0][0] = (vec3(6.0, -3.0, 7.0));
	block.var[2][2][0][1] = (vec3(-3.0, 1.0, -7.0));
	block.var[2][2][0][2] = (vec3(-1.0, 0.0, -9.0));
	block.var[2][2][0][3] = (vec3(0.0, -4.0, 9.0));
	block.var[2][2][1][0] = (vec3(-6.0, -5.0, 7.0));
	block.var[2][2][1][1] = (vec3(6.0, 1.0, -2.0));
	block.var[2][2][1][2] = (vec3(2.0, 8.0, 9.0));
	block.var[2][2][1][3] = (vec3(2.0, -8.0, -9.0));
	block.var[2][3][0][0] = (vec3(-2.0, -3.0, -9.0));
	block.var[2][3][0][1] = (vec3(5.0, -8.0, -5.0));
	block.var[2][3][0][2] = (vec3(-7.0, -4.0, -3.0));
	block.var[2][3][0][3] = (vec3(-1.0, 8.0, -8.0));
	block.var[2][3][1][0] = (vec3(-2.0, -6.0, 6.0));
	block.var[2][3][1][1] = (vec3(-3.0, -2.0, -8.0));
	block.var[2][3][1][2] = (vec3(-3.0, -2.0, -2.0));
	block.var[2][3][1][3] = (vec3(-9.0, 4.0, 7.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-3.0, 0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-1.0, 0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(7.0, -9.0, 1.0, -8.0, -1.0, -4.0, -7.0, -5.0, 8.0, -9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(-5.0, 9.0, 1.0, 3.0, 0.0, -5.0, 3.0, 4.0, -5.0, 1.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(-8.0, 1.0, -1.0, -1.0, -9.0, 7.0, -4.0, 0.0, -7.0, -9.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(5.0, -9.0, 6.0, -3.0, 3.0, -7.0, 3.0, -1.0, 2.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-5.0, -5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(7.0, -1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(2.0, 6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(7.0, -8.0, -6.0, 5.0, -1.0, -9.0, 2.0, -2.0, 6.0, -5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(-9.0, -8.0, -9.0, -3.0, -2.0, 8.0, 4.0, 3.0, -8.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(-9.0, 1.0, 7.0, 0.0, 0.0, -4.0, 3.0, -4.0, -6.0, -7.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(-4.0, -2.0, -1.0, -2.0, -5.0, -7.0, -6.0, 8.0, -9.0, -3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-5.0, 8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(5.0, -4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(2.0, -4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-7.0, -7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(8.0, -3.0, -6.0, 8.0, -2.0, 8.0, 9.0, 0.0, 1.0, -3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(7.0, 0.0, 3.0, 4.0, -5.0, -8.0, 5.0, 0.0, 8.0, 2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(9.0, 8.0, -4.0, -7.0, 9.0, 5.0, -7.0, 3.0, -2.0, -4.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(5.0, 4.0, -4.0, -7.0, 7.0, -2.0, 9.0, 5.0, 1.0, -9.0, 0.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(1.0, 2.0, -5.0));
	block.var[0][0][0][1] = (vec3(-3.0, -2.0, 2.0));
	block.var[0][0][0][2] = (vec3(-5.0, 9.0, 4.0));
	block.var[0][0][0][3] = (vec3(2.0, -4.0, 9.0));
	block.var[0][0][1][0] = (vec3(8.0, -4.0, -5.0));
	block.var[0][0][1][1] = (vec3(-5.0, 6.0, 8.0));
	block.var[0][0][1][2] = (vec3(-7.0, 4.0, -8.0));
	block.var[0][0][1][3] = (vec3(-1.0, 1.0, 1.0));
	block.var[0][1][0][0] = (vec3(2.0, 5.0, 2.0));
	block.var[0][1][0][1] = (vec3(2.0, 3.0, -2.0));
	block.var[0][1][0][2] = (vec3(5.0, 4.0, 6.0));
	block.var[0][1][0][3] = (vec3(-1.0, 5.0, 6.0));
	block.var[0][1][1][0] = (vec3(1.0, 2.0, -4.0));
	block.var[0][1][1][1] = (vec3(9.0, -1.0, 6.0));
	block.var[0][1][1][2] = (vec3(9.0, -1.0, -2.0));
	block.var[0][1][1][3] = (vec3(-1.0, -8.0, 3.0));
	block.var[0][2][0][0] = (vec3(-5.0, 3.0, -5.0));
	block.var[0][2][0][1] = (vec3(-6.0, 6.0, 3.0));
	block.var[0][2][0][2] = (vec3(-6.0, 0.0, -5.0));
	block.var[0][2][0][3] = (vec3(-9.0, 8.0, -8.0));
	block.var[0][2][1][0] = (vec3(-5.0, 2.0, -7.0));
	block.var[0][2][1][1] = (vec3(-1.0, -2.0, 7.0));
	block.var[0][2][1][2] = (vec3(4.0, -7.0, 7.0));
	block.var[0][2][1][3] = (vec3(-3.0, 7.0, 6.0));
	block.var[0][3][0][0] = (vec3(1.0, -1.0, 8.0));
	block.var[0][3][0][1] = (vec3(8.0, 3.0, -9.0));
	block.var[0][3][0][2] = (vec3(1.0, -1.0, -7.0));
	block.var[0][3][0][3] = (vec3(-1.0, -7.0, -5.0));
	block.var[0][3][1][0] = (vec3(-5.0, 1.0, 8.0));
	block.var[0][3][1][1] = (vec3(5.0, 5.0, -8.0));
	block.var[0][3][1][2] = (vec3(-8.0, 2.0, 8.0));
	block.var[0][3][1][3] = (vec3(2.0, -8.0, -6.0));
	block.var[1][0][0][0] = (vec3(-4.0, 5.0, 7.0));
	block.var[1][0][0][1] = (vec3(9.0, 5.0, -7.0));
	block.var[1][0][0][2] = (vec3(8.0, 9.0, 0.0));
	block.var[1][0][0][3] = (vec3(-3.0, 3.0, 0.0));
	block.var[1][0][1][0] = (vec3(7.0, -8.0, -7.0));
	block.var[1][0][1][1] = (vec3(2.0, 7.0, 5.0));
	block.var[1][0][1][2] = (vec3(5.0, -7.0, 0.0));
	block.var[1][0][1][3] = (vec3(-2.0, 9.0, -7.0));
	block.var[1][1][0][0] = (vec3(-4.0, 1.0, -4.0));
	block.var[1][1][0][1] = (vec3(4.0, 2.0, 0.0));
	block.var[1][1][0][2] = (vec3(1.0, -6.0, 1.0));
	block.var[1][1][0][3] = (vec3(-7.0, -9.0, 8.0));
	block.var[1][1][1][0] = (vec3(1.0, 9.0, -4.0));
	block.var[1][1][1][1] = (vec3(1.0, -5.0, 9.0));
	block.var[1][1][1][2] = (vec3(2.0, -1.0, -1.0));
	block.var[1][1][1][3] = (vec3(5.0, 7.0, -4.0));
	block.var[1][2][0][0] = (vec3(9.0, -2.0, 2.0));
	block.var[1][2][0][1] = (vec3(-3.0, -6.0, 3.0));
	block.var[1][2][0][2] = (vec3(7.0, -7.0, -1.0));
	block.var[1][2][0][3] = (vec3(0.0, 1.0, -3.0));
	block.var[1][2][1][0] = (vec3(-6.0, 6.0, 2.0));
	block.var[1][2][1][1] = (vec3(-5.0, 0.0, 4.0));
	block.var[1][2][1][2] = (vec3(7.0, -6.0, -6.0));
	block.var[1][2][1][3] = (vec3(3.0, 8.0, 1.0));
	block.var[1][3][0][0] = (vec3(-9.0, 1.0, 5.0));
	block.var[1][3][0][1] = (vec3(4.0, 5.0, 1.0));
	block.var[1][3][0][2] = (vec3(-7.0, 4.0, -5.0));
	block.var[1][3][0][3] = (vec3(4.0, 8.0, 8.0));
	block.var[1][3][1][0] = (vec3(-4.0, -2.0, -5.0));
	block.var[1][3][1][1] = (vec3(-5.0, -9.0, 8.0));
	block.var[1][3][1][2] = (vec3(4.0, 8.0, 0.0));
	block.var[1][3][1][3] = (vec3(0.0, 9.0, 5.0));
	block.var[2][0][0][0] = (vec3(2.0, -9.0, 0.0));
	block.var[2][0][0][1] = (vec3(9.0, -2.0, -8.0));
	block.var[2][0][0][2] = (vec3(-9.0, 5.0, 9.0));
	block.var[2][0][0][3] = (vec3(0.0, 8.0, -9.0));
	block.var[2][0][1][0] = (vec3(2.0, 1.0, -7.0));
	block.var[2][0][1][1] = (vec3(-7.0, 8.0, 7.0));
	block.var[2][0][1][2] = (vec3(8.0, -8.0, -5.0));
	block.var[2][0][1][3] = (vec3(5.0, 1.0, -3.0));
	block.var[2][1][0][0] = (vec3(-2.0, 9.0, -4.0));
	block.var[2][1][0][1] = (vec3(-4.0, 4.0, -1.0));
	block.var[2][1][0][2] = (vec3(0.0, 7.0, 9.0));
	block.var[2][1][0][3] = (vec3(-8.0, 3.0, 9.0));
	block.var[2][1][1][0] = (vec3(-7.0, -1.0, -9.0));
	block.var[2][1][1][1] = (vec3(-7.0, 3.0, 5.0));
	block.var[2][1][1][2] = (vec3(-7.0, 1.0, -1.0));
	block.var[2][1][1][3] = (vec3(-5.0, -7.0, 7.0));
	block.var[2][2][0][0] = (vec3(-3.0, -1.0, 7.0));
	block.var[2][2][0][1] = (vec3(-2.0, -7.0, -9.0));
	block.var[2][2][0][2] = (vec3(-8.0, -1.0, 4.0));
	block.var[2][2][0][3] = (vec3(0.0, -2.0, -5.0));
	block.var[2][2][1][0] = (vec3(2.0, -7.0, 3.0));
	block.var[2][2][1][1] = (vec3(-2.0, 4.0, -6.0));
	block.var[2][2][1][2] = (vec3(8.0, -7.0, -9.0));
	block.var[2][2][1][3] = (vec3(-4.0, 5.0, 4.0));
	block.var[2][3][0][0] = (vec3(-3.0, 8.0, 6.0));
	block.var[2][3][0][1] = (vec3(7.0, 8.0, -7.0));
	block.var[2][3][0][2] = (vec3(-3.0, -6.0, -2.0));
	block.var[2][3][0][3] = (vec3(-6.0, 0.0, -8.0));
	block.var[2][3][1][0] = (vec3(-6.0, 0.0, 6.0));
	block.var[2][3][1][1] = (vec3(-1.0, 6.0, -7.0));
	block.var[2][3][1][2] = (vec3(7.0, 0.0, 1.0));
	block.var[2][3][1][3] = (vec3(-8.0, 2.0, 7.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0].a), ivec3(9, 6, -7)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(1.0, -7.0, 1.0, 8.0, 3.0, 7.0, -3.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(-3.0, 3.0, -9.0, -1.0, 3.0, 8.0, -7.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(6.0, 2.0, -9.0, 6.0, -1.0, -7.0, 0.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(-6.0, -6.0, 3.0, -3.0, 0.0, 1.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(-3.0, -7.0, -8.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(-6, 4, 1)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(-6.0, -2.0, 7.0, 5.0, -5.0, 9.0, -2.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(-9.0, -2.0, 2.0, -3.0, 5.0, 4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(-3.0, 5.0, 0.0, 2.0, -8.0, 2.0, -7.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(6.0, 4.0, 1.0, -4.0, -1.0, -5.0, 6.0, -2.0, 2.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(-4.0, 0.0, 7.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(-8, -7, -5)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(2.0, -4.0, -8.0, 7.0, -4.0, -7.0, -1.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(8.0, 9.0, 1.0, -6.0, 1.0, -1.0, 0.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(3.0, -3.0, -2.0, 4.0, 1.0, 0.0, -8.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(0.0, -6.0, 3.0, -8.0, 9.0, 2.0, -1.0, -4.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(-1.0, -9.0, -3.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(8, -2, -9)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(2.0, 6.0, 7.0, 4.0, -5.0, 6.0, -5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(-2.0, 5.0, 5.0, 5.0, -5.0, 7.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(-2.0, 6.0, 6.0, -2.0, 7.0, 9.0, 8.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(0.0, -7.0, 4.0, -1.0, 6.0, 2.0, -3.0, 5.0, 0.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(3.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(-3, 4, -8)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(3.0, -1.0, 9.0, 1.0, 7.0, 6.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(7.0, -5.0, -9.0, 8.0, -2.0, -1.0, 8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(-5.0, 0.0, -6.0, 3.0, 3.0, -4.0, 5.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(-7.0, 3.0, -4.0, -9.0, 0.0, 6.0, 9.0, -1.0, 0.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(-8.0, -5.0, -7.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(9, 8, -4)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(-6.0, -1.0, 1.0, 5.0, 9.0, -7.0, -1.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(-3.0, -9.0, 6.0, -3.0, -5.0, -2.0, -4.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(3.0, 3.0, 2.0, -9.0, -9.0, -1.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(1.0, 1.0, -5.0, -3.0, 8.0, -3.0, 8.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(-5.0, -6.0, -9.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(1, -3, 9)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(-9.0, 4.0, 4.0, -4.0, -5.0, 4.0, 9.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(-2.0, -3.0, 7.0, -4.0, 0.0, 4.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(6.0, 7.0, -6.0, 6.0, 0.0, -2.0, -2.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(-5.0, 9.0, 8.0, 9.0, 4.0, 9.0, 5.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(-6.0, 8.0, 8.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(0, -8, -8)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(1.0, 7.0, 9.0, -8.0, 2.0, 3.0, 6.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(-1.0, 3.0, 1.0, 3.0, -7.0, -7.0, 2.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(6.0, 0.0, -1.0, -7.0, -7.0, 3.0, 2.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(3.0, -4.0, 4.0, 5.0, -1.0, -8.0, -6.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(2.0, 0.0, -7.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(-9, 3, -2)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(-3.0, 1.0, 4.0, 2.0, 8.0, 2.0, -9.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(8.0, 8.0, 7.0, 0.0, 1.0, 7.0, -3.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(7.0, 7.0, -1.0, 0.0, 8.0, 2.0, -5.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(8.0, -5.0, -9.0, 7.0, -1.0, -8.0, -2.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(-5.0, -4.0, -6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(-7, -8, 3));
	block[0].s[0].b[0] = (mat3(-7.0, 9.0, 0.0, 5.0, 7.0, 9.0, 3.0, -5.0, -5.0));
	block[0].s[0].b[1] = (mat3(4.0, 3.0, -2.0, -3.0, -4.0, 1.0, 2.0, 1.0, -8.0));
	block[0].s[0].b[2] = (mat3(-8.0, -4.0, 4.0, 0.0, -5.0, 2.0, 0.0, 7.0, 9.0));
	block[0].s[0].b[3] = (mat3(-3.0, -5.0, 3.0, 6.0, 3.0, 5.0, 4.0, 3.0, -6.0));
	block[0].s[0].c = (vec4(4.0, -2.0, -1.0, 2.0));
	block[0].s[1].a = (ivec3(7, 5, 6));
	block[0].s[1].b[0] = (mat3(8.0, 4.0, -6.0, 1.0, 8.0, -6.0, -3.0, -8.0, 9.0));
	block[0].s[1].b[1] = (mat3(-8.0, 6.0, 2.0, -2.0, 4.0, -6.0, 6.0, -4.0, -1.0));
	block[0].s[1].b[2] = (mat3(3.0, 0.0, -7.0, -3.0, 7.0, -6.0, 8.0, -3.0, -5.0));
	block[0].s[1].b[3] = (mat3(7.0, -5.0, 3.0, 2.0, -9.0, -5.0, 9.0, -3.0, -1.0));
	block[0].s[1].c = (vec4(-6.0, 6.0, -1.0, 3.0));
	block[0].s[2].a = (ivec3(5, 4, 6));
	block[0].s[2].b[0] = (mat3(-2.0, 5.0, -1.0, 0.0, -2.0, -1.0, 4.0, 8.0, -2.0));
	block[0].s[2].b[1] = (mat3(-4.0, 9.0, -5.0, -5.0, -5.0, 4.0, -7.0, 5.0, 6.0));
	block[0].s[2].b[2] = (mat3(7.0, -9.0, -6.0, -7.0, -8.0, -7.0, -8.0, 0.0, -8.0));
	block[0].s[2].b[3] = (mat3(5.0, 5.0, -3.0, 6.0, 4.0, -1.0, -8.0, 8.0, -5.0));
	block[0].s[2].c = (vec4(6.0, 2.0, 0.0, 8.0));
	block[0].v = (vec4(3.0, 0.0, 3.0, -6.0));
	block[1].s[0].a = (ivec3(3, -6, -4));
	block[1].s[0].b[0] = (mat3(4.0, -4.0, -2.0, 0.0, 3.0, 2.0, -5.0, -8.0, -3.0));
	block[1].s[0].b[1] = (mat3(6.0, 7.0, 9.0, -1.0, -7.0, 4.0, -6.0, -5.0, 2.0));
	block[1].s[0].b[2] = (mat3(2.0, 1.0, 4.0, -8.0, -3.0, -1.0, -4.0, 5.0, 6.0));
	block[1].s[0].b[3] = (mat3(0.0, 4.0, 9.0, 2.0, -9.0, 6.0, 7.0, 1.0, 3.0));
	block[1].s[0].c = (vec4(7.0, 7.0, 6.0, 9.0));
	block[1].s[1].a = (ivec3(-7, -1, 4));
	block[1].s[1].b[0] = (mat3(5.0, 5.0, -8.0, 6.0, 1.0, -5.0, 4.0, 0.0, -1.0));
	block[1].s[1].b[1] = (mat3(-4.0, -1.0, 4.0, 4.0, -4.0, 3.0, -7.0, 8.0, 4.0));
	block[1].s[1].b[2] = (mat3(0.0, -4.0, -3.0, 5.0, 0.0, -8.0, -7.0, 6.0, 9.0));
	block[1].s[1].b[3] = (mat3(5.0, 6.0, -7.0, 8.0, -7.0, 1.0, 4.0, 4.0, 5.0));
	block[1].s[1].c = (vec4(6.0, -3.0, -8.0, 2.0));
	block[1].s[2].a = (ivec3(0, 6, 6));
	block[1].s[2].b[0] = (mat3(-4.0, 2.0, 6.0, -8.0, 2.0, -1.0, -2.0, 2.0, -4.0));
	block[1].s[2].b[1] = (mat3(-3.0, -5.0, -7.0, -9.0, 7.0, -8.0, -9.0, 1.0, 3.0));
	block[1].s[2].b[2] = (mat3(-5.0, -5.0, -7.0, 7.0, -3.0, -5.0, 4.0, 1.0, 9.0));
	block[1].s[2].b[3] = (mat3(9.0, 4.0, 2.0, -2.0, -9.0, 2.0, -8.0, -9.0, 2.0));
	block[1].s[2].c = (vec4(5.0, -5.0, -6.0, 1.0));
	block[1].v = (vec4(4.0, -1.0, -8.0, -2.0));
	block[2].s[0].a = (ivec3(-1, -9, 8));
	block[2].s[0].b[0] = (mat3(-2.0, 1.0, 8.0, -5.0, -8.0, 8.0, -8.0, -5.0, 2.0));
	block[2].s[0].b[1] = (mat3(-2.0, 9.0, 3.0, -4.0, 3.0, -9.0, -4.0, 9.0, -7.0));
	block[2].s[0].b[2] = (mat3(-8.0, 6.0, -2.0, -9.0, 3.0, -1.0, -1.0, 8.0, -1.0));
	block[2].s[0].b[3] = (mat3(-2.0, 0.0, -1.0, -4.0, -6.0, 6.0, 4.0, -5.0, 7.0));
	block[2].s[0].c = (vec4(-7.0, 6.0, 3.0, -6.0));
	block[2].s[1].a = (ivec3(-9, -8, 5));
	block[2].s[1].b[0] = (mat3(-7.0, 8.0, -3.0, 5.0, -7.0, 3.0, -9.0, 0.0, 2.0));
	block[2].s[1].b[1] = (mat3(-4.0, 7.0, 5.0, -9.0, -8.0, -1.0, -2.0, -4.0, 8.0));
	block[2].s[1].b[2] = (mat3(7.0, -5.0, 8.0, -5.0, -9.0, -1.0, -5.0, -4.0, -4.0));
	block[2].s[1].b[3] = (mat3(-7.0, 5.0, -5.0, -6.0, -5.0, 1.0, 1.0, 4.0, 5.0));
	block[2].s[1].c = (vec4(7.0, -3.0, -4.0, 1.0));
	block[2].s[2].a = (ivec3(-6, 3, -8));
	block[2].s[2].b[0] = (mat3(5.0, -8.0, 3.0, 8.0, 1.0, -5.0, 7.0, 9.0, 3.0));
	block[2].s[2].b[1] = (mat3(-4.0, 7.0, 1.0, 0.0, -9.0, 0.0, 3.0, 0.0, -7.0));
	block[2].s[2].b[2] = (mat3(9.0, -6.0, -5.0, 9.0, 9.0, 3.0, -8.0, -8.0, -3.0));
	block[2].s[2].b[3] = (mat3(-2.0, 8.0, -3.0, -9.0, -9.0, -9.0, -4.0, -7.0, 8.0));
	block[2].s[2].c = (vec4(-2.0, 8.0, 9.0, 6.0));
	block[2].v = (vec4(7.0, 7.0, 9.0, -2.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(1, -7, 5)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-3.0, -9.0, -7.0, -5.0, 1.0, -9.0, -1.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-8.0, 3.0, -4.0, 4.0, -1.0, -8.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-5.0, 0.0, -4.0, 6.0, 9.0, 1.0, 8.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-5.0, 3.0, -9.0, 6.0, -3.0, 8.0, -3.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(2.0, 1.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(-8.0, -4.0, -8.0, -9.0, -3.0, -1.0, -8.0, 0.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(-5, 3, 3)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(7.0, 8.0, 0.0, 5.0, 0.0, -2.0, -2.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(5.0, 1.0, 9.0, -9.0, 9.0, 2.0, -4.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(0.0, -9.0, 0.0, 5.0, -8.0, 2.0, 6.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(-9.0, 3.0, 7.0, -4.0, 1.0, 1.0, -4.0, 0.0, -4.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(-7.0, -8.0, -8.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(2, -8, -7)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(8.0, -9.0, 3.0, 0.0, 3.0, -2.0, -8.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-6.0, 0.0, -9.0, 5.0, -4.0, -9.0, 6.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-6.0, 7.0, 1.0, 0.0, 6.0, -2.0, -2.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(3.0, 6.0, 1.0, -7.0, -5.0, 6.0, 1.0, 1.0, -1.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-5.0, -4.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(-6.0, -6.0, 0.0, 8.0, 7.0, -7.0, 7.0, -6.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(3, 8, 6)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(-4.0, 3.0, 6.0, 5.0, -3.0, 1.0, -4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(9.0, 4.0, -6.0, -2.0, 2.0, 6.0, 2.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(-4.0, -9.0, 5.0, -6.0, 4.0, 2.0, 7.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(4.0, -3.0, -5.0, 8.0, 2.0, -1.0, 3.0, 0.0, 4.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(2.0, 8.0, 9.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-6, 7, -4)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(3.0, -4.0, -1.0, 3.0, -8.0, 0.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-8.0, -4.0, 0.0, -8.0, -5.0, -6.0, -6.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(8.0, 2.0, -2.0, -9.0, -7.0, 8.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(9.0, -7.0, 4.0, 0.0, 9.0, 9.0, 5.0, 2.0, -4.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(3.0, -4.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(-2.0, 5.0, -9.0, 0.0, -3.0, 2.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(0, 2, -1)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(2.0, 8.0, -6.0, 0.0, -3.0, 7.0, 9.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(-2.0, 2.0, -4.0, 3.0, -8.0, 5.0, 0.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(8.0, -7.0, 9.0, -8.0, -4.0, -6.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(-8.0, -1.0, 2.0, 6.0, 6.0, 6.0, 1.0, 2.0, -8.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(2.0, 4.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a[0] = (vec3(2.0, -1.0, -7.0));
	block[0].t.a[1] = (vec3(-5.0, -4.0, -8.0));
	block[0].t.a[2] = (vec3(-3.0, -6.0, -8.0));
	block[0].t.b.a = (ivec3(5, 5, 5));
	block[0].t.b.b[0][0] = (vec3(0.0, 9.0, -9.0));
	block[0].t.b.b[0][1] = (vec3(-5.0, 7.0, -7.0));
	block[0].t.b.b[0][2] = (vec3(8.0, 0.0, -1.0));
	block[0].t.b.b[1][0] = (vec3(3.0, 9.0, 1.0));
	block[0].t.b.b[1][1] = (vec3(1.0, -8.0, 7.0));
	block[0].t.b.b[1][2] = (vec3(8.0, 3.0, 4.0));
	block[0].t.b.b[2][0] = (vec3(7.0, 5.0, 6.0));
	block[0].t.b.b[2][1] = (vec3(4.0, 0.0, -1.0));
	block[0].t.b.b[2][2] = (vec3(-2.0, -7.0, -8.0));
	block[0].t.b.b[3][0] = (vec3(7.0, -9.0, 4.0));
	block[0].t.b.b[3][1] = (vec3(6.0, 3.0, 7.0));
	block[0].t.b.b[3][2] = (vec3(-6.0, 1.0, -5.0));
	block[0].t.b.c = (vec4(-4.0, 0.0, -6.0, 9.0));
	block[0].u = (2u);
	block[1].t.a[0] = (vec3(0.0, 8.0, 9.0));
	block[1].t.a[1] = (vec3(2.0, -4.0, -8.0));
	block[1].t.a[2] = (vec3(3.0, -3.0, -6.0));
	block[1].t.b.a = (ivec3(-3, -5, -9));
	block[1].t.b.b[0][0] = (vec3(9.0, -2.0, 1.0));
	block[1].t.b.b[0][1] = (vec3(-5.0, 0.0, 7.0));
	block[1].t.b.b[0][2] = (vec3(-2.0, -7.0, -7.0));
	block[1].t.b.b[1][0] = (vec3(5.0, -3.0, -2.0));
	block[1].t.b.b[1][1] = (vec3(-6.0, 3.0, -8.0));
	block[1].t.b.b[1][2] = (vec3(4.0, 2.0, -9.0));
	block[1].t.b.b[2][0] = (vec3(3.0, 2.0, -2.0));
	block[1].t.b.b[2][1] = (vec3(9.0, -8.0, -5.0));
	block[1].t.b.b[2][2] = (vec3(-8.0, -2.0, 8.0));
	block[1].t.b.b[3][0] = (vec3(7.0, 6.0, -4.0));
	block[1].t.b.b[3][1] = (vec3(3.0, 3.0, 3.0));
	block[1].t.b.b[3][2] = (vec3(-8.0, 3.0, -3.0));
	block[1].t.b.c = (vec4(-1.0, -4.0, 9.0, -7.0));
	block[1].u = (5u);
	block[2].t.a[0] = (vec3(-6.0, 0.0, -1.0));
	block[2].t.a[1] = (vec3(0.0, -7.0, -8.0));
	block[2].t.a[2] = (vec3(-9.0, 3.0, 4.0));
	block[2].t.b.a = (ivec3(-9, 2, 0));
	block[2].t.b.b[0][0] = (vec3(7.0, 7.0, 7.0));
	block[2].t.b.b[0][1] = (vec3(-8.0, 2.0, -4.0));
	block[2].t.b.b[0][2] = (vec3(-3.0, 0.0, 2.0));
	block[2].t.b.b[1][0] = (vec3(4.0, 6.0, -3.0));
	block[2].t.b.b[1][1] = (vec3(0.0, 2.0, 2.0));
	block[2].t.b.b[1][2] = (vec3(-8.0, -4.0, 2.0));
	block[2].t.b.b[2][0] = (vec3(0.0, -3.0, 1.0));
	block[2].t.b.b[2][1] = (vec3(9.0, -4.0, -9.0));
	block[2].t.b.b[2][2] = (vec3(-2.0, -9.0, -4.0));
	block[2].t.b.b[3][0] = (vec3(5.0, 2.0, 9.0));
	block[2].t.b.b[3][1] = (vec3(-6.0, -8.0, -5.0));
	block[2].t.b.b[3][2] = (vec3(9.0, 8.0, -8.0));
	block[2].t.b.c = (vec4(2.0, 0.0, 9.0, -4.0));
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
	allOk = compare_mat3(block[0].t[0].a, mat3(1.0, 5.0, 1.0, 8.0, 3.0, -8.0, 5.0, 3.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(-9, 3, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(-3, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(4, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(-3, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(-2, 3)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-7.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(-6, -1, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(3, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(-4, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(0, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(7, 9)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(8.0, 4.0, -3.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(-1, 9, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(7, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(9, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(-3, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(-9, 4)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-1.0, -3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(2.0, 4.0, 5.0, 6.0, 7.0, 1.0, -6.0, -4.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(5, -6, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(-5, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(1, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(0, 9)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(-3.0, 4.0, 4.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(4, 6, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(9, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(-8, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(3, -3)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(-7.0, -4.0, 7.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(-5, 9, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(-5, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(-6, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(7, 3)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(2.0, -7.0, -2.0, 6.0)) && allOk;
	allOk = compare_uint((block[0].u), 1u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(-9.0, 2.0, -8.0, 3.0, 0.0, 3.0, -9.0, -1.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(6, -6, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(1, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(-1, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(-9, 1)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(6.0, 3.0, 4.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(-6, 5, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(-3, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(9, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(-5, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(-4, 9)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-4.0, 0.0, 8.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(-9, -2, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(-9, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(-7, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(1, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(2, 6)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-2.0, 7.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(-4.0, 9.0, 6.0, -4.0, -4.0, 5.0, 3.0, 1.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(-4, -1, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(-7, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(2, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(-2, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(5, 9)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(5.0, -3.0, -3.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(4, -4, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(4, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(-1, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(-2, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(1, 8)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(0.0, 0.0, 6.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(-8, -2, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(-3, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(7, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(9, -9)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(-8.0, -4.0, -4.0, -8.0)) && allOk;
	allOk = compare_uint((block[1].u), 1u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(-1.0, -2.0, 4.0, 0.0, -8.0, -4.0, 0.0, 1.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(-5, -7, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(-1, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(-6, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(-6, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(-5, 4)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(9.0, -3.0, -5.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(7, -7, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(5, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(-7, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-1, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(-1, 4)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-3.0, 8.0, -5.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(-4, -3, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(-6, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(2, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(2, -6)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(2.0, -5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(1.0, 9.0, 6.0, -1.0, 7.0, 5.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(2, -3, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(-3, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(-4, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(-7, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(4, 5)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(-2.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(-5, 8, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(-3, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(1, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(8, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(5, -2)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(2.0, -2.0, -5.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(4, -3, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(3, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(-8, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(7, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(-2, 8)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(-2.0, -7.0, -3.0, 6.0)) && allOk;
	allOk = compare_uint((block[2].u), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-5, 2, -1));
	block[0].s.b[0] = (ivec2(-4, 1));
	block[0].s.b[1] = (ivec2(2, -2));
	block[0].s.b[2] = (ivec2(8, 7));
	block[0].s.b[3] = (ivec2(2, -4));
	block[0].s.c = (vec4(3.0, -4.0, 6.0, 7.0));
	block[0].u = (6u);
	block[1].s.a = (ivec3(-5, -9, -2));
	block[1].s.b[0] = (ivec2(-8, -5));
	block[1].s.b[1] = (ivec2(-9, -8));
	block[1].s.b[2] = (ivec2(1, -8));
	block[1].s.b[3] = (ivec2(-9, 5));
	block[1].s.c = (vec4(-4.0, 1.0, -7.0, 5.0));
	block[1].u = (6u);
	block[2].s.a = (ivec3(-8, 5, 4));
	block[2].s.b[0] = (ivec2(-9, -7));
	block[2].s.b[1] = (ivec2(-9, -2));
	block[2].s.b[2] = (ivec2(9, -6));
	block[2].s.b[3] = (ivec2(-3, 6));
	block[2].s.c = (vec4(3.0, -8.0, -5.0, -8.0));
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
	allOk = compare_uvec2((block.s[0].a), uvec2(8u, 2u)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[0], mat2x4(5.0, -3.0, -2.0, -3.0, -7.0, 7.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[1], mat2x4(8.0, 8.0, 1.0, -5.0, -8.0, -8.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[2], mat2x4(8.0, -8.0, -7.0, 8.0, -2.0, -6.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[3], mat2x4(6.0, 9.0, 9.0, 9.0, -7.0, -1.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec3((block.s[0].c), vec3(9.0, -9.0, -9.0)) && allOk;
	allOk = compare_uvec2((block.s[1].a), uvec2(3u, 6u)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[0], mat2x4(1.0, 5.0, -1.0, -5.0, -4.0, 9.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[1], mat2x4(4.0, -5.0, -7.0, -7.0, -6.0, -8.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[2], mat2x4(7.0, -1.0, -5.0, 4.0, 0.0, 6.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[3], mat2x4(6.0, 0.0, 4.0, 5.0, 9.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec3((block.s[1].c), vec3(-5.0, 8.0, 3.0)) && allOk;
	allOk = compare_uvec2((block.s[2].a), uvec2(2u, 5u)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[0], mat2x4(8.0, -7.0, -2.0, 4.0, -2.0, 9.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[1], mat2x4(-8.0, 5.0, 4.0, 9.0, -3.0, 5.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[2], mat2x4(0.0, -6.0, 6.0, -2.0, -8.0, 9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[3], mat2x4(9.0, 5.0, 6.0, 1.0, 9.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_vec3((block.s[2].c), vec3(3.0, -8.0, 6.0)) && allOk;
	allOk = compare_uvec2((block.s[3].a), uvec2(6u, 4u)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[0], mat2x4(-1.0, 9.0, -4.0, -9.0, -3.0, -3.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[1], mat2x4(-4.0, 3.0, 8.0, 1.0, 6.0, 1.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[2], mat2x4(9.0, -2.0, -3.0, -3.0, -2.0, 8.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[3], mat2x4(6.0, -6.0, -3.0, -6.0, 0.0, -3.0, -1.0, 8.0)) && allOk;
	allOk = compare_vec3((block.s[3].c), vec3(5.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (5u);
	block.s[0].a = (uvec2(8u, 1u));
	block.s[0].b[0][0] = (vec4(-5.0, 1.0, 8.0, -2.0));
	block.s[0].b[0][1] = (vec4(-1.0, -5.0, -4.0, -2.0));
	block.s[0].b[1][0] = (vec4(0.0, 2.0, 6.0, 8.0));
	block.s[0].b[1][1] = (vec4(8.0, 8.0, 9.0, 9.0));
	block.s[0].b[2][0] = (vec4(-4.0, 4.0, -1.0, -8.0));
	block.s[0].b[2][1] = (vec4(7.0, 3.0, -6.0, 4.0));
	block.s[0].b[3][0] = (vec4(-9.0, -1.0, 8.0, 7.0));
	block.s[0].b[3][1] = (vec4(2.0, 7.0, -5.0, 3.0));
	block.s[0].c = (vec3(5.0, 9.0, -2.0));
	block.s[1].a = (uvec2(3u, 2u));
	block.s[1].b[0][0] = (vec4(-9.0, 7.0, -2.0, -2.0));
	block.s[1].b[0][1] = (vec4(9.0, 3.0, -8.0, -5.0));
	block.s[1].b[1][0] = (vec4(2.0, 9.0, 4.0, -2.0));
	block.s[1].b[1][1] = (vec4(-1.0, -6.0, -1.0, 1.0));
	block.s[1].b[2][0] = (vec4(-4.0, 6.0, 5.0, -4.0));
	block.s[1].b[2][1] = (vec4(4.0, -1.0, 1.0, -5.0));
	block.s[1].b[3][0] = (vec4(-4.0, -9.0, 1.0, -3.0));
	block.s[1].b[3][1] = (vec4(-1.0, 1.0, 2.0, -7.0));
	block.s[1].c = (vec3(-2.0, -3.0, -7.0));
	block.s[2].a = (uvec2(9u, 3u));
	block.s[2].b[0][0] = (vec4(-3.0, -9.0, -3.0, 0.0));
	block.s[2].b[0][1] = (vec4(4.0, 5.0, -8.0, 6.0));
	block.s[2].b[1][0] = (vec4(5.0, -3.0, 2.0, 0.0));
	block.s[2].b[1][1] = (vec4(1.0, 6.0, -2.0, -7.0));
	block.s[2].b[2][0] = (vec4(3.0, -6.0, -2.0, 2.0));
	block.s[2].b[2][1] = (vec4(5.0, -9.0, 3.0, -7.0));
	block.s[2].b[3][0] = (vec4(8.0, 5.0, -6.0, 4.0));
	block.s[2].b[3][1] = (vec4(1.0, -9.0, 6.0, 5.0));
	block.s[2].c = (vec3(-3.0, -6.0, -7.0));
	block.s[3].a = (uvec2(2u, 6u));
	block.s[3].b[0][0] = (vec4(-1.0, -5.0, 4.0, 8.0));
	block.s[3].b[0][1] = (vec4(2.0, 1.0, 2.0, -9.0));
	block.s[3].b[1][0] = (vec4(-5.0, -6.0, 1.0, 7.0));
	block.s[3].b[1][1] = (vec4(-8.0, 3.0, 0.0, -9.0));
	block.s[3].b[2][0] = (vec4(-8.0, -7.0, 5.0, -7.0));
	block.s[3].b[2][1] = (vec4(1.0, 3.0, -9.0, 8.0));
	block.s[3].b[3][0] = (vec4(5.0, -6.0, -7.0, 6.0));
	block.s[3].b[3][1] = (vec4(-7.0, 1.0, 8.0, -8.0));
	block.s[3].c = (vec3(-6.0, 8.0, 8.0));
}
#version 450
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
    Block block[3];
};

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
layout(std430, buffer_reference) buffer Block
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
	allOk = compare_uint((block.u), 4u) && allOk;
	allOk = compare_mat4x3(block.t[0].a, mat4x3(-4.0, 7.0, 5.0, -8.0, -8.0, -3.0, 0.0, -4.0, 9.0, 1.0, -6.0, 4.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[0].a), uvec3(2u, 4u, 7u)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[0]), vec2(9.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[1]), vec2(-1.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[2]), vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[3]), vec2(-5.0, -5.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(-9.0, -1.0, 1.0, -8.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[1].a), uvec3(5u, 8u, 2u)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[0]), vec2(4.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[1]), vec2(1.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[2]), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[3]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(-1.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[2].a), uvec3(8u, 2u, 3u)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[0]), vec2(5.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[1]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[2]), vec2(-1.0, 5.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[3]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(-3.0, -5.0, 9.0, 6.0)) && allOk;
	allOk = compare_int((block.t[0].c), -2) && allOk;
	allOk = compare_mat4x3(block.t[1].a, mat4x3(-9.0, 3.0, -7.0, -4.0, -4.0, -1.0, 6.0, -1.0, -3.0, -4.0, -8.0, -7.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[0].a), uvec3(5u, 0u, 5u)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[0]), vec2(-6.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[1]), vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[2]), vec2(-4.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[3]), vec2(7.0, -1.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(-1.0, -6.0, -3.0, -6.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[1].a), uvec3(2u, 9u, 7u)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[0]), vec2(5.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[1]), vec2(2.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[2]), vec2(7.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[3]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(9.0, 1.0, -7.0, 8.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[2].a), uvec3(8u, 5u, 1u)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[0]), vec2(-5.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[1]), vec2(2.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[2]), vec2(-7.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[3]), vec2(6.0, 8.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(-3.0, 3.0, -8.0, -5.0)) && allOk;
	allOk = compare_int((block.t[1].c), -6) && allOk;
	allOk = compare_mat4x3(block.t[2].a, mat4x3(-8.0, -6.0, 3.0, -4.0, 1.0, 1.0, -7.0, 9.0, -9.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[0].a), uvec3(1u, 1u, 4u)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[0]), vec2(6.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[1]), vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[2]), vec2(-4.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[3]), vec2(4.0, 1.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[0].c), vec4(-4.0, -3.0, -8.0, 5.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[1].a), uvec3(2u, 8u, 1u)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[0]), vec2(7.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[1]), vec2(-2.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[2]), vec2(3.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[3]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[1].c), vec4(7.0, -8.0, 0.0, 2.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[2].a), uvec3(8u, 3u, 7u)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[0]), vec2(5.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[1]), vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[2]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[3]), vec2(5.0, -2.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[2].c), vec4(-1.0, 3.0, -9.0, -1.0)) && allOk;
	allOk = compare_int((block.t[2].c), -5) && allOk;
	allOk = compare_mat4x3(block.t[3].a, mat4x3(3.0, -1.0, -5.0, -6.0, 0.0, -7.0, 8.0, -3.0, 1.0, -5.0, 8.0, 7.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[0].a), uvec3(1u, 6u, 9u)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[0]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[1]), vec2(-1.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[2]), vec2(-3.0, 1.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[3]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[0].c), vec4(3.0, 6.0, -9.0, 9.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[1].a), uvec3(2u, 9u, 6u)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[0]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[1]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[2]), vec2(7.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[3]), vec2(9.0, -8.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[1].c), vec4(3.0, -9.0, -3.0, -4.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[2].a), uvec3(4u, 6u, 7u)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[0]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[1]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[2]), vec2(-7.0, 1.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[3]), vec2(-6.0, 7.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[2].c), vec4(7.0, 4.0, 6.0, -9.0)) && allOk;
	allOk = compare_int((block.t[3].c), -3) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (uvec3(6u, 3u, 3u));
	block.s.b[0] = (vec2(-6.0, -2.0));
	block.s.b[1] = (vec2(4.0, -5.0));
	block.s.b[2] = (vec2(-9.0, -7.0));
	block.s.b[3] = (vec2(-1.0, 2.0));
	block.s.c = (vec4(2.0, -5.0, 0.0, -7.0));
	block.u = (0u);
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(block[0].var, mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	block[1].var = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	block[2].var = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	u16vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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

layout(scalar, buffer_reference) buffer Block
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

layout(scalar, row_major, buffer_reference) buffer Block
{
	float padding;
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

layout(scalar, row_major, buffer_reference) buffer Block
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
	allOk = compare_float((block[0].padding), 1.0) && allOk;
	allOk = compare_mat2x3(block[0].var, mat2x3(-6.0, 2.0, 1.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_float((block[1].padding), -2.0) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(-9.0, -8.0, -7.0, 7.0, -9.0, -6.0)) && allOk;
	allOk = compare_float((block[2].padding), -2.0) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(5.0, -6.0, -2.0, 0.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-7.0);
	block[0].var[0] = (vec3(-6.0, -3.0, -4.0));
	block[0].var[1] = (vec3(-8.0, 7.0, 3.0));
	block[1].padding = (-2.0);
	block[1].var[0] = (vec3(-8.0, -9.0, 6.0));
	block[1].var[1] = (vec3(5.0, 6.0, 1.0));
	block[2].padding = (-5.0);
	block[2].var[0] = (vec3(1.0, -3.0, 5.0));
	block[2].var[1] = (vec3(-7.0, 9.0, -7.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -4.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 4.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][1], -6.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(0.0, -5.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(0.0, -1.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-4.0, 4.0)) && allOk;
	allOk = compare_vec2(block[0].var[3], vec2(6.0, -6.0)) && allOk;
	allOk = compare_float((block[1].padding), 4.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 5.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-1.0, 1.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(-1.0, -8.0)) && allOk;
	allOk = compare_vec2(block[1].var[3], vec2(0.0, 5.0)) && allOk;
	allOk = compare_float((block[2].padding), 9.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 4.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-3.0, -4.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-1.0, -5.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(4.0, 3.0)) && allOk;
	allOk = compare_vec2(block[2].var[3], vec2(-2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (1.0);
	block[0].var = (mat4x2(-9.0, 4.0, 1.0, -5.0, 2.0, -5.0, 8.0, 8.0));
	block[1].padding = (8.0);
	block[1].var = (mat4x2(2.0, -6.0, 3.0, 8.0, -8.0, 8.0, 3.0, -3.0));
	block[2].padding = (-2.0);
	block[2].var = (mat4x2(-1.0, 6.0, 9.0, -5.0, -9.0, -1.0, 6.0, 0.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -1.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 1.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 7.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(5.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-9.0, 5.0, 0.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(8.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(-7.0, 8.0, 7.0)) && allOk;
	allOk = compare_float((block[1].padding), 0.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 1.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -2.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-6.0, 8.0, 8.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-7.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-9.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(-8.0, -3.0, -2.0)) && allOk;
	allOk = compare_float((block[2].padding), 9.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 7.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -5.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -7.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-2.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(0.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(4.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(8.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-2.0);
	block[0].var = (mat4x3(4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0, 9.0, 6.0, -8.0));
	block[1].padding = (9.0);
	block[1].var = (mat4x3(4.0, -7.0, 6.0, -7.0, 9.0, 6.0, -2.0, 9.0, 6.0, 6.0, -2.0, 9.0));
	block[2].padding = (-3.0);
	block[2].var = (mat4x3(9.0, 9.0, -3.0, 8.0, 8.0, -7.0, -6.0, 5.0, -9.0, 9.0, -5.0, 8.0));
}
#version 450
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
	i16vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block[0].padding), -6) && allOk;
	allOk = compare_i16vec4(ivec4(block[0].var), ivec4(-9, 9, 8, -1)) && allOk;
	allOk = compare_int16_t(int(block[1].padding), -8) && allOk;
	allOk = compare_i16vec4(ivec4(block[1].var), ivec4(8, 9, 3, 4)) && allOk;
	allOk = compare_int16_t(int(block[2].padding), 0) && allOk;
	allOk = compare_i16vec4(ivec4(block[2].var), ivec4(9, -2, -4, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = int16_t(-4);
	block[0].var = i16vec4(ivec4(-8, -4, 9, 2));
	block[1].padding = int16_t(7);
	block[1].var = i16vec4(ivec4(-4, 4, 8, 9));
	block[2].padding = int16_t(5);
	block[2].var = i16vec4(ivec4(1, -3, 3, 8));
}
#version 450
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
	allOk = compare_float((blockA.a), -4.0) && allOk;
	allOk = compare_mat2(blockA.c, mat2(-7.0, 6.0, -3.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(1, -4)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-8.0);
	blockB.a[0] = (vec3(-7.0, -1.0, 2.0));
	blockB.a[1] = (vec3(2.0, -5.0, 0.0));
	blockB.a[2] = (vec3(-7.0, 9.0, 9.0));
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
	allOk = compare_float((blockA.a), -3.0) && allOk;
	allOk = compare_uint((blockB.b.a), 4u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(3.0, -1.0, -9.0, 7.0, 1.0, 1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(5, -6)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(0, -4)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(-7, 0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(2, -5)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(-2.0, 1.0, 2.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (4.0);
	blockA.b.a = (mat3(1.0, 5.0, -4.0, 6.0, -4.0, -7.0, -1.0, -7.0, 1.0));
	blockA.b.b[0] = (ivec2(-9, -4));
	blockA.b.b[1] = (ivec2(-7, -5));
	blockA.b.b[2] = (ivec2(-4, -3));
	blockA.b.b[3] = (ivec2(-9, 3));
	blockA.b.c = (vec4(5.0, -9.0, 5.0, 2.0));
	blockB.a = (mat2(3.0, -7.0, -9.0, 4.0));
	blockB.b.a = (9u);
	blockB.b.b.a = (mat3(-6.0, 1.0, -9.0, -5.0, -7.0, 0.0, 0.0, -4.0, 2.0));
	blockB.b.b.b[0] = (ivec2(-8, -5));
	blockB.b.b.b[1] = (ivec2(2, 4));
	blockB.b.b.b[2] = (ivec2(-8, -4));
	blockB.b.b.b[3] = (ivec2(-8, 7));
	blockB.b.b.c = (vec4(9.0, 1.0, 5.0, -2.0));
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

layout(std430, buffer_reference) buffer BlockB
{
	highp uint a;
	lowp float b;
	bool c;
	lowp float d;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump float e;
	lowp float f;
	highp int g;
	bool h;
};
layout(std140, buffer_reference) buffer BlockD
{
	bool i;
	bool j;
	lowp uint k;
	bool l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 5u) && allOk;
	allOk = compare_float((blockB.b), -3.0) && allOk;
	allOk = compare_bool((blockB.c), true) && allOk;
	allOk = compare_float((blockB.d), -5.0) && allOk;
	allOk = compare_float((blockC.e), 2.0) && allOk;
	allOk = compare_int((blockC.g), -8) && allOk;
	allOk = compare_bool((blockD.i), false) && allOk;
	allOk = compare_bool((blockD.j), true) && allOk;
	allOk = compare_uint((blockD.k), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (-2.0);
	blockB.c = (true);
	blockC.e = (2.0);
	blockC.f = (-8.0);
	blockC.h = (false);
	blockD.i = (true);
	blockD.j = (true);
	blockD.k = (2u);
	blockD.l = (true);
}
#version 450
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
	lowp uint a;
	mediump uvec4 b;
};
layout(std140, buffer_reference) buffer BlockC
{
	highp ivec4 c;
	highp ivec2 d;
	mediump ivec3 e;
	bvec4 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockC.c), ivec4(-5, -4, -5, -3)) && allOk;
	allOk = compare_ivec2((blockC.d), ivec2(-2, -3)) && allOk;
	allOk = compare_bvec4((blockC.f), bvec4(false, true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (4u);
	blockB.b = (uvec4(1u, 0u, 4u, 9u));
	blockC.c = (ivec4(-1, 9, -4, -4));
	blockC.d = (ivec2(3, -7));
	blockC.e = (ivec3(-4, 0, -7));
	blockC.f = (bvec4(false, false, false, true));
}
#version 450
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
	mediump mat3x2 a;
	lowp mat4 b[6];
	bvec3 c[];
};
layout(std140, buffer_reference) buffer BlockC
{
	bool d;
	lowp mat2 e;
	bvec2 f;
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump mat2 g;
	highp int h[2];
};
layout(std430, buffer_reference) buffer BlockE
{
	lowp mat2 i[];
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.b[0], mat4(7.0, -2.0, 3.0, 9.0, 1.0, -5.0, -2.0, 0.0, 9.0, -1.0, -9.0, -6.0, -9.0, 6.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(blockB.b[1], mat4(0.0, 2.0, 5.0, 6.0, 4.0, 1.0, -7.0, -5.0, 1.0, 2.0, -7.0, 5.0, -6.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(blockB.b[2], mat4(-5.0, 9.0, -9.0, -2.0, 6.0, -7.0, 8.0, 3.0, 9.0, 7.0, 9.0, 7.0, 3.0, -3.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB.b[3], mat4(-8.0, -3.0, -3.0, -3.0, 3.0, 3.0, 2.0, 3.0, 1.0, 9.0, -4.0, 4.0, 8.0, 2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat4(blockB.b[4], mat4(-1.0, -9.0, -8.0, -2.0, 1.0, 1.0, -7.0, -9.0, -6.0, 4.0, 0.0, -3.0, -3.0, 9.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat4(blockB.b[5], mat4(-9.0, -7.0, -2.0, -6.0, 0.0, 5.0, 8.0, 5.0, 5.0, 3.0, 2.0, -8.0, 5.0, -7.0, 6.0, -9.0)) && allOk;
	allOk = compare_bvec3((blockB.c[0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.c[1]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.c[2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.c[3]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.c[4]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.c[5]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockB.c[6]), bvec3(true, false, false)) && allOk;
	allOk = compare_mat2(blockC.e, mat2(-2.0, 5.0, 6.0, 1.0)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(false, true)) && allOk;
	allOk = compare_mat2(blockE.i[0], mat2(-3.0, -1.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2(blockE.i[1], mat2(-1.0, 8.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2(blockE.i[2], mat2(8.0, 2.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2(blockE.i[3], mat2(5.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat2(blockE.i[4], mat2(0.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2(blockE.i[5], mat2(1.0, -7.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.d = (true);
	blockC.e = (mat2(-4.0, -6.0, -7.0, 1.0));
	blockD.g = (mat2(3.0, -3.0, -3.0, -4.0));
	blockD.h[0] = (3);
	blockD.h[1] = (0);
	blockE.i[0] = (mat2(3.0, -5.0, 8.0, 9.0));
	blockE.i[1] = (mat2(2.0, -9.0, 8.0, 6.0));
	blockE.i[2] = (mat2(-9.0, -3.0, 9.0, 3.0));
	blockE.i[3] = (mat2(0.0, -9.0, 7.0, 8.0));
	blockE.i[4] = (mat2(-5.0, -1.0, -5.0, 6.0));
	blockE.i[5] = (mat2(-7.0, -4.0, -1.0, 6.0));
}
#version 450
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
	mediump mat3x2 a;
	bvec4 b;
	mediump mat3 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(4.0, -1.0, 1.0, 6.0, 1.0, 9.0)) && allOk;
	allOk = compare_bvec4((blockB.b), bvec4(true, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(5.0, 7.0, -9.0, -6.0, 1.0, -2.0));
	blockB.c[0] = (mat3(-4.0, 3.0, 4.0, 9.0, 1.0, 2.0, -6.0, 5.0, 9.0));
	blockB.c[1] = (mat3(2.0, -1.0, -7.0, 3.0, -7.0, -5.0, 7.0, 5.0, 5.0));
	blockB.c[2] = (mat3(7.0, -3.0, 2.0, -2.0, 9.0, 5.0, 7.0, -5.0, 9.0));
	blockB.c[3] = (mat3(-3.0, 8.0, -3.0, 7.0, -4.0, -9.0, -2.0, 9.0, 7.0));
	blockB.c[4] = (mat3(8.0, -1.0, 5.0, -4.0, 9.0, -2.0, -5.0, -8.0, -4.0));
	blockB.c[5] = (mat3(0.0, 8.0, 2.0, 6.0, 3.0, -7.0, -9.0, -2.0, -9.0));
}
#version 450
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
	lowp mat4 a;
	mediump ivec3 b;
	highp mat4x2 c;
	bool d;
};
layout(std430, row_major, buffer_reference) readonly buffer BlockC
{
	highp ivec4 e;
	lowp mat3x2 f;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	highp mat3 g;
	highp uint h;
	mediump vec3 i;
	bool j[];
};
layout(std430, buffer_reference) buffer BlockE
{
	mediump mat3 k[4];
	mediump ivec2 l;
	lowp mat3x2 m;
	bool n;
	bvec2 o[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.b), ivec3(-8, -6, -1)) && allOk;
	allOk = compare_mat4x2(blockB.c, mat4x2(-8.0, -7.0, 7.0, 0.0, 9.0, -6.0, 5.0, -2.0)) && allOk;
	allOk = compare_ivec4((blockC.e), ivec4(-6, 5, 3, 3)) && allOk;
	allOk = compare_mat3x2(blockC.f, mat3x2(-9.0, 5.0, 4.0, -4.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3(blockD.g, mat3(-1.0, 4.0, -2.0, -5.0, -9.0, -7.0, 6.0, -3.0, 6.0)) && allOk;
	allOk = compare_uint((blockD.h), 9u) && allOk;
	allOk = compare_vec3((blockD.i), vec3(1.0, -3.0, 4.0)) && allOk;
	allOk = compare_bool((blockD.j[0]), false) && allOk;
	allOk = compare_bool((blockD.j[1]), false) && allOk;
	allOk = compare_bool((blockD.j[2]), true) && allOk;
	allOk = compare_bool((blockD.j[3]), true) && allOk;
	allOk = compare_bool((blockD.j[4]), false) && allOk;
	allOk = compare_mat3x2(blockE.m, mat3x2(-6.0, -7.0, 8.0, -6.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec3(-7, -8, -3));
	blockB.c = (mat4x2(6.0, 5.0, -2.0, -1.0, -4.0, -8.0, 2.0, 0.0));
	blockB.d = (true);
	blockD.g = (mat3(1.0, 7.0, -9.0, 2.0, 7.0, 0.0, -8.0, -4.0, -2.0));
	blockD.h = (6u);
	blockD.i = (vec3(-2.0, 0.0, -4.0));
	blockE.m = (mat3x2(-3.0, 4.0, -3.0, -5.0, -9.0, 4.0));
}
#version 450
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
	mediump uvec3 a;
	lowp int b;
	bvec4 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a), uvec3(5u, 4u, 9u)) && allOk;
	allOk = compare_bvec4((blockB[0].c[0]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_uvec3((blockB[1].a), uvec3(2u, 5u, 5u)) && allOk;
	allOk = compare_bvec4((blockB[1].c[0]), bvec4(true, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (uvec3(3u, 1u, 6u));
	blockB[0].c[0] = (bvec4(true, true, false, true));
	blockB[1].a = (uvec3(7u, 9u, 6u));
	blockB[1].c[0] = (bvec4(true, false, false, false));
}
#version 450
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
	mediump mat4x2 mA;
	highp ivec3 mB;
	lowp mat3 mC;
	highp vec3 mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	mediump mat3x4 a;
	sA b;
	lowp uint c;
	mediump ivec2 d;
	lowp mat2x3 e[];
};
layout(std430, buffer_reference) buffer BlockC
{
	bvec3 f;
	lowp vec3 g;
	mediump int h;
	lowp ivec4 i;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	highp uvec4 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[0].a, mat3x4(2.0, -8.0, -4.0, 7.0, 4.0, 0.0, -5.0, -8.0, -6.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].b.mA, mat4x2(-6.0, 1.0, 8.0, 1.0, -7.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockB[0].b.mB), ivec3(5, -9, -8)) && allOk;
	allOk = compare_mat3(blockB[0].b.mC, mat3(6.0, 2.0, 3.0, -7.0, -8.0, 9.0, -9.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB[0].b.mD), vec3(3.0, 6.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockB[0].d), ivec2(6, -4)) && allOk;
	allOk = compare_mat3x4(blockB[1].a, mat3x4(8.0, 6.0, -2.0, 2.0, 3.0, 7.0, 5.0, 9.0, -1.0, 7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockB[1].b.mA, mat4x2(-9.0, -4.0, -9.0, -2.0, 6.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_ivec3((blockB[1].b.mB), ivec3(8, 2, 4)) && allOk;
	allOk = compare_mat3(blockB[1].b.mC, mat3(9.0, 5.0, -7.0, 7.0, 0.0, 0.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_vec3((blockB[1].b.mD), vec3(-8.0, 6.0, -6.0)) && allOk;
	allOk = compare_ivec2((blockB[1].d), ivec2(0, -4)) && allOk;
	allOk = compare_bvec3((blockC.f), bvec3(true, false, true)) && allOk;
	allOk = compare_vec3((blockC.g), vec3(4.0, -9.0, 9.0)) && allOk;
	allOk = compare_int((blockC.h), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat3x4(8.0, -2.0, -1.0, -6.0, 6.0, 0.0, 9.0, 5.0, 4.0, 8.0, 6.0, 7.0));
	blockB[0].c = (2u);
	blockB[0].d = (ivec2(-7, -1));
	blockB[0].e[0] = (mat2x3(4.0, -7.0, 2.0, -1.0, 4.0, -6.0));
	blockB[0].e[1] = (mat2x3(5.0, -5.0, -1.0, -2.0, -3.0, -7.0));
	blockB[0].e[2] = (mat2x3(8.0, -6.0, 7.0, 9.0, 8.0, -3.0));
	blockB[0].e[3] = (mat2x3(-4.0, 4.0, 9.0, 0.0, 1.0, 2.0));
	blockB[0].e[4] = (mat2x3(-3.0, -9.0, -9.0, 0.0, -6.0, -8.0));
	blockB[0].e[5] = (mat2x3(4.0, -1.0, -8.0, -9.0, 0.0, 0.0));
	blockB[0].e[6] = (mat2x3(9.0, -9.0, 4.0, 7.0, 6.0, 6.0));
	blockB[1].a = (mat3x4(-5.0, -4.0, 3.0, -5.0, -2.0, 0.0, -5.0, 2.0, 9.0, -4.0, 4.0, -2.0));
	blockB[1].c = (7u);
	blockB[1].d = (ivec2(-7, -4));
	blockB[1].e[0] = (mat2x3(-6.0, 5.0, 3.0, -1.0, 0.0, 4.0));
	blockB[1].e[1] = (mat2x3(4.0, -4.0, -3.0, 8.0, 7.0, -6.0));
	blockB[1].e[2] = (mat2x3(1.0, 1.0, 6.0, 2.0, 2.0, -3.0));
	blockB[1].e[3] = (mat2x3(-5.0, 3.0, 0.0, -7.0, 6.0, 3.0));
	blockB[1].e[4] = (mat2x3(2.0, -2.0, 8.0, -5.0, -9.0, -5.0));
	blockB[1].e[5] = (mat2x3(2.0, 4.0, 3.0, -1.0, 4.0, -5.0));
	blockB[1].e[6] = (mat2x3(-4.0, 3.0, -9.0, -5.0, 2.0, -3.0));
	blockC.f = (bvec3(true, true, false));
	blockD.j[0] = (uvec4(5u, 4u, 3u, 1u));
	blockD.j[1] = (uvec4(2u, 1u, 5u, 5u));
	blockD.j[2] = (uvec4(6u, 1u, 6u, 7u));
	blockD.j[3] = (uvec4(4u, 2u, 1u, 4u));
	blockD.j[4] = (uvec4(4u, 1u, 8u, 4u));
}
#version 450
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
	mediump uvec4 a;
	lowp mat4 b;
	highp mat3 c;
	highp uvec3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(9u, 7u, 5u, 2u)) && allOk;
	allOk = compare_mat3(blockB.c, mat3(4.0, -6.0, -6.0, 7.0, 8.0, -5.0, 2.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(7u, 1u, 5u, 1u));
	blockB.b = (mat4(3.0, 9.0, 4.0, -2.0, 5.0, 3.0, 1.0, 4.0, -1.0, -7.0, 7.0, -2.0, 2.0, -7.0, -3.0, 3.0));
}
#version 450
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
	highp int mA[5];
	mediump mat3x4 mB;
	highp mat2 mC;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	mediump mat4x2 a;
	lowp mat4x2 b;
	sA c[3];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(2.0, 4.0, -3.0, 6.0, 2.0, -2.0, -4.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(8.0, 0.0, 7.0, 5.0, -2.0, 9.0, 6.0, -5.0));
	blockB.c[0].mA[0] = (-7);
	blockB.c[0].mA[1] = (-2);
	blockB.c[0].mA[2] = (-4);
	blockB.c[0].mA[3] = (-2);
	blockB.c[0].mA[4] = (4);
	blockB.c[0].mB = (mat3x4(3.0, -2.0, 3.0, -6.0, 0.0, 3.0, 2.0, -8.0, 9.0, -3.0, 2.0, -6.0));
	blockB.c[0].mC = (mat2(3.0, -2.0, -1.0, 1.0));
	blockB.c[1].mA[0] = (-2);
	blockB.c[1].mA[1] = (3);
	blockB.c[1].mA[2] = (0);
	blockB.c[1].mA[3] = (-8);
	blockB.c[1].mA[4] = (6);
	blockB.c[1].mB = (mat3x4(4.0, 7.0, -2.0, -1.0, -7.0, -3.0, -4.0, 4.0, -9.0, -1.0, 3.0, -2.0));
	blockB.c[1].mC = (mat2(2.0, 2.0, -4.0, -8.0));
	blockB.c[2].mA[0] = (-7);
	blockB.c[2].mA[1] = (4);
	blockB.c[2].mA[2] = (6);
	blockB.c[2].mA[3] = (-2);
	blockB.c[2].mA[4] = (-5);
	blockB.c[2].mB = (mat3x4(9.0, -5.0, 2.0, 7.0, -2.0, -8.0, -2.0, 3.0, 8.0, 9.0, -2.0, 7.0));
	blockB.c[2].mC = (mat2(-6.0, -5.0, 2.0, -6.0));
}
#version 450
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
	layout(offset = 4) highp uvec3 b;
	layout(offset = 16) highp ivec4 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.b), uvec3(0u, 2u, 5u)) && allOk;
	allOk = compare_ivec4((blockB.c), ivec4(-4, 0, -7, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = (uvec3(4u, 9u, 5u));
}
#version 450
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
	lowp uvec2 mA;
	lowp uvec3 mB;
	lowp uvec4 mC;
	bvec3 mD;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	sA a[][5];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a[0][0].mA), uvec2(2u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.a[0][0].mB), uvec3(8u, 6u, 9u)) && allOk;
	allOk = compare_uvec4((blockB.a[0][0].mC), uvec4(7u, 9u, 2u, 7u)) && allOk;
	allOk = compare_bvec3((blockB.a[0][0].mD), bvec3(false, true, true)) && allOk;
	allOk = compare_uvec2((blockB.a[0][1].mA), uvec2(5u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.a[0][1].mB), uvec3(7u, 9u, 3u)) && allOk;
	allOk = compare_uvec4((blockB.a[0][1].mC), uvec4(2u, 4u, 6u, 4u)) && allOk;
	allOk = compare_bvec3((blockB.a[0][1].mD), bvec3(true, true, true)) && allOk;
	allOk = compare_uvec2((blockB.a[0][2].mA), uvec2(1u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.a[0][2].mB), uvec3(9u, 4u, 9u)) && allOk;
	allOk = compare_uvec4((blockB.a[0][2].mC), uvec4(4u, 3u, 1u, 2u)) && allOk;
	allOk = compare_bvec3((blockB.a[0][2].mD), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec2((blockB.a[0][3].mA), uvec2(9u, 6u)) && allOk;
	allOk = compare_uvec3((blockB.a[0][3].mB), uvec3(7u, 7u, 2u)) && allOk;
	allOk = compare_uvec4((blockB.a[0][3].mC), uvec4(4u, 9u, 7u, 0u)) && allOk;
	allOk = compare_bvec3((blockB.a[0][3].mD), bvec3(false, true, true)) && allOk;
	allOk = compare_uvec2((blockB.a[0][4].mA), uvec2(7u, 4u)) && allOk;
	allOk = compare_uvec3((blockB.a[0][4].mB), uvec3(8u, 5u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.a[0][4].mC), uvec4(7u, 4u, 3u, 5u)) && allOk;
	allOk = compare_bvec3((blockB.a[0][4].mD), bvec3(true, false, true)) && allOk;
	allOk = compare_uvec2((blockB.a[1][0].mA), uvec2(3u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.a[1][0].mB), uvec3(9u, 7u, 3u)) && allOk;
	allOk = compare_uvec4((blockB.a[1][0].mC), uvec4(2u, 2u, 6u, 5u)) && allOk;
	allOk = compare_bvec3((blockB.a[1][0].mD), bvec3(false, true, false)) && allOk;
	allOk = compare_uvec2((blockB.a[1][1].mA), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.a[1][1].mB), uvec3(2u, 7u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.a[1][1].mC), uvec4(2u, 0u, 9u, 6u)) && allOk;
	allOk = compare_bvec3((blockB.a[1][1].mD), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec2((blockB.a[1][2].mA), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.a[1][2].mB), uvec3(6u, 1u, 4u)) && allOk;
	allOk = compare_uvec4((blockB.a[1][2].mC), uvec4(9u, 4u, 9u, 0u)) && allOk;
	allOk = compare_bvec3((blockB.a[1][2].mD), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec2((blockB.a[1][3].mA), uvec2(0u, 1u)) && allOk;
	allOk = compare_uvec3((blockB.a[1][3].mB), uvec3(2u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.a[1][3].mC), uvec4(3u, 3u, 4u, 9u)) && allOk;
	allOk = compare_bvec3((blockB.a[1][3].mD), bvec3(false, true, false)) && allOk;
	allOk = compare_uvec2((blockB.a[1][4].mA), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.a[1][4].mB), uvec3(4u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((blockB.a[1][4].mC), uvec4(9u, 0u, 5u, 5u)) && allOk;
	allOk = compare_bvec3((blockB.a[1][4].mD), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec2((blockB.a[2][0].mA), uvec2(8u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.a[2][0].mB), uvec3(2u, 1u, 8u)) && allOk;
	allOk = compare_uvec4((blockB.a[2][0].mC), uvec4(9u, 7u, 3u, 3u)) && allOk;
	allOk = compare_bvec3((blockB.a[2][0].mD), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec2((blockB.a[2][1].mA), uvec2(7u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.a[2][1].mB), uvec3(5u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((blockB.a[2][1].mC), uvec4(1u, 5u, 9u, 3u)) && allOk;
	allOk = compare_bvec3((blockB.a[2][1].mD), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec2((blockB.a[2][2].mA), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.a[2][2].mB), uvec3(0u, 3u, 8u)) && allOk;
	allOk = compare_uvec4((blockB.a[2][2].mC), uvec4(0u, 0u, 0u, 2u)) && allOk;
	allOk = compare_bvec3((blockB.a[2][2].mD), bvec3(false, false, true)) && allOk;
	allOk = compare_uvec2((blockB.a[2][3].mA), uvec2(5u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.a[2][3].mB), uvec3(7u, 6u, 9u)) && allOk;
	allOk = compare_uvec4((blockB.a[2][3].mC), uvec4(4u, 2u, 7u, 1u)) && allOk;
	allOk = compare_bvec3((blockB.a[2][3].mD), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec2((blockB.a[2][4].mA), uvec2(0u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.a[2][4].mB), uvec3(6u, 3u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.a[2][4].mC), uvec4(2u, 1u, 8u, 4u)) && allOk;
	allOk = compare_bvec3((blockB.a[2][4].mD), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec2((blockB.a[3][0].mA), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec3((blockB.a[3][0].mB), uvec3(6u, 0u, 5u)) && allOk;
	allOk = compare_uvec4((blockB.a[3][0].mC), uvec4(2u, 7u, 1u, 7u)) && allOk;
	allOk = compare_bvec3((blockB.a[3][0].mD), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec2((blockB.a[3][1].mA), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.a[3][1].mB), uvec3(6u, 8u, 3u)) && allOk;
	allOk = compare_uvec4((blockB.a[3][1].mC), uvec4(5u, 8u, 5u, 1u)) && allOk;
	allOk = compare_bvec3((blockB.a[3][1].mD), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec2((blockB.a[3][2].mA), uvec2(7u, 4u)) && allOk;
	allOk = compare_uvec3((blockB.a[3][2].mB), uvec3(8u, 6u, 4u)) && allOk;
	allOk = compare_uvec4((blockB.a[3][2].mC), uvec4(9u, 1u, 4u, 2u)) && allOk;
	allOk = compare_bvec3((blockB.a[3][2].mD), bvec3(false, true, true)) && allOk;
	allOk = compare_uvec2((blockB.a[3][3].mA), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.a[3][3].mB), uvec3(2u, 1u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.a[3][3].mC), uvec4(3u, 1u, 8u, 8u)) && allOk;
	allOk = compare_bvec3((blockB.a[3][3].mD), bvec3(true, true, true)) && allOk;
	allOk = compare_uvec2((blockB.a[3][4].mA), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.a[3][4].mB), uvec3(2u, 6u, 8u)) && allOk;
	allOk = compare_uvec4((blockB.a[3][4].mC), uvec4(6u, 5u, 9u, 5u)) && allOk;
	allOk = compare_bvec3((blockB.a[3][4].mD), bvec3(true, true, true)) && allOk;
	allOk = compare_uvec2((blockB.a[4][0].mA), uvec2(5u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.a[4][0].mB), uvec3(1u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.a[4][0].mC), uvec4(7u, 0u, 7u, 3u)) && allOk;
	allOk = compare_bvec3((blockB.a[4][0].mD), bvec3(false, true, false)) && allOk;
	allOk = compare_uvec2((blockB.a[4][1].mA), uvec2(4u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.a[4][1].mB), uvec3(2u, 3u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.a[4][1].mC), uvec4(2u, 6u, 8u, 8u)) && allOk;
	allOk = compare_bvec3((blockB.a[4][1].mD), bvec3(false, true, true)) && allOk;
	allOk = compare_uvec2((blockB.a[4][2].mA), uvec2(9u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.a[4][2].mB), uvec3(4u, 7u, 6u)) && allOk;
	allOk = compare_uvec4((blockB.a[4][2].mC), uvec4(9u, 7u, 9u, 8u)) && allOk;
	allOk = compare_bvec3((blockB.a[4][2].mD), bvec3(true, true, true)) && allOk;
	allOk = compare_uvec2((blockB.a[4][3].mA), uvec2(3u, 8u)) && allOk;
	allOk = compare_uvec3((blockB.a[4][3].mB), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_uvec4((blockB.a[4][3].mC), uvec4(1u, 6u, 2u, 8u)) && allOk;
	allOk = compare_bvec3((blockB.a[4][3].mD), bvec3(false, true, true)) && allOk;
	allOk = compare_uvec2((blockB.a[4][4].mA), uvec2(3u, 4u)) && allOk;
	allOk = compare_uvec3((blockB.a[4][4].mB), uvec3(5u, 1u, 0u)) && allOk;
	allOk = compare_uvec4((blockB.a[4][4].mC), uvec4(8u, 3u, 5u, 8u)) && allOk;
	allOk = compare_bvec3((blockB.a[4][4].mD), bvec3(false, true, true)) && allOk;
	allOk = compare_uvec2((blockB.a[5][0].mA), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.a[5][0].mB), uvec3(5u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((blockB.a[5][0].mC), uvec4(4u, 5u, 2u, 9u)) && allOk;
	allOk = compare_bvec3((blockB.a[5][0].mD), bvec3(false, true, false)) && allOk;
	allOk = compare_uvec2((blockB.a[5][1].mA), uvec2(3u, 1u)) && allOk;
	allOk = compare_uvec3((blockB.a[5][1].mB), uvec3(6u, 1u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.a[5][1].mC), uvec4(4u, 2u, 2u, 6u)) && allOk;
	allOk = compare_bvec3((blockB.a[5][1].mD), bvec3(false, false, true)) && allOk;
	allOk = compare_uvec2((blockB.a[5][2].mA), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec3((blockB.a[5][2].mB), uvec3(9u, 1u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.a[5][2].mC), uvec4(8u, 6u, 5u, 7u)) && allOk;
	allOk = compare_bvec3((blockB.a[5][2].mD), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec2((blockB.a[5][3].mA), uvec2(4u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.a[5][3].mB), uvec3(8u, 8u, 9u)) && allOk;
	allOk = compare_uvec4((blockB.a[5][3].mC), uvec4(7u, 1u, 3u, 2u)) && allOk;
	allOk = compare_bvec3((blockB.a[5][3].mD), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec2((blockB.a[5][4].mA), uvec2(9u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.a[5][4].mB), uvec3(6u, 9u, 0u)) && allOk;
	allOk = compare_uvec4((blockB.a[5][4].mC), uvec4(8u, 1u, 4u, 5u)) && allOk;
	allOk = compare_bvec3((blockB.a[5][4].mD), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec2((blockB.a[6][0].mA), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec3((blockB.a[6][0].mB), uvec3(5u, 4u, 8u)) && allOk;
	allOk = compare_uvec4((blockB.a[6][0].mC), uvec4(9u, 1u, 6u, 2u)) && allOk;
	allOk = compare_bvec3((blockB.a[6][0].mD), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec2((blockB.a[6][1].mA), uvec2(9u, 1u)) && allOk;
	allOk = compare_uvec3((blockB.a[6][1].mB), uvec3(6u, 4u, 4u)) && allOk;
	allOk = compare_uvec4((blockB.a[6][1].mC), uvec4(3u, 3u, 4u, 2u)) && allOk;
	allOk = compare_bvec3((blockB.a[6][1].mD), bvec3(false, false, true)) && allOk;
	allOk = compare_uvec2((blockB.a[6][2].mA), uvec2(7u, 8u)) && allOk;
	allOk = compare_uvec3((blockB.a[6][2].mB), uvec3(2u, 2u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0][0].mA = (uvec2(4u, 9u));
	blockB.a[0][0].mB = (uvec3(9u, 2u, 9u));
	blockB.a[0][0].mC = (uvec4(4u, 7u, 7u, 1u));
	blockB.a[0][0].mD = (bvec3(true, false, false));
	blockB.a[0][1].mA = (uvec2(3u, 3u));
	blockB.a[0][1].mB = (uvec3(1u, 7u, 1u));
	blockB.a[0][1].mC = (uvec4(7u, 7u, 7u, 7u));
	blockB.a[0][1].mD = (bvec3(false, true, true));
	blockB.a[0][2].mA = (uvec2(8u, 7u));
	blockB.a[0][2].mB = (uvec3(6u, 6u, 6u));
	blockB.a[0][2].mC = (uvec4(7u, 2u, 4u, 5u));
	blockB.a[0][2].mD = (bvec3(false, true, true));
	blockB.a[0][3].mA = (uvec2(3u, 3u));
	blockB.a[0][3].mB = (uvec3(4u, 6u, 0u));
	blockB.a[0][3].mC = (uvec4(2u, 0u, 6u, 1u));
	blockB.a[0][3].mD = (bvec3(false, false, true));
	blockB.a[0][4].mA = (uvec2(8u, 7u));
	blockB.a[0][4].mB = (uvec3(2u, 3u, 8u));
	blockB.a[0][4].mC = (uvec4(6u, 4u, 6u, 4u));
	blockB.a[0][4].mD = (bvec3(true, false, true));
	blockB.a[1][0].mA = (uvec2(2u, 4u));
	blockB.a[1][0].mB = (uvec3(9u, 4u, 3u));
	blockB.a[1][0].mC = (uvec4(2u, 7u, 1u, 3u));
	blockB.a[1][0].mD = (bvec3(false, false, true));
	blockB.a[1][1].mA = (uvec2(7u, 9u));
	blockB.a[1][1].mB = (uvec3(9u, 1u, 1u));
	blockB.a[1][1].mC = (uvec4(2u, 1u, 0u, 6u));
	blockB.a[1][1].mD = (bvec3(true, true, true));
	blockB.a[1][2].mA = (uvec2(4u, 9u));
	blockB.a[1][2].mB = (uvec3(2u, 0u, 4u));
	blockB.a[1][2].mC = (uvec4(8u, 1u, 7u, 9u));
	blockB.a[1][2].mD = (bvec3(true, false, true));
	blockB.a[1][3].mA = (uvec2(7u, 5u));
	blockB.a[1][3].mB = (uvec3(9u, 1u, 8u));
	blockB.a[1][3].mC = (uvec4(7u, 1u, 4u, 0u));
	blockB.a[1][3].mD = (bvec3(true, true, true));
	blockB.a[1][4].mA = (uvec2(7u, 1u));
	blockB.a[1][4].mB = (uvec3(9u, 9u, 8u));
	blockB.a[1][4].mC = (uvec4(9u, 2u, 3u, 1u));
	blockB.a[1][4].mD = (bvec3(false, false, false));
	blockB.a[2][0].mA = (uvec2(5u, 7u));
	blockB.a[2][0].mB = (uvec3(7u, 2u, 0u));
	blockB.a[2][0].mC = (uvec4(0u, 1u, 0u, 6u));
	blockB.a[2][0].mD = (bvec3(false, false, false));
	blockB.a[2][1].mA = (uvec2(4u, 4u));
	blockB.a[2][1].mB = (uvec3(0u, 4u, 9u));
	blockB.a[2][1].mC = (uvec4(9u, 6u, 7u, 7u));
	blockB.a[2][1].mD = (bvec3(true, false, true));
	blockB.a[2][2].mA = (uvec2(6u, 4u));
	blockB.a[2][2].mB = (uvec3(0u, 3u, 2u));
	blockB.a[2][2].mC = (uvec4(8u, 7u, 7u, 1u));
	blockB.a[2][2].mD = (bvec3(false, true, true));
	blockB.a[2][3].mA = (uvec2(5u, 2u));
	blockB.a[2][3].mB = (uvec3(2u, 1u, 8u));
	blockB.a[2][3].mC = (uvec4(5u, 4u, 7u, 0u));
	blockB.a[2][3].mD = (bvec3(false, false, false));
	blockB.a[2][4].mA = (uvec2(1u, 2u));
	blockB.a[2][4].mB = (uvec3(9u, 2u, 7u));
	blockB.a[2][4].mC = (uvec4(3u, 1u, 8u, 2u));
	blockB.a[2][4].mD = (bvec3(false, true, true));
	blockB.a[3][0].mA = (uvec2(9u, 5u));
	blockB.a[3][0].mB = (uvec3(0u, 5u, 9u));
	blockB.a[3][0].mC = (uvec4(3u, 9u, 6u, 7u));
	blockB.a[3][0].mD = (bvec3(false, true, true));
	blockB.a[3][1].mA = (uvec2(0u, 9u));
	blockB.a[3][1].mB = (uvec3(1u, 2u, 8u));
	blockB.a[3][1].mC = (uvec4(5u, 1u, 8u, 9u));
	blockB.a[3][1].mD = (bvec3(true, true, false));
	blockB.a[3][2].mA = (uvec2(8u, 6u));
	blockB.a[3][2].mB = (uvec3(7u, 5u, 8u));
	blockB.a[3][2].mC = (uvec4(0u, 9u, 7u, 1u));
	blockB.a[3][2].mD = (bvec3(true, true, false));
	blockB.a[3][3].mA = (uvec2(2u, 3u));
	blockB.a[3][3].mB = (uvec3(6u, 0u, 4u));
	blockB.a[3][3].mC = (uvec4(4u, 9u, 3u, 6u));
	blockB.a[3][3].mD = (bvec3(false, true, true));
	blockB.a[3][4].mA = (uvec2(8u, 0u));
	blockB.a[3][4].mB = (uvec3(5u, 4u, 9u));
	blockB.a[3][4].mC = (uvec4(9u, 6u, 1u, 8u));
	blockB.a[3][4].mD = (bvec3(false, false, true));
	blockB.a[4][0].mA = (uvec2(9u, 4u));
	blockB.a[4][0].mB = (uvec3(1u, 7u, 0u));
	blockB.a[4][0].mC = (uvec4(6u, 5u, 6u, 2u));
	blockB.a[4][0].mD = (bvec3(false, true, true));
	blockB.a[4][1].mA = (uvec2(4u, 0u));
	blockB.a[4][1].mB = (uvec3(1u, 4u, 5u));
	blockB.a[4][1].mC = (uvec4(5u, 9u, 9u, 3u));
	blockB.a[4][1].mD = (bvec3(false, false, false));
	blockB.a[4][2].mA = (uvec2(8u, 4u));
	blockB.a[4][2].mB = (uvec3(9u, 1u, 6u));
	blockB.a[4][2].mC = (uvec4(4u, 7u, 1u, 5u));
	blockB.a[4][2].mD = (bvec3(false, false, true));
	blockB.a[4][3].mA = (uvec2(3u, 2u));
	blockB.a[4][3].mB = (uvec3(5u, 4u, 4u));
	blockB.a[4][3].mC = (uvec4(7u, 4u, 7u, 5u));
	blockB.a[4][3].mD = (bvec3(true, true, false));
	blockB.a[4][4].mA = (uvec2(5u, 2u));
	blockB.a[4][4].mB = (uvec3(3u, 4u, 3u));
	blockB.a[4][4].mC = (uvec4(9u, 3u, 7u, 5u));
	blockB.a[4][4].mD = (bvec3(false, true, false));
	blockB.a[5][0].mA = (uvec2(8u, 6u));
	blockB.a[5][0].mB = (uvec3(5u, 5u, 5u));
	blockB.a[5][0].mC = (uvec4(8u, 5u, 7u, 3u));
	blockB.a[5][0].mD = (bvec3(false, true, false));
	blockB.a[5][1].mA = (uvec2(4u, 3u));
	blockB.a[5][1].mB = (uvec3(8u, 7u, 1u));
	blockB.a[5][1].mC = (uvec4(3u, 0u, 1u, 5u));
	blockB.a[5][1].mD = (bvec3(true, false, false));
	blockB.a[5][2].mA = (uvec2(0u, 6u));
	blockB.a[5][2].mB = (uvec3(6u, 8u, 6u));
	blockB.a[5][2].mC = (uvec4(0u, 3u, 9u, 8u));
	blockB.a[5][2].mD = (bvec3(false, true, true));
	blockB.a[5][3].mA = (uvec2(5u, 4u));
	blockB.a[5][3].mB = (uvec3(7u, 2u, 9u));
	blockB.a[5][3].mC = (uvec4(0u, 1u, 0u, 9u));
	blockB.a[5][3].mD = (bvec3(false, false, false));
	blockB.a[5][4].mA = (uvec2(4u, 4u));
	blockB.a[5][4].mB = (uvec3(1u, 4u, 8u));
	blockB.a[5][4].mC = (uvec4(8u, 3u, 0u, 3u));
	blockB.a[5][4].mD = (bvec3(true, false, true));
	blockB.a[6][0].mA = (uvec2(7u, 9u));
	blockB.a[6][0].mB = (uvec3(3u, 6u, 6u));
	blockB.a[6][0].mC = (uvec4(5u, 1u, 9u, 2u));
	blockB.a[6][0].mD = (bvec3(false, false, false));
	blockB.a[6][1].mA = (uvec2(5u, 7u));
	blockB.a[6][1].mB = (uvec3(5u, 6u, 8u));
	blockB.a[6][1].mC = (uvec4(9u, 9u, 3u, 4u));
	blockB.a[6][1].mD = (bvec3(false, false, false));
	blockB.a[6][2].mA = (uvec2(5u, 6u));
	blockB.a[6][2].mB = (uvec3(5u, 6u, 0u));
	blockB.a[6][2].mC = (uvec4(5u, 4u, 4u, 5u));
	blockB.a[6][2].mD = (bvec3(false, true, false));
	blockB.a[6][3].mA = (uvec2(2u, 9u));
	blockB.a[6][3].mB = (uvec3(7u, 8u, 2u));
	blockB.a[6][3].mC = (uvec4(6u, 8u, 9u, 8u));
	blockB.a[6][3].mD = (bvec3(false, true, true));
	blockB.a[6][4].mA = (uvec2(7u, 0u));
	blockB.a[6][4].mB = (uvec3(9u, 9u, 0u));
	blockB.a[6][4].mC = (uvec4(2u, 4u, 3u, 6u));
	blockB.a[6][4].mD = (bvec3(true, true, false));
	blockB.a[7][0].mA = (uvec2(1u, 2u));
	blockB.a[7][0].mB = (uvec3(5u, 7u, 8u));
	blockB.a[7][0].mC = (uvec4(5u, 7u, 2u, 7u));
	blockB.a[7][0].mD = (bvec3(false, false, true));
	blockB.a[7][1].mA = (uvec2(1u, 9u));
	blockB.a[7][1].mB = (uvec3(0u, 3u, 1u));
	blockB.a[7][1].mC = (uvec4(4u, 3u, 3u, 5u));
	blockB.a[7][1].mD = (bvec3(false, false, false));
	blockB.a[7][2].mA = (uvec2(5u, 4u));
	blockB.a[7][2].mB = (uvec3(3u, 2u, 4u));
	blockB.a[7][2].mC = (uvec4(5u, 6u, 6u, 7u));
	blockB.a[7][2].mD = (bvec3(true, true, false));
	blockB.a[7][3].mA = (uvec2(6u, 9u));
	blockB.a[7][3].mB = (uvec3(2u, 0u, 3u));
	blockB.a[7][3].mC = (uvec4(1u, 6u, 3u, 1u));
	blockB.a[7][3].mD = (bvec3(true, true, true));
	blockB.a[7][4].mA = (uvec2(5u, 2u));
	blockB.a[7][4].mB = (uvec3(5u, 8u, 6u));
	blockB.a[7][4].mC = (uvec4(1u, 6u, 0u, 6u));
	blockB.a[7][4].mD = (bvec3(false, false, false));
}
#version 450
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
	highp float a;
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	highp ivec2 b;
	mediump vec4 c;
	highp mat3 d[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	lowp uvec3 e;
	bvec2 f[][1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockC.b), ivec2(4, 3)) && allOk;
	allOk = compare_vec4((blockC.c), vec4(-8.0, 3.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(blockC.d[0], mat3(-5.0, -3.0, -2.0, -3.0, 6.0, -6.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3(blockC.d[1], mat3(-6.0, -3.0, 0.0, -6.0, 1.0, 2.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_bvec2((blockD.f[0][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD.f[1][0]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (vec4(-7.0, -4.0, -1.0, 9.0));
	blockC.d[0] = (mat3(-4.0, -4.0, 3.0, -7.0, -4.0, 0.0, -7.0, -9.0, -8.0));
	blockC.d[1] = (mat3(-4.0, -7.0, 2.0, -5.0, -9.0, 9.0, -1.0, 9.0, 4.0));
	blockD.e = (uvec3(6u, 3u, 2u));
	blockD.f[0][0] = (bvec2(false, true));
	blockD.f[1][0] = (bvec2(true, true));
}
#version 450
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
	layout(offset = 0) mediump vec2 a;
	layout(offset = 8) bool b;
	layout(offset = 16) lowp ivec3 c;
	layout(offset = 32) mediump mat2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].a), vec2(-7.0, -6.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(0)].c), ivec3(3, 3, -4)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].a), vec2(1.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(1)].c), ivec3(6, 7, -9)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].a), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(2)].c), ivec3(-5, 9, -3)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(3)].a), vec2(5.0, 1.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(3)].c), ivec3(9, -7, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].c = (ivec3(7, 7, 4));
	blockB[nonuniformEXT(0)].d = (mat2(-9.0, 5.0, -6.0, -7.0));
	blockB[nonuniformEXT(1)].c = (ivec3(-9, -8, 5));
	blockB[nonuniformEXT(1)].d = (mat2(5.0, 3.0, 1.0, -6.0));
	blockB[nonuniformEXT(2)].c = (ivec3(-3, 6, -2));
	blockB[nonuniformEXT(2)].d = (mat2(-2.0, -1.0, 5.0, -4.0));
	blockB[nonuniformEXT(3)].c = (ivec3(-9, -1, -4));
	blockB[nonuniformEXT(3)].d = (mat2(0.0, 9.0, -7.0, 1.0));
}
#version 450
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
	float16_t b[1];
	lowp float c[1];
	mediump uint d;
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	uint16_t e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.c[0]), 9.0) && allOk;
	allOk = compare_uint16_t(uint(blockC.e), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d = (6u);
}
#version 450
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
	highp uvec3 a;
	highp uvec3 b;
	mediump float c;
	u16vec4 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp ivec2 e;
	lowp uvec2 f[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	bvec3 g[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	highp ivec3 h;
	lowp uint i;
	bool j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(3u, 1u, 9u)) && allOk;
	allOk = compare_float((blockB.c), 9.0) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.d[0]), uvec4(8u, 0u, 7u, 5u)) && allOk;
	allOk = compare_ivec2((blockC.e), ivec2(0, 7)) && allOk;
	allOk = compare_uvec2((blockC.f[0]), uvec2(3u, 8u)) && allOk;
	allOk = compare_ivec3((blockE.h), ivec3(6, -7, 5)) && allOk;
	allOk = compare_uint((blockE.i), 4u) && allOk;
	allOk = compare_bool((blockE.j[0]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec3(0u, 7u, 6u));
	blockB.c = (4.0);
	blockB.d[0] = u16vec4(uvec4(0u, 5u, 6u, 3u));
	blockC.e = (ivec2(5, 2));
	blockD[0].g[0] = (bvec3(false, true, false));
	blockD[1].g[0] = (bvec3(false, true, false));
	blockE.i = (9u);
	blockE.j[0] = (true);
}
#version 450
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
	highp mat3x4 a;
	bvec4 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a, mat3x4(-7.0, 3.0, -2.0, 9.0, -9.0, -1.0, -9.0, 1.0, -8.0, 6.0, -5.0, -8.0)) && allOk;
	allOk = compare_bvec4((blockB.b[0]), bvec4(true, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(-6.0, -2.0, 3.0, -5.0, -4.0, 5.0, -9.0, 8.0, 1.0, 9.0, 5.0, -4.0));
	blockB.b[0] = (bvec4(true, true, false, true));
}
#version 450
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
	layout(offset = 2) f16vec4 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) i16vec3 c;
	layout(offset = 16) mediump vec4 d;
	layout(offset = 32) lowp vec4 e[1];
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) f16vec3 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.b), vec4(5.0, -6.0, -9.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC[0].d), vec4(0.0, 5.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC[0].e[0]), vec4(-2.0, -1.0, 5.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC[1].d), vec4(-1.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec4((blockC[1].e[0]), vec4(-5.0, 5.0, 3.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f), vec3(-5.0, 1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(3.0);
	blockC[0].c = i16vec3(ivec3(9, -2, -4));
	blockC[0].d = (vec4(-9.0, -2.0, 0.0, 9.0));
	blockC[1].c = i16vec3(ivec3(-8, -5, 0));
	blockC[1].d = (vec4(4.0, 7.0, 3.0, -2.0));
	blockD.f = f16vec3(vec3(5.0, 5.0, -5.0));
}
#version 450
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
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockB.a), ivec3(4, -1, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec3(ivec3(5, 7, -9));
}
#version 450
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
	f16vec4 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = f16vec4(vec4(8.0, 9.0, -5.0, 5.0));
	blockB[nonuniformEXT(1)].a = f16vec4(vec4(-4.0, 2.0, -1.0, 9.0));
	blockB[nonuniformEXT(2)].a = f16vec4(vec4(-3.0, 5.0, -8.0, -2.0));
}
#version 450
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
	int16_t a;
	bool b;
	mediump mat4 c;
	f16vec3 d;
	uint16_t e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB[nonuniformEXT(0)].a), 6) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(0)].b), true) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(0)].c, mat4(1.0, -7.0, 2.0, -1.0, -2.0, -8.0, -7.0, -4.0, -1.0, -5.0, -5.0, 4.0, -8.0, -3.0, -5.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(0)].d), vec3(-8.0, 0.0, 5.0)) && allOk;
	allOk = compare_int16_t(int(blockB[nonuniformEXT(1)].a), -3) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(1)].b), false) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(1)].c, mat4(6.0, -5.0, -9.0, 9.0, -7.0, -7.0, 9.0, -2.0, 9.0, 5.0, 5.0, 9.0, -4.0, -5.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(1)].d), vec3(1.0, -5.0, 4.0)) && allOk;
	allOk = compare_int16_t(int(blockB[nonuniformEXT(2)].a), 9) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(2)].b), true) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(2)].c, mat4(9.0, 1.0, 6.0, 9.0, -8.0, -6.0, 8.0, 7.0, 1.0, 5.0, 5.0, -4.0, -8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(2)].d), vec3(3.0, -9.0, 1.0)) && allOk;
	allOk = compare_int16_t(int(blockB[nonuniformEXT(3)].a), 8) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(3)].b), true) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(3)].c, mat4(-3.0, -6.0, -1.0, -6.0, 4.0, 7.0, -8.0, 2.0, 8.0, 7.0, 8.0, -8.0, -2.0, -2.0, 8.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(3)].d), vec3(-3.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = int16_t(6);
	blockB[nonuniformEXT(0)].d = f16vec3(vec3(8.0, -3.0, -3.0));
	blockB[nonuniformEXT(0)].e = uint16_t(9u);
	blockB[nonuniformEXT(1)].a = int16_t(1);
	blockB[nonuniformEXT(1)].d = f16vec3(vec3(-1.0, 7.0, -8.0));
	blockB[nonuniformEXT(1)].e = uint16_t(7u);
	blockB[nonuniformEXT(2)].a = int16_t(-1);
	blockB[nonuniformEXT(2)].d = f16vec3(vec3(-7.0, 6.0, 6.0));
	blockB[nonuniformEXT(2)].e = uint16_t(0u);
	blockB[nonuniformEXT(3)].a = int16_t(-4);
	blockB[nonuniformEXT(3)].d = f16vec3(vec3(-1.0, 8.0, -8.0));
	blockB[nonuniformEXT(3)].e = uint16_t(0u);
}
#version 450
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
	lowp ivec2 a;
	i8vec4 b[1];
	lowp uvec2 c;
	bool d;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp float e;
	highp uvec2 f;
	u8vec4 g;
	highp vec4 h;
	bvec2 i;
};
layout(std430, buffer_reference) buffer BlockD
{
	i8vec3 j;
	u8vec3 k;
};
layout(std430, buffer_reference) buffer BlockE
{
	highp int l[1];
	i8vec2 m;
	lowp uvec2 n;
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.b[0]), ivec4(4294967290, 4294967293, 4294967295, 4294967287)) && allOk;
	allOk = compare_uvec2((blockB.c), uvec2(4u, 3u)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
	allOk = compare_float((blockC.e), 8.0) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(9u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.g), uvec4(4u, 1u, 4u, 9u)) && allOk;
	allOk = compare_vec4((blockC.h), vec4(9.0, -2.0, -2.0, 1.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.j), ivec3(9, 4294967291, 8)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.k), uvec3(5u, 7u, 8u)) && allOk;
	allOk = compare_int((blockE.l[0]), -6) && allOk;
	allOk = compare_i8vec2(ivec2(blockE.m), ivec2(8, 2)) && allOk;
	allOk = compare_uvec2((blockE.n), uvec2(3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.e = (6.0);
	blockC.f = (uvec2(9u, 7u));
	blockC.g = u8vec4(uvec4(2u, 2u, 9u, 6u));
	blockC.h = (vec4(7.0, -9.0, -6.0, -1.0));
	blockD.k = u8vec3(uvec3(4u, 4u, 3u));
	blockE.l[0] = (2);
	blockE.m = i8vec2(ivec2(0, 5));
	blockE.n = (uvec2(6u, 4u));
}
#version 450
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
	highp uvec3 a;
	i8vec3 b;
	lowp vec3 c;
	i8vec3 d;
};
layout(std430, buffer_reference) buffer BlockC
{
	bool e;
	mediump int f;
	bvec2 g;
	lowp ivec3 h[1];
	i8vec3 i;
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump uvec2 j;
	mediump vec4 k[1];
	bvec4 l;
	bvec4 m[1];
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(5u, 4u, 9u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b), ivec3(2, 4, 0)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(-2.0, 6.0, -1.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.d), ivec3(5, 4294967287, 9)) && allOk;
	allOk = compare_bool((blockC.e), true) && allOk;
	allOk = compare_int((blockC.f), 2) && allOk;
	allOk = compare_bvec2((blockC.g), bvec2(false, false)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.i), ivec3(0, 4294967294, 4294967291)) && allOk;
	allOk = compare_uvec2((blockD.j), uvec2(4u, 4u)) && allOk;
	allOk = compare_vec4((blockD.k[0]), vec4(-7.0, -2.0, 9.0, 8.0)) && allOk;
	allOk = compare_bvec4((blockD.m[0]), bvec4(false, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(3u, 1u, 6u));
	blockB.b = i8vec3(ivec3(4294967294, 2, 4294967289));
	blockB.c = (vec3(4.0, 6.0, -8.0));
	blockB.d = i8vec3(ivec3(8, 4294967293, 3));
	blockC.e = (false);
	blockC.f = (-1);
	blockC.g = (bvec2(true, false));
	blockC.h[0] = (ivec3(-6, -1, -2));
	blockC.i = i8vec3(ivec3(2, 4294967293, 4294967287));
	blockD.j = (uvec2(4u, 2u));
	blockD.m[0] = (bvec4(false, true, true, true));
}
#version 450
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
	lowp uvec2 a;
	lowp mat3x4 b;
	highp mat2x3 c[1];
	highp int d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(3u, 0u)) && allOk;
	allOk = compare_mat3x4(blockB.b, mat3x4(-6.0, -3.0, -1.0, -9.0, 5.0, -7.0, -9.0, 8.0, -4.0, -8.0, 8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(7u, 9u));
	blockB.b = (mat3x4(5.0, 5.0, -3.0, -5.0, -8.0, 3.0, -9.0, 2.0, 6.0, 1.0, 9.0, -5.0));
	blockB.d = (-1);
}
#version 450
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
	highp mat4x3 a;
	lowp vec3 b;
	mediump mat3x4 c;
	lowp vec2 d;
	mediump mat2x3 e[];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump mat2 f[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.b), vec3(-6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockB.c, mat3x4(1.0, -7.0, 7.0, 5.0, 8.0, 5.0, -9.0, -8.0, 6.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2(blockC.f[0], mat2(7.0, -8.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2(blockC.f[1], mat2(1.0, 7.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2(blockC.f[2], mat2(7.0, 6.0, 7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(8.0, -2.0, -1.0, -6.0, 6.0, 0.0, 9.0, 5.0, 4.0, 8.0, 6.0, 7.0));
	blockB.b = (vec3(-5.0, 5.0, -2.0));
	blockB.d = (vec2(-4.0, 8.0));
	blockB.e[0] = (mat2x3(-6.0, -4.0, 6.0, -3.0, -6.0, 8.0));
	blockB.e[1] = (mat2x3(-6.0, -7.0, -1.0, 4.0, -7.0, 2.0));
	blockB.e[2] = (mat2x3(-1.0, 4.0, -6.0, 5.0, -5.0, -1.0));
	blockC.f[0] = (mat2(-2.0, -3.0, -7.0, 8.0));
	blockC.f[1] = (mat2(-6.0, 7.0, 9.0, 8.0));
	blockC.f[2] = (mat2(-3.0, -4.0, 4.0, 9.0));
}
#version 450
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
	mediump float a[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp mat4x3 b;
	mediump mat3x4 c;
	highp float d;
	bool e;
	mediump float f[];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockD
{
	lowp mat3 g[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	lowp uvec3 h;
	int8_t i;
	mediump ivec3 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a[0]), 4.0) && allOk;
	allOk = compare_mat3x4(blockC.c, mat3x4(-6.0, 7.0, -1.0, 4.0, -5.0, -7.0, -2.0, 6.0, -8.0, -1.0, -7.0, -4.0)) && allOk;
	allOk = compare_float((blockC.d), -1.0) && allOk;
	allOk = compare_bool((blockC.e), false) && allOk;
	allOk = compare_float((blockC.f[0]), 3.0) && allOk;
	allOk = compare_mat3(blockD.g[0], mat3(9.0, 7.0, 7.0, -7.0, -5.0, 3.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_int8_t(int(blockE[0].i), 4294967291) && allOk;
	allOk = compare_int8_t(int(blockE[1].i), 7) && allOk;
	allOk = compare_int8_t(int(blockE[2].i), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (mat3x4(3.0, 1.0, 5.0, -1.0, 4.0, 2.0, 9.0, -7.0, 9.0, -6.0, 2.0, 3.0));
	blockC.d = (-7.0);
	blockC.f[0] = (5.0);
	blockE[0].h = (uvec3(7u, 8u, 4u));
	blockE[1].h = (uvec3(7u, 1u, 3u));
	blockE[2].h = (uvec3(3u, 9u, 6u));
}
#version 450
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
	i8vec4 mB;
};
layout(std140, column_major, buffer_reference) readonly buffer BlockB
{
	i8vec2 a;
	sA b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

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

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) mediump vec3 a;
	layout(offset = 16) highp vec2 b;
	layout(offset = 24) bvec2 c;
	layout(offset = 32) bvec2 d;
	layout(offset = 48) bvec3 e;
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) mediump vec2 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) i8vec2 g;
	layout(offset = 4) lowp uvec2 h;
	layout(offset = 16) lowp uvec2 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(-3.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(8.0, -8.0)) && allOk;
	allOk = compare_bvec2((blockB.c), bvec2(true, true)) && allOk;
	allOk = compare_bvec3((blockB.e), bvec3(false, false, true)) && allOk;
	allOk = compare_vec2((blockC.f), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD[0].g), ivec2(9, 4294967293)) && allOk;
	allOk = compare_uvec2((blockD[0].h), uvec2(3u, 6u)) && allOk;
	allOk = compare_uvec2((blockD[0].i), uvec2(4u, 0u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD[1].g), ivec2(4294967287, 4294967287)) && allOk;
	allOk = compare_uvec2((blockD[1].h), uvec2(1u, 2u)) && allOk;
	allOk = compare_uvec2((blockD[1].i), uvec2(2u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(1.0, 8.0, 5.0));
	blockB.c = (bvec2(true, true));
	blockB.d = (bvec2(true, true));
	blockD[0].g = i8vec2(ivec2(6, 5));
	blockD[0].i = (uvec2(3u, 2u));
	blockD[1].g = i8vec2(ivec2(4294967288, 4294967288));
	blockD[1].i = (uvec2(8u, 3u));
}
#version 450
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
	layout(offset = 0) uint8_t a;
	layout(offset = 16) mediump ivec4 b;
	layout(offset = 32) mediump float c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp vec3 d;
	layout(offset = 12) u8vec4 e;
	layout(offset = 16) i8vec2 f;
	layout(offset = 20) mediump ivec3 g;
	layout(offset = 32) highp uvec2 h;
};
layout(buffer_reference) readonly buffer BlockD
{
	layout(offset = 0) bvec2 i;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) u8vec3 j;
	layout(offset = 3) int8_t k;
	layout(offset = 4) bvec2 l;
	layout(offset = 16) bvec2 m;
	layout(offset = 32) highp vec4 n;
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.c), -5.0) && allOk;
	allOk = compare_vec3((blockC.d), vec3(5.0, 8.0, -2.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.e), uvec4(1u, 1u, 1u, 5u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.f), ivec2(4294967289, 2)) && allOk;
	allOk = compare_uvec2((blockC.h), uvec2(3u, 4u)) && allOk;
	allOk = compare_bvec2((blockD.i), bvec2(true, true)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE.j), uvec3(3u, 8u, 0u)) && allOk;
	allOk = compare_int8_t(int(blockE.k), 8) && allOk;
	allOk = compare_bvec2((blockE.l), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.m), bvec2(false, false)) && allOk;
	allOk = compare_vec4((blockE.n), vec4(9.0, -8.0, 5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint8_t(7u);
	blockB.b = (ivec4(-1, -8, -4, 6));
	blockB.c = (-8.0);
	blockC.e = u8vec4(uvec4(8u, 5u, 4u, 1u));
	blockC.f = i8vec2(ivec2(4294967293, 4294967290));
	blockC.g = (ivec3(3, 6, 1));
	blockC.h = (uvec2(4u, 7u));
	blockE.j = u8vec3(uvec3(8u, 6u, 3u));
	blockE.k = int8_t(9);
	blockE.l = (bvec2(true, true));
	blockE.n = (vec4(2.0, -4.0, -9.0, -5.0));
}
#version 450
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
	u8vec3 a;
	mediump mat4x2 b;
	i8vec4 c;
	highp mat4x3 d[6];
	mediump mat4x2 e[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	u8vec3 f;
	bvec3 g;
	bvec4 h[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	bvec3 i;
	bvec3 j;
};
layout(scalar, row_major, buffer_reference) buffer BlockE
{
	mediump mat4 k;
	highp mat4x3 l;
	highp mat4x2 m;
	highp mat3x2 n[][6];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.d[0], mat4x3(-4.0, 7.0, -1.0, -1.0, -9.0, 4.0, 0.0, -1.0, -5.0, 7.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[1], mat4x3(-4.0, -4.0, 3.0, -2.0, -9.0, 9.0, -3.0, -9.0, -5.0, 8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[2], mat4x3(7.0, 6.0, 6.0, 2.0, 7.0, 0.0, -1.0, 7.0, 5.0, -2.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[3], mat4x3(2.0, -1.0, -1.0, -6.0, 3.0, 9.0, 1.0, 6.0, 2.0, -4.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[4], mat4x3(4.0, -8.0, -3.0, 2.0, -9.0, -1.0, 2.0, 9.0, 7.0, -3.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[5], mat4x3(9.0, 2.0, 4.0, -1.0, -7.0, 2.0, -1.0, 2.0, 7.0, -8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB.e[0], mat4x2(-1.0, 6.0, 0.0, 9.0, -1.0, 6.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockB.e[1], mat4x2(-4.0, -5.0, 0.0, -5.0, 7.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockB.e[2], mat4x2(-3.0, 5.0, -3.0, 3.0, 9.0, 3.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockB.e[3], mat4x2(-1.0, -7.0, 1.0, 8.0, 9.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockB.e[4], mat4x2(-2.0, 7.0, 5.0, -8.0, -9.0, -8.0, -6.0, 1.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f), uvec3(3u, 4u, 7u)) && allOk;
	allOk = compare_bvec3((blockC.g), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec4((blockC.h[0]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockC.h[1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec3((blockD.j), bvec3(false, false, false)) && allOk;
	allOk = compare_mat4(blockE.k, mat4(7.0, -1.0, -5.0, 5.0, -3.0, 8.0, -3.0, -1.0, -6.0, 3.0, 6.0, -3.0, -6.0, -7.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockE.n[0][0], mat3x2(-5.0, 3.0, 8.0, -5.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockE.n[0][1], mat3x2(4.0, -9.0, -5.0, 9.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockE.n[0][2], mat3x2(-9.0, 6.0, 3.0, 5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockE.n[0][3], mat3x2(-5.0, -7.0, 9.0, 9.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockE.n[0][4], mat3x2(6.0, -8.0, 2.0, -7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockE.n[0][5], mat3x2(1.0, 0.0, -6.0, -1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockE.n[1][0], mat3x2(5.0, -1.0, 5.0, 4.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockE.n[1][1], mat3x2(-3.0, -7.0, 1.0, -4.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockE.n[1][2], mat3x2(-8.0, -9.0, 0.0, 5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockE.n[1][3], mat3x2(2.0, -1.0, 7.0, 8.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockE.n[1][4], mat3x2(7.0, -6.0, 8.0, 6.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockE.n[1][5], mat3x2(2.0, 8.0, 2.0, 5.0, 0.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4x2(9.0, 5.0, 9.0, 5.0, -5.0, -6.0, -5.0, 9.0));
	blockB.d[0] = (mat4x3(9.0, -4.0, -5.0, -1.0, -4.0, -4.0, 2.0, 4.0, -3.0, -5.0, -9.0, 3.0));
	blockB.d[1] = (mat4x3(7.0, 6.0, 3.0, -4.0, -1.0, 6.0, 1.0, -3.0, -4.0, -9.0, -2.0, 1.0));
	blockB.d[2] = (mat4x3(-8.0, 3.0, -8.0, 0.0, 2.0, 4.0, 2.0, -3.0, -1.0, 5.0, -5.0, 8.0));
	blockB.d[3] = (mat4x3(-4.0, 9.0, 2.0, -6.0, 8.0, 1.0, -5.0, -1.0, -4.0, 5.0, 2.0, -9.0));
	blockB.d[4] = (mat4x3(2.0, 2.0, 1.0, 4.0, 0.0, 7.0, 2.0, 0.0, -4.0, 0.0, 6.0, -5.0));
	blockB.d[5] = (mat4x3(-7.0, -1.0, -3.0, -9.0, 2.0, 6.0, -7.0, 4.0, 3.0, -3.0, 9.0, 7.0));
	blockB.e[0] = (mat4x2(-5.0, -9.0, 8.0, 5.0, -8.0, 2.0, 3.0, -5.0));
	blockB.e[1] = (mat4x2(2.0, -3.0, -6.0, 1.0, 5.0, -4.0, -2.0, -9.0));
	blockB.e[2] = (mat4x2(9.0, 9.0, -1.0, 8.0, 0.0, 8.0, 9.0, 0.0));
	blockB.e[3] = (mat4x2(5.0, -4.0, -3.0, 7.0, -3.0, 9.0, -6.0, 7.0));
	blockB.e[4] = (mat4x2(-7.0, 2.0, 8.0, -7.0, 1.0, -8.0, 4.0, 5.0));
	blockC.f = u8vec3(uvec3(1u, 0u, 7u));
	blockC.g = (bvec3(true, true, false));
	blockC.h[0] = (bvec4(true, false, false, true));
	blockC.h[1] = (bvec4(false, false, false, false));
	blockD.j = (bvec3(false, false, false));
	blockE.k = (mat4(1.0, 6.0, -7.0, 4.0, 4.0, -7.0, -9.0, -6.0, 9.0, 4.0, 9.0, -9.0, -9.0, 8.0, 3.0, -9.0));
	blockE.l = (mat4x3(-1.0, 5.0, 8.0, 5.0, 1.0, 2.0, -6.0, -9.0, 9.0, 6.0, -2.0, 4.0));
}
#version 450
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
	u8vec2 a[8];
	highp int b;
	lowp uvec4 c;
	lowp mat2x3 d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	bvec3 e[1];
	highp uvec2 f;
	u8vec2 g;
	i8vec4 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b), -6) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.g), uvec2(1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = u8vec2(uvec2(9u, 5u));
	blockB.a[1] = u8vec2(uvec2(3u, 2u));
	blockB.a[2] = u8vec2(uvec2(2u, 7u));
	blockB.a[3] = u8vec2(uvec2(1u, 2u));
	blockB.a[4] = u8vec2(uvec2(3u, 7u));
	blockB.a[5] = u8vec2(uvec2(1u, 4u));
	blockB.a[6] = u8vec2(uvec2(9u, 1u));
	blockB.a[7] = u8vec2(uvec2(2u, 9u));
	blockB.c = (uvec4(4u, 0u, 7u, 8u));
	blockB.d[0] = (mat2x3(7.0, -4.0, 8.0, -5.0, -3.0, -2.0));
	blockB.d[1] = (mat2x3(-1.0, 1.0, 3.0, 0.0, -9.0, 0.0));
	blockC.e[0] = (bvec3(false, false, false));
	blockC.f = (uvec2(9u, 6u));
	blockC.h = i8vec4(ivec4(5, 4294967287, 8, 4294967289));
}
#version 450
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
	i8vec2 mB[8];
};
struct sB
{
	mediump vec3 mA;
	mediump mat3x2 mB;
	highp mat2 mC;
	mediump vec3 mD;
};
struct sC
{
	bvec2 mA;
	sB mB;
	uint8_t mC[6];
	bvec3 mD;
};
struct sD
{
	lowp mat2x3 mA;
};
struct sE
{
	mediump uvec2 mA;
	u8vec4 mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	sA a;
	highp mat2 b;
	highp ivec2 c;
	highp mat4 d;
	bvec3 e;
};
layout(scalar, buffer_reference) readonly buffer BlockC
{
	sC f[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	sD g[];
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	bvec4 h;
	lowp vec4 i;
	sE j;
	lowp uvec4 k[8];
	mediump vec4 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB[0].b, mat2(-1.0, -8.0, -7.0, -5.0)) && allOk;
	allOk = compare_bvec3((blockB[0].e), bvec3(true, true, true)) && allOk;
	allOk = compare_mat2(blockB[1].b, mat2(-1.0, -4.0, -3.0, 6.0)) && allOk;
	allOk = compare_bvec3((blockB[1].e), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec4((blockE.h), bvec4(true, true, true, false)) && allOk;
	allOk = compare_uvec2((blockE.j.mA), uvec2(7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.j.mB), uvec4(9u, 1u, 1u, 6u)) && allOk;
	allOk = compare_uvec4((blockE.k[0]), uvec4(6u, 2u, 3u, 2u)) && allOk;
	allOk = compare_uvec4((blockE.k[1]), uvec4(4u, 0u, 3u, 1u)) && allOk;
	allOk = compare_uvec4((blockE.k[2]), uvec4(3u, 1u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((blockE.k[3]), uvec4(8u, 8u, 6u, 8u)) && allOk;
	allOk = compare_uvec4((blockE.k[4]), uvec4(6u, 7u, 0u, 4u)) && allOk;
	allOk = compare_uvec4((blockE.k[5]), uvec4(6u, 9u, 6u, 8u)) && allOk;
	allOk = compare_uvec4((blockE.k[6]), uvec4(1u, 7u, 9u, 8u)) && allOk;
	allOk = compare_uvec4((blockE.k[7]), uvec4(6u, 3u, 3u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (vec4(-3.0, -9.0, 9.0, -6.0));
	blockB[0].a.mB[0] = i8vec2(ivec2(8, 7));
	blockB[0].a.mB[1] = i8vec2(ivec2(4294967288, 2));
	blockB[0].a.mB[2] = i8vec2(ivec2(4294967288, 4294967289));
	blockB[0].a.mB[3] = i8vec2(ivec2(8, 6));
	blockB[0].a.mB[4] = i8vec2(ivec2(4294967289, 4294967289));
	blockB[0].a.mB[5] = i8vec2(ivec2(4294967289, 3));
	blockB[0].a.mB[6] = i8vec2(ivec2(4294967287, 9));
	blockB[0].a.mB[7] = i8vec2(ivec2(6, 4294967291));
	blockB[0].c = (ivec2(6, 6));
	blockB[0].d = (mat4(-8.0, -7.0, -8.0, -7.0, -3.0, 8.0, 8.0, -2.0, 0.0, 0.0, -7.0, 6.0, 2.0, -5.0, 7.0, -1.0));
	blockB[0].e = (bvec3(false, true, true));
	blockB[1].a.mA = (vec4(9.0, 7.0, 4.0, -7.0));
	blockB[1].a.mB[0] = i8vec2(ivec2(7, 4294967292));
	blockB[1].a.mB[1] = i8vec2(ivec2(7, 2));
	blockB[1].a.mB[2] = i8vec2(ivec2(4294967294, 7));
	blockB[1].a.mB[3] = i8vec2(ivec2(6, 6));
	blockB[1].a.mB[4] = i8vec2(ivec2(5, 0));
	blockB[1].a.mB[5] = i8vec2(ivec2(9, 4294967288));
	blockB[1].a.mB[6] = i8vec2(ivec2(0, 4294967289));
	blockB[1].a.mB[7] = i8vec2(ivec2(4294967295, 1));
	blockB[1].c = (ivec2(-9, -5));
	blockB[1].d = (mat4(0.0, -8.0, 9.0, -4.0, 3.0, -4.0, -3.0, 1.0, 0.0, 9.0, 7.0, -6.0, -8.0, -3.0, -5.0, -7.0));
	blockB[1].e = (bvec3(true, false, true));
	blockD.g[0].mA = (mat2x3(-1.0, 6.0, -7.0, 2.0, -8.0, -7.0));
	blockE.h = (bvec4(false, true, true, true));
	blockE.j.mA = (uvec2(8u, 9u));
	blockE.j.mB = u8vec4(uvec4(7u, 7u, 8u, 5u));
	blockE.l[0] = (vec4(0.0, 8.0, 8.0, -3.0));
	blockE.l[1] = (vec4(7.0, 1.0, -7.0, 7.0));
	blockE.l[2] = (vec4(6.0, -3.0, 1.0, 9.0));
	blockE.l[3] = (vec4(-4.0, -6.0, -5.0, -3.0));
	blockE.l[4] = (vec4(4.0, 2.0, 6.0, -8.0));
	blockE.l[5] = (vec4(5.0, 3.0, -5.0, 0.0));
	blockE.l[6] = (vec4(-3.0, -2.0, -6.0, 6.0));
}
