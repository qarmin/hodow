#version 450
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

layout(std140, binding = 1) buffer Block
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

layout(std140, row_major, binding = 1) buffer Block
{
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(-7.0, 4.0, 2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(3.0, -2.0, -7.0, -2.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
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

	var = (mat3x2(-9.0, 0.0, 7.0, 6.0, 0.0, 3.0));
}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(4.0, 5.0, -8.0, -9.0, -9.0, 3.0, 9.0, 1.0, 7.0, 0.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(4.0, -9.0, -4.0, -7.0, 1.0, -2.0, 9.0, 9.0, -9.0, 4.0, 4.0, -7.0));
}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(-4.0, -6.0, 5.0, -5.0, 5.0, -9.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(-2.0, -4.0, -2.0, 3.0, -1.0, -2.0, 0.0, 2.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
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

	var[0] = (vec2(-9.0, 7.0));
	var[1] = (vec2(9.0, 8.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[0][3], -3.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[1][2], -4.0) && allOk;
	allOk = compare_float(var[1][3], -3.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 5.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[2][3], 4.0) && allOk;
	allOk = compare_float(var[3][0], 7.0) && allOk;
	allOk = compare_float(var[3][1], -6.0) && allOk;
	allOk = compare_float(var[3][2], -9.0) && allOk;
	allOk = compare_float(var[3][3], -4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-6.0, 3.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-4.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-9.0, 5.0, -9.0, 4.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(7.0, -6.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(7.0, 9.0, -1.0, -5.0));
	var[1] = (vec4(5.0, -7.0, 4.0, -8.0));
	var[2] = (vec4(-8.0, 0.0, -6.0, 9.0));
	var[3] = (vec4(-2.0, 0.0, -8.0, 3.0));
}
#version 450
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
	mediump float var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (2.0);
}
#version 450
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[0][2], -4.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], 4.0) && allOk;
	allOk = compare_vec3(var[0], vec3(2.0, -5.0, -4.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(8.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var = (mat2x3(8.0, 5.0, 2.0, -2.0, -1.0, -5.0));
}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], 1.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-8.0, 8.0, 1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-6.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (9.0);
	var[0] = (vec3(8.0, -4.0, -4.0));
	var[1] = (vec3(3.0, 2.0, -8.0));
}
#version 450
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-4.0, 7.0, 6.0, -1.0, -7.0, -7.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0] = (vec4(1.0, -2.0, -4.0, 2.0));
	var[1] = (vec4(-2.0, -6.0, -3.0, -8.0));
}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-6.0, -8.0, -2.0, -6.0, -3.0, 8.0, 7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var = (mat2x4(-2.0, -6.0, 0.0, -7.0, 7.0, -9.0, 0.0, 9.0));
}
#version 450
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
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], 6.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 7.0) && allOk;
	allOk = compare_float(var[2][2], 5.0) && allOk;
	allOk = compare_float(var[3][0], 7.0) && allOk;
	allOk = compare_float(var[3][1], -3.0) && allOk;
	allOk = compare_float(var[3][2], -9.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-4.0, 6.0, -8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(4.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-6.0, 7.0, 5.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(7.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var = (mat4x3(6.0, 1.0, 4.0, -1.0, 4.0, 5.0, 9.0, 6.0, 5.0, 8.0, 0.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
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
}
#version 450
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
	bvec2 var[3];
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((var[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[2]), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (bvec2(true, false));
	var[1] = (bvec2(true, true));
	var[2] = (bvec2(false, false));
}
#version 450
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
	allOk = compare_mat3x4(var[0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	var[1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	var[2] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
}
#version 450
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
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(1.0, 3.0, -7.0));
	var[0][1] = (vec3(-7.0, 2.0, 3.0));
	var[0][2] = (vec3(1.0, -2.0, -1.0));
	var[0][3] = (vec3(-5.0, -1.0, 9.0));
	var[1][0] = (vec3(8.0, -4.0, 3.0));
	var[1][1] = (vec3(4.0, 9.0, -6.0));
	var[1][2] = (vec3(7.0, 6.0, -5.0));
	var[1][3] = (vec3(2.0, 6.0, 3.0));
	var[2][0] = (vec3(2.0, 7.0, -1.0));
	var[2][1] = (vec3(-3.0, -3.0, -7.0));
	var[2][2] = (vec3(-5.0, 3.0, 4.0));
	var[2][3] = (vec3(-4.0, -2.0, 8.0));
}
#version 450
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

	var[0] = float16_t(-8.0);
	var[1] = float16_t(9.0);
	var[2] = float16_t(-2.0);
}
#version 450
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

	var[0][0] = (vec3(1.0, -1.0, 1.0));
	var[0][1] = (vec3(-3.0, 9.0, -8.0));
	var[1][0] = (vec3(-5.0, 6.0, 6.0));
	var[1][1] = (vec3(3.0, -3.0, 7.0));
	var[2][0] = (vec3(-9.0, -2.0, -7.0));
	var[2][1] = (vec3(7.0, 0.0, -8.0));
	var[3][0] = (vec3(0.0, -5.0, 5.0));
	var[3][1] = (vec3(-2.0, 4.0, -8.0));
	var[4][0] = (vec3(-3.0, -4.0, 7.0));
	var[4][1] = (vec3(-3.0, -1.0, -9.0));
	var[5][0] = (vec3(2.0, -3.0, 6.0));
	var[5][1] = (vec3(-4.0, 8.0, 2.0));
	var[6][0] = (vec3(6.0, -2.0, 0.0));
	var[6][1] = (vec3(3.0, 4.0, -6.0));
	var[7][0] = (vec3(3.0, -6.0, 2.0));
	var[7][1] = (vec3(4.0, -8.0, 0.0));
	var[8][0] = (vec3(-3.0, 3.0, 5.0));
	var[8][1] = (vec3(-6.0, -8.0, 8.0));
	var[9][0] = (vec3(4.0, -9.0, -1.0));
	var[9][1] = (vec3(-6.0, 7.0, -3.0));
	var[10][0] = (vec3(2.0, -2.0, 4.0));
	var[10][1] = (vec3(-3.0, -5.0, 9.0));
	var[11][0] = (vec3(-8.0, -1.0, 7.0));
	var[11][1] = (vec3(2.0, 0.0, 5.0));
	var[12][0] = (vec3(0.0, 9.0, -7.0));
	var[12][1] = (vec3(5.0, 6.0, -3.0));
	var[13][0] = (vec3(-6.0, 0.0, -3.0));
	var[13][1] = (vec3(7.0, 9.0, -2.0));
	var[14][0] = (vec3(-7.0, 6.0, -7.0));
	var[14][1] = (vec3(8.0, -6.0, 8.0));
	var[15][0] = (vec3(4.0, -8.0, 4.0));
	var[15][1] = (vec3(4.0, 5.0, 5.0));
	var[16][0] = (vec3(2.0, 3.0, 6.0));
	var[16][1] = (vec3(-4.0, -4.0, -1.0));
	var[17][0] = (vec3(-3.0, -1.0, -1.0));
	var[17][1] = (vec3(6.0, 2.0, 2.0));
	var[18][0] = (vec3(5.0, -2.0, -1.0));
	var[18][1] = (vec3(7.0, -7.0, 5.0));
}
#version 450
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
	highp mat2x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(-8.0, -1.0, -1.0, -6.0, 2.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(3.0, -9.0, 1.0, -9.0, 8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(1.0, -1.0, 0.0, 7.0, 2.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(2.0, 2.0, -8.0, 6.0, 0.0, -1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-4.0, -2.0, -4.0, -6.0, -3.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(8.0, -7.0, 8.0, 8.0, 2.0, 3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(9.0, 0.0, -4.0, -7.0, -7.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(-3.0, -7.0, -5.0, -4.0, -1.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(7.0, 0.0, -6.0, -2.0, 9.0, -7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(9.0, -3.0, 5.0, -7.0, 2.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(5.0, -1.0, 2.0, -6.0, -6.0, -7.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-7.0, -8.0, -7.0, -5.0, 1.0, 3.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(-9.0, -4.0, 8.0, 5.0, 6.0, -3.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(-8.0, 2.0, 8.0, 5.0, -8.0, 1.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-5.0, 2.0, 7.0, -3.0, 3.0, 9.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(6.0, 6.0, 2.0, -4.0, -3.0, 8.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	var[1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	var[2] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
	var[3] = (mat2x4(-3.0, 4.0, 7.0, -8.0, -6.0, -3.0, -2.0, -9.0));
	var[4] = (mat2x4(-6.0, 7.0, 6.0, -2.0, 2.0, 7.0, 4.0, -7.0));
	var[5] = (mat2x4(-8.0, 4.0, 3.0, -6.0, -9.0, -3.0, 5.0, -6.0));
	var[6] = (mat2x4(-5.0, 8.0, 2.0, 0.0, -9.0, 1.0, -2.0, -6.0));
	var[7] = (mat2x4(0.0, 6.0, 7.0, -2.0, -1.0, -3.0, -3.0, -9.0));
	var[8] = (mat2x4(7.0, -5.0, 9.0, -1.0, -1.0, 9.0, 0.0, 7.0));
	var[9] = (mat2x4(6.0, -8.0, -2.0, 3.0, 1.0, -8.0, -4.0, -9.0));
	var[10] = (mat2x4(-7.0, 0.0, -8.0, -1.0, 5.0, 7.0, 7.0, -3.0));
	var[11] = (mat2x4(1.0, -9.0, 2.0, -9.0, -3.0, 0.0, -4.0, 5.0));
	var[12] = (mat2x4(8.0, -2.0, 7.0, -7.0, -4.0, 2.0, -4.0, 0.0));
	var[13] = (mat2x4(7.0, -5.0, 6.0, -6.0, -2.0, 2.0, -8.0, 5.0));
	var[14] = (mat2x4(6.0, 8.0, -2.0, 0.0, 7.0, 9.0, 1.0, -3.0));
	var[15] = (mat2x4(5.0, 2.0, 9.0, 1.0, -1.0, -6.0, -3.0, -3.0));
	var[16] = (mat2x4(7.0, 4.0, 1.0, -9.0, -9.0, 4.0, 0.0, 1.0));
	var[17] = (mat2x4(-8.0, 4.0, 7.0, -7.0, -4.0, -4.0, -4.0, 1.0));
	var[18] = (mat2x4(-9.0, 3.0, 6.0, -5.0, 6.0, 4.0, 8.0, -7.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat2x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(-8.0, -1.0, -1.0, -6.0, 2.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(3.0, -9.0, 1.0, -9.0, 8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(1.0, -1.0, 0.0, 7.0, 2.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(2.0, 2.0, -8.0, 6.0, 0.0, -1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-4.0, -2.0, -4.0, -6.0, -3.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(8.0, -7.0, 8.0, 8.0, 2.0, 3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(9.0, 0.0, -4.0, -7.0, -7.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(-3.0, -7.0, -5.0, -4.0, -1.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(7.0, 0.0, -6.0, -2.0, 9.0, -7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(9.0, -3.0, 5.0, -7.0, 2.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(5.0, -1.0, 2.0, -6.0, -6.0, -7.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-7.0, -8.0, -7.0, -5.0, 1.0, 3.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(-9.0, -4.0, 8.0, 5.0, 6.0, -3.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(-8.0, 2.0, 8.0, 5.0, -8.0, 1.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-5.0, 2.0, 7.0, -3.0, 3.0, 9.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(6.0, 6.0, 2.0, -4.0, -3.0, 8.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	var[1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	var[2] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
	var[3] = (mat2x4(-3.0, 4.0, 7.0, -8.0, -6.0, -3.0, -2.0, -9.0));
	var[4] = (mat2x4(-6.0, 7.0, 6.0, -2.0, 2.0, 7.0, 4.0, -7.0));
	var[5] = (mat2x4(-8.0, 4.0, 3.0, -6.0, -9.0, -3.0, 5.0, -6.0));
	var[6] = (mat2x4(-5.0, 8.0, 2.0, 0.0, -9.0, 1.0, -2.0, -6.0));
	var[7] = (mat2x4(0.0, 6.0, 7.0, -2.0, -1.0, -3.0, -3.0, -9.0));
	var[8] = (mat2x4(7.0, -5.0, 9.0, -1.0, -1.0, 9.0, 0.0, 7.0));
	var[9] = (mat2x4(6.0, -8.0, -2.0, 3.0, 1.0, -8.0, -4.0, -9.0));
	var[10] = (mat2x4(-7.0, 0.0, -8.0, -1.0, 5.0, 7.0, 7.0, -3.0));
	var[11] = (mat2x4(1.0, -9.0, 2.0, -9.0, -3.0, 0.0, -4.0, 5.0));
	var[12] = (mat2x4(8.0, -2.0, 7.0, -7.0, -4.0, 2.0, -4.0, 0.0));
	var[13] = (mat2x4(7.0, -5.0, 6.0, -6.0, -2.0, 2.0, -8.0, 5.0));
	var[14] = (mat2x4(6.0, 8.0, -2.0, 0.0, 7.0, 9.0, 1.0, -3.0));
	var[15] = (mat2x4(5.0, 2.0, 9.0, 1.0, -1.0, -6.0, -3.0, -3.0));
	var[16] = (mat2x4(7.0, 4.0, 1.0, -9.0, -9.0, 4.0, 0.0, 1.0));
	var[17] = (mat2x4(-8.0, 4.0, 7.0, -7.0, -4.0, -4.0, -4.0, 1.0));
	var[18] = (mat2x4(-9.0, 3.0, 6.0, -5.0, 6.0, 4.0, 8.0, -7.0));
}
#version 450
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

	var[0][0] = (vec3(3.0, -9.0, 3.0));
	var[0][1] = (vec3(2.0, 4.0, 6.0));
	var[0][2] = (vec3(2.0, -9.0, 0.0));
	var[1][0] = (vec3(-7.0, 3.0, -3.0));
	var[1][1] = (vec3(-4.0, -4.0, 5.0));
	var[1][2] = (vec3(-4.0, 1.0, -7.0));
	var[2][0] = (vec3(7.0, 9.0, -7.0));
	var[2][1] = (vec3(8.0, 2.0, 5.0));
	var[2][2] = (vec3(-9.0, 7.0, -2.0));
	var[3][0] = (vec3(-7.0, 3.0, 4.0));
	var[3][1] = (vec3(-1.0, 1.0, 0.0));
	var[3][2] = (vec3(7.0, 7.0, 9.0));
	var[4][0] = (vec3(4.0, 4.0, -3.0));
	var[4][1] = (vec3(9.0, 1.0, -6.0));
	var[4][2] = (vec3(7.0, -6.0, -1.0));
	var[5][0] = (vec3(-5.0, -2.0, -7.0));
	var[5][1] = (vec3(-8.0, -9.0, 6.0));
	var[5][2] = (vec3(2.0, -2.0, -7.0));
	var[6][0] = (vec3(6.0, -2.0, -1.0));
	var[6][1] = (vec3(9.0, 2.0, -4.0));
	var[6][2] = (vec3(-9.0, -5.0, 4.0));
	var[7][0] = (vec3(-1.0, -6.0, 9.0));
	var[7][1] = (vec3(-1.0, 3.0, 0.0));
	var[7][2] = (vec3(-7.0, 1.0, -6.0));
	var[8][0] = (vec3(0.0, -6.0, 0.0));
	var[8][1] = (vec3(8.0, 6.0, 4.0));
	var[8][2] = (vec3(7.0, -4.0, 4.0));
	var[9][0] = (vec3(-6.0, 3.0, -3.0));
	var[9][1] = (vec3(0.0, -8.0, 6.0));
	var[9][2] = (vec3(-7.0, -2.0, 7.0));
	var[10][0] = (vec3(4.0, -8.0, 1.0));
	var[10][1] = (vec3(-6.0, 7.0, 1.0));
	var[10][2] = (vec3(6.0, 3.0, 0.0));
	var[11][0] = (vec3(-2.0, -9.0, 9.0));
	var[11][1] = (vec3(1.0, 3.0, 4.0));
	var[11][2] = (vec3(5.0, -3.0, -6.0));
	var[12][0] = (vec3(-7.0, 1.0, -4.0));
	var[12][1] = (vec3(8.0, -5.0, 4.0));
	var[12][2] = (vec3(1.0, -7.0, 3.0));
	var[13][0] = (vec3(-3.0, -3.0, 6.0));
	var[13][1] = (vec3(8.0, 1.0, -8.0));
	var[13][2] = (vec3(5.0, 9.0, -2.0));
	var[14][0] = (vec3(4.0, -7.0, 4.0));
	var[14][1] = (vec3(-6.0, 5.0, -4.0));
	var[14][2] = (vec3(5.0, -3.0, 3.0));
	var[15][0] = (vec3(8.0, 6.0, 1.0));
	var[15][1] = (vec3(6.0, 5.0, 1.0));
	var[15][2] = (vec3(7.0, 9.0, 0.0));
	var[16][0] = (vec3(-7.0, 8.0, 6.0));
	var[16][1] = (vec3(4.0, -8.0, -8.0));
	var[16][2] = (vec3(8.0, 9.0, -9.0));
	var[17][0] = (vec3(-8.0, -3.0, -7.0));
	var[17][1] = (vec3(4.0, -6.0, -4.0));
	var[17][2] = (vec3(-6.0, 0.0, 0.0));
	var[18][0] = (vec3(-3.0, -9.0, 1.0));
	var[18][1] = (vec3(-2.0, 3.0, -3.0));
	var[18][2] = (vec3(-1.0, 5.0, -8.0));
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	var[0][0][1] = (vec4(2.0, -4.0, 3.0, -5.0));
	var[0][0][2] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[0][0][3] = (vec4(3.0, 0.0, -4.0, -1.0));
	var[0][1][0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	var[0][1][1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	var[0][1][2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	var[0][1][3] = (vec4(6.0, -9.0, -1.0, -5.0));
	var[0][2][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	var[0][2][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	var[0][2][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	var[0][2][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
	var[1][0][0] = (vec4(-3.0, 2.0, 9.0, -4.0));
	var[1][0][1] = (vec4(2.0, 9.0, -9.0, -2.0));
	var[1][0][2] = (vec4(-1.0, 1.0, -9.0, 0.0));
	var[1][0][3] = (vec4(-7.0, 7.0, -3.0, -9.0));
	var[1][1][0] = (vec4(-1.0, 0.0, 7.0, 7.0));
	var[1][1][1] = (vec4(-5.0, -2.0, -6.0, 0.0));
	var[1][1][2] = (vec4(-2.0, 1.0, -2.0, 4.0));
	var[1][1][3] = (vec4(4.0, 0.0, 0.0, -2.0));
	var[1][2][0] = (vec4(4.0, 7.0, -5.0, -3.0));
	var[1][2][1] = (vec4(9.0, 1.0, 5.0, 5.0));
	var[1][2][2] = (vec4(9.0, -4.0, -6.0, 8.0));
	var[1][2][3] = (vec4(1.0, -5.0, 5.0, -3.0));
	var[2][0][0] = (vec4(-4.0, -3.0, 4.0, -8.0));
	var[2][0][1] = (vec4(-2.0, 0.0, -8.0, 2.0));
	var[2][0][2] = (vec4(-3.0, -5.0, 3.0, -2.0));
	var[2][0][3] = (vec4(-9.0, -8.0, -3.0, 5.0));
	var[2][1][0] = (vec4(-9.0, 6.0, -6.0, 7.0));
	var[2][1][1] = (vec4(-8.0, 2.0, 7.0, -5.0));
	var[2][1][2] = (vec4(0.0, -4.0, -7.0, 6.0));
	var[2][1][3] = (vec4(0.0, 0.0, 4.0, -5.0));
	var[2][2][0] = (vec4(-1.0, -9.0, -7.0, 5.0));
	var[2][2][1] = (vec4(3.0, 9.0, -8.0, -6.0));
	var[2][2][2] = (vec4(-3.0, 6.0, -9.0, 4.0));
	var[2][2][3] = (vec4(6.0, -6.0, -6.0, -2.0));
	var[3][0][0] = (vec4(-8.0, -3.0, -8.0, 5.0));
	var[3][0][1] = (vec4(6.0, -9.0, -7.0, -7.0));
	var[3][0][2] = (vec4(6.0, 1.0, 0.0, -3.0));
	var[3][0][3] = (vec4(4.0, 1.0, -7.0, 4.0));
	var[3][1][0] = (vec4(6.0, 4.0, 3.0, -5.0));
	var[3][1][1] = (vec4(-8.0, 0.0, -2.0, 7.0));
	var[3][1][2] = (vec4(5.0, -1.0, -3.0, -2.0));
	var[3][1][3] = (vec4(-6.0, -9.0, -3.0, 5.0));
	var[3][2][0] = (vec4(8.0, 7.0, -4.0, 1.0));
	var[3][2][1] = (vec4(6.0, -9.0, 8.0, 3.0));
	var[3][2][2] = (vec4(-6.0, -7.0, 7.0, -1.0));
	var[3][2][3] = (vec4(-7.0, 6.0, -5.0, 9.0));
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(3.0, 2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(4.0, -6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(7.0, 9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(2.0, 6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(2.0, 6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(1.0, 9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(-1.0, 0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(-8.0, -3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(-5.0, -2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	var[0][1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	var[0][2] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
	var[1][0] = (mat3x4(-9.0, 4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0));
	var[1][1] = (mat3x4(3.0, 1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0));
	var[1][2] = (mat3x4(1.0, 5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0));
	var[2][0] = (mat3x4(-2.0, -7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0));
	var[2][1] = (mat3x4(-8.0, 8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0));
	var[2][2] = (mat3x4(6.0, -1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0));
	var[3][0] = (mat3x4(5.0, 5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0));
	var[3][1] = (mat3x4(-4.0, 7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0));
	var[3][2] = (mat3x4(-1.0, 3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0));
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0], mat4(5.0, 8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(-6.0, -5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(-1.0, -6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(-9.0, -1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(-2.0, 7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(-9.0, 9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(1.0, 8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(4.0, -6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(9.0, -9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(6.0, 1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(-3.0, 2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(-1.0, -3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	var[0][1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	var[0][2] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
	var[1][0] = (mat4(-3.0, -9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0));
	var[1][1] = (mat4(1.0, 5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0));
	var[1][2] = (mat4(-7.0, 5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0));
	var[2][0] = (mat4(6.0, -8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0));
	var[2][1] = (mat4(6.0, 9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0));
	var[2][2] = (mat4(6.0, -6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0));
	var[3][0] = (mat4(-5.0, 3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0));
	var[3][1] = (mat4(-9.0, 5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0));
	var[3][2] = (mat4(5.0, -1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0][0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(3.0, 6.0, -5.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(9.0, 2.0, 6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(-7.0, -2.0, -4.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(6.0, 8.0, -4.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(6.0, 6.0, -9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(5.0, -3.0, 6.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(-9.0, -2.0, -3.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(0.0, 2.0, -1.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(-9.0, -7.0, 7.0, 0.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	var[0][1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	var[0][2] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
	var[1][0] = (mat2x3(7.0, -4.0, 4.0, -5.0, -1.0, 0.0));
	var[1][1] = (mat2x3(2.0, -5.0, 6.0, 7.0, -2.0, 4.0));
	var[1][2] = (mat2x3(-3.0, 7.0, 6.0, -3.0, -2.0, -6.0));
	var[2][0] = (mat2x3(7.0, -3.0, 2.0, 8.0, -1.0, 2.0));
	var[2][1] = (mat2x3(2.0, -9.0, 3.0, 1.0, -7.0, -7.0));
	var[2][2] = (mat2x3(3.0, -3.0, -5.0, 4.0, -6.0, 8.0));
	var[3][0] = (mat2x3(7.0, -9.0, 2.0, -8.0, 9.0, 9.0));
	var[3][1] = (mat2x3(3.0, 5.0, 8.0, 5.0, -7.0, 6.0));
	var[3][2] = (mat2x3(3.0, 6.0, 6.0, 1.0, 2.0, -7.0));
}
#version 450
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
	int16_t var[4][3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(var[0][0]), -5) && allOk;
	allOk = compare_int16_t(int(var[0][1]), 1) && allOk;
	allOk = compare_int16_t(int(var[0][2]), 8) && allOk;
	allOk = compare_int16_t(int(var[1][0]), -2) && allOk;
	allOk = compare_int16_t(int(var[1][1]), 9) && allOk;
	allOk = compare_int16_t(int(var[1][2]), -5) && allOk;
	allOk = compare_int16_t(int(var[2][0]), -8) && allOk;
	allOk = compare_int16_t(int(var[2][1]), 6) && allOk;
	allOk = compare_int16_t(int(var[2][2]), 3) && allOk;
	allOk = compare_int16_t(int(var[3][0]), -8) && allOk;
	allOk = compare_int16_t(int(var[3][1]), 6) && allOk;
	allOk = compare_int16_t(int(var[3][2]), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = int16_t(6);
	var[0][1] = int16_t(8);
	var[0][2] = int16_t(-2);
	var[1][0] = int16_t(-4);
	var[1][1] = int16_t(-3);
	var[1][2] = int16_t(9);
	var[2][0] = int16_t(-5);
	var[2][1] = int16_t(-8);
	var[2][2] = int16_t(-3);
	var[3][0] = int16_t(2);
	var[3][1] = int16_t(-1);
	var[3][2] = int16_t(4);
}
#version 450
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
	highp mat4x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4x2(var[0][0], mat4x2(5.0, 7.0, 1.0, -5.0, 5.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(-7.0, -4.0, 7.0, 7.0, 5.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(-9.0, -7.0, -1.0, 8.0, 0.0, 4.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(-5.0, -3.0, 4.0, 7.0, -4.0, -5.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(9.0, 2.0, -1.0, -1.0, 7.0, 2.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(4.0, 4.0, 9.0, -9.0, -2.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(5.0, -8.0, 2.0, 3.0, 3.0, 2.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(-8.0, -3.0, -1.0, 4.0, -8.0, -4.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(-7.0, 1.0, 0.0, -9.0, -6.0, 6.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(-8.0, 5.0, -3.0, 8.0, 6.0, -4.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(5.0, -2.0, -8.0, -1.0, 4.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(1.0, 5.0, -3.0, -4.0, 7.0, -7.0, 5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0][0][0] = (vec2(-4.0, -4.0));
	var[0][0][1] = (vec2(2.0, 0.0));
	var[0][0][2] = (vec2(-7.0, 3.0));
	var[0][0][3] = (vec2(9.0, 9.0));
	var[0][1][0] = (vec2(8.0, -9.0));
	var[0][1][1] = (vec2(-9.0, -6.0));
	var[0][1][2] = (vec2(-4.0, -6.0));
	var[0][1][3] = (vec2(-6.0, -8.0));
	var[0][2][0] = (vec2(6.0, -8.0));
	var[0][2][1] = (vec2(-8.0, 3.0));
	var[0][2][2] = (vec2(2.0, 8.0));
	var[0][2][3] = (vec2(5.0, -8.0));
	var[1][0][0] = (vec2(-3.0, 0.0));
	var[1][0][1] = (vec2(7.0, 5.0));
	var[1][0][2] = (vec2(-8.0, 5.0));
	var[1][0][3] = (vec2(-1.0, 7.0));
	var[1][1][0] = (vec2(4.0, -2.0));
	var[1][1][1] = (vec2(4.0, -2.0));
	var[1][1][2] = (vec2(-2.0, 9.0));
	var[1][1][3] = (vec2(8.0, 4.0));
	var[1][2][0] = (vec2(-5.0, -5.0));
	var[1][2][1] = (vec2(-6.0, 8.0));
	var[1][2][2] = (vec2(9.0, -5.0));
	var[1][2][3] = (vec2(-4.0, -2.0));
	var[2][0][0] = (vec2(6.0, -2.0));
	var[2][0][1] = (vec2(2.0, -5.0));
	var[2][0][2] = (vec2(3.0, -3.0));
	var[2][0][3] = (vec2(1.0, -6.0));
	var[2][1][0] = (vec2(-6.0, -7.0));
	var[2][1][1] = (vec2(9.0, 1.0));
	var[2][1][2] = (vec2(-4.0, 3.0));
	var[2][1][3] = (vec2(-4.0, 7.0));
	var[2][2][0] = (vec2(7.0, -4.0));
	var[2][2][1] = (vec2(8.0, -2.0));
	var[2][2][2] = (vec2(9.0, 0.0));
	var[2][2][3] = (vec2(-9.0, -9.0));
	var[3][0][0] = (vec2(1.0, 4.0));
	var[3][0][1] = (vec2(-7.0, 9.0));
	var[3][0][2] = (vec2(-5.0, 2.0));
	var[3][0][3] = (vec2(7.0, -9.0));
	var[3][1][0] = (vec2(-8.0, 5.0));
	var[3][1][1] = (vec2(-2.0, -8.0));
	var[3][1][2] = (vec2(7.0, -6.0));
	var[3][1][3] = (vec2(-3.0, -7.0));
	var[3][2][0] = (vec2(-3.0, 7.0));
	var[3][2][1] = (vec2(6.0, -5.0));
	var[3][2][2] = (vec2(9.0, -2.0));
	var[3][2][3] = (vec2(1.0, -9.0));
}
#version 450
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
	f16vec4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), -8.0) && allOk;
	allOk = compare_f16vec4(vec4(var[0][0]), vec4(-9.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1]), vec4(-8.0, -8.0, -3.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][2]), vec4(6.0, 1.0, -8.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0]), vec4(7.0, 5.0, -6.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1]), vec4(-4.0, -8.0, -4.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][2]), vec4(6.0, -4.0, 5.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0]), vec4(3.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1]), vec4(-9.0, 0.0, 3.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][2]), vec4(-2.0, -4.0, -2.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][0]), vec4(-9.0, -6.0, 4.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][1]), vec4(5.0, -9.0, 9.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][2]), vec4(7.0, 9.0, -4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = float16_t(9.0);
	var[0][0] = f16vec4(vec4(-6.0, 2.0, -8.0, -7.0));
	var[0][1] = f16vec4(vec4(-4.0, 2.0, -5.0, 9.0));
	var[0][2] = f16vec4(vec4(1.0, -6.0, 3.0, -1.0));
	var[1][0] = f16vec4(vec4(4.0, -1.0, -8.0, 5.0));
	var[1][1] = f16vec4(vec4(8.0, 7.0, 0.0, 4.0));
	var[1][2] = f16vec4(vec4(-5.0, -6.0, -8.0, -6.0));
	var[2][0] = f16vec4(vec4(2.0, -4.0, 8.0, -4.0));
	var[2][1] = f16vec4(vec4(-1.0, 8.0, 9.0, 0.0));
	var[2][2] = f16vec4(vec4(0.0, -5.0, 5.0, 7.0));
	var[3][0] = f16vec4(vec4(-6.0, -7.0, -8.0, -3.0));
	var[3][1] = f16vec4(vec4(-4.0, -7.0, 0.0, -7.0));
	var[3][2] = f16vec4(vec4(-2.0, 7.0, -1.0, 8.0));
}
#version 450
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
	highp uvec3 var[4][2][3];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var[0][0][0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((var[0][0][1]), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((var[0][0][2]), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_uvec3((var[0][1][0]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((var[0][1][1]), uvec3(5u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((var[0][1][2]), uvec3(6u, 6u, 8u)) && allOk;
	allOk = compare_uvec3((var[1][0][0]), uvec3(6u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((var[1][0][1]), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((var[1][0][2]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((var[1][1][0]), uvec3(6u, 7u, 9u)) && allOk;
	allOk = compare_uvec3((var[1][1][1]), uvec3(0u, 0u, 6u)) && allOk;
	allOk = compare_uvec3((var[1][1][2]), uvec3(0u, 2u, 2u)) && allOk;
	allOk = compare_uvec3((var[2][0][0]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((var[2][0][1]), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((var[2][0][2]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[2][1][0]), uvec3(9u, 3u, 7u)) && allOk;
	allOk = compare_uvec3((var[2][1][1]), uvec3(5u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[2][1][2]), uvec3(2u, 3u, 3u)) && allOk;
	allOk = compare_uvec3((var[3][0][0]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[3][0][1]), uvec3(8u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((var[3][0][2]), uvec3(7u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((var[3][1][0]), uvec3(1u, 4u, 9u)) && allOk;
	allOk = compare_uvec3((var[3][1][1]), uvec3(7u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((var[3][1][2]), uvec3(7u, 0u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (uvec3(3u, 5u, 6u));
	var[0][0][1] = (uvec3(5u, 4u, 5u));
	var[0][0][2] = (uvec3(4u, 9u, 4u));
	var[0][1][0] = (uvec3(1u, 1u, 6u));
	var[0][1][1] = (uvec3(3u, 9u, 4u));
	var[0][1][2] = (uvec3(9u, 7u, 9u));
	var[1][0][0] = (uvec3(4u, 7u, 7u));
	var[1][0][1] = (uvec3(0u, 2u, 9u));
	var[1][0][2] = (uvec3(4u, 7u, 8u));
	var[1][1][0] = (uvec3(1u, 4u, 6u));
	var[1][1][1] = (uvec3(4u, 9u, 3u));
	var[1][1][2] = (uvec3(4u, 3u, 5u));
	var[2][0][0] = (uvec3(9u, 4u, 3u));
	var[2][0][1] = (uvec3(5u, 8u, 0u));
	var[2][0][2] = (uvec3(5u, 4u, 6u));
	var[2][1][0] = (uvec3(4u, 8u, 7u));
	var[2][1][1] = (uvec3(1u, 5u, 2u));
	var[2][1][2] = (uvec3(4u, 1u, 2u));
	var[3][0][0] = (uvec3(7u, 7u, 5u));
	var[3][0][1] = (uvec3(3u, 7u, 0u));
	var[3][0][2] = (uvec3(8u, 1u, 2u));
	var[3][1][0] = (uvec3(6u, 5u, 3u));
	var[3][1][1] = (uvec3(8u, 8u, 7u));
	var[3][1][2] = (uvec3(1u, 2u, 5u));
}
#version 450
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
	highp mat2x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-2.0, -9.0, 4.0, -4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(2.0, -4.0, 4.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(-7.0, 4.0, -6.0, 9.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(6.0, -1.0, -8.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(4.0, 7.0, 2.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(0.0, 3.0, 1.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-7.0, -3.0, 0.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-3.0, -2.0, -4.0, -6.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(-2.0, -6.0, -4.0, 5.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-5.0, 0.0, 2.0, -8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(-7.0, 0.0, -6.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(2.0, 2.0, 8.0, 8.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-9.0, 5.0, -1.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-5.0, 6.0, -5.0, 8.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(-5.0, -6.0, -1.0, -9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(5.0, -5.0, 7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(-4.0, 4.0, -6.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(-1.0, 2.0, 6.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(-7.0, -3.0, -9.0, 9.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(-9.0, -2.0, 1.0, 4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(-5.0, -4.0, 9.0, 7.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	var[0][0][1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	var[0][0][2] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
	var[0][1][0] = (mat2x3(3.0, -4.0, -5.0, -4.0, -9.0, 4.0));
	var[0][1][1] = (mat2x3(6.0, 3.0, -4.0, 1.0, -8.0, 2.0));
	var[0][1][2] = (mat2x3(-4.0, 6.0, 9.0, 8.0, -3.0, 4.0));
	var[1][0][0] = (mat2x3(-5.0, 6.0, 8.0, -8.0, 0.0, 2.0));
	var[1][0][1] = (mat2x3(7.0, -9.0, -2.0, -9.0, -1.0, -1.0));
	var[1][0][2] = (mat2x3(-4.0, -3.0, 7.0, 9.0, 0.0, -4.0));
	var[1][1][0] = (mat2x3(-7.0, -8.0, 0.0, -7.0, 6.0, 7.0));
	var[1][1][1] = (mat2x3(8.0, 2.0, 8.0, 2.0, 1.0, 6.0));
	var[1][1][2] = (mat2x3(-1.0, 8.0, 1.0, -8.0, -1.0, 2.0));
	var[2][0][0] = (mat2x3(9.0, 0.0, 7.0, 7.0, 9.0, -8.0));
	var[2][0][1] = (mat2x3(5.0, 5.0, 1.0, 6.0, 3.0, -6.0));
	var[2][0][2] = (mat2x3(8.0, 9.0, 6.0, 7.0, 0.0, -6.0));
	var[2][1][0] = (mat2x3(-1.0, 7.0, -6.0, -6.0, -1.0, 0.0));
	var[2][1][1] = (mat2x3(-1.0, 2.0, 7.0, 6.0, -8.0, 6.0));
	var[2][1][2] = (mat2x3(7.0, -3.0, -1.0, 9.0, -1.0, -7.0));
	var[3][0][0] = (mat2x3(-7.0, 6.0, 4.0, 8.0, 5.0, -1.0));
	var[3][0][1] = (mat2x3(4.0, 4.0, 9.0, 9.0, -8.0, 6.0));
	var[3][0][2] = (mat2x3(6.0, 3.0, 8.0, 3.0, 4.0, 4.0));
	var[3][1][0] = (mat2x3(-2.0, 1.0, 4.0, -5.0, -8.0, -5.0));
	var[3][1][1] = (mat2x3(2.0, 1.0, 2.0, 5.0, -4.0, -5.0));
	var[3][1][2] = (mat2x3(-6.0, 9.0, -2.0, 0.0, 5.0, -9.0));
}
#version 450
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
	highp mat3x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(0.0, 6.0, 3.0, 9.0, -3.0, 9.0, 3.0, -5.0, -1.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-7.0, 6.0, 5.0, -7.0, -2.0, -4.0, 0.0, -8.0, 8.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(4.0, 4.0, -6.0, -2.0, 7.0, 1.0, -3.0, -2.0, -6.0, -2.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-6.0, -4.0, 8.0, -5.0, -5.0, 7.0, 3.0, -1.0, 7.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(5.0, -1.0, 4.0, -5.0, -8.0, -7.0, 7.0, -6.0, -4.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(-5.0, 3.0, 9.0, 0.0, 1.0, 3.0, -8.0, -9.0, 5.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-2.0, 9.0, -5.0, -3.0, 3.0, 5.0, 4.0, -7.0, -1.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(-5.0, 1.0, 5.0, -9.0, 3.0, 5.0, 3.0, 8.0, -8.0, -5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(-9.0, -3.0, -8.0, -8.0, 8.0, 8.0, 3.0, -6.0, -7.0, 4.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(7.0, 0.0, 9.0, -1.0, 2.0, 9.0, -3.0, 7.0, 4.0, -2.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(-4.0, -4.0, -1.0, -8.0, 9.0, -4.0, -1.0, -5.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(7.0, -1.0, -3.0, -4.0, -4.0, -3.0, 3.0, -7.0, -5.0, 8.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	var[0][0][1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	var[0][0][2] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
	var[0][1][0] = (mat3x4(-6.0, 0.0, 1.0, -2.0, 1.0, -4.0, -2.0, -6.0, -7.0, -8.0, 0.0, -8.0));
	var[0][1][1] = (mat3x4(0.0, 2.0, 9.0, -5.0, 9.0, -5.0, -4.0, 0.0, 4.0, 1.0, 0.0, -9.0));
	var[0][1][2] = (mat3x4(1.0, -1.0, -4.0, 9.0, 7.0, 3.0, 5.0, 1.0, 6.0, 6.0, 2.0, 2.0));
	var[1][0][0] = (mat3x4(-5.0, -5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0));
	var[1][0][1] = (mat3x4(-5.0, 5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0));
	var[1][0][2] = (mat3x4(-9.0, -1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0));
	var[1][1][0] = (mat3x4(8.0, -5.0, -9.0, 8.0, -3.0, -3.0, 9.0, -9.0, 6.0, -4.0, 9.0, 4.0));
	var[1][1][1] = (mat3x4(-8.0, 4.0, 7.0, 3.0, -1.0, -1.0, 9.0, -9.0, 8.0, -3.0, 9.0, -6.0));
	var[1][1][2] = (mat3x4(-4.0, 6.0, 2.0, 5.0, 3.0, 7.0, 3.0, 4.0, -4.0, 2.0, 0.0, 8.0));
	var[2][0][0] = (mat3x4(-4.0, 2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0));
	var[2][0][1] = (mat3x4(9.0, -2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0));
	var[2][0][2] = (mat3x4(-6.0, 5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0));
	var[2][1][0] = (mat3x4(-8.0, 0.0, 8.0, -6.0, -2.0, -3.0, 6.0, 4.0, 9.0, -2.0, 4.0, 1.0));
	var[2][1][1] = (mat3x4(-9.0, -5.0, -8.0, 5.0, 4.0, 2.0, 7.0, 1.0, -6.0, 2.0, -6.0, -4.0));
	var[2][1][2] = (mat3x4(-3.0, 1.0, -5.0, -9.0, -2.0, 3.0, 0.0, -4.0, 8.0, -3.0, 4.0, 9.0));
	var[3][0][0] = (mat3x4(9.0, 2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0));
	var[3][0][1] = (mat3x4(-1.0, 4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0));
	var[3][0][2] = (mat3x4(-9.0, 1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0));
	var[3][1][0] = (mat3x4(-6.0, -1.0, 3.0, -9.0, -6.0, -6.0, -3.0, 5.0, 0.0, -9.0, -4.0, 9.0));
	var[3][1][1] = (mat3x4(-8.0, 6.0, -4.0, -3.0, -4.0, 3.0, 3.0, 4.0, 4.0, 4.0, 3.0, 8.0));
	var[3][1][2] = (mat3x4(-3.0, -6.0, -3.0, 6.0, -9.0, -3.0, -6.0, 9.0, 3.0, -1.0, 6.0, 3.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0][0][0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(3.0, -6.0, 9.0, 8.0, -1.0, 8.0, -4.0, 2.0, 6.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(5.0, -1.0, 4.0, 2.0, -4.0, -2.0, -1.0, -4.0, 5.0, 9.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(2.0, -6.0, -1.0, 6.0, 9.0, -3.0, -8.0, 7.0, -5.0, 0.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-9.0, 3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(9.0, -8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(-3.0, -2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(7.0, -5.0, -4.0, -3.0, 5.0, 8.0, 9.0, -5.0, -5.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(9.0, -2.0, 0.0, 1.0, -8.0, -4.0, -9.0, 3.0, -1.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(-5.0, 1.0, 6.0, 5.0, 6.0, -1.0, -1.0, 1.0, -6.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(1.0, -2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(5.0, -9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(-1.0, -2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(0.0, 1.0, 5.0, -8.0, -8.0, 0.0, -9.0, 5.0, 2.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(5.0, -4.0, 3.0, -9.0, 3.0, 4.0, -2.0, 4.0, 4.0, 2.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(-2.0, 0.0, 6.0, 2.0, -9.0, 3.0, 3.0, -4.0, 5.0, -3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(5.0, 4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(-1.0, 6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(1.0, 6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(8.0, -9.0, -9.0, -6.0, 7.0, -8.0, 3.0, 0.0, -3.0, 3.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(-6.0, 1.0, 6.0, -1.0, 3.0, -4.0, 7.0, -7.0, -6.0, -3.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(-8.0, -1.0, 9.0, -6.0, 8.0, -4.0, -1.0, 0.0, -5.0, 0.0, -6.0, -2.0)) && allOk;
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
	var[0][0][2][0] = (vec3(5.0, -5.0, 7.0));
	var[0][0][2][1] = (vec3(-4.0, 8.0, -3.0));
	var[0][0][2][2] = (vec3(-2.0, 0.0, 8.0));
	var[0][0][2][3] = (vec3(-2.0, 6.0, -3.0));
	var[0][1][0][0] = (vec3(-5.0, -6.0, -3.0));
	var[0][1][0][1] = (vec3(-2.0, 5.0, 8.0));
	var[0][1][0][2] = (vec3(2.0, -9.0, 7.0));
	var[0][1][0][3] = (vec3(7.0, -3.0, 4.0));
	var[0][1][1][0] = (vec3(9.0, 4.0, 1.0));
	var[0][1][1][1] = (vec3(5.0, -9.0, 2.0));
	var[0][1][1][2] = (vec3(-7.0, -3.0, -9.0));
	var[0][1][1][3] = (vec3(9.0, -6.0, 3.0));
	var[0][1][2][0] = (vec3(-9.0, -4.0, 0.0));
	var[0][1][2][1] = (vec3(5.0, 8.0, 9.0));
	var[0][1][2][2] = (vec3(-7.0, -9.0, -5.0));
	var[0][1][2][3] = (vec3(0.0, -1.0, -6.0));
	var[1][0][0][0] = (vec3(-9.0, -2.0, -2.0));
	var[1][0][0][1] = (vec3(7.0, 9.0, -4.0));
	var[1][0][0][2] = (vec3(3.0, 1.0, 0.0));
	var[1][0][0][3] = (vec3(-9.0, -2.0, -7.0));
	var[1][0][1][0] = (vec3(-5.0, -6.0, 5.0));
	var[1][0][1][1] = (vec3(-2.0, -7.0, 5.0));
	var[1][0][1][2] = (vec3(-2.0, -6.0, 4.0));
	var[1][0][1][3] = (vec3(9.0, 5.0, -9.0));
	var[1][0][2][0] = (vec3(-3.0, 3.0, 7.0));
	var[1][0][2][1] = (vec3(3.0, -4.0, -8.0));
	var[1][0][2][2] = (vec3(-2.0, 2.0, -1.0));
	var[1][0][2][3] = (vec3(1.0, -9.0, 9.0));
	var[1][1][0][0] = (vec3(-9.0, -9.0, 9.0));
	var[1][1][0][1] = (vec3(9.0, -1.0, 8.0));
	var[1][1][0][2] = (vec3(8.0, -8.0, 4.0));
	var[1][1][0][3] = (vec3(9.0, -8.0, 8.0));
	var[1][1][1][0] = (vec3(4.0, 6.0, 1.0));
	var[1][1][1][1] = (vec3(-9.0, 7.0, 3.0));
	var[1][1][1][2] = (vec3(-4.0, -3.0, 8.0));
	var[1][1][1][3] = (vec3(-9.0, -9.0, 2.0));
	var[1][1][2][0] = (vec3(0.0, -2.0, 5.0));
	var[1][1][2][1] = (vec3(8.0, 4.0, -4.0));
	var[1][1][2][2] = (vec3(5.0, 4.0, -5.0));
	var[1][1][2][3] = (vec3(0.0, -3.0, 9.0));
	var[2][0][0][0] = (vec3(-7.0, -7.0, -7.0));
	var[2][0][0][1] = (vec3(6.0, -9.0, 3.0));
	var[2][0][0][2] = (vec3(-5.0, 2.0, 4.0));
	var[2][0][0][3] = (vec3(-2.0, -4.0, -6.0));
	var[2][0][1][0] = (vec3(-1.0, 5.0, 5.0));
	var[2][0][1][1] = (vec3(-9.0, -3.0, -9.0));
	var[2][0][1][2] = (vec3(3.0, 2.0, 0.0));
	var[2][0][1][3] = (vec3(0.0, -9.0, 7.0));
	var[2][0][2][0] = (vec3(5.0, -5.0, -2.0));
	var[2][0][2][1] = (vec3(6.0, 5.0, -4.0));
	var[2][0][2][2] = (vec3(-2.0, 9.0, -3.0));
	var[2][0][2][3] = (vec3(2.0, 5.0, -4.0));
	var[2][1][0][0] = (vec3(-4.0, -7.0, 3.0));
	var[2][1][0][1] = (vec3(6.0, 4.0, 1.0));
	var[2][1][0][2] = (vec3(-3.0, 3.0, 8.0));
	var[2][1][0][3] = (vec3(-6.0, 5.0, -6.0));
	var[2][1][1][0] = (vec3(3.0, 2.0, 3.0));
	var[2][1][1][1] = (vec3(1.0, -7.0, 3.0));
	var[2][1][1][2] = (vec3(6.0, -3.0, -2.0));
	var[2][1][1][3] = (vec3(3.0, 1.0, -1.0));
	var[2][1][2][0] = (vec3(0.0, 9.0, -4.0));
	var[2][1][2][1] = (vec3(6.0, -5.0, 0.0));
	var[2][1][2][2] = (vec3(-2.0, 4.0, 6.0));
	var[2][1][2][3] = (vec3(-5.0, 2.0, 4.0));
	var[3][0][0][0] = (vec3(6.0, 4.0, 7.0));
	var[3][0][0][1] = (vec3(1.0, -4.0, -6.0));
	var[3][0][0][2] = (vec3(4.0, -6.0, -5.0));
	var[3][0][0][3] = (vec3(5.0, 6.0, -1.0));
	var[3][0][1][0] = (vec3(6.0, 3.0, -9.0));
	var[3][0][1][1] = (vec3(-7.0, 3.0, -4.0));
	var[3][0][1][2] = (vec3(1.0, 2.0, 6.0));
	var[3][0][1][3] = (vec3(-2.0, 3.0, 7.0));
	var[3][0][2][0] = (vec3(-5.0, 8.0, -9.0));
	var[3][0][2][1] = (vec3(-4.0, -1.0, -9.0));
	var[3][0][2][2] = (vec3(5.0, 5.0, 6.0));
	var[3][0][2][3] = (vec3(-8.0, 1.0, -7.0));
	var[3][1][0][0] = (vec3(-4.0, -4.0, 0.0));
	var[3][1][0][1] = (vec3(-2.0, 5.0, 7.0));
	var[3][1][0][2] = (vec3(8.0, 8.0, -3.0));
	var[3][1][0][3] = (vec3(-9.0, -7.0, 5.0));
	var[3][1][1][0] = (vec3(6.0, -7.0, -2.0));
	var[3][1][1][1] = (vec3(0.0, 3.0, -5.0));
	var[3][1][1][2] = (vec3(-6.0, -7.0, -4.0));
	var[3][1][1][3] = (vec3(-8.0, 1.0, -7.0));
	var[3][1][2][0] = (vec3(2.0, -4.0, -7.0));
	var[3][1][2][1] = (vec3(-3.0, -4.0, 0.0));
	var[3][1][2][2] = (vec3(-8.0, -2.0, 6.0));
	var[3][1][2][3] = (vec3(-7.0, -7.0, 2.0));
}
#version 450
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
	highp mat2x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(9.0, -3.0, 5.0, -7.0, 2.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(5.0, -1.0, 2.0, -6.0, -6.0, -7.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-7.0, -8.0, -7.0, -5.0, 1.0, 3.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(-8.0, -1.0, -1.0, -6.0, 2.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(3.0, -9.0, 1.0, -9.0, 8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(1.0, -1.0, 0.0, 7.0, 2.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-9.0, -4.0, 8.0, 5.0, 6.0, -3.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-8.0, 2.0, 8.0, 5.0, -8.0, 1.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-5.0, 2.0, 7.0, -3.0, 3.0, 9.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(2.0, 2.0, -8.0, 6.0, 0.0, -1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-4.0, -2.0, -4.0, -6.0, -3.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(8.0, -7.0, 8.0, 8.0, 2.0, 3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(6.0, 6.0, 2.0, -4.0, -3.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(9.0, -6.0, -3.0, -7.0, 7.0, -7.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(0.0, 5.0, 0.0, -9.0, 3.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(9.0, 0.0, -4.0, -7.0, -7.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(-3.0, -7.0, -5.0, -4.0, -1.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(7.0, 0.0, -6.0, -2.0, 9.0, -7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(-2.0, -5.0, -2.0, -5.0, -8.0, -4.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(9.0, 0.0, 3.0, -7.0, -2.0, 6.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(2.0, -9.0, -8.0, 5.0, 3.0, -5.0, 5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	var[0][0][1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	var[0][0][2] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
	var[0][1][0] = (mat2x4(8.0, -2.0, 7.0, -7.0, -4.0, 2.0, -4.0, 0.0));
	var[0][1][1] = (mat2x4(7.0, -5.0, 6.0, -6.0, -2.0, 2.0, -8.0, 5.0));
	var[0][1][2] = (mat2x4(6.0, 8.0, -2.0, 0.0, 7.0, 9.0, 1.0, -3.0));
	var[1][0][0] = (mat2x4(-3.0, 4.0, 7.0, -8.0, -6.0, -3.0, -2.0, -9.0));
	var[1][0][1] = (mat2x4(-6.0, 7.0, 6.0, -2.0, 2.0, 7.0, 4.0, -7.0));
	var[1][0][2] = (mat2x4(-8.0, 4.0, 3.0, -6.0, -9.0, -3.0, 5.0, -6.0));
	var[1][1][0] = (mat2x4(5.0, 2.0, 9.0, 1.0, -1.0, -6.0, -3.0, -3.0));
	var[1][1][1] = (mat2x4(7.0, 4.0, 1.0, -9.0, -9.0, 4.0, 0.0, 1.0));
	var[1][1][2] = (mat2x4(-8.0, 4.0, 7.0, -7.0, -4.0, -4.0, -4.0, 1.0));
	var[2][0][0] = (mat2x4(-5.0, 8.0, 2.0, 0.0, -9.0, 1.0, -2.0, -6.0));
	var[2][0][1] = (mat2x4(0.0, 6.0, 7.0, -2.0, -1.0, -3.0, -3.0, -9.0));
	var[2][0][2] = (mat2x4(7.0, -5.0, 9.0, -1.0, -1.0, 9.0, 0.0, 7.0));
	var[2][1][0] = (mat2x4(-9.0, 3.0, 6.0, -5.0, 6.0, 4.0, 8.0, -7.0));
	var[2][1][1] = (mat2x4(-4.0, -8.0, -2.0, 8.0, -5.0, 5.0, -9.0, 9.0));
	var[2][1][2] = (mat2x4(5.0, 0.0, -8.0, -5.0, 5.0, -6.0, 9.0, 8.0));
	var[3][0][0] = (mat2x4(6.0, -8.0, -2.0, 3.0, 1.0, -8.0, -4.0, -9.0));
	var[3][0][1] = (mat2x4(-7.0, 0.0, -8.0, -1.0, 5.0, 7.0, 7.0, -3.0));
	var[3][0][2] = (mat2x4(1.0, -9.0, 2.0, -9.0, -3.0, 0.0, -4.0, 5.0));
	var[3][1][0] = (mat2x4(-9.0, -9.0, -2.0, -6.0, 7.0, 3.0, 3.0, -2.0));
	var[3][1][1] = (mat2x4(4.0, -3.0, -6.0, 4.0, -3.0, 9.0, -3.0, 0.0));
	var[3][1][2] = (mat2x4(4.0, 4.0, -6.0, 7.0, -8.0, 7.0, -1.0, -7.0));
}
#version 450
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
	highp mat3x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-7.0, -9.0, 9.0, 4.0, 9.0, 5.0, -2.0, -3.0, 8.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(1.0, 1.0, -3.0, 0.0, -6.0, -1.0, -5.0, -8.0, -9.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(9.0, 0.0, -8.0, 0.0, -8.0, 1.0, -3.0, 3.0, -4.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-4.0, -3.0, 7.0, 1.0, -8.0, -8.0, -5.0, 8.0, -6.0, 9.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-9.0, -2.0, 7.0, -7.0, 5.0, -9.0, 2.0, 8.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(-1.0, -3.0, 3.0, -5.0, 9.0, -5.0, 3.0, 9.0, 7.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(8.0, -7.0, 0.0, 6.0, 2.0, -6.0, 7.0, -8.0, -5.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(2.0, 6.0, -9.0, -2.0, 6.0, 0.0, -8.0, -1.0, -7.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(7.0, -2.0, 9.0, 0.0, 7.0, 3.0, -1.0, 8.0, 6.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(5.0, 9.0, 6.0, 2.0, 5.0, 9.0, 8.0, -5.0, -1.0, -4.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(-6.0, -2.0, -7.0, -3.0, -7.0, 3.0, -9.0, 4.0, -6.0, -1.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(5.0, 1.0, -1.0, 7.0, 1.0, 7.0, -9.0, -8.0, 8.0, -5.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(8.0, 8.0, -2.0, 8.0));
	var[0][0][0][1] = (vec4(8.0, 3.0, 5.0, -5.0));
	var[0][0][0][2] = (vec4(7.0, 6.0, -9.0, 3.0));
	var[0][0][1][0] = (vec4(0.0, -3.0, 1.0, -9.0));
	var[0][0][1][1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	var[0][0][1][2] = (vec4(9.0, 0.0, -9.0, -2.0));
	var[0][0][2][0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	var[0][0][2][1] = (vec4(1.0, -2.0, -2.0, -1.0));
	var[0][0][2][2] = (vec4(-7.0, 8.0, 0.0, -6.0));
	var[0][1][0][0] = (vec4(4.0, -1.0, 2.0, -8.0));
	var[0][1][0][1] = (vec4(-6.0, 4.0, -8.0, 9.0));
	var[0][1][0][2] = (vec4(0.0, 7.0, -2.0, 2.0));
	var[0][1][1][0] = (vec4(2.0, 9.0, -9.0, 2.0));
	var[0][1][1][1] = (vec4(1.0, 5.0, 5.0, 5.0));
	var[0][1][1][2] = (vec4(0.0, 9.0, 8.0, 7.0));
	var[0][1][2][0] = (vec4(7.0, 5.0, -7.0, -6.0));
	var[0][1][2][1] = (vec4(-4.0, 4.0, -5.0, -7.0));
	var[0][1][2][2] = (vec4(2.0, 2.0, 1.0, -7.0));
	var[1][0][0][0] = (vec4(-1.0, 7.0, -6.0, -1.0));
	var[1][0][0][1] = (vec4(-7.0, -8.0, 7.0, -8.0));
	var[1][0][0][2] = (vec4(6.0, -8.0, 2.0, -5.0));
	var[1][0][1][0] = (vec4(9.0, -7.0, 4.0, -1.0));
	var[1][0][1][1] = (vec4(-3.0, -8.0, -1.0, 1.0));
	var[1][0][1][2] = (vec4(-6.0, -4.0, -8.0, 4.0));
	var[1][0][2][0] = (vec4(5.0, 0.0, -6.0, 5.0));
	var[1][0][2][1] = (vec4(-1.0, 4.0, 3.0, -6.0));
	var[1][0][2][2] = (vec4(1.0, 8.0, -2.0, 3.0));
	var[1][1][0][0] = (vec4(1.0, -1.0, 9.0, -4.0));
	var[1][1][0][1] = (vec4(4.0, 1.0, 7.0, -4.0));
	var[1][1][0][2] = (vec4(1.0, 9.0, -7.0, 4.0));
	var[1][1][1][0] = (vec4(-2.0, 5.0, -1.0, 9.0));
	var[1][1][1][1] = (vec4(-9.0, -6.0, 3.0, 7.0));
	var[1][1][1][2] = (vec4(-1.0, -6.0, 3.0, -3.0));
	var[1][1][2][0] = (vec4(1.0, 7.0, 2.0, -9.0));
	var[1][1][2][1] = (vec4(0.0, -8.0, -8.0, 4.0));
	var[1][1][2][2] = (vec4(7.0, 6.0, 8.0, -2.0));
	var[2][0][0][0] = (vec4(-1.0, -9.0, 4.0, 9.0));
	var[2][0][0][1] = (vec4(0.0, 2.0, -7.0, -7.0));
	var[2][0][0][2] = (vec4(-1.0, 8.0, -9.0, -3.0));
	var[2][0][1][0] = (vec4(5.0, 7.0, -8.0, 1.0));
	var[2][0][1][1] = (vec4(-5.0, 0.0, -7.0, -3.0));
	var[2][0][1][2] = (vec4(-5.0, -4.0, 3.0, -5.0));
	var[2][0][2][0] = (vec4(4.0, 5.0, -9.0, -6.0));
	var[2][0][2][1] = (vec4(5.0, 3.0, -6.0, -7.0));
	var[2][0][2][2] = (vec4(-3.0, 9.0, 3.0, -7.0));
	var[2][1][0][0] = (vec4(8.0, 9.0, -2.0, -1.0));
	var[2][1][0][1] = (vec4(7.0, -4.0, -8.0, 9.0));
	var[2][1][0][2] = (vec4(-5.0, 7.0, 9.0, -6.0));
	var[2][1][1][0] = (vec4(-2.0, 8.0, -6.0, 9.0));
	var[2][1][1][1] = (vec4(-3.0, 4.0, 1.0, -8.0));
	var[2][1][1][2] = (vec4(9.0, -1.0, 4.0, 6.0));
	var[2][1][2][0] = (vec4(6.0, -5.0, -8.0, -2.0));
	var[2][1][2][1] = (vec4(-3.0, -8.0, 3.0, 8.0));
	var[2][1][2][2] = (vec4(1.0, -5.0, 7.0, 2.0));
	var[3][0][0][0] = (vec4(-9.0, -9.0, 6.0, -9.0));
	var[3][0][0][1] = (vec4(6.0, -1.0, -1.0, -4.0));
	var[3][0][0][2] = (vec4(5.0, 2.0, -6.0, 8.0));
	var[3][0][1][0] = (vec4(4.0, 2.0, 4.0, -3.0));
	var[3][0][1][1] = (vec4(9.0, 8.0, 5.0, -3.0));
	var[3][0][1][2] = (vec4(7.0, -4.0, 6.0, 4.0));
	var[3][0][2][0] = (vec4(0.0, -2.0, 1.0, 8.0));
	var[3][0][2][1] = (vec4(1.0, 4.0, 6.0, 4.0));
	var[3][0][2][2] = (vec4(-2.0, 9.0, 9.0, 7.0));
	var[3][1][0][0] = (vec4(4.0, 7.0, 0.0, -1.0));
	var[3][1][0][1] = (vec4(3.0, 8.0, -5.0, 9.0));
	var[3][1][0][2] = (vec4(-5.0, 8.0, -3.0, 1.0));
	var[3][1][1][0] = (vec4(7.0, 9.0, 3.0, -6.0));
	var[3][1][1][1] = (vec4(-1.0, -7.0, -5.0, 3.0));
	var[3][1][1][2] = (vec4(-1.0, -1.0, 9.0, 3.0));
	var[3][1][2][0] = (vec4(5.0, 6.0, -3.0, 6.0));
	var[3][1][2][1] = (vec4(-2.0, 2.0, -3.0, 0.0));
	var[3][1][2][2] = (vec4(7.0, 8.0, -4.0, -2.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(8.0, -5.0, -3.0, -5.0, 3.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-3.0, 9.0, 0.0, 7.0, 9.0, -6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(-9.0, 3.0, -7.0, -8.0, 7.0, -1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-7.0, 0.0, -1.0, -5.0, 7.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-2.0, 4.0, 6.0, -4.0, 1.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(9.0, 0.0, 1.0, -9.0, -5.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(6.0, 1.0, -3.0, -1.0, -3.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(2.0, 4.0, -4.0, 9.0, 9.0, 7.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(5.0, -9.0, -2.0, 8.0, 7.0, 0.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(8.0, -9.0, -2.0, -7.0, 6.0, -6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(4.0, -2.0, -9.0, 4.0, 9.0, 1.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(6.0, 9.0, 2.0, 5.0, -9.0, -3.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	var[0][0][1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	var[0][0][2] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
	var[0][1][0] = (mat4x2(-7.0, 4.0, -8.0, -6.0, -3.0, -4.0, 8.0, -4.0));
	var[0][1][1] = (mat4x2(6.0, -9.0, -7.0, -3.0, -9.0, -6.0, -3.0, -8.0));
	var[0][1][2] = (mat4x2(8.0, -4.0, -8.0, 4.0, 0.0, 4.0, -3.0, 8.0));
	var[1][0][0] = (mat4x2(-5.0, -9.0, -1.0, -9.0, 0.0, -4.0, 2.0, -7.0));
	var[1][0][1] = (mat4x2(-3.0, -5.0, 1.0, -5.0, -1.0, 7.0, 4.0, 4.0));
	var[1][0][2] = (mat4x2(-5.0, 2.0, -4.0, -3.0, 0.0, 4.0, -7.0, 5.0));
	var[1][1][0] = (mat4x2(0.0, 7.0, -2.0, -3.0, -5.0, 6.0, -2.0, 7.0));
	var[1][1][1] = (mat4x2(4.0, -1.0, 6.0, -2.0, 0.0, 7.0, 0.0, 2.0));
	var[1][1][2] = (mat4x2(-7.0, -7.0, -6.0, 8.0, -7.0, -4.0, 9.0, 9.0));
	var[2][0][0] = (mat4x2(1.0, -9.0, 0.0, -4.0, 2.0, 9.0, -5.0, -3.0));
	var[2][0][1] = (mat4x2(6.0, -4.0, -9.0, 5.0, -5.0, -6.0, 8.0, -5.0));
	var[2][0][2] = (mat4x2(-4.0, -5.0, 6.0, 9.0, -3.0, -4.0, 3.0, -7.0));
	var[2][1][0] = (mat4x2(4.0, -8.0, -6.0, -3.0, 8.0, -1.0, -5.0, 5.0));
	var[2][1][1] = (mat4x2(1.0, 9.0, -4.0, -5.0, 1.0, -2.0, 7.0, 1.0));
	var[2][1][2] = (mat4x2(-3.0, -1.0, 4.0, 9.0, 6.0, 3.0, -9.0, 2.0));
	var[3][0][0] = (mat4x2(-8.0, 8.0, -4.0, -6.0, 0.0, -3.0, -6.0, -4.0));
	var[3][0][1] = (mat4x2(5.0, 4.0, 5.0, 7.0, 2.0, -7.0, 8.0, -3.0));
	var[3][0][2] = (mat4x2(8.0, 7.0, 0.0, -5.0, 4.0, 5.0, -6.0, -8.0));
	var[3][1][0] = (mat4x2(-3.0, 9.0, 7.0, -5.0, -4.0, 0.0, -9.0, 9.0));
	var[3][1][1] = (mat4x2(6.0, 8.0, -4.0, -2.0, -7.0, -7.0, -4.0, 9.0));
	var[3][1][2] = (mat4x2(6.0, 7.0, -4.0, 6.0, -5.0, -4.0, 7.0, -1.0));
}
#version 450
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
	highp mat2x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(-7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(0.0, 6.0, 8.0, -9.0, 4.0, -5.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-1.0, 7.0, 9.0, 0.0, -2.0, 5.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(4.0, 8.0, 3.0, -3.0, -8.0, 8.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(-9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(-4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(-5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(6.0, -4.0, -8.0, -5.0, -4.0, 3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(0.0, 4.0, -6.0, 5.0, 2.0, 7.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-2.0, 0.0, -7.0, 8.0, -2.0, 7.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-3.0, -7.0, 2.0, -4.0, -3.0, -7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(-8.0, -2.0, 6.0, 8.0, 9.0, -4.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(3.0, 5.0, -3.0, -6.0, 8.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(-6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(-2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(-3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(-9.0, 7.0, 2.0, -1.0, 5.0, 6.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(2.0, 9.0, -9.0, -1.0, 9.0, 5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(8.0, 4.0, -3.0, 7.0, 5.0, 2.0, 7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0][0][0] = (mat2x4(-7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0, 0.0));
	var[0][0][1] = (mat2x4(1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0, 3.0));
	var[0][0][2] = (mat2x4(6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0, -8.0));
	var[0][1][0] = (mat2x4(3.0, 0.0, -3.0, 5.0, -4.0, 8.0, -3.0, 7.0));
	var[0][1][1] = (mat2x4(-1.0, 5.0, 0.0, -5.0, 2.0, -3.0, -8.0, -9.0));
	var[0][1][2] = (mat2x4(5.0, -6.0, -2.0, 0.0, 0.0, -2.0, -9.0, 3.0));
	var[1][0][0] = (mat2x4(-9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0, -5.0));
	var[1][0][1] = (mat2x4(8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0, -6.0));
	var[1][0][2] = (mat2x4(-7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0, 0.0));
	var[1][1][0] = (mat2x4(-5.0, -5.0, -6.0, 3.0, 0.0, -2.0, 5.0, -9.0));
	var[1][1][1] = (mat2x4(-9.0, 4.0, -7.0, -9.0, -2.0, 5.0, 9.0, 0.0));
	var[1][1][2] = (mat2x4(6.0, -3.0, -4.0, 0.0, -2.0, 8.0, 1.0, -3.0));
	var[2][0][0] = (mat2x4(-6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0, -5.0));
	var[2][0][1] = (mat2x4(4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0, -4.0));
	var[2][0][2] = (mat2x4(-7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0, -1.0));
	var[2][1][0] = (mat2x4(-9.0, -7.0, -5.0, -2.0, 8.0, -8.0, -8.0, -5.0));
	var[2][1][1] = (mat2x4(1.0, -1.0, 8.0, 3.0, 3.0, -4.0, 8.0, 2.0));
	var[2][1][2] = (mat2x4(5.0, -9.0, 0.0, -3.0, 2.0, -2.0, 9.0, -7.0));
	var[3][0][0] = (mat2x4(7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0, -5.0));
	var[3][0][1] = (mat2x4(3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0, 5.0));
	var[3][0][2] = (mat2x4(7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0, 8.0));
	var[3][1][0] = (mat2x4(-3.0, 5.0, -4.0, -2.0, 0.0, 2.0, -6.0, 2.0));
	var[3][1][1] = (mat2x4(3.0, 1.0, 6.0, -7.0, -8.0, -7.0, 9.0, -6.0));
	var[3][1][2] = (mat2x4(-2.0, -6.0, -8.0, -5.0, 7.0, 9.0, -5.0, -9.0));
}
#version 450
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
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-9.0, 1.0, -8.0, -1.0, -4.0, -7.0, -5.0, 8.0, -9.0, -6.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(9.0, 1.0, 3.0, 0.0, -5.0, 3.0, 4.0, -5.0, 1.0, -8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(-8.0, -6.0, 5.0, -1.0, -9.0, 2.0, -2.0, 6.0, -5.0, 2.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(-4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-8.0, -9.0, -3.0, -2.0, 8.0, 4.0, 3.0, -8.0, -6.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(-3.0, -6.0, 8.0, -2.0, 8.0, 9.0, 0.0, 1.0, -3.0, 4.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(0.0, 3.0, 4.0, -5.0, -8.0, 5.0, 0.0, 8.0, 2.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(-1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(1.0, -1.0, -1.0, -9.0, 7.0, -4.0, 0.0, -7.0, -9.0, 4.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-9.0, 6.0, -3.0, 3.0, -7.0, 3.0, -1.0, 2.0, -7.0, -4.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(1.0, 7.0, 0.0, 0.0, -4.0, 3.0, -4.0, -6.0, -7.0, -3.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(-4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(-7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(-2.0, -1.0, -2.0, -5.0, -7.0, -6.0, 8.0, -9.0, -3.0, -1.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(8.0, -4.0, -7.0, 9.0, 5.0, -7.0, 3.0, -2.0, -4.0, 2.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(4.0, -4.0, -7.0, 7.0, -2.0, 9.0, 5.0, 1.0, -9.0, 0.0, 2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0][0][0][0] = (vec3(2.0, -5.0, -3.0));
	var[0][0][0][1] = (vec3(-2.0, 2.0, -5.0));
	var[0][0][0][2] = (vec3(9.0, 4.0, 2.0));
	var[0][0][0][3] = (vec3(-4.0, 9.0, 8.0));
	var[0][0][1][0] = (vec3(-4.0, -5.0, -5.0));
	var[0][0][1][1] = (vec3(6.0, 8.0, -7.0));
	var[0][0][1][2] = (vec3(4.0, -8.0, -1.0));
	var[0][0][1][3] = (vec3(1.0, 1.0, -4.0));
	var[0][0][2][0] = (vec3(5.0, 7.0, 9.0));
	var[0][0][2][1] = (vec3(5.0, -7.0, 8.0));
	var[0][0][2][2] = (vec3(9.0, 0.0, -3.0));
	var[0][0][2][3] = (vec3(3.0, 0.0, 7.0));
	var[0][1][0][0] = (vec3(3.0, -5.0, -6.0));
	var[0][1][0][1] = (vec3(6.0, 3.0, -6.0));
	var[0][1][0][2] = (vec3(0.0, -5.0, -9.0));
	var[0][1][0][3] = (vec3(8.0, -8.0, -5.0));
	var[0][1][1][0] = (vec3(2.0, -7.0, -1.0));
	var[0][1][1][1] = (vec3(-2.0, 7.0, 4.0));
	var[0][1][1][2] = (vec3(-7.0, 7.0, -3.0));
	var[0][1][1][3] = (vec3(7.0, 6.0, 9.0));
	var[0][1][2][0] = (vec3(-2.0, 2.0, -3.0));
	var[0][1][2][1] = (vec3(-6.0, 3.0, 7.0));
	var[0][1][2][2] = (vec3(-7.0, -1.0, 0.0));
	var[0][1][2][3] = (vec3(1.0, -3.0, -6.0));
	var[1][0][0][0] = (vec3(-8.0, -7.0, 2.0));
	var[1][0][0][1] = (vec3(7.0, 5.0, 5.0));
	var[1][0][0][2] = (vec3(-7.0, 0.0, -2.0));
	var[1][0][0][3] = (vec3(9.0, -7.0, 2.0));
	var[1][0][1][0] = (vec3(-9.0, 0.0, 9.0));
	var[1][0][1][1] = (vec3(-2.0, -8.0, -9.0));
	var[1][0][1][2] = (vec3(5.0, 9.0, 0.0));
	var[1][0][1][3] = (vec3(8.0, -9.0, 2.0));
	var[1][0][2][0] = (vec3(1.0, -7.0, -7.0));
	var[1][0][2][1] = (vec3(8.0, 7.0, 8.0));
	var[1][0][2][2] = (vec3(-8.0, -5.0, 5.0));
	var[1][0][2][3] = (vec3(1.0, -3.0, 2.0));
	var[1][1][0][0] = (vec3(6.0, 2.0, -5.0));
	var[1][1][0][1] = (vec3(0.0, 4.0, 7.0));
	var[1][1][0][2] = (vec3(-6.0, -6.0, 3.0));
	var[1][1][0][3] = (vec3(8.0, 1.0, -3.0));
	var[1][1][1][0] = (vec3(-1.0, 7.0, -2.0));
	var[1][1][1][1] = (vec3(-7.0, -9.0, -8.0));
	var[1][1][1][2] = (vec3(-1.0, 4.0, 0.0));
	var[1][1][1][3] = (vec3(-2.0, -5.0, 2.0));
	var[1][1][2][0] = (vec3(-7.0, 3.0, -2.0));
	var[1][1][2][1] = (vec3(4.0, -6.0, 8.0));
	var[1][1][2][2] = (vec3(-7.0, -9.0, -4.0));
	var[1][1][2][3] = (vec3(5.0, 4.0, 1.0));
	var[2][0][0][0] = (vec3(5.0, 2.0, 2.0));
	var[2][0][0][1] = (vec3(3.0, -2.0, 5.0));
	var[2][0][0][2] = (vec3(4.0, 6.0, -1.0));
	var[2][0][0][3] = (vec3(5.0, 6.0, 1.0));
	var[2][0][1][0] = (vec3(2.0, -4.0, 9.0));
	var[2][0][1][1] = (vec3(-1.0, 6.0, 9.0));
	var[2][0][1][2] = (vec3(-1.0, -2.0, -1.0));
	var[2][0][1][3] = (vec3(-8.0, 3.0, -4.0));
	var[2][0][2][0] = (vec3(1.0, -4.0, 4.0));
	var[2][0][2][1] = (vec3(2.0, 0.0, 1.0));
	var[2][0][2][2] = (vec3(-6.0, 1.0, -7.0));
	var[2][0][2][3] = (vec3(-9.0, 8.0, 1.0));
	var[2][1][0][0] = (vec3(-1.0, 8.0, 8.0));
	var[2][1][0][1] = (vec3(3.0, -9.0, 1.0));
	var[2][1][0][2] = (vec3(-1.0, -7.0, -1.0));
	var[2][1][0][3] = (vec3(-7.0, -5.0, -5.0));
	var[2][1][1][0] = (vec3(1.0, 8.0, 5.0));
	var[2][1][1][1] = (vec3(5.0, -8.0, -8.0));
	var[2][1][1][2] = (vec3(2.0, 8.0, 2.0));
	var[2][1][1][3] = (vec3(-8.0, -6.0, -9.0));
	var[2][1][2][0] = (vec3(1.0, 5.0, 4.0));
	var[2][1][2][1] = (vec3(5.0, 1.0, -7.0));
	var[2][1][2][2] = (vec3(4.0, -5.0, 4.0));
	var[2][1][2][3] = (vec3(8.0, 8.0, -4.0));
	var[3][0][0][0] = (vec3(9.0, -4.0, 1.0));
	var[3][0][0][1] = (vec3(-5.0, 9.0, 2.0));
	var[3][0][0][2] = (vec3(-1.0, -1.0, 5.0));
	var[3][0][0][3] = (vec3(7.0, -4.0, -2.0));
	var[3][0][1][0] = (vec3(9.0, -4.0, -4.0));
	var[3][0][1][1] = (vec3(4.0, -1.0, 0.0));
	var[3][0][1][2] = (vec3(7.0, 9.0, -8.0));
	var[3][0][1][3] = (vec3(3.0, 9.0, -7.0));
	var[3][0][2][0] = (vec3(-1.0, -9.0, -7.0));
	var[3][0][2][1] = (vec3(3.0, 5.0, -7.0));
	var[3][0][2][2] = (vec3(1.0, -1.0, -5.0));
	var[3][0][2][3] = (vec3(-7.0, 7.0, -5.0));
	var[3][1][0][0] = (vec3(-2.0, -5.0, -5.0));
	var[3][1][0][1] = (vec3(-9.0, 8.0, 4.0));
	var[3][1][0][2] = (vec3(8.0, 0.0, 0.0));
	var[3][1][0][3] = (vec3(9.0, 5.0, -3.0));
	var[3][1][1][0] = (vec3(8.0, 6.0, 7.0));
	var[3][1][1][1] = (vec3(8.0, -7.0, -3.0));
	var[3][1][1][2] = (vec3(-6.0, -2.0, -6.0));
	var[3][1][1][3] = (vec3(0.0, -8.0, -6.0));
	var[3][1][2][0] = (vec3(0.0, 6.0, -1.0));
	var[3][1][2][1] = (vec3(6.0, -7.0, 7.0));
	var[3][1][2][2] = (vec3(0.0, 1.0, -8.0));
	var[3][1][2][3] = (vec3(2.0, 7.0, -6.0));
}
#version 450
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
	highp uvec2 var[][4][2];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var[0][0][0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((var[0][0][1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((var[0][1][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((var[0][1][1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((var[0][2][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((var[0][2][1]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((var[0][3][0]), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec2((var[0][3][1]), uvec2(7u, 3u)) && allOk;
	allOk = compare_uvec2((var[1][0][0]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((var[1][0][1]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((var[1][1][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[1][1][1]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((var[1][2][0]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((var[1][2][1]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((var[1][3][0]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((var[1][3][1]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((var[2][0][0]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((var[2][0][1]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[2][1][0]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((var[2][1][1]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((var[2][2][0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((var[2][2][1]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((var[2][3][0]), uvec2(4u, 8u)) && allOk;
	allOk = compare_uvec2((var[2][3][1]), uvec2(8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (uvec2(6u, 1u));
	var[0][0][1] = (uvec2(8u, 1u));
	var[0][1][0] = (uvec2(8u, 4u));
	var[0][1][1] = (uvec2(6u, 3u));
	var[0][2][0] = (uvec2(6u, 2u));
	var[0][2][1] = (uvec2(6u, 0u));
	var[0][3][0] = (uvec2(0u, 1u));
	var[0][3][1] = (uvec2(2u, 6u));
	var[1][0][0] = (uvec2(7u, 4u));
	var[1][0][1] = (uvec2(6u, 6u));
	var[1][1][0] = (uvec2(6u, 0u));
	var[1][1][1] = (uvec2(3u, 5u));
	var[1][2][0] = (uvec2(3u, 2u));
	var[1][2][1] = (uvec2(5u, 1u));
	var[1][3][0] = (uvec2(9u, 1u));
	var[1][3][1] = (uvec2(4u, 6u));
	var[2][0][0] = (uvec2(5u, 8u));
	var[2][0][1] = (uvec2(4u, 7u));
	var[2][1][0] = (uvec2(2u, 4u));
	var[2][1][1] = (uvec2(7u, 8u));
	var[2][2][0] = (uvec2(7u, 2u));
	var[2][2][1] = (uvec2(3u, 6u));
	var[2][3][0] = (uvec2(4u, 2u));
	var[2][3][1] = (uvec2(7u, 5u));
}
#version 450
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
	i16vec3 var[][4][2];
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(var[0][0][0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][0][1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][1][0]), ivec3(-1, -4, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][1][1]), ivec3(2, -8, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][2][0]), ivec3(6, -2, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][2][1]), ivec3(-6, 6, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][3][0]), ivec3(-6, 2, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][3][1]), ivec3(-4, 3, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][0][0]), ivec3(6, -5, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][0][1]), ivec3(9, 4, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][1][0]), ivec3(0, -3, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][1][1]), ivec3(-6, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][2][0]), ivec3(-4, -6, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][2][1]), ivec3(-5, -9, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][3][0]), ivec3(-1, 4, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][3][1]), ivec3(2, 8, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][0][0]), ivec3(-6, 6, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][0][1]), ivec3(2, -1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][1][0]), ivec3(5, 1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][1][1]), ivec3(8, 5, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][2][0]), ivec3(7, -7, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][2][1]), ivec3(2, 6, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][3][0]), ivec3(-8, -6, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][3][1]), ivec3(7, -5, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i16vec3(ivec3(6, 1, -2));
	var[0][0][1] = i16vec3(ivec3(-3, -1, -4));
	var[0][1][0] = i16vec3(ivec3(-5, -4, -8));
	var[0][1][1] = i16vec3(ivec3(0, 9, 6));
	var[0][2][0] = i16vec3(ivec3(-6, 7, -4));
	var[0][2][1] = i16vec3(ivec3(-8, 4, 1));
	var[0][3][0] = i16vec3(ivec3(-6, 9, -3));
	var[0][3][1] = i16vec3(ivec3(6, 8, 2));
	var[1][0][0] = i16vec3(ivec3(-2, -2, 2));
	var[1][0][1] = i16vec3(ivec3(0, -6, -2));
	var[1][1][0] = i16vec3(ivec3(5, -3, 4));
	var[1][1][1] = i16vec3(ivec3(-3, 9, 0));
	var[1][2][0] = i16vec3(ivec3(5, -4, -6));
	var[1][2][1] = i16vec3(ivec3(-6, 2, -7));
	var[1][3][0] = i16vec3(ivec3(7, -2, 2));
	var[1][3][1] = i16vec3(ivec3(5, -9, -7));
	var[2][0][0] = i16vec3(ivec3(0, -9, 2));
	var[2][0][1] = i16vec3(ivec3(-8, 6, 2));
	var[2][1][0] = i16vec3(ivec3(1, -5, 8));
	var[2][1][1] = i16vec3(ivec3(-5, 0, 7));
	var[2][2][0] = i16vec3(ivec3(-2, 2, -5));
	var[2][2][1] = i16vec3(ivec3(-3, -1, 0));
	var[2][3][0] = i16vec3(ivec3(4, -3, -4));
	var[2][3][1] = i16vec3(ivec3(-6, -4, -6));
}
#version 450
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
	highp mat2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(2.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-7.0, 8.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(-8.0, 7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(-8.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(4.0, 4.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(-3.0, -7.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(6.0, -4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(3.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(2.0, -7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(-3.0, -8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(5.0, -3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(5.0, -7.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(-3.0, -7.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(3.0, 2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(1.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-5.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(-9.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(9.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(6.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(2.0, 7.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(1.0, 2.0, 6.0, -6.0));
	var[0][0][1] = (mat2(2.0, 4.0, 4.0, 7.0));
	var[0][1][0] = (mat2(1.0, -8.0, -9.0, -7.0));
	var[0][1][1] = (mat2(1.0, -2.0, -6.0, -8.0));
	var[0][2][0] = (mat2(5.0, 1.0, -7.0, -2.0));
	var[0][2][1] = (mat2(-8.0, -9.0, 4.0, -4.0));
	var[0][3][0] = (mat2(9.0, 4.0, -3.0, -3.0));
	var[0][3][1] = (mat2(0.0, -1.0, -5.0, -6.0));
	var[1][0][0] = (mat2(0.0, 8.0, 0.0, -1.0));
	var[1][0][1] = (mat2(8.0, -4.0, -5.0, 7.0));
	var[1][1][0] = (mat2(-6.0, -6.0, 2.0, -9.0));
	var[1][1][1] = (mat2(9.0, 0.0, -3.0, -7.0));
	var[1][2][0] = (mat2(-7.0, -9.0, -5.0, 3.0));
	var[1][2][1] = (mat2(-1.0, -1.0, -6.0, -3.0));
	var[1][3][0] = (mat2(-8.0, 0.0, 8.0, 8.0));
	var[1][3][1] = (mat2(-3.0, -9.0, 5.0, -2.0));
	var[2][0][0] = (mat2(-3.0, -1.0, 0.0, 6.0));
	var[2][0][1] = (mat2(-6.0, 7.0, 4.0, -7.0));
	var[2][1][0] = (mat2(8.0, 8.0, 7.0, -3.0));
	var[2][1][1] = (mat2(7.0, 2.0, -8.0, -7.0));
	var[2][2][0] = (mat2(-9.0, -4.0, -8.0, -1.0));
	var[2][2][1] = (mat2(-8.0, 1.0, -2.0, 9.0));
	var[2][3][0] = (mat2(1.0, 9.0, -3.0, -5.0));
	var[2][3][1] = (mat2(-3.0, 5.0, 0.0, -9.0));
}
#version 450
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
	highp mat2x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(4.0, 7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(-6.0, 0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(-2.0, -2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(-1.0, -1.0, -5.0, 9.0, -1.0, -8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(-1.0, 7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(-7.0, 9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(7.0, 6.0, 2.0, -6.0, 9.0, -8.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(9.0, 4.0, -9.0, -9.0, -7.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(6.0, -8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(-1.0, -3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(3.0, -5.0, -6.0, 1.0, 6.0, -7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(4.0, -4.0, -5.0, -1.0, -7.0, 6.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	var[0][0][0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	var[0][0][1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	var[0][0][1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	var[0][1][0][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	var[0][1][0][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	var[0][1][1][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	var[0][1][1][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	var[0][2][0][0] = (vec4(-7.0, 4.0, -9.0, 1.0));
	var[0][2][0][1] = (vec4(0.0, -5.0, 6.0, -3.0));
	var[0][2][1][0] = (vec4(-9.0, -4.0, 8.0, -1.0));
	var[0][2][1][1] = (vec4(7.0, -1.0, -9.0, -2.0));
	var[0][3][0][0] = (vec4(-2.0, 4.0, 0.0, -2.0));
	var[0][3][0][1] = (vec4(9.0, -8.0, 7.0, 0.0));
	var[0][3][1][0] = (vec4(-8.0, 7.0, 0.0, 3.0));
	var[0][3][1][1] = (vec4(1.0, -9.0, -3.0, -8.0));
	var[1][0][0][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	var[1][0][0][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	var[1][0][1][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	var[1][0][1][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	var[1][1][0][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	var[1][1][0][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	var[1][1][1][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	var[1][1][1][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	var[1][2][0][0] = (vec4(-9.0, -6.0, -1.0, -3.0));
	var[1][2][0][1] = (vec4(6.0, -6.0, 2.0, 1.0));
	var[1][2][1][0] = (vec4(-3.0, -3.0, -5.0, -1.0));
	var[1][2][1][1] = (vec4(4.0, 0.0, -9.0, -1.0));
	var[1][3][0][0] = (vec4(1.0, 2.0, -4.0, -3.0));
	var[1][3][0][1] = (vec4(6.0, -7.0, 1.0, 0.0));
	var[1][3][1][0] = (vec4(-8.0, 1.0, -9.0, 2.0));
	var[1][3][1][1] = (vec4(9.0, 1.0, 2.0, -7.0));
	var[2][0][0][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	var[2][0][0][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	var[2][0][1][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	var[2][0][1][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	var[2][1][0][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	var[2][1][0][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	var[2][1][1][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	var[2][1][1][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
	var[2][2][0][0] = (vec4(1.0, -2.0, 4.0, -4.0));
	var[2][2][0][1] = (vec4(3.0, -9.0, 0.0, -4.0));
	var[2][2][1][0] = (vec4(-7.0, 7.0, 9.0, -2.0));
	var[2][2][1][1] = (vec4(5.0, -3.0, -5.0, 5.0));
	var[2][3][0][0] = (vec4(9.0, -9.0, -9.0, -8.0));
	var[2][3][0][1] = (vec4(-5.0, 8.0, 3.0, -6.0));
	var[2][3][1][0] = (vec4(-2.0, -3.0, 3.0, -1.0));
	var[2][3][1][1] = (vec4(8.0, 7.0, -4.0, -8.0));
}
#version 450
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
	allOk = compare_mat3(t[0].a, mat3(-4.0, 9.0, 3.0, -1.0, 0.0, -4.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_ivec3((t[0].b[0].a), ivec3(-9, 7, 4)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[0]), ivec2(8, 9)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[1]), ivec2(9, -2)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[2]), ivec2(-1, -7)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[3]), ivec2(-7, 6)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(8.0, -9.0, 4.0, 7.0)) && allOk;
	allOk = compare_ivec3((t[0].b[1].a), ivec3(-5, -8, 0)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[0]), ivec2(7, 1)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[1]), ivec2(-2, -4)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[2]), ivec2(1, 3)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[3]), ivec2(-6, -1)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(-7.0, -8.0, 8.0, 1.0)) && allOk;
	allOk = compare_ivec3((t[0].b[2].a), ivec3(-8, -6, 4)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[0]), ivec2(4, 4)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[1]), ivec2(8, 6)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[2]), ivec2(-6, 9)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[3]), ivec2(-3, 8)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(-3.0, -8.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(t[1].a, mat3(-3.0, 5.0, 2.0, 6.0, -8.0, 2.0, 1.0, 5.0, -2.0)) && allOk;
	allOk = compare_ivec3((t[1].b[0].a), ivec3(0, 7, 7)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[0]), ivec2(9, -5)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[1]), ivec2(2, 5)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[2]), ivec2(-4, 3)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[3]), ivec2(-4, 7)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-7.0, 6.0, 8.0, 9.0)) && allOk;
	allOk = compare_ivec3((t[1].b[1].a), ivec3(-2, 6, 8)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[0]), ivec2(3, -9)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[1]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[2]), ivec2(6, 9)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[3]), ivec2(5, 9)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(-1.0, 1.0, 3.0, 9.0)) && allOk;
	allOk = compare_ivec3((t[1].b[2].a), ivec3(0, -3, -3)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[0]), ivec2(-7, -5)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[1]), ivec2(4, -9)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[2]), ivec2(0, 5)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[3]), ivec2(9, 2)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(-9.0, -9.0, 1.0, -1.0)) && allOk;
	allOk = compare_uint((u), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(0, 7, -4));
	s.b[0] = (ivec2(-7, 3));
	s.b[1] = (ivec2(2, 8));
	s.b[2] = (ivec2(2, -9));
	s.b[3] = (ivec2(5, -5));
	s.c = (vec4(3.0, -9.0, 6.0, 9.0));
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
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(8, -2, -3)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(7.0, -2.0, -2.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(-6, -5, -6)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(3.0, -2.0, -2.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(-2, -1, -5)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(-9.0, 0.0, -8.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(7, -1, -7)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(1.0, -6.0, 8.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(3, -8, -7)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-4.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(9, 0, -9)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(1.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(2, -1, 2)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(1.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(4, -4, 6)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(9.0, -8.0, 0.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(3, -4, 1)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(-6, 6, 4)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-6.0, -8.0, -8.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(3, 9, 6)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(-6.0, 2.0, -4.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(-6, -7, 2)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(-5.0, -8.0, -3.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(-2.0, 5.0, 6.0, -1.0));
	block[0].s[0][0].a = (ivec3(-7, 3, 2));
	block[0].s[0][0].c = (vec4(-9.0, -4.0, 2.0, -4.0));
	block[0].s[0][1].a = (ivec3(1, 8, -4));
	block[0].s[0][1].c = (vec4(-6.0, 4.0, 4.0, 0.0));
	block[0].s[1][0].a = (ivec3(-9, -5, 6));
	block[0].s[1][0].c = (vec4(-6.0, -7.0, -6.0, -8.0));
	block[0].s[1][1].a = (ivec3(1, -2, -2));
	block[0].s[1][1].c = (vec4(6.0, -4.0, -1.0, -2.0));
	block[0].s[2][0].a = (ivec3(-7, 7, 4));
	block[0].s[2][0].c = (vec4(3.0, 1.0, -8.0, 3.0));
	block[0].s[2][1].a = (ivec3(0, -3, -5));
	block[0].s[2][1].c = (vec4(3.0, 0.0, -5.0, -5.0));
	block[1].v = (vec4(-7.0, 5.0, 1.0, -5.0));
	block[1].s[0][0].a = (ivec3(1, -5, 6));
	block[1].s[0][0].c = (vec4(-2.0, -6.0, -5.0, -6.0));
	block[1].s[0][1].a = (ivec3(-9, 0, 2));
	block[1].s[0][1].c = (vec4(5.0, 3.0, -8.0, 3.0));
	block[1].s[1][0].a = (ivec3(-3, 0, 6));
	block[1].s[1][0].c = (vec4(-1.0, 6.0, 8.0, -7.0));
	block[1].s[1][1].a = (ivec3(1, 9, -3));
	block[1].s[1][1].c = (vec4(0.0, 7.0, 6.0, 3.0));
	block[2].v = (vec4(-4.0, -5.0, -9.0, -2.0));
	block[2].s[0][0].a = (ivec3(1, 3, -3));
	block[2].s[0][0].c = (vec4(-3.0, 1.0, -4.0, 0.0));
	block[2].s[0][1].a = (ivec3(5, -9, 1));
	block[2].s[0][1].c = (vec4(-4.0, -7.0, 6.0, 7.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 0.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-2.0, -7.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(7.0, 0.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 5.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(3.0, -1.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-3.0, 5.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -4.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(2.0, 8.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2(3.0, 1.0, -4.0, -2.0));
	block[1].var = (mat2(1.0, -4.0, -1.0, -3.0));
	block[2].var = (mat2(-8.0, 5.0, -6.0, -2.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	float16_t padding;
	f16vec4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block[0].padding), -8.0) && allOk;
	allOk = compare_f16vec4(vec4(block[0].var), vec4(-9.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_float16_t(float(block[1].padding), -8.0) && allOk;
	allOk = compare_f16vec4(vec4(block[1].var), vec4(-8.0, -3.0, -8.0, 6.0)) && allOk;
	allOk = compare_float16_t(float(block[2].padding), 1.0) && allOk;
	allOk = compare_f16vec4(vec4(block[2].var), vec4(-8.0, 4.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = float16_t(9.0);
	block[0].var = f16vec4(vec4(-6.0, 2.0, -8.0, -7.0));
	block[1].padding = float16_t(-4.0);
	block[1].var = f16vec4(vec4(2.0, -5.0, 9.0, 1.0));
	block[2].padding = float16_t(-6.0);
	block[2].var = f16vec4(vec4(3.0, -1.0, 4.0, -1.0));
}
#version 450
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
	lowp vec2 a[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp mat4x3 b;
	lowp mat3x2 c;
	mediump int d[];
};
layout(std140, binding = 3) buffer BlockD
{
	bool e;
	mediump ivec3 f[2];
	lowp float g[3];
	highp uint h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(b, mat4x3(9.0, -5.0, 0.0, 3.0, 7.0, -1.0, -8.0, 2.0, 8.0, -2.0, -2.0, 4.0)) && allOk;
	allOk = compare_bool((e), false) && allOk;
	allOk = compare_ivec3((f[0]), ivec3(-2, 8, 0)) && allOk;
	allOk = compare_ivec3((f[1]), ivec3(2, 2, -2)) && allOk;
	allOk = compare_float((g[0]), 3.0) && allOk;
	allOk = compare_float((g[1]), -6.0) && allOk;
	allOk = compare_float((g[2]), 7.0) && allOk;
	allOk = compare_uint((h), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat4x3(-9.0, 0.0, 9.0, 2.0, -6.0, 6.0, -6.0, 3.0, 5.0, -8.0, -7.0, -8.0));
	d[0] = (8);
	d[1] = (-1);
	d[2] = (-4);
	d[3] = (0);
	d[4] = (-4);
	d[5] = (2);
	d[6] = (1);
	e = (false);
	f[0] = (ivec3(9, -3, -2));
	f[1] = (ivec3(-6, -2, 5));
	h = (1u);
}
#version 450
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
	layout(offset = 8) highp uvec2 b[1];
	layout(offset = 16) highp int c;
	layout(offset = 20) highp uvec2 d;
	layout(offset = 32) mediump uvec4 e;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp ivec4 f;
	layout(offset = 16) mediump uvec4 g;
	layout(offset = 32) mediump uvec4 h;
	layout(offset = 48) bvec3 i;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(2, 5)) && allOk;
	allOk = compare_int((blockB.c), -9) && allOk;
	allOk = compare_uvec4((blockB.e), uvec4(0u, 4u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((g), uvec4(6u, 5u, 7u, 4u)) && allOk;
	allOk = compare_bvec3((i), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(-1, -4));
	blockB.b[0] = (uvec2(2u, 8u));
	blockB.c = (2);
	blockB.d = (uvec2(2u, 5u));
	blockB.e = (uvec4(2u, 5u, 2u, 2u));
	f = (ivec4(4, -8, 9, -2));
	h = (uvec4(8u, 0u, 8u, 0u));
	i = (bvec3(true, true, false));
}
#version 450
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
	layout(offset = 0) mediump vec2 a[1];
	layout(offset = 8) bool b;
	layout(offset = 16) lowp vec4 c;
	layout(offset = 32) lowp vec4 d[1];
	layout(offset = 48) highp uint e;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp ivec2 f;
	layout(offset = 16) highp ivec3 g;
	layout(offset = 32) lowp vec4 h;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec3 i;
	layout(offset = 16) lowp uvec4 j[1];
	layout(offset = 32) lowp uvec2 k;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) highp ivec4 l;
	layout(offset = 16) bool m;
	layout(offset = 20) bool n;
	layout(offset = 24) highp vec2 o;
	layout(offset = 32) highp ivec2 p;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b), true) && allOk;
	allOk = compare_ivec2((blockC.f), ivec2(2, -2)) && allOk;
	allOk = compare_ivec3((blockC.g), ivec3(-4, 7, -1)) && allOk;
	allOk = compare_vec4((blockC.h), vec4(-1.0, -9.0, 4.0, 0.0)) && allOk;
	allOk = compare_bvec3((blockD.i), bvec3(true, true, true)) && allOk;
	allOk = compare_uvec2((blockD.k), uvec2(0u, 6u)) && allOk;
	allOk = compare_bool((m), false) && allOk;
	allOk = compare_bool((n), true) && allOk;
	allOk = compare_vec2((o), vec2(6.0, 2.0)) && allOk;
	allOk = compare_ivec2((p), ivec2(7, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec2(-1.0, -1.0));
	blockB.b = (false);
	blockB.c = (vec4(9.0, 5.0, 9.0, 5.0));
	blockB.d[0] = (vec4(-5.0, -6.0, -5.0, 9.0));
	blockB.e = (7u);
	blockC.f = (ivec2(6, 2));
	blockC.g = (ivec3(7, 9, -4));
	blockC.h = (vec4(-5.0, -1.0, -4.0, -4.0));
	blockD.i = (bvec3(true, true, false));
	blockD.j[0] = (uvec4(9u, 5u, 4u, 7u));
	blockD.k = (uvec2(4u, 3u));
	l = (ivec4(6, 1, -3, -4));
	p = (ivec2(0, 2));
}
#version 450
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
	mediump mat3 mB[6];
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	bvec4 a;
	lowp mat2 b[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	highp uint c;
	sA d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((c), 0u) && allOk;
	allOk = compare_mat3x2(d[0].mA, mat3x2(-5.0, -9.0, -3.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3(d[0].mB[0], mat3(5.0, -8.0, 5.0, 7.0, -2.0, -8.0, -3.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3(d[0].mB[1], mat3(2.0, 7.0, 5.0, -6.0, -5.0, 6.0, -3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(d[0].mB[2], mat3(-5.0, -6.0, -1.0, 3.0, 8.0, 3.0, 1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3(d[0].mB[3], mat3(0.0, 4.0, 8.0, -6.0, 9.0, 9.0, 9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(d[0].mB[4], mat3(-5.0, 8.0, 3.0, -1.0, -6.0, -6.0, 7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3(d[0].mB[5], mat3(-6.0, 3.0, -9.0, 5.0, -2.0, 1.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(d[1].mA, mat3x2(9.0, 7.0, 6.0, 2.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3(d[1].mB[0], mat3(-6.0, -3.0, -5.0, 4.0, 3.0, 3.0, 4.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3(d[1].mB[1], mat3(6.0, -9.0, 5.0, -8.0, 6.0, -4.0, -1.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3(d[1].mB[2], mat3(9.0, -5.0, -6.0, -7.0, -2.0, 9.0, -5.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(d[1].mB[3], mat3(0.0, -5.0, 1.0, -1.0, -2.0, -1.0, -8.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(d[1].mB[4], mat3(-4.0, -7.0, 5.0, -9.0, -2.0, -9.0, -6.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(d[1].mB[5], mat3(-7.0, -5.0, -3.0, 6.0, -3.0, 7.0, 0.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(d[2].mA, mat3x2(8.0, 0.0, 8.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3(d[2].mB[0], mat3(-6.0, 5.0, -5.0, -9.0, -4.0, 4.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat3(d[2].mB[1], mat3(1.0, -2.0, 7.0, 5.0, 0.0, -9.0, 0.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3(d[2].mB[2], mat3(3.0, -4.0, -6.0, 4.0, 2.0, -9.0, 0.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(d[2].mB[3], mat3(9.0, 2.0, 4.0, -7.0, 0.0, -3.0, 2.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(d[2].mB[4], mat3(4.0, -9.0, 2.0, -8.0, -9.0, 7.0, -3.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(d[2].mB[5], mat3(9.0, 5.0, 7.0, -5.0, -1.0, 7.0, -8.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(d[3].mA, mat3x2(-1.0, 5.0, -1.0, 1.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3(d[3].mB[0], mat3(2.0, 7.0, -7.0, -4.0, 6.0, 9.0, 4.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat3(d[3].mB[1], mat3(1.0, 1.0, -8.0, 2.0, 5.0, -7.0, -1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3(d[3].mB[2], mat3(-2.0, 9.0, 7.0, 5.0, 9.0, -7.0, -2.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3(d[3].mB[3], mat3(1.0, -8.0, 6.0, -8.0, -2.0, 9.0, -8.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat3(d[3].mB[4], mat3(3.0, -1.0, -1.0, 9.0, 6.0, -1.0, 3.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(d[3].mB[5], mat3(-4.0, 0.0, 0.0, 0.0, 3.0, 8.0, -9.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(d[4].mA, mat3x2(-5.0, 1.0, 2.0, 4.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3(d[4].mB[0], mat3(2.0, 3.0, 8.0, -6.0, 1.0, 5.0, 4.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3(d[4].mB[1], mat3(-8.0, -9.0, 2.0, 4.0, -9.0, 2.0, -3.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(d[4].mB[2], mat3(-4.0, 0.0, 5.0, 0.0, -4.0, -8.0, -4.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat3(d[4].mB[3], mat3(5.0, -8.0, 6.0, -5.0, 2.0, 2.0, 0.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(d[4].mB[4], mat3(-9.0, 6.0, 2.0, 0.0, -2.0, 3.0, 4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat3(d[4].mB[5], mat3(-3.0, 5.0, 1.0, 0.0, -5.0, -5.0, -1.0, -8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat2(-3.0, 3.0, 5.0, -9.0));
	blockB.b[1] = (mat2(5.0, 5.0, 2.0, 6.0));
	blockB.b[2] = (mat2(-5.0, -8.0, -8.0, -6.0));
	blockB.b[3] = (mat2(9.0, 7.0, 0.0, 1.0));
	c = (3u);
	d[0].mA = (mat3x2(1.0, -3.0, -5.0, -9.0, -5.0, -8.0));
	d[0].mB[0] = (mat3(6.0, 6.0, 6.0, 5.0, -2.0, -6.0, 7.0, 1.0, -1.0));
	d[0].mB[1] = (mat3(9.0, 2.0, 3.0, 5.0, 0.0, -8.0, 8.0, 2.0, -1.0));
	d[0].mB[2] = (mat3(8.0, 8.0, 2.0, 1.0, 8.0, -3.0, -7.0, 9.0, 2.0));
	d[0].mB[3] = (mat3(-7.0, -3.0, 8.0, -6.0, 3.0, -1.0, -9.0, 3.0, 8.0));
	d[0].mB[4] = (mat3(3.0, 2.0, -6.0, 4.0, 7.0, 8.0, -3.0, -4.0, -2.0));
	d[0].mB[5] = (mat3(5.0, -8.0, -2.0, -1.0, -7.0, -3.0, -5.0, -4.0, 2.0));
	d[1].mA = (mat3x2(3.0, 4.0, 2.0, 9.0, -4.0, 6.0));
	d[1].mB[0] = (mat3(7.0, -4.0, 7.0, -1.0, 5.0, 9.0, 2.0, -7.0, 7.0));
	d[1].mB[1] = (mat3(3.0, -9.0, -7.0, -1.0, -8.0, 4.0, -1.0, 2.0, -2.0));
	d[1].mB[2] = (mat3(2.0, 9.0, 0.0, -8.0, -9.0, 5.0, 2.0, 4.0, 8.0));
	d[1].mB[3] = (mat3(8.0, 5.0, 5.0, -7.0, 8.0, -3.0, -2.0, 6.0, 7.0));
	d[1].mB[4] = (mat3(-2.0, -8.0, -9.0, -6.0, 9.0, 9.0, 7.0, 3.0, 1.0));
	d[1].mB[5] = (mat3(5.0, -9.0, 6.0, 9.0, -2.0, 0.0, 7.0, -3.0, -3.0));
	d[2].mA = (mat3x2(-6.0, -2.0, 0.0, -6.0, 9.0, -2.0));
	d[2].mB[0] = (mat3(-1.0, 0.0, 8.0, -7.0, 5.0, 6.0, 0.0, 6.0, 1.0));
	d[2].mB[1] = (mat3(-5.0, 1.0, 5.0, 4.0, -4.0, 5.0, 1.0, -3.0, 7.0));
	d[2].mB[2] = (mat3(-7.0, 9.0, 4.0, 9.0, -3.0, -7.0, 0.0, 8.0, 4.0));
	d[2].mB[3] = (mat3(-9.0, 5.0, -1.0, 0.0, 2.0, -5.0, 6.0, 7.0, -1.0));
	d[2].mB[4] = (mat3(4.0, -6.0, 3.0, 9.0, 5.0, 9.0, 2.0, -6.0, -2.0));
	d[2].mB[5] = (mat3(-7.0, 0.0, -4.0, 0.0, 8.0, -4.0, 8.0, 2.0, -8.0));
	d[3].mA = (mat3x2(-3.0, 1.0, -5.0, 8.0, -3.0, 5.0));
	d[3].mB[0] = (mat3(-6.0, 3.0, 8.0, 9.0, -3.0, 5.0, -9.0, -6.0, 7.0));
	d[3].mB[1] = (mat3(-6.0, 3.0, 1.0, -1.0, -1.0, -3.0, 5.0, 0.0, 1.0));
	d[3].mB[2] = (mat3(-5.0, 1.0, 5.0, 1.0, 3.0, 7.0, 2.0, 7.0, -5.0));
	d[3].mB[3] = (mat3(-6.0, 6.0, 3.0, 4.0, 3.0, 8.0, 0.0, -5.0, -3.0));
	d[3].mB[4] = (mat3(9.0, -9.0, -3.0, -2.0, -9.0, -4.0, 3.0, -4.0, 2.0));
	d[3].mB[5] = (mat3(-8.0, 8.0, -3.0, 7.0, 8.0, -9.0, 2.0, -5.0, -5.0));
	d[4].mA = (mat3x2(-7.0, 3.0, 9.0, -5.0, 6.0, 1.0));
	d[4].mB[0] = (mat3(1.0, -1.0, -9.0, -3.0, -6.0, 7.0, -4.0, 4.0, 9.0));
	d[4].mB[1] = (mat3(-3.0, -8.0, 5.0, 1.0, -3.0, -2.0, -4.0, 6.0, 2.0));
	d[4].mB[2] = (mat3(4.0, 0.0, -6.0, -8.0, 7.0, -8.0, 8.0, 2.0, -9.0));
	d[4].mB[3] = (mat3(6.0, -3.0, -1.0, 6.0, 3.0, 4.0, 2.0, 2.0, 3.0));
	d[4].mB[4] = (mat3(-2.0, -9.0, 6.0, 0.0, 9.0, -4.0, -1.0, 3.0, -9.0));
	d[4].mB[5] = (mat3(1.0, 4.0, 4.0, 6.0, 9.0, -9.0, 1.0, 7.0, 2.0));
}
#version 450
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
	lowp uint a;
	lowp mat3x4 b;
	lowp int c;
	lowp mat4x2 d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[nonuniformEXT(0)].a), 9u) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(1)].a), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (9u);
	blockB[nonuniformEXT(0)].b = (mat3x4(-2.0, 6.0, 5.0, 6.0, -1.0, 0.0, 4.0, 7.0, -6.0, 9.0, 8.0, -5.0));
	blockB[nonuniformEXT(0)].d = (mat4x2(-2.0, 0.0, 7.0, 9.0, 4.0, -4.0, 7.0, -5.0));
	blockB[nonuniformEXT(1)].a = (4u);
	blockB[nonuniformEXT(1)].b = (mat3x4(9.0, -2.0, -6.0, -3.0, -7.0, -4.0, -4.0, -6.0, -6.0, 8.0, 6.0, 8.0));
	blockB[nonuniformEXT(1)].d = (mat4x2(-7.0, 2.0, -1.0, -1.0, 4.0, 4.0, -7.0, -6.0));
}
#version 450
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
	lowp float a;
	highp mat3x4 b[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp uvec2 c;
	lowp mat4x2 d;
	mediump mat3 e;
	bvec2 f[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	int16_t g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockC.f[0]), bvec2(false, false)) && allOk;
	allOk = compare_int16_t(int(g[0]), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (6.0);
	blockC.d = (mat4x2(-6.0, -9.0, 9.0, -9.0, 9.0, 8.0, -1.0, -4.0));
	blockC.f[0] = (bvec2(false, false));
	g[0] = int16_t(-3);
}
#version 450
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
	f16vec2 a;
	highp mat3x2 b;
	lowp mat2 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(a), vec2(4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(b, mat3x2(-4.0, 7.0, 4.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2(c[0], mat2(-5.0, -8.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = f16vec2(vec2(-5.0, 4.0));
	b = (mat3x2(-9.0, -7.0, -8.0, 8.0, 4.0, 6.0));
	c[0] = (mat2(-5.0, -5.0, -7.0, 5.0));
}
#version 450
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
	lowp mat4x2 mA;
	bvec2 mB;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	highp uvec2 a[2];
	mediump mat2x3 b;
	uint16_t c;
	sA d;
	lowp mat3x4 e[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	lowp ivec2 f;
	lowp uint g;
	f16vec2 h;
	float16_t i;
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	lowp uvec4 j;
	f16vec2 k[];
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	mediump float l;
	i16vec4 m;
	lowp mat4x2 n;
	i16vec4 o;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a[0]), uvec2(8u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.a[1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uint16_t(uint(blockB.c), 3u) && allOk;
	allOk = compare_mat4x2(blockB.d.mA, mat4x2(-9.0, -9.0, -7.0, 9.0, -3.0, -8.0, 6.0, 0.0)) && allOk;
	allOk = compare_bvec2((blockB.d.mB), bvec2(false, true)) && allOk;
	allOk = compare_mat3x4(blockB.e[0], mat3x4(-1.0, -7.0, -7.0, 6.0, 9.0, -1.0, -1.0, 6.0, 1.0, 1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockB.e[1], mat3x4(-6.0, 8.0, -2.0, 4.0, 0.0, -1.0, 1.0, -8.0, -9.0, 5.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockB.e[2], mat3x4(9.0, 1.0, -6.0, 1.0, 0.0, -5.0, -7.0, -9.0, 6.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockB.e[3], mat3x4(3.0, 8.0, -2.0, 1.0, -3.0, 0.0, 0.0, 0.0, -7.0, -9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockB.e[4], mat3x4(5.0, 3.0, -1.0, 1.0, 1.0, -7.0, 8.0, 8.0, 0.0, -2.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockB.e[5], mat3x4(-8.0, 0.0, -6.0, 5.0, -8.0, -5.0, -5.0, 8.0, -6.0, -4.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockB.e[6], mat3x4(-9.0, -8.0, 4.0, -7.0, 6.0, 6.0, 9.0, 3.0, -9.0, -7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockB.e[7], mat3x4(-3.0, -7.0, 0.0, -8.0, -1.0, 6.0, 0.0, -2.0, -9.0, 4.0, -6.0, 2.0)) && allOk;
	allOk = compare_ivec2((blockC.f), ivec2(-3, -4)) && allOk;
	allOk = compare_uint((blockC.g), 7u) && allOk;
	allOk = compare_f16vec2(vec2(blockC.h), vec2(3.0, 6.0)) && allOk;
	allOk = compare_uvec4((blockD.j), uvec4(3u, 9u, 9u, 6u)) && allOk;
	allOk = compare_float((l), -8.0) && allOk;
	allOk = compare_i16vec4(ivec4(o), ivec4(6, -4, 9, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = uint16_t(4u);
	blockB.d.mA = (mat4x2(4.0, -2.0, 5.0, -9.0, -3.0, -1.0, -9.0, 1.0));
	blockB.d.mB = (bvec2(false, false));
	blockC.g = (3u);
	blockD.j = (uvec4(1u, 3u, 0u, 4u));
	m = i16vec4(ivec4(7, -6, -5, -1));
	n = (mat4x2(9.0, -7.0, 5.0, -3.0, -2.0, 8.0, -4.0, -2.0));
}
#version 450
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
	highp mat3 a[8];
	lowp mat4 b;
	u16vec3 c;
	u16vec3 d[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	mediump mat4x3 e[];
} blockC;
layout(std140, row_major, binding = 3) readonly buffer BlockD
{
	int16_t f;
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	i16vec2 g[1][4];
	bool h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(a[0], mat3(2.0, 5.0, 9.0, -9.0, -9.0, -4.0, 4.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3(a[1], mat3(7.0, 5.0, 1.0, -2.0, 6.0, 3.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(a[2], mat3(3.0, 8.0, 8.0, -6.0, 2.0, -6.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat3(a[3], mat3(8.0, -6.0, -5.0, -9.0, -3.0, -5.0, 3.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat3(a[4], mat3(8.0, -9.0, -4.0, 1.0, 1.0, -4.0, -5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3(a[5], mat3(4.0, -2.0, 2.0, -1.0, 8.0, -8.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(a[6], mat3(-1.0, -8.0, -7.0, 4.0, -5.0, 4.0, 7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3(a[7], mat3(-1.0, -8.0, 8.0, 0.0, -3.0, 1.0, -6.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(b, mat4(9.0, -5.0, -9.0, 7.0, -6.0, 1.0, -3.0, -7.0, 1.0, -6.0, -2.0, -6.0, -8.0, 0.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockC.e[0], mat4x3(4.0, -7.0, -8.0, -9.0, 9.0, 4.0, 6.0, 9.0, 3.0, -8.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockC.e[1], mat4x3(9.0, -3.0, 8.0, -8.0, -1.0, 9.0, -7.0, -6.0, -7.0, -2.0, 0.0, 9.0)) && allOk;
	allOk = compare_int16_t(int(blockD.f), -3) && allOk;
	allOk = compare_bool((h[0]), true) && allOk;
	allOk = compare_bool((h[1]), false) && allOk;
	allOk = compare_bool((h[2]), false) && allOk;
	allOk = compare_bool((h[3]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat4(8.0, 2.0, -3.0, -3.0, -6.0, -5.0, 3.0, 3.0, 0.0, -4.0, -9.0, 0.0, -3.0, -8.0, 8.0, -7.0));
	c = u16vec3(uvec3(7u, 0u, 1u));
	d[0] = u16vec3(uvec3(5u, 0u, 5u));
	d[1] = u16vec3(uvec3(3u, 3u, 4u));
	d[2] = u16vec3(uvec3(1u, 5u, 7u));
	blockC.e[0] = (mat4x3(1.0, -7.0, 6.0, -4.0, -8.0, -9.0, 8.0, 6.0, 0.0, 4.0, -8.0, -6.0));
	blockC.e[1] = (mat4x3(-3.0, -5.0, -9.0, -5.0, 7.0, -8.0, 3.0, 0.0, 9.0, 5.0, -9.0, 3.0));
	h[0] = (false);
	h[1] = (true);
	h[2] = (false);
	h[3] = (false);
}
#version 450
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
	mediump vec4 b;
	mediump mat3x4 c[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	lowp vec4 d;
	highp int e;
	mediump mat4x3 f[];
} blockC[2];
layout(std140, binding = 3) buffer BlockD
{
	mediump float g;
	highp uint h;
	highp ivec4 i;
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.c[0], mat3x4(8.0, 6.0, -2.0, -6.0, 4.0, -6.0, -3.0, 2.0, -9.0, -7.0, -5.0, -7.0)) && allOk;
	allOk = compare_vec4((blockC[0].d), vec4(3.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_int((blockC[0].e), 0) && allOk;
	allOk = compare_mat4x3(blockC[0].f[0], mat4x3(-5.0, 0.0, -7.0, 0.0, 3.0, 1.0, 1.0, -5.0, -8.0, -8.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].f[1], mat4x3(0.0, 7.0, 6.0, 1.0, -6.0, -8.0, 8.0, -9.0, -8.0, -3.0, -5.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC[1].d), vec4(3.0, 8.0, 4.0, -1.0)) && allOk;
	allOk = compare_int((blockC[1].e), 3) && allOk;
	allOk = compare_mat4x3(blockC[1].f[0], mat4x3(-6.0, -4.0, -2.0, 8.0, 9.0, 4.0, -6.0, 9.0, 0.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].f[1], mat4x3(-8.0, -9.0, -7.0, 2.0, -3.0, -1.0, 4.0, 0.0, 1.0, 7.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].f[2], mat4x3(-7.0, -8.0, -5.0, 1.0, -5.0, 9.0, -5.0, 5.0, 4.0, 6.0, -2.0, 7.0)) && allOk;
	allOk = compare_float((blockD[0].g), -1.0) && allOk;
	allOk = compare_ivec4((blockD[0].i), ivec4(2, 0, -9, 8)) && allOk;
	allOk = compare_float((blockD[1].g), 3.0) && allOk;
	allOk = compare_ivec4((blockD[1].i), ivec4(-1, 0, -2, -9)) && allOk;
	allOk = compare_float((blockD[2].g), 1.0) && allOk;
	allOk = compare_ivec4((blockD[2].i), ivec4(-3, -4, 0, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = (mat3x4(8.0, 7.0, 1.0, 2.0, -5.0, 9.0, -6.0, -3.0, 9.0, 4.0, 0.0, 4.0));
	blockC[0].d = (vec4(5.0, -2.0, 4.0, -6.0));
	blockC[0].e = (5);
	blockC[0].f[0] = (mat4x3(-4.0, -5.0, -9.0, 9.0, 8.0, -1.0, 1.0, -5.0, -6.0, 4.0, 4.0, 9.0));
	blockC[0].f[1] = (mat4x3(-8.0, -2.0, -2.0, -4.0, 3.0, 5.0, -9.0, 1.0, -3.0, 9.0, -6.0, 4.0));
	blockC[1].d = (vec4(7.0, -1.0, -2.0, 2.0));
	blockC[1].e = (-2);
	blockC[1].f[0] = (mat4x3(1.0, 0.0, 8.0, 0.0, 7.0, 2.0, 2.0, -3.0, 2.0, -9.0, -5.0, -2.0));
	blockC[1].f[1] = (mat4x3(-1.0, -2.0, -6.0, 4.0, 2.0, -4.0, -3.0, -3.0, 3.0, -1.0, -1.0, -8.0));
	blockC[1].f[2] = (mat4x3(6.0, -3.0, -1.0, 7.0, 0.0, -9.0, -3.0, 7.0, 0.0, -2.0, 3.0, 3.0));
	blockD[0].g = (-4.0);
	blockD[0].h = (4u);
	blockD[0].i = (ivec4(0, 2, -2, -7));
	blockD[1].g = (-2.0);
	blockD[1].h = (0u);
	blockD[1].i = (ivec4(-8, 1, 1, -6));
	blockD[2].g = (-1.0);
	blockD[2].h = (1u);
	blockD[2].i = (ivec4(5, -2, 8, -2));
}
#version 450
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
	layout(offset = 0) mediump uvec2 a;
	layout(offset = 8) uint16_t b;
	layout(offset = 10) i16vec3 c;
} blockB[3];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp uvec4 d;
	layout(offset = 16) u16vec2 e;
} blockC;

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[0].a), uvec2(7u, 9u)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[0].c), ivec3(9, -1, 0)) && allOk;
	allOk = compare_uvec2((blockB[1].a), uvec2(7u, 4u)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[1].c), ivec3(0, 3, -3)) && allOk;
	allOk = compare_uvec2((blockB[2].a), uvec2(0u, 3u)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[2].c), ivec3(8, -3, 8)) && allOk;
	allOk = compare_uvec4((blockC.d), uvec4(4u, 8u, 9u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.e), uvec2(4u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = uint16_t(2u);
	blockB[1].b = uint16_t(1u);
	blockB[2].b = uint16_t(9u);
	blockC.e = u16vec2(uvec2(6u, 8u));
}
#version 450
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
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) u16vec4 b;
	layout(offset = 8) lowp uvec2 c;
	layout(offset = 16) f16vec3 d;
};
layout(binding = 3) readonly buffer BlockD
{
	layout(offset = 0) mediump ivec2 e;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) i16vec3 f;
	layout(offset = 8) mediump uvec2 g;
	layout(offset = 16) uint16_t h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a), vec4(7.0, -7.0, 0.0, -3.0)) && allOk;
	allOk = compare_u16vec4(uvec4(b), uvec4(3u, 4u, 7u, 2u)) && allOk;
	allOk = compare_uvec2((c), uvec2(4u, 3u)) && allOk;
	allOk = compare_f16vec3(vec3(d), vec3(0.0, -9.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockD.e), ivec2(7, -8)) && allOk;
	allOk = compare_uint16_t(uint(h), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec4(vec4(5.0, 6.0, 1.0, -5.0));
	b = u16vec4(uvec4(6u, 0u, 6u, 2u));
	c = (uvec2(5u, 3u));
	d = f16vec3(vec3(-5.0, 7.0, 4.0));
	f = i16vec3(ivec3(-3, 1, 7));
	g = (uvec2(6u, 6u));
	h = uint16_t(5u);
}
#version 450
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
	layout(offset = 16) bvec3 b[1];
	layout(offset = 32) f16vec4 c;
	layout(offset = 40) i16vec2 d;
	layout(offset = 44) int16_t e;
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp vec2 f[1];
	layout(offset = 16) highp vec3 g;
	layout(offset = 32) highp vec2 h;
	layout(offset = 40) f16vec2 i;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump int j;
	layout(offset = 4) u16vec2 k;
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[0].a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec3((blockB[0].b[0]), bvec3(false, true, false)) && allOk;
	allOk = compare_vec2((blockC.f[0]), vec2(0.0, -1.0)) && allOk;
	allOk = compare_vec2((blockC.h), vec2(-4.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.i), vec2(-5.0, -3.0)) && allOk;
	allOk = compare_int((blockD[0].j), -4) && allOk;
	allOk = compare_u16vec2(uvec2(blockD[0].k), uvec2(9u, 2u)) && allOk;
	allOk = compare_int((blockD[1].j), 1) && allOk;
	allOk = compare_u16vec2(uvec2(blockD[1].k), uvec2(9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec4(true, false, true, false));
	blockB[0].c = f16vec4(vec4(-9.0, -4.0, -3.0, 2.0));
	blockB[0].d = i16vec2(ivec2(4, 5));
	blockB[0].e = int16_t(8);
	blockC.f[0] = (vec2(2.0, -6.0));
	blockC.g = (vec3(4.0, -5.0, -5.0));
	blockC.h = (vec2(-9.0, -7.0));
	blockD[0].j = (8);
	blockD[0].k = u16vec2(uvec2(3u, 5u));
	blockD[1].j = (1);
	blockD[1].k = u16vec2(uvec2(4u, 7u));
}
#version 450
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
	layout(offset = 0) i16vec4 a;
	layout(offset = 8) f16vec2 b;
	layout(offset = 16) highp ivec4 c;
	layout(offset = 32) highp vec2 d;
	layout(offset = 40) f16vec3 e;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) f16vec4 f;
	layout(offset = 8) i16vec4 g[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB.b), vec2(-4.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB.d), vec2(2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.e), vec3(-1.0, -5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec4(ivec4(7, 7, 1, -6));
	blockB.c = (ivec4(3, -5, -9, -8));
	blockB.d = (vec2(3.0, -3.0));
	blockB.e = f16vec3(vec3(-6.0, 0.0, -8.0));
	f = f16vec4(vec4(-3.0, -7.0, 1.0, 0.0));
	g[0] = i16vec4(ivec4(1, -4, 2, -7));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(binding = 1) readonly buffer BlockB
{
	layout(offset = 0) highp uvec2 a[1];
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp uvec4 b;
	layout(offset = 16) highp int c;
	layout(offset = 20) float16_t d;
} blockC[1];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp uvec3 e;
	layout(offset = 16) lowp uvec4 f;
} blockD[3];

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a[0]), uvec2(6u, 8u)) && allOk;
	allOk = compare_uvec4((blockC[0].b), uvec4(4u, 0u, 7u, 0u)) && allOk;
	allOk = compare_int((blockC[0].c), 9) && allOk;
	allOk = compare_float16_t(float(blockC[0].d), -7.0) && allOk;
	allOk = compare_uvec4((blockD[0].f), uvec4(2u, 0u, 4u, 2u)) && allOk;
	allOk = compare_uvec4((blockD[1].f), uvec4(7u, 3u, 6u, 6u)) && allOk;
	allOk = compare_uvec4((blockD[2].f), uvec4(0u, 1u, 7u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].c = (8);
	blockC[0].d = float16_t(2.0);
	blockD[0].e = (uvec3(3u, 0u, 7u));
	blockD[0].f = (uvec4(9u, 7u, 7u, 7u));
	blockD[1].e = (uvec3(7u, 2u, 2u));
	blockD[1].f = (uvec4(1u, 6u, 2u, 7u));
	blockD[2].e = (uvec3(5u, 2u, 0u));
	blockD[2].f = (uvec4(2u, 7u, 2u, 4u));
}
#version 450
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
	lowp mat3x4 mA;
	u16vec4 mB;
};
layout(scalar, row_major, binding = 1) readonly buffer BlockB
{
	mediump mat3x2 a;
	u16vec2 b;
	lowp mat4x2 c;
	u16vec2 d;
	lowp mat3x4 e[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	sA f;
	mediump vec3 g;
	lowp uvec3 h[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(6.0, -9.0, 8.0, -4.0, 4.0, 4.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.b), uvec2(0u, 1u)) && allOk;
	allOk = compare_mat4x2(blockB.c, mat4x2(2.0, -1.0, -8.0, -5.0, 2.0, -5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockC.f.mA, mat3x4(5.0, -3.0, 0.0, 4.0, 2.0, 4.0, -1.0, 6.0, 1.0, -9.0, 3.0, 3.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.f.mB), uvec4(8u, 7u, 9u, 1u)) && allOk;
	allOk = compare_vec3((blockC.g), vec3(0.0, -4.0, 0.0)) && allOk;
	allOk = compare_uvec3((blockC.h[0]), uvec3(5u, 7u, 5u)) && allOk;
	allOk = compare_uvec3((blockC.h[1]), uvec3(7u, 5u, 2u)) && allOk;
	allOk = compare_uvec3((blockC.h[2]), uvec3(4u, 6u, 9u)) && allOk;
	allOk = compare_uvec3((blockC.h[3]), uvec3(3u, 0u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.f.mA = (mat3x4(6.0, 9.0, -5.0, 2.0, -5.0, -6.0, 0.0, -5.0, 7.0, 4.0, -1.0, -2.0));
	blockC.f.mB = u16vec4(uvec4(4u, 2u, 5u, 5u));
	blockC.g = (vec3(6.0, 9.0, -8.0));
	blockC.h[0] = (uvec3(0u, 4u, 9u));
	blockC.h[1] = (uvec3(0u, 2u, 9u));
	blockC.h[2] = (uvec3(7u, 2u, 3u));
	blockC.h[3] = (uvec3(5u, 6u, 4u));
}
#version 450
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
	i16vec4 a[];
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	mediump int b;
	float16_t c[];
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	highp vec4 d;
	bvec4 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.a[0]), ivec4(-3, -8, -6, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.a[1]), ivec4(9, 3, 9, -7)) && allOk;
	allOk = compare_float16_t(float(blockC.c[0]), -5.0) && allOk;
	allOk = compare_float16_t(float(blockC.c[1]), 9.0) && allOk;
	allOk = compare_float16_t(float(blockC.c[2]), 5.0) && allOk;
	allOk = compare_float16_t(float(blockC.c[3]), 6.0) && allOk;
	allOk = compare_vec4((d), vec4(-9.0, 5.0, 5.0, -7.0)) && allOk;
	allOk = compare_bvec4((e[0]), bvec4(true, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = i16vec4(ivec4(-9, -7, -4, 8));
	blockB.a[1] = i16vec4(ivec4(-8, -9, 8, 2));
	blockC.b = (-6);
	blockC.c[0] = float16_t(-3.0);
	blockC.c[1] = float16_t(1.0);
	blockC.c[2] = float16_t(6.0);
	blockC.c[3] = float16_t(3.0);
	d = (vec4(-5.0, -2.0, -7.0, 5.0));
	e[0] = (bvec4(false, true, true, true));
}
#version 450
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
	lowp mat3x4 a;
	mediump float b;
	highp mat3x2 c;
	f16vec4 d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].a, mat3x4(0.0, 2.0, -8.0, 6.0, 7.0, 5.0, -6.0, 1.0, 9.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].a, mat3x4(-1.0, 7.0, -5.0, -4.0, 3.0, -5.0, -3.0, -1.0, 1.0, 0.0, -3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat3x4(6.0, -1.0, 0.0, 3.0, -7.0, 6.0, -7.0, 6.0, -8.0, -4.0, -6.0, 3.0));
	blockB[nonuniformEXT(0)].b = (-2.0);
	blockB[nonuniformEXT(0)].c = (mat3x2(5.0, -2.0, 6.0, 7.0, -5.0, -5.0));
	blockB[nonuniformEXT(0)].d = f16vec4(vec4(-2.0, -2.0, 7.0, -2.0));
	blockB[nonuniformEXT(1)].a = (mat3x4(1.0, 3.0, -9.0, -2.0, -7.0, 9.0, -9.0, 4.0, -1.0, 8.0, 4.0, -4.0));
	blockB[nonuniformEXT(1)].b = (0.0);
	blockB[nonuniformEXT(1)].c = (mat3x2(7.0, 6.0, 5.0, 3.0, 3.0, -4.0));
	blockB[nonuniformEXT(1)].d = f16vec4(vec4(-6.0, 4.0, 2.0, -6.0));
}
#version 450
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
	lowp uint a;
	highp mat2x3 b;
	highp mat3x4 c[1];
	bvec3 d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB[nonuniformEXT(0)].b, mat2x3(-8.0, 7.0, 0.0, -4.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].c[0], mat3x4(-8.0, 5.0, 1.0, -7.0, -6.0, 6.0, 8.0, 7.0, 4.0, -6.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(1)].b, mat2x3(2.0, -7.0, 9.0, 3.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].c[0], mat3x4(1.0, 6.0, 6.0, 7.0, 1.0, -3.0, -4.0, 5.0, 3.0, 8.0, 6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (mat2x3(-2.0, -6.0, 0.0, -1.0, 6.0, 9.0));
	blockB[nonuniformEXT(0)].c[0] = (mat3x4(5.0, 6.0, 5.0, 4.0, 4.0, 7.0, -2.0, 7.0, 8.0, -5.0, 7.0, 0.0));
	blockB[nonuniformEXT(1)].b = (mat2x3(-7.0, -2.0, 8.0, -6.0, -4.0, -6.0));
	blockB[nonuniformEXT(1)].c[0] = (mat3x4(-4.0, -6.0, -7.0, -7.0, 6.0, 8.0, -1.0, 2.0, -3.0, -6.0, 4.0, -1.0));
}
#version 450
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
	highp vec4 a;
	u8vec2 b;
	u8vec4 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a), vec4(4.0, -1.0, 1.0, 6.0)) && allOk;
	allOk = compare_u8vec2(uvec2(b), uvec2(8u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(c), uvec4(7u, 1u, 5u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(5.0, 7.0, -9.0, -6.0));
	b = u8vec2(uvec2(5u, 7u));
	c = u8vec4(uvec4(9u, 5u, 9u, 4u));
}
#version 450
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
	u8vec3 a[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	i8vec2 b;
	i8vec4 c;
	mediump mat3 d;
	u8vec2 e[1];
	mediump vec4 f;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockC.b), ivec2(6, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.c), ivec4(9, 4294967290, 4294967292, 2)) && allOk;
	allOk = compare_mat3(blockC.d, mat3(-9.0, 6.0, 8.0, -9.0, -6.0, -5.0, -8.0, 7.0, -7.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.e[0]), uvec2(9u, 9u)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(-2.0, -7.0, 4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = u8vec3(uvec3(4u, 9u, 2u));
	blockC.c = i8vec4(ivec4(4294967294, 4294967295, 4294967293, 4294967287));
	blockC.d = (mat3(-9.0, -2.0, -4.0, -4.0, 3.0, 4.0, 9.0, 1.0, 2.0));
	blockC.e[0] = u8vec2(uvec2(9u, 9u));
	blockC.f = (vec4(9.0, 2.0, -1.0, -7.0));
}
#version 450
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
	mediump ivec4 b[4];
	uint8_t c;
	u8vec2 d[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump vec2 e;
	highp ivec4 f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -7.0) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.d[0]), uvec2(6u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.d[1]), uvec2(9u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.d[2]), uvec2(1u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.d[3]), uvec2(8u, 8u)) && allOk;
	allOk = compare_vec2((e), vec2(-5.0, 4.0)) && allOk;
	allOk = compare_ivec4((f), ivec4(-7, 0, -9, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-6.0);
	blockB.b[0] = (ivec4(-2, 3, -5, -4));
	blockB.b[1] = (ivec4(5, -9, 8, 1));
	blockB.b[2] = (ivec4(9, 5, -4, -9));
	blockB.b[3] = (ivec4(-3, 7, 3, 2));
	blockB.c = uint8_t(2u);
	blockB.d[0] = u8vec2(uvec2(3u, 0u));
	blockB.d[1] = u8vec2(uvec2(2u, 7u));
	blockB.d[2] = u8vec2(uvec2(5u, 9u));
	blockB.d[3] = u8vec2(uvec2(5u, 9u));
	e = (vec2(3.0, -1.0));
	f = (ivec4(4, 1, -8, -8));
}
#version 450
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
	u8vec2 a[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	mediump vec2 b;
	i8vec3 c;
	lowp int d;
	highp uvec3 e[];
} blockC[2];
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp vec3 f;
	highp vec3 g[];
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.a[0]), uvec2(8u, 2u)) && allOk;
	allOk = compare_int((blockC[0].d), -2) && allOk;
	allOk = compare_uvec3((blockC[0].e[0]), uvec3(4u, 5u, 3u)) && allOk;
	allOk = compare_int((blockC[1].d), -8) && allOk;
	allOk = compare_uvec3((blockC[1].e[0]), uvec3(8u, 5u, 4u)) && allOk;
	allOk = compare_vec3((blockD[0].f), vec3(-3.0, 0.0, -1.0)) && allOk;
	allOk = compare_vec3((blockD[0].g[0]), vec3(-7.0, -7.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD[1].f), vec3(9.0, -1.0, -1.0)) && allOk;
	allOk = compare_vec3((blockD[1].g[0]), vec3(6.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3((blockD[2].f), vec3(7.0, 2.0, -6.0)) && allOk;
	allOk = compare_vec3((blockD[2].g[0]), vec3(8.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = u8vec2(uvec2(9u, 2u));
	blockC[0].b = (vec2(9.0, 4.0));
	blockC[0].c = i8vec3(ivec3(1, 4294967289, 4294967292));
	blockC[0].d = (-4);
	blockC[0].e[0] = (uvec3(2u, 9u, 4u));
	blockC[1].b = (vec2(4.0, -2.0));
	blockC[1].c = i8vec3(ivec3(5, 4294967287, 4294967293));
	blockC[1].d = (-1);
	blockC[1].e[0] = (uvec3(5u, 9u, 1u));
	blockD[0].f = (vec3(7.0, 8.0, 9.0));
	blockD[1].f = (vec3(5.0, 6.0, 5.0));
	blockD[2].f = (vec3(3.0, -7.0, -4.0));
}
#version 450
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
	lowp uvec4 mB;
	mediump uvec3 mC;
	mediump vec3 mD;
};
struct sB
{
	lowp vec3 mA;
	sA mB;
	lowp mat4x2 mC;
	mediump mat4x2 mD;
};
layout(std140, binding = 1) buffer BlockB
{
	u8vec4 a;
	uint8_t b;
	highp int c;
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	uint8_t d;
	highp int e;
} blockC[1];
layout(std430, row_major, binding = 3) buffer BlockD
{
	sB f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockC[0].d), 1u) && allOk;
	allOk = compare_int((blockC[0].e), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	b = uint8_t(9u);
	c = (5);
	blockC[0].d = uint8_t(8u);
	blockC[0].e = (8);
	f[0].mA = (vec3(1.0, 9.0, 5.0));
	f[0].mB.mA = u8vec3(uvec3(4u, 1u, 2u));
	f[0].mB.mB = (uvec4(2u, 7u, 5u, 9u));
	f[0].mB.mC = (uvec3(2u, 4u, 3u));
	f[0].mB.mD = (vec3(7.0, -5.0, -3.0));
	f[0].mC = (mat4x2(-9.0, 1.0, 8.0, 4.0, -8.0, 3.0, -5.0, -9.0));
	f[0].mD = (mat4x2(7.0, 7.0, -2.0, 3.0, -9.0, -9.0, -9.0, 1.0));
	f[1].mA = (vec3(-4.0, -9.0, -3.0));
	f[1].mB.mA = u8vec3(uvec3(2u, 3u, 0u));
	f[1].mB.mB = (uvec4(5u, 9u, 5u, 1u));
	f[1].mB.mC = (uvec3(6u, 8u, 2u));
	f[1].mB.mD = (vec3(-8.0, 6.0, -4.0));
	f[1].mC = (mat4x2(-3.0, 1.0, 8.0, 8.0, 5.0, 9.0, 8.0, 2.0));
	f[1].mD = (mat4x2(-8.0, -6.0, -6.0, 6.0, -7.0, 6.0, 3.0, 0.0));
}
#version 450
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
	mediump mat4x2 a[6];
	i8vec2 b[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(b[0]), ivec2(4294967293, 4294967292)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = i8vec2(ivec2(2, 4294967294));
}
#version 450
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
	layout(offset = 0) lowp uint a[1];
	layout(offset = 4) u8vec2 b;
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp uint c;
	layout(offset = 4) highp ivec2 d;
} blockC;

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[0].a[0]), 3u) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[0].b), uvec2(1u, 1u)) && allOk;
	allOk = compare_uint((blockB[1].a[0]), 9u) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[1].b), uvec2(6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = u8vec2(uvec2(0u, 0u));
	blockB[1].b = u8vec2(uvec2(1u, 7u));
	blockC.c = (4u);
	blockC.d = (ivec2(-8, 8));
}
#version 450
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
	layout(offset = 0) bvec3 a;
	layout(offset = 16) mediump uvec4 b;
	layout(offset = 32) highp ivec2 c;
	layout(offset = 40) uint8_t d;
} blockB[3];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump ivec3 e;
	layout(offset = 12) mediump int f;
	layout(offset = 16) highp uvec4 g;
	layout(offset = 32) bvec3 h;
} blockC[3];

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

layout(std140, binding = 1) readonly buffer Block
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

}
#version 450
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
	mediump uvec4 var;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var), uvec4(1u, 4u, 9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, binding = 1) readonly buffer Block
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

layout(std140, binding = 1) readonly buffer Block
{
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(4.0, 5.0, -8.0, -9.0, -9.0, 3.0, 9.0, 1.0, 7.0, 0.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(-8.0, -1.0, -2.0, -5.0, -8.0, -3.0, 4.0, -5.0, -8.0, 3.0, 2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[0][3], -3.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[1][2], -4.0) && allOk;
	allOk = compare_float(var[1][3], -3.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 5.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[2][3], 4.0) && allOk;
	allOk = compare_float(var[3][0], 7.0) && allOk;
	allOk = compare_float(var[3][1], -6.0) && allOk;
	allOk = compare_float(var[3][2], -9.0) && allOk;
	allOk = compare_float(var[3][3], -4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-6.0, 3.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-4.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-9.0, 5.0, -9.0, 4.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(7.0, -6.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4(var, mat4(-3.0, 2.0, 9.0, -4.0, -9.0, -4.0, -5.0, -8.0, 0.0, -8.0, 6.0, -4.0, -6.0, -7.0, -3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(-4.0, 1.0, -2.0, -6.0, 1.0, 6.0, -7.0, 4.0, 3.0, -5.0, 1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], 6.0) && allOk;
	allOk = compare_float(var[0][2], -4.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[2][0], 4.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], -1.0) && allOk;
	allOk = compare_float(var[3][2], 1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(4.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-1.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(4.0, -2.0, -6.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-4.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp ivec2 var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), -1) && allOk;
	allOk = compare_ivec2((var), ivec2(-7, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[1][0], -9.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[1][2], -6.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], 5.0) && allOk;
	allOk = compare_float(var[2][2], -2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(3.0, 1.0, -8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-9.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(6.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[2][0], 5.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, 0.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x4(var, mat3x4(-1.0, -5.0, -6.0, 6.0, 0.0, -7.0, 9.0, -6.0, 0.0, 3.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, binding = 1) readonly buffer Block
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

}
#version 450
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
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x3(var[0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	i8vec3 var[3];
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(var[0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2]), ivec3(7, 9, 4294967292)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat4x3(var[0], mat4x3(1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat4x3(var[0], mat4x3(1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat4x3(var[0], mat4x3(6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4(var[0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(-3.0, 4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(-6.0, -2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(0.0, -2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(-2.0, -2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(1.0, -7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(-2.0, -9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(1.0, 6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp ivec3 var[];
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var[0]), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((var[1]), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((var[2]), ivec3(3, -1, -7)) && allOk;
	allOk = compare_ivec3((var[3]), ivec3(-1, 2, 9)) && allOk;
	allOk = compare_ivec3((var[4]), ivec3(-8, 4, 9)) && allOk;
	allOk = compare_ivec3((var[5]), ivec3(-3, -3, -9)) && allOk;
	allOk = compare_ivec3((var[6]), ivec3(9, 3, -6)) && allOk;
	allOk = compare_ivec3((var[7]), ivec3(-6, 7, 3)) && allOk;
	allOk = compare_ivec3((var[8]), ivec3(6, 9, 0)) && allOk;
	allOk = compare_ivec3((var[9]), ivec3(5, 8, 2)) && allOk;
	allOk = compare_ivec3((var[10]), ivec3(7, -7, 2)) && allOk;
	allOk = compare_ivec3((var[11]), ivec3(1, -4, 0)) && allOk;
	allOk = compare_ivec3((var[12]), ivec3(2, -2, 7)) && allOk;
	allOk = compare_ivec3((var[13]), ivec3(5, 2, 0)) && allOk;
	allOk = compare_ivec3((var[14]), ivec3(9, 6, 7)) && allOk;
	allOk = compare_ivec3((var[15]), ivec3(0, 4, -6)) && allOk;
	allOk = compare_ivec3((var[16]), ivec3(1, 7, 4)) && allOk;
	allOk = compare_ivec3((var[17]), ivec3(-6, 9, 3)) && allOk;
	allOk = compare_ivec3((var[18]), ivec3(1, 5, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(3.0, 7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(4.0, 9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-9.0, -9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(-2.0, -1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(-4.0, 9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(6.0, -4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(0.0, 5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-3.0, -7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(8.0, 4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(1.0, 8.0, -5.0, -5.0, -8.0, -4.0, -7.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(-5.0, -8.0, 6.0, 4.0, -3.0, 9.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(-2.0, 7.0, -4.0, 4.0, -4.0, 1.0, 6.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(2.0, -6.0, 4.0, -6.0, 8.0, 1.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(6.0, 5.0, 5.0, -1.0, -9.0, -7.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(0.0, -7.0, 0.0, -4.0, 1.0, -7.0, 1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(2.0, -4.0, -2.0, -7.0, 2.0, -2.0, 9.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp ivec2 var[];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var[0]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((var[1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((var[2]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((var[3]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((var[4]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((var[5]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((var[6]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((var[7]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((var[8]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((var[9]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((var[10]), ivec2(-8, 3)) && allOk;
	allOk = compare_ivec2((var[11]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((var[12]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((var[13]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((var[14]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((var[15]), ivec2(-4, -3)) && allOk;
	allOk = compare_ivec2((var[16]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((var[17]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((var[18]), ivec2(6, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump ivec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.var), ivec3(-9, 4, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (ivec3(-7, 5, -6));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -8.0) && allOk;
	allOk = compare_float(block.var[0][1], 4.0) && allOk;
	allOk = compare_float(block.var[0][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], -7.0) && allOk;
	allOk = compare_float(block.var[1][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][2], -3.0) && allOk;
	allOk = compare_float(block.var[2][0], -8.0) && allOk;
	allOk = compare_float(block.var[2][1], -5.0) && allOk;
	allOk = compare_float(block.var[2][2], -9.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-8.0, 4.0, 5.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-7.0, -2.0, -3.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-8.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(0.0, 7.0, -3.0, -8.0, 8.0, -8.0, -6.0, 5.0, -2.0));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(7.0, -6.0, 3.0, 6.0, 7.0, -2.0, -2.0, 0.0, 5.0, -3.0, -7.0, -1.0, 9.0, 7.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-2.0, 5.0, 7.0, -2.0));
	block.var[1] = (vec4(-7.0, -4.0, 0.0, 8.0));
	block.var[2] = (vec4(-8.0, 9.0, 5.0, 8.0));
	block.var[3] = (vec4(0.0, 8.0, -5.0, 4.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block.var[0][0], -8.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], 4.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][2], -8.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-8.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-2.0, 8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-3.0, -5.0, -7.0));
	block.var[1] = (vec3(-3.0, 1.0, -6.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -1.0) && allOk;
	allOk = compare_float(block.var[0][1], -9.0) && allOk;
	allOk = compare_float(block.var[1][0], 4.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_float(block.var[2][0], 3.0) && allOk;
	allOk = compare_float(block.var[2][1], -5.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-1.0, -9.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(4.0, 5.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-2.0, 9.0, -5.0, -5.0, -7.0, -2.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
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
	allOk = compare_mat4(block.var, mat4(2.0, 7.0, 4.0, -4.0, -1.0, -9.0, -2.0, 4.0, -5.0, -5.0, -7.0, -8.0, 5.0, 2.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(2.0, 0.0, -9.0, -5.0, 3.0, -8.0, 5.0, -4.0, 0.0, 1.0, 6.0, -2.0, -7.0, -5.0, 0.0, -5.0));
}
#version 450
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
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][2], 4.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-3.0, -7.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-1.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(2.0, 5.0, 6.0));
	block.var[1] = (vec3(-7.0, 5.0, 4.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][0], -5.0) && allOk;
	allOk = compare_float(block.var[2][1], -4.0) && allOk;
	allOk = compare_float(block.var[3][0], -7.0) && allOk;
	allOk = compare_float(block.var[3][1], 5.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-6.0, -5.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-5.0, -4.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-5.0, 6.0));
	block.var[1] = (vec2(4.0, 3.0));
	block.var[2] = (vec2(-5.0, -6.0));
	block.var[3] = (vec2(-8.0, -8.0));
}
#version 450
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
	mediump uvec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.padding), 8u) && allOk;
	allOk = compare_uvec3((block.var), uvec3(5u, 9u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6u);
	block.var = (uvec3(0u, 5u, 1u));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat3(block.var, mat3(-8.0, 7.0, 3.0, -2.0, -8.0, -1.0, 4.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0] = (vec3(4.0, 6.0, -7.0));
	block.var[1] = (vec3(9.0, -1.0, -5.0));
	block.var[2] = (vec3(5.0, 3.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_float(block.var[0][0], 6.0) && allOk;
	allOk = compare_float(block.var[0][1], 0.0) && allOk;
	allOk = compare_float(block.var[0][2], -7.0) && allOk;
	allOk = compare_float(block.var[0][3], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], -9.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_float(block.var[1][2], -8.0) && allOk;
	allOk = compare_float(block.var[1][3], 6.0) && allOk;
	allOk = compare_float(block.var[2][0], 7.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_float(block.var[2][2], 3.0) && allOk;
	allOk = compare_float(block.var[2][3], 1.0) && allOk;
	allOk = compare_float(block.var[3][0], 7.0) && allOk;
	allOk = compare_float(block.var[3][1], 8.0) && allOk;
	allOk = compare_float(block.var[3][2], -7.0) && allOk;
	allOk = compare_float(block.var[3][3], 4.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(6.0, 0.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-9.0, -9.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(7.0, 0.0, 3.0, 1.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(7.0, 8.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (9.0);
	block.var = (mat4(1.0, 8.0, -8.0, -6.0, 2.0, -9.0, 7.0, -2.0, 8.0, 7.0, 2.0, -8.0, 1.0, -6.0, 1.0, -9.0));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat2x3(block.var, mat2x3(1.0, 0.0, 2.0, 1.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var = (mat2x3(-5.0, 9.0, 0.0, 5.0, 3.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat3x4(block.var, mat3x4(8.0, 1.0, -1.0, 5.0, -1.0, 6.0, 8.0, 5.0, 2.0, 0.0, 9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0] = (vec4(4.0, 5.0, 9.0, -8.0));
	block.var[1] = (vec4(-7.0, -1.0, -4.0, 6.0));
	block.var[2] = (vec4(3.0, -1.0, -4.0, -1.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat3x4(block.var, mat3x4(-1.0, -5.0, -6.0, 6.0, 0.0, -7.0, 9.0, -6.0, 0.0, 3.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0] = (vec4(9.0, -6.0, 8.0, -2.0));
	block.var[1] = (vec4(6.0, 9.0, -3.0, 9.0));
	block.var[2] = (vec4(2.0, -9.0, -9.0, 2.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat4x2(block.var, mat4x2(8.0, 6.0, 0.0, 0.0, 2.0, -4.0, 2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var = (mat4x2(-4.0, 5.0, 9.0, -4.0, -2.0, 6.0, -6.0, -9.0));
}
#version 450
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
	u8vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.padding), 3u) && allOk;
	allOk = compare_u8vec4(uvec4(block.var), uvec4(4u, 6u, 8u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint8_t(9u);
	block.var = u8vec4(uvec4(5u, 9u, 4u, 6u));
}
#version 450
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
	float16_t var[3];
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
    if (allOk)
        ac_numPassed++;

	block.var[0] = float16_t(-8.0);
	block.var[1] = float16_t(9.0);
	block.var[2] = float16_t(-2.0);
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat2(block.var[0], mat2(-4.0, -1.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(-6.0, -6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-5.0, -8.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0] = (mat2(2.0, -8.0, -6.0, 2.0));
	block.var[1] = (mat2(-3.0, 9.0, -5.0, 4.0));
	block.var[2] = (mat2(-2.0, -6.0, -9.0, -2.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat2(block.var[0], mat2(3.0, 2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(2.0, 1.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(2.0, 4.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var[0][0] = (vec2(-4.0, 5.0));
	block.var[0][1] = (vec2(1.0, -8.0));
	block.var[1][0] = (vec2(-1.0, 9.0));
	block.var[1][1] = (vec2(-8.0, 5.0));
	block.var[2][0] = (vec2(-4.0, 5.0));
	block.var[2][1] = (vec2(-2.0, 9.0));
}
#version 450
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_mat3x4(block.var[0], mat3x4(-8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0, -2.0, -5.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0, 9.0, -2.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0, 8.0, -3.0, 3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0] = (mat3x4(-6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0, 6.0, 4.0, -6.0, -9.0));
	block.var[1] = (mat3x4(-4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0, 9.0, -2.0, 3.0, -7.0));
	block.var[2] = (mat3x4(-1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0, 6.0, 0.0, 4.0, -9.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat3x4(block.var[0], mat3x4(7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0] = (vec4(-5.0, 2.0, 5.0, -2.0));
	block.var[0][1] = (vec4(-3.0, 9.0, -2.0, -6.0));
	block.var[0][2] = (vec4(7.0, 4.0, -6.0, 2.0));
	block.var[1][0] = (vec4(6.0, 9.0, -2.0, 7.0));
	block.var[1][1] = (vec4(9.0, 0.0, 0.0, 8.0));
	block.var[1][2] = (vec4(-3.0, 0.0, 3.0, -6.0));
	block.var[2][0] = (vec4(1.0, 9.0, 6.0, -9.0));
	block.var[2][1] = (vec4(-9.0, 2.0, -4.0, -8.0));
	block.var[2][2] = (vec4(5.0, -1.0, 9.0, 8.0));
}
#version 450
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
	f16vec2 var[3];
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
	allOk = compare_f16vec2(vec2(block.var[0]), vec2(-3.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1]), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2]), vec2(3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = float16_t(-2.0);
	block.var[0] = f16vec2(vec2(4.0, -2.0));
	block.var[1] = f16vec2(vec2(4.0, -1.0));
	block.var[2] = f16vec2(vec2(1.0, 9.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(3.0, 9.0, -7.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(6.0, 5.0, -8.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(-2.0, -2.0, 2.0, 9.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(-5.0, -3.0, -1.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(9.0, 2.0, -2.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(9.0, -1.0, -8.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(9.0, -9.0, -8.0, -9.0, -7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(1.0, -1.0, 1.0));
	block.var[0][1] = (vec3(-3.0, 9.0, -8.0));
	block.var[1][0] = (vec3(-5.0, 6.0, 6.0));
	block.var[1][1] = (vec3(3.0, -3.0, 7.0));
	block.var[2][0] = (vec3(-9.0, -2.0, -7.0));
	block.var[2][1] = (vec3(7.0, 0.0, -8.0));
	block.var[3][0] = (vec3(0.0, -5.0, 5.0));
	block.var[3][1] = (vec3(-2.0, 4.0, -8.0));
	block.var[4][0] = (vec3(-3.0, -4.0, 7.0));
	block.var[4][1] = (vec3(-3.0, -1.0, -9.0));
	block.var[5][0] = (vec3(2.0, -3.0, 6.0));
	block.var[5][1] = (vec3(-4.0, 8.0, 2.0));
	block.var[6][0] = (vec3(6.0, -2.0, 0.0));
	block.var[6][1] = (vec3(3.0, 4.0, -6.0));
	block.var[7][0] = (vec3(3.0, -6.0, 2.0));
	block.var[7][1] = (vec3(4.0, -8.0, 0.0));
	block.var[8][0] = (vec3(-3.0, 3.0, 5.0));
	block.var[8][1] = (vec3(-6.0, -8.0, 8.0));
	block.var[9][0] = (vec3(4.0, -9.0, -1.0));
	block.var[9][1] = (vec3(-6.0, 7.0, -3.0));
	block.var[10][0] = (vec3(2.0, -2.0, 4.0));
	block.var[10][1] = (vec3(-3.0, -5.0, 9.0));
	block.var[11][0] = (vec3(-8.0, -1.0, 7.0));
	block.var[11][1] = (vec3(2.0, 0.0, 5.0));
	block.var[12][0] = (vec3(0.0, 9.0, -7.0));
	block.var[12][1] = (vec3(5.0, 6.0, -3.0));
	block.var[13][0] = (vec3(-6.0, 0.0, -3.0));
	block.var[13][1] = (vec3(7.0, 9.0, -2.0));
	block.var[14][0] = (vec3(-7.0, 6.0, -7.0));
	block.var[14][1] = (vec3(8.0, -6.0, 8.0));
	block.var[15][0] = (vec3(4.0, -8.0, 4.0));
	block.var[15][1] = (vec3(4.0, 5.0, 5.0));
	block.var[16][0] = (vec3(2.0, 3.0, 6.0));
	block.var[16][1] = (vec3(-4.0, -4.0, -1.0));
	block.var[17][0] = (vec3(-3.0, -1.0, -1.0));
	block.var[17][1] = (vec3(6.0, 2.0, 2.0));
	block.var[18][0] = (vec3(5.0, -2.0, -1.0));
	block.var[18][1] = (vec3(7.0, -7.0, 5.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(-7.0, -9.0, 9.0, 4.0, 9.0, 5.0, -2.0, -3.0, 8.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(1.0, 1.0, -3.0, 0.0, -6.0, -1.0, -5.0, -8.0, -9.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(9.0, 0.0, -8.0, 0.0, -8.0, 1.0, -3.0, 3.0, -4.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(-4.0, -3.0, 7.0, 1.0, -8.0, -8.0, -5.0, 8.0, -6.0, 9.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(-9.0, -2.0, 7.0, -7.0, 5.0, -9.0, 2.0, 8.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(-1.0, -3.0, 3.0, -5.0, 9.0, -5.0, 3.0, 9.0, 7.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(8.0, -7.0, 0.0, 6.0, 2.0, -6.0, 7.0, -8.0, -5.0, 4.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(8.0, 8.0, -2.0, 8.0));
	block.var[0][1] = (vec4(8.0, 3.0, 5.0, -5.0));
	block.var[0][2] = (vec4(7.0, 6.0, -9.0, 3.0));
	block.var[1][0] = (vec4(0.0, -3.0, 1.0, -9.0));
	block.var[1][1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	block.var[1][2] = (vec4(9.0, 0.0, -9.0, -2.0));
	block.var[2][0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	block.var[2][1] = (vec4(1.0, -2.0, -2.0, -1.0));
	block.var[2][2] = (vec4(-7.0, 8.0, 0.0, -6.0));
	block.var[3][0] = (vec4(-1.0, 7.0, -6.0, -1.0));
	block.var[3][1] = (vec4(-7.0, -8.0, 7.0, -8.0));
	block.var[3][2] = (vec4(6.0, -8.0, 2.0, -5.0));
	block.var[4][0] = (vec4(9.0, -7.0, 4.0, -1.0));
	block.var[4][1] = (vec4(-3.0, -8.0, -1.0, 1.0));
	block.var[4][2] = (vec4(-6.0, -4.0, -8.0, 4.0));
	block.var[5][0] = (vec4(5.0, 0.0, -6.0, 5.0));
	block.var[5][1] = (vec4(-1.0, 4.0, 3.0, -6.0));
	block.var[5][2] = (vec4(1.0, 8.0, -2.0, 3.0));
	block.var[6][0] = (vec4(-1.0, -9.0, 4.0, 9.0));
	block.var[6][1] = (vec4(0.0, 2.0, -7.0, -7.0));
	block.var[6][2] = (vec4(-1.0, 8.0, -9.0, -3.0));
	block.var[7][0] = (vec4(5.0, 7.0, -8.0, 1.0));
	block.var[7][1] = (vec4(-5.0, 0.0, -7.0, -3.0));
	block.var[7][2] = (vec4(-5.0, -4.0, 3.0, -5.0));
	block.var[8][0] = (vec4(4.0, 5.0, -9.0, -6.0));
	block.var[8][1] = (vec4(5.0, 3.0, -6.0, -7.0));
	block.var[8][2] = (vec4(-3.0, 9.0, 3.0, -7.0));
	block.var[9][0] = (vec4(-9.0, -9.0, 6.0, -9.0));
	block.var[9][1] = (vec4(6.0, -1.0, -1.0, -4.0));
	block.var[9][2] = (vec4(5.0, 2.0, -6.0, 8.0));
	block.var[10][0] = (vec4(4.0, 2.0, 4.0, -3.0));
	block.var[10][1] = (vec4(9.0, 8.0, 5.0, -3.0));
	block.var[10][2] = (vec4(7.0, -4.0, 6.0, 4.0));
	block.var[11][0] = (vec4(0.0, -2.0, 1.0, 8.0));
	block.var[11][1] = (vec4(1.0, 4.0, 6.0, 4.0));
	block.var[11][2] = (vec4(-2.0, 9.0, 9.0, 7.0));
	block.var[12][0] = (vec4(4.0, -1.0, 2.0, -8.0));
	block.var[12][1] = (vec4(-6.0, 4.0, -8.0, 9.0));
	block.var[12][2] = (vec4(0.0, 7.0, -2.0, 2.0));
	block.var[13][0] = (vec4(2.0, 9.0, -9.0, 2.0));
	block.var[13][1] = (vec4(1.0, 5.0, 5.0, 5.0));
	block.var[13][2] = (vec4(0.0, 9.0, 8.0, 7.0));
	block.var[14][0] = (vec4(7.0, 5.0, -7.0, -6.0));
	block.var[14][1] = (vec4(-4.0, 4.0, -5.0, -7.0));
	block.var[14][2] = (vec4(2.0, 2.0, 1.0, -7.0));
	block.var[15][0] = (vec4(1.0, -1.0, 9.0, -4.0));
	block.var[15][1] = (vec4(4.0, 1.0, 7.0, -4.0));
	block.var[15][2] = (vec4(1.0, 9.0, -7.0, 4.0));
	block.var[16][0] = (vec4(-2.0, 5.0, -1.0, 9.0));
	block.var[16][1] = (vec4(-9.0, -6.0, 3.0, 7.0));
	block.var[16][2] = (vec4(-1.0, -6.0, 3.0, -3.0));
	block.var[17][0] = (vec4(1.0, 7.0, 2.0, -9.0));
	block.var[17][1] = (vec4(0.0, -8.0, -8.0, 4.0));
	block.var[17][2] = (vec4(7.0, 6.0, 8.0, -2.0));
	block.var[18][0] = (vec4(8.0, 9.0, -2.0, -1.0));
	block.var[18][1] = (vec4(7.0, -4.0, -8.0, 9.0));
	block.var[18][2] = (vec4(-5.0, 7.0, 9.0, -6.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(3.0, -2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(-1.0, 0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(2.0, -2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(0.0, 7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(8.0, 8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(7.0, 4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(8.0, -7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(-4.0, 1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(2.0, -3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(3.0, -3.0, -9.0, 4.0, -4.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(-1.0, -6.0, -9.0, 0.0, 2.0, -7.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(4.0, -4.0, -5.0, -5.0, 1.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(-4.0, 2.0, -1.0, -3.0, -7.0, -8.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(4.0, 9.0, -6.0, -7.0, 1.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(2.0, -5.0, -5.0, -2.0, 5.0, 3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(1.0, -1.0, 1.0, -8.0, -7.0, -2.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	block.var[1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	block.var[2] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
	block.var[3] = (mat4x2(8.0, 7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0));
	block.var[4] = (mat4x2(1.0, 6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0));
	block.var[5] = (mat4x2(3.0, -5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0));
	block.var[6] = (mat4x2(-4.0, 4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0));
	block.var[7] = (mat4x2(8.0, -4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0));
	block.var[8] = (mat4x2(-4.0, -8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0));
	block.var[9] = (mat4x2(-5.0, 7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0));
	block.var[10] = (mat4x2(6.0, -7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0));
	block.var[11] = (mat4x2(3.0, -8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0));
	block.var[12] = (mat4x2(8.0, 9.0, 4.0, -2.0, -8.0, -5.0, -3.0, 9.0));
	block.var[13] = (mat4x2(9.0, -3.0, 8.0, 2.0, -9.0, 2.0, 1.0, -2.0));
	block.var[14] = (mat4x2(6.0, 7.0, -3.0, 4.0, 8.0, -4.0, -9.0, -6.0));
	block.var[15] = (mat4x2(-8.0, 1.0, 6.0, -6.0, 6.0, -2.0, -8.0, 8.0));
	block.var[16] = (mat4x2(0.0, 7.0, -6.0, 0.0, -7.0, 3.0, -3.0, 1.0));
	block.var[17] = (mat4x2(-4.0, -6.0, -8.0, -9.0, 1.0, 4.0, 2.0, -5.0));
	block.var[18] = (mat4x2(-4.0, 0.0, 5.0, 8.0, 4.0, -1.0, 1.0, 4.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(3.0, -6.0, -6.0, 5.0, 5.0, -8.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(-6.0, 3.0, -5.0, 0.0, 5.0, 8.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(-1.0, 4.0, -4.0, 9.0, 2.0, 5.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(1.0, -6.0, -4.0, 8.0, -1.0, -9.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(3.0, 8.0, -3.0, -7.0, 6.0, -6.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-9.0, -1.0, -4.0, -4.0, -4.0, 9.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(4.0, -5.0, 6.0, 7.0, -8.0, 2.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(9.0, 7.0, 4.0, 2.0, 8.0, 1.0, -9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(0.0, -6.0, 9.0, 7.0, 3.0, 2.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(6.0, 7.0, -1.0, 8.0, 1.0, 1.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(-5.0, -4.0, -5.0, -1.0, 5.0, 1.0, 5.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(4.0, -8.0, -9.0, 5.0, 9.0, 1.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(7.0, 6.0, -5.0, -8.0, -5.0, 4.0, -8.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(0.0, -8.0, 3.0, -4.0, -5.0, 7.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(5.0, -3.0, 3.0, 7.0, 2.0, 8.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(8.0, 2.0, -2.0, -2.0, 0.0, 9.0, 3.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	block.var[1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	block.var[2] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
	block.var[3] = (mat3(-4.0, 3.0, -8.0, -9.0, 9.0, -7.0, -1.0, -9.0, -9.0));
	block.var[4] = (mat3(-2.0, 7.0, -3.0, 2.0, -6.0, -7.0, 4.0, 8.0, -8.0));
	block.var[5] = (mat3(6.0, 1.0, 9.0, 7.0, -9.0, 5.0, -9.0, 9.0, 1.0));
	block.var[6] = (mat3(8.0, 7.0, -7.0, -4.0, 7.0, -5.0, 8.0, 3.0, -4.0));
	block.var[7] = (mat3(-5.0, 6.0, -1.0, 6.0, -8.0, 1.0, 7.0, 5.0, 7.0));
	block.var[8] = (mat3(1.0, 7.0, -1.0, -8.0, 9.0, -2.0, 7.0, 9.0, -5.0));
	block.var[9] = (mat3(8.0, 7.0, 6.0, -6.0, -1.0, -2.0, 9.0, 6.0, 0.0));
	block.var[10] = (mat3(-4.0, -3.0, -6.0, -5.0, -8.0, -6.0, 5.0, -5.0, 2.0));
	block.var[11] = (mat3(7.0, 5.0, -4.0, 7.0, 9.0, -8.0, -9.0, 8.0, -9.0));
	block.var[12] = (mat3(8.0, 0.0, -7.0, 0.0, -7.0, 5.0, -5.0, -2.0, -9.0));
	block.var[13] = (mat3(6.0, 5.0, 8.0, 2.0, 5.0, -8.0, 2.0, -9.0, -7.0));
	block.var[14] = (mat3(-8.0, 3.0, -4.0, 9.0, 2.0, 0.0, -3.0, -6.0, 4.0));
	block.var[15] = (mat3(6.0, -6.0, 5.0, -5.0, -5.0, -9.0, -4.0, -5.0, 7.0));
	block.var[16] = (mat3(-7.0, 5.0, 9.0, 0.0, -7.0, 7.0, 9.0, 9.0, 9.0));
	block.var[17] = (mat3(7.0, -1.0, 7.0, -4.0, 1.0, -3.0, 8.0, 0.0, 4.0));
	block.var[18] = (mat3(-1.0, 1.0, 8.0, 9.0, 5.0, -2.0, -6.0, -8.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-5.0, 7.0, -1.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-5.0, 7.0, -4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(8.0, -3.0, 3.0, -5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3], mat3x2(-8.0, -4.0, 7.0, 3.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[4], mat3x2(0.0, 9.0, -4.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[5], mat3x2(0.0, 9.0, 2.0, -2.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[6], mat3x2(0.0, 6.0, -2.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[7], mat3x2(1.0, 5.0, 8.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[8], mat3x2(0.0, 9.0, -2.0, 3.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[9], mat3x2(-3.0, 4.0, 1.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[10], mat3x2(1.0, -8.0, -7.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[11], mat3x2(-5.0, -4.0, 7.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[12], mat3x2(-1.0, -4.0, 1.0, 0.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[13], mat3x2(-1.0, 6.0, -9.0, -3.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[14], mat3x2(5.0, 2.0, -7.0, -9.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[15], mat3x2(-6.0, -4.0, 0.0, -4.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[16], mat3x2(-8.0, -6.0, -9.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[17], mat3x2(-7.0, 4.0, -5.0, -9.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[18], mat3x2(5.0, 0.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(-8.0, -4.0));
	block.var[0][1] = (vec2(-3.0, 5.0));
	block.var[0][2] = (vec2(-9.0, 4.0));
	block.var[1][0] = (vec2(-2.0, -1.0));
	block.var[1][1] = (vec2(8.0, 3.0));
	block.var[1][2] = (vec2(7.0, 2.0));
	block.var[2][0] = (vec2(-4.0, 4.0));
	block.var[2][1] = (vec2(3.0, -6.0));
	block.var[2][2] = (vec2(-4.0, 3.0));
	block.var[3][0] = (vec2(4.0, 6.0));
	block.var[3][1] = (vec2(3.0, 6.0));
	block.var[3][2] = (vec2(-2.0, -9.0));
	block.var[4][0] = (vec2(-9.0, 0.0));
	block.var[4][1] = (vec2(-4.0, 9.0));
	block.var[4][2] = (vec2(-1.0, -1.0));
	block.var[5][0] = (vec2(-8.0, 6.0));
	block.var[5][1] = (vec2(5.0, -2.0));
	block.var[5][2] = (vec2(1.0, 4.0));
	block.var[6][0] = (vec2(2.0, -5.0));
	block.var[6][1] = (vec2(-5.0, -9.0));
	block.var[6][2] = (vec2(-7.0, 3.0));
	block.var[7][0] = (vec2(-1.0, 0.0));
	block.var[7][1] = (vec2(-1.0, 4.0));
	block.var[7][2] = (vec2(-1.0, -6.0));
	block.var[8][0] = (vec2(-8.0, -6.0));
	block.var[8][1] = (vec2(8.0, 7.0));
	block.var[8][2] = (vec2(4.0, -9.0));
	block.var[9][0] = (vec2(-4.0, -1.0));
	block.var[9][1] = (vec2(-3.0, -2.0));
	block.var[9][2] = (vec2(-5.0, -2.0));
	block.var[10][0] = (vec2(-7.0, -3.0));
	block.var[10][1] = (vec2(5.0, 4.0));
	block.var[10][2] = (vec2(4.0, 1.0));
	block.var[11][0] = (vec2(-3.0, -6.0));
	block.var[11][1] = (vec2(-4.0, -2.0));
	block.var[11][2] = (vec2(-5.0, -7.0));
	block.var[12][0] = (vec2(2.0, 6.0));
	block.var[12][1] = (vec2(6.0, 1.0));
	block.var[12][2] = (vec2(4.0, -8.0));
	block.var[13][0] = (vec2(2.0, -5.0));
	block.var[13][1] = (vec2(-5.0, 5.0));
	block.var[13][2] = (vec2(2.0, -1.0));
	block.var[14][0] = (vec2(-9.0, 3.0));
	block.var[14][1] = (vec2(6.0, 5.0));
	block.var[14][2] = (vec2(-1.0, -8.0));
	block.var[15][0] = (vec2(2.0, -1.0));
	block.var[15][1] = (vec2(0.0, -2.0));
	block.var[15][2] = (vec2(-4.0, 6.0));
	block.var[16][0] = (vec2(2.0, -3.0));
	block.var[16][1] = (vec2(-2.0, 1.0));
	block.var[16][2] = (vec2(-3.0, 8.0));
	block.var[17][0] = (vec2(5.0, -1.0));
	block.var[17][1] = (vec2(-4.0, -4.0));
	block.var[17][2] = (vec2(7.0, -6.0));
	block.var[18][0] = (vec2(-2.0, -8.0));
	block.var[18][1] = (vec2(0.0, -2.0));
	block.var[18][2] = (vec2(8.0, -2.0));
}
#version 450
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
	i8vec4 var[];
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
	allOk = compare_i8vec4(ivec4(block.var[3]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[4]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[5]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[6]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[7]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[8]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[9]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[10]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[11]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[12]), ivec4(4294967293, 4294967294, 4, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[13]), ivec4(4294967289, 6, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[14]), ivec4(4294967290, 4294967289, 4294967295, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[15]), ivec4(4294967293, 4294967287, 4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[16]), ivec4(5, 4294967290, 4294967294, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[17]), ivec4(9, 3, 7, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[18]), ivec4(4294967287, 4294967291, 5, 4294967294)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	block.var[1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	block.var[2] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	block.var[3] = i8vec4(ivec4(6, 4, 9, 4294967287));
	block.var[4] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	block.var[5] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	block.var[6] = i8vec4(ivec4(8, 5, 4, 5));
	block.var[7] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	block.var[8] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	block.var[9] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	block.var[10] = i8vec4(ivec4(2, 5, 4, 6));
	block.var[11] = i8vec4(ivec4(4294967292, 7, 8, 9));
	block.var[12] = i8vec4(ivec4(3, 4294967293, 4294967290, 4294967290));
	block.var[13] = i8vec4(ivec4(8, 4294967289, 4294967292, 2));
	block.var[14] = i8vec4(ivec4(4294967295, 9, 4294967295, 6));
	block.var[15] = i8vec4(ivec4(6, 4294967289, 4294967293, 4294967289));
	block.var[16] = i8vec4(ivec4(6, 7, 5, 5));
	block.var[17] = i8vec4(ivec4(4294967291, 4, 3, 4294967290));
	block.var[18] = i8vec4(ivec4(1, 0, 5, 0));
}
#version 450
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
	f16vec4 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(block.var[0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[4]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[5]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[6]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[7]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[8]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[9]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[10]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[11]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[12]), vec4(7.0, -7.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[13]), vec4(7.0, 0.0, -2.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[14]), vec4(-6.0, -5.0, 8.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[15]), vec4(-9.0, 7.0, -3.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[16]), vec4(2.0, 7.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[17]), vec4(-7.0, 6.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[18]), vec4(1.0, 0.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	block.var[1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	block.var[2] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
	block.var[3] = f16vec4(vec4(-1.0, 4.0, -1.0, -8.0));
	block.var[4] = f16vec4(vec4(5.0, 8.0, 7.0, 0.0));
	block.var[5] = f16vec4(vec4(4.0, -5.0, -6.0, -8.0));
	block.var[6] = f16vec4(vec4(-6.0, 2.0, -4.0, 8.0));
	block.var[7] = f16vec4(vec4(-4.0, -1.0, 8.0, 9.0));
	block.var[8] = f16vec4(vec4(0.0, 0.0, -5.0, 5.0));
	block.var[9] = f16vec4(vec4(7.0, -6.0, -7.0, -8.0));
	block.var[10] = f16vec4(vec4(-3.0, -4.0, -7.0, 0.0));
	block.var[11] = f16vec4(vec4(-7.0, -2.0, 7.0, -1.0));
	block.var[12] = f16vec4(vec4(8.0, 3.0, -7.0, -9.0));
	block.var[13] = f16vec4(vec4(6.0, -8.0, -8.0, 3.0));
	block.var[14] = f16vec4(vec4(1.0, -6.0, -6.0, 9.0));
	block.var[15] = f16vec4(vec4(9.0, -7.0, 7.0, -4.0));
	block.var[16] = f16vec4(vec4(-3.0, 0.0, -5.0, -5.0));
	block.var[17] = f16vec4(vec4(-6.0, -7.0, -2.0, -8.0));
	block.var[18] = f16vec4(vec4(-3.0, -6.0, 7.0, 3.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(9.0, 0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(8.0, -5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(-1.0, -9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(-6.0, -7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(-4.0, 8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(-2.0, 3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(-4.0, 8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	block.var[1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	block.var[2] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
	block.var[3] = (mat3(-9.0, 3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0));
	block.var[4] = (mat3(4.0, 7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0));
	block.var[5] = (mat3(7.0, -6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0));
	block.var[6] = (mat3(5.0, 4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0));
	block.var[7] = (mat3(-3.0, 6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0));
	block.var[8] = (mat3(-4.0, -4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0));
	block.var[9] = (mat3(-8.0, -8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0));
	block.var[10] = (mat3(-3.0, -8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0));
	block.var[11] = (mat3(3.0, -2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0));
	block.var[12] = (mat3(-2.0, 4.0, 1.0, 4.0, 5.0, -8.0, 0.0, 4.0, -7.0));
	block.var[13] = (mat3(-3.0, 2.0, 7.0, -9.0, -9.0, -4.0, 6.0, -9.0, 9.0));
	block.var[14] = (mat3(-6.0, 9.0, 8.0, -8.0, -9.0, -8.0, 2.0, 4.0, 8.0));
	block.var[15] = (mat3(-5.0, 6.0, -5.0, 3.0, -2.0, -2.0, -3.0, -3.0, 8.0));
	block.var[16] = (mat3(1.0, -1.0, -6.0, -7.0, -4.0, -9.0, 9.0, -4.0, -3.0));
	block.var[17] = (mat3(8.0, 7.0, -9.0, 3.0, -6.0, 1.0, -4.0, -4.0, 3.0));
	block.var[18] = (mat3(0.0, 7.0, -3.0, -5.0, -1.0, 1.0, -7.0, 1.0, -9.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3], mat3x2(5.0, -5.0, -4.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[4], mat3x2(4.0, -6.0, -8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[5], mat3x2(1.0, 3.0, 6.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[6], mat3x2(-5.0, -8.0, -9.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[7], mat3x2(-8.0, 8.0, -1.0, -4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[8], mat3x2(2.0, 8.0, 8.0, -5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[9], mat3x2(-9.0, 8.0, -3.0, -8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[10], mat3x2(-5.0, 7.0, 5.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[11], mat3x2(-6.0, -3.0, -1.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[12], mat3x2(-5.0, -1.0, -9.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[13], mat3x2(-1.0, 6.0, 2.0, 9.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[14], mat3x2(4.0, 7.0, 5.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[15], mat3x2(1.0, -8.0, 5.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[16], mat3x2(3.0, -9.0, 0.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[17], mat3x2(5.0, -7.0, -7.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[18], mat3x2(-3.0, 8.0, 5.0, 5.0, -7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(-4.0, -6.0));
	block.var[0][1] = (vec2(1.0, -3.0));
	block.var[0][2] = (vec2(-1.0, -9.0));
	block.var[1][0] = (vec2(3.0, -2.0));
	block.var[1][1] = (vec2(5.0, -8.0));
	block.var[1][2] = (vec2(2.0, -9.0));
	block.var[2][0] = (vec2(1.0, -5.0));
	block.var[2][1] = (vec2(0.0, -2.0));
	block.var[2][2] = (vec2(2.0, -1.0));
	block.var[3][0] = (vec2(-7.0, 9.0));
	block.var[3][1] = (vec2(-8.0, 7.0));
	block.var[3][2] = (vec2(1.0, -9.0));
	block.var[4][0] = (vec2(-5.0, -5.0));
	block.var[4][1] = (vec2(9.0, 3.0));
	block.var[4][2] = (vec2(-3.0, -6.0));
	block.var[5][0] = (vec2(1.0, 3.0));
	block.var[5][1] = (vec2(-3.0, -4.0));
	block.var[5][2] = (vec2(-9.0, 4.0));
	block.var[6][0] = (vec2(-2.0, -3.0));
	block.var[6][1] = (vec2(-5.0, 1.0));
	block.var[6][2] = (vec2(-5.0, 8.0));
	block.var[7][0] = (vec2(7.0, 8.0));
	block.var[7][1] = (vec2(-1.0, -3.0));
	block.var[7][2] = (vec2(-8.0, 5.0));
	block.var[8][0] = (vec2(6.0, 6.0));
	block.var[8][1] = (vec2(0.0, -8.0));
	block.var[8][2] = (vec2(-6.0, -4.0));
	block.var[9][0] = (vec2(-6.0, -5.0));
	block.var[9][1] = (vec2(8.0, 5.0));
	block.var[9][2] = (vec2(-9.0, 0.0));
	block.var[10][0] = (vec2(6.0, -3.0));
	block.var[10][1] = (vec2(6.0, 0.0));
	block.var[10][2] = (vec2(1.0, 6.0));
	block.var[11][0] = (vec2(4.0, 4.0));
	block.var[11][1] = (vec2(0.0, -1.0));
	block.var[11][2] = (vec2(-2.0, 2.0));
	block.var[12][0] = (vec2(-1.0, -9.0));
	block.var[12][1] = (vec2(-8.0, 9.0));
	block.var[12][2] = (vec2(-1.0, -6.0));
	block.var[13][0] = (vec2(-5.0, 7.0));
	block.var[13][1] = (vec2(-8.0, -6.0));
	block.var[13][2] = (vec2(1.0, -5.0));
	block.var[14][0] = (vec2(-3.0, 8.0));
	block.var[14][1] = (vec2(-2.0, 3.0));
	block.var[14][2] = (vec2(-2.0, 5.0));
	block.var[15][0] = (vec2(7.0, -3.0));
	block.var[15][1] = (vec2(4.0, 5.0));
	block.var[15][2] = (vec2(-9.0, 3.0));
	block.var[16][0] = (vec2(6.0, -1.0));
	block.var[16][1] = (vec2(-6.0, -5.0));
	block.var[16][2] = (vec2(7.0, -6.0));
	block.var[17][0] = (vec2(1.0, 8.0));
	block.var[17][1] = (vec2(7.0, -1.0));
	block.var[17][2] = (vec2(2.0, 6.0));
	block.var[18][0] = (vec2(-6.0, 5.0));
	block.var[18][1] = (vec2(6.0, -8.0));
	block.var[18][2] = (vec2(-2.0, -1.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(8.0, 8.0, -2.0, 8.0));
	block.var[0][0][1] = (vec4(8.0, 3.0, 5.0, -5.0));
	block.var[0][0][2] = (vec4(7.0, 6.0, -9.0, 3.0));
	block.var[0][1][0] = (vec4(0.0, -3.0, 1.0, -9.0));
	block.var[0][1][1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	block.var[0][1][2] = (vec4(9.0, 0.0, -9.0, -2.0));
	block.var[0][2][0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	block.var[0][2][1] = (vec4(1.0, -2.0, -2.0, -1.0));
	block.var[0][2][2] = (vec4(-7.0, 8.0, 0.0, -6.0));
	block.var[1][0][0] = (vec4(-1.0, 7.0, -6.0, -1.0));
	block.var[1][0][1] = (vec4(-7.0, -8.0, 7.0, -8.0));
	block.var[1][0][2] = (vec4(6.0, -8.0, 2.0, -5.0));
	block.var[1][1][0] = (vec4(9.0, -7.0, 4.0, -1.0));
	block.var[1][1][1] = (vec4(-3.0, -8.0, -1.0, 1.0));
	block.var[1][1][2] = (vec4(-6.0, -4.0, -8.0, 4.0));
	block.var[1][2][0] = (vec4(5.0, 0.0, -6.0, 5.0));
	block.var[1][2][1] = (vec4(-1.0, 4.0, 3.0, -6.0));
	block.var[1][2][2] = (vec4(1.0, 8.0, -2.0, 3.0));
	block.var[2][0][0] = (vec4(-1.0, -9.0, 4.0, 9.0));
	block.var[2][0][1] = (vec4(0.0, 2.0, -7.0, -7.0));
	block.var[2][0][2] = (vec4(-1.0, 8.0, -9.0, -3.0));
	block.var[2][1][0] = (vec4(5.0, 7.0, -8.0, 1.0));
	block.var[2][1][1] = (vec4(-5.0, 0.0, -7.0, -3.0));
	block.var[2][1][2] = (vec4(-5.0, -4.0, 3.0, -5.0));
	block.var[2][2][0] = (vec4(4.0, 5.0, -9.0, -6.0));
	block.var[2][2][1] = (vec4(5.0, 3.0, -6.0, -7.0));
	block.var[2][2][2] = (vec4(-3.0, 9.0, 3.0, -7.0));
	block.var[3][0][0] = (vec4(-9.0, -9.0, 6.0, -9.0));
	block.var[3][0][1] = (vec4(6.0, -1.0, -1.0, -4.0));
	block.var[3][0][2] = (vec4(5.0, 2.0, -6.0, 8.0));
	block.var[3][1][0] = (vec4(4.0, 2.0, 4.0, -3.0));
	block.var[3][1][1] = (vec4(9.0, 8.0, 5.0, -3.0));
	block.var[3][1][2] = (vec4(7.0, -4.0, 6.0, 4.0));
	block.var[3][2][0] = (vec4(0.0, -2.0, 1.0, 8.0));
	block.var[3][2][1] = (vec4(1.0, 4.0, 6.0, 4.0));
	block.var[3][2][2] = (vec4(-2.0, 9.0, 9.0, 7.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-7.0, -7.0, 7.0, 2.0, -5.0, 3.0, 2.0, 0.0, 8.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(-8.0, 6.0, 2.0, -5.0, -7.0, -7.0, -4.0, -9.0, 7.0, 3.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(-7.0, 7.0, 6.0, 3.0, 4.0, 5.0, -2.0, 3.0, 8.0, -7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(0.0, 7.0, 1.0, -2.0, 9.0, -5.0, -3.0, 1.0, -6.0, 6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(9.0, 8.0, 5.0, 4.0, 7.0, -1.0, 6.0, -6.0, 2.0, 8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(0.0, 6.0, -8.0, -4.0, -8.0, 8.0, -5.0, 7.0, 3.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(6.0, -3.0, 0.0, -3.0, 2.0, -8.0, 6.0, 5.0, -2.0, 2.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(-7.0, 4.0, 5.0, -8.0, -1.0, -2.0, -8.0, -4.0, 2.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(4.0, -1.0, 3.0, 3.0, -3.0, 4.0, -6.0, -5.0, 1.0, 4.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	block.var[0][1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	block.var[0][2] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
	block.var[1][0] = (mat4x3(-6.0, -5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0));
	block.var[1][1] = (mat4x3(-6.0, 5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0));
	block.var[1][2] = (mat4x3(-7.0, -2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0));
	block.var[2][0] = (mat4x3(-9.0, -7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0));
	block.var[2][1] = (mat4x3(-8.0, -4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0));
	block.var[2][2] = (mat4x3(-3.0, -7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0));
	block.var[3][0] = (mat4x3(3.0, -8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0));
	block.var[3][1] = (mat4x3(-6.0, -9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0));
	block.var[3][2] = (mat4x3(-1.0, -9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0));
}
#version 450
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
	uint8_t var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.var[0][0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][2]), 3u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][2]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][2]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = uint8_t(9u);
	block.var[0][1] = uint8_t(5u);
	block.var[0][2] = uint8_t(2u);
	block.var[1][0] = uint8_t(6u);
	block.var[1][1] = uint8_t(7u);
	block.var[1][2] = uint8_t(5u);
	block.var[2][0] = uint8_t(8u);
	block.var[2][1] = uint8_t(4u);
	block.var[2][2] = uint8_t(2u);
	block.var[3][0] = uint8_t(6u);
	block.var[3][1] = uint8_t(0u);
	block.var[3][2] = uint8_t(1u);
}
#version 450
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
	highp vec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((block.var[0][0]), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((block.var[0][1]), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((block.var[0][2]), vec3(1.0, -1.0, 7.0)) && allOk;
	allOk = compare_vec3((block.var[1][0]), vec3(-1.0, -9.0, 3.0)) && allOk;
	allOk = compare_vec3((block.var[1][1]), vec3(-7.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec3((block.var[1][2]), vec3(3.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec3((block.var[2][0]), vec3(1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3((block.var[2][1]), vec3(5.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3((block.var[2][2]), vec3(-3.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec3((block.var[3][0]), vec3(8.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((block.var[3][1]), vec3(5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3((block.var[3][2]), vec3(-7.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(5.0, 4.0, 7.0));
	block.var[0][1] = (vec3(8.0, -2.0, 7.0));
	block.var[0][2] = (vec3(-5.0, -7.0, 9.0));
	block.var[1][0] = (vec3(6.0, 6.0, 0.0));
	block.var[1][1] = (vec3(-5.0, 2.0, -8.0));
	block.var[1][2] = (vec3(5.0, 0.0, 2.0));
	block.var[2][0] = (vec3(0.0, 5.0, 1.0));
	block.var[2][1] = (vec3(-5.0, 0.0, 1.0));
	block.var[2][2] = (vec3(0.0, 7.0, -2.0));
	block.var[3][0] = (vec3(-2.0, 8.0, -1.0));
	block.var[3][1] = (vec3(-1.0, 5.0, 1.0));
	block.var[3][2] = (vec3(-1.0, -3.0, 8.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(-4.0, -1.0, 7.0, 7.0, 0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(5.0, 0.0, 8.0, -9.0, 0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(-4.0, -3.0, -4.0, -7.0, 4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(9.0, -6.0, 6.0, 6.0, -2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(-4.0, -3.0, -8.0, 5.0, 8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(5.0, -1.0, 6.0, 0.0, -1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(0.0, -4.0, 0.0, 2.0, 5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(9.0, 2.0, 5.0, -7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(-9.0, -5.0, 3.0, -4.0, -6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	block.var[0][1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	block.var[0][2] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
	block.var[1][0] = (mat4(-3.0, 1.0, -5.0, 0.0, -1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0));
	block.var[1][1] = (mat4(4.0, 7.0, 2.0, 2.0, 5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0));
	block.var[1][2] = (mat4(-6.0, 0.0, -6.0, 3.0, -1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0));
	block.var[2][0] = (mat4(7.0, 9.0, -3.0, -6.0, 3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0));
	block.var[2][1] = (mat4(3.0, -3.0, 1.0, 4.0, -1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0));
	block.var[2][2] = (mat4(-6.0, -5.0, 3.0, -8.0, -4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0));
	block.var[3][0] = (mat4(-5.0, 2.0, 1.0, 1.0, -7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0));
	block.var[3][1] = (mat4(-4.0, -3.0, 2.0, -2.0, 4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0));
	block.var[3][2] = (mat4(6.0, -9.0, 7.0, 7.0, -1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(7.0, 4.0, -4.0));
	block.var[0][0][1] = (vec3(-6.0, 3.0, -3.0));
	block.var[0][0][2] = (vec3(9.0, -2.0, 3.0));
	block.var[0][0][3] = (vec3(9.0, -9.0, 7.0));
	block.var[0][1][0] = (vec3(5.0, 1.0, -9.0));
	block.var[0][1][1] = (vec3(-1.0, -2.0, 6.0));
	block.var[0][1][2] = (vec3(-4.0, 6.0, 4.0));
	block.var[0][1][3] = (vec3(-8.0, 7.0, 3.0));
	block.var[0][2][0] = (vec3(-4.0, -9.0, 8.0));
	block.var[0][2][1] = (vec3(9.0, 2.0, 2.0));
	block.var[0][2][2] = (vec3(9.0, -7.0, 3.0));
	block.var[0][2][3] = (vec3(8.0, 2.0, 4.0));
	block.var[1][0][0] = (vec3(2.0, 4.0, -3.0));
	block.var[1][0][1] = (vec3(-8.0, 7.0, 3.0));
	block.var[1][0][2] = (vec3(0.0, -8.0, 0.0));
	block.var[1][0][3] = (vec3(6.0, -9.0, 0.0));
	block.var[1][1][0] = (vec3(-4.0, 5.0, 5.0));
	block.var[1][1][1] = (vec3(-7.0, -8.0, -1.0));
	block.var[1][1][2] = (vec3(6.0, -3.0, -5.0));
	block.var[1][1][3] = (vec3(0.0, 8.0, -8.0));
	block.var[1][2][0] = (vec3(-4.0, 4.0, 8.0));
	block.var[1][2][1] = (vec3(-4.0, -4.0, -3.0));
	block.var[1][2][2] = (vec3(3.0, 3.0, 2.0));
	block.var[1][2][3] = (vec3(8.0, -8.0, -6.0));
	block.var[2][0][0] = (vec3(9.0, 1.0, -1.0));
	block.var[2][0][1] = (vec3(-1.0, 2.0, 4.0));
	block.var[2][0][2] = (vec3(4.0, 2.0, 0.0));
	block.var[2][0][3] = (vec3(5.0, 6.0, -6.0));
	block.var[2][1][0] = (vec3(-3.0, 7.0, -6.0));
	block.var[2][1][1] = (vec3(7.0, 9.0, 8.0));
	block.var[2][1][2] = (vec3(-9.0, -9.0, -9.0));
	block.var[2][1][3] = (vec3(6.0, -7.0, -3.0));
	block.var[2][2][0] = (vec3(7.0, -1.0, -4.0));
	block.var[2][2][1] = (vec3(-9.0, 0.0, -1.0));
	block.var[2][2][2] = (vec3(-7.0, -2.0, -3.0));
	block.var[2][2][3] = (vec3(1.0, 4.0, 5.0));
	block.var[3][0][0] = (vec3(9.0, 8.0, 7.0));
	block.var[3][0][1] = (vec3(5.0, 4.0, 7.0));
	block.var[3][0][2] = (vec3(3.0, -3.0, 4.0));
	block.var[3][0][3] = (vec3(3.0, -6.0, 5.0));
	block.var[3][1][0] = (vec3(-8.0, -4.0, -9.0));
	block.var[3][1][1] = (vec3(4.0, 8.0, -3.0));
	block.var[3][1][2] = (vec3(-9.0, 7.0, -2.0));
	block.var[3][1][3] = (vec3(0.0, -3.0, -3.0));
	block.var[3][2][0] = (vec3(4.0, -2.0, -4.0));
	block.var[3][2][1] = (vec3(-5.0, -7.0, 1.0));
	block.var[3][2][2] = (vec3(-8.0, 1.0, 9.0));
	block.var[3][2][3] = (vec3(-8.0, 0.0, -2.0));
}
#version 450
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
	i16vec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(block.var[0][0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][2]), ivec3(6, -5, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][0]), ivec3(9, 4, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][1]), ivec3(-6, 6, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][2]), ivec3(2, -1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][0]), ivec3(-1, -4, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][1]), ivec3(2, -8, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][2]), ivec3(0, -3, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][0]), ivec3(-6, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][1]), ivec3(5, 1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][2]), ivec3(8, 5, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = i16vec3(ivec3(6, 1, -2));
	block.var[0][1] = i16vec3(ivec3(-3, -1, -4));
	block.var[0][2] = i16vec3(ivec3(-2, -2, 2));
	block.var[1][0] = i16vec3(ivec3(0, -6, -2));
	block.var[1][1] = i16vec3(ivec3(0, -9, 2));
	block.var[1][2] = i16vec3(ivec3(-8, 6, 2));
	block.var[2][0] = i16vec3(ivec3(-5, -4, -8));
	block.var[2][1] = i16vec3(ivec3(0, 9, 6));
	block.var[2][2] = i16vec3(ivec3(5, -3, 4));
	block.var[3][0] = i16vec3(ivec3(-3, 9, 0));
	block.var[3][1] = i16vec3(ivec3(1, -5, 8));
	block.var[3][2] = i16vec3(ivec3(-5, 0, 7));
}
#version 450
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
	highp vec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_vec2((block.var[0][0]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_vec2((block.var[0][1]), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[0][2]), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_vec2((block.var[1][0]), vec2(7.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[1][1]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2((block.var[1][2]), vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2((block.var[2][0]), vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[2][1]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec2((block.var[2][2]), vec2(3.0, -8.0)) && allOk;
	allOk = compare_vec2((block.var[3][0]), vec2(-7.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[3][1]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((block.var[3][2]), vec2(-1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0][0] = (vec2(8.0, 7.0));
	block.var[0][1] = (vec2(-1.0, -4.0));
	block.var[0][2] = (vec2(8.0, -2.0));
	block.var[1][0] = (vec2(-5.0, -2.0));
	block.var[1][1] = (vec2(5.0, 6.0));
	block.var[1][2] = (vec2(-2.0, -6.0));
	block.var[2][0] = (vec2(-6.0, 1.0));
	block.var[2][1] = (vec2(6.0, -7.0));
	block.var[2][2] = (vec2(6.0, 1.0));
	block.var[3][0] = (vec2(-6.0, -9.0));
	block.var[3][1] = (vec2(0.0, -8.0));
	block.var[3][2] = (vec2(-4.0, -6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_mat3(block.var[0][0], mat3(-8.0, -3.0, -9.0, -1.0, 8.0, 8.0, 3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(1.0, 3.0, 0.0, -1.0, -1.0, -1.0, 5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(1.0, -7.0, 1.0, 3.0, 1.0, 1.0, 4.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(7.0, -9.0, -1.0, 5.0, -4.0, -7.0, -2.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(3.0, 0.0, 1.0, 6.0, 4.0, -7.0, 3.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(9.0, -3.0, 2.0, 4.0, 3.0, -9.0, 6.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(5.0, 7.0, -9.0, 3.0, -3.0, 8.0, 3.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(3.0, 4.0, -7.0, 5.0, -5.0, 5.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(-9.0, -4.0, 5.0, 3.0, 1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(1.0, -5.0, 4.0, 2.0, -5.0, 1.0, 7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(7.0, 8.0, 5.0, 7.0, 0.0, 0.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(9.0, -5.0, 8.0, -5.0, -9.0, 7.0, -3.0, 8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8.0);
	block.var[0][0][0] = (vec3(6.0, 2.0, -9.0));
	block.var[0][0][1] = (vec3(-8.0, 5.0, 2.0));
	block.var[0][0][2] = (vec3(3.0, 9.0, 3.0));
	block.var[0][1][0] = (vec3(2.0, -9.0, -5.0));
	block.var[0][1][1] = (vec3(5.0, 8.0, 8.0));
	block.var[0][1][2] = (vec3(-3.0, -4.0, -5.0));
	block.var[0][2][0] = (vec3(3.0, -5.0, -4.0));
	block.var[0][2][1] = (vec3(-7.0, 5.0, 3.0));
	block.var[0][2][2] = (vec3(-3.0, -3.0, -8.0));
	block.var[1][0][0] = (vec3(8.0, 2.0, -9.0));
	block.var[1][0][1] = (vec3(-3.0, 6.0, -3.0));
	block.var[1][0][2] = (vec3(7.0, 8.0, 7.0));
	block.var[1][1][0] = (vec3(-7.0, 6.0, -7.0));
	block.var[1][1][1] = (vec3(2.0, 3.0, -3.0));
	block.var[1][1][2] = (vec3(-3.0, 6.0, -1.0));
	block.var[1][2][0] = (vec3(8.0, 4.0, -3.0));
	block.var[1][2][1] = (vec3(8.0, -6.0, 4.0));
	block.var[1][2][2] = (vec3(-5.0, -1.0, 5.0));
	block.var[2][0][0] = (vec3(1.0, -3.0, -7.0));
	block.var[2][0][1] = (vec3(-5.0, 4.0, 1.0));
	block.var[2][0][2] = (vec3(9.0, -7.0, -3.0));
	block.var[2][1][0] = (vec3(-5.0, 6.0, 2.0));
	block.var[2][1][1] = (vec3(-9.0, -9.0, -1.0));
	block.var[2][1][2] = (vec3(-5.0, -8.0, 2.0));
	block.var[2][2][0] = (vec3(-6.0, 0.0, 3.0));
	block.var[2][2][1] = (vec3(9.0, -8.0, 3.0));
	block.var[2][2][2] = (vec3(8.0, -8.0, -9.0));
	block.var[3][0][0] = (vec3(6.0, -4.0, -8.0));
	block.var[3][0][1] = (vec3(3.0, 8.0, 1.0));
	block.var[3][0][2] = (vec3(9.0, 2.0, -9.0));
	block.var[3][1][0] = (vec3(-4.0, -1.0, -4.0));
	block.var[3][1][1] = (vec3(-6.0, 4.0, 9.0));
	block.var[3][1][2] = (vec3(-5.0, -7.0, -3.0));
	block.var[3][2][0] = (vec3(-9.0, -5.0, -9.0));
	block.var[3][2][1] = (vec3(-1.0, -9.0, 7.0));
	block.var[3][2][2] = (vec3(-9.0, 0.0, -4.0));
}
#version 450
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
	bool var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.var[0][0][0]), false) && allOk;
	allOk = compare_bool((block.var[0][0][1]), true) && allOk;
	allOk = compare_bool((block.var[0][0][2]), true) && allOk;
	allOk = compare_bool((block.var[0][1][0]), true) && allOk;
	allOk = compare_bool((block.var[0][1][1]), false) && allOk;
	allOk = compare_bool((block.var[0][1][2]), true) && allOk;
	allOk = compare_bool((block.var[1][0][0]), false) && allOk;
	allOk = compare_bool((block.var[1][0][1]), false) && allOk;
	allOk = compare_bool((block.var[1][0][2]), true) && allOk;
	allOk = compare_bool((block.var[1][1][0]), true) && allOk;
	allOk = compare_bool((block.var[1][1][1]), false) && allOk;
	allOk = compare_bool((block.var[1][1][2]), true) && allOk;
	allOk = compare_bool((block.var[2][0][0]), true) && allOk;
	allOk = compare_bool((block.var[2][0][1]), false) && allOk;
	allOk = compare_bool((block.var[2][0][2]), false) && allOk;
	allOk = compare_bool((block.var[2][1][0]), false) && allOk;
	allOk = compare_bool((block.var[2][1][1]), false) && allOk;
	allOk = compare_bool((block.var[2][1][2]), false) && allOk;
	allOk = compare_bool((block.var[3][0][0]), false) && allOk;
	allOk = compare_bool((block.var[3][0][1]), false) && allOk;
	allOk = compare_bool((block.var[3][0][2]), true) && allOk;
	allOk = compare_bool((block.var[3][1][0]), true) && allOk;
	allOk = compare_bool((block.var[3][1][1]), false) && allOk;
	allOk = compare_bool((block.var[3][1][2]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (false);
	block.var[0][0][1] = (false);
	block.var[0][0][2] = (true);
	block.var[0][1][0] = (false);
	block.var[0][1][1] = (false);
	block.var[0][1][2] = (true);
	block.var[1][0][0] = (true);
	block.var[1][0][1] = (false);
	block.var[1][0][2] = (false);
	block.var[1][1][0] = (false);
	block.var[1][1][1] = (true);
	block.var[1][1][2] = (false);
	block.var[2][0][0] = (true);
	block.var[2][0][1] = (true);
	block.var[2][0][2] = (true);
	block.var[2][1][0] = (true);
	block.var[2][1][1] = (true);
	block.var[2][1][2] = (true);
	block.var[3][0][0] = (true);
	block.var[3][0][1] = (false);
	block.var[3][0][2] = (false);
	block.var[3][1][0] = (true);
	block.var[3][1][1] = (true);
	block.var[3][1][2] = (false);
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(5.0, 9.0, -5.0, -4.0, 8.0, 3.0, -4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(5.0, 6.0, -6.0, -5.0, 4.0, 8.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(-6.0, 8.0, 9.0, 6.0, -6.0, -2.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-4.0, -8.0, -2.0, -5.0, -4.0, 2.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(-3.0, 9.0, 1.0, -4.0, -5.0, -5.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(6.0, -5.0, -2.0, 1.0, -4.0, 8.0, 3.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(2.0, -7.0, 1.0, -7.0, -9.0, 5.0, 3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(4.0, -6.0, -5.0, -8.0, 3.0, -6.0, 3.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(-6.0, 0.0, 3.0, 6.0, -8.0, 1.0, -6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(3.0, -6.0, -3.0, -4.0, 8.0, 1.0, -8.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(-3.0, 1.0, -5.0, 4.0, -6.0, 6.0, 1.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(5.0, 0.0, 0.0, -4.0, 5.0, -5.0, 4.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	block.var[0][0][1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	block.var[0][0][2] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
	block.var[0][1][0] = (mat3(-1.0, -3.0, 0.0, -4.0, -7.0, -5.0, 9.0, -1.0, -7.0));
	block.var[0][1][1] = (mat3(5.0, -8.0, 9.0, -7.0, 9.0, -8.0, -5.0, 9.0, 2.0));
	block.var[0][1][2] = (mat3(1.0, 9.0, -9.0, -1.0, 3.0, -5.0, -4.0, -9.0, -8.0));
	block.var[1][0][0] = (mat3(2.0, 1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0));
	block.var[1][0][1] = (mat3(-6.0, -8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0));
	block.var[1][0][2] = (mat3(2.0, -3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0));
	block.var[1][1][0] = (mat3(-9.0, 2.0, -4.0, -6.0, -2.0, 6.0, 4.0, 3.0, 0.0));
	block.var[1][1][1] = (mat3(-1.0, -8.0, -2.0, -5.0, 5.0, -8.0, -3.0, 4.0, -4.0));
	block.var[1][1][2] = (mat3(-5.0, 2.0, 5.0, 6.0, 7.0, 9.0, 1.0, -2.0, -9.0));
	block.var[2][0][0] = (mat3(3.0, 5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0));
	block.var[2][0][1] = (mat3(0.0, -4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0));
	block.var[2][0][2] = (mat3(9.0, 7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0));
	block.var[2][1][0] = (mat3(-6.0, -1.0, 0.0, -3.0, 8.0, -1.0, 6.0, 0.0, -6.0));
	block.var[2][1][1] = (mat3(9.0, 2.0, 4.0, 2.0, 8.0, -1.0, 0.0, -8.0, -9.0));
	block.var[2][1][2] = (mat3(-3.0, -9.0, 2.0, -3.0, 0.0, -5.0, -7.0, 7.0, -2.0));
	block.var[3][0][0] = (mat3(-6.0, -7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0));
	block.var[3][0][1] = (mat3(2.0, 4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0));
	block.var[3][0][2] = (mat3(-8.0, 3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0));
	block.var[3][1][0] = (mat3(-8.0, 6.0, -6.0, 7.0, -9.0, -1.0, -7.0, 3.0, -2.0));
	block.var[3][1][1] = (mat3(6.0, -4.0, 4.0, 1.0, -6.0, -5.0, 0.0, 0.0, -2.0));
	block.var[3][1][2] = (mat3(2.0, -2.0, 2.0, 5.0, 1.0, -4.0, 3.0, 5.0, -2.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(1.0, -6.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-3.0, 6.0, -4.0, -1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(2.0, -1.0, -8.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(0.0, 9.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(-8.0, 3.0, 8.0, -7.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(8.0, 4.0, -2.0, -2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(-7.0, 5.0, -9.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(3.0, -4.0, 0.0, -3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(-4.0, -2.0, 6.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(7.0, -5.0, -3.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(-9.0, -6.0, 5.0, -2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(8.0, 1.0, 8.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(0.0, 0.0, 5.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(3.0, -2.0, -1.0, 5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(-5.0, -2.0, 9.0, 2.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(-1.0, -2.0, -9.0, -1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(-5.0, -6.0, -3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(-3.0, -8.0, -9.0, -8.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(4.0, -4.0, -3.0, -5.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(-2.0, 0.0, 3.0, 7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(7.0, 7.0, -2.0, -8.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(4.0, 5.0, -6.0));
	block.var[0][0][0][1] = (vec3(0.0, -8.0, -2.0));
	block.var[0][0][1][0] = (vec3(8.0, 8.0, 0.0));
	block.var[0][0][1][1] = (vec3(3.0, -6.0, -6.0));
	block.var[0][0][2][0] = (vec3(-1.0, 2.0, -9.0));
	block.var[0][0][2][1] = (vec3(1.0, 3.0, 2.0));
	block.var[0][1][0][0] = (vec3(-7.0, 8.0, -3.0));
	block.var[0][1][0][1] = (vec3(3.0, 8.0, 1.0));
	block.var[0][1][1][0] = (vec3(3.0, 6.0, 2.0));
	block.var[0][1][1][1] = (vec3(9.0, -2.0, -9.0));
	block.var[0][1][2][0] = (vec3(-9.0, 6.0, -2.0));
	block.var[0][1][2][1] = (vec3(-3.0, -8.0, -5.0));
	block.var[1][0][0][0] = (vec3(1.0, 5.0, -6.0));
	block.var[1][0][0][1] = (vec3(-8.0, -6.0, -5.0));
	block.var[1][0][1][0] = (vec3(-9.0, 6.0, -9.0));
	block.var[1][0][1][1] = (vec3(0.0, -1.0, -3.0));
	block.var[1][0][2][0] = (vec3(-6.0, 9.0, 7.0));
	block.var[1][0][2][1] = (vec3(-5.0, -7.0, -2.0));
	block.var[1][1][0][0] = (vec3(-2.0, -5.0, 0.0));
	block.var[1][1][0][1] = (vec3(-9.0, -9.0, -9.0));
	block.var[1][1][1][0] = (vec3(-9.0, -3.0, -1.0));
	block.var[1][1][1][1] = (vec3(7.0, 1.0, 1.0));
	block.var[1][1][2][0] = (vec3(4.0, -2.0, 7.0));
	block.var[1][1][2][1] = (vec3(0.0, 1.0, 9.0));
	block.var[2][0][0][0] = (vec3(-1.0, -3.0, 0.0));
	block.var[2][0][0][1] = (vec3(3.0, 3.0, 5.0));
	block.var[2][0][1][0] = (vec3(-1.0, -1.0, 3.0));
	block.var[2][0][1][1] = (vec3(-1.0, -7.0, 7.0));
	block.var[2][0][2][0] = (vec3(-6.0, -6.0, -8.0));
	block.var[2][0][2][1] = (vec3(2.0, -4.0, -3.0));
	block.var[2][1][0][0] = (vec3(-4.0, 0.0, -1.0));
	block.var[2][1][0][1] = (vec3(8.0, 9.0, -4.0));
	block.var[2][1][1][0] = (vec3(6.0, 5.0, -2.0));
	block.var[2][1][1][1] = (vec3(0.0, 6.0, 6.0));
	block.var[2][1][2][0] = (vec3(3.0, 8.0, 3.0));
	block.var[2][1][2][1] = (vec3(2.0, 2.0, -8.0));
	block.var[3][0][0][0] = (vec3(-3.0, 4.0, 8.0));
	block.var[3][0][0][1] = (vec3(7.0, -2.0, -7.0));
	block.var[3][0][1][0] = (vec3(-5.0, 5.0, -5.0));
	block.var[3][0][1][1] = (vec3(1.0, -1.0, 7.0));
	block.var[3][0][2][0] = (vec3(-5.0, 8.0, -7.0));
	block.var[3][0][2][1] = (vec3(-2.0, 4.0, 3.0));
	block.var[3][1][0][0] = (vec3(0.0, -1.0, 2.0));
	block.var[3][1][0][1] = (vec3(7.0, 7.0, 4.0));
	block.var[3][1][1][0] = (vec3(-1.0, -5.0, -6.0));
	block.var[3][1][1][1] = (vec3(-9.0, 7.0, 3.0));
	block.var[3][1][2][0] = (vec3(7.0, 3.0, -9.0));
	block.var[3][1][2][1] = (vec3(1.0, -3.0, 5.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(6.0, 7.0, 9.0, 7.0, 0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(7.0, -7.0, 1.0, 0.0, -9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(0.0, 8.0, -8.0, -9.0, 5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(9.0, -4.0, -6.0, 0.0, 0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(5.0, 2.0, -1.0, 1.0, 1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(-5.0, 1.0, 4.0, 5.0, 5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-2.0, -2.0, 7.0, -9.0, 3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-9.0, 0.0, -2.0, -3.0, 4.0, -7.0, 8.0, -2.0, -7.0, -1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(6.0, 7.0, 1.0, 5.0, 4.0, 9.0, 5.0, 4.0, 9.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(1.0, 0.0, -7.0, -4.0, -3.0, 3.0, -7.0, 4.0, 1.0, 0.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(-1.0, 9.0, 4.0, -7.0, -2.0, 8.0, 8.0, 5.0, 3.0, -7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(-8.0, -3.0, 1.0, -8.0, -6.0, 9.0, 2.0, 4.0, 4.0, 1.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	block.var[0][0][0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block.var[0][0][0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block.var[0][0][1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	block.var[0][0][1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	block.var[0][0][1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block.var[0][0][2][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	block.var[0][0][2][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block.var[0][0][2][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	block.var[0][1][0][0] = (vec4(6.0, 2.0, 8.0, -5.0));
	block.var[0][1][0][1] = (vec4(9.0, 5.0, 9.0, -1.0));
	block.var[0][1][0][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[0][1][1][0] = (vec4(0.0, -4.0, 7.0, 1.0));
	block.var[0][1][1][1] = (vec4(4.0, 1.0, 9.0, 9.0));
	block.var[0][1][1][2] = (vec4(-9.0, -5.0, 3.0, 8.0));
	block.var[0][1][2][0] = (vec4(4.0, -1.0, -2.0, 2.0));
	block.var[0][1][2][1] = (vec4(-5.0, 4.0, -2.0, -4.0));
	block.var[0][1][2][2] = (vec4(8.0, -7.0, -1.0, -9.0));
	block.var[1][0][0][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	block.var[1][0][0][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	block.var[1][0][0][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	block.var[1][0][1][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	block.var[1][0][1][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	block.var[1][0][1][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	block.var[1][0][2][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	block.var[1][0][2][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	block.var[1][0][2][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	block.var[1][1][0][0] = (vec4(8.0, 5.0, 3.0, 6.0));
	block.var[1][1][0][1] = (vec4(0.0, 6.0, 0.0, 2.0));
	block.var[1][1][0][2] = (vec4(-1.0, -5.0, -6.0, -4.0));
	block.var[1][1][1][0] = (vec4(-3.0, -5.0, -4.0, -4.0));
	block.var[1][1][1][1] = (vec4(-8.0, -8.0, 1.0, 7.0));
	block.var[1][1][1][2] = (vec4(-6.0, -3.0, -7.0, 1.0));
	block.var[1][1][2][0] = (vec4(-5.0, 5.0, 0.0, 1.0));
	block.var[1][1][2][1] = (vec4(6.0, 2.0, 5.0, 5.0));
	block.var[1][1][2][2] = (vec4(5.0, -1.0, -7.0, -1.0));
	block.var[2][0][0][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	block.var[2][0][0][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	block.var[2][0][0][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	block.var[2][0][1][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	block.var[2][0][1][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	block.var[2][0][1][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	block.var[2][0][2][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	block.var[2][0][2][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	block.var[2][0][2][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	block.var[2][1][0][0] = (vec4(1.0, -1.0, -4.0, 2.0));
	block.var[2][1][0][1] = (vec4(5.0, 8.0, 5.0, -9.0));
	block.var[2][1][0][2] = (vec4(7.0, -9.0, 0.0, -3.0));
	block.var[2][1][1][0] = (vec4(-6.0, 6.0, -6.0, -5.0));
	block.var[2][1][1][1] = (vec4(5.0, 3.0, 4.0, 8.0));
	block.var[2][1][1][2] = (vec4(7.0, 0.0, -5.0, -6.0));
	block.var[2][1][2][0] = (vec4(5.0, 0.0, 8.0, 4.0));
	block.var[2][1][2][1] = (vec4(3.0, -1.0, -7.0, 0.0));
	block.var[2][1][2][2] = (vec4(-1.0, 6.0, -6.0, 1.0));
	block.var[3][0][0][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	block.var[3][0][0][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	block.var[3][0][0][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	block.var[3][0][1][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	block.var[3][0][1][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	block.var[3][0][1][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	block.var[3][0][2][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	block.var[3][0][2][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	block.var[3][0][2][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
	block.var[3][1][0][0] = (vec4(0.0, 8.0, 0.0, 9.0));
	block.var[3][1][0][1] = (vec4(-6.0, 8.0, -5.0, -1.0));
	block.var[3][1][0][2] = (vec4(0.0, 6.0, -9.0, 9.0));
	block.var[3][1][1][0] = (vec4(8.0, -2.0, -5.0, 0.0));
	block.var[3][1][1][1] = (vec4(1.0, 4.0, -3.0, -6.0));
	block.var[3][1][1][2] = (vec4(2.0, -2.0, -2.0, 3.0));
	block.var[3][1][2][0] = (vec4(-5.0, -4.0, -6.0, 2.0));
	block.var[3][1][2][1] = (vec4(-6.0, 0.0, 1.0, 9.0));
	block.var[3][1][2][2] = (vec4(2.0, 5.0, -8.0, 5.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(0.0, 6.0, 3.0, 9.0, -3.0, 9.0, 3.0, -5.0, -1.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-7.0, 6.0, 5.0, -7.0, -2.0, -4.0, 0.0, -8.0, 8.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(4.0, 4.0, -6.0, -2.0, 7.0, 1.0, -3.0, -2.0, -6.0, -2.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-6.0, -4.0, 8.0, -5.0, -5.0, 7.0, 3.0, -1.0, 7.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(5.0, -1.0, 4.0, -5.0, -8.0, -7.0, 7.0, -6.0, -4.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(-5.0, 3.0, 9.0, 0.0, 1.0, 3.0, -8.0, -9.0, 5.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-2.0, 9.0, -5.0, -3.0, 3.0, 5.0, 4.0, -7.0, -1.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-5.0, 1.0, 5.0, -9.0, 3.0, 5.0, 3.0, 8.0, -8.0, -5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(-9.0, -3.0, -8.0, -8.0, 8.0, 8.0, 3.0, -6.0, -7.0, 4.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(7.0, 0.0, 9.0, -1.0, 2.0, 9.0, -3.0, 7.0, 4.0, -2.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(-4.0, -4.0, -1.0, -8.0, 9.0, -4.0, -1.0, -5.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(7.0, -1.0, -3.0, -4.0, -4.0, -3.0, 3.0, -7.0, -5.0, 8.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	block.var[0][0][1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	block.var[0][0][2] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
	block.var[0][1][0] = (mat3x4(-6.0, 0.0, 1.0, -2.0, 1.0, -4.0, -2.0, -6.0, -7.0, -8.0, 0.0, -8.0));
	block.var[0][1][1] = (mat3x4(0.0, 2.0, 9.0, -5.0, 9.0, -5.0, -4.0, 0.0, 4.0, 1.0, 0.0, -9.0));
	block.var[0][1][2] = (mat3x4(1.0, -1.0, -4.0, 9.0, 7.0, 3.0, 5.0, 1.0, 6.0, 6.0, 2.0, 2.0));
	block.var[1][0][0] = (mat3x4(-5.0, -5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0));
	block.var[1][0][1] = (mat3x4(-5.0, 5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0));
	block.var[1][0][2] = (mat3x4(-9.0, -1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0));
	block.var[1][1][0] = (mat3x4(8.0, -5.0, -9.0, 8.0, -3.0, -3.0, 9.0, -9.0, 6.0, -4.0, 9.0, 4.0));
	block.var[1][1][1] = (mat3x4(-8.0, 4.0, 7.0, 3.0, -1.0, -1.0, 9.0, -9.0, 8.0, -3.0, 9.0, -6.0));
	block.var[1][1][2] = (mat3x4(-4.0, 6.0, 2.0, 5.0, 3.0, 7.0, 3.0, 4.0, -4.0, 2.0, 0.0, 8.0));
	block.var[2][0][0] = (mat3x4(-4.0, 2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0));
	block.var[2][0][1] = (mat3x4(9.0, -2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0));
	block.var[2][0][2] = (mat3x4(-6.0, 5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0));
	block.var[2][1][0] = (mat3x4(-8.0, 0.0, 8.0, -6.0, -2.0, -3.0, 6.0, 4.0, 9.0, -2.0, 4.0, 1.0));
	block.var[2][1][1] = (mat3x4(-9.0, -5.0, -8.0, 5.0, 4.0, 2.0, 7.0, 1.0, -6.0, 2.0, -6.0, -4.0));
	block.var[2][1][2] = (mat3x4(-3.0, 1.0, -5.0, -9.0, -2.0, 3.0, 0.0, -4.0, 8.0, -3.0, 4.0, 9.0));
	block.var[3][0][0] = (mat3x4(9.0, 2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0));
	block.var[3][0][1] = (mat3x4(-1.0, 4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0));
	block.var[3][0][2] = (mat3x4(-9.0, 1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0));
	block.var[3][1][0] = (mat3x4(-6.0, -1.0, 3.0, -9.0, -6.0, -6.0, -3.0, 5.0, 0.0, -9.0, -4.0, 9.0));
	block.var[3][1][1] = (mat3x4(-8.0, 6.0, -4.0, -3.0, -4.0, 3.0, 3.0, 4.0, 4.0, 4.0, 3.0, 8.0));
	block.var[3][1][2] = (mat3x4(-3.0, -6.0, -3.0, 6.0, -9.0, -3.0, -6.0, 9.0, 3.0, -1.0, 6.0, 3.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	i8vec2 var[4][2][3];
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
	allOk = compare_i8vec2(ivec2(block.var[0][0][2]), ivec2(0, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][1][0]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][1][1]), ivec2(2, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][1][2]), ivec2(4294967290, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][0][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][0][1]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][0][2]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][1][0]), ivec2(5, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][1][1]), ivec2(8, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][1][2]), ivec2(4294967294, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][0][0]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][0][1]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][0][2]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][1][0]), ivec2(7, 4294967292)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][1][1]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][1][2]), ivec2(2, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][0][0]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][0][1]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][0][2]), ivec2(3, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][1][0]), ivec2(0, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][1][1]), ivec2(4294967289, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][1][2]), ivec2(7, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i8vec2(ivec2(0, 8));
	block.var[0][0][1] = i8vec2(ivec2(4294967292, 9));
	block.var[0][0][2] = i8vec2(ivec2(4294967294, 4294967295));
	block.var[0][1][0] = i8vec2(ivec2(4294967293, 0));
	block.var[0][1][1] = i8vec2(ivec2(3, 4294967291));
	block.var[0][1][2] = i8vec2(ivec2(4294967295, 4294967292));
	block.var[1][0][0] = i8vec2(ivec2(8, 4294967290));
	block.var[1][0][1] = i8vec2(ivec2(8, 4294967289));
	block.var[1][0][2] = i8vec2(ivec2(7, 4294967294));
	block.var[1][1][0] = i8vec2(ivec2(5, 4294967292));
	block.var[1][1][1] = i8vec2(ivec2(4294967291, 4));
	block.var[1][1][2] = i8vec2(ivec2(0, 4294967293));
	block.var[2][0][0] = i8vec2(ivec2(4294967293, 4294967293));
	block.var[2][0][1] = i8vec2(ivec2(4294967290, 3));
	block.var[2][0][2] = i8vec2(ivec2(4294967295, 8));
	block.var[2][1][0] = i8vec2(ivec2(4294967292, 4294967292));
	block.var[2][1][1] = i8vec2(ivec2(3, 4294967294));
	block.var[2][1][2] = i8vec2(ivec2(8, 4));
	block.var[3][0][0] = i8vec2(ivec2(5, 8));
	block.var[3][0][1] = i8vec2(ivec2(4294967293, 4294967292));
	block.var[3][0][2] = i8vec2(ivec2(4294967287, 6));
	block.var[3][1][0] = i8vec2(ivec2(8, 6));
	block.var[3][1][1] = i8vec2(ivec2(5, 4294967294));
	block.var[3][1][2] = i8vec2(ivec2(4294967288, 4294967292));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(0.0, 7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(8.0, 8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(3.0, -3.0, -9.0, 4.0, -4.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(-1.0, -6.0, -9.0, 0.0, 2.0, -7.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(1.0, -1.0, 1.0, -8.0, -7.0, -2.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(-6.0, -7.0, -6.0, 9.0, -2.0, 0.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(3.0, -2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(7.0, 4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(8.0, -7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(4.0, -4.0, -5.0, -5.0, 1.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(-4.0, 2.0, -1.0, -3.0, -7.0, -8.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(2.0, 0.0, 6.0, 6.0, -2.0, -2.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(-7.0, 8.0, 7.0, 7.0, 3.0, -3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-1.0, 0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(2.0, -2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-4.0, 1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(2.0, -3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(4.0, 9.0, -6.0, -7.0, 1.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(2.0, -5.0, -5.0, -2.0, 5.0, 3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(-9.0, 3.0, 2.0, 9.0, 1.0, -1.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-5.0, 0.0, 5.0, 8.0, 6.0, 2.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	block.var[0][0][1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	block.var[0][1][0] = (mat4x2(-4.0, 4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0));
	block.var[0][1][1] = (mat4x2(8.0, -4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0));
	block.var[0][2][0] = (mat4x2(8.0, 9.0, 4.0, -2.0, -8.0, -5.0, -3.0, 9.0));
	block.var[0][2][1] = (mat4x2(9.0, -3.0, 8.0, 2.0, -9.0, 2.0, 1.0, -2.0));
	block.var[0][3][0] = (mat4x2(-4.0, 0.0, 5.0, 8.0, 4.0, -1.0, 1.0, 4.0));
	block.var[0][3][1] = (mat4x2(-1.0, -3.0, -1.0, 1.0, 3.0, 4.0, -6.0, -8.0));
	block.var[1][0][0] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
	block.var[1][0][1] = (mat4x2(8.0, 7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0));
	block.var[1][1][0] = (mat4x2(-4.0, -8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0));
	block.var[1][1][1] = (mat4x2(-5.0, 7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0));
	block.var[1][2][0] = (mat4x2(6.0, 7.0, -3.0, 4.0, 8.0, -4.0, -9.0, -6.0));
	block.var[1][2][1] = (mat4x2(-8.0, 1.0, 6.0, -6.0, 6.0, -2.0, -8.0, 8.0));
	block.var[1][3][0] = (mat4x2(-3.0, 8.0, -7.0, -8.0, 3.0, 0.0, -2.0, 7.0));
	block.var[1][3][1] = (mat4x2(-2.0, 7.0, -8.0, -6.0, 4.0, -9.0, 3.0, -6.0));
	block.var[2][0][0] = (mat4x2(1.0, 6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0));
	block.var[2][0][1] = (mat4x2(3.0, -5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0));
	block.var[2][1][0] = (mat4x2(6.0, -7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0));
	block.var[2][1][1] = (mat4x2(3.0, -8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0));
	block.var[2][2][0] = (mat4x2(0.0, 7.0, -6.0, 0.0, -7.0, 3.0, -3.0, 1.0));
	block.var[2][2][1] = (mat4x2(-4.0, -6.0, -8.0, -9.0, 1.0, 4.0, 2.0, -5.0));
	block.var[2][3][0] = (mat4x2(-7.0, 5.0, 0.0, -5.0, 7.0, 3.0, -1.0, -3.0));
	block.var[2][3][1] = (mat4x2(5.0, -8.0, 1.0, -3.0, 7.0, -8.0, 1.0, -4.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(5.0, -7.0, 2.0, -4.0, -1.0, -2.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(5.0, -7.0, 6.0, 5.0, 2.0, -2.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(-3.0, -5.0, 8.0, -6.0, -4.0, -4.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(-5.0, 4.0, 8.0, -2.0, -6.0, -6.0, 1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(1.0, -3.0, 4.0, 0.0, -1.0, 8.0, 6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(2.0, 7.0, -2.0, 3.0, 3.0, -2.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(6.0, -1.0, 4.0, 5.0, 0.0, 4.0, 4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(5.0, -1.0, -1.0, -6.0, 5.0, -7.0, -5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(9.0, 4.0, -5.0, 1.0, 0.0, -1.0, -5.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(9.0, 4.0, -9.0, 4.0, 7.0, -5.0, 6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(-7.0, 8.0, 7.0, 6.0, 0.0, 5.0, 6.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(-2.0, 7.0, 3.0, -6.0, -7.0, -9.0, -5.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(8.0, 3.0, 9.0));
	block.var[0][0][0][1] = (vec3(6.0, 2.0, -9.0));
	block.var[0][0][0][2] = (vec3(-8.0, 5.0, 2.0));
	block.var[0][0][1][0] = (vec3(3.0, -3.0, -4.0));
	block.var[0][0][1][1] = (vec3(2.0, -9.0, -5.0));
	block.var[0][0][1][2] = (vec3(5.0, 8.0, 8.0));
	block.var[0][1][0][0] = (vec3(5.0, 9.0, -7.0));
	block.var[0][1][0][1] = (vec3(1.0, -3.0, -7.0));
	block.var[0][1][0][2] = (vec3(-5.0, 4.0, 1.0));
	block.var[0][1][1][0] = (vec3(-3.0, -5.0, -8.0));
	block.var[0][1][1][1] = (vec3(-5.0, 6.0, 2.0));
	block.var[0][1][1][2] = (vec3(-9.0, -9.0, -1.0));
	block.var[0][2][0][0] = (vec3(-4.0, 8.0, 7.0));
	block.var[0][2][0][1] = (vec3(1.0, 7.0, -5.0));
	block.var[0][2][0][2] = (vec3(7.0, 9.0, 4.0));
	block.var[0][2][1][0] = (vec3(-2.0, 2.0, 1.0));
	block.var[0][2][1][1] = (vec3(-8.0, -6.0, 7.0));
	block.var[0][2][1][2] = (vec3(-3.0, 2.0, -5.0));
	block.var[0][3][0][0] = (vec3(3.0, 3.0, 8.0));
	block.var[0][3][0][1] = (vec3(1.0, -2.0, 0.0));
	block.var[0][3][0][2] = (vec3(-9.0, 5.0, 1.0));
	block.var[0][3][1][0] = (vec3(-2.0, 0.0, 0.0));
	block.var[0][3][1][1] = (vec3(-3.0, 7.0, -8.0));
	block.var[0][3][1][2] = (vec3(0.0, 1.0, -3.0));
	block.var[1][0][0][0] = (vec3(-5.0, -3.0, -3.0));
	block.var[1][0][0][1] = (vec3(3.0, -5.0, -4.0));
	block.var[1][0][0][2] = (vec3(-7.0, 5.0, 3.0));
	block.var[1][0][1][0] = (vec3(-8.0, 7.0, 8.0));
	block.var[1][0][1][1] = (vec3(8.0, 2.0, -9.0));
	block.var[1][0][1][2] = (vec3(-3.0, 6.0, -3.0));
	block.var[1][1][0][0] = (vec3(2.0, 8.0, -8.0));
	block.var[1][1][0][1] = (vec3(-6.0, 0.0, 3.0));
	block.var[1][1][0][2] = (vec3(9.0, -8.0, 3.0));
	block.var[1][1][1][0] = (vec3(-9.0, 9.0, 2.0));
	block.var[1][1][1][1] = (vec3(6.0, -4.0, -8.0));
	block.var[1][1][1][2] = (vec3(3.0, 8.0, 1.0));
	block.var[1][2][0][0] = (vec3(-6.0, 6.0, -7.0));
	block.var[1][2][0][1] = (vec3(1.0, 3.0, -7.0));
	block.var[1][2][0][2] = (vec3(6.0, -8.0, 4.0));
	block.var[1][2][1][0] = (vec3(-3.0, -8.0, 3.0));
	block.var[1][2][1][1] = (vec3(-5.0, -8.0, 8.0));
	block.var[1][2][1][2] = (vec3(7.0, 2.0, -3.0));
	block.var[1][3][0][0] = (vec3(-7.0, 1.0, 4.0));
	block.var[1][3][0][1] = (vec3(-2.0, -1.0, -5.0));
	block.var[1][3][0][2] = (vec3(-1.0, 4.0, -2.0));
	block.var[1][3][1][0] = (vec3(-9.0, -3.0, 6.0));
	block.var[1][3][1][1] = (vec3(-4.0, 8.0, 0.0));
	block.var[1][3][1][2] = (vec3(-5.0, -4.0, 2.0));
	block.var[2][0][0][0] = (vec3(7.0, -3.0, 6.0));
	block.var[2][0][0][1] = (vec3(-7.0, 6.0, -7.0));
	block.var[2][0][0][2] = (vec3(2.0, 3.0, -3.0));
	block.var[2][0][1][0] = (vec3(-1.0, -5.0, -1.0));
	block.var[2][0][1][1] = (vec3(8.0, 4.0, -3.0));
	block.var[2][0][1][2] = (vec3(8.0, -6.0, 4.0));
	block.var[2][1][0][0] = (vec3(-9.0, -5.0, -7.0));
	block.var[2][1][0][1] = (vec3(-4.0, -1.0, -4.0));
	block.var[2][1][0][2] = (vec3(-6.0, 4.0, 9.0));
	block.var[2][1][1][0] = (vec3(-3.0, -9.0, 0.0));
	block.var[2][1][1][1] = (vec3(-9.0, -5.0, -9.0));
	block.var[2][1][1][2] = (vec3(-1.0, -9.0, 7.0));
	block.var[2][2][0][0] = (vec3(3.0, -1.0, -6.0));
	block.var[2][2][0][1] = (vec3(-1.0, 6.0, 7.0));
	block.var[2][2][0][2] = (vec3(9.0, -1.0, 2.0));
	block.var[2][2][1][0] = (vec3(-9.0, -6.0, 9.0));
	block.var[2][2][1][1] = (vec3(4.0, 9.0, 5.0));
	block.var[2][2][1][2] = (vec3(5.0, 4.0, -9.0));
	block.var[2][3][0][0] = (vec3(-8.0, 0.0, -8.0));
	block.var[2][3][0][1] = (vec3(-8.0, 8.0, 0.0));
	block.var[2][3][0][2] = (vec3(-8.0, -6.0, -9.0));
	block.var[2][3][1][0] = (vec3(1.0, 3.0, 8.0));
	block.var[2][3][1][1] = (vec3(-2.0, 9.0, -6.0));
	block.var[2][3][1][2] = (vec3(-2.0, 6.0, 0.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-3.0, 7.0, 3.0, 4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(5.0, -6.0, -2.0, 1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(2.0, -3.0, 7.0, -7.0, -3.0, -9.0, 0.0, 4.0, 2.0, -2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(7.0, -3.0, 5.0, -8.0, 3.0, -8.0, 3.0, 6.0, 3.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(3.0, 2.0, -1.0, -2.0, -5.0, 9.0, -1.0, -2.0, 6.0, -5.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(0.0, 6.0, 8.0, -6.0, -9.0, 1.0, 7.0, -9.0, 1.0, 3.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-9.0, -4.0, -6.0, -5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(6.0, 1.0, 3.0, -8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(5.0, -6.0, 2.0, -3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(0.0, -9.0, -2.0, -4.0, -7.0, 3.0, -9.0, 6.0, -1.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(3.0, 8.0, -7.0, -3.0, 4.0, 9.0, 4.0, -3.0, -3.0, 0.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(8.0, 4.0, -9.0, 4.0, -6.0, 5.0, 3.0, -4.0, 0.0, -3.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(6.0, -5.0, -8.0, -6.0, -3.0, 7.0, 0.0, 0.0, 0.0, -8.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-9.0, 7.0, -2.0, 5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(3.0, -7.0, -4.0, -1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(5.0, 3.0, -8.0, 6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-7.0, -1.0, 3.0, -3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(-9.0, -2.0, 5.0, 9.0, -9.0, 7.0, -7.0, -8.0, 2.0, -8.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(4.0, -3.0, 9.0, -4.0, 9.0, 3.0, -2.0, 9.0, 0.0, -3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(6.0, -4.0, -1.0, -9.0, -9.0, 1.0, -3.0, -7.0, 9.0, -8.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(2.0, 2.0, -6.0, -5.0, 6.0, -7.0, -8.0, -1.0, 7.0, -2.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	block.var[0][0][1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	block.var[0][1][0] = (mat4x3(0.0, 5.0, -1.0, -3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0));
	block.var[0][1][1] = (mat4x3(2.0, 9.0, -6.0, 5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0));
	block.var[0][2][0] = (mat4x3(7.0, -6.0, 6.0, 6.0, 0.0, 6.0, -2.0, 0.0, 4.0, -2.0, -4.0, 0.0));
	block.var[0][2][1] = (mat4x3(0.0, 0.0, 8.0, 0.0, 5.0, -8.0, -7.0, 0.0, 2.0, 1.0, 6.0, -6.0));
	block.var[0][3][0] = (mat4x3(-3.0, -3.0, 9.0, 5.0, -4.0, 6.0, 4.0, -2.0, 9.0, 0.0, -7.0, 3.0));
	block.var[0][3][1] = (mat4x3(5.0, 0.0, 3.0, 8.0, 3.0, -1.0, 5.0, -3.0, 7.0, 3.0, -2.0, 5.0));
	block.var[1][0][0] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
	block.var[1][0][1] = (mat4x3(-7.0, 2.0, -4.0, -9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0));
	block.var[1][1][0] = (mat4x3(8.0, 9.0, 0.0, 1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0));
	block.var[1][1][1] = (mat4x3(2.0, 7.0, 3.0, 1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0));
	block.var[1][2][0] = (mat4x3(-9.0, 8.0, 6.0, 9.0, -9.0, 5.0, -2.0, 2.0, -2.0, 2.0, -6.0, -1.0));
	block.var[1][2][1] = (mat4x3(1.0, -7.0, -5.0, 9.0, -4.0, -7.0, -9.0, 7.0, -4.0, 9.0, -3.0, 3.0));
	block.var[1][3][0] = (mat4x3(6.0, -8.0, -9.0, -9.0, 6.0, 1.0, 0.0, 5.0, 1.0, -6.0, 1.0, 8.0));
	block.var[1][3][1] = (mat4x3(5.0, 2.0, 7.0, -9.0, -9.0, 7.0, -3.0, 4.0, -7.0, -4.0, -8.0, -6.0));
	block.var[2][0][0] = (mat4x3(0.0, 1.0, -1.0, -6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0));
	block.var[2][0][1] = (mat4x3(-9.0, -1.0, -4.0, -9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0));
	block.var[2][1][0] = (mat4x3(-1.0, 7.0, 7.0, 4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0));
	block.var[2][1][1] = (mat4x3(9.0, 4.0, 1.0, -2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0));
	block.var[2][2][0] = (mat4x3(7.0, -7.0, -2.0, -5.0, 7.0, 7.0, -1.0, 6.0, -1.0, 6.0, -9.0, 8.0));
	block.var[2][2][1] = (mat4x3(8.0, 7.0, -8.0, 1.0, 9.0, -1.0, -8.0, -3.0, 7.0, 9.0, -5.0, 8.0));
	block.var[2][3][0] = (mat4x3(-1.0, 7.0, 7.0, 4.0, -5.0, -2.0, 5.0, -3.0, -9.0, 0.0, 8.0, 3.0));
	block.var[2][3][1] = (mat4x3(7.0, -1.0, -2.0, 1.0, 4.0, -8.0, 6.0, 1.0, 4.0, -6.0, -1.0, 0.0));
}
#version 450
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
	highp ivec2 var[][4][2];
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
	allOk = compare_ivec2((block.var[0][1][0]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((block.var[0][1][1]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block.var[0][2][0]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((block.var[0][2][1]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block.var[0][3][0]), ivec2(6, 3)) && allOk;
	allOk = compare_ivec2((block.var[0][3][1]), ivec2(-5, -3)) && allOk;
	allOk = compare_ivec2((block.var[1][0][0]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((block.var[1][0][1]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block.var[1][1][0]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((block.var[1][1][1]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((block.var[1][2][0]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((block.var[1][2][1]), ivec2(-4, -3)) && allOk;
	allOk = compare_ivec2((block.var[1][3][0]), ivec2(-4, 7)) && allOk;
	allOk = compare_ivec2((block.var[1][3][1]), ivec2(-3, -4)) && allOk;
	allOk = compare_ivec2((block.var[2][0][0]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block.var[2][0][1]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((block.var[2][1][0]), ivec2(-8, 3)) && allOk;
	allOk = compare_ivec2((block.var[2][1][1]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((block.var[2][2][0]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((block.var[2][2][1]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((block.var[2][3][0]), ivec2(8, -5)) && allOk;
	allOk = compare_ivec2((block.var[2][3][1]), ivec2(-2, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (ivec2(-6, 8));
	block.var[0][0][1] = (ivec2(3, -1));
	block.var[0][1][0] = (ivec2(-6, -4));
	block.var[0][1][1] = (ivec2(3, -2));
	block.var[0][2][0] = (ivec2(4, 1));
	block.var[0][2][1] = (ivec2(1, 9));
	block.var[0][3][0] = (ivec2(-3, -1));
	block.var[0][3][1] = (ivec2(-4, 6));
	block.var[1][0][0] = (ivec2(-5, -2));
	block.var[1][0][1] = (ivec2(0, -2));
	block.var[1][1][0] = (ivec2(5, -7));
	block.var[1][1][1] = (ivec2(-3, 4));
	block.var[1][2][0] = (ivec2(-2, -9));
	block.var[1][2][1] = (ivec2(9, 6));
	block.var[1][3][0] = (ivec2(-4, -7));
	block.var[1][3][1] = (ivec2(-9, 1));
	block.var[2][0][0] = (ivec2(5, 2));
	block.var[2][0][1] = (ivec2(-8, 4));
	block.var[2][1][0] = (ivec2(1, 6));
	block.var[2][1][1] = (ivec2(8, 7));
	block.var[2][2][0] = (ivec2(-8, 1));
	block.var[2][2][1] = (ivec2(-3, 2));
	block.var[2][3][0] = (ivec2(8, 1));
	block.var[2][3][1] = (ivec2(-8, 3));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(-8.0, 3.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(0.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(3.0, 2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(-9.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(-1.0, 2.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(-8.0, 0.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(-9.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(-8.0, -2.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(-4.0, 3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(-3.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(-1.0, 2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(-6.0, -9.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-2.0, 1.0));
	block.var[0][0][0][1] = (vec2(-7.0, -1.0));
	block.var[0][0][1][0] = (vec2(5.0, -3.0));
	block.var[0][0][1][1] = (vec2(4.0, 8.0));
	block.var[0][1][0][0] = (vec2(-4.0, 2.0));
	block.var[0][1][0][1] = (vec2(-1.0, -4.0));
	block.var[0][1][1][0] = (vec2(-5.0, -8.0));
	block.var[0][1][1][1] = (vec2(3.0, -7.0));
	block.var[0][2][0][0] = (vec2(-7.0, 2.0));
	block.var[0][2][0][1] = (vec2(-9.0, 3.0));
	block.var[0][2][1][0] = (vec2(7.0, 9.0));
	block.var[0][2][1][1] = (vec2(-8.0, 3.0));
	block.var[0][3][0][0] = (vec2(-4.0, 7.0));
	block.var[0][3][0][1] = (vec2(4.0, 1.0));
	block.var[0][3][1][0] = (vec2(-1.0, -7.0));
	block.var[0][3][1][1] = (vec2(-5.0, 1.0));
	block.var[1][0][0][0] = (vec2(-2.0, -6.0));
	block.var[1][0][0][1] = (vec2(-5.0, -1.0));
	block.var[1][0][1][0] = (vec2(3.0, 4.0));
	block.var[1][0][1][1] = (vec2(-8.0, 6.0));
	block.var[1][1][0][0] = (vec2(5.0, 0.0));
	block.var[1][1][0][1] = (vec2(-4.0, -9.0));
	block.var[1][1][1][0] = (vec2(9.0, 1.0));
	block.var[1][1][1][1] = (vec2(7.0, 9.0));
	block.var[1][2][0][0] = (vec2(-8.0, -9.0));
	block.var[1][2][0][1] = (vec2(3.0, -5.0));
	block.var[1][2][1][0] = (vec2(7.0, 8.0));
	block.var[1][2][1][1] = (vec2(-8.0, 4.0));
	block.var[1][3][0][0] = (vec2(-1.0, 7.0));
	block.var[1][3][0][1] = (vec2(0.0, 9.0));
	block.var[1][3][1][0] = (vec2(-6.0, 1.0));
	block.var[1][3][1][1] = (vec2(-3.0, 1.0));
	block.var[2][0][0][0] = (vec2(6.0, -2.0));
	block.var[2][0][0][1] = (vec2(1.0, 3.0));
	block.var[2][0][1][0] = (vec2(2.0, 1.0));
	block.var[2][0][1][1] = (vec2(7.0, -2.0));
	block.var[2][1][0][0] = (vec2(1.0, 3.0));
	block.var[2][1][0][1] = (vec2(-3.0, 7.0));
	block.var[2][1][1][0] = (vec2(1.0, 5.0));
	block.var[2][1][1][1] = (vec2(4.0, 1.0));
	block.var[2][2][0][0] = (vec2(-4.0, 7.0));
	block.var[2][2][0][1] = (vec2(-4.0, -8.0));
	block.var[2][2][1][0] = (vec2(1.0, 0.0));
	block.var[2][2][1][1] = (vec2(0.0, -9.0));
	block.var[2][3][0][0] = (vec2(2.0, -1.0));
	block.var[2][3][0][1] = (vec2(-3.0, 3.0));
	block.var[2][3][1][0] = (vec2(-3.0, -6.0));
	block.var[2][3][1][1] = (vec2(3.0, 2.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(-9.0, 2.0, -4.0, -7.0, -8.0, -5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(0.0, 5.0, 4.0, -5.0, 1.0, -3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(4.0, -5.0, -6.0, -5.0, 5.0, 1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(6.0, -6.0, -1.0, -2.0, -4.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(-2.0, -8.0, -5.0, -3.0, -6.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(2.0, -8.0, -6.0, -8.0, 7.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(-1.0, 6.0, -6.0, 3.0, -7.0, -1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(-8.0, -4.0, -7.0, -3.0, -8.0, -2.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(4.0, 5.0, 0.0, 5.0, -4.0, -9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(-9.0, 3.0, -9.0, 0.0, 2.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(0.0, 8.0, 9.0, -5.0, -4.0, -9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(9.0, -2.0, -5.0, 3.0, 7.0, -8.0, -6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	block.var[0][0][1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	block.var[0][1][0] = (mat2x4(4.0, -7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0));
	block.var[0][1][1] = (mat2x4(-2.0, 1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0));
	block.var[0][2][0] = (mat2x4(7.0, -5.0, -6.0, -8.0, -5.0, 3.0, -4.0, -5.0));
	block.var[0][2][1] = (mat2x4(-3.0, -5.0, 7.0, -7.0, 7.0, 8.0, 6.0, 7.0));
	block.var[0][3][0] = (mat2x4(-7.0, -3.0, -2.0, -2.0, -6.0, -7.0, 1.0, 6.0));
	block.var[0][3][1] = (mat2x4(0.0, 7.0, 8.0, 8.0, 2.0, -2.0, 6.0, -8.0));
	block.var[1][0][0] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
	block.var[1][0][1] = (mat2x4(-7.0, -4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0));
	block.var[1][1][0] = (mat2x4(-8.0, 7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0));
	block.var[1][1][1] = (mat2x4(2.0, 9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0));
	block.var[1][2][0] = (mat2x4(-8.0, 2.0, 0.0, 3.0, 7.0, 9.0, 3.0, 0.0));
	block.var[1][2][1] = (mat2x4(-9.0, 1.0, -3.0, 3.0, 2.0, 9.0, -5.0, 3.0));
	block.var[1][3][0] = (mat2x4(5.0, -2.0, 5.0, -9.0, -1.0, 4.0, 6.0, 1.0));
	block.var[1][3][1] = (mat2x4(6.0, -8.0, 1.0, -8.0, -1.0, 0.0, -1.0, 9.0));
	block.var[2][0][0] = (mat2x4(0.0, -4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0));
	block.var[2][0][1] = (mat2x4(3.0, -8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0));
	block.var[2][1][0] = (mat2x4(5.0, -9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0));
	block.var[2][1][1] = (mat2x4(-6.0, -9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0));
	block.var[2][2][0] = (mat2x4(4.0, 1.0, 6.0, 5.0, 6.0, -8.0, 9.0, -8.0));
	block.var[2][2][1] = (mat2x4(-6.0, -7.0, 0.0, -1.0, -3.0, -5.0, -4.0, 3.0));
	block.var[2][3][0] = (mat2x4(-7.0, 0.0, 8.0, 0.0, -6.0, 3.0, -9.0, -7.0));
	block.var[2][3][1] = (mat2x4(0.0, 2.0, -7.0, -2.0, -3.0, 9.0, 7.0, 7.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0].a), ivec3(4, 4, -4)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(-6.0, 9.0, -1.0, 9.0, 2.0, -7.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(1.0, 8.0, 3.0, -8.0, 5.0, 3.0, -2.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(5.0, 6.0, 7.0, 1.0, -6.0, -4.0, -1.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(4.0, 5.0, -6.0, -2.0, -3.0, 7.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(-3.0, 0.0, -6.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(-4, -4, 9)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(-2.0, -2.0, 3.0, -5.0, 2.0, 1.0, -3.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(0.0, 9.0, -7.0, -1.0, 5.0, 8.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(1.0, -6.0, -1.0, 8.0, 4.0, 6.0, -1.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(-4.0, 5.0, 0.0, -2.0, 7.0, 9.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(-7.0, -2.0, 6.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(-5, 2, 9)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(-6.0, -8.0, 5.0, 3.0, -3.0, 8.0, 4.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(-7.0, -4.0, 7.0, -4.0, -1.0, 9.0, -8.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(3.0, 7.0, -2.0, 9.0, 3.0, -3.0, 1.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(-5.0, -8.0, -6.0, -2.0, 6.0, 2.0, 7.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(1.0, -1.0, 2.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(-6, -3, -6)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(2.0, -8.0, 3.0, 0.0, 3.0, -9.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(9.0, 6.0, -4.0, -4.0, 5.0, 3.0, 1.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(-6.0, -9.0, -4.0, -1.0, 1.0, 1.0, -2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(-9.0, 0.0, -9.0, 1.0, -7.0, 7.0, 2.0, 2.0, -2.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(0.0, -2.0, 2.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(9, -4, 5)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(8.0, 5.0, 9.0, 6.0, 3.0, 4.0, 8.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(-3.0, -1.0, -6.0, 5.0, -6.0, 4.0, -4.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(9.0, 9.0, 2.0, -5.0, 2.0, -4.0, 9.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(-1.0, 2.0, -2.0, -8.0, 1.0, 8.0, -4.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(-7.0, -6.0, 8.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(-6, 0, -9)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(-3.0, 0.0, 0.0, 6.0, -9.0, -9.0, -2.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(-2.0, -2.0, -9.0, -4.0, -7.0, -2.0, 1.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(6.0, -3.0, -4.0, 7.0, 3.0, 0.0, 8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(-2.0, 7.0, 1.0, 4.0, -8.0, -4.0, -4.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(-1.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(-1, -2, 4)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(1.0, 9.0, 6.0, -1.0, 7.0, 5.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(-5.0, -7.0, 3.0, 2.0, -3.0, -6.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(5.0, -6.0, 9.0, -5.0, 4.0, -3.0, -6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(-7.0, -6.0, 4.0, 5.0, 9.0, -3.0, -5.0, 6.0, -2.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(0.0, 3.0, 0.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(0, -8, -4)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(6.0, 1.0, -5.0, 7.0, -7.0, 5.0, -5.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(5.0, -1.0, -7.0, 4.0, -1.0, -8.0, -1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(-7.0, 1.0, 5.0, 8.0, -1.0, 5.0, -2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(-5.0, -8.0, 2.0, -2.0, -5.0, 4.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(-3.0, -6.0, -6.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(0, 1, 9)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(4.0, -3.0, -7.0, -6.0, 6.0, 0.0, 8.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(2.0, -6.0, 3.0, 1.0, -8.0, 9.0, 7.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(8.0, 2.0, -5.0, -7.0, -8.0, -2.0, -7.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(5.0, 1.0, -1.0, 7.0, 7.0, 7.0, -3.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(-4.0, 4.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(2, -1, -4));
	block[0].s[0].b[0] = (mat3(-4.0, 3.0, -4.0, 6.0, 7.0, -1.0, -6.0, -4.0, -8.0));
	block[0].s[0].b[1] = (mat3(-2.0, 7.0, -4.0, -9.0, 1.0, 9.0, -5.0, -2.0, -9.0));
	block[0].s[0].b[2] = (mat3(-6.0, 4.0, 2.0, 2.0, -6.0, -5.0, 3.0, 9.0, 8.0));
	block[0].s[0].b[3] = (mat3(-6.0, -2.0, -5.0, 2.0, 8.0, 8.0, -8.0, -2.0, 7.0));
	block[0].s[0].c = (vec4(-9.0, -7.0, -3.0, -2.0));
	block[0].s[1].a = (ivec3(1, 2, -2));
	block[0].s[1].b[0] = (mat3(-9.0, 6.0, 6.0, -9.0, 1.0, 7.0, 7.0, -2.0, -3.0));
	block[0].s[1].b[1] = (mat3(-4.0, -7.0, -7.0, -1.0, 5.0, -4.0, -9.0, -7.0, -6.0));
	block[0].s[1].b[2] = (mat3(-3.0, 8.0, -5.0, 0.0, 5.0, 4.0, -2.0, -1.0, -4.0));
	block[0].s[1].b[3] = (mat3(7.0, -6.0, -7.0, 3.0, -4.0, -3.0, 4.0, 4.0, 6.0));
	block[0].s[1].c = (vec4(-7.0, -8.0, 0.0, 4.0));
	block[0].s[2].a = (ivec3(8, 7, 2));
	block[0].s[2].b[0] = (mat3(8.0, -5.0, -9.0, -7.0, -1.0, -4.0, 3.0, -1.0, -1.0));
	block[0].s[2].b[1] = (mat3(3.0, -7.0, -6.0, -3.0, 2.0, 3.0, 7.0, 8.0, -3.0));
	block[0].s[2].b[2] = (mat3(6.0, -7.0, 3.0, -3.0, 0.0, 8.0, -1.0, -6.0, -9.0));
	block[0].s[2].b[3] = (mat3(-9.0, -5.0, -7.0, -9.0, -6.0, 9.0, -8.0, 4.0, 8.0));
	block[0].s[2].c = (vec4(-5.0, -9.0, -2.0, -8.0));
	block[0].v = (vec4(-5.0, -9.0, -8.0, 1.0));
	block[1].s[0].a = (ivec3(-9, 5, -4));
	block[1].s[0].b[0] = (mat3(-2.0, -8.0, -8.0, -7.0, 8.0, -4.0, -4.0, 3.0, 3.0));
	block[1].s[0].b[1] = (mat3(6.0, -9.0, 2.0, 7.0, -8.0, 5.0, 7.0, -1.0, -5.0));
	block[1].s[0].b[2] = (mat3(-4.0, -5.0, 7.0, -2.0, 8.0, -7.0, 5.0, 6.0, -4.0));
	block[1].s[0].b[3] = (mat3(0.0, 5.0, -1.0, 0.0, -3.0, 0.0, 0.0, -4.0, 2.0));
	block[1].s[0].c = (vec4(-8.0, 5.0, 4.0, -9.0));
	block[1].s[1].a = (ivec3(1, -7, 5));
	block[1].s[1].b[0] = (mat3(-7.0, 3.0, 0.0, -1.0, 9.0, 2.0, 6.0, 1.0, -9.0));
	block[1].s[1].b[1] = (mat3(2.0, 8.0, -7.0, -3.0, -1.0, 4.0, -7.0, 8.0, -9.0));
	block[1].s[1].b[2] = (mat3(4.0, -2.0, 8.0, 2.0, 1.0, 4.0, -2.0, -9.0, 2.0));
	block[1].s[1].b[3] = (mat3(-9.0, 6.0, -4.0, 5.0, 4.0, 5.0, 5.0, -2.0, 9.0));
	block[1].s[1].c = (vec4(-7.0, -9.0, -2.0, 9.0));
	block[1].s[2].a = (ivec3(9, 0, 8));
	block[1].s[2].b[0] = (mat3(-3.0, 1.0, -3.0, -6.0, -9.0, -2.0, 2.0, 6.0, -9.0));
	block[1].s[2].b[1] = (mat3(-6.0, -5.0, 8.0, 3.0, 8.0, 5.0, -6.0, -3.0, -4.0));
	block[1].s[2].b[2] = (mat3(9.0, -6.0, -9.0, 1.0, -3.0, -2.0, 5.0, 4.0, 1.0));
	block[1].s[2].b[3] = (mat3(-7.0, 2.0, 8.0, 2.0, 1.0, 7.0, 2.0, -6.0, -1.0));
	block[1].s[2].c = (vec4(-6.0, -3.0, 6.0, 3.0));
	block[1].v = (vec4(-8.0, -5.0, -8.0, 0.0));
	block[2].s[0].a = (ivec3(3, -7, 0));
	block[2].s[0].b[0] = (mat3(-4.0, -6.0, 3.0, 9.0, 5.0, 4.0, 7.0, -1.0, -6.0));
	block[2].s[0].b[1] = (mat3(-6.0, -8.0, -9.0, -1.0, -9.0, -7.0, 6.0, -4.0, -8.0));
	block[2].s[0].b[2] = (mat3(-8.0, 3.0, -5.0, 5.0, 1.0, -1.0, 8.0, 3.0, -1.0));
	block[2].s[0].b[3] = (mat3(9.0, -7.0, -9.0, 5.0, 2.0, -4.0, -6.0, 3.0, -1.0));
	block[2].s[0].c = (vec4(7.0, 1.0, -1.0, 0.0));
	block[2].s[1].a = (ivec3(-2, 3, 2));
	block[2].s[1].b[0] = (mat3(8.0, 0.0, 9.0, -8.0, -9.0, 6.0, 7.0, 3.0, -4.0));
	block[2].s[1].b[1] = (mat3(-2.0, -6.0, -3.0, -1.0, -9.0, -4.0, -9.0, -5.0, 2.0));
	block[2].s[1].b[2] = (mat3(4.0, -4.0, 1.0, -2.0, -2.0, 4.0, 0.0, -6.0, 6.0));
	block[2].s[1].b[3] = (mat3(6.0, -8.0, -6.0, 9.0, 6.0, 5.0, -1.0, -7.0, -9.0));
	block[2].s[1].c = (vec4(7.0, 7.0, 1.0, -8.0));
	block[2].s[2].a = (ivec3(7, 0, 1));
	block[2].s[2].b[0] = (mat3(-6.0, -8.0, 2.0, 0.0, 6.0, -6.0, 6.0, 2.0, 1.0));
	block[2].s[2].b[1] = (mat3(-8.0, -9.0, 0.0, 0.0, -3.0, -5.0, -8.0, 2.0, -8.0));
	block[2].s[2].b[2] = (mat3(-3.0, 4.0, 3.0, 4.0, 5.0, -4.0, 2.0, -7.0, -9.0));
	block[2].s[2].b[3] = (mat3(-4.0, 7.0, -2.0, 7.0, 6.0, 2.0, -3.0, -2.0, 2.0));
	block[2].s[2].c = (vec4(6.0, -9.0, 5.0, 0.0));
	block[2].v = (vec4(-6.0, -3.0, -2.0, -3.0));
}
#version 450
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
	allOk = compare_uint((block.u), 0u) && allOk;
	allOk = compare_mat4x3(block.t[0].a, mat4x3(-4.0, 8.0, 8.0, 1.0, -5.0, -8.0, -8.0, -8.0, -2.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[0].a), uvec3(7u, 6u, 8u)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[1]), vec2(9.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[2]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[3]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(-9.0, -3.0, -3.0, 6.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[1].a), uvec3(2u, 6u, 4u)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[0]), vec2(8.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[1]), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[2]), vec2(-5.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[3]), vec2(3.0, 3.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(-4.0, -7.0, 2.0, 8.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[2].a), uvec3(1u, 9u, 6u)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[0]), vec2(-1.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[1]), vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[2]), vec2(8.0, 2.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[3]), vec2(-5.0, 0.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(4.0, -7.0, -5.0, -5.0)) && allOk;
	allOk = compare_int((block.t[0].c), -8) && allOk;
	allOk = compare_mat4x3(block.t[1].a, mat4x3(8.0, -2.0, -6.0, -6.0, -8.0, 6.0, 9.0, 9.0, 9.0, -7.0, -1.0, 5.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[0].a), uvec3(4u, 0u, 4u)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[0]), vec2(9.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[1]), vec2(5.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[2]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[3]), vec2(-6.0, 6.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(1.0, -4.0, 3.0, 8.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[1].a), uvec3(7u, 0u, 9u)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[0]), vec2(-8.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[1]), vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[2]), vec2(9.0, 1.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[3]), vec2(4.0, 9.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(-4.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[2].a), uvec3(8u, 0u, 3u)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[0]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[1]), vec2(-4.0, 1.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[2]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[3]), vec2(-9.0, -1.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(-2.0, 6.0, 1.0, 9.0)) && allOk;
	allOk = compare_int((block.t[1].c), 5) && allOk;
	allOk = compare_mat4x3(block.t[2].a, mat4x3(-4.0, 1.0, 5.0, -1.0, -5.0, -4.0, 9.0, 5.0, 0.0, 4.0, -5.0, -7.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[0].a), uvec3(1u, 2u, 5u)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[0]), vec2(-2.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[1]), vec2(9.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[2]), vec2(3.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[3]), vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[0].c), vec4(1.0, 6.0, 1.0, 4.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[1].a), uvec3(0u, 8u, 1u)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[0]), vec2(7.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[1]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[2]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[3]), vec2(8.0, -1.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[1].c), vec4(-5.0, -6.0, 5.0, 7.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[2].a), uvec3(5u, 1u, 5u)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[0]), vec2(7.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[1]), vec2(-4.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[2]), vec2(6.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[3]), vec2(-4.0, -7.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[2].c), vec4(0.0, -6.0, -4.0, 1.0)) && allOk;
	allOk = compare_int((block.t[2].c), 1) && allOk;
	allOk = compare_mat4x3(block.t[3].a, mat4x3(-7.0, -6.0, -8.0, -7.0, 2.0, 7.0, -1.0, -5.0, 4.0, 0.0, 6.0, 8.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[0].a), uvec3(4u, 9u, 3u)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[0]), vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[1]), vec2(-1.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[2]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[3]), vec2(9.0, -4.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[0].c), vec4(3.0, 9.0, -2.0, -3.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[1].a), uvec3(0u, 9u, 9u)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[0]), vec2(4.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[1]), vec2(4.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[2]), vec2(-2.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[3]), vec2(-8.0, 6.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[1].c), vec4(3.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[2].a), uvec3(8u, 4u, 1u)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[0]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[1]), vec2(7.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[2]), vec2(-7.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[3]), vec2(-5.0, -5.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[2].c), vec4(1.0, 4.0, 1.0, 4.0)) && allOk;
	allOk = compare_int((block.t[3].c), 6) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (uvec3(3u, 2u, 5u));
	block.s.b[0] = (vec2(6.0, -6.0));
	block.s.b[1] = (vec2(5.0, 6.0));
	block.s.b[2] = (vec2(-9.0, 8.0));
	block.s.b[3] = (vec2(1.0, 4.0));
	block.s.c = (vec4(-5.0, 1.0, 8.0, -2.0));
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
	allOk = compare_float(block[0].var[0][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -7.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 1.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[3][2], -4.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(7.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(3.0, 1.0, -7.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(9.0, 9.0, -4.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -4.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[3][2], 4.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(3.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(6.0, 6.0, 0.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(3.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(8.0, 5.0, 4.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[3][2], 8.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-6.0, -5.0, 4.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-4.0, 1.0, 2.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(-5.0, 9.0, -7.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(-2.0, -5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(7.0, 4.0, -4.0));
	block[0].var[1] = (vec3(-6.0, 3.0, -3.0));
	block[0].var[2] = (vec3(9.0, -2.0, 3.0));
	block[0].var[3] = (vec3(9.0, -9.0, 7.0));
	block[1].var[0] = (vec3(5.0, 1.0, -9.0));
	block[1].var[1] = (vec3(-1.0, -2.0, 6.0));
	block[1].var[2] = (vec3(-4.0, 6.0, 4.0));
	block[1].var[3] = (vec3(-8.0, 7.0, 3.0));
	block[2].var[0] = (vec3(-4.0, -9.0, 8.0));
	block[2].var[1] = (vec3(9.0, 2.0, 2.0));
	block[2].var[2] = (vec3(9.0, -7.0, 3.0));
	block[2].var[3] = (vec3(8.0, 2.0, 4.0));
}
#version 450
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
	i8vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(block[0].var), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block[1].var), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block[2].var), ivec2(0, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = i8vec2(ivec2(0, 8));
	block[1].var = i8vec2(ivec2(4294967292, 9));
	block[2].var = i8vec2(ivec2(4294967294, 4294967295));
}
#version 450
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
	highp vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((block[0].var), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((block[1].var), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block[2].var), vec2(-7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (vec2(3.0, 8.0));
	block[1].var = (vec2(7.0, -1.0));
	block[2].var = (vec2(-4.0, 8.0));
}
#version 450
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
	allOk = compare_mat3x4(block[0].var, mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	block[1].var = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	block[2].var = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
}
#version 450
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
	highp ivec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block[0].padding), 6) && allOk;
	allOk = compare_ivec2((block[0].var), ivec2(-1, 7)) && allOk;
	allOk = compare_int((block[1].padding), -5) && allOk;
	allOk = compare_ivec2((block[1].var), ivec2(-8, 8)) && allOk;
	allOk = compare_int((block[2].padding), -2) && allOk;
	allOk = compare_ivec2((block[2].var), ivec2(-6, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-6);
	block[0].var = (ivec2(8, 3));
	block[1].padding = (-1);
	block[1].var = (ivec2(-5, -2));
	block[2].padding = (0);
	block[2].var = (ivec2(-2, 5));
}
#version 450
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
	float16_t padding;
	f16vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block[0].padding), -8.0) && allOk;
	allOk = compare_f16vec4(vec4(block[0].var), vec4(-9.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_float16_t(float(block[1].padding), -8.0) && allOk;
	allOk = compare_f16vec4(vec4(block[1].var), vec4(-8.0, -3.0, -8.0, 6.0)) && allOk;
	allOk = compare_float16_t(float(block[2].padding), 1.0) && allOk;
	allOk = compare_f16vec4(vec4(block[2].var), vec4(-8.0, 4.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = float16_t(9.0);
	block[0].var = f16vec4(vec4(-6.0, 2.0, -8.0, -7.0));
	block[1].padding = float16_t(-4.0);
	block[1].var = f16vec4(vec4(2.0, -5.0, 9.0, 1.0));
	block[2].padding = float16_t(-6.0);
	block[2].var = f16vec4(vec4(3.0, -1.0, 4.0, -1.0));
}
#version 450
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
	mediump int a;
	lowp uint b;
	mediump int c;
	highp int d;
};
layout(std140, buffer_reference) buffer BlockC
{
	bool e[1];
	lowp uint f;
	bool g;
	highp uint h;
	mediump uint i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), -7) && allOk;
	allOk = compare_uint((blockB.b), 4u) && allOk;
	allOk = compare_int((blockB.c), 8) && allOk;
	allOk = compare_int((blockB.d), 2) && allOk;
	allOk = compare_bool((blockC.e[0]), false) && allOk;
	allOk = compare_uint((blockC.f), 8u) && allOk;
	allOk = compare_bool((blockC.g), true) && allOk;
	allOk = compare_uint((blockC.h), 8u) && allOk;
	allOk = compare_uint((blockC.i), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (0);
	blockB.d = (-2);
	blockC.e[0] = (true);
	blockC.f = (2u);
	blockC.g = (false);
	blockC.h = (3u);
	blockC.i = (2u);
}
#version 450
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
	mediump int a;
	lowp vec4 b;
	highp ivec2 c;
	mediump int d;
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp float e;
	mediump ivec4 f;
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp ivec4 g;
	highp ivec3 h;
};
layout(std430, buffer_reference) buffer BlockE
{
	lowp vec2 i;
	bvec4 j;
	lowp ivec2 k;
	lowp ivec2 l;
	mediump float m;
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), -8) && allOk;
	allOk = compare_vec4((blockB.b), vec4(-8.0, 0.0, -9.0, -1.0)) && allOk;
	allOk = compare_int((blockB.d), 0) && allOk;
	allOk = compare_float((blockC.e), -2.0) && allOk;
	allOk = compare_ivec3((blockD.h), ivec3(7, 5, -6)) && allOk;
	allOk = compare_vec2((blockE.i), vec2(5.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockE.l), ivec2(-7, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-2);
	blockB.b = (vec4(-9.0, -3.0, -1.0, -2.0));
	blockB.d = (-6);
	blockC.e = (-5.0);
	blockC.f = (ivec4(-9, 4, -6, 2));
	blockD.h = (ivec3(2, -9, -8));
	blockE.i = (vec2(3.0, 6.0));
	blockE.k = (ivec2(3, 7));
	blockE.m = (-6.0);
}
#version 450
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
	highp ivec3 e[1];
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
	allOk = compare_mat3x2(blockD.h, mat3x2(6.0, 6.0, -8.0, 6.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat4(blockD.i, mat4(1.0, 4.0, 6.0, -4.0, 0.0, 1.0, 2.0, -1.0, 9.0, -9.0, 9.0, 3.0, -9.0, 3.0, 5.0, 2.0)) && allOk;
	allOk = compare_uvec2((blockE.j), uvec2(6u, 0u)) && allOk;
	allOk = compare_mat4x2(blockE.k, mat4x2(-6.0, -5.0, 9.0, 1.0, 5.0, -7.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(blockE.n, mat3(-7.0, 1.0, 4.0, -2.0, 0.0, -1.0, -3.0, -7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (bvec2(false, true));
	blockC.c = (ivec4(-1, -9, 0, 0));
	blockC.f = (-1.0);
	blockD.h = (mat3x2(-1.0, -6.0, -3.0, 2.0, 0.0, -6.0));
	blockD.i = (mat4(-5.0, -6.0, 6.0, -7.0, 0.0, -9.0, -1.0, -1.0, 4.0, -2.0, -5.0, 5.0, 3.0, 0.0, 9.0, -5.0));
	blockE.j = (uvec2(7u, 9u));
	blockE.k = (mat4x2(-7.0, 0.0, -2.0, -2.0, 7.0, -9.0, -8.0, 3.0));
	blockE.l = (mat2x3(5.0, 5.0, -1.0, 7.0, -1.0, -8.0));
	blockE.m = (vec2(0.0, -8.0));
	blockE.n = (mat3(4.0, -3.0, -4.0, 9.0, -9.0, -8.0, 8.0, 1.0, 2.0));
}
#version 450
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
	bool b;
	mediump vec2 c;
	lowp vec3 d;
	bvec2 e;
};
layout(std430, buffer_reference) buffer BlockC
{
	bvec2 f;
	bool g;
	mediump mat3x4 h;
	mediump ivec2 i;
	highp vec2 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, true)) && allOk;
	allOk = compare_bool((blockB.b), true) && allOk;
	allOk = compare_vec2((blockB.c), vec2(-5.0, -8.0)) && allOk;
	allOk = compare_bvec2((blockB.e), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(false, false)) && allOk;
	allOk = compare_bool((blockC.g), true) && allOk;
	allOk = compare_mat3x4(blockC.h, mat3x4(5.0, 8.0, 5.0, -9.0, -8.0, 6.0, 2.0, 3.0, -7.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockC.i), ivec2(1, 1)) && allOk;
	allOk = compare_vec2((blockC.j[0]), vec2(3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b = (false);
	blockB.d = (vec3(5.0, 4.0, 8.0));
	blockC.f = (bvec2(false, true));
	blockC.g = (true);
	blockC.i = (ivec2(-4, 6));
}
#version 450
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
	mediump mat3 a;
	bvec4 b;
	bool c[];
};
layout(std140, buffer_reference) buffer BlockC
{
	highp mat3x4 d;
	bvec2 e;
	bool f;
	mediump uint g;
	lowp mat4x2 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(-4.0, 6.0, 6.0, -7.0, -9.0, 5.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_bvec4((blockB.b), bvec4(true, true, true, false)) && allOk;
	allOk = compare_mat3x4(blockC.d, mat3x4(-9.0, 0.0, -5.0, 0.0, 1.0, -8.0, 0.0, 3.0, -5.0, 5.0, -7.0, 1.0)) && allOk;
	allOk = compare_bool((blockC.f), false) && allOk;
	allOk = compare_uint((blockC.g), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec4(true, true, true, true));
	blockB.c[0] = (true);
	blockB.c[1] = (false);
	blockB.c[2] = (false);
	blockB.c[3] = (true);
	blockB.c[4] = (false);
	blockC.d = (mat3x4(5.0, -4.0, 9.0, 1.0, 4.0, -5.0, 8.0, -5.0, 4.0, -9.0, -1.0, -6.0));
	blockC.f = (false);
	blockC.h[0] = (mat4x2(9.0, -2.0, 3.0, 1.0, -6.0, -2.0, 5.0, -3.0));
	blockC.h[1] = (mat4x2(4.0, 7.0, -1.0, -2.0, 2.0, -2.0, 1.0, 0.0));
	blockC.h[2] = (mat4x2(2.0, -9.0, 0.0, 7.0, -3.0, -5.0, 8.0, 2.0));
	blockC.h[3] = (mat4x2(2.0, -2.0, -1.0, 4.0, -3.0, -1.0, -2.0, 2.0));
	blockC.h[4] = (mat4x2(-3.0, -1.0, -6.0, -4.0, 3.0, -8.0, 6.0, 7.0));
}
#version 450
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
layout(std140, row_major, buffer_reference) buffer BlockB
{
	highp mat2 a;
	sA b;
	mediump vec3 c;
	lowp ivec4 d;
	lowp mat4x2 e;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp mat2x3 f;
	highp ivec2 g;
	highp ivec4 h;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.c), vec3(1.0, -4.0, -4.0)) && allOk;
	allOk = compare_ivec4((blockB.d), ivec4(-3, 1, 5, 6)) && allOk;
	allOk = compare_mat2x3(blockC.f, mat2x3(-8.0, 6.0, 6.0, 5.0, 1.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockC.g), ivec2(6, -4)) && allOk;
	allOk = compare_ivec4((blockC.h), ivec4(0, 1, 2, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(9.0, 5.0, 7.0, -2.0));
	blockB.c = (vec3(0.0, 4.0, -4.0));
	blockB.d = (ivec4(-4, 1, -6, 2));
	blockC.f = (mat2x3(-6.0, -3.0, 2.0, 0.0, -6.0, -5.0));
	blockC.g = (ivec2(-6, 6));
}
#version 450
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
	highp int mB;
};
layout(std140, buffer_reference) buffer BlockB
{
	mediump vec3 a[2];
	highp ivec2 b;
	sA c;
	highp vec4 d[][5];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.c.mA, mat4(-5.0, -8.0, -6.0, 0.0, 7.0, -1.0, -1.0, 6.0, -5.0, 5.0, -6.0, 5.0, -7.0, -4.0, -7.0, -7.0)) && allOk;
	allOk = compare_int((blockB.c.mB), 0) && allOk;
	allOk = compare_vec4((blockB.d[0][0]), vec4(6.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB.d[0][1]), vec4(3.0, -2.0, 6.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB.d[0][2]), vec4(1.0, -6.0, 0.0, -1.0)) && allOk;
	allOk = compare_vec4((blockB.d[0][3]), vec4(7.0, 9.0, 1.0, -8.0)) && allOk;
	allOk = compare_vec4((blockB.d[0][4]), vec4(1.0, 6.0, -5.0, 3.0)) && allOk;
	allOk = compare_vec4((blockB.d[1][0]), vec4(6.0, 9.0, 9.0, -1.0)) && allOk;
	allOk = compare_vec4((blockB.d[1][1]), vec4(-5.0, -3.0, 3.0, 2.0)) && allOk;
	allOk = compare_vec4((blockB.d[1][2]), vec4(1.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_vec4((blockB.d[1][3]), vec4(-3.0, 4.0, 9.0, -4.0)) && allOk;
	allOk = compare_vec4((blockB.d[1][4]), vec4(9.0, 8.0, 9.0, 1.0)) && allOk;
	allOk = compare_vec4((blockB.d[2][0]), vec4(-6.0, -7.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec4((blockB.d[2][1]), vec4(-6.0, -2.0, 2.0, -1.0)) && allOk;
	allOk = compare_vec4((blockB.d[2][2]), vec4(1.0, -1.0, -8.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB.d[2][3]), vec4(2.0, -6.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec4((blockB.d[2][4]), vec4(5.0, 8.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec4((blockB.d[3][0]), vec4(-4.0, 3.0, -3.0, 5.0)) && allOk;
	allOk = compare_vec4((blockB.d[3][1]), vec4(-9.0, 6.0, 6.0, -7.0)) && allOk;
	allOk = compare_vec4((blockB.d[3][2]), vec4(-5.0, 3.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec4((blockB.d[3][3]), vec4(2.0, -8.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec4((blockB.d[3][4]), vec4(-6.0, 7.0, -7.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB.d[4][0]), vec4(-2.0, -2.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB.d[4][1]), vec4(3.0, -6.0, 8.0, -1.0)) && allOk;
	allOk = compare_vec4((blockB.d[4][2]), vec4(-3.0, -9.0, -4.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB.d[4][3]), vec4(-6.0, -7.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec4((blockB.d[4][4]), vec4(-5.0, 9.0, 0.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec2(4, 6));
	blockB.c.mA = (mat4(-5.0, -5.0, -7.0, 5.0, 2.0, -4.0, -8.0, 0.0, 9.0, 3.0, 1.0, -6.0, 4.0, -4.0, -6.0, 9.0));
	blockB.c.mB = (3);
	blockB.d[0][0] = (vec4(7.0, 7.0, -8.0, 5.0));
	blockB.d[0][1] = (vec4(-2.0, -7.0, -2.0, 5.0));
	blockB.d[0][2] = (vec4(0.0, -1.0, 5.0, 4.0));
	blockB.d[0][3] = (vec4(-9.0, -1.0, -1.0, 7.0));
	blockB.d[0][4] = (vec4(-1.0, -7.0, 7.0, 4.0));
	blockB.d[1][0] = (vec4(-3.0, 1.0, 6.0, 5.0));
	blockB.d[1][1] = (vec4(8.0, 5.0, -1.0, -1.0));
	blockB.d[1][2] = (vec4(-1.0, 2.0, -8.0, -1.0));
	blockB.d[1][3] = (vec4(-2.0, -8.0, 1.0, -7.0));
	blockB.d[1][4] = (vec4(-3.0, 3.0, -6.0, 1.0));
	blockB.d[2][0] = (vec4(-1.0, -1.0, 1.0, 2.0));
	blockB.d[2][1] = (vec4(-5.0, -4.0, 4.0, 7.0));
	blockB.d[2][2] = (vec4(-2.0, 8.0, -5.0, -9.0));
	blockB.d[2][3] = (vec4(2.0, 3.0, 1.0, -5.0));
	blockB.d[2][4] = (vec4(-2.0, 5.0, -1.0, 0.0));
	blockB.d[3][0] = (vec4(-2.0, 2.0, -7.0, -7.0));
	blockB.d[3][1] = (vec4(-7.0, 9.0, -6.0, -8.0));
	blockB.d[3][2] = (vec4(6.0, 5.0, 3.0, 2.0));
	blockB.d[3][3] = (vec4(4.0, -9.0, 9.0, 1.0));
	blockB.d[3][4] = (vec4(6.0, -8.0, -6.0, -8.0));
	blockB.d[4][0] = (vec4(-6.0, -8.0, 7.0, 3.0));
	blockB.d[4][1] = (vec4(-6.0, -5.0, 1.0, 6.0));
	blockB.d[4][2] = (vec4(6.0, 4.0, 8.0, 0.0));
	blockB.d[4][3] = (vec4(-8.0, 1.0, -1.0, -7.0));
	blockB.d[4][4] = (vec4(5.0, 9.0, 0.0, -2.0));
}
#version 450
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
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp ivec3 b;
	layout(offset = 16) bvec4 c[1];
	layout(offset = 32) highp ivec2 d;
	layout(offset = 48) lowp uvec3 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec2 f;
	layout(offset = 8) bvec2 g;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) highp ivec3 h[1];
	layout(offset = 16) highp vec3 i;
	layout(offset = 32) highp uvec2 j;
	layout(offset = 48) lowp vec4 k;
	layout(offset = 64) lowp ivec2 l;
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
	allOk = compare_ivec3((blockC.b), ivec3(7, 5, -6)) && allOk;
	allOk = compare_bvec4((blockC.c[0]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_ivec2((blockC.d), ivec2(9, -9)) && allOk;
	allOk = compare_uvec3((blockC.e), uvec3(0u, 7u, 4u)) && allOk;
	allOk = compare_bvec2((blockD.f), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD.g), bvec2(false, true)) && allOk;
	allOk = compare_ivec3((blockE.h[0]), ivec3(-5, -4, 3)) && allOk;
	allOk = compare_vec3((blockE.i), vec3(-5.0, -3.0, -1.0)) && allOk;
	allOk = compare_uvec2((blockE.j), uvec2(5u, 7u)) && allOk;
	allOk = compare_vec4((blockE.k), vec4(-3.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockE.l), ivec2(-4, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, true, false));
	blockC.c[0] = (bvec4(false, true, true, false));
	blockC.d = (ivec2(-2, 6));
	blockC.e = (uvec3(0u, 2u, 1u));
	blockD.f = (bvec2(false, false));
	blockE.h[0] = (ivec3(-9, -2, -7));
	blockE.j = (uvec2(2u, 3u));
}
#version 450
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
	layout(offset = 0) highp vec4 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp vec2 b;
	layout(offset = 8) lowp float c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-9.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_float((blockC.c), 5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (vec2(3.0, 5.0));
	blockC.c = (-9.0);
}
#version 450
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
	lowp int a;
	float16_t b;
	float16_t c[1];
	highp float d;
};
layout(std140, buffer_reference) buffer BlockC
{
	highp int e;
	highp uint f;
	highp uint g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), -7) && allOk;
	allOk = compare_float16_t(float(blockB.b), 8.0) && allOk;
	allOk = compare_float16_t(float(blockB.c[0]), 8.0) && allOk;
	allOk = compare_float((blockB.d), 2.0) && allOk;
	allOk = compare_int((blockC.e), 4) && allOk;
	allOk = compare_uint((blockC.f), 8u) && allOk;
	allOk = compare_uint((blockC.g), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (0);
	blockB.d = (-2.0);
	blockC.e = (2);
	blockC.f = (3u);
	blockC.g = (2u);
}
#version 450
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
	f16vec4 a;
	highp uvec2 b;
	lowp float c;
};
layout(std430, buffer_reference) buffer BlockC
{
	bvec4 d;
	lowp uvec4 e;
	highp vec3 f[1];
	u16vec2 g[];
};
layout(std140, buffer_reference) buffer BlockD
{
	highp ivec2 h;
	lowp float i;
	highp mat3x2 j;
	u16vec3 k;
	i16vec2 l[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	lowp uint m;
	bvec4 n[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.c), -3.0) && allOk;
	allOk = compare_bvec4((blockC.d), bvec4(true, false, true, false)) && allOk;
	allOk = compare_uvec4((blockC.e), uvec4(3u, 4u, 7u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[0]), uvec2(9u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[1]), uvec2(4u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[2]), uvec2(2u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[3]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[4]), uvec2(3u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[5]), uvec2(5u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[6]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[7]), uvec2(9u, 8u)) && allOk;
	allOk = compare_ivec2((blockD.h), ivec2(-7, -2)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.k), uvec3(0u, 8u, 7u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.l[0]), ivec2(-3, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.l[1]), ivec2(-9, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.l[2]), ivec2(9, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.l[3]), ivec2(-4, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.l[4]), ivec2(6, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.l[5]), ivec2(9, 7)) && allOk;
	allOk = compare_bvec4((blockE.n[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockE.n[1]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockE.n[2]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockE.n[3]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockE.n[4]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((blockE.n[5]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockE.n[6]), bvec4(false, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec2(6u, 5u));
	blockC.e = (uvec4(9u, 5u, 2u, 7u));
	blockC.f[0] = (vec3(2.0, -4.0, -6.0));
	blockC.g[0] = u16vec2(uvec2(4u, 6u));
	blockC.g[1] = u16vec2(uvec2(8u, 0u));
	blockC.g[2] = u16vec2(uvec2(2u, 3u));
	blockC.g[3] = u16vec2(uvec2(3u, 8u));
	blockC.g[4] = u16vec2(uvec2(6u, 3u));
	blockC.g[5] = u16vec2(uvec2(3u, 4u));
	blockC.g[6] = u16vec2(uvec2(4u, 8u));
	blockC.g[7] = u16vec2(uvec2(4u, 4u));
	blockD.h = (ivec2(-3, -8));
	blockD.j = (mat3x2(-8.0, -6.0, -5.0, 0.0, 0.0, 2.0));
	blockD.k = u16vec3(uvec3(7u, 2u, 5u));
	blockE.m = (0u);
	blockE.n[0] = (bvec4(true, true, false, false));
	blockE.n[1] = (bvec4(true, true, false, false));
	blockE.n[2] = (bvec4(false, false, false, false));
	blockE.n[3] = (bvec4(false, true, true, true));
	blockE.n[4] = (bvec4(false, true, false, false));
	blockE.n[5] = (bvec4(false, false, false, false));
	blockE.n[6] = (bvec4(false, true, true, true));
}
#version 450
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
	i16vec3 a;
	highp uvec2 b;
	highp mat4x2 c;
	f16vec3 d[];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump int e;
	lowp uvec4 f;
	bvec3 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockC.f), uvec4(1u, 7u, 2u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec3(ivec3(-5, 4, -9));
	blockB.d[0] = f16vec3(vec3(-4.0, -8.0, 0.0));
	blockB.d[1] = f16vec3(vec3(9.0, 3.0, 1.0));
	blockB.d[2] = f16vec3(vec3(-6.0, 4.0, -4.0));
	blockB.d[3] = f16vec3(vec3(-6.0, 9.0, 3.0));
	blockB.d[4] = f16vec3(vec3(7.0, 7.0, -8.0));
	blockB.d[5] = f16vec3(vec3(5.0, -2.0, -7.0));
	blockB.d[6] = f16vec3(vec3(-2.0, 5.0, 0.0));
	blockB.d[7] = f16vec3(vec3(-1.0, 5.0, 4.0));
	blockC.f = (uvec4(1u, 6u, 6u, 4u));
	blockC.g[0] = (bvec3(true, true, true));
	blockC.g[1] = (bvec3(false, false, true));
	blockC.g[2] = (bvec3(false, false, false));
	blockC.g[3] = (bvec3(true, true, true));
}
#version 450
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
	f16vec4 a[1];
	lowp vec2 b;
	bvec2 c;
	f16vec2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[0].b), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB[0].d[0]), vec2(-1.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].d[0] = f16vec2(vec2(-1.0, -9.0));
}
#version 450
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
	lowp uint a[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockC
{
	mediump float b[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	f16vec4 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockC.b[0]), 2.0) && allOk;
	allOk = compare_float((blockC.b[1]), 0.0) && allOk;
	allOk = compare_float((blockC.b[2]), 5.0) && allOk;
	allOk = compare_float((blockC.b[3]), 5.0) && allOk;
	allOk = compare_float((blockC.b[4]), 5.0) && allOk;
	allOk = compare_float((blockC.b[5]), -5.0) && allOk;
	allOk = compare_float((blockC.b[6]), -2.0) && allOk;
	allOk = compare_float((blockC.b[7]), -9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (8u);
	blockB.a[1] = (3u);
	blockD.c[0] = f16vec4(vec4(6.0, 2.0, 9.0, 8.0));
	blockD.c[1] = f16vec4(vec4(5.0, -5.0, 8.0, -1.0));
	blockD.c[2] = f16vec4(vec4(7.0, -9.0, -3.0, -1.0));
}
#version 450
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
	u16vec3 a;
	mediump uvec3 b;
	highp vec4 c;
	mediump mat4x2 d;
	lowp ivec2 e;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp ivec2 f;
	highp mat4x2 g;
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	bool h;
	u16vec3 i;
	highp mat3 j;
	i16vec2 k;
	u16vec3 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB.a), uvec3(5u, 5u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.b), uvec3(5u, 4u, 2u)) && allOk;
	allOk = compare_vec4((blockB.c), vec4(7.0, -1.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockB.d, mat4x2(8.0, -7.0, -2.0, -2.0, -2.0, -1.0, 4.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockB.e), ivec2(-1, -6)) && allOk;
	allOk = compare_mat4x2(blockC[0].g, mat4x2(4.0, 2.0, 1.0, 8.0, -6.0, -2.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].g, mat4x2(2.0, 7.0, -2.0, -7.0, 3.0, 9.0, -6.0, -2.0)) && allOk;
	allOk = compare_bool((blockD[0].h), true) && allOk;
	allOk = compare_i16vec2(ivec2(blockD[0].k), ivec2(6, 1)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD[0].l), uvec3(6u, 1u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec3(uvec3(5u, 5u, 6u));
	blockB.c = (vec4(-6.0, 6.0, -6.0, 3.0));
	blockB.d = (mat4x2(5.0, 3.0, -8.0, -6.0, -7.0, -9.0, -8.0, 9.0));
	blockC[0].f = (ivec2(8, -1));
	blockC[0].g = (mat4x2(-4.0, 1.0, 0.0, 2.0, -4.0, 9.0, 2.0, -3.0));
	blockC[1].f = (ivec2(-2, -6));
	blockC[1].g = (mat4x2(-2.0, 0.0, 5.0, 0.0, -3.0, 2.0, 2.0, -8.0));
	blockD[0].j = (mat3(8.0, -4.0, 7.0, -9.0, 1.0, -4.0, 2.0, 8.0, -3.0));
	blockD[0].k = i16vec2(ivec2(-2, 7));
	blockD[0].l = u16vec3(uvec3(1u, 6u, 6u));
}
#version 450
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
	highp mat3 mB;
	highp uvec3 mC;
	bvec3 mD;
};
layout(std140, buffer_reference) buffer BlockB
{
	bvec4 a;
	sA b[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp mat4 c;
	lowp float d;
	u16vec4 e;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	bvec2 f;
	i16vec2 g[6];
	lowp mat2x3 h[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	lowp ivec2 i;
	i16vec2 j;
	uint16_t k;
	mediump mat4 l[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockC.c, mat4(-4.0, -9.0, 1.0, 8.0, 4.0, 7.0, 3.0, -4.0, -1.0, -2.0, 4.0, 6.0, -6.0, 3.0, -1.0, 0.0)) && allOk;
	allOk = compare_float((blockC.d), -4.0) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.e), uvec4(3u, 5u, 6u, 9u)) && allOk;
	allOk = compare_bvec2((blockD.f), bvec2(true, true)) && allOk;
	allOk = compare_ivec2((blockE[0].i), ivec2(-6, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(blockE[0].j), ivec2(-9, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0].mA = (mat2x3(-4.0, 0.0, -8.0, 6.0, -7.0, 7.0));
	blockB.b[0].mB = (mat3(-1.0, -2.0, 0.0, -6.0, -7.0, 1.0, -7.0, -3.0, 3.0));
	blockB.b[0].mC = (uvec3(5u, 6u, 1u));
	blockB.b[0].mD = (bvec3(true, true, true));
	blockB.b[1].mA = (mat2x3(4.0, 3.0, -8.0, -8.0, -7.0, 7.0));
	blockB.b[1].mB = (mat3(-7.0, -2.0, 8.0, 5.0, 8.0, 9.0, 9.0, 3.0, 4.0));
	blockB.b[1].mC = (uvec3(8u, 7u, 9u));
	blockB.b[1].mD = (bvec3(false, true, true));
	blockB.b[2].mA = (mat2x3(-9.0, -8.0, 7.0, 4.0, 4.0, 3.0));
	blockB.b[2].mB = (mat3(4.0, 1.0, -9.0, 5.0, -4.0, -4.0, 5.0, 8.0, 2.0));
	blockB.b[2].mC = (uvec3(1u, 8u, 9u));
	blockB.b[2].mD = (bvec3(true, false, true));
	blockB.b[3].mA = (mat2x3(-9.0, -9.0, -3.0, 8.0, 7.0, 9.0));
	blockB.b[3].mB = (mat3(9.0, -2.0, 2.0, 7.0, -6.0, -4.0, -9.0, 5.0, -1.0));
	blockB.b[3].mC = (uvec3(0u, 9u, 8u));
	blockB.b[3].mD = (bvec3(false, false, true));
	blockB.b[4].mA = (mat2x3(-7.0, -7.0, 4.0, -1.0, 6.0, 3.0));
	blockB.b[4].mB = (mat3(8.0, -1.0, -9.0, 2.0, 3.0, 1.0, 9.0, -6.0, 1.0));
	blockB.b[4].mC = (uvec3(1u, 7u, 8u));
	blockB.b[4].mD = (bvec3(true, false, true));
	blockB.b[5].mA = (mat2x3(-8.0, 6.0, -7.0, 4.0, -2.0, 1.0));
	blockB.b[5].mB = (mat3(3.0, 1.0, 6.0, -1.0, 4.0, 1.0, 3.0, 0.0, -9.0));
	blockB.b[5].mC = (uvec3(2u, 3u, 7u));
	blockB.b[5].mD = (bvec3(false, false, true));
	blockC.c = (mat4(-1.0, -6.0, -3.0, 6.0, -8.0, 9.0, -6.0, 6.0, 9.0, -3.0, -5.0, 3.0, -4.0, 7.0, -8.0, 1.0));
	blockC.d = (-9.0);
	blockC.e = u16vec4(uvec4(8u, 3u, 2u, 1u));
	blockD.g[0] = i16vec2(ivec2(-7, 0));
	blockD.g[1] = i16vec2(ivec2(8, -7));
	blockD.g[2] = i16vec2(ivec2(0, -9));
	blockD.g[3] = i16vec2(ivec2(4, 1));
	blockD.g[4] = i16vec2(ivec2(3, 8));
	blockD.g[5] = i16vec2(ivec2(7, 5));
	blockE[0].i = (ivec2(-6, -8));
	blockE[0].k = uint16_t(2u);
	blockE[0].l[0] = (mat4(-7.0, -3.0, -1.0, -2.0, -6.0, 2.0, 7.0, -9.0, 8.0, 6.0, 7.0, 2.0, -7.0, -8.0, 6.0, 9.0));
}
#version 450
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
	layout(offset = 6) u16vec2 b;
	layout(offset = 12) mediump uint c;
	layout(offset = 16) f16vec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockB.a), ivec3(-1, -5, -9)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.b), uvec2(4u, 6u)) && allOk;
	allOk = compare_uint((blockB.c), 0u) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d), vec4(8.0, -9.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec3(ivec3(0, -7, -2));
	blockB.b = u16vec2(uvec2(3u, 5u));
	blockB.c = (6u);
	blockB.d = f16vec4(vec4(-5.0, 5.0, -3.0, 4.0));
}
#version 450
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
	mediump float a;
	lowp mat4x3 b;
	highp mat2 c[3];
	mediump uvec2 d;
	lowp ivec2 e[][7][1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -8.0) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(-8.0, 0.0, -9.0, -1.0, 4.0, -4.0, 0.0, -2.0, -5.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2(blockB.c[0], mat2(-6.0, 9.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2(blockB.c[1], mat2(7.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2(blockB.c[2], mat2(-9.0, -2.0, 4.0, -1.0)) && allOk;
	allOk = compare_uvec2((blockB.d), uvec2(6u, 4u)) && allOk;
	allOk = compare_ivec2((blockB.e[0][0][0]), ivec2(2, -6)) && allOk;
	allOk = compare_ivec2((blockB.e[0][1][0]), ivec2(-1, 5)) && allOk;
	allOk = compare_ivec2((blockB.e[0][2][0]), ivec2(-9, -2)) && allOk;
	allOk = compare_ivec2((blockB.e[0][3][0]), ivec2(7, 4)) && allOk;
	allOk = compare_ivec2((blockB.e[0][4][0]), ivec2(-4, -8)) && allOk;
	allOk = compare_ivec2((blockB.e[0][5][0]), ivec2(-9, 2)) && allOk;
	allOk = compare_ivec2((blockB.e[0][6][0]), ivec2(3, 7)) && allOk;
	allOk = compare_ivec2((blockB.e[1][0][0]), ivec2(8, -7)) && allOk;
	allOk = compare_ivec2((blockB.e[1][1][0]), ivec2(9, -1)) && allOk;
	allOk = compare_ivec2((blockB.e[1][2][0]), ivec2(5, -8)) && allOk;
	allOk = compare_ivec2((blockB.e[1][3][0]), ivec2(-1, -2)) && allOk;
	allOk = compare_ivec2((blockB.e[1][4][0]), ivec2(-4, 7)) && allOk;
	allOk = compare_ivec2((blockB.e[1][5][0]), ivec2(2, 5)) && allOk;
	allOk = compare_ivec2((blockB.e[1][6][0]), ivec2(-8, 7)) && allOk;
	allOk = compare_ivec2((blockB.e[2][0][0]), ivec2(-4, -7)) && allOk;
	allOk = compare_ivec2((blockB.e[2][1][0]), ivec2(5, -9)) && allOk;
	allOk = compare_ivec2((blockB.e[2][2][0]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((blockB.e[2][3][0]), ivec2(2, 2)) && allOk;
	allOk = compare_ivec2((blockB.e[2][4][0]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((blockB.e[2][5][0]), ivec2(1, -3)) && allOk;
	allOk = compare_ivec2((blockB.e[2][6][0]), ivec2(-1, 8)) && allOk;
	allOk = compare_ivec2((blockB.e[3][0][0]), ivec2(-2, 2)) && allOk;
	allOk = compare_ivec2((blockB.e[3][1][0]), ivec2(2, 3)) && allOk;
	allOk = compare_ivec2((blockB.e[3][2][0]), ivec2(-1, 5)) && allOk;
	allOk = compare_ivec2((blockB.e[3][3][0]), ivec2(9, -4)) && allOk;
	allOk = compare_ivec2((blockB.e[3][4][0]), ivec2(6, -2)) && allOk;
	allOk = compare_ivec2((blockB.e[3][5][0]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((blockB.e[3][6][0]), ivec2(-1, 5)) && allOk;
	allOk = compare_ivec2((blockB.e[4][0][0]), ivec2(7, 8)) && allOk;
	allOk = compare_ivec2((blockB.e[4][1][0]), ivec2(2, -3)) && allOk;
	allOk = compare_ivec2((blockB.e[4][2][0]), ivec2(8, -5)) && allOk;
	allOk = compare_ivec2((blockB.e[4][3][0]), ivec2(8, -2)) && allOk;
	allOk = compare_ivec2((blockB.e[4][4][0]), ivec2(-1, -2)) && allOk;
	allOk = compare_ivec2((blockB.e[4][5][0]), ivec2(-9, -3)) && allOk;
	allOk = compare_ivec2((blockB.e[4][6][0]), ivec2(-9, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-2.0);
	blockB.c[0] = (mat2(6.0, 4.0, 6.0, -5.0));
	blockB.c[1] = (mat2(2.0, -9.0, -8.0, 3.0));
	blockB.c[2] = (mat2(6.0, -6.0, 5.0, 6.0));
	blockB.d = (uvec2(9u, 7u));
	blockB.e[0][0][0] = (ivec2(7, -8));
	blockB.e[0][1][0] = (ivec2(9, 7));
	blockB.e[0][2][0] = (ivec2(2, -6));
	blockB.e[0][3][0] = (ivec2(8, -3));
	blockB.e[0][4][0] = (ivec2(2, -8));
	blockB.e[0][5][0] = (ivec2(-7, 7));
	blockB.e[0][6][0] = (ivec2(-7, -4));
	blockB.e[1][0][0] = (ivec2(-2, -6));
	blockB.e[1][1][0] = (ivec2(-9, -8));
	blockB.e[1][2][0] = (ivec2(0, -6));
	blockB.e[1][3][0] = (ivec2(-1, 2));
	blockB.e[1][4][0] = (ivec2(9, -3));
	blockB.e[1][5][0] = (ivec2(7, 3));
	blockB.e[1][6][0] = (ivec2(-1, -2));
	blockB.e[2][0][0] = (ivec2(-3, 0));
	blockB.e[2][1][0] = (ivec2(-4, 0));
	blockB.e[2][2][0] = (ivec2(-6, -4));
	blockB.e[2][3][0] = (ivec2(-2, 2));
	blockB.e[2][4][0] = (ivec2(8, -7));
	blockB.e[2][5][0] = (ivec2(-6, -4));
	blockB.e[2][6][0] = (ivec2(-1, -8));
	blockB.e[3][0][0] = (ivec2(7, -1));
	blockB.e[3][1][0] = (ivec2(-3, 9));
	blockB.e[3][2][0] = (ivec2(-9, 4));
	blockB.e[3][3][0] = (ivec2(-1, 7));
	blockB.e[3][4][0] = (ivec2(-9, -5));
	blockB.e[3][5][0] = (ivec2(5, -1));
	blockB.e[3][6][0] = (ivec2(5, -6));
	blockB.e[4][0][0] = (ivec2(-5, -8));
	blockB.e[4][1][0] = (ivec2(9, -2));
	blockB.e[4][2][0] = (ivec2(-5, 8));
	blockB.e[4][3][0] = (ivec2(-1, 3));
	blockB.e[4][4][0] = (ivec2(9, 0));
	blockB.e[4][5][0] = (ivec2(-8, -9));
	blockB.e[4][6][0] = (ivec2(7, -5));
}
#version 450
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
	mediump uvec3 a;
	bvec2 b[7];
	mediump int c;
	highp mat3x2 d;
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	lowp uvec3 e;
	int16_t f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a), uvec3(9u, 6u, 1u)) && allOk;
	allOk = compare_int((blockB[0].c), 2) && allOk;
	allOk = compare_uvec3((blockB[1].a), uvec3(3u, 9u, 2u)) && allOk;
	allOk = compare_int((blockB[1].c), 1) && allOk;
	allOk = compare_uvec3((blockB[2].a), uvec3(8u, 9u, 5u)) && allOk;
	allOk = compare_int((blockB[2].c), 5) && allOk;
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
	blockC.e = (uvec3(2u, 6u, 6u));
}
#version 450
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
	lowp uint a;
	highp mat2x3 b;
	highp mat3x4 c[1];
	bvec3 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB[nonuniformEXT(0)].b, mat2x3(-8.0, 7.0, 0.0, -4.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].c[0], mat3x4(-8.0, 5.0, 1.0, -7.0, -6.0, 6.0, 8.0, 7.0, 4.0, -6.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(1)].b, mat2x3(2.0, -7.0, 9.0, 3.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].c[0], mat3x4(1.0, 6.0, 6.0, 7.0, 1.0, -3.0, -4.0, 5.0, 3.0, 8.0, 6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (mat2x3(-2.0, -6.0, 0.0, -1.0, 6.0, 9.0));
	blockB[nonuniformEXT(0)].c[0] = (mat3x4(5.0, 6.0, 5.0, 4.0, 4.0, 7.0, -2.0, 7.0, 8.0, -5.0, 7.0, 0.0));
	blockB[nonuniformEXT(1)].b = (mat2x3(-7.0, -2.0, 8.0, -6.0, -4.0, -6.0));
	blockB[nonuniformEXT(1)].c[0] = (mat3x4(-4.0, -6.0, -7.0, -7.0, 6.0, 8.0, -1.0, 2.0, -3.0, -6.0, 4.0, -1.0));
}
#version 450
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
	highp vec4 a;
	f16vec3 b;
	highp mat4x3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(0)].b), vec3(-6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(0)].c, mat4x3(-1.0, -6.0, 3.0, -7.0, 9.0, 3.0, -3.0, 3.0, 1.0, 7.0, -5.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(1)].b), vec3(9.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(1)].c, mat4x3(-8.0, -3.0, 3.0, 2.0, -6.0, 9.0, 2.0, -6.0, -9.0, 8.0, -6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec4(6.0, -5.0, -1.0, -3.0));
	blockB[nonuniformEXT(0)].b = f16vec3(vec3(-1.0, -2.0, 7.0));
	blockB[nonuniformEXT(0)].c = (mat4x3(-5.0, -5.0, -4.0, 1.0, -7.0, 1.0, 1.0, -9.0, -7.0, -8.0, 6.0, 5.0));
	blockB[nonuniformEXT(1)].a = (vec4(0.0, 1.0, -1.0, 6.0));
	blockB[nonuniformEXT(1)].b = f16vec3(vec3(3.0, 6.0, -6.0));
	blockB[nonuniformEXT(1)].c = (mat4x3(2.0, 6.0, 9.0, -9.0, 4.0, 4.0, -4.0, -4.0, 0.0, 3.0, -8.0, 1.0));
}
#version 450
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
	mediump mat2 a;
	bvec2 b;
	uint8_t c;
	lowp ivec4 d;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	uint8_t e;
	lowp ivec4 f;
	lowp uint g;
	uint8_t h;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	highp mat2x3 i;
	lowp ivec3 j;
	u8vec4 k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(0.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(false, true)) && allOk;
	allOk = compare_uint8_t(uint(blockB.c), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockC.e), 9u) && allOk;
	allOk = compare_ivec4((blockC.f), ivec4(3, 3, 3, 5)) && allOk;
	allOk = compare_uint8_t(uint(blockC.h), 1u) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.k), uvec4(2u, 6u, 5u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = uint8_t(0u);
	blockB.d = (ivec4(2, -4, -8, -4));
	blockC.e = uint8_t(8u);
	blockC.f = (ivec4(6, -3, -7, -4));
	blockC.g = (3u);
	blockD.i = (mat2x3(-8.0, 9.0, 1.0, -5.0, -1.0, 7.0));
	blockD.j = (ivec3(9, -8, -6));
	blockD.k = u8vec4(uvec4(2u, 0u, 1u, 4u));
}
#version 450
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
	u8vec4 a;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp ivec2 b;
	highp uint c[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	i8vec4 d[1];
	mediump uvec3 e;
	bvec2 f;
	u8vec3 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.a), uvec4(6u, 7u, 4u, 4u)) && allOk;
	allOk = compare_ivec2((blockC.b), ivec2(-1, -2)) && allOk;
	allOk = compare_uint((blockC.c[0]), 7u) && allOk;
	allOk = compare_uvec3((blockD.e), uvec3(3u, 2u, 8u)) && allOk;
	allOk = compare_bvec2((blockD.f), bvec2(false, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.g[0]), uvec3(9u, 4u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec4(uvec4(6u, 4u, 7u, 8u));
	blockC.c[0] = (9u);
	blockD.e = (uvec3(3u, 9u, 6u));
	blockD.g[0] = u8vec3(uvec3(1u, 7u, 9u));
}
#version 450
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
	lowp mat4 a[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	bvec2 b;
	mediump uvec2 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockC.b), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4(-7.0, -4.0, -4.0, 0.0, 3.0, -1.0, 3.0, -7.0, -9.0, 9.0, -7.0, -9.0, -7.0, -4.0, -4.0, -8.0));
	blockC.b = (bvec2(false, true));
	blockC.c = (uvec2(1u, 8u));
}
#version 450
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
	i8vec4 a[];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockC
{
	mediump mat2x3 b[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	u8vec2 c;
	highp vec4 d;
	highp mat3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.a[0]), ivec4(4294967289, 8, 8, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.a[1]), ivec4(4, 0, 4294967294, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.a[2]), ivec4(4294967295, 5, 4294967287, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.a[3]), ivec4(4294967294, 4294967287, 2, 0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.a[4]), ivec4(4294967287, 0, 4294967287, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.a[5]), ivec4(0, 4294967294, 4294967291, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.a[6]), ivec4(4, 4294967289, 4294967294, 9)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[0].c), uvec2(4u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = i8vec4(ivec4(0, 4294967289, 3, 4294967294));
	blockB.a[1] = i8vec4(ivec4(2, 4294967289, 4, 6));
	blockB.a[2] = i8vec4(ivec4(4294967288, 8, 4294967293, 3));
	blockB.a[3] = i8vec4(ivec4(4294967293, 4294967295, 6, 9));
	blockB.a[4] = i8vec4(ivec4(5, 4294967290, 4294967295, 4294967294));
	blockB.a[5] = i8vec4(ivec4(2, 4294967293, 4294967287, 4294967291));
	blockB.a[6] = i8vec4(ivec4(3, 5, 4294967291, 4294967294));
	blockD[0].d = (vec4(2.0, -7.0, -6.0, -2.0));
}
#version 450
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
	highp uvec3 b;
	lowp ivec4 c;
	i8vec4 d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	mediump vec3 e;
	bvec2 f;
	highp vec2 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(1, -8, 7, -4)) && allOk;
	allOk = compare_uvec3((blockB.b), uvec3(2u, 7u, 0u)) && allOk;
	allOk = compare_vec3((blockC.e), vec3(-9.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-7, 9, 6, -4));
	blockB.b = (uvec3(3u, 8u, 8u));
	blockB.c = (ivec4(-5, 1, -9, -8));
	blockB.d[0] = i8vec4(ivec4(5, 4294967295, 4294967287, 4294967292));
	blockB.d[1] = i8vec4(ivec4(4, 4294967290, 9, 4294967295));
	blockB.d[2] = i8vec4(ivec4(4294967294, 4294967293, 5, 6));
	blockB.d[3] = i8vec4(ivec4(0, 6, 1, 8));
	blockB.d[4] = i8vec4(ivec4(4294967292, 4294967292, 4294967292, 4294967294));
	blockC.e = (vec3(-2.0, -5.0, -9.0));
	blockC.f = (bvec2(false, false));
	blockC.g[0] = (vec2(3.0, 7.0));
	blockC.g[1] = (vec2(-6.0, -1.0));
	blockC.g[2] = (vec2(-3.0, -2.0));
	blockC.g[3] = (vec2(9.0, -6.0));
	blockC.g[4] = (vec2(1.0, 6.0));
	blockC.g[5] = (vec2(7.0, -7.0));
	blockC.g[6] = (vec2(2.0, -1.0));
	blockC.g[7] = (vec2(9.0, 0.0));
}
#version 450
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
	highp mat3x2 mA;
};
struct sB
{
	mediump mat3 mA;
	i8vec4 mB;
	i8vec4 mC;
};
struct sC
{
	sA mA[3];
	sB mB;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	uint8_t a;
	lowp vec3 b;
	mediump mat4x3 c[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	sC d;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.a), 0u) && allOk;
	allOk = compare_vec3((blockB.b), vec3(-4.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockC.d.mA[0].mA, mat3x2(8.0, -1.0, 8.0, 0.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockC.d.mA[1].mA, mat3x2(8.0, -1.0, -8.0, -3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockC.d.mA[2].mA, mat3x2(4.0, 0.0, -7.0, -8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3(blockC.d.mB.mA, mat3(4.0, 4.0, 7.0, -3.0, 3.0, -8.0, -4.0, 4.0, 2.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d.mB.mB), ivec4(8, 1, 2, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d.mB.mC), ivec4(0, 4294967293, 4294967290, 4294967288)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec3(-7.0, -6.0, -9.0));
	blockB.c[0] = (mat4x3(-1.0, 3.0, -9.0, 7.0, 7.0, 7.0, -9.0, -9.0, 4.0, -3.0, -7.0, -6.0));
	blockB.c[1] = (mat4x3(6.0, -3.0, 6.0, 0.0, -4.0, 2.0, -1.0, -7.0, 5.0, -9.0, -3.0, -2.0));
	blockB.c[2] = (mat4x3(-5.0, -7.0, -6.0, -7.0, -6.0, -1.0, 1.0, 7.0, 9.0, 0.0, 4.0, -5.0));
	blockB.c[3] = (mat4x3(-8.0, 8.0, -4.0, -9.0, 2.0, -1.0, -2.0, -3.0, 0.0, 4.0, 4.0, -1.0));
	blockC.d.mA[0].mA = (mat3x2(-8.0, 1.0, -8.0, 3.0, 2.0, -8.0));
	blockC.d.mA[1].mA = (mat3x2(6.0, -5.0, 9.0, 3.0, 4.0, -4.0));
	blockC.d.mA[2].mA = (mat3x2(-8.0, -6.0, -1.0, 7.0, -5.0, 9.0));
	blockC.d.mB.mA = (mat3(9.0, 7.0, 9.0, -5.0, -4.0, -9.0, -7.0, -8.0, -6.0));
	blockC.d.mB.mB = i8vec4(ivec4(4294967294, 4294967293, 4, 7));
	blockC.d.mB.mC = i8vec4(ivec4(0, 0, 4294967291, 7));
}
#version 450
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
	i8vec4 a;
	mediump mat3 b[5];
	highp vec2 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB[0].a), ivec4(5, 9, 3, 2)) && allOk;
	allOk = compare_mat3(blockB[0].b[0], mat3(5.0, 9.0, -2.0, -7.0, -4.0, 1.0, -2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB[0].b[1], mat3(-8.0, -2.0, -4.0, 7.0, -1.0, 6.0, -1.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3(blockB[0].b[2], mat3(-1.0, 4.0, -4.0, -6.0, 4.0, 1.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB[0].b[3], mat3(-1.0, -6.0, -2.0, -6.0, 9.0, 0.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3(blockB[0].b[4], mat3(3.0, -8.0, -7.0, -3.0, 1.0, -4.0, 5.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB[0].c), vec2(5.0, 9.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[1].a), ivec4(7, 4294967295, 8, 8)) && allOk;
	allOk = compare_mat3(blockB[1].b[0], mat3(-4.0, 6.0, -3.0, 6.0, -5.0, -9.0, 9.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[1], mat3(2.0, 1.0, -2.0, 4.0, 0.0, -8.0, 0.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[2], mat3(1.0, -6.0, 6.0, 1.0, 7.0, -9.0, -3.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[3], mat3(7.0, 6.0, 2.0, -9.0, -1.0, 2.0, -1.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[4], mat3(-4.0, -9.0, -9.0, -6.0, 6.0, 4.0, -6.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB[1].c), vec2(9.0, 6.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[2].a), ivec4(4294967287, 4294967288, 4, 9)) && allOk;
	allOk = compare_mat3(blockB[2].b[0], mat3(2.0, -1.0, -5.0, 3.0, 6.0, -7.0, -1.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[1], mat3(7.0, 1.0, -1.0, -1.0, 4.0, -8.0, -3.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[2], mat3(0.0, -9.0, 7.0, -3.0, -9.0, 0.0, -8.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[3], mat3(-5.0, 3.0, -3.0, 1.0, -4.0, 5.0, 3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[4], mat3(1.0, 8.0, -4.0, -6.0, 1.0, 4.0, 2.0, 6.0, 3.0)) && allOk;
	allOk = compare_vec2((blockB[2].c), vec2(7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i8vec4(ivec4(9, 2, 6, 4294967292));
	blockB[0].b[0] = (mat3(-3.0, -3.0, 5.0, 8.0, 1.0, 6.0, 6.0, -9.0, 8.0));
	blockB[0].b[1] = (mat3(7.0, 9.0, 0.0, 5.0, -5.0, 7.0, -5.0, -3.0, 9.0));
	blockB[0].b[2] = (mat3(-1.0, -6.0, -8.0, 0.0, 9.0, -9.0, -1.0, 5.0, 1.0));
	blockB[0].b[3] = (mat3(-9.0, -8.0, -8.0, -1.0, -8.0, 9.0, 7.0, -1.0, -2.0));
	blockB[0].b[4] = (mat3(-7.0, 0.0, -9.0, -2.0, 3.0, -9.0, 3.0, -6.0, -2.0));
	blockB[0].c = (vec2(5.0, -2.0));
	blockB[1].a = i8vec4(ivec4(9, 4294967295, 4294967289, 0));
	blockB[1].b[0] = (mat3(9.0, -3.0, -3.0, 7.0, 5.0, 7.0, 8.0, 4.0, -2.0));
	blockB[1].b[1] = (mat3(-7.0, 4.0, -1.0, 2.0, 7.0, 2.0, 3.0, 5.0, -6.0));
	blockB[1].b[2] = (mat3(-3.0, 3.0, -7.0, -1.0, 0.0, -2.0, 8.0, 9.0, -3.0));
	blockB[1].b[3] = (mat3(-1.0, 0.0, -4.0, 6.0, 8.0, -4.0, -5.0, 0.0, -2.0));
	blockB[1].b[4] = (mat3(-4.0, -5.0, 6.0, -3.0, -1.0, -9.0, -5.0, 3.0, 4.0));
	blockB[1].c = (vec2(-5.0, -7.0));
	blockB[2].a = i8vec4(ivec4(1, 4294967288, 4, 2));
	blockB[2].b[0] = (mat3(-8.0, 8.0, 6.0, -1.0, 8.0, -2.0, -4.0, 8.0, 7.0));
	blockB[2].b[1] = (mat3(-9.0, 8.0, -8.0, -2.0, 1.0, 0.0, -8.0, 2.0, 5.0));
	blockB[2].b[2] = (mat3(-9.0, 3.0, -3.0, -8.0, 4.0, -5.0, -6.0, 8.0, -1.0));
	blockB[2].b[3] = (mat3(-9.0, 2.0, 7.0, -1.0, 5.0, -8.0, 3.0, 3.0, 1.0));
	blockB[2].b[4] = (mat3(7.0, 5.0, -2.0, -1.0, -3.0, -1.0, -5.0, 9.0, -3.0));
	blockB[2].c = (vec2(7.0, 6.0));
}
