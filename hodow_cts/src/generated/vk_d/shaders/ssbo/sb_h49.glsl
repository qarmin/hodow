#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -9.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[0][3], -8.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[1][2], 8.0) && allOk;
	allOk = compare_float(var[1][3], 9.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], 3.0) && allOk;
	allOk = compare_float(var[2][3], 6.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-9.0, 3.0, -6.0, -8.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(2.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-9.0, -6.0, 3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-8.0, -3.0, 3.0, -7.0));
	var[1] = (vec4(7.0, 6.0, 3.0, -2.0));
	var[2] = (vec4(7.0, 7.0, -9.0, -7.0));
}
#version 450
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(4.0, 1.0, 0.0, 3.0, 8.0, -3.0, -1.0, 2.0, -9.0, 8.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(2.0, 9.0, 9.0, -3.0, 6.0, 1.0, 1.0, -1.0, -1.0, -5.0, -7.0, -2.0));
}
#version 450
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
	lowp uvec4 var;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var), uvec4(2u, 4u, 5u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (uvec4(6u, 6u, 2u, 2u));
}
#version 450
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
	allOk = compare_mat2(var, mat2(-4.0, 0.0, 8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(-7.0, -4.0, 9.0, 7.0));
}
#version 450
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

	var = (mat2x4(8.0, 7.0, 9.0, -5.0, 2.0, 9.0, -8.0, -9.0));
}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(-2.0, -2.0, 2.0, -8.0, -6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(1.0, -9.0));
	var[1] = (vec2(-5.0, 5.0));
	var[2] = (vec2(6.0, 5.0));
}
#version 450
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
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-4.0, 8.0, -4.0, -3.0, -1.0, -9.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0] = (vec4(-9.0, 5.0, -4.0, 7.0));
	var[1] = (vec4(6.0, -1.0, 7.0, 3.0));
}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-3.0, -8.0, 0.0, 2.0, 7.0, -2.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var = (mat2x4(6.0, 2.0, -6.0, 9.0, 7.0, 1.0, -6.0, -3.0));
}
#version 450
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

	padding = (6.0);
	var[0] = (vec4(-9.0, 1.0, -3.0, 4.0));
	var[1] = (vec4(-7.0, 5.0, 6.0, -3.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
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
}
#version 450
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
	highp mat3 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(2.0, -4.0, 9.0));
	var[0][1] = (vec3(-4.0, 2.0, 5.0));
	var[0][2] = (vec3(5.0, -9.0, -5.0));
	var[1][0] = (vec3(3.0, 1.0, 8.0));
	var[1][1] = (vec3(6.0, 9.0, -8.0));
	var[1][2] = (vec3(-1.0, 5.0, 1.0));
	var[2][0] = (vec3(6.0, -5.0, -4.0));
	var[2][1] = (vec3(-8.0, -8.0, -2.0));
	var[2][2] = (vec3(9.0, -4.0, 4.0));
}
#version 450
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

	var[0][0] = (vec2(-2.0, 8.0));
	var[0][1] = (vec2(1.0, 8.0));
	var[0][2] = (vec2(-7.0, 5.0));
	var[1][0] = (vec2(2.0, 0.0));
	var[1][1] = (vec2(-3.0, 1.0));
	var[1][2] = (vec2(2.0, -5.0));
	var[2][0] = (vec2(6.0, 3.0));
	var[2][1] = (vec2(6.0, 5.0));
	var[2][2] = (vec2(-5.0, 9.0));
}
#version 450
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

	var[0] = int8_t(4294967290);
	var[1] = int8_t(4294967294);
	var[2] = int8_t(3);
}
#version 450
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
	i16vec4 var[3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), -6) && allOk;
	allOk = compare_i16vec4(ivec4(var[0]), ivec4(-9, 9, 8, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1]), ivec4(-8, 8, 9, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2]), ivec4(4, 0, 9, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int16_t(-4);
	var[0] = i16vec4(ivec4(-8, -4, 9, 2));
	var[1] = i16vec4(ivec4(7, -4, 4, 8));
	var[2] = i16vec4(ivec4(9, 5, 1, -3));
}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3], mat2x3(0.0, -5.0, -8.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(8.0, 5.0, -3.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(-6.0, -2.0, 1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(1.0, 7.0, 8.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(-8.0, -9.0, -2.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(-5.0, -5.0, 6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(7.0, 0.0, 2.0, 4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(4.0, -9.0, 5.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(1.0, 5.0, -6.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(-8.0, -8.0, 8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(-5.0, 9.0, -6.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(4.0, 2.0, 6.0, 8.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(-3.0, 7.0, -7.0, -6.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(-6.0, -9.0, -2.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(8.0, -6.0, -6.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(9.0, -9.0, 3.0, -4.0, -3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(-7.0, -8.0, 7.0));
	var[0][1] = (vec3(-6.0, -3.0, -4.0));
	var[1][0] = (vec3(3.0, -8.0, -9.0));
	var[1][1] = (vec3(-2.0, 5.0, 6.0));
	var[2][0] = (vec3(6.0, -5.0, -7.0));
	var[2][1] = (vec3(1.0, 1.0, -3.0));
	var[3][0] = (vec3(9.0, -7.0, 2.0));
	var[3][1] = (vec3(5.0, -4.0, 6.0));
	var[4][0] = (vec3(-3.0, -8.0, 6.0));
	var[4][1] = (vec3(8.0, 2.0, 4.0));
	var[5][0] = (vec3(0.0, 8.0, 0.0));
	var[5][1] = (vec3(-2.0, 1.0, -3.0));
	var[6][0] = (vec3(-6.0, 3.0, 9.0));
	var[6][1] = (vec3(3.0, -2.0, -9.0));
	var[7][0] = (vec3(-7.0, -8.0, -6.0));
	var[7][1] = (vec3(-7.0, 2.0, -3.0));
	var[8][0] = (vec3(1.0, -1.0, 8.0));
	var[8][1] = (vec3(7.0, -2.0, -6.0));
	var[9][0] = (vec3(-1.0, -1.0, -5.0));
	var[9][1] = (vec3(-1.0, 1.0, -1.0));
	var[10][0] = (vec3(5.0, 5.0, -6.0));
	var[10][1] = (vec3(6.0, 7.0, -2.0));
	var[11][0] = (vec3(-5.0, -7.0, -1.0));
	var[11][1] = (vec3(4.0, -3.0, -7.0));
	var[12][0] = (vec3(5.0, 5.0, -4.0));
	var[12][1] = (vec3(1.0, -9.0, 1.0));
	var[13][0] = (vec3(3.0, 0.0, -6.0));
	var[13][1] = (vec3(5.0, -6.0, -6.0));
	var[14][0] = (vec3(7.0, 1.0, -9.0));
	var[14][1] = (vec3(7.0, -8.0, -1.0));
	var[15][0] = (vec3(5.0, -3.0, 9.0));
	var[15][1] = (vec3(-6.0, 4.0, -4.0));
	var[16][0] = (vec3(2.0, 5.0, 0.0));
	var[16][1] = (vec3(1.0, -8.0, 0.0));
	var[17][0] = (vec3(7.0, -2.0, -7.0));
	var[17][1] = (vec3(-6.0, -5.0, 3.0));
	var[18][0] = (vec3(1.0, -4.0, 2.0));
	var[18][1] = (vec3(0.0, 1.0, -8.0));
}
#version 450
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
	highp uint var[];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var[0]), 3u) && allOk;
	allOk = compare_uint((var[1]), 6u) && allOk;
	allOk = compare_uint((var[2]), 9u) && allOk;
	allOk = compare_uint((var[3]), 0u) && allOk;
	allOk = compare_uint((var[4]), 3u) && allOk;
	allOk = compare_uint((var[5]), 7u) && allOk;
	allOk = compare_uint((var[6]), 6u) && allOk;
	allOk = compare_uint((var[7]), 4u) && allOk;
	allOk = compare_uint((var[8]), 2u) && allOk;
	allOk = compare_uint((var[9]), 5u) && allOk;
	allOk = compare_uint((var[10]), 7u) && allOk;
	allOk = compare_uint((var[11]), 5u) && allOk;
	allOk = compare_uint((var[12]), 7u) && allOk;
	allOk = compare_uint((var[13]), 8u) && allOk;
	allOk = compare_uint((var[14]), 6u) && allOk;
	allOk = compare_uint((var[15]), 9u) && allOk;
	allOk = compare_uint((var[16]), 0u) && allOk;
	allOk = compare_uint((var[17]), 1u) && allOk;
	allOk = compare_uint((var[18]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (7u);
	var[1] = (9u);
	var[2] = (1u);
	var[3] = (0u);
	var[4] = (7u);
	var[5] = (7u);
	var[6] = (4u);
	var[7] = (8u);
	var[8] = (7u);
	var[9] = (5u);
	var[10] = (7u);
	var[11] = (2u);
	var[12] = (7u);
	var[13] = (8u);
	var[14] = (6u);
	var[15] = (1u);
	var[16] = (9u);
	var[17] = (8u);
	var[18] = (6u);
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	highp float var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var[0][0]), 7.0) && allOk;
	allOk = compare_float((var[0][1]), -1.0) && allOk;
	allOk = compare_float((var[0][2]), -6.0) && allOk;
	allOk = compare_float((var[1][0]), 0.0) && allOk;
	allOk = compare_float((var[1][1]), -7.0) && allOk;
	allOk = compare_float((var[1][2]), 5.0) && allOk;
	allOk = compare_float((var[2][0]), 4.0) && allOk;
	allOk = compare_float((var[2][1]), 2.0) && allOk;
	allOk = compare_float((var[2][2]), -1.0) && allOk;
	allOk = compare_float((var[3][0]), -6.0) && allOk;
	allOk = compare_float((var[3][1]), -2.0) && allOk;
	allOk = compare_float((var[3][2]), -1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (-2.0);
	var[0][1] = (4.0);
	var[0][2] = (6.0);
	var[1][0] = (7.0);
	var[1][1] = (-4.0);
	var[1][2] = (5.0);
	var[2][0] = (-8.0);
	var[2][1] = (9.0);
	var[2][2] = (-5.0);
	var[3][0] = (8.0);
	var[3][1] = (-5.0);
	var[3][2] = (6.0);
}
#version 450
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
	highp uvec3 var[4][3];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var[0][0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((var[0][1]), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((var[0][2]), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_uvec3((var[1][0]), uvec3(6u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((var[1][1]), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((var[1][2]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((var[2][0]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((var[2][1]), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((var[2][2]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[3][0]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[3][1]), uvec3(8u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((var[3][2]), uvec3(7u, 2u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (uvec3(3u, 5u, 6u));
	var[0][1] = (uvec3(5u, 4u, 5u));
	var[0][2] = (uvec3(4u, 9u, 4u));
	var[1][0] = (uvec3(4u, 7u, 7u));
	var[1][1] = (uvec3(0u, 2u, 9u));
	var[1][2] = (uvec3(4u, 7u, 8u));
	var[2][0] = (uvec3(9u, 4u, 3u));
	var[2][1] = (uvec3(5u, 8u, 0u));
	var[2][2] = (uvec3(5u, 4u, 6u));
	var[3][0] = (uvec3(7u, 7u, 5u));
	var[3][1] = (uvec3(3u, 7u, 0u));
	var[3][2] = (uvec3(8u, 1u, 2u));
}
#version 450
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
	highp mat2x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	var[0][0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	var[0][1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	var[0][1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	var[0][2][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	var[0][2][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	var[1][0][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	var[1][0][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	var[1][1][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	var[1][1][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	var[1][2][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	var[1][2][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	var[2][0][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	var[2][0][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	var[2][1][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	var[2][1][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	var[2][2][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	var[2][2][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	var[3][0][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	var[3][0][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	var[3][1][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	var[3][1][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	var[3][2][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	var[3][2][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
}
#version 450
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
	highp mat3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(3.0, -6.0, -6.0, 5.0, 5.0, -8.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(-6.0, 3.0, -5.0, 0.0, 5.0, 8.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(-1.0, 4.0, -4.0, 9.0, 2.0, 5.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(1.0, -6.0, -4.0, 8.0, -1.0, -9.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(3.0, 8.0, -3.0, -7.0, 6.0, -6.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-9.0, -1.0, -4.0, -4.0, -4.0, 9.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(4.0, -5.0, 6.0, 7.0, -8.0, 2.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(9.0, 7.0, 4.0, 2.0, 8.0, 1.0, -9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(0.0, -6.0, 9.0, 7.0, 3.0, 2.0, -6.0, 6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	var[0][1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	var[0][2] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
	var[1][0] = (mat3(-4.0, 3.0, -8.0, -9.0, 9.0, -7.0, -1.0, -9.0, -9.0));
	var[1][1] = (mat3(-2.0, 7.0, -3.0, 2.0, -6.0, -7.0, 4.0, 8.0, -8.0));
	var[1][2] = (mat3(6.0, 1.0, 9.0, 7.0, -9.0, 5.0, -9.0, 9.0, 1.0));
	var[2][0] = (mat3(8.0, 7.0, -7.0, -4.0, 7.0, -5.0, 8.0, 3.0, -4.0));
	var[2][1] = (mat3(-5.0, 6.0, -1.0, 6.0, -8.0, 1.0, 7.0, 5.0, 7.0));
	var[2][2] = (mat3(1.0, 7.0, -1.0, -8.0, 9.0, -2.0, 7.0, 9.0, -5.0));
	var[3][0] = (mat3(8.0, 7.0, 6.0, -6.0, -1.0, -2.0, 9.0, 6.0, 0.0));
	var[3][1] = (mat3(-4.0, -3.0, -6.0, -5.0, -8.0, -6.0, 5.0, -5.0, 2.0));
	var[3][2] = (mat3(7.0, 5.0, -4.0, 7.0, 9.0, -8.0, -9.0, 8.0, -9.0));
}
#version 450
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
	i16vec3 var[4][3];
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(var[0][0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[0][2]), ivec3(6, -5, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][0]), ivec3(9, 4, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][1]), ivec3(-6, 6, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1][2]), ivec3(2, -1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][0]), ivec3(-1, -4, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][1]), ivec3(2, -8, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2][2]), ivec3(0, -3, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][0]), ivec3(-6, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][1]), ivec3(5, 1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(var[3][2]), ivec3(8, 5, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = i16vec3(ivec3(6, 1, -2));
	var[0][1] = i16vec3(ivec3(-3, -1, -4));
	var[0][2] = i16vec3(ivec3(-2, -2, 2));
	var[1][0] = i16vec3(ivec3(0, -6, -2));
	var[1][1] = i16vec3(ivec3(0, -9, 2));
	var[1][2] = i16vec3(ivec3(-8, 6, 2));
	var[2][0] = i16vec3(ivec3(-5, -4, -8));
	var[2][1] = i16vec3(ivec3(0, 9, 6));
	var[2][2] = i16vec3(ivec3(5, -3, 4));
	var[3][0] = i16vec3(ivec3(-3, 9, 0));
	var[3][1] = i16vec3(ivec3(1, -5, 8));
	var[3][2] = i16vec3(ivec3(-5, 0, 7));
}
#version 450
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
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat2x3(var[0][0], mat2x3(-3.0, -7.0, 1.0, -1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(7.0, -9.0, 1.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-9.0, 1.0, -7.0, -5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(4.0, -5.0, 9.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(-7.0, -3.0, 0.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(-6.0, -8.0, 2.0, 5.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(-1.0, -4.0, -9.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(2.0, -8.0, 9.0, -9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(-8.0, -6.0, 2.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(-2.0, -6.0, 1.0, 1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(7.0, 2.0, 9.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(5.0, 4.0, 1.0, 8.0, 8.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0] = (mat2x3(-7.0, 9.0, -3.0, 0.0, 7.0, 1.0));
	var[0][1] = (mat2x3(-4.0, 1.0, 9.0, 6.0, -4.0, -1.0));
	var[0][2] = (mat2x3(-8.0, 4.0, 7.0, 8.0, 0.0, 9.0));
	var[1][0] = (mat2x3(4.0, 4.0, 2.0, 3.0, 8.0, 4.0));
	var[1][1] = (mat2x3(-5.0, 9.0, 7.0, -1.0, -6.0, -1.0));
	var[1][2] = (mat2x3(6.0, 4.0, 8.0, -3.0, -1.0, -2.0));
	var[2][0] = (mat2x3(5.0, -8.0, 8.0, -1.0, 6.0, -3.0));
	var[2][1] = (mat2x3(-9.0, 9.0, 7.0, 5.0, -8.0, -3.0));
	var[2][2] = (mat2x3(6.0, 2.0, -6.0, -1.0, -2.0, -7.0));
	var[3][0] = (mat2x3(-8.0, 5.0, -5.0, 6.0, 7.0, 5.0));
	var[3][1] = (mat2x3(-7.0, -3.0, -4.0, -1.0, 8.0, -5.0));
	var[3][2] = (mat2x3(9.0, -8.0, 3.0, 3.0, -8.0, -1.0));
}
#version 450
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
	i16vec4 var[4][2][3];
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(var[0][0][0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][0][1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][0][2]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][1][0]), ivec4(3, -5, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][1][1]), ivec4(6, 3, 6, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][1][2]), ivec4(9, -8, -9, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][0][0]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][0][1]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][0][2]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][1][0]), ivec4(-9, -3, -3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][1][1]), ivec4(-7, -4, 3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][1][2]), ivec4(-4, 5, -2, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][0][0]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][0][1]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][0][2]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][1][0]), ivec4(4, -6, 5, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][1][1]), ivec4(5, -2, 3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][1][2]), ivec4(0, 5, -8, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][0][0]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][0][1]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][0][2]), ivec4(4, 8, -6, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][1][0]), ivec4(-6, 7, 7, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][1][1]), ivec4(-5, 7, 3, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][1][2]), ivec4(-4, 7, 8, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i16vec4(ivec4(-4, -8, -4, 9));
	var[0][0][1] = i16vec4(ivec4(2, 7, -4, 4));
	var[0][0][2] = i16vec4(ivec4(8, 9, 5, 1));
	var[0][1][0] = i16vec4(ivec4(7, -1, 8, -5));
	var[0][1][1] = i16vec4(ivec4(-9, -6, -2, -2));
	var[0][1][2] = i16vec4(ivec4(-3, 8, 7, -4));
	var[1][0][0] = i16vec4(ivec4(-3, 3, 8, 7));
	var[1][0][1] = i16vec4(ivec4(2, 6, -9, 9));
	var[1][0][2] = i16vec4(ivec4(-2, 4, -8, -7));
	var[1][1][0] = i16vec4(ivec4(-2, 0, 6, -2));
	var[1][1][1] = i16vec4(ivec4(6, -5, -6, -3));
	var[1][1][2] = i16vec4(ivec4(4, -4, -4, 9));
	var[2][0][0] = i16vec4(ivec4(-9, -1, -8, -1));
	var[2][0][1] = i16vec4(ivec4(-1, -6, 5, 2));
	var[2][0][2] = i16vec4(ivec4(-3, 8, -7, -2));
	var[2][1][0] = i16vec4(ivec4(7, 6, 4, -1));
	var[2][1][1] = i16vec4(ivec4(8, 3, 4, 5));
	var[2][1][2] = i16vec4(ivec4(-3, 5, -8, -5));
	var[3][0][0] = i16vec4(ivec4(9, 7, 6, -9));
	var[3][0][1] = i16vec4(ivec4(5, -3, 8, 5));
	var[3][0][2] = i16vec4(ivec4(-6, -9, -6, 2));
	var[3][1][0] = i16vec4(ivec4(9, 3, -3, 9));
	var[3][1][1] = i16vec4(ivec4(1, -5, 8, -2));
	var[3][1][2] = i16vec4(ivec4(7, -6, -6, 0));
}
#version 450
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
	u16vec3 var[4][2][3];
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(var[0][0][0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][0][1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][0][2]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][1][0]), uvec3(9u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][1][1]), uvec3(9u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][1][2]), uvec3(8u, 5u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][0][0]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][0][1]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][0][2]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][1][0]), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][1][1]), uvec3(8u, 0u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][1][2]), uvec3(2u, 3u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][0][0]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][0][1]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][0][2]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][1][0]), uvec3(6u, 1u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][1][1]), uvec3(5u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][1][2]), uvec3(8u, 8u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][0][0]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][0][1]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][0][2]), uvec3(3u, 6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][1][0]), uvec3(8u, 7u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][1][1]), uvec3(1u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][1][2]), uvec3(3u, 7u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u16vec3(uvec3(1u, 2u, 6u));
	var[0][0][1] = u16vec3(uvec3(8u, 3u, 3u));
	var[0][0][2] = u16vec3(uvec3(4u, 4u, 9u));
	var[0][1][0] = u16vec3(uvec3(1u, 3u, 3u));
	var[0][1][1] = u16vec3(uvec3(0u, 2u, 2u));
	var[0][1][2] = u16vec3(uvec3(7u, 9u, 1u));
	var[1][0][0] = u16vec3(uvec3(7u, 5u, 4u));
	var[1][0][1] = u16vec3(uvec3(5u, 6u, 5u));
	var[1][0][2] = u16vec3(uvec3(7u, 0u, 6u));
	var[1][1][0] = u16vec3(uvec3(2u, 8u, 7u));
	var[1][1][1] = u16vec3(uvec3(9u, 6u, 3u));
	var[1][1][2] = u16vec3(uvec3(2u, 0u, 6u));
	var[2][0][0] = u16vec3(uvec3(4u, 7u, 0u));
	var[2][0][1] = u16vec3(uvec3(4u, 2u, 1u));
	var[2][0][2] = u16vec3(uvec3(0u, 2u, 8u));
	var[2][1][0] = u16vec3(uvec3(6u, 1u, 7u));
	var[2][1][1] = u16vec3(uvec3(6u, 2u, 5u));
	var[2][1][2] = u16vec3(uvec3(3u, 6u, 4u));
	var[3][0][0] = u16vec3(uvec3(0u, 7u, 0u));
	var[3][0][1] = u16vec3(uvec3(2u, 8u, 7u));
	var[3][0][2] = u16vec3(uvec3(1u, 2u, 8u));
	var[3][1][0] = u16vec3(uvec3(6u, 5u, 2u));
	var[3][1][1] = u16vec3(uvec3(3u, 1u, 1u));
	var[3][1][2] = u16vec3(uvec3(7u, 8u, 8u));
}
#version 450
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
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(7.0, -1.0, -4.0, 8.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(7.0, -4.0, -3.0, 4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(-3.0, 3.0, -5.0, -3.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-4.0, 1.0, 0.0, 4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(6.0, -9.0, -3.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(2.0, -7.0, -9.0, 2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-4.0, 7.0, 3.0, -4.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(9.0, -4.0, -9.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(9.0, 2.0, -2.0, -9.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-4.0, 0.0, -4.0, 5.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-6.0, -9.0, 9.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(4.0, -5.0, -9.0, -9.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(6.0, -2.0, 6.0, -7.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(5.0, 8.0, 3.0, 0.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(9.0, -2.0, 3.0, -1.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(0.0, 7.0, -1.0, 9.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(9.0, 4.0, 8.0, -2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(-5.0, 6.0, -8.0, 1.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(4.0, 1.0, -5.0, -2.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(-8.0, -7.0, -8.0, 1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-4.0, 7.0, 3.0, 3.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(4.0, -7.0, -4.0, -4.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(8.0, -8.0, -9.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(-4.0, 9.0, -5.0, -3.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-8.0);
	var[0][0][0][0] = (vec2(-4.0, -3.0));
	var[0][0][0][1] = (vec2(5.0, -9.0));
	var[0][0][0][2] = (vec2(4.0, -2.0));
	var[0][0][1][0] = (vec2(-1.0, 8.0));
	var[0][0][1][1] = (vec2(3.0, 7.0));
	var[0][0][1][2] = (vec2(2.0, -4.0));
	var[0][0][2][0] = (vec2(4.0, 3.0));
	var[0][0][2][1] = (vec2(-6.0, -4.0));
	var[0][0][2][2] = (vec2(3.0, 4.0));
	var[0][1][0][0] = (vec2(6.0, 6.0));
	var[0][1][0][1] = (vec2(1.0, 4.0));
	var[0][1][0][2] = (vec2(-8.0, 2.0));
	var[0][1][1][0] = (vec2(-5.0, -5.0));
	var[0][1][1][1] = (vec2(5.0, 2.0));
	var[0][1][1][2] = (vec2(-1.0, -9.0));
	var[0][1][2][0] = (vec2(3.0, 6.0));
	var[0][1][2][1] = (vec2(5.0, -1.0));
	var[0][1][2][2] = (vec2(-8.0, 2.0));
	var[1][0][0][0] = (vec2(6.0, 3.0));
	var[1][0][0][1] = (vec2(6.0, -2.0));
	var[1][0][0][2] = (vec2(-9.0, -9.0));
	var[1][0][1][0] = (vec2(0.0, -4.0));
	var[1][0][1][1] = (vec2(9.0, -1.0));
	var[1][0][1][2] = (vec2(-1.0, -8.0));
	var[1][0][2][0] = (vec2(6.0, 5.0));
	var[1][0][2][1] = (vec2(-2.0, 1.0));
	var[1][0][2][2] = (vec2(4.0, 2.0));
	var[1][1][0][0] = (vec2(-1.0, 0.0));
	var[1][1][0][1] = (vec2(-2.0, -4.0));
	var[1][1][0][2] = (vec2(6.0, 2.0));
	var[1][1][1][0] = (vec2(-3.0, -2.0));
	var[1][1][1][1] = (vec2(1.0, -3.0));
	var[1][1][1][2] = (vec2(8.0, 5.0));
	var[1][1][2][0] = (vec2(-1.0, -4.0));
	var[1][1][2][1] = (vec2(-4.0, 7.0));
	var[1][1][2][2] = (vec2(-6.0, -2.0));
	var[2][0][0][0] = (vec2(-5.0, -5.0));
	var[2][0][0][1] = (vec2(-9.0, -7.0));
	var[2][0][0][2] = (vec2(3.0, -1.0));
	var[2][0][1][0] = (vec2(0.0, -1.0));
	var[2][0][1][1] = (vec2(4.0, -1.0));
	var[2][0][1][2] = (vec2(-6.0, -8.0));
	var[2][0][2][0] = (vec2(-6.0, 8.0));
	var[2][0][2][1] = (vec2(7.0, 4.0));
	var[2][0][2][2] = (vec2(-9.0, -4.0));
	var[2][1][0][0] = (vec2(-8.0, 0.0));
	var[2][1][0][1] = (vec2(-2.0, 8.0));
	var[2][1][0][2] = (vec2(-2.0, 3.0));
	var[2][1][1][0] = (vec2(7.0, -9.0));
	var[2][1][1][1] = (vec2(-1.0, 5.0));
	var[2][1][1][2] = (vec2(7.0, -5.0));
	var[2][1][2][0] = (vec2(7.0, 6.0));
	var[2][1][2][1] = (vec2(2.0, -4.0));
	var[2][1][2][2] = (vec2(-3.0, -5.0));
	var[3][0][0][0] = (vec2(-1.0, -3.0));
	var[3][0][0][1] = (vec2(-2.0, -5.0));
	var[3][0][0][2] = (vec2(-2.0, -7.0));
	var[3][0][1][0] = (vec2(-3.0, 5.0));
	var[3][0][1][1] = (vec2(4.0, 4.0));
	var[3][0][1][2] = (vec2(1.0, -3.0));
	var[3][0][2][0] = (vec2(-6.0, -4.0));
	var[3][0][2][1] = (vec2(-2.0, -5.0));
	var[3][0][2][2] = (vec2(-7.0, 2.0));
	var[3][1][0][0] = (vec2(2.0, -7.0));
	var[3][1][0][1] = (vec2(8.0, -6.0));
	var[3][1][0][2] = (vec2(3.0, -3.0));
	var[3][1][1][0] = (vec2(-4.0, -5.0));
	var[3][1][1][1] = (vec2(-9.0, -8.0));
	var[3][1][1][2] = (vec2(-7.0, 8.0));
	var[3][1][2][0] = (vec2(-8.0, -2.0));
	var[3][1][2][1] = (vec2(7.0, 5.0));
	var[3][1][2][2] = (vec2(-5.0, -8.0));
}
#version 450
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
	i8vec4 var[4][2][3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967293) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][0][0]), ivec4(4294967289, 4294967295, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][0][1]), ivec4(4294967288, 4294967292, 4294967287, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][0][2]), ivec4(3, 4294967290, 4294967293, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][1][0]), ivec4(4294967294, 4, 2, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][1][1]), ivec4(6, 8, 5, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][1][2]), ivec4(4294967289, 4294967295, 4294967294, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][0][0]), ivec4(4294967292, 4294967291, 4294967289, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][0][1]), ivec4(4294967288, 8, 4294967295, 0)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][0][2]), ivec4(3, 4294967294, 4294967294, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][1][0]), ivec4(4294967287, 4294967292, 4294967295, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][1][1]), ivec4(4294967290, 4294967294, 8, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][1][2]), ivec4(3, 7, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][0][0]), ivec4(4294967295, 4294967292, 6, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][0][1]), ivec4(5, 4294967289, 4294967293, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][0][2]), ivec4(2, 2, 4, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][1][0]), ivec4(4294967291, 5, 4294967294, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][1][1]), ivec4(4294967287, 4294967291, 4294967292, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][1][2]), ivec4(8, 0, 7, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][0][0]), ivec4(9, 4294967287, 1, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][0][1]), ivec4(4294967290, 4294967289, 4294967287, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][0][2]), ivec4(4294967288, 9, 2, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][1][0]), ivec4(4294967288, 3, 4294967292, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][1][1]), ivec4(4294967290, 7, 4294967290, 0)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][1][2]), ivec4(5, 8, 4294967289, 4294967287)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int8_t(4294967294);
	var[0][0][0] = i8vec4(ivec4(4294967292, 4294967290, 4294967289, 4294967291));
	var[0][0][1] = i8vec4(ivec4(4294967291, 4, 4294967290, 4294967295));
	var[0][0][2] = i8vec4(ivec4(4294967287, 4294967293, 8, 6));
	var[0][1][0] = i8vec4(ivec4(4294967293, 4294967290, 4294967290, 8));
	var[0][1][1] = i8vec4(ivec4(4294967289, 4294967292, 2, 4294967295));
	var[0][1][2] = i8vec4(ivec4(9, 4294967295, 6, 6));
	var[1][0][0] = i8vec4(ivec4(4, 9, 4294967287, 4294967295));
	var[1][0][1] = i8vec4(ivec4(4294967292, 4294967287, 3, 9));
	var[1][0][2] = i8vec4(ivec4(4294967288, 4294967290, 4294967287, 8));
	var[1][1][0] = i8vec4(ivec4(4294967289, 4294967293, 4294967289, 6));
	var[1][1][1] = i8vec4(ivec4(7, 5, 5, 4294967291));
	var[1][1][2] = i8vec4(ivec4(4, 3, 4294967290, 1));
	var[2][0][0] = i8vec4(ivec4(5, 4, 5, 5));
	var[2][0][1] = i8vec4(ivec4(4294967289, 4294967287, 4294967294, 4294967291));
	var[2][0][2] = i8vec4(ivec4(4294967291, 4, 5, 4294967293));
	var[2][1][0] = i8vec4(ivec4(0, 5, 0, 4294967293));
	var[2][1][1] = i8vec4(ivec4(0, 4294967294, 6, 6));
	var[2][1][2] = i8vec4(ivec4(1, 0, 2, 6));
	var[3][0][0] = i8vec4(ivec4(4294967294, 4294967289, 4294967291, 2));
	var[3][0][1] = i8vec4(ivec4(5, 4, 6, 4294967292));
	var[3][0][2] = i8vec4(ivec4(7, 8, 9, 3));
	var[3][1][0] = i8vec4(ivec4(1, 9, 4294967291, 4294967295));
	var[3][1][1] = i8vec4(ivec4(0, 3, 9, 2));
	var[3][1][2] = i8vec4(ivec4(7, 7, 4294967293, 4294967290));
}
#version 450
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
	u16vec3 var[4][2][3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 1u) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][0][0]), uvec3(0u, 5u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][0][1]), uvec3(0u, 0u, 7u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][0][2]), uvec3(1u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][1][0]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][1][1]), uvec3(1u, 4u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][1][2]), uvec3(5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][0][0]), uvec3(4u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][0][1]), uvec3(7u, 2u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][0][2]), uvec3(0u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][1][0]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][1][1]), uvec3(0u, 6u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][1][2]), uvec3(3u, 6u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][0][0]), uvec3(8u, 6u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][0][1]), uvec3(6u, 1u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][0][2]), uvec3(3u, 9u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][1][0]), uvec3(1u, 8u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][1][1]), uvec3(4u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][1][2]), uvec3(8u, 1u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][0][0]), uvec3(0u, 9u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][0][1]), uvec3(3u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][0][2]), uvec3(6u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][1][0]), uvec3(7u, 0u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][1][1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][1][2]), uvec3(7u, 2u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint16_t(1u);
	var[0][0][0] = u16vec3(uvec3(2u, 6u, 8u));
	var[0][0][1] = u16vec3(uvec3(3u, 3u, 4u));
	var[0][0][2] = u16vec3(uvec3(4u, 9u, 7u));
	var[0][1][0] = u16vec3(uvec3(3u, 3u, 0u));
	var[0][1][1] = u16vec3(uvec3(2u, 2u, 7u));
	var[0][1][2] = u16vec3(uvec3(9u, 1u, 2u));
	var[1][0][0] = u16vec3(uvec3(5u, 4u, 5u));
	var[1][0][1] = u16vec3(uvec3(6u, 5u, 7u));
	var[1][0][2] = u16vec3(uvec3(0u, 6u, 4u));
	var[1][1][0] = u16vec3(uvec3(8u, 7u, 9u));
	var[1][1][1] = u16vec3(uvec3(6u, 3u, 2u));
	var[1][1][2] = u16vec3(uvec3(0u, 6u, 6u));
	var[2][0][0] = u16vec3(uvec3(7u, 0u, 4u));
	var[2][0][1] = u16vec3(uvec3(2u, 1u, 0u));
	var[2][0][2] = u16vec3(uvec3(2u, 8u, 0u));
	var[2][1][0] = u16vec3(uvec3(1u, 7u, 6u));
	var[2][1][1] = u16vec3(uvec3(2u, 5u, 3u));
	var[2][1][2] = u16vec3(uvec3(6u, 4u, 6u));
	var[3][0][0] = u16vec3(uvec3(7u, 0u, 2u));
	var[3][0][1] = u16vec3(uvec3(8u, 7u, 1u));
	var[3][0][2] = u16vec3(uvec3(2u, 8u, 1u));
	var[3][1][0] = u16vec3(uvec3(5u, 2u, 3u));
	var[3][1][1] = u16vec3(uvec3(1u, 1u, 7u));
	var[3][1][2] = u16vec3(uvec3(8u, 8u, 4u));
}
#version 450
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
	i16vec2 var[4][2][3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), 3) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][0][0]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][0][1]), ivec2(-3, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][0][2]), ivec2(2, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][1][0]), ivec2(2, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][1][1]), ivec2(-4, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[0][1][2]), ivec2(-2, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][0][0]), ivec2(-3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][0][1]), ivec2(-9, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][0][2]), ivec2(-7, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][1][0]), ivec2(0, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][1][1]), ivec2(-5, -8)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1][1][2]), ivec2(-1, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][0][0]), ivec2(-3, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][0][1]), ivec2(6, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][0][2]), ivec2(8, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][1][0]), ivec2(-8, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][1][1]), ivec2(7, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2][1][2]), ivec2(-4, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][0][0]), ivec2(1, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][0][1]), ivec2(-6, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][0][2]), ivec2(1, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][1][0]), ivec2(-1, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][1][1]), ivec2(-3, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3][1][2]), ivec2(6, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int16_t(6);
	var[0][0][0] = i16vec2(ivec2(-2, -2));
	var[0][0][1] = i16vec2(ivec2(-8, 3));
	var[0][0][2] = i16vec2(ivec2(5, -9));
	var[0][1][0] = i16vec2(ivec2(9, 0));
	var[0][1][1] = i16vec2(ivec2(9, 0));
	var[0][1][2] = i16vec2(ivec2(5, 9));
	var[1][0][0] = i16vec2(ivec2(-9, -4));
	var[1][0][1] = i16vec2(ivec2(-3, -2));
	var[1][0][2] = i16vec2(ivec2(6, 0));
	var[1][1][0] = i16vec2(ivec2(-8, 4));
	var[1][1][1] = i16vec2(ivec2(6, -9));
	var[1][1][2] = i16vec2(ivec2(-9, 4));
	var[2][0][0] = i16vec2(ivec2(-1, 3));
	var[2][0][1] = i16vec2(ivec2(-9, 9));
	var[2][0][2] = i16vec2(ivec2(-6, -1));
	var[2][1][0] = i16vec2(ivec2(1, -5));
	var[2][1][1] = i16vec2(ivec2(-1, 4));
	var[2][1][2] = i16vec2(ivec2(-5, -6));
	var[3][0][0] = i16vec2(ivec2(-7, -1));
	var[3][0][1] = i16vec2(ivec2(-6, 6));
	var[3][0][2] = i16vec2(ivec2(5, 6));
	var[3][1][0] = i16vec2(ivec2(1, -8));
	var[3][1][1] = i16vec2(ivec2(4, -6));
	var[3][1][2] = i16vec2(ivec2(1, 8));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
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
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(8.0, -5.0, -3.0, -5.0, 3.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(-3.0, 9.0, 0.0, 7.0, 9.0, -6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(6.0, 1.0, -3.0, -1.0, -3.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(2.0, 4.0, -4.0, 9.0, 9.0, 7.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(-9.0, 3.0, -7.0, -8.0, 7.0, -1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(-7.0, 0.0, -1.0, -5.0, 7.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(5.0, -9.0, -2.0, 8.0, 7.0, 0.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(8.0, -9.0, -2.0, -7.0, 6.0, -6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(-2.0, 4.0, 6.0, -4.0, 1.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(9.0, 0.0, 1.0, -9.0, -5.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(4.0, -2.0, -9.0, 4.0, 9.0, 1.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(6.0, 9.0, 2.0, 5.0, -9.0, -3.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	var[0][0][1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	var[0][1][0] = (mat4x2(1.0, -9.0, 0.0, -4.0, 2.0, 9.0, -5.0, -3.0));
	var[0][1][1] = (mat4x2(6.0, -4.0, -9.0, 5.0, -5.0, -6.0, 8.0, -5.0));
	var[0][2][0] = (mat4x2(-7.0, 4.0, -8.0, -6.0, -3.0, -4.0, 8.0, -4.0));
	var[0][2][1] = (mat4x2(6.0, -9.0, -7.0, -3.0, -9.0, -6.0, -3.0, -8.0));
	var[0][3][0] = (mat4x2(4.0, -8.0, -6.0, -3.0, 8.0, -1.0, -5.0, 5.0));
	var[0][3][1] = (mat4x2(1.0, 9.0, -4.0, -5.0, 1.0, -2.0, 7.0, 1.0));
	var[1][0][0] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
	var[1][0][1] = (mat4x2(-5.0, -9.0, -1.0, -9.0, 0.0, -4.0, 2.0, -7.0));
	var[1][1][0] = (mat4x2(-4.0, -5.0, 6.0, 9.0, -3.0, -4.0, 3.0, -7.0));
	var[1][1][1] = (mat4x2(-8.0, 8.0, -4.0, -6.0, 0.0, -3.0, -6.0, -4.0));
	var[1][2][0] = (mat4x2(8.0, -4.0, -8.0, 4.0, 0.0, 4.0, -3.0, 8.0));
	var[1][2][1] = (mat4x2(0.0, 7.0, -2.0, -3.0, -5.0, 6.0, -2.0, 7.0));
	var[1][3][0] = (mat4x2(-3.0, -1.0, 4.0, 9.0, 6.0, 3.0, -9.0, 2.0));
	var[1][3][1] = (mat4x2(-3.0, 9.0, 7.0, -5.0, -4.0, 0.0, -9.0, 9.0));
	var[2][0][0] = (mat4x2(-3.0, -5.0, 1.0, -5.0, -1.0, 7.0, 4.0, 4.0));
	var[2][0][1] = (mat4x2(-5.0, 2.0, -4.0, -3.0, 0.0, 4.0, -7.0, 5.0));
	var[2][1][0] = (mat4x2(5.0, 4.0, 5.0, 7.0, 2.0, -7.0, 8.0, -3.0));
	var[2][1][1] = (mat4x2(8.0, 7.0, 0.0, -5.0, 4.0, 5.0, -6.0, -8.0));
	var[2][2][0] = (mat4x2(4.0, -1.0, 6.0, -2.0, 0.0, 7.0, 0.0, 2.0));
	var[2][2][1] = (mat4x2(-7.0, -7.0, -6.0, 8.0, -7.0, -4.0, 9.0, 9.0));
	var[2][3][0] = (mat4x2(6.0, 8.0, -4.0, -2.0, -7.0, -7.0, -4.0, 9.0));
	var[2][3][1] = (mat4x2(6.0, 7.0, -4.0, 6.0, -5.0, -4.0, 7.0, -1.0));
}
#version 450
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
	int16_t var[][4][2];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(var[0][0][0]), -5) && allOk;
	allOk = compare_int16_t(int(var[0][0][1]), 1) && allOk;
	allOk = compare_int16_t(int(var[0][1][0]), -8) && allOk;
	allOk = compare_int16_t(int(var[0][1][1]), 6) && allOk;
	allOk = compare_int16_t(int(var[0][2][0]), 9) && allOk;
	allOk = compare_int16_t(int(var[0][2][1]), 5) && allOk;
	allOk = compare_int16_t(int(var[0][3][0]), 1) && allOk;
	allOk = compare_int16_t(int(var[0][3][1]), -9) && allOk;
	allOk = compare_int16_t(int(var[1][0][0]), 8) && allOk;
	allOk = compare_int16_t(int(var[1][0][1]), -2) && allOk;
	allOk = compare_int16_t(int(var[1][1][0]), 3) && allOk;
	allOk = compare_int16_t(int(var[1][1][1]), -8) && allOk;
	allOk = compare_int16_t(int(var[1][2][0]), 9) && allOk;
	allOk = compare_int16_t(int(var[1][2][1]), -3) && allOk;
	allOk = compare_int16_t(int(var[1][3][0]), -7) && allOk;
	allOk = compare_int16_t(int(var[1][3][1]), 8) && allOk;
	allOk = compare_int16_t(int(var[2][0][0]), 9) && allOk;
	allOk = compare_int16_t(int(var[2][0][1]), -5) && allOk;
	allOk = compare_int16_t(int(var[2][1][0]), 6) && allOk;
	allOk = compare_int16_t(int(var[2][1][1]), -7) && allOk;
	allOk = compare_int16_t(int(var[2][2][0]), -1) && allOk;
	allOk = compare_int16_t(int(var[2][2][1]), -2) && allOk;
	allOk = compare_int16_t(int(var[2][3][0]), 8) && allOk;
	allOk = compare_int16_t(int(var[2][3][1]), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = int16_t(6);
	var[0][0][1] = int16_t(8);
	var[0][1][0] = int16_t(-5);
	var[0][1][1] = int16_t(-8);
	var[0][2][0] = int16_t(3);
	var[0][2][1] = int16_t(9);
	var[0][3][0] = int16_t(7);
	var[0][3][1] = int16_t(7);
	var[1][0][0] = int16_t(-2);
	var[1][0][1] = int16_t(-4);
	var[1][1][0] = int16_t(-3);
	var[1][1][1] = int16_t(2);
	var[1][2][0] = int16_t(6);
	var[1][2][1] = int16_t(2);
	var[1][3][0] = int16_t(1);
	var[1][3][1] = int16_t(-9);
	var[2][0][0] = int16_t(-3);
	var[2][0][1] = int16_t(9);
	var[2][1][0] = int16_t(-1);
	var[2][1][1] = int16_t(4);
	var[2][2][0] = int16_t(3);
	var[2][2][1] = int16_t(7);
	var[2][3][0] = int16_t(-3);
	var[2][3][1] = int16_t(0);
}
#version 450
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
	allOk = compare_ivec3((s[0].a), ivec3(7, -6, 5)) && allOk;
	allOk = compare_mat3(s[0].b[0], mat3(3.0, -1.0, 8.0, 6.0, -9.0, -6.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(s[0].b[1], mat3(3.0, -1.0, 0.0, -4.0, 7.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3(s[0].b[2], mat3(2.0, 6.0, -8.0, 2.0, 1.0, 5.0, -2.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(s[0].b[3], mat3(4.0, 0.0, 7.0, 7.0, 8.0, 9.0, 9.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec4((s[0].c), vec4(-8.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_ivec3((s[1].a), ivec3(5, 2, -3)) && allOk;
	allOk = compare_mat3(s[1].b[0], mat3(-7.0, -7.0, 6.0, 9.0, -5.0, 2.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(s[1].b[1], mat3(-4.0, 7.0, 8.0, -9.0, 4.0, 7.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(s[1].b[2], mat3(9.0, -5.0, -8.0, 0.0, -2.0, 6.0, 8.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(s[1].b[3], mat3(-2.0, -4.0, 1.0, 3.0, -6.0, -1.0, 3.0, -9.0, 6.0)) && allOk;
	allOk = compare_vec4((s[1].c), vec4(-9.0, 1.0, -1.0, 3.0)) && allOk;
	allOk = compare_ivec3((s[2].a), ivec3(7, 6, 5)) && allOk;
	allOk = compare_mat3(s[2].b[0], mat3(4.0, 6.0, 9.0, 5.0, 9.0, -7.0, -8.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3(s[2].b[1], mat3(-1.0, 1.0, 3.0, 9.0, -8.0, -6.0, 4.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3(s[2].b[2], mat3(-3.0, 4.0, 4.0, 8.0, 6.0, -6.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(s[2].b[3], mat3(-7.0, -5.0, 4.0, -9.0, 0.0, 5.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_vec4((s[2].c), vec4(2.0, 4.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s[0].a = (ivec3(7, -4, -7));
	s[0].b[0] = (mat3(-5.0, 3.0, -9.0, 6.0, 9.0, 2.0, -1.0, -2.0, 5.0));
	s[0].b[1] = (mat3(9.0, -5.0, -8.0, -7.0, -6.0, -9.0, 0.0, 9.0, -1.0));
	s[0].b[2] = (mat3(1.0, -8.0, 9.0, 7.0, 8.0, -1.0, 0.0, 7.0, -1.0));
	s[0].b[3] = (mat3(-6.0, -7.0, 7.0, 6.0, 8.0, 2.0, -4.0, 5.0, 4.0));
	s[0].c = (vec4(-7.0, 6.0, -4.0, 9.0));
	s[1].a = (ivec3(3, 2, 8));
	s[1].b[0] = (mat3(1.0, -4.0, -8.0, 4.0, -2.0, 3.0, -8.0, -4.0, -3.0));
	s[1].b[1] = (mat3(-7.0, 1.0, -1.0, 4.0, 0.0, -5.0, 8.0, -1.0, 3.0));
	s[1].b[2] = (mat3(-9.0, 4.0, 4.0, -5.0, -1.0, 9.0, 5.0, 4.0, -5.0));
	s[1].b[3] = (mat3(9.0, -4.0, 7.0, -8.0, -6.0, 4.0, 5.0, -3.0, 3.0));
	s[1].c = (vec4(-8.0, 9.0, -7.0, -3.0));
	s[2].a = (ivec3(2, -9, 5));
	s[2].b[0] = (mat3(5.0, 4.0, -6.0, -4.0, -2.0, -6.0, 4.0, 5.0, -8.0));
	s[2].b[1] = (mat3(-8.0, 6.0, -2.0, -6.0, 3.0, -4.0, -1.0, -1.0, -9.0));
	s[2].b[2] = (mat3(1.0, 8.0, 2.0, 0.0, 4.0, -8.0, 1.0, -9.0, -1.0));
	s[2].b[3] = (mat3(-7.0, -2.0, -6.0, -2.0, -3.0, 4.0, 9.0, -1.0, 3.0));
	s[2].c = (vec4(-9.0, 4.0, 9.0, -5.0));
	v = (vec4(-3.0, -3.0, 0.0, 0.0));
}
#version 450
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
	allOk = compare_mat3(block[0].t[0].a, mat3(-4.0, -9.0, 0.0, -8.0, -1.0, -4.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(3, -2, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(8, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(1, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(1, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(-7, 4)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(1.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(4, 4, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(4, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(-8, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(-3, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(-8, -8)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(6.0, -6.0, 2.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(-5, -8, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(-2, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(-1, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(-6, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(3, 7)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(6.0, -8.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(-6.0, -5.0, -6.0, 7.0, -1.0, -7.0, 9.0, 0.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(-8, 1, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(2, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(1, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(-1, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(3, -4)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(4.0, 3.0, 8.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(6, -6, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(9, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(2, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(3, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(3, 9)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(7.0, -6.0, -7.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(5, -9, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(2, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(-5, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(-3, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(-6, -7)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-5.0, -6.0, -4.0, -7.0)) && allOk;
	allOk = compare_uint((block[0].u), 1u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(7.0, 2.0, 6.0, 4.0, -1.0, -7.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(3, 9, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(-1, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(1, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(4, -8)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-4.0, 9.0, 7.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(1, 2, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(7, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(-4, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(5, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(7, -9)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(2.0, 3.0, -3.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(-9, 5, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(-5, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(5, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(-2, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(-8, -7)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-7.0, 0.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(-4.0, 1.0, 6.0, 1.0, -8.0, -1.0, -5.0, 3.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(1, 1, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(4, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(-2, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(-9, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(4, -5)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(-7.0, -5.0, 1.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(3, 4, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(9, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(1, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(8, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(-2, -4)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(2.0, 6.0, 4.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(5, 3, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(-1, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(-6, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(2, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(-2, 0)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(8.0, 8.0, -6.0, 5.0)) && allOk;
	allOk = compare_uint((block[1].u), 7u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(-5.0, 0.0, -6.0, 5.0, -4.0, -5.0, 6.0, 1.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(5, -9, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(-1, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(8, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(3, -3)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-3.0, 1.0, -9.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(7, -7, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(1, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(4, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(-8, -5)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-5.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(-4, 7, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(-6, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(5, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(-2, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(-3, -3)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(-7.0, -2.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(-6.0, -6.0, 8.0, -2.0, 2.0, 6.0, -7.0, 6.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(-6, -5, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(2, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(-7, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(9, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(9, 4)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(-4.0, 2.0, -9.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(-4, 3, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(6, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(4, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(-8, 5)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(3.0, 7.0, -2.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(-3, -3, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(-1, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(-7, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(7, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(3, 6)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(-3.0, -1.0, 6.0, -6.0)) && allOk;
	allOk = compare_uint((block[2].u), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-2, -2, 5));
	block[0].s.b[0] = (ivec2(6, -1));
	block[0].s.b[1] = (ivec2(-7, 3));
	block[0].s.b[2] = (ivec2(2, -9));
	block[0].s.b[3] = (ivec2(-5, 6));
	block[0].s.c = (vec4(-7.0, 7.0, 4.0, -9.0));
	block[0].u = (5u);
	block[1].s.a = (ivec3(4, 4, 9));
	block[1].s.b[0] = (ivec2(-3, 1));
	block[1].s.b[1] = (ivec2(9, -9));
	block[1].s.b[2] = (ivec2(-4, -9));
	block[1].s.b[3] = (ivec2(-5, 1));
	block[1].s.c = (vec4(4.0, -6.0, 7.0, -7.0));
	block[1].u = (3u);
	block[2].s.a = (ivec3(-7, -4, 0));
	block[2].s.b[0] = (ivec2(6, -2));
	block[2].s.b[1] = (ivec2(6, 5));
	block[2].s.b[2] = (ivec2(7, -1));
	block[2].s.b[3] = (ivec2(9, 7));
	block[2].s.c = (vec4(3.0, 0.0, -3.0, 0.0));
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
	allOk = compare_mat3(block[0].t[0].a, mat3(-3.0, -3.0, 9.0, -9.0, -8.0, -6.0, -4.0, 6.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(3, -7, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(-6, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(-5, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(-2, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(-4, -3)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-3.0, -4.0, 9.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(-6, 4, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(-6, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(8, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(3, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(5, 5)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(4.0, 6.0, -6.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(7, -9, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(-7, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(0, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(8, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(-1, 9)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(1.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(-4.0, 1.0, -9.0, -8.0, 5.0, -7.0, -9.0, 6.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(-7, -5, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(-9, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(8, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(5, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(-2, 5)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(8.0, -8.0, -8.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(6, 2, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(-1, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(-8, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(-8, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(5, -4)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(6.0, 1.0, -6.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(-2, -1, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(9, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(-9, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(6, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(3, 2)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(5.0, -3.0, 1.0, -4.0)) && allOk;
	allOk = compare_uint((block[0].u), 5u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(-1.0, -4.0, -2.0, -9.0, 8.0, -9.0, 0.0, -9.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(-6, -6, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(-5, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(1, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(-9, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(-9, 4)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-6.0, 6.0, 8.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(-3, 4, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(9, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(9, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(-3, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(5, 9)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(3.0, 5.0, -9.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(8, -2, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(-1, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(6, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(0, 9)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-7.0, 6.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(6.0, 2.0, -5.0, 3.0, -2.0, 8.0, -5.0, -3.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(-2, 8, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(-3, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(-6, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(3, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(-9, -7)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(0.0, -5.0, -8.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(6, -5, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(9, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(5, -5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(6, 7)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(-9.0, -1.0, 0.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(4, -2, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(9, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(-6, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(3, 9)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(-7.0, -5.0, 4.0, -9.0)) && allOk;
	allOk = compare_uint((block[1].u), 8u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(0.0, -2.0, 4.0, -9.0, -1.0, -5.0, 3.0, -5.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(-6, 9, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(0, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(9, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(-4, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(-2, 1)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(4.0, 5.0, 7.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(-2, -8, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(-5, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(-1, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-4, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(0, -4)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(1.0, 9.0, 5.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(0, -8, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(3, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(2, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(5, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(-5, -5)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(-1.0, -7.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(5.0, -7.0, 2.0, -1.0, -6.0, 3.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(7, 8, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(-9, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(-1, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(-9, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(2, -7)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(5.0, 1.0, 7.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(-4, 3, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(8, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(6, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(-1, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(-2, 1)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(2.0, -8.0, -7.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(-5, -8, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(5, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(6, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(6, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(-4, -6)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(3.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_uint((block[2].u), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-7, -8, 2));
	block[0].s.b[0] = (ivec2(3, -5));
	block[0].s.b[1] = (ivec2(3, -3));
	block[0].s.b[2] = (ivec2(5, -6));
	block[0].s.b[3] = (ivec2(-6, -1));
	block[0].s.c = (vec4(-4.0, -1.0, -5.0, -1.0));
	block[0].u = (6u);
	block[1].s.a = (ivec3(-6, -6, -6));
	block[1].s.b[0] = (ivec2(3, 5));
	block[1].s.b[1] = (ivec2(-7, -2));
	block[1].s.b[2] = (ivec2(0, -4));
	block[1].s.b[3] = (ivec2(3, 2));
	block[1].s.c = (vec4(3.0, 3.0, 6.0, 5.0));
	block[1].u = (7u);
	block[2].s.a = (ivec3(1, 1, -3));
	block[2].s.b[0] = (ivec2(8, 1));
	block[2].s.b[1] = (ivec2(-3, 3));
	block[2].s.b[2] = (ivec2(3, 1));
	block[2].s.b[3] = (ivec2(5, -9));
	block[2].s.c = (vec4(7.0, 8.0, -3.0, 7.0));
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
	highp uvec2 a;
	mediump mat2x4 b[4];
	highp vec3 c;
};
layout(std140, binding = 1) buffer Block
{
	lowp vec2 u;
	mediump uint v;
	S s[];
} block[3];

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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(3u, 5u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(3.0, -8.0, -7.0, 7.0, -2.0, -2.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(0.0, -8.0, -1.0, -4.0, 7.0, -8.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(-5.0, -6.0, 7.0, -1.0, -7.0, 9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(3.0, -2.0, -2.0, -8.0, 1.0, -6.0, 8.0, 1.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(3.0, 9.0, -3.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(3u, 4u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(1.0, -8.0, 1.0, 8.0, -7.0, 4.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(1.0, 2.0, -1.0, 2.0, 3.0, -4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(-3.0, -4.0, 4.0, 3.0, 8.0, 7.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(-4.0, 6.0, -6.0, 6.0, 4.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(-5.0, 7.0, 2.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(4u, 6u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(-3.0, -6.0, -8.0, -8.0, 9.0, -7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(3.0, 7.0, 3.0, 9.0, 6.0, -6.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(7.0, -6.0, -7.0, 2.0, -5.0, -8.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(-9.0, 1.0, -2.0, -1.0, -1.0, 7.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(6.0, 4.0, -1.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(2u, 4u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(3.0, 7.0, 2.0, -1.0, -5.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(-6.0, -7.0, 6.0, -8.0, -8.0, 8.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(-4.0, -7.0, -4.0, 9.0, 7.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(-2.0, 2.0, 1.0, 2.0, 8.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(-7.0, -1.0, 8.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(8u, 9u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(9.0, 0.0, 1.0, 1.0, 3.0, -1.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(5.0, 1.0, 0.0, 4.0, -8.0, 4.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(-3.0, -9.0, -4.0, 4.0, -5.0, -4.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(-6.0, -7.0, -5.0, 1.0, 0.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(-6.0, -5.0, -8.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(0u, 0u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(3.0, 4.0, -7.0, 7.0, -7.0, -4.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(-3.0, 7.0, -9.0, 9.0, 3.0, 1.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(0.0, -2.0, -4.0, 2.0, 3.0, -3.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(6.0, 4.0, 6.0, -9.0, 5.0, 1.0, 5.0, 3.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(-1.0, -5.0, 8.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(0u, 6u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(-6.0, -5.0, -1.0, 5.0, -7.0, -2.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(-7.0, -1.0, 2.0, -6.0, 0.0, 2.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(0.0, -7.0, 0.0, -8.0, 0.0, 8.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(5.0, 6.0, -2.0, 6.0, 4.0, -1.0, 2.0, -2.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(2.0, 0.0, 8.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(6u, 6u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(1.0, 9.0, 7.0, 9.0, -2.0, 7.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(-3.0, -6.0, -2.0, -5.0, 0.0, -6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(-5.0, 6.0, 1.0, 9.0, -6.0, -6.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(2.0, 6.0, -7.0, 6.0, -3.0, 5.0, -9.0, -3.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(3.0, -3.0, 2.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(1u, 1u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(-9.0, -9.0, -4.0, 2.0, -9.0, 9.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(-2.0, -4.0, 3.0, 3.0, -8.0, 8.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(4.0, -5.0, -8.0, -5.0, -2.0, -6.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(4.0, 3.0, -8.0, 5.0, -5.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(-6.0, 2.0, -4.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(9u, 2u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(3.0, 7.0, -2.0, -6.0, -4.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(-3.0, -3.0, -6.0, 6.0, 5.0, -5.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(-3.0, -3.0, -1.0, 8.0, -7.0, 9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(3.0, 6.0, -7.0, -2.0, 5.0, 9.0, -3.0, -1.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(9.0, 4.0, 5.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(2u, 6u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(6.0, -6.0, -9.0, -6.0, 9.0, 6.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(-3.0, 7.0, 7.0, -3.0, 7.0, 6.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(-5.0, 7.0, 1.0, 1.0, -8.0, -5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(5.0, -7.0, -9.0, 0.0, -4.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(-8.0, -7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (7u);
	block[0].s[0].a = (uvec2(9u, 1u));
	block[0].s[0].b[0] = (mat2x4(-7.0, 7.0, 4.0, -9.0, -4.0, 2.0, -4.0, -6.0));
	block[0].s[0].b[1] = (mat2x4(-7.0, -6.0, -8.0, 3.0, 1.0, -8.0, 3.0, 1.0));
	block[0].s[0].b[2] = (mat2x4(8.0, -4.0, 1.0, -2.0, -2.0, 0.0, -3.0, -5.0));
	block[0].s[0].b[3] = (mat2x4(-6.0, 4.0, 4.0, 0.0, 6.0, -4.0, -1.0, -2.0));
	block[0].s[0].c = (vec3(7.0, -7.0, 1.0));
	block[0].s[1].a = (uvec2(3u, 3u));
	block[0].s[1].b[0] = (mat2x4(3.0, 0.0, -5.0, -5.0, 6.0, -7.0, 5.0, 1.0));
	block[0].s[1].b[1] = (mat2x4(-5.0, 1.0, -5.0, 6.0, -3.0, 0.0, 6.0, -2.0));
	block[0].s[1].b[2] = (mat2x4(-6.0, -5.0, -6.0, -1.0, 6.0, 8.0, -7.0, -9.0));
	block[0].s[1].b[3] = (mat2x4(0.0, 2.0, 1.0, 9.0, -3.0, 5.0, 3.0, -8.0));
	block[0].s[1].c = (vec3(-5.0, -3.0, -1.0));
	block[0].s[2].a = (uvec2(4u, 9u));
	block[0].s[2].b[0] = (mat2x4(3.0, 0.0, 7.0, 6.0, 3.0, 7.0, -4.0, -5.0));
	block[0].s[2].b[1] = (mat2x4(-9.0, -2.0, 1.0, 3.0, -3.0, -3.0, 1.0, -4.0));
	block[0].s[2].b[2] = (mat2x4(0.0, 5.0, -9.0, 1.0, -4.0, -7.0, 6.0, 7.0));
	block[0].s[2].b[3] = (mat2x4(0.0, -8.0, -2.0, 0.0, 5.0, -3.0, -1.0, -3.0));
	block[0].s[2].c = (vec3(3.0, 1.0, 1.0));
	block[0].s[3].a = (uvec2(8u, 5u));
	block[0].s[3].b[0] = (mat2x4(7.0, 1.0, -1.0, -4.0, -5.0, 0.0, 4.0, 0.0));
	block[0].s[3].b[1] = (mat2x4(3.0, -2.0, -5.0, -7.0, -1.0, 9.0, -8.0, -2.0));
	block[0].s[3].b[2] = (mat2x4(-8.0, -6.0, 7.0, 4.0, 4.0, 9.0, -3.0, 1.0));
	block[0].s[3].b[3] = (mat2x4(9.0, -9.0, -4.0, -9.0, -5.0, 1.0, 4.0, -6.0));
	block[0].s[3].c = (vec3(-8.0, -1.0, 9.0));
	block[1].v = (0u);
	block[1].s[0].a = (uvec2(6u, 3u));
	block[1].s[0].b[0] = (mat2x4(-9.0, 2.0, -6.0, -2.0, -8.0, 0.0, -1.0, -4.0));
	block[1].s[0].b[1] = (mat2x4(-9.0, 3.0, 7.0, -8.0, -9.0, -1.0, -3.0, 5.0));
	block[1].s[0].b[2] = (mat2x4(-1.0, -8.0, 7.0, -5.0, 4.0, -4.0, -1.0, -4.0));
	block[1].s[0].b[3] = (mat2x4(8.0, 6.0, 6.0, 1.0, -8.0, 3.0, -3.0, -1.0));
	block[1].s[0].c = (vec3(4.0, 3.0, -9.0));
	block[1].s[1].a = (uvec2(4u, 3u));
	block[1].s[1].b[0] = (mat2x4(-8.0, -9.0, 9.0, 0.0, -2.0, -2.0, 0.0, 4.0));
	block[1].s[1].b[1] = (mat2x4(-6.0, -1.0, -4.0, -3.0, -8.0, 5.0, -9.0, -6.0));
	block[1].s[1].b[2] = (mat2x4(5.0, 9.0, -2.0, -6.0, -8.0, 7.0, -1.0, 3.0));
	block[1].s[1].b[3] = (mat2x4(3.0, -3.0, -1.0, 9.0, -7.0, 4.0, 9.0, 4.0));
	block[1].s[1].c = (vec3(6.0, 3.0, -9.0));
	block[1].s[2].a = (uvec2(9u, 1u));
	block[1].s[2].b[0] = (mat2x4(-4.0, 8.0, 6.0, 5.0, -1.0, -1.0, 1.0, 0.0));
	block[1].s[2].b[1] = (mat2x4(0.0, 6.0, 6.0, 7.0, 5.0, 4.0, 1.0, -9.0));
	block[1].s[2].b[2] = (mat2x4(9.0, 3.0, -6.0, 3.0, -8.0, -3.0, 3.0, 4.0));
	block[1].s[2].b[3] = (mat2x4(9.0, 7.0, -7.0, -4.0, 0.0, 6.0, -2.0, 6.0));
	block[1].s[2].c = (vec3(4.0, 0.0, -6.0));
	block[1].s[3].a = (uvec2(7u, 2u));
	block[1].s[3].b[0] = (mat2x4(5.0, 7.0, -1.0, 9.0, 7.0, 3.0, 0.0, -3.0));
	block[1].s[3].b[1] = (mat2x4(0.0, 1.0, -8.0, -7.0, 3.0, -5.0, 9.0, 9.0));
	block[1].s[3].b[2] = (mat2x4(2.0, 7.0, 4.0, 6.0, 5.0, -4.0, -9.0, 1.0));
	block[1].s[3].b[3] = (mat2x4(-4.0, -1.0, 0.0, 9.0, -2.0, 6.0, 8.0, 5.0));
	block[1].s[3].c = (vec3(-3.0, -1.0, 7.0));
	block[2].v = (2u);
	block[2].s[0].a = (uvec2(9u, 2u));
	block[2].s[0].b[0] = (mat2x4(-3.0, 3.0, -6.0, 3.0, 8.0, -6.0, 9.0, 0.0));
	block[2].s[0].b[1] = (mat2x4(1.0, 1.0, 7.0, 2.0, 6.0, -9.0, 5.0, 3.0));
	block[2].s[0].b[2] = (mat2x4(-8.0, -6.0, 2.0, 5.0, 7.0, -8.0, 1.0, 4.0));
	block[2].s[0].b[3] = (mat2x4(-3.0, 8.0, 8.0, 0.0, -8.0, -9.0, -4.0, -7.0));
	block[2].s[0].c = (vec3(-7.0, 3.0, 6.0));
	block[2].s[1].a = (uvec2(1u, 7u));
	block[2].s[1].b[0] = (mat2x4(-5.0, -4.0, 0.0, -4.0, -1.0, 0.0, 4.0, -6.0));
	block[2].s[1].b[1] = (mat2x4(-3.0, 7.0, -5.0, 0.0, -8.0, -8.0, 1.0, 0.0));
	block[2].s[1].b[2] = (mat2x4(6.0, -5.0, 2.0, 3.0, -2.0, 4.0, -3.0, 2.0));
	block[2].s[1].b[3] = (mat2x4(1.0, 5.0, 8.0, 8.0, 8.0, 5.0, -2.0, -6.0));
	block[2].s[1].c = (vec3(8.0, 9.0, 3.0));
	block[2].s[2].a = (uvec2(0u, 0u));
	block[2].s[2].b[0] = (mat2x4(0.0, 2.0, 3.0, -8.0, 1.0, -7.0, 8.0, -6.0));
	block[2].s[2].b[1] = (mat2x4(-2.0, 8.0, -6.0, -6.0, -7.0, 3.0, 6.0, 1.0));
	block[2].s[2].b[2] = (mat2x4(0.0, 9.0, 8.0, 2.0, 4.0, 5.0, 5.0, -6.0));
	block[2].s[2].b[3] = (mat2x4(-5.0, -2.0, 1.0, 3.0, 7.0, -6.0, -4.0, -8.0));
	block[2].s[2].c = (vec3(-7.0, -5.0, -8.0));
}
#version 450
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
	allOk = compare_uint((u), 7u) && allOk;
	allOk = compare_mat4x3(t[0].a, mat4x3(6.0, -1.0, 8.0, 6.0, -1.0, 9.0, -2.0, -7.0, -8.0, 2.0, -6.0, -1.0)) && allOk;
	allOk = compare_uvec3((t[0].b[0].a), uvec3(8u, 5u, 7u)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[0]), vec2(-5.0, -2.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[1]), vec2(-1.0, -9.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[2]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[3]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(-3.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_uvec3((t[0].b[1].a), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[0]), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[1]), vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[2]), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[3]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(4.0, 7.0, 4.0, 6.0)) && allOk;
	allOk = compare_uvec3((t[0].b[2].a), uvec3(1u, 8u, 7u)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[0]), vec2(-9.0, 0.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[1]), vec2(0.0, -4.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[2]), vec2(6.0, -2.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[3]), vec2(8.0, 6.0)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(9.0, 5.0, 4.0, 2.0)) && allOk;
	allOk = compare_int((t[0].c), 4) && allOk;
	allOk = compare_mat4x3(t[1].a, mat4x3(-2.0, 0.0, -2.0, 7.0, -7.0, 6.0, -5.0, -8.0, -8.0, 4.0, 4.0, -9.0)) && allOk;
	allOk = compare_uvec3((t[1].b[0].a), uvec3(6u, 6u, 1u)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[0]), vec2(9.0, 1.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[1]), vec2(-2.0, -6.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[2]), vec2(-8.0, -6.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[3]), vec2(0.0, 9.0)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-5.0, 9.0, -1.0, -9.0)) && allOk;
	allOk = compare_uvec3((t[1].b[1].a), uvec3(6u, 9u, 6u)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[0]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[1]), vec2(3.0, 4.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[2]), vec2(-9.0, -3.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[3]), vec2(6.0, 5.0)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(5.0, 3.0, 3.0, 6.0)) && allOk;
	allOk = compare_uvec3((t[1].b[2].a), uvec3(3u, 5u, 6u)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[0]), vec2(7.0, 4.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[1]), vec2(-3.0, 5.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[2]), vec2(-6.0, 8.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[3]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(1.0, 7.0, 3.0, -9.0)) && allOk;
	allOk = compare_int((t[1].c), -1) && allOk;
	allOk = compare_mat4x3(t[2].a, mat4x3(-9.0, 5.0, -7.0, -5.0, 7.0, -4.0, 0.0, -9.0, 8.0, 2.0, 1.0, 1.0)) && allOk;
	allOk = compare_uvec3((t[2].b[0].a), uvec3(8u, 6u, 5u)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[0]), vec2(-5.0, -8.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[1]), vec2(-7.0, 4.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[2]), vec2(2.0, 5.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[3]), vec2(9.0, 7.0)) && allOk;
	allOk = compare_vec4((t[2].b[0].c), vec4(9.0, 7.0, -4.0, -1.0)) && allOk;
	allOk = compare_uvec3((t[2].b[1].a), uvec3(9u, 5u, 6u)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[0]), vec2(3.0, -4.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[1]), vec2(1.0, -9.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[2]), vec2(-1.0, -8.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[3]), vec2(-4.0, -3.0)) && allOk;
	allOk = compare_vec4((t[2].b[1].c), vec4(6.0, -9.0, 3.0, 2.0)) && allOk;
	allOk = compare_uvec3((t[2].b[2].a), uvec3(4u, 9u, 1u)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[0]), vec2(7.0, 0.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[1]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[2]), vec2(-9.0, -5.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[3]), vec2(4.0, 1.0)) && allOk;
	allOk = compare_vec4((t[2].b[2].c), vec4(4.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_int((t[2].c), 5) && allOk;
	allOk = compare_mat4x3(t[3].a, mat4x3(8.0, 4.0, 1.0, 5.0, -8.0, 5.0, -2.0, 5.0, -9.0, -5.0, 6.0, 5.0)) && allOk;
	allOk = compare_uvec3((t[3].b[0].a), uvec3(2u, 3u, 3u)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[0]), vec2(-1.0, -9.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[1]), vec2(0.0, -7.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[2]), vec2(7.0, -3.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[3]), vec2(-6.0, 9.0)) && allOk;
	allOk = compare_vec4((t[3].b[0].c), vec4(7.0, -4.0, -5.0, 5.0)) && allOk;
	allOk = compare_uvec3((t[3].b[1].a), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[0]), vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[1]), vec2(7.0, 6.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[2]), vec2(1.0, 0.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[3]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_vec4((t[3].b[1].c), vec4(8.0, -1.0, 6.0, -7.0)) && allOk;
	allOk = compare_uvec3((t[3].b[2].a), uvec3(4u, 8u, 5u)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[0]), vec2(1.0, 4.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[1]), vec2(-8.0, -5.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[2]), vec2(-3.0, -6.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[3]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec4((t[3].b[2].c), vec4(3.0, 1.0, -3.0, 0.0)) && allOk;
	allOk = compare_int((t[3].c), -9) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (uvec3(4u, 1u, 3u));
	s.b[0] = (vec2(-6.0, 3.0));
	s.b[1] = (vec2(-3.0, -2.0));
	s.b[2] = (vec2(-9.0, 1.0));
	s.b[3] = (vec2(-7.0, 9.0));
	s.c = (vec4(9.0, -7.0, -8.0, 3.0));
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

layout(std140, binding = 1) buffer Block
{
	i8vec4 var;
} block[3];

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(block[0].var), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block[1].var), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block[2].var), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	block[1].var = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	block[2].var = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
}
#version 450
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
	highp vec2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 5.0) && allOk;
	allOk = compare_vec2((block[0].var), vec2(4.0, -8.0)) && allOk;
	allOk = compare_float((block[1].padding), -7.0) && allOk;
	allOk = compare_vec2((block[1].var), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -9.0) && allOk;
	allOk = compare_vec2((block[2].var), vec2(7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (3.0);
	block[0].var = (vec2(8.0, 7.0));
	block[1].padding = (-1.0);
	block[1].var = (vec2(-4.0, 8.0));
	block[2].padding = (-2.0);
	block[2].var = (vec2(-5.0, -2.0));
}
#version 450
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
	highp mat3 var;
} block[3];

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

layout(scalar, row_major, binding = 1) buffer Block
{
	float padding;
	highp mat2x3 var;
} block[3];

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

layout(scalar, binding = 1) buffer Block
{
	int8_t padding;
	i8vec3 var;
} block[3];

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block[0].padding), 4294967295) && allOk;
	allOk = compare_i8vec3(ivec3(block[0].var), ivec3(4294967290, 1, 4294967293)) && allOk;
	allOk = compare_int8_t(int(block[1].padding), 4294967289) && allOk;
	allOk = compare_i8vec3(ivec3(block[1].var), ivec3(3, 7, 9)) && allOk;
	allOk = compare_int8_t(int(block[2].padding), 4294967292) && allOk;
	allOk = compare_i8vec3(ivec3(block[2].var), ivec3(5, 4294967288, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = int8_t(4294967292);
	block[0].var = i8vec3(ivec3(0, 0, 7));
	block[1].padding = int8_t(9);
	block[1].var = i8vec3(ivec3(4294967290, 4294967288, 9));
	block[2].padding = int8_t(4294967288);
	block[2].var = i8vec3(ivec3(4294967293, 3, 4294967295));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
} blockA;
layout(std430, binding = 2) buffer BlockB
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
	allOk = compare_float((blockA.a), -3.0) && allOk;
	allOk = compare_float(blockA.c[0][0], 1.0) && allOk;
	allOk = compare_float(blockA.c[0][1], 3.0) && allOk;
	allOk = compare_float(blockA.c[1][0], -3.0) && allOk;
	allOk = compare_float(blockA.c[1][1], -7.0) && allOk;
	allOk = compare_vec2(blockA.c[0], vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec2(blockA.c[1], vec2(-3.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-2, -8)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-5.0);
	blockB.a = (mat3(-6.0, 6.0, 0.0, -6.0, -4.0, 3.0, -6.0, -4.0, -4.0));
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
	lowp int a[1];
	mediump uint b;
	lowp float c;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	bool d;
	highp uint e;
	bool f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a[0]), 1) && allOk;
	allOk = compare_uint((blockB.b), 5u) && allOk;
	allOk = compare_float((blockB.c), -5.0) && allOk;
	allOk = compare_bool((f), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (9);
	blockB.b = (8u);
	blockB.c = (5.0);
	e = (4u);
	f = (true);
}
#version 450
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
	highp int b;
	bool c;
	lowp uint d[1];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	mediump float e;
	highp int f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_float((e), -2.0) && allOk;
	allOk = compare_int((f), 6) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = (3);
	blockB.c = (false);
	e = (-7.0);
}
#version 450
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
	mediump ivec4 a;
	bvec2 b[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	bvec4 c;
	mediump mat4x2 d;
	mediump mat4x2 e;
	mediump float f[];
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	bool g;
	lowp mat3x2 h;
	mediump mat4 i[1];
	highp ivec4 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((a), ivec4(-8, -8, 0, -9)) && allOk;
	allOk = compare_mat4x2(e, mat4x2(5.0, -1.0, -9.0, -1.0, -2.0, -5.0, 4.0, 2.0)) && allOk;
	allOk = compare_float((f[0]), -6.0) && allOk;
	allOk = compare_bool((g), false) && allOk;
	allOk = compare_mat3x2(h, mat3x2(-7.0, -4.0, -7.0, -2.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4(i[0], mat4(8.0, -1.0, 5.0, 9.0, -1.0, 5.0, -9.0, 2.0, 3.0, 2.0, -3.0, -9.0, -2.0, 5.0, -8.0, -9.0)) && allOk;
	allOk = compare_ivec4((j[0]), ivec4(-5, -1, 5, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec4(-2, -9, -3, -1));
	b[0] = (bvec2(true, true));
	d = (mat4x2(6.0, -8.0, -5.0, 3.0, 2.0, 6.0, -9.0, -6.0));
	e = (mat4x2(5.0, 7.0, 6.0, -8.0, -6.0, -2.0, 3.0, -6.0));
	g = (true);
}
#version 450
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
	lowp uvec3 a;
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp uvec4 b[1];
	highp ivec3 c;
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp vec4 d[2];
	bvec2 e;
	lowp mat3x4 f;
	bvec2 g;
} blockD;
layout(std430, column_major, binding = 4) buffer BlockE
{
	lowp int h;
	bvec2 i[][7];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(4u, 0u, 4u)) && allOk;
	allOk = compare_mat3x4(blockD.f, mat3x4(-7.0, 7.0, -5.0, 8.0, -5.0, 7.0, -8.0, -4.0, -3.0, 5.0, 0.0, -2.0)) && allOk;
	allOk = compare_bvec2((blockD.g), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[0][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[0][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[0][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.i[0][3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.i[0][4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[0][5]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.i[0][6]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.i[1][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.i[1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.i[1][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.i[1][3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.i[1][4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[1][5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[1][6]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.i[2][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.i[2][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[2][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.i[2][3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.i[2][4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[2][5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[2][6]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.i[3][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.i[3][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.i[3][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.i[3][3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[3][4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[3][5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[3][6]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[4][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.i[4][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[4][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.i[4][3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.i[4][4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.i[4][5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[4][6]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.i[5][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.i[5][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[5][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.i[5][3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[5][4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[5][5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[5][6]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[6][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.i[6][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.i[6][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.i[6][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.i[6][4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[6][5]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.i[6][6]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.i[7][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.i[7][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.i[7][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.i[7][3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.i[7][4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[7][5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.i[7][6]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(8u, 3u, 1u));
	b[0] = (uvec4(4u, 8u, 7u, 2u));
	blockD.d[0] = (vec4(6.0, 2.0, 9.0, 8.0));
	blockD.d[1] = (vec4(5.0, -5.0, 8.0, -1.0));
	blockD.e = (bvec2(true, false));
	blockD.f = (mat3x4(-1.0, 6.0, -2.0, -4.0, 9.0, -4.0, 2.0, -4.0, 4.0, -8.0, -4.0, 1.0));
	blockD.g = (bvec2(true, false));
	blockE.i[0][0] = (bvec2(false, false));
	blockE.i[0][1] = (bvec2(true, true));
	blockE.i[0][2] = (bvec2(false, true));
	blockE.i[0][3] = (bvec2(true, true));
	blockE.i[0][4] = (bvec2(false, true));
	blockE.i[0][5] = (bvec2(false, true));
	blockE.i[0][6] = (bvec2(false, false));
	blockE.i[1][0] = (bvec2(true, false));
	blockE.i[1][1] = (bvec2(true, false));
	blockE.i[1][2] = (bvec2(true, false));
	blockE.i[1][3] = (bvec2(false, true));
	blockE.i[1][4] = (bvec2(true, true));
	blockE.i[1][5] = (bvec2(false, false));
	blockE.i[1][6] = (bvec2(true, true));
	blockE.i[2][0] = (bvec2(true, true));
	blockE.i[2][1] = (bvec2(false, false));
	blockE.i[2][2] = (bvec2(false, false));
	blockE.i[2][3] = (bvec2(false, false));
	blockE.i[2][4] = (bvec2(false, true));
	blockE.i[2][5] = (bvec2(false, false));
	blockE.i[2][6] = (bvec2(false, false));
	blockE.i[3][0] = (bvec2(false, true));
	blockE.i[3][1] = (bvec2(true, true));
	blockE.i[3][2] = (bvec2(true, false));
	blockE.i[3][3] = (bvec2(false, true));
	blockE.i[3][4] = (bvec2(false, true));
	blockE.i[3][5] = (bvec2(false, false));
	blockE.i[3][6] = (bvec2(false, false));
	blockE.i[4][0] = (bvec2(true, true));
	blockE.i[4][1] = (bvec2(true, true));
	blockE.i[4][2] = (bvec2(true, true));
	blockE.i[4][3] = (bvec2(false, true));
	blockE.i[4][4] = (bvec2(false, false));
	blockE.i[4][5] = (bvec2(false, true));
	blockE.i[4][6] = (bvec2(false, true));
	blockE.i[5][0] = (bvec2(false, true));
	blockE.i[5][1] = (bvec2(false, true));
	blockE.i[5][2] = (bvec2(true, true));
	blockE.i[5][3] = (bvec2(true, true));
	blockE.i[5][4] = (bvec2(false, true));
	blockE.i[5][5] = (bvec2(true, true));
	blockE.i[5][6] = (bvec2(false, false));
	blockE.i[6][0] = (bvec2(true, false));
	blockE.i[6][1] = (bvec2(false, true));
	blockE.i[6][2] = (bvec2(true, false));
	blockE.i[6][3] = (bvec2(false, true));
	blockE.i[6][4] = (bvec2(false, false));
	blockE.i[6][5] = (bvec2(false, false));
	blockE.i[6][6] = (bvec2(true, false));
	blockE.i[7][0] = (bvec2(true, false));
	blockE.i[7][1] = (bvec2(true, true));
	blockE.i[7][2] = (bvec2(false, true));
	blockE.i[7][3] = (bvec2(false, false));
	blockE.i[7][4] = (bvec2(false, false));
	blockE.i[7][5] = (bvec2(true, false));
	blockE.i[7][6] = (bvec2(false, true));
}
#version 450
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
	layout(offset = 0) highp ivec3 a;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump uvec4 b;
	layout(offset = 16) lowp uvec4 c;
	layout(offset = 32) bvec2 d;
	layout(offset = 40) mediump vec2 e;
	layout(offset = 48) highp ivec3 f;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp ivec2 g;
	layout(offset = 16) bvec3 h;
	layout(offset = 32) highp vec4 i;
} blockD[3];
layout(binding = 4) readonly buffer BlockE
{
	layout(offset = 0) lowp int j;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(7, -7, 0)) && allOk;
	allOk = compare_uvec4((blockC.b), uvec4(1u, 3u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((blockC.c), uvec4(2u, 4u, 3u, 9u)) && allOk;
	allOk = compare_bvec2((blockC.d), bvec2(false, false)) && allOk;
	allOk = compare_vec2((blockC.e), vec2(7.0, -8.0)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(-8, -4, 8)) && allOk;
	allOk = compare_ivec2((blockD[0].g), ivec2(-1, 6)) && allOk;
	allOk = compare_bvec3((blockD[0].h), bvec3(false, false, true)) && allOk;
	allOk = compare_vec4((blockD[0].i), vec4(6.0, 0.0, 6.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockD[1].g), ivec2(7, -3)) && allOk;
	allOk = compare_bvec3((blockD[1].h), bvec3(true, true, true)) && allOk;
	allOk = compare_vec4((blockD[1].i), vec4(-5.0, -7.0, 5.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockD[2].g), ivec2(-2, -7)) && allOk;
	allOk = compare_bvec3((blockD[2].h), bvec3(true, false, true)) && allOk;
	allOk = compare_vec4((blockD[2].i), vec4(9.0, 2.0, 0.0, 2.0)) && allOk;
	allOk = compare_int((blockE.j), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (uvec4(8u, 6u, 0u, 6u));
	blockC.c = (uvec4(2u, 5u, 3u, 3u));
	blockC.e = (vec2(-3.0, 1.0));
	blockD[0].g = (ivec2(-2, 1));
	blockD[0].h = (bvec3(false, false, false));
	blockD[1].g = (ivec2(-3, -8));
	blockD[1].h = (bvec3(true, true, false));
	blockD[2].g = (ivec2(0, -4));
	blockD[2].h = (bvec3(false, true, false));
}
#version 450
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
	layout(offset = 0) lowp int a[1];
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump vec3 b;
	layout(offset = 16) lowp ivec3 c;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp uint d;
	layout(offset = 4) bvec2 e;
	layout(offset = 16) mediump ivec3 f;
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((b), vec3(4.0, 3.0, 7.0)) && allOk;
	allOk = compare_ivec3((c), ivec3(-3, 2, -1)) && allOk;
	allOk = compare_uint((blockD[0].d), 6u) && allOk;
	allOk = compare_bvec2((blockD[0].e), bvec2(true, false)) && allOk;
	allOk = compare_ivec3((blockD[0].f), ivec3(6, -6, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (-7);
	blockB[1].a[0] = (-2);
	b = (vec3(8.0, -4.0, -8.0));
	c = (ivec3(5, 3, 3));
	blockD[0].d = (9u);
	blockD[0].e = (bvec2(false, false));
	blockD[0].f = (ivec3(-8, -8, -8));
}
#version 450
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
	layout(offset = 16) bvec4 b;
	layout(offset = 32) bvec4 c[1];
	layout(offset = 48) mediump vec4 d;
	layout(offset = 64) highp vec3 e[1];
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump ivec3 f;
} blockC[1];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec2 g;
	layout(offset = 16) bvec4 h;
	layout(offset = 32) mediump int i[1];
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((a), bvec2(true, true)) && allOk;
	allOk = compare_bvec4((b), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((c[0]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_vec4((d), vec4(-5.0, -6.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3((e[0]), vec3(-9.0, -5.0, -1.0)) && allOk;
	allOk = compare_ivec3((blockC[0].f), ivec3(9, 3, 4)) && allOk;
	allOk = compare_bvec2((blockD[0].g), bvec2(true, true)) && allOk;
	allOk = compare_bvec4((blockD[0].h), bvec4(true, false, true, true)) && allOk;
	allOk = compare_int((blockD[0].i[0]), -2) && allOk;
	allOk = compare_bvec2((blockD[1].g), bvec2(true, false)) && allOk;
	allOk = compare_bvec4((blockD[1].h), bvec4(false, true, true, false)) && allOk;
	allOk = compare_int((blockD[1].i[0]), 2) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec2(true, true));
	b = (bvec4(false, false, false, true));
	d = (vec4(3.0, 9.0, 5.0, 1.0));
	e[0] = (vec3(8.0, -7.0, -2.0));
	blockC[0].f = (ivec3(6, 8, 6));
	blockD[0].h = (bvec4(true, false, false, true));
	blockD[0].i[0] = (1);
	blockD[1].h = (bvec4(true, false, true, false));
	blockD[1].i[0] = (6);
}
#version 450
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
	layout(offset = 0) bool a;
	layout(offset = 16) bvec4 b;
	layout(offset = 32) lowp ivec3 c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump ivec2 d;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump ivec2 e;
	layout(offset = 16) lowp uvec4 f;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) highp uvec4 g;
	layout(offset = 16) mediump vec3 h;
	layout(offset = 28) mediump uint i;
	layout(offset = 32) mediump vec3 j;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_bvec4((blockB.b), bvec4(false, false, false, false)) && allOk;
	allOk = compare_ivec2((blockC.d), ivec2(-7, -1)) && allOk;
	allOk = compare_ivec2((e), ivec2(3, 2)) && allOk;
	allOk = compare_uvec4((f), uvec4(0u, 2u, 7u, 2u)) && allOk;
	allOk = compare_uvec4((g), uvec4(4u, 3u, 4u, 1u)) && allOk;
	allOk = compare_uint((i), 3u) && allOk;
	allOk = compare_vec3((j), vec3(1.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.c = (ivec3(4, 9, -1));
	blockC.d = (ivec2(-7, 5));
	f = (uvec4(8u, 0u, 1u, 3u));
	g = (uvec4(4u, 7u, 5u, 9u));
	h = (vec3(2.0, -4.0, -7.0));
}
#version 450
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
	mediump vec3 mA;
	lowp mat3x2 mB;
	highp ivec3 mC;
};
struct sB
{
	highp mat3x2 mA;
};
struct sC
{
	mediump ivec3 mA;
};
struct sD
{
	bool mA;
	bvec2 mB;
	bvec3 mC;
	mediump uvec2 mD;
};
struct sE
{
	highp ivec3 mA;
	sD mB;
	mediump mat4 mC[1];
};
layout(scalar, binding = 1) buffer BlockB
{
	bvec4 a;
	lowp uvec4 b;
	sA c;
	mediump uvec2 d;
	lowp vec3 e;
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	lowp uint f;
	lowp ivec3 g;
	highp float h;
	sB i;
	highp float j[];
};
layout(scalar, binding = 3) buffer BlockD
{
	sC k;
	highp uint l;
	highp mat2 m;
	lowp mat2 n;
	sE o[];
} blockD;
layout(scalar, row_major, binding = 4) buffer BlockE
{
	bvec2 p;
	mediump mat4x3 q[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.d), uvec2(2u, 4u)) && allOk;
	allOk = compare_ivec3((g), ivec3(-4, 3, -2)) && allOk;
	allOk = compare_float((h), -9.0) && allOk;
	allOk = compare_float((j[0]), 1.0) && allOk;
	allOk = compare_float((j[1]), 7.0) && allOk;
	allOk = compare_float((j[2]), 6.0) && allOk;
	allOk = compare_float((j[3]), 6.0) && allOk;
	allOk = compare_ivec3((blockD.k.mA), ivec3(2, 7, 0)) && allOk;
	allOk = compare_mat2(blockD.n, mat2(-7.0, 2.0, -1.0, -1.0)) && allOk;
	allOk = compare_ivec3((blockD.o[0].mA), ivec3(-6, 3, 9)) && allOk;
	allOk = compare_bool((blockD.o[0].mB.mA), true) && allOk;
	allOk = compare_bvec2((blockD.o[0].mB.mB), bvec2(false, false)) && allOk;
	allOk = compare_bvec3((blockD.o[0].mB.mC), bvec3(true, false, true)) && allOk;
	allOk = compare_uvec2((blockD.o[0].mB.mD), uvec2(4u, 5u)) && allOk;
	allOk = compare_mat4(blockD.o[0].mC[0], mat4(-5.0, 2.0, -6.0, -3.0, 7.0, -3.0, -6.0, -6.0, -1.0, 8.0, 3.0, -7.0, -5.0, -3.0, 6.0, -9.0)) && allOk;
	allOk = compare_ivec3((blockD.o[1].mA), ivec3(1, 6, 2)) && allOk;
	allOk = compare_bool((blockD.o[1].mB.mA), false) && allOk;
	allOk = compare_bvec2((blockD.o[1].mB.mB), bvec2(true, false)) && allOk;
	allOk = compare_bvec3((blockD.o[1].mB.mC), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec2((blockD.o[1].mB.mD), uvec2(3u, 3u)) && allOk;
	allOk = compare_mat4(blockD.o[1].mC[0], mat4(5.0, -1.0, -3.0, 2.0, 2.0, 3.0, -8.0, 2.0, -8.0, -3.0, 3.0, 9.0, 7.0, -6.0, -6.0, -9.0)) && allOk;
	allOk = compare_ivec3((blockD.o[2].mA), ivec3(-4, 5, 7)) && allOk;
	allOk = compare_bool((blockD.o[2].mB.mA), false) && allOk;
	allOk = compare_bvec2((blockD.o[2].mB.mB), bvec2(false, true)) && allOk;
	allOk = compare_bvec3((blockD.o[2].mB.mC), bvec3(false, true, true)) && allOk;
	allOk = compare_uvec2((blockD.o[2].mB.mD), uvec2(7u, 0u)) && allOk;
	allOk = compare_mat4(blockD.o[2].mC[0], mat4(-8.0, -6.0, -1.0, 8.0, 4.0, -5.0, 7.0, -5.0, -5.0, 8.0, -3.0, 3.0, -5.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_ivec3((blockD.o[3].mA), ivec3(4, -8, -3)) && allOk;
	allOk = compare_bool((blockD.o[3].mB.mA), true) && allOk;
	allOk = compare_bvec2((blockD.o[3].mB.mB), bvec2(true, false)) && allOk;
	allOk = compare_bvec3((blockD.o[3].mB.mC), bvec3(false, false, true)) && allOk;
	allOk = compare_uvec2((blockD.o[3].mB.mD), uvec2(3u, 3u)) && allOk;
	allOk = compare_mat4(blockD.o[3].mC[0], mat4(8.0, -9.0, 9.0, 5.0, -9.0, 3.0, 3.0, 6.0, 5.0, 0.0, -5.0, 9.0, -9.0, -7.0, 9.0, 7.0)) && allOk;
	allOk = compare_ivec3((blockD.o[4].mA), ivec3(2, -9, -1)) && allOk;
	allOk = compare_bool((blockD.o[4].mB.mA), false) && allOk;
	allOk = compare_bvec2((blockD.o[4].mB.mB), bvec2(true, false)) && allOk;
	allOk = compare_bvec3((blockD.o[4].mB.mC), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec2((blockD.o[4].mB.mD), uvec2(1u, 2u)) && allOk;
	allOk = compare_mat4(blockD.o[4].mC[0], mat4(6.0, 2.0, -3.0, -8.0, -7.0, 0.0, 1.0, -6.0, 8.0, 0.0, -1.0, 7.0, 5.0, 5.0, 2.0, -1.0)) && allOk;
	allOk = compare_ivec3((blockD.o[5].mA), ivec3(2, 9, 7)) && allOk;
	allOk = compare_bool((blockD.o[5].mB.mA), false) && allOk;
	allOk = compare_bvec2((blockD.o[5].mB.mB), bvec2(true, false)) && allOk;
	allOk = compare_bvec3((blockD.o[5].mB.mC), bvec3(false, false, true)) && allOk;
	allOk = compare_uvec2((blockD.o[5].mB.mD), uvec2(5u, 1u)) && allOk;
	allOk = compare_mat4(blockD.o[5].mC[0], mat4(4.0, 4.0, -3.0, 1.0, 7.0, -7.0, -4.0, -3.0, -8.0, 0.0, 5.0, -9.0, 5.0, -6.0, 2.0, 7.0)) && allOk;
	allOk = compare_ivec3((blockD.o[6].mA), ivec3(-3, -3, 3)) && allOk;
	allOk = compare_bool((blockD.o[6].mB.mA), false) && allOk;
	allOk = compare_bvec2((blockD.o[6].mB.mB), bvec2(true, false)) && allOk;
	allOk = compare_bvec3((blockD.o[6].mB.mC), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec2((blockD.o[6].mB.mD), uvec2(8u, 3u)) && allOk;
	allOk = compare_mat4(blockD.o[6].mC[0], mat4(-1.0, -1.0, 8.0, 7.0, 7.0, 8.0, 3.0, -6.0, 6.0, -5.0, 2.0, 2.0, 0.0, 8.0, 5.0, 6.0)) && allOk;
	allOk = compare_bvec2((p), bvec2(false, true)) && allOk;
	allOk = compare_mat4x3(q[0], mat4x3(-2.0, -5.0, 4.0, 1.0, -8.0, -4.0, 9.0, 2.0, 0.0, 0.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(q[1], mat4x3(4.0, -5.0, 5.0, -5.0, -2.0, -2.0, 7.0, -6.0, -3.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(q[2], mat4x3(5.0, 7.0, -3.0, 3.0, -6.0, 9.0, -1.0, -1.0, 1.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x3(q[3], mat4x3(-5.0, -3.0, -7.0, -3.0, 3.0, -2.0, -6.0, 1.0, 9.0, 6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x3(q[4], mat4x3(-7.0, 2.0, -7.0, -7.0, 4.0, 4.0, -2.0, -7.0, 8.0, 1.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(q[5], mat4x3(9.0, 8.0, -3.0, 3.0, 8.0, 2.0, 8.0, 8.0, 7.0, 5.0, 9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec4(7u, 7u, 7u, 2u));
	blockB.d = (uvec2(7u, 9u));
	f = (5u);
	g = (ivec3(6, 3, -4));
	h = (-1.0);
	i.mA = (mat3x2(6.0, 1.0, -3.0, -4.0, -9.0, -2.0));
	j[0] = (1.0);
	j[1] = (-8.0);
	j[2] = (3.0);
	j[3] = (-8.0);
	blockD.k.mA = (ivec3(0, 2, 4));
	blockD.l = (5u);
	blockD.m = (mat2(-3.0, -1.0, 5.0, -5.0));
	blockD.n = (mat2(8.0, -4.0, 9.0, 2.0));
	blockD.o[0].mA = (ivec3(-6, 8, 1));
	blockD.o[0].mB.mA = (true);
	blockD.o[0].mB.mB = (bvec2(true, false));
	blockD.o[0].mB.mC = (bvec3(false, true, false));
	blockD.o[0].mB.mD = (uvec2(1u, 2u));
	blockD.o[0].mC[0] = (mat4(4.0, 9.0, -9.0, 6.0, -7.0, 4.0, 8.0, -7.0, -9.0, 9.0, 3.0, 4.0, -6.0, -9.0, -9.0, -1.0));
	blockD.o[1].mA = (ivec3(-5, -1, -4));
	blockD.o[1].mB.mA = (true);
	blockD.o[1].mB.mB = (bvec2(true, false));
	blockD.o[1].mB.mC = (bvec3(true, true, true));
	blockD.o[1].mB.mD = (uvec2(6u, 1u));
	blockD.o[1].mC[0] = (mat4(5.0, -6.0, 6.0, 5.0, 1.0, -9.0, -2.0, 8.0, 2.0, 9.0, 4.0, -2.0, 0.0, -4.0, -8.0, 6.0));
	blockD.o[2].mA = (ivec3(5, 2, -9));
	blockD.o[2].mB.mA = (false);
	blockD.o[2].mB.mB = (bvec2(true, false));
	blockD.o[2].mB.mC = (bvec3(true, false, false));
	blockD.o[2].mB.mD = (uvec2(0u, 6u));
	blockD.o[2].mC[0] = (mat4(-8.0, 6.0, 0.0, -1.0, 2.0, -6.0, 3.0, -4.0, -8.0, -5.0, -1.0, 0.0, -3.0, -3.0, -1.0, -1.0));
	blockD.o[3].mA = (ivec3(2, 2, 1));
	blockD.o[3].mB.mA = (true);
	blockD.o[3].mB.mB = (bvec2(false, true));
	blockD.o[3].mB.mC = (bvec3(false, false, false));
	blockD.o[3].mB.mD = (uvec2(9u, 8u));
	blockD.o[3].mC[0] = (mat4(-1.0, 2.0, 3.0, -5.0, -5.0, 3.0, -3.0, 8.0, -6.0, -1.0, -3.0, -6.0, -6.0, -8.0, 3.0, -5.0));
	blockD.o[4].mA = (ivec3(4, 0, 7));
	blockD.o[4].mB.mA = (true);
	blockD.o[4].mB.mB = (bvec2(true, false));
	blockD.o[4].mB.mC = (bvec3(true, true, false));
	blockD.o[4].mB.mD = (uvec2(4u, 7u));
	blockD.o[4].mC[0] = (mat4(8.0, -1.0, 2.0, 3.0, -6.0, -7.0, -5.0, 9.0, -6.0, 3.0, -6.0, -7.0, -1.0, -2.0, -4.0, 8.0));
	blockD.o[5].mA = (ivec3(2, 0, -4));
	blockD.o[5].mB.mA = (false);
	blockD.o[5].mB.mB = (bvec2(false, true));
	blockD.o[5].mB.mC = (bvec3(true, true, false));
	blockD.o[5].mB.mD = (uvec2(4u, 4u));
	blockD.o[5].mC[0] = (mat4(-6.0, 2.0, -3.0, 3.0, 8.0, -3.0, 1.0, 1.0, -8.0, 7.0, -1.0, 4.0, -2.0, 3.0, 6.0, -2.0));
	blockD.o[6].mA = (ivec3(0, 6, -5));
	blockD.o[6].mB.mA = (true);
	blockD.o[6].mB.mB = (bvec2(true, false));
	blockD.o[6].mB.mC = (bvec3(true, false, false));
	blockD.o[6].mB.mD = (uvec2(0u, 1u));
	blockD.o[6].mC[0] = (mat4(-4.0, 0.0, -6.0, -7.0, -1.0, 9.0, -3.0, -5.0, 2.0, -1.0, -6.0, -5.0, -6.0, -5.0, -2.0, -3.0));
	q[0] = (mat4x3(-2.0, 0.0, 3.0, 2.0, 7.0, -7.0, 4.0, -8.0, -7.0, -9.0, 6.0, 4.0));
	q[1] = (mat4x3(-3.0, 3.0, -9.0, 0.0, 6.0, -6.0, 7.0, -8.0, -1.0, 6.0, 7.0, -9.0));
	q[2] = (mat4x3(5.0, -2.0, 8.0, -2.0, -5.0, 9.0, -2.0, 1.0, -9.0, -1.0, 5.0, 1.0));
	q[3] = (mat4x3(4.0, -1.0, -6.0, -5.0, 1.0, -2.0, 5.0, -5.0, -6.0, -9.0, 0.0, 4.0));
	q[4] = (mat4x3(6.0, -5.0, 9.0, -9.0, -2.0, 3.0, 4.0, 2.0, 3.0, 8.0, -1.0, 3.0));
	q[5] = (mat4x3(6.0, -1.0, -1.0, 1.0, -5.0, 0.0, 8.0, -7.0, 7.0, -9.0, -7.0, 7.0));
}
#version 450
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
	mediump vec3 a;
	lowp uvec4 b[7];
	bvec4 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((a), vec3(4.0, -1.0, 1.0)) && allOk;
	allOk = compare_uvec4((b[0]), uvec4(0u, 8u, 2u, 7u)) && allOk;
	allOk = compare_uvec4((b[1]), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_uvec4((b[2]), uvec4(7u, 6u, 9u, 5u)) && allOk;
	allOk = compare_uvec4((b[3]), uvec4(2u, 8u, 6u, 9u)) && allOk;
	allOk = compare_uvec4((b[4]), uvec4(9u, 7u, 3u, 2u)) && allOk;
	allOk = compare_uvec4((b[5]), uvec4(1u, 8u, 6u, 0u)) && allOk;
	allOk = compare_uvec4((b[6]), uvec4(5u, 1u, 8u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec3(5.0, 7.0, -9.0));
}
#version 450
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
	lowp ivec3 a;
	mediump uvec4 b[3];
	mediump float c[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump mat3x2 d[4][2];
	highp int e;
	lowp mat3x4 f[];
};
layout(std140, binding = 3) buffer BlockD
{
	mediump vec2 g;
	f16vec2 h;
	bool i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a), ivec3(2, -8, -4)) && allOk;
	allOk = compare_uvec4((b[0]), uvec4(1u, 4u, 0u, 6u)) && allOk;
	allOk = compare_uvec4((b[1]), uvec4(0u, 4u, 1u, 3u)) && allOk;
	allOk = compare_uvec4((b[2]), uvec4(4u, 2u, 6u, 9u)) && allOk;
	allOk = compare_float((c[0]), 1.0) && allOk;
	allOk = compare_float((c[1]), -7.0) && allOk;
	allOk = compare_float((c[2]), 7.0) && allOk;
	allOk = compare_int((e), 9) && allOk;
	allOk = compare_mat3x4(f[0], mat3x4(-5.0, -3.0, 5.0, -4.0, 1.0, -1.0, -2.0, 3.0, -3.0, -9.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3x4(f[1], mat3x4(-2.0, -2.0, 7.0, -1.0, 8.0, 2.0, 5.0, 7.0, 6.0, 3.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(f[2], mat3x4(3.0, -9.0, 3.0, 8.0, -9.0, -2.0, -2.0, 2.0, -4.0, 6.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec2((g), vec2(9.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(h), vec2(-7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec3(8, -2, -1));
	c[0] = (7.0);
	c[1] = (4.0);
	c[2] = (7.0);
	d[0][0] = (mat3x2(0.0, -5.0, 9.0, 4.0, -4.0, 9.0));
	d[0][1] = (mat3x2(-7.0, -4.0, -6.0, 8.0, -2.0, -6.0));
	d[1][0] = (mat3x2(-4.0, -6.0, 6.0, 8.0, -3.0, -6.0));
	d[1][1] = (mat3x2(-7.0, -7.0, -1.0, 2.0, 4.0, -1.0));
	d[2][0] = (mat3x2(4.0, -5.0, -6.0, -1.0, 5.0, -2.0));
	d[2][1] = (mat3x2(-3.0, -6.0, -7.0, 7.0, 8.0, 9.0));
	d[3][0] = (mat3x2(8.0, 4.0, -3.0, 9.0, -4.0, 0.0));
	d[3][1] = (mat3x2(1.0, -9.0, 2.0, -9.0, -3.0, 0.0));
	e = (-6);
	i[0] = (true);
	i[1] = (true);
	i[2] = (false);
	i[3] = (false);
	i[4] = (true);
}
#version 450
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
	highp mat3x4 a[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	i16vec2 b;
	bvec2 c;
	lowp uvec2 d;
	u16vec2 e[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a[0], mat3x4(4.0, 6.0, -6.0, -9.0, -1.0, 1.0, -4.0, 6.0, 1.0, 9.0, 2.0, 8.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.b), ivec2(-9, -6)) && allOk;
	allOk = compare_uvec2((blockC.d), uvec2(9u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.e[0]), uvec2(7u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3x4(5.0, -6.0, -1.0, -9.0, 7.0, 1.0, -3.0, -2.0, -9.0, -2.0, -9.0, -4.0));
	blockC.b = i16vec2(ivec2(-4, 3));
	blockC.c = (bvec2(false, true));
	blockC.e[0] = u16vec2(uvec2(9u, 4u));
}
#version 450
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
	i16vec4 a;
	highp vec3 b;
	uint16_t c;
	mediump uvec3 d;
	i16vec2 e;
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp vec2 f;
	lowp ivec2 g;
	lowp mat3x4 h;
	lowp float i;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.d), uvec3(8u, 8u, 5u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e), ivec2(-5, -2)) && allOk;
	allOk = compare_vec2((blockC.f), vec2(0.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockC.g), ivec2(-1, -9)) && allOk;
	allOk = compare_float((blockC.i), -5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec4(ivec4(8, 9, -5, 5));
	blockB.b = (vec3(-4.0, 2.0, -1.0));
	blockB.c = uint16_t(4u);
	blockB.d = (uvec3(7u, 6u, 5u));
	blockB.e = i16vec2(ivec2(-2, 4));
	blockC.g = (ivec2(-8, -6));
	blockC.h = (mat3x4(9.0, 4.0, -5.0, 5.0, -1.0, 4.0, -7.0, 5.0, -6.0, 4.0, -3.0, 9.0));
	blockC.i = (0.0);
}
#version 450
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
	lowp uvec3 a;
	mediump mat3x2 b;
	mediump ivec4 c;
	f16vec3 d;
	mediump mat4 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((a), uvec3(2u, 0u, 3u)) && allOk;
	allOk = compare_mat3x2(b, mat3x2(6.0, 1.0, 9.0, -6.0, -4.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(d), vec3(-6.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec3(4u, 9u, 2u));
	b = (mat3x2(-6.0, 1.0, -2.0, -1.0, -3.0, -9.0));
	c = (ivec4(-9, -2, -4, -4));
	e[0] = (mat4(1.0, 2.0, -6.0, 5.0, 9.0, 2.0, -1.0, -7.0, 3.0, -7.0, -5.0, 7.0, 5.0, 5.0, 7.0, -3.0));
}
#version 450
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
	layout(offset = 4) highp uvec2 b;
	layout(offset = 16) highp vec4 c;
	layout(offset = 32) u16vec2 d;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), 6.0) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(6u, 5u)) && allOk;
	allOk = compare_vec4((blockB.c), vec4(-5.0, -6.0, -2.0, 8.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.d), uvec2(4u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(-8.0);
	blockB.b = (uvec2(3u, 3u));
	blockB.c = (vec4(9.0, 4.0, 0.0, -9.0));
}
#version 450
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
	lowp ivec3 a[][5];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	bvec4 b;
	lowp uvec3 c;
	i16vec4 d[][8];
} blockC[1];

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a[0][0]), ivec3(-9, -4, 0)) && allOk;
	allOk = compare_ivec3((blockB.a[0][1]), ivec3(-5, -1, -5)) && allOk;
	allOk = compare_ivec3((blockB.a[0][2]), ivec3(5, 1, -8)) && allOk;
	allOk = compare_ivec3((blockB.a[0][3]), ivec3(-6, 7, 2)) && allOk;
	allOk = compare_ivec3((blockB.a[0][4]), ivec3(6, 0, -4)) && allOk;
	allOk = compare_ivec3((blockB.a[1][0]), ivec3(7, 6, 9)) && allOk;
	allOk = compare_ivec3((blockB.a[1][1]), ivec3(-7, -7, 6)) && allOk;
	allOk = compare_ivec3((blockB.a[1][2]), ivec3(-9, 9, -8)) && allOk;
	allOk = compare_ivec3((blockB.a[1][3]), ivec3(-6, -7, 6)) && allOk;
	allOk = compare_ivec3((blockB.a[1][4]), ivec3(-8, -6, 3)) && allOk;
	allOk = compare_ivec3((blockB.a[2][0]), ivec3(1, 3, 4)) && allOk;
	allOk = compare_ivec3((blockB.a[2][1]), ivec3(-2, 2, 7)) && allOk;
	allOk = compare_ivec3((blockB.a[2][2]), ivec3(-4, -5, 9)) && allOk;
	allOk = compare_ivec3((blockB.a[2][3]), ivec3(4, -8, 7)) && allOk;
	allOk = compare_ivec3((blockB.a[2][4]), ivec3(6, 2, -2)) && allOk;
	allOk = compare_ivec3((blockB.a[3][0]), ivec3(8, 1, 4)) && allOk;
	allOk = compare_ivec3((blockB.a[3][1]), ivec3(0, -6, -3)) && allOk;
	allOk = compare_ivec3((blockB.a[3][2]), ivec3(-6, -4, -1)) && allOk;
	allOk = compare_ivec3((blockB.a[3][3]), ivec3(8, -4, 3)) && allOk;
	allOk = compare_ivec3((blockB.a[3][4]), ivec3(-7, 3, 9)) && allOk;
	allOk = compare_bvec4((blockC[0].b), bvec4(false, true, false, true)) && allOk;
	allOk = compare_uvec3((blockC[0].c), uvec3(4u, 4u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0][0] = (ivec3(2, -9, 2));
	blockB.a[0][1] = (ivec3(8, 3, 5));
	blockB.a[0][2] = (ivec3(-9, -4, 8));
	blockB.a[0][3] = (ivec3(-1, -3, -1));
	blockB.a[0][4] = (ivec3(9, 6, -8));
	blockB.a[1][0] = (ivec3(-1, 1, -1));
	blockB.a[1][1] = (ivec3(3, 8, 1));
	blockB.a[1][2] = (ivec3(8, 4, 9));
	blockB.a[1][3] = (ivec3(4, 2, -8));
	blockB.a[1][4] = (ivec3(-2, 2, -1));
	blockB.a[2][0] = (ivec3(4, -2, 3));
	blockB.a[2][1] = (ivec3(8, 3, 7));
	blockB.a[2][2] = (ivec3(-8, -9, 2));
	blockB.a[2][3] = (ivec3(5, 4, 5));
	blockB.a[2][4] = (ivec3(-4, 2, -1));
	blockB.a[3][0] = (ivec3(9, -7, 1));
	blockB.a[3][1] = (ivec3(-3, 3, 4));
	blockB.a[3][2] = (ivec3(-5, 9, 7));
	blockB.a[3][3] = (ivec3(-9, -6, 5));
	blockB.a[3][4] = (ivec3(-6, -4, -5));
	blockC[0].b = (bvec4(true, false, true, false));
	blockC[0].c = (uvec3(6u, 3u, 5u));
	blockC[0].d[0][0] = i16vec4(ivec4(-2, 7, 7, -8));
	blockC[0].d[0][1] = i16vec4(ivec4(8, 8, 4, -3));
	blockC[0].d[0][2] = i16vec4(ivec4(3, -3, -3, -4));
	blockC[0].d[0][3] = i16vec4(ivec4(-3, -5, 7, -2));
	blockC[0].d[0][4] = i16vec4(ivec4(4, -9, 4, -1));
	blockC[0].d[0][5] = i16vec4(ivec4(-7, 6, 7, -4));
	blockC[0].d[0][6] = i16vec4(ivec4(-4, 1, -3, -8));
	blockC[0].d[0][7] = i16vec4(ivec4(6, 0, -8, -8));
	blockC[0].d[1][0] = i16vec4(ivec4(-3, 1, -2, 1));
	blockC[0].d[1][1] = i16vec4(ivec4(0, 6, 4, -8));
	blockC[0].d[1][2] = i16vec4(ivec4(-9, -6, 8, -5));
	blockC[0].d[1][3] = i16vec4(ivec4(6, -3, 4, 7));
	blockC[0].d[1][4] = i16vec4(ivec4(2, -5, -5, 4));
	blockC[0].d[1][5] = i16vec4(ivec4(-9, -3, -7, 3));
	blockC[0].d[1][6] = i16vec4(ivec4(-5, 0, -8, -9));
	blockC[0].d[1][7] = i16vec4(ivec4(-2, 8, -8, 1));
	blockC[0].d[2][0] = i16vec4(ivec4(3, -8, -2, 5));
	blockC[0].d[2][1] = i16vec4(ivec4(3, 2, 7, 3));
	blockC[0].d[2][2] = i16vec4(ivec4(-2, 5, 2, -2));
	blockC[0].d[2][3] = i16vec4(ivec4(-9, 6, -6, -9));
	blockC[0].d[2][4] = i16vec4(ivec4(9, 5, 3, -6));
	blockC[0].d[2][5] = i16vec4(ivec4(8, -7, 7, 9));
	blockC[0].d[2][6] = i16vec4(ivec4(3, -8, 1, 3));
	blockC[0].d[2][7] = i16vec4(ivec4(-5, 6, 2, 6));
	blockC[0].d[3][0] = i16vec4(ivec4(2, -7, -4, -5));
	blockC[0].d[3][1] = i16vec4(ivec4(-4, 2, -8, -4));
	blockC[0].d[3][2] = i16vec4(ivec4(1, -3, 8, 2));
	blockC[0].d[3][3] = i16vec4(ivec4(1, -5, -7, 3));
	blockC[0].d[3][4] = i16vec4(ivec4(3, 2, 6, 3));
	blockC[0].d[3][5] = i16vec4(ivec4(-8, 2, 0, -4));
	blockC[0].d[3][6] = i16vec4(ivec4(-6, 0, 5, 8));
	blockC[0].d[3][7] = i16vec4(ivec4(6, 8, 1, 1));
}
#version 450
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
	float16_t a[];
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

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

layout(std430, row_major, binding = 1) buffer BlockB
{
	highp mat3x4 a;
	bvec2 b;
	uint8_t c;
	lowp ivec4 d;
};
layout(std140, binding = 2) buffer BlockC
{
	lowp vec2 e;
	i8vec3 f;
	mediump float g;
	u8vec4 h;
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	highp ivec3 i;
	i8vec2 j;
	mediump vec3 k;
	i8vec2 l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((b), bvec2(true, false)) && allOk;
	allOk = compare_uint8_t(uint(c), 6u) && allOk;
	allOk = compare_vec2((blockC.e), vec2(6.0, -8.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f), ivec3(7, 4294967293, 4294967287)) && allOk;
	allOk = compare_float((blockC.g), 9.0) && allOk;
	allOk = compare_ivec3((i), ivec3(-4, 1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(j), ivec2(4294967295, 6)) && allOk;
	allOk = compare_vec3((k), vec3(-9.0, -2.0, -2.0)) && allOk;
	allOk = compare_i8vec2(ivec2(l), ivec2(1, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x4(5.0, 9.0, 0.0, 2.0, -5.0, -5.0, -1.0, -4.0, 3.0, -5.0, -9.0, -8.0));
	c = uint8_t(3u);
	d = (ivec4(-3, -7, -4, -2));
	blockC.f = i8vec3(ivec3(4294967291, 9, 4294967295));
	blockC.g = (1.0);
	blockC.h = u8vec4(uvec4(2u, 3u, 9u, 4u));
	l = i8vec2(ivec2(1, 3));
}
#version 450
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
	i8vec2 a;
	highp vec4 b;
	u8vec3 c;
	highp ivec2 d;
	u8vec4 e;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	bool f;
	highp mat2 g;
	mediump int h[6];
	lowp uvec4 i;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(a), ivec2(0, 4294967290)) && allOk;
	allOk = compare_vec4((b), vec4(9.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_u8vec3(uvec3(c), uvec3(5u, 5u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (vec4(-9.0, 0.0, 9.0, 2.0));
	c = u8vec3(uvec3(1u, 8u, 5u));
	g = (mat2(-9.0, 9.0, -9.0, 9.0));
	h[0] = (8);
	h[1] = (-1);
	h[2] = (-4);
	h[3] = (0);
	h[4] = (-4);
	h[5] = (2);
	i = (uvec4(5u, 6u, 5u, 7u));
}
#version 450
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
	highp ivec4 a;
	lowp mat3 b;
	mediump mat4 c[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	int8_t d;
	lowp vec3 e;
	highp mat4 f;
	bvec3 g[];
};
layout(std430, row_major, binding = 3) readonly buffer BlockD
{
	highp vec4 h[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(b, mat3(4.0, -8.0, 5.0, 0.0, -6.0, 6.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat4(c[0], mat4(1.0, 7.0, -9.0, 3.0, 8.0, 5.0, -8.0, -7.0, 1.0, 8.0, 6.0, -8.0, -7.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4(c[1], mat4(-9.0, 6.0, -4.0, 8.0, 1.0, -3.0, 6.0, -9.0, 1.0, 8.0, 7.0, -5.0, 3.0, 6.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4(c[2], mat4(-8.0, 5.0, -7.0, 7.0, 9.0, -1.0, -7.0, 2.0, 7.0, 1.0, 7.0, 9.0, -8.0, 7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(c[3], mat4(5.0, 6.0, -3.0, 5.0, 3.0, 9.0, -3.0, -2.0, -6.0, -5.0, -1.0, -1.0, -5.0, 1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4(c[4], mat4(3.0, 6.0, 7.0, 7.0, 2.0, -2.0, 5.0, -5.0, -2.0, 2.0, 9.0, 3.0, 8.0, 3.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4(c[5], mat4(-4.0, 3.0, 2.0, -7.0, -9.0, -2.0, 4.0, 7.0, -2.0, 1.0, 9.0, 0.0, 6.0, 8.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(c[6], mat4(0.0, 6.0, -4.0, 1.0, -5.0, -6.0, 2.0, -4.0, 3.0, 9.0, 4.0, 4.0, -8.0, 0.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(c[7], mat4(6.0, 9.0, -3.0, -1.0, -5.0, 9.0, -5.0, -9.0, 7.0, 8.0, -5.0, -7.0, 6.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_bvec3((g[0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((g[1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((g[2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((g[3]), bvec3(false, true, true)) && allOk;
	allOk = compare_vec4((blockD.h[0]), vec4(5.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_vec4((blockD.h[1]), vec4(2.0, -7.0, -7.0, 2.0)) && allOk;
	allOk = compare_vec4((blockD.h[2]), vec4(5.0, 6.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec4((blockD.h[3]), vec4(1.0, 1.0, -9.0, 3.0)) && allOk;
	allOk = compare_vec4((blockD.h[4]), vec4(9.0, 9.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.h[5]), vec4(0.0, -7.0, -1.0, 3.0)) && allOk;
	allOk = compare_vec4((blockD.h[6]), vec4(-1.0, 6.0, -5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	d = int8_t(3);
	f = (mat4(-5.0, -9.0, -5.0, 2.0, 4.0, 3.0, -1.0, 4.0, -5.0, -4.0, 3.0, -9.0, -5.0, 2.0, -3.0, -9.0));
	g[0] = (bvec3(false, true, false));
	g[1] = (bvec3(false, false, true));
	g[2] = (bvec3(true, false, false));
	g[3] = (bvec3(false, true, false));
}
#version 450
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
	mediump uint mB;
	u8vec4 mC;
};
layout(std430, binding = 1) buffer BlockB
{
	bvec3 a;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp mat3x2 b[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	highp vec4 c;
	sA d[];
} blockD;
layout(std140, row_major, binding = 4) buffer BlockE
{
	lowp vec4 e[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((a), bvec3(true, true, true)) && allOk;
	allOk = compare_vec2((blockD.d[0].mA), vec2(-4.0, 8.0)) && allOk;
	allOk = compare_uint((blockD.d[0].mB), 6u) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.d[0].mC), uvec4(4u, 9u, 9u, 1u)) && allOk;
	allOk = compare_vec4((blockE.e[0]), vec4(-5.0, 2.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec3(true, false, true));
	b[0] = (mat3x2(5.0, 1.0, -9.0, 9.0, 8.0, 5.0));
	blockD.c = (vec4(-4.0, -9.0, -3.0, 7.0));
	blockD.d[0].mA = (vec2(3.0, 2.0));
	blockD.d[0].mB = (2u);
	blockD.d[0].mC = u8vec4(uvec4(3u, 0u, 2u, 7u));
	blockE.e[0] = (vec4(4.0, 9.0, -8.0, -1.0));
}
#version 450
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
	layout(offset = 0) highp uvec3 a;
	layout(offset = 16) mediump vec2 b;
	layout(offset = 24) highp uvec2 c;
} blockB[3];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) u8vec4 d;
	layout(offset = 4) lowp uint e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a), uvec3(7u, 9u, 0u)) && allOk;
	allOk = compare_uvec2((blockB[0].c), uvec2(9u, 7u)) && allOk;
	allOk = compare_uvec3((blockB[1].a), uvec3(4u, 7u, 2u)) && allOk;
	allOk = compare_uvec2((blockB[1].c), uvec2(0u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[2].a), uvec3(4u, 7u, 4u)) && allOk;
	allOk = compare_uvec2((blockB[2].c), uvec2(8u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(d), uvec4(0u, 4u, 8u, 2u)) && allOk;
	allOk = compare_uint((e), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (vec2(-7.0, -3.0));
	blockB[0].c = (uvec2(5u, 3u));
	blockB[1].b = (vec2(5.0, -7.0));
	blockB[1].c = (uvec2(4u, 1u));
	blockB[2].b = (vec2(1.0, 2.0));
	blockB[2].c = (uvec2(7u, 5u));
	d = u8vec4(uvec4(4u, 6u, 8u, 0u));
	e = (2u);
}
#version 450
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
	layout(offset = 0) bool a;
	layout(offset = 4) i8vec3 b;
	layout(offset = 8) lowp float c;
	layout(offset = 16) highp ivec2 d;
	layout(offset = 32) mediump uvec3 e;
} blockB[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB[0].b), ivec3(4, 4294967288, 4294967294)) && allOk;
	allOk = compare_float((blockB[0].c), -7.0) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[1].b), ivec3(4294967295, 4294967287, 4294967293)) && allOk;
	allOk = compare_float((blockB[1].c), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (true);
	blockB[0].c = (-6.0);
	blockB[0].d = (ivec2(-1, -8));
	blockB[0].e = (uvec3(7u, 5u, 6u));
	blockB[1].a = (false);
	blockB[1].c = (-5.0);
	blockB[1].d = (ivec2(8, 3));
	blockB[1].e = (uvec3(8u, 5u, 6u));
}
#version 450
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
	i8vec2 mB;
};
struct sB
{
	u8vec2 mA;
	int8_t mB;
	sA mC;
	mediump ivec4 mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	sB a;
	i8vec3 b;
	bool c;
	u8vec3 d[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	bvec3 e[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB.b), ivec3(4294967291, 1, 2)) && allOk;
	allOk = compare_bool((blockB.c), false) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.d[0]), uvec3(7u, 2u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.d[1]), uvec3(2u, 4u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.d[2]), uvec3(3u, 8u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.d[3]), uvec3(7u, 4u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.d[4]), uvec3(7u, 8u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.d[5]), uvec3(7u, 8u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.d[6]), uvec3(1u, 1u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.d[7]), uvec3(4u, 6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = i8vec3(ivec3(4294967293, 4294967294, 4294967295));
	blockB.c = (true);
	blockC.e[0] = (bvec3(false, true, true));
	blockC.e[1] = (bvec3(true, true, false));
	blockC.e[2] = (bvec3(false, true, true));
}
#version 450
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
	bvec4 mB;
	bool mC;
	mediump uvec4 mD;
};
struct sB
{
	mediump ivec3 mA;
	sA mB[6];
	lowp vec4 mC;
	highp vec4 mD;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	bool a;
	i8vec4 b[2];
	mediump vec3 c;
	sB d;
	i8vec4 e[];
} blockB[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB[0].b[0]), ivec4(4, 4294967288, 4294967294, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[0].b[1]), ivec4(1, 0, 5, 7)) && allOk;
	allOk = compare_vec3((blockB[0].c), vec3(-2.0, -5.0, -1.0)) && allOk;
	allOk = compare_ivec3((blockB[0].d.mA), ivec3(-9, -3, -4)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[0].mA), false) && allOk;
	allOk = compare_bvec4((blockB[0].d.mB[0].mB), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[0].mC), true) && allOk;
	allOk = compare_uvec4((blockB[0].d.mB[0].mD), uvec4(8u, 2u, 9u, 4u)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[1].mA), false) && allOk;
	allOk = compare_bvec4((blockB[0].d.mB[1].mB), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[1].mC), false) && allOk;
	allOk = compare_uvec4((blockB[0].d.mB[1].mD), uvec4(0u, 8u, 7u, 3u)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[2].mA), true) && allOk;
	allOk = compare_bvec4((blockB[0].d.mB[2].mB), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[2].mC), false) && allOk;
	allOk = compare_uvec4((blockB[0].d.mB[2].mD), uvec4(9u, 9u, 2u, 2u)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[3].mA), true) && allOk;
	allOk = compare_bvec4((blockB[0].d.mB[3].mB), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[3].mC), true) && allOk;
	allOk = compare_uvec4((blockB[0].d.mB[3].mD), uvec4(1u, 7u, 0u, 4u)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[4].mA), true) && allOk;
	allOk = compare_bvec4((blockB[0].d.mB[4].mB), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[4].mC), true) && allOk;
	allOk = compare_uvec4((blockB[0].d.mB[4].mD), uvec4(8u, 3u, 1u, 7u)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[5].mA), false) && allOk;
	allOk = compare_bvec4((blockB[0].d.mB[5].mB), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[5].mC), true) && allOk;
	allOk = compare_uvec4((blockB[0].d.mB[5].mD), uvec4(9u, 9u, 8u, 6u)) && allOk;
	allOk = compare_vec4((blockB[0].d.mC), vec4(-1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4((blockB[0].d.mD), vec4(2.0, -8.0, 2.0, -3.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[1].b[0]), ivec4(4294967288, 3, 4294967288, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[1].b[1]), ivec4(3, 4294967293, 3, 4294967290)) && allOk;
	allOk = compare_vec3((blockB[1].c), vec3(-4.0, -8.0, -7.0)) && allOk;
	allOk = compare_ivec3((blockB[1].d.mA), ivec3(6, -5, 9)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[0].mA), true) && allOk;
	allOk = compare_bvec4((blockB[1].d.mB[0].mB), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[0].mC), true) && allOk;
	allOk = compare_uvec4((blockB[1].d.mB[0].mD), uvec4(6u, 7u, 0u, 3u)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[1].mA), false) && allOk;
	allOk = compare_bvec4((blockB[1].d.mB[1].mB), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[1].mC), false) && allOk;
	allOk = compare_uvec4((blockB[1].d.mB[1].mD), uvec4(8u, 2u, 0u, 4u)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[2].mA), true) && allOk;
	allOk = compare_bvec4((blockB[1].d.mB[2].mB), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[2].mC), false) && allOk;
	allOk = compare_uvec4((blockB[1].d.mB[2].mD), uvec4(5u, 9u, 1u, 8u)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[3].mA), true) && allOk;
	allOk = compare_bvec4((blockB[1].d.mB[3].mB), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[3].mC), true) && allOk;
	allOk = compare_uvec4((blockB[1].d.mB[3].mD), uvec4(3u, 6u, 9u, 6u)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[4].mA), true) && allOk;
	allOk = compare_bvec4((blockB[1].d.mB[4].mB), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[4].mC), true) && allOk;
	allOk = compare_uvec4((blockB[1].d.mB[4].mD), uvec4(0u, 5u, 4u, 7u)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[5].mA), true) && allOk;
	allOk = compare_bvec4((blockB[1].d.mB[5].mB), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[5].mC), true) && allOk;
	allOk = compare_uvec4((blockB[1].d.mB[5].mD), uvec4(9u, 2u, 3u, 0u)) && allOk;
	allOk = compare_vec4((blockB[1].d.mC), vec4(1.0, -6.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec4((blockB[1].d.mD), vec4(-1.0, 9.0, -6.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].c = (vec3(1.0, -2.0, 4.0));
	blockB[1].c = (vec3(2.0, -7.0, 9.0));
}
#version 450
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
	bvec2 a;
	u8vec3 b;
} blockB[];

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

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

layout(std140, binding = 1) readonly buffer Block
{
	highp uint var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3(var, mat3(8.0, -3.0, -9.0, 8.0, -4.0, 0.0, -8.0, -7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	i8vec3 var;
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(var), ivec3(4294967295, 4294967290, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var), vec4(-2.0, 4.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2(var, mat2(6.0, 1.0, -4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -3.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-6.0, -3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat3 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x4 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3(var[0], mat3(-4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat4(var[0], mat4(-3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0, -2.0, -9.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0, 0.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0, 4.0, 2.0, -6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bool var[];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((var[0]), false) && allOk;
	allOk = compare_bool((var[1]), true) && allOk;
	allOk = compare_bool((var[2]), true) && allOk;
	allOk = compare_bool((var[3]), false) && allOk;
	allOk = compare_bool((var[4]), false) && allOk;
	allOk = compare_bool((var[5]), true) && allOk;
	allOk = compare_bool((var[6]), true) && allOk;
	allOk = compare_bool((var[7]), false) && allOk;
	allOk = compare_bool((var[8]), false) && allOk;
	allOk = compare_bool((var[9]), false) && allOk;
	allOk = compare_bool((var[10]), false) && allOk;
	allOk = compare_bool((var[11]), true) && allOk;
	allOk = compare_bool((var[12]), true) && allOk;
	allOk = compare_bool((var[13]), false) && allOk;
	allOk = compare_bool((var[14]), true) && allOk;
	allOk = compare_bool((var[15]), true) && allOk;
	allOk = compare_bool((var[16]), false) && allOk;
	allOk = compare_bool((var[17]), true) && allOk;
	allOk = compare_bool((var[18]), false) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x2(var[0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[3], mat3x2(8.0, -7.0, 1.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(4.0, -3.0, -4.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(8.0, 4.0, 1.0, 2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(6.0, 6.0, -8.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(-9.0, -8.0, -5.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(-7.0, -9.0, 9.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(8.0, -7.0, 7.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(2.0, -1.0, 5.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-7.0, -5.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(2.0, -3.0, -1.0, -7.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(1.0, -2.0, -2.0, -2.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(0.0, -1.0, 1.0, 9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(-9.0, 7.0, -7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(7.0, 4.0, 0.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(-3.0, 3.0, -7.0, -9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(7.0, 5.0, -6.0, -4.0, 8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(4, -7, 2)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-2.0, 9.0, 6.0, 2.0, 2.0, -9.0, -7.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(4.0, -1.0, -8.0, 8.0, 0.0, 1.0, 2.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(7.0, -5.0, 1.0, -5.0, 1.0, 6.0, 2.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(1.0, -3.0, 5.0, -5.0, -7.0, -9.0, -3.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(-3.0, 6.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(block.var[0][0], -2.0) && allOk;
	allOk = compare_float(block.var[0][1], -5.0) && allOk;
	allOk = compare_float(block.var[0][2], 0.0) && allOk;
	allOk = compare_float(block.var[0][3], 1.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][2], -8.0) && allOk;
	allOk = compare_float(block.var[1][3], -4.0) && allOk;
	allOk = compare_float(block.var[2][0], 5.0) && allOk;
	allOk = compare_float(block.var[2][1], 8.0) && allOk;
	allOk = compare_float(block.var[2][2], -5.0) && allOk;
	allOk = compare_float(block.var[2][3], -2.0) && allOk;
	allOk = compare_float(block.var[3][0], -9.0) && allOk;
	allOk = compare_float(block.var[3][1], 3.0) && allOk;
	allOk = compare_float(block.var[3][2], -9.0) && allOk;
	allOk = compare_float(block.var[3][3], -2.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-2.0, -5.0, 0.0, 1.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-2.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(5.0, 8.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(-9.0, 3.0, -9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-4.0, -3.0, -1.0, -1.0));
	block.var[1] = (vec4(6.0, -6.0, 8.0, -4.0));
	block.var[2] = (vec4(-5.0, 6.0, 5.0, 5.0));
	block.var[3] = (vec4(3.0, 2.0, -5.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(9.0, 1.0, -4.0, 3.0, 3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(8.0, 9.0, 9.0));
	block.var[1] = (vec3(2.0, -6.0, 2.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(-2.0, -2.0, 2.0, -8.0, -6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(1.0, -9.0));
	block.var[1] = (vec2(-5.0, 5.0));
	block.var[2] = (vec2(6.0, 5.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	i8vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(block.var), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][0], -8.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-9.0, -3.0));
	block.var[1] = (vec2(-8.0, 0.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], 4.0) && allOk;
	allOk = compare_float(block.var[0][2], -6.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], -8.0) && allOk;
	allOk = compare_float(block.var[1][2], 0.0) && allOk;
	allOk = compare_float(block.var[2][0], -1.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], -7.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(0.0, 4.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-4.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-1.0, -6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-8.0, 5.0, -6.0));
	block.var[1] = (vec3(3.0, -6.0, 8.0));
	block.var[2] = (vec3(-7.0, 4.0, -4.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(4.0, 5.0, -8.0, -9.0, -9.0, 3.0, 9.0, 1.0, 7.0, 0.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(4.0, -9.0, -4.0, -7.0, 1.0, -2.0, 9.0, 9.0, -9.0, 4.0, 4.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(3.0, 8.0, -6.0, -8.0, -3.0, 7.0, -7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-7.0, 5.0));
	block.var[1] = (vec2(-3.0, 5.0));
	block.var[2] = (vec2(-2.0, -4.0));
	block.var[3] = (vec2(1.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], -9.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[0][3], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], 8.0) && allOk;
	allOk = compare_float(block.var[1][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][2], -5.0) && allOk;
	allOk = compare_float(block.var[1][3], 2.0) && allOk;
	allOk = compare_float(block.var[2][0], 8.0) && allOk;
	allOk = compare_float(block.var[2][1], -3.0) && allOk;
	allOk = compare_float(block.var[2][2], 7.0) && allOk;
	allOk = compare_float(block.var[2][3], -1.0) && allOk;
	allOk = compare_float(block.var[3][0], -4.0) && allOk;
	allOk = compare_float(block.var[3][1], 5.0) && allOk;
	allOk = compare_float(block.var[3][2], 9.0) && allOk;
	allOk = compare_float(block.var[3][3], 8.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-7.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(8.0, 4.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(8.0, -3.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(-4.0, 5.0, 9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var = (mat4(-2.0, 8.0, -6.0, -2.0, -6.0, 7.0, 0.0, -1.0, 4.0, -8.0, 7.0, -1.0, -3.0, -6.0, -5.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat3x4(block.var, mat3x4(0.0, 2.0, 1.0, -5.0, 7.0, -3.0, -5.0, 8.0, -5.0, 8.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var = (mat3x4(-7.0, 1.0, -4.0, 5.0, 4.0, 1.0, 1.0, 1.0, 8.0, 9.0, 5.0, -6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_float(block.var[0][0], 5.0) && allOk;
	allOk = compare_float(block.var[0][1], -5.0) && allOk;
	allOk = compare_float(block.var[0][2], -1.0) && allOk;
	allOk = compare_float(block.var[0][3], -6.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], 3.0) && allOk;
	allOk = compare_float(block.var[1][2], -6.0) && allOk;
	allOk = compare_float(block.var[1][3], -3.0) && allOk;
	allOk = compare_float(block.var[2][0], 7.0) && allOk;
	allOk = compare_float(block.var[2][1], -8.0) && allOk;
	allOk = compare_float(block.var[2][2], 4.0) && allOk;
	allOk = compare_float(block.var[2][3], -8.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(5.0, -5.0, -1.0, -6.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-1.0, 3.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(7.0, -8.0, 4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0] = (vec4(-8.0, -4.0, -6.0, 8.0));
	block.var[1] = (vec4(-1.0, 9.0, -1.0, 1.0));
	block.var[2] = (vec4(3.0, -5.0, 5.0, -6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_float(block.var[0][0], 5.0) && allOk;
	allOk = compare_float(block.var[0][1], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], 2.0) && allOk;
	allOk = compare_float(block.var[2][0], -4.0) && allOk;
	allOk = compare_float(block.var[2][1], 3.0) && allOk;
	allOk = compare_float(block.var[3][0], 5.0) && allOk;
	allOk = compare_float(block.var[3][1], 7.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(5.0, -5.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-4.0, 3.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var = (mat4x2(-5.0, -6.0, 0.0, 4.0, 2.0, 9.0, 4.0, -2.0));
}
#version 450
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
	highp vec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((block.var[0]), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((block.var[1]), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((block.var[2]), vec3(1.0, -1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(5.0, 4.0, 7.0));
	block.var[1] = (vec3(8.0, -2.0, 7.0));
	block.var[2] = (vec3(-5.0, -7.0, 9.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	block.var[0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	block.var[1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	block.var[1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	block.var[2][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	block.var[2][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	block.var[1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	block.var[2] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
}
#version 450
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
	bvec2 var[3];
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
    if (allOk)
        ac_numPassed++;

	block.var[0] = (bvec2(true, false));
	block.var[1] = (bvec2(true, true));
	block.var[2] = (bvec2(false, false));
}
#version 450
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
	i16vec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(block.var[0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2]), ivec3(6, -5, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i16vec3(ivec3(6, 1, -2));
	block.var[1] = i16vec3(ivec3(-3, -1, -4));
	block.var[2] = i16vec3(ivec3(-2, -2, 2));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat2(block.var[0], mat2(-2.0, -2.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(-4.0, 8.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(9.0, 7.0, -2.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0] = (mat2(-8.0, -7.0, 9.0, 2.0));
	block.var[1] = (mat2(2.0, -4.0, -5.0, -1.0));
	block.var[2] = (mat2(-4.0, 0.0, -1.0, 0.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_mat4(block.var[0], mat4(6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0] = (vec4(-6.0, 8.0, 7.0, -8.0));
	block.var[0][1] = (vec4(6.0, 1.0, -6.0, 6.0));
	block.var[0][2] = (vec4(0.0, -6.0, 3.0, 3.0));
	block.var[0][3] = (vec4(3.0, -3.0, 2.0, -8.0));
	block.var[1][0] = (vec4(9.0, -6.0, 6.0, 1.0));
	block.var[1][1] = (vec4(9.0, -7.0, 4.0, -5.0));
	block.var[1][2] = (vec4(5.0, -6.0, 5.0, 7.0));
	block.var[1][3] = (vec4(7.0, -5.0, -9.0, 7.0));
	block.var[2][0] = (vec4(-2.0, -1.0, -4.0, -3.0));
	block.var[2][1] = (vec4(3.0, -8.0, 7.0, -8.0));
	block.var[2][2] = (vec4(-5.0, -9.0, -1.0, 0.0));
	block.var[2][3] = (vec4(-7.0, 7.0, 8.0, -6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_mat2x3(block.var[0], mat2x3(6.0, -6.0, -6.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(3.0, 1.0, 4.0, -2.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-5.0, -8.0, -7.0, 1.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0] = (mat2x3(-2.0, -5.0, 0.0, 7.0, -2.0, 0.0));
	block.var[1] = (mat2x3(9.0, 9.0, 8.0, -6.0, 3.0, -9.0));
	block.var[2] = (mat2x3(0.0, 1.0, 1.0, 7.0, -8.0, 7.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	highp uint var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.var[0]), 3u) && allOk;
	allOk = compare_uint((block.var[1]), 6u) && allOk;
	allOk = compare_uint((block.var[2]), 9u) && allOk;
	allOk = compare_uint((block.var[3]), 0u) && allOk;
	allOk = compare_uint((block.var[4]), 3u) && allOk;
	allOk = compare_uint((block.var[5]), 7u) && allOk;
	allOk = compare_uint((block.var[6]), 6u) && allOk;
	allOk = compare_uint((block.var[7]), 4u) && allOk;
	allOk = compare_uint((block.var[8]), 2u) && allOk;
	allOk = compare_uint((block.var[9]), 5u) && allOk;
	allOk = compare_uint((block.var[10]), 7u) && allOk;
	allOk = compare_uint((block.var[11]), 5u) && allOk;
	allOk = compare_uint((block.var[12]), 7u) && allOk;
	allOk = compare_uint((block.var[13]), 8u) && allOk;
	allOk = compare_uint((block.var[14]), 6u) && allOk;
	allOk = compare_uint((block.var[15]), 9u) && allOk;
	allOk = compare_uint((block.var[16]), 0u) && allOk;
	allOk = compare_uint((block.var[17]), 1u) && allOk;
	allOk = compare_uint((block.var[18]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (7u);
	block.var[1] = (9u);
	block.var[2] = (1u);
	block.var[3] = (0u);
	block.var[4] = (7u);
	block.var[5] = (7u);
	block.var[6] = (4u);
	block.var[7] = (8u);
	block.var[8] = (7u);
	block.var[9] = (5u);
	block.var[10] = (7u);
	block.var[11] = (2u);
	block.var[12] = (7u);
	block.var[13] = (8u);
	block.var[14] = (6u);
	block.var[15] = (1u);
	block.var[16] = (9u);
	block.var[17] = (8u);
	block.var[18] = (6u);
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(-2.0, -1.0, 3.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(5.0, 8.0, 1.0, -7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(0.0, 9.0, -1.0, -8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(-6.0, 9.0, 9.0, -2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(8.0, -6.0, -2.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(-2.0, -9.0, -1.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(-5.0, -9.0, -3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(-9.0, -1.0, -9.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(-6.0, -1.0, 7.0, -5.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(8.0, -7.0, 1.0, -9.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(3.0, 8.0, -5.0, -1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(9.0, -5.0, 0.0, 0.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(-8.0, -1.0, 3.0, -7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(-7.0, 6.0, -9.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(-7.0, 1.0, 7.0, 2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(5.0, -9.0, 5.0, 6.0, 6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	block.var[1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	block.var[2] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
	block.var[3] = (mat2x3(6.0, 9.0, 2.0, -3.0, 0.0, 5.0));
	block.var[4] = (mat2x3(-9.0, 6.0, -3.0, 9.0, -7.0, 2.0));
	block.var[5] = (mat2x3(8.0, -3.0, 7.0, -9.0, 7.0, -1.0));
	block.var[6] = (mat2x3(-4.0, -3.0, -6.0, -1.0, -5.0, 7.0));
	block.var[7] = (mat2x3(1.0, 9.0, -7.0, 3.0, 3.0, 1.0));
	block.var[8] = (mat2x3(-4.0, -9.0, 4.0, -1.0, -4.0, 1.0));
	block.var[9] = (mat2x3(-7.0, 0.0, -4.0, -6.0, -1.0, -1.0));
	block.var[10] = (mat2x3(5.0, -5.0, 0.0, -6.0, -9.0, -6.0));
	block.var[11] = (mat2x3(-2.0, -1.0, -6.0, -6.0, 3.0, -3.0));
	block.var[12] = (mat2x3(-1.0, -7.0, 4.0, 3.0, 8.0, -7.0));
	block.var[13] = (mat2x3(-1.0, -2.0, 2.0, 6.0, -5.0, 4.0));
	block.var[14] = (mat2x3(-8.0, 0.0, -4.0, 7.0, -5.0, -1.0));
	block.var[15] = (mat2x3(4.0, -6.0, -1.0, -4.0, 7.0, 8.0));
	block.var[16] = (mat2x3(-1.0, 4.0, -9.0, -3.0, -5.0, 8.0));
	block.var[17] = (mat2x3(5.0, -4.0, -4.0, 8.0, 6.0, 4.0));
	block.var[18] = (mat2x3(-9.0, -9.0, 0.0, 3.0, 6.0, -8.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	int16_t var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.var[0]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[1]), 1) && allOk;
	allOk = compare_int16_t(int(block.var[2]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[3]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[4]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[5]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[6]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[7]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[8]), 3) && allOk;
	allOk = compare_int16_t(int(block.var[9]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[10]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[11]), -7) && allOk;
	allOk = compare_int16_t(int(block.var[12]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[13]), 5) && allOk;
	allOk = compare_int16_t(int(block.var[14]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[15]), -3) && allOk;
	allOk = compare_int16_t(int(block.var[16]), -1) && allOk;
	allOk = compare_int16_t(int(block.var[17]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[18]), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = int16_t(6);
	block.var[1] = int16_t(8);
	block.var[2] = int16_t(-2);
	block.var[3] = int16_t(-4);
	block.var[4] = int16_t(-3);
	block.var[5] = int16_t(9);
	block.var[6] = int16_t(-5);
	block.var[7] = int16_t(-8);
	block.var[8] = int16_t(-3);
	block.var[9] = int16_t(2);
	block.var[10] = int16_t(-1);
	block.var[11] = int16_t(4);
	block.var[12] = int16_t(3);
	block.var[13] = int16_t(9);
	block.var[14] = int16_t(6);
	block.var[15] = int16_t(2);
	block.var[16] = int16_t(3);
	block.var[17] = int16_t(7);
	block.var[18] = int16_t(7);
}
#version 450
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
	highp ivec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), 6) && allOk;
	allOk = compare_ivec2((block.var[0][0]), ivec2(-1, 7)) && allOk;
	allOk = compare_ivec2((block.var[0][1]), ivec2(-5, -8)) && allOk;
	allOk = compare_ivec2((block.var[0][2]), ivec2(8, -2)) && allOk;
	allOk = compare_ivec2((block.var[1][0]), ivec2(-6, 6)) && allOk;
	allOk = compare_ivec2((block.var[1][1]), ivec2(2, -2)) && allOk;
	allOk = compare_ivec2((block.var[1][2]), ivec2(7, -1)) && allOk;
	allOk = compare_ivec2((block.var[2][0]), ivec2(-1, 0)) && allOk;
	allOk = compare_ivec2((block.var[2][1]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((block.var[2][2]), ivec2(-5, 6)) && allOk;
	allOk = compare_ivec2((block.var[3][0]), ivec2(4, -8)) && allOk;
	allOk = compare_ivec2((block.var[3][1]), ivec2(3, 7)) && allOk;
	allOk = compare_ivec2((block.var[3][2]), ivec2(-6, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6);
	block.var[0][0] = (ivec2(8, 3));
	block.var[0][1] = (ivec2(-1, -5));
	block.var[0][2] = (ivec2(-2, 0));
	block.var[1][0] = (ivec2(-2, 5));
	block.var[1][1] = (ivec2(2, -8));
	block.var[1][2] = (ivec2(4, -6));
	block.var[2][0] = (ivec2(-4, 3));
	block.var[2][1] = (ivec2(-2, 5));
	block.var[2][2] = (ivec2(-7, -3));
	block.var[3][0] = (ivec2(4, 1));
	block.var[3][1] = (ivec2(6, 8));
	block.var[3][2] = (ivec2(7, 4));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(3.0, 9.0, -7.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(6.0, 5.0, -8.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(-2.0, -2.0, 2.0, 9.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(-5.0, -3.0, -1.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(9.0, 2.0, -2.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(9.0, -1.0, -8.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(9.0, -9.0, -8.0, -9.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-5.0, -6.0, -2.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(-4.0, -4.0, 3.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(-6.0, -8.0, 0.0, -1.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(-4.0, 8.0, 6.0, -2.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(-8.0, 8.0, 5.0, -5.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(1.0, -1.0, 1.0));
	block.var[0][0][0][1] = (vec3(-3.0, 9.0, -8.0));
	block.var[0][0][1][0] = (vec3(-5.0, 6.0, 6.0));
	block.var[0][0][1][1] = (vec3(3.0, -3.0, 7.0));
	block.var[0][0][2][0] = (vec3(-9.0, -2.0, -7.0));
	block.var[0][0][2][1] = (vec3(7.0, 0.0, -8.0));
	block.var[0][1][0][0] = (vec3(0.0, 9.0, -7.0));
	block.var[0][1][0][1] = (vec3(5.0, 6.0, -3.0));
	block.var[0][1][1][0] = (vec3(-6.0, 0.0, -3.0));
	block.var[0][1][1][1] = (vec3(7.0, 9.0, -2.0));
	block.var[0][1][2][0] = (vec3(-7.0, 6.0, -7.0));
	block.var[0][1][2][1] = (vec3(8.0, -6.0, 8.0));
	block.var[1][0][0][0] = (vec3(0.0, -5.0, 5.0));
	block.var[1][0][0][1] = (vec3(-2.0, 4.0, -8.0));
	block.var[1][0][1][0] = (vec3(-3.0, -4.0, 7.0));
	block.var[1][0][1][1] = (vec3(-3.0, -1.0, -9.0));
	block.var[1][0][2][0] = (vec3(2.0, -3.0, 6.0));
	block.var[1][0][2][1] = (vec3(-4.0, 8.0, 2.0));
	block.var[1][1][0][0] = (vec3(4.0, -8.0, 4.0));
	block.var[1][1][0][1] = (vec3(4.0, 5.0, 5.0));
	block.var[1][1][1][0] = (vec3(2.0, 3.0, 6.0));
	block.var[1][1][1][1] = (vec3(-4.0, -4.0, -1.0));
	block.var[1][1][2][0] = (vec3(-3.0, -1.0, -1.0));
	block.var[1][1][2][1] = (vec3(6.0, 2.0, 2.0));
	block.var[2][0][0][0] = (vec3(6.0, -2.0, 0.0));
	block.var[2][0][0][1] = (vec3(3.0, 4.0, -6.0));
	block.var[2][0][1][0] = (vec3(3.0, -6.0, 2.0));
	block.var[2][0][1][1] = (vec3(4.0, -8.0, 0.0));
	block.var[2][0][2][0] = (vec3(-3.0, 3.0, 5.0));
	block.var[2][0][2][1] = (vec3(-6.0, -8.0, 8.0));
	block.var[2][1][0][0] = (vec3(5.0, -2.0, -1.0));
	block.var[2][1][0][1] = (vec3(7.0, -7.0, 5.0));
	block.var[2][1][1][0] = (vec3(-3.0, 6.0, 7.0));
	block.var[2][1][1][1] = (vec3(6.0, -5.0, -2.0));
	block.var[2][1][2][0] = (vec3(2.0, -1.0, 2.0));
	block.var[2][1][2][1] = (vec3(-3.0, 6.0, -3.0));
	block.var[3][0][0][0] = (vec3(4.0, -9.0, -1.0));
	block.var[3][0][0][1] = (vec3(-6.0, 7.0, -3.0));
	block.var[3][0][1][0] = (vec3(2.0, -2.0, 4.0));
	block.var[3][0][1][1] = (vec3(-3.0, -5.0, 9.0));
	block.var[3][0][2][0] = (vec3(-8.0, -1.0, 7.0));
	block.var[3][0][2][1] = (vec3(2.0, 0.0, 5.0));
	block.var[3][1][0][0] = (vec3(-2.0, 0.0, -6.0));
	block.var[3][1][0][1] = (vec3(2.0, -7.0, -2.0));
	block.var[3][1][1][0] = (vec3(1.0, -8.0, -3.0));
	block.var[3][1][1][1] = (vec3(7.0, 3.0, 1.0));
	block.var[3][1][2][0] = (vec3(2.0, -8.0, 6.0));
	block.var[3][1][2][1] = (vec3(-8.0, -7.0, 0.0));
}
#version 450
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
	i16vec3 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(block.var[0][0][0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][0][1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][0][2]), ivec3(6, -5, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][1][0]), ivec3(6, -2, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][1][1]), ivec3(-6, 6, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][1][2]), ivec3(-4, -6, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][0][0]), ivec3(9, 4, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][0][1]), ivec3(-6, 6, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][0][2]), ivec3(2, -1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][1][0]), ivec3(-5, -9, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][1][1]), ivec3(7, -7, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][1][2]), ivec3(2, 6, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][0][0]), ivec3(-1, -4, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][0][1]), ivec3(2, -8, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][0][2]), ivec3(0, -3, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][1][0]), ivec3(-6, 2, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][1][1]), ivec3(-4, 3, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][1][2]), ivec3(-1, 4, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][0][0]), ivec3(-6, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][0][1]), ivec3(5, 1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][0][2]), ivec3(8, 5, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][1][0]), ivec3(2, 8, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][1][1]), ivec3(-8, -6, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][1][2]), ivec3(7, -5, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i16vec3(ivec3(6, 1, -2));
	block.var[0][0][1] = i16vec3(ivec3(-3, -1, -4));
	block.var[0][0][2] = i16vec3(ivec3(-2, -2, 2));
	block.var[0][1][0] = i16vec3(ivec3(-6, 7, -4));
	block.var[0][1][1] = i16vec3(ivec3(-8, 4, 1));
	block.var[0][1][2] = i16vec3(ivec3(5, -4, -6));
	block.var[1][0][0] = i16vec3(ivec3(0, -6, -2));
	block.var[1][0][1] = i16vec3(ivec3(0, -9, 2));
	block.var[1][0][2] = i16vec3(ivec3(-8, 6, 2));
	block.var[1][1][0] = i16vec3(ivec3(-6, 2, -7));
	block.var[1][1][1] = i16vec3(ivec3(-2, 2, -5));
	block.var[1][1][2] = i16vec3(ivec3(-3, -1, 0));
	block.var[2][0][0] = i16vec3(ivec3(-5, -4, -8));
	block.var[2][0][1] = i16vec3(ivec3(0, 9, 6));
	block.var[2][0][2] = i16vec3(ivec3(5, -3, 4));
	block.var[2][1][0] = i16vec3(ivec3(-6, 9, -3));
	block.var[2][1][1] = i16vec3(ivec3(6, 8, 2));
	block.var[2][1][2] = i16vec3(ivec3(7, -2, 2));
	block.var[3][0][0] = i16vec3(ivec3(-3, 9, 0));
	block.var[3][0][1] = i16vec3(ivec3(1, -5, 8));
	block.var[3][0][2] = i16vec3(ivec3(-5, 0, 7));
	block.var[3][1][0] = i16vec3(ivec3(5, -9, -7));
	block.var[3][1][1] = i16vec3(ivec3(4, -3, -4));
	block.var[3][1][2] = i16vec3(ivec3(-6, -4, -6));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0, -9.0, 3.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0, -4.0, 9.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0, -6.0, -7.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0, 7.0, 9.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0, -7.0, 1.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0, 8.0, -8.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0, -4.0, 2.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0, 3.0, 9.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0, -4.0, -9.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0, -4.0, -6.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0, 2.0, -1.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0, 1.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0, 0.0, -7.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0, 9.0, -9.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(-9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0, -2.0, -1.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0, -2.0, 7.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(4.0, -7.0, 8.0, -2.0, -7.0, -1.0, 9.0, 0.0, 0.0, -2.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(4.0, 9.0, 5.0, 4.0, 9.0, -4.0, 5.0, 4.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(-3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0, 1.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0, 5.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0, 4.0, 1.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(-3.0, 3.0, -7.0, 4.0, 1.0, 0.0, 9.0, 9.0, 0.0, -7.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(-2.0, 8.0, 8.0, 5.0, 3.0, -7.0, -8.0, -4.0, 9.0, 4.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(-6.0, 9.0, 2.0, 4.0, 4.0, 1.0, -1.0, -6.0, -3.0, 1.0, -8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var[0][0][0][0] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block.var[0][0][0][1] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block.var[0][0][0][2] = (vec4(-4.0, 2.0, -3.0, 0.0));
	block.var[0][0][1][0] = (vec4(5.0, 2.0, 6.0, 6.0));
	block.var[0][0][1][1] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block.var[0][0][1][2] = (vec4(6.0, 0.0, 6.0, 3.0));
	block.var[0][0][2][0] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block.var[0][0][2][1] = (vec4(7.0, -8.0, -3.0, -2.0));
	block.var[0][0][2][2] = (vec4(-3.0, 6.0, -2.0, 6.0));
	block.var[0][1][0][0] = (vec4(9.0, 5.0, 9.0, -1.0));
	block.var[0][1][0][1] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[0][1][0][2] = (vec4(2.0, 8.0, -5.0, 0.0));
	block.var[0][1][1][0] = (vec4(4.0, 1.0, 9.0, 9.0));
	block.var[0][1][1][1] = (vec4(-9.0, -5.0, 3.0, 8.0));
	block.var[0][1][1][2] = (vec4(-4.0, 7.0, 1.0, 4.0));
	block.var[0][1][2][0] = (vec4(-5.0, 4.0, -2.0, -4.0));
	block.var[0][1][2][1] = (vec4(8.0, -7.0, -1.0, -9.0));
	block.var[0][1][2][2] = (vec4(-1.0, -2.0, 2.0, 8.0));
	block.var[1][0][0][0] = (vec4(-5.0, -8.0, -9.0, -8.0));
	block.var[1][0][0][1] = (vec4(9.0, 0.0, 3.0, -4.0));
	block.var[1][0][0][2] = (vec4(4.0, -5.0, 8.0, 0.0));
	block.var[1][0][1][0] = (vec4(9.0, -8.0, -1.0, -7.0));
	block.var[1][0][1][1] = (vec4(1.0, 2.0, 0.0, -9.0));
	block.var[1][0][1][2] = (vec4(-6.0, 5.0, 1.0, 2.0));
	block.var[1][0][2][0] = (vec4(-7.0, 0.0, 3.0, 4.0));
	block.var[1][0][2][1] = (vec4(4.0, 5.0, 2.0, -3.0));
	block.var[1][0][2][2] = (vec4(0.0, 5.0, -4.0, 0.0));
	block.var[1][1][0][0] = (vec4(0.0, 6.0, 0.0, 2.0));
	block.var[1][1][0][1] = (vec4(-1.0, -5.0, -6.0, -4.0));
	block.var[1][1][0][2] = (vec4(5.0, 3.0, 6.0, -3.0));
	block.var[1][1][1][0] = (vec4(-8.0, -8.0, 1.0, 7.0));
	block.var[1][1][1][1] = (vec4(-6.0, -3.0, -7.0, 1.0));
	block.var[1][1][1][2] = (vec4(-5.0, -4.0, -4.0, -5.0));
	block.var[1][1][2][0] = (vec4(6.0, 2.0, 5.0, 5.0));
	block.var[1][1][2][1] = (vec4(5.0, -1.0, -7.0, -1.0));
	block.var[1][1][2][2] = (vec4(5.0, 0.0, 1.0, 1.0));
	block.var[2][0][0][0] = (vec4(3.0, -2.0, -3.0, 1.0));
	block.var[2][0][0][1] = (vec4(-5.0, -9.0, -7.0, -7.0));
	block.var[2][0][0][2] = (vec4(-7.0, 3.0, -8.0, -2.0));
	block.var[2][0][1][0] = (vec4(7.0, -6.0, -4.0, 6.0));
	block.var[2][0][1][1] = (vec4(-5.0, -4.0, -8.0, -4.0));
	block.var[2][0][1][2] = (vec4(-9.0, -7.0, -8.0, 9.0));
	block.var[2][0][2][0] = (vec4(-6.0, -4.0, 5.0, -5.0));
	block.var[2][0][2][1] = (vec4(-5.0, 7.0, 6.0, 6.0));
	block.var[2][0][2][2] = (vec4(-2.0, 7.0, -9.0, 0.0));
	block.var[2][1][0][0] = (vec4(5.0, 8.0, 5.0, -9.0));
	block.var[2][1][0][1] = (vec4(7.0, -9.0, 0.0, -3.0));
	block.var[2][1][0][2] = (vec4(-1.0, -4.0, 2.0, -6.0));
	block.var[2][1][1][0] = (vec4(5.0, 3.0, 4.0, 8.0));
	block.var[2][1][1][1] = (vec4(7.0, 0.0, -5.0, -6.0));
	block.var[2][1][1][2] = (vec4(6.0, -6.0, -5.0, 5.0));
	block.var[2][1][2][0] = (vec4(3.0, -1.0, -7.0, 0.0));
	block.var[2][1][2][1] = (vec4(-1.0, 6.0, -6.0, 1.0));
	block.var[2][1][2][2] = (vec4(0.0, 8.0, 4.0, 0.0));
	block.var[3][0][0][0] = (vec4(-7.0, 6.0, -7.0, -1.0));
	block.var[3][0][0][1] = (vec4(-6.0, -6.0, 2.0, 8.0));
	block.var[3][0][0][2] = (vec4(9.0, -3.0, -9.0, -6.0));
	block.var[3][0][1][0] = (vec4(2.0, 0.0, 0.0, -2.0));
	block.var[3][0][1][1] = (vec4(-9.0, -3.0, 2.0, 2.0));
	block.var[3][0][1][2] = (vec4(6.0, -8.0, -3.0, -7.0));
	block.var[3][0][2][0] = (vec4(-3.0, 1.0, -7.0, 9.0));
	block.var[3][0][2][1] = (vec4(-9.0, -8.0, 0.0, 8.0));
	block.var[3][0][2][2] = (vec4(-4.0, 9.0, 7.0, 6.0));
	block.var[3][1][0][0] = (vec4(-6.0, 8.0, -5.0, -1.0));
	block.var[3][1][0][1] = (vec4(0.0, 6.0, -9.0, 9.0));
	block.var[3][1][0][2] = (vec4(8.0, 0.0, 9.0, 8.0));
	block.var[3][1][1][0] = (vec4(1.0, 4.0, -3.0, -6.0));
	block.var[3][1][1][1] = (vec4(2.0, -2.0, -2.0, 3.0));
	block.var[3][1][1][2] = (vec4(-2.0, -5.0, 0.0, -5.0));
	block.var[3][1][2][0] = (vec4(-6.0, 0.0, 1.0, 9.0));
	block.var[3][1][2][1] = (vec4(2.0, 5.0, -8.0, 5.0));
	block.var[3][1][2][2] = (vec4(-4.0, -6.0, 2.0, 5.0));
}
#version 450
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
	i8vec3 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(block.var[0][0][0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][0][1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][1][0]), ivec3(4294967289, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][1][1]), ivec3(8, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][2][0]), ivec3(7, 1, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][2][1]), ivec3(4294967294, 5, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][3][0]), ivec3(1, 4294967293, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0][3][1]), ivec3(4294967289, 4294967289, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][0][0]), ivec3(7, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][0][1]), ivec3(5, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][1][0]), ivec3(2, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][1][1]), ivec3(1, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][2][0]), ivec3(4294967295, 1, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][2][1]), ivec3(4294967292, 7, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][3][0]), ivec3(3, 4294967288, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1][3][1]), ivec3(3, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][0][0]), ivec3(9, 0, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][0][1]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][1][0]), ivec3(9, 7, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][1][1]), ivec3(2, 4294967294, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][2][0]), ivec3(4294967290, 4294967291, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][2][1]), ivec3(9, 4294967290, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][3][0]), ivec3(4294967292, 3, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2][3][1]), ivec3(4294967295, 4294967291, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i8vec3(ivec3(4294967292, 0, 0));
	block.var[0][0][1] = i8vec3(ivec3(7, 9, 4294967290));
	block.var[0][1][0] = i8vec3(ivec3(4294967293, 4294967295, 3));
	block.var[0][1][1] = i8vec3(ivec3(5, 4294967292, 4294967295));
	block.var[0][2][0] = i8vec3(ivec3(7, 4294967293, 7));
	block.var[0][2][1] = i8vec3(ivec3(4294967293, 4294967288, 2));
	block.var[0][3][0] = i8vec3(ivec3(4294967288, 4, 8));
	block.var[0][3][1] = i8vec3(ivec3(4294967288, 4294967293, 1));
	block.var[1][0][0] = i8vec3(ivec3(4294967288, 9, 4294967288));
	block.var[1][0][1] = i8vec3(ivec3(4294967293, 3, 4294967295));
	block.var[1][1][0] = i8vec3(ivec3(4294967293, 8, 4294967290));
	block.var[1][1][1] = i8vec3(ivec3(3, 7, 4));
	block.var[1][2][0] = i8vec3(ivec3(4294967287, 4294967295, 4294967293));
	block.var[1][2][1] = i8vec3(ivec3(4294967292, 4294967290, 4294967295));
	block.var[1][3][0] = i8vec3(ivec3(4294967290, 4294967289, 6));
	block.var[1][3][1] = i8vec3(ivec3(4294967295, 4294967289, 1));
	block.var[2][0][0] = i8vec3(ivec3(9, 7, 5));
	block.var[2][0][1] = i8vec3(ivec3(5, 4294967293, 6));
	block.var[2][1][0] = i8vec3(ivec3(4294967292, 8, 8));
	block.var[2][1][1] = i8vec3(ivec3(4294967294, 8, 1));
	block.var[2][2][0] = i8vec3(ivec3(4294967287, 1, 4294967288));
	block.var[2][2][1] = i8vec3(ivec3(4294967291, 8, 6));
	block.var[2][3][0] = i8vec3(ivec3(4294967292, 4294967295, 4294967292));
	block.var[2][3][1] = i8vec3(ivec3(4294967287, 1, 8));
}
#version 450
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
	i16vec3 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(block.var[0][0][0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][0][1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][1][0]), ivec3(-1, -4, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][1][1]), ivec3(2, -8, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][2][0]), ivec3(6, -2, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][2][1]), ivec3(-6, 6, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][3][0]), ivec3(-6, 2, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][3][1]), ivec3(-4, 3, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][0][0]), ivec3(6, -5, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][0][1]), ivec3(9, 4, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][1][0]), ivec3(0, -3, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][1][1]), ivec3(-6, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][2][0]), ivec3(-4, -6, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][2][1]), ivec3(-5, -9, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][3][0]), ivec3(-1, 4, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][3][1]), ivec3(2, 8, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][0][0]), ivec3(-6, 6, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][0][1]), ivec3(2, -1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][1][0]), ivec3(5, 1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][1][1]), ivec3(8, 5, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][2][0]), ivec3(7, -7, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][2][1]), ivec3(2, 6, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][3][0]), ivec3(-8, -6, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][3][1]), ivec3(7, -5, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i16vec3(ivec3(6, 1, -2));
	block.var[0][0][1] = i16vec3(ivec3(-3, -1, -4));
	block.var[0][1][0] = i16vec3(ivec3(-5, -4, -8));
	block.var[0][1][1] = i16vec3(ivec3(0, 9, 6));
	block.var[0][2][0] = i16vec3(ivec3(-6, 7, -4));
	block.var[0][2][1] = i16vec3(ivec3(-8, 4, 1));
	block.var[0][3][0] = i16vec3(ivec3(-6, 9, -3));
	block.var[0][3][1] = i16vec3(ivec3(6, 8, 2));
	block.var[1][0][0] = i16vec3(ivec3(-2, -2, 2));
	block.var[1][0][1] = i16vec3(ivec3(0, -6, -2));
	block.var[1][1][0] = i16vec3(ivec3(5, -3, 4));
	block.var[1][1][1] = i16vec3(ivec3(-3, 9, 0));
	block.var[1][2][0] = i16vec3(ivec3(5, -4, -6));
	block.var[1][2][1] = i16vec3(ivec3(-6, 2, -7));
	block.var[1][3][0] = i16vec3(ivec3(7, -2, 2));
	block.var[1][3][1] = i16vec3(ivec3(5, -9, -7));
	block.var[2][0][0] = i16vec3(ivec3(0, -9, 2));
	block.var[2][0][1] = i16vec3(ivec3(-8, 6, 2));
	block.var[2][1][0] = i16vec3(ivec3(1, -5, 8));
	block.var[2][1][1] = i16vec3(ivec3(-5, 0, 7));
	block.var[2][2][0] = i16vec3(ivec3(-2, 2, -5));
	block.var[2][2][1] = i16vec3(ivec3(-3, -1, 0));
	block.var[2][3][0] = i16vec3(ivec3(4, -3, -4));
	block.var[2][3][1] = i16vec3(ivec3(-6, -4, -6));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
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

layout(scalar, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(8.0, -3.0, 9.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(2.0, 4.0, 5.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-2.0, -1.0, 1.0, 0.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(-1.0, -3.0, 9.0, 9.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(1.0, -7.0, 3.0, -9.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(-9.0, 8.0, -7.0, 5.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-7.0, 6.0, -9.0, 5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(0.0, 1.0, 8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-4.0, 8.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(6.0, -9.0, 0.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(-9.0, 7.0, 0.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(8.0, -4.0, 2.0, 5.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(-2.0, -3.0, -5.0, 2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(8.0, -3.0, -5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-1.0, 3.0, 2.0, -6.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-5.0, -5.0, 2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-7.0, -1.0, -4.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(-7.0, -4.0, -4.0, 2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(-7.0, -7.0, -2.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(-4.0, 8.0, -4.0, -9.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(-7.0, -8.0, -2.0, -7.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	block.var[0][0][1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	block.var[0][1][0] = (mat3x2(0.0, 0.0, 2.0, -7.0, 5.0, 1.0));
	block.var[0][1][1] = (mat3x2(6.0, 0.0, -1.0, -4.0, -5.0, -3.0));
	block.var[0][2][0] = (mat3x2(9.0, 9.0, -7.0, 5.0, 9.0, -1.0));
	block.var[0][2][1] = (mat3x2(1.0, 7.0, 8.0, 8.0, -1.0, 5.0));
	block.var[0][3][0] = (mat3x2(1.0, -2.0, -7.0, 8.0, -1.0, 1.0));
	block.var[0][3][1] = (mat3x2(2.0, -3.0, 1.0, -9.0, -8.0, 9.0));
	block.var[1][0][0] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
	block.var[1][0][1] = (mat3x2(-4.0, -9.0, 4.0, 7.0, 9.0, 7.0));
	block.var[1][1][0] = (mat3x2(-8.0, 4.0, -1.0, 9.0, -1.0, 7.0));
	block.var[1][1][1] = (mat3x2(-8.0, -3.0, 6.0, 0.0, 4.0, 4.0));
	block.var[1][2][0] = (mat3x2(-7.0, -7.0, 7.0, -7.0, -4.0, 0.0));
	block.var[1][2][1] = (mat3x2(-4.0, -8.0, -1.0, 6.0, -9.0, 7.0));
	block.var[1][3][0] = (mat3x2(-7.0, 8.0, -6.0, -5.0, -8.0, 8.0));
	block.var[1][3][1] = (mat3x2(-5.0, 1.0, 4.0, -7.0, -6.0, -8.0));
	block.var[2][0][0] = (mat3x2(9.0, -1.0, -5.0, 6.0, -2.0, 6.0));
	block.var[2][0][1] = (mat3x2(-6.0, -8.0, 1.0, 5.0, 7.0, 1.0));
	block.var[2][1][0] = (mat3x2(-8.0, 8.0, -9.0, -4.0, 5.0, 5.0));
	block.var[2][1][1] = (mat3x2(4.0, 7.0, -3.0, 2.0, 8.0, 5.0));
	block.var[2][2][0] = (mat3x2(-9.0, 2.0, 5.0, -2.0, 2.0, -7.0));
	block.var[2][2][1] = (mat3x2(-7.0, 2.0, 5.0, 0.0, 1.0, -6.0));
	block.var[2][3][0] = (mat3x2(5.0, -9.0, 2.0, 0.0, -8.0, -6.0));
	block.var[2][3][1] = (mat3x2(8.0, 7.0, 3.0, 8.0, -8.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(8.0, -9.0, 9.0, -6.0, -8.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(3.0, 6.0, -4.0, 1.0, 5.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(0.0, 7.0, -8.0, 7.0, 2.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(5.0, -3.0, 1.0, -3.0, -2.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(-5.0, 5.0, 2.0, -9.0, -1.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(-9.0, -9.0, 4.0, 4.0, 6.0, -7.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(6.0, 8.0, 7.0, 0.0, -5.0, 3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(-9.0, 9.0, -5.0, 9.0, -3.0, 8.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(2.0, -9.0, 8.0, 9.0, 2.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-6.0, 7.0, 6.0, 4.0, 1.0, -8.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-6.0, 2.0, 4.0, 7.0, -8.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-4.0, 3.0, 2.0, -4.0, -2.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-2.0, -4.0, 4.0, 7.0, 4.0, 9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(-8.0, 0.0, -3.0, -4.0, 4.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(-6.0, 7.0, 6.0, -8.0, 7.0, 6.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(-7.0, 0.0, -1.0, 6.0, -3.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(7.0, 6.0, -2.0, -3.0, 3.0, 9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(3.0, -3.0, 6.0, -6.0, -5.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-7.0, 1.0, 1.0, 6.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(0.0, 8.0, -2.0, 7.0, 8.0, -1.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(7.0, 6.0, -7.0, 5.0, 0.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(7.0, -5.0, 3.0, -8.0, 1.0, -3.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(-3.0, -5.0, -2.0, -9.0, 3.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-6.0, -2.0, -3.0, -3.0, -9.0, 4.0, -5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(4.0, -9.0));
	block.var[0][0][0][1] = (vec2(-2.0, 8.0));
	block.var[0][0][0][2] = (vec2(-4.0, 4.0));
	block.var[0][0][0][3] = (vec2(9.0, 5.0));
	block.var[0][0][1][0] = (vec2(-2.0, 4.0));
	block.var[0][0][1][1] = (vec2(6.0, -8.0));
	block.var[0][0][1][2] = (vec2(-5.0, -1.0));
	block.var[0][0][1][3] = (vec2(9.0, 0.0));
	block.var[0][1][0][0] = (vec2(6.0, 4.0));
	block.var[0][1][0][1] = (vec2(5.0, 2.0));
	block.var[0][1][0][2] = (vec2(6.0, -4.0));
	block.var[0][1][0][3] = (vec2(-4.0, 8.0));
	block.var[0][1][1][0] = (vec2(5.0, -1.0));
	block.var[0][1][1][1] = (vec2(7.0, 0.0));
	block.var[0][1][1][2] = (vec2(-7.0, -4.0));
	block.var[0][1][1][3] = (vec2(1.0, -1.0));
	block.var[0][2][0][0] = (vec2(-8.0, 0.0));
	block.var[0][2][0][1] = (vec2(-4.0, 6.0));
	block.var[0][2][0][2] = (vec2(-7.0, 4.0));
	block.var[0][2][0][3] = (vec2(-6.0, -5.0));
	block.var[0][2][1][0] = (vec2(-2.0, 7.0));
	block.var[0][2][1][1] = (vec2(-3.0, 0.0));
	block.var[0][2][1][2] = (vec2(-8.0, -9.0));
	block.var[0][2][1][3] = (vec2(6.0, 0.0));
	block.var[0][3][0][0] = (vec2(6.0, 5.0));
	block.var[0][3][0][1] = (vec2(3.0, 5.0));
	block.var[0][3][0][2] = (vec2(2.0, 5.0));
	block.var[0][3][0][3] = (vec2(-8.0, 8.0));
	block.var[0][3][1][0] = (vec2(-9.0, 3.0));
	block.var[0][3][1][1] = (vec2(-5.0, 3.0));
	block.var[0][3][1][2] = (vec2(3.0, 5.0));
	block.var[0][3][1][3] = (vec2(9.0, -6.0));
	block.var[1][0][0][0] = (vec2(5.0, -2.0));
	block.var[1][0][0][1] = (vec2(4.0, -5.0));
	block.var[1][0][0][2] = (vec2(-2.0, -4.0));
	block.var[1][0][0][3] = (vec2(6.0, 4.0));
	block.var[1][0][1][0] = (vec2(5.0, 5.0));
	block.var[1][0][1][1] = (vec2(-6.0, -5.0));
	block.var[1][0][1][2] = (vec2(7.0, -6.0));
	block.var[1][0][1][3] = (vec2(8.0, 5.0));
	block.var[1][1][0][0] = (vec2(7.0, -6.0));
	block.var[1][1][0][1] = (vec2(9.0, -9.0));
	block.var[1][1][0][2] = (vec2(7.0, -8.0));
	block.var[1][1][0][3] = (vec2(5.0, -4.0));
	block.var[1][1][1][0] = (vec2(4.0, 3.0));
	block.var[1][1][1][1] = (vec2(9.0, 1.0));
	block.var[1][1][1][2] = (vec2(-6.0, -3.0));
	block.var[1][1][1][3] = (vec2(-7.0, 9.0));
	block.var[1][2][0][0] = (vec2(6.0, -7.0));
	block.var[1][2][0][1] = (vec2(2.0, 3.0));
	block.var[1][2][0][2] = (vec2(-4.0, -6.0));
	block.var[1][2][0][3] = (vec2(5.0, -1.0));
	block.var[1][2][1][0] = (vec2(-8.0, 7.0));
	block.var[1][2][1][1] = (vec2(0.0, 0.0));
	block.var[1][2][1][2] = (vec2(-7.0, -3.0));
	block.var[1][2][1][3] = (vec2(-7.0, -3.0));
	block.var[1][3][0][0] = (vec2(4.0, -3.0));
	block.var[1][3][0][1] = (vec2(-1.0, 3.0));
	block.var[1][3][0][2] = (vec2(0.0, 0.0));
	block.var[1][3][0][3] = (vec2(-4.0, 6.0));
	block.var[1][3][1][0] = (vec2(-3.0, 9.0));
	block.var[1][3][1][1] = (vec2(-9.0, 4.0));
	block.var[1][3][1][2] = (vec2(0.0, 1.0));
	block.var[1][3][1][3] = (vec2(4.0, 4.0));
	block.var[2][0][0][0] = (vec2(5.0, -5.0));
	block.var[2][0][0][1] = (vec2(-6.0, -3.0));
	block.var[2][0][0][2] = (vec2(-1.0, -1.0));
	block.var[2][0][0][3] = (vec2(-2.0, 6.0));
	block.var[2][0][1][0] = (vec2(-1.0, -8.0));
	block.var[2][0][1][1] = (vec2(-5.0, 5.0));
	block.var[2][0][1][2] = (vec2(5.0, 9.0));
	block.var[2][0][1][3] = (vec2(-7.0, 0.0));
	block.var[2][1][0][0] = (vec2(3.0, 5.0));
	block.var[2][1][0][1] = (vec2(3.0, -7.0));
	block.var[2][1][0][2] = (vec2(0.0, 6.0));
	block.var[2][1][0][3] = (vec2(-8.0, -2.0));
	block.var[2][1][1][0] = (vec2(7.0, -6.0));
	block.var[2][1][1][1] = (vec2(2.0, -2.0));
	block.var[2][1][1][2] = (vec2(8.0, 8.0));
	block.var[2][1][1][3] = (vec2(1.0, -3.0));
	block.var[2][2][0][0] = (vec2(2.0, 6.0));
	block.var[2][2][0][1] = (vec2(3.0, 3.0));
	block.var[2][2][0][2] = (vec2(-8.0, -2.0));
	block.var[2][2][0][3] = (vec2(-4.0, 0.0));
	block.var[2][2][1][0] = (vec2(2.0, 5.0));
	block.var[2][2][1][1] = (vec2(2.0, 3.0));
	block.var[2][2][1][2] = (vec2(-3.0, 2.0));
	block.var[2][2][1][3] = (vec2(4.0, 1.0));
	block.var[2][3][0][0] = (vec2(9.0, -8.0));
	block.var[2][3][0][1] = (vec2(-6.0, 2.0));
	block.var[2][3][0][2] = (vec2(-2.0, -9.0));
	block.var[2][3][0][3] = (vec2(-4.0, 6.0));
	block.var[2][3][1][0] = (vec2(1.0, 7.0));
	block.var[2][3][1][1] = (vec2(-8.0, -1.0));
	block.var[2][3][1][2] = (vec2(8.0, 4.0));
	block.var[2][3][1][3] = (vec2(7.0, -3.0));
}
#version 450
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
	allOk = compare_ivec3((block.s.a), ivec3(8, 2, -1)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(-2.0, 7.0, 2.0, 9.0, 0.0, 5.0, 4.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(-3.0, -2.0, -3.0, -7.0, 7.0, -5.0, -4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(1.0, -5.0, -8.0, -8.0, -8.0, -2.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(8.0, -2.0, -6.0, -6.0, -8.0, 6.0, 9.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(-7.0, -1.0, 5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(-1, 0, 1));
	block.s.b[0][0] = (vec3(6.0, -6.0, 5.0));
	block.s.b[0][1] = (vec3(6.0, -9.0, 8.0));
	block.s.b[0][2] = (vec3(1.0, 4.0, -5.0));
	block.s.b[1][0] = (vec3(1.0, 8.0, -2.0));
	block.s.b[1][1] = (vec3(-1.0, -5.0, -4.0));
	block.s.b[1][2] = (vec3(-2.0, 0.0, 2.0));
	block.s.b[2][0] = (vec3(6.0, 8.0, 8.0));
	block.s.b[2][1] = (vec3(8.0, 9.0, 9.0));
	block.s.b[2][2] = (vec3(-4.0, 4.0, -1.0));
	block.s.b[3][0] = (vec3(-8.0, 7.0, 3.0));
	block.s.b[3][1] = (vec3(-6.0, 4.0, -9.0));
	block.s.b[3][2] = (vec3(-1.0, 8.0, 7.0));
	block.s.c = (vec4(2.0, 7.0, -5.0, 3.0));
}
#version 450
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
    Block block[3];
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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(1u, 7u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(3.0, -2.0, -6.0, 3.0, -7.0, -5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(-4.0, -2.0, 5.0, 0.0, 0.0, -6.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(1.0, -4.0, 0.0, -4.0, -8.0, 7.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(9.0, 8.0, 6.0, -9.0, 7.0, 8.0, 9.0, -3.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(-7.0, 6.0, -7.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(6u, 7u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(5.0, -7.0, 2.0, 8.0, -1.0, 6.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(9.0, 0.0, 9.0, 5.0, -1.0, 8.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(-6.0, 6.0, 0.0, 9.0, -7.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(6.0, -5.0, 6.0, 9.0, -3.0, 8.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(3.0, 5.0, -4.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(9u, 8u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(-6.0, -4.0, -2.0, 6.0, -7.0, -5.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(3.0, -7.0, 9.0, 2.0, 5.0, 9.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(3.0, 9.0, 3.0, -6.0, 0.0, 6.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(5.0, -5.0, -5.0, 5.0, 2.0, -2.0, 9.0, 7.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(1.0, 6.0, 3.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(5u, 9u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(-2.0, -4.0, 5.0, 2.0, 1.0, -6.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(-8.0, 7.0, 0.0, -7.0, 7.0, -1.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(-2.0, 3.0, 6.0, 9.0, -3.0, -3.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(8.0, 0.0, 4.0, 1.0, 4.0, -1.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(9.0, -4.0, 6.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(5u, 1u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(4.0, -6.0, -6.0, 1.0, 7.0, -6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(-8.0, 1.0, -1.0, 1.0, 0.0, 9.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(2.0, -2.0, -7.0, 9.0, -3.0, 5.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(2.0, 2.0, -6.0, 4.0, 3.0, 1.0, -6.0, 2.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(-4.0, -5.0, 5.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(0u, 2u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(3.0, 5.0, 0.0, 8.0, 8.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(-1.0, -7.0, -9.0, -2.0, -6.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(-6.0, 8.0, 2.0, 9.0, 5.0, 4.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(-5.0, 2.0, -4.0, -9.0, 5.0, -7.0, 2.0, -7.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(6.0, -9.0, 2.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(4u, 2u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(1.0, 2.0, -3.0, -3.0, -1.0, 7.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(7.0, 8.0, -7.0, -5.0, 2.0, -2.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(0.0, -3.0, 8.0, 2.0, -6.0, -8.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(2.0, 3.0, -3.0, -5.0, 3.0, 8.0, 5.0, -2.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(7.0, -4.0, 7.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(5u, 5u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(5.0, 0.0, 8.0, -8.0, 4.0, 2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(-5.0, -6.0, -8.0, 1.0, 3.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(8.0, -4.0, 8.0, 0.0, -9.0, -6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(-9.0, 9.0, -6.0, 2.0, 6.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(5.0, 0.0, -6.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(0u, 2u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(2.0, 5.0, 7.0, 8.0, -2.0, -1.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(3.0, -5.0, 9.0, -4.0, 2.0, -6.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(4.0, 1.0, -5.0, -6.0, 2.0, 2.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(0.0, 9.0, 7.0, -9.0, 4.0, -8.0, 8.0, 4.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(7.0, 5.0, -2.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(4u, 8u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(-9.0, -3.0, 0.0, 3.0, -6.0, 1.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(-5.0, 9.0, 7.0, -6.0, -3.0, -2.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(7.0, 0.0, 3.0, 8.0, -5.0, 9.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(1.0, 7.0, 1.0, 5.0, -3.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(-5.0, -8.0, 9.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(4u, 5u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(9.0, 1.0, -8.0, 5.0, 4.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(-2.0, 6.0, 7.0, 8.0, 0.0, 8.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(-8.0, -7.0, -4.0, -8.0, 8.0, 0.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(-6.0, 7.0, 2.0, -6.0, 9.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(-9.0, 7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (2u);
	block[0].s[0].a = (uvec2(7u, 1u));
	block[0].s[0].b[0] = (mat2x4(-8.0, 9.0, 5.0, 0.0, -1.0, 6.0, 9.0, -7.0));
	block[0].s[0].b[1] = (mat2x4(-2.0, 1.0, -6.0, -5.0, 3.0, 8.0, -6.0, 6.0));
	block[0].s[0].b[2] = (mat2x4(1.0, -8.0, 5.0, -6.0, -4.0, 9.0, 4.0, 0.0));
	block[0].s[0].b[3] = (mat2x4(5.0, 3.0, -9.0, -6.0, -3.0, -3.0, -9.0, 6.0));
	block[0].s[0].c = (vec3(3.0, 0.0, -5.0));
	block[0].s[1].a = (uvec2(5u, 3u));
	block[0].s[1].b[0] = (mat2x4(-5.0, -7.0, 6.0, 3.0, 4.0, 6.0, 7.0, 8.0));
	block[0].s[1].b[1] = (mat2x4(5.0, 1.0, 2.0, 4.0, -6.0, -7.0, -6.0, -2.0));
	block[0].s[1].b[2] = (mat2x4(9.0, 0.0, -6.0, -7.0, 7.0, -5.0, 5.0, 9.0));
	block[0].s[1].b[3] = (mat2x4(7.0, -2.0, -9.0, -2.0, 6.0, 8.0, 1.0, -5.0));
	block[0].s[1].c = (vec3(1.0, -6.0, 1.0));
	block[0].s[2].a = (uvec2(4u, 3u));
	block[0].s[2].b[0] = (mat2x4(-4.0, 0.0, 2.0, -1.0, 1.0, 5.0, 2.0, 4.0));
	block[0].s[2].b[1] = (mat2x4(5.0, 8.0, 6.0, 7.0, 9.0, -1.0, 5.0, 5.0));
	block[0].s[2].b[2] = (mat2x4(-6.0, -7.0, -4.0, 2.0, -1.0, 5.0, -3.0, 3.0));
	block[0].s[2].b[3] = (mat2x4(4.0, 0.0, 3.0, -5.0, 0.0, -7.0, 1.0, -7.0));
	block[0].s[2].c = (vec3(6.0, -6.0, 3.0));
	block[0].s[3].a = (uvec2(1u, 4u));
	block[0].s[3].b[0] = (mat2x4(-8.0, -3.0, 0.0, 7.0, 9.0, 9.0, 1.0, -4.0));
	block[0].s[3].b[1] = (mat2x4(2.0, 4.0, -1.0, -6.0, 3.0, 6.0, -1.0, 6.0));
	block[0].s[3].b[2] = (mat2x4(6.0, -7.0, 7.0, 2.0, -2.0, -8.0, 6.0, 6.0));
	block[0].s[3].b[3] = (mat2x4(9.0, -8.0, -9.0, -6.0, 3.0, -5.0, 7.0, 4.0));
	block[0].s[3].c = (vec3(-3.0, -9.0, 3.0));
	block[1].v = (7u);
	block[1].s[0].a = (uvec2(1u, 0u));
	block[1].s[0].b[0] = (mat2x4(3.0, -3.0, 8.0, 1.0, 0.0, -1.0, 8.0, -9.0));
	block[1].s[0].b[1] = (mat2x4(-5.0, 9.0, 6.0, -1.0, -5.0, -8.0, 3.0, -3.0));
	block[1].s[0].b[2] = (mat2x4(-3.0, -7.0, 0.0, -4.0, -4.0, -9.0, -8.0, 9.0));
	block[1].s[0].b[3] = (mat2x4(-2.0, 4.0, 0.0, 1.0, 8.0, 5.0, -6.0, -6.0));
	block[1].s[0].c = (vec3(7.0, -8.0, -5.0));
	block[1].s[1].a = (uvec2(6u, 1u));
	block[1].s[1].b[0] = (mat2x4(2.0, 0.0, -2.0, -4.0, 1.0, 7.0, -5.0, 5.0));
	block[1].s[1].b[1] = (mat2x4(-4.0, -1.0, -2.0, -3.0, -6.0, 9.0, 6.0, -4.0));
	block[1].s[1].b[2] = (mat2x4(2.0, 6.0, 1.0, 4.0, 6.0, 9.0, 4.0, 4.0));
	block[1].s[1].b[3] = (mat2x4(-5.0, 8.0, -5.0, -4.0, 6.0, 0.0, 7.0, -3.0));
	block[1].s[1].c = (vec3(2.0, 5.0, 9.0));
	block[1].s[2].a = (uvec2(2u, 5u));
	block[1].s[2].b[0] = (mat2x4(1.0, 2.0, 3.0, 4.0, 5.0, 4.0, -5.0, -3.0));
	block[1].s[2].b[1] = (mat2x4(-5.0, 1.0, -1.0, -7.0, 3.0, -5.0, -6.0, -1.0));
	block[1].s[2].b[2] = (mat2x4(-1.0, -4.0, -6.0, -8.0, 3.0, 4.0, 1.0, 0.0));
	block[1].s[2].b[3] = (mat2x4(8.0, -4.0, 2.0, -9.0, -4.0, -6.0, 2.0, 3.0));
	block[1].s[2].c = (vec3(-9.0, 9.0, 3.0));
	block[1].s[3].a = (uvec2(5u, 0u));
	block[1].s[3].b[0] = (mat2x4(-4.0, 6.0, 4.0, -4.0, -9.0, -2.0, 3.0, 6.0));
	block[1].s[3].b[1] = (mat2x4(-5.0, 7.0, 8.0, -6.0, 1.0, -4.0, -9.0, 7.0));
	block[1].s[3].b[2] = (mat2x4(4.0, -4.0, 0.0, 6.0, -5.0, -2.0, -1.0, 0.0));
	block[1].s[3].b[3] = (mat2x4(2.0, -9.0, 8.0, -9.0, -2.0, -2.0, -8.0, -7.0));
	block[1].s[3].c = (vec3(-1.0, 3.0, -9.0));
	block[2].v = (1u);
	block[2].s[0].a = (uvec2(2u, 7u));
	block[2].s[0].b[0] = (mat2x4(6.0, -6.0, -2.0, -2.0, 2.0, 1.0, -8.0, -6.0));
	block[2].s[0].b[1] = (mat2x4(6.0, -2.0, -1.0, -5.0, -2.0, 3.0, 5.0, 5.0));
	block[2].s[0].b[2] = (mat2x4(6.0, -9.0, -1.0, -6.0, 7.0, 3.0, 3.0, -5.0));
	block[2].s[0].b[3] = (mat2x4(5.0, 2.0, 4.0, 1.0, 5.0, -5.0, 2.0, -4.0));
	block[2].s[0].c = (vec3(5.0, -1.0, -2.0));
	block[2].s[1].a = (uvec2(1u, 1u));
	block[2].s[1].b[0] = (mat2x4(1.0, 5.0, 7.0, 3.0, 3.0, -6.0, -7.0, 9.0));
	block[2].s[1].b[1] = (mat2x4(-8.0, 9.0, -4.0, -9.0, 1.0, -8.0, -7.0, -5.0));
	block[2].s[1].b[2] = (mat2x4(3.0, 0.0, 1.0, -1.0, -6.0, 6.0, 5.0, 4.0));
	block[2].s[1].b[3] = (mat2x4(8.0, -8.0, -4.0, -6.0, 7.0, -1.0, -3.0, 7.0));
	block[2].s[1].c = (vec3(5.0, -8.0, 2.0));
	block[2].s[2].a = (uvec2(9u, 2u));
	block[2].s[2].b[0] = (mat2x4(-3.0, -7.0, 6.0, -5.0, 7.0, -8.0, 8.0, 1.0));
	block[2].s[2].b[1] = (mat2x4(-5.0, 5.0, 7.0, 4.0, -1.0, 6.0, 5.0, -6.0));
	block[2].s[2].b[2] = (mat2x4(6.0, -2.0, -5.0, 4.0, -1.0, 2.0, 3.0, 2.0));
	block[2].s[2].b[3] = (mat2x4(7.0, -1.0, 0.0, 3.0, 1.0, 8.0, -9.0, -5.0));
	block[2].s[2].c = (vec3(-3.0, 3.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x2(block[0].var, mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	block[1].var = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	block[2].var = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
}
#version 450
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
	i16vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(block[0].var), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(block[1].var), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block[2].var), ivec3(6, -5, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = i16vec3(ivec3(6, 1, -2));
	block[1].var = i16vec3(ivec3(-3, -1, -4));
	block[2].var = i16vec3(ivec3(-2, -2, 2));
}
#version 450
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
	allOk = compare_float((block[0].padding), -7.0) && allOk;
	allOk = compare_mat2x4(block[0].var, mat2x4(-1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_float((block[1].padding), 9.0) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(-2.0, -3.0, 3.0, 3.0, 3.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_float((block[2].padding), -4.0) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(1.0, -2.0, -8.0, -7.0, -9.0, 9.0, 4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (4.0);
	block[0].var[0] = (vec4(-6.0, -9.0, -3.0, 5.0));
	block[0].var[1] = (vec4(1.0, -7.0, 1.0, -7.0));
	block[1].padding = (-4.0);
	block[1].var[0] = (vec4(1.0, 9.0, -1.0, -2.0));
	block[1].var[1] = (vec4(2.0, 4.0, -1.0, -9.0));
	block[2].padding = (-6.0);
	block[2].var[0] = (vec4(6.0, -7.0, 5.0, 8.0));
	block[2].var[1] = (vec4(4.0, -8.0, 1.0, 8.0));
}
#version 450
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
	allOk = compare_mat3x4(block[0].var, mat3x4(3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0, 2.0)) && allOk;
	allOk = compare_float((block[1].padding), -8.0) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0, -6.0, -3.0)) && allOk;
	allOk = compare_float((block[2].padding), 5.0) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0, 8.0, -1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-8.0);
	block[0].var = (mat3x4(-6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0, 3.0));
	block[1].padding = (-2.0);
	block[1].var = (mat3x4(-3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0, 1.0, -1.0));
	block[2].padding = (1.0);
	block[2].var = (mat3x4(5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0, -6.0, 7.0, -1.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 6.0) && allOk;
	allOk = compare_mat3x4(block[0].var, mat3x4(7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_float((block[1].padding), -9.0) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -7.0) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(-9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0, -5.0, 7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-3.0);
	block[0].var[0] = (vec4(-5.0, 2.0, 5.0, -2.0));
	block[0].var[1] = (vec4(-3.0, 9.0, -2.0, -6.0));
	block[0].var[2] = (vec4(7.0, 4.0, -6.0, 2.0));
	block[1].padding = (6.0);
	block[1].var[0] = (vec4(9.0, -2.0, 7.0, 9.0));
	block[1].var[1] = (vec4(0.0, 0.0, 8.0, -3.0));
	block[1].var[2] = (vec4(0.0, 3.0, -6.0, 1.0));
	block[2].padding = (9.0);
	block[2].var[0] = (vec4(6.0, -9.0, -9.0, 2.0));
	block[2].var[1] = (vec4(-4.0, -8.0, 5.0, -1.0));
	block[2].var[2] = (vec4(9.0, 8.0, -2.0, 1.0));
}
#version 450
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
    Block block[3];
};

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

layout(std430, buffer_reference) buffer BlockB
{
	bool a;
	lowp int b;
	mediump int c;
	bool d;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp float e;
	bool f;
	bool g;
	highp int h;
	mediump int i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_int((blockB.b), -7) && allOk;
	allOk = compare_bool((blockC.f), true) && allOk;
	allOk = compare_bool((blockC.g), false) && allOk;
	allOk = compare_int((blockC.i), -3) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.c = (-7);
	blockB.d = (false);
	blockC.f = (false);
	blockC.h = (-2);
}
#version 450
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
	mediump ivec2 a[1];
	bool b;
	lowp vec3 c;
	highp ivec2 d;
	highp uvec4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_uvec4((blockB.e), uvec4(5u, 1u, 5u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec2(6, -1));
	blockB.b = (true);
}
#version 450
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
	lowp ivec4 a;
	mediump vec2 b;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	mediump vec4 c;
	bvec2 d;
	bvec2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b), vec2(0.0, -3.0)) && allOk;
	allOk = compare_bvec2((blockC.d), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC.e[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC.e[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC.e[2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC.e[3]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (vec4(0.0, -1.0, -9.0, 2.0));
	blockC.d = (bvec2(false, false));
}
#version 450
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
	bool a;
	lowp uint b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b[0] = (0u);
}
#version 450
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
	bool a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	bvec2 b;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	highp mat4 c;
	highp int d;
	lowp uvec4 e;
	mediump vec4 f;
	mediump mat3 g[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	lowp ivec2 h[5];
	mediump vec3 i;
	mediump mat3x4 j[4];
	highp vec4 k;
	mediump mat4x2 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockD[0].c, mat4(-2.0, -9.0, 1.0, -6.0, -8.0, -5.0, 9.0, 7.0, -8.0, 1.0, 5.0, -5.0, -8.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_uvec4((blockD[0].e), uvec4(4u, 1u, 5u, 6u)) && allOk;
	allOk = compare_vec4((blockD[0].f), vec4(-3.0, 5.0, 0.0, -2.0)) && allOk;
	allOk = compare_vec3((blockE[0].i), vec3(9.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].j[0], mat3x4(-6.0, -3.0, 6.0, -3.0, -3.0, -1.0, -1.0, 9.0, 6.0, 3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].j[1], mat3x4(0.0, 1.0, 7.0, -2.0, -9.0, -5.0, -6.0, 4.0, -9.0, -7.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].j[2], mat3x4(-6.0, -9.0, 2.0, 7.0, 3.0, -4.0, -9.0, -3.0, 0.0, 4.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].j[3], mat3x4(7.0, -3.0, -7.0, 0.0, -5.0, -1.0, 7.0, 2.0, 7.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockE[0].l[0], mat4x2(2.0, -8.0, -3.0, -1.0, 6.0, 7.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockE[0].l[1], mat4x2(4.0, -1.0, -7.0, -8.0, 1.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockE[0].l[2], mat4x2(-2.0, 7.0, -2.0, 7.0, -4.0, -8.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockE[0].l[3], mat4x2(-7.0, 0.0, 4.0, -6.0, 2.0, 5.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockE[0].l[4], mat4x2(7.0, 8.0, 0.0, 7.0, 9.0, 6.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockE[0].l[5], mat4x2(9.0, 3.0, 3.0, -8.0, 1.0, -1.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (true);
	blockB.a[1] = (false);
	blockB.a[2] = (true);
	blockC.b = (bvec2(true, true));
	blockD[0].c = (mat4(8.0, 6.0, 2.0, 9.0, 8.0, 5.0, -5.0, 8.0, -1.0, 7.0, -9.0, -3.0, -1.0, 6.0, -2.0, -4.0));
	blockD[0].d = (9);
	blockD[0].e = (uvec4(8u, 1u, 6u, 5u));
	blockE[0].i = (vec3(-3.0, -1.0, 2.0));
	blockE[0].l[0] = (mat4x2(8.0, 1.0, -2.0, 0.0, 0.0, -7.0, -4.0, 9.0));
	blockE[0].l[1] = (mat4x2(-2.0, 6.0, 6.0, 4.0, 5.0, -9.0, -6.0, -6.0));
	blockE[0].l[2] = (mat4x2(-2.0, -4.0, -6.0, 3.0, -4.0, -9.0, 0.0, 1.0));
	blockE[0].l[3] = (mat4x2(4.0, 3.0, 7.0, 1.0, 2.0, 6.0, 1.0, 4.0));
	blockE[0].l[4] = (mat4x2(-8.0, 2.0, 2.0, 5.0, 7.0, -1.0, -2.0, -4.0));
	blockE[0].l[5] = (mat4x2(-4.0, 5.0, -1.0, 4.0, -8.0, -3.0, 9.0, -2.0));
}
#version 450
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
	mediump vec3 mA;
	mediump mat3x2 mB;
};
struct sB
{
	sA mA;
	bvec3 mB;
	highp ivec2 mC;
	mediump mat3 mD;
};
struct sC
{
	mediump mat3 mA;
};
struct sD
{
	highp mat4 mA;
	lowp mat3x4 mB;
	lowp uvec2 mC;
	sC mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	mediump mat4 a;
	bvec2 b;
	highp ivec3 c[8];
	sB d;
	mediump vec3 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump ivec3 f;
	sD g;
	lowp vec3 h;
	mediump ivec4 i[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	bvec4 j[2];
	mediump mat4x3 k;
	mediump uvec4 l;
	mediump vec4 m;
	highp uint n[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB[0].a, mat4(-1.0, -5.0, -9.0, -9.0, -9.0, 0.0, 8.0, -9.0, -1.0, 6.0, -5.0, -2.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_ivec3((blockB[0].c[0]), ivec3(-2, -3, -6)) && allOk;
	allOk = compare_ivec3((blockB[0].c[1]), ivec3(5, -4, 4)) && allOk;
	allOk = compare_ivec3((blockB[0].c[2]), ivec3(0, 4, -7)) && allOk;
	allOk = compare_ivec3((blockB[0].c[3]), ivec3(4, -5, 3)) && allOk;
	allOk = compare_ivec3((blockB[0].c[4]), ivec3(0, -7, 8)) && allOk;
	allOk = compare_ivec3((blockB[0].c[5]), ivec3(-7, -8, -9)) && allOk;
	allOk = compare_ivec3((blockB[0].c[6]), ivec3(1, -9, 1)) && allOk;
	allOk = compare_ivec3((blockB[0].c[7]), ivec3(7, -6, -6)) && allOk;
	allOk = compare_vec3((blockB[0].d.mA.mA), vec3(-8.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB[0].d.mA.mB, mat3x2(4.0, 5.0, -1.0, 3.0, -1.0, 8.0)) && allOk;
	allOk = compare_bvec3((blockB[0].d.mB), bvec3(false, false, false)) && allOk;
	allOk = compare_ivec2((blockB[0].d.mC), ivec2(-5, -1)) && allOk;
	allOk = compare_mat3(blockB[0].d.mD, mat3(6.0, -3.0, 5.0, 4.0, 7.0, -9.0, -2.0, 2.0, 0.0)) && allOk;
	allOk = compare_vec3((blockB[0].e[0]), vec3(1.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4(blockB[1].a, mat4(-2.0, -3.0, 0.0, 3.0, 4.0, -3.0, -5.0, 6.0, 3.0, 5.0, 6.0, -2.0, -8.0, -2.0, -3.0, -6.0)) && allOk;
	allOk = compare_ivec3((blockB[1].c[0]), ivec3(-5, -7, 4)) && allOk;
	allOk = compare_ivec3((blockB[1].c[1]), ivec3(-9, 1, -8)) && allOk;
	allOk = compare_ivec3((blockB[1].c[2]), ivec3(9, 9, -2)) && allOk;
	allOk = compare_ivec3((blockB[1].c[3]), ivec3(-6, 9, 7)) && allOk;
	allOk = compare_ivec3((blockB[1].c[4]), ivec3(6, 1, 9)) && allOk;
	allOk = compare_ivec3((blockB[1].c[5]), ivec3(-8, 3, -4)) && allOk;
	allOk = compare_ivec3((blockB[1].c[6]), ivec3(-1, -9, 4)) && allOk;
	allOk = compare_ivec3((blockB[1].c[7]), ivec3(6, -7, 4)) && allOk;
	allOk = compare_vec3((blockB[1].d.mA.mA), vec3(-2.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockB[1].d.mA.mB, mat3x2(6.0, 4.0, 7.0, 3.0, -2.0, 5.0)) && allOk;
	allOk = compare_bvec3((blockB[1].d.mB), bvec3(true, false, true)) && allOk;
	allOk = compare_ivec2((blockB[1].d.mC), ivec2(-7, -7)) && allOk;
	allOk = compare_mat3(blockB[1].d.mD, mat3(-7.0, -5.0, -1.0, -1.0, 4.0, 8.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_vec3((blockB[1].e[0]), vec3(0.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec3((blockC.h), vec3(-8.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockD.k, mat4x3(7.0, -4.0, 4.0, 4.0, 9.0, -1.0, 3.0, 3.0, 4.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_uvec4((blockD.l), uvec4(8u, 5u, 7u, 5u)) && allOk;
	allOk = compare_vec4((blockD.m), vec4(7.0, -8.0, 4.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat4(0.0, -7.0, -2.0, -6.0, 0.0, 4.0, -5.0, 5.0, -3.0, 4.0, 9.0, 1.0, -6.0, 4.0, -7.0, 9.0));
	blockB[0].b = (bvec2(true, false));
	blockB[0].c[0] = (ivec3(-7, 9, 7));
	blockB[0].c[1] = (ivec3(-4, -2, -4));
	blockB[0].c[2] = (ivec3(8, -7, 8));
	blockB[0].c[3] = (ivec3(-4, -3, -3));
	blockB[0].c[4] = (ivec3(9, -8, 0));
	blockB[0].c[5] = (ivec3(-4, -2, -4));
	blockB[0].c[6] = (ivec3(9, -1, -7));
	blockB[0].c[7] = (ivec3(9, 3, -6));
	blockB[0].d.mA.mA = (vec3(9.0, 0.0, 5.0));
	blockB[0].d.mA.mB = (mat3x2(-4.0, 6.0, -8.0, 4.0, -1.0, -4.0));
	blockB[0].d.mB = (bvec3(true, true, false));
	blockB[0].d.mC = (ivec2(-2, 9));
	blockB[0].d.mD = (mat3(2.0, 9.0, -7.0, 4.0, 2.0, -5.0, 5.0, 7.0, 9.0));
	blockB[0].e[0] = (vec3(1.0, 4.0, 2.0));
	blockB[1].a = (mat4(2.0, -3.0, -7.0, -2.0, 2.0, 5.0, 4.0, 3.0, -9.0, -8.0, 2.0, 7.0, -5.0, -4.0, 9.0, 9.0));
	blockB[1].b = (bvec2(false, false));
	blockB[1].c[0] = (ivec3(-7, -1, 7));
	blockB[1].c[1] = (ivec3(5, 1, -3));
	blockB[1].c[2] = (ivec3(-7, 6, -3));
	blockB[1].c[3] = (ivec3(3, -5, 2));
	blockB[1].c[4] = (ivec3(-6, 8, -3));
	blockB[1].c[5] = (ivec3(-2, 4, -8));
	blockB[1].c[6] = (ivec3(-5, 2, -9));
	blockB[1].c[7] = (ivec3(-7, 9, -1));
	blockB[1].d.mA.mA = (vec3(9.0, 7.0, 3.0));
	blockB[1].d.mA.mB = (mat3x2(-7.0, 1.0, 2.0, 8.0, 1.0, -9.0));
	blockB[1].d.mB = (bvec3(true, true, true));
	blockB[1].d.mC = (ivec2(-1, 6));
	blockB[1].d.mD = (mat3(5.0, 0.0, 3.0, 1.0, 5.0, -2.0, -7.0, -3.0, -3.0));
	blockB[1].e[0] = (vec3(-9.0, 8.0, -5.0));
	blockC.f = (ivec3(5, -1, -8));
	blockC.i[0] = (ivec4(4, -5, -8, 6));
	blockC.i[1] = (ivec4(2, 5, 7, 3));
	blockC.i[2] = (ivec4(7, -7, 3, -2));
	blockC.i[3] = (ivec4(1, -2, 3, 5));
	blockC.i[4] = (ivec4(0, 0, -7, -7));
	blockC.i[5] = (ivec4(-9, 1, 8, -5));
	blockC.i[6] = (ivec4(-1, -6, -9, 2));
	blockD.j[0] = (bvec4(false, false, true, false));
	blockD.j[1] = (bvec4(false, true, true, true));
	blockD.k = (mat4x3(4.0, 2.0, -2.0, 0.0, 0.0, -4.0, -5.0, 5.0, 8.0, 3.0, 6.0, -6.0));
	blockD.l = (uvec4(5u, 4u, 4u, 3u));
	blockD.m = (vec4(-7.0, 9.0, 0.0, 3.0));
	blockD.n[0] = (0u);
}
#version 450
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
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(-4, 4, -1));
}
#version 450
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
	layout(offset = 0) lowp int a;
	layout(offset = 4) mediump vec3 b;
	layout(offset = 16) highp ivec4 c[1];
	layout(offset = 32) mediump vec2 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bool e;
	layout(offset = 4) highp uint f;
	layout(offset = 8) lowp int g;
	layout(offset = 12) lowp uint h;
	layout(offset = 16) highp ivec2 i;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bool j;
	layout(offset = 4) highp float k;
	layout(offset = 16) highp ivec4 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.b), vec3(2.0, 9.0, -4.0)) && allOk;
	allOk = compare_ivec4((blockB.c[0]), ivec4(-7, -9, 6, -7)) && allOk;
	allOk = compare_uint((blockC.f), 2u) && allOk;
	allOk = compare_int((blockC.g), -2) && allOk;
	allOk = compare_uint((blockC.h), 1u) && allOk;
	allOk = compare_ivec2((blockC.i), ivec2(-8, -3)) && allOk;
	allOk = compare_bool((blockD.j), false) && allOk;
	allOk = compare_float((blockD.k), 4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-4);
	blockB.b = (vec3(-1.0, 9.0, -3.0));
	blockB.c[0] = (ivec4(2, 3, 7, -9));
	blockB.d = (vec2(-2.0, 5.0));
	blockC.e = (true);
	blockC.f = (7u);
	blockC.g = (-1);
	blockC.h = (2u);
	blockD.j = (true);
	blockD.k = (2.0);
	blockD.l = (ivec4(-3, -6, 0, -9));
}
#version 450
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
	layout(offset = 0) lowp int a;
	layout(offset = 16) highp uvec4 b[1];
	layout(offset = 32) bool c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump float d;
	layout(offset = 4) highp ivec3 e;
	layout(offset = 16) highp ivec3 f;
	layout(offset = 32) highp uvec2 g;
	layout(offset = 48) lowp uvec3 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 2) && allOk;
	allOk = compare_uvec4((blockB.b[0]), uvec4(5u, 9u, 0u, 3u)) && allOk;
	allOk = compare_bool((blockB.c), true) && allOk;
	allOk = compare_float((blockC.d), 3.0) && allOk;
	allOk = compare_ivec3((blockC.e), ivec3(-7, -8, 1)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(-8, 9, 8)) && allOk;
	allOk = compare_uvec2((blockC.g), uvec2(9u, 3u)) && allOk;
	allOk = compare_uvec3((blockC.h), uvec3(2u, 9u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (2);
	blockB.c = (true);
	blockC.d = (6.0);
	blockC.e = (ivec3(8, 0, 9));
	blockC.f = (ivec3(-4, -9, 0));
	blockC.g = (uvec2(9u, 9u));
	blockC.h = (uvec3(8u, 9u, 7u));
}
#version 450
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
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockB
{
	bool a[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	mediump mat3 b;
	highp uint c[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	sA d;
	highp vec4 e[6];
	lowp ivec2 f;
	mediump mat3 g;
	highp mat3x2 h;
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockD.d.mA), uvec4(6u, 2u, 1u, 8u)) && allOk;
	allOk = compare_ivec2((blockD.f), ivec2(3, -7)) && allOk;
	allOk = compare_mat3(blockD.g, mat3(6.0, -3.0, -2.0, -3.0, 7.0, 9.0, -3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockD.h, mat3x2(-1.0, 4.0, 5.0, -1.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat3(-9.0, 5.0, 6.0, 5.0, -2.0, 8.0, -2.0, 7.0, 7.0));
	blockD.d.mA = (uvec4(4u, 1u, 9u, 7u));
	blockD.e[0] = (vec4(-9.0, -9.0, -7.0, 5.0));
	blockD.e[1] = (vec4(8.0, -9.0, 1.0, 3.0));
	blockD.e[2] = (vec4(-3.0, -9.0, -6.0, 9.0));
	blockD.e[3] = (vec4(-6.0, -6.0, 0.0, 9.0));
	blockD.e[4] = (vec4(1.0, 6.0, 6.0, -1.0));
	blockD.e[5] = (vec4(6.0, 7.0, 5.0, 2.0));
	blockD.f = (ivec2(-6, 9));
	blockD.g = (mat3(6.0, -7.0, -1.0, 3.0, 5.0, -1.0, 0.0, 0.0, 4.0));
	blockD.h = (mat3x2(-7.0, -7.0, 4.0, -1.0, -2.0, -8.0));
}
#version 450
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
	highp vec3 mA[6][5];
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	bool a;
	bvec2 b;
	sA c;
	mediump mat3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(true, true)) && allOk;
	allOk = compare_vec3((blockB.c.mA[0][0]), vec3(8.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[0][1]), vec3(9.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[0][2]), vec3(6.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[0][3]), vec3(-9.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[0][4]), vec3(2.0, 0.0, -1.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[1][0]), vec3(-6.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[1][1]), vec3(-4.0, -9.0, 3.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[1][2]), vec3(2.0, 9.0, -1.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[1][3]), vec3(-7.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[1][4]), vec3(-3.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[2][0]), vec3(0.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[2][1]), vec3(-6.0, -9.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[2][2]), vec3(8.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[2][3]), vec3(9.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[2][4]), vec3(-4.0, -1.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[3][0]), vec3(3.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[3][1]), vec3(-9.0, 4.0, -1.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[3][2]), vec3(-8.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[3][3]), vec3(4.0, 4.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[3][4]), vec3(6.0, -6.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[4][0]), vec3(6.0, -2.0, 0.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[4][1]), vec3(8.0, 5.0, -7.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[4][2]), vec3(7.0, 4.0, -4.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[4][3]), vec3(-9.0, -2.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[4][4]), vec3(1.0, 0.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[5][0]), vec3(2.0, -1.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[5][1]), vec3(4.0, 0.0, 2.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[5][2]), vec3(3.0, 0.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[5][3]), vec3(-9.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3((blockB.c.mA[5][4]), vec3(-1.0, 2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.c.mA[0][0] = (vec3(0.0, -9.0, -4.0));
	blockB.c.mA[0][1] = (vec3(-9.0, -3.0, -6.0));
	blockB.c.mA[0][2] = (vec3(-6.0, -7.0, -9.0));
	blockB.c.mA[0][3] = (vec3(-4.0, -8.0, -1.0));
	blockB.c.mA[0][4] = (vec3(9.0, 4.0, 4.0));
	blockB.c.mA[1][0] = (vec3(-2.0, -9.0, 7.0));
	blockB.c.mA[1][1] = (vec3(-5.0, 7.0, 4.0));
	blockB.c.mA[1][2] = (vec3(-6.0, -3.0, -8.0));
	blockB.c.mA[1][3] = (vec3(-9.0, 1.0, -3.0));
	blockB.c.mA[1][4] = (vec3(-1.0, 6.0, 6.0));
	blockB.c.mA[2][0] = (vec3(-7.0, 8.0, -6.0));
	blockB.c.mA[2][1] = (vec3(-2.0, -2.0, 8.0));
	blockB.c.mA[2][2] = (vec3(-2.0, 6.0, 7.0));
	blockB.c.mA[2][3] = (vec3(8.0, 4.0, 1.0));
	blockB.c.mA[2][4] = (vec3(6.0, -5.0, 4.0));
	blockB.c.mA[3][0] = (vec3(-7.0, -4.0, -7.0));
	blockB.c.mA[3][1] = (vec3(-4.0, -2.0, -5.0));
	blockB.c.mA[3][2] = (vec3(-4.0, 6.0, 7.0));
	blockB.c.mA[3][3] = (vec3(-5.0, -7.0, -5.0));
	blockB.c.mA[3][4] = (vec3(2.0, -7.0, -8.0));
	blockB.c.mA[4][0] = (vec3(-7.0, 2.0, -2.0));
	blockB.c.mA[4][1] = (vec3(0.0, -8.0, -1.0));
	blockB.c.mA[4][2] = (vec3(-4.0, -2.0, 2.0));
	blockB.c.mA[4][3] = (vec3(8.0, 1.0, 6.0));
	blockB.c.mA[4][4] = (vec3(-6.0, 9.0, -2.0));
	blockB.c.mA[5][0] = (vec3(2.0, 5.0, -3.0));
	blockB.c.mA[5][1] = (vec3(1.0, 4.0, 6.0));
	blockB.c.mA[5][2] = (vec3(-2.0, -1.0, 6.0));
	blockB.c.mA[5][3] = (vec3(7.0, -6.0, -3.0));
	blockB.c.mA[5][4] = (vec3(-5.0, 7.0, 0.0));
}
#version 450
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
	layout(offset = 0) lowp mat4x3 a;
	layout(offset = 64) highp ivec2 b;
	layout(offset = 72) bvec2 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB[nonuniformEXT(0)].a, mat4x3(4.0, -1.0, 1.0, 6.0, 1.0, 9.0, -6.0, -4.0, 2.0, -9.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(1)].a, mat4x3(-1.0, -1.0, -2.0, -7.0, 4.0, 6.0, -4.0, -1.0, 8.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(2)].a, mat4x3(7.0, 3.0, -6.0, -5.0, -3.0, -4.0, -5.0, 8.0, -3.0, 6.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(3)].a, mat4x3(-2.0, 3.0, 3.0, 1.0, 5.0, 8.0, 7.0, -7.0, 6.0, -6.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4x3(5.0, 7.0, -9.0, -6.0, 1.0, -2.0, -1.0, -3.0, -9.0, -9.0, -2.0, -4.0));
	blockB[nonuniformEXT(0)].c = (bvec2(false, true));
	blockB[nonuniformEXT(1)].a = (mat4x3(2.0, -6.0, 5.0, 9.0, 2.0, -1.0, -7.0, 3.0, -7.0, -5.0, 7.0, 5.0));
	blockB[nonuniformEXT(1)].c = (bvec2(true, false));
	blockB[nonuniformEXT(2)].a = (mat4x3(9.0, 5.0, 7.0, -5.0, 9.0, -3.0, 8.0, -3.0, 7.0, -4.0, -9.0, -2.0));
	blockB[nonuniformEXT(2)].c = (bvec2(false, false));
	blockB[nonuniformEXT(3)].a = (mat4x3(5.0, -4.0, 9.0, -2.0, -5.0, -8.0, -4.0, 0.0, 8.0, 2.0, 6.0, 3.0));
	blockB[nonuniformEXT(3)].c = (bvec2(true, true));
}
#version 450
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
	u16vec2 a;
	i16vec2 b[1];
};
layout(std140, buffer_reference) buffer BlockC
{
	bvec3 c;
	u16vec3 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockC.c), bvec3(true, true, false)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.d), uvec3(3u, 4u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = i16vec2(ivec2(-9, -7));
	blockC.c = (bvec3(false, true, false));
	blockC.d = u16vec3(uvec3(6u, 4u, 5u));
}
#version 450
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
	bvec4 a;
	lowp mat3 b;
	int16_t c;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	u16vec4 d;
	lowp vec3 e[3];
	lowp vec4 f[7];
	u16vec3 g;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp ivec4 h;
	lowp ivec4 i;
	i16vec4 j[3];
	lowp mat3x2 k;
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	i16vec4 l;
	f16vec2 m;
	lowp vec2 n;
	highp ivec4 o;
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
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, true, false, true)) && allOk;
	allOk = compare_int16_t(int(blockB.c), -9) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.d), uvec4(3u, 8u, 6u, 1u)) && allOk;
	allOk = compare_vec3((blockC.e[0]), vec3(-6.0, 0.0, 2.0)) && allOk;
	allOk = compare_vec3((blockC.e[1]), vec3(5.0, 6.0, 4.0)) && allOk;
	allOk = compare_vec3((blockC.e[2]), vec3(1.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC.f[0]), vec4(1.0, 2.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec4((blockC.f[1]), vec4(-6.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC.f[2]), vec4(-5.0, 9.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec4((blockC.f[3]), vec4(6.0, -7.0, 8.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC.f[4]), vec4(9.0, 7.0, 9.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC.f[5]), vec4(3.0, -3.0, 8.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC.f[6]), vec4(-8.0, -3.0, -3.0, -3.0)) && allOk;
	allOk = compare_ivec4((blockD.i), ivec4(4, 8, 2, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.j[0]), ivec4(0, -1, -9, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.j[1]), ivec4(-2, 1, 1, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.j[2]), ivec4(-9, -6, 4, 0)) && allOk;
	allOk = compare_mat3x2(blockD.k, mat3x2(-3.0, -1.0, -3.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec2((blockE.n), vec2(5.0, 5.0)) && allOk;
	allOk = compare_ivec4((blockE.o), ivec4(3, 2, -8, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = int16_t(9);
	blockC.d = u16vec4(uvec4(6u, 6u, 3u, 2u));
	blockD.h = (ivec4(7, -8, 5, -2));
	blockD.i = (ivec4(-3, -9, 7, -4));
	blockD.j[0] = i16vec4(ivec4(-6, 3, -7, -4));
	blockD.j[1] = i16vec4(ivec4(2, -4, -3, 3));
	blockD.j[2] = i16vec4(ivec4(2, 0, 8, 8));
	blockE.l = i16vec4(ivec4(-8, 1, 0, -2));
	blockE.n = (vec2(-6.0, -5.0));
}
#version 450
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
	f16vec3 a;
	mediump uvec4 b;
	bool c[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp mat3x2 d;
	u16vec4 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp vec2 f;
	f16vec2 g;
	mediump mat4x2 h[];
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
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b), uvec4(4u, 9u, 5u, 7u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.e[0]), uvec4(2u, 9u, 4u, 8u)) && allOk;
	allOk = compare_vec2((blockD.f), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockD.g), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockD.h[0], mat4x2(-4.0, 0.0, -9.0, -2.0, -4.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockD.h[1], mat4x2(1.0, 0.0, -8.0, -2.0, 1.0, 5.0, -1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec3(vec3(6.0, 0.0, 5.0));
	blockB.b = (uvec4(8u, 8u, 2u, 9u));
	blockB.c[0] = (false);
	blockB.c[1] = (true);
	blockB.c[2] = (true);
	blockB.c[3] = (true);
	blockB.c[4] = (false);
	blockB.c[5] = (false);
	blockC.e[0] = u16vec4(uvec4(3u, 8u, 9u, 1u));
	blockD.f = (vec2(6.0, 2.0));
	blockD.g = f16vec2(vec2(7.0, -1.0));
	blockD.h[0] = (mat4x2(-6.0, -9.0, 3.0, 8.0, 1.0, -7.0, -4.0, 3.0));
	blockD.h[1] = (mat4x2(-9.0, 9.0, 3.0, -5.0, 5.0, -2.0, -9.0, -2.0));
}
#version 450
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
	bvec4 mB;
	highp ivec3 mC;
};
layout(std430, buffer_reference) buffer BlockB
{
	uint16_t a;
	lowp vec3 b;
	bool c[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	sA d;
	lowp float e;
	f16vec2 f;
	bvec2 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB.a), 7u) && allOk;
	allOk = compare_vec3((blockB.b), vec3(-9.0, -7.0, 9.0)) && allOk;
	allOk = compare_bool((blockB.c[0]), true) && allOk;
	allOk = compare_ivec2((blockC.d.mA), ivec2(-3, 9)) && allOk;
	allOk = compare_bvec4((blockC.d.mB), bvec4(false, false, true, false)) && allOk;
	allOk = compare_ivec3((blockC.d.mC), ivec3(-3, 8, 8)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f), vec2(8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint16_t(7u);
	blockB.b = (vec3(4.0, -4.0, -7.0));
	blockB.c[0] = (false);
	blockC.d.mA = (ivec2(-9, 1));
	blockC.d.mB = (bvec4(true, true, true, false));
	blockC.d.mC = (ivec3(-9, -7, 3));
	blockC.f = f16vec2(vec2(2.0, -4.0));
}
#version 450
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
	mediump vec4 b[];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockC
{
	lowp mat4x3 c;
	i16vec2 d;
	uint16_t e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 0u) && allOk;
	allOk = compare_vec4((blockB.b[0]), vec4(0.0, -7.0, -9.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB.b[1]), vec4(-2.0, -6.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].c, mat4x3(-1.0, -8.0, 0.0, 0.0, 4.0, 6.0, 5.0, -5.0, 0.0, -2.0, 6.0, 8.0)) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].e[0]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (2u);
	blockB.b[0] = (vec4(-4.0, 7.0, 9.0, 0.0));
	blockB.b[1] = (vec4(9.0, -5.0, -3.0, 3.0));
}
#version 450
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
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp uint b;
	layout(offset = 4) bool c;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec3 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_uint((blockC.b), 2u) && allOk;
	allOk = compare_bool((blockC.c), false) && allOk;
	allOk = compare_bvec3((blockD.d), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockC.b = (0u);
	blockC.c = (true);
	blockD.d = (bvec3(true, false, true));
}
#version 450
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
	layout(offset = 0) highp uvec2 a;
	layout(offset = 8) mediump uvec2 b;
	layout(offset = 16) highp ivec4 c[1];
	layout(offset = 32) mediump uvec3 d[1];
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) i16vec2 e;
	layout(offset = 4) uint16_t f;
	layout(offset = 16) bvec4 g;
	layout(offset = 32) uint16_t h;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump float i;
	layout(offset = 4) f16vec4 j;
	layout(offset = 16) highp uvec3 k;
	layout(offset = 32) i16vec4 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC[1];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[0].a), uvec2(9u, 7u)) && allOk;
	allOk = compare_uvec2((blockB[0].b), uvec2(5u, 2u)) && allOk;
	allOk = compare_ivec4((blockB[0].c[0]), ivec4(3, 0, -5, -2)) && allOk;
	allOk = compare_uvec3((blockB[0].d[0]), uvec3(0u, 5u, 6u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC[0].e), ivec2(4, 6)) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].f), 9u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].h), 7u) && allOk;
	allOk = compare_float((blockD.i), 4.0) && allOk;
	allOk = compare_f16vec4(vec4(blockD.j), vec4(7.0, 2.0, -6.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockD.k), uvec3(1u, 7u, 8u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.l), ivec4(-2, -4, 6, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (uvec2(7u, 1u));
	blockB[0].b = (uvec2(5u, 1u));
	blockB[0].c[0] = (ivec4(3, 5, -1, 2));
	blockB[0].d[0] = (uvec3(9u, 8u, 7u));
	blockC[0].g = (bvec4(false, true, true, false));
	blockD.j = f16vec4(vec4(-6.0, 1.0, -8.0, -3.0));
	blockD.k = (uvec3(3u, 2u, 3u));
	blockD.l = i16vec4(ivec4(-3, 9, 6, -4));
}
#version 450
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
	layout(offset = 0) bvec4 a;
	layout(offset = 16) bvec3 b[1];
	layout(offset = 32) f16vec4 c;
	layout(offset = 40) i16vec2 d;
	layout(offset = 44) int16_t e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp vec3 f;
	layout(offset = 12) lowp uint g;
	layout(offset = 16) mediump float h;
	layout(offset = 20) u16vec2 i;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) f16vec2 j;
	layout(offset = 4) int16_t k;
	layout(offset = 8) highp uint l;
	layout(offset = 16) highp vec2 m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
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
	allOk = compare_vec3((blockC.f), vec3(0.0, -1.0, -7.0)) && allOk;
	allOk = compare_uint((blockC.g), 7u) && allOk;
	allOk = compare_float((blockC.h), 2.0) && allOk;
	allOk = compare_int16_t(int(blockD[0].k), -4) && allOk;
	allOk = compare_uint((blockD[0].l), 9u) && allOk;
	allOk = compare_vec2((blockD[0].m), vec2(-7.0, 1.0)) && allOk;
	allOk = compare_int16_t(int(blockD[1].k), 5) && allOk;
	allOk = compare_uint((blockD[1].l), 1u) && allOk;
	allOk = compare_vec2((blockD[1].m), vec2(0.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec4(true, false, true, false));
	blockB[0].c = f16vec4(vec4(-9.0, -4.0, -3.0, 2.0));
	blockB[0].d = i16vec2(ivec2(4, 5));
	blockB[0].e = int16_t(8);
	blockC.g = (1u);
	blockC.h = (-5.0);
	blockC.i = u16vec2(uvec2(7u, 1u));
	blockD[0].j = f16vec2(vec2(7.0, -8.0));
	blockD[0].k = int16_t(8);
	blockD[0].l = (3u);
	blockD[0].m = (vec2(1.0, 1.0));
	blockD[1].j = f16vec2(vec2(7.0, 4.0));
	blockD[1].k = int16_t(5);
	blockD[1].l = (4u);
	blockD[1].m = (vec2(8.0, -7.0));
}
#version 450
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
	mediump float mA;
	highp uvec2 mB;
	mediump mat4x2 mC;
	highp uvec4 mD;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	mediump mat3x2 a;
	highp mat3x2 b[][8];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	uint16_t c;
	i16vec4 d;
	sA e;
	f16vec2 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.b[0][0], mat3x2(-6.0, -1.0, 9.0, 0.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[0][1], mat3x2(-2.0, -5.0, -8.0, 6.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[0][2], mat3x2(6.0, 4.0, 0.0, 2.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[0][3], mat3x2(7.0, -3.0, -5.0, -5.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[0][4], mat3x2(-4.0, 6.0, 9.0, 2.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[0][5], mat3x2(8.0, 8.0, 8.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[0][6], mat3x2(-1.0, -1.0, -1.0, 1.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[0][7], mat3x2(-5.0, 2.0, -5.0, 4.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1][0], mat3x2(8.0, 5.0, 5.0, 7.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1][1], mat3x2(-8.0, 7.0, -3.0, 2.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1][2], mat3x2(5.0, 6.0, -6.0, -3.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1][3], mat3x2(-8.0, -1.0, -5.0, 3.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1][4], mat3x2(3.0, 6.0, 1.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1][5], mat3x2(8.0, 9.0, -6.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1][6], mat3x2(-1.0, 3.0, -5.0, -1.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1][7], mat3x2(-6.0, -8.0, 7.0, -6.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2][0], mat3x2(-9.0, 1.0, 5.0, 1.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2][1], mat3x2(0.0, -5.0, -6.0, 4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2][2], mat3x2(3.0, -4.0, 4.0, 6.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2][3], mat3x2(5.0, -4.0, -8.0, -1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2][4], mat3x2(3.0, -6.0, 9.0, -7.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2][5], mat3x2(9.0, -2.0, -5.0, 0.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2][6], mat3x2(1.0, -1.0, -1.0, -8.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2][7], mat3x2(-9.0, 5.0, -4.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_uint16_t(uint(blockC.c), 2u) && allOk;
	allOk = compare_float((blockC.e.mA), -5.0) && allOk;
	allOk = compare_uvec2((blockC.e.mB), uvec2(0u, 0u)) && allOk;
	allOk = compare_mat4x2(blockC.e.mC, mat4x2(-3.0, 7.0, 0.0, 7.0, 6.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_uvec4((blockC.e.mD), uvec4(1u, 8u, 0u, 2u)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f[0]), vec2(4.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f[1]), vec2(1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(5.0, 9.0, -4.0, 0.0, 7.0, 9.0));
	blockC.c = uint16_t(7u);
	blockC.d = i16vec4(ivec4(3, 1, 5, -9));
	blockC.e.mA = (6.0);
	blockC.e.mB = (uvec2(3u, 4u));
	blockC.e.mC = (mat4x2(0.0, 7.0, -3.0, -3.0, -1.0, 0.0, 8.0, -7.0));
	blockC.e.mD = (uvec4(7u, 4u, 5u, 3u));
}
#version 450
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
	float16_t mB;
	lowp ivec2 mC[5];
	mediump mat4x2 mD;
};
struct sB
{
	mediump mat2x3 mA;
	float16_t mB;
	highp uvec3 mC;
};
struct sC
{
	lowp vec2 mA[8][8];
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	uint16_t a[7];
	sA b;
	sB c;
	bvec3 d;
	lowp uvec2 e[][1];
};
layout(scalar, buffer_reference) buffer BlockC
{
	highp ivec4 f;
	f16vec4 g;
	mediump vec3 h;
	highp mat4x3 i;
	mediump mat4 j[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	mediump ivec4 k;
	sC l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB[0].a[0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].a[1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].a[2]), 5u) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].a[3]), 7u) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].a[4]), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].a[5]), 2u) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].a[6]), 0u) && allOk;
	allOk = compare_mat2x3(blockB[0].c.mA, mat2x3(1.0, -4.0, -3.0, 5.0, 3.0, 0.0)) && allOk;
	allOk = compare_float16_t(float(blockB[0].c.mB), 3.0) && allOk;
	allOk = compare_uvec3((blockB[0].c.mC), uvec3(0u, 2u, 0u)) && allOk;
	allOk = compare_ivec4((blockC.f), ivec4(-6, -7, -1, 4)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.g), vec4(8.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockC.i, mat4x3(3.0, -8.0, 9.0, 9.0, 0.0, -9.0, 0.0, -2.0, -6.0, 1.0, -3.0, -8.0)) && allOk;
	allOk = compare_ivec4((blockD.k), ivec4(5, 9, 2, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = uint16_t(3u);
	blockB[0].a[1] = uint16_t(5u);
	blockB[0].a[2] = uint16_t(1u);
	blockB[0].a[3] = uint16_t(3u);
	blockB[0].a[4] = uint16_t(4u);
	blockB[0].a[5] = uint16_t(3u);
	blockB[0].a[6] = uint16_t(3u);
	blockB[0].c.mA = (mat2x3(-9.0, 1.0, 1.0, 7.0, 4.0, 5.0));
	blockB[0].c.mB = float16_t(4.0);
	blockB[0].c.mC = (uvec3(5u, 0u, 4u));
	blockC.g = f16vec4(vec4(-5.0, -9.0, -8.0, 2.0));
	blockC.h = (vec3(-9.0, 9.0, -4.0));
	blockC.j[0] = (mat4(0.0, 4.0, 5.0, 7.0, -5.0, -1.0, -2.0, 6.0, 7.0, 7.0, 3.0, 4.0, -8.0, -4.0, 3.0, 1.0));
	blockC.j[1] = (mat4(-4.0, 4.0, -3.0, -9.0, -3.0, 0.0, -7.0, 7.0, -6.0, 8.0, -9.0, -7.0, -7.0, -9.0, -5.0, -2.0));
	blockC.j[2] = (mat4(0.0, 8.0, 0.0, -8.0, 0.0, -7.0, 5.0, -1.0, -7.0, 6.0, -5.0, -7.0, 3.0, -6.0, 1.0, -4.0));
	blockC.j[3] = (mat4(1.0, -2.0, 3.0, -1.0, -6.0, -8.0, -4.0, -6.0, 4.0, -5.0, 0.0, -9.0, 3.0, 1.0, 0.0, 6.0));
	blockC.j[4] = (mat4(-7.0, 0.0, -3.0, -9.0, 9.0, 6.0, 8.0, -7.0, -9.0, 6.0, 0.0, -2.0, -2.0, -4.0, 7.0, 1.0));
	blockC.j[5] = (mat4(-1.0, -6.0, 1.0, 4.0, 7.0, -8.0, -5.0, -1.0, -2.0, -4.0, 3.0, 4.0, 6.0, -4.0, -6.0, -2.0));
	blockC.j[6] = (mat4(1.0, 1.0, -7.0, -1.0, -3.0, -8.0, -8.0, -4.0, 2.0, 2.0, -6.0, -1.0, -2.0, 8.0, -5.0, 8.0));
	blockC.j[7] = (mat4(-7.0, -6.0, 9.0, 1.0, -5.0, 2.0, -9.0, -2.0, 0.0, 2.0, 7.0, 7.0, -7.0, 4.0, 3.0, -4.0));
	blockD.k = (ivec4(3, -2, 1, -8));
}
#version 450
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
	uint16_t a;
	i16vec4 b;
	highp uvec3 c[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	int16_t d;
	bool e;
	i16vec4 f;
	f16vec4 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB.a), 0u) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.b), ivec4(-4, 5, 2, 5)) && allOk;
	allOk = compare_uvec3((blockB.c[0]), uvec3(6u, 5u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.c[1]), uvec3(5u, 8u, 9u)) && allOk;
	allOk = compare_uvec3((blockB.c[2]), uvec3(3u, 8u, 9u)) && allOk;
	allOk = compare_uvec3((blockB.c[3]), uvec3(7u, 7u, 1u)) && allOk;
	allOk = compare_uvec3((blockB.c[4]), uvec3(7u, 4u, 6u)) && allOk;
	allOk = compare_bool((blockC.e), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint16_t(6u);
	blockB.b = i16vec4(ivec4(-7, -6, -9, -1));
	blockB.c[0] = (uvec3(6u, 2u, 4u));
	blockB.c[1] = (uvec3(2u, 1u, 1u));
	blockB.c[2] = (uvec3(3u, 7u, 7u));
	blockB.c[3] = (uvec3(3u, 8u, 6u));
	blockB.c[4] = (uvec3(6u, 2u, 6u));
	blockC.e = (false);
	blockC.f = i16vec4(ivec4(-1, -7, 5, -9));
	blockC.g[0] = f16vec4(vec4(-3.0, -2.0, -5.0, -7.0));
	blockC.g[1] = f16vec4(vec4(-6.0, -7.0, -6.0, -1.0));
	blockC.g[2] = f16vec4(vec4(1.0, 7.0, 9.0, 0.0));
	blockC.g[3] = f16vec4(vec4(4.0, -5.0, -8.0, 8.0));
}
#version 450
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
	highp mat2 mB;
	mediump int mC;
	u16vec2 mD;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	u16vec3 a[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	i16vec2 b;
	highp vec2 c;
	sA d;
	lowp mat4x3 e;
	f16vec4 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB.a[0]), uvec3(7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.a[1]), uvec3(9u, 5u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.a[2]), uvec3(9u, 4u, 7u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.a[3]), uvec3(9u, 6u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.a[4]), uvec3(6u, 8u, 7u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.a[5]), uvec3(2u, 3u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.a[6]), uvec3(7u, 7u, 7u)) && allOk;
	allOk = compare_vec2((blockC.c), vec2(2.0, -7.0)) && allOk;
	allOk = compare_mat2(blockC.d.mA, mat2(-6.0, -7.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2(blockC.d.mB, mat2(2.0, -4.0, -2.0, -4.0)) && allOk;
	allOk = compare_int((blockC.d.mC), -3) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.d.mD), uvec2(8u, 6u)) && allOk;
	allOk = compare_mat4x3(blockC.e, mat4x3(8.0, 5.0, -9.0, -3.0, 9.0, 9.0, -1.0, -6.0, -1.0, 4.0, -7.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = u16vec3(uvec3(9u, 2u, 4u));
	blockB.a[1] = u16vec3(uvec3(5u, 7u, 3u));
	blockB.a[2] = u16vec3(uvec3(8u, 1u, 6u));
	blockB.a[3] = u16vec3(uvec3(8u, 7u, 3u));
	blockB.a[4] = u16vec3(uvec3(3u, 6u, 1u));
	blockB.a[5] = u16vec3(uvec3(6u, 7u, 5u));
	blockB.a[6] = u16vec3(uvec3(7u, 1u, 7u));
	blockC.b = i16vec2(ivec2(6, 4));
	blockC.d.mA = (mat2(-6.0, -9.0, 9.0, 9.0));
	blockC.d.mB = (mat2(6.0, -1.0, -6.0, 6.0));
	blockC.d.mC = (-3);
	blockC.d.mD = u16vec2(uvec2(8u, 2u));
	blockC.e = (mat4x3(3.0, 7.0, 1.0, -2.0, -3.0, 0.0, -6.0, -4.0, 8.0, -3.0, -4.0, 4.0));
	blockC.f[0] = f16vec4(vec4(-4.0, -8.0, -6.0, 7.0));
	blockC.f[1] = f16vec4(vec4(-7.0, 9.0, -4.0, -4.0));
	blockC.f[2] = f16vec4(vec4(-5.0, 0.0, 8.0, 2.0));
}
#version 450
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
	mediump ivec4 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec4(-2, 2, -1, -1));
	blockB.a[1] = (ivec4(-5, -1, -9, 0));
	blockB.a[2] = (ivec4(-7, 1, -3, 2));
	blockB.a[3] = (ivec4(-2, 4, -2, 6));
}
#version 450
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
	bool b;
	mediump uint c;
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	int8_t d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(blockC.d), 2) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = (true);
	blockB.c = (4u);
}
#version 450
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
	lowp vec2 a;
	u8vec2 b[1];
	bvec4 c;
	u8vec3 d;
	u8vec2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-7.0, 3.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.d), uvec3(6u, 0u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.e), uvec2(2u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (bvec4(true, true, true, false));
	blockB.e = u8vec2(uvec2(4u, 1u));
}
#version 450
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
	highp ivec3 b;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp vec3 c[6];
};
layout(std140, buffer_reference) buffer BlockD
{
	u8vec3 d;
	lowp uint e;
	uint8_t f;
	highp mat2x3 g[4];
	lowp mat2x3 h;
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(1.0, -5.0)) && allOk;
	allOk = compare_vec3((blockC.c[0]), vec3(-7.0, 1.0, 2.0)) && allOk;
	allOk = compare_vec3((blockC.c[1]), vec3(8.0, 7.0, 9.0)) && allOk;
	allOk = compare_vec3((blockC.c[2]), vec3(-8.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3((blockC.c[3]), vec3(6.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec3((blockC.c[4]), vec3(3.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec3((blockC.c[5]), vec3(4.0, -2.0, 9.0)) && allOk;
	allOk = compare_uint((blockD.e), 6u) && allOk;
	allOk = compare_uint8_t(uint(blockD.f), 8u) && allOk;
	allOk = compare_mat2x3(blockD.g[0], mat2x3(5.0, 5.0, -3.0, 3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockD.g[1], mat2x3(7.0, -2.0, 2.0, 9.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockD.g[2], mat2x3(1.0, 1.0, -9.0, -3.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockD.g[3], mat2x3(-4.0, -4.0, -6.0, 1.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockD.h, mat2x3(-4.0, 0.0, 1.0, -3.0, -9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec3(-5, -4, -8));
	blockC.c[0] = (vec3(-5.0, 0.0, 0.0));
	blockC.c[1] = (vec3(-7.0, 5.0, 3.0));
	blockC.c[2] = (vec3(4.0, 7.0, 8.0));
	blockC.c[3] = (vec3(3.0, 8.0, 8.0));
	blockC.c[4] = (vec3(0.0, 8.0, -6.0));
	blockC.c[5] = (vec3(5.0, 1.0, 7.0));
	blockD.f = uint8_t(8u);
	blockD.g[0] = (mat2x3(7.0, -9.0, -5.0, 5.0, 3.0, 7.0));
	blockD.g[1] = (mat2x3(-7.0, -6.0, 1.0, 8.0, 8.0, -9.0));
	blockD.g[2] = (mat2x3(-8.0, 4.0, 8.0, 5.0, 3.0, 5.0));
	blockD.g[3] = (mat2x3(-4.0, 8.0, 8.0, 0.0, -8.0, 1.0));
	blockD.h = (mat2x3(-8.0, 2.0, -7.0, -2.0, 2.0, -5.0));
}
#version 450
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
	u8vec4 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.a[0]), uvec4(2u, 5u, 1u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.a[1]), uvec4(5u, 7u, 9u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.a[2]), uvec4(0u, 4u, 5u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.a[3]), uvec4(0u, 2u, 4u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = u8vec4(uvec4(6u, 8u, 4u, 7u));
	blockB.a[1] = u8vec4(uvec4(4u, 8u, 4u, 7u));
	blockB.a[2] = u8vec4(uvec4(8u, 6u, 6u, 8u));
	blockB.a[3] = u8vec4(uvec4(4u, 2u, 4u, 9u));
}
#version 450
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
	lowp vec2 a;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump int b[];
};
layout(std430, buffer_reference) buffer BlockD
{
	i8vec2 c;
	lowp mat2x3 d[];
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
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-1.0, 5.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.c), ivec2(7, 5)) && allOk;
	allOk = compare_mat2x3(blockD.d[0], mat2x3(-8.0, 2.0, -9.0, 4.0, 5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(0.0, -7.0));
	blockC.b[0] = (3);
	blockD.c = i8vec2(ivec2(9, 4294967295));
	blockD.d[0] = (mat2x3(3.0, -7.0, -7.0, 6.0, 0.0, 6.0));
}
#version 450
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
	layout(offset = 4) u8vec2 b;
	layout(offset = 8) highp float c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.b), uvec2(2u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec4(ivec4(7, 4294967290, 8, 6));
	blockB.b = u8vec2(uvec2(6u, 3u));
	blockB.c = (8.0);
}
#version 450
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
	layout(offset = 0) u8vec4 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump ivec3 b;
	layout(offset = 12) bool c;
	layout(offset = 16) highp uint d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) u8vec3 e;
	layout(offset = 4) highp uint f;
	layout(offset = 8) u8vec3 g;
	layout(offset = 16) highp vec2 h[1];
	layout(offset = 24) i8vec2 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.a), uvec4(9u, 9u, 9u, 8u)) && allOk;
	allOk = compare_bool((blockC[0].c), false) && allOk;
	allOk = compare_bool((blockC[1].c), true) && allOk;
	allOk = compare_bool((blockC[2].c), false) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.e), uvec3(1u, 7u, 9u)) && allOk;
	allOk = compare_uint((blockD.f), 7u) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.g), uvec3(3u, 9u, 1u)) && allOk;
	allOk = compare_vec2((blockD.h[0]), vec2(-3.0, 3.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.i), ivec2(2, 4294967290)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b = (ivec3(-1, -2, 7));
	blockC[0].c = (false);
	blockC[0].d = (7u);
	blockC[1].b = (ivec3(-4, 1, -7));
	blockC[1].c = (true);
	blockC[1].d = (5u);
	blockC[2].b = (ivec3(-7, -8, 6));
	blockC[2].c = (false);
	blockC[2].d = (3u);
	blockD.e = u8vec3(uvec3(3u, 6u, 7u));
	blockD.g = u8vec3(uvec3(5u, 3u, 7u));
	blockD.h[0] = (vec2(6.0, 9.0));
}
#version 450
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
	layout(offset = 0) lowp ivec3 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB[nonuniformEXT(0)].a), ivec3(-5, -9, -7)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(1)].a), ivec3(9, -1, 0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(2)].a), ivec3(-3, 9, -2)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(3)].a), ivec3(0, 3, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	i8vec2 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = i8vec2(ivec2(0, 9));
	blockB[nonuniformEXT(1)].a = i8vec2(ivec2(5, 4294967289));
	blockB[nonuniformEXT(2)].a = i8vec2(ivec2(4294967290, 9));
}
