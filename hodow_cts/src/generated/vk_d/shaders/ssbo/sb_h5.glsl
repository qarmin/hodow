#version 450
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

layout(std140, binding = 1) buffer Block
{
	bvec3 var;
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((var), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (bvec3(true, true, false));
}
#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(-5.0, -5.0, -8.0, 9.0, -8.0, 6.0, 7.0, -8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(-8.0, 4.0, -3.0, -9.0, 4.0, -1.0, -9.0, -4.0, -3.0));
}
#version 450
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

	var[0] = (vec4(2.0, -1.0, -7.0, 2.0));
	var[1] = (vec4(-1.0, -5.0, 0.0, -1.0));
	var[2] = (vec4(7.0, 7.0, 2.0, 1.0));
	var[3] = (vec4(8.0, 2.0, -3.0, 0.0));
}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(8.0, 9.0, 7.0, 1.0, -5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(7.0, 7.0));
	var[1] = (vec2(5.0, 7.0));
	var[2] = (vec2(4.0, 8.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
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

	var = (mat4(1.0, -3.0, -8.0, 1.0, 3.0, -4.0, -4.0, -4.0, -6.0, -6.0, 9.0, 1.0, 1.0, 3.0, 2.0, -6.0));
}
#version 450
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[0][3], -1.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], 4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-5.0, 8.0, -9.0, -1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(3.0, -8.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-5.0, 4.0, -1.0, -1.0));
	var[1] = (vec4(-4.0, -7.0, -4.0, -8.0));
}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat2(var, mat2(-6.0, -2.0, 7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0] = (vec2(7.0, 9.0));
	var[1] = (vec2(8.0, -3.0));
}
#version 450
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
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(-4.0, -9.0, 3.0, 1.0, 3.0, -7.0, 3.0, 6.0, 1.0, 2.0, 6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0] = (vec4(-6.0, -2.0, -1.0, 8.0));
	var[1] = (vec4(9.0, 3.0, -1.0, 5.0));
	var[2] = (vec4(-9.0, -9.0, 6.0, -3.0));
}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(8.0, 4.0, 9.0, -4.0, -1.0, 1.0, 1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var = (mat4x2(1.0, -9.0, -6.0, 7.0, -3.0, 8.0, 7.0, -6.0));
}
#version 450
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
	highp ivec3 var[3];
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var[0]), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((var[1]), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((var[2]), ivec3(3, -1, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (ivec3(-5, 0, -9));
	var[1] = (ivec3(2, 4, 1));
	var[2] = (ivec3(6, 6, 2));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
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

	var[0][0] = (vec2(-3.0, 3.0));
	var[0][1] = (vec2(4.0, 4.0));
	var[1][0] = (vec2(9.0, -9.0));
	var[1][1] = (vec2(-5.0, 8.0));
	var[2][0] = (vec2(0.0, 4.0));
	var[2][1] = (vec2(2.0, -4.0));
}
#version 450
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
	uint16_t var[3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(var[0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(var[2]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = uint16_t(9u);
	var[1] = uint16_t(1u);
	var[2] = uint16_t(1u);
}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat3(var[0], mat3(-8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var[0] = (mat3(9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0, 8.0));
	var[1] = (mat3(-8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0, -2.0));
	var[2] = (mat3(5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0, 2.0));
}
#version 450
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

	var[0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	var[1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	var[2] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	var[3] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	var[4] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	var[5] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	var[6] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	var[7] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	var[8] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	var[9] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	var[10] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	var[11] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
	var[12] = (mat3x2(7.0, -4.0, 6.0, -9.0, -2.0, -7.0));
	var[13] = (mat3x2(-2.0, -2.0, -1.0, 7.0, 3.0, -9.0));
	var[14] = (mat3x2(6.0, -8.0, 1.0, -2.0, -2.0, 3.0));
	var[15] = (mat3x2(-9.0, 8.0, 3.0, 2.0, 3.0, 7.0));
	var[16] = (mat3x2(-9.0, 3.0, -6.0, -9.0, -4.0, -8.0));
	var[17] = (mat3x2(5.0, 8.0, 8.0, -6.0, -8.0, -4.0));
	var[18] = (mat3x2(-3.0, 2.0, -3.0, -9.0, 1.0, -7.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	u16vec3 var[];
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(var[0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[4]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[5]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[6]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[7]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[8]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[9]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[10]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[11]), uvec3(3u, 6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[12]), uvec3(9u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[13]), uvec3(9u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[14]), uvec3(8u, 5u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[15]), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[16]), uvec3(8u, 0u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[17]), uvec3(2u, 3u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[18]), uvec3(6u, 1u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = u16vec3(uvec3(1u, 2u, 6u));
	var[1] = u16vec3(uvec3(8u, 3u, 3u));
	var[2] = u16vec3(uvec3(4u, 4u, 9u));
	var[3] = u16vec3(uvec3(7u, 5u, 4u));
	var[4] = u16vec3(uvec3(5u, 6u, 5u));
	var[5] = u16vec3(uvec3(7u, 0u, 6u));
	var[6] = u16vec3(uvec3(4u, 7u, 0u));
	var[7] = u16vec3(uvec3(4u, 2u, 1u));
	var[8] = u16vec3(uvec3(0u, 2u, 8u));
	var[9] = u16vec3(uvec3(0u, 7u, 0u));
	var[10] = u16vec3(uvec3(2u, 8u, 7u));
	var[11] = u16vec3(uvec3(1u, 2u, 8u));
	var[12] = u16vec3(uvec3(1u, 3u, 3u));
	var[13] = u16vec3(uvec3(0u, 2u, 2u));
	var[14] = u16vec3(uvec3(7u, 9u, 1u));
	var[15] = u16vec3(uvec3(2u, 8u, 7u));
	var[16] = u16vec3(uvec3(9u, 6u, 3u));
	var[17] = u16vec3(uvec3(2u, 0u, 6u));
	var[18] = u16vec3(uvec3(6u, 1u, 7u));
}
#version 450
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

	var[0] = float16_t(-8.0);
	var[1] = float16_t(9.0);
	var[2] = float16_t(-2.0);
	var[3] = float16_t(7.0);
	var[4] = float16_t(8.0);
	var[5] = float16_t(-9.0);
	var[6] = float16_t(2.0);
	var[7] = float16_t(-8.0);
	var[8] = float16_t(-1.0);
	var[9] = float16_t(6.0);
	var[10] = float16_t(-7.0);
	var[11] = float16_t(-5.0);
	var[12] = float16_t(8.0);
	var[13] = float16_t(-3.0);
	var[14] = float16_t(6.0);
	var[15] = float16_t(-3.0);
	var[16] = float16_t(-8.0);
	var[17] = float16_t(1.0);
	var[18] = float16_t(3.0);
}
#version 450
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
	allOk = compare_mat4x2(var[0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[3], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(-1.0, 3.0, -9.0, 4.0, -2.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-3.0, 7.0, -5.0, 3.0, 2.0, -1.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(6.0, 9.0, -5.0, 0.0, 7.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(-7.0, -3.0, -5.0, 2.0, 3.0, -3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(5.0, -7.0, -9.0, 8.0, 8.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(-6.0, 8.0, -1.0, 0.0, 6.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(-4.0, 1.0, -2.0, 4.0, 1.0, -8.0, 8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(6.0, 9.0));
	var[0][1] = (vec2(-4.0, -4.0));
	var[0][2] = (vec2(2.0, 0.0));
	var[0][3] = (vec2(-7.0, 3.0));
	var[1][0] = (vec2(9.0, -6.0));
	var[1][1] = (vec2(8.0, -9.0));
	var[1][2] = (vec2(-9.0, -6.0));
	var[1][3] = (vec2(-4.0, -6.0));
	var[2][0] = (vec2(-8.0, 5.0));
	var[2][1] = (vec2(6.0, -8.0));
	var[2][2] = (vec2(-8.0, 3.0));
	var[2][3] = (vec2(2.0, 8.0));
	var[3][0] = (vec2(-8.0, -1.0));
	var[3][1] = (vec2(-3.0, 0.0));
	var[3][2] = (vec2(7.0, 5.0));
	var[3][3] = (vec2(-8.0, 5.0));
	var[4][0] = (vec2(7.0, 8.0));
	var[4][1] = (vec2(4.0, -2.0));
	var[4][2] = (vec2(4.0, -2.0));
	var[4][3] = (vec2(-2.0, 9.0));
	var[5][0] = (vec2(4.0, -4.0));
	var[5][1] = (vec2(-5.0, -5.0));
	var[5][2] = (vec2(-6.0, 8.0));
	var[5][3] = (vec2(9.0, -5.0));
	var[6][0] = (vec2(-2.0, 1.0));
	var[6][1] = (vec2(6.0, -2.0));
	var[6][2] = (vec2(2.0, -5.0));
	var[6][3] = (vec2(3.0, -3.0));
	var[7][0] = (vec2(-6.0, -4.0));
	var[7][1] = (vec2(-6.0, -7.0));
	var[7][2] = (vec2(9.0, 1.0));
	var[7][3] = (vec2(-4.0, 3.0));
	var[8][0] = (vec2(7.0, -9.0));
	var[8][1] = (vec2(7.0, -4.0));
	var[8][2] = (vec2(8.0, -2.0));
	var[8][3] = (vec2(9.0, 0.0));
	var[9][0] = (vec2(-9.0, 7.0));
	var[9][1] = (vec2(1.0, 4.0));
	var[9][2] = (vec2(-7.0, 9.0));
	var[9][3] = (vec2(-5.0, 2.0));
	var[10][0] = (vec2(-9.0, -3.0));
	var[10][1] = (vec2(-8.0, 5.0));
	var[10][2] = (vec2(-2.0, -8.0));
	var[10][3] = (vec2(7.0, -6.0));
	var[11][0] = (vec2(-7.0, 1.0));
	var[11][1] = (vec2(-3.0, 7.0));
	var[11][2] = (vec2(6.0, -5.0));
	var[11][3] = (vec2(9.0, -2.0));
	var[12][0] = (vec2(-9.0, -3.0));
	var[12][1] = (vec2(5.0, -5.0));
	var[12][2] = (vec2(3.0, 4.0));
	var[12][3] = (vec2(-9.0, 1.0));
	var[13][0] = (vec2(0.0, 8.0));
	var[13][1] = (vec2(-8.0, 3.0));
	var[13][2] = (vec2(-7.0, 9.0));
	var[13][3] = (vec2(-8.0, -7.0));
	var[14][0] = (vec2(7.0, 1.0));
	var[14][1] = (vec2(-1.0, -2.0));
	var[14][2] = (vec2(-8.0, -3.0));
	var[14][3] = (vec2(9.0, -1.0));
	var[15][0] = (vec2(-2.0, 1.0));
	var[15][1] = (vec2(-8.0, -7.0));
	var[15][2] = (vec2(-5.0, 7.0));
	var[15][3] = (vec2(-5.0, -7.0));
	var[16][0] = (vec2(-5.0, 2.0));
	var[16][1] = (vec2(-4.0, 8.0));
	var[16][2] = (vec2(-7.0, 6.0));
	var[16][3] = (vec2(5.0, 2.0));
	var[17][0] = (vec2(-5.0, 3.0));
	var[17][1] = (vec2(-9.0, 7.0));
	var[17][2] = (vec2(-3.0, -3.0));
	var[17][3] = (vec2(-7.0, -4.0));
	var[18][0] = (vec2(3.0, 7.0));
	var[18][1] = (vec2(-6.0, -7.0));
	var[18][2] = (vec2(-7.0, 5.0));
	var[18][3] = (vec2(-8.0, 4.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	highp ivec3 var[4][3];
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var[0][0]), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((var[0][1]), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((var[0][2]), ivec3(3, -1, -7)) && allOk;
	allOk = compare_ivec3((var[1][0]), ivec3(-1, 2, 9)) && allOk;
	allOk = compare_ivec3((var[1][1]), ivec3(-8, 4, 9)) && allOk;
	allOk = compare_ivec3((var[1][2]), ivec3(-3, -3, -9)) && allOk;
	allOk = compare_ivec3((var[2][0]), ivec3(9, 3, -6)) && allOk;
	allOk = compare_ivec3((var[2][1]), ivec3(-6, 7, 3)) && allOk;
	allOk = compare_ivec3((var[2][2]), ivec3(6, 9, 0)) && allOk;
	allOk = compare_ivec3((var[3][0]), ivec3(5, 8, 2)) && allOk;
	allOk = compare_ivec3((var[3][1]), ivec3(7, -7, 2)) && allOk;
	allOk = compare_ivec3((var[3][2]), ivec3(1, -4, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (ivec3(-5, 0, -9));
	var[0][1] = (ivec3(2, 4, 1));
	var[0][2] = (ivec3(6, 6, 2));
	var[1][0] = (ivec3(4, 4, 2));
	var[1][1] = (ivec3(-4, -1, -7));
	var[1][2] = (ivec3(8, -4, 1));
	var[2][0] = (ivec3(-4, -1, 5));
	var[2][1] = (ivec3(-4, 2, -2));
	var[2][2] = (ivec3(6, 7, -1));
	var[3][0] = (ivec3(-1, -3, -1));
	var[3][1] = (ivec3(-4, -1, -3));
	var[3][2] = (ivec3(6, -3, 8));
}
#version 450
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
	u16vec3 var[4][3];
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(var[0][0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][2]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][0]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][1]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][2]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][0]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][1]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][2]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][0]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][1]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][2]), uvec3(3u, 6u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = u16vec3(uvec3(1u, 2u, 6u));
	var[0][1] = u16vec3(uvec3(8u, 3u, 3u));
	var[0][2] = u16vec3(uvec3(4u, 4u, 9u));
	var[1][0] = u16vec3(uvec3(7u, 5u, 4u));
	var[1][1] = u16vec3(uvec3(5u, 6u, 5u));
	var[1][2] = u16vec3(uvec3(7u, 0u, 6u));
	var[2][0] = u16vec3(uvec3(4u, 7u, 0u));
	var[2][1] = u16vec3(uvec3(4u, 2u, 1u));
	var[2][2] = u16vec3(uvec3(0u, 2u, 8u));
	var[3][0] = u16vec3(uvec3(0u, 7u, 0u));
	var[3][1] = u16vec3(uvec3(2u, 8u, 7u));
	var[3][2] = u16vec3(uvec3(1u, 2u, 8u));
}
#version 450
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat2x3(var[0][0], mat2x3(7.0, -5.0, -9.0, 5.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(8.0, 9.0, 2.0, 6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-5.0, -8.0, 2.0, -2.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(8.0, -5.0, 6.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(2.0, 2.0, -8.0, 3.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(-7.0, 0.0, 7.0, 6.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(-8.0, 7.0, -3.0, 5.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(-4.0, 6.0, 2.0, 0.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(-2.0, 0.0, 8.0, -6.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(5.0, -9.0, -6.0, -1.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(4.0, -7.0, 6.0, 3.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(0.0, 3.0, -9.0, -9.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0][0][0] = (vec3(-3.0, 9.0, -8.0));
	var[0][0][1] = (vec3(-1.0, 1.0, -5.0));
	var[0][1][0] = (vec3(3.0, -3.0, 7.0));
	var[0][1][1] = (vec3(6.0, 6.0, -9.0));
	var[0][2][0] = (vec3(7.0, 0.0, -8.0));
	var[0][2][1] = (vec3(-2.0, -7.0, 0.0));
	var[1][0][0] = (vec3(-2.0, 4.0, -8.0));
	var[1][0][1] = (vec3(-5.0, 5.0, -3.0));
	var[1][1][0] = (vec3(-3.0, -1.0, -9.0));
	var[1][1][1] = (vec3(-4.0, 7.0, 2.0));
	var[1][2][0] = (vec3(-4.0, 8.0, 2.0));
	var[1][2][1] = (vec3(-3.0, 6.0, 6.0));
	var[2][0][0] = (vec3(3.0, 4.0, -6.0));
	var[2][0][1] = (vec3(-2.0, 0.0, 3.0));
	var[2][1][0] = (vec3(4.0, -8.0, 0.0));
	var[2][1][1] = (vec3(-6.0, 2.0, -3.0));
	var[2][2][0] = (vec3(-6.0, -8.0, 8.0));
	var[2][2][1] = (vec3(3.0, 5.0, 4.0));
	var[3][0][0] = (vec3(-6.0, 7.0, -3.0));
	var[3][0][1] = (vec3(-9.0, -1.0, 2.0));
	var[3][1][0] = (vec3(-3.0, -5.0, 9.0));
	var[3][1][1] = (vec3(-2.0, 4.0, -8.0));
	var[3][2][0] = (vec3(2.0, 0.0, 5.0));
	var[3][2][1] = (vec3(-1.0, 7.0, 0.0));
}
#version 450
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2x3(var[0][0], mat2x3(0.0, -9.0, 8.0, -4.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(-1.0, -3.0, -1.0, 7.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(9.0, 0.0, 0.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(8.0, -3.0, 7.0, 3.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(-2.0, -7.0, -8.0, 8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(-3.0, 2.0, 8.0, -4.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(-9.0, 0.0, -9.0, -8.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(3.0, 9.0, 1.0, 6.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(-3.0, 6.0, 8.0, -6.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(5.0, 6.0, 7.0, -1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(9.0, 5.0, 1.0, 3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(6.0, -5.0, 7.0, -3.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0][0][0] = (vec3(5.0, 5.0, 0.0));
	var[0][0][1] = (vec3(-7.0, 8.0, -7.0));
	var[0][1][0] = (vec3(-4.0, 6.0, 1.0));
	var[0][1][1] = (vec3(3.0, 2.0, -6.0));
	var[0][2][0] = (vec3(5.0, 2.0, 1.0));
	var[0][2][1] = (vec3(8.0, -8.0, 2.0));
	var[1][0][0] = (vec3(-7.0, 5.0, -4.0));
	var[1][0][1] = (vec3(-6.0, -9.0, 3.0));
	var[1][1][0] = (vec3(0.0, -7.0, 2.0));
	var[1][1][1] = (vec3(-4.0, 1.0, -2.0));
	var[1][2][0] = (vec3(-2.0, -5.0, 2.0));
	var[1][2][1] = (vec3(5.0, 4.0, 4.0));
	var[2][0][0] = (vec3(-1.0, 7.0, 9.0));
	var[2][0][1] = (vec3(-2.0, -4.0, 8.0));
	var[2][1][0] = (vec3(-4.0, 2.0, 5.0));
	var[2][1][1] = (vec3(-1.0, -3.0, 3.0));
	var[2][2][0] = (vec3(-2.0, -8.0, 6.0));
	var[2][2][1] = (vec3(0.0, 9.0, 1.0));
	var[3][0][0] = (vec3(-5.0, -1.0, -6.0));
	var[3][0][1] = (vec3(-6.0, 3.0, 1.0));
	var[3][1][0] = (vec3(-8.0, -5.0, 8.0));
	var[3][1][1] = (vec3(5.0, 8.0, 5.0));
	var[3][2][0] = (vec3(5.0, 7.0, -9.0));
	var[3][2][1] = (vec3(8.0, 0.0, 8.0));
}
#version 450
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
	u8vec4 var[4][3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 3u) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][0]), uvec4(4u, 6u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][1]), uvec4(5u, 7u, 0u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[0][2]), uvec4(4u, 6u, 1u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][0]), uvec4(7u, 6u, 2u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][1]), uvec4(3u, 3u, 2u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1][2]), uvec4(2u, 2u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][0]), uvec4(9u, 5u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][1]), uvec4(2u, 0u, 2u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2][2]), uvec4(3u, 7u, 9u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][0]), uvec4(7u, 4u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][1]), uvec4(8u, 5u, 7u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3][2]), uvec4(6u, 3u, 4u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint8_t(9u);
	var[0][0] = u8vec4(uvec4(5u, 9u, 4u, 6u));
	var[0][1] = u8vec4(uvec4(8u, 7u, 3u, 6u));
	var[0][2] = u8vec4(uvec4(7u, 1u, 9u, 8u));
	var[1][0] = u8vec4(uvec4(9u, 3u, 3u, 3u));
	var[1][1] = u8vec4(uvec4(9u, 0u, 6u, 8u));
	var[1][2] = u8vec4(uvec4(7u, 6u, 7u, 7u));
	var[2][0] = u8vec4(uvec4(7u, 4u, 8u, 8u));
	var[2][1] = u8vec4(uvec4(5u, 3u, 1u, 1u));
	var[2][2] = u8vec4(uvec4(4u, 7u, 1u, 3u));
	var[3][0] = u8vec4(uvec4(6u, 3u, 3u, 4u));
	var[3][1] = u8vec4(uvec4(7u, 8u, 8u, 1u));
	var[3][2] = u8vec4(uvec4(7u, 7u, 2u, 5u));
}
#version 450
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
	bvec2 var[4][2][3];
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((var[0][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[0][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[0][0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[0][1][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[0][1][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[0][1][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[1][0][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[1][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[1][0][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[1][1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[1][1][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[1][1][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[2][0][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[2][0][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[2][0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[2][1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[2][1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[2][1][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[3][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][0][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[3][1][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[3][1][2]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (bvec2(true, false));
	var[0][0][1] = (bvec2(true, true));
	var[0][0][2] = (bvec2(false, false));
	var[0][1][0] = (bvec2(false, true));
	var[0][1][1] = (bvec2(true, true));
	var[0][1][2] = (bvec2(false, false));
	var[1][0][0] = (bvec2(false, false));
	var[1][0][1] = (bvec2(false, true));
	var[1][0][2] = (bvec2(true, true));
	var[1][1][0] = (bvec2(true, true));
	var[1][1][1] = (bvec2(true, false));
	var[1][1][2] = (bvec2(false, false));
	var[2][0][0] = (bvec2(false, false));
	var[2][0][1] = (bvec2(false, true));
	var[2][0][2] = (bvec2(true, true));
	var[2][1][0] = (bvec2(true, false));
	var[2][1][1] = (bvec2(true, false));
	var[2][1][2] = (bvec2(true, false));
	var[3][0][0] = (bvec2(false, false));
	var[3][0][1] = (bvec2(true, false));
	var[3][0][2] = (bvec2(true, false));
	var[3][1][0] = (bvec2(false, false));
	var[3][1][1] = (bvec2(false, false));
	var[3][1][2] = (bvec2(false, true));
}
#version 450
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
	allOk = compare_mat3(var[0][0][0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(5.0, 9.0, -5.0, -4.0, 8.0, 3.0, -4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(5.0, 6.0, -6.0, -5.0, 4.0, 8.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(-6.0, 8.0, 9.0, 6.0, -6.0, -2.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-4.0, -8.0, -2.0, -5.0, -4.0, 2.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(-3.0, 9.0, 1.0, -4.0, -5.0, -5.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(6.0, -5.0, -2.0, 1.0, -4.0, 8.0, 3.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(2.0, -7.0, 1.0, -7.0, -9.0, 5.0, 3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(4.0, -6.0, -5.0, -8.0, 3.0, -6.0, 3.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(-6.0, 0.0, 3.0, 6.0, -8.0, 1.0, -6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(3.0, -6.0, -3.0, -4.0, 8.0, 1.0, -8.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(-3.0, 1.0, -5.0, 4.0, -6.0, 6.0, 1.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(5.0, 0.0, 0.0, -4.0, 5.0, -5.0, 4.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	var[0][0][1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	var[0][0][2] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
	var[0][1][0] = (mat3(-1.0, -3.0, 0.0, -4.0, -7.0, -5.0, 9.0, -1.0, -7.0));
	var[0][1][1] = (mat3(5.0, -8.0, 9.0, -7.0, 9.0, -8.0, -5.0, 9.0, 2.0));
	var[0][1][2] = (mat3(1.0, 9.0, -9.0, -1.0, 3.0, -5.0, -4.0, -9.0, -8.0));
	var[1][0][0] = (mat3(2.0, 1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0));
	var[1][0][1] = (mat3(-6.0, -8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0));
	var[1][0][2] = (mat3(2.0, -3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0));
	var[1][1][0] = (mat3(-9.0, 2.0, -4.0, -6.0, -2.0, 6.0, 4.0, 3.0, 0.0));
	var[1][1][1] = (mat3(-1.0, -8.0, -2.0, -5.0, 5.0, -8.0, -3.0, 4.0, -4.0));
	var[1][1][2] = (mat3(-5.0, 2.0, 5.0, 6.0, 7.0, 9.0, 1.0, -2.0, -9.0));
	var[2][0][0] = (mat3(3.0, 5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0));
	var[2][0][1] = (mat3(0.0, -4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0));
	var[2][0][2] = (mat3(9.0, 7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0));
	var[2][1][0] = (mat3(-6.0, -1.0, 0.0, -3.0, 8.0, -1.0, 6.0, 0.0, -6.0));
	var[2][1][1] = (mat3(9.0, 2.0, 4.0, 2.0, 8.0, -1.0, 0.0, -8.0, -9.0));
	var[2][1][2] = (mat3(-3.0, -9.0, 2.0, -3.0, 0.0, -5.0, -7.0, 7.0, -2.0));
	var[3][0][0] = (mat3(-6.0, -7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0));
	var[3][0][1] = (mat3(2.0, 4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0));
	var[3][0][2] = (mat3(-8.0, 3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0));
	var[3][1][0] = (mat3(-8.0, 6.0, -6.0, 7.0, -9.0, -1.0, -7.0, 3.0, -2.0));
	var[3][1][1] = (mat3(6.0, -4.0, 4.0, 1.0, -6.0, -5.0, 0.0, 0.0, -2.0));
	var[3][1][2] = (mat3(2.0, -2.0, 2.0, 5.0, 1.0, -4.0, 3.0, 5.0, -2.0));
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-6.0, 2.0, 1.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(-2.0, 7.0, -9.0, -9.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(-6.0, 5.0, -6.0, -2.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-4.0, -4.0, -3.0, -8.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(9.0, 5.0, -3.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(8.0, -5.0, 3.0, 2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-2.0, 9.0, -1.0, -5.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(-8.0, 1.0, -5.0, 5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(-3.0, 2.0, 9.0, -2.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-6.0, -3.0, 7.0, 7.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(1.0, 8.0, 3.0, -9.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(-3.0, 9.0, 5.0, -6.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-2.0, 9.0, -4.0, 7.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(7.0, 6.0, 8.0, -9.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(2.0, 3.0, -1.0, -5.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-4.0, -3.0, 4.0, -9.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(2.0, -1.0, -4.0, 0.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(-2.0, 5.0, -6.0, -5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(4.0, 9.0, 6.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(3.0, -6.0, 0.0, -9.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(4.0, 1.0, -6.0, 5.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(-1.0, -9.0, 2.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(-6.0, 8.0, 9.0, 3.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(-1.0, 9.0, 0.0, 5.0, 8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var[0][0][0][0] = (vec3(-6.0, -3.0, -4.0));
	var[0][0][0][1] = (vec3(-8.0, 7.0, 3.0));
	var[0][0][1][0] = (vec3(-2.0, 5.0, 6.0));
	var[0][0][1][1] = (vec3(-8.0, -9.0, 6.0));
	var[0][0][2][0] = (vec3(1.0, 1.0, -3.0));
	var[0][0][2][1] = (vec3(-5.0, -7.0, 9.0));
	var[0][1][0][0] = (vec3(1.0, -9.0, 1.0));
	var[0][1][0][1] = (vec3(5.0, -4.0, 3.0));
	var[0][1][1][0] = (vec3(5.0, -6.0, -6.0));
	var[0][1][1][1] = (vec3(0.0, -6.0, 7.0));
	var[0][1][2][0] = (vec3(7.0, -8.0, -1.0));
	var[0][1][2][1] = (vec3(1.0, -9.0, 5.0));
	var[1][0][0][0] = (vec3(5.0, -4.0, 6.0));
	var[1][0][0][1] = (vec3(-7.0, 2.0, -3.0));
	var[1][0][1][0] = (vec3(8.0, 2.0, 4.0));
	var[1][0][1][1] = (vec3(-8.0, 6.0, 0.0));
	var[1][0][2][0] = (vec3(-2.0, 1.0, -3.0));
	var[1][0][2][1] = (vec3(8.0, 0.0, -6.0));
	var[1][1][0][0] = (vec3(-6.0, 4.0, -4.0));
	var[1][1][0][1] = (vec3(-3.0, 9.0, 2.0));
	var[1][1][1][0] = (vec3(1.0, -8.0, 0.0));
	var[1][1][1][1] = (vec3(5.0, 0.0, 7.0));
	var[1][1][2][0] = (vec3(-6.0, -5.0, 3.0));
	var[1][1][2][1] = (vec3(-2.0, -7.0, 1.0));
	var[2][0][0][0] = (vec3(3.0, -2.0, -9.0));
	var[2][0][0][1] = (vec3(3.0, 9.0, -7.0));
	var[2][0][1][0] = (vec3(-7.0, 2.0, -3.0));
	var[2][0][1][1] = (vec3(-8.0, -6.0, 1.0));
	var[2][0][2][0] = (vec3(7.0, -2.0, -6.0));
	var[2][0][2][1] = (vec3(-1.0, 8.0, -1.0));
	var[2][1][0][0] = (vec3(0.0, 1.0, -8.0));
	var[2][1][0][1] = (vec3(-4.0, 2.0, -3.0));
	var[2][1][1][0] = (vec3(-3.0, 6.0, 6.0));
	var[2][1][1][1] = (vec3(-9.0, 6.0, -6.0));
	var[2][1][2][0] = (vec3(7.0, 9.0, -9.0));
	var[2][1][2][1] = (vec3(1.0, 4.0, -1.0));
	var[3][0][0][0] = (vec3(-1.0, 1.0, -1.0));
	var[3][0][0][1] = (vec3(-1.0, -5.0, 5.0));
	var[3][0][1][0] = (vec3(6.0, 7.0, -2.0));
	var[3][0][1][1] = (vec3(5.0, -6.0, -5.0));
	var[3][0][2][0] = (vec3(4.0, -3.0, -7.0));
	var[3][0][2][1] = (vec3(-7.0, -1.0, 5.0));
	var[3][1][0][0] = (vec3(7.0, 1.0, -4.0));
	var[3][1][0][1] = (vec3(-8.0, 8.0, -3.0));
	var[3][1][1][0] = (vec3(4.0, 1.0, 9.0));
	var[3][1][1][1] = (vec3(5.0, -5.0, 3.0));
	var[3][1][2][0] = (vec3(-7.0, -7.0, -1.0));
	var[3][1][2][1] = (vec3(-8.0, 6.0, -6.0));
}
#version 450
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
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(6.0, -6.0, -6.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(3.0, 1.0, 4.0, -2.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(-5.0, -8.0, -7.0, 1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(3.0, -2.0, -8.0, -9.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-5.0, -5.0, -2.0, 6.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(0.0, 7.0, 6.0, -3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(6.0, -5.0, 3.0, 7.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(2.0, 6.0, 8.0, 4.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(-2.0, -4.0, -2.0, -7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(9.0, 1.0, 3.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-2.0, 6.0, 8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(-2.0, 0.0, 0.0, 8.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(8.0, -4.0, -5.0, -4.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(6.0, -9.0, -2.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(-3.0, 6.0, 3.0, 2.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-7.0, 9.0, 9.0, -5.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-6.0, -7.0, 2.0, -1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(6.0, -6.0, -5.0, 8.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(-2.0, -3.0, -1.0, -4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(2.0, -1.0, -4.0, 5.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(-7.0, 7.0, 0.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(0.0, -9.0, 4.0, -2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(8.0, 7.0, -9.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(3.0, 1.0, -2.0, 9.0, 9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0][0][0] = (mat2x3(-2.0, -5.0, 0.0, 7.0, -2.0, 0.0));
	var[0][0][1] = (mat2x3(9.0, 9.0, 8.0, -6.0, 3.0, -9.0));
	var[0][0][2] = (mat2x3(0.0, 1.0, 1.0, 7.0, -8.0, 7.0));
	var[0][1][0] = (mat2x3(1.0, 2.0, -3.0, 0.0, -3.0, -2.0));
	var[0][1][1] = (mat2x3(3.0, -2.0, 5.0, -6.0, -7.0, -7.0));
	var[0][1][2] = (mat2x3(3.0, -4.0, -6.0, -2.0, 6.0, -7.0));
	var[1][0][0] = (mat2x3(-4.0, 4.0, -5.0, -1.0, 0.0, 2.0));
	var[1][0][1] = (mat2x3(-5.0, 6.0, 7.0, -2.0, 4.0, -3.0));
	var[1][0][2] = (mat2x3(7.0, 6.0, -3.0, -2.0, -6.0, 7.0));
	var[1][1][0] = (mat2x3(-3.0, 3.0, -9.0, 3.0, 8.0, -1.0));
	var[1][1][1] = (mat2x3(7.0, 4.0, -9.0, -7.0, 2.0, 1.0));
	var[1][1][2] = (mat2x3(-7.0, -2.0, 5.0, -6.0, -6.0, -1.0));
	var[2][0][0] = (mat2x3(-3.0, 2.0, 8.0, -1.0, 2.0, 2.0));
	var[2][0][1] = (mat2x3(-9.0, 3.0, 1.0, -7.0, -7.0, 3.0));
	var[2][0][2] = (mat2x3(-3.0, -5.0, 4.0, -6.0, 8.0, 7.0));
	var[2][1][0] = (mat2x3(-2.0, 6.0, 9.0, 1.0, -6.0, 6.0));
	var[2][1][1] = (mat2x3(6.0, 5.0, 3.0, 4.0, 7.0, 0.0));
	var[2][1][2] = (mat2x3(9.0, -5.0, 3.0, -7.0, 1.0, 0.0));
	var[3][0][0] = (mat2x3(-9.0, 2.0, -8.0, 9.0, 9.0, 3.0));
	var[3][0][1] = (mat2x3(5.0, 8.0, 5.0, -7.0, 6.0, 3.0));
	var[3][0][2] = (mat2x3(6.0, 6.0, 1.0, 2.0, -7.0, -9.0));
	var[3][1][0] = (mat2x3(6.0, 0.0, 6.0, 4.0, -1.0, -2.0));
	var[3][1][1] = (mat2x3(2.0, 3.0, 8.0, 3.0, -5.0, 1.0));
	var[3][1][2] = (mat2x3(-6.0, -1.0, 5.0, 9.0, -6.0, 9.0));
}
#version 450
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
	highp mat4x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-1.0, -8.0, -1.0, -7.0, -8.0, 6.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-8.0, -7.0, 7.0, 3.0, 7.0, 1.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(7.0, -7.0, -4.0, -2.0, -5.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-9.0, 6.0, -8.0, 0.0, 5.0, 5.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(0.0, 9.0, -8.0, 0.0, 5.0, 5.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(1.0, 2.0, -6.0, -9.0, -9.0, 7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(9.0, -5.0, -6.0, -1.0, 1.0, -8.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-1.0, -7.0, -7.0, -9.0, -4.0, 9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(-7.0, -8.0, 6.0, -7.0, -6.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(-8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(-2.0, 9.0, -6.0, 5.0, -1.0, 3.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(-3.0, 0.0, -2.0, -5.0, 8.0, -7.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(-9.0, 3.0, 5.0, 2.0, -2.0, -7.0, 6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0][0][0][0] = (vec2(-2.0, 2.0));
	var[0][0][0][1] = (vec2(8.0, -5.0));
	var[0][0][0][2] = (vec2(3.0, -1.0));
	var[0][0][0][3] = (vec2(-7.0, 4.0));
	var[0][0][1][0] = (vec2(2.0, -4.0));
	var[0][0][1][1] = (vec2(8.0, 3.0));
	var[0][0][1][2] = (vec2(8.0, -1.0));
	var[0][0][1][3] = (vec2(6.0, -8.0));
	var[0][0][2][0] = (vec2(2.0, -5.0));
	var[0][0][2][1] = (vec2(5.0, -4.0));
	var[0][0][2][2] = (vec2(-9.0, 0.0));
	var[0][0][2][3] = (vec2(4.0, 8.0));
	var[0][1][0][0] = (vec2(7.0, 0.0));
	var[0][1][0][1] = (vec2(-4.0, -1.0));
	var[0][1][0][2] = (vec2(5.0, 9.0));
	var[0][1][0][3] = (vec2(-8.0, -3.0));
	var[0][1][1][0] = (vec2(8.0, -1.0));
	var[0][1][1][1] = (vec2(7.0, 5.0));
	var[0][1][1][2] = (vec2(-7.0, 8.0));
	var[0][1][1][3] = (vec2(0.0, -5.0));
	var[0][1][2][0] = (vec2(7.0, 8.0));
	var[0][1][2][1] = (vec2(9.0, 8.0));
	var[0][1][2][2] = (vec2(9.0, 1.0));
	var[0][1][2][3] = (vec2(9.0, -9.0));
	var[1][0][0][0] = (vec2(2.0, -3.0));
	var[1][0][0][1] = (vec2(2.0, -4.0));
	var[1][0][0][2] = (vec2(-4.0, 2.0));
	var[1][0][0][3] = (vec2(-8.0, -4.0));
	var[1][0][1][0] = (vec2(8.0, 5.0));
	var[1][0][1][1] = (vec2(7.0, -4.0));
	var[1][0][1][2] = (vec2(6.0, 8.0));
	var[1][0][1][3] = (vec2(4.0, -9.0));
	var[1][0][2][0] = (vec2(-7.0, 7.0));
	var[1][0][2][1] = (vec2(-5.0, 1.0));
	var[1][0][2][2] = (vec2(-9.0, 9.0));
	var[1][0][2][3] = (vec2(5.0, 7.0));
	var[1][1][0][0] = (vec2(8.0, -2.0));
	var[1][1][0][1] = (vec2(9.0, 6.0));
	var[1][1][0][2] = (vec2(6.0, 3.0));
	var[1][1][0][3] = (vec2(-5.0, 1.0));
	var[1][1][1][0] = (vec2(-4.0, -5.0));
	var[1][1][1][1] = (vec2(7.0, -8.0));
	var[1][1][1][2] = (vec2(7.0, -1.0));
	var[1][1][1][3] = (vec2(-1.0, -2.0));
	var[1][1][2][0] = (vec2(-7.0, 4.0));
	var[1][1][2][1] = (vec2(-8.0, 2.0));
	var[1][1][2][2] = (vec2(4.0, 3.0));
	var[1][1][2][3] = (vec2(1.0, 7.0));
	var[2][0][0][0] = (vec2(3.0, 3.0));
	var[2][0][0][1] = (vec2(3.0, -5.0));
	var[2][0][0][2] = (vec2(-9.0, 2.0));
	var[2][0][0][3] = (vec2(9.0, 3.0));
	var[2][0][1][0] = (vec2(8.0, 3.0));
	var[2][0][1][1] = (vec2(-4.0, 6.0));
	var[2][0][1][2] = (vec2(1.0, -3.0));
	var[2][0][1][3] = (vec2(1.0, -5.0));
	var[2][0][2][0] = (vec2(-2.0, 7.0));
	var[2][0][2][1] = (vec2(8.0, 4.0));
	var[2][0][2][2] = (vec2(7.0, -1.0));
	var[2][0][2][3] = (vec2(-8.0, -6.0));
	var[2][1][0][0] = (vec2(8.0, 2.0));
	var[2][1][0][1] = (vec2(-9.0, -8.0));
	var[2][1][0][2] = (vec2(-9.0, -1.0));
	var[2][1][0][3] = (vec2(-3.0, -2.0));
	var[2][1][1][0] = (vec2(-1.0, 1.0));
	var[2][1][1][1] = (vec2(-1.0, -5.0));
	var[2][1][1][2] = (vec2(-6.0, -8.0));
	var[2][1][1][3] = (vec2(7.0, 2.0));
	var[2][1][2][0] = (vec2(0.0, -7.0));
	var[2][1][2][1] = (vec2(-6.0, 6.0));
	var[2][1][2][2] = (vec2(1.0, 8.0));
	var[2][1][2][3] = (vec2(9.0, 9.0));
	var[3][0][0][0] = (vec2(-6.0, -4.0));
	var[3][0][0][1] = (vec2(-2.0, 3.0));
	var[3][0][0][2] = (vec2(8.0, 4.0));
	var[3][0][0][3] = (vec2(4.0, -7.0));
	var[3][0][1][0] = (vec2(-6.0, 8.0));
	var[3][0][1][1] = (vec2(-6.0, 8.0));
	var[3][0][1][2] = (vec2(-3.0, -7.0));
	var[3][0][1][3] = (vec2(0.0, -9.0));
	var[3][0][2][0] = (vec2(2.0, -9.0));
	var[3][0][2][1] = (vec2(7.0, -2.0));
	var[3][0][2][2] = (vec2(2.0, -6.0));
	var[3][0][2][3] = (vec2(-1.0, 1.0));
	var[3][1][0][0] = (vec2(-8.0, -6.0));
	var[3][1][0][1] = (vec2(-7.0, -5.0));
	var[3][1][0][2] = (vec2(0.0, -3.0));
	var[3][1][0][3] = (vec2(1.0, -1.0));
	var[3][1][1][0] = (vec2(-6.0, 1.0));
	var[3][1][1][1] = (vec2(1.0, -7.0));
	var[3][1][1][2] = (vec2(-8.0, -5.0));
	var[3][1][1][3] = (vec2(5.0, 4.0));
	var[3][1][2][0] = (vec2(-9.0, -6.0));
	var[3][1][2][1] = (vec2(-7.0, -8.0));
	var[3][1][2][2] = (vec2(8.0, -3.0));
	var[3][1][2][3] = (vec2(6.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0][0][0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(3.0, 9.0, -7.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(6.0, 5.0, -8.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(9.0, -9.0, -8.0, -9.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(-5.0, -6.0, -2.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(-2.0, -2.0, 2.0, 9.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(-5.0, -3.0, -1.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(-4.0, -4.0, 3.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(-6.0, -8.0, 0.0, -1.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(9.0, 2.0, -2.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(9.0, -1.0, -8.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(-4.0, 8.0, 6.0, -2.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(-8.0, 8.0, 5.0, -5.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(1.0, -1.0, 1.0));
	var[0][0][0][1] = (vec3(-3.0, 9.0, -8.0));
	var[0][0][1][0] = (vec3(-5.0, 6.0, 6.0));
	var[0][0][1][1] = (vec3(3.0, -3.0, 7.0));
	var[0][1][0][0] = (vec3(6.0, -2.0, 0.0));
	var[0][1][0][1] = (vec3(3.0, 4.0, -6.0));
	var[0][1][1][0] = (vec3(3.0, -6.0, 2.0));
	var[0][1][1][1] = (vec3(4.0, -8.0, 0.0));
	var[0][2][0][0] = (vec3(0.0, 9.0, -7.0));
	var[0][2][0][1] = (vec3(5.0, 6.0, -3.0));
	var[0][2][1][0] = (vec3(-6.0, 0.0, -3.0));
	var[0][2][1][1] = (vec3(7.0, 9.0, -2.0));
	var[0][3][0][0] = (vec3(5.0, -2.0, -1.0));
	var[0][3][0][1] = (vec3(7.0, -7.0, 5.0));
	var[0][3][1][0] = (vec3(-3.0, 6.0, 7.0));
	var[0][3][1][1] = (vec3(6.0, -5.0, -2.0));
	var[1][0][0][0] = (vec3(-9.0, -2.0, -7.0));
	var[1][0][0][1] = (vec3(7.0, 0.0, -8.0));
	var[1][0][1][0] = (vec3(0.0, -5.0, 5.0));
	var[1][0][1][1] = (vec3(-2.0, 4.0, -8.0));
	var[1][1][0][0] = (vec3(-3.0, 3.0, 5.0));
	var[1][1][0][1] = (vec3(-6.0, -8.0, 8.0));
	var[1][1][1][0] = (vec3(4.0, -9.0, -1.0));
	var[1][1][1][1] = (vec3(-6.0, 7.0, -3.0));
	var[1][2][0][0] = (vec3(-7.0, 6.0, -7.0));
	var[1][2][0][1] = (vec3(8.0, -6.0, 8.0));
	var[1][2][1][0] = (vec3(4.0, -8.0, 4.0));
	var[1][2][1][1] = (vec3(4.0, 5.0, 5.0));
	var[1][3][0][0] = (vec3(2.0, -1.0, 2.0));
	var[1][3][0][1] = (vec3(-3.0, 6.0, -3.0));
	var[1][3][1][0] = (vec3(-2.0, 0.0, -6.0));
	var[1][3][1][1] = (vec3(2.0, -7.0, -2.0));
	var[2][0][0][0] = (vec3(-3.0, -4.0, 7.0));
	var[2][0][0][1] = (vec3(-3.0, -1.0, -9.0));
	var[2][0][1][0] = (vec3(2.0, -3.0, 6.0));
	var[2][0][1][1] = (vec3(-4.0, 8.0, 2.0));
	var[2][1][0][0] = (vec3(2.0, -2.0, 4.0));
	var[2][1][0][1] = (vec3(-3.0, -5.0, 9.0));
	var[2][1][1][0] = (vec3(-8.0, -1.0, 7.0));
	var[2][1][1][1] = (vec3(2.0, 0.0, 5.0));
	var[2][2][0][0] = (vec3(2.0, 3.0, 6.0));
	var[2][2][0][1] = (vec3(-4.0, -4.0, -1.0));
	var[2][2][1][0] = (vec3(-3.0, -1.0, -1.0));
	var[2][2][1][1] = (vec3(6.0, 2.0, 2.0));
	var[2][3][0][0] = (vec3(1.0, -8.0, -3.0));
	var[2][3][0][1] = (vec3(7.0, 3.0, 1.0));
	var[2][3][1][0] = (vec3(2.0, -8.0, 6.0));
	var[2][3][1][1] = (vec3(-8.0, -7.0, 0.0));
}
#version 450
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
	highp mat3x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-9.0, -4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-1.0, 9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(3.0, 8.0, 5.0, 9.0, 4.0, 6.0, 7.0, 0.0, 4.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(8.0, -7.0, -1.0, 4.0, -8.0, -5.0, 3.0, 6.0, 4.0, -1.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(8.0, 9.0, 2.0, 2.0, 6.0, -3.0, 4.0, -7.0, 0.0, 1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(-9.0, -7.0, -8.0, -4.0, 8.0, 2.0, 3.0, 0.0, -9.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(8.0, -1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-2.0, 2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(0.0, 2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(6.0, -2.0, -4.0, 2.0, -1.0, -5.0, -1.0, -2.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(-9.0, 3.0, 2.0, 5.0, -9.0, -1.0, -7.0, 5.0, -3.0, -9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(3.0, -4.0, -8.0, 9.0, -6.0, -5.0, 4.0, -7.0, 8.0, -7.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(8.0, 1.0, 3.0, 3.0, 6.0, 0.0, -6.0, 2.0, -5.0, 9.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-3.0, -9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-2.0, -4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(4.0, 1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(8.0, -5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(7.0, 3.0, 5.0, 9.0, -3.0, -2.0, -1.0, 5.0, -5.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(2.0, 0.0, -7.0, 6.0, 9.0, -6.0, -1.0, 6.0, 6.0, 4.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(1.0, 4.0, 2.0, -6.0, 2.0, 3.0, -5.0, 6.0, 7.0, 7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(7.0, -2.0, -5.0, 2.0, -9.0, -4.0, 9.0, -9.0, -8.0, 1.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	var[0][0][1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	var[0][1][0] = (mat3x4(6.0, 6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0));
	var[0][1][1] = (mat3x4(3.0, -3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0));
	var[0][2][0] = (mat3x4(9.0, -2.0, 8.0, -4.0, 8.0, 4.0, 3.0, -3.0, 3.0, -5.0, 7.0, -8.0));
	var[0][2][1] = (mat3x4(5.0, -3.0, 8.0, 6.0, 1.0, 6.0, -2.0, -6.0, 0.0, 1.0, 3.0, 3.0));
	var[0][3][0] = (mat3x4(3.0, -7.0, -1.0, 2.0, -7.0, -9.0, 4.0, 1.0, -9.0, 4.0, 5.0, -1.0));
	var[0][3][1] = (mat3x4(-3.0, -8.0, 4.0, 4.0, -5.0, 6.0, 7.0, 6.0, 5.0, 2.0, 2.0, -5.0));
	var[1][0][0] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
	var[1][0][1] = (mat3x4(-6.0, 7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0));
	var[1][1][0] = (mat3x4(9.0, 4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0));
	var[1][1][1] = (mat3x4(5.0, 0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0));
	var[1][2][0] = (mat3x4(-3.0, 0.0, -3.0, 5.0, -4.0, -5.0, 1.0, -5.0, -5.0, 0.0, 0.0, -6.0));
	var[1][2][1] = (mat3x4(4.0, 6.0, -7.0, 7.0, 3.0, 6.0, 4.0, -7.0, 8.0, -1.0, 3.0, 3.0));
	var[1][3][0] = (mat3x4(8.0, -2.0, -8.0, -1.0, -5.0, -1.0, -6.0, 3.0, 7.0, -8.0, -6.0, -9.0));
	var[1][3][1] = (mat3x4(-5.0, -1.0, 4.0, 9.0, -9.0, -3.0, -8.0, -1.0, 5.0, 9.0, -6.0, 2.0));
	var[2][0][0] = (mat3x4(7.0, -8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0));
	var[2][0][1] = (mat3x4(-1.0, 2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0));
	var[2][1][0] = (mat3x4(0.0, -3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0));
	var[2][1][1] = (mat3x4(5.0, 7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0));
	var[2][2][0] = (mat3x4(-1.0, 0.0, -1.0, 5.0, 3.0, -9.0, 6.0, 8.0, -9.0, -5.0, -1.0, 1.0));
	var[2][2][1] = (mat3x4(-1.0, -4.0, 7.0, 7.0, 5.0, -7.0, 1.0, 3.0, 6.0, 3.0, -3.0, -9.0));
	var[2][3][0] = (mat3x4(-6.0, 6.0, -6.0, 7.0, 6.0, -6.0, 8.0, 9.0, 6.0, 0.0, 7.0, 8.0));
	var[2][3][1] = (mat3x4(7.0, -9.0, -9.0, -4.0, 2.0, 7.0, 9.0, -8.0, -5.0, 6.0, 2.0, -3.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(4.0, -4.0, -2.0, 1.0, 2.0, 6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(8.0, 8.0, -3.0, -7.0, 8.0, -1.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(6.0, 8.0, 5.0, -7.0, -9.0, 6.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(1.0, -1.0, 8.0, 0.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(-4.0, 5.0, -6.0, 5.0, -9.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(-9.0, -9.0, 0.0, -2.0, 7.0, 4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(0.0, 1.0, -7.0, 0.0, -4.0, 9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(-3.0, 5.0, 6.0, 1.0, -2.0, 9.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(0.0, -7.0, -8.0, 5.0, 7.0, -1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(4.0, 3.0, 5.0, -4.0, 8.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(2.0, 8.0, -2.0, -7.0, 4.0, -5.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(-1.0, 2.0, 3.0, -6.0, 2.0, 8.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	var[0][0][1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	var[0][1][0] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	var[0][1][1] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	var[0][2][0] = (mat4x2(2.0, -6.0, -9.0, 6.0, 2.0, -2.0, 9.0, 8.0));
	var[0][2][1] = (mat4x2(8.0, 3.0, -2.0, -8.0, 8.0, 4.0, -3.0, 4.0));
	var[0][3][0] = (mat4x2(-1.0, 2.0, 5.0, -9.0, 3.0, 2.0, -5.0, 4.0));
	var[0][3][1] = (mat4x2(-2.0, 3.0, -1.0, -4.0, -7.0, 3.0, 1.0, -1.0));
	var[1][0][0] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	var[1][0][1] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	var[1][1][0] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	var[1][1][1] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	var[1][2][0] = (mat4x2(-5.0, 5.0, 9.0, -8.0, -8.0, -5.0, -4.0, -1.0));
	var[1][2][1] = (mat4x2(-1.0, -6.0, 6.0, -3.0, -5.0, 2.0, 6.0, 1.0));
	var[1][3][0] = (mat4x2(3.0, 6.0, -6.0, -2.0, -8.0, 0.0, -9.0, -5.0));
	var[1][3][1] = (mat4x2(-9.0, 5.0, -9.0, 2.0, -2.0, -5.0, -3.0, 5.0));
	var[2][0][0] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	var[2][0][1] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	var[2][1][0] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	var[2][1][1] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
	var[2][2][0] = (mat4x2(-9.0, 0.0, -5.0, -9.0, 9.0, 8.0, -6.0, -4.0));
	var[2][2][1] = (mat4x2(-4.0, -8.0, 9.0, 7.0, -5.0, -3.0, 3.0, 7.0));
	var[2][3][0] = (mat4x2(-8.0, -1.0, 9.0, 1.0, -6.0, 5.0, -5.0, -9.0));
	var[2][3][1] = (mat4x2(7.0, 1.0, 0.0, 3.0, 4.0, 8.0, 8.0, -2.0));
}
#version 450
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
	float16_t var[][4][2];
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(var[0][0][0]), -7.0) && allOk;
	allOk = compare_float16_t(float(var[0][0][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[0][1][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[0][1][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[0][2][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[0][2][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[0][3][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[0][3][1]), 9.0) && allOk;
	allOk = compare_float16_t(float(var[1][0][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[1][0][1]), 0.0) && allOk;
	allOk = compare_float16_t(float(var[1][1][0]), 7.0) && allOk;
	allOk = compare_float16_t(float(var[1][1][1]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[1][2][0]), -8.0) && allOk;
	allOk = compare_float16_t(float(var[1][2][1]), -2.0) && allOk;
	allOk = compare_float16_t(float(var[1][3][0]), 8.0) && allOk;
	allOk = compare_float16_t(float(var[1][3][1]), -1.0) && allOk;
	allOk = compare_float16_t(float(var[2][0][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[2][0][1]), 9.0) && allOk;
	allOk = compare_float16_t(float(var[2][1][0]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[2][1][1]), -3.0) && allOk;
	allOk = compare_float16_t(float(var[2][2][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[2][2][1]), 3.0) && allOk;
	allOk = compare_float16_t(float(var[2][3][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[2][3][1]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = float16_t(-8.0);
	var[0][0][1] = float16_t(9.0);
	var[0][1][0] = float16_t(2.0);
	var[0][1][1] = float16_t(-8.0);
	var[0][2][0] = float16_t(8.0);
	var[0][2][1] = float16_t(-3.0);
	var[0][3][0] = float16_t(3.0);
	var[0][3][1] = float16_t(8.0);
	var[1][0][0] = float16_t(-2.0);
	var[1][0][1] = float16_t(7.0);
	var[1][1][0] = float16_t(-1.0);
	var[1][1][1] = float16_t(6.0);
	var[1][2][0] = float16_t(6.0);
	var[1][2][1] = float16_t(-3.0);
	var[1][3][0] = float16_t(-7.0);
	var[1][3][1] = float16_t(-4.0);
	var[2][0][0] = float16_t(8.0);
	var[2][0][1] = float16_t(-9.0);
	var[2][1][0] = float16_t(-7.0);
	var[2][1][1] = float16_t(-5.0);
	var[2][2][0] = float16_t(-8.0);
	var[2][2][1] = float16_t(1.0);
	var[2][3][0] = float16_t(-6.0);
	var[2][3][1] = float16_t(8.0);
}
#version 450
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
	highp uvec4 var[][4][2];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var[0][0][0]), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((var[0][0][1]), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((var[0][1][0]), uvec4(7u, 3u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((var[0][1][1]), uvec4(8u, 7u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((var[0][2][0]), uvec4(8u, 5u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((var[0][2][1]), uvec4(3u, 6u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((var[0][3][0]), uvec4(9u, 6u, 7u, 7u)) && allOk;
	allOk = compare_uvec4((var[0][3][1]), uvec4(5u, 5u, 7u, 9u)) && allOk;
	allOk = compare_uvec4((var[1][0][0]), uvec4(3u, 6u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((var[1][0][1]), uvec4(2u, 3u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((var[1][1][0]), uvec4(5u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((var[1][1][1]), uvec4(1u, 6u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((var[1][2][0]), uvec4(4u, 0u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((var[1][2][1]), uvec4(6u, 2u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((var[1][3][0]), uvec4(1u, 6u, 5u, 2u)) && allOk;
	allOk = compare_uvec4((var[1][3][1]), uvec4(8u, 0u, 6u, 7u)) && allOk;
	allOk = compare_uvec4((var[2][0][0]), uvec4(0u, 7u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((var[2][0][1]), uvec4(2u, 8u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((var[2][1][0]), uvec4(7u, 9u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((var[2][1][1]), uvec4(5u, 7u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((var[2][2][0]), uvec4(5u, 8u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((var[2][2][1]), uvec4(9u, 8u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((var[2][3][0]), uvec4(9u, 4u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((var[2][3][1]), uvec4(2u, 3u, 8u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (uvec4(2u, 7u, 2u, 9u));
	var[0][0][1] = (uvec4(7u, 9u, 5u, 1u));
	var[0][1][0] = (uvec4(4u, 9u, 1u, 3u));
	var[0][1][1] = (uvec4(8u, 8u, 8u, 1u));
	var[0][2][0] = (uvec4(6u, 1u, 9u, 4u));
	var[0][2][1] = (uvec4(5u, 7u, 7u, 0u));
	var[0][3][0] = (uvec4(2u, 0u, 0u, 4u));
	var[0][3][1] = (uvec4(4u, 2u, 5u, 9u));
	var[1][0][0] = (uvec4(3u, 4u, 4u, 2u));
	var[1][0][1] = (uvec4(0u, 5u, 6u, 2u));
	var[1][1][0] = (uvec4(7u, 5u, 4u, 8u));
	var[1][1][1] = (uvec4(6u, 6u, 0u, 9u));
	var[1][2][0] = (uvec4(2u, 5u, 1u, 3u));
	var[1][2][1] = (uvec4(9u, 6u, 1u, 2u));
	var[1][3][0] = (uvec4(6u, 9u, 6u, 2u));
	var[1][3][1] = (uvec4(3u, 6u, 1u, 7u));
	var[2][0][0] = (uvec4(9u, 5u, 7u, 7u));
	var[2][0][1] = (uvec4(0u, 3u, 8u, 1u));
	var[2][1][0] = (uvec4(7u, 2u, 3u, 0u));
	var[2][1][1] = (uvec4(4u, 4u, 8u, 5u));
	var[2][2][0] = (uvec4(0u, 0u, 8u, 4u));
	var[2][2][1] = (uvec4(9u, 5u, 7u, 1u));
	var[2][3][0] = (uvec4(5u, 6u, 4u, 8u));
	var[2][3][1] = (uvec4(6u, 3u, 2u, 5u));
}
#version 450
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
	allOk = compare_uint((u), 1u) && allOk;
	allOk = compare_mat4x3(t[0].a, mat4x3(9.0, 3.0, -1.0, 0.0, -4.0, 7.0, 2.0, -1.0, -3.0, 5.0, 2.0, 6.0)) && allOk;
	allOk = compare_uvec3((t[0].b[0].a), uvec3(4u, 4u, 4u)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[0]), vec2(-1.0, 3.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[1]), vec2(-9.0, 6.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[2]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[3]), vec2(9.0, 5.0)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(-5.0, 4.0, -9.0, 0.0)) && allOk;
	allOk = compare_uvec3((t[0].b[1].a), uvec3(1u, 2u, 6u)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[0]), vec2(-9.0, 6.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[1]), vec2(4.0, 8.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[2]), vec2(-8.0, 0.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[3]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(-5.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_uvec3((t[0].b[2].a), uvec3(3u, 4u, 2u)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[0]), vec2(4.0, 3.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[1]), vec2(7.0, -9.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[2]), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[3]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(-4.0, -1.0, 4.0, -1.0)) && allOk;
	allOk = compare_int((t[0].c), 0) && allOk;
	allOk = compare_mat4x3(t[1].a, mat4x3(-8.0, 2.0, 1.0, 5.0, -2.0, -9.0, 7.0, 4.0, 0.0, 7.0, 7.0, 8.0)) && allOk;
	allOk = compare_uvec3((t[1].b[0].a), uvec3(7u, 2u, 0u)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[0]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[1]), vec2(-8.0, 8.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[2]), vec2(1.0, -1.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[3]), vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(5.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_uvec3((t[1].b[1].a), uvec3(0u, 7u, 3u)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[0]), vec2(7.0, 0.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[1]), vec2(7.0, 0.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[2]), vec2(-4.0, -2.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[3]), vec2(-2.0, -8.0)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(5.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_uvec3((t[1].b[2].a), uvec3(5u, 9u, 7u)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[0]), vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[1]), vec2(-4.0, 4.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[2]), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[3]), vec2(2.0, 0.0)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(-2.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_int((t[1].c), 5) && allOk;
	allOk = compare_mat4x3(t[2].a, mat4x3(9.0, 9.0, -2.0, -1.0, -7.0, -7.0, 6.0, 9.0, -5.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_uvec3((t[2].b[0].a), uvec3(3u, 8u, 5u)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[0]), vec2(9.0, -8.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[1]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[2]), vec2(0.0, -3.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[3]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec4((t[2].b[0].c), vec4(-8.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_uvec3((t[2].b[1].a), uvec3(2u, 9u, 0u)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[0]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[1]), vec2(8.0, -9.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[2]), vec2(-5.0, 8.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[3]), vec2(1.0, 6.0)) && allOk;
	allOk = compare_vec4((t[2].b[1].c), vec4(9.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_uvec3((t[2].b[2].a), uvec3(4u, 1u, 8u)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[0]), vec2(-2.0, 3.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[1]), vec2(-2.0, 9.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[2]), vec2(6.0, -5.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[3]), vec2(0.0, -5.0)) && allOk;
	allOk = compare_vec4((t[2].b[2].c), vec4(-3.0, -7.0, -9.0, 1.0)) && allOk;
	allOk = compare_int((t[2].c), -2) && allOk;
	allOk = compare_mat4x3(t[3].a, mat4x3(3.0, -4.0, 7.0, 8.0, -9.0, 4.0, 7.0, -7.0, 6.0, 8.0, 9.0, -5.0)) && allOk;
	allOk = compare_uvec3((t[3].b[0].a), uvec3(3u, 1u, 4u)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[0]), vec2(4.0, 8.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[1]), vec2(6.0, -6.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[2]), vec2(9.0, -3.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[3]), vec2(8.0, -7.0)) && allOk;
	allOk = compare_vec4((t[3].b[0].c), vec4(-9.0, 1.0, -1.0, 3.0)) && allOk;
	allOk = compare_uvec3((t[3].b[1].a), uvec3(2u, 7u, 6u)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[0]), vec2(7.0, -2.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[1]), vec2(3.0, 9.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[2]), vec2(0.0, 9.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[3]), vec2(-6.0, 1.0)) && allOk;
	allOk = compare_vec4((t[3].b[1].c), vec4(-5.0, -1.0, 6.0, -6.0)) && allOk;
	allOk = compare_uvec3((t[3].b[2].a), uvec3(4u, 4u, 8u)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[0]), vec2(3.0, -4.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[1]), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[2]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[3]), vec2(8.0, 0.0)) && allOk;
	allOk = compare_vec4((t[3].b[2].c), vec4(-5.0, -7.0, 8.0, 9.0)) && allOk;
	allOk = compare_int((t[3].c), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (uvec3(4u, 1u, 1u));
	s.b[0] = (vec2(-7.0, 3.0));
	s.b[1] = (vec2(2.0, 8.0));
	s.b[2] = (vec2(2.0, -9.0));
	s.b[3] = (vec2(5.0, -5.0));
	s.c = (vec4(3.0, -9.0, 6.0, 9.0));
	u = (3u);
}
#version 450
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
	highp uvec3 var;
} block[3];

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((block[0].var), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((block[1].var), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((block[2].var), uvec3(5u, 0u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (uvec3(3u, 5u, 6u));
	block[1].var = (uvec3(5u, 4u, 5u));
	block[2].var = (uvec3(4u, 9u, 4u));
}
#version 450
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
	bvec2 var;
} block[3];

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((block[0].var), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block[1].var), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block[2].var), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (bvec2(true, false));
	block[1].var = (bvec2(true, true));
	block[2].var = (bvec2(false, false));
}
#version 450
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
	highp mat3x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(block[0].var, mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(-2.0, 8.0));
	block[0].var[1] = (vec2(1.0, 8.0));
	block[0].var[2] = (vec2(-7.0, 5.0));
	block[1].var[0] = (vec2(2.0, 0.0));
	block[1].var[1] = (vec2(-3.0, 1.0));
	block[1].var[2] = (vec2(2.0, -5.0));
	block[2].var[0] = (vec2(6.0, 3.0));
	block[2].var[1] = (vec2(6.0, 5.0));
	block[2].var[2] = (vec2(-5.0, 9.0));
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
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
	allOk = compare_float((block[0].padding), -3.0) && allOk;
	allOk = compare_mat2x4(block[0].var, mat2x4(-2.0, 1.0, -1.0, 0.0, 3.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_float((block[1].padding), 1.0) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(-1.0, 3.0, 9.0, 6.0, 1.0, 2.0, -9.0, 2.0)) && allOk;
	allOk = compare_float((block[2].padding), 1.0) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(-6.0, 0.0, -3.0, 0.0, -8.0, 2.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (2.0);
	block[0].var[0] = (vec4(-1.0, -8.0, 7.0, 5.0));
	block[0].var[1] = (vec4(1.0, 7.0, 1.0, -7.0));
	block[1].padding = (7.0);
	block[1].var[0] = (vec4(2.0, -1.0, 4.0, 2.0));
	block[1].var[1] = (vec4(-4.0, 8.0, -2.0, 1.0));
	block[2].padding = (5.0);
	block[2].var[0] = (vec4(0.0, -4.0, 1.0, 9.0));
	block[2].var[1] = (vec4(-2.0, 1.0, 0.0, 5.0));
}
#version 450
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
	lowp uvec2 a[1];
	bvec3 b[1];
	lowp ivec3 c;
	highp ivec3 d;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((a[0]), uvec2(5u, 5u)) && allOk;
	allOk = compare_bvec3((b[0]), bvec3(false, false, false)) && allOk;
	allOk = compare_ivec3((c), ivec3(3, 7, -1)) && allOk;
	allOk = compare_ivec3((d), ivec3(-8, 2, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (uvec2(5u, 5u));
	b[0] = (bvec3(true, false, true));
}
#version 450
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
	lowp mat4x2 e;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp mat3 f[1];
	mediump vec2 g;
	highp mat4 h;
	highp mat2x3 i;
	highp float j;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(a, mat3x2(-4.0, -7.0, 6.0, -9.0, 6.0, 5.0)) && allOk;
	allOk = compare_ivec4((c), ivec4(6, -2, -6, 4)) && allOk;
	allOk = compare_mat4x2(e, mat4x2(-3.0, -5.0, 2.0, -7.0, -9.0, 3.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat4(blockC.h, mat4(-7.0, 1.0, -8.0, 2.0, 0.0, 1.0, 8.0, -3.0, 7.0, -6.0, -9.0, -5.0, 6.0, -8.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockC.i, mat2x3(3.0, 8.0, 4.0, -1.0, 3.0, -6.0)) && allOk;
	allOk = compare_float((blockC.j), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x2(9.0, -9.0, -7.0, -8.0, -5.0, 0.0));
	blockC.f[0] = (mat3(4.0, -6.0, 5.0, -4.0, 9.0, 1.0, 4.0, -5.0, 8.0));
	blockC.h = (mat4(-9.0, -1.0, -6.0, 9.0, -8.0, -4.0, -9.0, 9.0, -2.0, 3.0, 1.0, -6.0, -2.0, 5.0, -3.0, 4.0));
	blockC.i = (mat2x3(7.0, -1.0, -2.0, 2.0, -2.0, 1.0));
	blockC.j = (0.0);
}
#version 450
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
	mediump float a;
	lowp mat4 b[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp ivec2 c;
	mediump mat4x2 d[1];
	lowp float e;
	highp vec4 f;
	highp uvec2 g[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	mediump int h;
	mediump vec3 i;
	lowp mat4x2 j;
	lowp ivec2 k;
	bvec4 l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(b[0], mat4(-6.0, 9.0, -5.0, 0.0, 3.0, 7.0, -1.0, -8.0, 2.0, 8.0, -2.0, -2.0, 4.0, -7.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockC.d[0], mat4x2(-6.0, 3.0, -7.0, 4.0, 1.0, -6.0, -7.0, 2.0)) && allOk;
	allOk = compare_float((blockC.e), 8.0) && allOk;
	allOk = compare_vec4((blockC.f), vec4(-2.0, 8.0, 0.0, 2.0)) && allOk;
	allOk = compare_uvec2((blockC.g[0]), uvec2(3u, 3u)) && allOk;
	allOk = compare_int((h), 3) && allOk;
	allOk = compare_mat4x2(j, mat4x2(9.0, -2.0, 7.0, 6.0, 3.0, -8.0, -8.0, 0.0)) && allOk;
	allOk = compare_bvec4((l[0]), bvec4(true, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (mat4(3.0, -9.0, 0.0, 9.0, 2.0, -6.0, 6.0, -6.0, 3.0, 5.0, -8.0, -7.0, -8.0, 3.0, -6.0, -9.0));
	blockC.c = (ivec2(9, -9));
	blockC.d[0] = (mat4x2(9.0, 8.0, -1.0, -4.0, 0.0, -4.0, 2.0, 1.0));
	blockC.e = (2.0);
	blockC.f = (vec4(9.0, -3.0, -2.0, -6.0));
	blockC.g[0] = (uvec2(0u, 4u));
	h = (-3);
	i = (vec3(2.0, 0.0, 0.0));
	j = (mat4x2(2.0, -8.0, -5.0, -3.0, -3.0, 0.0, 8.0, -9.0));
	k = (ivec2(2, -4));
	l[0] = (bvec4(true, true, true, false));
}
#version 450
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
	highp uint a;
	mediump float b[1];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp mat2x3 c;
	highp uint d;
	mediump uvec4 e;
	highp uvec2 f[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	highp int g;
	lowp mat3 h;
	highp uvec2 i;
	mediump ivec2 j[];
} blockD;
layout(std140, row_major, binding = 4) buffer BlockE
{
	highp mat4x2 k;
	bvec4 l;
	lowp uint m;
	mediump mat4 n[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 0u) && allOk;
	allOk = compare_float((blockB.b[0]), 4.0) && allOk;
	allOk = compare_uint((blockC.d), 4u) && allOk;
	allOk = compare_mat3(blockD.h, mat3(-6.0, -3.0, 0.0, -6.0, 1.0, 2.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_uvec2((blockD.i), uvec2(0u, 7u)) && allOk;
	allOk = compare_mat4x2(k, mat4x2(9.0, 7.0, 7.0, 5.0, 2.0, -7.0, -8.0, -5.0)) && allOk;
	allOk = compare_uint((m), 5u) && allOk;
	allOk = compare_mat4(n[0], mat4(0.0, -2.0, 4.0, 7.0, 1.0, -3.0, 0.0, -4.0, -9.0, 0.0, 9.0, 5.0, 2.0, -4.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (4u);
	blockB.b[0] = (3.0);
	blockC.c = (mat2x3(-9.0, -4.0, 9.0, -7.0, -1.0, -4.0));
	blockC.d = (6u);
	blockC.e = (uvec4(4u, 5u, 2u, 2u));
	blockD.h = (mat3(-4.0, -7.0, 2.0, -5.0, -9.0, 9.0, -1.0, 9.0, 4.0));
	blockD.i = (uvec2(6u, 3u));
	k = (mat4x2(-9.0, -2.0, -7.0, 9.0, 0.0, -6.0, 7.0, 8.0));
	n[0] = (mat4(5.0, 5.0, 5.0, -3.0, 5.0, 5.0, 1.0, 8.0, 3.0, 3.0, 1.0, 2.0, 8.0, 6.0, -2.0, -1.0));
}
#version 450
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
	highp mat3x4 a;
	bvec3 b;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a, mat3x4(1.0, 7.0, -1.0, -6.0, -3.0, -5.0, -8.0, 5.0, 9.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec3(false, true, true));
}
#version 450
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
	mediump mat4x3 a;
	mediump float b[][1];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	bvec4 c;
	highp uvec2 d;
	mediump mat4 e;
	lowp mat3x2 f;
	lowp uvec2 g[];
};
layout(std140, binding = 3) buffer BlockD
{
	bvec3 h[];
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(e, mat4(-3.0, 3.0, -6.0, 3.0, -1.0, 9.0, -3.0, 9.0, -4.0, -3.0, 6.0, -4.0, 6.0, -4.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x2(f, mat3x2(-2.0, -4.0, -5.0, 1.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4x3(-6.0, -9.0, 9.0, 5.0, 6.0, -9.0, 4.0, 0.0, -5.0, 0.0, -7.0, -6.0));
	b[0][0] = (-7.0);
	b[1][0] = (3.0);
	b[2][0] = (9.0);
	b[3][0] = (-4.0);
	c = (bvec4(false, true, false, false));
	e = (mat4(-8.0, -4.0, 9.0, -2.0, -5.0, 3.0, -8.0, 1.0, 2.0, 9.0, -1.0, -6.0, 4.0, -2.0, -1.0, 3.0));
	blockD[0].h[0] = (bvec3(false, true, true));
}
#version 450
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
	lowp ivec4 a[8];
	mediump mat2x3 b[][2][5];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a[0]), ivec4(2, -8, -4, 7)) && allOk;
	allOk = compare_ivec4((blockB.a[1]), ivec4(4, 0, -5, -8)) && allOk;
	allOk = compare_ivec4((blockB.a[2]), ivec4(-6, 4, 5, 6)) && allOk;
	allOk = compare_ivec4((blockB.a[3]), ivec4(-6, 1, 8, 1)) && allOk;
	allOk = compare_ivec4((blockB.a[4]), ivec4(-7, 7, 5, 8)) && allOk;
	allOk = compare_ivec4((blockB.a[5]), ivec4(5, -9, -8, 6)) && allOk;
	allOk = compare_ivec4((blockB.a[6]), ivec4(2, 3, -7, -8)) && allOk;
	allOk = compare_ivec4((blockB.a[7]), ivec4(9, -9, 1, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec4(8, -2, -1, -6));
	blockB.a[1] = (ivec4(6, 0, 9, 5));
	blockB.a[2] = (ivec4(4, 8, 6, 7));
	blockB.a[3] = (ivec4(-5, 5, -2, 7));
	blockB.a[4] = (ivec4(4, 7, 0, 9));
	blockB.a[5] = (ivec4(-4, -5, 4, 9));
	blockB.a[6] = (ivec4(-7, -6, -2, -4));
	blockB.a[7] = (ivec4(8, -6, -4, 6));
	blockB.b[0][0][0] = (mat2x3(-3.0, 8.0, -7.0, -6.0, -6.0, -1.0));
	blockB.b[0][0][1] = (mat2x3(4.0, 2.0, 4.0, -7.0, -1.0, -6.0));
	blockB.b[0][0][2] = (mat2x3(5.0, -1.0, -3.0, -5.0, -2.0, -7.0));
	blockB.b[0][0][3] = (mat2x3(8.0, 7.0, 8.0, -6.0, 9.0, -3.0));
	blockB.b[0][0][4] = (mat2x3(-4.0, 9.0, 1.0, 4.0, 0.0, 2.0));
	blockB.b[0][1][0] = (mat2x3(-8.0, -7.0, -4.0, -1.0, 0.0, -2.0));
	blockB.b[0][1][1] = (mat2x3(5.0, 6.0, -4.0, -2.0, -8.0, -7.0));
	blockB.b[0][1][2] = (mat2x3(2.0, -3.0, 2.0, 7.0, -5.0, -7.0));
	blockB.b[0][1][3] = (mat2x3(6.0, 0.0, 5.0, -5.0, -3.0, 9.0));
	blockB.b[0][1][4] = (mat2x3(1.0, -1.0, -8.0, 2.0, 7.0, 2.0));
	blockB.b[1][0][0] = (mat2x3(-3.0, -9.0, -6.0, -9.0, 0.0, -8.0));
	blockB.b[1][0][1] = (mat2x3(4.0, -8.0, 0.0, -1.0, -9.0, 0.0));
	blockB.b[1][0][2] = (mat2x3(9.0, 4.0, 6.0, -9.0, 7.0, 6.0));
	blockB.b[1][0][3] = (mat2x3(-5.0, 3.0, -2.0, -4.0, -5.0, 0.0));
	blockB.b[1][0][4] = (mat2x3(-5.0, 9.0, 4.0, 2.0, -4.0, -2.0));
	blockB.b[1][1][0] = (mat2x3(6.0, 2.0, 2.0, -8.0, -8.0, 0.0));
	blockB.b[1][1][1] = (mat2x3(5.0, -7.0, -9.0, -9.0, 1.0, 5.0));
	blockB.b[1][1][2] = (mat2x3(-1.0, 4.0, 1.0, -2.0, 8.0, 9.0));
	blockB.b[1][1][3] = (mat2x3(-7.0, -7.0, 3.0, 6.0, -2.0, 0.0));
	blockB.b[1][1][4] = (mat2x3(-2.0, 6.0, -4.0, 7.0, 2.0, 3.0));
	blockB.b[2][0][0] = (mat2x3(-5.0, -1.0, 8.0, 4.0, 3.0, -9.0));
	blockB.b[2][0][1] = (mat2x3(-7.0, -2.0, -6.0, -2.0, -1.0, 8.0));
	blockB.b[2][0][2] = (mat2x3(-5.0, 5.0, -5.0, -3.0, 9.0, -8.0));
	blockB.b[2][0][3] = (mat2x3(-9.0, 5.0, -7.0, 9.0, 1.0, 3.0));
	blockB.b[2][0][4] = (mat2x3(-7.0, -6.0, 3.0, -4.0, 5.0, -1.0));
	blockB.b[2][1][0] = (mat2x3(3.0, -4.0, 3.0, -7.0, 3.0, 7.0));
	blockB.b[2][1][1] = (mat2x3(2.0, -4.0, -8.0, 0.0, 7.0, -9.0));
	blockB.b[2][1][2] = (mat2x3(8.0, 8.0, -4.0, 3.0, 1.0, 5.0));
	blockB.b[2][1][3] = (mat2x3(7.0, -5.0, -3.0, -7.0, -3.0, 5.0));
	blockB.b[2][1][4] = (mat2x3(-2.0, -3.0, 1.0, -3.0, 6.0, -4.0));
	blockB.b[3][0][0] = (mat2x3(0.0, 4.0, -3.0, 4.0, -4.0, 8.0));
	blockB.b[3][0][1] = (mat2x3(7.0, 1.0, 6.0, -6.0, 1.0, 2.0));
	blockB.b[3][0][2] = (mat2x3(2.0, -5.0, 0.0, -3.0, 3.0, -7.0));
	blockB.b[3][0][3] = (mat2x3(6.0, 2.0, 8.0, 3.0, -2.0, -5.0));
	blockB.b[3][0][4] = (mat2x3(-9.0, 2.0, 3.0, -5.0, 4.0, -1.0));
	blockB.b[3][1][0] = (mat2x3(-7.0, 5.0, 2.0, 4.0, 6.0, -5.0));
	blockB.b[3][1][1] = (mat2x3(1.0, -2.0, -7.0, 2.0, 3.0, 1.0));
	blockB.b[3][1][2] = (mat2x3(-7.0, 6.0, 3.0, 5.0, -4.0, -4.0));
	blockB.b[3][1][3] = (mat2x3(4.0, -7.0, 1.0, -9.0, 8.0, -9.0));
	blockB.b[3][1][4] = (mat2x3(9.0, -6.0, 3.0, -3.0, -5.0, 4.0));
	blockB.b[4][0][0] = (mat2x3(4.0, -4.0, -9.0, -5.0, 3.0, -5.0));
	blockB.b[4][0][1] = (mat2x3(2.0, -9.0, 4.0, -3.0, -1.0, -2.0));
	blockB.b[4][0][2] = (mat2x3(-3.0, -6.0, -2.0, -7.0, -8.0, -9.0));
	blockB.b[4][0][3] = (mat2x3(8.0, -2.0, 0.0, -8.0, 4.0, -6.0));
	blockB.b[4][0][4] = (mat2x3(-6.0, -6.0, -8.0, -1.0, -8.0, -8.0));
	blockB.b[4][1][0] = (mat2x3(3.0, 3.0, -9.0, -4.0, 3.0, 0.0));
	blockB.b[4][1][1] = (mat2x3(-7.0, -3.0, 9.0, 4.0, 9.0, 5.0));
	blockB.b[4][1][2] = (mat2x3(2.0, 3.0, -1.0, -3.0, 9.0, -5.0));
	blockB.b[4][1][3] = (mat2x3(8.0, -1.0, -9.0, 9.0, -3.0, 7.0));
	blockB.b[4][1][4] = (mat2x3(-1.0, 6.0, -1.0, -7.0, -2.0, 1.0));
}
#version 450
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
	lowp ivec3 mB;
	highp uint mC;
};
struct sB
{
	mediump mat3 mA;
	mediump float mB;
	lowp mat3 mC;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	bvec2 a;
};
layout(std430, column_major, binding = 2) readonly buffer BlockC
{
	sA b[];
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	lowp mat4x3 c;
	sB d;
	mediump float e[];
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	highp ivec4 f;
	mediump int g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((a), bvec2(true, true)) && allOk;
	allOk = compare_mat2(blockC.b[0].mA, mat2(-6.0, 8.0, -6.0, -1.0)) && allOk;
	allOk = compare_ivec3((blockC.b[0].mB), ivec3(3, -4, 1)) && allOk;
	allOk = compare_uint((blockC.b[0].mC), 6u) && allOk;
	allOk = compare_mat2(blockC.b[1].mA, mat2(-6.0, 3.0, -7.0, 9.0)) && allOk;
	allOk = compare_ivec3((blockC.b[1].mB), ivec3(9, -1, -9)) && allOk;
	allOk = compare_uint((blockC.b[1].mC), 8u) && allOk;
	allOk = compare_mat2(blockC.b[2].mA, mat2(3.0, -3.0, 3.0, 1.0)) && allOk;
	allOk = compare_ivec3((blockC.b[2].mB), ivec3(-8, -3, 3)) && allOk;
	allOk = compare_uint((blockC.b[2].mC), 6u) && allOk;
	allOk = compare_mat2(blockC.b[3].mA, mat2(7.0, -5.0, -4.0, -9.0)) && allOk;
	allOk = compare_ivec3((blockC.b[3].mB), ivec3(2, -6, 9)) && allOk;
	allOk = compare_uint((blockC.b[3].mC), 5u) && allOk;
	allOk = compare_float((blockD.e[0]), 7.0) && allOk;
	allOk = compare_float((blockD.e[1]), 0.0) && allOk;
	allOk = compare_float((blockD.e[2]), 3.0) && allOk;
	allOk = compare_float((blockD.e[3]), -3.0) && allOk;
	allOk = compare_float((blockD.e[4]), -3.0) && allOk;
	allOk = compare_float((blockD.e[5]), -3.0) && allOk;
	allOk = compare_int((g[0]), 1) && allOk;
	allOk = compare_int((g[1]), -6) && allOk;
	allOk = compare_int((g[2]), -3) && allOk;
	allOk = compare_int((g[3]), 4) && allOk;
	allOk = compare_int((g[4]), 5) && allOk;
	allOk = compare_int((g[5]), -4) && allOk;
	allOk = compare_int((g[6]), 8) && allOk;
	allOk = compare_int((g[7]), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec2(true, false));
	blockD.e[0] = (7.0);
	blockD.e[1] = (4.0);
	blockD.e[2] = (7.0);
	blockD.e[3] = (-2.0);
	blockD.e[4] = (6.0);
	blockD.e[5] = (5.0);
	f = (ivec4(-8, 2, -3, -9));
}
#version 450
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
	mediump vec4 mB;
};
struct sB
{
	highp mat4x2 mA;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	sA a;
	bool b[];
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	lowp uvec3 c;
	lowp mat3 d;
	sB e;
	mediump mat3x2 f[];
} blockC[3];
layout(scalar, row_major, binding = 3) buffer BlockD
{
	bvec3 g;
	bvec3 h;
	lowp mat2 i[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((a.mA), vec2(2.0, -4.0)) && allOk;
	allOk = compare_vec4((a.mB), vec4(-7.0, 7.0, 6.0, 2.0)) && allOk;
	allOk = compare_bool((b[0]), true) && allOk;
	allOk = compare_bool((b[1]), false) && allOk;
	allOk = compare_bool((b[2]), true) && allOk;
	allOk = compare_bool((b[3]), false) && allOk;
	allOk = compare_bool((b[4]), false) && allOk;
	allOk = compare_bool((b[5]), true) && allOk;
	allOk = compare_bool((b[6]), false) && allOk;
	allOk = compare_mat4x2(blockC[0].e.mA, mat4x2(2.0, -6.0, 2.0, 7.0, 8.0, -4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].e.mA, mat4x2(-3.0, 3.0, 4.0, 9.0, 0.0, -3.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockC[2].e.mA, mat4x2(4.0, 2.0, -8.0, -6.0, -2.0, 4.0, -1.0, 3.0)) && allOk;
	allOk = compare_bvec3((blockD.g), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockD.h), bvec3(false, false, true)) && allOk;
	allOk = compare_mat2(blockD.i[0], mat2(-9.0, 8.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(blockD.i[1], mat2(-3.0, -8.0, 3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = (vec2(-1.0, 9.0));
	a.mB = (vec4(1.0, 3.0, 5.0, -9.0));
	b[0] = (false);
	b[1] = (false);
	b[2] = (true);
	b[3] = (true);
	b[4] = (true);
	b[5] = (false);
	b[6] = (true);
	blockC[0].c = (uvec3(5u, 8u, 8u));
	blockC[0].e.mA = (mat4x2(2.0, 5.0, -5.0, -3.0, 3.0, 8.0, -3.0, -5.0));
	blockC[1].c = (uvec3(4u, 6u, 2u));
	blockC[1].e.mA = (mat4x2(7.0, -8.0, 4.0, 1.0, 2.0, -3.0, -9.0, 2.0));
	blockC[2].c = (uvec3(2u, 7u, 5u));
	blockC[2].e.mA = (mat4x2(-3.0, -5.0, 5.0, -2.0, 7.0, 4.0, -7.0, -3.0));
	blockD.g = (bvec3(true, false, false));
}
#version 450
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
	mediump uvec2 a;
	mediump mat2 b;
	lowp mat4x3 c;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].a), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].a), uvec2(9u, 7u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(2)].a), uvec2(2u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (uvec2(3u, 5u));
	blockB[nonuniformEXT(0)].b = (mat2(-1.0, 8.0, 9.0, -4.0));
	blockB[nonuniformEXT(0)].c = (mat4x3(-2.0, 9.0, -9.0, 3.0, -8.0, -9.0, -4.0, -3.0, 2.0, 4.0, 5.0, 8.0));
	blockB[nonuniformEXT(1)].a = (uvec2(1u, 3u));
	blockB[nonuniformEXT(1)].b = (mat2(4.0, -5.0, -5.0, -9.0));
	blockB[nonuniformEXT(1)].c = (mat4x3(-7.0, 7.0, -8.0, 8.0, -9.0, 1.0, 1.0, 7.0, 4.0, 5.0, 4.0, 8.0));
	blockB[nonuniformEXT(2)].a = (uvec2(0u, 4u));
	blockB[nonuniformEXT(2)].b = (mat2(5.0, 7.0, -8.0, -8.0));
	blockB[nonuniformEXT(2)].c = (mat4x3(1.0, 1.0, 2.0, -5.0, -9.0, 6.0, -9.0, 0.0, 1.0, -7.0, -8.0, 4.0));
}
#version 450
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
	uint16_t a;
	uint16_t b;
	bool c;
	mediump uint d;
};
layout(std140, binding = 2) buffer BlockC
{
	bool e;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(a), 7u) && allOk;
	allOk = compare_uint16_t(uint(b), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = uint16_t(7u);
	b = uint16_t(5u);
	c = (false);
	d = (4u);
	e = (false);
}
#version 450
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
	highp uvec3 a;
	f16vec4 b;
	highp ivec3 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((a), uvec3(6u, 7u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec3(6u, 4u, 7u));
	b = f16vec4(vec4(1.0, -7.0, -3.0, -7.0));
	c = (ivec3(9, -9, 8));
}
#version 450
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
	lowp vec4 a;
	highp mat2x3 b;
	uint16_t c;
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp ivec4 d;
	i16vec3 e[3];
	float16_t f;
};
layout(std140, binding = 3) readonly buffer BlockD
{
	u16vec4 g;
} blockD;
layout(std140, row_major, binding = 4) readonly buffer BlockE
{
	lowp mat3x2 h;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(b, mat2x3(-1.0, -3.0, -2.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_ivec4((d), ivec4(-3, 2, -3, 8)) && allOk;
	allOk = compare_float16_t(float(f), 7.0) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.g), uvec4(4u, 3u, 0u, 3u)) && allOk;
	allOk = compare_mat3x2(blockE.h, mat3x2(9.0, -8.0, 7.0, 6.0, -2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(-7.0, 4.0, -4.0, -7.0));
	b = (mat2x3(-3.0, 1.0, 8.0, -9.0, 2.0, -2.0));
	c = uint16_t(6u);
	e[0] = i16vec3(ivec3(-7, 3, 1));
	e[1] = i16vec3(ivec3(2, -4, -6));
	e[2] = i16vec3(ivec3(7, 1, 9));
}
#version 450
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
	i16vec2 a[][7];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp mat2x3 b;
	int16_t c;
	highp vec4 d[6];
	uint16_t e;
	mediump uint f[];
};
layout(std140, binding = 3) buffer BlockD
{
	mediump vec3 g[4];
	float16_t h;
	i16vec4 i;
	uint16_t j;
};
layout(std140, row_major, binding = 4) buffer BlockE
{
	uint16_t k;
	uint16_t l;
	uint16_t m;
	lowp vec2 n;
	highp float o[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.a[0][0]), ivec2(4, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[0][1]), ivec2(1, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[0][2]), ivec2(1, 9)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[0][3]), ivec2(-6, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[0][4]), ivec2(2, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[0][5]), ivec2(6, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[0][6]), ivec2(-9, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[1][0]), ivec2(-5, -8)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[1][1]), ivec2(7, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[1][2]), ivec2(-1, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[1][3]), ivec2(-2, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[1][4]), ivec2(4, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[1][5]), ivec2(-4, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[1][6]), ivec2(8, 3)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[2][0]), ivec2(9, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[2][1]), ivec2(9, 7)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[2][2]), ivec2(-5, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[2][3]), ivec2(7, 3)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[2][4]), ivec2(-6, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[2][5]), ivec2(-3, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.a[2][6]), ivec2(-5, 8)) && allOk;
	allOk = compare_mat2x3(b, mat2x3(-3.0, 6.0, -1.0, -3.0, -6.0, 7.0)) && allOk;
	allOk = compare_int16_t(int(c), 6) && allOk;
	allOk = compare_vec4((d[0]), vec4(-7.0, 2.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec4((d[1]), vec4(3.0, 1.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec4((d[2]), vec4(7.0, -7.0, 6.0, -6.0)) && allOk;
	allOk = compare_vec4((d[3]), vec4(-6.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_vec4((d[4]), vec4(7.0, 4.0, 1.0, 0.0)) && allOk;
	allOk = compare_vec4((d[5]), vec4(2.0, -7.0, -7.0, 9.0)) && allOk;
	allOk = compare_uint16_t(uint(e), 1u) && allOk;
	allOk = compare_uint((f[0]), 7u) && allOk;
	allOk = compare_uint((f[1]), 4u) && allOk;
	allOk = compare_uint((f[2]), 0u) && allOk;
	allOk = compare_uint((f[3]), 4u) && allOk;
	allOk = compare_uint((f[4]), 1u) && allOk;
	allOk = compare_vec3((g[0]), vec3(8.0, -2.0, 7.0)) && allOk;
	allOk = compare_vec3((g[1]), vec3(-6.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec3((g[2]), vec3(2.0, 9.0, -4.0)) && allOk;
	allOk = compare_vec3((g[3]), vec3(1.0, 0.0, 3.0)) && allOk;
	allOk = compare_float16_t(float(h), 9.0) && allOk;
	allOk = compare_i16vec4(ivec4(i), ivec4(-7, -8, 6, 9)) && allOk;
	allOk = compare_uint16_t(uint(j), 3u) && allOk;
	allOk = compare_uint16_t(uint(k), 0u) && allOk;
	allOk = compare_uint16_t(uint(l), 2u) && allOk;
	allOk = compare_uint16_t(uint(m), 5u) && allOk;
	allOk = compare_float((o[0]), 2.0) && allOk;
	allOk = compare_float((o[1]), -7.0) && allOk;
	allOk = compare_float((o[2]), 5.0) && allOk;
	allOk = compare_float((o[3]), -7.0) && allOk;
	allOk = compare_float((o[4]), -7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0][0] = i16vec2(ivec2(5, 7));
	blockB.a[0][1] = i16vec2(ivec2(-9, -6));
	blockB.a[0][2] = i16vec2(ivec2(1, -2));
	blockB.a[0][3] = i16vec2(ivec2(-1, -3));
	blockB.a[0][4] = i16vec2(ivec2(-9, -9));
	blockB.a[0][5] = i16vec2(ivec2(-2, -4));
	blockB.a[0][6] = i16vec2(ivec2(-4, 3));
	blockB.a[1][0] = i16vec2(ivec2(4, 9));
	blockB.a[1][1] = i16vec2(ivec2(1, 2));
	blockB.a[1][2] = i16vec2(ivec2(-6, 5));
	blockB.a[1][3] = i16vec2(ivec2(9, 2));
	blockB.a[1][4] = i16vec2(ivec2(-1, -7));
	blockB.a[1][5] = i16vec2(ivec2(3, -7));
	blockB.a[1][6] = i16vec2(ivec2(-5, 7));
	blockB.a[2][0] = i16vec2(ivec2(5, 5));
	blockB.a[2][1] = i16vec2(ivec2(7, -3));
	blockB.a[2][2] = i16vec2(ivec2(2, -2));
	blockB.a[2][3] = i16vec2(ivec2(9, 5));
	blockB.a[2][4] = i16vec2(ivec2(7, -5));
	blockB.a[2][5] = i16vec2(ivec2(9, -3));
	blockB.a[2][6] = i16vec2(ivec2(8, -3));
	b = (mat2x3(7.0, -4.0, -9.0, -2.0, 9.0, 7.0));
	c = int16_t(8);
	d[0] = (vec4(-1.0, 5.0, -4.0, 9.0));
	d[1] = (vec4(-2.0, -5.0, -8.0, -4.0));
	d[2] = (vec4(0.0, 8.0, 2.0, 6.0));
	d[3] = (vec4(3.0, -7.0, -9.0, -2.0));
	d[4] = (vec4(-9.0, 9.0, 7.0, 0.0));
	d[5] = (vec4(2.0, 3.0, -4.0, -9.0));
	f[0] = (6u);
	f[1] = (6u);
	f[2] = (3u);
	f[3] = (2u);
	f[4] = (9u);
	g[0] = (vec3(-6.0, 9.0, -8.0));
	g[1] = (vec3(4.0, 4.0, 7.0));
	g[2] = (vec3(-6.0, 7.0, -9.0));
	g[3] = (vec3(-2.0, 3.0, -8.0));
	h = float16_t(-8.0);
	i = i16vec4(ivec4(9, 5, 1, -5));
	j = uint16_t(9u);
	k = uint16_t(5u);
	l = uint16_t(5u);
	m = uint16_t(2u);
	n = (vec2(6.0, 3.0));
	o[0] = (8.0);
	o[1] = (-7.0);
	o[2] = (2.0);
	o[3] = (8.0);
	o[4] = (-4.0);
}
#version 450
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
	f16vec4 a[1];
	lowp vec2 b;
	bvec2 c;
	f16vec2 d[];
} blockB[1];

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

layout(std140, column_major, binding = 1) buffer BlockB
{
	float16_t a;
	lowp float b;
	i16vec2 c;
	i16vec4 d;
	lowp uvec3 e[];
} blockB;
layout(std140, column_major, binding = 2) readonly buffer BlockC
{
	mediump mat4 f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), -9.0) && allOk;
	allOk = compare_float((blockB.b), 9.0) && allOk;
	allOk = compare_uvec3((blockB.e[0]), uvec3(8u, 2u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (-3.0);
	blockB.c = i16vec2(ivec2(8, 0));
	blockB.e[0] = (uvec3(9u, 4u, 3u));
}
#version 450
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
	mediump ivec3 a;
	lowp mat3 b[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	u16vec3 c;
	f16vec3 d;
	mediump uvec2 e;
	int16_t f;
	u16vec3 g[];
} blockC[2];
layout(std140, column_major, binding = 3) buffer BlockD
{
	bool h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(4, -1, 1)) && allOk;
	allOk = compare_mat3(blockB.b[0], mat3(6.0, -6.0, -9.0, 1.0, -4.0, 6.0, 9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB.b[1], mat3(-9.0, -8.0, -1.0, -6.0, 7.0, -1.0, -5.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB.b[2], mat3(-7.0, -4.0, 3.0, 4.0, -1.0, 9.0, 6.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3(blockB.b[3], mat3(9.0, -9.0, -6.0, 7.0, 7.0, -5.0, -5.0, 3.0, -3.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].c), uvec3(2u, 7u, 9u)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[0].d), vec3(-3.0, 6.0, -1.0)) && allOk;
	allOk = compare_uvec2((blockC[0].e), uvec2(2u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].g[0]), uvec3(9u, 7u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].g[1]), uvec3(3u, 2u, 7u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].g[2]), uvec3(1u, 7u, 7u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].g[3]), uvec3(0u, 7u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].g[4]), uvec3(4u, 5u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].g[5]), uvec3(9u, 9u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].g[6]), uvec3(6u, 2u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[0].g[7]), uvec3(3u, 2u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].c), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[1].d), vec3(5.0, -5.0, 6.0)) && allOk;
	allOk = compare_uvec2((blockC[1].e), uvec2(1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].g[0]), uvec3(1u, 3u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].g[1]), uvec3(5u, 7u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].g[2]), uvec3(9u, 3u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].g[3]), uvec3(2u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].g[4]), uvec3(1u, 5u, 6u)) && allOk;
	allOk = compare_bool((h[0]), false) && allOk;
	allOk = compare_bool((h[1]), true) && allOk;
	allOk = compare_bool((h[2]), false) && allOk;
	allOk = compare_bool((h[3]), false) && allOk;
	allOk = compare_bool((h[4]), true) && allOk;
	allOk = compare_bool((h[5]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat3(-6.0, -1.0, -9.0, 1.0, -3.0, -2.0, -2.0, -9.0, -4.0));
	blockB.b[1] = (mat3(-4.0, 9.0, -6.0, 3.0, 1.0, 5.0, 4.0, 2.0, 9.0));
	blockB.b[2] = (mat3(2.0, 3.0, 7.0, -1.0, -7.0, 5.0, -7.0, -5.0, 5.0));
	blockB.b[3] = (mat3(7.0, -2.0, 7.0, -3.0, 9.0, -5.0, 2.0, 5.0, 9.0));
	blockC[0].c = u16vec3(uvec3(8u, 4u, 7u));
	blockC[0].d = f16vec3(vec3(7.0, -4.0, -9.0));
	blockC[0].e = (uvec2(7u, 1u));
	blockC[0].f = int16_t(7);
	blockC[0].g[0] = u16vec3(uvec3(0u, 1u, 0u));
	blockC[0].g[1] = u16vec3(uvec3(6u, 3u, 9u));
	blockC[0].g[2] = u16vec3(uvec3(6u, 7u, 6u));
	blockC[0].g[3] = u16vec3(uvec3(5u, 6u, 2u));
	blockC[0].g[4] = u16vec3(uvec3(8u, 5u, 7u));
	blockC[0].g[5] = u16vec3(uvec3(3u, 5u, 1u));
	blockC[0].g[6] = u16vec3(uvec3(9u, 2u, 5u));
	blockC[0].g[7] = u16vec3(uvec3(7u, 2u, 7u));
	blockC[1].c = u16vec3(uvec3(4u, 0u, 6u));
	blockC[1].d = f16vec3(vec3(-2.0, -3.0, 3.0));
	blockC[1].e = (uvec2(9u, 5u));
	blockC[1].f = int16_t(9);
	blockC[1].g[0] = u16vec3(uvec3(7u, 8u, 8u));
	blockC[1].g[1] = u16vec3(uvec3(7u, 0u, 5u));
	blockC[1].g[2] = u16vec3(uvec3(3u, 0u, 3u));
	blockC[1].g[3] = u16vec3(uvec3(3u, 0u, 5u));
	blockC[1].g[4] = u16vec3(uvec3(2u, 2u, 6u));
	h[0] = (false);
	h[1] = (false);
	h[2] = (false);
	h[3] = (false);
	h[4] = (false);
	h[5] = (false);
}
#version 450
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
	mediump vec3 mB;
	lowp mat3x4 mC;
	i16vec2 mD;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	u16vec3 a;
	highp uvec2 b;
	sA c;
	mediump ivec3 d[][3];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	i16vec4 e;
	int16_t f[];
} blockC;
layout(std140, row_major, binding = 3) readonly buffer BlockD
{
	bool g;
	bool h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB.a), uvec3(7u, 0u, 1u)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(9u, 0u)) && allOk;
	allOk = compare_vec4((blockB.c.mA), vec4(4.0, 6.0, 4.0, 8.0)) && allOk;
	allOk = compare_vec3((blockB.c.mB), vec3(-1.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockB.c.mC, mat3x4(-9.0, -9.0, 1.0, 1.0, 5.0, -5.0, 6.0, -8.0, 3.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.c.mD), ivec2(-8, -7)) && allOk;
	allOk = compare_ivec3((blockB.d[0][0]), ivec3(9, 8, 8)) && allOk;
	allOk = compare_ivec3((blockB.d[0][1]), ivec3(8, 2, 0)) && allOk;
	allOk = compare_ivec3((blockB.d[0][2]), ivec3(3, 4, -7)) && allOk;
	allOk = compare_ivec3((blockB.d[1][0]), ivec3(-6, 1, 0)) && allOk;
	allOk = compare_ivec3((blockB.d[1][1]), ivec3(-5, 4, -1)) && allOk;
	allOk = compare_ivec3((blockB.d[1][2]), ivec3(6, 8, 4)) && allOk;
	allOk = compare_ivec3((blockB.d[2][0]), ivec3(3, 1, 6)) && allOk;
	allOk = compare_ivec3((blockB.d[2][1]), ivec3(6, 7, -6)) && allOk;
	allOk = compare_ivec3((blockB.d[2][2]), ivec3(-1, -6, 3)) && allOk;
	allOk = compare_ivec3((blockB.d[3][0]), ivec3(-1, -8, -3)) && allOk;
	allOk = compare_ivec3((blockB.d[3][1]), ivec3(9, -4, -8)) && allOk;
	allOk = compare_ivec3((blockB.d[3][2]), ivec3(4, 0, 9)) && allOk;
	allOk = compare_ivec3((blockB.d[4][0]), ivec3(1, -2, -2)) && allOk;
	allOk = compare_ivec3((blockB.d[4][1]), ivec3(8, -5, 3)) && allOk;
	allOk = compare_ivec3((blockB.d[4][2]), ivec3(6, 0, -6)) && allOk;
	allOk = compare_ivec3((blockB.d[5][0]), ivec3(-3, 8, -5)) && allOk;
	allOk = compare_ivec3((blockB.d[5][1]), ivec3(6, -7, 5)) && allOk;
	allOk = compare_ivec3((blockB.d[5][2]), ivec3(5, 7, 6)) && allOk;
	allOk = compare_ivec3((blockB.d[6][0]), ivec3(6, -8, 7)) && allOk;
	allOk = compare_ivec3((blockB.d[6][1]), ivec3(2, -2, 7)) && allOk;
	allOk = compare_ivec3((blockB.d[6][2]), ivec3(6, -5, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.e), ivec4(-7, 7, 8, -9)) && allOk;
	allOk = compare_int16_t(int(blockC.f[0]), -2) && allOk;
	allOk = compare_int16_t(int(blockC.f[1]), 5) && allOk;
	allOk = compare_int16_t(int(blockC.f[2]), 2) && allOk;
	allOk = compare_int16_t(int(blockC.f[3]), 0) && allOk;
	allOk = compare_int16_t(int(blockC.f[4]), 2) && allOk;
	allOk = compare_int16_t(int(blockC.f[5]), -4) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec2(4u, 1u));
	blockB.c.mA = (vec4(7.0, -3.0, 4.0, 3.0));
	blockB.c.mB = (vec3(-9.0, 5.0, 2.0));
	blockB.c.mC = (mat3x4(0.0, -9.0, -6.0, -4.0, 4.0, -8.0, -4.0, -6.0, 2.0, 9.0, 5.0, -4.0));
	blockB.c.mD = i16vec2(ivec2(-2, -8));
	blockC.e = i16vec4(ivec4(-7, -4, -8, 6));
}
#version 450
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
	highp ivec3 mB;
	uint16_t mC;
	lowp ivec4 mD;
};
struct sB
{
	uint16_t mA[4];
	highp mat4x2 mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	sA a;
	highp mat2 b;
	highp uint c;
	i16vec3 d;
	bool e;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	sB f;
	int16_t g;
	mediump mat4 h;
	highp vec3 i;
	highp int j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(b, mat2(6.0, 2.0, 8.0, -6.0)) && allOk;
	allOk = compare_i16vec3(ivec3(d), ivec3(6, -4, 2)) && allOk;
	allOk = compare_uint16_t(uint(f.mA[0]), 0u) && allOk;
	allOk = compare_uint16_t(uint(f.mA[1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(f.mA[2]), 6u) && allOk;
	allOk = compare_uint16_t(uint(f.mA[3]), 4u) && allOk;
	allOk = compare_mat4x2(f.mB, mat4x2(1.0, 6.0, 2.0, 7.0, 7.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_int16_t(int(g), -2) && allOk;
	allOk = compare_mat4(h, mat4(-9.0, -1.0, -1.0, 5.0, 4.0, 8.0, -7.0, 9.0, 0.0, 0.0, 9.0, -9.0, 1.0, 7.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = (bvec4(true, false, true, false));
	a.mB = (ivec3(-5, 2, -5));
	a.mC = uint16_t(7u);
	a.mD = (ivec4(0, 7, 4, -9));
	e = (true);
	f.mA[0] = uint16_t(4u);
	f.mA[1] = uint16_t(5u);
	f.mA[2] = uint16_t(1u);
	f.mA[3] = uint16_t(4u);
	f.mB = (mat4x2(1.0, 0.0, 3.0, -9.0, 0.0, 9.0, -9.0, 3.0));
	g = int16_t(3);
	i = (vec3(-6.0, 3.0, -4.0));
}
#version 450
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
	layout(offset = 0) uint16_t a;
	layout(offset = 4) highp vec2 b;
	layout(offset = 12) mediump float c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(a), 3u) && allOk;
	allOk = compare_vec2((b), vec2(7.0, -8.0)) && allOk;
	allOk = compare_float((c), 7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = uint16_t(9u);
}
#version 450
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
layout(scalar, column_major, binding = 1) buffer BlockB
{
	lowp uvec4 a;
	mediump uvec2 b[4];
	sB c[][3];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	i16vec4 d[][8];
};
layout(scalar, binding = 3) buffer BlockD
{
	bvec3 e;
	highp vec2 f;
	mediump uint g;
	u16vec3 h[];
};
layout(scalar, column_major, binding = 4) buffer BlockE
{
	mediump uvec2 i[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
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
	allOk = compare_i16vec4(ivec4(d[0][0]), ivec4(-2, 1, 6, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(d[0][1]), ivec4(-1, -4, 1, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(d[0][2]), ivec4(4, -6, 3, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(d[0][3]), ivec4(2, -6, 4, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(d[0][4]), ivec4(8, 6, 2, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(d[0][5]), ivec4(-5, -5, -3, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(d[0][6]), ivec4(4, 9, -5, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(d[0][7]), ivec4(-8, 7, 9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(d[1][0]), ivec4(2, 1, -7, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(d[1][1]), ivec4(-2, -7, 0, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(d[1][2]), ivec4(1, 8, -6, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(d[1][3]), ivec4(-2, -4, -3, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(d[1][4]), ivec4(-3, -7, 3, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(d[1][5]), ivec4(3, -9, 4, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(d[1][6]), ivec4(3, 7, -4, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(d[1][7]), ivec4(-6, -3, 4, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(d[2][0]), ivec4(9, -5, 6, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(d[2][1]), ivec4(-1, -9, -4, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(d[2][2]), ivec4(-1, -5, 5, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(d[2][3]), ivec4(6, 2, -9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(d[2][4]), ivec4(-1, 3, -3, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(d[2][5]), ivec4(7, 7, 2, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(d[2][6]), ivec4(1, 3, -6, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(d[2][7]), ivec4(-9, 7, -4, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(d[3][0]), ivec4(5, -5, 7, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(d[3][1]), ivec4(-8, -7, 5, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(d[3][2]), ivec4(-6, 5, 8, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(d[3][3]), ivec4(-4, -5, -5, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(d[3][4]), ivec4(-2, -8, 1, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(d[3][5]), ivec4(-2, -7, 7, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(d[3][6]), ivec4(7, 7, 8, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(d[3][7]), ivec4(8, -6, 1, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(d[4][0]), ivec4(-1, -9, 6, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(d[4][1]), ivec4(5, -2, 9, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(d[4][2]), ivec4(-8, -9, -9, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(d[4][3]), ivec4(8, -4, 2, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(d[4][4]), ivec4(9, -1, 4, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(d[4][5]), ivec4(-7, 8, -6, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(d[4][6]), ivec4(-8, 6, 8, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(d[4][7]), ivec4(0, -9, 1, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(d[5][0]), ivec4(0, -6, -3, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(d[5][1]), ivec4(-1, 1, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(d[5][2]), ivec4(1, 4, -5, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(d[5][3]), ivec4(-6, -8, 9, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(d[5][4]), ivec4(2, 9, 5, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(d[5][5]), ivec4(4, -7, 9, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(d[5][6]), ivec4(-4, 9, -3, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(d[5][7]), ivec4(4, 7, 1, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(d[6][0]), ivec4(1, 9, 7, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(d[6][1]), ivec4(8, 7, -8, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(d[6][2]), ivec4(-5, 0, -2, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(7u, 5u, 2u, 6u));
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
	d[0][0] = i16vec4(ivec4(8, 0, -5, -8));
	d[0][1] = i16vec4(ivec4(7, -3, -5, -2));
	d[0][2] = i16vec4(ivec4(1, -7, 1, 7));
	d[0][3] = i16vec4(ivec4(-8, -9, -4, 7));
	d[0][4] = i16vec4(ivec4(-9, 4, -6, 5));
	d[0][5] = i16vec4(ivec4(-1, -1, 0, -3));
	d[0][6] = i16vec4(ivec4(-5, -6, 1, -8));
	d[0][7] = i16vec4(ivec4(2, -8, -2, 3));
	d[1][0] = i16vec4(ivec4(-1, -8, -9, -9));
	d[1][1] = i16vec4(ivec4(9, 1, -2, -1));
	d[1][2] = i16vec4(ivec4(9, -6, 5, 9));
	d[1][3] = i16vec4(ivec4(-8, 2, 3, 4));
	d[1][4] = i16vec4(ivec4(-2, -5, 4, -9));
	d[1][5] = i16vec4(ivec4(-8, 6, 4, -6));
	d[1][6] = i16vec4(ivec4(8, 9, 5, 4));
	d[1][7] = i16vec4(ivec4(6, -7, -1, -8));
	d[2][0] = i16vec4(ivec4(8, 7, 0, 0));
	d[2][1] = i16vec4(ivec4(7, 6, 1, 2));
	d[2][2] = i16vec4(ivec4(-9, 7, 1, -8));
	d[2][3] = i16vec4(ivec4(-8, -3, 6, 0));
	d[2][4] = i16vec4(ivec4(-1, -9, 8, -1));
	d[2][5] = i16vec4(ivec4(4, 2, -6, 4));
	d[2][6] = i16vec4(ivec4(8, 9, -4, 3));
	d[2][7] = i16vec4(ivec4(5, 0, 1, 6));
	d[3][0] = i16vec4(ivec4(-7, 6, 7, -8));
	d[3][1] = i16vec4(ivec4(8, 0, -8, 0));
	d[3][2] = i16vec4(ivec4(-1, 2, 2, 4));
	d[3][3] = i16vec4(ivec4(0, 4, 1, -7));
	d[3][4] = i16vec4(ivec4(-3, 5, 2, -4));
	d[3][5] = i16vec4(ivec4(-6, -7, 1, 5));
	d[3][6] = i16vec4(ivec4(-7, 1, 3, -6));
	d[3][7] = i16vec4(ivec4(1, 4, -9, 6));
	d[4][0] = i16vec4(ivec4(-6, -4, 9, -5));
	d[4][1] = i16vec4(ivec4(-8, -3, -5, 1));
	d[4][2] = i16vec4(ivec4(-5, -4, -8, -2));
	d[4][3] = i16vec4(ivec4(2, 6, -7, -1));
	d[4][4] = i16vec4(ivec4(6, 2, -7, 4));
	d[4][5] = i16vec4(ivec4(-7, 4, -2, -9));
	d[4][6] = i16vec4(ivec4(-9, -5, 0, 9));
	d[4][7] = i16vec4(ivec4(-4, -1, 7, 0));
	d[5][0] = i16vec4(ivec4(6, 1, 2, 0));
	d[5][1] = i16vec4(ivec4(5, 4, -2, -9));
	d[5][2] = i16vec4(ivec4(1, 4, -7, -6));
	d[5][3] = i16vec4(ivec4(4, 4, 6, 6));
	d[5][4] = i16vec4(ivec4(0, -5, -8, -6));
	d[5][5] = i16vec4(ivec4(0, 5, -5, -9));
	d[5][6] = i16vec4(ivec4(-6, 9, 8, 0));
	d[5][7] = i16vec4(ivec4(1, 8, -8, -2));
	d[6][0] = i16vec4(ivec4(-2, -2, 9, 3));
	d[6][1] = i16vec4(ivec4(-1, -1, -4, 7));
	d[6][2] = i16vec4(ivec4(-9, 8, 0, -1));
	d[6][3] = i16vec4(ivec4(9, -2, -1, 1));
	d[6][4] = i16vec4(ivec4(2, 2, -6, -4));
	d[6][5] = i16vec4(ivec4(1, -2, 5, -4));
	d[6][6] = i16vec4(ivec4(-8, -7, -9, -7));
	d[6][7] = i16vec4(ivec4(-9, 5, -9, -1));
	d[7][0] = i16vec4(ivec4(3, 7, 3, 5));
	d[7][1] = i16vec4(ivec4(-1, -9, -9, -9));
	d[7][2] = i16vec4(ivec4(3, 7, 9, -9));
	d[7][3] = i16vec4(ivec4(9, 1, -2, -9));
	d[7][4] = i16vec4(ivec4(-3, 6, -5, 9));
	d[7][5] = i16vec4(ivec4(-1, 8, 9, -6));
	d[7][6] = i16vec4(ivec4(-2, -4, 5, 2));
	d[7][7] = i16vec4(ivec4(6, 0, 8, 6));
	e = (bvec3(false, true, false));
	g = (9u);
	h[0] = u16vec3(uvec3(2u, 3u, 1u));
	h[1] = u16vec3(uvec3(4u, 7u, 7u));
	h[2] = u16vec3(uvec3(5u, 4u, 5u));
	h[3] = u16vec3(uvec3(9u, 9u, 1u));
	h[4] = u16vec3(uvec3(2u, 0u, 8u));
	h[5] = u16vec3(uvec3(9u, 3u, 8u));
	h[6] = u16vec3(uvec3(3u, 3u, 7u));
	blockE.i[0] = (uvec2(4u, 4u));
	blockE.i[1] = (uvec2(3u, 9u));
	blockE.i[2] = (uvec2(7u, 1u));
	blockE.i[3] = (uvec2(2u, 7u));
	blockE.i[4] = (uvec2(7u, 0u));
	blockE.i[5] = (uvec2(1u, 0u));
	blockE.i[6] = (uvec2(0u, 6u));
	blockE.i[7] = (uvec2(7u, 6u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(row_major, binding = 1) buffer BlockB
{
	layout(offset = 0) lowp uvec3 a[1];
	layout(offset = 16) highp mat4 b;
	layout(offset = 80) f16vec4 c;
	layout(offset = 88) highp vec2 d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[nonuniformEXT(0)].a[0]), uvec3(3u, 1u, 9u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(0)].c), vec4(5.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].d), vec2(-7.0, 0.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(1)].a[0]), uvec3(6u, 5u, 0u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(1)].c), vec4(3.0, 6.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].d), vec2(-1.0, -5.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(2)].a[0]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(2)].c), vec4(-6.0, -2.0, 2.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].d), vec2(1.0, -1.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(3)].a[0]), uvec3(3u, 3u, 1u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(3)].c), vec4(3.0, 0.0, -6.0, 2.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(3)].d), vec2(-8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (mat4(-7.0, 6.0, 5.0, 0.0, -8.0, -5.0, 2.0, 9.0, 8.0, -5.0, -4.0, 3.0, 4.0, -7.0, -8.0, 1.0));
	blockB[nonuniformEXT(0)].d = (vec2(9.0, 3.0));
	blockB[nonuniformEXT(1)].b = (mat4(5.0, 5.0, 4.0, 7.0, -2.0, 0.0, -9.0, -1.0, -7.0, -1.0, -1.0, -7.0, -2.0, 5.0, -1.0, 7.0));
	blockB[nonuniformEXT(1)].d = (vec2(5.0, 8.0));
	blockB[nonuniformEXT(2)].b = (mat4(-1.0, -2.0, -3.0, -1.0, 2.0, -8.0, 3.0, -1.0, -8.0, 1.0, -6.0, 1.0, -1.0, -7.0, 1.0, 2.0));
	blockB[nonuniformEXT(2)].d = (vec2(-2.0, 8.0));
	blockB[nonuniformEXT(3)].b = (mat4(3.0, 5.0, 2.0, 9.0, 1.0, -1.0, -7.0, -6.0, -5.0, 0.0, -7.0, -8.0, -2.0, -2.0, -7.0, 6.0));
	blockB[nonuniformEXT(3)].d = (vec2(-9.0, 9.0));
}
#version 450
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
	int8_t a[1];
	mediump float b;
	highp uint c[1];
	highp float d;
	highp uint e;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	bool f;
	mediump int g[1];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	uint8_t h;
	bool i[1];
	highp uint j;
	uint8_t k;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), -1.0) && allOk;
	allOk = compare_uint((blockB.c[0]), 3u) && allOk;
	allOk = compare_float((blockB.d), 6.0) && allOk;
	allOk = compare_bool((blockC.f), false) && allOk;
	allOk = compare_uint8_t(uint(blockD.h), 1u) && allOk;
	allOk = compare_bool((blockD.i[0]), false) && allOk;
	allOk = compare_uint8_t(uint(blockD.k), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = (2u);
	blockB.d = (-6.0);
	blockC.g[0] = (-3);
	blockD.h = uint8_t(9u);
	blockD.i[0] = (false);
	blockD.k = uint8_t(6u);
}
#version 450
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
	mediump uint a;
	mediump ivec3 b;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	lowp uvec4 c;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	mediump uvec3 d;
} blockD;

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 2u) && allOk;
	allOk = compare_ivec3((blockB.b), ivec3(-6, -5, 7)) && allOk;
	allOk = compare_uvec4((blockC.c), uvec4(5u, 7u, 9u, 2u)) && allOk;
	allOk = compare_uvec3((blockD.d), uvec3(0u, 4u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec3(7, 5, -2));
	blockC.c = (uvec4(4u, 8u, 4u, 7u));
	blockD.d = (uvec3(8u, 6u, 6u));
}
#version 450
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
	u8vec3 a;
	bvec3 b;
	highp vec3 c;
};
layout(std430, binding = 2) buffer BlockC
{
	u8vec3 d;
	mediump ivec2 e;
	lowp ivec3 f;
	lowp ivec2 g;
	highp ivec3 h;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	i8vec4 i;
	u8vec2 j;
	lowp float k;
	int8_t l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockC.d), uvec3(2u, 1u, 6u)) && allOk;
	allOk = compare_ivec2((blockC.e), ivec2(9, -3)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(-8, 6, 0)) && allOk;
	allOk = compare_ivec2((blockC.g), ivec2(-1, -3)) && allOk;
	allOk = compare_i8vec4(ivec4(i), ivec4(4294967289, 6, 9, 4294967295)) && allOk;
	allOk = compare_u8vec2(uvec2(j), uvec2(5u, 3u)) && allOk;
	allOk = compare_float((k), 1.0) && allOk;
	allOk = compare_int8_t(int(l), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (bvec3(false, true, true));
	c = (vec3(-6.0, -5.0, -2.0));
	blockC.d = u8vec3(uvec3(8u, 4u, 6u));
	blockC.e = (ivec2(-9, -3));
	blockC.f = (ivec3(-1, -9, 1));
	blockC.g = (ivec2(1, 7));
	i = i8vec4(ivec4(4294967295, 4294967290, 5, 6));
	k = (-6.0);
	l = int8_t(4294967287);
}
#version 450
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
	highp uvec4 a;
	u8vec4 b;
	highp ivec4 c;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((a), uvec4(6u, 7u, 4u, 4u)) && allOk;
	allOk = compare_ivec4((c), ivec4(2, 3, -6, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = u8vec4(uvec4(8u, 2u, 9u, 3u));
	c = (ivec4(-9, 8, 0, -8));
}
#version 450
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
	bvec2 a[];
};
layout(std430, column_major, binding = 2) readonly buffer BlockC
{
	mediump uvec3 b[][4];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((a[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((a[1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((a[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((a[3]), bvec2(false, false)) && allOk;
	allOk = compare_uvec3((b[0][0]), uvec3(4u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((b[0][1]), uvec3(0u, 5u, 9u)) && allOk;
	allOk = compare_uvec3((b[0][2]), uvec3(9u, 8u, 6u)) && allOk;
	allOk = compare_uvec3((b[0][3]), uvec3(8u, 1u, 2u)) && allOk;
	allOk = compare_uvec3((b[1][0]), uvec3(1u, 7u, 3u)) && allOk;
	allOk = compare_uvec3((b[1][1]), uvec3(1u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((b[1][2]), uvec3(5u, 3u, 6u)) && allOk;
	allOk = compare_uvec3((b[1][3]), uvec3(1u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((b[2][0]), uvec3(8u, 8u, 4u)) && allOk;
	allOk = compare_uvec3((b[2][1]), uvec3(3u, 8u, 9u)) && allOk;
	allOk = compare_uvec3((b[2][2]), uvec3(6u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((b[2][3]), uvec3(1u, 0u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
};
struct sB
{
	u8vec2 mA;
	mediump mat2 mB;
	u8vec4 mC;
	highp vec2 mD;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	sA a[6];
	sB b;
	highp mat4 c;
	i8vec4 d[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.d[0]), ivec4(5, 4294967290, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d[1]), ivec4(4294967293, 4294967293, 4294967294, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d[2]), ivec4(4294967289, 4294967287, 8, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA = (ivec4(7, -8, -6, -6));
	blockB.a[1].mA = (ivec4(3, 5, -1, 2));
	blockB.a[2].mA = (ivec4(9, 3, -7, -7));
	blockB.a[3].mA = (ivec4(4, 1, 7, -3));
	blockB.a[4].mA = (ivec4(-2, 4, -2, 3));
	blockB.a[5].mA = (ivec4(-7, 8, -6, 1));
	blockB.b.mA = u8vec2(uvec2(6u, 7u));
	blockB.b.mB = (mat2(0.0, 0.0, 7.0, -3.0));
	blockB.b.mC = u8vec4(uvec4(7u, 7u, 1u, 1u));
	blockB.b.mD = (vec2(5.0, -9.0));
	blockB.c = (mat4(6.0, -5.0, 7.0, -2.0, -6.0, 6.0, -3.0, 7.0, -2.0, 6.0, -2.0, -9.0, 6.0, -3.0, 5.0, -9.0));
	blockB.d[0] = i8vec4(ivec4(6, 3, 9, 4294967295));
	blockB.d[1] = i8vec4(ivec4(4294967290, 2, 8, 2));
	blockB.d[2] = i8vec4(ivec4(4294967291, 1, 8, 4294967289));
}
#version 450
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
	highp ivec2 a[8];
	mediump mat3x2 b[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a[0]), ivec2(2, -8)) && allOk;
	allOk = compare_ivec2((blockB.a[1]), ivec2(-4, 7)) && allOk;
	allOk = compare_ivec2((blockB.a[2]), ivec2(4, 0)) && allOk;
	allOk = compare_ivec2((blockB.a[3]), ivec2(-5, -8)) && allOk;
	allOk = compare_ivec2((blockB.a[4]), ivec2(-6, 4)) && allOk;
	allOk = compare_ivec2((blockB.a[5]), ivec2(5, 6)) && allOk;
	allOk = compare_ivec2((blockB.a[6]), ivec2(-6, 1)) && allOk;
	allOk = compare_ivec2((blockB.a[7]), ivec2(8, 1)) && allOk;
	allOk = compare_mat3x2(blockB.b[0], mat3x2(-7.0, 8.0, 7.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1], mat3x2(-8.0, 3.0, 6.0, -7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2], mat3x2(9.0, 1.0, -9.0, 3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[3], mat3x2(-3.0, -4.0, 8.0, 6.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[4], mat3x2(5.0, -5.0, 8.0, -1.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[5], mat3x2(9.0, 5.0, 7.0, -1.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[6], mat3x2(7.0, 7.0, -7.0, 6.0, -7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec2(8, -2));
	blockB.a[1] = (ivec2(-1, -6));
	blockB.a[2] = (ivec2(6, 0));
	blockB.a[3] = (ivec2(9, 5));
	blockB.a[4] = (ivec2(4, 8));
	blockB.a[5] = (ivec2(6, 7));
	blockB.a[6] = (ivec2(-5, 5));
	blockB.a[7] = (ivec2(-2, 7));
}
#version 450
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
	layout(offset = 2) u8vec2 b;
	layout(offset = 4) i8vec2 c[1];
	layout(offset = 6) int8_t d;
	layout(offset = 8) lowp uint e;
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp vec2 f;
	layout(offset = 16) highp ivec3 g;
	layout(offset = 32) lowp vec2 h;
	layout(offset = 40) lowp uvec2 i;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump uvec4 j;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump float k;
	layout(offset = 16) bvec4 l;
	layout(offset = 32) highp vec2 m;
	layout(offset = 48) mediump vec3 n[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB[0].a), ivec2(2, 4294967291)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[0].b), uvec2(4u, 4u)) && allOk;
	allOk = compare_int8_t(int(blockB[0].d), 4294967287) && allOk;
	allOk = compare_uint((blockB[0].e), 1u) && allOk;
	allOk = compare_vec2((f), vec2(2.0, 7.0)) && allOk;
	allOk = compare_ivec3((g), ivec3(-1, -2, 9)) && allOk;
	allOk = compare_uvec2((i), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec4((blockD.j), uvec4(6u, 6u, 5u, 0u)) && allOk;
	allOk = compare_float((k), -6.0) && allOk;
	allOk = compare_vec2((m), vec2(-7.0, -1.0)) && allOk;
	allOk = compare_vec3((n[0]), vec3(-3.0, 5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i8vec2(ivec2(8, 4294967288));
	blockB[0].b = u8vec2(uvec2(1u, 8u));
	blockB[0].c[0] = i8vec2(ivec2(4294967293, 5));
	blockB[0].d = int8_t(9);
	g = (ivec3(4, -8, 7));
	h = (vec2(-1.0, -6.0));
	blockD.j = (uvec4(0u, 3u, 2u, 1u));
	k = (-9.0);
	l = (bvec4(false, true, true, false));
	n[0] = (vec3(6.0, -4.0, 3.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, binding = 1) readonly buffer BlockB
{
	bvec4 a[];
};
layout(scalar, binding = 2) buffer BlockC
{
	mediump vec2 b;
} blockC[1];
layout(scalar, row_major, binding = 3) buffer BlockD
{
	u8vec3 c;
	highp vec2 d;
	highp uvec3 e[];
} blockD[2];
layout(scalar, row_major, binding = 4) buffer BlockE
{
	mediump uvec4 f;
	uint8_t g[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((a[0]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[0].c), uvec3(2u, 5u, 1u)) && allOk;
	allOk = compare_vec2((blockD[0].d), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[1].c), uvec3(2u, 9u, 7u)) && allOk;
	allOk = compare_vec2((blockD[1].d), vec2(3.0, -5.0)) && allOk;
	allOk = compare_uvec4((blockE.f), uvec4(3u, 3u, 6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b = (vec2(-7.0, 6.0));
	blockD[0].c = u8vec3(uvec3(2u, 4u, 4u));
	blockD[0].d = (vec2(3.0, -2.0));
	blockD[0].e[0] = (uvec3(2u, 5u, 6u));
	blockD[0].e[1] = (uvec3(0u, 2u, 1u));
	blockD[0].e[2] = (uvec3(9u, 4u, 8u));
	blockD[0].e[3] = (uvec3(0u, 4u, 7u));
	blockD[1].c = u8vec3(uvec3(4u, 2u, 3u));
	blockD[1].d = (vec2(9.0, -9.0));
	blockD[1].e[0] = (uvec3(5u, 2u, 3u));
	blockD[1].e[1] = (uvec3(1u, 2u, 8u));
	blockD[1].e[2] = (uvec3(5u, 4u, 7u));
	blockD[1].e[3] = (uvec3(4u, 3u, 5u));
	blockD[1].e[4] = (uvec3(1u, 6u, 7u));
	blockD[1].e[5] = (uvec3(9u, 0u, 8u));
	blockE.f = (uvec4(9u, 0u, 5u, 9u));
}
#version 450
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
	u8vec4 a;
	bvec4 b[][2][1];
};
layout(scalar, binding = 2) buffer BlockC
{
	highp vec4 c;
	bool d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((b[0][0][0]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((b[0][1][0]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((b[1][0][0]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((b[1][1][0]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_vec4((c), vec4(0.0, -3.0, -9.0, -2.0)) && allOk;
	allOk = compare_bool((d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec4(uvec4(5u, 3u, 7u, 2u));
	b[0][0][0] = (bvec4(false, false, false, true));
	b[0][1][0] = (bvec4(false, false, true, false));
	b[1][0][0] = (bvec4(false, true, false, false));
	b[1][1][0] = (bvec4(false, true, false, false));
	c = (vec4(-4.0, 3.0, 6.0, -4.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], -3.0) && allOk;
	allOk = compare_float(var[2][0], -8.0) && allOk;
	allOk = compare_float(var[2][1], -5.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-8.0, 4.0, 5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-7.0, -2.0, -3.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-8.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, column_major, binding = 1) readonly buffer Block
{
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 8.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[0][3], -9.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_float(var[1][3], -6.0) && allOk;
	allOk = compare_vec4(var[0], vec4(8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-3.0, -7.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	i8vec2 var;
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(var), ivec2(4294967288, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3(var, mat3(3.0, -5.0, 1.0, 4.0, 5.0, -2.0, 1.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(-3.0, -8.0, -3.0, -1.0, -7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(-7.0, -2.0, 6.0, 8.0, 5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[2][0], 9.0) && allOk;
	allOk = compare_float(var[2][1], -4.0) && allOk;
	allOk = compare_vec2(var[0], vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(6.0, 3.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(3.0, -5.0, -5.0, -3.0, 3.0, -1.0, 2.0, 2.0, -2.0, -8.0, -3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], 9.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[2][0], 8.0) && allOk;
	allOk = compare_float(var[2][1], 3.0) && allOk;
	allOk = compare_float(var[2][2], 0.0) && allOk;
	allOk = compare_float(var[3][0], 5.0) && allOk;
	allOk = compare_float(var[3][1], -1.0) && allOk;
	allOk = compare_float(var[3][2], -2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(9.0, 1.0, 9.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-1.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(8.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(5.0, -1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	uint8_t padding;
	u8vec3 var;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 4u) && allOk;
	allOk = compare_u8vec3(uvec3(var), uvec3(3u, 0u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat3(var[0], mat3(-4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(2.0, -3.0, -5.0, -8.0, -3.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-6.0, 9.0, 2.0, -1.0, 8.0, 0.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(-7.0, -3.0, 8.0, 0.0, -1.0, -5.0, 4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

layout(std140, binding = 1) readonly buffer Block
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

}
#version 450
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

}
#version 450
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
	allOk = compare_mat4(block.var, mat4(-9.0, 2.0, 5.0, 5.0, 7.0, -4.0, 0.0, 3.0, 4.0, -6.0, -8.0, 5.0, 5.0, 1.0, 4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(7.0, -8.0, -3.0, 9.0, -3.0, -5.0, -4.0, 4.0, 0.0, 3.0, 2.0, 1.0, 2.0, -4.0, -7.0, 7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], 5.0) && allOk;
	allOk = compare_float(block.var[1][1], 0.0) && allOk;
	allOk = compare_float(block.var[1][2], -1.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(1.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(5.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(3.0, 0.0, 3.0, 5.0, 3.0, -5.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(block.var, mat2x4(-7.0, -7.0, 7.0, -4.0, -5.0, -3.0, 1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(-4.0, 9.0, -1.0, 0.0, 4.0, -8.0, 1.0, 9.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -9.0) && allOk;
	allOk = compare_float(block.var[0][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], 8.0) && allOk;
	allOk = compare_float(block.var[2][1], 2.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-9.0, 5.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(6.0, -1.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(1.0, 2.0, 7.0, -2.0, 0.0, 7.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(6.0, 7.0, 5.0, -7.0, -7.0, -3.0, 8.0, 1.0, 2.0, 8.0, -1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(3.0, -7.0, -8.0, -2.0));
	block.var[1] = (vec4(6.0, 5.0, 7.0, 1.0));
	block.var[2] = (vec4(-9.0, -8.0, -7.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(-8.0, -1.0, -2.0, -5.0, -8.0, -3.0, 4.0, -5.0, -8.0, 3.0, 2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(5.0, 8.0, -6.0, 0.0));
	block.var[1] = (vec4(6.0, -2.0, 8.0, -8.0));
	block.var[2] = (vec4(4.0, -8.0, -3.0, -9.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(-7.0, 2.0, 0.0, 9.0, 8.0, 1.0, -1.0, 5.0, -1.0, 6.0, 8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-5.0, 3.0, -1.0, -4.0));
	block.var[1] = (vec4(4.0, 5.0, 9.0, -8.0));
	block.var[2] = (vec4(-7.0, -1.0, -4.0, 6.0));
}
#version 450
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
	bvec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((block.var), bvec4(true, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (bvec4(true, true, true, false));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(-6.0, -3.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-2.0, -9.0));
	block.var[1] = (vec2(5.0, 8.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
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
	allOk = compare_mat3(block.var, mat3(-4.0, 5.0, 1.0, 7.0, 4.0, -7.0, -4.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(-1.0, 7.0, 7.0, -3.0, -9.0, 7.0, 9.0, -5.0, 5.0));
}
#version 450
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
	allOk = compare_mat3(block.var, mat3(-9.0, 3.0, -5.0, 1.0, 4.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(-9.0, 5.0, 1.0, 3.0, 2.0, -5.0, 9.0, -3.0, -7.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(6.0, 7.0, 5.0, -7.0, -7.0, -3.0, 8.0, 1.0, 2.0, 8.0, -1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(3.0, -7.0, -8.0, -2.0));
	block.var[1] = (vec4(6.0, 5.0, 7.0, 1.0));
	block.var[2] = (vec4(-9.0, -8.0, -7.0, -3.0));
}
#version 450
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
	i16vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(block.var), ivec4(-6, -9, 9, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = i16vec4(ivec4(-4, -8, -4, 9));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_vec3((block.var), vec3(0.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var = (vec3(8.0, -1.0, 9.0));
}
#version 450
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
	lowp ivec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), -1) && allOk;
	allOk = compare_ivec2((block.var), ivec2(-7, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5);
	block.var = (ivec2(-9, -1));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(-9.0, 1.0, 3.0, -2.0, -4.0, -7.0, -6.0, 1.0, 8.0, 9.0, 8.0, 8.0, 9.0, 8.0, 8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var = (mat4(9.0, 2.0, -9.0, -4.0, -9.0, -7.0, -7.0, -2.0, -7.0, -3.0, -4.0, 1.0, 0.0, -9.0, -3.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_float(block.var[0][0], 4.0) && allOk;
	allOk = compare_float(block.var[0][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], -9.0) && allOk;
	allOk = compare_float(block.var[2][1], 9.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(4.0, -1.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-1.0, -5.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var = (mat3x2(-6.0, 0.0, -8.0, -3.0, 3.0, -5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_float(block.var[0][0], 8.0) && allOk;
	allOk = compare_float(block.var[0][1], 8.0) && allOk;
	allOk = compare_float(block.var[0][2], 9.0) && allOk;
	allOk = compare_float(block.var[0][3], 3.0) && allOk;
	allOk = compare_float(block.var[1][0], 7.0) && allOk;
	allOk = compare_float(block.var[1][1], -6.0) && allOk;
	allOk = compare_float(block.var[1][2], -1.0) && allOk;
	allOk = compare_float(block.var[1][3], -8.0) && allOk;
	allOk = compare_float(block.var[2][0], -9.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_float(block.var[2][2], -2.0) && allOk;
	allOk = compare_float(block.var[2][3], 2.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(8.0, 8.0, 9.0, 3.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(7.0, -6.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-9.0, 0.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var[0] = (vec4(7.0, 3.0, -3.0, 1.0));
	block.var[1] = (vec4(-4.0, 5.0, -8.0, -6.0));
	block.var[2] = (vec4(4.0, -1.0, -8.0, -5.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	block.var[1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	block.var[2] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
}
#version 450
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
	highp ivec4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((block.var[0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((block.var[1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((block.var[2]), ivec4(-3, -3, -5, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (ivec4(5, -9, 5, -6));
	block.var[1] = (ivec4(-2, -4, 1, -9));
	block.var[2] = (ivec4(7, 3, 6, 8));
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat4x2(block.var[0], mat4x2(6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8.0);
	block.var[0] = (mat4x2(-5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0, 6.0));
	block.var[1] = (mat4x2(3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0, 5.0));
	block.var[2] = (mat4x2(4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0, 6.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	highp uvec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block.var[0][0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[0][1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[0][2]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[1][0]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[1][1]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[1][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[2][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[2][1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[2][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[3][0]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[3][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[3][2]), uvec2(8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (uvec2(6u, 1u));
	block.var[0][1] = (uvec2(8u, 1u));
	block.var[0][2] = (uvec2(7u, 4u));
	block.var[1][0] = (uvec2(6u, 6u));
	block.var[1][1] = (uvec2(5u, 8u));
	block.var[1][2] = (uvec2(4u, 7u));
	block.var[2][0] = (uvec2(8u, 4u));
	block.var[2][1] = (uvec2(6u, 3u));
	block.var[2][2] = (uvec2(6u, 0u));
	block.var[3][0] = (uvec2(3u, 5u));
	block.var[3][1] = (uvec2(2u, 4u));
	block.var[3][2] = (uvec2(7u, 8u));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(-8.0, -1.0, -1.0, -6.0, 2.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(3.0, -9.0, 1.0, -9.0, 8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(1.0, -1.0, 0.0, 7.0, 2.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(2.0, 2.0, -8.0, 6.0, 0.0, -1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(-4.0, -2.0, -4.0, -6.0, -3.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(8.0, -7.0, 8.0, 8.0, 2.0, 3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(9.0, 0.0, -4.0, -7.0, -7.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(-3.0, -7.0, -5.0, -4.0, -1.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(7.0, 0.0, -6.0, -2.0, 9.0, -7.0, -6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	block.var[0][1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	block.var[0][2] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
	block.var[1][0] = (mat2x4(-3.0, 4.0, 7.0, -8.0, -6.0, -3.0, -2.0, -9.0));
	block.var[1][1] = (mat2x4(-6.0, 7.0, 6.0, -2.0, 2.0, 7.0, 4.0, -7.0));
	block.var[1][2] = (mat2x4(-8.0, 4.0, 3.0, -6.0, -9.0, -3.0, 5.0, -6.0));
	block.var[2][0] = (mat2x4(-5.0, 8.0, 2.0, 0.0, -9.0, 1.0, -2.0, -6.0));
	block.var[2][1] = (mat2x4(0.0, 6.0, 7.0, -2.0, -1.0, -3.0, -3.0, -9.0));
	block.var[2][2] = (mat2x4(7.0, -5.0, 9.0, -1.0, -1.0, 9.0, 0.0, 7.0));
	block.var[3][0] = (mat2x4(6.0, -8.0, -2.0, 3.0, 1.0, -8.0, -4.0, -9.0));
	block.var[3][1] = (mat2x4(-7.0, 0.0, -8.0, -1.0, 5.0, 7.0, 7.0, -3.0));
	block.var[3][2] = (mat2x4(1.0, -9.0, 2.0, -9.0, -3.0, 0.0, -4.0, 5.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(9.0, -9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(6.0, -4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(0.0, -5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-9.0, -1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(1.0, 2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(-8.0, 1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(-7.0, -6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(-5.0, -2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(2.0, -3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	block.var[0][1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	block.var[0][2] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
	block.var[1][0] = (mat2x4(-8.0, -9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0));
	block.var[1][1] = (mat2x4(-5.0, 8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0));
	block.var[1][2] = (mat2x4(-6.0, -7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0));
	block.var[2][0] = (mat2x4(0.0, -6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0));
	block.var[2][1] = (mat2x4(-5.0, 4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0));
	block.var[2][2] = (mat2x4(-4.0, -7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0));
	block.var[3][0] = (mat2x4(-1.0, 7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0));
	block.var[3][1] = (mat2x4(-5.0, 3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0));
	block.var[3][2] = (mat2x4(5.0, 7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(2.0, -4.0));
	block.var[0][0][1] = (vec2(-5.0, 3.0));
	block.var[0][0][2] = (vec2(7.0, 1.0));
	block.var[0][0][3] = (vec2(8.0, -5.0));
	block.var[0][1][0] = (vec2(7.0, -3.0));
	block.var[0][1][1] = (vec2(1.0, -6.0));
	block.var[0][1][2] = (vec2(9.0, -3.0));
	block.var[0][1][3] = (vec2(1.0, -5.0));
	block.var[0][2][0] = (vec2(-8.0, 4.0));
	block.var[0][2][1] = (vec2(5.0, -9.0));
	block.var[0][2][2] = (vec2(1.0, -5.0));
	block.var[0][2][3] = (vec2(-4.0, -2.0));
	block.var[1][0][0] = (vec2(6.0, -1.0));
	block.var[1][0][1] = (vec2(-7.0, -5.0));
	block.var[1][0][2] = (vec2(-2.0, -8.0));
	block.var[1][0][3] = (vec2(1.0, 3.0));
	block.var[1][1][0] = (vec2(4.0, 2.0));
	block.var[1][1][1] = (vec2(-9.0, 2.0));
	block.var[1][1][2] = (vec2(-3.0, 3.0));
	block.var[1][1][3] = (vec2(0.0, 1.0));
	block.var[1][2][0] = (vec2(-5.0, -9.0));
	block.var[1][2][1] = (vec2(2.0, -2.0));
	block.var[1][2][2] = (vec2(-3.0, 0.0));
	block.var[1][2][3] = (vec2(9.0, 6.0));
	block.var[2][0][0] = (vec2(3.0, -4.0));
	block.var[2][0][1] = (vec2(2.0, -3.0));
	block.var[2][0][2] = (vec2(6.0, 5.0));
	block.var[2][0][3] = (vec2(0.0, -2.0));
	block.var[2][1][0] = (vec2(-3.0, -2.0));
	block.var[2][1][1] = (vec2(-7.0, 3.0));
	block.var[2][1][2] = (vec2(-6.0, 2.0));
	block.var[2][1][3] = (vec2(9.0, 6.0));
	block.var[2][2][0] = (vec2(-4.0, 4.0));
	block.var[2][2][1] = (vec2(0.0, -3.0));
	block.var[2][2][2] = (vec2(-7.0, 0.0));
	block.var[2][2][3] = (vec2(-9.0, 1.0));
	block.var[3][0][0] = (vec2(7.0, 2.0));
	block.var[3][0][1] = (vec2(1.0, 9.0));
	block.var[3][0][2] = (vec2(-3.0, 3.0));
	block.var[3][0][3] = (vec2(-7.0, 9.0));
	block.var[3][1][0] = (vec2(-4.0, -1.0));
	block.var[3][1][1] = (vec2(3.0, 6.0));
	block.var[3][1][2] = (vec2(8.0, 3.0));
	block.var[3][1][3] = (vec2(1.0, 5.0));
	block.var[3][2][0] = (vec2(7.0, 0.0));
	block.var[3][2][1] = (vec2(0.0, -2.0));
	block.var[3][2][2] = (vec2(3.0, -7.0));
	block.var[3][2][3] = (vec2(-3.0, 1.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(0.0, -5.0, -8.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(8.0, 5.0, -3.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(-6.0, -2.0, 1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(1.0, 7.0, 8.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(-8.0, -9.0, -2.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(-5.0, -5.0, 6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(7.0, 0.0, 2.0, 4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(4.0, -9.0, 5.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(1.0, 5.0, -6.0, 4.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(-7.0, -8.0, 7.0));
	block.var[0][0][1] = (vec3(-6.0, -3.0, -4.0));
	block.var[0][1][0] = (vec3(3.0, -8.0, -9.0));
	block.var[0][1][1] = (vec3(-2.0, 5.0, 6.0));
	block.var[0][2][0] = (vec3(6.0, -5.0, -7.0));
	block.var[0][2][1] = (vec3(1.0, 1.0, -3.0));
	block.var[1][0][0] = (vec3(9.0, -7.0, 2.0));
	block.var[1][0][1] = (vec3(5.0, -4.0, 6.0));
	block.var[1][1][0] = (vec3(-3.0, -8.0, 6.0));
	block.var[1][1][1] = (vec3(8.0, 2.0, 4.0));
	block.var[1][2][0] = (vec3(0.0, 8.0, 0.0));
	block.var[1][2][1] = (vec3(-2.0, 1.0, -3.0));
	block.var[2][0][0] = (vec3(-6.0, 3.0, 9.0));
	block.var[2][0][1] = (vec3(3.0, -2.0, -9.0));
	block.var[2][1][0] = (vec3(-7.0, -8.0, -6.0));
	block.var[2][1][1] = (vec3(-7.0, 2.0, -3.0));
	block.var[2][2][0] = (vec3(1.0, -1.0, 8.0));
	block.var[2][2][1] = (vec3(7.0, -2.0, -6.0));
	block.var[3][0][0] = (vec3(-1.0, -1.0, -5.0));
	block.var[3][0][1] = (vec3(-1.0, 1.0, -1.0));
	block.var[3][1][0] = (vec3(5.0, 5.0, -6.0));
	block.var[3][1][1] = (vec3(6.0, 7.0, -2.0));
	block.var[3][2][0] = (vec3(-5.0, -7.0, -1.0));
	block.var[3][2][1] = (vec3(4.0, -3.0, -7.0));
}
#version 450
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
	highp float var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 7.0) && allOk;
	allOk = compare_float((block.var[0][0]), -1.0) && allOk;
	allOk = compare_float((block.var[0][1]), -6.0) && allOk;
	allOk = compare_float((block.var[0][2]), 0.0) && allOk;
	allOk = compare_float((block.var[1][0]), -7.0) && allOk;
	allOk = compare_float((block.var[1][1]), 5.0) && allOk;
	allOk = compare_float((block.var[1][2]), 4.0) && allOk;
	allOk = compare_float((block.var[2][0]), 2.0) && allOk;
	allOk = compare_float((block.var[2][1]), -1.0) && allOk;
	allOk = compare_float((block.var[2][2]), -6.0) && allOk;
	allOk = compare_float((block.var[3][0]), -2.0) && allOk;
	allOk = compare_float((block.var[3][1]), -1.0) && allOk;
	allOk = compare_float((block.var[3][2]), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0] = (4.0);
	block.var[0][1] = (6.0);
	block.var[0][2] = (7.0);
	block.var[1][0] = (-4.0);
	block.var[1][1] = (5.0);
	block.var[1][2] = (-8.0);
	block.var[2][0] = (9.0);
	block.var[2][1] = (-5.0);
	block.var[2][2] = (8.0);
	block.var[3][0] = (-5.0);
	block.var[3][1] = (6.0);
	block.var[3][2] = (-6.0);
}
#version 450
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_mat3x2(block.var[0][0], mat3x2(4.0, -9.0, -1.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(6.0, 3.0, 1.0, 8.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(-3.0, 3.0, -3.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(1.0, -3.0, -8.0, -2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(8.0, 7.0, 7.0, -8.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(-7.0, 1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(-8.0, -7.0, 7.0, 2.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(9.0, -2.0, 2.0, 1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(9.0, 6.0, 2.0, 9.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(1.0, 1.0, 8.0, 4.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(7.0, -2.0, -4.0, 1.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-1.0, -7.0, 9.0, 5.0, 3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0] = (mat3x2(-2.0, -8.0, 0.0, -9.0, 9.0, 0.0));
	block.var[0][1] = (mat3x2(1.0, -3.0, -6.0, -5.0, -7.0, 5.0));
	block.var[0][2] = (mat3x2(-4.0, 8.0, -1.0, -8.0, 1.0, 2.0));
	block.var[1][0] = (mat3x2(1.0, -5.0, 0.0, -3.0, 1.0, -4.0));
	block.var[1][1] = (mat3x2(4.0, 5.0, -5.0, -6.0, 3.0, 1.0));
	block.var[1][2] = (mat3x2(-2.0, 3.0, -8.0, -6.0, 2.0, -5.0));
	block.var[2][0] = (mat3x2(-4.0, -8.0, 9.0, -9.0, -8.0, 8.0));
	block.var[2][1] = (mat3x2(-4.0, 1.0, -1.0, 7.0, 0.0, 1.0));
	block.var[2][2] = (mat3x2(-3.0, 6.0, -4.0, -6.0, -5.0, -6.0));
	block.var[3][0] = (mat3x2(-4.0, 6.0, 4.0, 2.0, -8.0, 2.0));
	block.var[3][1] = (mat3x2(1.0, -3.0, -3.0, -5.0, -1.0, 6.0));
	block.var[3][2] = (mat3x2(9.0, 9.0, 9.0, -4.0, 8.0, -7.0));
}
#version 450
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
	highp vec2 var[4][2][3];
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
	allOk = compare_vec2((block.var[0][0][0]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_vec2((block.var[0][0][1]), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[0][0][2]), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_vec2((block.var[0][1][0]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_vec2((block.var[0][1][1]), vec2(-7.0, -8.0)) && allOk;
	allOk = compare_vec2((block.var[0][1][2]), vec2(7.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[1][0][0]), vec2(7.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[1][0][1]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2((block.var[1][0][2]), vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2((block.var[1][1][0]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec2((block.var[1][1][1]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((block.var[1][1][2]), vec2(-4.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[2][0][0]), vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[2][0][1]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec2((block.var[2][0][2]), vec2(3.0, -8.0)) && allOk;
	allOk = compare_vec2((block.var[2][1][0]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_vec2((block.var[2][1][1]), vec2(-2.0, -3.0)) && allOk;
	allOk = compare_vec2((block.var[2][1][2]), vec2(-5.0, 5.0)) && allOk;
	allOk = compare_vec2((block.var[3][0][0]), vec2(-7.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[3][0][1]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((block.var[3][0][2]), vec2(-1.0, -1.0)) && allOk;
	allOk = compare_vec2((block.var[3][1][0]), vec2(-8.0, -1.0)) && allOk;
	allOk = compare_vec2((block.var[3][1][1]), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[3][1][2]), vec2(6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0][0][0] = (vec2(8.0, 7.0));
	block.var[0][0][1] = (vec2(-1.0, -4.0));
	block.var[0][0][2] = (vec2(8.0, -2.0));
	block.var[0][1][0] = (vec2(-2.0, 5.0));
	block.var[0][1][1] = (vec2(4.0, 0.0));
	block.var[0][1][2] = (vec2(0.0, -4.0));
	block.var[1][0][0] = (vec2(-5.0, -2.0));
	block.var[1][0][1] = (vec2(5.0, 6.0));
	block.var[1][0][2] = (vec2(-2.0, -6.0));
	block.var[1][1][0] = (vec2(-9.0, -2.0));
	block.var[1][1][1] = (vec2(2.0, -2.0));
	block.var[1][1][2] = (vec2(8.0, -4.0));
	block.var[2][0][0] = (vec2(-6.0, 1.0));
	block.var[2][0][1] = (vec2(6.0, -7.0));
	block.var[2][0][2] = (vec2(6.0, 1.0));
	block.var[2][1][0] = (vec2(-4.0, -2.0));
	block.var[2][1][1] = (vec2(-8.0, 2.0));
	block.var[2][1][2] = (vec2(9.0, -8.0));
	block.var[3][0][0] = (vec2(-6.0, -9.0));
	block.var[3][0][1] = (vec2(0.0, -8.0));
	block.var[3][0][2] = (vec2(-4.0, -6.0));
	block.var[3][1][0] = (vec2(9.0, 0.0));
	block.var[3][1][1] = (vec2(-8.0, 1.0));
	block.var[3][1][2] = (vec2(5.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat2(block.var[0][0][0], mat2(7.0, 0.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(-3.0, 5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(-9.0, -4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(1.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(1.0, -4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(5.0, 1.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-7.0, -1.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-7.0, -5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(6.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-7.0, 4.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(2.0, 4.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(-8.0, -4.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-3.0, 0.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-3.0, 8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(-9.0, -7.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(-2.0, 3.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(9.0, 1.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(3.0, 0.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(5.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(-3.0, -8.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(2.0, -9.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(0.0, -5.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-1.0, -8.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(7.0, 1.0, -6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0][0][0] = (mat2(-4.0, -2.0, 1.0, 1.0));
	block.var[0][0][1] = (mat2(-1.0, -3.0, -4.0, -8.0));
	block.var[0][0][2] = (mat2(-6.0, -2.0, 5.0, 8.0));
	block.var[0][1][0] = (mat2(0.0, -7.0, -7.0, -6.0));
	block.var[0][1][1] = (mat2(5.0, 2.0, 8.0, 5.0));
	block.var[0][1][2] = (mat2(3.0, 8.0, -4.0, 0.0));
	block.var[1][0][0] = (mat2(0.0, -2.0, -5.0, -1.0));
	block.var[1][0][1] = (mat2(4.0, -4.0, -6.0, 9.0));
	block.var[1][0][2] = (mat2(-9.0, 0.0, 7.0, 2.0));
	block.var[1][1][0] = (mat2(7.0, 4.0, -2.0, 4.0));
	block.var[1][1][1] = (mat2(0.0, 7.0, -4.0, -7.0));
	block.var[1][1][2] = (mat2(-1.0, 4.0, 7.0, 6.0));
	block.var[2][0][0] = (mat2(9.0, 6.0, -5.0, 5.0));
	block.var[2][0][1] = (mat2(-5.0, -7.0, 8.0, -2.0));
	block.var[2][0][2] = (mat2(-1.0, 8.0, -9.0, -7.0));
	block.var[2][1][0] = (mat2(8.0, -1.0, 1.0, 9.0));
	block.var[2][1][1] = (mat2(-2.0, -9.0, 1.0, 1.0));
	block.var[2][1][2] = (mat2(-9.0, -7.0, -5.0, -6.0));
	block.var[3][0][0] = (mat2(-9.0, 3.0, 5.0, -3.0));
	block.var[3][0][1] = (mat2(-2.0, -9.0, -1.0, 5.0));
	block.var[3][0][2] = (mat2(-2.0, 4.0, 8.0, 8.0));
	block.var[3][1][0] = (mat2(4.0, 1.0, 7.0, -8.0));
	block.var[3][1][1] = (mat2(-5.0, -1.0, 7.0, -1.0));
	block.var[3][1][2] = (mat2(-4.0, 0.0, -7.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_mat4(block.var[0][0][0], mat4(-5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0, 3.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0, -2.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(-1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0, 0.0, 5.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(9.0, 3.0, 0.0, 7.0, 0.0, 9.0, -9.0, 1.0, 4.0, -9.0, -8.0, 4.0, 6.0, -6.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(8.0, -2.0, 4.0, -6.0, 7.0, -4.0, -8.0, -2.0, -2.0, 3.0, -3.0, 8.0, 7.0, -6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(-2.0, -1.0, 8.0, 5.0, 1.0, 7.0, 0.0, -1.0, 1.0, -2.0, 7.0, -8.0, -2.0, -9.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0, 8.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0, -9.0, -5.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0, -4.0, -9.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(8.0, 3.0, 6.0, -3.0, 8.0, -1.0, 8.0, 0.0, 5.0, 7.0, 9.0, -3.0, -7.0, 3.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(7.0, 9.0, 7.0, -8.0, 2.0, 6.0, 0.0, 5.0, -8.0, 5.0, 3.0, 9.0, 6.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(-1.0, 7.0, -5.0, 0.0, -3.0, -6.0, -8.0, -6.0, 6.0, -3.0, -1.0, -6.0, 8.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0, -7.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0, -8.0, 2.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(-9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0, 5.0, 8.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(3.0, 7.0, -3.0, 1.0, -8.0, 3.0, 7.0, -3.0, 7.0, 5.0, -7.0, -8.0, 3.0, 3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-3.0, 9.0, 9.0, -5.0, 5.0, -1.0, 6.0, -1.0, -4.0, -9.0, -9.0, -9.0, -1.0, 1.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(5.0, 4.0, 1.0, 4.0, -7.0, -4.0, -2.0, -8.0, -7.0, 9.0, -6.0, 8.0, -9.0, 2.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(-6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0, 3.0, 3.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(-8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0, -8.0, 8.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0, 8.0, -7.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-8.0, 7.0, 0.0, 6.0, -9.0, -5.0, 9.0, -7.0, 6.0, -9.0, 6.0, -4.0, 1.0, 7.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(6.0, 2.0, -6.0, -9.0, -4.0, -6.0, 3.0, 4.0, 7.0, 1.0, -8.0, 8.0, -7.0, -9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(4.0, 8.0, 8.0, -3.0, -8.0, -1.0, -7.0, -6.0, 7.0, -3.0, -6.0, -6.0, 7.0, 3.0, 2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0][0][0][0] = (vec4(-9.0, -4.0, -9.0, -5.0));
	block.var[0][0][0][1] = (vec4(-2.0, 9.0, 0.0, -8.0));
	block.var[0][0][0][2] = (vec4(-6.0, -3.0, -8.0, 3.0));
	block.var[0][0][0][3] = (vec4(0.0, -1.0, -4.0, 4.0));
	block.var[0][0][1][0] = (vec4(7.0, -9.0, 6.0, 5.0));
	block.var[0][0][1][1] = (vec4(6.0, -1.0, -3.0, -3.0));
	block.var[0][0][1][2] = (vec4(-9.0, 3.0, -9.0, 0.0));
	block.var[0][0][1][3] = (vec4(9.0, 4.0, -3.0, 1.0));
	block.var[0][0][2][0] = (vec4(2.0, 1.0, 9.0, -4.0));
	block.var[0][0][2][1] = (vec4(-7.0, 7.0, 0.0, 7.0));
	block.var[0][0][2][2] = (vec4(9.0, 9.0, -5.0, -7.0));
	block.var[0][0][2][3] = (vec4(-4.0, -6.0, 5.0, -9.0));
	block.var[0][1][0][0] = (vec4(0.0, 3.0, 6.0, -1.0));
	block.var[0][1][0][1] = (vec4(4.0, 6.0, 8.0, 1.0));
	block.var[0][1][0][2] = (vec4(9.0, -4.0, 7.0, 7.0));
	block.var[0][1][0][3] = (vec4(-6.0, -8.0, -9.0, 2.0));
	block.var[0][1][1][0] = (vec4(-1.0, 7.0, -4.0, 2.0));
	block.var[0][1][1][1] = (vec4(9.0, 2.0, -2.0, -1.0));
	block.var[0][1][1][2] = (vec4(7.0, 3.0, -6.0, 0.0));
	block.var[0][1][1][3] = (vec4(-1.0, -8.0, 9.0, -7.0));
	block.var[0][1][2][0] = (vec4(5.0, 7.0, -3.0, -2.0));
	block.var[0][1][2][1] = (vec4(9.0, -5.0, -2.0, -2.0));
	block.var[0][1][2][2] = (vec4(2.0, 4.0, -1.0, 9.0));
	block.var[0][1][2][3] = (vec4(-8.0, -7.0, 8.0, 3.0));
	block.var[1][0][0][0] = (vec4(4.0, 6.0, -1.0, -7.0));
	block.var[1][0][0][1] = (vec4(7.0, 8.0, 5.0, -1.0));
	block.var[1][0][0][2] = (vec4(8.0, 2.0, -8.0, 0.0));
	block.var[1][0][0][3] = (vec4(5.0, 8.0, 6.0, -9.0));
	block.var[1][0][1][0] = (vec4(3.0, 1.0, 2.0, 2.0));
	block.var[1][0][1][1] = (vec4(-3.0, -7.0, 1.0, 0.0));
	block.var[1][0][1][2] = (vec4(9.0, 5.0, -2.0, 6.0));
	block.var[1][0][1][3] = (vec4(-1.0, -5.0, 7.0, -9.0));
	block.var[1][0][2][0] = (vec4(-2.0, -2.0, -8.0, -4.0));
	block.var[1][0][2][1] = (vec4(7.0, -4.0, -1.0, 2.0));
	block.var[1][0][2][2] = (vec4(7.0, 7.0, 2.0, 8.0));
	block.var[1][0][2][3] = (vec4(1.0, 2.0, -3.0, -5.0));
	block.var[1][1][0][0] = (vec4(-3.0, -9.0, 9.0, -7.0));
	block.var[1][1][0][1] = (vec4(-7.0, 9.0, -4.0, 0.0));
	block.var[1][1][0][2] = (vec4(-4.0, -3.0, 0.0, 6.0));
	block.var[1][1][0][3] = (vec4(3.0, 4.0, -8.0, -5.0));
	block.var[1][1][1][0] = (vec4(4.0, 5.0, 0.0, -6.0));
	block.var[1][1][1][1] = (vec4(7.0, 4.0, 1.0, 9.0));
	block.var[1][1][1][2] = (vec4(-8.0, 8.0, 7.0, 4.0));
	block.var[1][1][1][3] = (vec4(-7.0, 3.0, -9.0, -1.0));
	block.var[1][1][2][0] = (vec4(-5.0, -8.0, 2.0, -5.0));
	block.var[1][1][2][1] = (vec4(3.0, -8.0, -1.0, -5.0));
	block.var[1][1][2][2] = (vec4(-6.0, -2.0, 3.0, 0.0));
	block.var[1][1][2][3] = (vec4(5.0, 9.0, -2.0, 1.0));
	block.var[2][0][0][0] = (vec4(6.0, -2.0, -1.0, -2.0));
	block.var[2][0][0][1] = (vec4(0.0, 5.0, -4.0, 5.0));
	block.var[2][0][0][2] = (vec4(8.0, -8.0, 9.0, -3.0));
	block.var[2][0][0][3] = (vec4(9.0, 9.0, 4.0, 4.0));
	block.var[2][0][1][0] = (vec4(-3.0, -4.0, -7.0, 1.0));
	block.var[2][0][1][1] = (vec4(4.0, -2.0, 1.0, -8.0));
	block.var[2][0][1][2] = (vec4(-8.0, 5.0, 4.0, 7.0));
	block.var[2][0][1][3] = (vec4(-8.0, -1.0, 0.0, 7.0));
	block.var[2][0][2][0] = (vec4(-7.0, -5.0, 2.0, 2.0));
	block.var[2][0][2][1] = (vec4(4.0, 8.0, 4.0, -9.0));
	block.var[2][0][2][2] = (vec4(0.0, -9.0, 0.0, 0.0));
	block.var[2][0][2][3] = (vec4(-2.0, -6.0, 9.0, 9.0));
	block.var[2][1][0][0] = (vec4(-4.0, -5.0, 6.0, 9.0));
	block.var[2][1][0][1] = (vec4(-5.0, -7.0, 1.0, 2.0));
	block.var[2][1][0][2] = (vec4(-7.0, 2.0, -8.0, 9.0));
	block.var[2][1][0][3] = (vec4(-3.0, -1.0, 9.0, -1.0));
	block.var[2][1][1][0] = (vec4(5.0, -8.0, -7.0, 3.0));
	block.var[2][1][1][1] = (vec4(-5.0, 2.0, 5.0, 7.0));
	block.var[2][1][1][2] = (vec4(-9.0, 2.0, -7.0, 9.0));
	block.var[2][1][1][3] = (vec4(2.0, 4.0, 1.0, -7.0));
	block.var[2][1][2][0] = (vec4(6.0, -2.0, 9.0, 1.0));
	block.var[2][1][2][1] = (vec4(0.0, -3.0, -6.0, -8.0));
	block.var[2][1][2][2] = (vec4(-4.0, 0.0, -2.0, 0.0));
	block.var[2][1][2][3] = (vec4(5.0, -6.0, -3.0, -8.0));
	block.var[3][0][0][0] = (vec4(-9.0, -6.0, -8.0, 4.0));
	block.var[3][0][0][1] = (vec4(-6.0, 9.0, -8.0, 3.0));
	block.var[3][0][0][2] = (vec4(0.0, 1.0, -1.0, -7.0));
	block.var[3][0][0][3] = (vec4(-1.0, -1.0, -3.0, -9.0));
	block.var[3][0][1][0] = (vec4(4.0, 9.0, 4.0, -4.0));
	block.var[3][0][1][1] = (vec4(3.0, -1.0, 2.0, 8.0));
	block.var[3][0][1][2] = (vec4(-3.0, -6.0, -4.0, 0.0));
	block.var[3][0][1][3] = (vec4(-4.0, 4.0, 6.0, 2.0));
	block.var[3][0][2][0] = (vec4(8.0, 5.0, 3.0, 0.0));
	block.var[3][0][2][1] = (vec4(-2.0, 0.0, 7.0, -5.0));
	block.var[3][0][2][2] = (vec4(6.0, 0.0, 6.0, -6.0));
	block.var[3][0][2][3] = (vec4(-1.0, 1.0, -1.0, -1.0));
	block.var[3][1][0][0] = (vec4(-9.0, 1.0, 2.0, 8.0));
	block.var[3][1][0][1] = (vec4(2.0, 9.0, 8.0, 5.0));
	block.var[3][1][0][2] = (vec4(-8.0, 4.0, -3.0, -4.0));
	block.var[3][1][0][3] = (vec4(9.0, 5.0, 6.0, -5.0));
	block.var[3][1][1][0] = (vec4(5.0, -5.0, 4.0, 2.0));
	block.var[3][1][1][1] = (vec4(-4.0, -6.0, -2.0, 5.0));
	block.var[3][1][1][2] = (vec4(-1.0, -4.0, 1.0, 6.0));
	block.var[3][1][1][3] = (vec4(-3.0, 4.0, -1.0, -1.0));
	block.var[3][1][2][0] = (vec4(9.0, 4.0, 8.0, 0.0));
	block.var[3][1][2][1] = (vec4(0.0, -3.0, -3.0, 1.0));
	block.var[3][1][2][2] = (vec4(4.0, 6.0, -3.0, -5.0));
	block.var[3][1][2][3] = (vec4(0.0, 3.0, -1.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-3.0, -7.0, 1.0, -1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(7.0, -9.0, 1.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(-9.0, 1.0, -7.0, -5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(9.0, -6.0, 7.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(3.0, 9.0, 3.0, 8.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(-9.0, 4.0, 4.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(4.0, -5.0, 9.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(-7.0, -3.0, 0.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(-6.0, -8.0, 2.0, 5.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(1.0, 7.0, -7.0, 7.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-9.0, 5.0, -1.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(9.0, -9.0, -2.0, 4.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-1.0, -4.0, -9.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(2.0, -8.0, 9.0, -9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(-8.0, -6.0, 2.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-8.0, 9.0, -9.0, 5.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(3.0, 6.0, -3.0, 4.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(-9.0, -6.0, -5.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(-2.0, -6.0, 1.0, 1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(7.0, 2.0, 9.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(5.0, 4.0, 1.0, 8.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(8.0, 0.0, -1.0, 5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(2.0, 3.0, -4.0, 0.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(-8.0, -6.0, 0.0, -8.0, -1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0][0] = (mat2x3(-7.0, 9.0, -3.0, 0.0, 7.0, 1.0));
	block.var[0][0][1] = (mat2x3(-4.0, 1.0, 9.0, 6.0, -4.0, -1.0));
	block.var[0][0][2] = (mat2x3(-8.0, 4.0, 7.0, 8.0, 0.0, 9.0));
	block.var[0][1][0] = (mat2x3(-5.0, 2.0, 6.0, -9.0, 3.0, 5.0));
	block.var[0][1][1] = (mat2x3(0.0, 1.0, -3.0, 8.0, 1.0, -5.0));
	block.var[0][1][2] = (mat2x3(-7.0, -8.0, -4.0, -7.0, -6.0, -9.0));
	block.var[1][0][0] = (mat2x3(4.0, 4.0, 2.0, 3.0, 8.0, 4.0));
	block.var[1][0][1] = (mat2x3(-5.0, 9.0, 7.0, -1.0, -6.0, -1.0));
	block.var[1][0][2] = (mat2x3(6.0, 4.0, 8.0, -3.0, -1.0, -2.0));
	block.var[1][1][0] = (mat2x3(-7.0, 4.0, 8.0, 8.0, 1.0, 3.0));
	block.var[1][1][1] = (mat2x3(7.0, 2.0, -8.0, -9.0, 6.0, 0.0));
	block.var[1][1][2] = (mat2x3(-2.0, 8.0, -5.0, -7.0, -7.0, -2.0));
	block.var[2][0][0] = (mat2x3(5.0, -8.0, 8.0, -1.0, 6.0, -3.0));
	block.var[2][0][1] = (mat2x3(-9.0, 9.0, 7.0, 5.0, -8.0, -3.0));
	block.var[2][0][2] = (mat2x3(6.0, 2.0, -6.0, -1.0, -2.0, -7.0));
	block.var[2][1][0] = (mat2x3(-3.0, -5.0, -9.0, 1.0, -5.0, 3.0));
	block.var[2][1][1] = (mat2x3(8.0, 6.0, 0.0, 8.0, -9.0, 2.0));
	block.var[2][1][2] = (mat2x3(3.0, 4.0, 2.0, 3.0, 4.0, -1.0));
	block.var[3][0][0] = (mat2x3(-8.0, 5.0, -5.0, 6.0, 7.0, 5.0));
	block.var[3][0][1] = (mat2x3(-7.0, -3.0, -4.0, -1.0, 8.0, -5.0));
	block.var[3][0][2] = (mat2x3(9.0, -8.0, 3.0, 3.0, -8.0, -1.0));
	block.var[3][1][0] = (mat2x3(-8.0, 2.0, 8.0, -4.0, 9.0, 6.0));
	block.var[3][1][1] = (mat2x3(-3.0, -1.0, -9.0, -6.0, 4.0, 6.0));
	block.var[3][1][2] = (mat2x3(-2.0, 7.0, -7.0, 3.0, -4.0, -2.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-3.0, -9.0, 4.0, -4.0, -4.0, -2.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-6.0, -9.0, 0.0, 2.0, -7.0, -1.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(-4.0, -5.0, -5.0, 1.0, -5.0, 8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(-2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(2.0, -1.0, -3.0, -7.0, -8.0, 8.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(9.0, -6.0, -7.0, 1.0, 2.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(-5.0, -5.0, -2.0, 5.0, 3.0, 6.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-1.0, 1.0, -8.0, -7.0, -2.0, 3.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-7.0, -6.0, 9.0, -2.0, 0.0, 5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(0.0, 6.0, 6.0, -2.0, -2.0, -4.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(-7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(-3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(8.0, 7.0, 7.0, 3.0, -3.0, 0.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(3.0, 2.0, 9.0, 1.0, -1.0, -8.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(0.0, 5.0, 8.0, 6.0, 2.0, -3.0, 7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0][0][0] = (mat4x2(-8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0, 5.0));
	block.var[0][0][1] = (mat4x2(8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0, -6.0));
	block.var[0][0][2] = (mat4x2(-9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0, 8.0));
	block.var[0][1][0] = (mat4x2(9.0, 4.0, -2.0, -8.0, -5.0, -3.0, 9.0, 9.0));
	block.var[0][1][1] = (mat4x2(-3.0, 8.0, 2.0, -9.0, 2.0, 1.0, -2.0, 6.0));
	block.var[0][1][2] = (mat4x2(7.0, -3.0, 4.0, 8.0, -4.0, -9.0, -6.0, -8.0));
	block.var[1][0][0] = (mat4x2(7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0, 1.0));
	block.var[1][0][1] = (mat4x2(6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0, 3.0));
	block.var[1][0][2] = (mat4x2(-5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0, -4.0));
	block.var[1][1][0] = (mat4x2(1.0, 6.0, -6.0, 6.0, -2.0, -8.0, 8.0, 0.0));
	block.var[1][1][1] = (mat4x2(7.0, -6.0, 0.0, -7.0, 3.0, -3.0, 1.0, -4.0));
	block.var[1][1][2] = (mat4x2(-6.0, -8.0, -9.0, 1.0, 4.0, 2.0, -5.0, -4.0));
	block.var[2][0][0] = (mat4x2(4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0, 8.0));
	block.var[2][0][1] = (mat4x2(-4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0, -4.0));
	block.var[2][0][2] = (mat4x2(-8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0, -5.0));
	block.var[2][1][0] = (mat4x2(0.0, 5.0, 8.0, 4.0, -1.0, 1.0, 4.0, -1.0));
	block.var[2][1][1] = (mat4x2(-3.0, -1.0, 1.0, 3.0, 4.0, -6.0, -8.0, -3.0));
	block.var[2][1][2] = (mat4x2(8.0, -7.0, -8.0, 3.0, 0.0, -2.0, 7.0, -2.0));
	block.var[3][0][0] = (mat4x2(7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0, 6.0));
	block.var[3][0][1] = (mat4x2(-7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0, 3.0));
	block.var[3][0][2] = (mat4x2(-8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0, 8.0));
	block.var[3][1][0] = (mat4x2(7.0, -8.0, -6.0, 4.0, -9.0, 3.0, -6.0, -7.0));
	block.var[3][1][1] = (mat4x2(5.0, 0.0, -5.0, 7.0, 3.0, -1.0, -3.0, 5.0));
	block.var[3][1][2] = (mat4x2(-8.0, 1.0, -3.0, 7.0, -8.0, 1.0, -4.0, -4.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
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
	bvec3 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((block.var[0][0][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[0][0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[0][1][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((block.var[0][1][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[0][2][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][2][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][3][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][3][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[1][0][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[1][0][1]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[1][1][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[1][1][1]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[1][2][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[1][2][1]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[1][3][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[1][3][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[2][0][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][0][1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((block.var[2][1][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][2][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][2][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[2][3][0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((block.var[2][3][1]), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (bvec3(true, true, false));
	block.var[0][0][1] = (bvec3(false, true, true));
	block.var[0][1][0] = (bvec3(false, true, true));
	block.var[0][1][1] = (bvec3(true, true, true));
	block.var[0][2][0] = (bvec3(false, false, true));
	block.var[0][2][1] = (bvec3(true, false, true));
	block.var[0][3][0] = (bvec3(true, true, false));
	block.var[0][3][1] = (bvec3(false, true, false));
	block.var[1][0][0] = (bvec3(false, false, false));
	block.var[1][0][1] = (bvec3(true, false, false));
	block.var[1][1][0] = (bvec3(true, true, true));
	block.var[1][1][1] = (bvec3(true, false, false));
	block.var[1][2][0] = (bvec3(false, false, false));
	block.var[1][2][1] = (bvec3(true, true, false));
	block.var[1][3][0] = (bvec3(false, true, false));
	block.var[1][3][1] = (bvec3(false, false, false));
	block.var[2][0][0] = (bvec3(true, true, true));
	block.var[2][0][1] = (bvec3(false, true, true));
	block.var[2][1][0] = (bvec3(false, true, false));
	block.var[2][1][1] = (bvec3(true, false, false));
	block.var[2][2][0] = (bvec3(false, false, true));
	block.var[2][2][1] = (bvec3(false, false, true));
	block.var[2][3][0] = (bvec3(true, true, false));
	block.var[2][3][1] = (bvec3(false, true, false));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(7.0, 3.0, -1.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-8.0, -5.0, 9.0, -3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-4.0, -8.0, -7.0, -9.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(-1.0, -4.0, -4.0, 6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(0.0, 9.0, -1.0, -2.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(4.0, 8.0, 2.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-2.0, -1.0, 5.0, 2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-4.0, 6.0, -7.0, 0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-9.0, 0.0, 9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(-8.0, 8.0, -4.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(-3.0, -7.0, -5.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(2.0, 6.0, -9.0, 3.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(-6.0, -1.0, -5.0, 1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(9.0, -5.0, 7.0, 6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-1.0, -4.0, 0.0, -2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-7.0, -5.0, 3.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-3.0, -2.0, 3.0, -8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(0.0, -8.0, -1.0, 9.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(-7.0, -9.0, 6.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(2.0, -1.0, -4.0, 7.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(5.0, 5.0, 4.0, -6.0, -5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(9.0, -4.0));
	block.var[0][0][0][1] = (vec2(-7.0, 8.0));
	block.var[0][0][0][2] = (vec2(-2.0, -9.0));
	block.var[0][0][1][0] = (vec2(-1.0, 7.0));
	block.var[0][0][1][1] = (vec2(-3.0, -3.0));
	block.var[0][0][1][2] = (vec2(-8.0, 2.0));
	block.var[0][1][0][0] = (vec2(-3.0, -2.0));
	block.var[0][1][0][1] = (vec2(-9.0, -8.0));
	block.var[0][1][0][2] = (vec2(-8.0, 4.0));
	block.var[0][1][1][0] = (vec2(-2.0, 9.0));
	block.var[0][1][1][1] = (vec2(-1.0, 3.0));
	block.var[0][1][1][2] = (vec2(-2.0, 9.0));
	block.var[0][2][0][0] = (vec2(9.0, 4.0));
	block.var[0][2][0][1] = (vec2(-8.0, -6.0));
	block.var[0][2][0][2] = (vec2(4.0, -6.0));
	block.var[0][2][1][0] = (vec2(-9.0, -3.0));
	block.var[0][2][1][1] = (vec2(8.0, 9.0));
	block.var[0][2][1][2] = (vec2(4.0, -8.0));
	block.var[0][3][0][0] = (vec2(2.0, -5.0));
	block.var[0][3][0][1] = (vec2(2.0, 8.0));
	block.var[0][3][0][2] = (vec2(1.0, 5.0));
	block.var[0][3][1][0] = (vec2(-2.0, 0.0));
	block.var[0][3][1][1] = (vec2(-7.0, 5.0));
	block.var[0][3][1][2] = (vec2(-8.0, 2.0));
	block.var[1][0][0][0] = (vec2(-2.0, -1.0));
	block.var[1][0][0][1] = (vec2(-3.0, -3.0));
	block.var[1][0][0][2] = (vec2(-4.0, 5.0));
	block.var[1][0][1][0] = (vec2(9.0, 7.0));
	block.var[1][0][1][1] = (vec2(-4.0, 7.0));
	block.var[1][0][1][2] = (vec2(1.0, 6.0));
	block.var[1][1][0][0] = (vec2(-2.0, -4.0));
	block.var[1][1][0][1] = (vec2(-1.0, 9.0));
	block.var[1][1][0][2] = (vec2(-9.0, -4.0));
	block.var[1][1][1][0] = (vec2(-3.0, -2.0));
	block.var[1][1][1][1] = (vec2(7.0, -5.0));
	block.var[1][1][1][2] = (vec2(-5.0, 0.0));
	block.var[1][2][0][0] = (vec2(0.0, -4.0));
	block.var[1][2][0][1] = (vec2(6.0, -1.0));
	block.var[1][2][0][2] = (vec2(-7.0, 8.0));
	block.var[1][2][1][0] = (vec2(4.0, 2.0));
	block.var[1][2][1][1] = (vec2(2.0, -3.0));
	block.var[1][2][1][2] = (vec2(1.0, -6.0));
	block.var[1][3][0][0] = (vec2(6.0, 3.0));
	block.var[1][3][0][1] = (vec2(0.0, 1.0));
	block.var[1][3][0][2] = (vec2(7.0, -7.0));
	block.var[1][3][1][0] = (vec2(-4.0, 0.0));
	block.var[1][3][1][1] = (vec2(8.0, -1.0));
	block.var[1][3][1][2] = (vec2(-4.0, -1.0));
	block.var[2][0][0][0] = (vec2(-8.0, 9.0));
	block.var[2][0][0][1] = (vec2(8.0, 1.0));
	block.var[2][0][0][2] = (vec2(6.0, 8.0));
	block.var[2][0][1][0] = (vec2(-1.0, 2.0));
	block.var[2][0][1][1] = (vec2(1.0, -1.0));
	block.var[2][0][1][2] = (vec2(0.0, 3.0));
	block.var[2][1][0][0] = (vec2(4.0, -4.0));
	block.var[2][1][0][1] = (vec2(5.0, 5.0));
	block.var[2][1][0][2] = (vec2(2.0, -3.0));
	block.var[2][1][1][0] = (vec2(-5.0, -3.0));
	block.var[2][1][1][1] = (vec2(-7.0, 6.0));
	block.var[2][1][1][2] = (vec2(-6.0, 8.0));
	block.var[2][2][0][0] = (vec2(7.0, 3.0));
	block.var[2][2][0][1] = (vec2(-7.0, 5.0));
	block.var[2][2][0][2] = (vec2(2.0, -9.0));
	block.var[2][2][1][0] = (vec2(-2.0, -8.0));
	block.var[2][2][1][1] = (vec2(-9.0, 5.0));
	block.var[2][2][1][2] = (vec2(-2.0, 1.0));
	block.var[2][3][0][0] = (vec2(-3.0, 3.0));
	block.var[2][3][0][1] = (vec2(0.0, 5.0));
	block.var[2][3][0][2] = (vec2(-6.0, 4.0));
	block.var[2][3][1][0] = (vec2(-1.0, 1.0));
	block.var[2][3][1][1] = (vec2(-1.0, -6.0));
	block.var[2][3][1][2] = (vec2(3.0, -5.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(6.0, -3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(3.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(6.0, -8.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(8.0, 4.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(3.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(6.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(6.0, 4.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(5.0, -3.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(0.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(-4.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(-6.0, -7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(-8.0, -2.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(5.0, -4.0));
	block.var[0][0][0][1] = (vec2(5.0, 1.0));
	block.var[0][0][1][0] = (vec2(-8.0, -1.0));
	block.var[0][0][1][1] = (vec2(9.0, -8.0));
	block.var[0][1][0][0] = (vec2(4.0, -3.0));
	block.var[0][1][0][1] = (vec2(6.0, 7.0));
	block.var[0][1][1][0] = (vec2(-7.0, -9.0));
	block.var[0][1][1][1] = (vec2(5.0, 0.0));
	block.var[0][2][0][0] = (vec2(7.0, 7.0));
	block.var[0][2][0][1] = (vec2(0.0, 2.0));
	block.var[0][2][1][0] = (vec2(4.0, -7.0));
	block.var[0][2][1][1] = (vec2(-5.0, -7.0));
	block.var[0][3][0][0] = (vec2(4.0, -2.0));
	block.var[0][3][0][1] = (vec2(6.0, 1.0));
	block.var[0][3][1][0] = (vec2(-2.0, -8.0));
	block.var[0][3][1][1] = (vec2(9.0, 1.0));
	block.var[1][0][0][0] = (vec2(5.0, -4.0));
	block.var[1][0][0][1] = (vec2(5.0, -2.0));
	block.var[1][0][1][0] = (vec2(9.0, -9.0));
	block.var[1][0][1][1] = (vec2(-1.0, 6.0));
	block.var[1][1][0][0] = (vec2(9.0, 2.0));
	block.var[1][1][0][1] = (vec2(1.0, -6.0));
	block.var[1][1][1][0] = (vec2(8.0, -8.0));
	block.var[1][1][1][1] = (vec2(5.0, -5.0));
	block.var[1][2][0][0] = (vec2(8.0, 2.0));
	block.var[1][2][0][1] = (vec2(1.0, -1.0));
	block.var[1][2][1][0] = (vec2(9.0, 0.0));
	block.var[1][2][1][1] = (vec2(-8.0, -9.0));
	block.var[1][3][0][0] = (vec2(3.0, 4.0));
	block.var[1][3][0][1] = (vec2(-1.0, 5.0));
	block.var[1][3][1][0] = (vec2(2.0, -6.0));
	block.var[1][3][1][1] = (vec2(7.0, -4.0));
	block.var[2][0][0][0] = (vec2(-4.0, 7.0));
	block.var[2][0][0][1] = (vec2(-8.0, 1.0));
	block.var[2][0][1][0] = (vec2(4.0, -4.0));
	block.var[2][0][1][1] = (vec2(6.0, -5.0));
	block.var[2][1][0][0] = (vec2(-5.0, 4.0));
	block.var[2][1][0][1] = (vec2(5.0, 0.0));
	block.var[2][1][1][0] = (vec2(6.0, 9.0));
	block.var[2][1][1][1] = (vec2(5.0, -8.0));
	block.var[2][2][0][0] = (vec2(-2.0, 7.0));
	block.var[2][2][0][1] = (vec2(8.0, 2.0));
	block.var[2][2][1][0] = (vec2(-3.0, -3.0));
	block.var[2][2][1][1] = (vec2(7.0, -2.0));
	block.var[2][3][0][0] = (vec2(5.0, 3.0));
	block.var[2][3][0][1] = (vec2(9.0, -9.0));
	block.var[2][3][1][0] = (vec2(7.0, 1.0));
	block.var[2][3][1][1] = (vec2(-5.0, -7.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-8, -2, 6)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-9.0, -5.0, 7.0, -9.0, -9.0, -8.0, 4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(2.0, 3.0, 1.0, -1.0, -5.0, -3.0, -3.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-8.0, -6.0, -4.0, 6.0, 6.0, -4.0, 1.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(5.0, -7.0, -9.0, 6.0, 5.0, 3.0, -7.0, 2.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(-5.0, 1.0, -6.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(-5, 8, -2)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(4.0, -4.0, -3.0, -9.0, -3.0, 8.0, 7.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-2.0, 5.0, -3.0, -4.0, 9.0, 1.0, 8.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(1.0, -6.0, 4.0, 2.0, 6.0, 2.0, 5.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(8.0, -2.0, 3.0, -5.0, 5.0, 5.0, -1.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-2.0, -8.0, -1.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-4, 4, 6)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-6.0, -9.0, 6.0, 1.0, -6.0, 7.0, 7.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-2.0, -1.0, -5.0, -7.0, -2.0, 0.0, -8.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-1.0, 9.0, 9.0, -3.0, -9.0, -3.0, 6.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(2.0, 1.0, 2.0, -5.0, 9.0, 5.0, -3.0, 1.0, -4.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(1.0, 9.0, 2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-7, -8, 2));
	block[0].s.b[0][0] = (vec3(3.0, -5.0, 3.0));
	block[0].s.b[0][1] = (vec3(-3.0, 5.0, -6.0));
	block[0].s.b[0][2] = (vec3(-6.0, -1.0, -4.0));
	block[0].s.b[1][0] = (vec3(-1.0, -5.0, -1.0));
	block[0].s.b[1][1] = (vec3(8.0, 2.0, -1.0));
	block[0].s.b[1][2] = (vec3(0.0, -9.0, -5.0));
	block[0].s.b[2][0] = (vec3(-1.0, 7.0, -2.0));
	block[0].s.b[2][1] = (vec3(-1.0, 0.0, 7.0));
	block[0].s.b[2][2] = (vec3(1.0, -1.0, -4.0));
	block[0].s.b[3][0] = (vec3(9.0, -6.0, -6.0));
	block[0].s.b[3][1] = (vec3(6.0, 9.0, 7.0));
	block[0].s.b[3][2] = (vec3(0.0, -4.0, -2.0));
	block[0].s.c = (vec4(-4.0, 6.0, -2.0, 5.0));
	block[1].s.a = (ivec3(-6, 9, -5));
	block[1].s.b[0][0] = (vec3(4.0, 2.0, 8.0));
	block[1].s.b[0][1] = (vec3(-2.0, -2.0, -2.0));
	block[1].s.b[0][2] = (vec3(-7.0, -4.0, 9.0));
	block[1].s.b[1][0] = (vec3(-8.0, -1.0, 9.0));
	block[1].s.b[1][1] = (vec3(-5.0, 2.0, 4.0));
	block[1].s.b[1][2] = (vec3(-7.0, 7.0, 3.0));
	block[1].s.b[2][0] = (vec3(9.0, 6.0, -3.0));
	block[1].s.b[2][1] = (vec3(-2.0, 2.0, 6.0));
	block[1].s.b[2][2] = (vec3(-8.0, 9.0, 1.0));
	block[1].s.b[3][0] = (vec3(-8.0, -4.0, 8.0));
	block[1].s.b[3][1] = (vec3(1.0, 7.0, -4.0));
	block[1].s.b[3][2] = (vec3(-2.0, 0.0, 8.0));
	block[1].s.c = (vec4(-3.0, 8.0, 0.0, 7.0));
	block[2].s.a = (ivec3(-8, 1, -9));
	block[2].s.b[0][0] = (vec3(8.0, -1.0, -2.0));
	block[2].s.b[0][1] = (vec3(-7.0, -5.0, 4.0));
	block[2].s.b[0][2] = (vec3(9.0, 6.0, -4.0));
	block[2].s.b[1][0] = (vec3(0.0, 4.0, 2.0));
	block[2].s.b[1][1] = (vec3(-4.0, 9.0, -6.0));
	block[2].s.b[1][2] = (vec3(3.0, -1.0, 5.0));
	block[2].s.b[2][0] = (vec3(7.0, -4.0, 3.0));
	block[2].s.b[2][1] = (vec3(9.0, -2.0, -6.0));
	block[2].s.b[2][2] = (vec3(6.0, -4.0, -9.0));
	block[2].s.b[3][0] = (vec3(2.0, 0.0, 0.0));
	block[2].s.b[3][1] = (vec3(-5.0, 6.0, 3.0));
	block[2].s.b[3][2] = (vec3(-7.0, -3.0, -7.0));
	block[2].s.c = (vec4(3.0, -6.0, -6.0, -6.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-8, -2, 6)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-9.0, -5.0, 7.0, -9.0, -9.0, -8.0, 4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(2.0, 3.0, 1.0, -1.0, -5.0, -3.0, -3.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-8.0, -6.0, -4.0, 6.0, 6.0, -4.0, 1.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(5.0, -7.0, -9.0, 6.0, 5.0, 3.0, -7.0, 2.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(-5.0, 1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(-2.0, 4.0, -4.0, -3.0, -9.0, -3.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(9, -2, 5)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(-3.0, -4.0, 9.0, 1.0, 8.0, -8.0, -8.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(4.0, 2.0, 6.0, 2.0, 5.0, -6.0, -4.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(3.0, -5.0, 5.0, 5.0, -1.0, -3.0, -8.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(-1.0, 5.0, -4.0, 4.0, 6.0, -6.0, -9.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(-6.0, 7.0, 7.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(-2, -1, -5)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-7.0, -2.0, 0.0, -8.0, 8.0, -7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-3.0, -9.0, -3.0, 6.0, 0.0, 3.0, 2.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-5.0, 9.0, 5.0, -3.0, 1.0, -4.0, 1.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-2.0, 2.0, -2.0, 2.0, 5.0, 0.0, -1.0, 3.0, -9.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-7.0, -8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(-1.0, -4.0, -2.0, -9.0, 8.0, -9.0, 0.0, -9.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(6, 2, -5)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(3.0, -2.0, 8.0, -5.0, -3.0, -5.0, -6.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(-2.0, 8.0, -1.0, -5.0, 2.0, 1.0, -3.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(-9.0, 4.0, -3.0, 1.0, -6.0, -8.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(-7.0, -6.0, 6.0, 8.0, 5.0, 0.0, -5.0, -8.0, 4.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(-3.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-1, 9, 5)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(9.0, -3.0, -3.0, -9.0, 5.0, 9.0, -3.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-8.0, 5.0, -5.0, 6.0, 7.0, 3.0, 5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-9.0, -1.0, 0.0, -5.0, 8.0, -2.0, 2.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(9.0, 7.0, -4.0, -1.0, -8.0, 6.0, 1.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(1.0, 0.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(3.0, 9.0, -7.0, 6.0, 1.0, 3.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(-9, -2, -3)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(-7.0, -2.0, 5.0, 3.0, -6.0, -9.0, 3.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(6.0, -3.0, 2.0, -7.0, -4.0, -1.0, -8.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(4.0, -9.0, -1.0, -5.0, 3.0, -5.0, 4.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(2.0, -1.0, -6.0, 3.0, -5.0, -7.0, 9.0, -6.0, 9.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(4.0, 7.0, 8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a[0] = (vec3(-5.0, 4.0, 2.0));
	block[0].t.a[1] = (vec3(8.0, -2.0, -2.0));
	block[0].t.a[2] = (vec3(-2.0, -7.0, -4.0));
	block[0].t.b.a = (ivec3(9, -8, -1));
	block[0].t.b.b[0][0] = (vec3(9.0, -5.0, 2.0));
	block[0].t.b.b[0][1] = (vec3(4.0, -7.0, 7.0));
	block[0].t.b.b[0][2] = (vec3(3.0, 9.0, 6.0));
	block[0].t.b.b[1][0] = (vec3(-3.0, -2.0, 2.0));
	block[0].t.b.b[1][1] = (vec3(6.0, -8.0, 9.0));
	block[0].t.b.b[1][2] = (vec3(1.0, -8.0, -4.0));
	block[0].t.b.b[2][0] = (vec3(8.0, 1.0, 7.0));
	block[0].t.b.b[2][1] = (vec3(-4.0, -2.0, 0.0));
	block[0].t.b.b[2][2] = (vec3(8.0, -3.0, 8.0));
	block[0].t.b.b[3][0] = (vec3(0.0, 7.0, -8.0));
	block[0].t.b.b[3][1] = (vec3(1.0, -9.0, 8.0));
	block[0].t.b.b[3][2] = (vec3(-1.0, -2.0, -7.0));
	block[0].t.b.c = (vec4(-5.0, 4.0, 9.0, 6.0));
	block[0].u = (5u);
	block[1].t.a[0] = (vec3(-6.0, 2.0, 3.0));
	block[1].t.a[1] = (vec3(6.0, 3.0, -2.0));
	block[1].t.a[2] = (vec3(0.0, -1.0, 2.0));
	block[1].t.b.a = (ivec3(-7, -8, -8));
	block[1].t.b.b[0][0] = (vec3(-3.0, -9.0, 1.0));
	block[1].t.b.b[0][1] = (vec3(-6.0, 7.0, -4.0));
	block[1].t.b.b[0][2] = (vec3(0.0, -3.0, -5.0));
	block[1].t.b.b[1][0] = (vec3(-2.0, -5.0, 4.0));
	block[1].t.b.b[1][1] = (vec3(-5.0, 2.0, -7.0));
	block[1].t.b.b[1][2] = (vec3(4.0, 8.0, 5.0));
	block[1].t.b.b[2][0] = (vec3(4.0, -3.0, -4.0));
	block[1].t.b.b[2][1] = (vec3(-4.0, 1.0, 2.0));
	block[1].t.b.b[2][2] = (vec3(6.0, 6.0, -3.0));
	block[1].t.b.b[3][0] = (vec3(-4.0, -9.0, -3.0));
	block[1].t.b.b[3][1] = (vec3(-2.0, -1.0, 6.0));
	block[1].t.b.b[3][2] = (vec3(7.0, -7.0, 9.0));
	block[1].t.b.c = (vec4(4.0, -2.0, -9.0, -4.0));
	block[1].u = (3u);
	block[2].t.a[0] = (vec3(2.0, 3.0, -5.0));
	block[2].t.a[1] = (vec3(-7.0, 8.0, 5.0));
	block[2].t.a[2] = (vec3(9.0, 8.0, -1.0));
	block[2].t.b.a = (ivec3(2, -4, 1));
	block[2].t.b.b[0][0] = (vec3(1.0, -3.0, 8.0));
	block[2].t.b.b[0][1] = (vec3(1.0, -3.0, 3.0));
	block[2].t.b.b[0][2] = (vec3(3.0, 1.0, 5.0));
	block[2].t.b.b[1][0] = (vec3(-9.0, 7.0, 8.0));
	block[2].t.b.b[1][1] = (vec3(-3.0, 7.0, 8.0));
	block[2].t.b.b[1][2] = (vec3(-7.0, 8.0, -9.0));
	block[2].t.b.b[2][0] = (vec3(2.0, 3.0, -8.0));
	block[2].t.b.b[2][1] = (vec3(3.0, 5.0, 8.0));
	block[2].t.b.b[2][2] = (vec3(-9.0, 3.0, -7.0));
	block[2].t.b.b[3][0] = (vec3(-8.0, -1.0, 1.0));
	block[2].t.b.b[3][1] = (vec3(2.0, 9.0, 6.0));
	block[2].t.b.b[3][2] = (vec3(-6.0, 8.0, 3.0));
	block[2].t.b.c = (vec4(-3.0, 2.0, -3.0, 1.0));
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
	allOk = compare_mat3(block.t[0].a, mat3(1.0, -4.0, 7.0, 5.0, -8.0, -8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[0].a), ivec3(-1, 6, -1)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[0]), ivec2(-7, -8)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[1]), ivec2(-6, 3)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[2]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[3]), ivec2(1, -7)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(-6.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[1].a), ivec3(7, 1, -6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[0]), ivec2(8, -5)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[1]), ivec2(-8, 1)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[2]), ivec2(-6, -6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[3]), ivec2(-4, 9)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(2.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[2].a), ivec3(7, 5, 6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[0]), ivec2(1, -6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[1]), ivec2(4, -1)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[2]), ivec2(-9, -3)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[3]), ivec2(1, 4)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(-6.0, -4.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3(block.t[1].a, mat3(9.0, 1.0, -6.0, 4.0, -9.0, 3.0, -7.0, -4.0, -4.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[0].a), ivec3(-3, -4, -8)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[0]), ivec2(9, -9)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[1]), ivec2(5, 5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[2]), ivec2(-9, 3)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[3]), ivec2(-1, -5)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(-3.0, 1.0, -5.0, 8.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[1].a), ivec3(3, 0, -6)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[0]), ivec2(2, -1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[1]), ivec2(8, 1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[2]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[3]), ivec2(-5, -6)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(-5.0, 7.0, -1.0, 6.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[2].a), ivec3(-4, -6, 4)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[0]), ivec2(-6, -9)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[1]), ivec2(-1, 1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[2]), ivec2(-8, -1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[3]), ivec2(-6, -3)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(5.0, 3.0, 6.0, -9.0)) && allOk;
	allOk = compare_uint((block.u), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(-8, -9, 6));
	block.s.b[0] = (ivec2(-6, -2));
	block.s.b[1] = (ivec2(4, -5));
	block.s.b[2] = (ivec2(-9, -7));
	block.s.b[3] = (ivec2(-1, 2));
	block.s.c = (vec4(2.0, -5.0, 0.0, -7.0));
	block.u = (3u);
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.s[0][0].a), ivec3(3, -3, -7)) && allOk;
	allOk = compare_vec4((block.s[0][0].c), vec4(8.0, -7.0, -3.0, -2.0)) && allOk;
	allOk = compare_ivec3((block.s[0][1].a), ivec3(-8, 1, 7)) && allOk;
	allOk = compare_vec4((block.s[0][1].c), vec4(-2.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_ivec3((block.s[1][0].a), ivec3(8, -8, 2)) && allOk;
	allOk = compare_vec4((block.s[1][0].c), vec4(-8.0, -9.0, 2.0, -8.0)) && allOk;
	allOk = compare_ivec3((block.s[1][1].a), ivec3(6, -9, 1)) && allOk;
	allOk = compare_vec4((block.s[1][1].c), vec4(2.0, -2.0, 6.0, 7.0)) && allOk;
	allOk = compare_ivec3((block.s[2][0].a), ivec3(8, -2, 4)) && allOk;
	allOk = compare_vec4((block.s[2][0].c), vec4(9.0, 0.0, 9.0, 7.0)) && allOk;
	allOk = compare_ivec3((block.s[2][1].a), ivec3(-4, -5, -5)) && allOk;
	allOk = compare_vec4((block.s[2][1].c), vec4(-3.0, -2.0, 6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (vec4(-2.0, 8.0, 8.0, -7.0));
	block.s[0][0].a = (ivec3(8, -2, -2));
	block.s[0][0].c = (vec4(-6.0, -4.0, -4.0, -3.0));
	block.s[0][1].a = (ivec3(-6, 9, -2));
	block.s[0][1].c = (vec4(9.0, -5.0, -4.0, 1.0));
	block.s[1][0].a = (ivec3(-6, 6, 0));
	block.s[1][0].c = (vec4(-6.0, 0.0, -2.0, -1.0));
	block.s[1][1].a = (ivec3(-5, 7, -9));
	block.s[1][1].c = (vec4(-6.0, 7.0, 8.0, -2.0));
	block.s[2][0].a = (ivec3(-6, -4, 3));
	block.s[2][0].c = (vec4(-2.0, -2.0, -8.0, 7.0));
	block.s[2][1].a = (ivec3(-9, 8, 1));
	block.s[2][1].c = (vec4(0.0, 7.0, 6.0, -5.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat2(block[0].var, mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block[1].var, mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(block[2].var, mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(-3.0, 3.0));
	block[0].var[1] = (vec2(4.0, 4.0));
	block[1].var[0] = (vec2(9.0, -9.0));
	block[1].var[1] = (vec2(-5.0, 8.0));
	block[2].var[0] = (vec2(0.0, 4.0));
	block[2].var[1] = (vec2(2.0, -4.0));
}
#version 450
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
	highp vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 7.0) && allOk;
	allOk = compare_vec3((block[0].var), vec3(9.0, -6.0, -9.0)) && allOk;
	allOk = compare_float((block[1].padding), 5.0) && allOk;
	allOk = compare_vec3((block[1].var), vec3(-8.0, 1.0, -1.0)) && allOk;
	allOk = compare_float((block[2].padding), 7.0) && allOk;
	allOk = compare_vec3((block[2].var), vec3(-1.0, -9.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (5.0);
	block[0].var = (vec3(4.0, 7.0, 8.0));
	block[1].padding = (-2.0);
	block[1].var = (vec3(7.0, -5.0, -7.0));
	block[2].padding = (9.0);
	block[2].var = (vec3(6.0, 6.0, 0.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 8.0) && allOk;
	allOk = compare_mat2(block[0].var, mat2(-9.0, -4.0, -8.0, 0.0)) && allOk;
	allOk = compare_float((block[1].padding), -8.0) && allOk;
	allOk = compare_mat2(block[1].var, mat2(-4.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_float((block[2].padding), -4.0) && allOk;
	allOk = compare_mat2(block[2].var, mat2(2.0, -3.0, 0.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-3.0);
	block[0].var[0] = (vec2(4.0, 4.0));
	block[0].var[1] = (vec2(3.0, 9.0));
	block[1].padding = (-5.0);
	block[1].var[0] = (vec2(-9.0, 0.0));
	block[1].var[1] = (vec2(8.0, 2.0));
	block[2].padding = (4.0);
	block[2].var[0] = (vec2(-4.0, -8.0));
	block[2].var[1] = (vec2(-3.0, 3.0));
}
#version 450
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
    Block block[3];
};

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
	allOk = compare_float((blockA.a), -5.0) && allOk;
	allOk = compare_uint((blockB.b.a), 4u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(-2.0, 0.0, -2.0, 7.0, -7.0, 6.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(4, 4)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(-9, -9)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(5, -7)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(-5, 7)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(-4.0, 0.0, -9.0, 8.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-9.0);
	blockA.b.a[0] = (vec3(-7.0, 5.0, -6.0));
	blockA.b.a[1] = (vec3(3.0, -3.0, -2.0));
	blockA.b.a[2] = (vec3(-9.0, 1.0, -7.0));
	blockA.b.b[0] = (ivec2(9, 9));
	blockA.b.b[1] = (ivec2(-7, -8));
	blockA.b.b[2] = (ivec2(3, -7));
	blockA.b.b[3] = (ivec2(8, 6));
	blockA.b.c = (vec4(8.0, 0.0, 5.0, -7.0));
	blockB.a[0] = (vec2(7.0, 3.0));
	blockB.a[1] = (vec2(-2.0, 9.0));
	blockB.b.a = (2u);
	blockB.b.b.a[0] = (vec3(-1.0, 9.0, 0.0));
	blockB.b.b.a[1] = (vec3(5.0, -2.0, 4.0));
	blockB.b.b.a[2] = (vec3(-3.0, 0.0, 7.0));
	blockB.b.b.b[0] = (ivec2(-2, -7));
	blockB.b.b.b[1] = (ivec2(1, 4));
	blockB.b.b.b[2] = (ivec2(-2, 5));
	blockB.b.b.b[3] = (ivec2(-7, -7));
	blockB.b.b.c = (vec4(1.0, -6.0, 2.0, 3.0));
	blockB.b.c = (bvec4(true, true, true, true));
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

layout(std430, row_major, buffer_reference) buffer BlockB
{
	mediump mat2x3 a;
	mediump ivec2 b;
	highp ivec3 c[4];
	bvec3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(6.0, 8.0, -4.0, 8.0, 0.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(9, -4)) && allOk;
	allOk = compare_ivec3((blockB.c[0]), ivec3(-6, -1, -1)) && allOk;
	allOk = compare_ivec3((blockB.c[1]), ivec3(-2, 1, 6)) && allOk;
	allOk = compare_ivec3((blockB.c[2]), ivec3(5, 7, -2)) && allOk;
	allOk = compare_ivec3((blockB.c[3]), ivec3(-4, -9, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(-5.0, -2.0, -6.0, -3.0, 0.0, 6.0));
	blockB.d[0] = (bvec3(true, true, true));
	blockB.d[1] = (bvec3(true, false, false));
	blockB.d[2] = (bvec3(true, false, true));
}
#version 450
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
	mediump vec4 a[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	mediump ivec3 b;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	mediump int c;
	bvec2 d;
	highp ivec3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockD.c), -9) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (ivec3(-8, 0, 8));
	blockD.c = (0);
	blockD.e[0] = (ivec3(2, -5, 9));
}
#version 450
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
	bool b;
	mediump mat3x4 c;
	lowp mat3 d[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp mat2x3 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	bvec3 f;
	highp mat2x3 g;
	mediump mat4 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 2u) && allOk;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_mat2x3(blockD[0].g, mat2x3(6.0, -8.0, 6.0, 6.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4(blockD[0].h, mat4(4.0, 6.0, -4.0, 0.0, 1.0, 2.0, -1.0, 9.0, -9.0, 9.0, 3.0, -9.0, 3.0, 5.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockD[1].g, mat2x3(5.0, -7.0, 6.0, -1.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4(blockD[1].h, mat4(8.0, 5.0, -4.0, -1.0, -8.0, 4.0, -7.0, 1.0, 4.0, -2.0, 0.0, -1.0, -3.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockD[2].g, mat2x3(-5.0, 9.0, -2.0, 9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat4(blockD[2].h, mat4(1.0, -5.0, 8.0, -5.0, 3.0, 9.0, 6.0, -8.0, 6.0, 4.0, 4.0, -7.0, -3.0, 7.0, -3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6u);
	blockB.c = (mat3x4(5.0, -6.0, -4.0, 0.0, -2.0, 1.0, -1.0, 0.0, 9.0, 2.0, -9.0, 6.0));
	blockB.d[0] = (mat3(-6.0, 3.0, -4.0, -5.0, 0.0, -4.0, 2.0, 4.0, 1.0));
	blockC.e[0] = (mat2x3(-6.0, 2.0, -1.0, 4.0, -4.0, -7.0));
	blockD[0].f = (bvec3(true, true, true));
	blockD[0].g = (mat2x3(2.0, 0.0, -6.0, -5.0, -6.0, 6.0));
	blockD[1].f = (bvec3(false, true, true));
	blockD[1].g = (mat2x3(-8.0, 3.0, 5.0, 5.0, -1.0, 7.0));
	blockD[2].f = (bvec3(true, false, true));
	blockD[2].g = (mat2x3(9.0, 6.0, -4.0, 0.0, -9.0, 3.0));
}
#version 450
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
	mediump int mA;
};
struct sB
{
	bool mA;
};
layout(std430, buffer_reference) buffer BlockB
{
	lowp ivec3 a;
	sA b[];
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	bvec4 c[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	mediump uvec2 d;
	lowp mat2 e;
	sB f;
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	mediump mat3x4 g;
	highp mat2x3 h;
	lowp mat3 i;
	highp mat2 j;
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(-5, 5, -6)) && allOk;
	allOk = compare_int((blockB.b[0].mA), -9) && allOk;
	allOk = compare_int((blockB.b[1].mA), 9) && allOk;
	allOk = compare_bvec4((blockC[0].c[0]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC[1].c[0]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC[1].c[1]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC[1].c[2]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockC[1].c[3]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockC[1].c[4]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC[1].c[5]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC[1].c[6]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC[1].c[7]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uvec2((blockD.d), uvec2(6u, 3u)) && allOk;
	allOk = compare_mat2(blockD.e, mat2(-1.0, 0.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockE.g, mat3x4(-5.0, 2.0, -9.0, 0.0, 5.0, -4.0, 4.0, -4.0, -1.0, -4.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockE.h, mat2x3(-1.0, 9.0, -4.0, -4.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(3, -4, 2));
	blockB.b[0].mA = (2);
	blockB.b[1].mA = (4);
	blockD.d = (uvec2(6u, 5u));
	blockD.f.mA = (false);
	blockE.g = (mat3x4(9.0, 2.0, 5.0, -2.0, -5.0, 0.0, -4.0, 9.0, 0.0, -5.0, 8.0, -4.0));
	blockE.h = (mat2x3(6.0, -6.0, 2.0, 7.0, 8.0, 7.0));
	blockE.i = (mat3(-6.0, -2.0, 8.0, 6.0, -6.0, 1.0, -8.0, 1.0, -8.0));
	blockE.j = (mat2(6.0, -7.0, 0.0, 1.0));
}
#version 450
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
	lowp mat4x3 a;
	bvec4 b;
	mediump mat4x3 c;
	highp ivec3 d[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp ivec2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.c, mat4x3(-9.0, -5.0, -2.0, 7.0, 2.0, 9.0, 0.0, 4.0, 8.0, -2.0, -7.0, 9.0)) && allOk;
	allOk = compare_ivec3((blockB.d[0]), ivec3(0, -5, 2)) && allOk;
	allOk = compare_ivec3((blockB.d[1]), ivec3(3, 8, 7)) && allOk;
	allOk = compare_ivec3((blockB.d[2]), ivec3(9, -3, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(0.0, 2.0, -8.0, -7.0, -7.0, 8.0, 3.0, 4.0, -3.0, -2.0, 6.0, 3.0));
	blockB.b = (bvec4(false, true, true, false));
	blockB.c = (mat4x3(-1.0, -9.0, -5.0, -2.0, -5.0, -2.0, 2.0, 3.0, -2.0, -3.0, 5.0, 8.0));
	blockB.d[0] = (ivec3(-3, -3, -8));
	blockB.d[1] = (ivec3(1, -3, -1));
	blockB.d[2] = (ivec3(3, 7, -4));
	blockC[0].e[0] = (ivec2(-5, -1));
	blockC[0].e[1] = (ivec2(-3, 1));
}
#version 450
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
	layout(offset = 0) mediump uint a;
	layout(offset = 4) lowp vec3 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump ivec3 c;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) highp vec4 d;
	layout(offset = 16) lowp uvec4 e;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) mediump int f;
	layout(offset = 16) mediump ivec4 g;
	layout(offset = 32) highp vec4 h[1];
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 5u) && allOk;
	allOk = compare_vec3((blockB.b), vec3(3.0, 4.0, -6.0)) && allOk;
	allOk = compare_ivec3((blockC.c), ivec3(7, 7, 6)) && allOk;
	allOk = compare_vec4((blockD.d), vec4(-9.0, 6.0, -2.0, -7.0)) && allOk;
	allOk = compare_uvec4((blockD.e), uvec4(0u, 6u, 9u, 9u)) && allOk;
	allOk = compare_int((blockE.f), 9) && allOk;
	allOk = compare_ivec4((blockE.g), ivec4(1, 4, -8, -4)) && allOk;
	allOk = compare_vec4((blockE.h[0]), vec4(-3.0, 6.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (3u);
	blockC.c = (ivec3(7, 4, -7));
	blockD.d = (vec4(-8.0, -7.0, 2.0, -1.0));
	blockE.f = (0);
	blockE.g = (ivec4(-6, 0, -8, -7));
	blockE.h[0] = (vec4(-2.0, -4.0, 5.0, 4.0));
}
#version 450
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
	lowp uint a;
	highp uint b;
	uint16_t c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 5u) && allOk;
	allOk = compare_uint((blockB.b), 7u) && allOk;
	allOk = compare_uint16_t(uint(blockB.c), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockB.b = (4u);
}
#version 450
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
	int16_t a;
	highp float b;
	mediump int c;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp uint d;
	float16_t e;
	uint16_t f;
};
layout(std430, buffer_reference) buffer BlockD
{
	float16_t g[1];
	int16_t h;
	highp float i[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.a), -8) && allOk;
	allOk = compare_float((blockB.b), -8.0) && allOk;
	allOk = compare_int((blockB.c), 0) && allOk;
	allOk = compare_uint((blockC.d), 9u) && allOk;
	allOk = compare_float16_t(float(blockC.e), -1.0) && allOk;
	allOk = compare_float16_t(float(blockD.g[0]), -4.0) && allOk;
	allOk = compare_int16_t(int(blockD.h), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int16_t(-2);
	blockB.b = (-9.0);
	blockB.c = (-3);
	blockC.d = (8u);
	blockC.e = float16_t(-2.0);
	blockC.f = uint16_t(6u);
	blockD.g[0] = float16_t(-7.0);
	blockD.i[0] = (-5.0);
}
#version 450
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
	u16vec3 a;
	u16vec4 b;
	mediump vec2 c;
	i16vec2 d;
	highp mat2x3 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	uint16_t f;
	lowp mat4x2 g[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	mediump float h[4];
	highp mat2x3 i[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB.a), uvec3(3u, 1u, 9u)) && allOk;
	allOk = compare_vec2((blockB.c), vec2(3.0, -5.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.d), ivec2(-8, -6)) && allOk;
	allOk = compare_uint16_t(uint(blockC.f), 4u) && allOk;
	allOk = compare_mat4x2(blockC.g[0], mat4x2(-1.0, -5.0, -3.0, 3.0, 2.0, 1.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[1], mat4x2(2.0, -3.0, 4.0, 9.0, -4.0, 9.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[2], mat4x2(1.0, -6.0, -7.0, -7.0, 1.0, -6.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[3], mat4x2(-1.0, 1.0, -1.0, -8.0, -9.0, 2.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[0], mat2x3(7.0, -4.0, 3.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[1], mat2x3(6.0, 6.0, -7.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[2], mat2x3(-6.0, 2.0, -8.0, 6.0, 2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec3(uvec3(3u, 2u, 9u));
	blockB.e[0] = (mat2x3(5.0, 2.0, -4.0, -8.0, 0.0, 9.0));
	blockB.e[1] = (mat2x3(3.0, 1.0, -6.0, 4.0, -4.0, -6.0));
	blockB.e[2] = (mat2x3(9.0, 3.0, 7.0, 7.0, -8.0, 5.0));
	blockB.e[3] = (mat2x3(-2.0, -7.0, -2.0, 5.0, 0.0, -1.0));
	blockB.e[4] = (mat2x3(5.0, 4.0, -9.0, -1.0, -1.0, 7.0));
	blockB.e[5] = (mat2x3(-1.0, -7.0, 7.0, 4.0, -3.0, 1.0));
	blockC.g[0] = (mat4x2(5.0, 8.0, 5.0, -1.0, -1.0, -1.0, 2.0, -8.0));
	blockC.g[1] = (mat4x2(-1.0, -2.0, -8.0, 1.0, -7.0, -3.0, 3.0, -6.0));
	blockC.g[2] = (mat4x2(1.0, -1.0, -1.0, 1.0, 2.0, -5.0, -4.0, 4.0));
	blockC.g[3] = (mat4x2(7.0, -2.0, 8.0, -5.0, -9.0, 2.0, 3.0, 1.0));
	blockD.h[0] = (-5.0);
	blockD.h[1] = (-2.0);
	blockD.h[2] = (5.0);
	blockD.h[3] = (-1.0);
	blockD.i[0] = (mat2x3(0.0, -2.0, 2.0, -7.0, -7.0, -7.0));
	blockD.i[1] = (mat2x3(9.0, -6.0, -8.0, 6.0, 5.0, 3.0));
	blockD.i[2] = (mat2x3(2.0, 4.0, -9.0, 9.0, 1.0, 6.0));
}
#version 450
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
	bvec4 a[1];
	mediump uint b[1];
	mediump mat3x4 c;
	bool d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[0].b[0]), 0u) && allOk;
	allOk = compare_mat3x4(blockB[0].c, mat3x4(-6.0, 6.0, 8.0, 7.0, 4.0, -6.0, 1.0, 5.0, 5.0, 1.0, -7.0, 8.0)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b[0]), 5u) && allOk;
	allOk = compare_mat3x4(blockB[1].c, mat3x4(-9.0, 3.0, 8.0, 6.0, 1.0, 6.0, 6.0, 7.0, 1.0, -3.0, -4.0, 5.0)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_uint((blockB[2].b[0]), 8u) && allOk;
	allOk = compare_mat3x4(blockB[2].c, mat3x4(-1.0, -7.0, 6.0, 9.0, 1.0, -7.0, 7.0, 1.0, 7.0, 7.0, 2.0, 5.0)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (bvec4(true, true, false, false));
	blockB[0].b[0] = (3u);
	blockB[0].c = (mat3x4(5.0, 6.0, 5.0, 4.0, 4.0, 7.0, -2.0, 7.0, 8.0, -5.0, 7.0, 0.0));
	blockB[0].d = (true);
	blockB[1].a[0] = (bvec4(false, false, false, false));
	blockB[1].b[0] = (2u);
	blockB[1].c = (mat3x4(-2.0, -6.0, -3.0, -6.0, -4.0, -4.0, -6.0, -7.0, 8.0, 6.0, 8.0, -1.0));
	blockB[1].d = (false);
	blockB[2].a[0] = (bvec4(false, false, true, true));
	blockB[2].b[0] = (2u);
	blockB[2].c = (mat3x4(-1.0, -7.0, 7.0, -3.0, -2.0, 8.0, 9.0, -4.0, -3.0, -6.0, 8.0, 4.0));
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

layout(std430, buffer_reference) buffer BlockB
{
	f16vec3 a;
	highp vec4 b;
	uint16_t c;
	mediump uvec4 d;
	bool e[][6];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	u16vec3 f;
	int16_t g[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	mediump vec4 h;
	highp mat3x4 i;
	highp vec3 j;
	float16_t k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB[0].a), vec3(2.0, -8.0, -4.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].c), 0u) && allOk;
	allOk = compare_f16vec3(vec3(blockB[1].a), vec3(2.0, 9.0, 1.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[1].c), 3u) && allOk;
	allOk = compare_int16_t(int(blockC.g[0]), 0) && allOk;
	allOk = compare_int16_t(int(blockC.g[1]), -5) && allOk;
	allOk = compare_int16_t(int(blockC.g[2]), 3) && allOk;
	allOk = compare_int16_t(int(blockC.g[3]), -8) && allOk;
	allOk = compare_int16_t(int(blockC.g[4]), 6) && allOk;
	allOk = compare_int16_t(int(blockC.g[5]), -6) && allOk;
	allOk = compare_mat3x4(blockD[0].i, mat3x4(4.0, 4.0, 1.0, -4.0, 4.0, 5.0, 6.0, -5.0, 7.0, 6.0, 9.0, 9.0)) && allOk;
	allOk = compare_float16_t(float(blockD[0].k[0]), -5.0) && allOk;
	allOk = compare_float16_t(float(blockD[0].k[1]), -5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = f16vec3(vec3(8.0, -2.0, -1.0));
	blockB[0].b = (vec4(-6.0, 6.0, 0.0, 9.0));
	blockB[0].c = uint16_t(8u);
	blockB[0].d = (uvec4(3u, 7u, 7u, 5u));
	blockB[0].e[0][0] = (false);
	blockB[0].e[0][1] = (false);
	blockB[0].e[0][2] = (true);
	blockB[0].e[0][3] = (true);
	blockB[0].e[0][4] = (true);
	blockB[0].e[0][5] = (true);
	blockB[0].e[1][0] = (false);
	blockB[0].e[1][1] = (false);
	blockB[0].e[1][2] = (false);
	blockB[0].e[1][3] = (true);
	blockB[0].e[1][4] = (false);
	blockB[0].e[1][5] = (true);
	blockB[0].e[2][0] = (false);
	blockB[0].e[2][1] = (true);
	blockB[0].e[2][2] = (true);
	blockB[0].e[2][3] = (true);
	blockB[0].e[2][4] = (false);
	blockB[0].e[2][5] = (false);
	blockB[0].e[3][0] = (false);
	blockB[0].e[3][1] = (false);
	blockB[0].e[3][2] = (true);
	blockB[0].e[3][3] = (true);
	blockB[0].e[3][4] = (true);
	blockB[0].e[3][5] = (false);
	blockB[0].e[4][0] = (false);
	blockB[0].e[4][1] = (false);
	blockB[0].e[4][2] = (false);
	blockB[0].e[4][3] = (false);
	blockB[0].e[4][4] = (true);
	blockB[0].e[4][5] = (false);
	blockB[1].a = f16vec3(vec3(-3.0, -4.0, 4.0));
	blockB[1].b = (vec4(9.0, 0.0, 1.0, 2.0));
	blockB[1].c = uint16_t(5u);
	blockB[1].d = (uvec4(1u, 5u, 5u, 3u));
	blockB[1].e[0][0] = (false);
	blockB[1].e[0][1] = (true);
	blockB[1].e[0][2] = (true);
	blockB[1].e[0][3] = (true);
	blockB[1].e[0][4] = (true);
	blockB[1].e[0][5] = (true);
	blockB[1].e[1][0] = (false);
	blockB[1].e[1][1] = (true);
	blockB[1].e[1][2] = (false);
	blockB[1].e[1][3] = (true);
	blockB[1].e[1][4] = (false);
	blockB[1].e[1][5] = (true);
	blockB[1].e[2][0] = (false);
	blockB[1].e[2][1] = (false);
	blockB[1].e[2][2] = (true);
	blockB[1].e[2][3] = (false);
	blockB[1].e[2][4] = (true);
	blockB[1].e[2][5] = (true);
	blockB[1].e[3][0] = (true);
	blockB[1].e[3][1] = (false);
	blockB[1].e[3][2] = (true);
	blockB[1].e[3][3] = (false);
	blockB[1].e[3][4] = (false);
	blockB[1].e[3][5] = (true);
	blockC.f = u16vec3(uvec3(9u, 4u, 8u));
	blockC.g[0] = int16_t(-5);
	blockC.g[1] = int16_t(-8);
	blockC.g[2] = int16_t(-9);
	blockC.g[3] = int16_t(9);
	blockC.g[4] = int16_t(5);
	blockC.g[5] = int16_t(1);
	blockD[0].h = (vec4(-7.0, 3.0, -7.0, -4.0));
	blockD[0].k[0] = float16_t(2.0);
	blockD[0].k[1] = float16_t(2.0);
}
#version 450
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
	mediump ivec4 a[7];
	bvec2 b;
	uint16_t c;
	bvec2 d;
	highp uint e;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump float f;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	f16vec3 g;
	i16vec4 h[2];
	float16_t i[8];
	i16vec4 j[7];
	bvec2 k[][4];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a[0]), ivec4(1, 2, 2, 2)) && allOk;
	allOk = compare_ivec4((blockB.a[1]), ivec4(-1, -3, 2, -3)) && allOk;
	allOk = compare_ivec4((blockB.a[2]), ivec4(-9, 2, -1, -3)) && allOk;
	allOk = compare_ivec4((blockB.a[3]), ivec4(-9, -8, 0, -6)) && allOk;
	allOk = compare_ivec4((blockB.a[4]), ivec4(-5, -1, -3, 5)) && allOk;
	allOk = compare_ivec4((blockB.a[5]), ivec4(3, -3, 5, -7)) && allOk;
	allOk = compare_ivec4((blockB.a[6]), ivec4(1, 9, -2, 8)) && allOk;
	allOk = compare_uint16_t(uint(blockB.c), 9u) && allOk;
	allOk = compare_f16vec3(vec3(blockD.g), vec3(5.0, -5.0, 7.0)) && allOk;
	allOk = compare_float16_t(float(blockD.i[0]), -6.0) && allOk;
	allOk = compare_float16_t(float(blockD.i[1]), -4.0) && allOk;
	allOk = compare_float16_t(float(blockD.i[2]), 3.0) && allOk;
	allOk = compare_float16_t(float(blockD.i[3]), 7.0) && allOk;
	allOk = compare_float16_t(float(blockD.i[4]), -1.0) && allOk;
	allOk = compare_float16_t(float(blockD.i[5]), 7.0) && allOk;
	allOk = compare_float16_t(float(blockD.i[6]), -1.0) && allOk;
	allOk = compare_float16_t(float(blockD.i[7]), -5.0) && allOk;
	allOk = compare_bvec2((blockD.k[0][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD.k[0][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.k[0][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD.k[0][3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD.k[1][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD.k[1][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD.k[1][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.k[1][3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD.k[2][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD.k[2][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD.k[2][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.k[2][3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD.k[3][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD.k[3][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.k[3][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD.k[3][3]), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec4(-8, -4, -7, 2));
	blockB.a[1] = (ivec4(-2, 1, 6, -8));
	blockB.a[2] = (ivec4(6, -1, -9, 3));
	blockB.a[3] = (ivec4(-6, 4, -7, 6));
	blockB.a[4] = (ivec4(-5, -4, 8, -7));
	blockB.a[5] = (ivec4(4, -3, -3, 5));
	blockB.a[6] = (ivec4(6, 7, -8, 3));
	blockB.d = (bvec2(true, true));
	blockC[0].f = (9.0);
	blockD.g = f16vec3(vec3(0.0, -6.0, -7.0));
	blockD.h[0] = i16vec4(ivec4(1, -2, 8, -2));
	blockD.h[1] = i16vec4(ivec4(4, 9, 4, 8));
	blockD.i[0] = float16_t(2.0);
	blockD.i[1] = float16_t(-4.0);
	blockD.i[2] = float16_t(6.0);
	blockD.i[3] = float16_t(1.0);
	blockD.i[4] = float16_t(3.0);
	blockD.i[5] = float16_t(-7.0);
	blockD.i[6] = float16_t(-3.0);
	blockD.i[7] = float16_t(4.0);
	blockD.k[0][0] = (bvec2(true, true));
	blockD.k[0][1] = (bvec2(false, false));
	blockD.k[0][2] = (bvec2(false, false));
	blockD.k[0][3] = (bvec2(true, true));
	blockD.k[1][0] = (bvec2(true, true));
	blockD.k[1][1] = (bvec2(false, true));
	blockD.k[1][2] = (bvec2(true, true));
	blockD.k[1][3] = (bvec2(true, true));
	blockD.k[2][0] = (bvec2(true, false));
	blockD.k[2][1] = (bvec2(true, true));
	blockD.k[2][2] = (bvec2(true, true));
	blockD.k[2][3] = (bvec2(false, false));
	blockD.k[3][0] = (bvec2(true, true));
	blockD.k[3][1] = (bvec2(false, true));
	blockD.k[3][2] = (bvec2(true, true));
	blockD.k[3][3] = (bvec2(true, false));
}
#version 450
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
	mediump uint mB[7];
	highp mat3x2 mC;
	f16vec2 mD;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	sA a;
	highp ivec2 b[5];
	u16vec2 c;
	bvec4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a.mA), vec3(6.0, -3.0, 6.0)) && allOk;
	allOk = compare_uint((blockB.a.mB[0]), 7u) && allOk;
	allOk = compare_uint((blockB.a.mB[1]), 7u) && allOk;
	allOk = compare_uint((blockB.a.mB[2]), 2u) && allOk;
	allOk = compare_uint((blockB.a.mB[3]), 1u) && allOk;
	allOk = compare_uint((blockB.a.mB[4]), 5u) && allOk;
	allOk = compare_uint((blockB.a.mB[5]), 3u) && allOk;
	allOk = compare_uint((blockB.a.mB[6]), 3u) && allOk;
	allOk = compare_mat3x2(blockB.a.mC, mat3x2(-4.0, -5.0, -1.0, 4.0, -5.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.a.mD), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockB.d[0]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((blockB.d[1]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockB.d[2]), bvec4(true, false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (vec3(6.0, 9.0, -9.0));
	blockB.a.mB[0] = (9u);
	blockB.a.mB[1] = (6u);
	blockB.a.mB[2] = (0u);
	blockB.a.mB[3] = (2u);
	blockB.a.mB[4] = (4u);
	blockB.a.mB[5] = (2u);
	blockB.a.mB[6] = (0u);
	blockB.a.mC = (mat3x2(-6.0, 3.0, 3.0, -3.0, 7.0, 2.0));
	blockB.a.mD = f16vec2(vec2(-9.0, -4.0));
	blockB.b[0] = (ivec2(8, -3));
	blockB.b[1] = (ivec2(-3, 5));
	blockB.b[2] = (ivec2(1, 7));
	blockB.b[3] = (ivec2(9, -3));
	blockB.b[4] = (ivec2(7, 7));
	blockB.c = u16vec2(uvec2(8u, 2u));
}
#version 450
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
	i16vec4 a;
	mediump uvec2 b;
	highp mat4x3 c;
	highp vec2 d[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp int e;
	mediump vec4 f;
	mediump ivec4 g;
	lowp int h[];
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp uvec3 i;
	f16vec3 j;
	highp vec3 k[];
};
layout(std430, buffer_reference) buffer BlockE
{
	uint16_t l[3];
	u16vec3 m[2];
	f16vec3 n;
	u16vec3 o[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.a), ivec4(2, -4, -7, 7)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(9u, 6u)) && allOk;
	allOk = compare_mat4x3(blockB.c, mat4x3(-2.0, -6.0, -4.0, 9.0, 7.0, 0.0, 4.0, -6.0, -1.0, -8.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(9.0, -6.0, 7.0, -4.0)) && allOk;
	allOk = compare_int((blockC.h[0]), 8) && allOk;
	allOk = compare_int((blockC.h[1]), 8) && allOk;
	allOk = compare_int((blockC.h[2]), -1) && allOk;
	allOk = compare_int((blockC.h[3]), 7) && allOk;
	allOk = compare_int((blockC.h[4]), -8) && allOk;
	allOk = compare_int((blockC.h[5]), 9) && allOk;
	allOk = compare_int((blockC.h[6]), 4) && allOk;
	allOk = compare_f16vec3(vec3(blockD.j), vec3(8.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec3((blockD.k[0]), vec3(3.0, -9.0, -1.0)) && allOk;
	allOk = compare_vec3((blockD.k[1]), vec3(0.0, 8.0, -4.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.m[0]), uvec3(6u, 2u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.m[1]), uvec3(8u, 4u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.h[0] = (2);
	blockC.h[1] = (7);
	blockC.h[2] = (-3);
	blockC.h[3] = (2);
	blockC.h[4] = (9);
	blockC.h[5] = (-6);
	blockC.h[6] = (-1);
	blockD.j = f16vec3(vec3(4.0, 1.0, -6.0));
	blockD.k[0] = (vec3(5.0, -9.0, -1.0));
	blockD.k[1] = (vec3(8.0, 6.0, -1.0));
	blockE.l[0] = uint16_t(3u);
	blockE.l[1] = uint16_t(6u);
	blockE.l[2] = uint16_t(9u);
	blockE.o[0] = u16vec3(uvec3(9u, 8u, 3u));
	blockE.o[1] = u16vec3(uvec3(4u, 6u, 2u));
	blockE.o[2] = u16vec3(uvec3(8u, 2u, 7u));
	blockE.o[3] = u16vec3(uvec3(4u, 2u, 9u));
	blockE.o[4] = u16vec3(uvec3(9u, 9u, 5u));
}
#version 450
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
	layout(offset = 8) uint16_t b;
	layout(offset = 10) i16vec3 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) int16_t d;
	layout(offset = 16) highp ivec4 e[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
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
	allOk = compare_int16_t(int(blockC.d), 5) && allOk;
	allOk = compare_ivec4((blockC.e[0]), ivec4(-7, -3, -9, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = uint16_t(2u);
	blockB[1].b = uint16_t(1u);
	blockB[2].b = uint16_t(9u);
	blockC.d = int16_t(2);
	blockC.e[0] = (ivec4(-4, -6, 7, 1));
}
#version 450
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
	layout(offset = 0) mediump int a[1];
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp uvec4 b;
	layout(offset = 16) lowp uvec2 c;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) i16vec4 d;
	layout(offset = 8) i16vec4 e;
	layout(offset = 16) mediump ivec2 f;
	layout(offset = 32) lowp uvec3 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockC.b), uvec4(0u, 1u, 4u, 0u)) && allOk;
	allOk = compare_uvec2((blockC.c), uvec2(7u, 2u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.d), ivec4(9, -8, 0, 1)) && allOk;
	allOk = compare_uvec3((blockD.g), uvec3(8u, 9u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (-7);
	blockB[1].a[0] = (-2);
	blockC.b = (uvec4(1u, 0u, 9u, 7u));
	blockC.c = (uvec2(7u, 0u));
	blockD.d = i16vec4(ivec4(9, -4, 3, -8));
	blockD.e = i16vec4(ivec4(-8, -8, -4, 2));
	blockD.f = (ivec2(-8, -2));
	blockD.g = (uvec3(3u, 4u, 0u));
}
#version 450
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
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump float b;
	layout(offset = 4) bvec3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockC.b), -3.0) && allOk;
	allOk = compare_bvec3((blockC.c), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(7, -1, 7, 8));
	blockC.b = (0.0);
	blockC.c = (bvec3(false, true, true));
}
#version 450
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
	uint16_t mA;
	bool mB;
	lowp mat2x3 mC;
};
struct sC
{
	mediump vec3 mA;
};
struct sD
{
	bvec3 mA;
	highp float mB;
	sC mC;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	float16_t a;
	mediump mat4x2 b[4];
	mediump vec3 c[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	highp mat3 d;
	lowp ivec2 e;
	i16vec4 f;
	highp uvec4 g[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	lowp uvec3 h;
	u16vec4 i;
	sA j;
	sB k;
	sD l;
};
layout(scalar, row_major, buffer_reference) buffer BlockE
{
	float16_t m[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.b[0], mat4x2(-3.0, -2.0, 9.0, 6.0, 4.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[1], mat4x2(4.0, -1.0, 8.0, -2.0, 2.0, -1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[2], mat4x2(-2.0, -8.0, -3.0, 7.0, -8.0, 7.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[3], mat4x2(-1.0, 3.0, -1.0, -1.0, -7.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec3((blockB.c[0]), vec3(-7.0, -5.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB.c[1]), vec3(-8.0, 3.0, -7.0)) && allOk;
	allOk = compare_uvec4((blockC.g[0]), uvec4(8u, 6u, 9u, 3u)) && allOk;
	allOk = compare_uvec4((blockC.g[1]), uvec4(9u, 8u, 5u, 7u)) && allOk;
	allOk = compare_uvec4((blockC.g[2]), uvec4(5u, 5u, 9u, 9u)) && allOk;
	allOk = compare_uvec4((blockC.g[3]), uvec4(7u, 9u, 9u, 6u)) && allOk;
	allOk = compare_uvec4((blockC.g[4]), uvec4(4u, 0u, 4u, 7u)) && allOk;
	allOk = compare_uvec3((blockD[0].h), uvec3(3u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[0].i), uvec4(1u, 2u, 0u, 8u)) && allOk;
	allOk = compare_uint((blockD[0].j.mA), 1u) && allOk;
	allOk = compare_bvec3((blockD[0].l.mA), bvec3(false, true, false)) && allOk;
	allOk = compare_float((blockD[0].l.mB), -3.0) && allOk;
	allOk = compare_vec3((blockD[0].l.mC.mA), vec3(3.0, 5.0, -6.0)) && allOk;
	allOk = compare_uvec3((blockD[1].h), uvec3(8u, 0u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[1].i), uvec4(3u, 4u, 7u, 9u)) && allOk;
	allOk = compare_uint((blockD[1].j.mA), 2u) && allOk;
	allOk = compare_bvec3((blockD[1].l.mA), bvec3(true, true, false)) && allOk;
	allOk = compare_float((blockD[1].l.mB), 0.0) && allOk;
	allOk = compare_vec3((blockD[1].l.mC.mA), vec3(0.0, -1.0, 6.0)) && allOk;
	allOk = compare_uvec3((blockD[2].h), uvec3(6u, 4u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[2].i), uvec4(4u, 2u, 0u, 4u)) && allOk;
	allOk = compare_uint((blockD[2].j.mA), 3u) && allOk;
	allOk = compare_bvec3((blockD[2].l.mA), bvec3(true, true, true)) && allOk;
	allOk = compare_float((blockD[2].l.mB), 5.0) && allOk;
	allOk = compare_vec3((blockD[2].l.mC.mA), vec3(8.0, -7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(2.0);
	blockB.b[0] = (mat4x2(9.0, 4.0, -1.0, -7.0, -2.0, -7.0, 4.0, 8.0));
	blockB.b[1] = (mat4x2(1.0, 7.0, -6.0, 1.0, 9.0, 5.0, 4.0, 2.0));
	blockB.b[2] = (mat4x2(-1.0, -5.0, -4.0, 6.0, 9.0, 0.0, 9.0, -7.0));
	blockB.b[3] = (mat4x2(-8.0, -5.0, 3.0, 4.0, -2.0, 4.0, 9.0, 3.0));
	blockC.e = (ivec2(-2, -2));
	blockC.g[0] = (uvec4(2u, 0u, 4u, 8u));
	blockC.g[1] = (uvec4(2u, 0u, 3u, 9u));
	blockC.g[2] = (uvec4(7u, 4u, 9u, 6u));
	blockC.g[3] = (uvec4(9u, 4u, 0u, 1u));
	blockC.g[4] = (uvec4(1u, 5u, 2u, 3u));
	blockD[0].h = (uvec3(5u, 9u, 4u));
	blockD[0].i = u16vec4(uvec4(2u, 2u, 4u, 7u));
	blockD[0].j.mA = (5u);
	blockD[0].l.mA = (bvec3(true, false, false));
	blockD[0].l.mB = (-9.0);
	blockD[0].l.mC.mA = (vec3(3.0, -1.0, -3.0));
	blockD[1].h = (uvec3(7u, 7u, 6u));
	blockD[1].i = u16vec4(uvec4(4u, 4u, 5u, 3u));
	blockD[1].j.mA = (3u);
	blockD[1].l.mA = (bvec3(true, false, true));
	blockD[1].l.mB = (-7.0);
	blockD[1].l.mC.mA = (vec3(1.0, 3.0, -6.0));
	blockD[2].h = (uvec3(8u, 2u, 4u));
	blockD[2].i = u16vec4(uvec4(3u, 1u, 1u, 3u));
	blockD[2].j.mA = (1u);
	blockD[2].l.mA = (bvec3(true, true, false));
	blockD[2].l.mB = (9.0);
	blockD[2].l.mC.mA = (vec3(2.0, 4.0, 3.0));
	blockE.m[0] = float16_t(6.0);
	blockE.m[1] = float16_t(-6.0);
	blockE.m[2] = float16_t(1.0);
	blockE.m[3] = float16_t(-4.0);
}
#version 450
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
	highp uvec2 a;
	float16_t b;
	i16vec2 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].a), uvec2(0u, 2u)) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(0)].b), 8.0) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(0)].c), ivec2(0, -4)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].a), uvec2(0u, 9u)) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(1)].b), -4.0) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(1)].c), ivec2(-6, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = float16_t(-2.0);
	blockB[nonuniformEXT(1)].b = float16_t(3.0);
}
#version 450
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
	highp mat4x2 a;
	lowp uvec2 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].b), uvec2(4u, 1u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].b), uvec2(4u, 5u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(2)].b), uvec2(5u, 4u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(3)].b), uvec2(4u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (uvec2(5u, 2u));
	blockB[nonuniformEXT(1)].b = (uvec2(5u, 8u));
	blockB[nonuniformEXT(2)].b = (uvec2(0u, 3u));
	blockB[nonuniformEXT(3)].b = (uvec2(2u, 4u));
}
#version 450
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
	layout(offset = 0) uint16_t a;
	layout(offset = 2) f16vec4 b;
	layout(offset = 10) uint16_t c;
	layout(offset = 16) mediump uvec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(0)].a), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(1)].a), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(2)].a), 3u) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(3)].a), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = f16vec4(vec4(-1.0, 8.0, -4.0, 7.0));
	blockB[nonuniformEXT(0)].d = (uvec4(7u, 1u, 7u, 5u));
	blockB[nonuniformEXT(1)].b = f16vec4(vec4(1.0, 9.0, -4.0, -9.0));
	blockB[nonuniformEXT(1)].d = (uvec4(9u, 0u, 2u, 3u));
	blockB[nonuniformEXT(2)].b = f16vec4(vec4(9.0, -9.0, 4.0, -3.0));
	blockB[nonuniformEXT(2)].d = (uvec4(3u, 8u, 7u, 9u));
	blockB[nonuniformEXT(3)].b = f16vec4(vec4(-4.0, -9.0, -6.0, 4.0));
	blockB[nonuniformEXT(3)].d = (uvec4(5u, 9u, 7u, 1u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, buffer_reference) readonly buffer BlockB
{
	uint8_t a;
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump float b;
};
layout(std140, buffer_reference) buffer BlockD
{
	bool c;
	lowp int d[1];
	highp int e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.a), 7u) && allOk;
	allOk = compare_float((blockC.b), -3.0) && allOk;
	allOk = compare_bool((blockD.c), false) && allOk;
	allOk = compare_int((blockD.d[0]), -4) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (7.0);
	blockD.c = (true);
}
#version 450
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
	i8vec2 a;
	mediump uvec3 b;
	uint8_t c;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uvec4 d;
	lowp uvec3 e;
	bvec2 f;
	mediump mat4 g[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	mediump mat4 h;
	highp vec3 i;
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	highp mat2x3 j;
	mediump mat2 k[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.a), ivec2(2, 7)) && allOk;
	allOk = compare_uvec4((blockC.d), uvec4(6u, 5u, 8u, 8u)) && allOk;
	allOk = compare_mat2x3(blockE.j, mat2x3(2.0, 0.0, -9.0, 3.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(blockE.k[0], mat2(-2.0, 1.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2(blockE.k[1], mat2(-9.0, 4.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2(blockE.k[2], mat2(-3.0, 9.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat2(blockE.k[3], mat2(-8.0, -7.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2(blockE.k[4], mat2(-6.0, 5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2(blockE.k[5], mat2(5.0, 3.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2(blockE.k[6], mat2(-8.0, -7.0, 5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.g[0] = (mat4(-6.0, 9.0, 4.0, -5.0, 5.0, -1.0, 4.0, -7.0, 5.0, -6.0, 4.0, -3.0, 9.0, 0.0, -8.0, 6.0));
	blockC.g[1] = (mat4(-8.0, -7.0, -2.0, 5.0, 1.0, 3.0, -3.0, -1.0, 1.0, -6.0, -5.0, -4.0, -2.0, 8.0, -7.0, 4.0));
	blockD.i = (vec3(5.0, -2.0, -3.0));
	blockE.j = (mat2x3(-9.0, -4.0, 3.0, 7.0, -6.0, -7.0));
	blockE.k[0] = (mat2(-4.0, -4.0, 2.0, -3.0));
	blockE.k[1] = (mat2(3.0, 0.0, 2.0, 8.0));
	blockE.k[2] = (mat2(8.0, -6.0, -2.0, 7.0));
	blockE.k[3] = (mat2(1.0, -1.0, 9.0, -8.0));
	blockE.k[4] = (mat2(1.0, -2.0, 0.0, -8.0));
	blockE.k[5] = (mat2(7.0, -5.0, -6.0, -6.0));
	blockE.k[6] = (mat2(-7.0, 9.0, -5.0, 6.0));
}
#version 450
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
	lowp vec3 b[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	bvec2 c[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	i8vec2 d[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	uint8_t e;
	mediump int f;
	lowp float g[1];
	int8_t h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
    BlockE blockE[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_vec3((blockB.b[0]), vec3(3.0, -8.0, 3.0)) && allOk;
	allOk = compare_bvec2((blockC.c[0]), bvec2(false, true)) && allOk;
	allOk = compare_uint8_t(uint(blockE[0].e), 7u) && allOk;
	allOk = compare_float((blockE[0].g[0]), -6.0) && allOk;
	allOk = compare_int8_t(int(blockE[0].h[0]), 4294967293) && allOk;
	allOk = compare_uint8_t(uint(blockE[1].e), 9u) && allOk;
	allOk = compare_float((blockE[1].g[0]), 1.0) && allOk;
	allOk = compare_int8_t(int(blockE[1].h[0]), 2) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(-7.0, 3.0));
	blockB.b[0] = (vec3(-9.0, -7.0, -4.0));
	blockC.c[0] = (bvec2(true, false));
	blockD[0].d[0] = i8vec2(ivec2(4294967292, 3));
	blockD[1].d[0] = i8vec2(ivec2(4294967289, 4294967292));
	blockD[2].d[0] = i8vec2(ivec2(0, 4294967289));
	blockE[0].e = uint8_t(6u);
	blockE[0].g[0] = (-4.0);
	blockE[0].h[0] = int8_t(4294967289);
	blockE[1].e = uint8_t(4u);
	blockE[1].g[0] = (-9.0);
	blockE[1].h[0] = int8_t(9);
}
#version 450
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
};
struct sB
{
	highp mat3x4 mA;
	u8vec4 mB;
	u8vec4 mC;
	lowp mat4x2 mD;
};
struct sC
{
	bvec4 mA[6];
	u8vec3 mB;
	highp vec4 mC;
};
struct sD
{
	sB mA;
	int8_t mB;
	sC mC[8];
	int8_t mD;
};
struct sE
{
	lowp int mA;
	u8vec2 mB;
};
struct sF
{
	mediump mat4x3 mA[8];
	lowp mat4x2 mB;
	mediump mat3 mC;
	highp vec4 mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	highp mat2x3 a;
	mediump ivec3 b;
	sA c;
	mediump mat4x2 d;
	lowp mat3 e[];
};
layout(std140, buffer_reference) buffer BlockC
{
	sD f;
	sE g;
	mediump uvec3 h;
	sF i;
	u8vec3 j[];
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp ivec3 k;
	highp mat4 l[];
};
layout(std430, buffer_reference) buffer BlockE
{
	highp mat3 m;
	bool n[][7];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.c.mA), ivec3(4, -4, -9)) && allOk;
	allOk = compare_mat3x4(blockC.f.mA.mA, mat3x4(1.0, -7.0, 8.0, 8.0, 0.0, -2.0, -5.0, -7.0, -8.0, 0.0, -6.0, 5.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.f.mA.mB), uvec4(2u, 1u, 9u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.f.mA.mC), uvec4(1u, 4u, 9u, 9u)) && allOk;
	allOk = compare_mat4x2(blockC.f.mA.mD, mat4x2(-9.0, -8.0, 4.0, -7.0, 6.0, 6.0, 9.0, 3.0)) && allOk;
	allOk = compare_int8_t(int(blockC.f.mB), 4294967287) && allOk;
	allOk = compare_bvec4((blockC.f.mC[0].mA[0]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[0].mA[1]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[0].mA[2]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[0].mA[3]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[0].mA[4]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[0].mA[5]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f.mC[0].mB), uvec3(1u, 1u, 6u)) && allOk;
	allOk = compare_vec4((blockC.f.mC[0].mC), vec4(0.0, -6.0, -1.0, 7.0)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[1].mA[0]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[1].mA[1]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[1].mA[2]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[1].mA[3]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[1].mA[4]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[1].mA[5]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f.mC[1].mB), uvec3(0u, 8u, 3u)) && allOk;
	allOk = compare_vec4((blockC.f.mC[1].mC), vec4(7.0, 6.0, -8.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[2].mA[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[2].mA[1]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[2].mA[2]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[2].mA[3]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[2].mA[4]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[2].mA[5]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f.mC[2].mB), uvec3(4u, 9u, 8u)) && allOk;
	allOk = compare_vec4((blockC.f.mC[2].mC), vec4(-1.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[3].mA[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[3].mA[1]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[3].mA[2]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[3].mA[3]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[3].mA[4]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[3].mA[5]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f.mC[3].mB), uvec3(9u, 3u, 3u)) && allOk;
	allOk = compare_vec4((blockC.f.mC[3].mC), vec4(-2.0, 1.0, -5.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[4].mA[0]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[4].mA[1]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[4].mA[2]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[4].mA[3]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[4].mA[4]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[4].mA[5]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f.mC[4].mB), uvec3(7u, 6u, 3u)) && allOk;
	allOk = compare_vec4((blockC.f.mC[4].mC), vec4(-9.0, 3.0, -4.0, -9.0)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[5].mA[0]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[5].mA[1]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[5].mA[2]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[5].mA[3]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[5].mA[4]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[5].mA[5]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f.mC[5].mB), uvec3(4u, 6u, 6u)) && allOk;
	allOk = compare_vec4((blockC.f.mC[5].mC), vec4(2.0, -5.0, 0.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[6].mA[0]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[6].mA[1]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[6].mA[2]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[6].mA[3]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[6].mA[4]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[6].mA[5]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f.mC[6].mB), uvec3(6u, 2u, 0u)) && allOk;
	allOk = compare_vec4((blockC.f.mC[6].mC), vec4(-3.0, -4.0, 4.0, -2.0)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[7].mA[0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[7].mA[1]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[7].mA[2]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[7].mA[3]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[7].mA[4]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f.mC[7].mA[5]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f.mC[7].mB), uvec3(4u, 4u, 7u)) && allOk;
	allOk = compare_vec4((blockC.f.mC[7].mC), vec4(8.0, 5.0, -2.0, 2.0)) && allOk;
	allOk = compare_int8_t(int(blockC.f.mD), 4294967289) && allOk;
	allOk = compare_mat4x3(blockC.i.mA[0], mat4x3(-9.0, 0.0, -8.0, 9.0, 9.0, -2.0, -6.0, 8.0, 5.0, -3.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockC.i.mA[1], mat4x3(-5.0, 8.0, -3.0, -4.0, 8.0, 4.0, 5.0, -8.0, -5.0, 2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockC.i.mA[2], mat4x3(7.0, 3.0, 3.0, 3.0, 1.0, -7.0, -6.0, -1.0, -3.0, 0.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockC.i.mA[3], mat4x3(2.0, 8.0, 4.0, -4.0, 2.0, 2.0, -6.0, 9.0, 1.0, -9.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockC.i.mA[4], mat4x3(-3.0, 2.0, -5.0, -2.0, -3.0, 5.0, -4.0, -2.0, 8.0, 8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockC.i.mA[5], mat4x3(7.0, -1.0, -1.0, -5.0, 7.0, 7.0, -6.0, -1.0, 4.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockC.i.mA[6], mat4x3(-9.0, -2.0, 0.0, 2.0, 1.0, -8.0, -2.0, -3.0, 9.0, -7.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockC.i.mA[7], mat4x3(3.0, 6.0, -4.0, 3.0, 8.0, 6.0, -9.0, 5.0, 7.0, 8.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockC.i.mB, mat4x2(-9.0, 5.0, -2.0, 8.0, 5.0, 6.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(blockC.i.mC, mat3(-7.0, -4.0, -9.0, 7.0, -5.0, -8.0, 5.0, 6.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC.i.mD), vec4(-9.0, -9.0, 4.0, -1.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.j[0]), uvec3(9u, 6u, 6u)) && allOk;
	allOk = compare_mat3(blockE.m, mat3(9.0, -2.0, 1.0, 3.0, -8.0, -2.0, -7.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c.mA = (ivec3(-5, -2, 4));
	blockB.d = (mat4x2(-2.0, 5.0, -9.0, -3.0, -1.0, -9.0, 1.0, 1.0));
	blockB.e[0] = (mat3(7.0, 8.0, 9.0, -7.0, -1.0, -6.0, 5.0, 6.0, 5.0));
	blockB.e[1] = (mat3(6.0, -6.0, -9.0, 3.0, -7.0, -4.0, -6.0, -5.0, 3.0));
	blockB.e[2] = (mat3(-9.0, -6.0, -3.0, -7.0, -1.0, -5.0, 6.0, -5.0, -6.0));
	blockB.e[3] = (mat3(8.0, 9.0, 6.0, -9.0, 4.0, 7.0, -3.0, 0.0, 8.0));
	blockB.e[4] = (mat3(-9.0, -1.0, 8.0, 3.0, -6.0, 7.0, 0.0, 5.0, -9.0));
	blockB.e[5] = (mat3(0.0, -2.0, -6.0, -3.0, -7.0, 9.0, 5.0, -5.0, -2.0));
	blockC.f.mA.mA = (mat3x4(1.0, 8.0, -2.0, -4.0, -5.0, 8.0, -8.0, -8.0, 6.0, 4.0, 5.0, 8.0));
	blockC.f.mA.mB = u8vec4(uvec4(1u, 8u, 1u, 3u));
	blockC.f.mA.mC = u8vec4(uvec4(7u, 2u, 0u, 4u));
	blockC.f.mA.mD = (mat4x2(1.0, 6.0, 9.0, -8.0, -1.0, 5.0, -6.0, -8.0));
	blockC.f.mB = int8_t(3);
	blockC.f.mC[0].mA[0] = (bvec4(true, false, false, true));
	blockC.f.mC[0].mA[1] = (bvec4(false, true, false, true));
	blockC.f.mC[0].mA[2] = (bvec4(true, false, false, true));
	blockC.f.mC[0].mA[3] = (bvec4(true, true, false, false));
	blockC.f.mC[0].mA[4] = (bvec4(false, false, false, true));
	blockC.f.mC[0].mA[5] = (bvec4(false, false, false, true));
	blockC.f.mC[0].mB = u8vec3(uvec3(6u, 6u, 0u));
	blockC.f.mC[0].mC = (vec4(-9.0, -7.0, 6.0, -2.0));
	blockC.f.mC[1].mA[0] = (bvec4(false, false, true, false));
	blockC.f.mC[1].mA[1] = (bvec4(false, true, true, true));
	blockC.f.mC[1].mA[2] = (bvec4(false, false, false, false));
	blockC.f.mC[1].mA[3] = (bvec4(true, true, false, false));
	blockC.f.mC[1].mA[4] = (bvec4(true, true, true, false));
	blockC.f.mC[1].mA[5] = (bvec4(true, true, false, true));
	blockC.f.mC[1].mB = u8vec3(uvec3(3u, 0u, 9u));
	blockC.f.mC[1].mC = (vec4(-1.0, -8.0, -7.0, 9.0));
	blockC.f.mC[2].mA[0] = (bvec4(false, true, true, true));
	blockC.f.mC[2].mA[1] = (bvec4(true, true, true, false));
	blockC.f.mC[2].mA[2] = (bvec4(false, false, false, false));
	blockC.f.mC[2].mA[3] = (bvec4(true, true, true, true));
	blockC.f.mC[2].mA[4] = (bvec4(true, true, false, false));
	blockC.f.mC[2].mA[5] = (bvec4(true, true, false, true));
	blockC.f.mC[2].mB = u8vec3(uvec3(2u, 7u, 8u));
	blockC.f.mC[2].mC = (vec4(7.0, -6.0, -4.0, -2.0));
	blockC.f.mC[3].mA[0] = (bvec4(false, true, true, true));
	blockC.f.mC[3].mA[1] = (bvec4(false, true, false, true));
	blockC.f.mC[3].mA[2] = (bvec4(true, true, true, false));
	blockC.f.mC[3].mA[3] = (bvec4(true, true, false, false));
	blockC.f.mC[3].mA[4] = (bvec4(true, true, false, true));
	blockC.f.mC[3].mA[5] = (bvec4(false, false, true, false));
	blockC.f.mC[3].mB = u8vec3(uvec3(5u, 7u, 4u));
	blockC.f.mC[3].mC = (vec4(3.0, 2.0, -3.0, 8.0));
	blockC.f.mC[4].mA[0] = (bvec4(true, false, false, false));
	blockC.f.mC[4].mA[1] = (bvec4(true, true, false, false));
	blockC.f.mC[4].mA[2] = (bvec4(false, false, true, true));
	blockC.f.mC[4].mA[3] = (bvec4(true, false, true, false));
	blockC.f.mC[4].mA[4] = (bvec4(true, false, false, true));
	blockC.f.mC[4].mA[5] = (bvec4(false, true, true, false));
	blockC.f.mC[4].mB = u8vec3(uvec3(5u, 6u, 5u));
	blockC.f.mC[4].mC = (vec4(-1.0, 7.0, 7.0, -6.0));
	blockC.f.mC[5].mA[0] = (bvec4(true, true, false, true));
	blockC.f.mC[5].mA[1] = (bvec4(false, false, false, false));
	blockC.f.mC[5].mA[2] = (bvec4(false, true, true, true));
	blockC.f.mC[5].mA[3] = (bvec4(true, false, true, true));
	blockC.f.mC[5].mA[4] = (bvec4(true, true, false, false));
	blockC.f.mC[5].mA[5] = (bvec4(true, true, false, false));
	blockC.f.mC[5].mB = u8vec3(uvec3(7u, 1u, 2u));
	blockC.f.mC[5].mC = (vec4(-8.0, 7.0, -6.0, -6.0));
	blockC.f.mC[6].mA[0] = (bvec4(true, true, true, true));
	blockC.f.mC[6].mA[1] = (bvec4(true, false, true, false));
	blockC.f.mC[6].mA[2] = (bvec4(true, false, true, true));
	blockC.f.mC[6].mA[3] = (bvec4(false, true, true, true));
	blockC.f.mC[6].mA[4] = (bvec4(true, false, true, false));
	blockC.f.mC[6].mA[5] = (bvec4(false, false, false, false));
	blockC.f.mC[6].mB = u8vec3(uvec3(5u, 4u, 3u));
	blockC.f.mC[6].mC = (vec4(-8.0, 3.0, -2.0, -7.0));
	blockC.f.mC[7].mA[0] = (bvec4(true, false, false, false));
	blockC.f.mC[7].mA[1] = (bvec4(true, false, false, false));
	blockC.f.mC[7].mA[2] = (bvec4(false, false, false, false));
	blockC.f.mC[7].mA[3] = (bvec4(false, true, false, true));
	blockC.f.mC[7].mA[4] = (bvec4(true, false, true, false));
	blockC.f.mC[7].mA[5] = (bvec4(true, true, false, true));
	blockC.f.mC[7].mB = u8vec3(uvec3(0u, 3u, 1u));
	blockC.f.mC[7].mC = (vec4(-1.0, -9.0, -3.0, -8.0));
	blockC.f.mD = int8_t(4294967294);
	blockC.g.mA = (-3);
	blockC.g.mB = u8vec2(uvec2(0u, 4u));
	blockC.h = (uvec3(2u, 5u, 0u));
	blockC.j[0] = u8vec3(uvec3(1u, 9u, 0u));
	blockD.k = (ivec3(7, 7, 8));
	blockE.m = (mat3(0.0, 5.0, 3.0, -7.0, 8.0, -5.0, -7.0, -9.0, 0.0));
}
#version 450
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
layout(std430, column_major, buffer_reference) buffer BlockB
{
	sA a;
	int8_t b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

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

layout(std430, buffer_reference) buffer BlockB
{
	u8vec3 a;
	highp mat2 b[][4];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump mat2 c[];
};
layout(std430, buffer_reference) buffer BlockD
{
	highp vec2 d;
	highp vec2 e;
	lowp uvec3 f;
	highp vec4 g;
	lowp uvec3 h[];
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
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.a), uvec3(5u, 7u, 4u)) && allOk;
	allOk = compare_vec2((blockD.e), vec2(-9.0, -1.0)) && allOk;
	allOk = compare_uvec3((blockD.f), uvec3(3u, 1u, 1u)) && allOk;
	allOk = compare_uvec3((blockD.h[0]), uvec3(2u, 2u, 9u)) && allOk;
	allOk = compare_uvec3((blockD.h[1]), uvec3(0u, 4u, 9u)) && allOk;
	allOk = compare_uvec3((blockD.h[2]), uvec3(0u, 5u, 5u)) && allOk;
	allOk = compare_uvec3((blockD.h[3]), uvec3(6u, 0u, 7u)) && allOk;
	allOk = compare_uvec3((blockD.h[4]), uvec3(3u, 1u, 5u)) && allOk;
	allOk = compare_uvec3((blockD.h[5]), uvec3(0u, 0u, 7u)) && allOk;
	allOk = compare_uvec3((blockD.h[6]), uvec3(2u, 4u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec3(uvec3(9u, 2u, 5u));
	blockB.b[0][0] = (mat2(-7.0, 6.0, 2.0, -8.0));
	blockB.b[0][1] = (mat2(7.0, 6.0, -4.0, 5.0));
	blockB.b[0][2] = (mat2(7.0, 9.0, -2.0, 6.0));
	blockB.b[0][3] = (mat2(4.0, 0.0, 7.0, 5.0));
	blockB.b[1][0] = (mat2(-3.0, 1.0, 0.0, -8.0));
	blockB.b[1][1] = (mat2(-8.0, 5.0, 2.0, 6.0));
	blockB.b[1][2] = (mat2(6.0, -9.0, 7.0, 6.0));
	blockB.b[1][3] = (mat2(3.0, 9.0, -8.0, 1.0));
	blockB.b[2][0] = (mat2(4.0, -5.0, 0.0, -7.0));
	blockB.b[2][1] = (mat2(-1.0, 7.0, 9.0, 5.0));
	blockB.b[2][2] = (mat2(-4.0, -6.0, 0.0, -8.0));
	blockB.b[2][3] = (mat2(-2.0, 5.0, -8.0, 0.0));
	blockB.b[3][0] = (mat2(-6.0, 9.0, 3.0, -2.0));
	blockB.b[3][1] = (mat2(9.0, -1.0, 8.0, 4.0));
	blockB.b[3][2] = (mat2(9.0, -5.0, 8.0, 0.0));
	blockB.b[3][3] = (mat2(3.0, 8.0, 9.0, 3.0));
	blockB.b[4][0] = (mat2(-9.0, 6.0, 7.0, 3.0));
	blockB.b[4][1] = (mat2(2.0, -5.0, 6.0, 3.0));
	blockB.b[4][2] = (mat2(-9.0, 6.0, 8.0, 1.0));
	blockB.b[4][3] = (mat2(-3.0, -2.0, -8.0, 1.0));
	blockB.b[5][0] = (mat2(-4.0, -7.0, 7.0, 9.0));
	blockB.b[5][1] = (mat2(9.0, -1.0, -1.0, 0.0));
	blockB.b[5][2] = (mat2(-6.0, -6.0, 7.0, 9.0));
	blockB.b[5][3] = (mat2(0.0, -6.0, 7.0, 4.0));
	blockB.b[6][0] = (mat2(-6.0, -6.0, 1.0, -1.0));
	blockB.b[6][1] = (mat2(-9.0, 7.0, -5.0, 0.0));
	blockB.b[6][2] = (mat2(-4.0, 7.0, 2.0, -2.0));
	blockB.b[6][3] = (mat2(7.0, -4.0, 7.0, 2.0));
	blockC.c[0] = (mat2(8.0, -9.0, -2.0, -8.0));
	blockD.d = (vec2(9.0, -3.0));
	blockD.e = (vec2(-1.0, -4.0));
	blockD.f = (uvec3(5u, 3u, 1u));
	blockD.g = (vec4(-1.0, 3.0, 6.0, 8.0));
	blockD.h[0] = (uvec3(8u, 8u, 4u));
	blockD.h[1] = (uvec3(5u, 5u, 7u));
	blockD.h[2] = (uvec3(6u, 9u, 7u));
	blockD.h[3] = (uvec3(9u, 6u, 8u));
	blockD.h[4] = (uvec3(2u, 0u, 7u));
	blockD.h[5] = (uvec3(2u, 6u, 5u));
	blockD.h[6] = (uvec3(7u, 7u, 6u));
}
#version 450
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
	bvec3 a;
	mediump mat4 b[][1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp ivec2 a;
	mediump mat4 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(0, 6)) && allOk;
	allOk = compare_mat4(blockB.b[0], mat4(5.0, 9.0, -8.0, 6.0, -8.0, 2.0, 1.0, -9.0, 4.0, -4.0, -2.0, 7.0, 2.0, -4.0, 7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat4(-1.0, -1.0, -1.0, -7.0, 2.0, -3.0, -3.0, 5.0, 2.0, 2.0, 4.0, 9.0, 3.0, -6.0, -7.0, -9.0));
}
#version 450
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
	lowp vec2 a;
	u8vec4 b;
	highp float c;
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	highp mat4x3 d;
	highp int e[5];
	i8vec4 f;
	mediump ivec4 g;
	lowp uvec2 h[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	mediump ivec4 i[5];
	mediump ivec4 j[][6];
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
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-8.0, 4.0)) && allOk;
	allOk = compare_float((blockB.c), 0.0) && allOk;
	allOk = compare_mat4x3(blockC.d, mat4x3(6.0, -5.0, 1.0, 4.0, -4.0, 9.0, -1.0, 2.0, -2.0, 2.0, 4.0, 6.0)) && allOk;
	allOk = compare_int((blockC.e[0]), 8) && allOk;
	allOk = compare_int((blockC.e[1]), 0) && allOk;
	allOk = compare_int((blockC.e[2]), 1) && allOk;
	allOk = compare_int((blockC.e[3]), 3) && allOk;
	allOk = compare_int((blockC.e[4]), -1) && allOk;
	allOk = compare_uvec2((blockC.h[0]), uvec2(5u, 9u)) && allOk;
	allOk = compare_uvec2((blockC.h[1]), uvec2(4u, 5u)) && allOk;
	allOk = compare_uvec2((blockC.h[2]), uvec2(2u, 4u)) && allOk;
	allOk = compare_uvec2((blockC.h[3]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((blockC.h[4]), uvec2(6u, 1u)) && allOk;
	allOk = compare_uvec2((blockC.h[5]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((blockC.h[6]), uvec2(2u, 4u)) && allOk;
	allOk = compare_ivec4((blockD.j[0][0]), ivec4(-1, -5, -5, 2)) && allOk;
	allOk = compare_ivec4((blockD.j[0][1]), ivec4(-5, -5, 4, 2)) && allOk;
	allOk = compare_ivec4((blockD.j[0][2]), ivec4(9, 3, 6, -1)) && allOk;
	allOk = compare_ivec4((blockD.j[0][3]), ivec4(2, 9, 9, -9)) && allOk;
	allOk = compare_ivec4((blockD.j[0][4]), ivec4(7, 4, 0, -2)) && allOk;
	allOk = compare_ivec4((blockD.j[0][5]), ivec4(0, -5, 5, 0)) && allOk;
	allOk = compare_ivec4((blockD.j[1][0]), ivec4(0, 9, -5, -7)) && allOk;
	allOk = compare_ivec4((blockD.j[1][1]), ivec4(-7, 4, 0, 5)) && allOk;
	allOk = compare_ivec4((blockD.j[1][2]), ivec4(9, -1, -9, -2)) && allOk;
	allOk = compare_ivec4((blockD.j[1][3]), ivec4(-8, 6, 5, 0)) && allOk;
	allOk = compare_ivec4((blockD.j[1][4]), ivec4(-4, -9, 0, -4)) && allOk;
	allOk = compare_ivec4((blockD.j[1][5]), ivec4(-7, -5, 8, -3)) && allOk;
	allOk = compare_ivec4((blockD.j[2][0]), ivec4(-4, -8, -9, -2)) && allOk;
	allOk = compare_ivec4((blockD.j[2][1]), ivec4(-9, 7, 0, 2)) && allOk;
	allOk = compare_ivec4((blockD.j[2][2]), ivec4(1, -8, -4, -6)) && allOk;
	allOk = compare_ivec4((blockD.j[2][3]), ivec4(1, 0, -9, 8)) && allOk;
	allOk = compare_ivec4((blockD.j[2][4]), ivec4(-3, 3, 2, 0)) && allOk;
	allOk = compare_ivec4((blockD.j[2][5]), ivec4(-1, 9, 3, 3)) && allOk;
	allOk = compare_ivec4((blockD.j[3][0]), ivec4(-8, -1, 8, -8)) && allOk;
	allOk = compare_ivec4((blockD.j[3][1]), ivec4(-8, 5, -2, 2)) && allOk;
	allOk = compare_ivec4((blockD.j[3][2]), ivec4(-6, -7, 7, 1)) && allOk;
	allOk = compare_ivec4((blockD.j[3][3]), ivec4(9, -2, 3, 3)) && allOk;
	allOk = compare_ivec4((blockD.j[3][4]), ivec4(4, -9, 0, 5)) && allOk;
	allOk = compare_ivec4((blockD.j[3][5]), ivec4(6, 8, 6, -9)) && allOk;
	allOk = compare_ivec4((blockD.j[4][0]), ivec4(-5, -2, 2, -2)) && allOk;
	allOk = compare_ivec4((blockD.j[4][1]), ivec4(-2, -4, 7, -8)) && allOk;
	allOk = compare_ivec4((blockD.j[4][2]), ivec4(2, 6, -8, -6)) && allOk;
	allOk = compare_ivec4((blockD.j[4][3]), ivec4(8, 3, 6, 5)) && allOk;
	allOk = compare_ivec4((blockD.j[4][4]), ivec4(-7, 0, -4, -8)) && allOk;
	allOk = compare_ivec4((blockD.j[4][5]), ivec4(8, 1, -3, -3)) && allOk;
	allOk = compare_ivec4((blockD.j[5][0]), ivec4(4, -8, -5, -4)) && allOk;
	allOk = compare_ivec4((blockD.j[5][1]), ivec4(6, 7, 9, -4)) && allOk;
	allOk = compare_ivec4((blockD.j[5][2]), ivec4(7, -9, -6, 4)) && allOk;
	allOk = compare_ivec4((blockD.j[5][3]), ivec4(8, 6, -8, -8)) && allOk;
	allOk = compare_ivec4((blockD.j[5][4]), ivec4(-7, 6, -8, 0)) && allOk;
	allOk = compare_ivec4((blockD.j[5][5]), ivec4(2, 5, -4, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = u8vec4(uvec4(7u, 5u, 6u, 0u));
	blockB.c = (0.0);
	blockC.d = (mat4x3(8.0, 3.0, -1.0, -5.0, 3.0, -7.0, 7.0, 0.0, -8.0, 4.0, 7.0, 6.0));
	blockC.e[0] = (-8);
	blockC.e[1] = (-5);
	blockC.e[2] = (-9);
	blockC.e[3] = (-1);
	blockC.e[4] = (-5);
	blockC.f = i8vec4(ivec4(4294967294, 4294967288, 8, 4294967294));
	blockC.g = (ivec4(4, -6, -7, 7));
	blockC.h[0] = (uvec2(3u, 4u));
	blockC.h[1] = (uvec2(5u, 8u));
	blockC.h[2] = (uvec2(6u, 4u));
	blockC.h[3] = (uvec2(5u, 5u));
	blockC.h[4] = (uvec2(0u, 4u));
	blockC.h[5] = (uvec2(3u, 9u));
	blockC.h[6] = (uvec2(4u, 1u));
	blockD.i[0] = (ivec4(3, 5, -4, -7));
	blockD.i[1] = (ivec4(2, 8, -2, -4));
	blockD.i[2] = (ivec4(-2, -4, -5, 3));
	blockD.i[3] = (ivec4(-2, -3, -9, -5));
	blockD.i[4] = (ivec4(-7, -9, -7, 4));
	blockD.j[0][0] = (ivec4(-7, -9, 8, 4));
	blockD.j[0][1] = (ivec4(-5, -5, 2, 3));
	blockD.j[0][2] = (ivec4(-6, 7, -1, 8));
	blockD.j[0][3] = (ivec4(3, 2, -4, -1));
	blockD.j[0][4] = (ivec4(-9, 4, -9, -3));
	blockD.j[0][5] = (ivec4(-6, 6, -7, 1));
	blockD.j[1][0] = (ivec4(3, 8, -3, -9));
	blockD.j[1][1] = (ivec4(7, 3, 2, 0));
	blockD.j[1][2] = (ivec4(6, -7, 0, -6));
	blockD.j[1][3] = (ivec4(-4, -7, 5, 3));
	blockD.j[1][4] = (ivec4(4, -4, -5, -1));
	blockD.j[1][5] = (ivec4(3, -5, -7, -1));
	blockD.j[2][0] = (ivec4(4, -8, 9, -9));
	blockD.j[2][1] = (ivec4(1, 9, 3, -5));
	blockD.j[2][2] = (ivec4(-7, -4, 7, -7));
	blockD.j[2][3] = (ivec4(3, -3, -1, 9));
	blockD.j[2][4] = (ivec4(1, -9, 4, 7));
	blockD.j[2][5] = (ivec4(-7, -1, -9, 5));
	blockD.j[3][0] = (ivec4(3, 0, -6, -5));
	blockD.j[3][1] = (ivec4(-4, 3, 1, 5));
	blockD.j[3][2] = (ivec4(3, -6, -3, 0));
	blockD.j[3][3] = (ivec4(-8, 4, 7, -5));
	blockD.j[3][4] = (ivec4(7, 3, -7, 9));
	blockD.j[3][5] = (ivec4(-2, 8, -6, -6));
	blockD.j[4][0] = (ivec4(-7, -3, 8, -7));
	blockD.j[4][1] = (ivec4(-1, 0, -2, 4));
	blockD.j[4][2] = (ivec4(-2, -4, -5, -5));
	blockD.j[4][3] = (ivec4(6, -2, -8, 7));
	blockD.j[4][4] = (ivec4(2, 9, 4, -6));
	blockD.j[4][5] = (ivec4(3, 0, -4, -1));
	blockD.j[5][0] = (ivec4(6, 1, -8, -8));
	blockD.j[5][1] = (ivec4(8, 2, -5, -1));
	blockD.j[5][2] = (ivec4(8, 7, -8, 2));
	blockD.j[5][3] = (ivec4(-5, -6, -9, 0));
	blockD.j[5][4] = (ivec4(2, -3, 2, 4));
	blockD.j[5][5] = (ivec4(-3, -6, 1, -5));
}
#version 450
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
	lowp uvec3 a;
	u8vec3 b;
	u8vec2 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[nonuniformEXT(0)].a), uvec3(0u, 2u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(0)].b), uvec3(4u, 4u, 0u)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(1)].a), uvec3(5u, 6u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(1)].b), uvec3(4u, 1u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (uvec3(4u, 1u, 0u));
	blockB[nonuniformEXT(0)].b = u8vec3(uvec3(6u, 8u, 2u));
	blockB[nonuniformEXT(0)].c = u8vec2(uvec2(2u, 8u));
	blockB[nonuniformEXT(1)].a = (uvec3(6u, 5u, 9u));
	blockB[nonuniformEXT(1)].b = u8vec3(uvec3(9u, 4u, 7u));
	blockB[nonuniformEXT(1)].c = u8vec2(uvec2(7u, 8u));
}
#version 450
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
	lowp mat2 a;
	lowp ivec3 b;
	mediump vec2 c;
	mediump int d;
	mediump uvec2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB[nonuniformEXT(0)].a, mat2(1.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].c), vec2(2.0, 8.0)) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(0)].d), 7) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(1)].a, mat2(2.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].c), vec2(7.0, 4.0)) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(1)].d), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (ivec3(-8, -5, 0));
	blockB[nonuniformEXT(0)].c = (vec2(0.0, -7.0));
	blockB[nonuniformEXT(0)].d = (5);
	blockB[nonuniformEXT(0)].e = (uvec2(1u, 5u));
	blockB[nonuniformEXT(1)].b = (ivec3(8, 0, 8));
	blockB[nonuniformEXT(1)].c = (vec2(-6.0, 5.0));
	blockB[nonuniformEXT(1)].d = (1);
	blockB[nonuniformEXT(1)].e = (uvec2(2u, 9u));
}
