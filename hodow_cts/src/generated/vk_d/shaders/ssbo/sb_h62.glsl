#version 450
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
	lowp float var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var), -9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (-9.0);
}
#version 450
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
	bvec4 var;
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((var), bvec4(true, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (bvec4(true, true, true, false));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
{
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[0][3], -7.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[1][2], -7.0) && allOk;
	allOk = compare_float(var[1][3], -4.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], -9.0) && allOk;
	allOk = compare_float(var[2][2], -8.0) && allOk;
	allOk = compare_float(var[2][3], 6.0) && allOk;
	allOk = compare_float(var[3][0], 7.0) && allOk;
	allOk = compare_float(var[3][1], 0.0) && allOk;
	allOk = compare_float(var[3][2], 3.0) && allOk;
	allOk = compare_float(var[3][3], 1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(9.0, 7.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(6.0, 0.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-9.0, -9.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(7.0, 0.0, 3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4(9.0, 1.0, -6.0, 1.0, 1.0, 8.0, -8.0, -6.0, 2.0, -9.0, 7.0, -2.0, 8.0, 7.0, 2.0, -8.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[1][0], 7.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_float(var[2][0], -2.0) && allOk;
	allOk = compare_float(var[2][1], -1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-5.0, -4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(7.0, -8.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(0.0, -4.0, 4.0, -5.0, 1.0, 9.0));
}
#version 450
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(-4.0, 2.0, 6.0, -2.0, -6.0, -6.0, 8.0, 4.0, -1.0, -1.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(-3.0, -1.0, -3.0, 9.0, 5.0, 7.0, -2.0, -6.0, 0.0, -3.0, 4.0, 6.0));
}
#version 450
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
	allOk = compare_mat4(var, mat4(3.0, -4.0, 1.0, -6.0, 0.0, 0.0, -1.0, -6.0, -3.0, 1.0, 1.0, 9.0, 6.0, 8.0, 9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4(-7.0, 2.0, -1.0, 7.0, -7.0, 9.0, 1.0, 3.0, -1.0, -4.0, -5.0, 4.0, 4.0, 3.0, 2.0, 7.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
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

	var[0] = (vec4(-5.0, 0.0, 6.0, -3.0));
	var[1] = (vec4(-7.0, -8.0, 7.0, -1.0));
}
#version 450
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

	var = (mat2x4(-7.0, 6.0, 2.0, -6.0, 9.0, 7.0, 1.0, -6.0));
}
#version 450
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
	mediump uvec4 var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 1u) && allOk;
	allOk = compare_uvec4((var), uvec4(4u, 9u, 6u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5u);
	var = (uvec4(0u, 1u, 3u, 9u));
}
#version 450
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
	allOk = compare_mat2(var, mat2(8.0, 2.0, -3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0] = (vec2(5.0, 8.0));
	var[1] = (vec2(-9.0, 8.0));
}
#version 450
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat4(var, mat4(2.0, 5.0, 5.0, 7.0, -4.0, 0.0, 3.0, 4.0, -6.0, -8.0, 5.0, 5.0, 1.0, 4.0, 5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var = (mat4(-8.0, -3.0, 9.0, -3.0, -5.0, -4.0, 4.0, 0.0, 3.0, 2.0, 1.0, 2.0, -4.0, -7.0, 7.0, 9.0));
}
#version 450
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(-5.0, -4.0, -5.0, 2.0, -2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var = (mat3x2(-3.0, -4.0, 9.0, -7.0, -6.0, 8.0));
}
#version 450
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
	uint8_t padding;
	u8vec4 var;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 3u) && allOk;
	allOk = compare_u8vec4(uvec4(var), uvec4(4u, 6u, 8u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint8_t(9u);
	var = u8vec4(uvec4(5u, 9u, 4u, 6u));
}
#version 450
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

	var[0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	var[1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	var[2] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
}
#version 450
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

	var[0] = i8vec3(ivec3(4294967292, 0, 0));
	var[1] = i8vec3(ivec3(7, 9, 4294967290));
	var[2] = i8vec3(ivec3(4294967288, 9, 4294967288));
}
#version 450
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
	highp mat3x2 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	var[1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	var[2] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
}
#version 450
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

	var[0] = i8vec3(ivec3(4294967292, 0, 0));
	var[1] = i8vec3(ivec3(7, 9, 4294967290));
	var[2] = i8vec3(ivec3(4294967288, 9, 4294967288));
}
#version 450
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat3x2(var[0], mat3x2(-5.0, -1.0, 5.0, 3.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-5.0, -1.0, -7.0, 3.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(7.0, 0.0, 5.0, 0.0, -5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-4.0);
	var[0][0] = (vec2(-6.0, 1.0));
	var[0][1] = (vec2(-3.0, -1.0));
	var[0][2] = (vec2(-9.0, 3.0));
	var[1][0] = (vec2(-2.0, 5.0));
	var[1][1] = (vec2(-8.0, 2.0));
	var[1][2] = (vec2(-9.0, 1.0));
	var[2][0] = (vec2(-5.0, 0.0));
	var[2][1] = (vec2(-2.0, 2.0));
	var[2][2] = (vec2(-1.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[3], mat2x3(-6.0, 8.0, -3.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(6.0, -2.0, -7.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(7.0, -3.0, 2.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(7.0, -9.0, 0.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(5.0, 3.0, 9.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(5.0, -3.0, 6.0, 8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(9.0, 5.0, 6.0, 7.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(1.0, 9.0, 5.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(1.0, 6.0, -5.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(1.0, -3.0, -1.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(-2.0, 8.0, 1.0, 6.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(2.0, 5.0, 0.0, -6.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(9.0, 7.0, -7.0, 4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(3.0, 7.0, 0.0, -3.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(9.0, 5.0, -9.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(-3.0, -8.0, -3.0, 7.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(0.0, 5.0, 5.0));
	var[0][1] = (vec3(0.0, -7.0, 8.0));
	var[1][0] = (vec3(-7.0, -4.0, 6.0));
	var[1][1] = (vec3(1.0, 3.0, 2.0));
	var[2][0] = (vec3(-6.0, 5.0, 2.0));
	var[2][1] = (vec3(1.0, 8.0, -8.0));
	var[3][0] = (vec3(2.0, -7.0, 5.0));
	var[3][1] = (vec3(-4.0, -6.0, -9.0));
	var[4][0] = (vec3(3.0, 0.0, -7.0));
	var[4][1] = (vec3(2.0, -4.0, 1.0));
	var[5][0] = (vec3(-2.0, -2.0, -5.0));
	var[5][1] = (vec3(2.0, 5.0, 4.0));
	var[6][0] = (vec3(4.0, -1.0, 7.0));
	var[6][1] = (vec3(9.0, -2.0, -4.0));
	var[7][0] = (vec3(8.0, -4.0, 2.0));
	var[7][1] = (vec3(5.0, -1.0, -3.0));
	var[8][0] = (vec3(3.0, -2.0, -8.0));
	var[8][1] = (vec3(6.0, 0.0, 9.0));
	var[9][0] = (vec3(1.0, -5.0, -1.0));
	var[9][1] = (vec3(-6.0, -6.0, 3.0));
	var[10][0] = (vec3(1.0, -8.0, -5.0));
	var[10][1] = (vec3(8.0, 5.0, 8.0));
	var[11][0] = (vec3(5.0, 5.0, 7.0));
	var[11][1] = (vec3(-9.0, 8.0, 0.0));
	var[12][0] = (vec3(8.0, 7.0, -1.0));
	var[12][1] = (vec3(-6.0, 1.0, -2.0));
	var[13][0] = (vec3(8.0, -6.0, -8.0));
	var[13][1] = (vec3(9.0, -5.0, 5.0));
	var[14][0] = (vec3(-8.0, 1.0, -3.0));
	var[14][1] = (vec3(-4.0, -5.0, 1.0));
	var[15][0] = (vec3(4.0, -2.0, -5.0));
	var[15][1] = (vec3(-9.0, -8.0, -5.0));
	var[16][0] = (vec3(5.0, 9.0, 6.0));
	var[16][1] = (vec3(7.0, 5.0, 7.0));
	var[17][0] = (vec3(0.0, 9.0, -4.0));
	var[17][1] = (vec3(7.0, -3.0, 7.0));
	var[18][0] = (vec3(5.0, -5.0, 1.0));
	var[18][1] = (vec3(9.0, 2.0, -6.0));
}
#version 450
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

	var[0] = (-2.0);
	var[1] = (4.0);
	var[2] = (6.0);
	var[3] = (7.0);
	var[4] = (-4.0);
	var[5] = (5.0);
	var[6] = (-8.0);
	var[7] = (9.0);
	var[8] = (-5.0);
	var[9] = (8.0);
	var[10] = (-5.0);
	var[11] = (6.0);
	var[12] = (-6.0);
	var[13] = (-9.0);
	var[14] = (-4.0);
	var[15] = (3.0);
	var[16] = (7.0);
	var[17] = (6.0);
	var[18] = (5.0);
}
#version 450
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

layout(scalar, binding = 1) buffer Block
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

	var[0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	var[1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	var[2] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
	var[3] = (mat3x4(-6.0, 7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0));
	var[4] = (mat3x4(7.0, -8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0));
	var[5] = (mat3x4(-1.0, 2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0));
	var[6] = (mat3x4(6.0, 6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0));
	var[7] = (mat3x4(3.0, -3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0));
	var[8] = (mat3x4(9.0, 4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0));
	var[9] = (mat3x4(5.0, 0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0));
	var[10] = (mat3x4(0.0, -3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0));
	var[11] = (mat3x4(5.0, 7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0));
	var[12] = (mat3x4(9.0, -2.0, 8.0, -4.0, 8.0, 4.0, 3.0, -3.0, 3.0, -5.0, 7.0, -8.0));
	var[13] = (mat3x4(5.0, -3.0, 8.0, 6.0, 1.0, 6.0, -2.0, -6.0, 0.0, 1.0, 3.0, 3.0));
	var[14] = (mat3x4(-3.0, 0.0, -3.0, 5.0, -4.0, -5.0, 1.0, -5.0, -5.0, 0.0, 0.0, -6.0));
	var[15] = (mat3x4(4.0, 6.0, -7.0, 7.0, 3.0, 6.0, 4.0, -7.0, 8.0, -1.0, 3.0, 3.0));
	var[16] = (mat3x4(-1.0, 0.0, -1.0, 5.0, 3.0, -9.0, 6.0, 8.0, -9.0, -5.0, -1.0, 1.0));
	var[17] = (mat3x4(-1.0, -4.0, 7.0, 7.0, 5.0, -7.0, 1.0, 3.0, 6.0, 3.0, -3.0, -9.0));
	var[18] = (mat3x4(3.0, -7.0, -1.0, 2.0, -7.0, -9.0, 4.0, 1.0, -9.0, 4.0, 5.0, -1.0));
}
#version 450
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

layout(scalar, column_major, binding = 1) buffer Block
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
	var[3][0] = (vec3(-9.0, -2.0, -2.0));
	var[3][1] = (vec3(7.0, 9.0, -4.0));
	var[3][2] = (vec3(3.0, 1.0, 0.0));
	var[3][3] = (vec3(-9.0, -2.0, -7.0));
	var[4][0] = (vec3(-5.0, -6.0, 5.0));
	var[4][1] = (vec3(-2.0, -7.0, 5.0));
	var[4][2] = (vec3(-2.0, -6.0, 4.0));
	var[4][3] = (vec3(9.0, 5.0, -9.0));
	var[5][0] = (vec3(-3.0, 3.0, 7.0));
	var[5][1] = (vec3(3.0, -4.0, -8.0));
	var[5][2] = (vec3(-2.0, 2.0, -1.0));
	var[5][3] = (vec3(1.0, -9.0, 9.0));
	var[6][0] = (vec3(-7.0, -7.0, -7.0));
	var[6][1] = (vec3(6.0, -9.0, 3.0));
	var[6][2] = (vec3(-5.0, 2.0, 4.0));
	var[6][3] = (vec3(-2.0, -4.0, -6.0));
	var[7][0] = (vec3(-1.0, 5.0, 5.0));
	var[7][1] = (vec3(-9.0, -3.0, -9.0));
	var[7][2] = (vec3(3.0, 2.0, 0.0));
	var[7][3] = (vec3(0.0, -9.0, 7.0));
	var[8][0] = (vec3(5.0, -5.0, -2.0));
	var[8][1] = (vec3(6.0, 5.0, -4.0));
	var[8][2] = (vec3(-2.0, 9.0, -3.0));
	var[8][3] = (vec3(2.0, 5.0, -4.0));
	var[9][0] = (vec3(6.0, 4.0, 7.0));
	var[9][1] = (vec3(1.0, -4.0, -6.0));
	var[9][2] = (vec3(4.0, -6.0, -5.0));
	var[9][3] = (vec3(5.0, 6.0, -1.0));
	var[10][0] = (vec3(6.0, 3.0, -9.0));
	var[10][1] = (vec3(-7.0, 3.0, -4.0));
	var[10][2] = (vec3(1.0, 2.0, 6.0));
	var[10][3] = (vec3(-2.0, 3.0, 7.0));
	var[11][0] = (vec3(-5.0, 8.0, -9.0));
	var[11][1] = (vec3(-4.0, -1.0, -9.0));
	var[11][2] = (vec3(5.0, 5.0, 6.0));
	var[11][3] = (vec3(-8.0, 1.0, -7.0));
	var[12][0] = (vec3(-5.0, -6.0, -3.0));
	var[12][1] = (vec3(-2.0, 5.0, 8.0));
	var[12][2] = (vec3(2.0, -9.0, 7.0));
	var[12][3] = (vec3(7.0, -3.0, 4.0));
	var[13][0] = (vec3(9.0, 4.0, 1.0));
	var[13][1] = (vec3(5.0, -9.0, 2.0));
	var[13][2] = (vec3(-7.0, -3.0, -9.0));
	var[13][3] = (vec3(9.0, -6.0, 3.0));
	var[14][0] = (vec3(-9.0, -4.0, 0.0));
	var[14][1] = (vec3(5.0, 8.0, 9.0));
	var[14][2] = (vec3(-7.0, -9.0, -5.0));
	var[14][3] = (vec3(0.0, -1.0, -6.0));
	var[15][0] = (vec3(-9.0, -9.0, 9.0));
	var[15][1] = (vec3(9.0, -1.0, 8.0));
	var[15][2] = (vec3(8.0, -8.0, 4.0));
	var[15][3] = (vec3(9.0, -8.0, 8.0));
	var[16][0] = (vec3(4.0, 6.0, 1.0));
	var[16][1] = (vec3(-9.0, 7.0, 3.0));
	var[16][2] = (vec3(-4.0, -3.0, 8.0));
	var[16][3] = (vec3(-9.0, -9.0, 2.0));
	var[17][0] = (vec3(0.0, -2.0, 5.0));
	var[17][1] = (vec3(8.0, 4.0, -4.0));
	var[17][2] = (vec3(5.0, 4.0, -5.0));
	var[17][3] = (vec3(0.0, -3.0, 9.0));
	var[18][0] = (vec3(-4.0, -7.0, 3.0));
	var[18][1] = (vec3(6.0, 4.0, 1.0));
	var[18][2] = (vec3(-3.0, 3.0, 8.0));
	var[18][3] = (vec3(-6.0, 5.0, -6.0));
}
#version 450
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

	var[0] = i16vec4(ivec4(-4, -8, -4, 9));
	var[1] = i16vec4(ivec4(2, 7, -4, 4));
	var[2] = i16vec4(ivec4(8, 9, 5, 1));
	var[3] = i16vec4(ivec4(-3, 3, 8, 7));
	var[4] = i16vec4(ivec4(2, 6, -9, 9));
	var[5] = i16vec4(ivec4(-2, 4, -8, -7));
	var[6] = i16vec4(ivec4(-9, -1, -8, -1));
	var[7] = i16vec4(ivec4(-1, -6, 5, 2));
	var[8] = i16vec4(ivec4(-3, 8, -7, -2));
	var[9] = i16vec4(ivec4(9, 7, 6, -9));
	var[10] = i16vec4(ivec4(5, -3, 8, 5));
	var[11] = i16vec4(ivec4(-6, -9, -6, 2));
	var[12] = i16vec4(ivec4(7, -1, 8, -5));
	var[13] = i16vec4(ivec4(-9, -6, -2, -2));
	var[14] = i16vec4(ivec4(-3, 8, 7, -4));
	var[15] = i16vec4(ivec4(-2, 0, 6, -2));
	var[16] = i16vec4(ivec4(6, -5, -6, -3));
	var[17] = i16vec4(ivec4(4, -4, -4, 9));
	var[18] = i16vec4(ivec4(7, 6, 4, -1));
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0], mat3x4(5.0, -7.0, -9.0, 4.0, 5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(-9.0, 7.0, -4.0, 5.0, -9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(4.0, 1.0, 3.0, -1.0, -3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(5.0, 1.0, -8.0, -9.0, -6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(-3.0, 6.0, 3.0, 0.0, -4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(-1.0, 6.0, 5.0, -4.0, -5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(2.0, 3.0, 2.0, 5.0, -4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(-3.0, 3.0, -2.0, 6.0, 9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(1.0, -2.0, 4.0, 2.0, 7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(6.0, -8.0, 1.0, 3.0, 2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(-8.0, 4.0, 3.0, 2.0, 2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(2.0, 0.0, -3.0, 3.0, -7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	var[0][1] = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	var[0][2] = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
	var[1][0] = (mat3x4(0.0, -2.0, -8.0, -5.0, 0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0));
	var[1][1] = (mat3x4(-1.0, 7.0, 7.0, 7.0, 2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0));
	var[1][2] = (mat3x4(5.0, 8.0, 9.0, 8.0, 7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0));
	var[2][0] = (mat3x4(-7.0, -8.0, -2.0, 9.0, -8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0));
	var[2][1] = (mat3x4(1.0, 5.0, 7.0, 5.0, -4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0));
	var[2][2] = (mat3x4(-1.0, 2.0, 3.0, -5.0, -6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0));
	var[3][0] = (mat3x4(-2.0, 9.0, -8.0, 3.0, -5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0));
	var[3][1] = (mat3x4(-3.0, 2.0, 8.0, 3.0, -1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0));
	var[3][2] = (mat3x4(-7.0, -5.0, -3.0, 6.0, -7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0));
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0], mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(8.0, -1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(-3.0, -9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(-2.0, -4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(-9.0, -4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(-1.0, 9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(-2.0, 2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(0.0, 2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(4.0, 1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(8.0, -5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	var[0][1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	var[0][2] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
	var[1][0] = (mat3x4(-6.0, 7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0));
	var[1][1] = (mat3x4(7.0, -8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0));
	var[1][2] = (mat3x4(-1.0, 2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0));
	var[2][0] = (mat3x4(6.0, 6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0));
	var[2][1] = (mat3x4(3.0, -3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0));
	var[2][2] = (mat3x4(9.0, 4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0));
	var[3][0] = (mat3x4(5.0, 0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0));
	var[3][1] = (mat3x4(0.0, -3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0));
	var[3][2] = (mat3x4(5.0, 7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0));
}
#version 450
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
	highp float var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_float((var[0][0]), -1.0) && allOk;
	allOk = compare_float((var[0][1]), -6.0) && allOk;
	allOk = compare_float((var[0][2]), 0.0) && allOk;
	allOk = compare_float((var[1][0]), -7.0) && allOk;
	allOk = compare_float((var[1][1]), 5.0) && allOk;
	allOk = compare_float((var[1][2]), 4.0) && allOk;
	allOk = compare_float((var[2][0]), 2.0) && allOk;
	allOk = compare_float((var[2][1]), -1.0) && allOk;
	allOk = compare_float((var[2][2]), -6.0) && allOk;
	allOk = compare_float((var[3][0]), -2.0) && allOk;
	allOk = compare_float((var[3][1]), -1.0) && allOk;
	allOk = compare_float((var[3][2]), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0] = (4.0);
	var[0][1] = (6.0);
	var[0][2] = (7.0);
	var[1][0] = (-4.0);
	var[1][1] = (5.0);
	var[1][2] = (-8.0);
	var[2][0] = (9.0);
	var[2][1] = (-5.0);
	var[2][2] = (8.0);
	var[3][0] = (-5.0);
	var[3][1] = (6.0);
	var[3][2] = (-6.0);
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3x4(var[0][0], mat3x4(7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(-9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(-5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(-8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(-3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0][0] = (vec4(-5.0, 2.0, 5.0, -2.0));
	var[0][0][1] = (vec4(-3.0, 9.0, -2.0, -6.0));
	var[0][0][2] = (vec4(7.0, 4.0, -6.0, 2.0));
	var[0][1][0] = (vec4(6.0, 9.0, -2.0, 7.0));
	var[0][1][1] = (vec4(9.0, 0.0, 0.0, 8.0));
	var[0][1][2] = (vec4(-3.0, 0.0, 3.0, -6.0));
	var[0][2][0] = (vec4(1.0, 9.0, 6.0, -9.0));
	var[0][2][1] = (vec4(-9.0, 2.0, -4.0, -8.0));
	var[0][2][2] = (vec4(5.0, -1.0, 9.0, 8.0));
	var[1][0][0] = (vec4(-2.0, 1.0, 1.0, -6.0));
	var[1][0][1] = (vec4(-1.0, -9.0, 6.0, 7.0));
	var[1][0][2] = (vec4(-1.0, 1.0, -8.0, 6.0));
	var[1][1][0] = (vec4(8.0, -2.0, 7.0, 1.0));
	var[1][1][1] = (vec4(-6.0, -3.0, 9.0, 1.0));
	var[1][1][2] = (vec4(-6.0, 1.0, -6.0, 3.0));
	var[1][2][0] = (vec4(-1.0, 5.0, -2.0, 7.0));
	var[1][2][1] = (vec4(-1.0, -2.0, -3.0, -6.0));
	var[1][2][2] = (vec4(4.0, -4.0, -1.0, -3.0));
	var[2][0][0] = (vec4(-3.0, 3.0, -7.0, 2.0));
	var[2][0][1] = (vec4(8.0, -4.0, 1.0, -1.0));
	var[2][0][2] = (vec4(6.0, -4.0, 7.0, 5.0));
	var[2][1][0] = (vec4(-8.0, -2.0, 6.0, -2.0));
	var[2][1][1] = (vec4(8.0, -2.0, 2.0, 3.0));
	var[2][1][2] = (vec4(7.0, 0.0, 2.0, 3.0));
	var[2][2][0] = (vec4(9.0, 8.0, 5.0, 2.0));
	var[2][2][1] = (vec4(-3.0, -7.0, 2.0, -1.0));
	var[2][2][2] = (vec4(1.0, -4.0, -1.0, -6.0));
	var[3][0][0] = (vec4(-4.0, -1.0, -3.0, -8.0));
	var[3][0][1] = (vec4(5.0, -4.0, -9.0, 8.0));
	var[3][0][2] = (vec4(3.0, -8.0, 0.0, 7.0));
	var[3][1][0] = (vec4(-2.0, 0.0, 8.0, -9.0));
	var[3][1][1] = (vec4(2.0, -3.0, -7.0, -5.0));
	var[3][1][2] = (vec4(3.0, 9.0, -6.0, -7.0));
	var[3][2][0] = (vec4(-8.0, -8.0, -7.0, -9.0));
	var[3][2][1] = (vec4(2.0, 4.0, -7.0, 8.0));
	var[3][2][2] = (vec4(-7.0, 4.0, -8.0, 0.0));
}
#version 450
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
	int16_t var[4][3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), -5) && allOk;
	allOk = compare_int16_t(int(var[0][0]), 1) && allOk;
	allOk = compare_int16_t(int(var[0][1]), 8) && allOk;
	allOk = compare_int16_t(int(var[0][2]), -2) && allOk;
	allOk = compare_int16_t(int(var[1][0]), 9) && allOk;
	allOk = compare_int16_t(int(var[1][1]), -5) && allOk;
	allOk = compare_int16_t(int(var[1][2]), -8) && allOk;
	allOk = compare_int16_t(int(var[2][0]), 6) && allOk;
	allOk = compare_int16_t(int(var[2][1]), 3) && allOk;
	allOk = compare_int16_t(int(var[2][2]), -8) && allOk;
	allOk = compare_int16_t(int(var[3][0]), 6) && allOk;
	allOk = compare_int16_t(int(var[3][1]), -7) && allOk;
	allOk = compare_int16_t(int(var[3][2]), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int16_t(6);
	var[0][0] = int16_t(8);
	var[0][1] = int16_t(-2);
	var[0][2] = int16_t(-4);
	var[1][0] = int16_t(-3);
	var[1][1] = int16_t(9);
	var[1][2] = int16_t(-5);
	var[2][0] = int16_t(-8);
	var[2][1] = int16_t(-3);
	var[2][2] = int16_t(2);
	var[3][0] = int16_t(-1);
	var[3][1] = int16_t(4);
	var[3][2] = int16_t(3);
}
#version 450
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
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(5.0, -7.0, 2.0, -4.0, -1.0, -2.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(5.0, -7.0, 6.0, 5.0, 2.0, -2.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(1.0, -3.0, 4.0, 0.0, -1.0, 8.0, 6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(2.0, 7.0, -2.0, 3.0, 3.0, -2.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(9.0, 4.0, -5.0, 1.0, 0.0, -1.0, -5.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(9.0, 4.0, -9.0, 4.0, 7.0, -5.0, 6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-3.0, -5.0, 8.0, -6.0, -4.0, -4.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(-5.0, 4.0, 8.0, -2.0, -6.0, -6.0, 1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(6.0, -1.0, 4.0, 5.0, 0.0, 4.0, 4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(5.0, -1.0, -1.0, -6.0, 5.0, -7.0, -5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(-7.0, 8.0, 7.0, 6.0, 0.0, 5.0, 6.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(-2.0, 7.0, 3.0, -6.0, -7.0, -9.0, -5.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(8.0, 3.0, 9.0));
	var[0][0][0][1] = (vec3(6.0, 2.0, -9.0));
	var[0][0][0][2] = (vec3(-8.0, 5.0, 2.0));
	var[0][0][1][0] = (vec3(3.0, -3.0, -4.0));
	var[0][0][1][1] = (vec3(2.0, -9.0, -5.0));
	var[0][0][1][2] = (vec3(5.0, 8.0, 8.0));
	var[0][0][2][0] = (vec3(-5.0, -3.0, -3.0));
	var[0][0][2][1] = (vec3(3.0, -5.0, -4.0));
	var[0][0][2][2] = (vec3(-7.0, 5.0, 3.0));
	var[0][1][0][0] = (vec3(-4.0, 8.0, 7.0));
	var[0][1][0][1] = (vec3(1.0, 7.0, -5.0));
	var[0][1][0][2] = (vec3(7.0, 9.0, 4.0));
	var[0][1][1][0] = (vec3(-2.0, 2.0, 1.0));
	var[0][1][1][1] = (vec3(-8.0, -6.0, 7.0));
	var[0][1][1][2] = (vec3(-3.0, 2.0, -5.0));
	var[0][1][2][0] = (vec3(-6.0, 6.0, -7.0));
	var[0][1][2][1] = (vec3(1.0, 3.0, -7.0));
	var[0][1][2][2] = (vec3(6.0, -8.0, 4.0));
	var[1][0][0][0] = (vec3(-8.0, 7.0, 8.0));
	var[1][0][0][1] = (vec3(8.0, 2.0, -9.0));
	var[1][0][0][2] = (vec3(-3.0, 6.0, -3.0));
	var[1][0][1][0] = (vec3(7.0, -3.0, 6.0));
	var[1][0][1][1] = (vec3(-7.0, 6.0, -7.0));
	var[1][0][1][2] = (vec3(2.0, 3.0, -3.0));
	var[1][0][2][0] = (vec3(-1.0, -5.0, -1.0));
	var[1][0][2][1] = (vec3(8.0, 4.0, -3.0));
	var[1][0][2][2] = (vec3(8.0, -6.0, 4.0));
	var[1][1][0][0] = (vec3(-3.0, -8.0, 3.0));
	var[1][1][0][1] = (vec3(-5.0, -8.0, 8.0));
	var[1][1][0][2] = (vec3(7.0, 2.0, -3.0));
	var[1][1][1][0] = (vec3(3.0, -1.0, -6.0));
	var[1][1][1][1] = (vec3(-1.0, 6.0, 7.0));
	var[1][1][1][2] = (vec3(9.0, -1.0, 2.0));
	var[1][1][2][0] = (vec3(-9.0, -6.0, 9.0));
	var[1][1][2][1] = (vec3(4.0, 9.0, 5.0));
	var[1][1][2][2] = (vec3(5.0, 4.0, -9.0));
	var[2][0][0][0] = (vec3(5.0, 9.0, -7.0));
	var[2][0][0][1] = (vec3(1.0, -3.0, -7.0));
	var[2][0][0][2] = (vec3(-5.0, 4.0, 1.0));
	var[2][0][1][0] = (vec3(-3.0, -5.0, -8.0));
	var[2][0][1][1] = (vec3(-5.0, 6.0, 2.0));
	var[2][0][1][2] = (vec3(-9.0, -9.0, -1.0));
	var[2][0][2][0] = (vec3(2.0, 8.0, -8.0));
	var[2][0][2][1] = (vec3(-6.0, 0.0, 3.0));
	var[2][0][2][2] = (vec3(9.0, -8.0, 3.0));
	var[2][1][0][0] = (vec3(3.0, 3.0, 8.0));
	var[2][1][0][1] = (vec3(1.0, -2.0, 0.0));
	var[2][1][0][2] = (vec3(-9.0, 5.0, 1.0));
	var[2][1][1][0] = (vec3(-2.0, 0.0, 0.0));
	var[2][1][1][1] = (vec3(-3.0, 7.0, -8.0));
	var[2][1][1][2] = (vec3(0.0, 1.0, -3.0));
	var[2][1][2][0] = (vec3(-7.0, 1.0, 4.0));
	var[2][1][2][1] = (vec3(-2.0, -1.0, -5.0));
	var[2][1][2][2] = (vec3(-1.0, 4.0, -2.0));
	var[3][0][0][0] = (vec3(-9.0, 9.0, 2.0));
	var[3][0][0][1] = (vec3(6.0, -4.0, -8.0));
	var[3][0][0][2] = (vec3(3.0, 8.0, 1.0));
	var[3][0][1][0] = (vec3(-9.0, -5.0, -7.0));
	var[3][0][1][1] = (vec3(-4.0, -1.0, -4.0));
	var[3][0][1][2] = (vec3(-6.0, 4.0, 9.0));
	var[3][0][2][0] = (vec3(-3.0, -9.0, 0.0));
	var[3][0][2][1] = (vec3(-9.0, -5.0, -9.0));
	var[3][0][2][2] = (vec3(-1.0, -9.0, 7.0));
	var[3][1][0][0] = (vec3(-9.0, -3.0, 6.0));
	var[3][1][0][1] = (vec3(-4.0, 8.0, 0.0));
	var[3][1][0][2] = (vec3(-5.0, -4.0, 2.0));
	var[3][1][1][0] = (vec3(-8.0, 0.0, -8.0));
	var[3][1][1][1] = (vec3(-8.0, 8.0, 0.0));
	var[3][1][1][2] = (vec3(-8.0, -6.0, -9.0));
	var[3][1][2][0] = (vec3(1.0, 3.0, 8.0));
	var[3][1][2][1] = (vec3(-2.0, 9.0, -6.0));
	var[3][1][2][2] = (vec3(-2.0, 6.0, 0.0));
}
#version 450
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
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(-1.0, 5.0, -1.0, 7.0, -2.0, -7.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-3.0, -8.0, 0.0, -2.0, 6.0, -7.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(1.0, 7.0, 9.0, -8.0, 7.0, -3.0, -9.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-4.0, -2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-2.0, 1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(3.0, 0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-9.0, 2.0, -9.0, 9.0, 5.0, 3.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(2.0, -4.0, -3.0, 6.0, -4.0, -3.0, -8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(-1.0, 5.0, -7.0, -9.0, 2.0, 9.0, -3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(0.0, 1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-5.0, -7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(4.0, -4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(0.0, 0.0, 9.0, -5.0, 2.0, 9.0, -4.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(4.0, -6.0, 6.0, -1.0, 7.0, 1.0, -1.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(5.0, -1.0, -5.0, -9.0, -2.0, -5.0, 0.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(0.0, -5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(-1.0, 3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(-4.0, 7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(-8.0, 4.0, 0.0, 6.0, -4.0, -5.0, 8.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(-2.0, -3.0, -8.0, 5.0, 6.0, 7.0, -3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(7.0, -5.0, -7.0, -8.0, 4.0, 4.0, 0.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(-1.0, 1.0, 4.0));
	var[0][0][0][1] = (vec3(6.0, -5.0, -5.0));
	var[0][0][0][2] = (vec3(9.0, -6.0, 5.0));
	var[0][0][1][0] = (vec3(7.0, 7.0, -2.0));
	var[0][0][1][1] = (vec3(-4.0, 1.0, -5.0));
	var[0][0][1][2] = (vec3(8.0, -1.0, -8.0));
	var[0][0][2][0] = (vec3(-6.0, -4.0, 5.0));
	var[0][0][2][1] = (vec3(3.0, 9.0, -8.0));
	var[0][0][2][2] = (vec3(-4.0, 8.0, 0.0));
	var[0][1][0][0] = (vec3(4.0, 2.0, 9.0));
	var[0][1][0][1] = (vec3(-7.0, 2.0, 0.0));
	var[0][1][0][2] = (vec3(0.0, -4.0, 3.0));
	var[0][1][1][0] = (vec3(-7.0, -7.0, 1.0));
	var[0][1][1][1] = (vec3(1.0, -5.0, 0.0));
	var[0][1][1][2] = (vec3(5.0, -6.0, 7.0));
	var[0][1][2][0] = (vec3(-2.0, 8.0, -5.0));
	var[0][1][2][1] = (vec3(4.0, -8.0, 2.0));
	var[0][1][2][2] = (vec3(4.0, 2.0, -7.0));
	var[1][0][0][0] = (vec3(5.0, -1.0, 2.0));
	var[1][0][0][1] = (vec3(3.0, 0.0, 8.0));
	var[1][0][0][2] = (vec3(-8.0, -9.0, -1.0));
	var[1][0][1][0] = (vec3(-9.0, 4.0, -9.0));
	var[1][0][1][1] = (vec3(7.0, 3.0, 7.0));
	var[1][0][1][2] = (vec3(5.0, -4.0, 3.0));
	var[1][0][2][0] = (vec3(-9.0, 9.0, 4.0));
	var[1][0][2][1] = (vec3(7.0, -1.0, 2.0));
	var[1][0][2][2] = (vec3(-5.0, 2.0, -9.0));
	var[1][1][0][0] = (vec3(-5.0, 2.0, -4.0));
	var[1][1][0][1] = (vec3(0.0, 5.0, -5.0));
	var[1][1][0][2] = (vec3(3.0, 3.0, -8.0));
	var[1][1][1][0] = (vec3(0.0, -7.0, -2.0));
	var[1][1][1][1] = (vec3(-8.0, 3.0, -2.0));
	var[1][1][1][2] = (vec3(9.0, -7.0, -7.0));
	var[1][1][2][0] = (vec3(4.0, -6.0, -3.0));
	var[1][1][2][1] = (vec3(-9.0, -3.0, 8.0));
	var[1][1][2][2] = (vec3(-8.0, -1.0, -6.0));
	var[2][0][0][0] = (vec3(9.0, -7.0, -5.0));
	var[2][0][0][1] = (vec3(-4.0, -8.0, -6.0));
	var[2][0][0][2] = (vec3(-9.0, -6.0, -5.0));
	var[2][0][1][0] = (vec3(7.0, -5.0, 1.0));
	var[2][0][1][1] = (vec3(-7.0, 6.0, -4.0));
	var[2][0][1][2] = (vec3(-3.0, -4.0, -2.0));
	var[2][0][2][0] = (vec3(-4.0, -4.0, 3.0));
	var[2][0][2][1] = (vec3(-9.0, -7.0, 0.0));
	var[2][0][2][2] = (vec3(3.0, 0.0, -1.0));
	var[2][1][0][0] = (vec3(0.0, 5.0, 9.0));
	var[2][1][0][1] = (vec3(-2.0, -2.0, 3.0));
	var[2][1][0][2] = (vec3(-5.0, 3.0, -7.0));
	var[2][1][1][0] = (vec3(-2.0, -3.0, 0.0));
	var[2][1][1][1] = (vec3(-8.0, -8.0, 6.0));
	var[2][1][1][2] = (vec3(2.0, -2.0, -4.0));
	var[2][1][2][0] = (vec3(7.0, 1.0, 7.0));
	var[2][1][2][1] = (vec3(-6.0, 7.0, -3.0));
	var[2][1][2][2] = (vec3(4.0, -6.0, -5.0));
	var[3][0][0][0] = (vec3(-5.0, -6.0, 8.0));
	var[3][0][0][1] = (vec3(3.0, 3.0, -1.0));
	var[3][0][0][2] = (vec3(-7.0, 5.0, 7.0));
	var[3][0][1][0] = (vec3(7.0, 4.0, -7.0));
	var[3][0][1][1] = (vec3(7.0, 7.0, -4.0));
	var[3][0][1][2] = (vec3(-5.0, 9.0, -8.0));
	var[3][0][2][0] = (vec3(-6.0, -7.0, -1.0));
	var[3][0][2][1] = (vec3(8.0, 9.0, 3.0));
	var[3][0][2][2] = (vec3(0.0, -5.0, -7.0));
	var[3][1][0][0] = (vec3(-6.0, -9.0, -9.0));
	var[3][1][0][1] = (vec3(-3.0, 9.0, -8.0));
	var[3][1][0][2] = (vec3(7.0, 7.0, -2.0));
	var[3][1][1][0] = (vec3(-3.0, 4.0, 1.0));
	var[3][1][1][1] = (vec3(-6.0, 4.0, 7.0));
	var[3][1][1][2] = (vec3(-2.0, -4.0, -3.0));
	var[3][1][2][0] = (vec3(-3.0, -5.0, 1.0));
	var[3][1][2][1] = (vec3(4.0, 9.0, -7.0));
	var[3][1][2][2] = (vec3(-1.0, -7.0, -9.0));
}
#version 450
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
	allOk = compare_mat3x4(var[0][0][0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(8.0, 5.0, 9.0, 6.0, -3.0, 4.0, 6.0, -8.0, -9.0, -2.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(1.0, 7.0, -6.0, 3.0, 2.0, 9.0, -9.0, 1.0, 0.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(1.0, 0.0, 9.0, -2.0, -2.0, 1.0, 8.0, 0.0, 0.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-5.0, 7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-9.0, 6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(-9.0, 7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(9.0, -5.0, 2.0, 8.0, -5.0, -3.0, -6.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(2.0, 0.0, -2.0, -7.0, 6.0, -9.0, 9.0, -6.0, 3.0, -2.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(-5.0, 4.0, 0.0, 2.0, 9.0, 7.0, -3.0, 3.0, 5.0, 2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-8.0, 1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-9.0, 9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(-5.0, -8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-8.0, -4.0, 5.0, -8.0, -2.0, -1.0, -3.0, 5.0, 7.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(0.0, 0.0, -6.0, 6.0, -6.0, -9.0, 8.0, 2.0, 6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(-2.0, 4.0, -9.0, -3.0, -4.0, 1.0, -6.0, -1.0, -7.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(8.0, 4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(7.0, -3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(9.0, 2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(-5.0, -5.0, 3.0, 2.0, 1.0, -9.0, 5.0, -2.0, -9.0, 4.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(-2.0, 4.0, -7.0, -4.0, 3.0, 6.0, 0.0, -2.0, -7.0, 2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(-8.0, 6.0, -6.0, 2.0, 7.0, 0.0, 4.0, -6.0, 5.0, 3.0, -8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	var[0][0][0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	var[0][0][0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	var[0][0][1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	var[0][0][1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	var[0][0][1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	var[0][0][2][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	var[0][0][2][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	var[0][0][2][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
	var[0][1][0][0] = (vec4(0.0, 7.0, 3.0, -7.0));
	var[0][1][0][1] = (vec4(-7.0, 7.0, -4.0, -5.0));
	var[0][1][0][2] = (vec4(-8.0, -8.0, -7.0, 4.0));
	var[0][1][1][0] = (vec4(6.0, -3.0, 8.0, -1.0));
	var[0][1][1][1] = (vec4(-4.0, 8.0, 8.0, 1.0));
	var[0][1][1][2] = (vec4(-8.0, -7.0, 5.0, -9.0));
	var[0][1][2][0] = (vec4(1.0, -8.0, 2.0, -2.0));
	var[0][1][2][1] = (vec4(-8.0, -9.0, 1.0, -3.0));
	var[0][1][2][2] = (vec4(-4.0, 3.0, -9.0, 6.0));
	var[1][0][0][0] = (vec4(8.0, -2.0, 1.0, 1.0));
	var[1][0][0][1] = (vec4(-6.0, -1.0, -9.0, 6.0));
	var[1][0][0][2] = (vec4(7.0, -1.0, 1.0, -8.0));
	var[1][0][1][0] = (vec4(6.0, 8.0, -2.0, 7.0));
	var[1][0][1][1] = (vec4(1.0, -6.0, -3.0, 9.0));
	var[1][0][1][2] = (vec4(1.0, -6.0, 1.0, -6.0));
	var[1][0][2][0] = (vec4(3.0, -1.0, 5.0, -2.0));
	var[1][0][2][1] = (vec4(7.0, -1.0, -2.0, -3.0));
	var[1][0][2][2] = (vec4(-6.0, 4.0, -4.0, -1.0));
	var[1][1][0][0] = (vec4(-8.0, 3.0, -5.0, 6.0));
	var[1][1][0][1] = (vec4(9.0, 2.0, -1.0, 8.0));
	var[1][1][0][2] = (vec4(-2.0, 5.0, -2.0, 6.0));
	var[1][1][1][0] = (vec4(1.0, 2.0, 8.0, -3.0));
	var[1][1][1][1] = (vec4(6.0, -3.0, -8.0, 2.0));
	var[1][1][1][2] = (vec4(-6.0, -8.0, 3.0, 3.0));
	var[1][1][2][0] = (vec4(0.0, 9.0, 4.0, -8.0));
	var[1][1][2][1] = (vec4(-7.0, 6.0, -4.0, -8.0));
	var[1][1][2][2] = (vec4(2.0, 9.0, 1.0, 0.0));
	var[2][0][0][0] = (vec4(-3.0, -3.0, 3.0, -7.0));
	var[2][0][0][1] = (vec4(2.0, 8.0, -4.0, 1.0));
	var[2][0][0][2] = (vec4(-1.0, 6.0, -4.0, 7.0));
	var[2][0][1][0] = (vec4(5.0, -8.0, -2.0, 6.0));
	var[2][0][1][1] = (vec4(-2.0, 8.0, -2.0, 2.0));
	var[2][0][1][2] = (vec4(3.0, 7.0, 0.0, 2.0));
	var[2][0][2][0] = (vec4(3.0, 9.0, 8.0, 5.0));
	var[2][0][2][1] = (vec4(2.0, -3.0, -7.0, 2.0));
	var[2][0][2][2] = (vec4(-1.0, 1.0, -4.0, -1.0));
	var[2][1][0][0] = (vec4(3.0, 0.0, -5.0, -4.0));
	var[2][1][0][1] = (vec4(-9.0, -4.0, 0.0, -5.0));
	var[2][1][0][2] = (vec4(-9.0, -9.0, 6.0, -4.0));
	var[2][1][1][0] = (vec4(-7.0, 0.0, 8.0, -6.0));
	var[2][1][1][1] = (vec4(-3.0, 8.0, 9.0, 3.0));
	var[2][1][1][2] = (vec4(7.0, -2.0, -6.0, -6.0));
	var[2][1][2][0] = (vec4(6.0, -9.0, 2.0, 0.0));
	var[2][1][2][1] = (vec4(9.0, 5.0, 5.0, 7.0));
	var[2][1][2][2] = (vec4(8.0, 2.0, 1.0, -1.0));
	var[3][0][0][0] = (vec4(-6.0, -4.0, -1.0, -3.0));
	var[3][0][0][1] = (vec4(-8.0, 5.0, -4.0, -9.0));
	var[3][0][0][2] = (vec4(8.0, 3.0, -8.0, 0.0));
	var[3][0][1][0] = (vec4(7.0, -2.0, 0.0, 8.0));
	var[3][0][1][1] = (vec4(-9.0, 2.0, -3.0, -7.0));
	var[3][0][1][2] = (vec4(-5.0, 3.0, 9.0, -6.0));
	var[3][0][2][0] = (vec4(-7.0, -8.0, -8.0, -7.0));
	var[3][0][2][1] = (vec4(-9.0, 2.0, 4.0, -7.0));
	var[3][0][2][2] = (vec4(8.0, -7.0, 4.0, -8.0));
	var[3][1][0][0] = (vec4(-4.0, 6.0, -3.0, 4.0));
	var[3][1][0][1] = (vec4(9.0, 0.0, -2.0, -7.0));
	var[3][1][0][2] = (vec4(4.0, 7.0, 8.0, 6.0));
	var[3][1][1][0] = (vec4(-1.0, -3.0, 7.0, 5.0));
	var[3][1][1][1] = (vec4(-4.0, -6.0, 0.0, -2.0));
	var[3][1][1][2] = (vec4(-6.0, 2.0, 3.0, 4.0));
	var[3][1][2][0] = (vec4(-6.0, -1.0, 1.0, -2.0));
	var[3][1][2][1] = (vec4(2.0, -6.0, -2.0, 3.0));
	var[3][1][2][2] = (vec4(-8.0, 4.0, -4.0, 7.0));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-8.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(6.0, 6.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-7.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(9.0, -6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(-7.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(0.0, -7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-9.0, 1.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(4.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(3.0, -4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(-8.0, -4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(5.0, 3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(-5.0, -2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(2.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(2.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(9.0, 6.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(-1.0, 9.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(-5.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(-7.0, -3.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(2.0, 4.0, 4.0, -1.0));
	var[0][0][1] = (mat2(2.0, -5.0, 1.0, -1.0));
	var[0][0][2] = (mat2(-2.0, -9.0, -3.0, -8.0));
	var[0][1][0] = (mat2(-5.0, 7.0, -8.0, 6.0));
	var[0][1][1] = (mat2(1.0, 0.0, 7.0, -3.0));
	var[0][1][2] = (mat2(9.0, -8.0, -6.0, -9.0));
	var[1][0][0] = (mat2(-6.0, -7.0, 1.0, -1.0));
	var[1][0][1] = (mat2(6.0, 2.0, -7.0, 8.0));
	var[1][0][2] = (mat2(-3.0, -2.0, 2.0, -7.0));
	var[1][1][0] = (mat2(-6.0, 8.0, 1.0, -2.0));
	var[1][1][1] = (mat2(-4.0, -5.0, -4.0, 2.0));
	var[1][1][2] = (mat2(4.0, -9.0, 8.0, -9.0));
	var[2][0][0] = (mat2(-1.0, -3.0, -7.0, 2.0));
	var[2][0][1] = (mat2(-3.0, -6.0, 2.0, 7.0));
	var[2][0][2] = (mat2(4.0, -2.0, -7.0, 4.0));
	var[2][1][0] = (mat2(-2.0, 2.0, 3.0, -3.0));
	var[2][1][1] = (mat2(3.0, 2.0, -9.0, -5.0));
	var[2][1][2] = (mat2(-9.0, 7.0, -7.0, 5.0));
	var[3][0][0] = (mat2(-7.0, -5.0, -7.0, -5.0));
	var[3][0][1] = (mat2(-6.0, 4.0, 6.0, 4.0));
	var[3][0][2] = (mat2(2.0, -1.0, 9.0, 6.0));
	var[3][1][0] = (mat2(-9.0, -6.0, -9.0, 3.0));
	var[3][1][1] = (mat2(4.0, -2.0, 0.0, -7.0));
	var[3][1][2] = (mat2(4.0, -2.0, -8.0, 0.0));
}
#version 450
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
	highp mat4x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-3.0, -5.0, -5.0, -4.0, 8.0, -3.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-8.0, 9.0, -7.0, -5.0, -5.0, -5.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(3.0, -7.0, 5.0, 3.0, 9.0, -8.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(4.0, -9.0, 5.0, 5.0, 0.0, 1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-6.0, -6.0, 2.0, 8.0, 7.0, 2.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(-3.0, -1.0, 3.0, 8.0, -8.0, 9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-4.0, -6.0, 9.0, -3.0, -6.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(6.0, 4.0, -6.0, -2.0, -8.0, 6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(-4.0, -6.0, 4.0, -5.0, -8.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-6.0, 2.0, 3.0, -7.0, 6.0, -7.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(1.0, 3.0, 4.0, -2.0, -5.0, -3.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(-6.0, 6.0, -8.0, 8.0, -4.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-1.0, -6.0, 5.0, 3.0, -9.0, 9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-9.0, 9.0, 5.0, 8.0, -3.0, 7.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(-7.0, -3.0, 6.0, -7.0, -5.0, 5.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(3.0, -4.0, -6.0, 5.0, -1.0, 3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-1.0, -2.0, 2.0, 1.0, 8.0, -6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(1.0, 4.0, 2.0, -8.0, 7.0, 0.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(-5.0, -3.0, -6.0, -9.0, 1.0, 3.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(9.0, -7.0, -6.0, -8.0, 6.0, 3.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(7.0, -6.0, 0.0, 0.0, 6.0, -4.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(3.0, 1.0, -5.0, 5.0, -8.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(4.0, 1.0, -3.0, 2.0, 3.0, -6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(2.0, 2.0, -4.0, -7.0, -5.0, -1.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0][0][0] = (mat4x2(1.0, 5.0, 0.0, 6.0, 3.0, 6.0, 9.0, -5.0));
	var[0][0][1] = (mat4x2(8.0, -6.0, 1.0, -3.0, 2.0, 4.0, -7.0, 8.0));
	var[0][0][2] = (mat4x2(6.0, 6.0, 1.0, -9.0, 9.0, -3.0, -2.0, 2.0));
	var[0][1][0] = (mat4x2(1.0, 3.0, 1.0, -5.0, -5.0, -5.0, -8.0, 2.0));
	var[0][1][1] = (mat4x2(1.0, 5.0, -5.0, 1.0, -2.0, -4.0, -5.0, 0.0));
	var[0][1][2] = (mat4x2(-2.0, 7.0, 1.0, -5.0, -2.0, -9.0, -1.0, -1.0));
	var[1][0][0] = (mat4x2(-9.0, -3.0, -1.0, 1.0, 8.0, 1.0, 0.0, -3.0));
	var[1][0][1] = (mat4x2(-3.0, -6.0, -7.0, 2.0, 2.0, 7.0, 6.0, 3.0));
	var[1][0][2] = (mat4x2(-7.0, -9.0, 6.0, 3.0, 6.0, 3.0, -6.0, -8.0));
	var[1][1][0] = (mat4x2(-2.0, 4.0, 6.0, 1.0, -4.0, 9.0, -5.0, 3.0));
	var[1][1][1] = (mat4x2(-9.0, -6.0, -1.0, 2.0, -9.0, 3.0, -5.0, -9.0));
	var[1][1][2] = (mat4x2(-3.0, -1.0, -3.0, -6.0, -9.0, 9.0, 2.0, 1.0));
	var[2][0][0] = (mat4x2(-9.0, -8.0, -8.0, -4.0, -5.0, -5.0, 5.0, -6.0));
	var[2][0][1] = (mat4x2(7.0, 7.0, -9.0, 6.0, -8.0, -3.0, 1.0, 4.0));
	var[2][0][2] = (mat4x2(8.0, -6.0, 5.0, 3.0, 3.0, 2.0, -4.0, 2.0));
	var[2][1][0] = (mat4x2(1.0, -6.0, 0.0, -2.0, 2.0, -8.0, -8.0, 2.0));
	var[2][1][1] = (mat4x2(-3.0, 7.0, 5.0, 6.0, 5.0, -4.0, -7.0, -1.0));
	var[2][1][2] = (mat4x2(-3.0, -1.0, 7.0, -2.0, -4.0, 2.0, -8.0, 7.0));
	var[3][0][0] = (mat4x2(9.0, 9.0, -2.0, 0.0, -5.0, -2.0, -3.0, 3.0));
	var[3][0][1] = (mat4x2(8.0, 9.0, -2.0, -1.0, 3.0, -2.0, 5.0, 7.0));
	var[3][0][2] = (mat4x2(1.0, -1.0, 2.0, 8.0, 7.0, 7.0, 5.0, 9.0));
	var[3][1][0] = (mat4x2(0.0, -8.0, 0.0, 2.0, -9.0, 5.0, 2.0, -8.0));
	var[3][1][1] = (mat4x2(-4.0, 4.0, -3.0, -5.0, -3.0, 8.0, -1.0, -4.0));
	var[3][1][2] = (mat4x2(-1.0, 0.0, -9.0, 4.0, -2.0, -6.0, -1.0, 7.0));
}
#version 450
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
	allOk = compare_mat4(var[0][0][0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(9.0, -6.0, 6.0, 6.0, -2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-4.0, -3.0, -8.0, 5.0, 8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(2.0, -9.0, 8.0, -3.0, -3.0, -1.0, -8.0, -7.0, -8.0, 4.0, 2.0, -4.0, -5.0, 1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(6.0, -2.0, -2.0, -9.0, 7.0, 8.0, -4.0, -9.0, -8.0, -4.0, 6.0, 7.0, -4.0, -5.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(8.0, 1.0, -4.0, 3.0, 7.0, 9.0, 6.0, -6.0, 2.0, 8.0, 2.0, 3.0, -8.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(-5.0, 3.0, -1.0, -1.0, -9.0, 4.0, -7.0, 5.0, 5.0, 3.0, 8.0, -1.0, 6.0, 3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-4.0, -1.0, 7.0, 7.0, 0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(5.0, -1.0, 6.0, 0.0, -1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(0.0, -4.0, 0.0, 2.0, 5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(3.0, 8.0, 3.0, 9.0, -8.0, 9.0, 4.0, -3.0, -1.0, -3.0, 5.0, -1.0, 3.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(-7.0, 9.0, -8.0, -7.0, -5.0, 5.0, 6.0, 9.0, -7.0, -2.0, 5.0, 7.0, -2.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(-5.0, 5.0, 1.0, 6.0, 0.0, -7.0, -5.0, -8.0, 2.0, 0.0, 4.0, 9.0, -3.0, 8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(5.0, -3.0, -9.0, 6.0, -1.0, -9.0, 1.0, -2.0, 4.0, -2.0, 2.0, -5.0, 6.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(5.0, 0.0, 8.0, -9.0, 0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-4.0, -3.0, -4.0, -7.0, 4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(9.0, 2.0, 5.0, -7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-9.0, -5.0, 3.0, -4.0, -6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(3.0, 7.0, 1.0, -2.0, 8.0, 6.0, 9.0, 5.0, 3.0, 4.0, -8.0, -4.0, -5.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(-3.0, 9.0, 7.0, -3.0, 8.0, -4.0, -7.0, 1.0, -3.0, 9.0, -9.0, -1.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(4.0, 4.0, 9.0, -5.0, -1.0, 8.0, 9.0, 8.0, 5.0, 6.0, -9.0, 1.0, 9.0, 8.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(-5.0, 7.0, -9.0, -5.0, 6.0, -4.0, -5.0, -4.0, -9.0, -8.0, 9.0, 4.0, 2.0, 5.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	var[0][0][1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	var[0][1][0] = (mat4(7.0, 9.0, -3.0, -6.0, 3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0));
	var[0][1][1] = (mat4(3.0, -3.0, 1.0, 4.0, -1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0));
	var[0][2][0] = (mat4(4.0, -5.0, 0.0, -7.0, 5.0, 6.0, -9.0, 8.0, -2.0, -3.0, -2.0, -2.0, -4.0, -1.0, -7.0, -8.0));
	var[0][2][1] = (mat4(6.0, 2.0, 6.0, -7.0, 2.0, 4.0, -8.0, -9.0, -9.0, -5.0, -7.0, 1.0, 9.0, 1.0, 5.0, -3.0));
	var[0][3][0] = (mat4(-6.0, -4.0, 9.0, 8.0, 6.0, 8.0, -4.0, 1.0, -6.0, 4.0, -2.0, 2.0, -3.0, -4.0, 3.0, -5.0));
	var[0][3][1] = (mat4(2.0, 9.0, -7.0, -6.0, 2.0, -1.0, 9.0, 2.0, 9.0, -4.0, 4.0, -1.0, -3.0, -4.0, 0.0, -3.0));
	var[1][0][0] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
	var[1][0][1] = (mat4(-3.0, 1.0, -5.0, 0.0, -1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0));
	var[1][1][0] = (mat4(-6.0, -5.0, 3.0, -8.0, -4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0));
	var[1][1][1] = (mat4(-5.0, 2.0, 1.0, 1.0, -7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0));
	var[1][2][0] = (mat4(7.0, 8.0, 7.0, -3.0, 0.0, -2.0, -3.0, -6.0, -6.0, -6.0, 6.0, -6.0, -6.0, 9.0, 8.0, -5.0));
	var[1][2][1] = (mat4(4.0, -4.0, 4.0, 7.0, -4.0, 5.0, -8.0, 5.0, -8.0, 9.0, 3.0, 9.0, 3.0, -3.0, -8.0, -6.0));
	var[1][3][0] = (mat4(8.0, -4.0, -1.0, -5.0, 9.0, -8.0, -2.0, -9.0, -5.0, -3.0, 0.0, 0.0, 1.0, 1.0, -4.0, 4.0));
	var[1][3][1] = (mat4(-9.0, -9.0, 4.0, 8.0, 2.0, -6.0, -1.0, 5.0, -4.0, -6.0, -8.0, 7.0, 4.0, -2.0, -4.0, -1.0));
	var[2][0][0] = (mat4(4.0, 7.0, 2.0, 2.0, 5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0));
	var[2][0][1] = (mat4(-6.0, 0.0, -6.0, 3.0, -1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0));
	var[2][1][0] = (mat4(-4.0, -3.0, 2.0, -2.0, 4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0));
	var[2][1][1] = (mat4(6.0, -9.0, 7.0, 7.0, -1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0));
	var[2][2][0] = (mat4(2.0, 4.0, -9.0, 6.0, 4.0, -1.0, 2.0, 1.0, 2.0, 6.0, -9.0, -1.0, -5.0, -1.0, -7.0, 9.0));
	var[2][2][1] = (mat4(6.0, -6.0, -2.0, -7.0, 6.0, 8.0, -3.0, -9.0, 7.0, 6.0, -5.0, 9.0, -5.0, 0.0, -9.0, 3.0));
	var[2][3][0] = (mat4(1.0, 7.0, 5.0, 2.0, 5.0, 9.0, 3.0, -9.0, -6.0, -4.0, 4.0, 7.0, 6.0, -1.0, -7.0, -5.0));
	var[2][3][1] = (mat4(0.0, 9.0, 4.0, 7.0, 3.0, -1.0, 9.0, -1.0, 3.0, 3.0, 5.0, 7.0, 7.0, -8.0, -9.0, -5.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0][0][0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-6.0, 9.0, 9.0, -2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(8.0, -6.0, -2.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(8.0, -7.0, 1.0, -9.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(3.0, 8.0, -5.0, -1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(5.0, -9.0, 5.0, 6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(4.0, 1.0, -5.0, 7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(-2.0, -1.0, 3.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-2.0, -9.0, -1.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-5.0, -9.0, -3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(9.0, -5.0, 0.0, 0.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(-8.0, -1.0, 3.0, -7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(6.0, 2.0, -9.0, 9.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(4.0, -5.0, 0.0, 0.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(5.0, 8.0, 1.0, -7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(0.0, 9.0, -1.0, -8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-9.0, -1.0, -9.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-6.0, -1.0, 7.0, -5.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(-7.0, 6.0, -9.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(-7.0, 1.0, 7.0, 2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(6.0, 8.0, 9.0, 5.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(-6.0, -1.0, -9.0, 3.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	var[0][0][1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	var[0][1][0] = (mat2x3(-4.0, -3.0, -6.0, -1.0, -5.0, 7.0));
	var[0][1][1] = (mat2x3(1.0, 9.0, -7.0, 3.0, 3.0, 1.0));
	var[0][2][0] = (mat2x3(-1.0, -7.0, 4.0, 3.0, 8.0, -7.0));
	var[0][2][1] = (mat2x3(-1.0, -2.0, 2.0, 6.0, -5.0, 4.0));
	var[0][3][0] = (mat2x3(-9.0, -9.0, 0.0, 3.0, 6.0, -8.0));
	var[0][3][1] = (mat2x3(-7.0, -4.0, 3.0, -6.0, -7.0, -9.0));
	var[1][0][0] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
	var[1][0][1] = (mat2x3(6.0, 9.0, 2.0, -3.0, 0.0, 5.0));
	var[1][1][0] = (mat2x3(-4.0, -9.0, 4.0, -1.0, -4.0, 1.0));
	var[1][1][1] = (mat2x3(-7.0, 0.0, -4.0, -6.0, -1.0, -1.0));
	var[1][2][0] = (mat2x3(-8.0, 0.0, -4.0, 7.0, -5.0, -1.0));
	var[1][2][1] = (mat2x3(4.0, -6.0, -1.0, -4.0, 7.0, 8.0));
	var[1][3][0] = (mat2x3(-9.0, 8.0, -8.0, 7.0, 8.0, -9.0));
	var[1][3][1] = (mat2x3(0.0, -8.0, -9.0, 3.0, 8.0, -4.0));
	var[2][0][0] = (mat2x3(-9.0, 6.0, -3.0, 9.0, -7.0, 2.0));
	var[2][0][1] = (mat2x3(8.0, -3.0, 7.0, -9.0, 7.0, -1.0));
	var[2][1][0] = (mat2x3(5.0, -5.0, 0.0, -6.0, -9.0, -6.0));
	var[2][1][1] = (mat2x3(-2.0, -1.0, -6.0, -6.0, 3.0, -3.0));
	var[2][2][0] = (mat2x3(-1.0, 4.0, -9.0, -3.0, -5.0, 8.0));
	var[2][2][1] = (mat2x3(5.0, -4.0, -4.0, 8.0, 6.0, 4.0));
	var[2][3][0] = (mat2x3(6.0, -9.0, -1.0, 5.0, 7.0, -4.0));
	var[2][3][1] = (mat2x3(0.0, -7.0, -9.0, -2.0, -6.0, -1.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	highp mat3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(-2.0, -1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-4.0, 9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(1.0, 8.0, -5.0, -5.0, -8.0, -4.0, -7.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(-5.0, -8.0, 6.0, 4.0, -3.0, 9.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(2.0, -4.0, -2.0, -7.0, 2.0, -2.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(3.0, -2.0, 5.0, -3.0, 7.0, -5.0, 2.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(3.0, 7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(6.0, -4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(0.0, 5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(-2.0, 7.0, -4.0, 4.0, -4.0, 1.0, 6.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(2.0, -6.0, 4.0, -6.0, 8.0, 1.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(2.0, 2.0, 8.0, -3.0, -7.0, -9.0, -7.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(-6.0, 7.0, -4.0, 4.0, 5.0, 3.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(4.0, 9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-9.0, -9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-3.0, -7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(8.0, 4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(6.0, 5.0, 5.0, -1.0, -9.0, -7.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(0.0, -7.0, 0.0, -4.0, 1.0, -7.0, 1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(5.0, -9.0, 6.0, -4.0, -2.0, -4.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(0.0, -9.0, 2.0, -6.0, 6.0, 7.0, 8.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(2.0, -4.0, 9.0));
	var[0][0][0][1] = (vec3(-4.0, 2.0, 5.0));
	var[0][0][0][2] = (vec3(5.0, -9.0, -5.0));
	var[0][0][1][0] = (vec3(3.0, 1.0, 8.0));
	var[0][0][1][1] = (vec3(6.0, 9.0, -8.0));
	var[0][0][1][2] = (vec3(-1.0, 5.0, 1.0));
	var[0][1][0][0] = (vec3(9.0, -3.0, -9.0));
	var[0][1][0][1] = (vec3(6.0, -1.0, -6.0));
	var[0][1][0][2] = (vec3(6.0, 2.0, -5.0));
	var[0][1][1][0] = (vec3(-1.0, -2.0, 2.0));
	var[0][1][1][1] = (vec3(9.0, 1.0, -8.0));
	var[0][1][1][2] = (vec3(6.0, -1.0, 7.0));
	var[0][2][0][0] = (vec3(-9.0, -8.0, 2.0));
	var[0][2][0][1] = (vec3(-6.0, 9.0, -7.0));
	var[0][2][0][2] = (vec3(9.0, 6.0, 1.0));
	var[0][2][1][0] = (vec3(-4.0, 8.0, -7.0));
	var[0][2][1][1] = (vec3(1.0, 0.0, 4.0));
	var[0][2][1][2] = (vec3(-6.0, -3.0, 3.0));
	var[0][3][0][0] = (vec3(-5.0, 7.0, 5.0));
	var[0][3][0][1] = (vec3(-2.0, -2.0, 8.0));
	var[0][3][0][2] = (vec3(-3.0, 1.0, 7.0));
	var[0][3][1][0] = (vec3(-9.0, 8.0, 7.0));
	var[0][3][1][1] = (vec3(2.0, 2.0, -5.0));
	var[0][3][1][2] = (vec3(-8.0, -5.0, 6.0));
	var[1][0][0][0] = (vec3(6.0, -5.0, -4.0));
	var[1][0][0][1] = (vec3(-8.0, -8.0, -2.0));
	var[1][0][0][2] = (vec3(9.0, -4.0, 4.0));
	var[1][0][1][0] = (vec3(4.0, -1.0, 5.0));
	var[1][0][1][1] = (vec3(-1.0, 0.0, 9.0));
	var[1][0][1][2] = (vec3(7.0, 7.0, 5.0));
	var[1][1][0][0] = (vec3(4.0, 2.0, -8.0));
	var[1][1][0][1] = (vec3(0.0, 3.0, 9.0));
	var[1][1][0][2] = (vec3(9.0, -8.0, -4.0));
	var[1][1][1][0] = (vec3(-8.0, 3.0, 4.0));
	var[1][1][1][1] = (vec3(-4.0, 4.0, 1.0));
	var[1][1][1][2] = (vec3(0.0, 4.0, 5.0));
	var[1][2][0][0] = (vec3(-5.0, -6.0, 5.0));
	var[1][2][0][1] = (vec3(4.0, 3.0, -2.0));
	var[1][2][0][2] = (vec3(-6.0, -4.0, -1.0));
	var[1][2][1][0] = (vec3(4.0, 4.0, -6.0));
	var[1][2][1][1] = (vec3(0.0, 2.0, -5.0));
	var[1][2][1][2] = (vec3(5.0, 8.0, -2.0));
	var[1][3][0][0] = (vec3(4.0, 1.0, 9.0));
	var[1][3][0][1] = (vec3(5.0, -6.0, 7.0));
	var[1][3][0][2] = (vec3(-7.0, -2.0, -6.0));
	var[1][3][1][0] = (vec3(0.0, -9.0, 7.0));
	var[1][3][1][1] = (vec3(-2.0, 0.0, 5.0));
	var[1][3][1][2] = (vec3(8.0, 8.0, -1.0));
	var[2][0][0][0] = (vec3(8.0, -6.0, -1.0));
	var[2][0][0][1] = (vec3(-1.0, -2.0, -5.0));
	var[2][0][0][2] = (vec3(-5.0, 6.0, -3.0));
	var[2][0][1][0] = (vec3(-4.0, -6.0, 2.0));
	var[2][0][1][1] = (vec3(3.0, -1.0, 2.0));
	var[2][0][1][2] = (vec3(-3.0, 4.0, 1.0));
	var[2][1][0][0] = (vec3(-9.0, -4.0, 2.0));
	var[2][1][0][1] = (vec3(-6.0, 8.0, 3.0));
	var[2][1][0][2] = (vec3(2.0, 0.0, -1.0));
	var[2][1][1][0] = (vec3(7.0, 1.0, 3.0));
	var[2][1][1][1] = (vec3(5.0, 1.0, -6.0));
	var[2][1][1][2] = (vec3(2.0, -5.0, 4.0));
	var[2][2][0][0] = (vec3(3.0, -1.0, 7.0));
	var[2][2][0][1] = (vec3(-9.0, -9.0, -8.0));
	var[2][2][0][2] = (vec3(9.0, -9.0, -5.0));
	var[2][2][1][0] = (vec3(1.0, -2.0, 1.0));
	var[2][2][1][1] = (vec3(-8.0, -4.0, -3.0));
	var[2][2][1][2] = (vec3(3.0, -4.0, -3.0));
	var[2][3][0][0] = (vec3(-4.0, 3.0, 5.0));
	var[2][3][0][1] = (vec3(-9.0, 8.0, -7.0));
	var[2][3][0][2] = (vec3(7.0, -3.0, 4.0));
	var[2][3][1][0] = (vec3(-6.0, 3.0, 6.0));
	var[2][3][1][1] = (vec3(-9.0, 9.0, 3.0));
	var[2][3][1][2] = (vec3(8.0, 8.0, -2.0));
}
#version 450
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
	highp mat3x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(-5.0, -6.0, -9.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(1.0, 6.0, 2.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(9.0, 7.0, 3.0, 7.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(-5.0, -7.0, 8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(-4.0, -2.0, -2.0, 0.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(5.0, -5.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(2.0, -4.0, -7.0, 4.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(-8.0, 0.0, -2.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(7.0, -4.0, -4.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(-8.0, 6.0, 4.0, 2.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(-6.0, 1.0, 9.0, 1.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(3.0, -3.0, 9.0, -6.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	var[0][0][1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	var[0][1][0] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	var[0][1][1] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	var[0][2][0] = (mat3x2(7.0, -4.0, 6.0, -9.0, -2.0, -7.0));
	var[0][2][1] = (mat3x2(-2.0, -2.0, -1.0, 7.0, 3.0, -9.0));
	var[0][3][0] = (mat3x2(-3.0, 2.0, -3.0, -9.0, 1.0, -7.0));
	var[0][3][1] = (mat3x2(6.0, -2.0, 9.0, -6.0, 7.0, 1.0));
	var[1][0][0] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	var[1][0][1] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	var[1][1][0] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	var[1][1][1] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	var[1][2][0] = (mat3x2(6.0, -8.0, 1.0, -2.0, -2.0, 3.0));
	var[1][2][1] = (mat3x2(-9.0, 8.0, 3.0, 2.0, 3.0, 7.0));
	var[1][3][0] = (mat3x2(9.0, 6.0, -3.0, 1.0, -1.0, 0.0));
	var[1][3][1] = (mat3x2(3.0, -9.0, 6.0, 0.0, -2.0, 4.0));
	var[2][0][0] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	var[2][0][1] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	var[2][1][0] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	var[2][1][1] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
	var[2][2][0] = (mat3x2(-9.0, 3.0, -6.0, -9.0, -4.0, -8.0));
	var[2][2][1] = (mat3x2(5.0, 8.0, 8.0, -6.0, -8.0, -4.0));
	var[2][3][0] = (mat3x2(9.0, 1.0, 5.0, -7.0, 2.0, 1.0));
	var[2][3][1] = (mat3x2(8.0, 8.0, 9.0, 6.0, -1.0, 4.0));
}
#version 450
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
	highp mat2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(0.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-6.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(-4.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(-4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(-7.0, 6.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-1.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-9.0, -1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-9.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(-2.0, -6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(3.0, 4.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(-4.0, 9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(9.0, -2.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(4.0, 1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(7.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(4.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(8.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(-5.0, -9.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(-2.0, -8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(-3.0, 0.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(0.0, 1.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(7.0, -3.0));
	var[0][0][0][1] = (vec2(-2.0, 4.0));
	var[0][0][1][0] = (vec2(1.0, -3.0));
	var[0][0][1][1] = (vec2(2.0, -4.0));
	var[0][1][0][0] = (vec2(1.0, 5.0));
	var[0][1][0][1] = (vec2(9.0, -6.0));
	var[0][1][1][0] = (vec2(-7.0, 5.0));
	var[0][1][1][1] = (vec2(7.0, 4.0));
	var[0][2][0][0] = (vec2(-5.0, 8.0));
	var[0][2][0][1] = (vec2(3.0, 1.0));
	var[0][2][1][0] = (vec2(-9.0, 7.0));
	var[0][2][1][1] = (vec2(7.0, 1.0));
	var[0][3][0][0] = (vec2(-8.0, 7.0));
	var[0][3][0][1] = (vec2(0.0, 2.0));
	var[0][3][1][0] = (vec2(-7.0, -7.0));
	var[0][3][1][1] = (vec2(5.0, -3.0));
	var[1][0][0][0] = (vec2(-1.0, 1.0));
	var[1][0][0][1] = (vec2(-4.0, 3.0));
	var[1][0][1][0] = (vec2(7.0, -7.0));
	var[1][0][1][1] = (vec2(2.0, 5.0));
	var[1][1][0][0] = (vec2(7.0, -9.0));
	var[1][1][0][1] = (vec2(0.0, 6.0));
	var[1][1][1][0] = (vec2(-1.0, -7.0));
	var[1][1][1][1] = (vec2(-8.0, 4.0));
	var[1][2][0][0] = (vec2(-3.0, -9.0));
	var[1][2][0][1] = (vec2(-7.0, 1.0));
	var[1][2][1][0] = (vec2(-7.0, 6.0));
	var[1][2][1][1] = (vec2(2.0, -5.0));
	var[1][3][0][0] = (vec2(-1.0, -1.0));
	var[1][3][0][1] = (vec2(1.0, 1.0));
	var[1][3][1][0] = (vec2(7.0, 1.0));
	var[1][3][1][1] = (vec2(2.0, -8.0));
	var[2][0][0][0] = (vec2(-8.0, 4.0));
	var[2][0][0][1] = (vec2(8.0, 1.0));
	var[2][0][1][0] = (vec2(4.0, 6.0));
	var[2][0][1][1] = (vec2(-9.0, 9.0));
	var[2][1][0][0] = (vec2(5.0, 6.0));
	var[2][1][0][1] = (vec2(-7.0, 7.0));
	var[2][1][1][0] = (vec2(-1.0, -5.0));
	var[2][1][1][1] = (vec2(9.0, -7.0));
	var[2][2][0][0] = (vec2(6.0, -3.0));
	var[2][2][0][1] = (vec2(-5.0, -6.0));
	var[2][2][1][0] = (vec2(-3.0, 7.0));
	var[2][2][1][1] = (vec2(9.0, 6.0));
	var[2][3][0][0] = (vec2(-1.0, 1.0));
	var[2][3][0][1] = (vec2(2.0, -4.0));
	var[2][3][1][0] = (vec2(-9.0, -4.0));
	var[2][3][1][1] = (vec2(7.0, 0.0));
}
#version 450
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
	highp mat3x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(8.0, -3.0, 9.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(2.0, 4.0, 5.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(-2.0, -1.0, 1.0, 0.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(-1.0, -3.0, 9.0, 9.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(1.0, -7.0, 3.0, -9.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(-9.0, 8.0, -7.0, 5.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(-7.0, 6.0, -9.0, 5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(0.0, 1.0, 8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-4.0, 8.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(6.0, -9.0, 0.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(-9.0, 7.0, 0.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(8.0, -4.0, 2.0, 5.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(-2.0, -3.0, -5.0, 2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(8.0, -3.0, -5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(-1.0, 3.0, 2.0, -6.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-5.0, -5.0, 2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-7.0, -1.0, -4.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(-7.0, -4.0, -4.0, 2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(-7.0, -7.0, -2.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(-4.0, 8.0, -4.0, -9.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(-7.0, -8.0, -2.0, -7.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	var[0][0][1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	var[0][1][0] = (mat3x2(0.0, 0.0, 2.0, -7.0, 5.0, 1.0));
	var[0][1][1] = (mat3x2(6.0, 0.0, -1.0, -4.0, -5.0, -3.0));
	var[0][2][0] = (mat3x2(9.0, 9.0, -7.0, 5.0, 9.0, -1.0));
	var[0][2][1] = (mat3x2(1.0, 7.0, 8.0, 8.0, -1.0, 5.0));
	var[0][3][0] = (mat3x2(1.0, -2.0, -7.0, 8.0, -1.0, 1.0));
	var[0][3][1] = (mat3x2(2.0, -3.0, 1.0, -9.0, -8.0, 9.0));
	var[1][0][0] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
	var[1][0][1] = (mat3x2(-4.0, -9.0, 4.0, 7.0, 9.0, 7.0));
	var[1][1][0] = (mat3x2(-8.0, 4.0, -1.0, 9.0, -1.0, 7.0));
	var[1][1][1] = (mat3x2(-8.0, -3.0, 6.0, 0.0, 4.0, 4.0));
	var[1][2][0] = (mat3x2(-7.0, -7.0, 7.0, -7.0, -4.0, 0.0));
	var[1][2][1] = (mat3x2(-4.0, -8.0, -1.0, 6.0, -9.0, 7.0));
	var[1][3][0] = (mat3x2(-7.0, 8.0, -6.0, -5.0, -8.0, 8.0));
	var[1][3][1] = (mat3x2(-5.0, 1.0, 4.0, -7.0, -6.0, -8.0));
	var[2][0][0] = (mat3x2(9.0, -1.0, -5.0, 6.0, -2.0, 6.0));
	var[2][0][1] = (mat3x2(-6.0, -8.0, 1.0, 5.0, 7.0, 1.0));
	var[2][1][0] = (mat3x2(-8.0, 8.0, -9.0, -4.0, 5.0, 5.0));
	var[2][1][1] = (mat3x2(4.0, 7.0, -3.0, 2.0, 8.0, 5.0));
	var[2][2][0] = (mat3x2(-9.0, 2.0, 5.0, -2.0, 2.0, -7.0));
	var[2][2][1] = (mat3x2(-7.0, 2.0, 5.0, 0.0, 1.0, -6.0));
	var[2][3][0] = (mat3x2(5.0, -9.0, 2.0, 0.0, -8.0, -6.0));
	var[2][3][1] = (mat3x2(8.0, 7.0, 3.0, 8.0, -8.0, 5.0));
}
#version 450
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
layout(std140, binding = 1) buffer Block
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-6, -4, 4)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(4.0, -4.0, 8.0, -2.0, -3.0, -2.0, -1.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-8.0, -7.0, 7.0, -2.0, -2.0, -4.0, -9.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-1.0, -4.0, 7.0, -8.0, 2.0, -6.0, -5.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-1.0, -7.0, 9.0, 0.0, -9.0, 3.0, -2.0, -2.0, -8.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(1.0, -6.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(1.0, 8.0, -7.0, 4.0, 2.0, 4.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(2, 3, -4)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(1.0, 1.0, -3.0, -4.0, 4.0, 3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(4.0, -4.0, 6.0, -6.0, 6.0, 4.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(-3.0, -6.0, -8.0, -8.0, 9.0, -7.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(7.0, 3.0, 9.0, 6.0, -6.0, 2.0, -4.0, 7.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(-7.0, 2.0, -5.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(5, -9, 1)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-2.0, -1.0, -1.0, 7.0, -6.0, 8.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-1.0, -5.0, -1.0, -3.0, 5.0, -6.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-8.0, 8.0, -5.0, -6.0, -4.0, -7.0, -4.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(1.0, -4.0, -3.0, -2.0, 2.0, 1.0, 2.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(4.0, 2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(7.0, 2.0, 6.0, 4.0, -1.0, -7.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(-4, 1, 6)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(1.0, -8.0, -1.0, -5.0, 3.0, 6.0, 3.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(1.0, 1.0, 3.0, -1.0, 6.0, 1.0, 5.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(4.0, -8.0, 4.0, -8.0, -2.0, -3.0, -9.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(-5.0, -4.0, 9.0, 7.0, -6.0, -7.0, -5.0, 1.0, 0.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(1.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-7, 7, -7)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-4.0, -8.0, 5.0, -3.0, 7.0, -9.0, 9.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-8.0, 8.0, 0.0, -2.0, -4.0, 2.0, 3.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(2.0, 6.0, 4.0, 6.0, -9.0, 5.0, 1.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-6.0, -5.0, -1.0, 5.0, -7.0, -2.0, 4.0, -8.0, -7.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-1.0, 2.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(-2.0, 0.0, -7.0, 0.0, -8.0, 0.0, 8.0, 8.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(5, 6, -2)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(6.0, 4.0, -1.0, 2.0, -2.0, 1.0, 9.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(-2.0, 7.0, 1.0, 4.0, -3.0, -6.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(-6.0, 5.0, -4.0, -5.0, 6.0, 1.0, 9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(8.0, -2.0, 2.0, 6.0, -7.0, 6.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(-3.0, -6.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a = (mat3(-5.0, -5.0, 6.0, -7.0, 5.0, 1.0, -5.0, 1.0, -5.0));
	block[0].t.b.a = (ivec3(6, -3, 0));
	block[0].t.b.b[0] = (mat3(6.0, -2.0, -6.0, -5.0, -6.0, -1.0, 6.0, 8.0, -7.0));
	block[0].t.b.b[1] = (mat3(-9.0, 0.0, 2.0, 1.0, 9.0, -3.0, 5.0, 3.0, -8.0));
	block[0].t.b.b[2] = (mat3(3.0, 0.0, 7.0, 6.0, 3.0, 7.0, -4.0, -5.0, -9.0));
	block[0].t.b.b[3] = (mat3(-2.0, 1.0, 3.0, -3.0, -3.0, 1.0, -4.0, 0.0, 5.0));
	block[0].t.b.c = (vec4(-9.0, 1.0, -4.0, -7.0));
	block[0].u = (3u);
	block[1].t.a = (mat3(-3.0, -1.0, 3.0, 1.0, 1.0, -8.0, -1.0, 9.0, -9.0));
	block[1].t.b.a = (ivec3(-9, 1, -4));
	block[1].t.b.b[0] = (mat3(-8.0, -9.0, 7.0, 1.0, 5.0, 4.0, -2.0, -9.0, 2.0));
	block[1].t.b.b[1] = (mat3(-6.0, -2.0, -8.0, 0.0, -1.0, -4.0, -9.0, 3.0, 7.0));
	block[1].t.b.b[2] = (mat3(-8.0, -9.0, -1.0, -3.0, 5.0, -1.0, -8.0, 7.0, -5.0));
	block[1].t.b.b[3] = (mat3(4.0, -4.0, -1.0, -4.0, 8.0, 6.0, 6.0, 1.0, -8.0));
	block[1].t.b.c = (vec4(3.0, -3.0, -1.0, -8.0));
	block[1].u = (3u);
	block[2].t.a = (mat3(-9.0, 9.0, 3.0, -6.0, 3.0, -8.0, -3.0, 3.0, 4.0));
	block[2].t.b.a = (ivec3(9, 7, -7));
	block[2].t.b.b[0] = (mat3(-4.0, 0.0, 6.0, -2.0, 6.0, 5.0, 7.0, -1.0, 9.0));
	block[2].t.b.b[1] = (mat3(7.0, 3.0, 0.0, -3.0, 0.0, 1.0, -8.0, -7.0, 3.0));
	block[2].t.b.b[2] = (mat3(-5.0, 9.0, 9.0, 2.0, 7.0, 4.0, 6.0, 5.0, -4.0));
	block[2].t.b.b[3] = (mat3(-9.0, 1.0, -4.0, -1.0, 0.0, 9.0, -2.0, 6.0, 8.0));
	block[2].t.b.c = (vec4(5.0, 4.0, 3.0, -9.0));
	block[2].u = (9u);
}
#version 450
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
} block[3];

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

layout(scalar, column_major, binding = 1) buffer Block
{
	float padding;
	highp mat4x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -7.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[3][1], -9.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(3.0, -9.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-1.0, 6.0)) && allOk;
	allOk = compare_vec2(block[0].var[3], vec2(-3.0, -9.0)) && allOk;
	allOk = compare_float((block[1].padding), 6.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 1.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(8.0, 9.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec2(block[1].var[3], vec2(4.0, 1.0)) && allOk;
	allOk = compare_float((block[2].padding), -1.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -9.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-5.0, 5.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-9.0, -7.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(-2.0, -2.0)) && allOk;
	allOk = compare_vec2(block[2].var[3], vec2(-2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (6.0);
	block[0].var[0] = (vec2(-2.0, 2.0));
	block[0].var[1] = (vec2(8.0, -5.0));
	block[0].var[2] = (vec2(3.0, -1.0));
	block[0].var[3] = (vec2(-7.0, 4.0));
	block[1].padding = (2.0);
	block[1].var[0] = (vec2(-4.0, 8.0));
	block[1].var[1] = (vec2(3.0, 8.0));
	block[1].var[2] = (vec2(-1.0, 6.0));
	block[1].var[3] = (vec2(-8.0, 2.0));
	block[2].padding = (-5.0);
	block[2].var[0] = (vec2(5.0, -4.0));
	block[2].var[1] = (vec2(-9.0, 0.0));
	block[2].var[2] = (vec2(4.0, 8.0));
	block[2].var[3] = (vec2(2.0, -3.0));
}
#version 450
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
	u16vec3 var;
} block[3];

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

layout(std140, binding = 1) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
} blockA;
layout(std140, binding = 2) buffer BlockB
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c;
	bool d;
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
	allOk = compare_float((blockA.a), 4.0) && allOk;
	allOk = compare_float(blockA.c[0][0], 1.0) && allOk;
	allOk = compare_float(blockA.c[0][1], 2.0) && allOk;
	allOk = compare_float(blockA.c[1][0], 9.0) && allOk;
	allOk = compare_float(blockA.c[1][1], -7.0) && allOk;
	allOk = compare_vec2(blockA.c[0], vec2(1.0, 2.0)) && allOk;
	allOk = compare_vec2(blockA.c[1], vec2(9.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-7, 5)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-6.0);
	blockB.a[0] = (vec3(0.0, 7.0, 2.0));
	blockB.a[1] = (vec3(7.0, -7.0, 5.0));
	blockB.a[2] = (vec3(1.0, -7.0, -6.0));
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
} blockA[3];
layout(scalar, binding = 2) buffer BlockB
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
	allOk = compare_float((blockA[0].a), -7.0) && allOk;
	allOk = compare_float((blockA[1].a), -2.0) && allOk;
	allOk = compare_float((blockA[2].a), 2.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(2.0, 7.0, -6.0, -8.0, 5.0, 3.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(-3, 9)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(-7, -4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(-1, 9)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(-8.0, -5.0, 9.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(-2.0, 6.0, -9.0, 1.0, -1.0, 2.0, 3.0, 8.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(6, 7)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(5, -6)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(-3, -6)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(9, -4)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(5.0, -6.0, 0.0, -9.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_uint((blockB[2].b.a), 2u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(6.0, -6.0, -9.0, -4.0, -1.0, 1.0, 1.0, -2.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(5, -9)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(1, -7)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(7, 2)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(2.0, -2.0, 8.0, 5.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-5.0);
	blockA[0].b.a = (mat3(2.0, -1.0, -4.0, 1.0, 2.0, -2.0, 8.0, 7.0, 2.0));
	blockA[0].b.b[0] = (ivec2(-4, 3));
	blockA[0].b.b[1] = (ivec2(-4, 6));
	blockA[0].b.b[2] = (ivec2(7, -1));
	blockA[0].b.b[3] = (ivec2(-6, -4));
	blockA[0].b.c = (vec4(-8.0, -2.0, 7.0, -4.0));
	blockA[1].a = (-5.0);
	blockA[1].b.a = (mat3(-2.0, -9.0, -6.0, 4.0, 2.0, 2.0, -6.0, -5.0, 3.0));
	blockA[1].b.b[0] = (ivec2(9, 8));
	blockA[1].b.b[1] = (ivec2(-6, -2));
	blockA[1].b.b[2] = (ivec2(-5, 2));
	blockA[1].b.b[3] = (ivec2(8, 8));
	blockA[1].b.c = (vec4(-8.0, -2.0, 7.0, -9.0));
	blockA[2].a = (1.0);
	blockA[2].b.a = (mat3(7.0, 7.0, -2.0, -3.0, -4.0, -7.0, -7.0, -1.0, 5.0));
	blockA[2].b.b[0] = (ivec2(-4, -9));
	blockA[2].b.b[1] = (ivec2(-7, -6));
	blockA[2].b.b[2] = (ivec2(-3, 8));
	blockA[2].b.b[3] = (ivec2(-5, 0));
	blockA[2].b.c = (vec4(5.0, 4.0, -2.0, -1.0));
	blockB[0].a = (mat2(-7.0, 3.0, -4.0, -3.0));
	blockB[0].b.a = (8u);
	blockB[0].b.b.a = (mat3(4.0, 6.0, 8.0, -5.0, -9.0, -7.0, -1.0, -4.0, 3.0));
	blockB[0].b.b.b[0] = (ivec2(-1, -1));
	blockB[0].b.b.b[1] = (ivec2(3, -7));
	blockB[0].b.b.b[2] = (ivec2(-6, -3));
	blockB[0].b.b.b[3] = (ivec2(2, 3));
	blockB[0].b.b.c = (vec4(7.0, 8.0, -3.0, 6.0));
	blockB[0].b.c = (bvec4(false, false, false, false));
	blockB[0].d = (false);
	blockB[1].a = (mat2(-7.0, -9.0, -6.0, 9.0));
	blockB[1].b.a = (0u);
	blockB[1].b.b.a = (mat3(4.0, 8.0, -9.0, -7.0, -3.0, -2.0, -7.0, -8.0, 0.0));
	blockB[1].b.b.b[0] = (ivec2(4, -5));
	blockB[1].b.b.b[1] = (ivec2(-9, -2));
	blockB[1].b.b.b[2] = (ivec2(-8, -5));
	blockB[1].b.b.b[3] = (ivec2(-9, -8));
	blockB[1].b.b.c = (vec4(1.0, -8.0, -9.0, 5.0));
	blockB[1].b.c = (bvec4(false, false, false, false));
	blockB[1].d = (false);
	blockB[2].a = (mat2(8.0, -4.0, -4.0, 3.0));
	blockB[2].b.a = (1u);
	blockB[2].b.b.a = (mat3(6.0, -9.0, 2.0, 7.0, -8.0, 5.0, 7.0, -1.0, -5.0));
	blockB[2].b.b.b[0] = (ivec2(-4, -5));
	blockB[2].b.b.b[1] = (ivec2(7, -2));
	blockB[2].b.b.b[2] = (ivec2(8, -7));
	blockB[2].b.b.b[3] = (ivec2(5, 6));
	blockB[2].b.b.c = (vec4(-4.0, 0.0, 5.0, -1.0));
	blockB[2].b.c = (bvec4(false, false, true, false));
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

layout(std430, column_major, binding = 1) buffer BlockB
{
	mediump mat3x2 a;
	mediump mat4 b;
	highp uint c;
	lowp vec4 d;
	lowp vec4 e[];
};
layout(std140, binding = 2) buffer BlockC
{
	lowp mat3 f;
	mediump mat4 g;
	highp uvec2 h;
	lowp mat4 i;
	mediump mat2 j[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(b, mat4(7.0, -1.0, -8.0, 2.0, 8.0, -2.0, -2.0, 4.0, -7.0, -2.0, -1.0, 1.0, -1.0, -6.0, 3.0, -7.0)) && allOk;
	allOk = compare_vec4((e[0]), vec4(8.0, -2.0, 8.0, 0.0)) && allOk;
	allOk = compare_vec4((e[1]), vec4(2.0, 2.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec4((e[2]), vec4(-6.0, 7.0, -7.0, 9.0)) && allOk;
	allOk = compare_vec4((e[3]), vec4(-2.0, 7.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(blockC.f, mat3(-8.0, -8.0, 0.0, 6.0, 7.0, 2.0, -4.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4(blockC.g, mat4(2.0, -3.0, 6.0, 1.0, 7.0, 8.0, -4.0, -7.0, 9.0, 8.0, 4.0, -3.0, 0.0, -9.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x2(6.0, 3.0, -9.0, 0.0, 9.0, 2.0));
	b = (mat4(-6.0, 6.0, -6.0, 3.0, 5.0, -8.0, -7.0, -8.0, 3.0, -6.0, -9.0, 9.0, -9.0, 9.0, 8.0, -1.0));
	blockC.g = (mat4(-3.0, -2.0, 7.0, -9.0, 3.0, 8.0, 2.0, 4.0, -8.0, -4.0, -3.0, -8.0, 8.0, -8.0, 3.0, -1.0));
	blockC.j[0] = (mat2(1.0, 7.0, -5.0, 0.0));
	blockC.j[1] = (mat2(-1.0, 9.0, 7.0, 1.0));
	blockC.j[2] = (mat2(-6.0, -6.0, -8.0, 2.0));
	blockC.j[3] = (mat2(7.0, -8.0, -1.0, 5.0));
	blockC.j[4] = (mat2(4.0, -2.0, -6.0, -1.0));
}
#version 450
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
	lowp mat4x2 a;
	lowp mat2x3 b;
	mediump float c;
	bvec3 d;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp uint e;
	highp mat3x2 f[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(b, mat2x3(-6.0, 5.0, -6.0, 4.0, 6.0, 1.0)) && allOk;
	allOk = compare_float((c), 8.0) && allOk;
	allOk = compare_mat3x2(blockC.f[0], mat3x2(5.0, -9.0, -8.0, 6.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockC.f[1], mat3x2(-7.0, -8.0, 9.0, -9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockC.f[2], mat3x2(3.0, 6.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockC.f[3], mat3x2(6.0, 7.0, 5.0, 8.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockC.f[4], mat3x2(-1.0, -8.0, 9.0, 7.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockC.f[5], mat3x2(-1.0, 1.0, 7.0, -7.0, -7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (-2.0);
	blockC.f[0] = (mat3x2(-5.0, 4.0, 9.0, -7.0, -6.0, -2.0));
	blockC.f[1] = (mat3x2(-4.0, 8.0, -6.0, -4.0, 6.0, -3.0));
	blockC.f[2] = (mat3x2(-6.0, 8.0, -6.0, -7.0, -1.0, 4.0));
	blockC.f[3] = (mat3x2(-7.0, 2.0, -1.0, 4.0, -6.0, 5.0));
	blockC.f[4] = (mat3x2(-5.0, -1.0, -2.0, -3.0, -7.0, 8.0));
	blockC.f[5] = (mat3x2(-6.0, 7.0, 9.0, 8.0, -3.0, -4.0));
}
#version 450
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
	bool b;
	lowp mat3x4 c;
	highp uvec2 d[];
} blockB[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[0].a), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bool((blockB[0].b), true) && allOk;
	allOk = compare_mat3x4(blockB[0].c, mat3x4(7.0, 5.0, 1.0, -2.0, 6.0, 3.0, -6.0, -9.0, -9.0, 3.0, 8.0, 8.0)) && allOk;
	allOk = compare_bvec4((blockB[1].a), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bool((blockB[1].b), false) && allOk;
	allOk = compare_mat3x4(blockB[1].c, mat3x4(1.0, 1.0, -4.0, -5.0, -1.0, 2.0, 4.0, -2.0, 2.0, -1.0, 8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec4(true, true, true, true));
	blockB[0].b = (false);
	blockB[0].c = (mat3x4(5.0, -3.0, 4.0, -8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0, 3.0, -2.0));
	blockB[0].d[0] = (uvec2(8u, 0u));
	blockB[0].d[1] = (uvec2(6u, 2u));
	blockB[0].d[2] = (uvec2(6u, 4u));
	blockB[0].d[3] = (uvec2(5u, 0u));
	blockB[0].d[4] = (uvec2(3u, 3u));
	blockB[1].a = (bvec4(false, false, true, false));
	blockB[1].b = (false);
	blockB[1].c = (mat3x4(8.0, 2.0, -4.0, 6.0, 9.0, 9.0, -1.0, -2.0, 8.0, 7.0, -5.0, -2.0));
	blockB[1].d[0] = (uvec2(7u, 3u));
	blockB[1].d[1] = (uvec2(9u, 8u));
	blockB[1].d[2] = (uvec2(2u, 7u));
	blockB[1].d[3] = (uvec2(3u, 1u));
	blockB[1].d[4] = (uvec2(5u, 2u));
	blockB[1].d[5] = (uvec2(1u, 8u));
}
#version 450
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
	lowp mat3x4 a;
	bvec4 b;
	lowp mat4x2 c;
	mediump vec2 d;
	highp uvec2 e[][7];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b), bvec4(true, true, false, true)) && allOk;
	allOk = compare_mat4x2(blockB.c, mat4x2(-9.0, 3.0, -4.0, 1.0, 9.0, -1.0, -9.0, -8.0)) && allOk;
	allOk = compare_vec2((blockB.d), vec2(-3.0, 3.0)) && allOk;
	allOk = compare_uvec2((blockB.e[0][0]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((blockB.e[0][1]), uvec2(2u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.e[0][2]), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.e[0][3]), uvec2(5u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.e[0][4]), uvec2(3u, 8u)) && allOk;
	allOk = compare_uvec2((blockB.e[0][5]), uvec2(9u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.e[0][6]), uvec2(2u, 7u)) && allOk;
	allOk = compare_uvec2((blockB.e[1][0]), uvec2(1u, 3u)) && allOk;
	allOk = compare_uvec2((blockB.e[1][1]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.e[1][2]), uvec2(5u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.e[1][3]), uvec2(1u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.e[1][4]), uvec2(7u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.e[1][5]), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec2((blockB.e[1][6]), uvec2(5u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.e[2][0]), uvec2(4u, 8u)) && allOk;
	allOk = compare_uvec2((blockB.e[2][1]), uvec2(3u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.e[2][2]), uvec2(4u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.e[2][3]), uvec2(2u, 3u)) && allOk;
	allOk = compare_uvec2((blockB.e[2][4]), uvec2(0u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.e[2][5]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.e[2][6]), uvec2(8u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.e[3][0]), uvec2(7u, 8u)) && allOk;
	allOk = compare_uvec2((blockB.e[3][1]), uvec2(7u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.e[3][2]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.e[3][3]), uvec2(8u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.e[3][4]), uvec2(8u, 3u)) && allOk;
	allOk = compare_uvec2((blockB.e[3][5]), uvec2(1u, 3u)) && allOk;
	allOk = compare_uvec2((blockB.e[3][6]), uvec2(4u, 7u)) && allOk;
	allOk = compare_uvec2((blockB.e[4][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.e[4][1]), uvec2(8u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.e[4][2]), uvec2(7u, 8u)) && allOk;
	allOk = compare_uvec2((blockB.e[4][3]), uvec2(5u, 1u)) && allOk;
	allOk = compare_uvec2((blockB.e[4][4]), uvec2(9u, 3u)) && allOk;
	allOk = compare_uvec2((blockB.e[4][5]), uvec2(6u, 3u)) && allOk;
	allOk = compare_uvec2((blockB.e[4][6]), uvec2(6u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.e[5][0]), uvec2(5u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.e[5][1]), uvec2(3u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.e[5][2]), uvec2(5u, 3u)) && allOk;
	allOk = compare_uvec2((blockB.e[5][3]), uvec2(3u, 8u)) && allOk;
	allOk = compare_uvec2((blockB.e[5][4]), uvec2(9u, 3u)) && allOk;
	allOk = compare_uvec2((blockB.e[5][5]), uvec2(5u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.e[5][6]), uvec2(6u, 5u)) && allOk;
	allOk = compare_uvec2((blockB.e[6][0]), uvec2(3u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.e[6][1]), uvec2(6u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.e[6][2]), uvec2(2u, 3u)) && allOk;
	allOk = compare_uvec2((blockB.e[6][3]), uvec2(8u, 1u)) && allOk;
	allOk = compare_uvec2((blockB.e[6][4]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.e[6][5]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.e[6][6]), uvec2(9u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(6.0, -5.0, -1.0, -3.0, -1.0, -2.0, 7.0, -5.0, -5.0, -4.0, 1.0, -7.0));
	blockB.b = (bvec4(true, false, true, true));
	blockB.c = (mat4x2(0.0, 1.0, -1.0, 6.0, 3.0, 6.0, -6.0, 2.0));
}
#version 450
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
	mediump mat4x2 mB;
	bool mC[7][2];
};
struct sB
{
	lowp uvec4 mA;
	bvec3 mB;
	lowp mat2 mC;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	sA a;
	lowp mat4x3 b;
	sB c;
	lowp ivec2 d;
};
layout(std140, binding = 2) buffer BlockC
{
	mediump ivec3 e;
	mediump float f;
	lowp mat2 g;
	bvec4 h[3];
	lowp uvec3 i;
} blockC[1];
layout(std140, column_major, binding = 3) buffer BlockD
{
	bool j;
	bvec2 k;
	lowp ivec4 l;
	mediump uint m;
	lowp mat2x3 n[];
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	highp mat4x3 o[5];
	highp float p;
	highp uint q;
	mediump mat4x2 r;
	highp uint s[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((a.mA), 4u) && allOk;
	allOk = compare_mat4x2(a.mB, mat4x2(9.0, 5.0, 2.0, 5.0, 0.0, -5.0, 5.0, -2.0)) && allOk;
	allOk = compare_bool((a.mC[0][0]), false) && allOk;
	allOk = compare_bool((a.mC[0][1]), false) && allOk;
	allOk = compare_bool((a.mC[1][0]), false) && allOk;
	allOk = compare_bool((a.mC[1][1]), false) && allOk;
	allOk = compare_bool((a.mC[2][0]), true) && allOk;
	allOk = compare_bool((a.mC[2][1]), false) && allOk;
	allOk = compare_bool((a.mC[3][0]), true) && allOk;
	allOk = compare_bool((a.mC[3][1]), true) && allOk;
	allOk = compare_bool((a.mC[4][0]), false) && allOk;
	allOk = compare_bool((a.mC[4][1]), true) && allOk;
	allOk = compare_bool((a.mC[5][0]), true) && allOk;
	allOk = compare_bool((a.mC[5][1]), false) && allOk;
	allOk = compare_bool((a.mC[6][0]), false) && allOk;
	allOk = compare_bool((a.mC[6][1]), true) && allOk;
	allOk = compare_mat4x3(b, mat4x3(-3.0, 3.0, -1.0, 5.0, 0.0, 6.0, 0.0, 8.0, -7.0, -2.0, -4.0, -9.0)) && allOk;
	allOk = compare_uvec4((c.mA), uvec4(3u, 9u, 5u, 7u)) && allOk;
	allOk = compare_bvec3((c.mB), bvec3(false, false, false)) && allOk;
	allOk = compare_mat2(c.mC, mat2(-5.0, -6.0, -8.0, 6.0)) && allOk;
	allOk = compare_ivec3((blockC[0].e), ivec3(-6, -6, -3)) && allOk;
	allOk = compare_float((blockC[0].f), 6.0) && allOk;
	allOk = compare_mat2(blockC[0].g, mat2(-3.0, -3.0, -1.0, -1.0)) && allOk;
	allOk = compare_bvec4((blockC[0].h[0]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC[0].h[1]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC[0].h[2]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec2((blockD.k), bvec2(false, true)) && allOk;
	allOk = compare_uint((blockD.m), 2u) && allOk;
	allOk = compare_float((p), 8.0) && allOk;
	allOk = compare_uint((q), 9u) && allOk;
	allOk = compare_mat4x2(r, mat4x2(8.0, -4.0, 8.0, 5.0, 1.0, -8.0, -6.0, 8.0)) && allOk;
	allOk = compare_uint((s[0]), 5u) && allOk;
	allOk = compare_uint((s[1]), 5u) && allOk;
	allOk = compare_uint((s[2]), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = (8u);
	a.mB = (mat4x2(-3.0, 9.0, 8.0, -5.0, 0.0, 2.0, -3.0, 1.0));
	a.mC[0][0] = (false);
	a.mC[0][1] = (false);
	a.mC[1][0] = (true);
	a.mC[1][1] = (true);
	a.mC[2][0] = (false);
	a.mC[2][1] = (false);
	a.mC[3][0] = (false);
	a.mC[3][1] = (true);
	a.mC[4][0] = (false);
	a.mC[4][1] = (false);
	a.mC[5][0] = (false);
	a.mC[5][1] = (false);
	a.mC[6][0] = (true);
	a.mC[6][1] = (false);
	b = (mat4x3(2.0, -4.0, -7.0, -4.0, 1.0, -1.0, 4.0, -4.0, 9.0, -8.0, -4.0, -8.0));
	d = (ivec2(-2, -3));
	blockC[0].e = (ivec3(-1, 2, -5));
	blockC[0].f = (4.0);
	blockC[0].g = (mat2(-6.0, -5.0, -3.0, -5.0));
	blockC[0].i = (uvec3(6u, 0u, 0u));
	blockD.k = (bvec2(false, false));
	blockD.l = (ivec4(-6, -1, -6, -2));
	blockD.m = (8u);
	blockD.n[0] = (mat2x3(-4.0, 7.0, -6.0, -9.0, -3.0, 1.0));
	blockD.n[1] = (mat2x3(8.0, 7.0, -9.0, 6.0, -4.0, 4.0));
	o[0] = (mat4x3(-5.0, 5.0, -1.0, 8.0, 1.0, -2.0, 0.0, 0.0, -7.0, -4.0, 9.0, -2.0));
	o[1] = (mat4x3(6.0, 6.0, 4.0, 5.0, -9.0, -6.0, -6.0, -2.0, -4.0, -6.0, 3.0, -4.0));
	o[2] = (mat4x3(-9.0, 0.0, 1.0, 4.0, 3.0, 7.0, 1.0, 2.0, 6.0, 1.0, 4.0, -8.0));
	o[3] = (mat4x3(2.0, 2.0, 5.0, 7.0, -1.0, -2.0, -4.0, -4.0, 5.0, -1.0, 4.0, -8.0));
	o[4] = (mat4x3(-3.0, 9.0, -2.0, -7.0, 7.0, 9.0, -7.0, -7.0, -2.0, 5.0, -3.0, 9.0));
	p = (5.0);
	r = (mat4x2(0.0, -5.0, -1.0, 7.0, 5.0, 8.0, 8.0, 9.0));
	s[0] = (4u);
	s[1] = (2u);
	s[2] = (1u);
}
#version 450
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
	mediump mat4x3 a;
	lowp uvec2 b;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.b), uvec2(6u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(0.0, -2.0, -1.0, 6.0, 7.0, 4.0, -7.0, -8.0, -7.0, 2.0, -1.0, -1.0));
}
#version 450
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
	layout(offset = 0) highp uint a;
	layout(offset = 4) mediump vec3 b;
	layout(offset = 16) bool c;
	layout(offset = 20) bvec3 d;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp int e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((b), vec3(8.0, 8.0, 0.0)) && allOk;
	allOk = compare_bvec3((d), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (4u);
	c = (true);
	d = (bvec3(true, false, false));
	e = (5);
}
#version 450
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
	layout(offset = 0) mediump vec4 a;
	layout(offset = 16) bvec3 b;
	layout(offset = 32) highp vec4 c;
	layout(offset = 48) highp uint d;
	layout(offset = 64) highp vec4 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((b), bvec3(false, false, true)) && allOk;
	allOk = compare_vec4((c), vec4(-2.0, -5.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(-2.0, -9.0, -3.0, -1.0));
	b = (bvec3(true, true, true));
	c = (vec4(4.0, -6.0, 2.0, 6.0));
	d = (0u);
	e = (vec4(6.0, -5.0, 2.0, -9.0));
}
#version 450
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
	layout(offset = 0) mediump vec2 a;
	layout(offset = 8) highp int b;
	layout(offset = 12) bool c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((b), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec2(-4.0, -8.0));
	b = (1);
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

layout(column_major, binding = 1) buffer BlockB
{
	layout(offset = 0) mediump int a;
} blockB[];

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

layout(std140, row_major, binding = 1) buffer BlockB
{
	bool a;
} blockB[];

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (true);
	blockB[nonuniformEXT(1)].a = (true);
}
#version 450
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
	float16_t a[1];
	float16_t b;
	mediump float c;
	float16_t d;
	float16_t e;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.c), -9.0) && allOk;
	allOk = compare_float16_t(float(blockB.d), -5.0) && allOk;
	allOk = compare_float16_t(float(blockB.e), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = float16_t(2.0);
	blockB.b = float16_t(7.0);
	blockB.d = float16_t(-4.0);
	blockB.e = float16_t(-8.0);
}
#version 450
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
	mediump uvec4 a;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	lowp ivec2 b;
	mediump ivec2 c;
	int16_t d;
	lowp float e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(4u, 0u, 4u, 6u)) && allOk;
	allOk = compare_ivec2((b), ivec2(5, 5)) && allOk;
	allOk = compare_ivec2((c), ivec2(5, -5)) && allOk;
	allOk = compare_int16_t(int(d), -2) && allOk;
	allOk = compare_float((e), -9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	e = (8.0);
}
#version 450
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
	lowp mat4 mB;
	mediump mat4 mC;
};
struct sB
{
	i16vec3 mA;
	highp mat2 mB;
	float16_t mC;
	bvec3 mD;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	u16vec4 a;
	mediump mat4x2 b;
	lowp mat2x3 c;
	bvec3 d[1];
	mediump vec2 e[];
};
layout(std430, binding = 2) buffer BlockC
{
	f16vec3 f;
	sA g;
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	highp mat3x4 h;
	i16vec2 i;
	mediump mat2x3 j;
	sB k;
	highp mat4 l[];
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	mediump mat4x2 m;
	u16vec4 n;
	highp uvec3 o[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(a), uvec4(5u, 5u, 0u, 5u)) && allOk;
	allOk = compare_mat4x2(b, mat4x2(0.0, -8.0, 3.0, 2.0, 7.0, 8.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat2x3(c, mat2x3(-2.0, -7.0, -1.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_bvec3((d[0]), bvec3(true, false, true)) && allOk;
	allOk = compare_vec2((e[0]), vec2(1.0, -6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.f), vec3(-7.0, 2.0, 8.0)) && allOk;
	allOk = compare_float((blockC.g.mA), -2.0) && allOk;
	allOk = compare_mat4(blockC.g.mB, mat4(8.0, 0.0, 2.0, 2.0, -2.0, 3.0, -6.0, 7.0, -7.0, 9.0, -2.0, 7.0, 6.0, 3.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat4(blockC.g.mC, mat4(0.0, 6.0, 7.0, 2.0, -4.0, -9.0, -8.0, 2.0, -3.0, 6.0, 1.0, 7.0, 8.0, -4.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockD.j, mat2x3(3.0, 5.0, 7.0, -6.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u16vec4(uvec4(5u, 5u, 6u, 2u));
	c = (mat2x3(-7.0, 3.0, -9.0, -8.0, -6.0, 9.0));
	e[0] = (vec2(0.0, -4.0));
	blockC.f = f16vec3(vec3(2.0, 1.0, 2.0));
	blockC.g.mA = (9.0);
	blockC.g.mB = (mat4(-3.0, -2.0, -6.0, -2.0, 5.0, -3.0, 2.0, 0.0, 0.0, 2.0, -8.0, -5.0, -3.0, -3.0, 0.0, 8.0));
	blockC.g.mC = (mat4(-9.0, 2.0, -4.0, 1.0, 8.0, 7.0, -4.0, -3.0, -2.0, 7.0, -9.0, 3.0, 8.0, 2.0, 4.0, -8.0));
	blockD.j = (mat2x3(-7.0, -7.0, -2.0, 2.0, 3.0, -4.0));
	blockD.l[0] = (mat4(1.0, 2.0, 5.0, -1.0, -6.0, 7.0, 4.0, 3.0, -6.0, -8.0, -2.0, -7.0, -8.0, -1.0, -6.0, -2.0));
	m = (mat4x2(-4.0, 9.0, 3.0, 7.0, 8.0, -1.0, -8.0, -5.0));
	o[0] = (uvec3(3u, 1u, 8u));
}
#version 450
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
	mediump uvec4 mB;
};
layout(std140, binding = 1) buffer BlockB
{
	highp float a;
	sA b;
	bvec2 c;
} blockB[1];
layout(std140, row_major, binding = 2) buffer BlockC
{
	u16vec4 d;
	bvec4 e;
	highp mat3x2 f[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	mediump mat4x2 g;
	u16vec4 h;
	highp mat3 i;
	int16_t j[];
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB[0].b.mA), ivec2(-9, -7)) && allOk;
	allOk = compare_uvec4((blockB[0].b.mB), uvec4(1u, 6u, 9u, 7u)) && allOk;
	allOk = compare_u16vec4(uvec4(d), uvec4(8u, 4u, 0u, 3u)) && allOk;
	allOk = compare_bvec4((e), bvec4(false, true, true, false)) && allOk;
	allOk = compare_mat3x2(f[0], mat3x2(-3.0, -9.0, -9.0, 7.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].g, mat4x2(6.0, 7.0, 7.0, -2.0, -8.0, -8.0, 9.0, 6.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[0].h), uvec4(9u, 8u, 1u, 0u)) && allOk;
	allOk = compare_mat4x2(blockD[1].g, mat4x2(-3.0, 9.0, -6.0, 0.0, -9.0, -4.0, 0.0, -9.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[1].h), uvec4(0u, 6u, 3u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (-7.0);
	blockB[0].b.mA = i16vec2(ivec2(4, -4));
	blockB[0].b.mB = (uvec4(4u, 6u, 5u, 3u));
	f[0] = (mat3x2(-6.0, 9.0, 7.0, 1.0, 1.0, 3.0));
	blockD[0].g = (mat4x2(9.0, -6.0, 6.0, 2.0, 4.0, 8.0, -5.0, 0.0));
	blockD[0].h = u16vec4(uvec4(8u, 4u, 4u, 7u));
	blockD[1].g = (mat4x2(-3.0, 7.0, 0.0, 4.0, 5.0, 0.0, -3.0, -3.0));
	blockD[1].h = u16vec4(uvec4(3u, 6u, 3u, 2u));
}
#version 450
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
	lowp uint mA;
};
struct sB
{
	mediump uvec3 mA;
	mediump uvec4 mB;
	i16vec4 mC;
	highp mat3x2 mD;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	mediump int a;
	u16vec3 b;
	uint16_t c[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	sA d;
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	uint16_t e;
	i16vec3 f;
	int16_t g[3];
	highp mat3x4 h;
	sB i[];
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	i16vec2 j;
	bvec3 k;
	bvec2 l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), -7) && allOk;
	allOk = compare_uint16_t(uint(blockB.c[0]), 5u) && allOk;
	allOk = compare_uint16_t(uint(blockB.c[1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(blockB.c[2]), 1u) && allOk;
	allOk = compare_uint16_t(uint(blockB.c[3]), 3u) && allOk;
	allOk = compare_uint16_t(uint(blockB.c[4]), 9u) && allOk;
	allOk = compare_uint16_t(uint(blockB.c[5]), 3u) && allOk;
	allOk = compare_uint16_t(uint(blockB.c[6]), 5u) && allOk;
	allOk = compare_uint((blockC.d.mA), 0u) && allOk;
	allOk = compare_uint16_t(uint(blockD.e), 6u) && allOk;
	allOk = compare_int16_t(int(blockD.g[0]), 1) && allOk;
	allOk = compare_int16_t(int(blockD.g[1]), 4) && allOk;
	allOk = compare_int16_t(int(blockD.g[2]), -8) && allOk;
	allOk = compare_uvec3((blockD.i[0].mA), uvec3(9u, 3u, 2u)) && allOk;
	allOk = compare_uvec4((blockD.i[0].mB), uvec4(2u, 2u, 5u, 6u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.i[0].mC), ivec4(-5, -7, -7, -8)) && allOk;
	allOk = compare_mat3x2(blockD.i[0].mD, mat3x2(3.0, 8.0, -9.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockD.i[1].mA), uvec3(2u, 8u, 4u)) && allOk;
	allOk = compare_uvec4((blockD.i[1].mB), uvec4(9u, 8u, 4u, 2u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.i[1].mC), ivec4(-2, 3, -6, -6)) && allOk;
	allOk = compare_mat3x2(blockD.i[1].mD, mat3x2(9.0, 5.0, 9.0, 3.0, -5.0, 5.0)) && allOk;
	allOk = compare_i16vec2(ivec2(j), ivec2(-6, -9)) && allOk;
	allOk = compare_bvec3((k), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = u16vec3(uvec3(1u, 0u, 0u));
	blockB.c[0] = uint16_t(3u);
	blockB.c[1] = uint16_t(5u);
	blockB.c[2] = uint16_t(6u);
	blockB.c[3] = uint16_t(2u);
	blockB.c[4] = uint16_t(7u);
	blockB.c[5] = uint16_t(9u);
	blockB.c[6] = uint16_t(8u);
	blockC.d.mA = (0u);
	blockD.g[0] = int16_t(-6);
	blockD.g[1] = int16_t(0);
	blockD.g[2] = int16_t(-8);
	blockD.h = (mat3x4(-7.0, 5.0, 6.0, 2.0, -2.0, 4.0, 2.0, -7.0, -4.0, 5.0, 5.0, 1.0));
	blockD.i[0].mA = (uvec3(5u, 5u, 0u));
	blockD.i[0].mB = (uvec4(0u, 1u, 4u, 6u));
	blockD.i[0].mC = i16vec4(ivec4(6, -7, -6, -4));
	blockD.i[0].mD = (mat3x2(2.0, 9.0, -2.0, 3.0, 5.0, 0.0));
	blockD.i[1].mA = (uvec3(0u, 1u, 9u));
	blockD.i[1].mB = (uvec4(4u, 5u, 1u, 6u));
	blockD.i[1].mC = i16vec4(ivec4(5, -9, 8, -9));
	blockD.i[1].mD = (mat3x2(6.0, 5.0, -2.0, 1.0, -4.0, -9.0));
	k = (bvec3(true, false, false));
}
#version 450
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
	layout(offset = 0) mediump vec2 a;
	layout(offset = 8) highp uvec2 b;
	layout(offset = 16) bool c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp ivec4 d;
} blockC[1];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp ivec3 e;
	layout(offset = 16) u16vec4 f;
	layout(offset = 24) int16_t g;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) i16vec4 h[1];
	layout(offset = 16) lowp vec4 i;
	layout(offset = 32) bvec4 j;
	layout(offset = 48) int16_t k;
	layout(offset = 64) mediump uvec4 l;
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(0.0, -6.0)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(0u, 5u)) && allOk;
	allOk = compare_ivec3((e), ivec3(2, 8, -2)) && allOk;
	allOk = compare_u16vec4(uvec4(f), uvec4(9u, 0u, 3u, 4u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE[0].h[0]), ivec4(1, -1, -6, 3)) && allOk;
	allOk = compare_vec4((blockE[0].i), vec4(-7.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_uvec4((blockE[0].l), uvec4(2u, 3u, 3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(6.0, 3.0));
	blockB.b = (uvec2(6u, 2u));
	blockB.c = (false);
	blockC[0].d = (ivec4(2, -6, 6, -6));
	g = int16_t(-9);
	blockE[0].i = (vec4(-1.0, -4.0, 0.0, -4.0));
	blockE[0].j = (bvec4(false, false, false, false));
	blockE[0].k = int16_t(-3);
	blockE[0].l = (uvec4(8u, 3u, 0u, 4u));
}
#version 450
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
	layout(offset = 16) highp vec4 b;
	layout(offset = 32) u16vec2 c;
	layout(offset = 36) lowp float d;
} blockB[3];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec4 e;
} blockC[1];

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

layout(binding = 1) readonly buffer BlockB
{
	layout(offset = 0) i16vec4 a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i16vec4 b;
	layout(offset = 8) i16vec2 c;
	layout(offset = 16) u16vec3 d[1];
	layout(offset = 24) lowp vec2 e;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) uint16_t f;
	layout(offset = 4) bool g;
	layout(offset = 8) bvec2 h;
	layout(offset = 16) highp int i;
} blockD[1];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump ivec3 j;
	layout(offset = 16) bvec3 k;
	layout(offset = 28) u16vec2 l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(a), ivec4(-5, 7, -2, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.b), ivec4(0, -2, -3, 0)) && allOk;
	allOk = compare_vec2((blockC.e), vec2(4.0, 1.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD[0].f), 6u) && allOk;
	allOk = compare_bvec2((blockD[0].h), bvec2(false, true)) && allOk;
	allOk = compare_int((blockD[0].i), -6) && allOk;
	allOk = compare_ivec3((j), ivec3(-1, 4, -1)) && allOk;
	allOk = compare_bvec3((k), bvec3(true, false, false)) && allOk;
	allOk = compare_u16vec2(uvec2(l), uvec2(7u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = i16vec4(ivec4(-5, 2, 1, -5));
	blockC.c = i16vec2(ivec2(-6, -9));
	blockC.d[0] = u16vec3(uvec3(3u, 5u, 1u));
	blockC.e = (vec2(-5.0, 0.0));
	blockD[0].f = uint16_t(8u);
	blockD[0].g = (true);
	blockD[0].h = (bvec2(false, true));
	blockD[0].i = (-1);
	k = (bvec3(true, false, true));
}
#version 450
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
	u8vec2 b;
	i8vec4 c;
	i8vec3 d;
	u8vec4 e[1];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	bvec2 f;
	i8vec3 g;
	bool h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), 4.0) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.d), ivec3(3, 4294967291, 4294967288)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.e[0]), uvec4(5u, 6u, 7u, 3u)) && allOk;
	allOk = compare_bool((h), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = u8vec2(uvec2(2u, 9u));
	blockB.c = i8vec4(ivec4(4294967289, 4294967288, 8, 4));
	blockB.d = i8vec3(ivec3(6, 4294967291, 4294967291));
	blockB.e[0] = u8vec4(uvec4(3u, 1u, 9u, 5u));
	f = (bvec2(true, true));
	g = i8vec3(ivec3(1, 4294967290, 4));
	h = (false);
}
#version 450
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
	bvec2 a;
	highp ivec3 b;
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp mat3 c;
	i8vec3 d;
	lowp mat4 e;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	u8vec3 f;
	highp uvec4 g;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((b), ivec3(0, 5, 5)) && allOk;
	allOk = compare_mat3(blockC.c, mat3(5.0, -5.0, -2.0, -9.0, 1.0, -6.0, -8.0, -5.0, 9.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.d), ivec3(7, 4294967288, 1)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.f), uvec3(0u, 4u, 2u)) && allOk;
	allOk = compare_uvec4((blockD.g), uvec4(0u, 5u, 1u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (ivec3(0, -3, 9));
	blockC.d = i8vec3(ivec3(4294967291, 8, 4294967295));
	blockC.e = (mat4(7.0, -9.0, -3.0, -1.0, 6.0, -2.0, -4.0, 9.0, -4.0, 2.0, -4.0, 4.0, -8.0, -4.0, 1.0, -4.0));
	blockD.g = (uvec4(9u, 9u, 0u, 0u));
}
#version 450
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
	i8vec4 a;
	highp ivec3 b;
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	lowp vec3 c[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp mat3x4 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(a), ivec4(1, 4294967291, 4294967287, 4294967291)) && allOk;
	allOk = compare_vec3((c[0]), vec3(2.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec3((c[1]), vec3(9.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec3((c[2]), vec3(9.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec3((c[3]), vec3(7.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec3((c[4]), vec3(7.0, 4.0, -2.0)) && allOk;
	allOk = compare_vec3((c[5]), vec3(9.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec3((c[6]), vec3(1.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(d[0], mat3x4(5.0, 5.0, -3.0, 3.0, 1.0, -9.0, 7.0, -2.0, 2.0, 9.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(d[1], mat3x4(1.0, 1.0, -9.0, -3.0, -9.0, -7.0, -4.0, -4.0, -6.0, 1.0, 3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i8vec4(ivec4(2, 7, 4294967291, 4294967292));
	b = (ivec3(-8, -5, 0));
	c[0] = (vec3(0.0, -7.0, 5.0));
	c[1] = (vec3(3.0, 4.0, 7.0));
	c[2] = (vec3(8.0, 3.0, 8.0));
	c[3] = (vec3(8.0, 0.0, 8.0));
	c[4] = (vec3(-6.0, 5.0, 1.0));
	c[5] = (vec3(7.0, -1.0, -9.0));
	c[6] = (vec3(-2.0, -7.0, -5.0));
	d[0] = (mat3x4(7.0, -9.0, -5.0, 5.0, 3.0, 7.0, -7.0, -6.0, 1.0, 8.0, 8.0, -9.0));
	d[1] = (mat3x4(-8.0, 4.0, 8.0, 5.0, 3.0, 5.0, -4.0, 8.0, 8.0, 0.0, -8.0, 1.0));
}
#version 450
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
	mediump mat4 a;
	uint8_t b;
	lowp ivec2 c;
	i8vec2 d;
	bvec3 e[];
} blockB;
layout(std430, binding = 2) readonly buffer BlockC
{
	bvec3 f;
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp vec4 g;
	lowp vec3 h;
	lowp uvec2 i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.b), 8u) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(5, -6)) && allOk;
	allOk = compare_bvec3((blockB.e[0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.e[1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockB.e[2]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.e[3]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.e[4]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.e[5]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((f), bvec3(false, false, true)) && allOk;
	allOk = compare_vec3((h), vec3(1.0, -2.0, 4.0)) && allOk;
	allOk = compare_uvec2((i[0]), uvec2(6u, 4u)) && allOk;
	allOk = compare_uvec2((i[1]), uvec2(8u, 5u)) && allOk;
	allOk = compare_uvec2((i[2]), uvec2(8u, 1u)) && allOk;
	allOk = compare_uvec2((i[3]), uvec2(1u, 2u)) && allOk;
	allOk = compare_uvec2((i[4]), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec2((i[5]), uvec2(7u, 3u)) && allOk;
	allOk = compare_uvec2((i[6]), uvec2(4u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(-5.0, 4.0, -9.0, -7.0, -8.0, 8.0, 4.0, 6.0, -5.0, -5.0, -7.0, 5.0, 2.0, -4.0, -8.0, 0.0));
	blockB.b = uint8_t(9u);
	blockB.c = (ivec2(3, 1));
	h = (vec3(-1.0, -2.0, -8.0));
}
#version 450
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
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	a = (true);
}
#version 450
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
	bool a[];
};
layout(std430, binding = 2) buffer BlockC
{
	highp mat4x2 b;
	int8_t c;
	lowp vec2 d[];
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockC[0].b, mat4x2(-6.0, -3.0, -1.0, -9.0, 5.0, -7.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].b, mat4x2(-8.0, -6.0, -2.0, 9.0, -2.0, -2.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockC[2].b, mat4x2(-5.0, 8.0, 4.0, -9.0, 8.0, -6.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (true);
	blockC[0].b = (mat4x2(5.0, 5.0, -3.0, -5.0, -8.0, 3.0, -9.0, 2.0));
	blockC[0].d[0] = (vec2(1.0, 9.0));
	blockC[1].b = (mat4x2(-5.0, 9.0, -3.0, 6.0, 7.0, -9.0, -6.0, -1.0));
	blockC[1].d[0] = (vec2(5.0, 3.0));
	blockC[2].b = (mat4x2(9.0, 8.0, -4.0, -8.0, -5.0, -1.0, 2.0, 0.0));
	blockC[2].d[0] = (vec2(3.0, -3.0));
}
#version 450
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
	highp float a;
	lowp uvec2 b[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -8.0) && allOk;
	allOk = compare_uvec2((blockB.b[0]), uvec2(2u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (4.0);
	blockB.b[0] = (uvec2(2u, 1u));
}
#version 450
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
	highp mat2 mA;
	highp uvec4 mB;
	bvec4 mC;
	mediump ivec2 mD;
};
struct sB
{
	i8vec2 mA;
	bvec4 mB;
	mediump float mC;
	bvec3 mD;
};
struct sC
{
	highp mat3 mA;
};
layout(std140, binding = 1) buffer BlockB
{
	sA a;
	bvec3 b;
	lowp uvec4 c;
	mediump uvec4 d;
	highp ivec2 e;
} blockB[3];
layout(std140, row_major, binding = 2) buffer BlockC
{
	sB f;
	lowp uvec4 g;
	highp vec2 h[5];
	mediump float i;
	u8vec2 j[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	u8vec2 k;
	highp ivec4 l;
	sC m[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[0].b), bvec3(false, true, false)) && allOk;
	allOk = compare_uvec4((blockB[0].c), uvec4(9u, 8u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((blockB[0].d), uvec4(8u, 2u, 9u, 4u)) && allOk;
	allOk = compare_ivec2((blockB[0].e), ivec2(3, -8)) && allOk;
	allOk = compare_bvec3((blockB[1].b), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec4((blockB[1].c), uvec4(9u, 2u, 2u, 6u)) && allOk;
	allOk = compare_uvec4((blockB[1].d), uvec4(9u, 8u, 6u, 1u)) && allOk;
	allOk = compare_ivec2((blockB[1].e), ivec2(-6, -3)) && allOk;
	allOk = compare_bvec3((blockB[2].b), bvec3(false, true, true)) && allOk;
	allOk = compare_uvec4((blockB[2].c), uvec4(1u, 7u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((blockB[2].d), uvec4(0u, 5u, 4u, 5u)) && allOk;
	allOk = compare_ivec2((blockB[2].e), ivec2(-2, 9)) && allOk;
	allOk = compare_vec2((blockC.h[0]), vec2(-2.0, 9.0)) && allOk;
	allOk = compare_vec2((blockC.h[1]), vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2((blockC.h[2]), vec2(8.0, -8.0)) && allOk;
	allOk = compare_vec2((blockC.h[3]), vec2(3.0, -8.0)) && allOk;
	allOk = compare_vec2((blockC.h[4]), vec2(-7.0, 3.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.j[0]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.j[1]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.j[2]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.j[3]), uvec2(9u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.j[4]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.j[5]), uvec2(4u, 9u)) && allOk;
	allOk = compare_ivec4((blockD.l), ivec4(2, -9, -4, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (mat2(6.0, -8.0, -5.0, -5.0));
	blockB[0].a.mB = (uvec4(3u, 4u, 2u, 9u));
	blockB[0].a.mC = (bvec4(true, true, true, false));
	blockB[0].a.mD = (ivec2(-5, 8));
	blockB[0].b = (bvec3(false, true, true));
	blockB[0].d = (uvec4(3u, 3u, 0u, 3u));
	blockB[0].e = (ivec2(4, -5));
	blockB[1].a.mA = (mat2(-8.0, -3.0, -5.0, 0.0));
	blockB[1].a.mB = (uvec4(8u, 4u, 7u, 2u));
	blockB[1].a.mC = (bvec4(true, false, true, false));
	blockB[1].a.mD = (ivec2(9, 3));
	blockB[1].b = (bvec3(false, true, false));
	blockB[1].d = (uvec4(7u, 3u, 4u, 8u));
	blockB[1].e = (ivec2(-8, 9));
	blockB[2].a.mA = (mat2(0.0, -8.0, -2.0, -5.0));
	blockB[2].a.mB = (uvec4(5u, 1u, 9u, 3u));
	blockB[2].a.mC = (bvec4(true, true, false, false));
	blockB[2].a.mD = (ivec2(3, 8));
	blockB[2].b = (bvec3(false, true, false));
	blockB[2].d = (uvec4(9u, 9u, 0u, 4u));
	blockB[2].e = (ivec2(7, 9));
	blockC.h[0] = (vec2(5.0, -7.0));
	blockC.h[1] = (vec2(4.0, -1.0));
	blockC.h[2] = (vec2(7.0, -5.0));
	blockC.h[3] = (vec2(-9.0, 3.0));
	blockC.h[4] = (vec2(9.0, -1.0));
	blockC.j[0] = u8vec2(uvec2(3u, 2u));
	blockC.j[1] = u8vec2(uvec2(1u, 7u));
	blockC.j[2] = u8vec2(uvec2(0u, 5u));
	blockC.j[3] = u8vec2(uvec2(9u, 0u));
	blockC.j[4] = u8vec2(uvec2(6u, 7u));
	blockC.j[5] = u8vec2(uvec2(3u, 7u));
	blockD.k = u8vec2(uvec2(6u, 7u));
	blockD.m[0].mA = (mat3(-8.0, -9.0, 0.0, -4.0, 9.0, 6.0, -2.0, 8.0, 1.0));
	blockD.m[1].mA = (mat3(-2.0, 5.0, 0.0, -3.0, -1.0, 0.0, -5.0, 3.0, -2.0));
	blockD.m[2].mA = (mat3(-9.0, 2.0, -4.0, 4.0, -1.0, 6.0, -2.0, 2.0, 4.0));
}
#version 450
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
	mediump uvec3 mB;
};
struct sB
{
	lowp mat4x3 mA;
	mediump ivec2 mB;
	bvec3 mC;
	lowp ivec2 mD;
};
layout(std140, binding = 1) buffer BlockB
{
	sA a;
	highp uvec3 b;
	mediump uint c;
	mediump uvec2 d;
	sB e;
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[0].a.mA), uvec2(3u, 0u)) && allOk;
	allOk = compare_uvec3((blockB[0].a.mB), uvec3(3u, 0u, 4u)) && allOk;
	allOk = compare_uvec3((blockB[0].b), uvec3(5u, 4u, 3u)) && allOk;
	allOk = compare_uint((blockB[0].c), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].c = (4u);
	blockB[0].d = (uvec2(5u, 4u));
	blockB[0].e.mA = (mat4x3(1.0, 9.0, -5.0, 9.0, -3.0, 6.0, 7.0, -9.0, -6.0, -1.0, 3.0, 5.0));
	blockB[0].e.mB = (ivec2(3, 9));
	blockB[0].e.mC = (bvec3(false, false, true));
	blockB[0].e.mD = (ivec2(-1, 2));
}
#version 450
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
	highp uvec2 mA;
	u8vec3 mB;
	highp uvec4 mC;
};
struct sB
{
	mediump mat4x2 mA;
	i8vec3 mB;
};
struct sC
{
	u8vec2 mA;
};
struct sD
{
	mediump mat4 mA;
	bvec2 mB;
	sC mC;
	highp vec3 mD;
};
layout(std430, binding = 1) buffer BlockB
{
	sA a;
	bvec2 b;
	bvec3 c;
	lowp mat3x2 d[];
};
layout(std140, binding = 2) buffer BlockC
{
	highp uint e;
	sB f;
	highp ivec3 g;
	u8vec2 h[];
};
layout(std140, binding = 3) buffer BlockD
{
	lowp vec3 i;
	highp ivec4 j;
	sD k;
	i8vec2 l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((a.mA), uvec2(2u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(a.mB), uvec3(1u, 9u, 5u)) && allOk;
	allOk = compare_uvec4((a.mC), uvec4(7u, 9u, 2u, 0u)) && allOk;
	allOk = compare_bvec2((b), bvec2(false, true)) && allOk;
	allOk = compare_bvec3((c), bvec3(false, false, false)) && allOk;
	allOk = compare_mat3x2(d[0], mat3x2(9.0, 5.0, -4.0, 1.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3x2(d[1], mat3x2(-3.0, 1.0, 5.0, 6.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(d[2], mat3x2(1.0, -3.0, 1.0, 6.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x2(d[3], mat3x2(-8.0, 6.0, 6.0, 5.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3x2(d[4], mat3x2(6.0, -4.0, 0.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3x2(d[5], mat3x2(9.0, -9.0, 9.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(d[6], mat3x2(5.0, 2.0, 3.0, 1.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(d[7], mat3x2(9.0, 1.0, 5.0, -7.0, 6.0, -1.0)) && allOk;
	allOk = compare_uint((e), 3u) && allOk;
	allOk = compare_mat4x2(f.mA, mat4x2(-5.0, 8.0, 5.0, -4.0, -1.0, -8.0, 4.0, -7.0)) && allOk;
	allOk = compare_i8vec3(ivec3(f.mB), ivec3(1, 4, 4294967294)) && allOk;
	allOk = compare_ivec3((g), ivec3(0, -1, -3)) && allOk;
	allOk = compare_u8vec2(uvec2(h[0]), uvec2(2u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(h[1]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(h[2]), uvec2(9u, 3u)) && allOk;
	allOk = compare_ivec4((j), ivec4(9, -2, 9, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(l[0]), ivec2(4294967290, 4294967294)) && allOk;
	allOk = compare_i8vec2(ivec2(l[1]), ivec2(1, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(l[2]), ivec2(4294967293, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(l[3]), ivec2(4294967290, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = (uvec2(6u, 8u));
	a.mB = u8vec3(uvec3(4u, 7u, 4u));
	a.mC = (uvec4(8u, 4u, 7u, 8u));
	e = (1u);
	f.mA = (mat4x2(5.0, 5.0, -1.0, 7.0, -1.0, -8.0, 0.0, -8.0));
	f.mB = i8vec3(ivec3(4, 4294967293, 4294967292));
	g = (ivec3(9, -9, -8));
	h[0] = u8vec2(uvec2(9u, 8u));
	h[1] = u8vec2(uvec2(1u, 8u));
	h[2] = u8vec2(uvec2(9u, 0u));
	j = (ivec4(-8, 3, 9, 6));
	k.mA = (mat4(-4.0, 0.0, -9.0, 3.0, 5.0, 0.0, -7.0, 1.0, 0.0, 0.0, -4.0, 5.0, -3.0, 2.0, 1.0, 8.0));
	k.mB = (bvec2(false, false));
	k.mC.mA = u8vec2(uvec2(6u, 3u));
	k.mD = (vec3(2.0, 0.0, -4.0));
}
#version 450
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
	highp int mB;
	lowp uvec4 mC;
};
layout(scalar, binding = 1) buffer BlockB
{
	sA a;
} blockB[2];
layout(scalar, row_major, binding = 2) buffer BlockC
{
	mediump vec3 b[];
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	mediump ivec2 c;
	highp uint d;
	bool e[];
} blockD[1];
layout(scalar, row_major, binding = 4) buffer BlockE
{
	lowp ivec3 f;
	mediump uvec3 g;
	uint8_t h;
	i8vec4 i[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB[0].a.mA), uvec2(9u, 8u)) && allOk;
	allOk = compare_int((blockB[0].a.mB), -2) && allOk;
	allOk = compare_uvec4((blockB[0].a.mC), uvec4(8u, 1u, 5u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[1].a.mA), uvec2(9u, 5u)) && allOk;
	allOk = compare_int((blockB[1].a.mB), 6) && allOk;
	allOk = compare_uvec4((blockB[1].a.mC), uvec4(5u, 6u, 0u, 8u)) && allOk;
	allOk = compare_vec3((blockC.b[0]), vec3(-7.0, 7.0, -4.0)) && allOk;
	allOk = compare_vec3((blockC.b[1]), vec3(8.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec3((blockC.b[2]), vec3(0.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec3((blockC.b[3]), vec3(-5.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec3((blockC.b[4]), vec3(-5.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec3((blockC.b[5]), vec3(0.0, -9.0, -3.0)) && allOk;
	allOk = compare_vec3((blockC.b[6]), vec3(-2.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec3((blockC.b[7]), vec3(-3.0, 1.0, 8.0)) && allOk;
	allOk = compare_bool((blockD[0].e[0]), true) && allOk;
	allOk = compare_ivec3((blockE.f), ivec3(-2, -4, 1)) && allOk;
	allOk = compare_uvec3((blockE.g), uvec3(7u, 4u, 6u)) && allOk;
	allOk = compare_uint8_t(uint(blockE.h), 3u) && allOk;
	allOk = compare_i8vec4(ivec4(blockE.i[0]), ivec4(4294967295, 4294967287, 4294967291, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(blockE.i[1]), ivec4(4294967291, 4294967292, 4294967290, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(blockE.i[2]), ivec4(8, 9, 4294967288, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(blockE.i[3]), ivec4(9, 1, 6, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(blockE.i[4]), ivec4(0, 4294967290, 4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(blockE.i[5]), ivec4(7, 4294967287, 4294967295, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = u8vec2(uvec2(1u, 5u));
	blockB[0].a.mB = (3);
	blockB[0].a.mC = (uvec4(2u, 9u, 4u, 8u));
	blockB[1].a.mA = u8vec2(uvec2(5u, 8u));
	blockB[1].a.mB = (9);
	blockB[1].a.mC = (uvec4(9u, 5u, 4u, 2u));
	blockC.b[0] = (vec3(7.0, 3.0, 2.0));
	blockC.b[1] = (vec3(-7.0, 1.0, 3.0));
	blockC.b[2] = (vec3(2.0, -7.0, 4.0));
	blockC.b[3] = (vec3(9.0, -8.0, -1.0));
	blockC.b[4] = (vec3(3.0, -1.0, 4.0));
	blockC.b[5] = (vec3(1.0, -8.0, -8.0));
	blockC.b[6] = (vec3(-1.0, -5.0, 7.0));
	blockC.b[7] = (vec3(-5.0, -3.0, -8.0));
	blockD[0].c = (ivec2(6, -4));
	blockD[0].d = (1u);
	blockD[0].e[0] = (false);
	blockE.g = (uvec3(0u, 4u, 1u));
}
#version 450
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
	highp mat2 mA[6];
	highp float mB;
	mediump int mC;
	mediump mat2 mD;
};
struct sB
{
	bvec4 mA;
	sA mB;
	lowp mat3x4 mC;
	highp mat4x2 mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	lowp mat2 a;
	lowp vec4 b[];
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	lowp vec4 c[4];
	mediump mat4 d[2];
	lowp mat3x4 e;
	lowp mat3 f[];
};
layout(scalar, column_major, binding = 3) buffer BlockD
{
	highp uvec2 g;
	highp mat3x2 h;
	sB i;
};
layout(scalar, row_major, binding = 4) buffer BlockE
{
	bvec2 j[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b[0]), vec4(7.0, 7.0, 6.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB.b[1]), vec4(6.0, -2.0, -7.0, -1.0)) && allOk;
	allOk = compare_vec4((blockB.b[2]), vec4(2.0, 9.0, 6.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB.b[3]), vec4(1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4((blockB.b[4]), vec4(-3.0, 6.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec4((blockB.b[5]), vec4(8.0, 5.0, -1.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB.b[6]), vec4(4.0, -6.0, -2.0, -3.0)) && allOk;
	allOk = compare_vec4((c[0]), vec4(-2.0, 0.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec4((c[1]), vec4(3.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_vec4((c[2]), vec4(-2.0, -5.0, 6.0, 3.0)) && allOk;
	allOk = compare_vec4((c[3]), vec4(-5.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4(d[0], mat4(-8.0, -2.0, 3.0, -6.0, -6.0, 3.0, -9.0, 8.0, 8.0, -7.0, 8.0, 9.0, 9.0, -5.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(d[1], mat4(5.0, -6.0, -9.0, -3.0, 1.0, -2.0, 9.0, -8.0, 2.0, -1.0, 5.0, -7.0, 5.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x4(e, mat3x4(-3.0, -4.0, -3.0, -8.0, 9.0, 8.0, -9.0, 9.0, 3.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(f[0], mat3(6.0, -1.0, 5.0, -9.0, -8.0, 2.0, 6.0, 3.0, -8.0)) && allOk;
	allOk = compare_uvec2((g), uvec2(7u, 5u)) && allOk;
	allOk = compare_mat3x2(h, mat3x2(4.0, 0.0, -4.0, 9.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(0.0, -2.0, -1.0, 6.0));
	blockB.b[0] = (vec4(7.0, 4.0, -7.0, -8.0));
	blockB.b[1] = (vec4(-7.0, 2.0, -1.0, -1.0));
	blockB.b[2] = (vec4(-8.0, -1.0, -5.0, 0.0));
	blockB.b[3] = (vec4(-6.0, 0.0, -8.0, -7.0));
	blockB.b[4] = (vec4(-2.0, -4.0, 5.0, 4.0));
	blockB.b[5] = (vec4(5.0, 6.0, 2.0, 5.0));
	blockB.b[6] = (vec4(2.0, -7.0, 1.0, -1.0));
	c[0] = (vec4(-8.0, 4.0, 5.0, 6.0));
	c[1] = (vec4(-9.0, -9.0, 8.0, 4.0));
	c[2] = (vec4(-7.0, -7.0, -9.0, -8.0));
	c[3] = (vec4(8.0, 6.0, -7.0, -6.0));
	d[0] = (mat4(-4.0, 5.0, -9.0, 8.0, -9.0, 2.0, -2.0, 5.0, 9.0, 3.0, 0.0, 6.0, -2.0, -4.0, 5.0, 1.0));
	d[1] = (mat4(-9.0, 2.0, 3.0, -9.0, 6.0, -2.0, 9.0, -9.0, 1.0, 9.0, -4.0, 5.0, -8.0, 9.0, -8.0, -5.0));
	e = (mat3x4(6.0, -5.0, 4.0, 8.0, -1.0, -1.0, -3.0, -8.0, -3.0, -9.0, 1.0, 6.0));
	f[0] = (mat3(3.0, -3.0, -3.0, -7.0, -3.0, -1.0, 9.0, 0.0, -1.0));
	g = (uvec2(9u, 1u));
	i.mA = (bvec4(false, false, true, true));
	i.mB.mA[0] = (mat2(0.0, 8.0, -3.0, -1.0));
	i.mB.mA[1] = (mat2(5.0, 2.0, -3.0, 1.0));
	i.mB.mA[2] = (mat2(8.0, 1.0, -3.0, 5.0));
	i.mB.mA[3] = (mat2(6.0, -3.0, -3.0, -1.0));
	i.mB.mA[4] = (mat2(-4.0, -1.0, 1.0, 3.0));
	i.mB.mA[5] = (mat2(8.0, 4.0, -7.0, 4.0));
	i.mB.mB = (1.0);
	i.mB.mC = (-8);
	i.mB.mD = (mat2(-4.0, -8.0, 3.0, -4.0));
	i.mC = (mat3x4(-7.0, 7.0, 3.0, 7.0, -9.0, 5.0, -5.0, 1.0, -5.0, 3.0, -5.0, -5.0));
	i.mD = (mat4x2(-3.0, -2.0, -8.0, 5.0, -2.0, -8.0, -5.0, -9.0));
	blockE.j[0] = (bvec2(true, true));
}
#version 450
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
	bvec3 mA;
	mediump uvec2 mB;
};
layout(scalar, binding = 1) buffer BlockB
{
	sA a;
	highp mat2 b;
	highp ivec2 c;
	highp mat4 d;
	bvec3 e;
} blockB[2];
layout(scalar, binding = 2) readonly buffer BlockC
{
	mediump mat2 f[];
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	i8vec3 g;
	lowp mat4x3 h;
	sB i;
	int8_t j;
};
layout(scalar, column_major, binding = 4) buffer BlockE
{
	u8vec3 k[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB[0].b, mat2(-1.0, -8.0, -7.0, -5.0)) && allOk;
	allOk = compare_bvec3((blockB[0].e), bvec3(true, true, true)) && allOk;
	allOk = compare_mat2(blockB[1].b, mat2(-1.0, -4.0, -3.0, 6.0)) && allOk;
	allOk = compare_bvec3((blockB[1].e), bvec3(false, true, true)) && allOk;
	allOk = compare_mat2(blockC.f[0], mat2(6.0, 9.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(h, mat4x3(0.0, 7.0, 3.0, 6.0, 4.0, -5.0, 2.0, 4.0, -2.0, -9.0, -1.0, 6.0)) && allOk;
	allOk = compare_u8vec3(uvec3(k[0]), uvec3(3u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(k[1]), uvec3(3u, 0u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(k[2]), uvec3(7u, 9u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(k[3]), uvec3(7u, 6u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(k[4]), uvec3(9u, 7u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(k[5]), uvec3(0u, 4u, 5u)) && allOk;
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
	g = i8vec3(ivec3(0, 4294967291, 4294967287));
	h = (mat4x3(-3.0, 2.0, 2.0, 1.0, 7.0, 5.0, -7.0, -4.0, -8.0, -8.0, 7.0, -6.0));
	k[0] = u8vec3(uvec3(5u, 1u, 4u));
	k[1] = u8vec3(uvec3(8u, 3u, 4u));
	k[2] = u8vec3(uvec3(0u, 9u, 4u));
	k[3] = u8vec3(uvec3(1u, 9u, 3u));
	k[4] = u8vec3(uvec3(4u, 4u, 6u));
	k[5] = u8vec3(uvec3(2u, 3u, 5u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, binding = 1) readonly buffer BlockB
{
	lowp vec2 a[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((a[0]), vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2((a[1]), vec2(-4.0, 5.0)) && allOk;
	allOk = compare_vec2((a[2]), vec2(-6.0, -9.0)) && allOk;
	allOk = compare_vec2((a[3]), vec2(5.0, -2.0)) && allOk;
	allOk = compare_vec2((a[4]), vec2(9.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bvec4 b;
	mediump mat4x3 c;
	bvec4 d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB[nonuniformEXT(0)].a, mat3(7.0, -4.0, 4.0, 3.0, 7.0, -3.0, 2.0, -1.0, 9.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].b), bvec4(true, false, true, true)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(1)].a, mat3(-7.0, 3.0, 8.0, -5.0, 3.0, -4.0, -8.0, -5.0, -6.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].b), bvec4(false, true, true, false)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(2)].a, mat3(0.0, 0.0, 8.0, 7.0, 4.0, -2.0, -2.0, -1.0, -3.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(2)].b), bvec4(true, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (bvec4(false, false, false, true));
	blockB[nonuniformEXT(1)].b = (bvec4(false, false, false, false));
	blockB[nonuniformEXT(2)].b = (bvec4(true, true, true, false));
}
#version 450
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
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[1][0], 1.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[1][2], 9.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-2.0, -8.0, 8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(1.0, -6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], -1.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[0][2], 7.0) && allOk;
	allOk = compare_float(var[0][3], -6.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], 0.0) && allOk;
	allOk = compare_float(var[1][3], 1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-1.0, 0.0, 7.0, -6.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(5.0, 5.0, 0.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, row_major, binding = 1) readonly buffer Block
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
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-3.0, 8.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat3(var, mat3(-8.0, 7.0, 3.0, -2.0, -8.0, -1.0, 4.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(1.0, 0.0, 2.0, 1.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(7.0, -1.0, 7.0, 8.0, -6.0, 1.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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
	allOk = compare_mat2x4(var[0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x2(var[0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, column_major, binding = 1) readonly buffer Block
{
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(-1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp vec2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var[0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((var[1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[2]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((var[3]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((var[4]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((var[5]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((var[6]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((var[7]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((var[8]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((var[9]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[10]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((var[11]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((var[12]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((var[13]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((var[14]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((var[15]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((var[16]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((var[17]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((var[18]), vec2(-5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat3x2(var[0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[3], mat3x2(-7.0, 6.0, -9.0, 5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(8.0, -3.0, -5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(-1.0, 3.0, 2.0, -6.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(8.0, -3.0, 9.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(2.0, 4.0, 5.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(0.0, 1.0, 8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(-4.0, 8.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(-5.0, -5.0, 2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-7.0, -1.0, -4.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-2.0, -1.0, 1.0, 0.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(-1.0, -3.0, 9.0, 9.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(6.0, -9.0, 0.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(-9.0, 7.0, 0.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(-7.0, -4.0, -4.0, 2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(-7.0, -7.0, -2.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(1.0, -7.0, 3.0, -9.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, binding = 1) readonly buffer Block
{
	highp vec3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((var[0]), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((var[1]), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((var[2]), vec3(1.0, -1.0, 7.0)) && allOk;
	allOk = compare_vec3((var[3]), vec3(-1.0, -9.0, 3.0)) && allOk;
	allOk = compare_vec3((var[4]), vec3(-7.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec3((var[5]), vec3(3.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec3((var[6]), vec3(1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3((var[7]), vec3(5.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3((var[8]), vec3(-3.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec3((var[9]), vec3(8.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((var[10]), vec3(5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3((var[11]), vec3(-7.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec3((var[12]), vec3(-1.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((var[13]), vec3(2.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3((var[14]), vec3(8.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3((var[15]), vec3(6.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3((var[16]), vec3(-6.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec3((var[17]), vec3(2.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec3((var[18]), vec3(-8.0, -2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(-3, -3, -8)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-9.0, 1.0, 3.0, -3.0, -7.0, 8.0, -8.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(-2.0, 4.0, 8.0, -7.0, -3.0, -2.0, -8.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(-8.0, 9.0, 0.0, 9.0, 7.0, -8.0, 1.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(-9.0, 1.0, -4.0, -5.0, -5.0, -2.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(2.0, -2.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, buffer_reference) buffer Block
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
	allOk = compare_mat2x3(block.var, mat2x3(6.0, 0.0, 4.0, -7.0, -8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(-3.0, -5.0, -2.0, -1.0, -6.0, 1.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(-1.0, -1.0, 3.0, 5.0, 6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(-9.0, -1.0, -7.0, 6.0, 0.0, -8.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(0.0, -5.0, 6.0, -5.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(5.0, 1.0, 2.0, -5.0, 5.0, 3.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(4.0, -4.0, 8.0, -4.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-9.0, -9.0, 5.0, -4.0));
	block.var[1] = (vec4(7.0, 6.0, -1.0, 7.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.var), 7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (7.0);
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(-6.0, 3.0, 2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(7.0, 5.0));
	block.var[1] = (vec2(0.0, 7.0));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(3.0, -4.0, 1.0, -6.0, 0.0, 0.0, -1.0, -6.0, -3.0, 1.0, 1.0, 9.0, 6.0, 8.0, 9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(-7.0, 2.0, -1.0, 7.0, -7.0, 9.0, 1.0, 3.0, -1.0, -4.0, -5.0, 4.0, 4.0, 3.0, 2.0, 7.0));
}
#version 450
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

layout(scalar, row_major, buffer_reference) buffer Block
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_float(block.var[0][0], 3.0) && allOk;
	allOk = compare_float(block.var[0][1], -8.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[0][3], 4.0) && allOk;
	allOk = compare_float(block.var[1][0], 8.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_float(block.var[1][2], -1.0) && allOk;
	allOk = compare_float(block.var[1][3], -5.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(3.0, -8.0, -2.0, 4.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(8.0, -9.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0] = (vec4(-4.0, -7.0, -4.0, -8.0));
	block.var[1] = (vec4(4.0, -1.0, -1.0, -6.0));
}
#version 450
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
	allOk = compare_float((block.padding), 4.0) && allOk;
	allOk = compare_mat2x4(block.var, mat2x4(-4.0, 8.0, -4.0, -3.0, -1.0, -9.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0] = (vec4(-9.0, 5.0, -4.0, 7.0));
	block.var[1] = (vec4(6.0, -1.0, 7.0, 3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_float(block.var[0][0], 9.0) && allOk;
	allOk = compare_float(block.var[0][1], -2.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][2], -9.0) && allOk;
	allOk = compare_float(block.var[2][0], -7.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_float(block.var[2][2], -6.0) && allOk;
	allOk = compare_float(block.var[3][0], 1.0) && allOk;
	allOk = compare_float(block.var[3][1], -9.0) && allOk;
	allOk = compare_float(block.var[3][2], -5.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(9.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-4.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-7.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(1.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0] = (vec3(-9.0, 9.0, -9.0));
	block.var[1] = (vec3(6.0, 9.0, -6.0));
	block.var[2] = (vec3(-2.0, 0.0, -9.0));
	block.var[3] = (vec3(6.0, -2.0, 6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], 0.0) && allOk;
	allOk = compare_float(block.var[0][2], -6.0) && allOk;
	allOk = compare_float(block.var[1][0], 8.0) && allOk;
	allOk = compare_float(block.var[1][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][2], 6.0) && allOk;
	allOk = compare_float(block.var[2][0], -4.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_float(block.var[2][2], 8.0) && allOk;
	allOk = compare_float(block.var[3][0], -4.0) && allOk;
	allOk = compare_float(block.var[3][1], -2.0) && allOk;
	allOk = compare_float(block.var[3][2], 0.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-4.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(8.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-4.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-4.0, -2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0] = (vec3(-8.0, 7.0, -1.0));
	block.var[1] = (vec3(-2.0, -9.0, 9.0));
	block.var[2] = (vec3(1.0, 7.0, 2.0));
	block.var[3] = (vec3(-1.0, -3.0, 6.0));
}
#version 450
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
	bvec4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((block.var[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[2]), bvec4(false, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (bvec4(true, true, true, false));
	block.var[1] = (bvec4(true, false, false, false));
	block.var[2] = (bvec4(false, true, true, true));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	block.var[1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	block.var[2] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3], mat3x2(1.0, 1.0, -3.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[4], mat3x2(2.0, 8.0, 7.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[5], mat3x2(-4.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[6], mat3x2(8.0, -8.0, -7.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[7], mat3x2(3.0, 9.0, -2.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[8], mat3x2(-3.0, 9.0, 6.0, 2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[9], mat3x2(7.0, 1.0, 1.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[10], mat3x2(2.0, 7.0, -2.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[11], mat3x2(-8.0, -1.0, -7.0, 9.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[12], mat3x2(-7.0, 3.0, -2.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[13], mat3x2(0.0, 9.0, -3.0, 8.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[14], mat3x2(8.0, -3.0, 6.0, 0.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[15], mat3x2(6.0, -8.0, 1.0, -6.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[16], mat3x2(8.0, 9.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[17], mat3x2(1.0, -7.0, 6.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[18], mat3x2(-9.0, 9.0, 5.0, -2.0, -4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	block.var[1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	block.var[2] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
	block.var[3] = (mat3x2(2.0, 1.0, -5.0, 0.0, -3.0, 1.0));
	block.var[4] = (mat3x2(-4.0, 4.0, 5.0, -5.0, -6.0, 3.0));
	block.var[5] = (mat3x2(1.0, -2.0, 3.0, -8.0, -6.0, 2.0));
	block.var[6] = (mat3x2(-5.0, -4.0, -8.0, 9.0, -9.0, -8.0));
	block.var[7] = (mat3x2(8.0, -4.0, 1.0, -1.0, 7.0, 0.0));
	block.var[8] = (mat3x2(1.0, -3.0, 6.0, -4.0, -6.0, -5.0));
	block.var[9] = (mat3x2(-6.0, -4.0, 6.0, 4.0, 2.0, -8.0));
	block.var[10] = (mat3x2(2.0, 1.0, -3.0, -3.0, -5.0, -1.0));
	block.var[11] = (mat3x2(6.0, 9.0, 9.0, 9.0, -4.0, 8.0));
	block.var[12] = (mat3x2(-7.0, -7.0, -1.0, 1.0, -5.0, 2.0));
	block.var[13] = (mat3x2(5.0, 5.0, 3.0, -9.0, 7.0, -4.0));
	block.var[14] = (mat3x2(-1.0, -7.0, -6.0, -4.0, -4.0, 8.0));
	block.var[15] = (mat3x2(3.0, -5.0, 8.0, 6.0, 0.0, -2.0));
	block.var[16] = (mat3x2(9.0, -9.0, -7.0, -9.0, -9.0, 4.0));
	block.var[17] = (mat3x2(5.0, 9.0, 6.0, -1.0, 0.0, -2.0));
	block.var[18] = (mat3x2(-2.0, -4.0, 7.0, -2.0, 0.0, 0.0));
}
#version 450
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
	highp vec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((block.var[0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((block.var[1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[2]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[3]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[4]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((block.var[5]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[6]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((block.var[7]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[8]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((block.var[9]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[10]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((block.var[11]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((block.var[12]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((block.var[13]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[14]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[15]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((block.var[16]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[17]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((block.var[18]), vec2(-5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(3.0, 8.0));
	block.var[1] = (vec2(7.0, -1.0));
	block.var[2] = (vec2(-4.0, 8.0));
	block.var[3] = (vec2(-2.0, -5.0));
	block.var[4] = (vec2(-2.0, 5.0));
	block.var[5] = (vec2(6.0, -2.0));
	block.var[6] = (vec2(-6.0, -6.0));
	block.var[7] = (vec2(1.0, 6.0));
	block.var[8] = (vec2(-7.0, 6.0));
	block.var[9] = (vec2(1.0, -6.0));
	block.var[10] = (vec2(-9.0, 0.0));
	block.var[11] = (vec2(-8.0, -4.0));
	block.var[12] = (vec2(-6.0, -2.0));
	block.var[13] = (vec2(5.0, 4.0));
	block.var[14] = (vec2(0.0, 0.0));
	block.var[15] = (vec2(-4.0, -9.0));
	block.var[16] = (vec2(-2.0, 2.0));
	block.var[17] = (vec2(-2.0, 8.0));
	block.var[18] = (vec2(-4.0, -4.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(4.0, 4.0, 9.0, -7.0, 9.0, 2.0, 3.0, 7.0, 0.0, -9.0, 2.0, -1.0, -8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(0.0, -3.0, -1.0, -1.0, -6.0, 1.0, -8.0, 1.0, 5.0, 0.0, 2.0, -1.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(7.0, 5.0, -2.0, -4.0, 0.0, 1.0, -6.0, -3.0, -1.0, -7.0, -7.0, -6.0, 1.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(8.0, -3.0, 9.0, 6.0, -2.0, -9.0, 4.0, 5.0, 6.0, 4.0, -3.0, -8.0, 6.0, 5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(-2.0, 5.0, 8.0, 4.0, -4.0, 9.0, 3.0, -5.0, 1.0, -6.0, 1.0, -5.0, 8.0, 7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(3.0, 0.0, -3.0, 3.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -9.0, -7.0, 1.0, -5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(0.0, 0.0, -1.0, 0.0, -9.0, 5.0, 4.0, 0.0, -6.0, -7.0, 1.0, -9.0, -4.0, -4.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	block.var[0][1] = (vec4(2.0, -4.0, 3.0, -5.0));
	block.var[0][2] = (vec4(2.0, 3.0, 8.0, 8.0));
	block.var[0][3] = (vec4(3.0, 0.0, -4.0, -1.0));
	block.var[1][0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	block.var[1][1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	block.var[1][2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	block.var[1][3] = (vec4(6.0, -9.0, -1.0, -5.0));
	block.var[2][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	block.var[2][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	block.var[2][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	block.var[2][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
	block.var[3][0] = (vec4(-3.0, 2.0, 9.0, -4.0));
	block.var[3][1] = (vec4(2.0, 9.0, -9.0, -2.0));
	block.var[3][2] = (vec4(-1.0, 1.0, -9.0, 0.0));
	block.var[3][3] = (vec4(-7.0, 7.0, -3.0, -9.0));
	block.var[4][0] = (vec4(-1.0, 0.0, 7.0, 7.0));
	block.var[4][1] = (vec4(-5.0, -2.0, -6.0, 0.0));
	block.var[4][2] = (vec4(-2.0, 1.0, -2.0, 4.0));
	block.var[4][3] = (vec4(4.0, 0.0, 0.0, -2.0));
	block.var[5][0] = (vec4(4.0, 7.0, -5.0, -3.0));
	block.var[5][1] = (vec4(9.0, 1.0, 5.0, 5.0));
	block.var[5][2] = (vec4(9.0, -4.0, -6.0, 8.0));
	block.var[5][3] = (vec4(1.0, -5.0, 5.0, -3.0));
	block.var[6][0] = (vec4(-4.0, -3.0, 4.0, -8.0));
	block.var[6][1] = (vec4(-2.0, 0.0, -8.0, 2.0));
	block.var[6][2] = (vec4(-3.0, -5.0, 3.0, -2.0));
	block.var[6][3] = (vec4(-9.0, -8.0, -3.0, 5.0));
	block.var[7][0] = (vec4(-9.0, 6.0, -6.0, 7.0));
	block.var[7][1] = (vec4(-8.0, 2.0, 7.0, -5.0));
	block.var[7][2] = (vec4(0.0, -4.0, -7.0, 6.0));
	block.var[7][3] = (vec4(0.0, 0.0, 4.0, -5.0));
	block.var[8][0] = (vec4(-1.0, -9.0, -7.0, 5.0));
	block.var[8][1] = (vec4(3.0, 9.0, -8.0, -6.0));
	block.var[8][2] = (vec4(-3.0, 6.0, -9.0, 4.0));
	block.var[8][3] = (vec4(6.0, -6.0, -6.0, -2.0));
	block.var[9][0] = (vec4(-8.0, -3.0, -8.0, 5.0));
	block.var[9][1] = (vec4(6.0, -9.0, -7.0, -7.0));
	block.var[9][2] = (vec4(6.0, 1.0, 0.0, -3.0));
	block.var[9][3] = (vec4(4.0, 1.0, -7.0, 4.0));
	block.var[10][0] = (vec4(6.0, 4.0, 3.0, -5.0));
	block.var[10][1] = (vec4(-8.0, 0.0, -2.0, 7.0));
	block.var[10][2] = (vec4(5.0, -1.0, -3.0, -2.0));
	block.var[10][3] = (vec4(-6.0, -9.0, -3.0, 5.0));
	block.var[11][0] = (vec4(8.0, 7.0, -4.0, 1.0));
	block.var[11][1] = (vec4(6.0, -9.0, 8.0, 3.0));
	block.var[11][2] = (vec4(-6.0, -7.0, 7.0, -1.0));
	block.var[11][3] = (vec4(-7.0, 6.0, -5.0, 9.0));
	block.var[12][0] = (vec4(-3.0, 9.0, 5.0, -2.0));
	block.var[12][1] = (vec4(-7.0, 3.0, 3.0, 1.0));
	block.var[12][2] = (vec4(-7.0, -9.0, -5.0, -7.0));
	block.var[12][3] = (vec4(-7.0, -8.0, -2.0, -8.0));
	block.var[13][0] = (vec4(3.0, 7.0, 3.0, 7.0));
	block.var[13][1] = (vec4(-8.0, 9.0, -9.0, -9.0));
	block.var[13][2] = (vec4(3.0, -4.0, -8.0, 3.0));
	block.var[13][3] = (vec4(9.0, -7.0, -5.0, -5.0));
	block.var[14][0] = (vec4(2.0, 2.0, -3.0, 9.0));
	block.var[14][1] = (vec4(0.0, -6.0, 7.0, 1.0));
	block.var[14][2] = (vec4(-1.0, 2.0, -7.0, 2.0));
	block.var[14][3] = (vec4(-1.0, -6.0, -8.0, 1.0));
	block.var[15][0] = (vec4(1.0, -4.0, -6.0, -4.0));
	block.var[15][1] = (vec4(-9.0, 0.0, -2.0, 6.0));
	block.var[15][2] = (vec4(3.0, 3.0, 4.0, -6.0));
	block.var[15][3] = (vec4(-7.0, 9.0, -1.0, 6.0));
	block.var[16][0] = (vec4(-8.0, -1.0, 0.0, -8.0));
	block.var[16][1] = (vec4(3.0, -1.0, 9.0, -7.0));
	block.var[16][2] = (vec4(-4.0, 7.0, 9.0, -5.0));
	block.var[16][3] = (vec4(2.0, -8.0, 7.0, 8.0));
	block.var[17][0] = (vec4(1.0, -8.0, -3.0, -8.0));
	block.var[17][1] = (vec4(-8.0, -6.0, -2.0, -9.0));
	block.var[17][2] = (vec4(-4.0, 4.0, -9.0, -5.0));
	block.var[17][3] = (vec4(-2.0, 9.0, -7.0, -6.0));
	block.var[18][0] = (vec4(-2.0, -9.0, -3.0, -3.0));
	block.var[18][1] = (vec4(-3.0, 0.0, -7.0, 1.0));
	block.var[18][2] = (vec4(6.0, -1.0, 3.0, 4.0));
	block.var[18][3] = (vec4(8.0, 7.0, 7.0, -9.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
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

layout(scalar, row_major, buffer_reference) buffer Block
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

layout(std140, buffer_reference) buffer Block
{
	u8vec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(block.var[0][0]), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][1]), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][2]), uvec4(1u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][0]), uvec4(7u, 7u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][1]), uvec4(3u, 3u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][2]), uvec4(7u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][0]), uvec4(6u, 9u, 5u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][1]), uvec4(5u, 2u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][2]), uvec4(8u, 3u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][0]), uvec4(5u, 7u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][1]), uvec4(5u, 8u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][2]), uvec4(8u, 6u, 3u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	block.var[0][1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	block.var[0][2] = u8vec4(uvec4(6u, 7u, 1u, 9u));
	block.var[1][0] = u8vec4(uvec4(8u, 9u, 3u, 3u));
	block.var[1][1] = u8vec4(uvec4(3u, 9u, 0u, 6u));
	block.var[1][2] = u8vec4(uvec4(8u, 7u, 6u, 7u));
	block.var[2][0] = u8vec4(uvec4(7u, 7u, 4u, 8u));
	block.var[2][1] = u8vec4(uvec4(8u, 5u, 3u, 1u));
	block.var[2][2] = u8vec4(uvec4(1u, 4u, 7u, 1u));
	block.var[3][0] = u8vec4(uvec4(3u, 6u, 3u, 3u));
	block.var[3][1] = u8vec4(uvec4(4u, 7u, 8u, 8u));
	block.var[3][2] = u8vec4(uvec4(1u, 7u, 7u, 2u));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_mat4(block.var[0][0], mat4(0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(-8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(-5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(-9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(-2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(-6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(-7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0] = (mat4(-8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0, 1.0));
	block.var[0][1] = (mat4(6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0, 1.0));
	block.var[0][2] = (mat4(-7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0, 2.0));
	block.var[1][0] = (mat4(3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0, -4.0));
	block.var[1][1] = (mat4(-1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0, -5.0));
	block.var[1][2] = (mat4(-1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0, 3.0));
	block.var[2][0] = (mat4(6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0, 1.0));
	block.var[2][1] = (mat4(2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0, 2.0));
	block.var[2][2] = (mat4(4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0, 8.0));
	block.var[3][0] = (mat4(9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0, -8.0));
	block.var[3][1] = (mat4(6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0, -2.0));
	block.var[3][2] = (mat4(0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0, 5.0));
}
#version 450
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
	highp int var[4][2][3];
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
	allOk = compare_int((block.var[0][0][2]), 9) && allOk;
	allOk = compare_int((block.var[0][1][0]), 5) && allOk;
	allOk = compare_int((block.var[0][1][1]), -3) && allOk;
	allOk = compare_int((block.var[0][1][2]), 4) && allOk;
	allOk = compare_int((block.var[1][0][0]), -6) && allOk;
	allOk = compare_int((block.var[1][0][1]), -9) && allOk;
	allOk = compare_int((block.var[1][0][2]), -8) && allOk;
	allOk = compare_int((block.var[1][1][0]), 4) && allOk;
	allOk = compare_int((block.var[1][1][1]), -9) && allOk;
	allOk = compare_int((block.var[1][1][2]), -9) && allOk;
	allOk = compare_int((block.var[2][0][0]), 8) && allOk;
	allOk = compare_int((block.var[2][0][1]), -9) && allOk;
	allOk = compare_int((block.var[2][0][2]), -1) && allOk;
	allOk = compare_int((block.var[2][1][0]), 3) && allOk;
	allOk = compare_int((block.var[2][1][1]), -1) && allOk;
	allOk = compare_int((block.var[2][1][2]), -9) && allOk;
	allOk = compare_int((block.var[3][0][0]), 0) && allOk;
	allOk = compare_int((block.var[3][0][1]), -9) && allOk;
	allOk = compare_int((block.var[3][0][2]), 5) && allOk;
	allOk = compare_int((block.var[3][1][0]), -7) && allOk;
	allOk = compare_int((block.var[3][1][1]), 9) && allOk;
	allOk = compare_int((block.var[3][1][2]), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (8);
	block.var[0][0][1] = (2);
	block.var[0][0][2] = (-5);
	block.var[0][1][0] = (-4);
	block.var[0][1][1] = (9);
	block.var[0][1][2] = (-8);
	block.var[1][0][0] = (0);
	block.var[1][0][1] = (-7);
	block.var[1][0][2] = (-7);
	block.var[1][1][0] = (4);
	block.var[1][1][1] = (-4);
	block.var[1][1][2] = (5);
	block.var[2][0][0] = (-8);
	block.var[2][0][1] = (6);
	block.var[2][0][2] = (-6);
	block.var[2][1][0] = (-3);
	block.var[2][1][1] = (-3);
	block.var[2][1][2] = (6);
	block.var[3][0][0] = (6);
	block.var[3][0][1] = (-5);
	block.var[3][0][2] = (5);
	block.var[3][1][0] = (-2);
	block.var[3][1][1] = (5);
	block.var[3][1][2] = (7);
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(4.0, 4.0, 9.0, -7.0, 9.0, 2.0, 3.0, 7.0, 0.0, -9.0, 2.0, -1.0, -8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(0.0, -3.0, -1.0, -1.0, -6.0, 1.0, -8.0, 1.0, 5.0, 0.0, 2.0, -1.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(7.0, 5.0, -2.0, -4.0, 0.0, 1.0, -6.0, -3.0, -1.0, -7.0, -7.0, -6.0, 1.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(8.0, -3.0, 9.0, 6.0, -2.0, -9.0, 4.0, 5.0, 6.0, 4.0, -3.0, -8.0, 6.0, 5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-2.0, 5.0, 8.0, 4.0, -4.0, 9.0, 3.0, -5.0, 1.0, -6.0, 1.0, -5.0, 8.0, 7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(3.0, 0.0, -3.0, 3.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -9.0, -7.0, 1.0, -5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(0.0, 0.0, -1.0, 0.0, -9.0, 5.0, 4.0, 0.0, -6.0, -7.0, 1.0, -9.0, -4.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(0.0, 5.0, -7.0, -5.0, 9.0, 2.0, -2.0, 5.0, 8.0, -7.0, 9.0, 9.0, -8.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(5.0, 3.0, 5.0, -5.0, 6.0, 3.0, 0.0, -9.0, -1.0, 0.0, -8.0, 3.0, 4.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-6.0, -9.0, -8.0, -2.0, -6.0, -8.0, 8.0, 4.0, 4.0, 1.0, 5.0, 0.0, -1.0, 4.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(-2.0, 2.0, 9.0, 7.0, -2.0, -6.0, -3.0, -7.0, 1.0, 2.0, -3.0, 0.0, -5.0, 5.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(3.0, 5.0, 2.0, -6.0, 9.0, 7.0, 4.0, 4.0, 5.0, 8.0, 4.0, -9.0, 3.0, -7.0, 7.0, -9.0)) && allOk;
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
	block.var[0][0][2][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	block.var[0][0][2][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	block.var[0][0][2][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	block.var[0][0][2][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
	block.var[0][1][0][0] = (vec4(-3.0, 9.0, 5.0, -2.0));
	block.var[0][1][0][1] = (vec4(-7.0, 3.0, 3.0, 1.0));
	block.var[0][1][0][2] = (vec4(-7.0, -9.0, -5.0, -7.0));
	block.var[0][1][0][3] = (vec4(-7.0, -8.0, -2.0, -8.0));
	block.var[0][1][1][0] = (vec4(3.0, 7.0, 3.0, 7.0));
	block.var[0][1][1][1] = (vec4(-8.0, 9.0, -9.0, -9.0));
	block.var[0][1][1][2] = (vec4(3.0, -4.0, -8.0, 3.0));
	block.var[0][1][1][3] = (vec4(9.0, -7.0, -5.0, -5.0));
	block.var[0][1][2][0] = (vec4(2.0, 2.0, -3.0, 9.0));
	block.var[0][1][2][1] = (vec4(0.0, -6.0, 7.0, 1.0));
	block.var[0][1][2][2] = (vec4(-1.0, 2.0, -7.0, 2.0));
	block.var[0][1][2][3] = (vec4(-1.0, -6.0, -8.0, 1.0));
	block.var[1][0][0][0] = (vec4(-3.0, 2.0, 9.0, -4.0));
	block.var[1][0][0][1] = (vec4(2.0, 9.0, -9.0, -2.0));
	block.var[1][0][0][2] = (vec4(-1.0, 1.0, -9.0, 0.0));
	block.var[1][0][0][3] = (vec4(-7.0, 7.0, -3.0, -9.0));
	block.var[1][0][1][0] = (vec4(-1.0, 0.0, 7.0, 7.0));
	block.var[1][0][1][1] = (vec4(-5.0, -2.0, -6.0, 0.0));
	block.var[1][0][1][2] = (vec4(-2.0, 1.0, -2.0, 4.0));
	block.var[1][0][1][3] = (vec4(4.0, 0.0, 0.0, -2.0));
	block.var[1][0][2][0] = (vec4(4.0, 7.0, -5.0, -3.0));
	block.var[1][0][2][1] = (vec4(9.0, 1.0, 5.0, 5.0));
	block.var[1][0][2][2] = (vec4(9.0, -4.0, -6.0, 8.0));
	block.var[1][0][2][3] = (vec4(1.0, -5.0, 5.0, -3.0));
	block.var[1][1][0][0] = (vec4(1.0, -4.0, -6.0, -4.0));
	block.var[1][1][0][1] = (vec4(-9.0, 0.0, -2.0, 6.0));
	block.var[1][1][0][2] = (vec4(3.0, 3.0, 4.0, -6.0));
	block.var[1][1][0][3] = (vec4(-7.0, 9.0, -1.0, 6.0));
	block.var[1][1][1][0] = (vec4(-8.0, -1.0, 0.0, -8.0));
	block.var[1][1][1][1] = (vec4(3.0, -1.0, 9.0, -7.0));
	block.var[1][1][1][2] = (vec4(-4.0, 7.0, 9.0, -5.0));
	block.var[1][1][1][3] = (vec4(2.0, -8.0, 7.0, 8.0));
	block.var[1][1][2][0] = (vec4(1.0, -8.0, -3.0, -8.0));
	block.var[1][1][2][1] = (vec4(-8.0, -6.0, -2.0, -9.0));
	block.var[1][1][2][2] = (vec4(-4.0, 4.0, -9.0, -5.0));
	block.var[1][1][2][3] = (vec4(-2.0, 9.0, -7.0, -6.0));
	block.var[2][0][0][0] = (vec4(-4.0, -3.0, 4.0, -8.0));
	block.var[2][0][0][1] = (vec4(-2.0, 0.0, -8.0, 2.0));
	block.var[2][0][0][2] = (vec4(-3.0, -5.0, 3.0, -2.0));
	block.var[2][0][0][3] = (vec4(-9.0, -8.0, -3.0, 5.0));
	block.var[2][0][1][0] = (vec4(-9.0, 6.0, -6.0, 7.0));
	block.var[2][0][1][1] = (vec4(-8.0, 2.0, 7.0, -5.0));
	block.var[2][0][1][2] = (vec4(0.0, -4.0, -7.0, 6.0));
	block.var[2][0][1][3] = (vec4(0.0, 0.0, 4.0, -5.0));
	block.var[2][0][2][0] = (vec4(-1.0, -9.0, -7.0, 5.0));
	block.var[2][0][2][1] = (vec4(3.0, 9.0, -8.0, -6.0));
	block.var[2][0][2][2] = (vec4(-3.0, 6.0, -9.0, 4.0));
	block.var[2][0][2][3] = (vec4(6.0, -6.0, -6.0, -2.0));
	block.var[2][1][0][0] = (vec4(-2.0, -9.0, -3.0, -3.0));
	block.var[2][1][0][1] = (vec4(-3.0, 0.0, -7.0, 1.0));
	block.var[2][1][0][2] = (vec4(6.0, -1.0, 3.0, 4.0));
	block.var[2][1][0][3] = (vec4(8.0, 7.0, 7.0, -9.0));
	block.var[2][1][1][0] = (vec4(-9.0, 3.0, 5.0, 7.0));
	block.var[2][1][1][1] = (vec4(3.0, -6.0, -1.0, -5.0));
	block.var[2][1][1][2] = (vec4(9.0, -7.0, 9.0, -7.0));
	block.var[2][1][1][3] = (vec4(7.0, 5.0, -8.0, 6.0));
	block.var[2][1][2][0] = (vec4(1.0, 7.0, -7.0, -7.0));
	block.var[2][1][2][1] = (vec4(-9.0, -7.0, -8.0, 7.0));
	block.var[2][1][2][2] = (vec4(5.0, -2.0, 5.0, -4.0));
	block.var[2][1][2][3] = (vec4(-8.0, 0.0, 0.0, 7.0));
	block.var[3][0][0][0] = (vec4(-8.0, -3.0, -8.0, 5.0));
	block.var[3][0][0][1] = (vec4(6.0, -9.0, -7.0, -7.0));
	block.var[3][0][0][2] = (vec4(6.0, 1.0, 0.0, -3.0));
	block.var[3][0][0][3] = (vec4(4.0, 1.0, -7.0, 4.0));
	block.var[3][0][1][0] = (vec4(6.0, 4.0, 3.0, -5.0));
	block.var[3][0][1][1] = (vec4(-8.0, 0.0, -2.0, 7.0));
	block.var[3][0][1][2] = (vec4(5.0, -1.0, -3.0, -2.0));
	block.var[3][0][1][3] = (vec4(-6.0, -9.0, -3.0, 5.0));
	block.var[3][0][2][0] = (vec4(8.0, 7.0, -4.0, 1.0));
	block.var[3][0][2][1] = (vec4(6.0, -9.0, 8.0, 3.0));
	block.var[3][0][2][2] = (vec4(-6.0, -7.0, 7.0, -1.0));
	block.var[3][0][2][3] = (vec4(-7.0, 6.0, -5.0, 9.0));
	block.var[3][1][0][0] = (vec4(-9.0, 2.0, -4.0, 0.0));
	block.var[3][1][0][1] = (vec4(-5.0, -8.0, -8.0, 2.0));
	block.var[3][1][0][2] = (vec4(9.0, -9.0, -6.0, 5.0));
	block.var[3][1][0][3] = (vec4(0.0, 9.0, 6.0, 5.0));
	block.var[3][1][1][0] = (vec4(-2.0, -9.0, 6.0, -7.0));
	block.var[3][1][1][1] = (vec4(5.0, 4.0, 2.0, -6.0));
	block.var[3][1][1][2] = (vec4(-8.0, -7.0, 4.0, 1.0));
	block.var[3][1][1][3] = (vec4(1.0, 1.0, 6.0, 2.0));
	block.var[3][1][2][0] = (vec4(-7.0, 8.0, -8.0, 4.0));
	block.var[3][1][2][1] = (vec4(2.0, 3.0, -3.0, -2.0));
	block.var[3][1][2][2] = (vec4(9.0, 1.0, -8.0, 2.0));
	block.var[3][1][2][3] = (vec4(2.0, -1.0, -9.0, 9.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(-7.0, -9.0, 9.0, 4.0, 9.0, 5.0, -2.0, -3.0, 8.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(1.0, 1.0, -3.0, 0.0, -6.0, -1.0, -5.0, -8.0, -9.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(9.0, 0.0, -8.0, 0.0, -8.0, 1.0, -3.0, 3.0, -4.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-4.0, -3.0, 7.0, 1.0, -8.0, -8.0, -5.0, 8.0, -6.0, 9.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-9.0, -2.0, 7.0, -7.0, 5.0, -9.0, 2.0, 8.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(-1.0, -3.0, 3.0, -5.0, 9.0, -5.0, 3.0, 9.0, 7.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(8.0, -7.0, 0.0, 6.0, 2.0, -6.0, 7.0, -8.0, -5.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(2.0, 6.0, -9.0, -2.0, 6.0, 0.0, -8.0, -1.0, -7.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(7.0, -2.0, 9.0, 0.0, 7.0, 3.0, -1.0, 8.0, 6.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(5.0, 9.0, 6.0, 2.0, 5.0, 9.0, 8.0, -5.0, -1.0, -4.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(-6.0, -2.0, -7.0, -3.0, -7.0, 3.0, -9.0, 4.0, -6.0, -1.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(5.0, 1.0, -1.0, 7.0, 1.0, 7.0, -9.0, -8.0, 8.0, -5.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(8.0, 8.0, -2.0, 8.0));
	block.var[0][0][0][1] = (vec4(8.0, 3.0, 5.0, -5.0));
	block.var[0][0][0][2] = (vec4(7.0, 6.0, -9.0, 3.0));
	block.var[0][0][1][0] = (vec4(0.0, -3.0, 1.0, -9.0));
	block.var[0][0][1][1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	block.var[0][0][1][2] = (vec4(9.0, 0.0, -9.0, -2.0));
	block.var[0][0][2][0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	block.var[0][0][2][1] = (vec4(1.0, -2.0, -2.0, -1.0));
	block.var[0][0][2][2] = (vec4(-7.0, 8.0, 0.0, -6.0));
	block.var[0][1][0][0] = (vec4(4.0, -1.0, 2.0, -8.0));
	block.var[0][1][0][1] = (vec4(-6.0, 4.0, -8.0, 9.0));
	block.var[0][1][0][2] = (vec4(0.0, 7.0, -2.0, 2.0));
	block.var[0][1][1][0] = (vec4(2.0, 9.0, -9.0, 2.0));
	block.var[0][1][1][1] = (vec4(1.0, 5.0, 5.0, 5.0));
	block.var[0][1][1][2] = (vec4(0.0, 9.0, 8.0, 7.0));
	block.var[0][1][2][0] = (vec4(7.0, 5.0, -7.0, -6.0));
	block.var[0][1][2][1] = (vec4(-4.0, 4.0, -5.0, -7.0));
	block.var[0][1][2][2] = (vec4(2.0, 2.0, 1.0, -7.0));
	block.var[1][0][0][0] = (vec4(-1.0, 7.0, -6.0, -1.0));
	block.var[1][0][0][1] = (vec4(-7.0, -8.0, 7.0, -8.0));
	block.var[1][0][0][2] = (vec4(6.0, -8.0, 2.0, -5.0));
	block.var[1][0][1][0] = (vec4(9.0, -7.0, 4.0, -1.0));
	block.var[1][0][1][1] = (vec4(-3.0, -8.0, -1.0, 1.0));
	block.var[1][0][1][2] = (vec4(-6.0, -4.0, -8.0, 4.0));
	block.var[1][0][2][0] = (vec4(5.0, 0.0, -6.0, 5.0));
	block.var[1][0][2][1] = (vec4(-1.0, 4.0, 3.0, -6.0));
	block.var[1][0][2][2] = (vec4(1.0, 8.0, -2.0, 3.0));
	block.var[1][1][0][0] = (vec4(1.0, -1.0, 9.0, -4.0));
	block.var[1][1][0][1] = (vec4(4.0, 1.0, 7.0, -4.0));
	block.var[1][1][0][2] = (vec4(1.0, 9.0, -7.0, 4.0));
	block.var[1][1][1][0] = (vec4(-2.0, 5.0, -1.0, 9.0));
	block.var[1][1][1][1] = (vec4(-9.0, -6.0, 3.0, 7.0));
	block.var[1][1][1][2] = (vec4(-1.0, -6.0, 3.0, -3.0));
	block.var[1][1][2][0] = (vec4(1.0, 7.0, 2.0, -9.0));
	block.var[1][1][2][1] = (vec4(0.0, -8.0, -8.0, 4.0));
	block.var[1][1][2][2] = (vec4(7.0, 6.0, 8.0, -2.0));
	block.var[2][0][0][0] = (vec4(-1.0, -9.0, 4.0, 9.0));
	block.var[2][0][0][1] = (vec4(0.0, 2.0, -7.0, -7.0));
	block.var[2][0][0][2] = (vec4(-1.0, 8.0, -9.0, -3.0));
	block.var[2][0][1][0] = (vec4(5.0, 7.0, -8.0, 1.0));
	block.var[2][0][1][1] = (vec4(-5.0, 0.0, -7.0, -3.0));
	block.var[2][0][1][2] = (vec4(-5.0, -4.0, 3.0, -5.0));
	block.var[2][0][2][0] = (vec4(4.0, 5.0, -9.0, -6.0));
	block.var[2][0][2][1] = (vec4(5.0, 3.0, -6.0, -7.0));
	block.var[2][0][2][2] = (vec4(-3.0, 9.0, 3.0, -7.0));
	block.var[2][1][0][0] = (vec4(8.0, 9.0, -2.0, -1.0));
	block.var[2][1][0][1] = (vec4(7.0, -4.0, -8.0, 9.0));
	block.var[2][1][0][2] = (vec4(-5.0, 7.0, 9.0, -6.0));
	block.var[2][1][1][0] = (vec4(-2.0, 8.0, -6.0, 9.0));
	block.var[2][1][1][1] = (vec4(-3.0, 4.0, 1.0, -8.0));
	block.var[2][1][1][2] = (vec4(9.0, -1.0, 4.0, 6.0));
	block.var[2][1][2][0] = (vec4(6.0, -5.0, -8.0, -2.0));
	block.var[2][1][2][1] = (vec4(-3.0, -8.0, 3.0, 8.0));
	block.var[2][1][2][2] = (vec4(1.0, -5.0, 7.0, 2.0));
	block.var[3][0][0][0] = (vec4(-9.0, -9.0, 6.0, -9.0));
	block.var[3][0][0][1] = (vec4(6.0, -1.0, -1.0, -4.0));
	block.var[3][0][0][2] = (vec4(5.0, 2.0, -6.0, 8.0));
	block.var[3][0][1][0] = (vec4(4.0, 2.0, 4.0, -3.0));
	block.var[3][0][1][1] = (vec4(9.0, 8.0, 5.0, -3.0));
	block.var[3][0][1][2] = (vec4(7.0, -4.0, 6.0, 4.0));
	block.var[3][0][2][0] = (vec4(0.0, -2.0, 1.0, 8.0));
	block.var[3][0][2][1] = (vec4(1.0, 4.0, 6.0, 4.0));
	block.var[3][0][2][2] = (vec4(-2.0, 9.0, 9.0, 7.0));
	block.var[3][1][0][0] = (vec4(4.0, 7.0, 0.0, -1.0));
	block.var[3][1][0][1] = (vec4(3.0, 8.0, -5.0, 9.0));
	block.var[3][1][0][2] = (vec4(-5.0, 8.0, -3.0, 1.0));
	block.var[3][1][1][0] = (vec4(7.0, 9.0, 3.0, -6.0));
	block.var[3][1][1][1] = (vec4(-1.0, -7.0, -5.0, 3.0));
	block.var[3][1][1][2] = (vec4(-1.0, -1.0, 9.0, 3.0));
	block.var[3][1][2][0] = (vec4(5.0, 6.0, -3.0, 6.0));
	block.var[3][1][2][1] = (vec4(-2.0, 2.0, -3.0, 0.0));
	block.var[3][1][2][2] = (vec4(7.0, 8.0, -4.0, -2.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(7.0, -5.0, 4.0, -9.0, 5.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(2.0, 9.0, -6.0, -6.0, 2.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(-6.0, 9.0, -3.0, -1.0, 3.0, 8.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(7.0, -4.0, -4.0, -6.0, 9.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-2.0, 5.0, 6.0, 4.0, -6.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(-5.0, 9.0, -4.0, -6.0, 4.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-7.0, -7.0, -6.0, 2.0, 3.0, -7.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(8.0, -4.0, 1.0, 3.0, 4.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(6.0, -4.0, -6.0, 6.0, -8.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-4.0, 9.0, -1.0, -6.0, 5.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-7.0, -7.0, -9.0, 9.0, 5.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(-6.0, -5.0, -7.0, -3.0, 6.0, -7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(1.0, 0.0, 3.0, -4.0, -6.0, 5.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(1.0, -5.0, -1.0, -2.0, 2.0, 1.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(-3.0, 1.0, 1.0, 4.0, 2.0, -8.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(7.0, -9.0, -5.0, -3.0, -6.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(-4.0, -9.0, 9.0, -7.0, -6.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(8.0, 6.0, 7.0, -6.0, 0.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(-4.0, 8.0, 3.0, 1.0, -5.0, 5.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(0.0, 1.0, 4.0, 1.0, -3.0, 2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(-8.0, 6.0, 2.0, 2.0, -4.0, -7.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	block.var[0][0][1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	block.var[0][0][2] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	block.var[0][1][0] = (mat4x2(9.0, -8.0, 1.0, 3.0, 1.0, -5.0, -5.0, -5.0));
	block.var[0][1][1] = (mat4x2(2.0, -5.0, 1.0, 5.0, -5.0, 1.0, -2.0, -4.0));
	block.var[0][1][2] = (mat4x2(0.0, -1.0, -2.0, 7.0, 1.0, -5.0, -2.0, -9.0));
	block.var[1][0][0] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	block.var[1][0][1] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	block.var[1][0][2] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	block.var[1][1][0] = (mat4x2(-1.0, -5.0, -2.0, 4.0, 6.0, 1.0, -4.0, 9.0));
	block.var[1][1][1] = (mat4x2(3.0, -5.0, -9.0, -6.0, -1.0, 2.0, -9.0, 3.0));
	block.var[1][1][2] = (mat4x2(-9.0, 2.0, -3.0, -1.0, -3.0, -6.0, -9.0, 9.0));
	block.var[2][0][0] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	block.var[2][0][1] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	block.var[2][0][2] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	block.var[2][1][0] = (mat4x2(1.0, -8.0, 1.0, -6.0, 0.0, -2.0, 2.0, -8.0));
	block.var[2][1][1] = (mat4x2(2.0, -7.0, -3.0, 7.0, 5.0, 6.0, 5.0, -4.0));
	block.var[2][1][2] = (mat4x2(-1.0, -8.0, -3.0, -1.0, 7.0, -2.0, -4.0, 2.0));
	block.var[3][0][0] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	block.var[3][0][1] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	block.var[3][0][2] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
	block.var[3][1][0] = (mat4x2(7.0, 2.0, 0.0, -8.0, 0.0, 2.0, -9.0, 5.0));
	block.var[3][1][1] = (mat4x2(-8.0, -1.0, -4.0, 4.0, -3.0, -5.0, -3.0, 8.0));
	block.var[3][1][2] = (mat4x2(-4.0, -1.0, -1.0, 0.0, -9.0, 4.0, -2.0, -6.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(3.0, -6.0, 9.0, 8.0, -1.0, 8.0, -4.0, 2.0, 6.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(5.0, -1.0, 4.0, 2.0, -4.0, -2.0, -1.0, -4.0, 5.0, 9.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(2.0, -6.0, -1.0, 6.0, 9.0, -3.0, -8.0, 7.0, -5.0, 0.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-9.0, 3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(9.0, -8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(-3.0, -2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(7.0, -5.0, -4.0, -3.0, 5.0, 8.0, 9.0, -5.0, -5.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(9.0, -2.0, 0.0, 1.0, -8.0, -4.0, -9.0, 3.0, -1.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(-5.0, 1.0, 6.0, 5.0, 6.0, -1.0, -1.0, 1.0, -6.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(1.0, -2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(5.0, -9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(-1.0, -2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(0.0, 1.0, 5.0, -8.0, -8.0, 0.0, -9.0, 5.0, 2.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(5.0, -4.0, 3.0, -9.0, 3.0, 4.0, -2.0, 4.0, 4.0, 2.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(-2.0, 0.0, 6.0, 2.0, -9.0, 3.0, 3.0, -4.0, 5.0, -3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(5.0, 4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(-1.0, 6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(1.0, 6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(8.0, -9.0, -9.0, -6.0, 7.0, -8.0, 3.0, 0.0, -3.0, 3.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(-6.0, 1.0, 6.0, -1.0, 3.0, -4.0, 7.0, -7.0, -6.0, -3.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(-8.0, -1.0, 9.0, -6.0, 8.0, -4.0, -1.0, 0.0, -5.0, 0.0, -6.0, -2.0)) && allOk;
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
	block.var[0][0][2][0] = (vec3(5.0, -5.0, 7.0));
	block.var[0][0][2][1] = (vec3(-4.0, 8.0, -3.0));
	block.var[0][0][2][2] = (vec3(-2.0, 0.0, 8.0));
	block.var[0][0][2][3] = (vec3(-2.0, 6.0, -3.0));
	block.var[0][1][0][0] = (vec3(-5.0, -6.0, -3.0));
	block.var[0][1][0][1] = (vec3(-2.0, 5.0, 8.0));
	block.var[0][1][0][2] = (vec3(2.0, -9.0, 7.0));
	block.var[0][1][0][3] = (vec3(7.0, -3.0, 4.0));
	block.var[0][1][1][0] = (vec3(9.0, 4.0, 1.0));
	block.var[0][1][1][1] = (vec3(5.0, -9.0, 2.0));
	block.var[0][1][1][2] = (vec3(-7.0, -3.0, -9.0));
	block.var[0][1][1][3] = (vec3(9.0, -6.0, 3.0));
	block.var[0][1][2][0] = (vec3(-9.0, -4.0, 0.0));
	block.var[0][1][2][1] = (vec3(5.0, 8.0, 9.0));
	block.var[0][1][2][2] = (vec3(-7.0, -9.0, -5.0));
	block.var[0][1][2][3] = (vec3(0.0, -1.0, -6.0));
	block.var[1][0][0][0] = (vec3(-9.0, -2.0, -2.0));
	block.var[1][0][0][1] = (vec3(7.0, 9.0, -4.0));
	block.var[1][0][0][2] = (vec3(3.0, 1.0, 0.0));
	block.var[1][0][0][3] = (vec3(-9.0, -2.0, -7.0));
	block.var[1][0][1][0] = (vec3(-5.0, -6.0, 5.0));
	block.var[1][0][1][1] = (vec3(-2.0, -7.0, 5.0));
	block.var[1][0][1][2] = (vec3(-2.0, -6.0, 4.0));
	block.var[1][0][1][3] = (vec3(9.0, 5.0, -9.0));
	block.var[1][0][2][0] = (vec3(-3.0, 3.0, 7.0));
	block.var[1][0][2][1] = (vec3(3.0, -4.0, -8.0));
	block.var[1][0][2][2] = (vec3(-2.0, 2.0, -1.0));
	block.var[1][0][2][3] = (vec3(1.0, -9.0, 9.0));
	block.var[1][1][0][0] = (vec3(-9.0, -9.0, 9.0));
	block.var[1][1][0][1] = (vec3(9.0, -1.0, 8.0));
	block.var[1][1][0][2] = (vec3(8.0, -8.0, 4.0));
	block.var[1][1][0][3] = (vec3(9.0, -8.0, 8.0));
	block.var[1][1][1][0] = (vec3(4.0, 6.0, 1.0));
	block.var[1][1][1][1] = (vec3(-9.0, 7.0, 3.0));
	block.var[1][1][1][2] = (vec3(-4.0, -3.0, 8.0));
	block.var[1][1][1][3] = (vec3(-9.0, -9.0, 2.0));
	block.var[1][1][2][0] = (vec3(0.0, -2.0, 5.0));
	block.var[1][1][2][1] = (vec3(8.0, 4.0, -4.0));
	block.var[1][1][2][2] = (vec3(5.0, 4.0, -5.0));
	block.var[1][1][2][3] = (vec3(0.0, -3.0, 9.0));
	block.var[2][0][0][0] = (vec3(-7.0, -7.0, -7.0));
	block.var[2][0][0][1] = (vec3(6.0, -9.0, 3.0));
	block.var[2][0][0][2] = (vec3(-5.0, 2.0, 4.0));
	block.var[2][0][0][3] = (vec3(-2.0, -4.0, -6.0));
	block.var[2][0][1][0] = (vec3(-1.0, 5.0, 5.0));
	block.var[2][0][1][1] = (vec3(-9.0, -3.0, -9.0));
	block.var[2][0][1][2] = (vec3(3.0, 2.0, 0.0));
	block.var[2][0][1][3] = (vec3(0.0, -9.0, 7.0));
	block.var[2][0][2][0] = (vec3(5.0, -5.0, -2.0));
	block.var[2][0][2][1] = (vec3(6.0, 5.0, -4.0));
	block.var[2][0][2][2] = (vec3(-2.0, 9.0, -3.0));
	block.var[2][0][2][3] = (vec3(2.0, 5.0, -4.0));
	block.var[2][1][0][0] = (vec3(-4.0, -7.0, 3.0));
	block.var[2][1][0][1] = (vec3(6.0, 4.0, 1.0));
	block.var[2][1][0][2] = (vec3(-3.0, 3.0, 8.0));
	block.var[2][1][0][3] = (vec3(-6.0, 5.0, -6.0));
	block.var[2][1][1][0] = (vec3(3.0, 2.0, 3.0));
	block.var[2][1][1][1] = (vec3(1.0, -7.0, 3.0));
	block.var[2][1][1][2] = (vec3(6.0, -3.0, -2.0));
	block.var[2][1][1][3] = (vec3(3.0, 1.0, -1.0));
	block.var[2][1][2][0] = (vec3(0.0, 9.0, -4.0));
	block.var[2][1][2][1] = (vec3(6.0, -5.0, 0.0));
	block.var[2][1][2][2] = (vec3(-2.0, 4.0, 6.0));
	block.var[2][1][2][3] = (vec3(-5.0, 2.0, 4.0));
	block.var[3][0][0][0] = (vec3(6.0, 4.0, 7.0));
	block.var[3][0][0][1] = (vec3(1.0, -4.0, -6.0));
	block.var[3][0][0][2] = (vec3(4.0, -6.0, -5.0));
	block.var[3][0][0][3] = (vec3(5.0, 6.0, -1.0));
	block.var[3][0][1][0] = (vec3(6.0, 3.0, -9.0));
	block.var[3][0][1][1] = (vec3(-7.0, 3.0, -4.0));
	block.var[3][0][1][2] = (vec3(1.0, 2.0, 6.0));
	block.var[3][0][1][3] = (vec3(-2.0, 3.0, 7.0));
	block.var[3][0][2][0] = (vec3(-5.0, 8.0, -9.0));
	block.var[3][0][2][1] = (vec3(-4.0, -1.0, -9.0));
	block.var[3][0][2][2] = (vec3(5.0, 5.0, 6.0));
	block.var[3][0][2][3] = (vec3(-8.0, 1.0, -7.0));
	block.var[3][1][0][0] = (vec3(-4.0, -4.0, 0.0));
	block.var[3][1][0][1] = (vec3(-2.0, 5.0, 7.0));
	block.var[3][1][0][2] = (vec3(8.0, 8.0, -3.0));
	block.var[3][1][0][3] = (vec3(-9.0, -7.0, 5.0));
	block.var[3][1][1][0] = (vec3(6.0, -7.0, -2.0));
	block.var[3][1][1][1] = (vec3(0.0, 3.0, -5.0));
	block.var[3][1][1][2] = (vec3(-6.0, -7.0, -4.0));
	block.var[3][1][1][3] = (vec3(-8.0, 1.0, -7.0));
	block.var[3][1][2][0] = (vec3(2.0, -4.0, -7.0));
	block.var[3][1][2][1] = (vec3(-3.0, -4.0, 0.0));
	block.var[3][1][2][2] = (vec3(-8.0, -2.0, 6.0));
	block.var[3][1][2][3] = (vec3(-7.0, -7.0, 2.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat2(block.var[0][0][0], mat2(-4.0, -1.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(-6.0, -6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(-5.0, -8.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-2.0, -9.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(4.0, -8.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(2.0, 9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(4.0, 5.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-1.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(2.0, -8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(4.0, 1.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(-9.0, -9.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(-9.0, -7.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(0.0, 7.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-7.0, 8.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(-5.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(-1.0, 6.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(0.0, -9.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(-5.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(-9.0, -1.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(4.0, -9.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(6.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(-1.0, 7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-5.0, 0.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(-8.0, 7.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0][0][0] = (mat2(2.0, -8.0, -6.0, 2.0));
	block.var[0][0][1] = (mat2(-3.0, 9.0, -5.0, 4.0));
	block.var[0][0][2] = (mat2(-2.0, -6.0, -9.0, -2.0));
	block.var[0][1][0] = (mat2(-9.0, -7.0, -2.0, 2.0));
	block.var[0][1][1] = (mat2(5.0, -3.0, 7.0, -2.0));
	block.var[0][1][2] = (mat2(3.0, -1.0, -3.0, -2.0));
	block.var[1][0][0] = (mat2(-5.0, -1.0, 4.0, 3.0));
	block.var[1][0][1] = (mat2(6.0, 0.0, 1.0, -2.0));
	block.var[1][0][2] = (mat2(2.0, 8.0, -5.0, -2.0));
	block.var[1][1][0] = (mat2(1.0, -1.0, -8.0, 9.0));
	block.var[1][1][1] = (mat2(-3.0, 6.0, -2.0, 2.0));
	block.var[1][1][2] = (mat2(-4.0, -6.0, 6.0, 5.0));
	block.var[2][0][0] = (mat2(-8.0, 6.0, -7.0, 2.0));
	block.var[2][0][1] = (mat2(-8.0, 4.0, 3.0, 7.0));
	block.var[2][0][2] = (mat2(8.0, -1.0, -3.0, 7.0));
	block.var[2][1][0] = (mat2(1.0, 5.0, -6.0, -4.0));
	block.var[2][1][1] = (mat2(1.0, 6.0, -2.0, -6.0));
	block.var[2][1][2] = (mat2(3.0, -6.0, -2.0, -9.0));
	block.var[3][0][0] = (mat2(5.0, -2.0, -8.0, -5.0));
	block.var[3][0][1] = (mat2(-2.0, 1.0, -2.0, 6.0));
	block.var[3][0][2] = (mat2(1.0, 8.0, 0.0, 1.0));
	block.var[3][1][0] = (mat2(0.0, -1.0, -4.0, 0.0));
	block.var[3][1][1] = (mat2(4.0, 1.0, 7.0, 5.0));
	block.var[3][1][2] = (mat2(5.0, -4.0, -6.0, 2.0));
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(1.0, 7.0, 8.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-8.0, -9.0, -2.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(-8.0, -8.0, 8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(-5.0, 9.0, -6.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(9.0, -9.0, 3.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(-6.0, 0.0, -2.0, 2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(0.0, -5.0, -8.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(-5.0, -5.0, 6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(7.0, 0.0, 2.0, 4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(4.0, 2.0, 6.0, 8.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(-3.0, 7.0, -7.0, -6.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(-1.0, -5.0, 0.0, -2.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(1.0, -6.0, -2.0, -1.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(8.0, 5.0, -3.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(-6.0, -2.0, 1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(4.0, -9.0, 5.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(1.0, 5.0, -6.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(-6.0, -9.0, -2.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(8.0, -6.0, -6.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(-2.0, 3.0, 0.0, -6.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(0.0, 5.0, 8.0, -1.0, 9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(-7.0, -8.0, 7.0));
	block.var[0][0][0][1] = (vec3(-6.0, -3.0, -4.0));
	block.var[0][0][1][0] = (vec3(3.0, -8.0, -9.0));
	block.var[0][0][1][1] = (vec3(-2.0, 5.0, 6.0));
	block.var[0][1][0][0] = (vec3(-6.0, 3.0, 9.0));
	block.var[0][1][0][1] = (vec3(3.0, -2.0, -9.0));
	block.var[0][1][1][0] = (vec3(-7.0, -8.0, -6.0));
	block.var[0][1][1][1] = (vec3(-7.0, 2.0, -3.0));
	block.var[0][2][0][0] = (vec3(5.0, 5.0, -4.0));
	block.var[0][2][0][1] = (vec3(1.0, -9.0, 1.0));
	block.var[0][2][1][0] = (vec3(3.0, 0.0, -6.0));
	block.var[0][2][1][1] = (vec3(5.0, -6.0, -6.0));
	block.var[0][3][0][0] = (vec3(1.0, -4.0, 2.0));
	block.var[0][3][0][1] = (vec3(0.0, 1.0, -8.0));
	block.var[0][3][1][0] = (vec3(-3.0, -9.0, 6.0));
	block.var[0][3][1][1] = (vec3(-3.0, 6.0, 6.0));
	block.var[1][0][0][0] = (vec3(6.0, -5.0, -7.0));
	block.var[1][0][0][1] = (vec3(1.0, 1.0, -3.0));
	block.var[1][0][1][0] = (vec3(9.0, -7.0, 2.0));
	block.var[1][0][1][1] = (vec3(5.0, -4.0, 6.0));
	block.var[1][1][0][0] = (vec3(1.0, -1.0, 8.0));
	block.var[1][1][0][1] = (vec3(7.0, -2.0, -6.0));
	block.var[1][1][1][0] = (vec3(-1.0, -1.0, -5.0));
	block.var[1][1][1][1] = (vec3(-1.0, 1.0, -1.0));
	block.var[1][2][0][0] = (vec3(7.0, 1.0, -9.0));
	block.var[1][2][0][1] = (vec3(7.0, -8.0, -1.0));
	block.var[1][2][1][0] = (vec3(5.0, -3.0, 9.0));
	block.var[1][2][1][1] = (vec3(-6.0, 4.0, -4.0));
	block.var[1][3][0][0] = (vec3(-6.0, 1.0, 4.0));
	block.var[1][3][0][1] = (vec3(7.0, 9.0, -9.0));
	block.var[1][3][1][0] = (vec3(-1.0, -8.0, 8.0));
	block.var[1][3][1][1] = (vec3(7.0, 1.0, -4.0));
	block.var[2][0][0][0] = (vec3(-3.0, -8.0, 6.0));
	block.var[2][0][0][1] = (vec3(8.0, 2.0, 4.0));
	block.var[2][0][1][0] = (vec3(0.0, 8.0, 0.0));
	block.var[2][0][1][1] = (vec3(-2.0, 1.0, -3.0));
	block.var[2][1][0][0] = (vec3(5.0, 5.0, -6.0));
	block.var[2][1][0][1] = (vec3(6.0, 7.0, -2.0));
	block.var[2][1][1][0] = (vec3(-5.0, -7.0, -1.0));
	block.var[2][1][1][1] = (vec3(4.0, -3.0, -7.0));
	block.var[2][2][0][0] = (vec3(2.0, 5.0, 0.0));
	block.var[2][2][0][1] = (vec3(1.0, -8.0, 0.0));
	block.var[2][2][1][0] = (vec3(7.0, -2.0, -7.0));
	block.var[2][2][1][1] = (vec3(-6.0, -5.0, 3.0));
	block.var[2][3][0][0] = (vec3(-3.0, 5.0, -5.0));
	block.var[2][3][0][1] = (vec3(4.0, 1.0, 9.0));
	block.var[2][3][1][0] = (vec3(3.0, -8.0, 6.0));
	block.var[2][3][1][1] = (vec3(-7.0, -7.0, -1.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	highp uvec4 var[][4][2];
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
	allOk = compare_uvec4((block.var[0][1][0]), uvec4(7u, 3u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[0][1][1]), uvec4(8u, 7u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[0][2][0]), uvec4(8u, 5u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[0][2][1]), uvec4(3u, 6u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[0][3][0]), uvec4(9u, 6u, 7u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[0][3][1]), uvec4(5u, 5u, 7u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[1][0][0]), uvec4(3u, 6u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[1][0][1]), uvec4(2u, 3u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((block.var[1][1][0]), uvec4(5u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[1][1][1]), uvec4(1u, 6u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[1][2][0]), uvec4(4u, 0u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((block.var[1][2][1]), uvec4(6u, 2u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[1][3][0]), uvec4(1u, 6u, 5u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[1][3][1]), uvec4(8u, 0u, 6u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[2][0][0]), uvec4(0u, 7u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((block.var[2][0][1]), uvec4(2u, 8u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[2][1][0]), uvec4(7u, 9u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((block.var[2][1][1]), uvec4(5u, 7u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[2][2][0]), uvec4(5u, 8u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[2][2][1]), uvec4(9u, 8u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((block.var[2][3][0]), uvec4(9u, 4u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((block.var[2][3][1]), uvec4(2u, 3u, 8u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (uvec4(2u, 7u, 2u, 9u));
	block.var[0][0][1] = (uvec4(7u, 9u, 5u, 1u));
	block.var[0][1][0] = (uvec4(4u, 9u, 1u, 3u));
	block.var[0][1][1] = (uvec4(8u, 8u, 8u, 1u));
	block.var[0][2][0] = (uvec4(6u, 1u, 9u, 4u));
	block.var[0][2][1] = (uvec4(5u, 7u, 7u, 0u));
	block.var[0][3][0] = (uvec4(2u, 0u, 0u, 4u));
	block.var[0][3][1] = (uvec4(4u, 2u, 5u, 9u));
	block.var[1][0][0] = (uvec4(3u, 4u, 4u, 2u));
	block.var[1][0][1] = (uvec4(0u, 5u, 6u, 2u));
	block.var[1][1][0] = (uvec4(7u, 5u, 4u, 8u));
	block.var[1][1][1] = (uvec4(6u, 6u, 0u, 9u));
	block.var[1][2][0] = (uvec4(2u, 5u, 1u, 3u));
	block.var[1][2][1] = (uvec4(9u, 6u, 1u, 2u));
	block.var[1][3][0] = (uvec4(6u, 9u, 6u, 2u));
	block.var[1][3][1] = (uvec4(3u, 6u, 1u, 7u));
	block.var[2][0][0] = (uvec4(9u, 5u, 7u, 7u));
	block.var[2][0][1] = (uvec4(0u, 3u, 8u, 1u));
	block.var[2][1][0] = (uvec4(7u, 2u, 3u, 0u));
	block.var[2][1][1] = (uvec4(4u, 4u, 8u, 5u));
	block.var[2][2][0] = (uvec4(0u, 0u, 8u, 4u));
	block.var[2][2][1] = (uvec4(9u, 5u, 7u, 1u));
	block.var[2][3][0] = (uvec4(5u, 6u, 4u, 8u));
	block.var[2][3][1] = (uvec4(6u, 3u, 2u, 5u));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(2.0, -7.0, 8.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(5.0, -2.0, 1.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-9.0, 9.0, 8.0, -5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(9.0, -3.0, -8.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(7.0, -5.0, -4.0, 2.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(0.0, 2.0, 2.0, 4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(-7.0, -4.0, 0.0, -8.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(-6.0, 3.0, 6.0, 5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(6.0, 7.0, 2.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(-5.0, 5.0, 9.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(-8.0, 9.0, 4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-4.0, -8.0, 0.0, -2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(-7.0, -4.0, -2.0, -2.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(4.0, -2.0, -1.0, 3.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(-3.0, 3.0, -2.0, 7.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(0.0, 7.0, 6.0, 0.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(9.0, 7.0, 9.0, 5.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(1.0, 4.0, -6.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-3.0, 2.0, 2.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-3.0, 9.0, -3.0, -8.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(6.0, -7.0, -9.0, -5.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(-1.0, 5.0, 6.0, -4.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(-3.0, -8.0, 4.0, -4.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(-8.0, -6.0, 5.0, -2.0, -8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	block.var[0][0][1] = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	block.var[0][1][0] = (mat2x3(4.0, -7.0, -7.0, 6.0, -8.0, -8.0));
	block.var[0][1][1] = (mat2x3(7.0, -8.0, 4.0, 7.0, 0.0, 3.0));
	block.var[0][2][0] = (mat2x3(-1.0, 0.0, -8.0, 1.0, -2.0, -5.0));
	block.var[0][2][1] = (mat2x3(6.0, 6.0, 2.0, 0.0, 4.0, -7.0));
	block.var[0][3][0] = (mat2x3(-1.0, 6.0, -1.0, 2.0, -2.0, -5.0));
	block.var[0][3][1] = (mat2x3(-9.0, 4.0, -7.0, -5.0, -1.0, -3.0));
	block.var[1][0][0] = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
	block.var[1][0][1] = (mat2x3(-4.0, 3.0, 7.0, -5.0, -6.0, 7.0));
	block.var[1][1][0] = (mat2x3(9.0, 4.0, 7.0, 4.0, -7.0, 6.0));
	block.var[1][1][1] = (mat2x3(1.0, 3.0, 2.0, -1.0, -8.0, -8.0));
	block.var[1][2][0] = (mat2x3(1.0, -6.0, 8.0, 1.0, -5.0, 1.0));
	block.var[1][2][1] = (mat2x3(-7.0, -4.0, -4.0, -5.0, 3.0, 3.0));
	block.var[1][3][0] = (mat2x3(-4.0, 1.0, -4.0, 7.0, 3.0, 7.0));
	block.var[1][3][1] = (mat2x3(2.0, -9.0, -2.0, -7.0, 2.0, -7.0));
	block.var[2][0][0] = (mat2x3(3.0, 8.0, -7.0, -7.0, -6.0, 2.0));
	block.var[2][0][1] = (mat2x3(-8.0, 8.0, -7.0, -2.0, 5.0, 7.0));
	block.var[2][1][0] = (mat2x3(2.0, 9.0, -3.0, -1.0, -2.0, -1.0));
	block.var[2][1][1] = (mat2x3(-1.0, 8.0, 1.0, -6.0, -9.0, -3.0));
	block.var[2][2][0] = (mat2x3(1.0, 0.0, 9.0, 1.0, -8.0, -1.0));
	block.var[2][2][1] = (mat2x3(9.0, 5.0, -3.0, -9.0, -8.0, 3.0));
	block.var[2][3][0] = (mat2x3(-4.0, -8.0, 9.0, 3.0, -1.0, 7.0));
	block.var[2][3][1] = (mat2x3(-9.0, 4.0, -2.0, -8.0, 3.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-2.0, 5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-9.0, -7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(-8.0, 0.0, 0.0, 1.0, 3.0, -4.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(0.0, -3.0, 4.0, -6.0, 4.0, 7.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(5.0, -4.0, -9.0, 2.0, -4.0, 7.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(4.0, -6.0, 7.0, 5.0, 5.0, -1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(-5.0, -8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-5.0, -4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-9.0, 2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(1.0, -8.0, 0.0, 1.0, -3.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(8.0, -3.0, 0.0, -2.0, -4.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(0.0, -2.0, -6.0, 8.0, -4.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(8.0, 6.0, 0.0, -2.0, -7.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(1.0, 4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(4.0, 4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-5.0, 2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(6.0, 1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(0.0, -9.0, 7.0, 0.0, -5.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(-7.0, -9.0, -7.0, 4.0, -9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(-7.0, -4.0, 9.0, 0.0, 7.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(-3.0, -7.0, -1.0, -5.0, 1.0, 5.0, 9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	block.var[0][0][1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	block.var[0][1][0] = (mat2x4(-6.0, 9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0));
	block.var[0][1][1] = (mat2x4(8.0, -6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0));
	block.var[0][2][0] = (mat2x4(4.0, 9.0, -8.0, 5.0, 6.0, -1.0, 4.0, -3.0));
	block.var[0][2][1] = (mat2x4(3.0, -1.0, -8.0, 3.0, 0.0, 1.0, -4.0, -1.0));
	block.var[0][3][0] = (mat2x4(-5.0, 6.0, 0.0, 7.0, -5.0, 2.0, 0.0, -5.0));
	block.var[0][3][1] = (mat2x4(-7.0, 4.0, 4.0, 2.0, -9.0, 5.0, -7.0, -7.0));
	block.var[1][0][0] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
	block.var[1][0][1] = (mat2x4(-3.0, -9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0));
	block.var[1][1][0] = (mat2x4(-1.0, 2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0));
	block.var[1][1][1] = (mat2x4(2.0, 0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0));
	block.var[1][2][0] = (mat2x4(-3.0, 4.0, 1.0, 2.0, 2.0, 0.0, 7.0, 2.0));
	block.var[1][2][1] = (mat2x4(6.0, 1.0, -2.0, 4.0, 9.0, -2.0, -7.0, 5.0));
	block.var[1][3][0] = (mat2x4(0.0, -2.0, -7.0, -5.0, 1.0, 4.0, 6.0, -3.0));
	block.var[1][3][1] = (mat2x4(4.0, 7.0, -8.0, -8.0, -4.0, -9.0, 3.0, -5.0));
	block.var[2][0][0] = (mat2x4(-3.0, -3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0));
	block.var[2][0][1] = (mat2x4(4.0, 9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0));
	block.var[2][1][0] = (mat2x4(5.0, -8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0));
	block.var[2][1][1] = (mat2x4(4.0, 9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0));
	block.var[2][2][0] = (mat2x4(-8.0, 2.0, -4.0, 4.0, -8.0, 1.0, -7.0, -7.0));
	block.var[2][2][1] = (mat2x4(1.0, 7.0, 2.0, 3.0, -2.0, 1.0, 0.0, 7.0));
	block.var[2][3][0] = (mat2x4(-7.0, -3.0, -1.0, -4.0, 2.0, -8.0, -5.0, -3.0));
	block.var[2][3][1] = (mat2x4(-7.0, 7.0, -5.0, 8.0, -1.0, 1.0, 7.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(8.0, -5.0, -3.0, -5.0, 3.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(-3.0, 9.0, 0.0, 7.0, 9.0, -6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(6.0, 1.0, -3.0, -1.0, -3.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(2.0, 4.0, -4.0, 9.0, 9.0, 7.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-9.0, 3.0, -7.0, -8.0, 7.0, -1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(-7.0, 0.0, -1.0, -5.0, 7.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(5.0, -9.0, -2.0, 8.0, 7.0, 0.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(8.0, -9.0, -2.0, -7.0, 6.0, -6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(-2.0, 4.0, 6.0, -4.0, 1.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(9.0, 0.0, 1.0, -9.0, -5.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(4.0, -2.0, -9.0, 4.0, 9.0, 1.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(6.0, 9.0, 2.0, 5.0, -9.0, -3.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	block.var[0][0][1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	block.var[0][1][0] = (mat4x2(1.0, -9.0, 0.0, -4.0, 2.0, 9.0, -5.0, -3.0));
	block.var[0][1][1] = (mat4x2(6.0, -4.0, -9.0, 5.0, -5.0, -6.0, 8.0, -5.0));
	block.var[0][2][0] = (mat4x2(-7.0, 4.0, -8.0, -6.0, -3.0, -4.0, 8.0, -4.0));
	block.var[0][2][1] = (mat4x2(6.0, -9.0, -7.0, -3.0, -9.0, -6.0, -3.0, -8.0));
	block.var[0][3][0] = (mat4x2(4.0, -8.0, -6.0, -3.0, 8.0, -1.0, -5.0, 5.0));
	block.var[0][3][1] = (mat4x2(1.0, 9.0, -4.0, -5.0, 1.0, -2.0, 7.0, 1.0));
	block.var[1][0][0] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
	block.var[1][0][1] = (mat4x2(-5.0, -9.0, -1.0, -9.0, 0.0, -4.0, 2.0, -7.0));
	block.var[1][1][0] = (mat4x2(-4.0, -5.0, 6.0, 9.0, -3.0, -4.0, 3.0, -7.0));
	block.var[1][1][1] = (mat4x2(-8.0, 8.0, -4.0, -6.0, 0.0, -3.0, -6.0, -4.0));
	block.var[1][2][0] = (mat4x2(8.0, -4.0, -8.0, 4.0, 0.0, 4.0, -3.0, 8.0));
	block.var[1][2][1] = (mat4x2(0.0, 7.0, -2.0, -3.0, -5.0, 6.0, -2.0, 7.0));
	block.var[1][3][0] = (mat4x2(-3.0, -1.0, 4.0, 9.0, 6.0, 3.0, -9.0, 2.0));
	block.var[1][3][1] = (mat4x2(-3.0, 9.0, 7.0, -5.0, -4.0, 0.0, -9.0, 9.0));
	block.var[2][0][0] = (mat4x2(-3.0, -5.0, 1.0, -5.0, -1.0, 7.0, 4.0, 4.0));
	block.var[2][0][1] = (mat4x2(-5.0, 2.0, -4.0, -3.0, 0.0, 4.0, -7.0, 5.0));
	block.var[2][1][0] = (mat4x2(5.0, 4.0, 5.0, 7.0, 2.0, -7.0, 8.0, -3.0));
	block.var[2][1][1] = (mat4x2(8.0, 7.0, 0.0, -5.0, 4.0, 5.0, -6.0, -8.0));
	block.var[2][2][0] = (mat4x2(4.0, -1.0, 6.0, -2.0, 0.0, 7.0, 0.0, 2.0));
	block.var[2][2][1] = (mat4x2(-7.0, -7.0, -6.0, 8.0, -7.0, -4.0, 9.0, 9.0));
	block.var[2][3][0] = (mat4x2(6.0, 8.0, -4.0, -2.0, -7.0, -7.0, -4.0, 9.0));
	block.var[2][3][1] = (mat4x2(6.0, 7.0, -4.0, 6.0, -5.0, -4.0, 7.0, -1.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(-9.0, -4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-1.0, 9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(3.0, 8.0, 5.0, 9.0, 4.0, 6.0, 7.0, 0.0, 4.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(8.0, -7.0, -1.0, 4.0, -8.0, -5.0, 3.0, 6.0, 4.0, -1.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(8.0, 9.0, 2.0, 2.0, 6.0, -3.0, 4.0, -7.0, 0.0, 1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(-9.0, -7.0, -8.0, -4.0, 8.0, 2.0, 3.0, 0.0, -9.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(8.0, -1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-2.0, 2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(0.0, 2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(6.0, -2.0, -4.0, 2.0, -1.0, -5.0, -1.0, -2.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(-9.0, 3.0, 2.0, 5.0, -9.0, -1.0, -7.0, 5.0, -3.0, -9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(3.0, -4.0, -8.0, 9.0, -6.0, -5.0, 4.0, -7.0, 8.0, -7.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(8.0, 1.0, 3.0, 3.0, 6.0, 0.0, -6.0, 2.0, -5.0, 9.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-3.0, -9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-2.0, -4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(4.0, 1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(8.0, -5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(7.0, 3.0, 5.0, 9.0, -3.0, -2.0, -1.0, 5.0, -5.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(2.0, 0.0, -7.0, 6.0, 9.0, -6.0, -1.0, 6.0, 6.0, 4.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(1.0, 4.0, 2.0, -6.0, 2.0, 3.0, -5.0, 6.0, 7.0, 7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(7.0, -2.0, -5.0, 2.0, -9.0, -4.0, 9.0, -9.0, -8.0, 1.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	block.var[0][0][1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	block.var[0][1][0] = (mat3x4(6.0, 6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0));
	block.var[0][1][1] = (mat3x4(3.0, -3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0));
	block.var[0][2][0] = (mat3x4(9.0, -2.0, 8.0, -4.0, 8.0, 4.0, 3.0, -3.0, 3.0, -5.0, 7.0, -8.0));
	block.var[0][2][1] = (mat3x4(5.0, -3.0, 8.0, 6.0, 1.0, 6.0, -2.0, -6.0, 0.0, 1.0, 3.0, 3.0));
	block.var[0][3][0] = (mat3x4(3.0, -7.0, -1.0, 2.0, -7.0, -9.0, 4.0, 1.0, -9.0, 4.0, 5.0, -1.0));
	block.var[0][3][1] = (mat3x4(-3.0, -8.0, 4.0, 4.0, -5.0, 6.0, 7.0, 6.0, 5.0, 2.0, 2.0, -5.0));
	block.var[1][0][0] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
	block.var[1][0][1] = (mat3x4(-6.0, 7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0));
	block.var[1][1][0] = (mat3x4(9.0, 4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0));
	block.var[1][1][1] = (mat3x4(5.0, 0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0));
	block.var[1][2][0] = (mat3x4(-3.0, 0.0, -3.0, 5.0, -4.0, -5.0, 1.0, -5.0, -5.0, 0.0, 0.0, -6.0));
	block.var[1][2][1] = (mat3x4(4.0, 6.0, -7.0, 7.0, 3.0, 6.0, 4.0, -7.0, 8.0, -1.0, 3.0, 3.0));
	block.var[1][3][0] = (mat3x4(8.0, -2.0, -8.0, -1.0, -5.0, -1.0, -6.0, 3.0, 7.0, -8.0, -6.0, -9.0));
	block.var[1][3][1] = (mat3x4(-5.0, -1.0, 4.0, 9.0, -9.0, -3.0, -8.0, -1.0, 5.0, 9.0, -6.0, 2.0));
	block.var[2][0][0] = (mat3x4(7.0, -8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0));
	block.var[2][0][1] = (mat3x4(-1.0, 2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0));
	block.var[2][1][0] = (mat3x4(0.0, -3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0));
	block.var[2][1][1] = (mat3x4(5.0, 7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0));
	block.var[2][2][0] = (mat3x4(-1.0, 0.0, -1.0, 5.0, 3.0, -9.0, 6.0, 8.0, -9.0, -5.0, -1.0, 1.0));
	block.var[2][2][1] = (mat3x4(-1.0, -4.0, 7.0, 7.0, 5.0, -7.0, 1.0, 3.0, 6.0, 3.0, -3.0, -9.0));
	block.var[2][3][0] = (mat3x4(-6.0, 6.0, -6.0, 7.0, 6.0, -6.0, 8.0, 9.0, 6.0, 0.0, 7.0, 8.0));
	block.var[2][3][1] = (mat3x4(7.0, -9.0, -9.0, -4.0, 2.0, 7.0, 9.0, -8.0, -5.0, 6.0, 2.0, -3.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-8, 9, 6)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-7.0, -6.0, 4.0, 1.0, -8.0, -7.0, -5.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(1.0, 8.0, 3.0, 7.0, -3.0, 4.0, -8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-9.0, -1.0, 3.0, 8.0, -7.0, -6.0, 9.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-9.0, 6.0, -1.0, -7.0, 0.0, -4.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(3.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(-7, 4, -9)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-6.0, -2.0, 7.0, 5.0, -5.0, 9.0, -2.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-9.0, -2.0, 2.0, -3.0, 5.0, 4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-3.0, 5.0, 0.0, 2.0, -8.0, 2.0, -7.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(6.0, 4.0, 1.0, -4.0, -1.0, -5.0, 6.0, -2.0, 2.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(2.0, -4.0, -8.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-4, -7, -1)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(9.0, 7.0, 8.0, 9.0, 1.0, -6.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(3.0, 3.0, 3.0, -3.0, -2.0, 4.0, 1.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(3.0, 8.0, 0.0, -6.0, 3.0, -8.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-4.0, -1.0, -3.0, -7.0, -8.0, 0.0, -4.0, 0.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(5.0, -1.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-4, -7, -8));
	block[0].s.b[0] = (mat3(3.0, 7.0, 5.0, 6.0, 5.0, 4.0, 6.0, -7.0, 9.0));
	block[0].s.b[1] = (mat3(0.0, 5.0, 7.0, 9.0, 3.0, -5.0, -5.0, 4.0, 3.0));
	block[0].s.b[2] = (mat3(-2.0, -3.0, -4.0, 1.0, 2.0, 1.0, -8.0, -8.0, -4.0));
	block[0].s.b[3] = (mat3(4.0, 0.0, -5.0, 2.0, 0.0, 7.0, 9.0, -3.0, -5.0));
	block[0].s.c = (vec4(3.0, 6.0, 3.0, 5.0));
	block[1].s.a = (ivec3(4, 3, -6));
	block[1].s.b[0] = (mat3(8.0, 4.0, -6.0, 1.0, 8.0, -6.0, -3.0, -8.0, 9.0));
	block[1].s.b[1] = (mat3(-8.0, 6.0, 2.0, -2.0, 4.0, -6.0, 6.0, -4.0, -1.0));
	block[1].s.b[2] = (mat3(3.0, 0.0, -7.0, -3.0, 7.0, -6.0, 8.0, -3.0, -5.0));
	block[1].s.b[3] = (mat3(7.0, -5.0, 3.0, 2.0, -9.0, -5.0, 9.0, -3.0, -1.0));
	block[1].s.c = (vec4(-2.0, 5.0, -1.0, 0.0));
	block[2].s.a = (ivec3(-2, -1, 4));
	block[2].s.b[0] = (mat3(8.0, -2.0, -4.0, 9.0, -5.0, -5.0, -5.0, 4.0, -7.0));
	block[2].s.b[1] = (mat3(5.0, 6.0, 7.0, -9.0, -6.0, -7.0, -8.0, -7.0, -8.0));
	block[2].s.b[2] = (mat3(0.0, -8.0, 5.0, 5.0, -3.0, 6.0, 4.0, -1.0, -8.0));
	block[2].s.b[3] = (mat3(8.0, -5.0, 4.0, -2.0, -1.0, 2.0, -6.0, 6.0, -1.0));
	block[2].s.c = (vec4(3.0, 6.0, 2.0, 0.0));
}
#version 450
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
	allOk = compare_ivec3((block.s[0].a), ivec3(-3, 3, 1)) && allOk;
	allOk = compare_mat3(block.s[0].b[0], mat3(-5.0, -1.0, -8.0, -2.0, 8.0, -3.0, 3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[1], mat3(-6.0, -1.0, -7.0, -4.0, 7.0, 5.0, 5.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[2], mat3(2.0, 6.0, 3.0, -1.0, -9.0, 7.0, 1.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[3], mat3(2.0, -5.0, 5.0, -6.0, 0.0, -4.0, -7.0, 0.0, 2.0)) && allOk;
	allOk = compare_vec4((block.s[0].c), vec4(6.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_ivec3((block.s[1].a), ivec3(1, -8, -2)) && allOk;
	allOk = compare_mat3(block.s[1].b[0], mat3(-5.0, -2.0, 1.0, 2.0, -5.0, -8.0, 1.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[1], mat3(-8.0, -6.0, -5.0, 2.0, 5.0, -6.0, 9.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[2], mat3(-8.0, 4.0, 5.0, 6.0, -7.0, -7.0, -5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[3], mat3(-2.0, 5.0, 4.0, -2.0, -5.0, 9.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_vec4((block.s[1].c), vec4(-2.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_ivec3((block.s[2].a), ivec3(-7, -1, 8)) && allOk;
	allOk = compare_mat3(block.s[2].b[0], mat3(4.0, 3.0, 4.0, -5.0, 7.0, 4.0, -3.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[1], mat3(3.0, -8.0, 7.0, 3.0, -2.0, 0.0, -7.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[2], mat3(2.0, 3.0, -3.0, 1.0, -1.0, 0.0, 6.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[3], mat3(7.0, 6.0, -3.0, 9.0, 7.0, -4.0, -3.0, -8.0, 4.0)) && allOk;
	allOk = compare_vec4((block.s[2].c), vec4(-3.0, 6.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s[0].a = (ivec3(1, 5, -4));
	block.s[0].b[0] = (mat3(-9.0, -4.0, -7.0, -5.0, -4.0, -3.0, -9.0, 3.0, 5.0));
	block.s[0].b[1] = (mat3(-9.0, 5.0, 2.0, 5.0, -2.0, -1.0, 3.0, -7.0, -9.0));
	block.s[0].b[2] = (mat3(4.0, 4.0, -6.0, 1.0, -9.0, -5.0, -7.0, 0.0, 0.0));
	block.s[0].b[3] = (mat3(-4.0, 2.0, -8.0, -5.0, 2.0, 4.0, -8.0, -4.0, -8.0));
	block.s[0].c = (vec4(5.0, -9.0, -4.0, -4.0));
	block.s[1].a = (ivec3(6, -4, -7));
	block.s[1].b[0] = (mat3(7.0, 9.0, 1.0, 5.0, -2.0, -6.0, -3.0, -1.0, -5.0));
	block.s[1].b[1] = (mat3(-1.0, 0.0, -3.0, 0.0, 5.0, -6.0, 2.0, 5.0, 1.0));
	block.s[1].b[2] = (mat3(-9.0, -2.0, 9.0, -4.0, -9.0, -1.0, -3.0, -5.0, 9.0));
	block.s[1].b[3] = (mat3(5.0, -9.0, 4.0, 1.0, 1.0, -3.0, 3.0, 0.0, -8.0));
	block.s[1].c = (vec4(-4.0, -7.0, 3.0, -3.0));
	block.s[2].a = (ivec3(-1, -7, 1));
	block.s[2].b[0] = (mat3(-6.0, -5.0, 0.0, 4.0, -2.0, -9.0, -4.0, 5.0, 3.0));
	block.s[2].b[1] = (mat3(5.0, 9.0, 5.0, -8.0, 7.0, 0.0, -4.0, 9.0, -8.0));
	block.s[2].b[2] = (mat3(0.0, 3.0, 5.0, -5.0, 8.0, 2.0, -9.0, -3.0, 5.0));
	block.s[2].b[3] = (mat3(5.0, 2.0, 6.0, -9.0, 2.0, -8.0, 7.0, 8.0, -2.0));
	block.s[2].c = (vec4(-3.0, -4.0, -5.0, 6.0));
	block.v = (vec4(-5.0, -3.0, 4.0, -1.0));
}
#version 450
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
	allOk = compare_ivec3((block.s[0].a), ivec3(-7, 2, -2)) && allOk;
	allOk = compare_mat3(block.s[0].b[0], mat3(-4.0, -9.0, 4.0, -1.0, -8.0, 8.0, 0.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[1], mat3(0.0, -7.0, 7.0, -5.0, 1.0, -5.0, 1.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[2], mat3(-1.0, 4.0, 1.0, -3.0, 5.0, -5.0, -7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[3], mat3(-8.0, -4.0, -3.0, 6.0, 1.0, 1.0, 0.0, 6.0, -9.0)) && allOk;
	allOk = compare_vec4((block.s[0].c), vec4(6.0, 3.0, -2.0, -8.0)) && allOk;
	allOk = compare_ivec3((block.s[1].a), ivec3(9, 6, 2)) && allOk;
	allOk = compare_mat3(block.s[1].b[0], mat3(-3.0, 2.0, 5.0, -4.0, -1.0, 9.0, 4.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[1], mat3(2.0, 4.0, 9.0, -7.0, -5.0, -9.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[2], mat3(7.0, 0.0, -3.0, -9.0, -8.0, -8.0, 5.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[3], mat3(3.0, -6.0, 0.0, 0.0, 4.0, -4.0, 9.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((block.s[1].c), vec4(3.0, -3.0, 8.0, -1.0)) && allOk;
	allOk = compare_ivec3((block.s[2].a), ivec3(2, -9, -7)) && allOk;
	allOk = compare_mat3(block.s[2].b[0], mat3(-2.0, 4.0, 5.0, 5.0, -3.0, 9.0, -1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[1], mat3(6.0, 1.0, -4.0, 6.0, 4.0, -4.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[2], mat3(-8.0, -2.0, -9.0, 9.0, 9.0, -2.0, 3.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[3], mat3(-9.0, -6.0, -7.0, 4.0, -1.0, 4.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4((block.s[2].c), vec4(-3.0, 5.0, -5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s[0].a = (ivec3(8, -7, -9));
	block.s[0].b[0] = (mat3(-3.0, 7.0, -9.0, 8.0, -2.0, 5.0, 1.0, 6.0, 4.0));
	block.s[0].b[1] = (mat3(-5.0, -1.0, -2.0, 5.0, 3.0, -3.0, -2.0, -9.0, 9.0));
	block.s[0].b[2] = (mat3(9.0, -6.0, -5.0, 0.0, 4.0, 6.0, 5.0, -6.0, -8.0));
	block.s[0].b[3] = (mat3(4.0, -6.0, -1.0, 8.0, -1.0, 6.0, -2.0, 7.0, -9.0));
	block.s[0].c = (vec4(-6.0, 3.0, 3.0, -5.0));
	block.s[1].a = (ivec3(5, 2, 9));
	block.s[1].b[0] = (mat3(-6.0, -6.0, 3.0, -3.0, 8.0, 4.0, -6.0, -1.0, -8.0));
	block.s[1].b[1] = (mat3(0.0, 9.0, 7.0, -5.0, 9.0, -6.0, -7.0, -7.0, -2.0));
	block.s[1].b[2] = (mat3(2.0, 3.0, -5.0, -7.0, -2.0, 8.0, -6.0, 3.0, -7.0));
	block.s[1].b[3] = (mat3(3.0, -6.0, -7.0, -2.0, 2.0, 2.0, -7.0, 6.0, -2.0));
	block.s[1].c = (vec4(-2.0, 1.0, -9.0, -4.0));
	block.s[2].a = (ivec3(-9, -9, 0));
	block.s[2].b[0] = (mat3(5.0, 8.0, -8.0, 8.0, 3.0, 4.0, 6.0, -6.0, 0.0));
	block.s[2].b[1] = (mat3(1.0, 0.0, -7.0, -5.0, 3.0, 7.0, -8.0, -7.0, 3.0));
	block.s[2].b[2] = (mat3(9.0, -5.0, -2.0, 2.0, 2.0, 3.0, -6.0, -5.0, -7.0));
	block.s[2].b[3] = (mat3(-7.0, -4.0, 2.0, -6.0, -9.0, -3.0, -7.0, -8.0, -5.0));
	block.s[2].c = (vec4(-8.0, 1.0, -1.0, -7.0));
	block.v = (vec4(8.0, -5.0, 4.0, -7.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(block[0].var, mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(block[1].var, mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(block[2].var, mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	block[0].var[1] = (vec4(2.0, -4.0, 3.0, -5.0));
	block[0].var[2] = (vec4(2.0, 3.0, 8.0, 8.0));
	block[0].var[3] = (vec4(3.0, 0.0, -4.0, -1.0));
	block[1].var[0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	block[1].var[1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	block[1].var[2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	block[1].var[3] = (vec4(6.0, -9.0, -1.0, -5.0));
	block[2].var[0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	block[2].var[1] = (vec4(0.0, -1.0, -2.0, 1.0));
	block[2].var[2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	block[2].var[3] = (vec4(-3.0, 1.0, 1.0, -9.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 9.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(5.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][3], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 1.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-7.0, 1.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -6.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(8.0, 3.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(2.0, 6.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	block[0].var[1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	block[1].var[0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	block[1].var[1] = (vec4(5.0, 8.0, -8.0, -8.0));
	block[2].var[0] = (vec4(6.0, -3.0, 7.0, 0.0));
	block[2].var[1] = (vec4(4.0, 6.0, -4.0, 0.0));
}
#version 450
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
    Block block[3];
};

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
	allOk = compare_float((block[0].padding), -7.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 8.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-7.0, -1.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-9.0, 8.0)) && allOk;
	allOk = compare_float((block[1].padding), 8.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -3.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(9.0, 8.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-6.0, -3.0)) && allOk;
	allOk = compare_float((block[2].padding), -6.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -5.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (7.0);
	block[0].var[0] = (vec2(-2.0, 4.0));
	block[0].var[1] = (vec2(-3.0, 1.0));
	block[1].padding = (2.0);
	block[1].var[0] = (vec2(-3.0, -1.0));
	block[1].var[1] = (vec2(-4.0, -4.0));
	block[2].padding = (1.0);
	block[2].var[0] = (vec2(3.0, 2.0));
	block[2].var[1] = (vec2(7.0, -7.0));
}
#version 450
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
	uint8_t var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block[0].var), 7u) && allOk;
	allOk = compare_uint8_t(uint(block[1].var), 1u) && allOk;
	allOk = compare_uint8_t(uint(block[2].var), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = uint8_t(9u);
	block[1].var = uint8_t(5u);
	block[2].var = uint8_t(2u);
}
#version 450
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
	mediump uint b;
	bool c[1];
	lowp int d;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump int e;
	lowp int f;
	lowp float g;
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp float h;
	lowp uint i;
	bool j;
	lowp int k;
};
layout(std430, buffer_reference) buffer BlockE
{
	lowp int l;
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
	allOk = compare_uint((blockB.a), 9u) && allOk;
	allOk = compare_bool((blockB.c[0]), true) && allOk;
	allOk = compare_int((blockB.d), -9) && allOk;
	allOk = compare_int((blockC.f), -9) && allOk;
	allOk = compare_float((blockD.h), -8.0) && allOk;
	allOk = compare_uint((blockD.i), 0u) && allOk;
	allOk = compare_int((blockD.k), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (5u);
	blockB.c[0] = (false);
	blockC.e = (-4);
	blockC.g = (-9.0);
	blockD.h = (8.0);
	blockD.i = (8u);
	blockD.k = (5);
	blockE.l = (-4);
}
#version 450
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
	bvec3 c[3];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uvec3 d;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	highp ivec4 e;
	mediump float f[3];
	lowp uvec3 g[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	lowp float h;
	highp mat2x3 i[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.c[0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.c[1]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockB.c[2]), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec3((blockC.d), uvec3(4u, 8u, 2u)) && allOk;
	allOk = compare_float((blockD.f[0]), 9.0) && allOk;
	allOk = compare_float((blockD.f[1]), 7.0) && allOk;
	allOk = compare_float((blockD.f[2]), -2.0) && allOk;
	allOk = compare_uvec3((blockD.g[0]), uvec3(0u, 7u, 9u)) && allOk;
	allOk = compare_uvec3((blockD.g[1]), uvec3(8u, 1u, 0u)) && allOk;
	allOk = compare_uvec3((blockD.g[2]), uvec3(4u, 7u, 2u)) && allOk;
	allOk = compare_uvec3((blockD.g[3]), uvec3(4u, 9u, 3u)) && allOk;
	allOk = compare_uvec3((blockD.g[4]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_uvec3((blockD.g[5]), uvec3(7u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((blockD.g[6]), uvec3(8u, 7u, 2u)) && allOk;
	allOk = compare_uvec3((blockD.g[7]), uvec3(6u, 3u, 2u)) && allOk;
	allOk = compare_mat2x3(blockE.i[0], mat2x3(-3.0, 9.0, 7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockE.i[1], mat2x3(7.0, -7.0, 7.0, -8.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockE.i[2], mat2x3(-2.0, -1.0, 6.0, 4.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockE.i[3], mat2x3(-2.0, 5.0, 6.0, 1.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockE.i[4], mat2x3(-2.0, 8.0, -5.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockE.i[5], mat2x3(2.0, -2.0, 5.0, -9.0, 5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(-7.0, -3.0, 4.0, -9.0, -4.0, 1.0, -7.0, 2.0));
	blockB.b = (true);
	blockB.c[0] = (bvec3(true, true, true));
	blockB.c[1] = (bvec3(true, false, false));
	blockB.c[2] = (bvec3(true, false, false));
	blockC.d = (uvec3(0u, 2u, 3u));
	blockD.e = (ivec4(6, 4, -5, -6));
	blockD.f[0] = (2.0);
	blockD.f[1] = (8.0);
	blockD.f[2] = (0.0);
	blockD.g[0] = (uvec3(8u, 4u, 4u));
	blockD.g[1] = (uvec3(7u, 0u, 4u));
	blockD.g[2] = (uvec3(8u, 9u, 3u));
	blockD.g[3] = (uvec3(2u, 2u, 1u));
	blockD.g[4] = (uvec3(7u, 2u, 5u));
	blockD.g[5] = (uvec3(9u, 0u, 1u));
	blockD.g[6] = (uvec3(4u, 6u, 4u));
	blockD.g[7] = (uvec3(5u, 3u, 6u));
	blockE.h = (-1.0);
	blockE.i[0] = (mat2x3(-5.0, 1.0, -7.0, 2.0, -4.0, 1.0));
	blockE.i[1] = (mat2x3(-2.0, -8.0, 3.0, -7.0, -4.0, 3.0));
	blockE.i[2] = (mat2x3(-7.0, 1.0, -7.0, -5.0, 5.0, -5.0));
	blockE.i[3] = (mat2x3(-6.0, -6.0, -6.0, -3.0, 2.0, 9.0));
	blockE.i[4] = (mat2x3(-3.0, -7.0, -9.0, 8.0, 6.0, -1.0));
	blockE.i[5] = (mat2x3(6.0, -9.0, 0.0, 8.0, -1.0, 0.0));
}
#version 450
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
	mediump mat4x2 a;
	lowp mat3x2 b;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp mat3x2 c;
	highp mat2x3 d[];
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp mat3x4 e;
	mediump mat3x4 f;
	lowp mat2x3 g[5];
	bvec3 h;
	bvec3 i[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	mediump uvec2 j;
	highp mat4x2 k;
	mediump mat3x2 l;
	lowp mat3x4 m;
	lowp float n[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockC.d[0], mat2x3(1.0, -1.0, -5.0, 7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockD.e, mat3x4(4.0, -9.0, 8.0, -6.0, 8.0, 2.0, -5.0, 9.0, 3.0, -5.0, -3.0, 0.0)) && allOk;
	allOk = compare_bvec3((blockD.h), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockD.i[0]), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec2((blockE.j), uvec2(3u, 2u)) && allOk;
	allOk = compare_mat3x2(blockE.l, mat3x2(9.0, 6.0, -7.0, 5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockE.m, mat3x4(-4.0, -4.0, 7.0, 7.0, 9.0, -3.0, -4.0, -6.0, -3.0, -6.0, 0.0, -9.0)) && allOk;
	allOk = compare_float((blockE.n[0]), 5.0) && allOk;
	allOk = compare_float((blockE.n[1]), -7.0) && allOk;
	allOk = compare_float((blockE.n[2]), 4.0) && allOk;
	allOk = compare_float((blockE.n[3]), -9.0) && allOk;
	allOk = compare_float((blockE.n[4]), -4.0) && allOk;
	allOk = compare_float((blockE.n[5]), -2.0) && allOk;
	allOk = compare_float((blockE.n[6]), 2.0) && allOk;
	allOk = compare_float((blockE.n[7]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(-5.0, 9.0, 5.0, 5.0, -3.0, -5.0, -8.0, 3.0));
	blockB.b = (mat3x2(-9.0, 2.0, 6.0, 1.0, 9.0, -5.0));
	blockC.d[0] = (mat2x3(-1.0, 5.0, 9.0, 3.0, 3.0, 8.0));
	blockD.f = (mat3x4(-6.0, 4.0, -5.0, -2.0, -4.0, -5.0, 7.0, 6.0, -9.0, 0.0, -7.0, 2.0));
	blockD.g[0] = (mat2x3(1.0, 9.0, 2.0, -9.0, -2.0, -7.0));
	blockD.g[1] = (mat2x3(8.0, 8.0, 8.0, 7.0, 9.0, -6.0));
	blockD.g[2] = (mat2x3(-3.0, -1.0, 3.0, 7.0, -2.0, -7.0));
	blockD.g[3] = (mat2x3(-7.0, -5.0, 3.0, 8.0, 6.0, -1.0));
	blockD.g[4] = (mat2x3(-8.0, -7.0, 3.0, 8.0, 1.0, 4.0));
	blockD.h = (bvec3(false, false, false));
	blockD.i[0] = (bvec3(false, true, true));
	blockE.j = (uvec2(5u, 9u));
	blockE.l = (mat3x2(-8.0, 4.0, -1.0, -2.0, 4.0, 3.0));
	blockE.m = (mat3x4(-2.0, -1.0, 9.0, 4.0, -4.0, -6.0, -2.0, 8.0, 1.0, -4.0, 3.0, -6.0));
	blockE.n[0] = (-3.0);
	blockE.n[1] = (6.0);
	blockE.n[2] = (8.0);
	blockE.n[3] = (-8.0);
	blockE.n[4] = (-6.0);
	blockE.n[5] = (-3.0);
	blockE.n[6] = (2.0);
	blockE.n[7] = (-3.0);
}
#version 450
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
};
layout(std140, buffer_reference) buffer BlockC
{
	highp mat4x3 b;
	lowp ivec4 c;
	highp vec4 d;
	lowp int e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockC.c), ivec4(-6, -2, 9, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.e[0] = (5);
}
#version 450
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
	mediump mat4 a;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	bvec4 b;
	bvec3 c;
	lowp int d[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	lowp mat3x4 e;
	lowp vec4 f;
	highp ivec2 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockC.c), bvec3(true, true, false)) && allOk;
	allOk = compare_mat3x4(blockD.e, mat3x4(-4.0, 3.0, -5.0, -8.0, -9.0, 0.0, 0.0, 1.0, -4.0, -2.0, 1.0, -1.0)) && allOk;
	allOk = compare_vec4((blockD.f), vec4(0.0, -2.0, 5.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockD.g[0]), ivec2(-6, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(6.0, -7.0, -9.0, -9.0, 0.0, -3.0, 8.0, 5.0, 5.0, -7.0, 0.0, 4.0, 1.0, 9.0, -8.0, -2.0));
	blockC.b = (bvec4(true, true, true, true));
	blockC.c = (bvec3(true, false, false));
	blockC.d[0] = (7);
	blockD.e = (mat3x4(-1.0, 1.0, 8.0, -9.0, -6.0, -4.0, -7.0, 3.0, 3.0, -9.0, 3.0, 5.0));
	blockD.f = (vec4(-9.0, 9.0, -5.0, -2.0));
}
#version 450
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
	bvec2 mB;
	lowp uint mC;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	mediump mat3 a;
	bvec3 b;
	lowp ivec4 c;
	sA d;
};
layout(std430, column_major, buffer_reference) readonly buffer BlockC
{
	bvec3 e;
	bvec4 f;
	highp uvec2 g[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	highp uint h;
	lowp mat3x4 i;
	lowp vec2 j[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(4.0, 7.0, 9.0, 4.0, 4.0, 3.0, -4.0, 1.0, -5.0)) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(true, true, false)) && allOk;
	allOk = compare_int((blockB.d.mA), -6) && allOk;
	allOk = compare_bvec2((blockB.d.mB), bvec2(true, true)) && allOk;
	allOk = compare_uint((blockB.d.mC), 0u) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d.mA = (-6);
	blockB.d.mB = (bvec2(true, false));
	blockB.d.mC = (0u);
	blockD.i = (mat3x4(-1.0, -1.0, 4.0, 6.0, -1.0, -7.0, -3.0, 5.0, 7.0, 7.0, 1.0, 8.0));
}
#version 450
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
	layout(offset = 0) lowp float a;
	layout(offset = 4) mediump vec2 b;
	layout(offset = 12) mediump int c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bool d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump ivec2 e;
	layout(offset = 16) highp ivec4 f;
	layout(offset = 32) mediump vec4 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -8.0) && allOk;
	allOk = compare_vec2((blockB.b), vec2(4.0, -4.0)) && allOk;
	allOk = compare_int((blockB.c), -9) && allOk;
	allOk = compare_bool((blockC[0].d), true) && allOk;
	allOk = compare_bool((blockC[1].d), true) && allOk;
	allOk = compare_ivec2((blockD.e), ivec2(4, -1)) && allOk;
	allOk = compare_ivec4((blockD.f), ivec4(2, -5, -4, 2)) && allOk;
	allOk = compare_vec4((blockD.g), vec4(4.0, 1.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].d = (false);
	blockC[1].d = (false);
	blockD.e = (ivec2(0, 8));
	blockD.f = (ivec4(-5, 7, 4, 3));
	blockD.g = (vec4(3.0, 0.0, 7.0, -1.0));
}
#version 450
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
	bvec2 a;
	lowp mat3x4 b;
	lowp mat3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[nonuniformEXT(0)].a), bvec2(true, true)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].b, mat3x4(-4.0, -4.0, -1.0, 6.0, -5.0, -6.0, -2.0, 5.0, 9.0, -1.0, 1.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockB[nonuniformEXT(1)].a), bvec2(true, false)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].b, mat3x4(-1.0, -4.0, -4.0, -4.0, -7.0, -3.0, -9.0, 0.0, 7.0, 1.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (bvec2(true, true));
	blockB[nonuniformEXT(0)].c = (mat3(-1.0, -6.0, -4.0, 4.0, -7.0, 8.0, -4.0, -7.0, 2.0));
	blockB[nonuniformEXT(1)].a = (bvec2(false, true));
	blockB[nonuniformEXT(1)].c = (mat3(-4.0, 2.0, -1.0, 8.0, -2.0, -1.0, -5.0, 8.0, 1.0));
}
#version 450
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
	highp mat3x4 a;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	f16vec2 b;
	bvec3 c;
	f16vec3 d;
	lowp mat2 e;
};
layout(std140, buffer_reference) readonly buffer BlockD
{
	mediump mat4 f;
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	mediump int g[1];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a, mat3x4(1.0, -6.0, -5.0, 7.0, 2.0, -1.0, 4.0, 1.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.b), vec2(3.0, 8.0)) && allOk;
	allOk = compare_int((blockE.g[0]), -4) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(9.0, 7.0, 5.0, -2.0, 9.0, -6.0, 1.0, 2.0, -4.0, -1.0, -9.0, 0.0));
	blockC.b = f16vec2(vec2(0.0, 6.0));
	blockC.c = (bvec3(false, true, true));
	blockC.d = f16vec3(vec3(4.0, -4.0, -4.0));
	blockE.g[0] = (0);
}
#version 450
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
	mediump mat2x3 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat2x3(8.0, 7.0, -2.0, 6.0, 0.0, 5.0));
	blockB.a[1] = (mat2x3(9.0, -5.0, 4.0, 7.0, -1.0, 6.0));
	blockB.a[2] = (mat2x3(5.0, 8.0, 6.0, 2.0, -7.0, -2.0));
	blockB.a[3] = (mat2x3(-4.0, -2.0, 4.0, -2.0, 3.0, 0.0));
}
#version 450
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
	bool mA;
	sA mB;
	f16vec4 mC;
};
struct sC
{
	mediump mat3 mA;
};
struct sD
{
	bvec4 mA;
	highp mat4x2 mB;
	mediump mat3 mC;
	highp uint mD;
};
struct sE
{
	bvec3 mA[3];
	i16vec4 mB;
};
struct sF
{
	i16vec3 mA;
	bvec3 mB;
};
struct sG
{
	u16vec4 mA;
	lowp mat3 mB;
	bvec4 mC;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	sB a;
	sC b;
	lowp vec2 c[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	u16vec4 d;
	sD e[6];
	mediump mat3x2 f;
	mediump vec3 g[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	mediump mat2 h;
	lowp mat4 i;
	sE j;
	sF k;
	sG l[];
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.c[0]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec2((blockB.c[1]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB.c[2]), vec2(-9.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB.c[3]), vec2(-5.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB.c[4]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_vec2((blockB.c[5]), vec2(9.0, 6.0)) && allOk;
	allOk = compare_vec2((blockB.c[6]), vec2(3.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB.c[7]), vec2(1.0, -4.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.d), uvec4(3u, 4u, 6u, 5u)) && allOk;
	allOk = compare_bvec4((blockC.e[0].mA), bvec4(true, true, false, true)) && allOk;
	allOk = compare_mat4x2(blockC.e[0].mB, mat4x2(7.0, -1.0, 7.0, 2.0, 2.0, -3.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat3(blockC.e[0].mC, mat3(2.0, -5.0, 8.0, -4.0, -5.0, -4.0, 0.0, 2.0, -5.0)) && allOk;
	allOk = compare_uint((blockC.e[0].mD), 4u) && allOk;
	allOk = compare_bvec4((blockC.e[1].mA), bvec4(false, false, true, true)) && allOk;
	allOk = compare_mat4x2(blockC.e[1].mB, mat4x2(4.0, 4.0, 7.0, 2.0, -1.0, -2.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3(blockC.e[1].mC, mat3(-9.0, 4.0, -2.0, 4.0, 1.0, -4.0, -6.0, 8.0, 9.0)) && allOk;
	allOk = compare_uint((blockC.e[1].mD), 9u) && allOk;
	allOk = compare_bvec4((blockC.e[2].mA), bvec4(false, false, true, false)) && allOk;
	allOk = compare_mat4x2(blockC.e[2].mB, mat4x2(-5.0, 6.0, 2.0, 8.0, -8.0, 9.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(blockC.e[2].mC, mat3(-4.0, 7.0, -3.0, -4.0, 0.0, 9.0, 7.0, 6.0, 1.0)) && allOk;
	allOk = compare_uint((blockC.e[2].mD), 2u) && allOk;
	allOk = compare_bvec4((blockC.e[3].mA), bvec4(false, true, false, false)) && allOk;
	allOk = compare_mat4x2(blockC.e[3].mB, mat4x2(0.0, -9.0, -7.0, -2.0, 1.0, -5.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(blockC.e[3].mC, mat3(4.0, -6.0, 0.0, -6.0, -4.0, 6.0, -9.0, 4.0, -2.0)) && allOk;
	allOk = compare_uint((blockC.e[3].mD), 4u) && allOk;
	allOk = compare_bvec4((blockC.e[4].mA), bvec4(false, false, false, true)) && allOk;
	allOk = compare_mat4x2(blockC.e[4].mB, mat4x2(-1.0, 7.0, -7.0, -2.0, -8.0, -9.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(blockC.e[4].mC, mat3(-5.0, -3.0, 4.0, -2.0, 7.0, -3.0, -8.0, -3.0, 8.0)) && allOk;
	allOk = compare_uint((blockC.e[4].mD), 4u) && allOk;
	allOk = compare_bvec4((blockC.e[5].mA), bvec4(true, false, false, true)) && allOk;
	allOk = compare_mat4x2(blockC.e[5].mB, mat4x2(3.0, 8.0, -1.0, 7.0, 2.0, -5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3(blockC.e[5].mC, mat3(-7.0, -2.0, -4.0, 0.0, 8.0, 4.0, 9.0, 4.0, 2.0)) && allOk;
	allOk = compare_uint((blockC.e[5].mD), 9u) && allOk;
	allOk = compare_vec3((blockC.g[0]), vec3(6.0, 2.0, -9.0)) && allOk;
	allOk = compare_vec3((blockC.g[1]), vec3(-6.0, 3.0, 7.0)) && allOk;
	allOk = compare_vec3((blockC.g[2]), vec3(-8.0, -3.0, 6.0)) && allOk;
	allOk = compare_vec3((blockC.g[3]), vec3(6.0, -5.0, -5.0)) && allOk;
	allOk = compare_vec3((blockC.g[4]), vec3(-5.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec3((blockC.g[5]), vec3(7.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec3((blockC.g[6]), vec3(-4.0, -6.0, -7.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD.k.mA), ivec3(-9, 6, -9)) && allOk;
	allOk = compare_bvec3((blockD.k.mB), bvec3(false, false, true)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.l[0].mA), uvec4(1u, 9u, 6u, 7u)) && allOk;
	allOk = compare_mat3(blockD.l[0].mB, mat3(-5.0, 6.0, -2.0, -8.0, -6.0, 5.0, 1.0, 2.0, 9.0)) && allOk;
	allOk = compare_bvec4((blockD.l[0].mC), bvec4(true, false, false, false)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.l[1].mA), uvec4(8u, 5u, 7u, 2u)) && allOk;
	allOk = compare_mat3(blockD.l[1].mB, mat3(9.0, -3.0, 7.0, 2.0, -1.0, 2.0, 5.0, -6.0, 8.0)) && allOk;
	allOk = compare_bvec4((blockD.l[1].mC), bvec4(true, false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (true);
	blockB.a.mB.mA = u16vec4(uvec4(9u, 0u, 5u, 3u));
	blockB.a.mC = f16vec4(vec4(4.0, -9.0, -6.0, 5.0));
	blockB.b.mA = (mat3(-7.0, -4.0, 5.0, 1.0, -9.0, 5.0, 9.0, -8.0, 1.0));
	blockC.e[0].mA = (bvec4(false, false, true, true));
	blockC.e[0].mB = (mat4x2(-5.0, -3.0, 8.0, 0.0, 4.0, -9.0, 3.0, 7.0));
	blockC.e[0].mC = (mat3(-2.0, -6.0, -7.0, 3.0, 0.0, 5.0, -3.0, -8.0, -5.0));
	blockC.e[0].mD = (1u);
	blockC.e[1].mA = (bvec4(false, true, false, true));
	blockC.e[1].mB = (mat4x2(5.0, 1.0, -5.0, -5.0, 6.0, 3.0, -6.0, 0.0));
	blockC.e[1].mC = (mat3(-9.0, -7.0, -5.0, -9.0, 4.0, 9.0, 6.0, -3.0, -6.0));
	blockC.e[1].mD = (0u);
	blockC.e[2].mA = (bvec4(false, false, true, false));
	blockC.e[2].mB = (mat4x2(1.0, -2.0, -1.0, -4.0, 4.0, -4.0, -4.0, -2.0));
	blockC.e[2].mC = (mat3(-7.0, 5.0, 1.0, 4.0, 4.0, 2.0, 4.0, 1.0, 8.0));
	blockC.e[2].mD = (9u);
	blockC.e[3].mA = (bvec4(true, false, false, true));
	blockC.e[3].mB = (mat4x2(-7.0, -6.0, -1.0, 4.0, 0.0, -5.0, -5.0, 4.0));
	blockC.e[3].mC = (mat3(-1.0, -4.0, -5.0, 0.0, -5.0, -8.0, -9.0, 4.0, 4.0));
	blockC.e[3].mD = (9u);
	blockC.e[4].mA = (bvec4(false, true, false, false));
	blockC.e[4].mB = (mat4x2(-3.0, 5.0, -1.0, 0.0, -2.0, 0.0, -2.0, 4.0));
	blockC.e[4].mC = (mat3(0.0, -6.0, 6.0, 4.0, -8.0, 6.0, 8.0, 9.0, 7.0));
	blockC.e[4].mD = (9u);
	blockC.e[5].mA = (bvec4(false, false, false, false));
	blockC.e[5].mB = (mat4x2(-9.0, 4.0, -4.0, 4.0, -2.0, 8.0, -4.0, 4.0));
	blockC.e[5].mC = (mat3(-5.0, 5.0, -1.0, 9.0, -3.0, 5.0, -7.0, -9.0, -4.0));
	blockC.e[5].mD = (2u);
	blockD.k.mA = i16vec3(ivec3(3, 1, 1));
	blockD.k.mB = (bvec3(false, true, true));
	blockD.l[0].mA = u16vec4(uvec4(7u, 7u, 1u, 8u));
	blockD.l[0].mB = (mat3(-8.0, 9.0, -7.0, 2.0, -4.0, -9.0, 0.0, 2.0, -6.0));
	blockD.l[0].mC = (bvec4(false, true, false, false));
	blockD.l[1].mA = u16vec4(uvec4(1u, 0u, 7u, 7u));
	blockD.l[1].mB = (mat3(-5.0, -4.0, 2.0, 9.0, 7.0, -8.0, -6.0, -4.0, 5.0));
	blockD.l[1].mC = (bvec4(false, true, true, true));
}
#version 450
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
	lowp ivec2 a;
	mediump vec3 b;
	f16vec3 c;
	lowp mat3x2 d;
	float16_t e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(-4, 4)) && allOk;
	allOk = compare_vec3((blockB.b), vec3(-6.0, -2.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.c), vec3(-2.0, 6.0, 3.0)) && allOk;
	allOk = compare_float16_t(float(blockB.e[0]), -1.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1]), 4.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2]), 8.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[3]), -1.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[4]), 6.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[5]), 5.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[6]), -8.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[7]), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(6, 0));
	blockB.b = (vec3(5.0, 1.0, -7.0));
	blockB.c = f16vec3(vec3(-3.0, -7.0, 9.0));
	blockB.d = (mat3x2(-9.0, -8.0, 8.0, -9.0, 0.0, 5.0));
	blockB.e[0] = float16_t(4.0);
	blockB.e[1] = float16_t(-2.0);
	blockB.e[2] = float16_t(-5.0);
	blockB.e[3] = float16_t(5.0);
	blockB.e[4] = float16_t(-6.0);
	blockB.e[5] = float16_t(3.0);
	blockB.e[6] = float16_t(-5.0);
	blockB.e[7] = float16_t(0.0);
}
#version 450
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
	u16vec2 mA;
	mediump mat4x2 mB;
	mediump ivec3 mC;
	lowp vec3 mD;
};
struct sB
{
	i16vec2 mA;
	sA mB;
	mediump uvec3 mC[2];
	bool mD;
};
struct sC
{
	f16vec3 mA;
};
layout(scalar, buffer_reference) buffer BlockB
{
	f16vec2 a;
	sB b;
	mediump mat2 c[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	bvec2 d;
	highp vec4 e;
	f16vec2 f;
	lowp vec2 g[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	bvec3 h;
	lowp mat3x2 i[];
};
layout(scalar, row_major, buffer_reference) buffer BlockE
{
	sC j;
	u16vec4 k[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB[0].a), vec2(3.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB[1].a), vec2(-5.0, -8.0)) && allOk;
	allOk = compare_bvec2((blockC.d), bvec2(true, false)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f), vec2(6.0, -9.0)) && allOk;
	allOk = compare_vec2((blockC.g[0]), vec2(2.0, 9.0)) && allOk;
	allOk = compare_vec2((blockC.g[1]), vec2(-3.0, 8.0)) && allOk;
	allOk = compare_vec2((blockC.g[2]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((blockC.g[3]), vec2(7.0, -7.0)) && allOk;
	allOk = compare_vec2((blockC.g[4]), vec2(-6.0, -6.0)) && allOk;
	allOk = compare_vec2((blockC.g[5]), vec2(-6.0, -6.0)) && allOk;
	allOk = compare_vec2((blockC.g[6]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.j.mA), vec3(-9.0, 2.0, 5.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.k[0]), uvec4(1u, 5u, 2u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.k[1]), uvec4(8u, 9u, 2u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = f16vec2(vec2(-1.0, -2.0));
	blockB[0].b.mA = i16vec2(ivec2(8, -9));
	blockB[0].b.mB.mA = u16vec2(uvec2(8u, 5u));
	blockB[0].b.mB.mB = (mat4x2(7.0, -6.0, 5.0, 2.0, 1.0, -1.0, -7.0, -8.0));
	blockB[0].b.mB.mC = (ivec3(-8, -5, 1));
	blockB[0].b.mB.mD = (vec3(-3.0, 9.0, 1.0));
	blockB[0].b.mC[0] = (uvec3(8u, 3u, 5u));
	blockB[0].b.mC[1] = (uvec3(3u, 2u, 5u));
	blockB[0].b.mD = (false);
	blockB[1].a = f16vec2(vec2(4.0, 9.0));
	blockB[1].b.mA = i16vec2(ivec2(3, -7));
	blockB[1].b.mB.mA = u16vec2(uvec2(8u, 9u));
	blockB[1].b.mB.mB = (mat4x2(7.0, 4.0, 9.0, 6.0, 9.0, -6.0, 2.0, 0.0));
	blockB[1].b.mB.mC = (ivec3(-5, 7, -8));
	blockB[1].b.mB.mD = (vec3(7.0, -3.0, -4.0));
	blockB[1].b.mC[0] = (uvec3(7u, 8u, 8u));
	blockB[1].b.mC[1] = (uvec3(1u, 4u, 5u));
	blockB[1].b.mD = (true);
	blockC.d = (bvec2(true, false));
	blockC.e = (vec4(-8.0, -5.0, -3.0, -7.0));
	blockC.f = f16vec2(vec2(-1.0, 7.0));
	blockC.g[0] = (vec2(-9.0, -6.0));
	blockC.g[1] = (vec2(-1.0, 0.0));
	blockC.g[2] = (vec2(-1.0, 9.0));
	blockC.g[3] = (vec2(-6.0, 0.0));
	blockC.g[4] = (vec2(-7.0, -5.0));
	blockC.g[5] = (vec2(6.0, 2.0));
	blockC.g[6] = (vec2(-6.0, -5.0));
	blockD.h = (bvec3(false, false, true));
	blockE.j.mA = f16vec3(vec3(0.0, -8.0, -9.0));
	blockE.k[0] = u16vec4(uvec4(0u, 2u, 9u, 5u));
	blockE.k[1] = u16vec4(uvec4(4u, 7u, 8u, 4u));
}
#version 450
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
	highp ivec3 a[8];
	mediump vec2 b[];
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockC
{
	f16vec4 c;
	f16vec3 d;
	u16vec4 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[0].b[0]), vec2(7.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB[0].b[1]), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB[0].b[2]), vec2(-9.0, -5.0)) && allOk;
	allOk = compare_vec2((blockB[0].b[3]), vec2(-9.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB[0].b[4]), vec2(-7.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB[1].b[0]), vec2(6.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB[1].b[1]), vec2(7.0, -5.0)) && allOk;
	allOk = compare_vec2((blockB[1].b[2]), vec2(0.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB[1].b[3]), vec2(-7.0, 1.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].e[0]), uvec4(8u, 8u, 9u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].e[1]), uvec4(2u, 5u, 9u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].e[2]), uvec4(5u, 5u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].e[3]), uvec4(4u, 7u, 4u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].e[4]), uvec4(1u, 0u, 7u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].e[5]), uvec4(7u, 9u, 0u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].e[0]), uvec4(6u, 3u, 1u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].e[1]), uvec4(9u, 5u, 5u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].e[2]), uvec4(4u, 1u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].e[3]), uvec4(7u, 5u, 9u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (ivec3(-3, -8, -4));
	blockB[0].a[1] = (ivec3(-1, -1, -8));
	blockB[0].a[2] = (ivec3(8, -8, 8));
	blockB[0].a[3] = (ivec3(-4, -2, -4));
	blockB[0].a[4] = (ivec3(-5, 8, -2));
	blockB[0].a[5] = (ivec3(-7, 6, -2));
	blockB[0].a[6] = (ivec3(3, 5, -1));
	blockB[0].a[7] = (ivec3(3, 9, 4));
	blockB[0].b[0] = (vec2(0.0, 1.0));
	blockB[0].b[1] = (vec2(-1.0, 3.0));
	blockB[0].b[2] = (vec2(8.0, 3.0));
	blockB[0].b[3] = (vec2(-9.0, 7.0));
	blockB[0].b[4] = (vec2(-3.0, -2.0));
	blockB[1].a[0] = (ivec3(3, -1, -1));
	blockB[1].a[1] = (ivec3(6, -8, 4));
	blockB[1].a[2] = (ivec3(5, -9, 7));
	blockB[1].a[3] = (ivec3(9, 3, -6));
	blockB[1].a[4] = (ivec3(5, 5, 0));
	blockB[1].a[5] = (ivec3(9, 6, 2));
	blockB[1].a[6] = (ivec3(-3, 6, 4));
	blockB[1].a[7] = (ivec3(-4, -4, 8));
	blockB[1].b[0] = (vec2(-3.0, -7.0));
	blockB[1].b[1] = (vec2(5.0, -7.0));
	blockB[1].b[2] = (vec2(-2.0, 2.0));
	blockB[1].b[3] = (vec2(4.0, 0.0));
}
#version 450
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
	mediump uvec3 a;
	highp uint b;
	int16_t c;
	mediump vec3 d[5];
	mediump ivec2 e;
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	mediump mat3x4 f;
	highp mat3 g[][7];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	bvec3 h;
	lowp mat4x2 i[];
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	lowp vec4 j;
	bvec3 k;
	float16_t l[4];
	lowp float m;
	bvec4 n[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD[3];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[0].b), 4u) && allOk;
	allOk = compare_ivec2((blockB[0].e), ivec2(6, -6)) && allOk;
	allOk = compare_bvec3((blockD[0].h), bvec3(false, true, true)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[0], mat4x2(-4.0, 0.0, 2.0, 1.0, -7.0, -2.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[1], mat4x2(5.0, -9.0, -9.0, 8.0, -1.0, -2.0, -5.0, -2.0)) && allOk;
	allOk = compare_bvec3((blockD[1].h), bvec3(true, true, true)) && allOk;
	allOk = compare_mat4x2(blockD[1].i[0], mat4x2(-9.0, 0.0, 7.0, -9.0, -2.0, 1.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].i[1], mat4x2(1.0, -3.0, 7.0, -1.0, 4.0, 0.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].i[2], mat4x2(-4.0, 7.0, 1.0, -2.0, 2.0, 2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].i[3], mat4x2(9.0, 9.0, 1.0, 6.0, -4.0, 0.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].i[4], mat4x2(0.0, -5.0, 9.0, -3.0, -5.0, -2.0, -7.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockD[2].h), bvec3(false, false, true)) && allOk;
	allOk = compare_mat4x2(blockD[2].i[0], mat4x2(-5.0, 0.0, 7.0, 0.0, -2.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockD[2].i[1], mat4x2(1.0, 6.0, 1.0, -4.0, -9.0, -9.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockD[2].i[2], mat4x2(-6.0, 7.0, 9.0, -8.0, 6.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockD[2].i[3], mat4x2(-8.0, 0.0, -8.0, -7.0, -1.0, 5.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockD[2].i[4], mat4x2(-1.0, 4.0, -4.0, -1.0, 5.0, -9.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockD[2].i[5], mat4x2(3.0, 8.0, -6.0, -1.0, -1.0, 6.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockD[2].i[6], mat4x2(0.0, 4.0, 8.0, -6.0, 2.0, -1.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4((blockE.j), vec4(-8.0, 2.0, 8.0, 5.0)) && allOk;
	allOk = compare_bvec3((blockE.k), bvec3(true, false, false)) && allOk;
	allOk = compare_float16_t(float(blockE.l[0]), -3.0) && allOk;
	allOk = compare_float16_t(float(blockE.l[1]), 1.0) && allOk;
	allOk = compare_float16_t(float(blockE.l[2]), -5.0) && allOk;
	allOk = compare_float16_t(float(blockE.l[3]), -8.0) && allOk;
	allOk = compare_float((blockE.m), 7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (uvec3(8u, 0u, 1u));
	blockB[0].c = int16_t(-3);
	blockB[0].e = (ivec2(0, -9));
	blockC.f = (mat3x4(4.0, 7.0, -9.0, -5.0, 5.0, -9.0, 1.0, -9.0, 6.0, -4.0, 3.0, 3.0));
	blockC.g[0][0] = (mat3(6.0, 4.0, -6.0, -3.0, -1.0, 5.0, 5.0, -5.0, -9.0));
	blockC.g[0][1] = (mat3(3.0, -2.0, 3.0, 0.0, 7.0, -5.0, -2.0, -9.0, -3.0));
	blockC.g[0][2] = (mat3(9.0, -9.0, 4.0, -4.0, 0.0, -8.0, 4.0, -8.0, 3.0));
	blockC.g[0][3] = (mat3(6.0, -7.0, 8.0, -1.0, 7.0, -2.0, -3.0, 1.0, -2.0));
	blockC.g[0][4] = (mat3(-3.0, 0.0, -4.0, 4.0, -3.0, -8.0, 0.0, 7.0, -6.0));
	blockC.g[0][5] = (mat3(-6.0, 4.0, -1.0, 4.0, -9.0, -2.0, -6.0, 4.0, 2.0));
	blockC.g[0][6] = (mat3(-9.0, 9.0, -2.0, 5.0, -9.0, -2.0, -6.0, -2.0, 9.0));
	blockC.g[1][0] = (mat3(0.0, -2.0, -3.0, 8.0, 3.0, 5.0, 8.0, -1.0, -2.0));
	blockC.g[1][1] = (mat3(1.0, -2.0, 4.0, -9.0, 5.0, 2.0, 4.0, 6.0, 7.0));
	blockC.g[1][2] = (mat3(0.0, 9.0, 5.0, 1.0, -8.0, 5.0, -1.0, 2.0, 3.0));
	blockC.g[1][3] = (mat3(7.0, -2.0, -8.0, -4.0, 4.0, -4.0, 3.0, -2.0, -6.0));
	blockC.g[1][4] = (mat3(2.0, 4.0, 1.0, 1.0, 7.0, 1.0, -4.0, -8.0, -1.0));
	blockC.g[1][5] = (mat3(-5.0, 9.0, -7.0, -7.0, -8.0, 7.0, 4.0, -3.0, 1.0));
	blockC.g[1][6] = (mat3(7.0, -4.0, -5.0, 0.0, 7.0, 2.0, 4.0, -1.0, 8.0));
	blockC.g[2][0] = (mat3(5.0, 3.0, -5.0, -1.0, 0.0, -1.0, 0.0, -5.0, 2.0));
	blockC.g[2][1] = (mat3(-6.0, 8.0, -1.0, -3.0, -1.0, 7.0, -6.0, -5.0, 1.0));
	blockC.g[2][2] = (mat3(-3.0, 7.0, -6.0, 3.0, -6.0, 0.0, -6.0, 4.0, 6.0));
	blockC.g[2][3] = (mat3(-3.0, -5.0, -1.0, -4.0, -7.0, 9.0, -7.0, -4.0, -4.0));
	blockC.g[2][4] = (mat3(-3.0, 9.0, -2.0, -5.0, -3.0, -5.0, 1.0, -3.0, -7.0));
	blockC.g[2][5] = (mat3(1.0, 5.0, 9.0, -6.0, 5.0, -7.0, 5.0, -7.0, -6.0));
	blockC.g[2][6] = (mat3(-7.0, 1.0, -5.0, 2.0, 5.0, 5.0, -4.0, 7.0, -6.0));
	blockC.g[3][0] = (mat3(-5.0, 7.0, 9.0, -9.0, 0.0, -2.0, 9.0, 5.0, 0.0));
	blockC.g[3][1] = (mat3(6.0, -1.0, -2.0, 1.0, -3.0, -2.0, 2.0, -7.0, 5.0));
	blockC.g[3][2] = (mat3(1.0, -1.0, 6.0, 0.0, 5.0, -6.0, -5.0, -7.0, 3.0));
	blockC.g[3][3] = (mat3(6.0, -8.0, 6.0, 3.0, -5.0, 1.0, 5.0, 4.0, 1.0));
	blockC.g[3][4] = (mat3(3.0, 6.0, -9.0, 1.0, 3.0, 6.0, 9.0, 9.0, 9.0));
	blockC.g[3][5] = (mat3(5.0, 1.0, 1.0, -1.0, 8.0, -3.0, -2.0, 4.0, 1.0));
	blockC.g[3][6] = (mat3(9.0, 4.0, 0.0, 7.0, 2.0, -9.0, -9.0, -8.0, -6.0));
	blockC.g[4][0] = (mat3(-6.0, 5.0, 0.0, 2.0, -9.0, 6.0, -3.0, -7.0, 9.0));
	blockC.g[4][1] = (mat3(2.0, -4.0, -6.0, -7.0, -3.0, -5.0, 5.0, -8.0, -2.0));
	blockC.g[4][2] = (mat3(-3.0, -1.0, 0.0, -5.0, 0.0, 8.0, 4.0, -6.0, -5.0));
	blockC.g[4][3] = (mat3(8.0, -2.0, 4.0, -3.0, 2.0, 1.0, 4.0, 3.0, -5.0));
	blockC.g[4][4] = (mat3(2.0, -7.0, -5.0, -1.0, 2.0, -7.0, 2.0, 4.0, 4.0));
	blockC.g[4][5] = (mat3(-4.0, -9.0, -1.0, 1.0, -7.0, -2.0, 4.0, -2.0, -4.0));
	blockC.g[4][6] = (mat3(-1.0, -1.0, -7.0, -8.0, -2.0, -7.0, -6.0, 5.0, 8.0));
	blockC.g[5][0] = (mat3(4.0, -2.0, 1.0, -4.0, 1.0, -1.0, 2.0, 6.0, -1.0));
	blockC.g[5][1] = (mat3(9.0, 9.0, -2.0, 5.0, 1.0, -9.0, 4.0, 7.0, -9.0));
	blockC.g[5][2] = (mat3(-9.0, 4.0, 3.0, -4.0, -3.0, -4.0, -3.0, -7.0, 6.0));
	blockC.g[5][3] = (mat3(-3.0, 3.0, -2.0, 0.0, 0.0, 7.0, -7.0, -9.0, 6.0));
	blockC.g[5][4] = (mat3(6.0, -5.0, -1.0, 2.0, 0.0, -5.0, -5.0, -2.0, -4.0));
	blockC.g[5][5] = (mat3(4.0, 2.0, 2.0, -2.0, -4.0, -5.0, -6.0, -5.0, 7.0));
	blockC.g[5][6] = (mat3(9.0, -4.0, 0.0, -8.0, -1.0, -3.0, -8.0, -9.0, 0.0));
	blockC.g[6][0] = (mat3(-7.0, 5.0, -5.0, 6.0, -1.0, -8.0, -6.0, 0.0, -2.0));
	blockC.g[6][1] = (mat3(-4.0, 4.0, -7.0, 7.0, 6.0, -5.0, -9.0, 0.0, 2.0));
	blockC.g[6][2] = (mat3(-3.0, 1.0, -9.0, 3.0, 3.0, 3.0, 1.0, -4.0, 6.0));
	blockC.g[6][3] = (mat3(-4.0, -4.0, 3.0, -3.0, 8.0, -4.0, 5.0, 4.0, -8.0));
	blockC.g[6][4] = (mat3(1.0, -9.0, -5.0, 8.0, 0.0, 2.0, -5.0, 0.0, 1.0));
	blockC.g[6][5] = (mat3(-3.0, -6.0, -7.0, -5.0, 2.0, 3.0, -9.0, -5.0, 5.0));
	blockC.g[6][6] = (mat3(8.0, 1.0, 2.0, -7.0, -3.0, -2.0, -9.0, 8.0, -9.0));
	blockD[0].h = (bvec3(false, true, true));
	blockD[0].i[0] = (mat4x2(-1.0, 9.0, 5.0, 1.0, 9.0, -2.0, 3.0, -1.0));
	blockD[0].i[1] = (mat4x2(-1.0, 8.0, 4.0, 4.0, -4.0, -9.0, -6.0, -7.0));
	blockD[1].h = (bvec3(true, false, false));
	blockD[1].i[0] = (mat4x2(-6.0, 8.0, -7.0, 5.0, -7.0, -6.0, -1.0, -9.0));
	blockD[1].i[1] = (mat4x2(8.0, -4.0, 7.0, 1.0, -9.0, 4.0, 8.0, 3.0));
	blockD[1].i[2] = (mat4x2(-1.0, -4.0, -1.0, 6.0, -1.0, 6.0, 0.0, -4.0));
	blockD[1].i[3] = (mat4x2(8.0, -8.0, -4.0, -4.0, 9.0, 9.0, 8.0, 8.0));
	blockD[1].i[4] = (mat4x2(-6.0, 1.0, 0.0, 7.0, -7.0, -6.0, -2.0, -5.0));
	blockD[2].h = (bvec3(true, true, false));
	blockD[2].i[0] = (mat4x2(2.0, 8.0, -1.0, 2.0, -6.0, -8.0, 4.0, 5.0));
	blockD[2].i[1] = (mat4x2(5.0, 1.0, -5.0, 3.0, 8.0, 6.0, -9.0, 4.0));
	blockD[2].i[2] = (mat4x2(9.0, 0.0, -4.0, -1.0, -8.0, 1.0, 1.0, 3.0));
	blockD[2].i[3] = (mat4x2(3.0, 5.0, -8.0, -4.0, 7.0, 3.0, 8.0, -8.0));
	blockD[2].i[4] = (mat4x2(2.0, -7.0, 4.0, 2.0, 0.0, 7.0, -2.0, -8.0));
	blockD[2].i[5] = (mat4x2(3.0, 7.0, -7.0, -5.0, 4.0, -1.0, 8.0, 0.0));
	blockD[2].i[6] = (mat4x2(-7.0, -1.0, -2.0, 7.0, 8.0, 6.0, 6.0, -8.0));
	blockE.j = (vec4(8.0, -8.0, 4.0, 5.0));
	blockE.k = (bvec3(true, true, false));
	blockE.l[0] = float16_t(6.0);
	blockE.l[1] = float16_t(-2.0);
	blockE.l[2] = float16_t(3.0);
	blockE.l[3] = float16_t(9.0);
	blockE.n[0] = (bvec4(false, false, false, true));
	blockE.n[1] = (bvec4(false, true, false, true));
	blockE.n[2] = (bvec4(false, true, true, true));
	blockE.n[3] = (bvec4(true, true, true, true));
}
#version 450
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
	float16_t a;
	lowp int b;
	i16vec2 c;
	mediump float d;
	mediump vec2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(0)].c), ivec2(-9, -9)) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(0)].d), -9.0) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].e), vec2(0.0, 8.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(1)].c), ivec2(6, -5)) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(1)].d), -2.0) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].e), vec2(5.0, -6.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(2)].c), ivec2(5, -7)) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(2)].d), 4.0) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].e), vec2(-2.0, -3.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(3)].c), ivec2(-4, 4)) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(3)].d), 0.0) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(3)].e), vec2(4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = float16_t(0.0);
	blockB[nonuniformEXT(0)].b = (-7);
	blockB[nonuniformEXT(0)].c = i16vec2(ivec2(-2, -6));
	blockB[nonuniformEXT(1)].a = float16_t(5.0);
	blockB[nonuniformEXT(1)].b = (-3);
	blockB[nonuniformEXT(1)].c = i16vec2(ivec2(4, 9));
	blockB[nonuniformEXT(2)].a = float16_t(-7.0);
	blockB[nonuniformEXT(2)].b = (9);
	blockB[nonuniformEXT(2)].c = i16vec2(ivec2(7, -4));
	blockB[nonuniformEXT(3)].a = float16_t(7.0);
	blockB[nonuniformEXT(3)].b = (-4);
	blockB[nonuniformEXT(3)].c = i16vec2(ivec2(-2, -4));
}
#version 450
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
	highp uvec2 mA;
	highp ivec2 mB;
	mediump mat4x2 mC;
};
struct sB
{
	i8vec3 mA;
	sA mB;
	u8vec4 mC;
};
struct sC
{
	mediump uvec2 mA;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	sB a;
	mediump mat3 b[7][6];
	bvec2 c;
	u8vec3 d;
	sC e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.b[0][0], mat3(7.0, -5.0, -7.0, 0.0, 2.0, -2.0, -2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3(blockB.b[0][1], mat3(8.0, -5.0, 8.0, 9.0, 2.0, 7.0, 0.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(blockB.b[0][2], mat3(-3.0, -9.0, -1.0, 1.0, 2.0, -3.0, 4.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3(blockB.b[0][3], mat3(0.0, 3.0, -4.0, 2.0, 3.0, 8.0, 7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(blockB.b[0][4], mat3(0.0, -5.0, 6.0, 4.0, -5.0, -9.0, 1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB.b[0][5], mat3(-3.0, -9.0, -8.0, 5.0, -6.0, -6.0, 1.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(blockB.b[1][0], mat3(-6.0, 7.0, 5.0, 0.0, 0.0, -1.0, -1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3(blockB.b[1][1], mat3(4.0, -9.0, -2.0, 6.0, 3.0, 9.0, 5.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3(blockB.b[1][2], mat3(-1.0, -1.0, 4.0, -8.0, -1.0, -8.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB.b[1][3], mat3(-6.0, -1.0, -4.0, 6.0, 0.0, -9.0, 0.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB.b[1][4], mat3(-1.0, -2.0, -4.0, -9.0, 4.0, 5.0, -4.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3(blockB.b[1][5], mat3(7.0, 2.0, 9.0, 8.0, -4.0, -8.0, 3.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3(blockB.b[2][0], mat3(-1.0, -9.0, -7.0, -8.0, 5.0, -6.0, -2.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat3(blockB.b[2][1], mat3(-1.0, 5.0, 0.0, 5.0, -4.0, -7.0, -6.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB.b[2][2], mat3(0.0, 1.0, 4.0, 8.0, -8.0, -4.0, 5.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat3(blockB.b[2][3], mat3(7.0, 9.0, 7.0, 4.0, 8.0, 8.0, 6.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat3(blockB.b[2][4], mat3(6.0, 9.0, -4.0, 1.0, 4.0, 4.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3(blockB.b[2][5], mat3(-6.0, 9.0, 2.0, 8.0, -9.0, -1.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(blockB.b[3][0], mat3(8.0, 2.0, 3.0, -6.0, -6.0, 1.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3(blockB.b[3][1], mat3(5.0, -7.0, -7.0, -2.0, 7.0, 8.0, -3.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat3(blockB.b[3][2], mat3(-2.0, 6.0, 4.0, -2.0, 4.0, -3.0, -9.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(blockB.b[3][3], mat3(9.0, 8.0, -9.0, -4.0, 6.0, -8.0, -3.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB.b[3][4], mat3(-5.0, -7.0, 2.0, 2.0, -8.0, 4.0, 8.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(blockB.b[3][5], mat3(-1.0, -4.0, -9.0, -6.0, -1.0, 0.0, -6.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(blockB.b[4][0], mat3(3.0, 9.0, -5.0, -2.0, -8.0, 9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3(blockB.b[4][1], mat3(8.0, 3.0, -7.0, -5.0, 4.0, -8.0, 3.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB.b[4][2], mat3(7.0, 8.0, 6.0, -4.0, 1.0, -5.0, 4.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(blockB.b[4][3], mat3(4.0, 7.0, 8.0, 1.0, 0.0, 3.0, 4.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(blockB.b[4][4], mat3(-8.0, -5.0, -2.0, -4.0, -1.0, -1.0, -3.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB.b[4][5], mat3(9.0, -5.0, 9.0, -2.0, -2.0, 9.0, -6.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(blockB.b[5][0], mat3(6.0, 9.0, 0.0, -6.0, -2.0, -9.0, 3.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(blockB.b[5][1], mat3(2.0, 0.0, 2.0, -2.0, -7.0, 8.0, 0.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(blockB.b[5][2], mat3(-1.0, -2.0, 1.0, -5.0, 0.0, 4.0, -3.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(blockB.b[5][3], mat3(8.0, -5.0, 2.0, 5.0, -9.0, 6.0, 4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3(blockB.b[5][4], mat3(0.0, -3.0, -7.0, 1.0, 6.0, -6.0, -6.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3(blockB.b[5][5], mat3(-1.0, -6.0, -2.0, -8.0, 7.0, 1.0, 0.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3(blockB.b[6][0], mat3(4.0, 7.0, -5.0, 4.0, 5.0, 6.0, -4.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3(blockB.b[6][1], mat3(-3.0, -5.0, 2.0, 2.0, -9.0, 5.0, 0.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(blockB.b[6][2], mat3(4.0, 6.0, -9.0, -7.0, 4.0, 9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3(blockB.b[6][3], mat3(1.0, -8.0, 3.0, 4.0, 4.0, -3.0, -4.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB.b[6][4], mat3(8.0, 1.0, 6.0, -7.0, 9.0, 2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB.b[6][5], mat3(5.0, 9.0, 9.0, -7.0, 3.0, -6.0, -7.0, 2.0, -6.0)) && allOk;
	allOk = compare_bvec2((blockB.c), bvec2(true, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.d), uvec3(9u, 2u, 8u)) && allOk;
	allOk = compare_uvec2((blockB.e[0].mA), uvec2(4u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.e[1].mA), uvec2(3u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = i8vec3(ivec3(0, 4294967289, 3));
	blockB.a.mB.mA = (uvec2(8u, 6u));
	blockB.a.mB.mB = (ivec2(-7, 4));
	blockB.a.mB.mC = (mat4x2(6.0, 3.0, -8.0, -3.0, 8.0, -1.0, -3.0, 6.0));
	blockB.a.mC = u8vec4(uvec4(2u, 3u, 6u, 3u));
	blockB.b[0][0] = (mat3(-2.0, -9.0, 5.0, 2.0, -5.0, -5.0, -3.0, 3.0, -2.0));
	blockB.b[0][1] = (mat3(-2.0, -3.0, -3.0, 8.0, -8.0, -1.0, -3.0, 1.0, 3.0));
	blockB.b[0][2] = (mat3(7.0, -1.0, -9.0, -4.0, -3.0, 8.0, -5.0, 1.0, 9.0));
	blockB.b[0][3] = (mat3(-8.0, -3.0, 6.0, -8.0, 0.0, 1.0, 3.0, 4.0, -4.0));
	blockB.b[0][4] = (mat3(6.0, -1.0, -7.0, 0.0, 5.0, -6.0, -2.0, 2.0, -2.0));
	blockB.b[0][5] = (mat3(-6.0, -9.0, 9.0, 9.0, 5.0, -9.0, 9.0, -3.0, -7.0));
	blockB.b[1][0] = (mat3(6.0, 4.0, 0.0, 9.0, 5.0, 5.0, 0.0, -3.0, 0.0));
	blockB.b[1][1] = (mat3(1.0, -7.0, -2.0, -1.0, -6.0, -1.0, 0.0, 7.0, -5.0));
	blockB.b[1][2] = (mat3(-6.0, 5.0, -6.0, -6.0, 9.0, -4.0, 2.0, -4.0, 3.0));
	blockB.b[1][3] = (mat3(5.0, 2.0, -3.0, 0.0, -8.0, -7.0, 3.0, -4.0, 3.0));
	blockB.b[1][4] = (mat3(1.0, -9.0, -8.0, 6.0, -9.0, -1.0, 1.0, 0.0, -3.0));
	blockB.b[1][5] = (mat3(8.0, 5.0, 7.0, -5.0, -7.0, -3.0, 3.0, 9.0, 2.0));
	blockB.b[2][0] = (mat3(1.0, 5.0, 1.0, 4.0, -3.0, -3.0, -3.0, -2.0, 5.0));
	blockB.b[2][1] = (mat3(9.0, 5.0, -4.0, 7.0, 0.0, 4.0, 3.0, -1.0, 9.0));
	blockB.b[2][2] = (mat3(5.0, 9.0, -4.0, -4.0, -6.0, 1.0, 0.0, -6.0, 8.0));
	blockB.b[2][3] = (mat3(-7.0, -6.0, -6.0, -3.0, 7.0, -2.0, 7.0, -9.0, -8.0));
	blockB.b[2][4] = (mat3(2.0, -3.0, 7.0, -9.0, -6.0, 1.0, 4.0, -2.0, 2.0));
	blockB.b[2][5] = (mat3(-3.0, 8.0, -4.0, -7.0, 9.0, 2.0, 1.0, 9.0, 4.0));
	blockB.b[3][0] = (mat3(-8.0, 0.0, 1.0, -8.0, -4.0, -5.0, -5.0, 3.0, -1.0));
	blockB.b[3][1] = (mat3(-5.0, 3.0, 8.0, 9.0, 8.0, -6.0, 1.0, 8.0, -6.0));
	blockB.b[3][2] = (mat3(-4.0, -8.0, 7.0, -1.0, 0.0, -7.0, -2.0, -4.0, 9.0));
	blockB.b[3][3] = (mat3(9.0, 0.0, -8.0, 7.0, -1.0, 0.0, 5.0, 4.0, -8.0));
	blockB.b[3][4] = (mat3(6.0, -9.0, -3.0, 2.0, 0.0, -2.0, -6.0, -4.0, 4.0));
	blockB.b[3][5] = (mat3(2.0, -9.0, 5.0, -1.0, 9.0, -2.0, 4.0, 0.0, 2.0));
	blockB.b[4][0] = (mat3(4.0, -3.0, -9.0, 3.0, 9.0, 7.0, 0.0, 8.0, -1.0));
	blockB.b[4][1] = (mat3(-3.0, 9.0, -7.0, 9.0, 5.0, -1.0, 3.0, -1.0, -9.0));
	blockB.b[4][2] = (mat3(-7.0, -5.0, 4.0, 2.0, 0.0, 5.0, 3.0, -3.0, 8.0));
	blockB.b[4][3] = (mat3(9.0, 3.0, -3.0, -5.0, 1.0, -4.0, -2.0, -4.0, -4.0));
	blockB.b[4][4] = (mat3(6.0, 4.0, -8.0, 3.0, -3.0, -3.0, -6.0, 7.0, 9.0));
	blockB.b[4][5] = (mat3(9.0, -3.0, 3.0, 0.0, -4.0, -2.0, -2.0, 5.0, 9.0));
	blockB.b[5][0] = (mat3(1.0, 4.0, -2.0, 9.0, 6.0, 1.0, 5.0, 5.0, 6.0));
	blockB.b[5][1] = (mat3(3.0, -9.0, 9.0, -2.0, -9.0, -1.0, 2.0, 2.0, 7.0));
	blockB.b[5][2] = (mat3(-4.0, -7.0, -8.0, 2.0, -6.0, -6.0, -1.0, 0.0, -8.0));
	blockB.b[5][3] = (mat3(-6.0, -5.0, -3.0, 6.0, 2.0, 8.0, 2.0, -3.0, -5.0));
	blockB.b[5][4] = (mat3(-2.0, 7.0, -3.0, -3.0, 2.0, 3.0, -4.0, -3.0, 2.0));
	blockB.b[5][5] = (mat3(-1.0, -8.0, 1.0, -3.0, -4.0, -5.0, -6.0, 8.0, 2.0));
	blockB.b[6][0] = (mat3(8.0, -9.0, -4.0, -5.0, -7.0, 6.0, 1.0, 0.0, -8.0));
	blockB.b[6][1] = (mat3(-4.0, 6.0, -2.0, 4.0, 7.0, 4.0, 6.0, 7.0, 7.0));
	blockB.b[6][2] = (mat3(-9.0, 7.0, 8.0, -3.0, -1.0, 5.0, 2.0, 5.0, 5.0));
	blockB.b[6][3] = (mat3(9.0, -1.0, 5.0, 0.0, 6.0, -3.0, -1.0, 0.0, 1.0));
	blockB.b[6][4] = (mat3(7.0, 0.0, 1.0, 3.0, 2.0, -7.0, 4.0, 8.0, -8.0));
	blockB.b[6][5] = (mat3(-5.0, 3.0, 4.0, 3.0, -5.0, 3.0, -7.0, -6.0, -8.0));
	blockB.d = u8vec3(uvec3(4u, 5u, 2u));
	blockB.e[0].mA = (uvec2(7u, 7u));
	blockB.e[1].mA = (uvec2(4u, 1u));
}
#version 450
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
	i8vec2 a;
	lowp ivec2 b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	bvec3 c;
	i8vec4 d;
	u8vec3 e;
	highp uvec3 f[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	mediump mat4x2 g;
	highp mat4 h;
	bvec4 i[];
};
layout(std140, buffer_reference) readonly buffer BlockE
{
	mediump mat3x2 j;
	highp mat4x2 k[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.b[0]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((blockB.b[1]), ivec2(-8, -7)) && allOk;
	allOk = compare_ivec2((blockB.b[2]), ivec2(4, 0)) && allOk;
	allOk = compare_ivec2((blockB.b[3]), ivec2(-5, 9)) && allOk;
	allOk = compare_ivec2((blockB.b[4]), ivec2(3, -9)) && allOk;
	allOk = compare_ivec2((blockB.b[5]), ivec2(6, -6)) && allOk;
	allOk = compare_ivec2((blockB.b[6]), ivec2(-3, 7)) && allOk;
	allOk = compare_uvec3((blockC.f[0]), uvec3(3u, 8u, 4u)) && allOk;
	allOk = compare_mat4(blockD.h, mat4(-2.0, 9.0, 4.0, -2.0, 0.0, 5.0, -3.0, -8.0, -4.0, -3.0, -6.0, 2.0, 4.0, -6.0, 4.0, 5.0)) && allOk;
	allOk = compare_bvec4((blockD.i[0]), bvec4(false, true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec2(ivec2(4294967288, 4294967291));
	blockB.b[0] = (ivec2(7, 4));
	blockB.b[1] = (ivec2(4, 8));
	blockB.b[2] = (ivec2(1, -4));
	blockB.b[3] = (ivec2(0, -8));
	blockB.b[4] = (ivec2(6, -7));
	blockB.b[5] = (ivec2(7, 4));
	blockB.b[6] = (ivec2(3, -8));
	blockC.c = (bvec3(false, false, true));
	blockC.d = i8vec4(ivec4(4294967288, 7, 4, 4));
	blockC.e = u8vec3(uvec3(7u, 6u, 7u));
	blockC.f[0] = (uvec3(0u, 5u, 2u));
	blockD.g = (mat4x2(9.0, -7.0, -7.0, 4.0, -1.0, 6.0, 3.0, -8.0));
	blockD.i[0] = (bvec4(true, false, true, true));
}
#version 450
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
	highp ivec3 mB;
	uint8_t mC;
	i8vec2 mD;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	sA a;
	highp mat2x3 b;
	highp mat4x3 c[2];
	mediump mat2 d[][8];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.b, mat2x3(-4.0, -5.0, 4.0, -1.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockB.c[0], mat4x3(-3.0, 0.0, 7.0, -5.0, 5.0, 6.0, 7.0, 4.0, -5.0, -8.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB.c[1], mat4x3(9.0, -2.0, 9.0, -7.0, 9.0, -4.0, -7.0, 5.0, -5.0, 9.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat2(blockB.d[0][0], mat2(-5.0, -5.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat2(blockB.d[0][1], mat2(2.0, -8.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2(blockB.d[0][2], mat2(9.0, 6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(blockB.d[0][3], mat2(-8.0, 8.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2(blockB.d[0][4], mat2(1.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2(blockB.d[0][5], mat2(-8.0, -5.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(blockB.d[0][6], mat2(3.0, 1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(blockB.d[0][7], mat2(8.0, -1.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2(blockB.d[1][0], mat2(-6.0, -6.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat2(blockB.d[1][1], mat2(7.0, 2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(blockB.d[1][2], mat2(7.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2(blockB.d[1][3], mat2(-2.0, -5.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat2(blockB.d[1][4], mat2(8.0, -1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(blockB.d[1][5], mat2(-6.0, -8.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2(blockB.d[1][6], mat2(9.0, 5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(blockB.d[1][7], mat2(-9.0, 6.0, 3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = (mat4x3(-9.0, -3.0, 9.0, -4.0, 5.0, -3.0, 8.0, 1.0, 7.0, -3.0, 7.0, 7.0));
	blockB.c[1] = (mat4x3(-9.0, -4.0, -6.0, 8.0, 1.0, 2.0, 5.0, 6.0, 3.0, 9.0, -5.0, -1.0));
	blockB.d[0][0] = (mat2(-3.0, 7.0, -1.0, -8.0));
	blockB.d[0][1] = (mat2(4.0, -6.0, -1.0, 2.0));
	blockB.d[0][2] = (mat2(7.0, -5.0, 4.0, 3.0));
	blockB.d[0][3] = (mat2(9.0, -4.0, 1.0, -2.0));
	blockB.d[0][4] = (mat2(2.0, 2.0, -6.0, -7.0));
	blockB.d[0][5] = (mat2(9.0, -8.0, -2.0, -8.0));
	blockB.d[0][6] = (mat2(-7.0, 6.0, 6.0, -1.0));
	blockB.d[0][7] = (mat2(-4.0, 9.0, -9.0, -6.0));
	blockB.d[1][0] = (mat2(-3.0, 1.0, 7.0, -7.0));
	blockB.d[1][1] = (mat2(3.0, -9.0, -6.0, 7.0));
	blockB.d[1][2] = (mat2(-4.0, -3.0, -1.0, -5.0));
	blockB.d[1][3] = (mat2(-8.0, 7.0, -7.0, -1.0));
	blockB.d[1][4] = (mat2(8.0, 1.0, -8.0, -3.0));
	blockB.d[1][5] = (mat2(5.0, -4.0, -1.0, 7.0));
	blockB.d[1][6] = (mat2(0.0, 9.0, 6.0, -7.0));
	blockB.d[1][7] = (mat2(-3.0, -9.0, -6.0, -6.0));
}
#version 450
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
	lowp uvec3 mB;
	highp mat3x4 mC;
	lowp uint mD;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	sA a;
	lowp ivec3 b;
	highp float c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB[0].a.mA), uvec4(4u, 0u, 2u, 9u)) && allOk;
	allOk = compare_uvec3((blockB[0].a.mB), uvec3(8u, 7u, 2u)) && allOk;
	allOk = compare_mat3x4(blockB[0].a.mC, mat3x4(0.0, 3.0, -6.0, -9.0, -5.0, -9.0, -3.0, -7.0, 9.0, 6.0, 7.0, 7.0)) && allOk;
	allOk = compare_uint((blockB[0].a.mD), 8u) && allOk;
	allOk = compare_ivec3((blockB[0].b), ivec3(3, -6, 2)) && allOk;
	allOk = compare_float((blockB[0].c), -7.0) && allOk;
	allOk = compare_uvec4((blockB[1].a.mA), uvec4(5u, 2u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[1].a.mB), uvec3(8u, 4u, 3u)) && allOk;
	allOk = compare_mat3x4(blockB[1].a.mC, mat3x4(8.0, 3.0, -8.0, 4.0, 4.0, -2.0, -2.0, -2.0, 1.0, -9.0, 9.0, 0.0)) && allOk;
	allOk = compare_uint((blockB[1].a.mD), 5u) && allOk;
	allOk = compare_ivec3((blockB[1].b), ivec3(-3, -8, -4)) && allOk;
	allOk = compare_float((blockB[1].c), -3.0) && allOk;
	allOk = compare_uvec4((blockB[2].a.mA), uvec4(3u, 5u, 3u, 9u)) && allOk;
	allOk = compare_uvec3((blockB[2].a.mB), uvec3(6u, 9u, 7u)) && allOk;
	allOk = compare_mat3x4(blockB[2].a.mC, mat3x4(7.0, 4.0, -2.0, -9.0, 2.0, 0.0, 4.0, 0.0, 8.0, 4.0, -3.0, -7.0)) && allOk;
	allOk = compare_uint((blockB[2].a.mD), 8u) && allOk;
	allOk = compare_ivec3((blockB[2].b), ivec3(1, 4, 4)) && allOk;
	allOk = compare_float((blockB[2].c), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (uvec4(4u, 4u, 5u, 2u));
	blockB[0].a.mB = (uvec3(7u, 4u, 8u));
	blockB[0].a.mC = (mat3x4(-4.0, 6.0, 4.0, -8.0, 0.0, -7.0, 3.0, -7.0, -8.0, 7.0, -8.0, 7.0));
	blockB[0].a.mD = (5u);
	blockB[0].b = (ivec3(-8, 7, 4));
	blockB[1].a.mA = (uvec4(7u, 6u, 7u, 0u));
	blockB[1].a.mB = (uvec3(5u, 2u, 5u));
	blockB[1].a.mC = (mat3x4(-7.0, -1.0, -8.0, 4.0, -7.0, 6.0, 6.0, -2.0, 4.0, 3.0, -7.0, 1.0));
	blockB[1].a.mD = (5u);
	blockB[1].b = (ivec3(-2, 0, -6));
	blockB[2].a.mA = (uvec4(4u, 1u, 3u, 0u));
	blockB[2].a.mB = (uvec3(9u, 8u, 8u));
	blockB[2].a.mC = (mat3x4(5.0, 9.0, 4.0, 5.0, 8.0, 3.0, 1.0, -4.0, 9.0, 4.0, -9.0, -4.0));
	blockB[2].a.mD = (8u);
	blockB[2].b = (ivec3(8, 2, 9));
}
#version 450
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
	bvec4 mB;
	lowp vec3 mC;
};
struct sB
{
	mediump vec2 mA;
	highp uvec2 mB;
};
struct sC
{
	uint8_t mA;
	sB mB;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	mediump mat4 a;
	highp mat3 b;
	lowp int c;
	sA d;
	highp mat4 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	sC f;
	lowp mat4x3 g;
	mediump mat2x3 h;
	lowp mat4x2 i;
	mediump vec2 j;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	highp vec2 k;
	highp mat3x4 l;
	mediump mat3x2 m;
	mediump vec3 n;
	highp mat3x2 o[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(6.0, -4.0, 2.0, -1.0, 8.0, 4.0, -8.0, -5.0, 4.0, 0.0, 2.0, -5.0, -9.0, 7.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockB.d.mA, mat3x2(-5.0, -6.0, -1.0, 5.0, 6.0, -3.0)) && allOk;
	allOk = compare_bvec4((blockB.d.mB), bvec4(true, true, false, false)) && allOk;
	allOk = compare_vec3((blockB.d.mC), vec3(1.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].h, mat2x3(-3.0, -2.0, 5.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].i, mat4x2(-1.0, -1.0, 1.0, 8.0, -5.0, 7.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].h, mat2x3(8.0, 1.0, 1.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].i, mat4x2(-5.0, -7.0, 6.0, -2.0, 9.0, -1.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockC[2].h, mat2x3(6.0, 5.0, -2.0, -9.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockC[2].i, mat4x2(-5.0, 9.0, 0.0, 1.0, 5.0, -8.0, 5.0, 2.0)) && allOk;
	allOk = compare_vec2((blockD.k), vec2(0.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockD.l, mat3x4(-1.0, 5.0, 6.0, -5.0, -1.0, -7.0, 7.0, 0.0, -3.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockD.m, mat3x2(6.0, -2.0, 4.0, 7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockD.o[0], mat3x2(-2.0, 4.0, -2.0, -1.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockD.o[1], mat3x2(0.0, -5.0, -4.0, -7.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockD.o[2], mat3x2(2.0, -9.0, 4.0, 0.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockD.o[3], mat3x2(-4.0, -1.0, -2.0, 6.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockD.o[4], mat3x2(-4.0, -1.0, 8.0, -6.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockD.o[5], mat3x2(-2.0, 5.0, -4.0, 3.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockD.o[6], mat3x2(6.0, 4.0, -5.0, 5.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockD.o[7], mat3x2(2.0, 4.0, -3.0, 0.0, 1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(7.0, -1.0, -9.0, -6.0, 7.0, 9.0, -8.0, 0.0, 1.0, 3.0, 3.0, -8.0, -6.0, -5.0, -3.0, -3.0));
	blockB.b = (mat3(-7.0, 1.0, -7.0, 1.0, -4.0, -7.0, 0.0, 2.0, -3.0));
	blockB.c = (-5);
	blockC[0].h = (mat2x3(-4.0, 5.0, -3.0, -3.0, -5.0, -4.0));
	blockC[0].j = (vec2(-6.0, -5.0));
	blockC[1].h = (mat2x3(-7.0, -5.0, -9.0, 4.0, -3.0, -1.0));
	blockC[1].j = (vec2(1.0, 6.0));
	blockC[2].h = (mat2x3(-8.0, 7.0, 4.0, 0.0, 6.0, 5.0));
	blockC[2].j = (vec2(1.0, 2.0));
	blockD.m = (mat3x2(6.0, 8.0, 6.0, 0.0, 6.0, 8.0));
	blockD.n = (vec3(-3.0, -3.0, 2.0));
	blockD.o[0] = (mat3x2(-9.0, -7.0, 0.0, -1.0, 5.0, -5.0));
	blockD.o[1] = (mat3x2(-2.0, 8.0, 7.0, 1.0, -7.0, 0.0));
	blockD.o[2] = (mat3x2(3.0, 2.0, 3.0, -5.0, -6.0, -3.0));
	blockD.o[3] = (mat3x2(-7.0, -9.0, 9.0, 5.0, -7.0, -2.0));
	blockD.o[4] = (mat3x2(9.0, -9.0, 7.0, -9.0, -1.0, 3.0));
	blockD.o[5] = (mat3x2(-3.0, -7.0, 5.0, 5.0, 6.0, 3.0));
	blockD.o[6] = (mat3x2(2.0, -1.0, 9.0, 9.0, -4.0, 9.0));
	blockD.o[7] = (mat3x2(-4.0, 7.0, -3.0, -2.0, -8.0, 7.0));
}
#version 450
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
	layout(offset = 0) mediump uvec3 a;
	layout(offset = 12) highp uint b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec4 c[1];
	layout(offset = 16) mediump ivec3 d;
	layout(offset = 28) u8vec3 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump vec2 f[1];
	layout(offset = 8) i8vec3 g;
	layout(offset = 16) highp vec3 h[1];
	layout(offset = 32) mediump uvec4 i;
	layout(offset = 48) lowp uvec4 j;
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
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_uint((blockB.b), 9u) && allOk;
	allOk = compare_bvec4((blockC.c[0]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_ivec3((blockC.d), ivec3(9, 7, 0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.e), uvec3(9u, 7u, 9u)) && allOk;
	allOk = compare_vec2((blockD.f[0]), vec2(-8.0, -8.0)) && allOk;
	allOk = compare_vec3((blockD.h[0]), vec3(-8.0, 3.0, 7.0)) && allOk;
	allOk = compare_uvec4((blockD.i), uvec4(9u, 3u, 0u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (6u);
	blockC.c[0] = (bvec4(true, false, false, true));
	blockC.d = (ivec3(6, 3, -6));
	blockC.e = u8vec3(uvec3(5u, 1u, 0u));
	blockD.f[0] = (vec2(9.0, 1.0));
	blockD.g = i8vec3(ivec3(0, 4294967295, 4));
	blockD.h[0] = (vec3(-4.0, -2.0, -2.0));
	blockD.j = (uvec4(3u, 1u, 3u, 8u));
}
#version 450
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
	layout(offset = 0) mediump uvec3 a[1];
	layout(offset = 16) uint8_t b;
	layout(offset = 20) mediump uvec3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB[0].b), 8u) && allOk;
	allOk = compare_uvec3((blockB[0].c), uvec3(1u, 2u, 5u)) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].b), 8u) && allOk;
	allOk = compare_uvec3((blockB[1].c), uvec3(0u, 9u, 7u)) && allOk;
	allOk = compare_uint8_t(uint(blockB[2].b), 8u) && allOk;
	allOk = compare_uvec3((blockB[2].c), uvec3(8u, 5u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (uvec3(8u, 2u, 6u));
	blockB[0].b = uint8_t(9u);
	blockB[0].c = (uvec3(2u, 1u, 0u));
	blockB[1].a[0] = (uvec3(4u, 0u, 7u));
	blockB[1].b = uint8_t(4u);
	blockB[1].c = (uvec3(2u, 9u, 9u));
	blockB[2].a[0] = (uvec3(5u, 0u, 1u));
	blockB[2].b = uint8_t(9u);
	blockB[2].c = (uvec3(9u, 8u, 1u));
}
#version 450
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
	layout(offset = 0) lowp uvec2 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(3u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x4 a;
	highp vec4 b;
	uint8_t c;
	lowp mat2x3 d;
	u8vec4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a, mat3x4(-6.0, -1.0, -4.0, -3.0, -1.0, 8.0, 8.0, 0.0, -3.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_vec4((blockB.b), vec4(-8.0, 9.0, -4.0, 9.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB.c), 6u) && allOk;
	allOk = compare_mat2x3(blockB.d, mat2x3(-5.0, -8.0, 3.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.e), uvec4(2u, 3u, 0u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(-6.0, -9.0, 9.0, 5.0, 6.0, -9.0, 4.0, 0.0, -5.0, 0.0, -7.0, -6.0));
	blockB.b = (vec4(-7.0, 3.0, 9.0, -4.0));
	blockB.c = uint8_t(7u);
	blockB.d = (mat2x3(-6.0, 4.0, 6.0, 9.0, 8.0, -8.0));
	blockB.e = u8vec4(uvec4(9u, 3u, 4u, 2u));
}
#version 450
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
	mediump mat3x4 a;
	bool b;
	highp ivec2 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].c), ivec2(6, -6)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].c), ivec2(1, -3)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(2)].c), ivec2(-4, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat3x4(-1.0, -9.0, 7.0, 2.0, -2.0, -6.0, -6.0, 1.0, 8.0, 0.0, 5.0, -1.0));
	blockB[nonuniformEXT(1)].a = (mat3x4(-5.0, 9.0, -1.0, 2.0, 1.0, 1.0, -7.0, -2.0, -3.0, 8.0, 2.0, 9.0));
	blockB[nonuniformEXT(2)].a = (mat3x4(8.0, -4.0, 4.0, 9.0, 9.0, -8.0, -7.0, 3.0, 6.0, 7.0, 4.0, -7.0));
}
