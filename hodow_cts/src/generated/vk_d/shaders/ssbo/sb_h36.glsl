#version 450
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
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((var), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (bvec2(true, false));
}
#version 450
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
	allOk = compare_mat4(var, mat4(5.0, 3.0, 1.0, 5.0, -4.0, 3.0, -7.0, 3.0, -7.0, -6.0, 6.0, -4.0, 1.0, 8.0, -5.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-2.0, 8.0, -3.0, -1.0));
	var[1] = (vec4(6.0, -9.0, -1.0, -9.0));
	var[2] = (vec4(-4.0, -3.0, 5.0, 3.0));
	var[3] = (vec4(7.0, 6.0, 9.0, 0.0));
}
#version 450
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
	allOk = compare_mat4(var, mat4(-3.0, 2.0, 9.0, -4.0, -9.0, -4.0, -5.0, -8.0, 0.0, -8.0, 6.0, -4.0, -6.0, -7.0, -3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4(2.0, 5.0, 1.0, -7.0, -8.0, 5.0, 6.0, 2.0, -2.0, 6.0, 3.0, -3.0, 5.0, -8.0, 1.0, 1.0));
}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], 5.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-2.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, 4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(-6.0, 8.0, -1.0, -4.0, -5.0, 4.0));
}
#version 450
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
	highp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[0][3], -7.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[1][3], 7.0) && allOk;
	allOk = compare_float(var[2][0], 9.0) && allOk;
	allOk = compare_float(var[2][1], 2.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[2][3], -8.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-4.0, -4.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-2.0, -7.0, 1.0, 7.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(9.0, 2.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-3.0, -1.0, -6.0, -7.0));
	var[1] = (vec4(-3.0, -8.0, 8.0, 3.0));
	var[2] = (vec4(-2.0, 9.0, 7.0, 0.0));
}
#version 450
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
	highp vec2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var), vec2(6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (vec2(7.0, -3.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(-2.0, 1.0, 2.0, 1.0, -6.0, -9.0, 7.0, 0.0, -3.0, -2.0, -3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(2.0, -6.0, -3.0, 1.0, -1.0, 0.0, 4.0, -4.0, -6.0, 0.0, 2.0, -7.0));
}
#version 450
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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat2(var, mat2(2.0, -4.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0] = (vec2(0.0, 7.0));
	var[1] = (vec2(5.0, 7.0));
}
#version 450
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

	padding = (0.0);
	var = (mat2x4(-2.0, -8.0, -1.0, 8.0, 1.0, 1.0, 2.0, -5.0));
}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(-8.0, -3.0, 4.0, -5.0, -8.0, 3.0, 2.0, -4.0, -1.0, -2.0, -5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var[0] = (vec4(6.0, -2.0, 8.0, -8.0));
	var[1] = (vec4(4.0, -8.0, -3.0, -9.0));
	var[2] = (vec4(8.0, -6.0, 0.0, 5.0));
}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	var[1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	var[2] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
}
#version 450
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
	highp mat4 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	var[0][1] = (vec4(2.0, -4.0, 3.0, -5.0));
	var[0][2] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[0][3] = (vec4(3.0, 0.0, -4.0, -1.0));
	var[1][0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	var[1][1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	var[1][2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	var[1][3] = (vec4(6.0, -9.0, -1.0, -5.0));
	var[2][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	var[2][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	var[2][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	var[2][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
}
#version 450
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

	var[0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	var[0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	var[1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	var[1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	var[2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	var[2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
}
#version 450
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
	highp vec2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var[0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((var[1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[2]), vec2(-7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(3.0, 8.0));
	var[1] = (vec2(7.0, -1.0));
	var[2] = (vec2(-4.0, 8.0));
}
#version 450
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

	var[0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	var[1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	var[2] = u8vec4(uvec4(6u, 7u, 1u, 9u));
}
#version 450
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
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(-8.0, -3.0, -8.0, 8.0, -2.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(3.0, -6.0, 9.0, -3.0, 1.0, 0.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(2.0, -4.0, 5.0, -1.0, 4.0, -2.0, 4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0] = (vec4(-4.0, -6.0, -3.0, 6.0));
	var[0][1] = (vec4(4.0, -6.0, 2.0, -5.0));
	var[1][0] = (vec4(1.0, 7.0, 0.0, 9.0));
	var[1][1] = (vec4(1.0, 6.0, 1.0, 8.0));
	var[2][0] = (vec4(-6.0, 5.0, 5.0, -6.0));
	var[2][1] = (vec4(6.0, -7.0, -4.0, 5.0));
}
#version 450
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
	highp int var[];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var[0]), 6) && allOk;
	allOk = compare_int((var[1]), 0) && allOk;
	allOk = compare_int((var[2]), 9) && allOk;
	allOk = compare_int((var[3]), -6) && allOk;
	allOk = compare_int((var[4]), -9) && allOk;
	allOk = compare_int((var[5]), -8) && allOk;
	allOk = compare_int((var[6]), 8) && allOk;
	allOk = compare_int((var[7]), -9) && allOk;
	allOk = compare_int((var[8]), -1) && allOk;
	allOk = compare_int((var[9]), 0) && allOk;
	allOk = compare_int((var[10]), -9) && allOk;
	allOk = compare_int((var[11]), 5) && allOk;
	allOk = compare_int((var[12]), 5) && allOk;
	allOk = compare_int((var[13]), -3) && allOk;
	allOk = compare_int((var[14]), 4) && allOk;
	allOk = compare_int((var[15]), 4) && allOk;
	allOk = compare_int((var[16]), -9) && allOk;
	allOk = compare_int((var[17]), -9) && allOk;
	allOk = compare_int((var[18]), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (8);
	var[1] = (2);
	var[2] = (-5);
	var[3] = (0);
	var[4] = (-7);
	var[5] = (-7);
	var[6] = (-8);
	var[7] = (6);
	var[8] = (-6);
	var[9] = (6);
	var[10] = (-5);
	var[11] = (5);
	var[12] = (-4);
	var[13] = (9);
	var[14] = (-8);
	var[15] = (4);
	var[16] = (-4);
	var[17] = (5);
	var[18] = (-3);
}
#version 450
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

	var[0] = (mat2(3.0, 1.0, -4.0, -2.0));
	var[1] = (mat2(1.0, -4.0, -1.0, -3.0));
	var[2] = (mat2(-8.0, 5.0, -6.0, -2.0));
	var[3] = (mat2(8.0, -5.0, 0.0, -2.0));
	var[4] = (mat2(-1.0, -6.0, 4.0, -4.0));
	var[5] = (mat2(9.0, 7.0, -9.0, 0.0));
	var[6] = (mat2(2.0, -5.0, 9.0, 6.0));
	var[7] = (mat2(5.0, 8.0, -5.0, -7.0));
	var[8] = (mat2(-2.0, -9.0, -1.0, 8.0));
	var[9] = (mat2(-7.0, 5.0, -9.0, 3.0));
	var[10] = (mat2(-3.0, -1.0, -2.0, -9.0));
	var[11] = (mat2(5.0, 8.0, -2.0, 4.0));
	var[12] = (mat2(8.0, -7.0, 0.0, -7.0));
	var[13] = (mat2(-6.0, 8.0, 5.0, 2.0));
	var[14] = (mat2(5.0, -4.0, 3.0, 8.0));
	var[15] = (mat2(0.0, -2.0, 7.0, 4.0));
	var[16] = (mat2(4.0, -4.0, 0.0, 7.0));
	var[17] = (mat2(-7.0, 7.0, -1.0, 4.0));
	var[18] = (mat2(6.0, 1.0, 8.0, -1.0));
}
#version 450
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

	var[0] = (ivec2(-6, 8));
	var[1] = (ivec2(3, -1));
	var[2] = (ivec2(-5, -2));
	var[3] = (ivec2(0, -2));
	var[4] = (ivec2(5, 2));
	var[5] = (ivec2(-8, 4));
	var[6] = (ivec2(-6, -4));
	var[7] = (ivec2(3, -2));
	var[8] = (ivec2(5, -7));
	var[9] = (ivec2(-3, 4));
	var[10] = (ivec2(1, 6));
	var[11] = (ivec2(8, 7));
	var[12] = (ivec2(4, 1));
	var[13] = (ivec2(1, 9));
	var[14] = (ivec2(-2, -9));
	var[15] = (ivec2(9, 6));
	var[16] = (ivec2(-8, 1));
	var[17] = (ivec2(-3, 2));
	var[18] = (ivec2(-3, -1));
}
#version 450
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
	highp mat2x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	var[0][1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	var[0][2] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
	var[1][0] = (mat2x4(-7.0, -4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0));
	var[1][1] = (mat2x4(0.0, -4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0));
	var[1][2] = (mat2x4(3.0, -8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0));
	var[2][0] = (mat2x4(4.0, -7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0));
	var[2][1] = (mat2x4(-2.0, 1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0));
	var[2][2] = (mat2x4(-8.0, 7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0));
	var[3][0] = (mat2x4(2.0, 9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0));
	var[3][1] = (mat2x4(5.0, -9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0));
	var[3][2] = (mat2x4(-6.0, -9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0));
}
#version 450
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
	allOk = compare_mat3x4(var[0][0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	var[0][0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	var[0][0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	var[0][1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	var[0][1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	var[0][1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	var[0][2][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	var[0][2][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	var[0][2][2] = (vec4(0.0, 4.0, 1.0, -9.0));
	var[1][0][0] = (vec4(3.0, -3.0, 5.0, 9.0));
	var[1][0][1] = (vec4(4.0, -2.0, -3.0, -6.0));
	var[1][0][2] = (vec4(8.0, 9.0, -9.0, -5.0));
	var[1][1][0] = (vec4(3.0, 4.0, -1.0, -5.0));
	var[1][1][1] = (vec4(9.0, -2.0, 4.0, -9.0));
	var[1][1][2] = (vec4(1.0, -8.0, -2.0, 1.0));
	var[1][2][0] = (vec4(-8.0, -2.0, 9.0, 8.0));
	var[1][2][1] = (vec4(-5.0, -8.0, -2.0, 7.0));
	var[1][2][2] = (vec4(-3.0, -9.0, 0.0, -9.0));
	var[2][0][0] = (vec4(7.0, 4.0, -2.0, -4.0));
	var[2][0][1] = (vec4(6.0, -9.0, -7.0, 3.0));
	var[2][0][2] = (vec4(-3.0, -6.0, -1.0, 0.0));
	var[2][1][0] = (vec4(2.0, 3.0, -1.0, 9.0));
	var[2][1][1] = (vec4(-3.0, -9.0, -1.0, 0.0));
	var[2][1][2] = (vec4(-9.0, 1.0, 6.0, 5.0));
	var[2][2][0] = (vec4(-8.0, 4.0, -8.0, 5.0));
	var[2][2][1] = (vec4(4.0, 3.0, -7.0, 5.0));
	var[2][2][2] = (vec4(-4.0, 7.0, 2.0, -6.0));
	var[3][0][0] = (vec4(-2.0, 4.0, -9.0, -3.0));
	var[3][0][1] = (vec4(7.0, 5.0, -1.0, 1.0));
	var[3][0][2] = (vec4(6.0, -2.0, -5.0, 9.0));
	var[3][1][0] = (vec4(-6.0, 2.0, 5.0, -5.0));
	var[3][1][1] = (vec4(2.0, 4.0, -3.0, 1.0));
	var[3][1][2] = (vec4(9.0, -1.0, -1.0, -1.0));
	var[3][2][0] = (vec4(7.0, -4.0, -7.0, -3.0));
	var[3][2][1] = (vec4(9.0, -7.0, -5.0, -9.0));
	var[3][2][2] = (vec4(3.0, 9.0, 2.0, -5.0));
}
#version 450
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
	highp vec4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var[0][0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((var[0][1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((var[0][2]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((var[1][0]), vec4(-3.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4((var[1][1]), vec4(-1.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[1][2]), vec4(7.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[2][0]), vec4(6.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((var[2][1]), vec4(8.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((var[2][2]), vec4(-7.0, 2.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((var[3][0]), vec4(-1.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((var[3][1]), vec4(8.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((var[3][2]), vec4(3.0, -4.0, 2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	var[0][1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	var[0][2] = (vec4(5.0, -9.0, 4.0, -1.0));
	var[1][0] = (vec4(-7.0, -6.0, -2.0, -8.0));
	var[1][1] = (vec4(8.0, 7.0, 5.0, 1.0));
	var[1][2] = (vec4(-6.0, -5.0, -8.0, 8.0));
	var[2][0] = (vec4(0.0, 8.0, 4.0, -4.0));
	var[2][1] = (vec4(-8.0, -3.0, 9.0, -7.0));
	var[2][2] = (vec4(-9.0, 2.0, -6.0, 6.0));
	var[3][0] = (vec4(6.0, 2.0, -3.0, 0.0));
	var[3][1] = (vec4(-9.0, 8.0, -8.0, 0.0));
	var[3][2] = (vec4(2.0, 6.0, 6.0, 1.0));
}
#version 450
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
	highp mat3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(3.0, 7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(4.0, 9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(-9.0, -9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(-2.0, -1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(-4.0, 9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(6.0, -4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(0.0, 5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(-3.0, -7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(8.0, 4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(2.0, -4.0, 9.0));
	var[0][0][1] = (vec3(-4.0, 2.0, 5.0));
	var[0][0][2] = (vec3(5.0, -9.0, -5.0));
	var[0][1][0] = (vec3(3.0, 1.0, 8.0));
	var[0][1][1] = (vec3(6.0, 9.0, -8.0));
	var[0][1][2] = (vec3(-1.0, 5.0, 1.0));
	var[0][2][0] = (vec3(6.0, -5.0, -4.0));
	var[0][2][1] = (vec3(-8.0, -8.0, -2.0));
	var[0][2][2] = (vec3(9.0, -4.0, 4.0));
	var[1][0][0] = (vec3(4.0, -1.0, 5.0));
	var[1][0][1] = (vec3(-1.0, 0.0, 9.0));
	var[1][0][2] = (vec3(7.0, 7.0, 5.0));
	var[1][1][0] = (vec3(8.0, -6.0, -1.0));
	var[1][1][1] = (vec3(-1.0, -2.0, -5.0));
	var[1][1][2] = (vec3(-5.0, 6.0, -3.0));
	var[1][2][0] = (vec3(-4.0, -6.0, 2.0));
	var[1][2][1] = (vec3(3.0, -1.0, 2.0));
	var[1][2][2] = (vec3(-3.0, 4.0, 1.0));
	var[2][0][0] = (vec3(9.0, -3.0, -9.0));
	var[2][0][1] = (vec3(6.0, -1.0, -6.0));
	var[2][0][2] = (vec3(6.0, 2.0, -5.0));
	var[2][1][0] = (vec3(-1.0, -2.0, 2.0));
	var[2][1][1] = (vec3(9.0, 1.0, -8.0));
	var[2][1][2] = (vec3(6.0, -1.0, 7.0));
	var[2][2][0] = (vec3(4.0, 2.0, -8.0));
	var[2][2][1] = (vec3(0.0, 3.0, 9.0));
	var[2][2][2] = (vec3(9.0, -8.0, -4.0));
	var[3][0][0] = (vec3(-8.0, 3.0, 4.0));
	var[3][0][1] = (vec3(-4.0, 4.0, 1.0));
	var[3][0][2] = (vec3(0.0, 4.0, 5.0));
	var[3][1][0] = (vec3(-9.0, -4.0, 2.0));
	var[3][1][1] = (vec3(-6.0, 8.0, 3.0));
	var[3][1][2] = (vec3(2.0, 0.0, -1.0));
	var[3][2][0] = (vec3(7.0, 1.0, 3.0));
	var[3][2][1] = (vec3(5.0, 1.0, -6.0));
	var[3][2][2] = (vec3(2.0, -5.0, 4.0));
}
#version 450
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
	int padding;
	highp ivec2 var[4][3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), 6) && allOk;
	allOk = compare_ivec2((var[0][0]), ivec2(-1, 7)) && allOk;
	allOk = compare_ivec2((var[0][1]), ivec2(-5, -8)) && allOk;
	allOk = compare_ivec2((var[0][2]), ivec2(8, -2)) && allOk;
	allOk = compare_ivec2((var[1][0]), ivec2(-6, 6)) && allOk;
	allOk = compare_ivec2((var[1][1]), ivec2(2, -2)) && allOk;
	allOk = compare_ivec2((var[1][2]), ivec2(7, -1)) && allOk;
	allOk = compare_ivec2((var[2][0]), ivec2(-1, 0)) && allOk;
	allOk = compare_ivec2((var[2][1]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((var[2][2]), ivec2(-5, 6)) && allOk;
	allOk = compare_ivec2((var[3][0]), ivec2(4, -8)) && allOk;
	allOk = compare_ivec2((var[3][1]), ivec2(3, 7)) && allOk;
	allOk = compare_ivec2((var[3][2]), ivec2(-6, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6);
	var[0][0] = (ivec2(8, 3));
	var[0][1] = (ivec2(-1, -5));
	var[0][2] = (ivec2(-2, 0));
	var[1][0] = (ivec2(-2, 5));
	var[1][1] = (ivec2(2, -8));
	var[1][2] = (ivec2(4, -6));
	var[2][0] = (ivec2(-4, 3));
	var[2][1] = (ivec2(-2, 5));
	var[2][2] = (ivec2(-7, -3));
	var[3][0] = (ivec2(4, 1));
	var[3][1] = (ivec2(6, 8));
	var[3][2] = (ivec2(7, 4));
}
#version 450
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
	highp mat2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2(var[0][0], mat2(-7.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(8.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(-3.0, -8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(9.0, 7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(-6.0, -3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(0.0, -8.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(-8.0, 0.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(7.0, -4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(-3.0, 6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(-8.0, -7.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(9.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(-6.0, -6.0, -1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0][0][0] = (vec2(-2.0, 4.0));
	var[0][0][1] = (vec2(-3.0, 1.0));
	var[0][1][0] = (vec2(2.0, -4.0));
	var[0][1][1] = (vec2(-3.0, -1.0));
	var[0][2][0] = (vec2(-4.0, 3.0));
	var[0][2][1] = (vec2(1.0, 7.0));
	var[1][0][0] = (vec2(2.0, 5.0));
	var[1][0][1] = (vec2(-7.0, -8.0));
	var[1][1][0] = (vec2(8.0, 1.0));
	var[1][1][1] = (vec2(4.0, 4.0));
	var[1][2][0] = (vec2(-9.0, 9.0));
	var[1][2][1] = (vec2(6.0, 1.0));
	var[2][0][0] = (vec2(9.0, -6.0));
	var[2][0][1] = (vec2(5.0, -7.0));
	var[2][1][0] = (vec2(7.0, 4.0));
	var[2][1][1] = (vec2(5.0, 7.0));
	var[2][2][0] = (vec2(0.0, 6.0));
	var[2][2][1] = (vec2(-9.0, -1.0));
	var[3][0][0] = (vec2(-8.0, 4.0));
	var[3][0][1] = (vec2(-7.0, 5.0));
	var[3][1][0] = (vec2(-7.0, 7.0));
	var[3][1][1] = (vec2(6.0, -1.0));
	var[3][2][0] = (vec2(9.0, -7.0));
	var[3][2][1] = (vec2(-5.0, -5.0));
}
#version 450
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
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat4(var[0][0], mat4(0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(-8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(-5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(-9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(-2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(-6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(-7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0] = (mat4(-8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0, 1.0));
	var[0][1] = (mat4(6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0, 1.0));
	var[0][2] = (mat4(-7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0, 2.0));
	var[1][0] = (mat4(3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0, -4.0));
	var[1][1] = (mat4(-1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0, -5.0));
	var[1][2] = (mat4(-1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0, 3.0));
	var[2][0] = (mat4(6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0, 1.0));
	var[2][1] = (mat4(2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0, 2.0));
	var[2][2] = (mat4(4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0, 8.0));
	var[3][0] = (mat4(9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0, -8.0));
	var[3][1] = (mat4(6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0, -2.0));
	var[3][2] = (mat4(0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0, 5.0));
}
#version 450
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
	highp mat4x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4x3(var[0][0], mat4x3(5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0, 9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0, -2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0, 8.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(-5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(-6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0, -5.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0, -4.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0, 4.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0, -9.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(-9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0, -5.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(-9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0, 1.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0][0] = (mat4x3(-5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0, 9.0, 2.0, -5.0));
	var[0][1] = (mat4x3(-6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0, 2.0, 4.0, 4.0));
	var[0][2] = (mat4x3(-9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0, 2.0, 8.0, 9.0));
	var[1][0] = (mat4x3(-3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0, -7.0, -4.0, 9.0));
	var[1][1] = (mat4x3(7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0, 0.0, 0.0, -4.0));
	var[1][2] = (mat4x3(-5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0, 1.0, 3.0, -8.0));
	var[2][0] = (mat4x3(-5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0, -3.0, -8.0, 8.0));
	var[2][1] = (mat4x3(9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0, -8.0, -9.0, -8.0));
	var[2][2] = (mat4x3(-9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0, 9.0, 8.0, 8.0));
	var[3][0] = (mat4x3(2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0, -3.0, -6.0, 1.0));
	var[3][1] = (mat4x3(-5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0, -6.0, -5.0, -4.0));
	var[3][2] = (mat4x3(-4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0, 8.0, 5.0, 4.0));
}
#version 450
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
	allOk = compare_mat2(var[0][0][0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(6.0, -3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(3.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(3.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(6.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(0.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(-4.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(6.0, -8.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(8.0, 4.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(6.0, 4.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(5.0, -3.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(-6.0, -7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(-8.0, -2.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(5.0, -4.0));
	var[0][0][0][1] = (vec2(5.0, 1.0));
	var[0][0][1][0] = (vec2(-8.0, -1.0));
	var[0][0][1][1] = (vec2(9.0, -8.0));
	var[0][0][2][0] = (vec2(5.0, -4.0));
	var[0][0][2][1] = (vec2(5.0, -2.0));
	var[0][1][0][0] = (vec2(7.0, 7.0));
	var[0][1][0][1] = (vec2(0.0, 2.0));
	var[0][1][1][0] = (vec2(4.0, -7.0));
	var[0][1][1][1] = (vec2(-5.0, -7.0));
	var[0][1][2][0] = (vec2(8.0, 2.0));
	var[0][1][2][1] = (vec2(1.0, -1.0));
	var[1][0][0][0] = (vec2(9.0, -9.0));
	var[1][0][0][1] = (vec2(-1.0, 6.0));
	var[1][0][1][0] = (vec2(-4.0, 7.0));
	var[1][0][1][1] = (vec2(-8.0, 1.0));
	var[1][0][2][0] = (vec2(4.0, -4.0));
	var[1][0][2][1] = (vec2(6.0, -5.0));
	var[1][1][0][0] = (vec2(9.0, 0.0));
	var[1][1][0][1] = (vec2(-8.0, -9.0));
	var[1][1][1][0] = (vec2(-2.0, 7.0));
	var[1][1][1][1] = (vec2(8.0, 2.0));
	var[1][1][2][0] = (vec2(-3.0, -3.0));
	var[1][1][2][1] = (vec2(7.0, -2.0));
	var[2][0][0][0] = (vec2(4.0, -3.0));
	var[2][0][0][1] = (vec2(6.0, 7.0));
	var[2][0][1][0] = (vec2(-7.0, -9.0));
	var[2][0][1][1] = (vec2(5.0, 0.0));
	var[2][0][2][0] = (vec2(9.0, 2.0));
	var[2][0][2][1] = (vec2(1.0, -6.0));
	var[2][1][0][0] = (vec2(4.0, -2.0));
	var[2][1][0][1] = (vec2(6.0, 1.0));
	var[2][1][1][0] = (vec2(-2.0, -8.0));
	var[2][1][1][1] = (vec2(9.0, 1.0));
	var[2][1][2][0] = (vec2(3.0, 4.0));
	var[2][1][2][1] = (vec2(-1.0, 5.0));
	var[3][0][0][0] = (vec2(8.0, -8.0));
	var[3][0][0][1] = (vec2(5.0, -5.0));
	var[3][0][1][0] = (vec2(-5.0, 4.0));
	var[3][0][1][1] = (vec2(5.0, 0.0));
	var[3][0][2][0] = (vec2(6.0, 9.0));
	var[3][0][2][1] = (vec2(5.0, -8.0));
	var[3][1][0][0] = (vec2(2.0, -6.0));
	var[3][1][0][1] = (vec2(7.0, -4.0));
	var[3][1][1][0] = (vec2(5.0, 3.0));
	var[3][1][1][1] = (vec2(9.0, -9.0));
	var[3][1][2][0] = (vec2(7.0, 1.0));
	var[3][1][2][1] = (vec2(-5.0, -7.0));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat2(var[0][0][0], mat2(3.0, -3.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(3.0, 0.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(-5.0, -3.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(3.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-5.0, -8.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(2.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(8.0, -5.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-4.0, -5.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(1.0, 3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(0.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(3.0, -5.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(4.0, -8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-4.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-4.0, 5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(-3.0, 2.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(2.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-2.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(-2.0, 4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(-6.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(1.0, -5.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(3.0, 7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(-2.0, -3.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(2.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(-9.0, 0.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0][0][0] = (vec2(1.0, -7.0));
	var[0][0][0][1] = (vec2(-1.0, 5.0));
	var[0][0][1][0] = (vec2(-3.0, 4.0));
	var[0][0][1][1] = (vec2(8.0, -2.0));
	var[0][0][2][0] = (vec2(-6.0, -5.0));
	var[0][0][2][1] = (vec2(-1.0, 3.0));
	var[0][1][0][0] = (vec2(2.0, -9.0));
	var[0][1][0][1] = (vec2(3.0, 7.0));
	var[0][1][1][0] = (vec2(9.0, -8.0));
	var[0][1][1][1] = (vec2(3.0, -8.0));
	var[0][1][2][0] = (vec2(-9.0, 3.0));
	var[0][1][2][1] = (vec2(-5.0, 7.0));
	var[1][0][0][0] = (vec2(4.0, -8.0));
	var[1][0][0][1] = (vec2(6.0, 6.0));
	var[1][0][1][0] = (vec2(-2.0, 1.0));
	var[1][0][1][1] = (vec2(3.0, 2.0));
	var[1][0][2][0] = (vec2(1.0, 7.0));
	var[1][0][2][1] = (vec2(-2.0, -4.0));
	var[1][1][0][0] = (vec2(8.0, -8.0));
	var[1][1][0][1] = (vec2(4.0, -4.0));
	var[1][1][1][0] = (vec2(7.0, -4.0));
	var[1][1][1][1] = (vec2(-8.0, 1.0));
	var[1][1][2][0] = (vec2(0.0, 0.0));
	var[1][1][2][1] = (vec2(-9.0, -4.0));
	var[2][0][0][0] = (vec2(2.0, -1.0));
	var[2][0][0][1] = (vec2(-4.0, -5.0));
	var[2][0][1][0] = (vec2(-8.0, 3.0));
	var[2][0][1][1] = (vec2(-7.0, 5.0));
	var[2][0][2][0] = (vec2(0.0, -4.0));
	var[2][0][2][1] = (vec2(-9.0, 9.0));
	var[2][1][0][0] = (vec2(7.0, 4.0));
	var[2][1][0][1] = (vec2(1.0, -1.0));
	var[2][1][1][0] = (vec2(-7.0, -5.0));
	var[2][1][1][1] = (vec2(1.0, -1.0));
	var[2][1][2][0] = (vec2(7.0, 0.0));
	var[2][1][2][1] = (vec2(9.0, -6.0));
	var[3][0][0][0] = (vec2(1.0, 7.0));
	var[3][0][0][1] = (vec2(9.0, 1.0));
	var[3][0][1][0] = (vec2(3.0, -3.0));
	var[3][0][1][1] = (vec2(7.0, 1.0));
	var[3][0][2][0] = (vec2(5.0, 4.0));
	var[3][0][2][1] = (vec2(1.0, -7.0));
	var[3][1][0][0] = (vec2(1.0, -3.0));
	var[3][1][0][1] = (vec2(1.0, 2.0));
	var[3][1][1][0] = (vec2(-1.0, -3.0));
	var[3][1][1][1] = (vec2(3.0, -3.0));
	var[3][1][2][0] = (vec2(-6.0, 3.0));
	var[3][1][2][1] = (vec2(2.0, -2.0));
}
#version 450
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
	highp mat4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat4(var[0][0][0], mat4(-2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(-1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0, 8.0, 1.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0, -4.0, -7.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(6.0, 6.0, 9.0, 9.0, 7.0, 3.0, 6.0, 1.0, 5.0, 1.0, 7.0, -7.0, 9.0, -7.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(0.0, 3.0, -7.0, -8.0, -9.0, 1.0, 4.0, 2.0, 0.0, -6.0, 3.0, 9.0, 7.0, 4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(6.0, -7.0, 3.0, -2.0, -8.0, 6.0, 5.0, 8.0, 5.0, 1.0, 8.0, 1.0, 7.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0, 6.0, 6.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0, -5.0, -8.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0, -8.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(4.0, 2.0, -1.0, 8.0, -6.0, 2.0, 6.0, 6.0, 5.0, 4.0, 5.0, 3.0, -3.0, -5.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-1.0, 9.0, 7.0, 9.0, 5.0, -5.0, -5.0, 8.0, -5.0, 7.0, -8.0, 2.0, -2.0, -6.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(7.0, -6.0, -4.0, 7.0, 5.0, -4.0, -1.0, 2.0, 6.0, 9.0, 2.0, 7.0, -6.0, 5.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0, 1.0, -9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0, 9.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(-6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0, 3.0, -9.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(4.0, 0.0, -4.0, -1.0, 4.0, -5.0, -8.0, 0.0, 8.0, 4.0, 5.0, 7.0, 4.0, -8.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-1.0, -8.0, 9.0, 7.0, 4.0, -2.0, -7.0, 3.0, -9.0, -1.0, 9.0, -7.0, -8.0, 8.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(-3.0, 1.0, -4.0, -5.0, 3.0, -9.0, 9.0, -1.0, -6.0, 8.0, 3.0, -3.0, -4.0, -3.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(-4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0, -3.0, -3.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(-4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0, 7.0, -4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0, -1.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(7.0, 6.0, 2.0, 2.0, 3.0, -2.0, -1.0, 2.0, 5.0, 3.0, 5.0, -9.0, 8.0, 6.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(-4.0, 2.0, 7.0, 7.0, 6.0, 6.0, 7.0, -3.0, 6.0, -1.0, -1.0, 4.0, 6.0, 8.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(-1.0, -5.0, -9.0, 8.0, -6.0, 4.0, 3.0, 9.0, 3.0, -1.0, 0.0, -8.0, -5.0, 8.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var[0][0][0] = (mat4(5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0, 6.0, -9.0, 9.0, -6.0));
	var[0][0][1] = (mat4(-2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0, 3.0, -2.0, 2.0, -7.0));
	var[0][0][2] = (mat4(-4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0, -7.0, 8.0, 1.0, 6.0));
	var[0][1][0] = (mat4(2.0, -8.0, -3.0, 3.0, -4.0, 1.0, 2.0, 3.0, -1.0, 1.0, 8.0, -3.0, 4.0, 7.0, 8.0, 0.0));
	var[0][1][1] = (mat4(2.0, 8.0, 7.0, 5.0, 3.0, 8.0, 4.0, -1.0, 5.0, -1.0, -3.0, 5.0, 5.0, -3.0, -5.0, -7.0));
	var[0][1][2] = (mat4(9.0, -1.0, 0.0, 8.0, -3.0, 4.0, 5.0, -5.0, 1.0, -8.0, -1.0, 3.0, 1.0, 5.0, -4.0, 9.0));
	var[1][0][0] = (mat4(6.0, 3.0, 3.0, 2.0, -4.0, 4.0, 2.0, -3.0, -7.0, -8.0, -6.0, 1.0, -6.0, 8.0, 6.0, -4.0));
	var[1][0][1] = (mat4(-2.0, -9.0, 0.0, 3.0, 9.0, 2.0, -5.0, 5.0, 1.0, 9.0, -1.0, 0.0, -6.0, -2.0, -5.0, -4.0));
	var[1][0][2] = (mat4(1.0, -1.0, -7.0, -1.0, -1.0, 3.0, -8.0, 4.0, 8.0, 4.0, -3.0, -8.0, 8.0, 6.0, -2.0, 3.0));
	var[1][1][0] = (mat4(1.0, -8.0, 4.0, 2.0, 8.0, 3.0, -2.0, -6.0, 2.0, -7.0, 1.0, 0.0, -4.0, -2.0, 7.0, 5.0));
	var[1][1][1] = (mat4(-3.0, 9.0, 9.0, 8.0, 9.0, 7.0, 5.0, 1.0, -6.0, -4.0, -4.0, 4.0, 9.0, 8.0, 8.0, 1.0));
	var[1][1][2] = (mat4(-1.0, 2.0, 2.0, 4.0, -1.0, -9.0, 4.0, 4.0, 1.0, -7.0, 7.0, -7.0, 4.0, 7.0, 6.0, -6.0));
	var[2][0][0] = (mat4(0.0, 3.0, 7.0, 6.0, 4.0, 6.0, 8.0, -9.0, 5.0, 9.0, -4.0, -4.0, -8.0, 9.0, 8.0, 1.0));
	var[2][0][1] = (mat4(7.0, 1.0, -7.0, -6.0, -9.0, 6.0, -5.0, -8.0, 1.0, -3.0, 3.0, 4.0, 0.0, -1.0, 1.0, -4.0));
	var[2][0][2] = (mat4(2.0, -4.0, 9.0, -7.0, -6.0, 4.0, 4.0, -2.0, -6.0, 1.0, 2.0, -7.0, 2.0, 6.0, -8.0, -2.0));
	var[2][1][0] = (mat4(1.0, 3.0, 4.0, -7.0, -9.0, -3.0, 3.0, -1.0, 8.0, 6.0, 3.0, 3.0, 6.0, 8.0, 4.0, -8.0));
	var[2][1][1] = (mat4(4.0, -4.0, -8.0, 9.0, 7.0, 7.0, -3.0, -6.0, 5.0, -5.0, -1.0, 7.0, 1.0, -8.0, -4.0, 9.0));
	var[2][1][2] = (mat4(8.0, 2.0, -9.0, 3.0, -4.0, 5.0, 1.0, -7.0, 4.0, 7.0, 6.0, -4.0, 7.0, -2.0, -4.0, 3.0));
	var[3][0][0] = (mat4(4.0, -4.0, 2.0, 4.0, 2.0, -1.0, -8.0, 0.0, -9.0, 2.0, 8.0, 9.0, 7.0, 4.0, 1.0, -1.0));
	var[3][0][1] = (mat4(7.0, 1.0, -8.0, -8.0, -3.0, -2.0, 5.0, 7.0, -2.0, -8.0, 8.0, -6.0, -7.0, -2.0, -1.0, 4.0));
	var[3][0][2] = (mat4(-1.0, -3.0, -8.0, 3.0, -3.0, 8.0, 1.0, -4.0, -9.0, -7.0, 3.0, 6.0, 3.0, -2.0, -4.0, -8.0));
	var[3][1][0] = (mat4(-9.0, -3.0, -4.0, 6.0, 9.0, 3.0, 8.0, -1.0, -7.0, -5.0, -3.0, 0.0, 4.0, 2.0, 1.0, 3.0));
	var[3][1][1] = (mat4(-7.0, 8.0, -5.0, -9.0, 7.0, 9.0, 7.0, -5.0, -8.0, -4.0, 1.0, -8.0, -6.0, -2.0, 7.0, -5.0));
	var[3][1][2] = (mat4(2.0, -4.0, 1.0, -3.0, -5.0, -5.0, 1.0, -7.0, 7.0, -1.0, -5.0, 5.0, -6.0, 4.0, 9.0, 7.0));
}
#version 450
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
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-6.0, -5.0, 5.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-6.0, -8.0, 6.0, -3.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(-8.0, 9.0, -8.0, -3.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(7.0, 3.0, 8.0, 1.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-7.0, 7.0, 5.0, -3.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(0.0, 2.0, -5.0, 9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(0.0, 4.0, 3.0, 9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(-1.0, -2.0, -8.0, -4.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(-6.0, 0.0, -1.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(6.0, -3.0, 2.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-6.0, -8.0, -7.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(-1.0, 1.0, 6.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(7.0, -4.0, 3.0, 7.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(-2.0, 0.0, -2.0, 1.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(-4.0, 1.0, -1.0, 0.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-2.0, -2.0, -9.0, 8.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(2.0, -1.0, -3.0, -2.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(0.0, 6.0, 9.0, -5.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(-7.0, -1.0, -4.0, -8.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(9.0, 8.0, 2.0, 1.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-3.0, 8.0, -5.0, 6.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(8.0, 6.0, 6.0, 0.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(5.0, 4.0, 5.0, -9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(-1.0, -1.0, -7.0, 8.0, 2.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0][0][0] = (mat3x2(-5.0, -1.0, -8.0, 7.0, 8.0, -4.0));
	var[0][0][1] = (mat3x2(-8.0, 1.0, 5.0, -2.0, 7.0, 4.0));
	var[0][0][2] = (mat3x2(-6.0, 7.0, -6.0, 2.0, 5.0, 0.0));
	var[0][1][0] = (mat3x2(-9.0, -8.0, 7.0, -5.0, -1.0, -7.0));
	var[0][1][1] = (mat3x2(4.0, -2.0, -6.0, -5.0, 6.0, -3.0));
	var[0][1][2] = (mat3x2(-7.0, 9.0, 9.0, -8.0, 0.0, 6.0));
	var[1][0][0] = (mat3x2(6.0, -5.0, 4.0, -2.0, 0.0, -3.0));
	var[1][0][1] = (mat3x2(-3.0, -2.0, 9.0, -2.0, -7.0, -9.0));
	var[1][0][2] = (mat3x2(-2.0, -8.0, 4.0, 3.0, 8.0, 7.0));
	var[1][1][0] = (mat3x2(-3.0, 9.0, -2.0, -5.0, -4.0, -4.0));
	var[1][1][1] = (mat3x2(6.0, -7.0, 5.0, -1.0, 5.0, 4.0));
	var[1][1][2] = (mat3x2(-7.0, -3.0, 6.0, -8.0, 2.0, -3.0));
	var[2][0][0] = (mat3x2(9.0, -5.0, 9.0, -1.0, 4.0, 6.0));
	var[2][0][1] = (mat3x2(-4.0, -6.0, 0.0, 7.0, -2.0, -1.0));
	var[2][0][2] = (mat3x2(-9.0, 8.0, -6.0, -9.0, 5.0, 2.0));
	var[2][1][0] = (mat3x2(-4.0, -7.0, 0.0, 8.0, 4.0, -8.0));
	var[2][1][1] = (mat3x2(-5.0, -1.0, -5.0, 2.0, -6.0, 3.0));
	var[2][1][2] = (mat3x2(4.0, 5.0, 1.0, -7.0, 1.0, 2.0));
	var[3][0][0] = (mat3x2(-9.0, 9.0, 4.0, -4.0, 9.0, 3.0));
	var[3][0][1] = (mat3x2(3.0, 1.0, -4.0, 0.0, -7.0, -4.0));
	var[3][0][2] = (mat3x2(7.0, 7.0, -1.0, -2.0, 6.0, 4.0));
	var[3][1][0] = (mat3x2(-7.0, -1.0, -4.0, 8.0, 1.0, -8.0));
	var[3][1][1] = (mat3x2(2.0, 7.0, 8.0, -5.0, -3.0, 8.0));
	var[3][1][2] = (mat3x2(-6.0, 3.0, -2.0, 7.0, -4.0, -7.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat2x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(-7.0, -3.0, 7.0, -3.0, 8.0, 3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(8.0, 0.0, -1.0, 2.0, 2.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(5.0, -7.0, 7.0, 2.0, 1.0, -3.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(5.0, -1.0, 6.0, -9.0, -1.0, 6.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(-5.0, 6.0, 6.0, 8.0, -9.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(-5.0, 5.0, -1.0, 2.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(-8.0, -2.0, -9.0, 0.0, 5.0, -8.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(-3.0, 3.0, -7.0, 1.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(-5.0, 8.0, 6.0, 1.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(-8.0, -3.0, 1.0, -2.0, 5.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(4.0, -5.0, 0.0, -6.0, 4.0, -3.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(-9.0, 1.0, 6.0, -4.0, 3.0, -3.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	var[0][0][0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	var[0][0][1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	var[0][0][1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	var[0][1][0][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	var[0][1][0][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	var[0][1][1][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	var[0][1][1][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	var[0][2][0][0] = (vec4(5.0, 0.0, 0.0, -1.0));
	var[0][2][0][1] = (vec4(9.0, 1.0, -4.0, 7.0));
	var[0][2][1][0] = (vec4(8.0, 0.0, -5.0, -4.0));
	var[0][2][1][1] = (vec4(2.0, 1.0, -9.0, 5.0));
	var[0][3][0][0] = (vec4(-8.0, 3.0, -6.0, 6.0));
	var[0][3][0][1] = (vec4(2.0, 1.0, 3.0, -6.0));
	var[0][3][1][0] = (vec4(-1.0, -4.0, -2.0, 6.0));
	var[0][3][1][1] = (vec4(6.0, 2.0, 1.0, 2.0));
	var[1][0][0][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	var[1][0][0][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	var[1][0][1][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	var[1][0][1][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	var[1][1][0][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	var[1][1][0][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	var[1][1][1][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	var[1][1][1][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	var[1][2][0][0] = (vec4(-5.0, 0.0, 5.0, 7.0));
	var[1][2][0][1] = (vec4(8.0, -8.0, 8.0, 1.0));
	var[1][2][1][0] = (vec4(6.0, -3.0, -3.0, -4.0));
	var[1][2][1][1] = (vec4(-9.0, 1.0, 6.0, -4.0));
	var[1][3][0][0] = (vec4(8.0, 9.0, 4.0, -4.0));
	var[1][3][0][1] = (vec4(5.0, -4.0, 9.0, 9.0));
	var[1][3][1][0] = (vec4(-8.0, 6.0, 2.0, 3.0));
	var[1][3][1][1] = (vec4(-1.0, 2.0, 2.0, -7.0));
	var[2][0][0][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	var[2][0][0][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	var[2][0][1][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	var[2][0][1][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	var[2][1][0][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	var[2][1][0][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	var[2][1][1][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	var[2][1][1][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
	var[2][2][0][0] = (vec4(-8.0, -4.0, -9.0, -8.0));
	var[2][2][0][1] = (vec4(-1.0, -1.0, 1.0, -7.0));
	var[2][2][1][0] = (vec4(7.0, -4.0, -6.0, -8.0));
	var[2][2][1][1] = (vec4(-8.0, -1.0, -2.0, 1.0));
	var[2][3][0][0] = (vec4(9.0, 2.0, -3.0, 1.0));
	var[2][3][0][1] = (vec4(5.0, 2.0, -3.0, 3.0));
	var[2][3][1][0] = (vec4(-9.0, -1.0, -7.0, 1.0));
	var[2][3][1][1] = (vec4(1.0, 5.0, -1.0, -3.0));
}
#version 450
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
	highp mat4x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(0.0, 7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(8.0, 8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(3.0, -3.0, -9.0, 4.0, -4.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(-1.0, -6.0, -9.0, 0.0, 2.0, -7.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(1.0, -1.0, 1.0, -8.0, -7.0, -2.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(-6.0, -7.0, -6.0, 9.0, -2.0, 0.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(3.0, -2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(7.0, 4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(8.0, -7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(4.0, -4.0, -5.0, -5.0, 1.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(-4.0, 2.0, -1.0, -3.0, -7.0, -8.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(2.0, 0.0, 6.0, 6.0, -2.0, -2.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(-7.0, 8.0, 7.0, 7.0, 3.0, -3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-1.0, 0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(2.0, -2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-4.0, 1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(2.0, -3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(4.0, 9.0, -6.0, -7.0, 1.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(2.0, -5.0, -5.0, -2.0, 5.0, 3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(-9.0, 3.0, 2.0, 9.0, 1.0, -1.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(-5.0, 0.0, 5.0, 8.0, 6.0, 2.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	var[0][0][1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	var[0][1][0] = (mat4x2(-4.0, 4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0));
	var[0][1][1] = (mat4x2(8.0, -4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0));
	var[0][2][0] = (mat4x2(8.0, 9.0, 4.0, -2.0, -8.0, -5.0, -3.0, 9.0));
	var[0][2][1] = (mat4x2(9.0, -3.0, 8.0, 2.0, -9.0, 2.0, 1.0, -2.0));
	var[0][3][0] = (mat4x2(-4.0, 0.0, 5.0, 8.0, 4.0, -1.0, 1.0, 4.0));
	var[0][3][1] = (mat4x2(-1.0, -3.0, -1.0, 1.0, 3.0, 4.0, -6.0, -8.0));
	var[1][0][0] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
	var[1][0][1] = (mat4x2(8.0, 7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0));
	var[1][1][0] = (mat4x2(-4.0, -8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0));
	var[1][1][1] = (mat4x2(-5.0, 7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0));
	var[1][2][0] = (mat4x2(6.0, 7.0, -3.0, 4.0, 8.0, -4.0, -9.0, -6.0));
	var[1][2][1] = (mat4x2(-8.0, 1.0, 6.0, -6.0, 6.0, -2.0, -8.0, 8.0));
	var[1][3][0] = (mat4x2(-3.0, 8.0, -7.0, -8.0, 3.0, 0.0, -2.0, 7.0));
	var[1][3][1] = (mat4x2(-2.0, 7.0, -8.0, -6.0, 4.0, -9.0, 3.0, -6.0));
	var[2][0][0] = (mat4x2(1.0, 6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0));
	var[2][0][1] = (mat4x2(3.0, -5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0));
	var[2][1][0] = (mat4x2(6.0, -7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0));
	var[2][1][1] = (mat4x2(3.0, -8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0));
	var[2][2][0] = (mat4x2(0.0, 7.0, -6.0, 0.0, -7.0, 3.0, -3.0, 1.0));
	var[2][2][1] = (mat4x2(-4.0, -6.0, -8.0, -9.0, 1.0, 4.0, 2.0, -5.0));
	var[2][3][0] = (mat4x2(-7.0, 5.0, 0.0, -5.0, 7.0, 3.0, -1.0, -3.0));
	var[2][3][1] = (mat4x2(5.0, -8.0, 1.0, -3.0, 7.0, -8.0, 1.0, -4.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(7.0, -5.0, -3.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-9.0, -6.0, 5.0, -2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(1.0, -6.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(-3.0, 6.0, -4.0, -1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(0.0, 0.0, 5.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(3.0, -2.0, -1.0, 5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(0.0, 9.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(8.0, 1.0, 8.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-1.0, -2.0, -9.0, -1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(2.0, -1.0, -8.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(-7.0, 5.0, -9.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(-5.0, -2.0, 9.0, 2.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(4.0, -4.0, -3.0, -5.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-8.0, 3.0, 8.0, -7.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(8.0, 4.0, -2.0, -2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-5.0, -6.0, -3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-3.0, -8.0, -9.0, -8.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(3.0, -4.0, 0.0, -3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(-4.0, -2.0, 6.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(-2.0, 0.0, 3.0, 7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(7.0, 7.0, -2.0, -8.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(4.0, 5.0, -6.0));
	var[0][0][0][1] = (vec3(0.0, -8.0, -2.0));
	var[0][0][1][0] = (vec3(8.0, 8.0, 0.0));
	var[0][0][1][1] = (vec3(3.0, -6.0, -6.0));
	var[0][1][0][0] = (vec3(-1.0, -3.0, 0.0));
	var[0][1][0][1] = (vec3(3.0, 3.0, 5.0));
	var[0][1][1][0] = (vec3(-1.0, -1.0, 3.0));
	var[0][1][1][1] = (vec3(-1.0, -7.0, 7.0));
	var[0][2][0][0] = (vec3(-7.0, 8.0, -3.0));
	var[0][2][0][1] = (vec3(3.0, 8.0, 1.0));
	var[0][2][1][0] = (vec3(3.0, 6.0, 2.0));
	var[0][2][1][1] = (vec3(9.0, -2.0, -9.0));
	var[0][3][0][0] = (vec3(-4.0, 0.0, -1.0));
	var[0][3][0][1] = (vec3(8.0, 9.0, -4.0));
	var[0][3][1][0] = (vec3(6.0, 5.0, -2.0));
	var[0][3][1][1] = (vec3(0.0, 6.0, 6.0));
	var[1][0][0][0] = (vec3(-1.0, 2.0, -9.0));
	var[1][0][0][1] = (vec3(1.0, 3.0, 2.0));
	var[1][0][1][0] = (vec3(1.0, 5.0, -6.0));
	var[1][0][1][1] = (vec3(-8.0, -6.0, -5.0));
	var[1][1][0][0] = (vec3(-6.0, -6.0, -8.0));
	var[1][1][0][1] = (vec3(2.0, -4.0, -3.0));
	var[1][1][1][0] = (vec3(-3.0, 4.0, 8.0));
	var[1][1][1][1] = (vec3(7.0, -2.0, -7.0));
	var[1][2][0][0] = (vec3(-9.0, 6.0, -2.0));
	var[1][2][0][1] = (vec3(-3.0, -8.0, -5.0));
	var[1][2][1][0] = (vec3(-2.0, -5.0, 0.0));
	var[1][2][1][1] = (vec3(-9.0, -9.0, -9.0));
	var[1][3][0][0] = (vec3(3.0, 8.0, 3.0));
	var[1][3][0][1] = (vec3(2.0, 2.0, -8.0));
	var[1][3][1][0] = (vec3(0.0, -1.0, 2.0));
	var[1][3][1][1] = (vec3(7.0, 7.0, 4.0));
	var[2][0][0][0] = (vec3(-9.0, 6.0, -9.0));
	var[2][0][0][1] = (vec3(0.0, -1.0, -3.0));
	var[2][0][1][0] = (vec3(-6.0, 9.0, 7.0));
	var[2][0][1][1] = (vec3(-5.0, -7.0, -2.0));
	var[2][1][0][0] = (vec3(-5.0, 5.0, -5.0));
	var[2][1][0][1] = (vec3(1.0, -1.0, 7.0));
	var[2][1][1][0] = (vec3(-5.0, 8.0, -7.0));
	var[2][1][1][1] = (vec3(-2.0, 4.0, 3.0));
	var[2][2][0][0] = (vec3(-9.0, -3.0, -1.0));
	var[2][2][0][1] = (vec3(7.0, 1.0, 1.0));
	var[2][2][1][0] = (vec3(4.0, -2.0, 7.0));
	var[2][2][1][1] = (vec3(0.0, 1.0, 9.0));
	var[2][3][0][0] = (vec3(-1.0, -5.0, -6.0));
	var[2][3][0][1] = (vec3(-9.0, 7.0, 3.0));
	var[2][3][1][0] = (vec3(7.0, 3.0, -9.0));
	var[2][3][1][1] = (vec3(1.0, -3.0, 5.0));
}
#version 450
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
	highp mat3x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(-7.0, -9.0, 9.0, 4.0, 9.0, 5.0, -2.0, -3.0, 8.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(1.0, 1.0, -3.0, 0.0, -6.0, -1.0, -5.0, -8.0, -9.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(8.0, -7.0, 0.0, 6.0, 2.0, -6.0, 7.0, -8.0, -5.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(2.0, 6.0, -9.0, -2.0, 6.0, 0.0, -8.0, -1.0, -7.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(9.0, 0.0, -8.0, 0.0, -8.0, 1.0, -3.0, 3.0, -4.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(-4.0, -3.0, 7.0, 1.0, -8.0, -8.0, -5.0, 8.0, -6.0, 9.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(7.0, -2.0, 9.0, 0.0, 7.0, 3.0, -1.0, 8.0, 6.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(5.0, 9.0, 6.0, 2.0, 5.0, 9.0, 8.0, -5.0, -1.0, -4.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(-9.0, -2.0, 7.0, -7.0, 5.0, -9.0, 2.0, 8.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(-1.0, -3.0, 3.0, -5.0, 9.0, -5.0, 3.0, 9.0, 7.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-6.0, -2.0, -7.0, -3.0, -7.0, 3.0, -9.0, 4.0, -6.0, -1.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(5.0, 1.0, -1.0, 7.0, 1.0, 7.0, -9.0, -8.0, 8.0, -5.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(8.0, 8.0, -2.0, 8.0));
	var[0][0][0][1] = (vec4(8.0, 3.0, 5.0, -5.0));
	var[0][0][0][2] = (vec4(7.0, 6.0, -9.0, 3.0));
	var[0][0][1][0] = (vec4(0.0, -3.0, 1.0, -9.0));
	var[0][0][1][1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	var[0][0][1][2] = (vec4(9.0, 0.0, -9.0, -2.0));
	var[0][1][0][0] = (vec4(-1.0, -9.0, 4.0, 9.0));
	var[0][1][0][1] = (vec4(0.0, 2.0, -7.0, -7.0));
	var[0][1][0][2] = (vec4(-1.0, 8.0, -9.0, -3.0));
	var[0][1][1][0] = (vec4(5.0, 7.0, -8.0, 1.0));
	var[0][1][1][1] = (vec4(-5.0, 0.0, -7.0, -3.0));
	var[0][1][1][2] = (vec4(-5.0, -4.0, 3.0, -5.0));
	var[0][2][0][0] = (vec4(4.0, -1.0, 2.0, -8.0));
	var[0][2][0][1] = (vec4(-6.0, 4.0, -8.0, 9.0));
	var[0][2][0][2] = (vec4(0.0, 7.0, -2.0, 2.0));
	var[0][2][1][0] = (vec4(2.0, 9.0, -9.0, 2.0));
	var[0][2][1][1] = (vec4(1.0, 5.0, 5.0, 5.0));
	var[0][2][1][2] = (vec4(0.0, 9.0, 8.0, 7.0));
	var[0][3][0][0] = (vec4(8.0, 9.0, -2.0, -1.0));
	var[0][3][0][1] = (vec4(7.0, -4.0, -8.0, 9.0));
	var[0][3][0][2] = (vec4(-5.0, 7.0, 9.0, -6.0));
	var[0][3][1][0] = (vec4(-2.0, 8.0, -6.0, 9.0));
	var[0][3][1][1] = (vec4(-3.0, 4.0, 1.0, -8.0));
	var[0][3][1][2] = (vec4(9.0, -1.0, 4.0, 6.0));
	var[1][0][0][0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	var[1][0][0][1] = (vec4(1.0, -2.0, -2.0, -1.0));
	var[1][0][0][2] = (vec4(-7.0, 8.0, 0.0, -6.0));
	var[1][0][1][0] = (vec4(-1.0, 7.0, -6.0, -1.0));
	var[1][0][1][1] = (vec4(-7.0, -8.0, 7.0, -8.0));
	var[1][0][1][2] = (vec4(6.0, -8.0, 2.0, -5.0));
	var[1][1][0][0] = (vec4(4.0, 5.0, -9.0, -6.0));
	var[1][1][0][1] = (vec4(5.0, 3.0, -6.0, -7.0));
	var[1][1][0][2] = (vec4(-3.0, 9.0, 3.0, -7.0));
	var[1][1][1][0] = (vec4(-9.0, -9.0, 6.0, -9.0));
	var[1][1][1][1] = (vec4(6.0, -1.0, -1.0, -4.0));
	var[1][1][1][2] = (vec4(5.0, 2.0, -6.0, 8.0));
	var[1][2][0][0] = (vec4(7.0, 5.0, -7.0, -6.0));
	var[1][2][0][1] = (vec4(-4.0, 4.0, -5.0, -7.0));
	var[1][2][0][2] = (vec4(2.0, 2.0, 1.0, -7.0));
	var[1][2][1][0] = (vec4(1.0, -1.0, 9.0, -4.0));
	var[1][2][1][1] = (vec4(4.0, 1.0, 7.0, -4.0));
	var[1][2][1][2] = (vec4(1.0, 9.0, -7.0, 4.0));
	var[1][3][0][0] = (vec4(6.0, -5.0, -8.0, -2.0));
	var[1][3][0][1] = (vec4(-3.0, -8.0, 3.0, 8.0));
	var[1][3][0][2] = (vec4(1.0, -5.0, 7.0, 2.0));
	var[1][3][1][0] = (vec4(4.0, 7.0, 0.0, -1.0));
	var[1][3][1][1] = (vec4(3.0, 8.0, -5.0, 9.0));
	var[1][3][1][2] = (vec4(-5.0, 8.0, -3.0, 1.0));
	var[2][0][0][0] = (vec4(9.0, -7.0, 4.0, -1.0));
	var[2][0][0][1] = (vec4(-3.0, -8.0, -1.0, 1.0));
	var[2][0][0][2] = (vec4(-6.0, -4.0, -8.0, 4.0));
	var[2][0][1][0] = (vec4(5.0, 0.0, -6.0, 5.0));
	var[2][0][1][1] = (vec4(-1.0, 4.0, 3.0, -6.0));
	var[2][0][1][2] = (vec4(1.0, 8.0, -2.0, 3.0));
	var[2][1][0][0] = (vec4(4.0, 2.0, 4.0, -3.0));
	var[2][1][0][1] = (vec4(9.0, 8.0, 5.0, -3.0));
	var[2][1][0][2] = (vec4(7.0, -4.0, 6.0, 4.0));
	var[2][1][1][0] = (vec4(0.0, -2.0, 1.0, 8.0));
	var[2][1][1][1] = (vec4(1.0, 4.0, 6.0, 4.0));
	var[2][1][1][2] = (vec4(-2.0, 9.0, 9.0, 7.0));
	var[2][2][0][0] = (vec4(-2.0, 5.0, -1.0, 9.0));
	var[2][2][0][1] = (vec4(-9.0, -6.0, 3.0, 7.0));
	var[2][2][0][2] = (vec4(-1.0, -6.0, 3.0, -3.0));
	var[2][2][1][0] = (vec4(1.0, 7.0, 2.0, -9.0));
	var[2][2][1][1] = (vec4(0.0, -8.0, -8.0, 4.0));
	var[2][2][1][2] = (vec4(7.0, 6.0, 8.0, -2.0));
	var[2][3][0][0] = (vec4(7.0, 9.0, 3.0, -6.0));
	var[2][3][0][1] = (vec4(-1.0, -7.0, -5.0, 3.0));
	var[2][3][0][2] = (vec4(-1.0, -1.0, 9.0, 3.0));
	var[2][3][1][0] = (vec4(5.0, 6.0, -3.0, 6.0));
	var[2][3][1][1] = (vec4(-2.0, 2.0, -3.0, 0.0));
	var[2][3][1][2] = (vec4(7.0, 8.0, -4.0, -2.0));
}
#version 450
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
	highp mat4x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(-1.0, 3.0, -9.0, 4.0, -2.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(-3.0, 7.0, -5.0, 3.0, 2.0, -1.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(-4.0, 1.0, -2.0, 4.0, 1.0, -8.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(-3.0, 8.0, -5.0, 6.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(6.0, 9.0, -5.0, 0.0, 7.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(-7.0, -3.0, -5.0, 2.0, 3.0, -3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(0.0, 0.0, 7.0, -1.0, 5.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(-4.0, 8.0, -2.0, -8.0, 3.0, -3.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(5.0, -7.0, -9.0, 8.0, 8.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(-6.0, 8.0, -1.0, 0.0, 6.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(-7.0, -6.0, -2.0, 5.0, -6.0, 7.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(8.0, -4.0, 0.0, -7.0, 2.0, -2.0, 6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(6.0, 9.0));
	var[0][0][0][1] = (vec2(-4.0, -4.0));
	var[0][0][0][2] = (vec2(2.0, 0.0));
	var[0][0][0][3] = (vec2(-7.0, 3.0));
	var[0][0][1][0] = (vec2(9.0, -6.0));
	var[0][0][1][1] = (vec2(8.0, -9.0));
	var[0][0][1][2] = (vec2(-9.0, -6.0));
	var[0][0][1][3] = (vec2(-4.0, -6.0));
	var[0][1][0][0] = (vec2(-2.0, 1.0));
	var[0][1][0][1] = (vec2(6.0, -2.0));
	var[0][1][0][2] = (vec2(2.0, -5.0));
	var[0][1][0][3] = (vec2(3.0, -3.0));
	var[0][1][1][0] = (vec2(-6.0, -4.0));
	var[0][1][1][1] = (vec2(-6.0, -7.0));
	var[0][1][1][2] = (vec2(9.0, 1.0));
	var[0][1][1][3] = (vec2(-4.0, 3.0));
	var[0][2][0][0] = (vec2(-9.0, -3.0));
	var[0][2][0][1] = (vec2(5.0, -5.0));
	var[0][2][0][2] = (vec2(3.0, 4.0));
	var[0][2][0][3] = (vec2(-9.0, 1.0));
	var[0][2][1][0] = (vec2(0.0, 8.0));
	var[0][2][1][1] = (vec2(-8.0, 3.0));
	var[0][2][1][2] = (vec2(-7.0, 9.0));
	var[0][2][1][3] = (vec2(-8.0, -7.0));
	var[0][3][0][0] = (vec2(3.0, 7.0));
	var[0][3][0][1] = (vec2(-6.0, -7.0));
	var[0][3][0][2] = (vec2(-7.0, 5.0));
	var[0][3][0][3] = (vec2(-8.0, 4.0));
	var[0][3][1][0] = (vec2(4.0, -5.0));
	var[0][3][1][1] = (vec2(-6.0, -9.0));
	var[0][3][1][2] = (vec2(7.0, 7.0));
	var[0][3][1][3] = (vec2(-2.0, 6.0));
	var[1][0][0][0] = (vec2(-8.0, 5.0));
	var[1][0][0][1] = (vec2(6.0, -8.0));
	var[1][0][0][2] = (vec2(-8.0, 3.0));
	var[1][0][0][3] = (vec2(2.0, 8.0));
	var[1][0][1][0] = (vec2(-8.0, -1.0));
	var[1][0][1][1] = (vec2(-3.0, 0.0));
	var[1][0][1][2] = (vec2(7.0, 5.0));
	var[1][0][1][3] = (vec2(-8.0, 5.0));
	var[1][1][0][0] = (vec2(7.0, -9.0));
	var[1][1][0][1] = (vec2(7.0, -4.0));
	var[1][1][0][2] = (vec2(8.0, -2.0));
	var[1][1][0][3] = (vec2(9.0, 0.0));
	var[1][1][1][0] = (vec2(-9.0, 7.0));
	var[1][1][1][1] = (vec2(1.0, 4.0));
	var[1][1][1][2] = (vec2(-7.0, 9.0));
	var[1][1][1][3] = (vec2(-5.0, 2.0));
	var[1][2][0][0] = (vec2(7.0, 1.0));
	var[1][2][0][1] = (vec2(-1.0, -2.0));
	var[1][2][0][2] = (vec2(-8.0, -3.0));
	var[1][2][0][3] = (vec2(9.0, -1.0));
	var[1][2][1][0] = (vec2(-2.0, 1.0));
	var[1][2][1][1] = (vec2(-8.0, -7.0));
	var[1][2][1][2] = (vec2(-5.0, 7.0));
	var[1][2][1][3] = (vec2(-5.0, -7.0));
	var[1][3][0][0] = (vec2(1.0, -9.0));
	var[1][3][0][1] = (vec2(7.0, 6.0));
	var[1][3][0][2] = (vec2(-4.0, 2.0));
	var[1][3][0][3] = (vec2(1.0, 5.0));
	var[1][3][1][0] = (vec2(-8.0, -6.0));
	var[1][3][1][1] = (vec2(-6.0, 4.0));
	var[1][3][1][2] = (vec2(4.0, 7.0));
	var[1][3][1][3] = (vec2(-7.0, -9.0));
	var[2][0][0][0] = (vec2(7.0, 8.0));
	var[2][0][0][1] = (vec2(4.0, -2.0));
	var[2][0][0][2] = (vec2(4.0, -2.0));
	var[2][0][0][3] = (vec2(-2.0, 9.0));
	var[2][0][1][0] = (vec2(4.0, -4.0));
	var[2][0][1][1] = (vec2(-5.0, -5.0));
	var[2][0][1][2] = (vec2(-6.0, 8.0));
	var[2][0][1][3] = (vec2(9.0, -5.0));
	var[2][1][0][0] = (vec2(-9.0, -3.0));
	var[2][1][0][1] = (vec2(-8.0, 5.0));
	var[2][1][0][2] = (vec2(-2.0, -8.0));
	var[2][1][0][3] = (vec2(7.0, -6.0));
	var[2][1][1][0] = (vec2(-7.0, 1.0));
	var[2][1][1][1] = (vec2(-3.0, 7.0));
	var[2][1][1][2] = (vec2(6.0, -5.0));
	var[2][1][1][3] = (vec2(9.0, -2.0));
	var[2][2][0][0] = (vec2(-5.0, 2.0));
	var[2][2][0][1] = (vec2(-4.0, 8.0));
	var[2][2][0][2] = (vec2(-7.0, 6.0));
	var[2][2][0][3] = (vec2(5.0, 2.0));
	var[2][2][1][0] = (vec2(-5.0, 3.0));
	var[2][2][1][1] = (vec2(-9.0, 7.0));
	var[2][2][1][2] = (vec2(-3.0, -3.0));
	var[2][2][1][3] = (vec2(-7.0, -4.0));
	var[2][3][0][0] = (vec2(7.0, -6.0));
	var[2][3][0][1] = (vec2(8.0, -8.0));
	var[2][3][0][2] = (vec2(-6.0, -7.0));
	var[2][3][0][3] = (vec2(-4.0, -2.0));
	var[2][3][1][0] = (vec2(-9.0, 9.0));
	var[2][3][1][1] = (vec2(4.0, -6.0));
	var[2][3][1][2] = (vec2(2.0, 3.0));
	var[2][3][1][3] = (vec2(6.0, 8.0));
}
#version 450
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
	uint8_t var[][4][2];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(var[0][0][0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[0][0][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[0][1][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[0][1][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[0][2][0]), 6u) && allOk;
	allOk = compare_uint8_t(uint(var[0][2][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[0][3][0]), 3u) && allOk;
	allOk = compare_uint8_t(uint(var[0][3][1]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[1][0][0]), 3u) && allOk;
	allOk = compare_uint8_t(uint(var[1][0][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[1][1][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[1][1][1]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[1][2][0]), 5u) && allOk;
	allOk = compare_uint8_t(uint(var[1][2][1]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[1][3][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[1][3][1]), 0u) && allOk;
	allOk = compare_uint8_t(uint(var[2][0][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[2][0][1]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[2][1][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[2][1][1]), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[2][2][0]), 8u) && allOk;
	allOk = compare_uint8_t(uint(var[2][2][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[2][3][0]), 6u) && allOk;
	allOk = compare_uint8_t(uint(var[2][3][1]), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = uint8_t(9u);
	var[0][0][1] = uint8_t(5u);
	var[0][1][0] = uint8_t(8u);
	var[0][1][1] = uint8_t(4u);
	var[0][2][0] = uint8_t(6u);
	var[0][2][1] = uint8_t(0u);
	var[0][3][0] = uint8_t(0u);
	var[0][3][1] = uint8_t(3u);
	var[1][0][0] = uint8_t(2u);
	var[1][0][1] = uint8_t(6u);
	var[1][1][0] = uint8_t(2u);
	var[1][1][1] = uint8_t(6u);
	var[1][2][0] = uint8_t(5u);
	var[1][2][1] = uint8_t(4u);
	var[1][3][0] = uint8_t(3u);
	var[1][3][1] = uint8_t(3u);
	var[2][0][0] = uint8_t(7u);
	var[2][0][1] = uint8_t(5u);
	var[2][1][0] = uint8_t(0u);
	var[2][1][1] = uint8_t(1u);
	var[2][2][0] = uint8_t(1u);
	var[2][2][1] = uint8_t(3u);
	var[2][3][0] = uint8_t(3u);
	var[2][3][1] = uint8_t(3u);
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(block[0].var, mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(0.0, 5.0, 5.0));
	block[0].var[1] = (vec3(0.0, -7.0, 8.0));
	block[1].var[0] = (vec3(-7.0, -4.0, 6.0));
	block[1].var[1] = (vec3(1.0, 3.0, 2.0));
	block[2].var[0] = (vec3(-6.0, 5.0, 2.0));
	block[2].var[1] = (vec3(1.0, 8.0, -8.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat2x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(block[0].var, mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	block[1].var = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	block[2].var = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
}
#version 450
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
	highp int var;
} block[3];

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block[0].var), 6) && allOk;
	allOk = compare_int((block[1].var), 0) && allOk;
	allOk = compare_int((block[2].var), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (8);
	block[1].var = (2);
	block[2].var = (-5);
}
#version 450
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
	highp mat3x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_mat3x4(block[0].var, mat3x4(-7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0, 8.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_float((block[1].padding), -1.0) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(-1.0, -2.0, -3.0, -8.0, -3.0, -5.0, 8.0, 2.0, -9.0, 0.0, -5.0, -1.0)) && allOk;
	allOk = compare_float((block[2].padding), -7.0) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(-8.0, 6.0, 3.0, -4.0, -1.0, 2.0, 5.0, -9.0, -3.0, 8.0, -6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-2.0);
	block[0].var[0] = (vec4(-8.0, -4.0, 1.0, -8.0));
	block[0].var[1] = (vec4(-4.0, 3.0, 6.0, -4.0));
	block[0].var[2] = (vec4(-8.0, -5.0, 9.0, -4.0));
	block[1].padding = (0.0);
	block[1].var[0] = (vec4(-4.0, -4.0, -8.0, 9.0));
	block[1].var[1] = (vec4(-7.0, 6.0, -4.0, 2.0));
	block[1].var[2] = (vec4(7.0, -9.0, 4.0, -1.0));
	block[2].padding = (0.0);
	block[2].var[0] = (vec4(-7.0, 2.0, -6.0, 3.0));
	block[2].var[1] = (vec4(-7.0, 7.0, 1.0, 4.0));
	block[2].var[2] = (vec4(4.0, 1.0, -9.0, 8.0));
}
#version 450
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

layout(std430, binding = 1) buffer BlockB
{
	highp vec2 a;
	bool b;
	mediump mat2 c;
	bvec4 d;
	highp ivec3 e;
} blockB;
layout(std430, binding = 2) readonly buffer BlockC
{
	bvec4 f;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	highp mat3x4 g;
	bvec2 h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(4.0, 4.0)) && allOk;
	allOk = compare_bvec4((blockC.f), bvec4(true, true, true, true)) && allOk;
	allOk = compare_mat3x4(g, mat3x4(6.0, -7.0, 5.0, -9.0, 3.0, -2.0, 6.0, -2.0, 1.0, -6.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(-5.0, 4.0));
	blockB.b = (false);
	blockB.c = (mat2(-7.0, -8.0, 8.0, 4.0));
	blockB.d = (bvec4(true, true, true, true));
	blockB.e = (ivec3(0, 9, 3));
	g = (mat3x4(9.0, 3.0, 7.0, 7.0, -8.0, 5.0, -2.0, -7.0, -2.0, 5.0, 0.0, -1.0));
}
#version 450
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
	lowp mat3x2 e[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp mat4 f[];
};
layout(std140, binding = 3) buffer BlockD
{
	highp mat2x3 g;
	mediump mat4 h;
	bvec4 i;
	mediump mat4x3 j[];
} blockD;
layout(std430, row_major, binding = 4) buffer BlockE
{
	highp mat3 k;
	bvec2 l[3];
	lowp vec3 m;
	bool n;
	mediump mat3 o[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(b, mat2(-5.0, 9.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(e[0], mat3x2(5.0, 7.0, -2.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(e[1], mat3x2(3.0, 0.0, 2.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(e[2], mat3x2(9.0, -1.0, -1.0, -7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4(f[0], mat4(-3.0, 1.0, -4.0, -9.0, 1.0, -4.0, 0.0, 2.0, 0.0, 6.0, 2.0, 3.0, -5.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(f[1], mat4(-9.0, -6.0, -9.0, -8.0, 6.0, -2.0, 3.0, 7.0, 2.0, -7.0, -2.0, -5.0, 4.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4(f[2], mat4(-2.0, -8.0, -2.0, -9.0, 0.0, -8.0, -3.0, 8.0, -7.0, 9.0, -9.0, 2.0, 4.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat4(f[3], mat4(-8.0, 5.0, -7.0, 8.0, -2.0, 6.0, 2.0, -9.0, -5.0, 4.0, 4.0, -7.0, -4.0, -9.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat4(blockD.h, mat4(9.0, -9.0, -6.0, 7.0, 6.0, -4.0, 7.0, -1.0, 3.0, 3.0, 3.0, 0.0, 6.0, -7.0, 7.0, 6.0)) && allOk;
	allOk = compare_bvec4((blockD.i), bvec4(true, false, false, false)) && allOk;
	allOk = compare_mat4x3(blockD.j[0], mat4x3(7.0, -9.0, -8.0, 6.0, 3.0, 6.0, 2.0, -3.0, -1.0, 4.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(blockE.k, mat3(0.0, 5.0, -9.0, -1.0, 0.0, -1.0, -6.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat3(blockE.o[0], mat3(1.0, 2.0, 4.0, -5.0, 3.0, 1.0, -7.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec3(true, true, true));
	b = (mat2(-6.0, 3.0, -7.0, 8.0));
	c = (mat2(5.0, -6.0, -7.0, -2.0));
	d = (2);
	e[0] = (mat3x2(3.0, -1.0, 4.0, -4.0, -6.0, -7.0));
	e[1] = (mat3x2(-7.0, -4.0, 8.0, 2.0, -9.0, 0.0));
	e[2] = (mat3x2(4.0, 3.0, -1.0, -6.0, -4.0, -5.0));
	f[0] = (mat4(3.0, -5.0, 6.0, -6.0, -2.0, -8.0, 5.0, -4.0, 8.0, -5.0, 2.0, -2.0, 8.0, -1.0, -1.0, 1.0));
	f[1] = (mat4(7.0, 8.0, 7.0, 0.0, -5.0, 6.0, 5.0, -6.0, -6.0, 6.0, 6.0, -6.0, 3.0, 2.0, -4.0, 5.0));
	f[2] = (mat4(-9.0, 5.0, -9.0, -5.0, -1.0, -8.0, -7.0, 8.0, 2.0, 8.0, -1.0, -1.0, 3.0, -6.0, 6.0, -1.0));
	f[3] = (mat4(-9.0, 7.0, 5.0, -7.0, 5.0, -3.0, -4.0, -1.0, 7.0, -9.0, 2.0, -7.0, 1.0, -9.0, -7.0, 3.0));
	blockD.h = (mat4(-4.0, -2.0, 7.0, -7.0, -1.0, 8.0, 0.0, 1.0, 0.0, 0.0, 4.0, 4.0, 2.0, 7.0, 2.0, 5.0));
	blockD.i = (bvec4(true, false, true, false));
	blockD.j[0] = (mat4x3(-4.0, -1.0, -6.0, 2.0, 5.0, -8.0, -3.0, -6.0, -2.0, 5.0, 2.0, 9.0));
	blockE.k = (mat3(-3.0, -4.0, 0.0, -4.0, 9.0, 8.0, 3.0, -8.0, -2.0));
	blockE.m = (vec3(6.0, -7.0, 4.0));
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

layout(std430, column_major, binding = 1) buffer BlockB
{
	lowp mat4x2 a;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp uint b;
	bool c;
	mediump mat2x3 d;
	lowp mat4 e[];
};
layout(std140, binding = 3) buffer BlockD
{
	bvec4 f;
	mediump vec4 g;
};
layout(std140, column_major, binding = 4) buffer BlockE
{
	mediump vec4 h;
	mediump mat3x2 i;
	mediump uvec3 j;
	mediump uvec2 k;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(e[0], mat4(-9.0, 0.0, 4.0, 8.0, 0.0, -2.0, -7.0, 9.0, -9.0, -5.0, -2.0, 0.0, 7.0, 2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(e[1], mat4(2.0, 9.0, -9.0, -3.0, 3.0, -3.0, 2.0, 5.0, 8.0, 1.0, 7.0, 0.0, 7.0, 4.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4(e[2], mat4(7.0, -4.0, 4.0, 7.0, 3.0, 8.0, 1.0, 6.0, 3.0, 0.0, -5.0, -9.0, 8.0, 0.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(e[3], mat4(-3.0, -6.0, -8.0, 7.0, 5.0, -5.0, -6.0, 0.0, 1.0, -8.0, 0.0, 1.0, -9.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4(e[4], mat4(-1.0, 5.0, -2.0, -8.0, 3.0, -9.0, 9.0, -1.0, 4.0, 3.0, 3.0, -1.0, 6.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4(e[5], mat4(-9.0, -6.0, 0.0, 8.0, 4.0, 6.0, -2.0, -1.0, -8.0, 0.0, -4.0, -9.0, 8.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_bvec4((f), bvec4(false, true, false, false)) && allOk;
	allOk = compare_vec4((h), vec4(2.0, -4.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3x2(i, mat3x2(-8.0, 2.0, -1.0, -8.0, -2.0, -9.0)) && allOk;
	allOk = compare_uvec3((j), uvec3(6u, 2u, 6u)) && allOk;
	allOk = compare_uvec2((k), uvec2(2u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4x2(0.0, -7.0, 3.0, -2.0, 2.0, -7.0, 4.0, 6.0));
	b = (3u);
	f = (bvec4(true, true, false, true));
	h = (vec4(7.0, -3.0, 2.0, 1.0));
	i = (mat3x2(4.0, -3.0, 5.0, -3.0, -2.0, 1.0));
	j = (uvec3(1u, 6u, 0u));
	k = (uvec2(3u, 1u));
}
#version 450
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
};
struct sB
{
	highp vec3 mA;
	mediump uvec2 mB[3];
	sA mC;
	highp uvec3 mD;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	mediump float a;
	bool b;
	highp mat3 c;
	lowp mat2 d[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	mediump uvec2 e;
	bool f;
	sB g[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -7.0) && allOk;
	allOk = compare_mat3(blockB.c, mat3(-2.0, 9.0, -9.0, -1.0, -9.0, 1.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_uvec2((blockC.e), uvec2(9u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-6.0);
	blockC.g[0].mA = (vec3(3.0, -1.0, 4.0));
	blockC.g[0].mB[0] = (uvec2(4u, 1u));
	blockC.g[0].mB[1] = (uvec2(1u, 6u));
	blockC.g[0].mB[2] = (uvec2(8u, 1u));
	blockC.g[0].mC.mA = (mat3x2(-9.0, 1.0, -8.0, -6.0, -7.0, 3.0));
	blockC.g[0].mD = (uvec3(9u, 9u, 9u));
	blockC.g[1].mA = (vec3(1.0, -8.0, -8.0));
	blockC.g[1].mB[0] = (uvec2(1u, 0u));
	blockC.g[1].mB[1] = (uvec2(4u, 1u));
	blockC.g[1].mB[2] = (uvec2(7u, 9u));
	blockC.g[1].mC.mA = (mat3x2(-6.0, 6.0, 6.0, 0.0, -2.0, 8.0));
	blockC.g[1].mD = (uvec3(0u, 8u, 9u));
	blockC.g[2].mA = (vec3(-1.0, -5.0, 7.0));
	blockC.g[2].mB[0] = (uvec2(2u, 6u));
	blockC.g[2].mB[1] = (uvec2(2u, 2u));
	blockC.g[2].mB[2] = (uvec2(7u, 4u));
	blockC.g[2].mC.mA = (mat3x2(-8.0, -9.0, -9.0, -7.0, 9.0, -7.0));
	blockC.g[2].mD = (uvec3(4u, 4u, 3u));
	blockC.g[3].mA = (vec3(-5.0, -3.0, -8.0));
	blockC.g[3].mB[0] = (uvec2(4u, 6u));
	blockC.g[3].mB[1] = (uvec2(9u, 5u));
	blockC.g[3].mB[2] = (uvec2(9u, 8u));
	blockC.g[3].mC.mA = (mat3x2(-8.0, 7.0, 4.0, -4.0, 4.0, -1.0));
	blockC.g[3].mD = (uvec3(9u, 8u, 2u));
}
#version 450
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
	layout(offset = 0) mediump uint a;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((a), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
struct sB
{
	sA mA;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	sB a[];
} blockB;

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a[0].mA.mA), uvec2(2u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.a[0].mA.mB), uvec3(8u, 6u, 9u)) && allOk;
	allOk = compare_uvec4((blockB.a[0].mA.mC), uvec4(7u, 9u, 2u, 7u)) && allOk;
	allOk = compare_bvec3((blockB.a[0].mA.mD), bvec3(false, true, true)) && allOk;
	allOk = compare_uvec2((blockB.a[1].mA.mA), uvec2(3u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.a[1].mA.mB), uvec3(9u, 7u, 3u)) && allOk;
	allOk = compare_uvec4((blockB.a[1].mA.mC), uvec4(2u, 2u, 6u, 5u)) && allOk;
	allOk = compare_bvec3((blockB.a[1].mA.mD), bvec3(false, true, false)) && allOk;
	allOk = compare_uvec2((blockB.a[2].mA.mA), uvec2(8u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.a[2].mA.mB), uvec3(2u, 1u, 8u)) && allOk;
	allOk = compare_uvec4((blockB.a[2].mA.mC), uvec4(9u, 7u, 3u, 3u)) && allOk;
	allOk = compare_bvec3((blockB.a[2].mA.mD), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec2((blockB.a[3].mA.mA), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec3((blockB.a[3].mA.mB), uvec3(6u, 0u, 5u)) && allOk;
	allOk = compare_uvec4((blockB.a[3].mA.mC), uvec4(2u, 7u, 1u, 7u)) && allOk;
	allOk = compare_bvec3((blockB.a[3].mA.mD), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec2((blockB.a[4].mA.mA), uvec2(5u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.a[4].mA.mB), uvec3(1u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.a[4].mA.mC), uvec4(7u, 0u, 7u, 3u)) && allOk;
	allOk = compare_bvec3((blockB.a[4].mA.mD), bvec3(false, true, false)) && allOk;
	allOk = compare_uvec2((blockB.a[5].mA.mA), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.a[5].mA.mB), uvec3(5u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((blockB.a[5].mA.mC), uvec4(4u, 5u, 2u, 9u)) && allOk;
	allOk = compare_bvec3((blockB.a[5].mA.mD), bvec3(false, true, false)) && allOk;
	allOk = compare_uvec2((blockB.a[6].mA.mA), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec3((blockB.a[6].mA.mB), uvec3(5u, 4u, 8u)) && allOk;
	allOk = compare_uvec4((blockB.a[6].mA.mC), uvec4(9u, 1u, 6u, 2u)) && allOk;
	allOk = compare_bvec3((blockB.a[6].mA.mD), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec2((blockB.a[7].mA.mA), uvec2(5u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.a[7].mA.mB), uvec3(3u, 5u, 2u)) && allOk;
	allOk = compare_uvec4((blockB.a[7].mA.mC), uvec4(8u, 3u, 2u, 8u)) && allOk;
	allOk = compare_bvec3((blockB.a[7].mA.mD), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA.mA = (uvec2(4u, 9u));
	blockB.a[0].mA.mB = (uvec3(9u, 2u, 9u));
	blockB.a[0].mA.mC = (uvec4(4u, 7u, 7u, 1u));
	blockB.a[0].mA.mD = (bvec3(true, false, false));
	blockB.a[1].mA.mA = (uvec2(2u, 4u));
	blockB.a[1].mA.mB = (uvec3(9u, 4u, 3u));
	blockB.a[1].mA.mC = (uvec4(2u, 7u, 1u, 3u));
	blockB.a[1].mA.mD = (bvec3(false, false, true));
	blockB.a[2].mA.mA = (uvec2(5u, 7u));
	blockB.a[2].mA.mB = (uvec3(7u, 2u, 0u));
	blockB.a[2].mA.mC = (uvec4(0u, 1u, 0u, 6u));
	blockB.a[2].mA.mD = (bvec3(false, false, false));
	blockB.a[3].mA.mA = (uvec2(9u, 5u));
	blockB.a[3].mA.mB = (uvec3(0u, 5u, 9u));
	blockB.a[3].mA.mC = (uvec4(3u, 9u, 6u, 7u));
	blockB.a[3].mA.mD = (bvec3(false, true, true));
	blockB.a[4].mA.mA = (uvec2(9u, 4u));
	blockB.a[4].mA.mB = (uvec3(1u, 7u, 0u));
	blockB.a[4].mA.mC = (uvec4(6u, 5u, 6u, 2u));
	blockB.a[4].mA.mD = (bvec3(false, true, true));
	blockB.a[5].mA.mA = (uvec2(8u, 6u));
	blockB.a[5].mA.mB = (uvec3(5u, 5u, 5u));
	blockB.a[5].mA.mC = (uvec4(8u, 5u, 7u, 3u));
	blockB.a[5].mA.mD = (bvec3(false, true, false));
	blockB.a[6].mA.mA = (uvec2(7u, 9u));
	blockB.a[6].mA.mB = (uvec3(3u, 6u, 6u));
	blockB.a[6].mA.mC = (uvec4(5u, 1u, 9u, 2u));
	blockB.a[6].mA.mD = (bvec3(false, false, false));
	blockB.a[7].mA.mA = (uvec2(1u, 2u));
	blockB.a[7].mA.mB = (uvec3(5u, 7u, 8u));
	blockB.a[7].mA.mC = (uvec4(5u, 7u, 2u, 7u));
	blockB.a[7].mA.mD = (bvec3(false, false, true));
}
#version 450
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
	highp vec4 mB;
	lowp mat2x3 mC;
};
struct sB
{
	lowp mat4x2 mA;
	highp mat2x3 mB;
};
layout(scalar, row_major, binding = 1) readonly buffer BlockB
{
	mediump int a[][7][4];
};
layout(scalar, binding = 2) buffer BlockC
{
	highp mat2x3 b[];
};
layout(scalar, binding = 3) buffer BlockD
{
	bvec4 c;
	highp mat4x3 d;
	sA e;
	sB f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(b[0], mat2x3(-8.0, -9.0, -3.0, 3.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2x3(b[1], mat2x3(-3.0, 3.0, -1.0, 0.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(b[2], mat2x3(6.0, 4.0, -7.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2x3(b[3], mat2x3(8.0, -4.0, 8.0, 3.0, -8.0, 5.0)) && allOk;
	allOk = compare_bvec4((c), bvec4(true, true, true, false)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(-1.0, -1.0, 8.0, -5.0, 8.0, 2.0, -1.0, 8.0, -8.0, 2.0, 2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (mat2x3(0.0, 6.0, -1.0, 1.0, -3.0, 7.0));
	b[1] = (mat2x3(-9.0, 3.0, -1.0, 0.0, 8.0, -9.0));
	b[2] = (mat2x3(-5.0, 5.0, 1.0, -1.0, -9.0, -5.0));
	b[3] = (mat2x3(-1.0, 2.0, -4.0, -1.0, -8.0, -3.0));
	c = (bvec4(true, false, false, true));
	d = (mat4x3(-3.0, 4.0, -7.0, -6.0, 8.0, 5.0, 2.0, -1.0, 0.0, 4.0, 9.0, -2.0));
	e.mA = (mat2(0.0, 9.0, 9.0, -2.0));
	e.mB = (vec4(-5.0, 9.0, -8.0, 8.0));
	e.mC = (mat2x3(-5.0, 5.0, -7.0, -4.0, 3.0, 4.0));
	f[0].mA = (mat4x2(-1.0, 6.0, 1.0, 9.0, -3.0, -8.0, 0.0, -7.0));
	f[0].mB = (mat2x3(-2.0, -4.0, 8.0, 7.0, 6.0, 3.0));
	f[1].mA = (mat4x2(-9.0, 4.0, 3.0, 7.0, 0.0, -4.0, -4.0, -6.0));
	f[1].mB = (mat2x3(4.0, 0.0, 9.0, 6.0, 0.0, 3.0));
	f[2].mA = (mat4x2(4.0, 8.0, -1.0, -6.0, 4.0, 3.0, 2.0, 3.0));
	f[2].mB = (mat2x3(-6.0, 0.0, 3.0, -9.0, -7.0, -8.0));
	f[3].mA = (mat4x2(6.0, -1.0, -4.0, -2.0, 5.0, 8.0, -9.0, 9.0));
	f[3].mB = (mat2x3(-9.0, 7.0, 0.0, -1.0, -9.0, -5.0));
	f[4].mA = (mat4x2(-8.0, 8.0, -8.0, 5.0, 8.0, -6.0, 9.0, -3.0));
	f[4].mB = (mat2x3(-1.0, 7.0, 3.0, -2.0, 8.0, -1.0));
}
#version 450
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
	highp vec2 a;
	bvec3 b;
	lowp mat2 c;
	highp mat3 d;
	bool e[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(false, false, true)) && allOk;
	allOk = compare_mat3(blockB.d, mat3(0.0, 8.0, -8.0, -9.0, 1.0, -6.0, 1.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(1.0, 1.0));
	blockB.b = (bvec3(true, true, true));
	blockB.d = (mat3(3.0, -4.0, -3.0, 4.0, -7.0, 6.0, -1.0, -8.0, 5.0));
	blockB.e[0] = (true);
}
#version 450
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
	lowp vec2 a;
	mediump uvec4 b;
	u16vec2 c;
	bvec4 d;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	mediump uint e;
	u16vec4 f;
	lowp ivec2 g;
	lowp vec2 h;
	bvec2 i;
};
layout(std430, binding = 3) buffer BlockD
{
	mediump uvec4 j;
	bvec2 k;
	bool l;
	u16vec2 m;
	u16vec2 n[1];
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	i16vec3 o;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-8.0, -8.0)) && allOk;
	allOk = compare_uvec4((blockB.b), uvec4(4u, 9u, 3u, 7u)) && allOk;
	allOk = compare_bvec4((blockB.d), bvec4(false, true, false, false)) && allOk;
	allOk = compare_uint((e), 8u) && allOk;
	allOk = compare_u16vec4(uvec4(f), uvec4(0u, 3u, 0u, 4u)) && allOk;
	allOk = compare_vec2((h), vec2(5.0, -9.0)) && allOk;
	allOk = compare_uvec4((blockD.j), uvec4(4u, 6u, 8u, 4u)) && allOk;
	allOk = compare_bvec2((blockD.k), bvec2(false, false)) && allOk;
	allOk = compare_bool((blockD.l), true) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.n[0]), uvec2(6u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec4(4u, 8u, 5u, 6u));
	blockB.c = u16vec2(uvec2(5u, 8u));
	blockB.d = (bvec4(true, false, true, true));
	e = (2u);
	f = u16vec4(uvec4(5u, 7u, 7u, 0u));
	g = (ivec2(3, 6));
	h = (vec2(-6.0, 5.0));
	blockD.j = (uvec4(7u, 4u, 8u, 6u));
	blockD.k = (bvec2(false, true));
	blockD.l = (false);
	blockD.n[0] = u16vec2(uvec2(0u, 5u));
	o = i16vec3(ivec3(7, -9, -8));
}
#version 450
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
	u16vec2 a;
	highp mat4x3 b;
	lowp mat4x3 c;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp mat4x3 d;
	mediump ivec2 e;
	f16vec3 f;
	highp mat2 g;
	f16vec3 h[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(a), uvec2(6u, 7u)) && allOk;
	allOk = compare_mat4x3(b, mat4x3(-6.0, 6.0, -6.0, -2.0, 3.0, -4.0, -1.0, 2.0, -6.0, -2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(4.0, -8.0, 7.0, -4.0, -9.0, -4.0, 3.0, 0.0, -2.0, -5.0, 0.0, 1.0)) && allOk;
	allOk = compare_ivec2((e), ivec2(-8, 1)) && allOk;
	allOk = compare_f16vec3(vec3(f), vec3(-1.0, 0.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat4x3(5.0, -7.0, 0.0, 1.0, 9.0, -8.0, -7.0, -9.0, -9.0, -3.0, 8.0, 5.0));
	c = (mat4x3(4.0, -6.0, -9.0, -2.0, 3.0, 3.0, -5.0, -5.0, -9.0, 5.0, 0.0, -1.0));
	e = (ivec2(-9, 3));
	g = (mat2(-5.0, -2.0, -2.0, -6.0));
	h[0] = f16vec3(vec3(4.0, 9.0, -2.0));
}
#version 450
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
};
struct sB
{
	sA mA;
	mediump uvec3 mB;
	int16_t mC[3];
	lowp uvec4 mD;
};
struct sC
{
	bool mA;
	u16vec3 mB;
};
struct sD
{
	highp uint mA;
	bvec3 mB;
};
struct sE
{
	sD mA;
};
layout(std430, binding = 1) buffer BlockB
{
	float16_t a;
	sB b;
	highp mat2 c;
	f16vec4 d[7][4];
	u16vec4 e[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	sC f;
	u16vec3 g[1];
	bvec4 h;
	sE i;
	mediump vec3 j[];
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	mediump mat4x2 k[];
};
layout(std140, column_major, binding = 4) buffer BlockE
{
	i16vec4 l;
	bvec3 m;
	lowp int n[][2];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(b.mA.mA), uvec2(5u, 1u)) && allOk;
	allOk = compare_uvec3((b.mB), uvec3(9u, 5u, 7u)) && allOk;
	allOk = compare_int16_t(int(b.mC[0]), 4) && allOk;
	allOk = compare_int16_t(int(b.mC[1]), 1) && allOk;
	allOk = compare_int16_t(int(b.mC[2]), -8) && allOk;
	allOk = compare_uvec4((b.mD), uvec4(4u, 5u, 9u, 0u)) && allOk;
	allOk = compare_mat2(c, mat2(8.0, 1.0, 9.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[0][0]), vec4(-4.0, 1.0, -4.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[0][1]), vec4(-3.0, 1.0, 5.0, 6.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[0][2]), vec4(9.0, 0.0, 1.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[0][3]), vec4(1.0, 6.0, 6.0, 6.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[1][0]), vec4(-8.0, 6.0, 6.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[1][1]), vec4(1.0, 4.0, 6.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[1][2]), vec4(0.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[1][3]), vec4(9.0, -9.0, 9.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[2][0]), vec4(-9.0, 3.0, 5.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[2][1]), vec4(3.0, 1.0, -6.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[2][2]), vec4(9.0, 1.0, 5.0, -7.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[2][3]), vec4(6.0, -1.0, -9.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[3][0]), vec4(8.0, 5.0, -4.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[3][1]), vec4(-8.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[3][2]), vec4(4.0, -2.0, 0.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[3][3]), vec4(-3.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[4][0]), vec4(2.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[4][1]), vec4(2.0, -5.0, 9.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[4][2]), vec4(9.0, 9.0, 2.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[4][3]), vec4(-5.0, 8.0, -5.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[5][0]), vec4(9.0, 6.0, -8.0, 6.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[5][1]), vec4(4.0, 4.0, -7.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[5][2]), vec4(7.0, -3.0, 9.0, -7.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[5][3]), vec4(-5.0, -7.0, 0.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[6][0]), vec4(3.0, 2.0, -6.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[6][1]), vec4(1.0, 6.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[6][2]), vec4(-6.0, 5.0, -1.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(d[6][3]), vec4(-6.0, -9.0, 1.0, 9.0)) && allOk;
	allOk = compare_u16vec4(uvec4(e[0]), uvec4(5u, 3u, 6u, 7u)) && allOk;
	allOk = compare_bvec4((blockC.h), bvec4(false, false, false, false)) && allOk;
	allOk = compare_uint((blockC.i.mA.mA), 3u) && allOk;
	allOk = compare_bvec3((blockC.i.mA.mB), bvec3(true, false, false)) && allOk;
	allOk = compare_mat4x2(k[0], mat4x2(-8.0, 3.0, 3.0, 4.0, -3.0, 0.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat4x2(k[1], mat4x2(5.0, -2.0, 6.0, -5.0, -9.0, 5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(k[2], mat4x2(3.0, 5.0, -1.0, 2.0, -7.0, 5.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat4x2(k[3], mat4x2(6.0, 2.0, -9.0, -3.0, 0.0, 5.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(k[4], mat4x2(7.0, -8.0, 4.0, -1.0, 3.0, 4.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4x2(k[5], mat4x2(6.0, -3.0, 3.0, -5.0, 2.0, -5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(k[6], mat4x2(-3.0, -2.0, 0.0, 1.0, 7.0, 4.0, 8.0, -2.0)) && allOk;
	allOk = compare_int((blockE.n[0][0]), -3) && allOk;
	allOk = compare_int((blockE.n[0][1]), -3) && allOk;
	allOk = compare_int((blockE.n[1][0]), 4) && allOk;
	allOk = compare_int((blockE.n[1][1]), -7) && allOk;
	allOk = compare_int((blockE.n[2][0]), 4) && allOk;
	allOk = compare_int((blockE.n[2][1]), -8) && allOk;
	allOk = compare_int((blockE.n[3][0]), -8) && allOk;
	allOk = compare_int((blockE.n[3][1]), 3) && allOk;
	allOk = compare_int((blockE.n[4][0]), -1) && allOk;
	allOk = compare_int((blockE.n[4][1]), 6) && allOk;
	allOk = compare_int((blockE.n[5][0]), -7) && allOk;
	allOk = compare_int((blockE.n[5][1]), -9) && allOk;
	allOk = compare_int((blockE.n[6][0]), -6) && allOk;
	allOk = compare_int((blockE.n[6][1]), 7) && allOk;
	allOk = compare_int((blockE.n[7][0]), 1) && allOk;
	allOk = compare_int((blockE.n[7][1]), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	a = float16_t(9.0);
	d[0][0] = f16vec4(vec4(3.0, 0.0, 4.0, -4.0));
	d[0][1] = f16vec4(vec4(-4.0, 1.0, -6.0, 2.0));
	d[0][2] = f16vec4(vec4(-1.0, 4.0, -4.0, -7.0));
	d[0][3] = f16vec4(vec4(8.0, -8.0, 1.0, -1.0));
	d[1][0] = f16vec4(vec4(-6.0, -3.0, 2.0, 0.0));
	d[1][1] = f16vec4(vec4(-6.0, -5.0, -6.0, 6.0));
	d[1][2] = f16vec4(vec4(-7.0, 0.0, -9.0, -1.0));
	d[1][3] = f16vec4(vec4(-1.0, 4.0, -2.0, -5.0));
	d[2][0] = f16vec4(vec4(5.0, 3.0, 0.0, 9.0));
	d[2][1] = f16vec4(vec4(-5.0, -3.0, 3.0, -7.0));
	d[2][2] = f16vec4(vec4(0.0, -2.0, -2.0, 7.0));
	d[2][3] = f16vec4(vec4(-9.0, -8.0, 3.0, 5.0));
	d[3][0] = f16vec4(vec4(5.0, -1.0, 7.0, -1.0));
	d[3][1] = f16vec4(vec4(-8.0, 0.0, -8.0, 4.0));
	d[3][2] = f16vec4(vec4(-3.0, -4.0, 9.0, -9.0));
	d[3][3] = f16vec4(vec4(-8.0, 8.0, 1.0, 2.0));
	d[4][0] = f16vec4(vec4(-6.0, 8.0, -9.0, 7.0));
	d[4][1] = f16vec4(vec4(-1.0, 3.0, -8.0, 3.0));
	d[4][2] = f16vec4(vec4(9.0, 6.0, -4.0, 0.0));
	d[4][3] = f16vec4(vec4(-9.0, 3.0, 5.0, 0.0));
	d[5][0] = f16vec4(vec4(-7.0, 1.0, 0.0, 0.0));
	d[5][1] = f16vec4(vec4(-4.0, 5.0, -3.0, 2.0));
	d[5][2] = f16vec4(vec4(1.0, 8.0, -6.0, 2.0));
	d[5][3] = f16vec4(vec4(-5.0, 6.0, 2.0, 0.0));
	d[6][0] = f16vec4(vec4(-4.0, 7.0, -3.0, 3.0));
	d[6][1] = f16vec4(vec4(-9.0, 4.0, 8.0, 3.0));
	d[6][2] = f16vec4(vec4(-6.0, -5.0, 9.0, -6.0));
	d[6][3] = f16vec4(vec4(-9.0, -2.0, -4.0, -9.0));
	e[0] = u16vec4(uvec4(3u, 8u, 2u, 8u));
	blockC.g[0] = u16vec3(uvec3(2u, 6u, 1u));
	blockC.h = (bvec4(false, false, true, false));
	blockC.i.mA.mA = (5u);
	blockC.i.mA.mB = (bvec3(true, true, false));
	blockC.j[0] = (vec3(9.0, -5.0, 6.0));
	blockC.j[1] = (vec3(2.0, -1.0, 3.0));
	blockC.j[2] = (vec3(-4.0, -9.0, 9.0));
	blockC.j[3] = (vec3(-8.0, 1.0, -2.0));
	blockC.j[4] = (vec3(-8.0, 3.0, 4.0));
	k[0] = (mat4x2(6.0, 2.0, 7.0, -6.0, 5.0, 2.0, -5.0, 6.0));
	k[1] = (mat4x2(8.0, -9.0, 1.0, 2.0, 0.0, -2.0, -6.0, 4.0));
	k[2] = (mat4x2(1.0, -4.0, -3.0, 4.0, 0.0, 2.0, -6.0, -1.0));
	k[3] = (mat4x2(-4.0, -3.0, 2.0, 8.0, 7.0, -3.0, 5.0, 7.0));
	k[4] = (mat4x2(6.0, 4.0, -9.0, -8.0, 7.0, 1.0, -7.0, 5.0));
	k[5] = (mat4x2(1.0, -7.0, 5.0, -8.0, -7.0, 8.0, 9.0, -6.0));
	k[6] = (mat4x2(-5.0, 2.0, -8.0, 3.0, -9.0, -4.0, -2.0, -1.0));
	blockE.l = i16vec4(ivec4(2, 4, -4, 9));
}
#version 450
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
	u16vec2 mB;
	u16vec2 mC;
	f16vec4 mD;
};
struct sB
{
	uint16_t mA;
	mediump vec3 mB;
	sA mC;
};
struct sC
{
	f16vec3 mA;
	highp mat4x2 mB;
	uint16_t mC;
};
struct sD
{
	i16vec4 mA;
	sC mB;
};
layout(std140, binding = 1) buffer BlockB
{
	float16_t a;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	sB b;
	mediump mat2x3 c;
	highp mat4x2 d;
	sD e;
	mediump mat4 f[];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(a), -2.0) && allOk;
	allOk = compare_mat2x3(blockC[0].c, mat2x3(9.0, 2.0, 7.0, 7.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = float16_t(-7.0);
	blockC[0].b.mA = uint16_t(1u);
	blockC[0].b.mB = (vec3(-9.0, -7.0, -4.0));
	blockC[0].b.mC.mA = (mat4(-1.0, 3.0, -7.0, -7.0, 9.0, -7.0, -9.0, 2.0, -4.0, -4.0, -8.0, -5.0, -4.0, 0.0, -4.0, -9.0));
	blockC[0].b.mC.mB = u16vec2(uvec2(5u, 4u));
	blockC[0].b.mC.mC = u16vec2(uvec2(0u, 3u));
	blockC[0].b.mC.mD = f16vec4(vec4(1.0, -8.0, -2.0, -5.0));
	blockC[0].c = (mat2x3(-9.0, 0.0, -2.0, -7.0, 7.0, 9.0));
	blockC[0].d = (mat4x2(-6.0, -3.0, 8.0, 6.0, 5.0, -2.0, 3.0, 2.0));
	blockC[0].e.mA = i16vec4(ivec4(-5, 5, 5, 3));
	blockC[0].e.mB.mA = f16vec3(vec3(8.0, 5.0, 5.0));
	blockC[0].e.mB.mB = (mat4x2(3.0, 1.0, 6.0, -2.0, 5.0, -3.0, 1.0, 8.0));
	blockC[0].e.mB.mC = uint16_t(3u);
	blockC[0].f[0] = (mat4(-1.0, 5.0, -8.0, 6.0, -8.0, 1.0, -8.0, -5.0, 9.0, 3.0, -6.0, 7.0, -7.0, 6.0, 7.0, 6.0));
}
#version 450
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
	highp int mB;
	f16vec3 mC;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	highp mat2x3 a;
	int16_t b[2];
	highp mat3 c;
};
layout(std430, column_major, binding = 2) readonly buffer BlockC
{
	lowp mat3x2 d[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	u16vec2 e;
	highp vec2 f;
	sA g[];
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(b[0]), -4) && allOk;
	allOk = compare_int16_t(int(b[1]), -2) && allOk;
	allOk = compare_mat3(c, mat3(-2.0, 1.0, 6.0, -4.0, 8.0, 7.0, 8.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec2((blockD[0].f), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2((blockD[1].f), vec2(2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = int16_t(4);
	b[1] = int16_t(-9);
	blockD[0].e = u16vec2(uvec2(2u, 3u));
	blockD[0].f = (vec2(-3.0, -7.0));
	blockD[1].e = u16vec2(uvec2(1u, 5u));
	blockD[1].f = (vec2(3.0, 7.0));
}
#version 450
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
	layout(offset = 4) bvec2 b;
	layout(offset = 16) i16vec4 c;
	layout(offset = 24) f16vec2 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump uvec3 e;
	layout(offset = 12) bool f;
	layout(offset = 16) lowp uvec3 g;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) i16vec4 h;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.b), bvec2(false, false)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c), ivec4(-5, 1, -7, 1)) && allOk;
	allOk = compare_uvec3((blockC.e), uvec3(7u, 6u, 0u)) && allOk;
	allOk = compare_bool((blockC.f), false) && allOk;
	allOk = compare_uvec3((blockC.g), uvec3(2u, 5u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (5u);
	blockB.b = (bvec2(false, true));
	blockB.c = i16vec4(ivec4(-8, -5, 0, 0));
	blockB.d = f16vec2(vec2(-7.0, 5.0));
	blockC.e = (uvec3(1u, 5u, 2u));
	blockC.f = (false);
	blockC.g = (uvec3(2u, 7u, 3u));
	blockD.h = i16vec4(ivec4(0, 8, -6, 5));
}
#version 450
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
	layout(offset = 0) i16vec2 a;
	layout(offset = 4) mediump vec2 b;
	layout(offset = 12) lowp float c;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bool d;
	layout(offset = 16) lowp uvec4 e;
	layout(offset = 32) mediump uvec3 f;
	layout(offset = 48) highp uvec2 g;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(a), ivec2(0, -6)) && allOk;
	allOk = compare_bool((blockC.d), true) && allOk;
	allOk = compare_uvec4((blockC.e), uvec4(1u, 5u, 7u, 6u)) && allOk;
	allOk = compare_uvec2((blockC.g), uvec2(3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i16vec2(ivec2(9, -5));
	b = (vec2(0.0, 1.0));
	c = (-9.0);
	blockC.d = (false);
	blockC.e = (uvec4(5u, 0u, 4u, 8u));
	blockC.f = (uvec3(7u, 1u, 1u));
	blockC.g = (uvec2(6u, 3u));
}
#version 450
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
	lowp ivec3 mB;
	mediump uint mC;
};
struct sB
{
	highp mat2 mA;
	sA mB;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	sB a;
	mediump vec4 b[];
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	float16_t c[][4];
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	mediump int d[2];
	highp mat2 e;
	mediump uint f[][3];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(a.mA, mat2(2.0, -4.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec4((a.mB.mA), vec4(6.0, 2.0, -2.0, -6.0)) && allOk;
	allOk = compare_ivec3((a.mB.mB), ivec3(-4, 9, 7)) && allOk;
	allOk = compare_uint((a.mB.mC), 9u) && allOk;
	allOk = compare_mat2(blockD.e, mat2(9.0, 9.0, 0.0, -7.0)) && allOk;
	allOk = compare_uint((blockD.f[0][0]), 6u) && allOk;
	allOk = compare_uint((blockD.f[0][1]), 2u) && allOk;
	allOk = compare_uint((blockD.f[0][2]), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = (mat2(-1.0, 9.0, 1.0, 3.0));
	a.mB.mA = (vec4(5.0, -9.0, 8.0, 2.0));
	a.mB.mB = (ivec3(-7, 3, 6));
	a.mB.mC = (5u);
	b[0] = (vec4(-6.0, -3.0, 8.0, 4.0));
	b[1] = (vec4(9.0, 1.0, 0.0, -1.0));
	b[2] = (vec4(4.0, -4.0, -2.0, -2.0));
	b[3] = (vec4(6.0, -3.0, 8.0, 7.0));
	b[4] = (vec4(-8.0, 2.0, -5.0, 3.0));
	b[5] = (vec4(-3.0, 5.0, -3.0, 8.0));
	blockC.c[0][0] = float16_t(-5.0);
	blockC.c[0][1] = float16_t(-1.0);
	blockC.c[0][2] = float16_t(0.0);
	blockC.c[0][3] = float16_t(2.0);
	blockC.c[1][0] = float16_t(7.0);
	blockC.c[1][1] = float16_t(-3.0);
	blockC.c[1][2] = float16_t(2.0);
	blockC.c[1][3] = float16_t(9.0);
	blockC.c[2][0] = float16_t(-6.0);
	blockC.c[2][1] = float16_t(-1.0);
	blockC.c[2][2] = float16_t(7.0);
	blockC.c[2][3] = float16_t(9.0);
	blockC.c[3][0] = float16_t(-2.0);
	blockC.c[3][1] = float16_t(4.0);
	blockC.c[3][2] = float16_t(1.0);
	blockC.c[3][3] = float16_t(-6.0);
	blockC.c[4][0] = float16_t(5.0);
	blockC.c[4][1] = float16_t(-9.0);
	blockC.c[4][2] = float16_t(-1.0);
	blockC.c[4][3] = float16_t(8.0);
	blockC.c[5][0] = float16_t(6.0);
	blockC.c[5][1] = float16_t(-1.0);
	blockC.c[5][2] = float16_t(8.0);
	blockC.c[5][3] = float16_t(9.0);
	blockC.c[6][0] = float16_t(8.0);
	blockC.c[6][1] = float16_t(-4.0);
	blockC.c[6][2] = float16_t(9.0);
	blockC.c[6][3] = float16_t(-7.0);
	blockC.c[7][0] = float16_t(-6.0);
	blockC.c[7][1] = float16_t(9.0);
	blockC.c[7][2] = float16_t(-3.0);
	blockC.c[7][3] = float16_t(-6.0);
	blockD.e = (mat2(-1.0, -1.0, 9.0, -3.0));
	blockD.f[0][0] = (6u);
	blockD.f[0][1] = (2u);
	blockD.f[0][2] = (8u);
}
#version 450
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
	lowp ivec2 a;
	u8vec3 b;
	mediump mat4 c;
	u8vec3 d;
	mediump mat2 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((a), ivec2(-8, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(-2, -9));
	b = u8vec3(uvec3(4u, 8u, 5u));
	c = (mat4(7.0, -9.0, 6.0, 2.0, -7.0, 4.0, 4.0, -9.0, -6.0, -6.0, 6.0, -8.0, -5.0, 2.0, -5.0, 3.0));
	d = u8vec3(uvec3(8u, 2u, 8u));
}
#version 450
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
	int8_t mA[6];
	u8vec2 mB;
	highp int mC[2];
	mediump vec4 mD;
};
layout(std140, binding = 1) buffer BlockB
{
	highp mat4x3 a[2][6][6];
	sA b;
	i8vec2 c;
	mediump mat2 d;
	mediump mat3x2 e;
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp mat3x4 f;
	mediump uvec2 g[];
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	mediump ivec4 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a[0][0][0], mat4x3(2.0, -3.0, 2.0, -4.0, 4.0, 6.0, -2.0, -5.0, -3.0, -3.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][0][1], mat4x3(8.0, 7.0, 3.0, 3.0, -4.0, 8.0, -7.0, -9.0, -3.0, 4.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][0][2], mat4x3(-7.0, -1.0, 9.0, -6.0, 8.0, -4.0, 4.0, 1.0, -6.0, -2.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][0][3], mat4x3(4.0, 3.0, 0.0, 6.0, -1.0, -8.0, -3.0, -6.0, 1.0, 7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][0][4], mat4x3(-9.0, 2.0, 9.0, 7.0, 3.0, 6.0, 2.0, 0.0, -1.0, 1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][0][5], mat4x3(9.0, -2.0, -1.0, -4.0, -8.0, 0.0, 6.0, -5.0, -2.0, -7.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][1][0], mat4x3(1.0, -5.0, -2.0, 7.0, 7.0, -4.0, 2.0, 9.0, -2.0, -6.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][1][1], mat4x3(-6.0, -6.0, 0.0, 1.0, 4.0, 6.0, 5.0, 8.0, -3.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][1][2], mat4x3(7.0, -4.0, 4.0, 7.0, -3.0, 7.0, 5.0, 3.0, 7.0, 3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][1][3], mat4x3(0.0, -4.0, 8.0, -8.0, -8.0, 7.0, -4.0, -4.0, 9.0, -5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][1][4], mat4x3(-8.0, 9.0, 8.0, 0.0, 2.0, 8.0, -1.0, 1.0, 0.0, -7.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][1][5], mat4x3(3.0, -9.0, 1.0, 5.0, 3.0, -1.0, -7.0, 3.0, 8.0, -5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][2][0], mat4x3(3.0, -7.0, 7.0, -9.0, -5.0, -1.0, -9.0, 1.0, -5.0, -7.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][2][1], mat4x3(2.0, -8.0, -8.0, 0.0, 5.0, 2.0, 5.0, 8.0, -7.0, -3.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][2][2], mat4x3(-5.0, -6.0, 8.0, -8.0, 4.0, 8.0, -9.0, 6.0, 4.0, 3.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][2][3], mat4x3(-6.0, -9.0, -5.0, -4.0, 1.0, -3.0, 7.0, -8.0, -7.0, 4.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][2][4], mat4x3(4.0, -8.0, 8.0, 7.0, -1.0, 7.0, 7.0, -3.0, 3.0, -3.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][2][5], mat4x3(5.0, -4.0, -1.0, -6.0, 3.0, -3.0, 1.0, 8.0, 3.0, -6.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][3][0], mat4x3(-9.0, -2.0, -7.0, 5.0, 5.0, 4.0, -8.0, -1.0, -1.0, 4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][3][1], mat4x3(-9.0, -3.0, -2.0, 5.0, -2.0, -3.0, -5.0, -6.0, -6.0, 7.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][3][2], mat4x3(6.0, 7.0, -4.0, 0.0, 3.0, 2.0, 5.0, 5.0, 3.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][3][3], mat4x3(0.0, -1.0, 6.0, -2.0, 8.0, 6.0, 1.0, -2.0, -5.0, 9.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][3][4], mat4x3(0.0, -1.0, 1.0, 2.0, -9.0, -6.0, -4.0, 9.0, -6.0, -5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][3][5], mat4x3(4.0, 6.0, 3.0, -1.0, -7.0, 8.0, 5.0, 1.0, -7.0, 0.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][4][0], mat4x3(-1.0, -5.0, 7.0, -5.0, 1.0, 5.0, -9.0, -8.0, -4.0, 5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][4][1], mat4x3(-4.0, 7.0, 4.0, 7.0, 9.0, -2.0, 1.0, -7.0, -3.0, -2.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][4][2], mat4x3(6.0, -5.0, -8.0, -9.0, -2.0, 7.0, 3.0, -6.0, -3.0, -7.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][4][3], mat4x3(-2.0, -4.0, 2.0, -1.0, -7.0, -7.0, 4.0, 6.0, 8.0, -1.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][4][4], mat4x3(0.0, 8.0, 9.0, -3.0, -8.0, 8.0, 5.0, 7.0, 6.0, 6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][4][5], mat4x3(-9.0, 6.0, -1.0, -2.0, -1.0, -5.0, 5.0, 9.0, -4.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][5][0], mat4x3(7.0, 8.0, 1.0, -2.0, 5.0, 2.0, 0.0, 9.0, 9.0, 7.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][5][1], mat4x3(4.0, -4.0, 7.0, 3.0, 1.0, -4.0, 3.0, 1.0, -9.0, -2.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][5][2], mat4x3(-1.0, -7.0, 6.0, -7.0, 9.0, 1.0, 2.0, 8.0, -1.0, 1.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][5][3], mat4x3(-8.0, -6.0, -1.0, -9.0, -8.0, -6.0, -7.0, 7.0, -5.0, 0.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][5][4], mat4x3(-4.0, 5.0, -3.0, 0.0, -6.0, -3.0, 4.0, -2.0, -7.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][5][5], mat4x3(-8.0, -7.0, -9.0, 6.0, -2.0, -3.0, 2.0, -9.0, 9.0, 2.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][0][0], mat4x3(-2.0, -9.0, -7.0, -2.0, -3.0, -3.0, -9.0, 6.0, 9.0, -7.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][0][1], mat4x3(9.0, -3.0, -4.0, -8.0, -7.0, -2.0, 6.0, -3.0, 7.0, 7.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][0][2], mat4x3(-9.0, 3.0, -2.0, 0.0, 5.0, -6.0, -6.0, -2.0, 8.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][0][3], mat4x3(7.0, 4.0, 7.0, 9.0, 6.0, 1.0, 2.0, 3.0, 1.0, 6.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][0][4], mat4x3(-3.0, 5.0, 0.0, -8.0, 6.0, -7.0, 1.0, -3.0, 9.0, -6.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][0][5], mat4x3(2.0, 6.0, -6.0, 9.0, 7.0, -8.0, -4.0, -3.0, 5.0, 3.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][1][0], mat4x3(6.0, -4.0, 6.0, -2.0, 5.0, 8.0, 3.0, -2.0, 3.0, 4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][1][1], mat4x3(8.0, 5.0, -2.0, 0.0, -1.0, 3.0, -1.0, -1.0, 9.0, -8.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][1][2], mat4x3(8.0, 1.0, 2.0, 6.0, 2.0, -4.0, -3.0, 1.0, -1.0, -4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][1][3], mat4x3(-6.0, -3.0, 8.0, -6.0, 2.0, 7.0, 4.0, -5.0, 7.0, -9.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][1][4], mat4x3(-1.0, -4.0, 6.0, -6.0, 0.0, -7.0, -2.0, 6.0, -1.0, 4.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][1][5], mat4x3(5.0, -8.0, 6.0, -4.0, 2.0, -6.0, 0.0, 3.0, -6.0, -6.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][2][0], mat4x3(-9.0, 9.0, 5.0, -1.0, -2.0, -8.0, -9.0, 7.0, 9.0, -3.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][2][1], mat4x3(9.0, -4.0, -1.0, -4.0, 1.0, -6.0, -5.0, -5.0, -3.0, 1.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][2][2], mat4x3(-6.0, 7.0, -7.0, 1.0, -3.0, -7.0, 5.0, -9.0, -1.0, 6.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][2][3], mat4x3(-1.0, -7.0, 4.0, -6.0, -6.0, 4.0, -3.0, -3.0, 2.0, 0.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][2][4], mat4x3(-5.0, 8.0, -6.0, 2.0, -4.0, -9.0, -4.0, -5.0, 9.0, -5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][2][5], mat4x3(7.0, 5.0, 7.0, 6.0, 4.0, 8.0, 8.0, -3.0, 0.0, 0.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][3][0], mat4x3(0.0, 2.0, 2.0, 8.0, -4.0, 4.0, 5.0, -9.0, 3.0, 0.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][3][1], mat4x3(-5.0, -6.0, -7.0, 4.0, -7.0, 3.0, -4.0, 3.0, -7.0, -8.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][3][2], mat4x3(8.0, 7.0, 3.0, 3.0, -7.0, 0.0, -7.0, -1.0, -6.0, 0.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][3][3], mat4x3(6.0, -1.0, 4.0, 0.0, -5.0, 1.0, 2.0, 4.0, 0.0, 6.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][3][4], mat4x3(-1.0, -7.0, 4.0, -1.0, 3.0, 3.0, -2.0, 4.0, 6.0, 0.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][3][5], mat4x3(-5.0, -6.0, 2.0, -7.0, -1.0, -5.0, 8.0, 6.0, 0.0, -6.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][4][0], mat4x3(-2.0, -8.0, 4.0, 0.0, 5.0, -1.0, 4.0, 7.0, 0.0, -4.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][4][1], mat4x3(8.0, 0.0, 2.0, -4.0, 1.0, 1.0, -8.0, -1.0, -7.0, 2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][4][2], mat4x3(6.0, -2.0, -4.0, 6.0, -7.0, -4.0, -3.0, -3.0, 2.0, -9.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][4][3], mat4x3(7.0, -8.0, 0.0, 9.0, 4.0, 8.0, -9.0, -2.0, -9.0, -4.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][4][4], mat4x3(-5.0, 3.0, 0.0, 7.0, -7.0, -7.0, -8.0, 6.0, -8.0, 7.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][4][5], mat4x3(-3.0, 3.0, 1.0, -8.0, -1.0, 4.0, 9.0, -5.0, 2.0, 0.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][5][0], mat4x3(1.0, -7.0, -4.0, -2.0, 6.0, 8.0, -7.0, -7.0, 5.0, -6.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][5][1], mat4x3(-7.0, -1.0, -3.0, 7.0, 2.0, 2.0, 2.0, -2.0, -4.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][5][2], mat4x3(3.0, 3.0, -5.0, -3.0, 8.0, -4.0, 4.0, -1.0, -4.0, -2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][5][3], mat4x3(-9.0, 6.0, -9.0, 7.0, -7.0, 4.0, -7.0, 8.0, -4.0, -7.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][5][4], mat4x3(3.0, -7.0, -3.0, -3.0, 5.0, -5.0, 9.0, -1.0, -9.0, 8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][5][5], mat4x3(-4.0, -2.0, 4.0, 9.0, -9.0, 4.0, -2.0, 9.0, -1.0, 1.0, 4.0, -1.0)) && allOk;
	allOk = compare_int8_t(int(blockB.b.mA[0]), 4294967294) && allOk;
	allOk = compare_int8_t(int(blockB.b.mA[1]), 0) && allOk;
	allOk = compare_int8_t(int(blockB.b.mA[2]), 4294967291) && allOk;
	allOk = compare_int8_t(int(blockB.b.mA[3]), 5) && allOk;
	allOk = compare_int8_t(int(blockB.b.mA[4]), 4294967290) && allOk;
	allOk = compare_int8_t(int(blockB.b.mA[5]), 4294967293) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.b.mB), uvec2(3u, 7u)) && allOk;
	allOk = compare_int((blockB.b.mC[0]), 6) && allOk;
	allOk = compare_int((blockB.b.mC[1]), 2) && allOk;
	allOk = compare_vec4((blockB.b.mD), vec4(6.0, -5.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat2(blockB.d, mat2(-3.0, -5.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockB.e, mat3x2(-1.0, -3.0, 0.0, -3.0, 2.0, 1.0)) && allOk;
	allOk = compare_uvec2((blockC.g[0]), uvec2(5u, 2u)) && allOk;
	allOk = compare_ivec4((h[0]), ivec4(7, -5, 7, 3)) && allOk;
	allOk = compare_ivec4((h[1]), ivec4(8, 0, -1, -5)) && allOk;
	allOk = compare_ivec4((h[2]), ivec4(-2, -8, -3, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0][0][0] = (mat4x3(8.0, 7.0, -2.0, 6.0, 0.0, 5.0, 9.0, -5.0, 4.0, 7.0, -1.0, 6.0));
	blockB.a[0][0][1] = (mat4x3(5.0, 8.0, 6.0, 2.0, -7.0, -2.0, -4.0, -2.0, 4.0, -2.0, 3.0, 0.0));
	blockB.a[0][0][2] = (mat4x3(-8.0, 6.0, -7.0, 4.0, 6.0, -2.0, -5.0, 3.0, 0.0, 9.0, -2.0, 3.0));
	blockB.a[0][0][3] = (mat4x3(-3.0, 3.0, 2.0, 2.0, -6.0, -8.0, -6.0, 4.0, -7.0, -9.0, 7.0, -3.0));
	blockB.a[0][0][4] = (mat4x3(-1.0, -2.0, -4.0, 3.0, -1.0, 4.0, -2.0, 9.0, -2.0, 8.0, -5.0, -8.0));
	blockB.a[0][0][5] = (mat4x3(9.0, 2.0, -2.0, -2.0, 7.0, 3.0, 7.0, 3.0, -1.0, -2.0, 1.0, 2.0));
	blockB.a[0][1][0] = (mat4x3(7.0, 8.0, 7.0, 6.0, 9.0, -9.0, 7.0, -9.0, -3.0, 4.0, -2.0, 6.0));
	blockB.a[0][1][1] = (mat4x3(-1.0, 8.0, -9.0, 5.0, -9.0, 5.0, -5.0, -7.0, -2.0, -7.0, -1.0, -3.0));
	blockB.a[0][1][2] = (mat4x3(-4.0, -3.0, -7.0, -3.0, 7.0, 7.0, -1.0, 9.0, -1.0, -3.0, 8.0, 9.0));
	blockB.a[0][1][3] = (mat4x3(-5.0, 1.0, -9.0, -7.0, 6.0, 2.0, -4.0, -4.0, -2.0, -6.0, 3.0, -9.0));
	blockB.a[0][1][4] = (mat4x3(-5.0, 9.0, -3.0, 3.0, -1.0, -7.0, -1.0, 7.0, -7.0, -3.0, 8.0, -1.0));
	blockB.a[0][1][5] = (mat4x3(9.0, -3.0, 8.0, 1.0, 0.0, 6.0, 9.0, 7.0, 0.0, -5.0, 1.0, -8.0));
	blockB.a[0][2][0] = (mat4x3(2.0, -6.0, 7.0, 3.0, -7.0, 7.0, 2.0, 7.0, 8.0, -6.0, 2.0, 6.0));
	blockB.a[0][2][1] = (mat4x3(3.0, -8.0, 9.0, 2.0, -5.0, -1.0, -4.0, 1.0, 9.0, 0.0, -1.0, 0.0));
	blockB.a[0][2][2] = (mat4x3(9.0, 1.0, 2.0, 5.0, 5.0, 2.0, 8.0, -9.0, 3.0, 9.0, -2.0, 2.0));
	blockB.a[0][2][3] = (mat4x3(6.0, -9.0, -3.0, -3.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 6.0, 4.0));
	blockB.a[0][2][4] = (mat4x3(-6.0, 1.0, 7.0, 1.0, -6.0, -8.0, 7.0, -5.0, 7.0, 0.0, 0.0, -1.0));
	blockB.a[0][2][5] = (mat4x3(-2.0, -8.0, 2.0, 0.0, 3.0, -1.0, 7.0, 9.0, 4.0, 4.0, 1.0, -1.0));
	blockB.a[0][3][0] = (mat4x3(9.0, 2.0, 2.0, 9.0, 2.0, 7.0, -8.0, 2.0, -4.0, 7.0, -3.0, 5.0));
	blockB.a[0][3][1] = (mat4x3(6.0, -7.0, -7.0, -7.0, -1.0, -1.0, -9.0, 5.0, 1.0, 1.0, 1.0, 5.0));
	blockB.a[0][3][2] = (mat4x3(9.0, -9.0, 6.0, 3.0, 6.0, -5.0, 4.0, 2.0, 8.0, -4.0, -2.0, 3.0));
	blockB.a[0][3][3] = (mat4x3(2.0, 0.0, 2.0, 9.0, -2.0, 2.0, -8.0, -8.0, -3.0, -3.0, 0.0, 6.0));
	blockB.a[0][3][4] = (mat4x3(-1.0, -1.0, -9.0, -8.0, -4.0, -1.0, -8.0, -3.0, 3.0, 0.0, -4.0, 7.0));
	blockB.a[0][3][5] = (mat4x3(-8.0, -7.0, 8.0, -3.0, -5.0, -2.0, -7.0, 2.0, -5.0, -1.0, -4.0, 7.0));
	blockB.a[0][4][0] = (mat4x3(6.0, 7.0, 4.0, -7.0, -9.0, 7.0, -9.0, -7.0, 8.0, -3.0, 4.0, -1.0));
	blockB.a[0][4][1] = (mat4x3(-5.0, -3.0, -6.0, -9.0, 3.0, -3.0, 5.0, 9.0, 8.0, 3.0, 0.0, 0.0));
	blockB.a[0][4][2] = (mat4x3(-8.0, 5.0, 5.0, 8.0, -3.0, 7.0, -8.0, 9.0, -9.0, 5.0, -2.0, 3.0));
	blockB.a[0][4][3] = (mat4x3(8.0, 8.0, -6.0, 4.0, -6.0, -8.0, 4.0, -7.0, 8.0, 8.0, -4.0, 6.0));
	blockB.a[0][4][4] = (mat4x3(-3.0, -7.0, -6.0, 0.0, 9.0, 1.0, 1.0, 1.0, 2.0, 4.0, -3.0, 6.0));
	blockB.a[0][4][5] = (mat4x3(9.0, 2.0, 1.0, 1.0, 3.0, 7.0, -5.0, -5.0, 1.0, 7.0, -6.0, 2.0));
	blockB.a[0][5][0] = (mat4x3(-2.0, -2.0, 8.0, 8.0, 9.0, 6.0, -2.0, 9.0, -2.0, 7.0, 4.0, 2.0));
	blockB.a[0][5][1] = (mat4x3(4.0, 9.0, -8.0, 7.0, -3.0, 9.0, -9.0, 6.0, -1.0, 0.0, -2.0, 5.0));
	blockB.a[0][5][2] = (mat4x3(8.0, -5.0, 0.0, 4.0, 1.0, 4.0, -2.0, -4.0, -3.0, 9.0, -5.0, 4.0));
	blockB.a[0][5][3] = (mat4x3(9.0, 5.0, 8.0, -7.0, 7.0, -6.0, -6.0, 6.0, 9.0, 1.0, -2.0, -5.0));
	blockB.a[0][5][4] = (mat4x3(8.0, -5.0, 8.0, 6.0, 8.0, -5.0, -7.0, -1.0, -2.0, -6.0, -8.0, -9.0));
	blockB.a[0][5][5] = (mat4x3(-3.0, 9.0, -3.0, 3.0, -4.0, -3.0, 8.0, 3.0, 6.0, -6.0, 3.0, 8.0));
	blockB.a[1][0][0] = (mat4x3(-4.0, 2.0, -8.0, -6.0, 2.0, -5.0, -6.0, -3.0, -2.0, 7.0, -4.0, -1.0));
	blockB.a[1][0][1] = (mat4x3(-5.0, -8.0, 5.0, 8.0, -8.0, -5.0, 2.0, -9.0, -3.0, -9.0, -2.0, 5.0));
	blockB.a[1][0][2] = (mat4x3(4.0, 2.0, -8.0, -8.0, 2.0, 2.0, 6.0, 5.0, 2.0, -4.0, -9.0, -7.0));
	blockB.a[1][0][3] = (mat4x3(4.0, 0.0, 6.0, -6.0, 0.0, 5.0, -3.0, 3.0, -2.0, -9.0, -5.0, -3.0));
	blockB.a[1][0][4] = (mat4x3(-9.0, 7.0, 9.0, 8.0, 2.0, 9.0, 7.0, -2.0, -3.0, -2.0, -5.0, 8.0));
	blockB.a[1][0][5] = (mat4x3(-4.0, -3.0, -6.0, -1.0, -2.0, -3.0, 8.0, 1.0, -5.0, -4.0, -8.0, 1.0));
	blockB.a[1][1][0] = (mat4x3(-6.0, -3.0, -4.0, 5.0, -8.0, 6.0, -2.0, 4.0, 9.0, -7.0, 4.0, -6.0));
	blockB.a[1][1][1] = (mat4x3(-4.0, -5.0, 3.0, -8.0, 8.0, 9.0, 6.0, 7.0, 5.0, -3.0, 7.0, -7.0));
	blockB.a[1][1][2] = (mat4x3(7.0, 2.0, -6.0, 1.0, 0.0, 9.0, 6.0, 1.0, 5.0, -2.0, 4.0, 4.0));
	blockB.a[1][1][3] = (mat4x3(-9.0, -9.0, 8.0, -9.0, 1.0, -1.0, 2.0, 6.0, 8.0, 4.0, -9.0, -9.0));
	blockB.a[1][1][4] = (mat4x3(2.0, 8.0, -8.0, 3.0, 7.0, -6.0, -8.0, -5.0, 4.0, 1.0, -6.0, -1.0));
	blockB.a[1][1][5] = (mat4x3(-8.0, -5.0, 0.0, 2.0, -2.0, -1.0, -1.0, -4.0, -3.0, -3.0, 4.0, 8.0));
	blockB.a[1][2][0] = (mat4x3(7.0, -3.0, 5.0, -8.0, -2.0, -1.0, 1.0, 2.0, -4.0, 5.0, 0.0, 6.0));
	blockB.a[1][2][1] = (mat4x3(5.0, -7.0, -7.0, -7.0, -2.0, 4.0, 9.0, -9.0, -7.0, 4.0, 7.0, -3.0));
	blockB.a[1][2][2] = (mat4x3(8.0, -8.0, 9.0, 6.0, -1.0, -6.0, -6.0, -9.0, -6.0, 5.0, 6.0, 5.0));
	blockB.a[1][2][3] = (mat4x3(2.0, -8.0, 6.0, 0.0, -8.0, -3.0, -5.0, 2.0, 8.0, -8.0, 9.0, 5.0));
	blockB.a[1][2][4] = (mat4x3(3.0, -4.0, -9.0, -4.0, -3.0, -1.0, -6.0, 1.0, -1.0, 2.0, 8.0, 1.0));
	blockB.a[1][2][5] = (mat4x3(9.0, -5.0, -9.0, -3.0, 7.0, -3.0, 2.0, -2.0, 9.0, 7.0, -4.0, 2.0));
	blockB.a[1][3][0] = (mat4x3(-6.0, 6.0, -4.0, 3.0, 2.0, 8.0, 2.0, -2.0, 0.0, -1.0, 8.0, 9.0));
	blockB.a[1][3][1] = (mat4x3(4.0, -4.0, 5.0, -3.0, -9.0, 7.0, 0.0, 6.0, -8.0, -9.0, 9.0, 4.0));
	blockB.a[1][3][2] = (mat4x3(-4.0, 0.0, -6.0, -8.0, -8.0, 9.0, -3.0, -5.0, 1.0, 5.0, 6.0, 5.0));
	blockB.a[1][3][3] = (mat4x3(7.0, -6.0, 0.0, -5.0, -4.0, 9.0, 4.0, 4.0, 9.0, 8.0, -7.0, 3.0));
	blockB.a[1][3][4] = (mat4x3(8.0, 0.0, 0.0, 5.0, 2.0, 6.0, -4.0, 7.0, 2.0, 6.0, -2.0, -8.0));
	blockB.a[1][3][5] = (mat4x3(3.0, 6.0, 5.0, 6.0, 7.0, -5.0, -9.0, -5.0, 0.0, 5.0, 3.0, 0.0));
	blockB.a[1][4][0] = (mat4x3(6.0, -2.0, 7.0, 1.0, 3.0, 6.0, 3.0, -4.0, -1.0, -5.0, 7.0, 4.0));
	blockB.a[1][4][1] = (mat4x3(-3.0, 0.0, -8.0, 7.0, 8.0, -7.0, 0.0, 9.0, 5.0, 8.0, 2.0, 1.0));
	blockB.a[1][4][2] = (mat4x3(-6.0, 4.0, -3.0, 8.0, -4.0, -1.0, 1.0, 5.0, 3.0, -9.0, 4.0, 4.0));
	blockB.a[1][4][3] = (mat4x3(5.0, -3.0, -2.0, 4.0, 8.0, -8.0, -1.0, -5.0, 0.0, -4.0, 3.0, -6.0));
	blockB.a[1][4][4] = (mat4x3(-4.0, -7.0, -2.0, 6.0, -3.0, -5.0, -4.0, -4.0, 7.0, 6.0, 7.0, 1.0));
	blockB.a[1][4][5] = (mat4x3(4.0, -6.0, 6.0, 5.0, -2.0, 7.0, -1.0, -9.0, -3.0, -8.0, -8.0, 5.0));
	blockB.a[1][5][0] = (mat4x3(-7.0, 8.0, 0.0, 0.0, 4.0, -3.0, 1.0, 8.0, 6.0, -8.0, -5.0, -6.0));
	blockB.a[1][5][1] = (mat4x3(-1.0, -9.0, -3.0, 3.0, -5.0, -5.0, -4.0, -6.0, -9.0, 4.0, -7.0, -1.0));
	blockB.a[1][5][2] = (mat4x3(1.0, -9.0, -5.0, 1.0, -6.0, -4.0, -8.0, 0.0, -2.0, 8.0, -4.0, 8.0));
	blockB.a[1][5][3] = (mat4x3(-2.0, 6.0, 3.0, -3.0, -3.0, -1.0, -1.0, 7.0, -2.0, -7.0, 4.0, 4.0));
	blockB.a[1][5][4] = (mat4x3(-9.0, 7.0, -7.0, -2.0, -4.0, 5.0, 9.0, 5.0, 5.0, 9.0, 9.0, 6.0));
	blockB.a[1][5][5] = (mat4x3(-7.0, 1.0, 7.0, 2.0, -8.0, -1.0, -2.0, 9.0, 4.0, 3.0, -7.0, -1.0));
	blockB.b.mA[0] = int8_t(6);
	blockB.b.mA[1] = int8_t(7);
	blockB.b.mA[2] = int8_t(4294967290);
	blockB.b.mA[3] = int8_t(4294967290);
	blockB.b.mA[4] = int8_t(4294967287);
	blockB.b.mA[5] = int8_t(4294967288);
	blockB.b.mB = u8vec2(uvec2(0u, 3u));
	blockB.b.mC[0] = (-8);
	blockB.b.mC[1] = (9);
	blockB.b.mD = (vec4(0.0, 5.0, 4.0, -2.0));
	blockB.d = (mat2(-1.0, 6.0, 7.0, -9.0));
	blockB.e = (mat3x2(1.0, 2.0, 8.0, -7.0, 7.0, 4.0));
	blockC.g[0] = (uvec2(4u, 8u));
	h[0] = (ivec4(-8, -5, 9, -8));
	h[1] = (ivec4(5, -6, -1, -2));
	h[2] = (ivec4(-4, 9, -1, -8));
}
#version 450
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
	u8vec3 mB;
	u8vec3 mC;
	i8vec4 mD;
};
struct sB
{
	highp mat4x3 mA;
	mediump mat4x2 mB;
	mediump mat4x2 mC;
	i8vec4 mD[3];
};
struct sC
{
	i8vec2 mA;
	sB mB;
	lowp float mC;
	lowp ivec4 mD;
};
layout(std430, binding = 1) buffer BlockB
{
	i8vec4 a;
	sA b;
	bvec2 c;
	sC d;
	i8vec2 e[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.a), ivec4(4294967291, 4294967294, 3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d.mA), ivec2(4294967287, 3)) && allOk;
	allOk = compare_mat4x3(blockB.d.mB.mA, mat4x3(-4.0, 1.0, 9.0, -1.0, -9.0, -8.0, -3.0, 3.0, 2.0, -6.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockB.d.mB.mB, mat4x2(-6.0, -9.0, 8.0, -6.0, -7.0, 2.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockB.d.mB.mC, mat4x2(4.0, -9.0, 0.0, -9.0, -2.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d.mB.mD[0]), ivec4(1, 3, 4294967289, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d.mB.mD[1]), ivec4(3, 4294967292, 0, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.d.mB.mD[2]), ivec4(0, 4, 4294967295, 4294967288)) && allOk;
	allOk = compare_float((blockB.d.mC), 3.0) && allOk;
	allOk = compare_ivec4((blockB.d.mD), ivec4(8, 4, 5, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.e[0]), ivec2(3, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec4(ivec4(6, 4294967291, 4294967295, 4294967293));
	blockB.d.mA = i8vec2(ivec2(0, 1));
	blockB.d.mB.mA = (mat4x3(-1.0, 6.0, 3.0, 6.0, -6.0, 2.0, 6.0, 9.0, -9.0, 4.0, 4.0, -4.0));
	blockB.d.mB.mB = (mat4x2(-4.0, 0.0, 3.0, -8.0, 1.0, 0.0, 0.0, -5.0));
	blockB.d.mB.mC = (mat4x2(-3.0, -7.0, -6.0, -8.0, 0.0, 1.0, 6.0, -6.0));
	blockB.d.mB.mD[0] = i8vec4(ivec4(9, 6, 4294967289, 4294967293));
	blockB.d.mB.mD[1] = i8vec4(ivec4(3, 1, 4294967295, 8));
	blockB.d.mB.mD[2] = i8vec4(ivec4(4294967295, 8, 4294967295, 4294967291));
	blockB.d.mC = (5.0);
	blockB.d.mD = (ivec4(7, -2, 8, -8));
}
#version 450
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
	bvec3 mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	i8vec2 a;
	highp mat4x2 b;
	mediump mat2x3 c;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	mediump mat4x2 d;
	highp mat3 e[];
} blockC[3];
layout(std430, binding = 3) buffer BlockD
{
	sA f;
	bvec4 g;
	bvec2 h[];
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	mediump mat3x4 i;
	mediump uint j;
	i8vec4 k;
	mediump uvec3 l[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.a), ivec2(6, 4294967293)) && allOk;
	allOk = compare_mat2x3(blockB.c, mat2x3(-4.0, -5.0, 4.0, -1.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].d, mat4x2(-3.0, -5.0, 7.0, -8.0, 0.0, 5.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(blockC[0].e[0], mat3(7.0, 6.0, -5.0, -9.0, 9.0, -7.0, -7.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].d, mat4x2(9.0, 5.0, 5.0, 9.0, -4.0, -5.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3(blockC[1].e[0], mat3(1.0, -5.0, 4.0, 2.0, 9.0, -8.0, 6.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(blockC[1].e[1], mat3(6.0, 9.0, -8.0, -6.0, 8.0, 7.0, 1.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat3(blockC[1].e[2], mat3(-4.0, -8.0, 1.0, -5.0, 9.0, 3.0, -9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockC[2].d, mat4x2(8.0, -1.0, -1.0, -3.0, -6.0, -1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(blockC[2].e[0], mat3(7.0, -8.0, 2.0, 8.0, 7.0, 8.0, -8.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(blockC[2].e[1], mat3(8.0, -5.0, -3.0, 8.0, -5.0, -1.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(blockC[2].e[2], mat3(-8.0, 2.0, 9.0, 1.0, 5.0, 5.0, -9.0, 3.0, 6.0)) && allOk;
	allOk = compare_uvec2((blockD.f.mA), uvec2(8u, 8u)) && allOk;
	allOk = compare_bvec3((blockD.f.mB), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec4((blockD.g), bvec4(false, false, true, true)) && allOk;
	allOk = compare_uint((blockE.j), 7u) && allOk;
	allOk = compare_i8vec4(ivec4(blockE.k), ivec4(1, 4294967295, 4294967287, 4294967293)) && allOk;
	allOk = compare_uvec3((blockE.l[0]), uvec3(0u, 3u, 5u)) && allOk;
	allOk = compare_uvec3((blockE.l[1]), uvec3(4u, 7u, 3u)) && allOk;
	allOk = compare_uvec3((blockE.l[2]), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_uvec3((blockE.l[3]), uvec3(3u, 2u, 1u)) && allOk;
	allOk = compare_uvec3((blockE.l[4]), uvec3(5u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((blockE.l[5]), uvec3(0u, 8u, 8u)) && allOk;
	allOk = compare_uvec3((blockE.l[6]), uvec3(9u, 8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4x2(-9.0, 5.0, -1.0, -8.0, 5.0, -3.0, 2.0, 5.0));
	blockB.c = (mat2x3(-6.0, 7.0, -3.0, 3.0, 3.0, 2.0));
	blockC[0].d = (mat4x2(-9.0, -4.0, 8.0, -3.0, -3.0, 5.0, 1.0, 7.0));
	blockC[1].d = (mat4x2(1.0, 6.0, -5.0, -6.0, 2.0, 3.0, -1.0, -3.0));
	blockC[2].d = (mat4x2(-4.0, -9.0, 9.0, -6.0, -3.0, 7.0, 1.0, -7.0));
	blockD.f.mA = (uvec2(8u, 1u));
	blockD.f.mB = (bvec3(true, false, false));
	blockD.h[0] = (bvec2(true, true));
	blockE.j = (7u);
	blockE.k = i8vec4(ivec4(5, 4, 4294967293, 4294967292));
}
#version 450
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
	layout(offset = 0) mediump uint a;
	layout(offset = 16) bvec4 b;
	layout(offset = 32) bvec4 c;
	layout(offset = 48) mediump uint d;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp vec3 e;
	layout(offset = 12) i8vec4 f;
	layout(offset = 16) i8vec3 g;
	layout(offset = 20) highp float h;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((a), 0u) && allOk;
	allOk = compare_bvec4((c), bvec4(false, true, false, true)) && allOk;
	allOk = compare_uint((d), 3u) && allOk;
	allOk = compare_vec3((blockC.e), vec3(5.0, 7.0, -2.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.g), ivec3(0, 2, 1)) && allOk;
	allOk = compare_float((blockC.h), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (bvec4(false, true, true, true));
	c = (bvec4(false, false, false, true));
	d = (7u);
	blockC.f = i8vec4(ivec4(4, 4294967292, 4294967290, 4294967289));
}
#version 450
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
	layout(offset = 16) mediump uvec4 b;
	layout(offset = 32) highp float c[1];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b), uvec4(8u, 8u, 2u, 1u)) && allOk;
	allOk = compare_float((blockB.c[0]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(7u, 7u));
	blockB.b = (uvec4(4u, 3u, 6u, 3u));
	blockB.c[0] = (8.0);
}
#version 450
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
	layout(offset = 2) int8_t b;
	layout(offset = 3) uint8_t c;
	layout(offset = 16) lowp ivec4 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) u8vec3 e;
	layout(offset = 16) highp vec4 f;
	layout(offset = 32) i8vec4 g;
	layout(offset = 36) mediump uint h;
	layout(offset = 40) bool i;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.a), ivec2(1, 4294967288)) && allOk;
	allOk = compare_int8_t(int(blockB.b), 7) && allOk;
	allOk = compare_uint8_t(uint(blockB.c), 6u) && allOk;
	allOk = compare_ivec4((blockB.d), ivec4(-9, 0, -2, -3)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.g), ivec4(4294967289, 3, 0, 0)) && allOk;
	allOk = compare_uint((blockC.h), 5u) && allOk;
	allOk = compare_bool((blockC.i), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d = (ivec4(-9, -3, 2, -5));
	blockC.e = u8vec3(uvec3(8u, 8u, 3u));
	blockC.f = (vec4(5.0, -1.0, -9.0, -4.0));
	blockC.h = (9u);
	blockC.i = (true);
}
#version 450
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
	layout(offset = 0) int8_t a;
	layout(offset = 4) bool b;
	layout(offset = 16) highp ivec4 c;
	layout(offset = 32) mediump ivec4 d;
	layout(offset = 48) bvec3 e;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) u8vec2 f;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec4 g;
	layout(offset = 16) highp vec2 h;
	layout(offset = 24) i8vec3 i;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(a), 4294967293) && allOk;
	allOk = compare_ivec4((c), ivec4(7, 8, -8, 7)) && allOk;
	allOk = compare_bvec3((e), bvec3(true, false, false)) && allOk;
	allOk = compare_u8vec2(uvec2(f), uvec2(9u, 0u)) && allOk;
	allOk = compare_vec2((blockD.h), vec2(3.0, -9.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.i), ivec3(4294967287, 9, 4294967287)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = int8_t(1);
	b = (false);
	d = (ivec4(1, 3, -9, 8));
	f = u8vec2(uvec2(3u, 9u));
	blockD.g = (bvec4(false, false, false, true));
	blockD.h = (vec2(3.0, 9.0));
	blockD.i = i8vec3(ivec3(1, 4294967295, 4294967288));
}
#version 450
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
	lowp uint mB;
};
struct sB
{
	mediump uvec4 mA[5];
	u8vec3 mB;
	lowp vec2 mC;
	highp vec3 mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	sA a;
	bvec3 b;
	u8vec3 c;
	mediump ivec2 d[5];
	sB e[];
};
layout(scalar, binding = 2) buffer BlockC
{
	mediump uvec3 f[2];
	highp mat3 g;
};
layout(scalar, binding = 3) buffer BlockD
{
	lowp mat4x2 h;
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
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a.mA, mat3x4(-5.0, -6.0, -8.0, -2.0, 1.0, 9.0, 0.0, -3.0, 5.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_uint((a.mB), 4u) && allOk;
	allOk = compare_uvec4((e[0].mA[0]), uvec4(8u, 8u, 4u, 5u)) && allOk;
	allOk = compare_uvec4((e[0].mA[1]), uvec4(1u, 0u, 3u, 3u)) && allOk;
	allOk = compare_uvec4((e[0].mA[2]), uvec4(5u, 8u, 8u, 3u)) && allOk;
	allOk = compare_uvec4((e[0].mA[3]), uvec4(1u, 3u, 3u, 4u)) && allOk;
	allOk = compare_uvec4((e[0].mA[4]), uvec4(0u, 8u, 5u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(e[0].mB), uvec3(0u, 8u, 2u)) && allOk;
	allOk = compare_vec2((e[0].mC), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec3((e[0].mD), vec3(-6.0, 8.0, -4.0)) && allOk;
	allOk = compare_uvec3((f[0]), uvec3(0u, 8u, 8u)) && allOk;
	allOk = compare_uvec3((f[1]), uvec3(6u, 3u, 0u)) && allOk;
	allOk = compare_mat3(g, mat3(-7.0, -6.0, 7.0, 0.0, -4.0, 2.0, -1.0, 2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = (mat3x4(-4.0, 4.0, 1.0, -2.0, 5.0, 0.0, -5.0, 4.0, 8.0, -2.0, 5.0, -3.0));
	a.mB = (8u);
	c = u8vec3(uvec3(3u, 0u, 2u));
	d[0] = (ivec2(-6, -2));
	d[1] = (ivec2(4, 2));
	d[2] = (ivec2(4, 6));
	d[3] = (ivec2(-4, 2));
	d[4] = (ivec2(-2, -3));
	e[0].mA[0] = (uvec4(7u, 9u, 3u, 2u));
	e[0].mA[1] = (uvec4(5u, 4u, 1u, 3u));
	e[0].mA[2] = (uvec4(7u, 1u, 5u, 9u));
	e[0].mA[3] = (uvec4(4u, 8u, 2u, 7u));
	e[0].mA[4] = (uvec4(3u, 7u, 4u, 7u));
	e[0].mB = u8vec3(uvec3(5u, 0u, 7u));
	e[0].mC = (vec2(8.0, 9.0));
	e[0].mD = (vec3(-5.0, 7.0, 9.0));
	f[0] = (uvec3(0u, 4u, 5u));
	f[1] = (uvec3(3u, 3u, 6u));
	g = (mat3(-3.0, -9.0, 8.0, -5.0, -8.0, 4.0, -7.0, 7.0, -7.0));
	h = (mat4x2(-7.0, 5.0, 1.0, 9.0, 7.0, 3.0, -1.0, -3.0));
}
#version 450
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
struct sC
{
	lowp vec3 mA;
};
layout(scalar, binding = 1) buffer BlockB
{
	mediump uvec4 a;
	lowp uint b[7];
	uint8_t c;
	sA d;
	sB e[];
} blockB[1];
layout(scalar, row_major, binding = 2) buffer BlockC
{
	bvec3 f;
} blockC[3];
layout(scalar, column_major, binding = 3) buffer BlockD
{
	lowp ivec4 g;
	lowp ivec3 h;
	u8vec4 i[];
} blockD;
layout(scalar, row_major, binding = 4) buffer BlockE
{
	highp uvec4 j;
	lowp vec2 k;
	sC l;
	mediump uint m;
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

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
	allOk = compare_ivec4((blockD.g), ivec4(9, 5, -4, -6)) && allOk;
	allOk = compare_ivec3((blockD.h), ivec3(7, -7, -5)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.i[0]), uvec4(8u, 6u, 9u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.i[1]), uvec4(8u, 5u, 4u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.i[2]), uvec4(6u, 7u, 8u, 6u)) && allOk;
	allOk = compare_uvec4((blockE[0].j), uvec4(5u, 3u, 6u, 7u)) && allOk;
	allOk = compare_vec2((blockE[0].k), vec2(-9.0, -1.0)) && allOk;
	allOk = compare_uint((blockE[0].m), 9u) && allOk;
	allOk = compare_uvec4((blockE[1].j), uvec4(9u, 0u, 0u, 8u)) && allOk;
	allOk = compare_vec2((blockE[1].k), vec2(4.0, 9.0)) && allOk;
	allOk = compare_uint((blockE[1].m), 9u) && allOk;
	allOk = compare_uvec4((blockE[2].j), uvec4(9u, 7u, 2u, 3u)) && allOk;
	allOk = compare_vec2((blockE[2].k), vec2(-7.0, -4.0)) && allOk;
	allOk = compare_uint((blockE[2].m), 8u) && allOk;
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
	blockD.g = (ivec4(-2, 3, 0, 7));
	blockD.i[0] = u8vec4(uvec4(4u, 3u, 9u, 9u));
	blockD.i[1] = u8vec4(uvec4(2u, 0u, 6u, 9u));
	blockD.i[2] = u8vec4(uvec4(1u, 6u, 6u, 1u));
	blockE[0].j = (uvec4(3u, 6u, 4u, 8u));
	blockE[0].k = (vec2(-3.0, 1.0));
	blockE[0].l.mA = (vec3(-2.0, -3.0, 0.0));
	blockE[1].j = (uvec4(7u, 4u, 2u, 2u));
	blockE[1].k = (vec2(7.0, -6.0));
	blockE[1].l.mA = (vec3(-6.0, 4.0, -1.0));
	blockE[2].j = (uvec4(0u, 4u, 7u, 3u));
	blockE[2].k = (vec2(2.0, -9.0));
	blockE[2].l.mA = (vec3(9.0, -2.0, 5.0));
}
#version 450
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
	allOk = compare_bool((blockB[nonuniformEXT(0)].a), true) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(1)].a), true) && allOk;
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

layout(std140, binding = 1) readonly buffer Block
{
	highp ivec4 var;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var), ivec4(5, -9, -6, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], 1.0) && allOk;
	allOk = compare_float(var[0][3], -5.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 3.0) && allOk;
	allOk = compare_float(var[1][3], -8.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], 8.0) && allOk;
	allOk = compare_float(var[2][2], 3.0) && allOk;
	allOk = compare_float(var[2][3], -6.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], -5.0) && allOk;
	allOk = compare_float(var[3][2], -8.0) && allOk;
	allOk = compare_float(var[3][3], -8.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-7.0, -4.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(2.0, 8.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(2.0, 8.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-5.0, -5.0, -8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, row_major, binding = 1) readonly buffer Block
{
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(6.0, 0.0, 4.0, 4.0, -2.0, 5.0, -5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(-7.0, -7.0, 7.0, -4.0, -5.0, -3.0, 1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat3x4(var, mat3x4(-4.0, 8.0, 9.0, 9.0, 9.0, 9.0, -1.0, -9.0, 9.0, 7.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -9.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[0][2], 1.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_float(var[2][0], -2.0) && allOk;
	allOk = compare_float(var[2][1], 8.0) && allOk;
	allOk = compare_float(var[2][2], 3.0) && allOk;
	allOk = compare_float(var[3][0], 0.0) && allOk;
	allOk = compare_float(var[3][1], 5.0) && allOk;
	allOk = compare_float(var[3][2], -1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-9.0, 9.0, 1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(9.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-2.0, 8.0, 3.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(0.0, 5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(4.0, -8.0, -5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat2(var, mat2(-4.0, 9.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat4(var, mat4(5.0, 6.0, -3.0, 3.0, 8.0, -6.0, 6.0, 4.0, 6.0, 4.0, 6.0, 4.0, 5.0, -2.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], 7.0) && allOk;
	allOk = compare_float(var[0][3], -4.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], -4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-5.0, -8.0, 7.0, -4.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(3.0, -2.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(1.0, 0.0, 3.0, 8.0, -3.0, -1.0, 2.0, -9.0, 8.0, -7.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	u16vec4 var[3];
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(var[0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	f16vec2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(var[0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2]), vec2(6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bvec2 var[3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), true) && allOk;
	allOk = compare_bvec2((var[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[2]), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2(var[0], mat2(3.0, 2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(2.0, 1.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(2.0, 4.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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

}
#version 450
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
	highp mat2x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[3], mat2x3(3.0, 6.0, -5.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(9.0, 2.0, 6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(-7.0, -2.0, -4.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(6.0, 8.0, -4.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(6.0, 6.0, -9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(5.0, -3.0, 6.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(-9.0, -2.0, -3.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(0.0, 2.0, -1.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(-9.0, -7.0, 7.0, 0.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(-5.0, 3.0, -2.0, -8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(1.0, -5.0, -5.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(-2.0, 0.0, 7.0, 6.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(3.0, 9.0, 1.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(-9.0, -2.0, 6.0, 8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(5.0, -2.0, 0.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(-2.0, -7.0, 9.0, 9.0, -5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_float(block.var[0][0], 6.0) && allOk;
	allOk = compare_float(block.var[0][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], -4.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(6.0, -2.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-1.0, -3.0));
	block.var[1] = (vec2(-7.0, -2.0));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(1.0, -6.0, 0.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(0.0, -6.0, -1.0, 7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], 3.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], 9.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-6.0, 3.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(1.0, -9.0));
	block.var[1] = (vec2(-7.0, 2.0));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(6.0, 4.0, 9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(5.0, -5.0));
	block.var[1] = (vec2(-3.0, 5.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 9.0) && allOk;
	allOk = compare_float(block.var[0][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], 0.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], -7.0) && allOk;
	allOk = compare_float(block.var[3][0], 9.0) && allOk;
	allOk = compare_float(block.var[3][1], 7.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(3.0, 0.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-6.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-7.0, 3.0, -5.0, 1.0, -6.0, -1.0, -4.0, -5.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 4.0) && allOk;
	allOk = compare_float(block.var[0][1], 0.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], 9.0) && allOk;
	allOk = compare_float(block.var[3][0], -5.0) && allOk;
	allOk = compare_float(block.var[3][1], -6.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(4.0, 0.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(2.0, -9.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-6.0, 9.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(3.0, 2.0));
	block.var[1] = (vec2(2.0, -4.0));
	block.var[2] = (vec2(5.0, -4.0));
	block.var[3] = (vec2(-3.0, -3.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(1.0, 9.0, 6.0, -5.0, -3.0, 2.0, 7.0, -9.0, -6.0, -2.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(9.0, -6.0, -4.0));
	block.var[1] = (vec3(9.0, -8.0, -2.0));
	block.var[2] = (vec3(-1.0, 9.0, 8.0));
	block.var[3] = (vec3(7.0, 4.0, 3.0));
}
#version 450
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
	lowp float var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.var), -9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (-9.0);
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], -3.0) && allOk;
	allOk = compare_float(block.var[0][2], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], 9.0) && allOk;
	allOk = compare_float(block.var[1][2], 4.0) && allOk;
	allOk = compare_float(block.var[2][0], 6.0) && allOk;
	allOk = compare_float(block.var[2][1], -8.0) && allOk;
	allOk = compare_float(block.var[2][2], -8.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-6.0, -3.0, -5.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(2.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(6.0, -8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var = (mat3(-5.0, -6.0, -8.0, -9.0, -3.0, 5.0, 7.0, -7.0, -9.0));
}
#version 450
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
	highp vec2 var[3];
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
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(3.0, 8.0));
	block.var[1] = (vec2(7.0, -1.0));
	block.var[2] = (vec2(-4.0, 8.0));
}
#version 450
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
	u16vec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(block.var[0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2]), uvec3(7u, 1u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u16vec3(uvec3(1u, 2u, 6u));
	block.var[1] = u16vec3(uvec3(8u, 3u, 3u));
	block.var[2] = u16vec3(uvec3(4u, 4u, 9u));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_mat2x3(block.var[0], mat2x3(-6.0, 2.0, 1.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(-2.0, 7.0, -9.0, -9.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-6.0, 5.0, -6.0, -2.0, 0.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var[0][0] = (vec3(-6.0, -3.0, -4.0));
	block.var[0][1] = (vec3(-8.0, 7.0, 3.0));
	block.var[1][0] = (vec3(-2.0, 5.0, 6.0));
	block.var[1][1] = (vec3(-8.0, -9.0, 6.0));
	block.var[2][0] = (vec3(1.0, 1.0, -3.0));
	block.var[2][1] = (vec3(-5.0, -7.0, 9.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
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

layout(std140, buffer_reference) buffer Block
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	block.var[0][1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	block.var[0][2] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	block.var[1][0] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	block.var[1][1] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	block.var[1][2] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	block.var[2][0] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	block.var[2][1] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	block.var[2][2] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	block.var[3][0] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	block.var[3][1] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	block.var[3][2] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat4x3(block.var[0][0], mat4x3(1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(-5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-7.0, 7.0, 2.0, -5.0, 3.0, 2.0, 0.0, 8.0, -1.0, -5.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(6.0, 2.0, -5.0, -7.0, -7.0, -4.0, -9.0, 7.0, 3.0, 1.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(7.0, 6.0, 3.0, 4.0, 5.0, -2.0, 3.0, 8.0, -7.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(7.0, 1.0, -2.0, 9.0, -5.0, -3.0, 1.0, -6.0, 6.0, -1.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(8.0, 5.0, 4.0, 7.0, -1.0, 6.0, -6.0, 2.0, 8.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(6.0, -8.0, -4.0, -8.0, 8.0, -5.0, 7.0, 3.0, 9.0, -3.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(-3.0, 0.0, -3.0, 2.0, -8.0, 6.0, 5.0, -2.0, 2.0, 7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(4.0, 5.0, -8.0, -1.0, -2.0, -8.0, -4.0, 2.0, 8.0, 5.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(-1.0, 3.0, 3.0, -3.0, 4.0, -6.0, -5.0, 1.0, 4.0, -4.0, -1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0][0] = (mat4x3(8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0, 4.0));
	block.var[0][1] = (mat4x3(-2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0, -7.0));
	block.var[0][2] = (mat4x3(-4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0, -6.0));
	block.var[1][0] = (mat4x3(-5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0, -6.0));
	block.var[1][1] = (mat4x3(5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0, -7.0));
	block.var[1][2] = (mat4x3(-2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0, -9.0));
	block.var[2][0] = (mat4x3(-7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0, -8.0));
	block.var[2][1] = (mat4x3(-4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0, -3.0));
	block.var[2][2] = (mat4x3(-7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0, 3.0));
	block.var[3][0] = (mat4x3(-8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0, -6.0));
	block.var[3][1] = (mat4x3(-9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0, -1.0));
	block.var[3][2] = (mat4x3(-9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0, -2.0));
}
#version 450
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
	highp uvec3 var[4][2][3];
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
	allOk = compare_uvec3((block.var[0][0][2]), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_uvec3((block.var[0][1][0]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((block.var[0][1][1]), uvec3(5u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[0][1][2]), uvec3(6u, 6u, 8u)) && allOk;
	allOk = compare_uvec3((block.var[1][0][0]), uvec3(6u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[1][0][1]), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((block.var[1][0][2]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[1][1][0]), uvec3(6u, 7u, 9u)) && allOk;
	allOk = compare_uvec3((block.var[1][1][1]), uvec3(0u, 0u, 6u)) && allOk;
	allOk = compare_uvec3((block.var[1][1][2]), uvec3(0u, 2u, 2u)) && allOk;
	allOk = compare_uvec3((block.var[2][0][0]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[2][0][1]), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[2][0][2]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[2][1][0]), uvec3(9u, 3u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[2][1][1]), uvec3(5u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[2][1][2]), uvec3(2u, 3u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[3][0][0]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[3][0][1]), uvec3(8u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[3][0][2]), uvec3(7u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((block.var[3][1][0]), uvec3(1u, 4u, 9u)) && allOk;
	allOk = compare_uvec3((block.var[3][1][1]), uvec3(7u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[3][1][2]), uvec3(7u, 0u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (uvec3(3u, 5u, 6u));
	block.var[0][0][1] = (uvec3(5u, 4u, 5u));
	block.var[0][0][2] = (uvec3(4u, 9u, 4u));
	block.var[0][1][0] = (uvec3(1u, 1u, 6u));
	block.var[0][1][1] = (uvec3(3u, 9u, 4u));
	block.var[0][1][2] = (uvec3(9u, 7u, 9u));
	block.var[1][0][0] = (uvec3(4u, 7u, 7u));
	block.var[1][0][1] = (uvec3(0u, 2u, 9u));
	block.var[1][0][2] = (uvec3(4u, 7u, 8u));
	block.var[1][1][0] = (uvec3(1u, 4u, 6u));
	block.var[1][1][1] = (uvec3(4u, 9u, 3u));
	block.var[1][1][2] = (uvec3(4u, 3u, 5u));
	block.var[2][0][0] = (uvec3(9u, 4u, 3u));
	block.var[2][0][1] = (uvec3(5u, 8u, 0u));
	block.var[2][0][2] = (uvec3(5u, 4u, 6u));
	block.var[2][1][0] = (uvec3(4u, 8u, 7u));
	block.var[2][1][1] = (uvec3(1u, 5u, 2u));
	block.var[2][1][2] = (uvec3(4u, 1u, 2u));
	block.var[3][0][0] = (uvec3(7u, 7u, 5u));
	block.var[3][0][1] = (uvec3(3u, 7u, 0u));
	block.var[3][0][2] = (uvec3(8u, 1u, 2u));
	block.var[3][1][0] = (uvec3(6u, 5u, 3u));
	block.var[3][1][1] = (uvec3(8u, 8u, 7u));
	block.var[3][1][2] = (uvec3(1u, 2u, 5u));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-4.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(-2.0, -6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-1.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(4.0, 1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(7.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(3.0, 4.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(-5.0, -9.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(-2.0, -8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(0.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-6.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(-9.0, -1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-7.0, 6.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(-4.0, 9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(-9.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(4.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(8.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(9.0, -2.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-3.0, 0.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(0.0, 1.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(7.0, -3.0));
	block.var[0][0][0][1] = (vec2(-2.0, 4.0));
	block.var[0][0][1][0] = (vec2(1.0, -3.0));
	block.var[0][0][1][1] = (vec2(2.0, -4.0));
	block.var[0][0][2][0] = (vec2(-1.0, 1.0));
	block.var[0][0][2][1] = (vec2(-4.0, 3.0));
	block.var[0][1][0][0] = (vec2(-5.0, 8.0));
	block.var[0][1][0][1] = (vec2(3.0, 1.0));
	block.var[0][1][1][0] = (vec2(-9.0, 7.0));
	block.var[0][1][1][1] = (vec2(7.0, 1.0));
	block.var[0][1][2][0] = (vec2(-3.0, -9.0));
	block.var[0][1][2][1] = (vec2(-7.0, 1.0));
	block.var[1][0][0][0] = (vec2(7.0, -7.0));
	block.var[1][0][0][1] = (vec2(2.0, 5.0));
	block.var[1][0][1][0] = (vec2(-8.0, 4.0));
	block.var[1][0][1][1] = (vec2(8.0, 1.0));
	block.var[1][0][2][0] = (vec2(4.0, 6.0));
	block.var[1][0][2][1] = (vec2(-9.0, 9.0));
	block.var[1][1][0][0] = (vec2(-7.0, 6.0));
	block.var[1][1][0][1] = (vec2(2.0, -5.0));
	block.var[1][1][1][0] = (vec2(6.0, -3.0));
	block.var[1][1][1][1] = (vec2(-5.0, -6.0));
	block.var[1][1][2][0] = (vec2(-3.0, 7.0));
	block.var[1][1][2][1] = (vec2(9.0, 6.0));
	block.var[2][0][0][0] = (vec2(1.0, 5.0));
	block.var[2][0][0][1] = (vec2(9.0, -6.0));
	block.var[2][0][1][0] = (vec2(-7.0, 5.0));
	block.var[2][0][1][1] = (vec2(7.0, 4.0));
	block.var[2][0][2][0] = (vec2(7.0, -9.0));
	block.var[2][0][2][1] = (vec2(0.0, 6.0));
	block.var[2][1][0][0] = (vec2(-8.0, 7.0));
	block.var[2][1][0][1] = (vec2(0.0, 2.0));
	block.var[2][1][1][0] = (vec2(-7.0, -7.0));
	block.var[2][1][1][1] = (vec2(5.0, -3.0));
	block.var[2][1][2][0] = (vec2(-1.0, -1.0));
	block.var[2][1][2][1] = (vec2(1.0, 1.0));
	block.var[3][0][0][0] = (vec2(-1.0, -7.0));
	block.var[3][0][0][1] = (vec2(-8.0, 4.0));
	block.var[3][0][1][0] = (vec2(5.0, 6.0));
	block.var[3][0][1][1] = (vec2(-7.0, 7.0));
	block.var[3][0][2][0] = (vec2(-1.0, -5.0));
	block.var[3][0][2][1] = (vec2(9.0, -7.0));
	block.var[3][1][0][0] = (vec2(7.0, 1.0));
	block.var[3][1][0][1] = (vec2(2.0, -8.0));
	block.var[3][1][1][0] = (vec2(-1.0, 1.0));
	block.var[3][1][1][1] = (vec2(2.0, -4.0));
	block.var[3][1][2][0] = (vec2(-9.0, -4.0));
	block.var[3][1][2][1] = (vec2(7.0, 0.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(6.0, -1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(-5.0, -9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(6.0, -3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(7.0, 8.0, 7.0, 3.0, 8.0, -3.0, -9.0, -6.0, 2.0, 0.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(2.0, -1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(7.0, 1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(4.0, -8.0, 4.0, 1.0, 8.0, -2.0, 5.0, -4.0, -7.0, -4.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(-9.0, 7.0, -5.0, 5.0, -6.0, -9.0, -8.0, 4.0, 1.0, 0.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(2.0, 9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(9.0, 6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(-5.0, 3.0, -9.0, 7.0, -8.0, -8.0, 4.0, -3.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(2.0, -3.0, 2.0, -8.0, 3.0, -8.0, 3.0, 0.0, -9.0, 0.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	block.var[0][0][1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	block.var[0][1][0] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	block.var[0][1][1] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	block.var[0][2][0] = (mat4x3(-2.0, 7.0, -6.0, -4.0, -2.0, 0.0, 4.0, -2.0, 6.0, -6.0, -5.0, -8.0));
	block.var[0][2][1] = (mat4x3(-1.0, 2.0, 4.0, 2.0, -2.0, 9.0, 0.0, -4.0, 6.0, -7.0, -4.0, 2.0));
	block.var[0][3][0] = (mat4x3(2.0, 6.0, 9.0, -5.0, -9.0, -9.0, 5.0, 6.0, 4.0, 6.0, -3.0, 1.0));
	block.var[0][3][1] = (mat4x3(3.0, -1.0, 9.0, -2.0, 9.0, 6.0, -9.0, 4.0, 3.0, -7.0, -3.0, 3.0));
	block.var[1][0][0] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	block.var[1][0][1] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	block.var[1][1][0] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	block.var[1][1][1] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	block.var[1][2][0] = (mat4x3(1.0, 2.0, -9.0, -3.0, 6.0, -9.0, 8.0, 2.0, 1.0, -8.0, 3.0, 2.0));
	block.var[1][2][1] = (mat4x3(1.0, 4.0, 9.0, -7.0, -5.0, 2.0, -8.0, 0.0, 0.0, -4.0, 9.0, 5.0));
	block.var[1][3][0] = (mat4x3(-7.0, 9.0, 6.0, -6.0, 1.0, 1.0, -3.0, -1.0, 8.0, -2.0, 3.0, -3.0));
	block.var[1][3][1] = (mat4x3(-5.0, 4.0, 0.0, -9.0, 9.0, -1.0, 0.0, -9.0, -3.0, 6.0, -2.0, 0.0));
	block.var[2][0][0] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	block.var[2][0][1] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	block.var[2][1][0] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	block.var[2][1][1] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
	block.var[2][2][0] = (mat4x3(-2.0, -9.0, 6.0, -9.0, -4.0, -7.0, 9.0, -5.0, 3.0, 5.0, -1.0, -4.0));
	block.var[2][2][1] = (mat4x3(1.0, -1.0, -8.0, 4.0, 4.0, 4.0, -3.0, 4.0, 0.0, 0.0, -7.0, -1.0));
	block.var[2][3][0] = (mat4x3(-5.0, -9.0, 2.0, -1.0, 4.0, 0.0, -4.0, 1.0, 3.0, -9.0, -5.0, -6.0));
	block.var[2][3][1] = (mat4x3(7.0, -4.0, 3.0, 0.0, -2.0, -5.0, -8.0, 3.0, 5.0, -1.0, 3.0, 5.0));
}
#version 450
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
	uint8_t var[][4][2];
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
	allOk = compare_uint8_t(uint(block.var[0][1][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][1][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][2][0]), 6u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][2][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][3][0]), 3u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][3][1]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][0][0]), 3u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][0][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][1][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][1][1]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][2][0]), 5u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][2][1]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][3][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][3][1]), 0u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][0][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][0][1]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][1][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][1][1]), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][2][0]), 8u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][2][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][3][0]), 6u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][3][1]), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = uint8_t(9u);
	block.var[0][0][1] = uint8_t(5u);
	block.var[0][1][0] = uint8_t(8u);
	block.var[0][1][1] = uint8_t(4u);
	block.var[0][2][0] = uint8_t(6u);
	block.var[0][2][1] = uint8_t(0u);
	block.var[0][3][0] = uint8_t(0u);
	block.var[0][3][1] = uint8_t(3u);
	block.var[1][0][0] = uint8_t(2u);
	block.var[1][0][1] = uint8_t(6u);
	block.var[1][1][0] = uint8_t(2u);
	block.var[1][1][1] = uint8_t(6u);
	block.var[1][2][0] = uint8_t(5u);
	block.var[1][2][1] = uint8_t(4u);
	block.var[1][3][0] = uint8_t(3u);
	block.var[1][3][1] = uint8_t(3u);
	block.var[2][0][0] = uint8_t(7u);
	block.var[2][0][1] = uint8_t(5u);
	block.var[2][1][0] = uint8_t(0u);
	block.var[2][1][1] = uint8_t(1u);
	block.var[2][2][0] = uint8_t(1u);
	block.var[2][2][1] = uint8_t(3u);
	block.var[2][3][0] = uint8_t(3u);
	block.var[2][3][1] = uint8_t(3u);
}
#version 450
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
	highp vec4 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((block.var[0][0][0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((block.var[0][0][1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((block.var[0][1][0]), vec4(6.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((block.var[0][1][1]), vec4(8.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((block.var[0][2][0]), vec4(-1.0, 3.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((block.var[0][2][1]), vec4(9.0, 1.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4((block.var[0][3][0]), vec4(6.0, -4.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec4((block.var[0][3][1]), vec4(-2.0, 7.0, -3.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[1][0][0]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[1][0][1]), vec4(-3.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[1][1][0]), vec4(-7.0, 2.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((block.var[1][1][1]), vec4(-1.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((block.var[1][2][0]), vec4(0.0, 6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4((block.var[1][2][1]), vec4(6.0, -7.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((block.var[1][3][0]), vec4(-2.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec4((block.var[1][3][1]), vec4(3.0, -9.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4((block.var[2][0][0]), vec4(-1.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[2][0][1]), vec4(7.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[2][1][0]), vec4(8.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((block.var[2][1][1]), vec4(3.0, -4.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4((block.var[2][2][0]), vec4(8.0, -6.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[2][2][1]), vec4(5.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[2][3][0]), vec4(5.0, -9.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4((block.var[2][3][1]), vec4(-6.0, -9.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	block.var[0][0][1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	block.var[0][1][0] = (vec4(0.0, 8.0, 4.0, -4.0));
	block.var[0][1][1] = (vec4(-8.0, -3.0, 9.0, -7.0));
	block.var[0][2][0] = (vec4(1.0, 7.0, 1.0, 1.0));
	block.var[0][2][1] = (vec4(-7.0, -6.0, -7.0, -4.0));
	block.var[0][3][0] = (vec4(5.0, -4.0, -5.0, 6.0));
	block.var[0][3][1] = (vec4(0.0, -2.0, -8.0, 7.0));
	block.var[1][0][0] = (vec4(5.0, -9.0, 4.0, -1.0));
	block.var[1][0][1] = (vec4(-7.0, -6.0, -2.0, -8.0));
	block.var[1][1][0] = (vec4(-9.0, 2.0, -6.0, 6.0));
	block.var[1][1][1] = (vec4(6.0, 2.0, -3.0, 0.0));
	block.var[1][2][0] = (vec4(8.0, -1.0, -6.0, -8.0));
	block.var[1][2][1] = (vec4(9.0, 7.0, -3.0, -8.0));
	block.var[1][3][0] = (vec4(0.0, -7.0, -2.0, -7.0));
	block.var[1][3][1] = (vec4(3.0, -8.0, 1.0, 6.0));
	block.var[2][0][0] = (vec4(8.0, 7.0, 5.0, 1.0));
	block.var[2][0][1] = (vec4(-6.0, -5.0, -8.0, 8.0));
	block.var[2][1][0] = (vec4(-9.0, 8.0, -8.0, 0.0));
	block.var[2][1][1] = (vec4(2.0, 6.0, 6.0, 1.0));
	block.var[2][2][0] = (vec4(-3.0, -9.0, 2.0, 1.0));
	block.var[2][2][1] = (vec4(-7.0, 3.0, -5.0, 8.0));
	block.var[2][3][0] = (vec4(0.0, 5.0, -3.0, -2.0));
	block.var[2][3][1] = (vec4(-9.0, -7.0, 2.0, -7.0));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
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

layout(scalar, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(3.0, -1.0, -8.0, -1.0, -7.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(0.0, -8.0, -7.0, 7.0, 3.0, 7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(-8.0, 9.0, -5.0, -6.0, -1.0, 1.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(8.0, -1.0, -7.0, -7.0, -9.0, -4.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-7.0, 7.0, -7.0, -4.0, -2.0, -5.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(3.0, -9.0, 6.0, -8.0, 0.0, 5.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(-6.0, -7.0, -8.0, 6.0, -7.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(8.0, -2.0, 9.0, -6.0, 5.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(-2.0, 0.0, 9.0, -8.0, 0.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(9.0, 1.0, 2.0, -6.0, -9.0, -9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(-3.0, -3.0, 0.0, -2.0, -5.0, 8.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-5.0, -9.0, 3.0, 5.0, 2.0, -2.0, -7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(6.0, -2.0));
	block.var[0][0][0][1] = (vec2(2.0, 8.0));
	block.var[0][0][0][2] = (vec2(-5.0, 3.0));
	block.var[0][0][0][3] = (vec2(-1.0, -7.0));
	block.var[0][0][1][0] = (vec2(4.0, 2.0));
	block.var[0][0][1][1] = (vec2(-4.0, 8.0));
	block.var[0][0][1][2] = (vec2(3.0, 8.0));
	block.var[0][0][1][3] = (vec2(-1.0, 6.0));
	block.var[0][1][0][0] = (vec2(7.0, 3.0));
	block.var[0][1][0][1] = (vec2(3.0, 3.0));
	block.var[0][1][0][2] = (vec2(-5.0, -9.0));
	block.var[0][1][0][3] = (vec2(2.0, 9.0));
	block.var[0][1][1][0] = (vec2(3.0, 8.0));
	block.var[0][1][1][1] = (vec2(3.0, -4.0));
	block.var[0][1][1][2] = (vec2(6.0, 1.0));
	block.var[0][1][1][3] = (vec2(-3.0, 1.0));
	block.var[0][2][0][0] = (vec2(1.0, 7.0));
	block.var[0][2][0][1] = (vec2(0.0, -4.0));
	block.var[0][2][0][2] = (vec2(-1.0, 5.0));
	block.var[0][2][0][3] = (vec2(9.0, -8.0));
	block.var[0][2][1][0] = (vec2(-3.0, 8.0));
	block.var[0][2][1][1] = (vec2(-1.0, 7.0));
	block.var[0][2][1][2] = (vec2(5.0, -7.0));
	block.var[0][2][1][3] = (vec2(8.0, 0.0));
	block.var[0][3][0][0] = (vec2(7.0, 8.0));
	block.var[0][3][0][1] = (vec2(2.0, -9.0));
	block.var[0][3][0][2] = (vec2(-8.0, -9.0));
	block.var[0][3][0][3] = (vec2(-1.0, -3.0));
	block.var[0][3][1][0] = (vec2(-2.0, -1.0));
	block.var[0][3][1][1] = (vec2(1.0, -1.0));
	block.var[0][3][1][2] = (vec2(-5.0, -6.0));
	block.var[0][3][1][3] = (vec2(-8.0, 7.0));
	block.var[1][0][0][0] = (vec2(-8.0, 2.0));
	block.var[1][0][0][1] = (vec2(-5.0, 5.0));
	block.var[1][0][0][2] = (vec2(-4.0, -9.0));
	block.var[1][0][0][3] = (vec2(0.0, 4.0));
	block.var[1][0][1][0] = (vec2(8.0, 2.0));
	block.var[1][0][1][1] = (vec2(-3.0, 2.0));
	block.var[1][0][1][2] = (vec2(-4.0, -4.0));
	block.var[1][0][1][3] = (vec2(2.0, -8.0));
	block.var[1][1][0][0] = (vec2(-5.0, -2.0));
	block.var[1][1][0][1] = (vec2(7.0, 8.0));
	block.var[1][1][0][2] = (vec2(4.0, 7.0));
	block.var[1][1][0][3] = (vec2(-1.0, -8.0));
	block.var[1][1][1][0] = (vec2(-6.0, -6.0));
	block.var[1][1][1][1] = (vec2(-4.0, -2.0));
	block.var[1][1][1][2] = (vec2(3.0, 8.0));
	block.var[1][1][1][3] = (vec2(4.0, 4.0));
	block.var[1][2][0][0] = (vec2(-5.0, 7.0));
	block.var[1][2][0][1] = (vec2(8.0, 9.0));
	block.var[1][2][0][2] = (vec2(8.0, 9.0));
	block.var[1][2][0][3] = (vec2(1.0, 9.0));
	block.var[1][2][1][0] = (vec2(-9.0, 8.0));
	block.var[1][2][1][1] = (vec2(-2.0, 9.0));
	block.var[1][2][1][2] = (vec2(6.0, 6.0));
	block.var[1][2][1][3] = (vec2(3.0, -5.0));
	block.var[1][3][0][0] = (vec2(2.0, 0.0));
	block.var[1][3][0][1] = (vec2(-7.0, -6.0));
	block.var[1][3][0][2] = (vec2(6.0, 1.0));
	block.var[1][3][0][3] = (vec2(8.0, 9.0));
	block.var[1][3][1][0] = (vec2(9.0, -8.0));
	block.var[1][3][1][1] = (vec2(-6.0, -7.0));
	block.var[1][3][1][2] = (vec2(-5.0, 0.0));
	block.var[1][3][1][3] = (vec2(-3.0, 1.0));
	block.var[2][0][0][0] = (vec2(-4.0, 8.0));
	block.var[2][0][0][1] = (vec2(5.0, 7.0));
	block.var[2][0][0][2] = (vec2(-4.0, 6.0));
	block.var[2][0][0][3] = (vec2(8.0, 4.0));
	block.var[2][0][1][0] = (vec2(-9.0, -7.0));
	block.var[2][0][1][1] = (vec2(7.0, -5.0));
	block.var[2][0][1][2] = (vec2(1.0, -9.0));
	block.var[2][0][1][3] = (vec2(9.0, 5.0));
	block.var[2][1][0][0] = (vec2(-7.0, -6.0));
	block.var[2][1][0][1] = (vec2(8.0, -6.0));
	block.var[2][1][0][2] = (vec2(8.0, -3.0));
	block.var[2][1][0][3] = (vec2(-7.0, 0.0));
	block.var[2][1][1][0] = (vec2(-9.0, 2.0));
	block.var[2][1][1][1] = (vec2(-9.0, 7.0));
	block.var[2][1][1][2] = (vec2(-2.0, 2.0));
	block.var[2][1][1][3] = (vec2(-6.0, -1.0));
	block.var[2][2][0][0] = (vec2(1.0, -4.0));
	block.var[2][2][0][1] = (vec2(-5.0, 7.0));
	block.var[2][2][0][2] = (vec2(-8.0, 7.0));
	block.var[2][2][0][3] = (vec2(-1.0, -1.0));
	block.var[2][2][1][0] = (vec2(-2.0, -7.0));
	block.var[2][2][1][1] = (vec2(4.0, -8.0));
	block.var[2][2][1][2] = (vec2(2.0, 4.0));
	block.var[2][2][1][3] = (vec2(3.0, 1.0));
	block.var[2][3][0][0] = (vec2(-1.0, -6.0));
	block.var[2][3][0][1] = (vec2(1.0, 1.0));
	block.var[2][3][0][2] = (vec2(-7.0, -8.0));
	block.var[2][3][0][3] = (vec2(-5.0, 5.0));
	block.var[2][3][1][0] = (vec2(4.0, -9.0));
	block.var[2][3][1][1] = (vec2(-6.0, -7.0));
	block.var[2][3][1][2] = (vec2(-8.0, 8.0));
	block.var[2][3][1][3] = (vec2(-3.0, 6.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.s.a), ivec3(2, 2, -2)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(0.0, -3.0, -4.0, 0.0, -5.0, 5.0, 1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(2.0, 7.0, 3.0, -7.0, -2.0, -2.0, 0.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(9.0, 6.0, 1.0, 8.0, 2.0, -8.0, -9.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(6.0, 6.0, 0.0, -9.0, -5.0, -5.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(8.0, -4.0, 0.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(-3, 6, 8));
	block.s.b[0] = (mat3(1.0, -7.0, 5.0, -7.0, 2.0, -2.0, -1.0, -6.0, -6.0));
	block.s.b[1] = (mat3(7.0, 1.0, 8.0, 8.0, 9.0, -7.0, -4.0, 0.0, -9.0));
	block.s.b[2] = (mat3(-2.0, 7.0, 2.0, 3.0, -7.0, -4.0, 2.0, -2.0, -7.0));
	block.s.b[3] = (mat3(3.0, 5.0, 3.0, 1.0, -6.0, -6.0, -6.0, 0.0, -7.0));
	block.s.c = (vec4(4.0, 5.0, -6.0, -8.0));
}
#version 450
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
	allOk = compare_vec3((block[0].var), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((block[1].var), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((block[2].var), vec3(1.0, -1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (vec3(5.0, 4.0, 7.0));
	block[1].var = (vec3(8.0, -2.0, 7.0));
	block[2].var = (vec3(-5.0, -7.0, 9.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 5.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 8.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 1.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-1.0, -7.0, 8.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(5.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(-9.0, 5.0, 0.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(8.0, 6.0, 1.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 8.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[3][2], 7.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(7.0, -9.0, 6.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(0.0, -8.0, -3.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-6.0, 8.0, 8.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(-7.0, 8.0, 7.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[3][2], 5.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(1.0, 0.0, 7.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-2.0, 4.0, 9.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(9.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(-2.0, -4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	block[1].var = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	block[2].var = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
}
#version 450
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
    Block block[3];
};

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
layout(std430, buffer_reference) buffer BlockA
{
	highp float a;
	S b;
	lowp uvec3 c;
};
layout(std430, buffer_reference) buffer BlockB
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
	allOk = compare_uint((blockB.b.a), 2u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(-9.0, 1.0, -4.0, -5.0, -5.0, -2.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(2, -2)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(6, 7)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(-3, -2)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(6, 9)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(6.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-5.0);
	blockA.b.a = (mat3(-2.0, 8.0, 8.0, -7.0, 8.0, -2.0, -2.0, -6.0, 6.0));
	blockA.b.b[0] = (ivec2(0, -6));
	blockA.b.b[1] = (ivec2(-4, 3));
	blockA.b.b[2] = (ivec2(-6, -4));
	blockA.b.b[3] = (ivec2(-4, -3));
	blockA.b.c = (vec4(-6.0, 0.0, -2.0, -1.0));
	blockB.a = (mat2(7.0, -6.0, 9.0, -2.0));
	blockB.b.a = (0u);
	blockB.b.b.a = (mat3(7.0, -9.0, -9.0, 8.0, 1.0, 9.0, -5.0, -4.0, 1.0));
	blockB.b.b.b[0] = (ivec2(-6, 7));
	blockB.b.b.b[1] = (ivec2(8, -2));
	blockB.b.b.b[2] = (ivec2(0, 7));
	blockB.b.b.b[3] = (ivec2(6, -5));
	blockB.b.b.c = (vec4(3.0, -7.0, 0.0, -5.0));
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

layout(std430, buffer_reference) buffer BlockB
{
	mediump uvec2 a;
	lowp uvec2 b;
	highp uvec4 c[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp float d;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	bvec3 e;
	highp uvec3 f;
	mediump uvec4 g[5];
	lowp vec3 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(0u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(2u, 2u)) && allOk;
	allOk = compare_float((blockC.d), -6.0) && allOk;
	allOk = compare_bvec3((blockD.e), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec3((blockD.f), uvec3(9u, 1u, 1u)) && allOk;
	allOk = compare_vec3((blockD.h[0]), vec3(-3.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD.h[1]), vec3(6.0, 0.0, 1.0)) && allOk;
	allOk = compare_vec3((blockD.h[2]), vec3(-9.0, 2.0, -2.0)) && allOk;
	allOk = compare_vec3((blockD.h[3]), vec3(-3.0, 0.0, -4.0)) && allOk;
	allOk = compare_vec3((blockD.h[4]), vec3(4.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD.h[5]), vec3(-5.0, 7.0, -4.0)) && allOk;
	allOk = compare_vec3((blockD.h[6]), vec3(5.0, 7.0, -8.0)) && allOk;
	allOk = compare_vec3((blockD.h[7]), vec3(-1.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(4u, 1u));
	blockC.d = (0.0);
	blockD.e = (bvec3(false, false, false));
	blockD.f = (uvec3(5u, 3u, 4u));
	blockD.g[0] = (uvec4(1u, 8u, 5u, 4u));
	blockD.g[1] = (uvec4(0u, 3u, 6u, 3u));
	blockD.g[2] = (uvec4(2u, 6u, 2u, 9u));
	blockD.g[3] = (uvec4(2u, 7u, 3u, 2u));
	blockD.g[4] = (uvec4(6u, 9u, 9u, 6u));
}
#version 450
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
	lowp mat2 a;
	bool b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp vec2 c;
	mediump mat3 d[];
};
layout(std140, buffer_reference) buffer BlockD
{
	highp ivec3 e;
	highp mat4 f;
	highp uvec2 g;
	lowp ivec4 h;
	bvec2 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB[0].a, mat2(2.0, -4.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec2((blockC.c), vec2(-5.0, -8.0)) && allOk;
	allOk = compare_mat3(blockC.d[0], mat3(-6.0, 6.0, 8.0, 4.0, -6.0, 1.0, 5.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat4(blockD[0].f, mat4(5.0, -9.0, -8.0, 6.0, 2.0, 3.0, -7.0, -8.0, 9.0, -9.0, 1.0, 1.0, 3.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_uvec2((blockD[0].g), uvec2(2u, 4u)) && allOk;
	allOk = compare_ivec4((blockD[0].h), ivec4(6, 7, 5, 8)) && allOk;
	allOk = compare_bvec2((blockD[0].i[0]), bvec2(false, true)) && allOk;
	allOk = compare_mat4(blockD[1].f, mat4(-8.0, 5.0, -1.0, 1.0, 7.0, -7.0, -7.0, 7.0, 6.0, 7.0, 2.0, 9.0, 1.0, 5.0, 3.0, -6.0)) && allOk;
	allOk = compare_uvec2((blockD[1].g), uvec2(2u, 3u)) && allOk;
	allOk = compare_ivec4((blockD[1].h), ivec4(9, -5, 1, -3)) && allOk;
	allOk = compare_bvec2((blockD[1].i[0]), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat2(8.0, -1.0, -2.0, -6.0));
	blockB[0].b[0] = (false);
	blockC.c = (vec2(0.0, 9.0));
	blockC.d[0] = (mat3(5.0, 6.0, 5.0, 4.0, 7.0, -2.0, 8.0, -5.0, 7.0));
	blockD[0].e = (ivec3(4, 7, 0));
	blockD[0].f = (mat4(9.0, -4.0, -5.0, 4.0, 9.0, -7.0, -6.0, -2.0, -4.0, 8.0, -6.0, -4.0, 6.0, -3.0, -6.0, 8.0));
	blockD[0].g = (uvec2(2u, 6u));
	blockD[0].i[0] = (bvec2(true, true));
	blockD[1].e = (ivec3(-5, -1, -2));
	blockD[1].f = (mat4(-3.0, -7.0, 8.0, -6.0, 7.0, 9.0, 8.0, -3.0, -4.0, 4.0, 9.0, 0.0, 1.0, 2.0, -3.0, -9.0));
	blockD[1].g = (uvec2(5u, 5u));
	blockD[1].i[0] = (bvec2(true, true));
}
#version 450
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
	mediump uvec4 a[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump float b;
	mediump vec4 c;
	highp mat2 d;
	lowp mat2x3 e;
};
layout(std140, row_major, buffer_reference) readonly buffer BlockD
{
	bvec3 f;
	mediump ivec3 g[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a[0]), uvec4(0u, 2u, 0u, 4u)) && allOk;
	allOk = compare_vec4((blockC.c), vec4(-5.0, 9.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2(blockC.d, mat2(-1.0, -1.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockC.e, mat2x3(6.0, 5.0, 7.0, -2.0, -4.0, -9.0)) && allOk;
	allOk = compare_bvec3((blockD.f), bvec3(true, true, false)) && allOk;
	allOk = compare_ivec3((blockD.g[0]), ivec3(8, 0, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (-6.0);
	blockC.c = (vec4(6.0, -6.0, 3.0, -7.0));
	blockC.d = (mat2(8.0, 5.0, -6.0, -7.0));
}
#version 450
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
layout(std140, buffer_reference) buffer BlockB
{
	mediump mat3 a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	sB b[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	highp mat2 c;
	lowp mat4x3 d;
	bool e;
	mediump ivec2 f;
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	mediump mat2x3 g;
	highp mat4x2 h;
	lowp mat3x2 i;
	highp uvec3 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC[1];
    BlockD blockD[2];
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
	allOk = compare_mat2x3(blockE.g, mat2x3(-2.0, 8.0, -9.0, -2.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockE.i, mat3x2(1.0, -9.0, -4.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_uvec3((blockE.j[0]), uvec3(8u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((blockE.j[1]), uvec3(9u, 6u, 3u)) && allOk;
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
	blockE.h = (mat4x2(-1.0, 2.0, 2.0, -7.0, -3.0, -9.0, 2.0, -9.0));
	blockE.i = (mat3x2(2.0, 1.0, 6.0, 3.0, -5.0, 5.0));
	blockE.j[0] = (uvec3(2u, 8u, 8u));
	blockE.j[1] = (uvec3(8u, 7u, 6u));
}
#version 450
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
	lowp mat2x3 a;
	mediump uvec3 b;
	lowp vec4 c;
	mediump mat2 d[];
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	highp vec2 e;
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
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(-4.0, 6.0, -9.0, 6.0, -7.0, 5.0)) && allOk;
	allOk = compare_uvec3((blockB.b), uvec3(4u, 7u, 0u)) && allOk;
	allOk = compare_vec2((blockC.e), vec2(0.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(9.0, -5.0, -8.0, -7.0, -9.0, 0.0));
	blockB.c = (vec4(7.0, 1.0, 2.0, -5.0));
}
#version 450
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
	layout(offset = 0) mediump ivec3 a;
	layout(offset = 16) bvec2 b;
	layout(offset = 32) mediump uvec4 c;
	layout(offset = 48) highp uvec2 d;
	layout(offset = 64) mediump uvec3 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp vec4 f;
	layout(offset = 16) highp uint g;
	layout(offset = 20) lowp float h;
	layout(offset = 32) bvec3 i;
	layout(offset = 48) lowp vec2 j;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp vec4 k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(0, 3, 3)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(true, true)) && allOk;
	allOk = compare_uvec4((blockB.c), uvec4(0u, 0u, 8u, 1u)) && allOk;
	allOk = compare_uvec2((blockB.d), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec3((blockB.e), uvec3(9u, 2u, 6u)) && allOk;
	allOk = compare_uint((blockC.g), 9u) && allOk;
	allOk = compare_vec2((blockC.j), vec2(2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(5, -5, 3));
	blockB.c = (uvec4(6u, 8u, 0u, 5u));
	blockB.d = (uvec2(7u, 1u));
	blockC.f = (vec4(-3.0, -7.0, -4.0, -2.0));
	blockC.g = (5u);
	blockC.h = (-8.0);
	blockC.i = (bvec3(false, true, false));
	blockD.k = (vec4(-8.0, -6.0, 4.0, 8.0));
}
#version 450
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
	layout(offset = 0) bvec2 a;
	layout(offset = 16) highp mat3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[nonuniformEXT(0)].a), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB[nonuniformEXT(1)].a), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB[nonuniformEXT(2)].a), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB[nonuniformEXT(3)].a), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (bvec2(true, true));
	blockB[nonuniformEXT(1)].a = (bvec2(true, false));
	blockB[nonuniformEXT(2)].a = (bvec2(true, false));
	blockB[nonuniformEXT(3)].a = (bvec2(false, false));
}
#version 450
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
	mediump mat2 a;
	highp int b[1];
	bvec4 c[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB[nonuniformEXT(0)].a, mat2(-7.0, 3.0, -2.0, 9.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].c[0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(1)].a, mat2(7.0, -7.0, 7.0, -4.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].c[0]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(2)].a, mat2(7.0, -5.0, 4.0, -7.0)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(2)].c[0]), bvec4(false, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat2(-6.0, -2.0, 3.0, -5.0));
	blockB[nonuniformEXT(0)].b[0] = (-4);
	blockB[nonuniformEXT(0)].c[0] = (bvec4(true, true, false, false));
	blockB[nonuniformEXT(1)].a = (mat2(-4.0, -9.0, -3.0, 7.0));
	blockB[nonuniformEXT(1)].b[0] = (3);
	blockB[nonuniformEXT(1)].c[0] = (bvec4(false, true, false, false));
	blockB[nonuniformEXT(2)].a = (mat2(-7.0, 4.0, 9.0, -8.0));
	blockB[nonuniformEXT(2)].b[0] = (-1);
	blockB[nonuniformEXT(2)].c[0] = (bvec4(true, false, true, false));
}
#version 450
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
	lowp uvec2 a;
	bvec3 b[1];
	f16vec4 c;
	mediump vec2 d;
};
layout(std140, buffer_reference) buffer BlockC
{
	i16vec3 e;
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp vec2 f;
	highp vec3 g[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(5u, 4u)) && allOk;
	allOk = compare_bvec3((blockB.b[0]), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(3u, 1u));
	blockB.d = (vec2(-3.0, -1.0));
	blockC.e = i16vec3(ivec3(6, 9, 5));
	blockD.f = (vec2(-6.0, -1.0));
}
#version 450
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
	highp uvec4 mB;
};
struct sB
{
	i16vec3 mA;
};
struct sC
{
	mediump ivec3 mA;
	lowp int mB;
	lowp vec3 mC;
};
struct sD
{
	lowp mat2 mA;
	sC mB;
	lowp ivec3 mC;
	i16vec4 mD;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	sA a;
	mediump float b;
	float16_t c;
	sB d;
	u16vec2 e;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump mat4x3 f[1];
	mediump int g;
	highp vec2 h[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	sD i;
	f16vec2 j;
	lowp uint k[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	lowp vec4 l;
	bvec4 m;
	bvec4 n;
	highp mat2 o;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.a.mA), ivec4(6, 6, -6, -3)) && allOk;
	allOk = compare_uvec4((blockB.a.mB), uvec4(4u, 5u, 4u, 3u)) && allOk;
	allOk = compare_float((blockB.b), -9.0) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.d.mA), ivec3(-4, -8, 8)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.e), uvec2(1u, 4u)) && allOk;
	allOk = compare_mat4x3(blockC.f[0], mat4x3(-2.0, 9.0, -2.0, -2.0, 1.0, 1.0, 7.0, -1.0, 9.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2(blockD.i.mA, mat2(8.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_ivec3((blockD.i.mB.mA), ivec3(3, -5, -3)) && allOk;
	allOk = compare_int((blockD.i.mB.mB), 0) && allOk;
	allOk = compare_vec3((blockD.i.mB.mC), vec3(-2.0, -4.0, 4.0)) && allOk;
	allOk = compare_ivec3((blockD.i.mC), ivec3(-6, -3, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.i.mD), ivec4(-2, 4, -4, 8)) && allOk;
	allOk = compare_f16vec2(vec2(blockD.j), vec2(-5.0, -4.0)) && allOk;
	allOk = compare_uint((blockD.k[0]), 3u) && allOk;
	allOk = compare_vec4((blockE.l), vec4(-3.0, 0.0, -9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (-9.0);
	blockB.e = u16vec2(uvec2(2u, 2u));
	blockC.f[0] = (mat4x3(-3.0, 6.0, 7.0, -9.0, -6.0, -1.0, 3.0, 5.0, 3.0, 9.0, 8.0, -4.0));
	blockC.g = (-8);
	blockC.h[0] = (vec2(-5.0, -1.0));
	blockD.i.mA = (mat2(2.0, 0.0, 5.0, 3.0));
	blockD.i.mB.mA = (ivec3(-3, 2, 4));
	blockD.i.mB.mB = (4);
	blockD.i.mB.mC = (vec3(-6.0, 4.0, -5.0));
	blockD.i.mC = (ivec3(-2, -4, -5));
	blockD.i.mD = i16vec4(ivec4(7, 6, -9, 0));
	blockD.j = f16vec2(vec2(-7.0, 2.0));
	blockD.k[0] = (9u);
	blockE.l = (vec4(9.0, 2.0, -9.0, -2.0));
	blockE.m = (bvec4(false, true, true, false));
	blockE.n = (bvec4(false, false, true, false));
}
#version 450
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
	highp mat3 a[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	float16_t b;
	f16vec4 c;
	mediump uvec3 d;
	lowp vec3 e;
	highp uvec4 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a[0], mat3(4.0, 4.0, -4.0, 7.0, 4.0, 1.0, 9.0, 3.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.c), vec4(-6.0, 0.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = float16_t(-5.0);
	blockC.f[0] = (uvec4(8u, 2u, 9u, 0u));
}
#version 450
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
	uint16_t mA;
	f16vec3 mB[5];
	lowp uint mC;
	bvec3 mD;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	i16vec2 a;
	highp mat3x2 b;
	lowp mat3x2 c[6][7];
	sA d;
	u16vec4 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	uint16_t f;
	mediump mat4x2 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.a), ivec2(1, -3)) && allOk;
	allOk = compare_mat3x2(blockB.b, mat3x2(9.0, 7.0, -5.0, 2.0, -1.0, -8.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB.d.mA), 6u) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d.mB[0]), vec3(-7.0, -8.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d.mB[1]), vec3(2.0, -3.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d.mB[2]), vec3(-9.0, -3.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d.mB[3]), vec3(-5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d.mB[4]), vec3(4.0, 0.0, -9.0)) && allOk;
	allOk = compare_uint((blockB.d.mC), 0u) && allOk;
	allOk = compare_bvec3((blockB.d.mD), bvec3(true, false, false)) && allOk;
	allOk = compare_uint16_t(uint(blockC.f), 8u) && allOk;
	allOk = compare_mat4x2(blockC.g[0], mat4x2(8.0, 5.0, 1.0, 5.0, -2.0, -8.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockC.g[1], mat4x2(9.0, 5.0, 0.0, -6.0, -9.0, 7.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec2(ivec2(9, -2));
	blockB.b = (mat3x2(-3.0, -7.0, 6.0, 2.0, -8.0, 7.0));
	blockB.c[0][0] = (mat3x2(6.0, -4.0, 5.0, 7.0, 9.0, -2.0));
	blockB.c[0][1] = (mat3x2(6.0, 4.0, 0.0, 7.0, 5.0, -3.0));
	blockB.c[0][2] = (mat3x2(1.0, 0.0, -8.0, -8.0, 5.0, 2.0));
	blockB.c[0][3] = (mat3x2(6.0, 6.0, -9.0, 7.0, 6.0, 3.0));
	blockB.c[0][4] = (mat3x2(9.0, -8.0, 1.0, 4.0, -5.0, 0.0));
	blockB.c[0][5] = (mat3x2(-7.0, -1.0, 7.0, 9.0, 5.0, -4.0));
	blockB.c[0][6] = (mat3x2(-6.0, 0.0, -8.0, -2.0, 5.0, -8.0));
	blockB.c[1][0] = (mat3x2(0.0, -6.0, 9.0, 3.0, -2.0, 9.0));
	blockB.c[1][1] = (mat3x2(-1.0, 8.0, 4.0, 9.0, -5.0, 8.0));
	blockB.c[1][2] = (mat3x2(0.0, 3.0, 8.0, 9.0, 3.0, -9.0));
	blockB.c[1][3] = (mat3x2(6.0, 7.0, 3.0, 2.0, -5.0, 6.0));
	blockB.c[1][4] = (mat3x2(3.0, -9.0, 6.0, 8.0, 1.0, -3.0));
	blockB.c[1][5] = (mat3x2(-2.0, -8.0, 1.0, -4.0, -7.0, 7.0));
	blockB.c[1][6] = (mat3x2(9.0, 9.0, -1.0, -1.0, 0.0, -6.0));
	blockB.c[2][0] = (mat3x2(-6.0, 7.0, 9.0, 0.0, -6.0, 7.0));
	blockB.c[2][1] = (mat3x2(4.0, -6.0, -6.0, 1.0, -1.0, -9.0));
	blockB.c[2][2] = (mat3x2(7.0, -5.0, 0.0, -4.0, 7.0, 2.0));
	blockB.c[2][3] = (mat3x2(-2.0, 7.0, -4.0, 7.0, 2.0, 8.0));
	blockB.c[2][4] = (mat3x2(-9.0, -2.0, -8.0, 9.0, -3.0, -1.0));
	blockB.c[2][5] = (mat3x2(-4.0, 8.0, 1.0, 0.0, -1.0, 3.0));
	blockB.c[2][6] = (mat3x2(6.0, 8.0, 6.0, -7.0, -6.0, 6.0));
	blockB.c[3][0] = (mat3x2(-3.0, 1.0, -6.0, -9.0, 9.0, 3.0));
	blockB.c[3][1] = (mat3x2(5.0, 7.0, -2.0, 3.0, 6.0, 1.0));
	blockB.c[3][2] = (mat3x2(-9.0, 0.0, -8.0, -5.0, 8.0, -7.0));
	blockB.c[3][3] = (mat3x2(-1.0, 6.0, -9.0, 7.0, 8.0, 4.0));
	blockB.c[3][4] = (mat3x2(-2.0, 9.0, -8.0, 0.0, 5.0, 2.0));
	blockB.c[3][5] = (mat3x2(4.0, 7.0, 1.0, 4.0, 4.0, -4.0));
	blockB.c[3][6] = (mat3x2(5.0, 5.0, 2.0, 0.0, -5.0, 2.0));
	blockB.c[4][0] = (mat3x2(-5.0, -5.0, 5.0, -9.0, 9.0, 0.0));
	blockB.c[4][1] = (mat3x2(8.0, 8.0, 3.0, 9.0, 1.0, -8.0));
	blockB.c[4][2] = (mat3x2(4.0, 6.0, 8.0, 1.0, 1.0, 6.0));
	blockB.c[4][3] = (mat3x2(-5.0, 6.0, -4.0, -2.0, -4.0, 1.0));
	blockB.c[4][4] = (mat3x2(-8.0, 8.0, -3.0, -3.0, 5.0, 9.0));
	blockB.c[4][5] = (mat3x2(-2.0, -8.0, 9.0, 6.0, -3.0, -8.0));
	blockB.c[4][6] = (mat3x2(6.0, 8.0, -5.0, 7.0, -2.0, 0.0));
	blockB.c[5][0] = (mat3x2(-4.0, -8.0, -6.0, 3.0, 0.0, -6.0));
	blockB.c[5][1] = (mat3x2(-5.0, 6.0, -1.0, 1.0, -4.0, 9.0));
	blockB.c[5][2] = (mat3x2(-3.0, 1.0, -5.0, -7.0, 4.0, 9.0));
	blockB.c[5][3] = (mat3x2(-9.0, 8.0, -9.0, -8.0, 6.0, -6.0));
	blockB.c[5][4] = (mat3x2(9.0, -3.0, 4.0, 3.0, -1.0, 3.0));
	blockB.c[5][5] = (mat3x2(6.0, -6.0, -9.0, -2.0, 6.0, 0.0));
	blockB.c[5][6] = (mat3x2(-3.0, -4.0, 9.0, 3.0, 7.0, -2.0));
	blockC.f = uint16_t(6u);
	blockC.g[0] = (mat4x2(4.0, 5.0, 3.0, 7.0, 0.0, 6.0, 4.0, -8.0));
	blockC.g[1] = (mat4x2(0.0, 2.0, 7.0, -4.0, 3.0, -5.0, 1.0, 9.0));
}
#version 450
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
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	int16_t a;
	u16vec3 b;
	lowp uvec2 c;
	f16vec4 d;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	sA e[];
};
layout(std140, buffer_reference) buffer BlockD
{
	highp mat3x2 f;
	i16vec2 g[];
};
layout(std140, buffer_reference) buffer BlockE
{
	lowp int h;
	highp uvec3 i;
	i16vec4 j;
	mediump uvec3 k[6];
	uint16_t l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.a), 0) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.b), uvec3(9u, 6u, 3u)) && allOk;
	allOk = compare_uvec2((blockB.c), uvec2(9u, 2u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.d), vec4(1.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_bvec4((blockC.e[0].mA), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.e[1].mA), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.e[2].mA), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockC.e[3].mA), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.e[4].mA), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.e[5].mA), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.e[6].mA), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uvec3((blockE.i), uvec3(4u, 1u, 5u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.j), ivec4(-6, -8, 6, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int16_t(5);
	blockB.b = u16vec3(uvec3(6u, 1u, 3u));
	blockB.c = (uvec2(3u, 9u));
	blockB.d = f16vec4(vec4(0.0, -1.0, -9.0, 2.0));
	blockC.e[0].mA = (bvec4(false, false, false, false));
	blockC.e[1].mA = (bvec4(false, true, true, false));
	blockC.e[2].mA = (bvec4(false, false, true, false));
	blockC.e[3].mA = (bvec4(true, false, true, false));
	blockC.e[4].mA = (bvec4(false, false, false, false));
	blockC.e[5].mA = (bvec4(false, true, false, true));
	blockC.e[6].mA = (bvec4(true, false, true, true));
	blockD.f = (mat3x2(-9.0, 1.0, -9.0, 6.0, 2.0, -1.0));
	blockD.g[0] = i16vec2(ivec2(2, -5));
	blockE.h = (-8);
	blockE.i = (uvec3(9u, 0u, 0u));
	blockE.j = i16vec4(ivec4(2, -2, 3, -7));
	blockE.k[0] = (uvec3(8u, 8u, 3u));
	blockE.k[1] = (uvec3(1u, 9u, 2u));
	blockE.k[2] = (uvec3(0u, 3u, 5u));
	blockE.k[3] = (uvec3(3u, 2u, 6u));
	blockE.k[4] = (uvec3(6u, 6u, 1u));
	blockE.k[5] = (uvec3(4u, 6u, 4u));
}
#version 450
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
	lowp ivec4 a;
	lowp ivec2 b;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump uvec2 c[];
};
layout(std140, buffer_reference) buffer BlockD
{
	bvec3 d;
	highp float e;
	highp uvec4 f;
	f16vec3 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(-6, -1, -4, -3)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-1, 8)) && allOk;
	allOk = compare_bvec3((blockD.d), bvec3(true, false, false)) && allOk;
	allOk = compare_float((blockD.e), 3.0) && allOk;
	allOk = compare_uvec4((blockD.f), uvec4(7u, 1u, 7u, 0u)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.g[0]), vec3(-4.0, -3.0, 3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.g[1]), vec3(-6.0, 3.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.g[2]), vec3(9.0, -3.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.g[3]), vec3(-4.0, -3.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.g[4]), vec3(-4.0, 6.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.g[5]), vec3(2.0, -6.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.g[6]), vec3(-4.0, -5.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.g[7]), vec3(-9.0, -9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-6, -9, 9, 5));
	blockB.b = (ivec2(6, -9));
	blockC.c[0] = (uvec2(2u, 2u));
	blockC.c[1] = (uvec2(0u, 7u));
	blockC.c[2] = (uvec2(9u, 2u));
	blockD.d = (bvec3(false, false, false));
	blockD.e = (-4.0);
	blockD.g[0] = f16vec3(vec3(9.0, 8.0, -8.0));
	blockD.g[1] = f16vec3(vec3(-8.0, -4.0, 9.0));
	blockD.g[2] = f16vec3(vec3(-2.0, -5.0, 3.0));
	blockD.g[3] = f16vec3(vec3(-8.0, 1.0, 2.0));
	blockD.g[4] = f16vec3(vec3(9.0, -1.0, -6.0));
	blockD.g[5] = f16vec3(vec3(4.0, -2.0, -1.0));
	blockD.g[6] = f16vec3(vec3(3.0, 3.0, -9.0));
	blockD.g[7] = f16vec3(vec3(7.0, 2.0, -5.0));
}
#version 450
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
	i16vec4 a;
	i16vec3 b;
	i16vec3 c;
	u16vec2 d;
	bvec2 e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	u16vec4 f;
	u16vec2 g[][8];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	mediump vec3 h[4];
	int16_t i;
	highp uint j;
	bvec2 k;
	mediump ivec4 l[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	u16vec3 m;
	f16vec3 n;
	bvec2 o[];
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
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.a), ivec4(-8, -9, -9, 3)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.d), uvec2(6u, 4u)) && allOk;
	allOk = compare_bvec2((blockB.e[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.e[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.e[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.e[3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.e[4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.e[5]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.e[6]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.e[7]), bvec2(true, false)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.f), uvec4(3u, 2u, 7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[0][0]), uvec2(7u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[0][1]), uvec2(0u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[0][2]), uvec2(3u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[0][3]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[0][4]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[0][5]), uvec2(5u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[0][6]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[0][7]), uvec2(8u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[1][0]), uvec2(7u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[1][1]), uvec2(0u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[1][2]), uvec2(6u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[1][3]), uvec2(8u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[1][4]), uvec2(4u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[1][5]), uvec2(8u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[1][6]), uvec2(7u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[1][7]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[2][0]), uvec2(1u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[2][1]), uvec2(0u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[2][2]), uvec2(6u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[2][3]), uvec2(7u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[2][4]), uvec2(5u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[2][5]), uvec2(9u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[2][6]), uvec2(9u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[2][7]), uvec2(2u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[3][0]), uvec2(3u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[3][1]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[3][2]), uvec2(9u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[3][3]), uvec2(3u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[3][4]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[3][5]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[3][6]), uvec2(6u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.g[3][7]), uvec2(0u, 4u)) && allOk;
	allOk = compare_int16_t(int(blockD.i), 0) && allOk;
	allOk = compare_uint((blockD.j), 2u) && allOk;
	allOk = compare_bvec2((blockD.k), bvec2(false, true)) && allOk;
	allOk = compare_ivec4((blockD.l[0]), ivec4(-2, 7, 5, -4)) && allOk;
	allOk = compare_ivec4((blockD.l[1]), ivec4(-7, -3, 1, 3)) && allOk;
	allOk = compare_ivec4((blockD.l[2]), ivec4(-8, -6, 8, -1)) && allOk;
	allOk = compare_ivec4((blockD.l[3]), ivec4(-6, 9, 1, -9)) && allOk;
	allOk = compare_ivec4((blockD.l[4]), ivec4(1, -9, -5, 2)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.m), uvec3(3u, 8u, 5u)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.n), vec3(-3.0, 9.0, -5.0)) && allOk;
	allOk = compare_bvec2((blockE.o[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.o[1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.o[2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.o[3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.o[4]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec4(ivec4(7, -8, -6, -6));
	blockB.b = i16vec3(ivec3(3, 5, -1));
	blockB.c = i16vec3(ivec3(2, 9, 3));
	blockB.d = u16vec2(uvec2(7u, 0u));
	blockB.e[0] = (bvec2(false, true));
	blockB.e[1] = (bvec2(true, true));
	blockB.e[2] = (bvec2(false, true));
	blockB.e[3] = (bvec2(true, false));
	blockB.e[4] = (bvec2(false, false));
	blockB.e[5] = (bvec2(false, false));
	blockB.e[6] = (bvec2(true, true));
	blockB.e[7] = (bvec2(true, false));
	blockC.f = u16vec4(uvec4(9u, 5u, 3u, 9u));
	blockC.g[0][0] = u16vec2(uvec2(9u, 5u));
	blockC.g[0][1] = u16vec2(uvec2(5u, 3u));
	blockC.g[0][2] = u16vec2(uvec2(4u, 8u));
	blockC.g[0][3] = u16vec2(uvec2(7u, 9u));
	blockC.g[0][4] = u16vec2(uvec2(8u, 8u));
	blockC.g[0][5] = u16vec2(uvec2(3u, 1u));
	blockC.g[0][6] = u16vec2(uvec2(6u, 2u));
	blockC.g[0][7] = u16vec2(uvec2(4u, 1u));
	blockC.g[1][0] = u16vec2(uvec2(0u, 8u));
	blockC.g[1][1] = u16vec2(uvec2(9u, 9u));
	blockC.g[1][2] = u16vec2(uvec2(0u, 2u));
	blockC.g[1][3] = u16vec2(uvec2(3u, 1u));
	blockC.g[1][4] = u16vec2(uvec2(2u, 3u));
	blockC.g[1][5] = u16vec2(uvec2(2u, 7u));
	blockC.g[1][6] = u16vec2(uvec2(8u, 6u));
	blockC.g[1][7] = u16vec2(uvec2(4u, 7u));
	blockC.g[2][0] = u16vec2(uvec2(8u, 8u));
	blockC.g[2][1] = u16vec2(uvec2(8u, 2u));
	blockC.g[2][2] = u16vec2(uvec2(3u, 2u));
	blockC.g[2][3] = u16vec2(uvec2(0u, 9u));
	blockC.g[2][4] = u16vec2(uvec2(8u, 4u));
	blockC.g[2][5] = u16vec2(uvec2(1u, 2u));
	blockC.g[2][6] = u16vec2(uvec2(1u, 4u));
	blockC.g[2][7] = u16vec2(uvec2(4u, 7u));
	blockC.g[3][0] = u16vec2(uvec2(2u, 0u));
	blockC.g[3][1] = u16vec2(uvec2(3u, 7u));
	blockC.g[3][2] = u16vec2(uvec2(5u, 8u));
	blockC.g[3][3] = u16vec2(uvec2(5u, 8u));
	blockC.g[3][4] = u16vec2(uvec2(1u, 3u));
	blockC.g[3][5] = u16vec2(uvec2(2u, 6u));
	blockC.g[3][6] = u16vec2(uvec2(2u, 6u));
	blockC.g[3][7] = u16vec2(uvec2(4u, 4u));
	blockD.j = (7u);
	blockD.k = (bvec2(true, false));
	blockD.l[0] = (ivec4(-5, -6, -2, -7));
	blockD.l[1] = (ivec4(0, -1, -1, -2));
	blockD.l[2] = (ivec4(-5, -8, -6, -6));
	blockD.l[3] = (ivec4(2, 4, 1, 8));
	blockD.l[4] = (ivec4(6, 2, 1, 6));
	blockE.n = f16vec3(vec3(5.0, 8.0, -2.0));
	blockE.o[0] = (bvec2(false, true));
	blockE.o[1] = (bvec2(false, true));
	blockE.o[2] = (bvec2(true, true));
	blockE.o[3] = (bvec2(true, false));
	blockE.o[4] = (bvec2(false, false));
}
#version 450
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
	layout(offset = 16) lowp vec4 b;
	layout(offset = 32) highp uvec4 c;
	layout(offset = 48) highp float d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp vec4 e[1];
	layout(offset = 16) f16vec2 f;
	layout(offset = 20) f16vec4 g;
	layout(offset = 28) i16vec2 h;
	layout(offset = 32) bvec4 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b), vec4(-5.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_float((blockB.d), 4.0) && allOk;
	allOk = compare_vec4((blockC.e[0]), vec4(-7.0, 3.0, 8.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f), vec2(9.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.g), vec4(-4.0, 1.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = (vec4(5.0, -2.0, 9.0, -6.0));
	blockB.c = (uvec4(4u, 7u, 8u, 6u));
	blockB.d = (-9.0);
	blockC.f = f16vec2(vec2(-5.0, 2.0));
	blockC.h = i16vec2(ivec2(-4, 1));
	blockC.i = (bvec4(true, true, false, false));
}
#version 450
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
	layout(offset = 0) f16vec3 a;
	layout(offset = 16) lowp vec3 b[1];
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp uvec3 c;
	layout(offset = 16) lowp vec4 d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp vec3 e;
	layout(offset = 16) mediump vec2 f;
	layout(offset = 24) lowp vec2 g;
	layout(offset = 32) i16vec3 h[1];
	layout(offset = 40) u16vec2 i;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) u16vec4 j[1];
	layout(offset = 8) i16vec3 k;
	layout(offset = 16) mediump int l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB[0].b[0]), vec3(7.0, 4.0, 0.0)) && allOk;
	allOk = compare_uvec3((blockC.c), uvec3(6u, 0u, 4u)) && allOk;
	allOk = compare_vec3((blockD.e), vec3(1.0, 8.0, 1.0)) && allOk;
	allOk = compare_vec2((blockD.f), vec2(-7.0, 7.0)) && allOk;
	allOk = compare_vec2((blockD.g), vec2(5.0, 8.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD.h[0]), ivec3(5, -9, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE[0].k), ivec3(-9, 1, 1)) && allOk;
	allOk = compare_int((blockE[0].l), 3) && allOk;
	allOk = compare_i16vec3(ivec3(blockE[1].k), ivec3(-4, 6, 7)) && allOk;
	allOk = compare_int((blockE[1].l), 5) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = f16vec3(vec3(8.0, -2.0, -1.0));
	blockC.c = (uvec3(3u, 8u, 3u));
	blockC.d = (vec4(8.0, 6.0, 7.0, -5.0));
	blockD.h[0] = i16vec3(ivec3(-4, -5, 4));
	blockD.i = u16vec2(uvec2(6u, 2u));
	blockE[0].j[0] = u16vec4(uvec4(2u, 7u, 7u, 0u));
	blockE[0].l = (-3);
	blockE[1].j[0] = u16vec4(uvec4(4u, 3u, 2u, 6u));
	blockE[1].l = (2);
}
#version 450
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
	layout(offset = 16) u16vec2 c[1];
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) mediump float d[1];
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) i16vec3 e;
	layout(offset = 16) mediump ivec3 f;
	layout(offset = 32) lowp uvec2 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a), vec4(6.0, -3.0, 6.0, 1.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.b), ivec3(-7, 2, -1)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.c[0]), uvec2(5u, 3u)) && allOk;
	allOk = compare_float((blockC[0].d[0]), -7.0) && allOk;
	allOk = compare_float((blockC[1].d[0]), -4.0) && allOk;
	allOk = compare_i16vec3(ivec3(blockD.e), ivec3(-1, -5, -5)) && allOk;
	allOk = compare_uvec2((blockD.g), uvec2(6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec4(vec4(6.0, 9.0, -9.0, -1.0));
	blockB.b = i16vec3(ivec3(5, 2, 5));
	blockB.c[0] = u16vec2(uvec2(4u, 2u));
	blockD.e = i16vec3(ivec3(3, 7, 3));
	blockD.f = (ivec3(-3, 2, -9));
	blockD.g = (uvec2(3u, 4u));
}
#version 450
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
struct sB
{
	highp vec4 mA;
	sA mB;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	lowp uint a;
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	highp vec3 b;
	i16vec2 c;
	mediump vec4 d;
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	highp uvec2 e[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	sB f[];
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
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 1u) && allOk;
	allOk = compare_vec3((blockC.b), vec3(6.0, 5.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC.d), vec4(-8.0, 2.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4((blockE.f[0].mA), vec4(-4.0, -8.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2(blockE.f[0].mB.mA, mat2(8.0, -2.0, 5.0, -7.0)) && allOk;
	allOk = compare_vec4((blockE.f[1].mA), vec4(1.0, 5.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2(blockE.f[1].mB.mA, mat2(5.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_vec4((blockE.f[2].mA), vec4(-8.0, -5.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(blockE.f[2].mB.mA, mat2(6.0, -6.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec4((blockE.f[3].mA), vec4(8.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2(blockE.f[3].mB.mA, mat2(-1.0, -1.0, 9.0, 2.0)) && allOk;
	allOk = compare_vec4((blockE.f[4].mA), vec4(0.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2(blockE.f[4].mB.mA, mat2(-9.0, -5.0, -2.0, 1.0)) && allOk;
	allOk = compare_vec4((blockE.f[5].mA), vec4(6.0, -7.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2(blockE.f[5].mB.mA, mat2(-9.0, -1.0, -3.0, -1.0)) && allOk;
	allOk = compare_vec4((blockE.f[6].mA), vec4(-3.0, -7.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2(blockE.f[6].mB.mA, mat2(1.0, 9.0, -1.0, 5.0)) && allOk;
	allOk = compare_vec4((blockE.f[7].mA), vec4(3.0, 3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(blockE.f[7].mB.mA, mat2(6.0, -6.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockC.b = (vec3(-9.0, -1.0, -1.0));
	blockC.c = i16vec2(ivec2(-1, -7));
	blockD.e[0] = (uvec2(7u, 2u));
	blockD.e[1] = (uvec2(5u, 9u));
	blockD.e[2] = (uvec2(0u, 6u));
	blockD.e[3] = (uvec2(1u, 4u));
	blockE.f[0].mA = (vec4(-4.0, 7.0, 1.0, -2.0));
	blockE.f[0].mB.mA = (mat2(-9.0, -2.0, 1.0, -2.0));
	blockE.f[1].mA = (vec4(-2.0, -8.0, -2.0, 0.0));
	blockE.f[1].mB.mA = (mat2(-8.0, -2.0, -3.0, -5.0));
	blockE.f[2].mA = (vec4(-1.0, 2.0, 2.0, -6.0));
	blockE.f[2].mB.mA = (mat2(-1.0, -7.0, 3.0, -2.0));
	blockE.f[3].mA = (vec4(6.0, -3.0, -4.0, -7.0));
	blockE.f[3].mB.mA = (mat2(-1.0, -9.0, -3.0, 5.0));
	blockE.f[4].mA = (vec4(4.0, 7.0, 1.0, 4.0));
	blockE.f[4].mB.mA = (mat2(-8.0, -5.0, 3.0, -3.0));
	blockE.f[5].mA = (vec4(-5.0, -6.0, -4.0, 5.0));
	blockE.f[5].mB.mA = (mat2(-7.0, -4.0, 8.0, -2.0));
	blockE.f[6].mA = (vec4(-7.0, 9.0, -2.0, 5.0));
	blockE.f[6].mB.mA = (mat2(3.0, -2.0, 3.0, 9.0));
	blockE.f[7].mA = (vec4(-1.0, 7.0, 2.0, -2.0));
	blockE.f[7].mB.mA = (mat2(-9.0, 8.0, 0.0, 8.0));
}
#version 450
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
	uint8_t a;
	lowp int b;
	bool c;
	highp uint d;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uint e;
};
layout(std140, buffer_reference) buffer BlockD
{
	int8_t f;
	highp int g;
	lowp uint h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockC.e), 0u) && allOk;
	allOk = compare_int((blockD.g), -4) && allOk;
	allOk = compare_uint((blockD.h), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint8_t(4u);
	blockB.b = (-3);
	blockC.e = (2u);
	blockD.h = (6u);
}
#version 450
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
	mediump uvec4 a;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	bvec2 b;
	u8vec2 c[4];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp mat3 d;
	i8vec2 e;
	bool f;
	bvec4 g;
	highp uvec4 h;
};
layout(std140, buffer_reference) buffer BlockE
{
	mediump uvec2 i;
	highp float j;
	u8vec4 k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(2u, 5u, 1u, 9u)) && allOk;
	allOk = compare_bvec2((blockC.b), bvec2(true, true)) && allOk;
	allOk = compare_mat3(blockD.d, mat3(5.0, -4.0, 1.0, -4.0, -4.0, -3.0, 1.0, 5.0, 6.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.e), ivec2(9, 0)) && allOk;
	allOk = compare_bool((blockD.f), true) && allOk;
	allOk = compare_bvec4((blockD.g), bvec4(false, false, false, false)) && allOk;
	allOk = compare_uvec4((blockD.h), uvec4(3u, 6u, 6u, 8u)) && allOk;
	allOk = compare_uvec2((blockE.i), uvec2(6u, 8u)) && allOk;
	allOk = compare_float((blockE.j), 6.0) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.k), uvec4(8u, 2u, 2u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(6u, 8u, 4u, 7u));
	blockC.b = (bvec2(true, false));
	blockC.c[0] = u8vec2(uvec2(7u, 8u));
	blockC.c[1] = u8vec2(uvec2(6u, 6u));
	blockC.c[2] = u8vec2(uvec2(8u, 4u));
	blockC.c[3] = u8vec2(uvec2(2u, 4u));
	blockD.d = (mat3(-5.0, 2.0, 3.0, 0.0, 4.0, -4.0, -4.0, 1.0, -6.0));
	blockD.e = i8vec2(ivec2(2, 4294967295));
	blockD.f = (false);
	blockD.g = (bvec4(false, false, true, true));
	blockE.k = u8vec4(uvec4(8u, 0u, 8u, 4u));
}
#version 450
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
	lowp mat4x2 a;
	i8vec4 b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp mat3 c[];
};
layout(std140, buffer_reference) buffer BlockD
{
	bvec2 d;
	mediump mat4x3 e;
	lowp int f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.b[0]), ivec4(4294967294, 4294967291, 1, 5)) && allOk;
	allOk = compare_bvec2((blockD.d), bvec2(false, true)) && allOk;
	allOk = compare_mat4x3(blockD.e, mat4x3(-1.0, -1.0, -5.0, 2.0, -6.0, 8.0, -7.0, -4.0, -7.0, -2.0, 2.0, 7.0)) && allOk;
	allOk = compare_int((blockD.f[0]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(-2.0, -9.0, -3.0, -1.0, -2.0, 7.0, -7.0, -6.0));
	blockC.c[0] = (mat3(2.0, 6.0, 4.0, 6.0, -5.0, 2.0, -9.0, -8.0, 3.0));
	blockD.e = (mat4x3(6.0, -6.0, 3.0, 7.0, -8.0, -2.0, -6.0, -3.0, 0.0, 7.0, -1.0, -5.0));
	blockD.f[0] = (-8);
}
#version 450
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
	highp mat4 a;
	uint8_t b;
	highp mat3 c;
	uint8_t d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB[0].d[0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockB[0].d[1]), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockB[0].d[2]), 5u) && allOk;
	allOk = compare_uint8_t(uint(blockB[0].d[3]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockB[0].d[4]), 7u) && allOk;
	allOk = compare_uint8_t(uint(blockB[0].d[5]), 7u) && allOk;
	allOk = compare_uint8_t(uint(blockB[0].d[6]), 2u) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d[0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d[1]), 7u) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d[2]), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d[3]), 2u) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d[4]), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d[5]), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d[6]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d[7]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat4(-1.0, -4.0, 2.0, -1.0, 2.0, 2.0, -5.0, 7.0, -5.0, 5.0, -3.0, 4.0, -8.0, 9.0, -2.0, 5.0));
	blockB[0].d[0] = uint8_t(4u);
	blockB[0].d[1] = uint8_t(5u);
	blockB[0].d[2] = uint8_t(0u);
	blockB[0].d[3] = uint8_t(3u);
	blockB[0].d[4] = uint8_t(3u);
	blockB[0].d[5] = uint8_t(0u);
	blockB[0].d[6] = uint8_t(4u);
	blockB[1].a = (mat4(0.0, -6.0, -8.0, -3.0, 8.0, 2.0, -4.0, 6.0, 9.0, 9.0, -1.0, -2.0, 8.0, 7.0, -5.0, -2.0));
	blockB[1].d[0] = uint8_t(1u);
	blockB[1].d[1] = uint8_t(8u);
	blockB[1].d[2] = uint8_t(1u);
	blockB[1].d[3] = uint8_t(0u);
	blockB[1].d[4] = uint8_t(8u);
	blockB[1].d[5] = uint8_t(5u);
	blockB[1].d[6] = uint8_t(9u);
	blockB[1].d[7] = uint8_t(0u);
}
#version 450
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
	layout(offset = 0) i8vec3 a;
	layout(offset = 3) i8vec2 b;
	layout(offset = 8) mediump vec2 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump uvec3 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockC.d), uvec3(1u, 5u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec3(ivec3(9, 4294967291, 0));
	blockB.b = i8vec2(ivec2(1, 4294967287));
	blockB.c = (vec2(-8.0, 5.0));
	blockC.d = (uvec3(0u, 4u, 8u));
}
#version 450
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
	bvec2 a;
	lowp mat3x4 b[4];
	bool c;
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	i8vec2 d[3][7];
	mediump mat4 e;
	mediump float f;
};
layout(scalar, buffer_reference) buffer BlockD
{
	highp mat3x2 g;
	highp vec4 h;
	i8vec2 i;
	highp vec3 j;
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
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_bool((blockB.c), false) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[0][0]), ivec2(2, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[0][1]), ivec2(4294967294, 4)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[0][2]), ivec2(2, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[0][3]), ivec2(4, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[0][4]), ivec2(4294967292, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[0][5]), ivec2(8, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[0][6]), ivec2(1, 4294967290)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[1][0]), ivec2(4294967289, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[1][1]), ivec2(1, 4294967290)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[1][2]), ivec2(4294967294, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[1][3]), ivec2(4294967295, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[1][4]), ivec2(4294967295, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[1][5]), ivec2(4294967287, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[1][6]), ivec2(4294967290, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[2][0]), ivec2(4294967291, 5)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[2][1]), ivec2(8, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[2][2]), ivec2(7, 4294967292)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[2][3]), ivec2(3, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[2][4]), ivec2(5, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[2][5]), ivec2(6, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d[2][6]), ivec2(4294967289, 4294967291)) && allOk;
	allOk = compare_mat4(blockC.e, mat4(3.0, -8.0, 7.0, -2.0, 0.0, 6.0, -7.0, -2.0, -6.0, 2.0, -2.0, -9.0, 2.0, -6.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockD.g, mat3x2(8.0, -1.0, -3.0, -9.0, -4.0, -2.0)) && allOk;
	allOk = compare_vec4((blockD.h), vec4(-6.0, -7.0, -8.0, -5.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.i), ivec2(4294967291, 9)) && allOk;
	allOk = compare_vec3((blockD.j), vec3(0.0, 0.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockB.c = (false);
	blockC.d[0][0] = i8vec2(ivec2(4294967295, 4294967295));
	blockC.d[0][1] = i8vec2(ivec2(2, 4294967288));
	blockC.d[0][2] = i8vec2(ivec2(4294967295, 4294967294));
	blockC.d[0][3] = i8vec2(ivec2(4294967288, 1));
	blockC.d[0][4] = i8vec2(ivec2(4294967289, 4294967293));
	blockC.d[0][5] = i8vec2(ivec2(3, 4294967290));
	blockC.d[0][6] = i8vec2(ivec2(1, 4294967295));
	blockC.d[1][0] = i8vec2(ivec2(4294967295, 1));
	blockC.d[1][1] = i8vec2(ivec2(2, 4294967291));
	blockC.d[1][2] = i8vec2(ivec2(4294967292, 4));
	blockC.d[1][3] = i8vec2(ivec2(7, 4294967294));
	blockC.d[1][4] = i8vec2(ivec2(8, 4294967291));
	blockC.d[1][5] = i8vec2(ivec2(4294967287, 2));
	blockC.d[1][6] = i8vec2(ivec2(3, 1));
	blockC.d[2][0] = i8vec2(ivec2(4294967291, 4294967294));
	blockC.d[2][1] = i8vec2(ivec2(5, 4294967295));
	blockC.d[2][2] = i8vec2(ivec2(0, 4294967294));
	blockC.d[2][3] = i8vec2(ivec2(2, 4294967289));
	blockC.d[2][4] = i8vec2(ivec2(4294967289, 4294967289));
	blockC.d[2][5] = i8vec2(ivec2(9, 4294967290));
	blockC.d[2][6] = i8vec2(ivec2(4294967288, 6));
	blockC.e = (mat4(5.0, -9.0, -8.0, -8.0, 3.0, 9.0, -6.0, 7.0, 2.0, 1.0, -8.0, 3.0, 4.0, 6.0, -6.0, -6.0));
	blockD.h = (vec4(-8.0, 1.0, -1.0, -7.0));
	blockD.i = i8vec2(ivec2(5, 9));
}
#version 450
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
	i8vec4 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(0)].a), ivec4(7, 4294967289, 0, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(1)].a), ivec4(7, 2, 3, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = i8vec4(ivec4(5, 6, 1, 4294967291));
	blockB[nonuniformEXT(1)].a = i8vec4(ivec4(7, 4294967292, 4, 4294967294));
}
#version 450
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
	layout(offset = 0) u8vec4 a;
	layout(offset = 4) lowp vec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB[nonuniformEXT(0)].a), uvec4(4u, 8u, 8u, 0u)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(0)].b), vec3(-2.0, -7.0, 1.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[nonuniformEXT(1)].a), uvec4(7u, 3u, 3u, 5u)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(1)].b), vec3(-5.0, -1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = u8vec4(uvec4(4u, 3u, 7u, 8u));
	blockB[nonuniformEXT(0)].b = (vec3(8.0, -6.0, -1.0));
	blockB[nonuniformEXT(1)].a = u8vec4(uvec4(9u, 7u, 5u, 6u));
	blockB[nonuniformEXT(1)].b = (vec3(-2.0, 4.0, 9.0));
}
