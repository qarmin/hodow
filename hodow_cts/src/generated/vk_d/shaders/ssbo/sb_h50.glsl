#version 450
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
	highp ivec4 var;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var), ivec4(5, -9, -6, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (ivec4(-9, -9, -3, -7));
}
#version 450
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
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], 4.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-8.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-2.0, 8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-3.0, -5.0, -7.0));
	var[1] = (vec3(-3.0, 1.0, -6.0));
}
#version 450
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

	var = (mat2x3(6.0, 8.0, 5.0, 2.0, -2.0, -1.0));
}
#version 450
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 5.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[0][3], -9.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[1][2], -4.0) && allOk;
	allOk = compare_float(var[1][3], -4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(5.0, 9.0, -1.0, -9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-6.0, -4.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(1.0, -8.0, -5.0, -2.0, 9.0, 1.0, -5.0, 4.0));
}
#version 450
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
	f16vec2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(var), vec2(-6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = f16vec2(vec2(-2.0, 4.0));
}
#version 450
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

	var[0] = (vec2(1.0, -9.0));
	var[1] = (vec2(-1.0, -7.0));
}
#version 450
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
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(-7.0, 4.0, -1.0, 3.0));
}
#version 450
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

	var = (mat4(-8.0, 8.0, -7.0, -7.0, 5.0, 9.0, -3.0, -7.0, 6.0, -4.0, -3.0, 0.0, -4.0, -5.0, 5.0, 0.0));
}
#version 450
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
	allOk = compare_mat4(var, mat4(9.0, 6.0, 4.0, -5.0, -2.0, 9.0, 9.0, 1.0, 4.0, -2.0, -3.0, 6.0, 1.0, -4.0, -4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-4.0, -7.0, 4.0, 2.0));
	var[1] = (vec4(2.0, 2.0, 1.0, 9.0));
	var[2] = (vec4(7.0, -2.0, 6.0, 5.0));
	var[3] = (vec4(4.0, 0.0, 2.0, -8.0));
}
#version 450
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
	highp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(8.0, -8.0, -2.0, -6.0, -3.0, 1.0, 4.0, -6.0, 6.0, 8.0, -7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(6.0, -8.0, -6.0, -7.0, 1.0, -5.0, 8.0, 0.0, 5.0, 6.0, 6.0, 8.0));
}
#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat3(var, mat3(5.0, 1.0, 7.0, 4.0, -7.0, -4.0, 8.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var = (mat3(7.0, 7.0, -3.0, -9.0, 7.0, 9.0, -5.0, 5.0, 3.0));
}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(0.0, 2.0, 1.0, -5.0, 7.0, -3.0, -5.0, 8.0, -5.0, 8.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var = (mat3x4(-7.0, 1.0, -4.0, 5.0, 4.0, 1.0, 1.0, 1.0, 8.0, 9.0, 5.0, -6.0));
}
#version 450
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
	allOk = compare_mat3x2(var[0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	var[1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	var[2] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
}
#version 450
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

	padding = (7.0);
	var[0][0] = (vec3(-6.0, 3.0, -3.0));
	var[0][1] = (vec3(9.0, -2.0, 3.0));
	var[0][2] = (vec3(9.0, -9.0, 7.0));
	var[0][3] = (vec3(4.0, -4.0, 5.0));
	var[1][0] = (vec3(-1.0, -2.0, 6.0));
	var[1][1] = (vec3(-4.0, 6.0, 4.0));
	var[1][2] = (vec3(-8.0, 7.0, 3.0));
	var[1][3] = (vec3(1.0, -9.0, -4.0));
	var[2][0] = (vec3(9.0, 2.0, 2.0));
	var[2][1] = (vec3(9.0, -7.0, 3.0));
	var[2][2] = (vec3(8.0, 2.0, 4.0));
	var[2][3] = (vec3(-9.0, 8.0, 2.0));
}
#version 450
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
	highp mat2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(-8.0, 3.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(0.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-1.0, 2.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(-8.0, 0.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(-4.0, 3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(-3.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(3.0, 2.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(-2.0, 1.0));
	var[0][1] = (vec2(-7.0, -1.0));
	var[1][0] = (vec2(5.0, -3.0));
	var[1][1] = (vec2(4.0, 8.0));
	var[2][0] = (vec2(-2.0, -6.0));
	var[2][1] = (vec2(-5.0, -1.0));
	var[3][0] = (vec2(3.0, 4.0));
	var[3][1] = (vec2(-8.0, 6.0));
	var[4][0] = (vec2(6.0, -2.0));
	var[4][1] = (vec2(1.0, 3.0));
	var[5][0] = (vec2(2.0, 1.0));
	var[5][1] = (vec2(7.0, -2.0));
	var[6][0] = (vec2(-4.0, 2.0));
	var[6][1] = (vec2(-1.0, -4.0));
	var[7][0] = (vec2(-5.0, -8.0));
	var[7][1] = (vec2(3.0, -7.0));
	var[8][0] = (vec2(5.0, 0.0));
	var[8][1] = (vec2(-4.0, -9.0));
	var[9][0] = (vec2(9.0, 1.0));
	var[9][1] = (vec2(7.0, 9.0));
	var[10][0] = (vec2(1.0, 3.0));
	var[10][1] = (vec2(-3.0, 7.0));
	var[11][0] = (vec2(1.0, 5.0));
	var[11][1] = (vec2(4.0, 1.0));
	var[12][0] = (vec2(-7.0, 2.0));
	var[12][1] = (vec2(-9.0, 3.0));
	var[13][0] = (vec2(7.0, 9.0));
	var[13][1] = (vec2(-8.0, 3.0));
	var[14][0] = (vec2(-8.0, -9.0));
	var[14][1] = (vec2(3.0, -5.0));
	var[15][0] = (vec2(7.0, 8.0));
	var[15][1] = (vec2(-8.0, 4.0));
	var[16][0] = (vec2(-4.0, 7.0));
	var[16][1] = (vec2(-4.0, -8.0));
	var[17][0] = (vec2(1.0, 0.0));
	var[17][1] = (vec2(0.0, -9.0));
	var[18][0] = (vec2(-4.0, 7.0));
	var[18][1] = (vec2(4.0, 1.0));
}
#version 450
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
	allOk = compare_mat3x4(var[0], mat3x4(5.0, -7.0, -9.0, 4.0, 5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-9.0, 7.0, -4.0, 5.0, -9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(4.0, 1.0, 3.0, -1.0, -3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3], mat3x4(5.0, 1.0, -8.0, -9.0, -6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(-3.0, 6.0, 3.0, 0.0, -4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-1.0, 6.0, 5.0, -4.0, -5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(2.0, 3.0, 2.0, 5.0, -4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-3.0, 3.0, -2.0, 6.0, 9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(1.0, -2.0, 4.0, 2.0, 7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(6.0, -8.0, 1.0, 3.0, 2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(-8.0, 4.0, 3.0, 2.0, 2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(2.0, 0.0, -3.0, 3.0, -7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(-3.0, -7.0, 5.0, 2.0, -5.0, 9.0, -1.0, -1.0, 1.0, -7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(2.0, 0.0, 8.0, -9.0, 5.0, -4.0, 5.0, -7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(3.0, 6.0, -3.0, 3.0, 9.0, -1.0, -3.0, 6.0, -9.0, 9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(-2.0, 8.0, 5.0, -9.0, 0.0, -8.0, 8.0, -8.0, 6.0, -2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(-5.0, -3.0, 9.0, 7.0, 1.0, -1.0, -8.0, -6.0, 5.0, 0.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(5.0, -7.0, -3.0, -7.0, 3.0, 9.0, -6.0, -7.0, -4.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(3.0, 5.0, -2.0, -6.0, -7.0, -4.0, 6.0, 5.0, -9.0, 2.0, 7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	var[1] = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	var[2] = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
	var[3] = (mat3x4(0.0, -2.0, -8.0, -5.0, 0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0));
	var[4] = (mat3x4(-1.0, 7.0, 7.0, 7.0, 2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0));
	var[5] = (mat3x4(5.0, 8.0, 9.0, 8.0, 7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0));
	var[6] = (mat3x4(-7.0, -8.0, -2.0, 9.0, -8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0));
	var[7] = (mat3x4(1.0, 5.0, 7.0, 5.0, -4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0));
	var[8] = (mat3x4(-1.0, 2.0, 3.0, -5.0, -6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0));
	var[9] = (mat3x4(-2.0, 9.0, -8.0, 3.0, -5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0));
	var[10] = (mat3x4(-3.0, 2.0, 8.0, 3.0, -1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0));
	var[11] = (mat3x4(-7.0, -5.0, -3.0, 6.0, -7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0));
	var[12] = (mat3x4(-3.0, -3.0, -1.0, -2.0, 7.0, 1.0, 7.0, 0.0, -9.0, 2.0, -2.0, -6.0));
	var[13] = (mat3x4(4.0, -5.0, -8.0, -9.0, 4.0, 2.0, -1.0, -3.0, 9.0, -6.0, -9.0, -8.0));
	var[14] = (mat3x4(7.0, 6.0, -3.0, -6.0, -1.0, 2.0, 7.0, -9.0, -3.0, -4.0, -1.0, 0.0));
	var[15] = (mat3x4(-7.0, 4.0, 3.0, -4.0, 4.0, 2.0, -4.0, -3.0, 8.0, 9.0, 9.0, 8.0));
	var[16] = (mat3x4(1.0, 2.0, 5.0, 6.0, 8.0, 4.0, 6.0, -3.0, 6.0, -7.0, 9.0, -9.0));
	var[17] = (mat3x4(-9.0, -8.0, 4.0, 0.0, -8.0, 2.0, 2.0, -2.0, -7.0, 9.0, 5.0, -9.0));
	var[18] = (mat3x4(-9.0, -9.0, 8.0, -1.0, 9.0, 2.0, -9.0, -3.0, -9.0, -1.0, 3.0, -2.0));
}
#version 450
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
	int16_t var[];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(var[0]), -5) && allOk;
	allOk = compare_int16_t(int(var[1]), 1) && allOk;
	allOk = compare_int16_t(int(var[2]), 8) && allOk;
	allOk = compare_int16_t(int(var[3]), -2) && allOk;
	allOk = compare_int16_t(int(var[4]), 9) && allOk;
	allOk = compare_int16_t(int(var[5]), -5) && allOk;
	allOk = compare_int16_t(int(var[6]), -8) && allOk;
	allOk = compare_int16_t(int(var[7]), 6) && allOk;
	allOk = compare_int16_t(int(var[8]), 3) && allOk;
	allOk = compare_int16_t(int(var[9]), -8) && allOk;
	allOk = compare_int16_t(int(var[10]), 6) && allOk;
	allOk = compare_int16_t(int(var[11]), -7) && allOk;
	allOk = compare_int16_t(int(var[12]), 9) && allOk;
	allOk = compare_int16_t(int(var[13]), 5) && allOk;
	allOk = compare_int16_t(int(var[14]), 9) && allOk;
	allOk = compare_int16_t(int(var[15]), -3) && allOk;
	allOk = compare_int16_t(int(var[16]), -1) && allOk;
	allOk = compare_int16_t(int(var[17]), -2) && allOk;
	allOk = compare_int16_t(int(var[18]), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = int16_t(6);
	var[1] = int16_t(8);
	var[2] = int16_t(-2);
	var[3] = int16_t(-4);
	var[4] = int16_t(-3);
	var[5] = int16_t(9);
	var[6] = int16_t(-5);
	var[7] = int16_t(-8);
	var[8] = int16_t(-3);
	var[9] = int16_t(2);
	var[10] = int16_t(-1);
	var[11] = int16_t(4);
	var[12] = int16_t(3);
	var[13] = int16_t(9);
	var[14] = int16_t(6);
	var[15] = int16_t(2);
	var[16] = int16_t(3);
	var[17] = int16_t(7);
	var[18] = int16_t(7);
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	bvec3 var[4][3];
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((var[0][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[0][2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[1][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[1][2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((var[2][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((var[2][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[2][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[3][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[3][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[3][2]), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (bvec3(true, true, false));
	var[0][1] = (bvec3(false, true, true));
	var[0][2] = (bvec3(false, false, false));
	var[1][0] = (bvec3(true, false, false));
	var[1][1] = (bvec3(true, true, true));
	var[1][2] = (bvec3(false, true, true));
	var[2][0] = (bvec3(false, true, true));
	var[2][1] = (bvec3(true, true, true));
	var[2][2] = (bvec3(true, true, true));
	var[3][0] = (bvec3(true, false, false));
	var[3][1] = (bvec3(false, true, false));
	var[3][2] = (bvec3(true, false, false));
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(-3.0, 1.0, 4.0, 2.0, -2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(6.0, -6.0, -8.0, 8.0, 4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(2.0, 8.0, -9.0, 0.0, 3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(-9.0, -9.0, 1.0, 6.0, -2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(-6.0, 1.0, -4.0, 2.0, 9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(-6.0, 5.0, 3.0, -1.0, 6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(-8.0, 6.0, 7.0, -3.0, -3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(-9.0, 1.0, 2.0, 0.0, -3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(4.0, 8.0, -1.0, 7.0, 0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	var[0][1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	var[0][2] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
	var[1][0] = (mat3x4(-9.0, 1.0, -3.0, -5.0, -5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0));
	var[1][1] = (mat3x4(-4.0, 4.0, 3.0, 8.0, -8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0));
	var[1][2] = (mat3x4(-9.0, -3.0, 7.0, -7.0, -6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0));
	var[2][0] = (mat3x4(3.0, 1.0, -4.0, -8.0, -9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0));
	var[2][1] = (mat3x4(1.0, -1.0, -1.0, -7.0, -9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0));
	var[2][2] = (mat3x4(9.0, 2.0, -4.0, -9.0, -7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0));
	var[3][0] = (mat3x4(4.0, -5.0, 0.0, -5.0, -7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0));
	var[3][1] = (mat3x4(-9.0, 0.0, 8.0, 4.0, -9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0));
	var[3][2] = (mat3x4(6.0, -3.0, -7.0, -8.0, 6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	float padding;
	highp vec3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_vec3((var[0][0]), vec3(9.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec3((var[0][1]), vec3(5.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec3((var[0][2]), vec3(-1.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec3((var[1][0]), vec3(-9.0, 3.0, -7.0)) && allOk;
	allOk = compare_vec3((var[1][1]), vec3(-2.0, -4.0, 3.0)) && allOk;
	allOk = compare_vec3((var[1][2]), vec3(3.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3((var[2][0]), vec3(-4.0, 0.0, 5.0)) && allOk;
	allOk = compare_vec3((var[2][1]), vec3(6.0, 5.0, -3.0)) && allOk;
	allOk = compare_vec3((var[2][2]), vec3(5.0, 7.0, 8.0)) && allOk;
	allOk = compare_vec3((var[3][0]), vec3(5.0, 8.0, 5.0)) && allOk;
	allOk = compare_vec3((var[3][1]), vec3(-8.0, -5.0, -7.0)) && allOk;
	allOk = compare_vec3((var[3][2]), vec3(-3.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var[0][0] = (vec3(4.0, 7.0, 8.0));
	var[0][1] = (vec3(-2.0, 7.0, -5.0));
	var[0][2] = (vec3(-7.0, 9.0, 6.0));
	var[1][0] = (vec3(6.0, 0.0, -5.0));
	var[1][1] = (vec3(2.0, -8.0, 5.0));
	var[1][2] = (vec3(0.0, 2.0, 0.0));
	var[2][0] = (vec3(5.0, 1.0, -5.0));
	var[2][1] = (vec3(0.0, 1.0, 0.0));
	var[2][2] = (vec3(7.0, -2.0, -2.0));
	var[3][0] = (vec3(8.0, -1.0, -1.0));
	var[3][1] = (vec3(5.0, 1.0, -1.0));
	var[3][2] = (vec3(-3.0, 8.0, -4.0));
}
#version 450
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
	highp uvec4 var[4][3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 4u) && allOk;
	allOk = compare_uvec4((var[0][0]), uvec4(1u, 8u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((var[0][1]), uvec4(9u, 5u, 9u, 3u)) && allOk;
	allOk = compare_uvec4((var[0][2]), uvec4(6u, 5u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((var[1][0]), uvec4(3u, 3u, 6u, 0u)) && allOk;
	allOk = compare_uvec4((var[1][1]), uvec4(7u, 0u, 0u, 2u)) && allOk;
	allOk = compare_uvec4((var[1][2]), uvec4(8u, 5u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((var[2][0]), uvec4(3u, 1u, 5u, 8u)) && allOk;
	allOk = compare_uvec4((var[2][1]), uvec4(7u, 6u, 2u, 5u)) && allOk;
	allOk = compare_uvec4((var[2][2]), uvec4(9u, 5u, 9u, 1u)) && allOk;
	allOk = compare_uvec4((var[3][0]), uvec4(6u, 2u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((var[3][1]), uvec4(9u, 5u, 3u, 5u)) && allOk;
	allOk = compare_uvec4((var[3][2]), uvec4(7u, 4u, 7u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2u);
	var[0][0] = (uvec4(7u, 2u, 9u, 7u));
	var[0][1] = (uvec4(9u, 5u, 1u, 3u));
	var[0][2] = (uvec4(4u, 4u, 2u, 0u));
	var[1][0] = (uvec4(5u, 6u, 2u, 9u));
	var[1][1] = (uvec4(5u, 7u, 7u, 0u));
	var[1][2] = (uvec4(3u, 8u, 1u, 4u));
	var[2][0] = (uvec4(9u, 1u, 3u, 8u));
	var[2][1] = (uvec4(8u, 8u, 1u, 7u));
	var[2][2] = (uvec4(5u, 4u, 8u, 6u));
	var[3][0] = (uvec4(6u, 0u, 9u, 7u));
	var[3][1] = (uvec4(2u, 3u, 0u, 4u));
	var[3][2] = (uvec4(4u, 8u, 5u, 6u));
}
#version 450
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
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat4x2(var[0][0], mat4x2(-2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(-1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(-8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(-7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(-6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(-8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(-5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(-1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(-9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0][0] = (mat4x2(-3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0, 5.0));
	var[0][1] = (mat4x2(-6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0, -5.0));
	var[0][2] = (mat4x2(-1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0, 2.0));
	var[1][0] = (mat4x2(0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0, 5.0));
	var[1][1] = (mat4x2(-4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0, 4.0));
	var[1][2] = (mat4x2(7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0, 6.0));
	var[2][0] = (mat4x2(-3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0, 2.0));
	var[2][1] = (mat4x2(2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0, 6.0));
	var[2][2] = (mat4x2(2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0, -1.0));
	var[3][0] = (mat4x2(-4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0, 9.0));
	var[3][1] = (mat4x2(-3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0, 5.0));
	var[3][2] = (mat4x2(6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0, 2.0));
}
#version 450
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
	highp mat4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(2.0, -9.0, 8.0, -3.0, -3.0, -1.0, -8.0, -7.0, -8.0, 4.0, 2.0, -4.0, -5.0, 1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(6.0, -2.0, -2.0, -9.0, 7.0, 8.0, -4.0, -9.0, -8.0, -4.0, 6.0, 7.0, -4.0, -5.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(3.0, 8.0, 3.0, 9.0, -8.0, 9.0, 4.0, -3.0, -1.0, -3.0, 5.0, -1.0, 3.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-4.0, -1.0, 7.0, 7.0, 0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(5.0, 0.0, 8.0, -9.0, 0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(-4.0, -3.0, -4.0, -7.0, 4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-7.0, 9.0, -8.0, -7.0, -5.0, 5.0, 6.0, 9.0, -7.0, -2.0, 5.0, 7.0, -2.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(3.0, 7.0, 1.0, -2.0, 8.0, 6.0, 9.0, 5.0, 3.0, 4.0, -8.0, -4.0, -5.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(-3.0, 9.0, 7.0, -3.0, 8.0, -4.0, -7.0, 1.0, -3.0, 9.0, -9.0, -1.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(9.0, -6.0, 6.0, 6.0, -2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-4.0, -3.0, -8.0, 5.0, 8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(5.0, -1.0, 6.0, 0.0, -1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(8.0, 1.0, -4.0, 3.0, 7.0, 9.0, 6.0, -6.0, 2.0, 8.0, 2.0, 3.0, -8.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-5.0, 3.0, -1.0, -1.0, -9.0, 4.0, -7.0, 5.0, 5.0, 3.0, 8.0, -1.0, 6.0, 3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(-5.0, 5.0, 1.0, 6.0, 0.0, -7.0, -5.0, -8.0, 2.0, 0.0, 4.0, 9.0, -3.0, 8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(0.0, -4.0, 0.0, 2.0, 5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(9.0, 2.0, 5.0, -7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(-9.0, -5.0, 3.0, -4.0, -6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(5.0, -3.0, -9.0, 6.0, -1.0, -9.0, 1.0, -2.0, 4.0, -2.0, 2.0, -5.0, 6.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(4.0, 4.0, 9.0, -5.0, -1.0, 8.0, 9.0, 8.0, 5.0, 6.0, -9.0, 1.0, 9.0, 8.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(-5.0, 7.0, -9.0, -5.0, 6.0, -4.0, -5.0, -4.0, -9.0, -8.0, 9.0, 4.0, 2.0, 5.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	var[0][0][1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	var[0][0][2] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
	var[0][1][0] = (mat4(4.0, -5.0, 0.0, -7.0, 5.0, 6.0, -9.0, 8.0, -2.0, -3.0, -2.0, -2.0, -4.0, -1.0, -7.0, -8.0));
	var[0][1][1] = (mat4(6.0, 2.0, 6.0, -7.0, 2.0, 4.0, -8.0, -9.0, -9.0, -5.0, -7.0, 1.0, 9.0, 1.0, 5.0, -3.0));
	var[0][1][2] = (mat4(7.0, 8.0, 7.0, -3.0, 0.0, -2.0, -3.0, -6.0, -6.0, -6.0, 6.0, -6.0, -6.0, 9.0, 8.0, -5.0));
	var[1][0][0] = (mat4(-3.0, 1.0, -5.0, 0.0, -1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0));
	var[1][0][1] = (mat4(4.0, 7.0, 2.0, 2.0, 5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0));
	var[1][0][2] = (mat4(-6.0, 0.0, -6.0, 3.0, -1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0));
	var[1][1][0] = (mat4(4.0, -4.0, 4.0, 7.0, -4.0, 5.0, -8.0, 5.0, -8.0, 9.0, 3.0, 9.0, 3.0, -3.0, -8.0, -6.0));
	var[1][1][1] = (mat4(2.0, 4.0, -9.0, 6.0, 4.0, -1.0, 2.0, 1.0, 2.0, 6.0, -9.0, -1.0, -5.0, -1.0, -7.0, 9.0));
	var[1][1][2] = (mat4(6.0, -6.0, -2.0, -7.0, 6.0, 8.0, -3.0, -9.0, 7.0, 6.0, -5.0, 9.0, -5.0, 0.0, -9.0, 3.0));
	var[2][0][0] = (mat4(7.0, 9.0, -3.0, -6.0, 3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0));
	var[2][0][1] = (mat4(3.0, -3.0, 1.0, 4.0, -1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0));
	var[2][0][2] = (mat4(-6.0, -5.0, 3.0, -8.0, -4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0));
	var[2][1][0] = (mat4(-6.0, -4.0, 9.0, 8.0, 6.0, 8.0, -4.0, 1.0, -6.0, 4.0, -2.0, 2.0, -3.0, -4.0, 3.0, -5.0));
	var[2][1][1] = (mat4(2.0, 9.0, -7.0, -6.0, 2.0, -1.0, 9.0, 2.0, 9.0, -4.0, 4.0, -1.0, -3.0, -4.0, 0.0, -3.0));
	var[2][1][2] = (mat4(8.0, -4.0, -1.0, -5.0, 9.0, -8.0, -2.0, -9.0, -5.0, -3.0, 0.0, 0.0, 1.0, 1.0, -4.0, 4.0));
	var[3][0][0] = (mat4(-5.0, 2.0, 1.0, 1.0, -7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0));
	var[3][0][1] = (mat4(-4.0, -3.0, 2.0, -2.0, 4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0));
	var[3][0][2] = (mat4(6.0, -9.0, 7.0, 7.0, -1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0));
	var[3][1][0] = (mat4(-9.0, -9.0, 4.0, 8.0, 2.0, -6.0, -1.0, 5.0, -4.0, -6.0, -8.0, 7.0, 4.0, -2.0, -4.0, -1.0));
	var[3][1][1] = (mat4(1.0, 7.0, 5.0, 2.0, 5.0, 9.0, 3.0, -9.0, -6.0, -4.0, 4.0, 7.0, 6.0, -1.0, -7.0, -5.0));
	var[3][1][2] = (mat4(0.0, 9.0, 4.0, 7.0, 3.0, -1.0, 9.0, -1.0, 3.0, 3.0, 5.0, 7.0, 7.0, -8.0, -9.0, -5.0));
}
#version 450
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
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-1.0, 1.0, 9.0, 7.0, 0.0, 9.0, -1.0, -1.0, -7.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(5.0, 7.0, -6.0, -7.0, 6.0, -5.0, -4.0, -1.0, 8.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(-2.0, -5.0, -2.0, -2.0, 9.0, 9.0, -6.0, 0.0, -5.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-4.0, -7.0, 7.0, -5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(3.0, -3.0, 0.0, 8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(6.0, 2.0, -1.0, -6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(8.0, -9.0, 6.0, -7.0, 6.0, 5.0, -5.0, -1.0, 5.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(8.0, 3.0, -1.0, 2.0, 5.0, -8.0, 0.0, -6.0, 4.0, 6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(8.0, 4.0, -1.0, -5.0, 0.0, -6.0, 3.0, 7.0, -8.0, -4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-9.0, -5.0, -9.0, 1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(-7.0, -4.0, 0.0, 2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(-7.0, 4.0, 9.0, 8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(6.0, -3.0, 0.0, -6.0, -3.0, -6.0, 8.0, 4.0, 2.0, 4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-1.0, -7.0, 6.0, -3.0, -8.0, -4.0, 6.0, 4.0, 6.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(2.0, -8.0, 4.0, 7.0, -9.0, -4.0, 2.0, -4.0, -9.0, 4.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(0.0, -9.0, -1.0, 9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(5.0, -5.0, -1.0, -9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(-3.0, 1.0, 7.0, -9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(-7.0, -3.0, 9.0, -6.0, 0.0, -2.0, -4.0, 8.0, 3.0, -4.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(-5.0, -4.0, -7.0, 2.0, -5.0, -5.0, 2.0, 4.0, -5.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(2.0, 3.0, -9.0, -6.0, -1.0, -7.0, 8.0, -6.0, 1.0, 7.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	var[0][0][1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	var[0][0][2] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
	var[0][1][0] = (mat4x3(4.0, 9.0, 7.0, 5.0, 7.0, -2.0, -4.0, -2.0, 3.0, -6.0, 0.0, -7.0));
	var[0][1][1] = (mat4x3(9.0, -6.0, -9.0, 5.0, -1.0, -2.0, 4.0, 7.0, 2.0, 8.0, -7.0, 9.0));
	var[0][1][2] = (mat4x3(7.0, 3.0, 4.0, 9.0, 8.0, -1.0, -6.0, -4.0, 5.0, -8.0, -4.0, 1.0));
	var[1][0][0] = (mat4x3(9.0, -7.0, -4.0, -3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0));
	var[1][0][1] = (mat4x3(9.0, 0.0, 0.0, 7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0));
	var[1][0][2] = (mat4x3(-4.0, 1.0, 3.0, -5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0));
	var[1][1][0] = (mat4x3(-1.0, 6.0, 7.0, -9.0, 0.0, 8.0, -4.0, 2.0, 0.0, 3.0, -3.0, 1.0));
	var[1][1][1] = (mat4x3(7.0, 7.0, -6.0, 0.0, 1.0, 7.0, 2.0, 8.0, -2.0, -5.0, 8.0, 3.0));
	var[1][1][2] = (mat4x3(-1.0, -5.0, -8.0, 1.0, 4.0, 0.0, 2.0, -3.0, 8.0, -5.0, -9.0, 4.0));
	var[2][0][0] = (mat4x3(-8.0, -3.0, -8.0, -5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0));
	var[2][0][1] = (mat4x3(8.0, -8.0, -9.0, 9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0));
	var[2][0][2] = (mat4x3(-8.0, 9.0, 8.0, -9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0));
	var[2][1][0] = (mat4x3(5.0, -9.0, 3.0, -6.0, -1.0, 2.0, 6.0, -2.0, 0.0, 5.0, -5.0, -5.0));
	var[2][1][1] = (mat4x3(-3.0, -7.0, -1.0, -5.0, 2.0, -7.0, 9.0, 1.0, 1.0, -5.0, 8.0, -6.0));
	var[2][1][2] = (mat4x3(-7.0, -1.0, 4.0, 4.0, -4.0, -4.0, -1.0, -2.0, 0.0, -3.0, 8.0, 7.0));
	var[3][0][0] = (mat4x3(8.0, -3.0, -6.0, 2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0));
	var[3][0][1] = (mat4x3(1.0, -6.0, -5.0, -5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0));
	var[3][0][2] = (mat4x3(-4.0, 8.0, 5.0, -4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0));
	var[3][1][0] = (mat4x3(-8.0, -4.0, -4.0, 2.0, 3.0, -9.0, 2.0, -1.0, -4.0, 3.0, 5.0, 1.0));
	var[3][1][1] = (mat4x3(1.0, -2.0, 8.0, -8.0, -5.0, -8.0, -8.0, -7.0, 7.0, -9.0, 8.0, -2.0));
	var[3][1][2] = (mat4x3(-7.0, -4.0, 2.0, 2.0, 5.0, 7.0, -5.0, 5.0, 2.0, -2.0, 9.0, -6.0));
}
#version 450
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
	highp vec2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var[0][0][0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((var[0][0][1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[0][0][2]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((var[0][1][0]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((var[0][1][1]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((var[0][1][2]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((var[1][0][0]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((var[1][0][1]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((var[1][0][2]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((var[1][1][0]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((var[1][1][1]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((var[1][1][2]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((var[2][0][0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((var[2][0][1]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((var[2][0][2]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((var[2][1][0]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((var[2][1][1]), vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec2((var[2][1][2]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2((var[3][0][0]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[3][0][1]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((var[3][0][2]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((var[3][1][0]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2((var[3][1][1]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_vec2((var[3][1][2]), vec2(-7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(3.0, 8.0));
	var[0][0][1] = (vec2(7.0, -1.0));
	var[0][0][2] = (vec2(-4.0, 8.0));
	var[0][1][0] = (vec2(-6.0, -2.0));
	var[0][1][1] = (vec2(5.0, 4.0));
	var[0][1][2] = (vec2(0.0, 0.0));
	var[1][0][0] = (vec2(-2.0, -5.0));
	var[1][0][1] = (vec2(-2.0, 5.0));
	var[1][0][2] = (vec2(6.0, -2.0));
	var[1][1][0] = (vec2(-4.0, -9.0));
	var[1][1][1] = (vec2(-2.0, 2.0));
	var[1][1][2] = (vec2(-2.0, 8.0));
	var[2][0][0] = (vec2(-6.0, -6.0));
	var[2][0][1] = (vec2(1.0, 6.0));
	var[2][0][2] = (vec2(-7.0, 6.0));
	var[2][1][0] = (vec2(-4.0, -4.0));
	var[2][1][1] = (vec2(-2.0, -8.0));
	var[2][1][2] = (vec2(2.0, 9.0));
	var[3][0][0] = (vec2(1.0, -6.0));
	var[3][0][1] = (vec2(-9.0, 0.0));
	var[3][0][2] = (vec2(-8.0, -4.0));
	var[3][1][0] = (vec2(-8.0, 9.0));
	var[3][1][1] = (vec2(0.0, -8.0));
	var[3][1][2] = (vec2(1.0, 5.0));
}
#version 450
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
	highp uvec2 var[4][2][3];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var[0][0][0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((var[0][0][1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((var[0][0][2]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((var[0][1][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((var[0][1][1]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((var[0][1][2]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((var[1][0][0]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((var[1][0][1]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((var[1][0][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[1][1][0]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((var[1][1][1]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((var[1][1][2]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((var[2][0][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((var[2][0][1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((var[2][0][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[2][1][0]), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec2((var[2][1][1]), uvec2(7u, 3u)) && allOk;
	allOk = compare_uvec2((var[2][1][2]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((var[3][0][0]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((var[3][0][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((var[3][0][2]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((var[3][1][0]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((var[3][1][1]), uvec2(4u, 8u)) && allOk;
	allOk = compare_uvec2((var[3][1][2]), uvec2(8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (uvec2(6u, 1u));
	var[0][0][1] = (uvec2(8u, 1u));
	var[0][0][2] = (uvec2(7u, 4u));
	var[0][1][0] = (uvec2(6u, 2u));
	var[0][1][1] = (uvec2(6u, 0u));
	var[0][1][2] = (uvec2(3u, 2u));
	var[1][0][0] = (uvec2(6u, 6u));
	var[1][0][1] = (uvec2(5u, 8u));
	var[1][0][2] = (uvec2(4u, 7u));
	var[1][1][0] = (uvec2(5u, 1u));
	var[1][1][1] = (uvec2(7u, 2u));
	var[1][1][2] = (uvec2(3u, 6u));
	var[2][0][0] = (uvec2(8u, 4u));
	var[2][0][1] = (uvec2(6u, 3u));
	var[2][0][2] = (uvec2(6u, 0u));
	var[2][1][0] = (uvec2(0u, 1u));
	var[2][1][1] = (uvec2(2u, 6u));
	var[2][1][2] = (uvec2(9u, 1u));
	var[3][0][0] = (uvec2(3u, 5u));
	var[3][0][1] = (uvec2(2u, 4u));
	var[3][0][2] = (uvec2(7u, 8u));
	var[3][1][0] = (uvec2(4u, 6u));
	var[3][1][1] = (uvec2(4u, 2u));
	var[3][1][2] = (uvec2(7u, 5u));
}
#version 450
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
	allOk = compare_mat2(var[0][0][0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-2.0, -4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(4.0, -3.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(-5.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(0.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-4.0, -1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(-1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(8.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(1.0, 1.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(-6.0, 1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-7.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-9.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(-4.0, -9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(7.0, -2.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-8.0, -5.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(-3.0, -9.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(-9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(-9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(6.0, -1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(9.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(-7.0, 1.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(-3.0, 3.0));
	var[0][0][0][1] = (vec2(4.0, 4.0));
	var[0][0][1][0] = (vec2(9.0, -9.0));
	var[0][0][1][1] = (vec2(-5.0, 8.0));
	var[0][0][2][0] = (vec2(0.0, 4.0));
	var[0][0][2][1] = (vec2(2.0, -4.0));
	var[0][1][0][0] = (vec2(-3.0, -8.0));
	var[0][1][0][1] = (vec2(-4.0, -7.0));
	var[0][1][1][0] = (vec2(-9.0, 5.0));
	var[0][1][1][1] = (vec2(5.0, -6.0));
	var[0][1][2][0] = (vec2(4.0, -1.0));
	var[0][1][2][1] = (vec2(-3.0, -8.0));
	var[1][0][0][0] = (vec2(-3.0, 3.0));
	var[1][0][0][1] = (vec2(-8.0, -7.0));
	var[1][0][1][0] = (vec2(-7.0, -6.0));
	var[1][0][1][1] = (vec2(-2.0, 1.0));
	var[1][0][2][0] = (vec2(-4.0, 3.0));
	var[1][0][2][1] = (vec2(0.0, 7.0));
	var[1][1][0][0] = (vec2(1.0, -2.0));
	var[1][1][0][1] = (vec2(-6.0, -3.0));
	var[1][1][1][0] = (vec2(-5.0, 4.0));
	var[1][1][1][1] = (vec2(-7.0, -6.0));
	var[1][1][2][0] = (vec2(1.0, -9.0));
	var[1][1][2][1] = (vec2(7.0, -1.0));
	var[2][0][0][0] = (vec2(-7.0, -5.0));
	var[2][0][0][1] = (vec2(6.0, -6.0));
	var[2][0][1][0] = (vec2(-4.0, 0.0));
	var[2][0][1][1] = (vec2(2.0, 3.0));
	var[2][0][2][0] = (vec2(-2.0, -4.0));
	var[2][0][2][1] = (vec2(-1.0, 1.0));
	var[2][1][0][0] = (vec2(-6.0, -1.0));
	var[2][1][0][1] = (vec2(9.0, -5.0));
	var[2][1][1][0] = (vec2(-2.0, -2.0));
	var[2][1][1][1] = (vec2(9.0, -8.0));
	var[2][1][2][0] = (vec2(2.0, 6.0));
	var[2][1][2][1] = (vec2(-1.0, 7.0));
	var[3][0][0][0] = (vec2(8.0, -9.0));
	var[3][0][0][1] = (vec2(8.0, -6.0));
	var[3][0][1][0] = (vec2(7.0, -2.0));
	var[3][0][1][1] = (vec2(1.0, -2.0));
	var[3][0][2][0] = (vec2(-7.0, -6.0));
	var[3][0][2][1] = (vec2(8.0, -4.0));
	var[3][1][0][0] = (vec2(4.0, -9.0));
	var[3][1][0][1] = (vec2(-8.0, -4.0));
	var[3][1][1][0] = (vec2(6.0, 9.0));
	var[3][1][1][1] = (vec2(-3.0, -1.0));
	var[3][1][2][0] = (vec2(-1.0, 5.0));
	var[3][1][2][1] = (vec2(-8.0, 1.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	highp mat2x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-5.0, 3.0, -2.0, -8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(1.0, -5.0, -5.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(-2.0, 0.0, 7.0, 6.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(3.0, 6.0, -5.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(9.0, 2.0, 6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(-7.0, -2.0, -4.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(3.0, 9.0, 1.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-9.0, -2.0, 6.0, 8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(5.0, -2.0, 0.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(6.0, 8.0, -4.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(6.0, 6.0, -9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(5.0, -3.0, 6.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-2.0, -7.0, 9.0, 9.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(0.0, -6.0, -7.0, 2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(3.0, 6.0, -6.0, -5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(-9.0, -2.0, -3.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(0.0, 2.0, -1.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(-9.0, -7.0, 7.0, 0.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(7.0, 0.0, -9.0, 4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(-9.0, 8.0, 7.0, -9.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(-9.0, 3.0, 1.0, -2.0, 9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	var[0][0][1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	var[0][0][2] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
	var[0][1][0] = (mat2x3(-9.0, 1.0, 2.0, -3.0, 0.0, -3.0));
	var[0][1][1] = (mat2x3(-2.0, 3.0, -2.0, 5.0, -6.0, -7.0));
	var[0][1][2] = (mat2x3(-7.0, 3.0, -4.0, -6.0, -2.0, 6.0));
	var[1][0][0] = (mat2x3(7.0, -4.0, 4.0, -5.0, -1.0, 0.0));
	var[1][0][1] = (mat2x3(2.0, -5.0, 6.0, 7.0, -2.0, 4.0));
	var[1][0][2] = (mat2x3(-3.0, 7.0, 6.0, -3.0, -2.0, -6.0));
	var[1][1][0] = (mat2x3(-7.0, -3.0, 3.0, -9.0, 3.0, 8.0));
	var[1][1][1] = (mat2x3(-1.0, 7.0, 4.0, -9.0, -7.0, 2.0));
	var[1][1][2] = (mat2x3(1.0, -7.0, -2.0, 5.0, -6.0, -6.0));
	var[2][0][0] = (mat2x3(7.0, -3.0, 2.0, 8.0, -1.0, 2.0));
	var[2][0][1] = (mat2x3(2.0, -9.0, 3.0, 1.0, -7.0, -7.0));
	var[2][0][2] = (mat2x3(3.0, -3.0, -5.0, 4.0, -6.0, 8.0));
	var[2][1][0] = (mat2x3(-1.0, -2.0, 6.0, 9.0, 1.0, -6.0));
	var[2][1][1] = (mat2x3(6.0, 6.0, 5.0, 3.0, 4.0, 7.0));
	var[2][1][2] = (mat2x3(0.0, 9.0, -5.0, 3.0, -7.0, 1.0));
	var[3][0][0] = (mat2x3(7.0, -9.0, 2.0, -8.0, 9.0, 9.0));
	var[3][0][1] = (mat2x3(3.0, 5.0, 8.0, 5.0, -7.0, 6.0));
	var[3][0][2] = (mat2x3(3.0, 6.0, 6.0, 1.0, 2.0, -7.0));
	var[3][1][0] = (mat2x3(0.0, 6.0, 0.0, 6.0, 4.0, -1.0));
	var[3][1][1] = (mat2x3(-2.0, 2.0, 3.0, 8.0, 3.0, -5.0));
	var[3][1][2] = (mat2x3(1.0, -6.0, -1.0, 5.0, 9.0, -6.0));
}
#version 450
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
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(6.0, -5.0, -6.0, 6.0, 3.0, -1.0, 3.0, 3.0, 7.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-8.0, 2.0, 5.0, -7.0, 6.0, -6.0, -4.0, 3.0, 5.0, 1.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(-3.0, 2.0, 2.0, -2.0, -2.0, 2.0, 5.0, 6.0, 3.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-8.0, -7.0, 6.0, 1.0, 0.0, -2.0, -9.0, 5.0, 0.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(9.0, 5.0, 6.0, 9.0, -3.0, -5.0, -4.0, -2.0, 3.0, -9.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(5.0, -9.0, -3.0, 8.0, -8.0, 6.0, 6.0, 8.0, -6.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(9.0, 7.0, 1.0, 2.0, 8.0, 4.0, 2.0, -2.0, 1.0, 2.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-3.0, -8.0, 7.0, -1.0, 8.0, -8.0, 6.0, -2.0, 2.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(9.0, 4.0, -9.0, -2.0, -3.0, -2.0, 2.0, 1.0, -8.0, 7.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(0.0, 4.0, 9.0, -3.0, 3.0, 5.0, 8.0, 3.0, 0.0, -3.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(5.0, -8.0, 5.0, 4.0, -4.0, 5.0, -2.0, 0.0, -4.0, 1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(2.0, -5.0, -4.0, -7.0, 7.0, -3.0, 9.0, -4.0, -8.0, 1.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	var[0][0][1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	var[0][0][2] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	var[0][1][0] = (mat4x3(-6.0, 9.0, 3.0, 4.0, 2.0, -2.0, -4.0, 3.0, 0.0, 4.0, -2.0, 0.0));
	var[0][1][1] = (mat4x3(6.0, -8.0, 4.0, 9.0, 3.0, 0.0, -8.0, -3.0, 5.0, 5.0, 7.0, 7.0));
	var[0][1][2] = (mat4x3(-1.0, -4.0, -7.0, -7.0, 7.0, 9.0, -7.0, 3.0, 7.0, -6.0, -6.0, 8.0));
	var[1][0][0] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	var[1][0][1] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	var[1][0][2] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	var[1][1][0] = (mat4x3(7.0, -7.0, -8.0, -3.0, 8.0, -1.0, -8.0, 2.0, -9.0, 9.0, 0.0, -7.0));
	var[1][1][1] = (mat4x3(-4.0, -2.0, 9.0, 2.0, -9.0, 7.0, 0.0, -4.0, 0.0, -3.0, 4.0, -6.0));
	var[1][1][2] = (mat4x3(9.0, -7.0, 9.0, 4.0, -8.0, 9.0, 0.0, -6.0, -6.0, 4.0, 4.0, 3.0));
	var[2][0][0] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	var[2][0][1] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	var[2][0][2] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	var[2][1][0] = (mat4x3(-9.0, -6.0, -4.0, -8.0, 0.0, 1.0, -9.0, -8.0, 1.0, 6.0, 3.0, -7.0));
	var[2][1][1] = (mat4x3(-8.0, -3.0, 4.0, -2.0, 5.0, -2.0, 4.0, 4.0, -7.0, 0.0, 0.0, -9.0));
	var[2][1][2] = (mat4x3(-5.0, -9.0, -7.0, 2.0, 1.0, 6.0, -3.0, 4.0, 2.0, 4.0, 3.0, -6.0));
	var[3][0][0] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	var[3][0][1] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	var[3][0][2] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
	var[3][1][0] = (mat4x3(3.0, 5.0, 5.0, 8.0, -4.0, -5.0, 6.0, 5.0, -2.0, -2.0, -1.0, -1.0));
	var[3][1][1] = (mat4x3(-2.0, 6.0, 8.0, 5.0, 5.0, 5.0, 4.0, 1.0, 7.0, -4.0, 8.0, -2.0));
	var[3][1][2] = (mat4x3(4.0, 7.0, 3.0, 7.0, 5.0, 9.0, -9.0, -5.0, 0.0, 1.0, -1.0, -2.0));
}
#version 450
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
	int16_t var[4][2][3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(var[0][0][0]), -5) && allOk;
	allOk = compare_int16_t(int(var[0][0][1]), 1) && allOk;
	allOk = compare_int16_t(int(var[0][0][2]), 8) && allOk;
	allOk = compare_int16_t(int(var[0][1][0]), 9) && allOk;
	allOk = compare_int16_t(int(var[0][1][1]), 5) && allOk;
	allOk = compare_int16_t(int(var[0][1][2]), 9) && allOk;
	allOk = compare_int16_t(int(var[1][0][0]), -2) && allOk;
	allOk = compare_int16_t(int(var[1][0][1]), 9) && allOk;
	allOk = compare_int16_t(int(var[1][0][2]), -5) && allOk;
	allOk = compare_int16_t(int(var[1][1][0]), -3) && allOk;
	allOk = compare_int16_t(int(var[1][1][1]), -1) && allOk;
	allOk = compare_int16_t(int(var[1][1][2]), -2) && allOk;
	allOk = compare_int16_t(int(var[2][0][0]), -8) && allOk;
	allOk = compare_int16_t(int(var[2][0][1]), 6) && allOk;
	allOk = compare_int16_t(int(var[2][0][2]), 3) && allOk;
	allOk = compare_int16_t(int(var[2][1][0]), 1) && allOk;
	allOk = compare_int16_t(int(var[2][1][1]), -9) && allOk;
	allOk = compare_int16_t(int(var[2][1][2]), -7) && allOk;
	allOk = compare_int16_t(int(var[3][0][0]), -8) && allOk;
	allOk = compare_int16_t(int(var[3][0][1]), 6) && allOk;
	allOk = compare_int16_t(int(var[3][0][2]), -7) && allOk;
	allOk = compare_int16_t(int(var[3][1][0]), 8) && allOk;
	allOk = compare_int16_t(int(var[3][1][1]), 8) && allOk;
	allOk = compare_int16_t(int(var[3][1][2]), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = int16_t(6);
	var[0][0][1] = int16_t(8);
	var[0][0][2] = int16_t(-2);
	var[0][1][0] = int16_t(3);
	var[0][1][1] = int16_t(9);
	var[0][1][2] = int16_t(6);
	var[1][0][0] = int16_t(-4);
	var[1][0][1] = int16_t(-3);
	var[1][0][2] = int16_t(9);
	var[1][1][0] = int16_t(2);
	var[1][1][1] = int16_t(3);
	var[1][1][2] = int16_t(7);
	var[2][0][0] = int16_t(-5);
	var[2][0][1] = int16_t(-8);
	var[2][0][2] = int16_t(-3);
	var[2][1][0] = int16_t(7);
	var[2][1][1] = int16_t(7);
	var[2][1][2] = int16_t(1);
	var[3][0][0] = int16_t(2);
	var[3][0][1] = int16_t(-1);
	var[3][0][2] = int16_t(4);
	var[3][1][0] = int16_t(-9);
	var[3][1][1] = int16_t(-3);
	var[3][1][2] = int16_t(0);
}
#version 450
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
	highp mat3x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(5.0, -6.0, -5.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-5.0, -6.0, -8.0, 6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-1.0, 7.0, -4.0, 3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-5.0, -2.0, 0.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(-1.0, 7.0, 3.0, 8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(6.0, -7.0, 7.0, 5.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(1.0, -2.0, -2.0, -9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(8.0, 2.0, -1.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(2.0, -8.0, 9.0, -8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(5.0, 0.0, 4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-7.0, -4.0, 1.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-8.0, -7.0, -1.0, -4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(9.0, 0.0, 2.0, -5.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(-5.0, 6.0, -3.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(-6.0, 0.0, 6.0, 9.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(1.0, 8.0, 6.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(-1.0, -1.0, -2.0, -8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(-8.0, -6.0, 0.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(7.0, 9.0, 8.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(8.0, -3.0, 8.0, -5.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(9.0, -6.0, -8.0, -7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(-2.0, -1.0, 1.0, 6.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(2.0, 5.0, 4.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(-7.0, -1.0, -1.0, -7.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	var[0][0][1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	var[0][1][0] = (mat3x2(7.0, 9.0, -5.0, 9.0, -1.0, 4.0));
	var[0][1][1] = (mat3x2(6.0, -4.0, -6.0, 0.0, 7.0, -2.0));
	var[0][2][0] = (mat3x2(4.0, -9.0, -8.0, 7.0, -5.0, -1.0));
	var[0][2][1] = (mat3x2(-7.0, 4.0, -2.0, -6.0, -5.0, 6.0));
	var[0][3][0] = (mat3x2(-3.0, -4.0, -7.0, 0.0, 8.0, 4.0));
	var[0][3][1] = (mat3x2(-8.0, -5.0, -1.0, -5.0, 2.0, -6.0));
	var[1][0][0] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
	var[1][0][1] = (mat3x2(0.0, 6.0, -5.0, 4.0, -2.0, 0.0));
	var[1][1][0] = (mat3x2(-1.0, -9.0, 8.0, -6.0, -9.0, 5.0));
	var[1][1][1] = (mat3x2(2.0, -9.0, 9.0, 4.0, -4.0, 9.0));
	var[1][2][0] = (mat3x2(-3.0, -7.0, 9.0, 9.0, -8.0, 0.0));
	var[1][2][1] = (mat3x2(6.0, -3.0, 9.0, -2.0, -5.0, -4.0));
	var[1][3][0] = (mat3x2(3.0, 4.0, 5.0, 1.0, -7.0, 1.0));
	var[1][3][1] = (mat3x2(2.0, -7.0, -1.0, -4.0, 8.0, 1.0));
	var[2][0][0] = (mat3x2(-3.0, -3.0, -2.0, 9.0, -2.0, -7.0));
	var[2][0][1] = (mat3x2(-9.0, -2.0, -8.0, 4.0, 3.0, 8.0));
	var[2][1][0] = (mat3x2(3.0, 3.0, 1.0, -4.0, 0.0, -7.0));
	var[2][1][1] = (mat3x2(-4.0, 7.0, 7.0, -1.0, -2.0, 6.0));
	var[2][2][0] = (mat3x2(-4.0, 6.0, -7.0, 5.0, -1.0, 5.0));
	var[2][2][1] = (mat3x2(4.0, -7.0, -3.0, 6.0, -8.0, 2.0));
	var[2][3][0] = (mat3x2(-8.0, 2.0, 7.0, 8.0, -5.0, -3.0));
	var[2][3][1] = (mat3x2(8.0, -6.0, 3.0, -2.0, 7.0, -4.0));
}
#version 450
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
	highp mat3x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(2.0, 6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(2.0, 6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(5.0, 2.0, -1.0, 6.0, -6.0, 4.0, 2.0, 5.0, 9.0, 7.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(-2.0, -5.0, 0.0, 0.0, 2.0, 5.0, 8.0, -5.0, 7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(-2.0, -9.0, 2.0, -8.0, -3.0, 1.0, -5.0, 1.0, 3.0, 1.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(3.0, -7.0, -4.0, -9.0, 6.0, 5.0, 0.0, -1.0, -4.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(3.0, 2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(1.0, 9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-1.0, 0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(-7.0, -9.0, 9.0, 1.0, -6.0, 3.0, 9.0, 6.0, -4.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(0.0, -4.0, 4.0, -6.0, 0.0, -7.0, -2.0, 2.0, 1.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(-9.0, 4.0, 0.0, -9.0, 6.0, -2.0, -9.0, 9.0, 1.0, 8.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(-4.0, -7.0, 1.0, 0.0, 6.0, -8.0, 9.0, -2.0, 3.0, 4.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(4.0, -6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(7.0, 9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-8.0, -3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(-5.0, -2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(-4.0, -6.0, -6.0, 3.0, -4.0, 7.0, -9.0, 0.0, 4.0, 0.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(-7.0, -8.0, -8.0, -8.0, 9.0, 7.0, -9.0, -6.0, -2.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-6.0, 3.0, 7.0, 1.0, -9.0, -5.0, 4.0, 9.0, 4.0, -7.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(-8.0, -4.0, -3.0, -5.0, -2.0, -8.0, 2.0, -1.0, 4.0, 7.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	var[0][0][1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	var[0][1][0] = (mat3x4(-2.0, -7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0));
	var[0][1][1] = (mat3x4(-8.0, 8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0));
	var[0][2][0] = (mat3x4(-7.0, 8.0, 5.0, -1.0, 0.0, 6.0, 7.0, -1.0, 3.0, 5.0, -7.0, 2.0));
	var[0][2][1] = (mat3x4(9.0, -2.0, -7.0, -4.0, 7.0, 9.0, 9.0, -2.0, -7.0, -3.0, 9.0, 9.0));
	var[0][3][0] = (mat3x4(-5.0, 9.0, -5.0, 5.0, -4.0, 7.0, 7.0, -1.0, -9.0, 8.0, 2.0, -5.0));
	var[0][3][1] = (mat3x4(-4.0, 4.0, -6.0, 7.0, 7.0, 0.0, -4.0, -5.0, 3.0, -2.0, -4.0, -9.0));
	var[1][0][0] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
	var[1][0][1] = (mat3x4(-9.0, 4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0));
	var[1][1][0] = (mat3x4(6.0, -1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0));
	var[1][1][1] = (mat3x4(5.0, 5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0));
	var[1][2][0] = (mat3x4(4.0, -7.0, 5.0, -1.0, -8.0, -1.0, -1.0, 1.0, -1.0, 6.0, 6.0, 9.0));
	var[1][2][1] = (mat3x4(3.0, 1.0, 7.0, 6.0, 8.0, 1.0, 8.0, -5.0, -5.0, -9.0, -1.0, -9.0));
	var[1][3][0] = (mat3x4(9.0, 0.0, -3.0, -8.0, 1.0, -4.0, 4.0, 3.0, 4.0, -8.0, 6.0, 7.0));
	var[1][3][1] = (mat3x4(-6.0, -3.0, 9.0, 1.0, -6.0, 0.0, -9.0, -9.0, -2.0, -6.0, 0.0, 2.0));
	var[2][0][0] = (mat3x4(3.0, 1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0));
	var[2][0][1] = (mat3x4(1.0, 5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0));
	var[2][1][0] = (mat3x4(-4.0, 7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0));
	var[2][1][1] = (mat3x4(-1.0, 3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0));
	var[2][2][0] = (mat3x4(-1.0, 6.0, 3.0, -9.0, -4.0, -5.0, 2.0, -2.0, -2.0, -2.0, -2.0, 2.0));
	var[2][2][1] = (mat3x4(-7.0, -4.0, 6.0, -9.0, 6.0, -3.0, -9.0, 6.0, 3.0, 2.0, -5.0, -9.0));
	var[2][3][0] = (mat3x4(-4.0, 1.0, 0.0, -2.0, 8.0, 2.0, 9.0, 3.0, -5.0, -2.0, -4.0, 0.0));
	var[2][3][1] = (mat3x4(-3.0, -7.0, -4.0, 2.0, 1.0, -7.0, 2.0, 9.0, 1.0, -1.0, -2.0, 3.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
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

layout(scalar, binding = 1) buffer Block
{
	u16vec2 var[][4][2];
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(var[0][0][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][0][1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1][0]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1][1]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][2][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][2][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][3][0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][3][1]), uvec2(0u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0][0]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0][1]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1][0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1][1]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][2][0]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][2][1]), uvec2(4u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][3][0]), uvec2(9u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][3][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0][0]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0][1]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1][0]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1][1]), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][2][0]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][2][1]), uvec2(1u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][3][0]), uvec2(3u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][3][1]), uvec2(2u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u16vec2(uvec2(8u, 0u));
	var[0][0][1] = u16vec2(uvec2(6u, 0u));
	var[0][1][0] = u16vec2(uvec2(1u, 1u));
	var[0][1][1] = u16vec2(uvec2(2u, 8u));
	var[0][2][0] = u16vec2(uvec2(7u, 0u));
	var[0][2][1] = u16vec2(uvec2(3u, 9u));
	var[0][3][0] = u16vec2(uvec2(7u, 6u));
	var[0][3][1] = u16vec2(uvec2(4u, 4u));
	var[1][0][0] = u16vec2(uvec2(6u, 9u));
	var[1][0][1] = u16vec2(uvec2(3u, 2u));
	var[1][1][0] = u16vec2(uvec2(1u, 5u));
	var[1][1][1] = u16vec2(uvec2(0u, 2u));
	var[1][2][0] = u16vec2(uvec2(8u, 9u));
	var[1][2][1] = u16vec2(uvec2(1u, 2u));
	var[1][3][0] = u16vec2(uvec2(6u, 4u));
	var[1][3][1] = u16vec2(uvec2(5u, 7u));
	var[2][0][0] = u16vec2(uvec2(9u, 2u));
	var[2][0][1] = u16vec2(uvec2(4u, 5u));
	var[2][1][0] = u16vec2(uvec2(3u, 8u));
	var[2][1][1] = u16vec2(uvec2(1u, 8u));
	var[2][2][0] = u16vec2(uvec2(5u, 7u));
	var[2][2][1] = u16vec2(uvec2(9u, 9u));
	var[2][3][0] = u16vec2(uvec2(9u, 3u));
	var[2][3][1] = u16vec2(uvec2(3u, 2u));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-9, 2, 5)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(1.0, 5.0, 0.0, -2.0, -5.0, -5.0, -1.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-8.0, -9.0, -8.0, -2.0, -9.0, 5.0, 0.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(0.0, -2.0, 3.0, 5.0, -1.0, -2.0, -1.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-8.0, 1.0, 5.0, 3.0, -1.0, -3.0, 5.0, -1.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(-1.0, 6.0, -6.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(5, 2, 0)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(8.0, -8.0, -8.0, 8.0, 4.0, 2.0, -7.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-7.0, -4.0, 5.0, -5.0, 8.0, -4.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(5.0, -3.0, -9.0, 7.0, 0.0, 0.0, 2.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-9.0, -1.0, 9.0, -9.0, -1.0, 2.0, -7.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-4.0, -2.0, -3.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-3, -9, 1)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(2.0, 6.0, 3.0, -4.0, -5.0, 3.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(0.0, 3.0, 3.0, 5.0, -1.0, -2.0, -6.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(8.0, -6.0, 3.0, 0.0, -9.0, 2.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-4.0, 0.0, -6.0, 0.0, 6.0, -3.0, -6.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-6.0, 2.0, 1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-3, -4, 7));
	block[0].s.b[0] = (mat3(5.0, 3.0, -9.0, -1.0, 5.0, 9.0, -5.0, 5.0, 7.0));
	block[0].s.b[1] = (mat3(-1.0, -8.0, -6.0, -1.0, 4.0, 9.0, -7.0, -5.0, -1.0));
	block[0].s.b[2] = (mat3(5.0, 9.0, -8.0, 6.0, -9.0, 8.0, 2.0, -2.0, -9.0));
	block[0].s.b[3] = (mat3(-2.0, 1.0, 2.0, -1.0, 5.0, -4.0, 6.0, 8.0, -8.0));
	block[0].s.c = (vec4(4.0, 0.0, 5.0, 3.0));
	block[1].s.a = (ivec3(3, 7, -2));
	block[1].s.b[0] = (mat3(-3.0, -5.0, -8.0, 9.0, 4.0, -6.0, 1.0, -4.0, -2.0));
	block[1].s.b[1] = (mat3(9.0, 6.0, -3.0, -7.0, 7.0, 5.0, 2.0, -7.0, 6.0));
	block[1].s.b[2] = (mat3(1.0, 3.0, 6.0, -6.0, 5.0, -6.0, 3.0, 5.0, 5.0));
	block[1].s.b[3] = (mat3(4.0, -7.0, -5.0, 6.0, -2.0, 8.0, -4.0, 1.0, 7.0));
	block[1].s.c = (vec4(-9.0, 9.0, 8.0, -9.0));
	block[2].s.a = (ivec3(6, 0, 0));
	block[2].s.b[0] = (mat3(7.0, 1.0, -9.0, -1.0, -3.0, 1.0, 9.0, 0.0, 9.0));
	block[2].s.b[1] = (mat3(7.0, -1.0, 0.0, -2.0, -1.0, -5.0, -8.0, 2.0, -2.0));
	block[2].s.b[2] = (mat3(2.0, 3.0, 6.0, 0.0, 5.0, -8.0, -1.0, 8.0, 5.0));
	block[2].s.b[3] = (mat3(-2.0, -1.0, -8.0, 6.0, 0.0, 9.0, -5.0, -6.0, 8.0));
	block[2].s.c = (vec4(-2.0, 4.0, -6.0, -4.0));
}
#version 450
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
	allOk = compare_mat3(block[0].t[0].a, mat3(9.0, 1.0, 4.0, 9.0, 2.0, -8.0, 4.0, 8.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(-9, 9, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(-2, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(4, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(7, 6)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(4.0, -2.0, 1.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(0, 8, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(4, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(-9, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(-4, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(-9, -5)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-1.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(-6, 7, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(3, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(-9, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(1, -2)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(6.0, -9.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(8.0, 7.0, -6.0, 1.0, 1.0, -3.0, -2.0, 0.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(-1, 4, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(-2, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(6, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(0, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(-3, -1)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(-9.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(-5, -3, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(-6, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(1, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(4, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(4, -7)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(-4.0, 8.0, 0.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(-3, 5, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(-6, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(-2, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(-1, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(-5, -7)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(3.0, 7.0, -7.0, -7.0)) && allOk;
	allOk = compare_uint((block[0].u), 4u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(2.0, -8.0, -5.0, 2.0, 5.0, -8.0, -3.0, -9.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(1, 1, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(0, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(9, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(0, -4)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-2.0, 4.0, 5.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(-9, -9, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(8, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(-8, -5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(-5, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(-4, 8)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-1.0, -5.0, 5.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(5, -8, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(1, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(-2, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(-7, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(-3, 0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-2.0, -1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(9.0, -6.0, -8.0, 9.0, 8.0, -8.0, -7.0, -6.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(-3, 5, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(9, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(8, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(-9, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(8, -3)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(-6.0, -6.0, 7.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(-7, -5, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(2, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(-7, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(3, 6)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(-1.0, 4.0, 3.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(-6, 7, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(4, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(9, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(-1, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(6, 5)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(5.0, 6.0, 6.0, 0.0)) && allOk;
	allOk = compare_uint((block[1].u), 2u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(-2.0, 4.0, 1.0, -1.0, -1.0, -4.0, 7.0, -8.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(-6, 4, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(1, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(4, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(-8, -2)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(8.0, -4.0, 0.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(-1, -6, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(1, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(-3, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-4, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(7, -5)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(1.0, 7.0, 5.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(4, 6, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(1, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(-7, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(3, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(-6, -2)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(-3.0, 4.0, -4.0, 6.0, -3.0, -3.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(-9, 5, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(-9, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(8, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(1, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(6, -1)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(-9.0, 2.0, 3.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(-2, -8, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(9, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(-8, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(-2, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(6, 4)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(-8.0, -3.0, -4.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(-5, 8, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(-6, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(-7, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(4, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(9, -8)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(9.0, -8.0, -9.0, 0.0)) && allOk;
	allOk = compare_uint((block[2].u), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(5, -9, -8));
	block[0].s.b[0] = (ivec2(1, 8));
	block[0].s.b[1] = (ivec2(-1, 4));
	block[0].s.b[2] = (ivec2(-7, 5));
	block[0].s.b[3] = (ivec2(5, 1));
	block[0].s.c = (vec4(-2.0, 7.0, 4.0, 3.0));
	block[0].u = (4u);
	block[1].s.a = (ivec3(4, -2, -3));
	block[1].s.b[0] = (ivec2(-9, 5));
	block[1].s.b[1] = (ivec2(-2, -5));
	block[1].s.b[2] = (ivec2(6, -9));
	block[1].s.b[3] = (ivec2(-3, -6));
	block[1].s.c = (vec4(-7.0, 3.0, -4.0, 8.0));
	block[1].u = (2u);
	block[2].s.a = (ivec3(-5, 8, 9));
	block[2].s.b[0] = (ivec2(8, -7));
	block[2].s.b[1] = (ivec2(-1, -1));
	block[2].s.b[2] = (ivec2(-8, 7));
	block[2].s.b[3] = (ivec2(-6, -9));
	block[2].s.c = (vec4(-9.0, 2.0, -5.0, -4.0));
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
	highp uvec2 a;
	mediump mat2x4 b[4];
	highp vec3 c;
};
layout(std430, binding = 1) buffer Block
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat3x2 var;
} block[3];

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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat3x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 1.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -6.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(2.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(2.0, 3.0, 6.0, 6.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 4.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 3.0) && allOk;
	allOk = compare_float(block[1].var[2][3], -9.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-4.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(9.0, 3.0, 2.0, -4.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(-7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 7.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 0.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -9.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(3.0, -5.0, 6.0, -3.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(3.0, 2.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-7.0, 0.0, 1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(8.0, 8.0, -2.0, 8.0));
	block[0].var[1] = (vec4(8.0, 3.0, 5.0, -5.0));
	block[0].var[2] = (vec4(7.0, 6.0, -9.0, 3.0));
	block[1].var[0] = (vec4(0.0, -3.0, 1.0, -9.0));
	block[1].var[1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	block[1].var[2] = (vec4(9.0, 0.0, -9.0, -2.0));
	block[2].var[0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	block[2].var[1] = (vec4(1.0, -2.0, -2.0, -1.0));
	block[2].var[2] = (vec4(-7.0, 8.0, 0.0, -6.0));
}
#version 450
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
	highp mat4x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(block[0].var, mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	block[1].var = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	block[2].var = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
}
#version 450
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
	u8vec2 var;
} block[3];

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(block[0].var), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block[1].var), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block[2].var), uvec2(4u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = u8vec2(uvec2(7u, 7u));
	block[1].var = u8vec2(uvec2(9u, 6u));
	block[2].var = u8vec2(uvec2(0u, 2u));
}
#version 450
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
	i8vec2 var;
} block[3];

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

layout(std430, binding = 1) buffer Block
{
	i8vec3 var;
} block[3];

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(block[0].var), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block[1].var), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(block[2].var), ivec3(7, 9, 4294967292)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = i8vec3(ivec3(4294967292, 0, 0));
	block[1].var = i8vec3(ivec3(7, 9, 4294967290));
	block[2].var = i8vec3(ivec3(4294967288, 9, 4294967288));
}
#version 450
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
	bvec4 var;
} block[3];

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

layout(scalar, binding = 1) buffer Block
{
	float padding;
	highp mat2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -7.0) && allOk;
	allOk = compare_mat2(block[0].var, mat2(-2.0, 6.0, -6.0, 0.0)) && allOk;
	allOk = compare_float((block[1].padding), 4.0) && allOk;
	allOk = compare_mat2(block[1].var, mat2(-7.0, 8.0, -2.0, -1.0)) && allOk;
	allOk = compare_float((block[2].padding), -9.0) && allOk;
	allOk = compare_mat2(block[2].var, mat2(-3.0, 6.0, -4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (1.0);
	block[0].var = (mat2(2.0, 6.0, -6.0, 2.0));
	block[1].padding = (4.0);
	block[1].var = (mat2(4.0, 7.0, 0.0, 8.0));
	block[2].padding = (0.0);
	block[2].var = (mat2(-1.0, 8.0, -4.0, -5.0));
}
#version 450
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
} block[3];

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

layout(scalar, row_major, binding = 1) buffer Block
{
	float padding;
	highp mat2 var;
} block[3];

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

layout(scalar, binding = 1) buffer Block
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

layout(scalar, row_major, binding = 1) buffer Block
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
	allOk = compare_float((block[0].padding), 9.0) && allOk;
	allOk = compare_mat4x2(block[0].var, mat4x2(-3.0, -5.0, -5.0, -4.0, 8.0, -3.0, 2.0, 7.0)) && allOk;
	allOk = compare_float((block[1].padding), -8.0) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(-7.0, -5.0, -5.0, -5.0, 7.0, -9.0, 9.0, 3.0)) && allOk;
	allOk = compare_float((block[2].padding), 5.0) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(9.0, -8.0, 8.0, 7.0, -7.0, -4.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-9.0);
	block[0].var = (mat4x2(1.0, 5.0, 0.0, 6.0, 3.0, 6.0, 9.0, -5.0));
	block[1].padding = (8.0);
	block[1].var = (mat4x2(1.0, -3.0, 2.0, 4.0, -7.0, 8.0, -6.0, 6.0));
	block[2].padding = (1.0);
	block[2].var = (mat4x2(9.0, -3.0, -2.0, 2.0, 6.0, -9.0, -9.0, -1.0));
}
#version 450
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
	highp mat4x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -4.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -7.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][1], -8.0) && allOk;
	allOk = compare_float(block[0].var[3][2], -4.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(6.0, 7.0, -6.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(2.0, -5.0, 0.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(-2.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(6.0, -8.0, -4.0)) && allOk;
	allOk = compare_float((block[1].padding), -5.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 7.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[3][2], 5.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-7.0, 0.0, -7.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-8.0, -3.0, 1.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(3.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(-4.0, -9.0, 5.0)) && allOk;
	allOk = compare_float((block[2].padding), 2.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -6.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[3][2], 0.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-9.0, 9.0, 2.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(8.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(8.0, 6.0, -6.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(-9.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-3.0);
	block[0].var[0] = (vec3(-6.0, 6.0, 1.0));
	block[0].var[1] = (vec3(-4.0, -3.0, -3.0));
	block[0].var[2] = (vec3(3.0, -2.0, -7.0));
	block[0].var[3] = (vec3(1.0, -5.0, -1.0));
	block[1].padding = (-5.0);
	block[1].var[0] = (vec3(7.0, 1.0, -2.0));
	block[1].var[1] = (vec3(-4.0, -4.0, -6.0));
	block[1].var[2] = (vec3(5.0, -2.0, 6.0));
	block[1].var[3] = (vec3(-9.0, 5.0, -5.0));
	block[2].padding = (7.0);
	block[2].var[0] = (vec3(-4.0, 8.0, -3.0));
	block[2].var[1] = (vec3(-2.0, 0.0, 8.0));
	block[2].var[2] = (vec3(-2.0, 6.0, -3.0));
	block[2].var[3] = (vec3(-9.0, -2.0, -2.0));
}
#version 450
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
	bool b;
	lowp uvec4 c;
	lowp mat4x3 d;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.c), uvec4(4u, 5u, 4u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockB.b = (true);
	blockB.c = (uvec4(4u, 4u, 2u, 4u));
	blockB.d = (mat4x3(2.0, 6.0, 1.0, 9.0, -5.0, 9.0, -3.0, 6.0, 7.0, -9.0, -6.0, -1.0));
}
#version 450
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
	bvec3 a[6];
	mediump ivec4 b;
	mediump mat3x2 c;
	mediump int d[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp int e;
	highp uint f;
	mediump uvec4 g[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	lowp vec4 h;
	highp vec2 i;
	mediump uvec4 j;
	highp mat3x2 k;
	bvec2 l[];
};
layout(std140, row_major, binding = 4) readonly buffer BlockE
{
	mediump mat4 m;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a[0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.a[1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockB.a[2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.a[3]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.a[4]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.a[5]), bvec3(false, false, false)) && allOk;
	allOk = compare_ivec4((blockB.b), ivec4(6, -8, -9, 0)) && allOk;
	allOk = compare_mat3x2(blockB.c, mat3x2(-1.0, 4.0, -1.0, 0.0, 5.0, -1.0)) && allOk;
	allOk = compare_uvec4((g[0]), uvec4(7u, 9u, 2u, 6u)) && allOk;
	allOk = compare_uvec4((g[1]), uvec4(6u, 9u, 9u, 3u)) && allOk;
	allOk = compare_vec4((h), vec4(5.0, 1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec2((i), vec2(4.0, -4.0)) && allOk;
	allOk = compare_uvec4((j), uvec4(9u, 5u, 8u, 1u)) && allOk;
	allOk = compare_mat3x2(k, mat3x2(-1.0, -1.0, -9.0, -4.0, -9.0, 5.0)) && allOk;
	allOk = compare_bvec2((l[0]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (mat3x2(4.0, -7.0, -5.0, -1.0, 0.0, 7.0));
	e = (0);
	f = (7u);
	g[0] = (uvec4(2u, 5u, 3u, 2u));
	g[1] = (uvec4(1u, 6u, 1u, 9u));
	h = (vec4(9.0, -1.0, 8.0, 4.0));
	i = (vec2(9.0, -5.0));
	k = (mat3x2(9.0, 6.0, 3.0, 7.0, -9.0, 3.0));
}
#version 450
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
	highp uvec3 a[1];
	mediump float b;
	mediump mat3x2 c;
	mediump ivec4 d;
	highp uvec3 e;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	bvec3 f;
	highp mat4 g;
	bvec2 h;
	mediump ivec4 i;
	highp vec3 j[];
};
layout(std140, column_major, binding = 3) readonly buffer BlockD
{
	mediump float k[];
} blockD[1];
layout(std430, column_major, binding = 4) buffer BlockE
{
	bvec4 l;
	mediump ivec2 m;
	highp float n[];
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((a[0]), uvec3(4u, 9u, 6u)) && allOk;
	allOk = compare_uvec3((e), uvec3(2u, 6u, 4u)) && allOk;
	allOk = compare_mat4(g, mat4(6.0, -8.0, 7.0, -3.0, -9.0, 9.0, 8.0, 2.0, 4.0, -4.0, -4.0, 1.0, 9.0, -1.0, 6.0, -9.0)) && allOk;
	allOk = compare_vec3((j[0]), vec3(1.0, 9.0, -8.0)) && allOk;
	allOk = compare_float((blockD[0].k[0]), -7.0) && allOk;
	allOk = compare_bvec4((blockE[0].l), bvec4(true, false, true, true)) && allOk;
	allOk = compare_ivec2((blockE[0].m), ivec2(1, 0)) && allOk;
	allOk = compare_bvec4((blockE[1].l), bvec4(false, false, false, true)) && allOk;
	allOk = compare_ivec2((blockE[1].m), ivec2(-6, 7)) && allOk;
	allOk = compare_bvec4((blockE[2].l), bvec4(false, false, false, true)) && allOk;
	allOk = compare_ivec2((blockE[2].m), ivec2(0, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (9.0);
	f = (bvec3(true, false, false));
	g = (mat4(-5.0, 9.0, -1.0, 1.0, 7.0, 9.0, -8.0, -6.0, 4.0, 8.0, -8.0, 4.0, 6.0, -9.0, 5.0, 6.0));
	h = (bvec2(true, true));
	i = (ivec4(-3, -8, -6, 3));
	j[0] = (vec3(2.0, 7.0, 2.0));
	blockE[0].l = (bvec4(false, false, false, true));
	blockE[0].n[0] = (-8.0);
	blockE[1].l = (bvec4(true, true, false, true));
	blockE[1].n[0] = (4.0);
	blockE[2].l = (bvec4(false, true, true, true));
	blockE[2].n[0] = (0.0);
}
#version 450
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
	bvec3 a;
	lowp mat3x2 b[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
	allOk = compare_mat3x2(blockB.b[0], mat3x2(-1.0, -9.0, 5.0, -7.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1], mat3x2(-4.0, -8.0, 8.0, -8.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2], mat3x2(9.0, -2.0, -2.0, 1.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[3], mat3x2(-1.0, 9.0, -5.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[4], mat3x2(8.0, -6.0, 8.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[5], mat3x2(3.0, -5.0, -3.0, 0.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, false, true));
}
#version 450
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
	lowp uint mB;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	sA a;
	highp mat3x4 b[];
} blockB[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB[0].a.mA, mat4(-7.0, 3.0, -2.0, 9.0, -9.0, -1.0, -9.0, 1.0, -8.0, 6.0, -5.0, -8.0, 2.0, 7.0, -7.0, 7.0)) && allOk;
	allOk = compare_uint((blockB[0].a.mB), 4u) && allOk;
	allOk = compare_mat3x4(blockB[0].b[0], mat3x4(8.0, -1.0, 2.0, 0.0, 1.0, 6.0, -5.0, 2.0, 7.0, -5.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4(blockB[1].a.mA, mat4(0.0, -9.0, -3.0, -2.0, 0.0, -6.0, -3.0, 1.0, 8.0, -5.0, 8.0, 8.0, 9.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_uint((blockB[1].a.mB), 2u) && allOk;
	allOk = compare_mat3x4(blockB[1].b[0], mat3x4(6.0, -4.0, 8.0, -4.0, -1.0, -9.0, -5.0, 5.0, -5.0, -4.0, -6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (mat4(-6.0, -2.0, 3.0, -5.0, -4.0, 5.0, -9.0, 8.0, 1.0, 9.0, 5.0, -4.0, -9.0, -3.0, 7.0, 3.0));
	blockB[0].a.mB = (2u);
	blockB[1].a.mA = (mat4(1.0, -8.0, -8.0, -1.0, -5.0, 7.0, -5.0, -3.0, -8.0, 6.0, -4.0, -9.0, 8.0, -8.0, -5.0, 1.0));
	blockB[1].a.mB = (0u);
}
#version 450
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
	highp uvec4 mB[4];
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	highp mat3x2 a;
	lowp vec3 b;
	highp uvec3 c;
	highp vec2 d;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	lowp mat2 e;
	highp vec4 f;
	sA g;
	highp uvec4 h[];
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	highp mat3x4 i;
	bool j[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(8.0, 0.0, -5.0, 3.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB.d), vec2(-9.0, 5.0)) && allOk;
	allOk = compare_uvec4((blockC.h[0]), uvec4(6u, 0u, 7u, 6u)) && allOk;
	allOk = compare_uvec4((blockC.h[1]), uvec4(8u, 1u, 6u, 6u)) && allOk;
	allOk = compare_uvec4((blockC.h[2]), uvec4(0u, 2u, 3u, 2u)) && allOk;
	allOk = compare_mat3x4(blockD.i, mat3x4(1.0, 8.0, 6.0, -3.0, -2.0, -5.0, 0.0, 8.0, -2.0, 3.0, -6.0, -5.0)) && allOk;
	allOk = compare_bool((blockD.j[0]), false) && allOk;
	allOk = compare_bool((blockD.j[1]), false) && allOk;
	allOk = compare_bool((blockD.j[2]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(8.0, 3.0, 2.0, -3.0, -4.0, 7.0));
	blockB.b = (vec3(-3.0, 4.0, 3.0));
	blockB.c = (uvec3(3u, 0u, 6u));
	blockB.d = (vec2(0.0, 4.0));
	blockC.e = (mat2(2.0, -9.0, -8.0, 9.0));
	blockC.f = (vec4(-6.0, -4.0, 5.0, -4.0));
	blockD.i = (mat3x4(-1.0, -4.0, -3.0, -6.0, -9.0, 9.0, 4.0, -4.0, 7.0, -5.0, 7.0, 6.0));
	blockD.j[0] = (true);
	blockD.j[1] = (false);
	blockD.j[2] = (false);
}
#version 450
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
	layout(offset = 16) mediump int b;
	layout(offset = 32) bvec4 c;
	layout(offset = 48) bvec3 d;
	layout(offset = 64) highp uvec2 e;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp vec2 f;
	layout(offset = 8) bvec2 g[1];
} blockC[3];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec2 h;
} blockD[3];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump ivec3 i[1];
	layout(offset = 16) bvec3 j;
	layout(offset = 28) bool k;
	layout(offset = 32) lowp vec3 l;
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((b), -2) && allOk;
	allOk = compare_bvec4((c), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec3((d), bvec3(false, true, false)) && allOk;
	allOk = compare_uvec2((e), uvec2(9u, 4u)) && allOk;
	allOk = compare_bvec2((blockC[0].g[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[1].g[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[2].g[0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[0].h), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[1].h), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[2].h), bvec2(false, false)) && allOk;
	allOk = compare_bvec3((blockE[0].j), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((blockE[0].l), vec3(-7.0, 3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, false, true, true));
	c = (bvec4(true, true, true, false));
	d = (bvec3(false, true, true));
	e = (uvec2(1u, 4u));
	blockC[0].f = (vec2(-9.0, 3.0));
	blockC[0].g[0] = (bvec2(true, false));
	blockC[1].f = (vec2(2.0, 7.0));
	blockC[1].g[0] = (bvec2(true, true));
	blockC[2].f = (vec2(-4.0, -9.0));
	blockC[2].g[0] = (bvec2(true, true));
	blockD[0].h = (bvec2(true, true));
	blockD[1].h = (bvec2(false, true));
	blockD[2].h = (bvec2(false, false));
	blockE[0].i[0] = (ivec3(9, -2, -6));
	blockE[0].j = (bvec3(false, true, false));
	blockE[0].k = (true);
	blockE[0].l = (vec3(-4.0, 7.0, 6.0));
}
#version 450
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
	layout(offset = 12) lowp int b;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec3 c;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp vec4 d;
	layout(offset = 16) lowp uvec4 e;
	layout(offset = 32) bool f;
	layout(offset = 36) bool g[1];
	layout(offset = 48) lowp vec3 h;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) lowp uint i;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(-7, 3, 4)) && allOk;
	allOk = compare_bvec3((c), bvec3(true, false, false)) && allOk;
	allOk = compare_vec4((d), vec4(6.0, -2.0, -7.0, -1.0)) && allOk;
	allOk = compare_uvec4((e), uvec4(6u, 9u, 9u, 1u)) && allOk;
	allOk = compare_bool((f), false) && allOk;
	allOk = compare_bool((g[0]), false) && allOk;
	allOk = compare_vec3((h), vec3(-8.0, -4.0, -3.0)) && allOk;
	allOk = compare_uint((i), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (6);
	c = (bvec3(true, true, false));
	d = (vec4(2.0, -1.0, -1.0, -8.0));
	f = (true);
	g[0] = (false);
	h = (vec3(-2.0, -4.0, 5.0));
	i = (4u);
}
#version 450
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
	layout(offset = 12) mediump uint b[1];
	layout(offset = 16) highp ivec2 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((a), vec3(3.0, 7.0, 9.0)) && allOk;
	allOk = compare_ivec2((c), ivec2(0, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (1u);
	c = (ivec2(-9, 0));
}
#version 450
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
	bvec4 a;
	lowp mat3 b;
	bool c;
	lowp mat4x3 d[];
} blockB[3];
layout(scalar, row_major, binding = 2) buffer BlockC
{
	lowp mat2x3 e;
	bvec4 f;
	highp mat2 g;
	highp vec2 h[];
} blockC;

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

struct sA
{
	mediump int mA;
	lowp mat2 mB;
	u16vec2 mC;
	highp mat3x4 mD;
};
layout(std140, binding = 1) buffer BlockB
{
	f16vec4 a;
	bool b;
	int16_t c;
	lowp mat3x2 d;
	sA e[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.c), 5) && allOk;
	allOk = compare_int((blockB.e[0].mA), 4) && allOk;
	allOk = compare_mat2(blockB.e[0].mB, mat2(9.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.e[0].mC), uvec2(4u, 8u)) && allOk;
	allOk = compare_mat3x4(blockB.e[0].mD, mat3x4(4.0, -4.0, 7.0, 2.0, -1.0, 7.0, -5.0, -4.0, 3.0, -5.0, -3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec4(vec4(6.0, -1.0, 0.0, 3.0));
	blockB.b = (false);
	blockB.c = int16_t(6);
	blockB.d = (mat3x2(-7.0, 6.0, -8.0, -4.0, -6.0, 3.0));
	blockB.e[0].mA = (-2);
	blockB.e[0].mB = (mat2(5.0, -2.0, 6.0, 7.0));
	blockB.e[0].mC = u16vec2(uvec2(2u, 1u));
	blockB.e[0].mD = (mat3x4(-2.0, -2.0, 7.0, -2.0, 1.0, 3.0, -9.0, -2.0, -7.0, 9.0, -9.0, 4.0));
}
#version 450
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
	highp ivec4 b[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (4.0);
	blockB.b[0] = (ivec4(0, 9, 4, 1));
	blockB.b[1] = (ivec4(-7, -4, -4, -6));
	blockB.b[2] = (ivec4(-5, -2, 4, -2));
	blockB.b[3] = (ivec4(5, -9, -3, -1));
	blockB.b[4] = (ivec4(-9, 1, 1, 7));
	blockB.b[5] = (ivec4(8, 9, -7, -1));
	blockB.b[6] = (ivec4(-6, 5, 6, 5));
	blockB.b[7] = (ivec4(6, -6, -9, 3));
}
#version 450
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
	layout(offset = 16) mediump vec4 b;
	layout(offset = 32) f16vec4 c[1];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a), vec4(-2.0, 4.0, 8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec4(-3.0, 9.0, 8.0, 1.0));
	blockB.c[0] = f16vec4(vec4(-6.0, 0.0, -8.0, 3.0));
}
#version 450
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
	layout(offset = 8) bool b;
	layout(offset = 12) bool c;
	layout(offset = 16) lowp ivec4 d;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_bool((blockB.c), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec4(vec4(-4.0, -3.0, -2.0, 6.0));
	blockB.b = (false);
	blockB.c = (false);
	blockB.d = (ivec4(-3, -4, -4, -2));
}
#version 450
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
	layout(offset = 0) f16vec3 a;
	layout(offset = 6) int16_t b;
	layout(offset = 8) u16vec4 c;
	layout(offset = 16) uint16_t d;
	layout(offset = 18) u16vec3 e;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i16vec2 f;
	layout(offset = 4) f16vec4 g;
	layout(offset = 12) f16vec2 h;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp int i;
	layout(offset = 4) f16vec3 j;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB.a), vec3(3.0, 4.0, -3.0)) && allOk;
	allOk = compare_int16_t(int(blockB.b), 6) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.c), uvec4(7u, 0u, 8u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.e), uvec3(6u, 1u, 3u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.f), ivec2(9, -8)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.g), vec4(9.0, -9.0, 9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec3(vec3(3.0, -9.0, 1.0));
	blockB.b = int16_t(-1);
	blockB.c = u16vec4(uvec4(0u, 8u, 2u, 3u));
	blockB.d = uint16_t(2u);
	blockB.e = u16vec3(uvec3(6u, 0u, 2u));
	blockC.f = i16vec2(ivec2(-2, 3));
	blockC.h = f16vec2(vec2(1.0, -1.0));
	blockD.i = (3);
	blockD.j = f16vec3(vec3(2.0, -3.0, -8.0));
}
#version 450
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
	layout(offset = 0) f16vec3 a;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(a), vec3(8.0, 5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = f16vec3(vec3(-4.0, 4.0, -1.0));
}
#version 450
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
	mediump vec3 a[3];
	lowp mat4 b[];
};
layout(scalar, binding = 2) buffer BlockC
{
	lowp vec4 c;
	lowp mat2x3 d;
	mediump uvec3 e[];
};
layout(scalar, column_major, binding = 3) buffer BlockD
{
	bool f;
	f16vec4 g[][1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((a[0]), vec3(-5.0, 5.0, -6.0)) && allOk;
	allOk = compare_vec3((a[1]), vec3(-9.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec3((a[2]), vec3(7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4(b[0], mat4(5.0, -7.0, -5.0, -2.0, -1.0, 5.0, 2.0, -4.0, 7.0, 7.0, -1.0, 3.0, -2.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4(b[1], mat4(3.0, 9.0, -5.0, 1.0, 8.0, -8.0, 4.0, -8.0, -3.0, -1.0, 4.0, -9.0, 7.0, 1.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4(b[2], mat4(-6.0, 0.0, 6.0, 8.0, 5.0, 9.0, -3.0, 2.0, 2.0, 3.0, 3.0, -7.0, 7.0, -3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(b[3], mat4(3.0, -1.0, 0.0, -6.0, -5.0, -3.0, -5.0, 2.0, -9.0, 0.0, 5.0, -4.0, 4.0, -4.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4(b[4], mat4(-1.0, -1.0, -1.0, 9.0, -4.0, -4.0, -8.0, 9.0, -5.0, 7.0, -8.0, -2.0, -1.0, 4.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat4(b[5], mat4(-9.0, -9.0, 8.0, 9.0, -3.0, 8.0, 2.0, 7.0, -5.0, -3.0, 3.0, 4.0, -7.0, 0.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat4(b[6], mat4(2.0, 3.0, 2.0, 0.0, 9.0, 3.0, 4.0, -4.0, 6.0, -9.0, 2.0, 1.0, -3.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4(b[7], mat4(-7.0, -7.0, -4.0, 4.0, 3.0, -7.0, -6.0, 0.0, -6.0, 8.0, -9.0, 1.0, -7.0, 6.0, -9.0, 8.0)) && allOk;
	allOk = compare_uvec3((e[0]), uvec3(2u, 8u, 6u)) && allOk;
	allOk = compare_uvec3((e[1]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_uvec3((e[2]), uvec3(4u, 0u, 8u)) && allOk;
	allOk = compare_bool((f), false) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (vec3(3.0, -4.0, 2.0));
	a[1] = (vec3(2.0, 4.0, 9.0));
	a[2] = (vec3(-2.0, -4.0, -9.0));
	c = (vec4(-5.0, -2.0, -8.0, 5.0));
	f = (true);
	g[0][0] = f16vec4(vec4(-8.0, 9.0, 8.0, 0.0));
	g[1][0] = f16vec4(vec4(-7.0, 3.0, 7.0, -8.0));
	g[2][0] = f16vec4(vec4(-9.0, 1.0, 9.0, -5.0));
	g[3][0] = f16vec4(vec4(-8.0, 9.0, -6.0, 7.0));
}
#version 450
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
	lowp ivec2 mB;
	bvec2 mC;
	mediump mat3 mD[4];
};
struct sB
{
	highp uvec2 mA;
	highp uvec2 mB[7];
	uint16_t mC;
	lowp ivec2 mD;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	i16vec3 a;
	sA b;
	highp uint c;
	mediump mat2x3 d;
	highp mat2 e[];
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	bool f;
	lowp vec4 g;
	highp uvec3 h;
	mediump ivec4 i;
	highp int j[];
};
layout(scalar, row_major, binding = 3) buffer BlockD
{
	lowp ivec2 k;
	mediump mat3x4 l;
	mediump ivec3 m;
	sB n[];
};
layout(scalar, column_major, binding = 4) buffer BlockE
{
	highp uvec4 o;
	lowp mat4x2 p[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(b.mA, mat3x2(-2.0, 6.0, -1.0, 3.0, -2.0, 2.0)) && allOk;
	allOk = compare_ivec2((b.mB), ivec2(3, -6)) && allOk;
	allOk = compare_bvec2((b.mC), bvec2(false, false)) && allOk;
	allOk = compare_mat3(b.mD[0], mat3(-3.0, 8.0, 5.0, -1.0, -1.0, -8.0, 4.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat3(b.mD[1], mat3(5.0, -3.0, 7.0, -1.0, 4.0, -4.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(b.mD[2], mat3(-4.0, -2.0, 1.0, 3.0, -5.0, -8.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(b.mD[3], mat3(-1.0, 5.0, 7.0, 0.0, -4.0, 0.0, -2.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(d, mat2x3(-7.0, 6.0, -1.0, 3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(e[0], mat2(5.0, -2.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat2(e[1], mat2(-8.0, -5.0, 4.0, 8.0)) && allOk;
	allOk = compare_bool((f), false) && allOk;
	allOk = compare_uvec3((h), uvec3(7u, 9u, 9u)) && allOk;
	allOk = compare_ivec4((i), ivec4(2, 3, -4, -2)) && allOk;
	allOk = compare_int((j[0]), -4) && allOk;
	allOk = compare_int((j[1]), -5) && allOk;
	allOk = compare_mat3x4(l, mat3x4(5.0, 8.0, 1.0, 0.0, 9.0, 4.0, 5.0, 1.0, -5.0, -1.0, 6.0, -9.0)) && allOk;
	allOk = compare_ivec3((m), ivec3(6, 5, -3)) && allOk;
	allOk = compare_uvec2((n[0].mA), uvec2(8u, 2u)) && allOk;
	allOk = compare_uvec2((n[0].mB[0]), uvec2(4u, 8u)) && allOk;
	allOk = compare_uvec2((n[0].mB[1]), uvec2(3u, 8u)) && allOk;
	allOk = compare_uvec2((n[0].mB[2]), uvec2(7u, 6u)) && allOk;
	allOk = compare_uvec2((n[0].mB[3]), uvec2(1u, 9u)) && allOk;
	allOk = compare_uvec2((n[0].mB[4]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((n[0].mB[5]), uvec2(3u, 0u)) && allOk;
	allOk = compare_uvec2((n[0].mB[6]), uvec2(6u, 8u)) && allOk;
	allOk = compare_uint16_t(uint(n[0].mC), 2u) && allOk;
	allOk = compare_ivec2((n[0].mD), ivec2(-8, -5)) && allOk;
	allOk = compare_uvec2((n[1].mA), uvec2(3u, 1u)) && allOk;
	allOk = compare_uvec2((n[1].mB[0]), uvec2(5u, 6u)) && allOk;
	allOk = compare_uvec2((n[1].mB[1]), uvec2(9u, 1u)) && allOk;
	allOk = compare_uvec2((n[1].mB[2]), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec2((n[1].mB[3]), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec2((n[1].mB[4]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((n[1].mB[5]), uvec2(4u, 1u)) && allOk;
	allOk = compare_uvec2((n[1].mB[6]), uvec2(3u, 4u)) && allOk;
	allOk = compare_uint16_t(uint(n[1].mC), 9u) && allOk;
	allOk = compare_ivec2((n[1].mD), ivec2(7, -2)) && allOk;
	allOk = compare_uvec2((n[2].mA), uvec2(8u, 2u)) && allOk;
	allOk = compare_uvec2((n[2].mB[0]), uvec2(8u, 1u)) && allOk;
	allOk = compare_uvec2((n[2].mB[1]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((n[2].mB[2]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((n[2].mB[3]), uvec2(5u, 6u)) && allOk;
	allOk = compare_uvec2((n[2].mB[4]), uvec2(9u, 3u)) && allOk;
	allOk = compare_uvec2((n[2].mB[5]), uvec2(6u, 5u)) && allOk;
	allOk = compare_uvec2((n[2].mB[6]), uvec2(9u, 3u)) && allOk;
	allOk = compare_uint16_t(uint(n[2].mC), 6u) && allOk;
	allOk = compare_ivec2((n[2].mD), ivec2(-7, 9)) && allOk;
	allOk = compare_uvec2((n[3].mA), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((n[3].mB[0]), uvec2(3u, 8u)) && allOk;
	allOk = compare_uvec2((n[3].mB[1]), uvec2(2u, 5u)) && allOk;
	allOk = compare_uvec2((n[3].mB[2]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((n[3].mB[3]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((n[3].mB[4]), uvec2(5u, 0u)) && allOk;
	allOk = compare_uvec2((n[3].mB[5]), uvec2(6u, 3u)) && allOk;
	allOk = compare_uvec2((n[3].mB[6]), uvec2(0u, 5u)) && allOk;
	allOk = compare_uint16_t(uint(n[3].mC), 9u) && allOk;
	allOk = compare_ivec2((n[3].mD), ivec2(-1, 0)) && allOk;
	allOk = compare_uvec2((n[4].mA), uvec2(8u, 9u)) && allOk;
	allOk = compare_uvec2((n[4].mB[0]), uvec2(4u, 2u)) && allOk;
	allOk = compare_uvec2((n[4].mB[1]), uvec2(6u, 1u)) && allOk;
	allOk = compare_uvec2((n[4].mB[2]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((n[4].mB[3]), uvec2(7u, 0u)) && allOk;
	allOk = compare_uvec2((n[4].mB[4]), uvec2(5u, 9u)) && allOk;
	allOk = compare_uvec2((n[4].mB[5]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((n[4].mB[6]), uvec2(6u, 5u)) && allOk;
	allOk = compare_uint16_t(uint(n[4].mC), 2u) && allOk;
	allOk = compare_ivec2((n[4].mD), ivec2(5, -5)) && allOk;
	allOk = compare_uvec2((n[5].mA), uvec2(7u, 9u)) && allOk;
	allOk = compare_uvec2((n[5].mB[0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_uvec2((n[5].mB[1]), uvec2(2u, 8u)) && allOk;
	allOk = compare_uvec2((n[5].mB[2]), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec2((n[5].mB[3]), uvec2(6u, 4u)) && allOk;
	allOk = compare_uvec2((n[5].mB[4]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((n[5].mB[5]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((n[5].mB[6]), uvec2(3u, 7u)) && allOk;
	allOk = compare_uint16_t(uint(n[5].mC), 6u) && allOk;
	allOk = compare_ivec2((n[5].mD), ivec2(-8, 6)) && allOk;
	allOk = compare_uvec4((blockE.o), uvec4(4u, 1u, 0u, 3u)) && allOk;
	allOk = compare_mat4x2(blockE.p[0], mat4x2(2.0, 0.0, -3.0, 5.0, 4.0, 6.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockE.p[1], mat4x2(9.0, -2.0, -5.0, 7.0, -6.0, 7.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockE.p[2], mat4x2(6.0, 7.0, 2.0, 8.0, -8.0, -9.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockE.p[3], mat4x2(4.0, 9.0, 7.0, 7.0, 1.0, 4.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockE.p[4], mat4x2(-1.0, 2.0, -9.0, 9.0, -6.0, -3.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockE.p[5], mat4x2(-1.0, 3.0, -8.0, 1.0, 6.0, 1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockE.p[6], mat4x2(-5.0, 7.0, -4.0, -8.0, 6.0, 2.0, 1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b.mA = (mat3x2(1.0, -7.0, -7.0, 9.0, -3.0, -9.0));
	b.mB = (ivec2(8, 0));
	b.mC = (bvec2(false, true));
	b.mD[0] = (mat3(4.0, 5.0, -5.0, -2.0, -6.0, 0.0, -5.0, 3.0, -9.0));
	b.mD[1] = (mat3(3.0, 6.0, -1.0, -9.0, 2.0, -6.0, -1.0, 7.0, 3.0));
	b.mD[2] = (mat3(1.0, 8.0, -9.0, -4.0, -7.0, 3.0, -9.0, 3.0, 5.0));
	b.mD[3] = (mat3(-9.0, -2.0, 4.0, 9.0, -2.0, 9.0, -5.0, -6.0, -2.0));
	e[0] = (mat2(-4.0, 6.0, 7.0, 5.0));
	e[1] = (mat2(0.0, 8.0, -8.0, 5.0));
	g = (vec4(6.0, 1.0, 5.0, -8.0));
	h = (uvec3(9u, 8u, 4u));
	j[0] = (0);
	j[1] = (2);
	k = (ivec2(4, 3));
	l = (mat3x4(-1.0, 8.0, -9.0, 6.0, -4.0, 6.0, -7.0, -7.0, 4.0, -5.0, 2.0, 8.0));
	m = (ivec3(2, 5, 5));
	n[0].mA = (uvec2(9u, 4u));
	n[0].mB[0] = (uvec2(7u, 6u));
	n[0].mB[1] = (uvec2(9u, 5u));
	n[0].mB[2] = (uvec2(2u, 9u));
	n[0].mB[3] = (uvec2(6u, 0u));
	n[0].mB[4] = (uvec2(1u, 3u));
	n[0].mB[5] = (uvec2(6u, 8u));
	n[0].mB[6] = (uvec2(5u, 1u));
	n[0].mC = uint16_t(5u);
	n[0].mD = (ivec2(-2, -4));
	n[1].mA = (uvec2(7u, 9u));
	n[1].mB[0] = (uvec2(3u, 8u));
	n[1].mB[1] = (uvec2(6u, 5u));
	n[1].mB[2] = (uvec2(6u, 1u));
	n[1].mB[3] = (uvec2(4u, 8u));
	n[1].mB[4] = (uvec2(2u, 4u));
	n[1].mB[5] = (uvec2(3u, 5u));
	n[1].mB[6] = (uvec2(0u, 1u));
	n[1].mC = uint16_t(9u);
	n[1].mD = (ivec2(-9, -1));
	n[2].mA = (uvec2(2u, 8u));
	n[2].mB[0] = (uvec2(9u, 9u));
	n[2].mB[1] = (uvec2(4u, 0u));
	n[2].mB[2] = (uvec2(8u, 1u));
	n[2].mB[3] = (uvec2(9u, 5u));
	n[2].mB[4] = (uvec2(7u, 8u));
	n[2].mB[5] = (uvec2(8u, 8u));
	n[2].mB[6] = (uvec2(2u, 4u));
	n[2].mC = uint16_t(1u);
	n[2].mD = (ivec2(-9, -2));
	n[3].mA = (uvec2(9u, 0u));
	n[3].mB[0] = (uvec2(1u, 2u));
	n[3].mB[1] = (uvec2(9u, 8u));
	n[3].mB[2] = (uvec2(3u, 2u));
	n[3].mB[3] = (uvec2(3u, 8u));
	n[3].mB[4] = (uvec2(0u, 5u));
	n[3].mB[5] = (uvec2(1u, 5u));
	n[3].mB[6] = (uvec2(2u, 6u));
	n[3].mC = uint16_t(8u);
	n[3].mD = (ivec2(5, 9));
	n[4].mA = (uvec2(0u, 3u));
	n[4].mB[0] = (uvec2(6u, 7u));
	n[4].mB[1] = (uvec2(7u, 7u));
	n[4].mB[2] = (uvec2(4u, 0u));
	n[4].mB[3] = (uvec2(8u, 1u));
	n[4].mB[4] = (uvec2(2u, 9u));
	n[4].mB[5] = (uvec2(8u, 5u));
	n[4].mB[6] = (uvec2(3u, 6u));
	n[4].mC = uint16_t(4u);
	n[4].mD = (ivec2(8, -2));
	n[5].mA = (uvec2(5u, 6u));
	n[5].mB[0] = (uvec2(6u, 4u));
	n[5].mB[1] = (uvec2(2u, 7u));
	n[5].mB[2] = (uvec2(9u, 8u));
	n[5].mB[3] = (uvec2(4u, 1u));
	n[5].mB[4] = (uvec2(7u, 6u));
	n[5].mB[5] = (uvec2(1u, 8u));
	n[5].mB[6] = (uvec2(4u, 6u));
	n[5].mC = uint16_t(6u);
	n[5].mD = (ivec2(-8, 8));
	blockE.o = (uvec4(4u, 7u, 3u, 1u));
	blockE.p[0] = (mat4x2(-9.0, -5.0, -1.0, -7.0, 7.0, 4.0, -9.0, 5.0));
	blockE.p[1] = (mat4x2(9.0, -5.0, 6.0, 4.0, -7.0, 5.0, -6.0, 2.0));
	blockE.p[2] = (mat4x2(-2.0, -5.0, 0.0, -3.0, 1.0, 7.0, 4.0, -9.0));
	blockE.p[3] = (mat4x2(3.0, 2.0, 5.0, -3.0, 9.0, -9.0, -4.0, -6.0));
	blockE.p[4] = (mat4x2(-4.0, -3.0, 1.0, 6.0, 8.0, 9.0, 0.0, -5.0));
	blockE.p[5] = (mat4x2(-8.0, 0.0, 4.0, 8.0, -5.0, -5.0, -7.0, -5.0));
	blockE.p[6] = (mat4x2(7.0, 0.0, -3.0, 1.0, -2.0, 3.0, -1.0, 1.0));
}
#version 450
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
	i16vec4 mB;
};
struct sB
{
	lowp mat3x4 mA;
	mediump mat4x3 mB;
	f16vec3 mC;
	f16vec2 mD;
};
layout(scalar, binding = 1) buffer BlockB
{
	sA a;
	i16vec4 b;
	lowp uvec4 c;
	i16vec2 d;
	sB e[];
} blockB[2];
layout(scalar, row_major, binding = 2) buffer BlockC
{
	f16vec2 f[];
};
layout(scalar, row_major, binding = 3) buffer BlockD
{
	mediump uvec3 g[1];
	i16vec3 h[5];
	i16vec3 i;
	lowp mat3 j;
};
layout(scalar, row_major, binding = 4) readonly buffer BlockE
{
	i16vec2 k[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB[0].a.mA), vec3(-3.0, -9.0, -9.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].a.mB), ivec4(-6, 3, 4, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].b), ivec4(6, -2, 9, 1)) && allOk;
	allOk = compare_vec3((blockB[1].a.mA), vec3(-6.0, -9.0, 3.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].a.mB), ivec4(-9, -2, -5, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].b), ivec4(-5, 7, -2, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(h[0]), ivec3(5, -8, -6)) && allOk;
	allOk = compare_i16vec3(ivec3(h[1]), ivec3(-6, -8, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(h[2]), ivec3(0, 8, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(h[3]), ivec3(-3, -2, -5)) && allOk;
	allOk = compare_i16vec3(ivec3(h[4]), ivec3(-2, 6, 5)) && allOk;
	allOk = compare_mat3(j, mat3(9.0, 3.0, -5.0, -3.0, 7.0, -7.0, 1.0, 2.0, 2.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockE.k[0]), ivec2(3, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (vec3(-3.0, -9.0, 9.0));
	blockB[0].a.mB = i16vec4(ivec4(-6, 8, 7, -8));
	blockB[0].b = i16vec4(ivec4(2, -8, -7, 8));
	blockB[0].c = (uvec4(3u, 1u, 3u, 9u));
	blockB[1].a.mA = (vec3(7.0, -4.0, -9.0));
	blockB[1].a.mB = i16vec4(ivec4(5, 6, 2, -1));
	blockB[1].b = i16vec4(ivec4(4, 9, 7, -8));
	blockB[1].c = (uvec4(2u, 7u, 0u, 7u));
	f[0] = f16vec2(vec2(-2.0, 8.0));
	f[1] = f16vec2(vec2(2.0, -5.0));
	f[2] = f16vec2(vec2(7.0, 6.0));
	f[3] = f16vec2(vec2(1.0, 5.0));
	h[0] = i16vec3(ivec3(7, 2, -6));
	h[1] = i16vec3(ivec3(2, -7, -2));
	h[2] = i16vec3(ivec3(-6, 8, -5));
	h[3] = i16vec3(ivec3(-2, 0, 1));
	h[4] = i16vec3(ivec3(-7, -2, -8));
	i = i16vec3(ivec3(-8, 9, -4));
	j = (mat3(-4.0, -3.0, -8.0, 3.0, -8.0, 3.0, -4.0, 0.0, -8.0));
}
#version 450
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
	f16vec4 a;
} blockB[];

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

layout(std430, row_major, binding = 1) buffer BlockB
{
	mediump uvec4 a[6];
	bvec2 b;
	bvec2 c;
	bool d[];
} blockB;
layout(std430, row_major, binding = 2) readonly buffer BlockC
{
	u8vec4 e;
	lowp uvec2 f[];
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	uint8_t g;
	highp mat3x4 h;
	u8vec2 i[];
};
layout(std140, column_major, binding = 4) buffer BlockE
{
	highp uint j;
	mediump mat3x2 k;
	highp mat4x2 l;
	i8vec4 m;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockC.f[0]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((blockC.f[1]), uvec2(9u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.f[2]), uvec2(6u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.f[3]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uint8_t(uint(g), 8u) && allOk;
	allOk = compare_mat3x4(h, mat3x4(-4.0, 8.0, -9.0, -4.0, 0.0, -5.0, -9.0, 5.0, 0.0, -1.0, -1.0, 1.0)) && allOk;
	allOk = compare_u8vec2(uvec2(i[0]), uvec2(3u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(i[1]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(i[2]), uvec2(7u, 8u)) && allOk;
	allOk = compare_uint((blockE.j), 3u) && allOk;
	allOk = compare_mat3x2(blockE.k, mat3x2(9.0, 1.0, 5.0, 9.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockE.l, mat4x2(-3.0, -9.0, 5.0, 4.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockE.m), ivec4(4294967288, 1, 7, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec4(9u, 2u, 5u, 7u));
	blockB.a[1] = (uvec4(0u, 7u, 4u, 1u));
	blockB.a[2] = (uvec4(7u, 5u, 0u, 0u));
	blockB.a[3] = (uvec4(6u, 2u, 6u, 3u));
	blockB.a[4] = (uvec4(7u, 5u, 0u, 9u));
	blockB.a[5] = (uvec4(5u, 7u, 8u, 3u));
	h = (mat3x4(9.0, 9.0, 4.0, 8.0, 3.0, -1.0, 9.0, 0.0, -2.0, 8.0, -5.0, 3.0));
	i[0] = u8vec2(uvec2(6u, 6u));
	i[1] = u8vec2(uvec2(2u, 3u));
	i[2] = u8vec2(uvec2(8u, 3u));
	blockE.j = (5u);
	blockE.l = (mat4x2(8.0, 1.0, -3.0, -2.0, -8.0, 1.0, -4.0, -7.0));
	blockE.m = i8vec4(ivec4(7, 9, 9, 4294967295));
}
#version 450
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
	highp mat2x3 a;
	highp mat3 b;
	bvec4 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(a, mat2x3(-7.0, 8.0, 4.0, 8.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3(b, mat3(-2.0, 5.0, -2.0, 6.0, -9.0, -9.0, -1.0, 9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat3(4.0, 8.0, -3.0, 6.0, -3.0, -1.0, -8.0, 3.0, 6.0));
	c = (bvec4(true, false, false, false));
}
#version 450
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
	lowp mat4x2 a;
	mediump uvec2 b;
	lowp mat4 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(c[0], mat4(3.0, -3.0, 2.0, -3.0, 8.0, 8.0, -3.0, 8.0, 5.0, -7.0, -3.0, -9.0, 5.0, -9.0, 7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4x2(-7.0, 4.0, -4.0, -7.0, -3.0, -9.0, 1.0, 2.0));
	c[0] = (mat4(5.0, -7.0, -5.0, -9.0, -9.0, -7.0, 3.0, 1.0, 2.0, -4.0, -6.0, 7.0, 1.0, 9.0, 1.0, 3.0));
}
#version 450
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
	bool b[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(a, mat3x2(-5.0, -9.0, 5.0, 9.0, -6.0, -5.0)) && allOk;
	allOk = compare_bool((b[0]), true) && allOk;
	allOk = compare_bool((b[1]), true) && allOk;
	allOk = compare_bool((b[2]), false) && allOk;
	allOk = compare_bool((b[3]), true) && allOk;
	allOk = compare_bool((b[4]), true) && allOk;
	allOk = compare_bool((b[5]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x2(3.0, 2.0, -4.0, 4.0, 2.0, 9.0));
	b[0] = (false);
	b[1] = (false);
	b[2] = (true);
	b[3] = (false);
	b[4] = (false);
	b[5] = (true);
}
#version 450
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
	highp mat3 mA;
	mediump ivec2 mB;
	mediump uint mC;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	sA a;
	sB b;
	u8vec2 c;
	highp mat4 d;
	mediump vec4 e[];
} blockB[1];
layout(std430, binding = 2) buffer BlockC
{
	lowp uint f;
	highp uvec2 g[2];
	lowp mat2 h;
	i8vec2 i;
	lowp vec3 j[];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB[0].c), uvec2(7u, 1u)) && allOk;
	allOk = compare_mat4(blockB[0].d, mat4(6.0, -8.0, 7.0, -1.0, 2.0, 2.0, 6.0, 1.0, 1.0, 1.0, 6.0, -8.0, -9.0, 0.0, -1.0, -1.0)) && allOk;
	allOk = compare_vec4((blockB[0].e[0]), vec4(5.0, 4.0, 0.0, -1.0)) && allOk;
	allOk = compare_vec4((blockB[0].e[1]), vec4(-2.0, -9.0, 1.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB[0].e[2]), vec4(8.0, 0.0, 5.0, -7.0)) && allOk;
	allOk = compare_vec4((blockB[0].e[3]), vec4(6.0, 6.0, 7.0, -7.0)) && allOk;
	allOk = compare_vec4((blockB[0].e[4]), vec4(6.0, -8.0, 5.0, 1.0)) && allOk;
	allOk = compare_vec4((blockB[0].e[5]), vec4(-4.0, 0.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2(blockC[0].h, mat2(-9.0, -9.0, -1.0, -4.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].i), ivec2(5, 1)) && allOk;
	allOk = compare_vec3((blockC[0].j[0]), vec3(-9.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec3((blockC[0].j[1]), vec3(-6.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (9);
	blockB[0].c = u8vec2(uvec2(2u, 6u));
	blockB[0].d = (mat4(4.0, 0.0, 7.0, 5.0, -3.0, 1.0, 0.0, -8.0, -8.0, 5.0, 2.0, 6.0, 6.0, -9.0, 7.0, 6.0));
	blockB[0].e[0] = (vec4(3.0, 9.0, -8.0, 1.0));
	blockB[0].e[1] = (vec4(4.0, -5.0, 0.0, -7.0));
	blockB[0].e[2] = (vec4(-1.0, 7.0, 9.0, 5.0));
	blockB[0].e[3] = (vec4(-4.0, -6.0, 0.0, -8.0));
	blockB[0].e[4] = (vec4(-2.0, 5.0, -8.0, 0.0));
	blockB[0].e[5] = (vec4(-6.0, 9.0, 3.0, -2.0));
	blockC[0].g[0] = (uvec2(3u, 2u));
	blockC[0].g[1] = (uvec2(3u, 3u));
	blockC[0].h = (mat2(-5.0, 8.0, 0.0, 3.0));
	blockC[0].i = i8vec2(ivec2(8, 9));
}
#version 450
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
	layout(offset = 8) int8_t b;
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i8vec2 c;
	layout(offset = 4) lowp float d;
	layout(offset = 16) mediump ivec4 e;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) i8vec2 f;
	layout(offset = 4) mediump uvec3 g;
	layout(offset = 16) u8vec2 h;
	layout(offset = 18) int8_t i;
	layout(offset = 19) i8vec2 j;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) highp int k;
	layout(offset = 4) uint8_t l;
	layout(offset = 5) i8vec4 m;
	layout(offset = 12) lowp int n;
	layout(offset = 16) mediump uvec3 o;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[0].a), bvec2(true, false)) && allOk;
	allOk = compare_float((d), -1.0) && allOk;
	allOk = compare_ivec4((e), ivec4(-2, 2, -9, -1)) && allOk;
	allOk = compare_i8vec2(ivec2(f), ivec2(4294967292, 4294967288)) && allOk;
	allOk = compare_u8vec2(uvec2(h), uvec2(3u, 1u)) && allOk;
	allOk = compare_int((blockE.k), -9) && allOk;
	allOk = compare_i8vec4(ivec4(blockE.m), ivec4(1, 9, 8, 1)) && allOk;
	allOk = compare_int((blockE.n), 6) && allOk;
	allOk = compare_uvec3((blockE.o), uvec3(2u, 5u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec2(true, true));
	blockB[0].b = int8_t(4294967287);
	c = i8vec2(ivec2(8, 2));
	f = i8vec2(ivec2(6, 4294967287));
	g = (uvec3(0u, 1u, 1u));
	h = u8vec2(uvec2(6u, 1u));
	i = int8_t(4294967293);
	j = i8vec2(ivec2(4294967291, 4294967287));
	blockE.l = uint8_t(4u);
	blockE.m = i8vec4(ivec4(4, 4294967294, 4294967294, 3));
	blockE.o = (uvec3(6u, 6u, 4u));
}
#version 450
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
	layout(offset = 4) lowp ivec3 b;
	layout(offset = 16) i8vec2 c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) uint8_t d;
	layout(offset = 1) u8vec4 e;
} blockC[2];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec2 f;
	layout(offset = 8) highp uint g;
} blockD[1];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) u8vec4 h;
	layout(offset = 4) bvec2 i;
	layout(offset = 16) highp ivec2 j;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_ivec3((blockB.b), ivec3(3, 4, -9)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c), ivec2(4294967291, 5)) && allOk;
	allOk = compare_uint8_t(uint(blockC[0].d), 0u) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].e), uvec4(1u, 1u, 1u, 1u)) && allOk;
	allOk = compare_uint8_t(uint(blockC[1].d), 5u) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[1].e), uvec4(0u, 2u, 7u, 2u)) && allOk;
	allOk = compare_bvec2((i), bvec2(false, true)) && allOk;
	allOk = compare_ivec2((j), ivec2(8, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockC[0].e = u8vec4(uvec4(0u, 8u, 5u, 4u));
	blockC[1].e = u8vec4(uvec4(9u, 8u, 0u, 1u));
	blockD[0].f = (bvec2(false, true));
	blockD[0].g = (5u);
	h = u8vec4(uvec4(9u, 8u, 6u, 3u));
	j = (ivec2(-5, 4));
}
#version 450
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
	highp mat3 mA[3];
};
struct sB
{
	u8vec4 mA;
	bool mB;
	highp ivec2 mC[7];
};
struct sC
{
	lowp mat4 mA;
	lowp vec2 mB;
	highp mat4x3 mC;
	sB mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	highp mat4 a;
	sA b;
	sC c[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(-2.0, 4.0, 8.0, -9.0, 4.0, 7.0, 2.0, -2.0, 2.0, -5.0, 0.0, -2.0, -7.0, -5.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3(blockB.b.mA[0], mat3(1.0, 0.0, 3.0, 5.0, -5.0, 0.0, 0.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3(blockB.b.mA[1], mat3(4.0, 3.0, 8.0, -8.0, -5.0, 3.0, -2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3(blockB.b.mA[2], mat3(-3.0, 6.0, 8.0, 6.0, -4.0, 8.0, 6.0, 5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b.mA[0] = (mat3(8.0, 3.0, 4.0, 9.0, -6.0, -6.0, 1.0, 9.0, -6.0));
	blockB.b.mA[1] = (mat3(-6.0, 7.0, 2.0, -1.0, -6.0, -2.0, 6.0, -9.0, -9.0));
	blockB.b.mA[2] = (mat3(-1.0, 8.0, -9.0, 9.0, -9.0, 4.0, 0.0, 1.0, -2.0));
	blockB.c[0].mA = (mat4(6.0, -4.0, -3.0, -9.0, 5.0, 7.0, -4.0, 0.0, -5.0, 6.0, -7.0, -7.0, -7.0, -1.0, -6.0, 9.0));
	blockB.c[0].mB = (vec2(5.0, 9.0));
	blockB.c[0].mC = (mat4x3(5.0, -8.0, 7.0, 6.0, -2.0, -5.0, -9.0, 0.0, 6.0, 5.0, 3.0, -9.0));
	blockB.c[0].mD.mA = u8vec4(uvec4(2u, 2u, 4u, 2u));
	blockB.c[0].mD.mB = (false);
	blockB.c[0].mD.mC[0] = (ivec2(1, -2));
	blockB.c[0].mD.mC[1] = (ivec2(1, 6));
	blockB.c[0].mD.mC[2] = (ivec2(4, 4));
	blockB.c[0].mD.mC[3] = (ivec2(-3, 6));
	blockB.c[0].mD.mC[4] = (ivec2(-2, 2));
	blockB.c[0].mD.mC[5] = (ivec2(-2, 6));
	blockB.c[0].mD.mC[6] = (ivec2(-1, -7));
	blockB.c[1].mA = (mat4(8.0, -3.0, -9.0, -3.0, -2.0, -1.0, 3.0, 7.0, -1.0, -3.0, -5.0, 7.0, -4.0, 6.0, -6.0, -8.0));
	blockB.c[1].mB = (vec2(9.0, 5.0));
	blockB.c[1].mC = (mat4x3(-3.0, -4.0, 7.0, -5.0, 2.0, 4.0, 0.0, -5.0, 7.0, -9.0, 9.0, 1.0));
	blockB.c[1].mD.mA = u8vec4(uvec4(5u, 7u, 7u, 6u));
	blockB.c[1].mD.mB = (false);
	blockB.c[1].mD.mC[0] = (ivec2(-5, 9));
	blockB.c[1].mD.mC[1] = (ivec2(2, 5));
	blockB.c[1].mD.mC[2] = (ivec2(4, 8));
	blockB.c[1].mD.mC[3] = (ivec2(-7, 9));
	blockB.c[1].mD.mC[4] = (ivec2(-2, -8));
	blockB.c[1].mD.mC[5] = (ivec2(4, -3));
	blockB.c[1].mD.mC[6] = (ivec2(9, 0));
	blockB.c[2].mA = (mat4(6.0, -4.0, 8.0, 4.0, -8.0, 8.0, -3.0, -3.0, 0.0, -9.0, -3.0, 0.0, 0.0, 7.0, -5.0, 3.0));
	blockB.c[2].mB = (vec2(6.0, -3.0));
	blockB.c[2].mC = (mat4x3(2.0, -7.0, -6.0, 4.0, -3.0, 8.0, 6.0, -7.0, 4.0, 5.0, -4.0, -2.0));
	blockB.c[2].mD.mA = u8vec4(uvec4(1u, 6u, 0u, 2u));
	blockB.c[2].mD.mB = (true);
	blockB.c[2].mD.mC[0] = (ivec2(8, 9));
	blockB.c[2].mD.mC[1] = (ivec2(-9, -7));
	blockB.c[2].mD.mC[2] = (ivec2(9, -5));
	blockB.c[2].mD.mC[3] = (ivec2(9, 6));
	blockB.c[2].mD.mC[4] = (ivec2(-3, 5));
	blockB.c[2].mD.mC[5] = (ivec2(-9, 3));
	blockB.c[2].mD.mC[6] = (ivec2(-4, 9));
	blockB.c[3].mA = (mat4(-1.0, 2.0, 2.0, 9.0, 7.0, -9.0, 9.0, -8.0, 8.0, -7.0, -8.0, -5.0, -2.0, 6.0, -8.0, 8.0));
	blockB.c[3].mB = (vec2(4.0, -8.0));
	blockB.c[3].mC = (mat4x3(7.0, -3.0, 7.0, -4.0, 6.0, 5.0, -7.0, -5.0, 6.0, -2.0, -7.0, -6.0));
	blockB.c[3].mD.mA = u8vec4(uvec4(1u, 8u, 8u, 4u));
	blockB.c[3].mD.mB = (true);
	blockB.c[3].mD.mC[0] = (ivec2(7, -9));
	blockB.c[3].mD.mC[1] = (ivec2(-8, -8));
	blockB.c[3].mD.mC[2] = (ivec2(-6, 9));
	blockB.c[3].mD.mC[3] = (ivec2(8, 5));
	blockB.c[3].mD.mC[4] = (ivec2(-3, 5));
	blockB.c[3].mD.mC[5] = (ivec2(4, -5));
	blockB.c[3].mD.mC[6] = (ivec2(-5, 3));
	blockB.c[4].mA = (mat4(-1.0, 2.0, 8.0, -3.0, 4.0, 8.0, -5.0, 2.0, 0.0, -4.0, 3.0, -9.0, 4.0, -9.0, 8.0, 0.0));
	blockB.c[4].mB = (vec2(0.0, -3.0));
	blockB.c[4].mC = (mat4x3(4.0, 6.0, -7.0, -2.0, -9.0, -4.0, -6.0, -9.0, 5.0, 0.0, 1.0, 7.0));
	blockB.c[4].mD.mA = u8vec4(uvec4(5u, 7u, 5u, 3u));
	blockB.c[4].mD.mB = (true);
	blockB.c[4].mD.mC[0] = (ivec2(3, -9));
	blockB.c[4].mD.mC[1] = (ivec2(-2, -9));
	blockB.c[4].mD.mC[2] = (ivec2(3, 5));
	blockB.c[4].mD.mC[3] = (ivec2(3, -4));
	blockB.c[4].mD.mC[4] = (ivec2(5, -1));
	blockB.c[4].mD.mC[5] = (ivec2(4, 7));
	blockB.c[4].mD.mC[6] = (ivec2(-3, -8));
	blockB.c[5].mA = (mat4(-4.0, 0.0, -7.0, 7.0, -4.0, 0.0, 8.0, -1.0, -1.0, 3.0, -7.0, -2.0, 6.0, 3.0, -9.0, -5.0));
	blockB.c[5].mB = (vec2(-3.0, -2.0));
	blockB.c[5].mC = (mat4x3(9.0, 8.0, -3.0, -6.0, -9.0, 5.0, -2.0, 9.0, 5.0, 5.0, 4.0, 9.0));
	blockB.c[5].mD.mA = u8vec4(uvec4(4u, 6u, 3u, 2u));
	blockB.c[5].mD.mB = (false);
	blockB.c[5].mD.mC[0] = (ivec2(8, 6));
	blockB.c[5].mD.mC[1] = (ivec2(-9, -9));
	blockB.c[5].mD.mC[2] = (ivec2(5, 4));
	blockB.c[5].mD.mC[3] = (ivec2(-7, -9));
	blockB.c[5].mD.mC[4] = (ivec2(9, -5));
	blockB.c[5].mD.mC[5] = (ivec2(1, 8));
	blockB.c[5].mD.mC[6] = (ivec2(-5, 2));
	blockB.c[6].mA = (mat4(-4.0, 8.0, -5.0, 0.0, 1.0, 8.0, 1.0, 9.0, 5.0, 4.0, 9.0, -7.0, 9.0, -9.0, 2.0, 4.0));
	blockB.c[6].mB = (vec2(9.0, 8.0));
	blockB.c[6].mC = (mat4x3(8.0, -7.0, -7.0, -6.0, -6.0, -3.0, 9.0, 8.0, -6.0, 9.0, 7.0, 2.0));
	blockB.c[6].mD.mA = u8vec4(uvec4(4u, 7u, 3u, 8u));
	blockB.c[6].mD.mB = (false);
	blockB.c[6].mD.mC[0] = (ivec2(0, 4));
	blockB.c[6].mD.mC[1] = (ivec2(7, 3));
	blockB.c[6].mD.mC[2] = (ivec2(4, -9));
	blockB.c[6].mD.mC[3] = (ivec2(7, 0));
	blockB.c[6].mD.mC[4] = (ivec2(4, 7));
	blockB.c[6].mD.mC[5] = (ivec2(9, -6));
	blockB.c[6].mD.mC[6] = (ivec2(3, 1));
}
#version 450
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
	lowp uvec4 a;
	lowp uvec2 b;
	bvec2 c;
	u8vec2 d[];
} blockB[3];
layout(scalar, binding = 2) buffer BlockC
{
	highp mat2x3 e;
	lowp vec4 f;
	highp vec2 g;
	highp mat3x4 h;
	highp mat3x2 i;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[0].c), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB[1].c), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB[2].c), bvec2(true, true)) && allOk;
	allOk = compare_mat2x3(blockC.e, mat2x3(-5.0, 9.0, -1.0, -5.0, 4.0, -3.0)) && allOk;
	allOk = compare_vec2((blockC.g), vec2(-3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockC.h, mat3x4(3.0, -1.0, -8.0, 5.0, -7.0, 9.0, -4.0, -9.0, -4.0, -8.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (uvec4(1u, 0u, 1u, 3u));
	blockB[0].c = (bvec2(false, false));
	blockB[0].d[0] = u8vec2(uvec2(4u, 3u));
	blockB[0].d[1] = u8vec2(uvec2(2u, 8u));
	blockB[0].d[2] = u8vec2(uvec2(0u, 6u));
	blockB[0].d[3] = u8vec2(uvec2(9u, 2u));
	blockB[0].d[4] = u8vec2(uvec2(1u, 4u));
	blockB[1].a = (uvec4(5u, 5u, 1u, 4u));
	blockB[1].c = (bvec2(false, false));
	blockB[1].d[0] = u8vec2(uvec2(5u, 6u));
	blockB[1].d[1] = u8vec2(uvec2(2u, 4u));
	blockB[2].a = (uvec4(7u, 4u, 8u, 7u));
	blockB[2].c = (bvec2(false, true));
	blockB[2].d[0] = u8vec2(uvec2(9u, 8u));
	blockB[2].d[1] = u8vec2(uvec2(0u, 7u));
	blockB[2].d[2] = u8vec2(uvec2(7u, 6u));
	blockB[2].d[3] = u8vec2(uvec2(7u, 2u));
	blockB[2].d[4] = u8vec2(uvec2(0u, 6u));
	blockB[2].d[5] = u8vec2(uvec2(1u, 1u));
	blockB[2].d[6] = u8vec2(uvec2(5u, 8u));
	blockC.f = (vec4(6.0, -1.0, -4.0, -3.0));
	blockC.h = (mat3x4(7.0, 9.0, -2.0, -5.0, 7.0, 0.0, -6.0, 7.0, 9.0, -3.0, -9.0, 9.0));
	blockC.i = (mat3x2(-8.0, 3.0, -7.0, -9.0, 1.0, 5.0));
}
#version 450
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

layout(std140, row_major, binding = 1) readonly buffer Block
{
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(-6.0, 3.0, 2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat2x4(var, mat2x4(3.0, 7.0, 8.0, -7.0, -8.0, -2.0, -1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x2(var, mat3x2(-6.0, 6.0, -6.0, 8.0, -5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(8.0, 6.0, -1.0, -6.0, 1.0, -4.0, -9.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(9.0, 4.0, 5.0, 6.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(1.0, 9.0, 9.0, 9.0, -4.0, 5.0, -6.0, 5.0, 4.0, -3.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], -9.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[1][2], -3.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], 8.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[3][0], -8.0) && allOk;
	allOk = compare_float(var[3][1], -1.0) && allOk;
	allOk = compare_float(var[3][2], 6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-9.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-8.0, -5.0, -3.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(2.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-8.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	f16vec2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(var), vec2(-6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat4(var, mat4(1.0, 3.0, -2.0, 5.0, -5.0, -6.0, 2.0, -1.0, 0.0, -3.0, 9.0, -3.0, -6.0, -5.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[0][2], 3.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], 7.0) && allOk;
	allOk = compare_float(var[3][0], 2.0) && allOk;
	allOk = compare_float(var[3][1], -6.0) && allOk;
	allOk = compare_float(var[3][2], 1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-6.0, -1.0, 3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(4.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-6.0, -2.0, 7.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(2.0, -6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, column_major, binding = 1) readonly buffer Block
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

layout(std430, column_major, binding = 1) readonly buffer Block
{
	highp mat2x3 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	u16vec2 var[3];
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(var[0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2]), uvec2(6u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	int16_t var[3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(var[0]), -5) && allOk;
	allOk = compare_int16_t(int(var[1]), 1) && allOk;
	allOk = compare_int16_t(int(var[2]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	int16_t var[];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(var[0]), -5) && allOk;
	allOk = compare_int16_t(int(var[1]), 1) && allOk;
	allOk = compare_int16_t(int(var[2]), 8) && allOk;
	allOk = compare_int16_t(int(var[3]), -2) && allOk;
	allOk = compare_int16_t(int(var[4]), 9) && allOk;
	allOk = compare_int16_t(int(var[5]), -5) && allOk;
	allOk = compare_int16_t(int(var[6]), -8) && allOk;
	allOk = compare_int16_t(int(var[7]), 6) && allOk;
	allOk = compare_int16_t(int(var[8]), 3) && allOk;
	allOk = compare_int16_t(int(var[9]), -8) && allOk;
	allOk = compare_int16_t(int(var[10]), 6) && allOk;
	allOk = compare_int16_t(int(var[11]), -7) && allOk;
	allOk = compare_int16_t(int(var[12]), 9) && allOk;
	allOk = compare_int16_t(int(var[13]), 5) && allOk;
	allOk = compare_int16_t(int(var[14]), 9) && allOk;
	allOk = compare_int16_t(int(var[15]), -3) && allOk;
	allOk = compare_int16_t(int(var[16]), -1) && allOk;
	allOk = compare_int16_t(int(var[17]), -2) && allOk;
	allOk = compare_int16_t(int(var[18]), 1) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, column_major, binding = 1) readonly buffer Block
{
	highp mat2x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(-5.0, -8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(1.0, 4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(4.0, 4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-2.0, 5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-9.0, -7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(-5.0, -4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(-9.0, 2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(-5.0, 2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(6.0, 1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(-8.0, 0.0, 0.0, 1.0, 3.0, -4.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(0.0, -3.0, 4.0, -6.0, 4.0, 7.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(1.0, -8.0, 0.0, 1.0, -3.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(8.0, -3.0, 0.0, -2.0, -4.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(0.0, -9.0, 7.0, 0.0, -5.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-7.0, -9.0, -7.0, 4.0, -9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(5.0, -4.0, -9.0, 2.0, -4.0, 7.0, 4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
layout(std140, binding = 1) readonly buffer Block
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

}
#version 450
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

layout(std140, buffer_reference) buffer Block
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
	allOk = compare_mat2(block.var, mat2(4.0, -8.0, -5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(7.0, -1.0, -6.0, 9.0));
}
#version 450
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
	allOk = compare_mat3(block.var, mat3(8.0, 6.0, -1.0, -6.0, 1.0, -4.0, -9.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(2.0, -3.0, 9.0, -8.0, 1.0, 7.0, 4.0, -1.0, 8.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(6.0, -6.0, 5.0, -1.0, -8.0, 2.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-9.0, -6.0));
	block.var[1] = (vec2(6.0, 8.0));
	block.var[2] = (vec2(-4.0, 3.0));
	block.var[3] = (vec2(6.0, 7.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(block.var, mat4x2(-5.0, 9.0, 3.0, -7.0, 8.0, 0.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(6.0, 0.0));
	block.var[1] = (vec2(-6.0, -8.0));
	block.var[2] = (vec2(-6.0, -7.0));
	block.var[3] = (vec2(-7.0, 1.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], 2.0) && allOk;
	allOk = compare_float(block.var[0][2], -6.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], 6.0) && allOk;
	allOk = compare_float(block.var[1][2], 2.0) && allOk;
	allOk = compare_float(block.var[2][0], 6.0) && allOk;
	allOk = compare_float(block.var[2][1], -8.0) && allOk;
	allOk = compare_float(block.var[2][2], 2.0) && allOk;
	allOk = compare_float(block.var[3][0], 0.0) && allOk;
	allOk = compare_float(block.var[3][1], -4.0) && allOk;
	allOk = compare_float(block.var[3][2], 8.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(1.0, 2.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-2.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(6.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(0.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(2.0, 8.0, 7.0, -6.0, -3.0, -1.0, -7.0, -9.0, 8.0, -9.0, -3.0, 1.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], -2.0) && allOk;
	allOk = compare_float(block.var[0][1], -8.0) && allOk;
	allOk = compare_float(block.var[0][2], 8.0) && allOk;
	allOk = compare_float(block.var[1][0], 1.0) && allOk;
	allOk = compare_float(block.var[1][1], -6.0) && allOk;
	allOk = compare_float(block.var[1][2], 9.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-2.0, -8.0, 8.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(1.0, -6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(9.0, 8.0, -4.0));
	block.var[1] = (vec3(-4.0, 3.0, 2.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(block.var, mat3x4(6.0, -1.0, -3.0, -3.0, -7.0, 2.0, 4.0, 3.0, -7.0, 9.0, 7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(6.0, 7.0, -9.0, -7.0, 8.0, 0.0, -5.0, -6.0, 0.0, -3.0, -8.0, 3.0));
}
#version 450
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
	mediump vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_vec4((block.var), vec4(4.0, -7.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var = (vec4(6.0, 7.0, 3.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2(block.var, mat2(2.0, -5.0, 4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var = (mat2(-7.0, -2.0, -2.0, -4.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat3(block.var, mat3(-7.0, 5.0, 2.0, 1.0, 1.0, -5.0, 3.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var = (mat3(1.0, 8.0, -8.0, -6.0, -2.0, 1.0, 6.0, 1.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat3(block.var, mat3(6.0, -1.0, -6.0, -5.0, -8.0, 5.0, 6.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var = (mat3(3.0, -5.0, 8.0, 0.0, 9.0, -8.0, 1.0, -5.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat4(block.var, mat4(2.0, 5.0, 5.0, 7.0, -4.0, 0.0, 3.0, 4.0, -6.0, -8.0, 5.0, 5.0, 1.0, 4.0, 5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var = (mat4(-8.0, -3.0, 9.0, -3.0, -5.0, -4.0, 4.0, 0.0, 3.0, 2.0, 1.0, 2.0, -4.0, -7.0, 7.0, 9.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat4(block.var, mat4(0.0, 0.0, -1.0, -6.0, -3.0, 1.0, 1.0, 9.0, 6.0, 8.0, 9.0, 5.0, -4.0, 1.0, -6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var = (mat4(-7.0, 9.0, 1.0, 3.0, -1.0, -4.0, -5.0, 4.0, 4.0, 3.0, 2.0, 7.0, 2.0, -1.0, 7.0, 0.0));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat4(block.var, mat4(-5.0, -6.0, -1.0, 3.0, -5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, -4.0, -9.0, 4.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0] = (vec4(-1.0, -2.0, -5.0, 5.0));
	block.var[1] = (vec4(-2.0, -8.0, -2.0, 3.0));
	block.var[2] = (vec4(1.0, -9.0, 1.0, 0.0));
	block.var[3] = (vec4(3.0, 9.0, 7.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_mat2x4(block.var, mat2x4(-4.0, 7.0, 6.0, -1.0, -7.0, -7.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0] = (vec4(1.0, -2.0, -4.0, 2.0));
	block.var[1] = (vec4(-2.0, -6.0, -3.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 4.0) && allOk;
	allOk = compare_mat2x4(block.var, mat2x4(-2.0, 8.0, -5.0, 9.0, -6.0, -1.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var = (mat2x4(-3.0, -3.0, -7.0, -9.0, 3.0, -6.0, -5.0, -6.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(1.0, -1.0, 1.0));
	block.var[0][1] = (vec3(-3.0, 9.0, -8.0));
	block.var[1][0] = (vec3(-5.0, 6.0, 6.0));
	block.var[1][1] = (vec3(3.0, -3.0, 7.0));
	block.var[2][0] = (vec3(-9.0, -2.0, -7.0));
	block.var[2][1] = (vec3(7.0, 0.0, -8.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	block.var[0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	block.var[1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	block.var[1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	block.var[2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	block.var[2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	block.var[1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	block.var[2] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
}
#version 450
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
	i8vec2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(block.var[0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2]), ivec2(0, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i8vec2(ivec2(0, 8));
	block.var[1] = i8vec2(ivec2(4294967292, 9));
	block.var[2] = i8vec2(ivec2(4294967294, 4294967295));
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x3(block.var[0][0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(-2.0, -1.0, 3.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(5.0, 8.0, 1.0, -7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(0.0, 9.0, -1.0, -8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(-6.0, 9.0, 9.0, -2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(8.0, -6.0, -2.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(-2.0, -9.0, -1.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(-5.0, -9.0, -3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(-9.0, -1.0, -9.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(-6.0, -1.0, 7.0, -5.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	block.var[0][1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	block.var[0][2] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
	block.var[1][0] = (mat2x3(6.0, 9.0, 2.0, -3.0, 0.0, 5.0));
	block.var[1][1] = (mat2x3(-9.0, 6.0, -3.0, 9.0, -7.0, 2.0));
	block.var[1][2] = (mat2x3(8.0, -3.0, 7.0, -9.0, 7.0, -1.0));
	block.var[2][0] = (mat2x3(-4.0, -3.0, -6.0, -1.0, -5.0, 7.0));
	block.var[2][1] = (mat2x3(1.0, 9.0, -7.0, 3.0, 3.0, 1.0));
	block.var[2][2] = (mat2x3(-4.0, -9.0, 4.0, -1.0, -4.0, 1.0));
	block.var[3][0] = (mat2x3(-7.0, 0.0, -4.0, -6.0, -1.0, -1.0));
	block.var[3][1] = (mat2x3(5.0, -5.0, 0.0, -6.0, -9.0, -6.0));
	block.var[3][2] = (mat2x3(-2.0, -1.0, -6.0, -6.0, 3.0, -3.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0], mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	block.var[0][1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	block.var[0][2] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
	block.var[1][0] = (mat3(8.0, -1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0));
	block.var[1][1] = (mat3(-2.0, 9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0));
	block.var[1][2] = (mat3(-9.0, -7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0));
	block.var[2][0] = (mat3(-2.0, 9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0));
	block.var[2][1] = (mat3(-5.0, 6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0));
	block.var[2][2] = (mat3(6.0, 6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0));
	block.var[3][0] = (mat3(-1.0, 6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0));
	block.var[3][1] = (mat3(3.0, -9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0));
	block.var[3][2] = (mat3(-6.0, -9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0));
}
#version 450
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
	int8_t var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.var[0][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[0][1]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[0][2]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[1][0]), 1) && allOk;
	allOk = compare_int8_t(int(block.var[1][1]), 6) && allOk;
	allOk = compare_int8_t(int(block.var[1][2]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[2][0]), 5) && allOk;
	allOk = compare_int8_t(int(block.var[2][1]), 2) && allOk;
	allOk = compare_int8_t(int(block.var[2][2]), 0) && allOk;
	allOk = compare_int8_t(int(block.var[3][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[3][1]), 4294967287) && allOk;
	allOk = compare_int8_t(int(block.var[3][2]), 4294967289) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = int8_t(4294967290);
	block.var[0][1] = int8_t(4294967294);
	block.var[0][2] = int8_t(3);
	block.var[1][0] = int8_t(4294967288);
	block.var[1][1] = int8_t(1);
	block.var[1][2] = int8_t(2);
	block.var[2][0] = int8_t(4294967288);
	block.var[2][1] = int8_t(4294967294);
	block.var[2][2] = int8_t(7);
	block.var[3][0] = int8_t(9);
	block.var[3][1] = int8_t(0);
	block.var[3][2] = int8_t(4294967292);
}
#version 450
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
	i8vec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(block.var[0][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][2]), ivec2(0, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][1]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][2]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][0]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][1]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][2]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][0]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][1]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[3][2]), ivec2(3, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = i8vec2(ivec2(0, 8));
	block.var[0][1] = i8vec2(ivec2(4294967292, 9));
	block.var[0][2] = i8vec2(ivec2(4294967294, 4294967295));
	block.var[1][0] = i8vec2(ivec2(8, 4294967290));
	block.var[1][1] = i8vec2(ivec2(8, 4294967289));
	block.var[1][2] = i8vec2(ivec2(7, 4294967294));
	block.var[2][0] = i8vec2(ivec2(4294967293, 4294967293));
	block.var[2][1] = i8vec2(ivec2(4294967290, 3));
	block.var[2][2] = i8vec2(ivec2(4294967295, 8));
	block.var[3][0] = i8vec2(ivec2(5, 8));
	block.var[3][1] = i8vec2(ivec2(4294967293, 4294967292));
	block.var[3][2] = i8vec2(ivec2(4294967287, 6));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0], mat3x4(5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0, -7.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(-9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0, 7.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(-3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0, 1.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(-6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0, 1.0, -8.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(-4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0, 6.0, 3.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(-5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0, 6.0, 5.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(-4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0, 3.0, 2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0, 3.0, -2.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0, -2.0, 4.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0, -8.0, 1.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0, 4.0, 3.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(-7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0, 0.0, -3.0, 3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0][0] = (mat3x4(5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0, 2.0, -8.0, -3.0, 0.0));
	block.var[0][1] = (mat3x4(-1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0, -5.0, 1.0, -9.0, -7.0));
	block.var[0][2] = (mat3x4(-7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0, 5.0, -9.0, -3.0, 0.0));
	block.var[1][0] = (mat3x4(0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0, -2.0, -8.0, -5.0, -1.0));
	block.var[1][1] = (mat3x4(2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0, 7.0, 7.0, 7.0, 5.0));
	block.var[1][2] = (mat3x4(7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0, 8.0, 9.0, 8.0, -7.0));
	block.var[2][0] = (mat3x4(-8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0, -8.0, -2.0, 9.0, 1.0));
	block.var[2][1] = (mat3x4(-4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0, 5.0, 7.0, 5.0, -1.0));
	block.var[2][2] = (mat3x4(-6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0, 2.0, 3.0, -5.0, -2.0));
	block.var[3][0] = (mat3x4(-5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0, 9.0, -8.0, 3.0, -3.0));
	block.var[3][1] = (mat3x4(-1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0, 2.0, 8.0, 3.0, -7.0));
	block.var[3][2] = (mat3x4(-7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0, -5.0, -3.0, 6.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0], mat3x4(7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(-9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(-5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(-8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(-3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0][0] = (vec4(-5.0, 2.0, 5.0, -2.0));
	block.var[0][0][1] = (vec4(-3.0, 9.0, -2.0, -6.0));
	block.var[0][0][2] = (vec4(7.0, 4.0, -6.0, 2.0));
	block.var[0][1][0] = (vec4(6.0, 9.0, -2.0, 7.0));
	block.var[0][1][1] = (vec4(9.0, 0.0, 0.0, 8.0));
	block.var[0][1][2] = (vec4(-3.0, 0.0, 3.0, -6.0));
	block.var[0][2][0] = (vec4(1.0, 9.0, 6.0, -9.0));
	block.var[0][2][1] = (vec4(-9.0, 2.0, -4.0, -8.0));
	block.var[0][2][2] = (vec4(5.0, -1.0, 9.0, 8.0));
	block.var[1][0][0] = (vec4(-2.0, 1.0, 1.0, -6.0));
	block.var[1][0][1] = (vec4(-1.0, -9.0, 6.0, 7.0));
	block.var[1][0][2] = (vec4(-1.0, 1.0, -8.0, 6.0));
	block.var[1][1][0] = (vec4(8.0, -2.0, 7.0, 1.0));
	block.var[1][1][1] = (vec4(-6.0, -3.0, 9.0, 1.0));
	block.var[1][1][2] = (vec4(-6.0, 1.0, -6.0, 3.0));
	block.var[1][2][0] = (vec4(-1.0, 5.0, -2.0, 7.0));
	block.var[1][2][1] = (vec4(-1.0, -2.0, -3.0, -6.0));
	block.var[1][2][2] = (vec4(4.0, -4.0, -1.0, -3.0));
	block.var[2][0][0] = (vec4(-3.0, 3.0, -7.0, 2.0));
	block.var[2][0][1] = (vec4(8.0, -4.0, 1.0, -1.0));
	block.var[2][0][2] = (vec4(6.0, -4.0, 7.0, 5.0));
	block.var[2][1][0] = (vec4(-8.0, -2.0, 6.0, -2.0));
	block.var[2][1][1] = (vec4(8.0, -2.0, 2.0, 3.0));
	block.var[2][1][2] = (vec4(7.0, 0.0, 2.0, 3.0));
	block.var[2][2][0] = (vec4(9.0, 8.0, 5.0, 2.0));
	block.var[2][2][1] = (vec4(-3.0, -7.0, 2.0, -1.0));
	block.var[2][2][2] = (vec4(1.0, -4.0, -1.0, -6.0));
	block.var[3][0][0] = (vec4(-4.0, -1.0, -3.0, -8.0));
	block.var[3][0][1] = (vec4(5.0, -4.0, -9.0, 8.0));
	block.var[3][0][2] = (vec4(3.0, -8.0, 0.0, 7.0));
	block.var[3][1][0] = (vec4(-2.0, 0.0, 8.0, -9.0));
	block.var[3][1][1] = (vec4(2.0, -3.0, -7.0, -5.0));
	block.var[3][1][2] = (vec4(3.0, 9.0, -6.0, -7.0));
	block.var[3][2][0] = (vec4(-8.0, -8.0, -7.0, -9.0));
	block.var[3][2][1] = (vec4(2.0, 4.0, -7.0, 8.0));
	block.var[3][2][2] = (vec4(-7.0, 4.0, -8.0, 0.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat4x3(block.var[0][0], mat4x3(5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0, 9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0, -2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0, 8.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(-6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0, -5.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0, -4.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0, 4.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0, -9.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(-9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0, -5.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(-9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0, 1.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0][0] = (mat4x3(-5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0, 9.0, 2.0, -5.0));
	block.var[0][1] = (mat4x3(-6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0, 2.0, 4.0, 4.0));
	block.var[0][2] = (mat4x3(-9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0, 2.0, 8.0, 9.0));
	block.var[1][0] = (mat4x3(-3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0, -7.0, -4.0, 9.0));
	block.var[1][1] = (mat4x3(7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0, 0.0, 0.0, -4.0));
	block.var[1][2] = (mat4x3(-5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0, 1.0, 3.0, -8.0));
	block.var[2][0] = (mat4x3(-5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0, -3.0, -8.0, 8.0));
	block.var[2][1] = (mat4x3(9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0, -8.0, -9.0, -8.0));
	block.var[2][2] = (mat4x3(-9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0, 9.0, 8.0, 8.0));
	block.var[3][0] = (mat4x3(2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0, -3.0, -6.0, 1.0));
	block.var[3][1] = (mat4x3(-5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0, -6.0, -5.0, -4.0));
	block.var[3][2] = (mat4x3(-4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0, 8.0, 5.0, 4.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(0.0, -5.0, 8.0, -6.0, -1.0, -7.0, 0.0, 3.0, -2.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-4.0, -5.0, 4.0, 2.0, -5.0, -5.0, -9.0, 2.0, -7.0, 9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(2.0, 0.0, -4.0, 6.0, 3.0, -2.0, -9.0, 8.0, -8.0, 8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-7.0, -2.0, 9.0, -3.0, 9.0, -8.0, 1.0, -7.0, -8.0, -9.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-2.0, 9.0, -3.0, -1.0, -8.0, 5.0, 9.0, -3.0, 7.0, 2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(0.0, 7.0, -2.0, 1.0, 7.0, 1.0, -5.0, 4.0, 4.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(0.0, -3.0, -6.0, 4.0, -8.0, -1.0, 9.0, 9.0, 2.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-7.0, 4.0, 7.0, 7.0, 0.0, -9.0, -8.0, -1.0, -6.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(8.0, -2.0, 1.0, 8.0, 4.0, 6.0, -6.0, -5.0, 1.0, -7.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(5.0, 1.0, 1.0, -6.0, 0.0, -8.0, -7.0, 3.0, 3.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(-2.0, -2.0, 3.0, -6.0, -5.0, -1.0, 2.0, -4.0, -8.0, -7.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(-3.0, -9.0, 3.0, 8.0, 3.0, 7.0, 9.0, 3.0, -3.0, 7.0, -8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	block.var[0][0][0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	block.var[0][0][0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	block.var[0][0][1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	block.var[0][0][1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	block.var[0][0][1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	block.var[0][0][2][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	block.var[0][0][2][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	block.var[0][0][2][2] = (vec4(0.0, 4.0, 1.0, -9.0));
	block.var[0][1][0][0] = (vec4(7.0, 5.0, 1.0, 8.0));
	block.var[0][1][0][1] = (vec4(-4.0, 6.0, -3.0, -6.0));
	block.var[0][1][0][2] = (vec4(2.0, -9.0, -8.0, 6.0));
	block.var[0][1][1][0] = (vec4(-7.0, 0.0, 5.0, 8.0));
	block.var[0][1][1][1] = (vec4(9.0, 8.0, -6.0, -2.0));
	block.var[0][1][1][2] = (vec4(9.0, -5.0, 4.0, -4.0));
	block.var[0][1][2][0] = (vec4(-5.0, -1.0, -2.0, -8.0));
	block.var[0][1][2][1] = (vec4(-2.0, 5.0, -5.0, 9.0));
	block.var[0][1][2][2] = (vec4(7.0, -5.0, -3.0, 0.0));
	block.var[1][0][0][0] = (vec4(3.0, -3.0, 5.0, 9.0));
	block.var[1][0][0][1] = (vec4(4.0, -2.0, -3.0, -6.0));
	block.var[1][0][0][2] = (vec4(8.0, 9.0, -9.0, -5.0));
	block.var[1][0][1][0] = (vec4(3.0, 4.0, -1.0, -5.0));
	block.var[1][0][1][1] = (vec4(9.0, -2.0, 4.0, -9.0));
	block.var[1][0][1][2] = (vec4(1.0, -8.0, -2.0, 1.0));
	block.var[1][0][2][0] = (vec4(-8.0, -2.0, 9.0, 8.0));
	block.var[1][0][2][1] = (vec4(-5.0, -8.0, -2.0, 7.0));
	block.var[1][0][2][2] = (vec4(-3.0, -9.0, 0.0, -9.0));
	block.var[1][1][0][0] = (vec4(-5.0, -6.0, 7.0, 0.0));
	block.var[1][1][0][1] = (vec4(7.0, -8.0, -6.0, 0.0));
	block.var[1][1][0][2] = (vec4(7.0, -9.0, 2.0, 3.0));
	block.var[1][1][1][0] = (vec4(6.0, -9.0, -7.0, 6.0));
	block.var[1][1][1][1] = (vec4(0.0, 2.0, 9.0, -1.0));
	block.var[1][1][1][2] = (vec4(3.0, -4.0, 9.0, -2.0));
	block.var[1][1][2][0] = (vec4(-4.0, 6.0, 1.0, -2.0));
	block.var[1][1][2][1] = (vec4(-4.0, 3.0, 1.0, -1.0));
	block.var[1][1][2][2] = (vec4(9.0, -4.0, -1.0, 3.0));
	block.var[2][0][0][0] = (vec4(7.0, 4.0, -2.0, -4.0));
	block.var[2][0][0][1] = (vec4(6.0, -9.0, -7.0, 3.0));
	block.var[2][0][0][2] = (vec4(-3.0, -6.0, -1.0, 0.0));
	block.var[2][0][1][0] = (vec4(2.0, 3.0, -1.0, 9.0));
	block.var[2][0][1][1] = (vec4(-3.0, -9.0, -1.0, 0.0));
	block.var[2][0][1][2] = (vec4(-9.0, 1.0, 6.0, 5.0));
	block.var[2][0][2][0] = (vec4(-8.0, 4.0, -8.0, 5.0));
	block.var[2][0][2][1] = (vec4(4.0, 3.0, -7.0, 5.0));
	block.var[2][0][2][2] = (vec4(-4.0, 7.0, 2.0, -6.0));
	block.var[2][1][0][0] = (vec4(-1.0, -1.0, -9.0, -5.0));
	block.var[2][1][0][1] = (vec4(6.0, 2.0, -2.0, 8.0));
	block.var[2][1][0][2] = (vec4(9.0, 2.0, -4.0, 7.0));
	block.var[2][1][1][0] = (vec4(-8.0, -7.0, 8.0, -8.0));
	block.var[2][1][1][1] = (vec4(-5.0, 2.0, -3.0, 5.0));
	block.var[2][1][1][2] = (vec4(-3.0, -2.0, -5.0, 3.0));
	block.var[2][1][2][0] = (vec4(-3.0, 8.0, -3.0, -6.0));
	block.var[2][1][2][1] = (vec4(-4.0, 6.0, -2.0, -2.0));
	block.var[2][1][2][2] = (vec4(-4.0, -3.0, -1.0, -3.0));
	block.var[3][0][0][0] = (vec4(-2.0, 4.0, -9.0, -3.0));
	block.var[3][0][0][1] = (vec4(7.0, 5.0, -1.0, 1.0));
	block.var[3][0][0][2] = (vec4(6.0, -2.0, -5.0, 9.0));
	block.var[3][0][1][0] = (vec4(-6.0, 2.0, 5.0, -5.0));
	block.var[3][0][1][1] = (vec4(2.0, 4.0, -3.0, 1.0));
	block.var[3][0][1][2] = (vec4(9.0, -1.0, -1.0, -1.0));
	block.var[3][0][2][0] = (vec4(7.0, -4.0, -7.0, -3.0));
	block.var[3][0][2][1] = (vec4(9.0, -7.0, -5.0, -9.0));
	block.var[3][0][2][2] = (vec4(3.0, 9.0, 2.0, -5.0));
	block.var[3][1][0][0] = (vec4(7.0, 9.0, -4.0, 8.0));
	block.var[3][1][0][1] = (vec4(-6.0, 4.0, -4.0, -8.0));
	block.var[3][1][0][2] = (vec4(1.0, 2.0, 2.0, -4.0));
	block.var[3][1][1][0] = (vec4(-1.0, -9.0, 2.0, 6.0));
	block.var[3][1][1][1] = (vec4(5.0, 9.0, 3.0, -7.0));
	block.var[3][1][1][2] = (vec4(7.0, -8.0, -1.0, -8.0));
	block.var[3][1][2][0] = (vec4(3.0, -4.0, 6.0, -5.0));
	block.var[3][1][2][1] = (vec4(-5.0, 3.0, 5.0, -2.0));
	block.var[3][1][2][2] = (vec4(-3.0, 2.0, 1.0, 6.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(4.0, 9.0, 6.0, -4.0, -3.0, 3.0, -3.0, 5.0, -3.0, 6.0, -9.0, 2.0, 5.0, 7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(-5.0, -3.0, 7.0, -5.0, -5.0, -7.0, -9.0, 5.0, 3.0, -1.0, 9.0, -3.0, 4.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(-6.0, -7.0, -9.0, 4.0, 6.0, -4.0, 2.0, -1.0, 9.0, 3.0, -3.0, 3.0, -6.0, 5.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-8.0, -6.0, 5.0, 0.0, -1.0, -7.0, 4.0, 2.0, -1.0, -9.0, 6.0, 4.0, -9.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-3.0, 8.0, -5.0, 2.0, -2.0, -2.0, 9.0, 4.0, 0.0, 3.0, -5.0, 4.0, 0.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(7.0, -4.0, 0.0, -2.0, -9.0, -9.0, 0.0, -9.0, 7.0, 9.0, -9.0, -9.0, -8.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(-9.0, 0.0, -3.0, -3.0, -4.0, -6.0, -9.0, 9.0, 8.0, 6.0, 3.0, -2.0, 1.0, 5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(5.0, -4.0, -6.0, -5.0, 7.0, -3.0, 5.0, -5.0, -8.0, 2.0, -5.0, 8.0, 2.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(6.0, -2.0, 6.0, -6.0, 6.0, 4.0, 7.0, 9.0, -7.0, -3.0, -4.0, 9.0, 5.0, -8.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-8.0, 1.0, 4.0, -5.0, 3.0, 6.0, -6.0, 7.0, -1.0, -4.0, 7.0, 1.0, -6.0, 5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(8.0, 6.0, 6.0, 7.0, 8.0, 4.0, 5.0, 0.0, 6.0, -6.0, 6.0, 7.0, 9.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(4.0, -6.0, -6.0, -8.0, 9.0, 3.0, 8.0, -6.0, -4.0, -5.0, -7.0, -4.0, -7.0, -4.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	block.var[0][0][1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	block.var[0][0][2] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
	block.var[0][1][0] = (mat4(5.0, 4.0, 4.0, 1.0, 7.0, -5.0, 1.0, 7.0, 8.0, 8.0, 5.0, 4.0, 9.0, -4.0, 9.0, 7.0));
	block.var[0][1][1] = (mat4(8.0, 7.0, -8.0, 1.0, -7.0, 7.0, 0.0, -2.0, 1.0, -8.0, -2.0, 8.0, -8.0, 9.0, -6.0, -1.0));
	block.var[0][1][2] = (mat4(-3.0, -5.0, -4.0, -7.0, -9.0, -6.0, -8.0, 6.0, -1.0, 8.0, 0.0, -8.0, -4.0, 4.0, 8.0, -5.0));
	block.var[1][0][0] = (mat4(-1.0, 9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0));
	block.var[1][0][1] = (mat4(5.0, 6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0));
	block.var[1][0][2] = (mat4(7.0, -1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0));
	block.var[1][1][0] = (mat4(-4.0, -9.0, 6.0, 9.0, -4.0, -2.0, -8.0, -8.0, 4.0, 7.0, 3.0, 6.0, -4.0, -3.0, -4.0, 6.0));
	block.var[1][1][1] = (mat4(7.0, 4.0, 4.0, 3.0, -8.0, -4.0, -4.0, 7.0, -3.0, -4.0, 4.0, -6.0, 2.0, 8.0, 4.0, -7.0));
	block.var[1][1][2] = (mat4(1.0, 1.0, 6.0, 3.0, 8.0, 2.0, -7.0, 7.0, 9.0, -8.0, 9.0, 0.0, 8.0, 4.0, 8.0, 2.0));
	block.var[2][0][0] = (mat4(4.0, -8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0));
	block.var[2][0][1] = (mat4(-9.0, -2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0));
	block.var[2][0][2] = (mat4(5.0, -2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0));
	block.var[2][1][0] = (mat4(4.0, 2.0, -9.0, 1.0, 5.0, -7.0, -4.0, -2.0, -7.0, -5.0, 1.0, -6.0, -8.0, 6.0, -2.0, 4.0));
	block.var[2][1][1] = (mat4(-4.0, 2.0, -7.0, -3.0, -2.0, 4.0, -5.0, 8.0, -3.0, 2.0, -8.0, -9.0, 0.0, 8.0, 5.0, -5.0));
	block.var[2][1][2] = (mat4(-1.0, -9.0, -7.0, 0.0, -9.0, -9.0, 7.0, -8.0, -5.0, -2.0, -2.0, -8.0, 5.0, 1.0, 7.0, -6.0));
	block.var[3][0][0] = (mat4(-2.0, -6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0));
	block.var[3][0][1] = (mat4(-9.0, -3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0));
	block.var[3][0][2] = (mat4(6.0, 9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0));
	block.var[3][1][0] = (mat4(-8.0, -1.0, 9.0, 1.0, -8.0, -1.0, -6.0, 2.0, -8.0, -8.0, -9.0, -1.0, -8.0, 1.0, -1.0, 0.0));
	block.var[3][1][1] = (mat4(4.0, 8.0, 5.0, 7.0, -8.0, -2.0, 3.0, -9.0, 5.0, -1.0, -6.0, -3.0, -9.0, 9.0, -8.0, 9.0));
	block.var[3][1][2] = (mat4(2.0, 0.0, 2.0, 2.0, 9.0, -4.0, -4.0, 8.0, -8.0, -2.0, -7.0, 4.0, -1.0, 2.0, -6.0, 1.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	float padding;
	highp vec4 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_vec4((block.var[0][0][0]), vec4(4.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4((block.var[0][0][1]), vec4(4.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec4((block.var[0][0][2]), vec4(-4.0, 3.0, -8.0, -3.0)) && allOk;
	allOk = compare_vec4((block.var[0][1][0]), vec4(3.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_vec4((block.var[0][1][1]), vec4(1.0, -6.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec4((block.var[0][1][2]), vec4(6.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_vec4((block.var[1][0][0]), vec4(-3.0, -6.0, -4.0, -1.0)) && allOk;
	allOk = compare_vec4((block.var[1][0][1]), vec4(0.0, -8.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec4((block.var[1][0][2]), vec4(1.0, 8.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec4((block.var[1][1][0]), vec4(-7.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec4((block.var[1][1][1]), vec4(-6.0, 5.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec4((block.var[1][1][2]), vec4(-5.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((block.var[2][0][0]), vec4(9.0, -5.0, -1.0, 8.0)) && allOk;
	allOk = compare_vec4((block.var[2][0][1]), vec4(-5.0, -7.0, 0.0, -7.0)) && allOk;
	allOk = compare_vec4((block.var[2][0][2]), vec4(2.0, -6.0, 6.0, -1.0)) && allOk;
	allOk = compare_vec4((block.var[2][1][0]), vec4(-4.0, -2.0, -7.0, -2.0)) && allOk;
	allOk = compare_vec4((block.var[2][1][1]), vec4(7.0, -3.0, -4.0, -2.0)) && allOk;
	allOk = compare_vec4((block.var[2][1][2]), vec4(-5.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_vec4((block.var[3][0][0]), vec4(6.0, -6.0, 8.0, 8.0)) && allOk;
	allOk = compare_vec4((block.var[3][0][1]), vec4(1.0, 8.0, 2.0, 3.0)) && allOk;
	allOk = compare_vec4((block.var[3][0][2]), vec4(-4.0, 2.0, 1.0, -1.0)) && allOk;
	allOk = compare_vec4((block.var[3][1][0]), vec4(-9.0, 9.0, 9.0, 5.0)) && allOk;
	allOk = compare_vec4((block.var[3][1][1]), vec4(-9.0, -7.0, -7.0, -6.0)) && allOk;
	allOk = compare_vec4((block.var[3][1][2]), vec4(-9.0, 4.0, 7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0][0][0] = (vec4(8.0, 3.0, -4.0, -6.0));
	block.var[0][0][1] = (vec4(-1.0, -3.0, 6.0, 5.0));
	block.var[0][0][2] = (vec4(-9.0, 4.0, -1.0, -7.0));
	block.var[0][1][0] = (vec4(7.0, 1.0, 1.0, -7.0));
	block.var[0][1][1] = (vec4(-6.0, -7.0, -4.0, 8.0));
	block.var[0][1][2] = (vec4(-1.0, -6.0, -8.0, 9.0));
	block.var[1][0][0] = (vec4(-6.0, -2.0, -8.0, 8.0));
	block.var[1][0][1] = (vec4(7.0, 5.0, 1.0, -6.0));
	block.var[1][0][2] = (vec4(-5.0, -8.0, 8.0, 0.0));
	block.var[1][1][0] = (vec4(7.0, -3.0, -8.0, -3.0));
	block.var[1][1][1] = (vec4(-9.0, 2.0, 1.0, -7.0));
	block.var[1][1][2] = (vec4(3.0, -5.0, 8.0, 5.0));
	block.var[2][0][0] = (vec4(8.0, 4.0, -4.0, -8.0));
	block.var[2][0][1] = (vec4(-3.0, 9.0, -7.0, -9.0));
	block.var[2][0][2] = (vec4(2.0, -6.0, 6.0, 6.0));
	block.var[2][1][0] = (vec4(-4.0, -5.0, 6.0, 0.0));
	block.var[2][1][1] = (vec4(-2.0, -8.0, 7.0, 0.0));
	block.var[2][1][2] = (vec4(-7.0, -2.0, -7.0, 3.0));
	block.var[3][0][0] = (vec4(2.0, -3.0, 0.0, -9.0));
	block.var[3][0][1] = (vec4(8.0, -8.0, 0.0, 2.0));
	block.var[3][0][2] = (vec4(6.0, 6.0, 1.0, 1.0));
	block.var[3][1][0] = (vec4(-8.0, 1.0, 6.0, 0.0));
	block.var[3][1][1] = (vec4(5.0, -3.0, -2.0, -9.0));
	block.var[3][1][2] = (vec4(-7.0, 2.0, -7.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat2(block.var[0][0][0], mat2(3.0, -8.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(5.0, 4.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(2.0, -7.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(5.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-1.0, -4.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(6.0, 3.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(9.0, 1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-6.0, 4.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(3.0, 7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-7.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(1.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(-2.0, 9.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(6.0, -5.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-4.0, -1.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(-4.0, -3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(-5.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(3.0, 4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(-2.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(7.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(4.0, -2.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(6.0, -7.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(9.0, -6.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-2.0, -3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(-3.0, 7.0, -9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0][0] = (mat2(4.0, 4.0, -1.0, 2.0));
	block.var[0][0][1] = (mat2(-5.0, 1.0, -1.0, -2.0));
	block.var[0][0][2] = (mat2(-9.0, -3.0, -8.0, -6.0));
	block.var[0][1][0] = (mat2(7.0, -8.0, 6.0, 1.0));
	block.var[0][1][1] = (mat2(0.0, 7.0, -3.0, 9.0));
	block.var[0][1][2] = (mat2(-8.0, -6.0, -9.0, -6.0));
	block.var[1][0][0] = (mat2(-7.0, 1.0, -1.0, 6.0));
	block.var[1][0][1] = (mat2(2.0, -7.0, 8.0, -3.0));
	block.var[1][0][2] = (mat2(-2.0, 2.0, -7.0, -1.0));
	block.var[1][1][0] = (mat2(8.0, 1.0, -2.0, -4.0));
	block.var[1][1][1] = (mat2(-5.0, -4.0, 2.0, 4.0));
	block.var[1][1][2] = (mat2(-9.0, 8.0, -9.0, -2.0));
	block.var[2][0][0] = (mat2(-3.0, -7.0, 2.0, -3.0));
	block.var[2][0][1] = (mat2(-6.0, 2.0, 7.0, 4.0));
	block.var[2][0][2] = (mat2(-2.0, -7.0, 4.0, -7.0));
	block.var[2][1][0] = (mat2(2.0, 3.0, -3.0, 3.0));
	block.var[2][1][1] = (mat2(2.0, -9.0, -5.0, -9.0));
	block.var[2][1][2] = (mat2(7.0, -7.0, 5.0, -9.0));
	block.var[3][0][0] = (mat2(-5.0, -7.0, -5.0, -6.0));
	block.var[3][0][1] = (mat2(4.0, 6.0, 4.0, 2.0));
	block.var[3][0][2] = (mat2(-1.0, 9.0, 6.0, -5.0));
	block.var[3][1][0] = (mat2(-6.0, -9.0, 3.0, 4.0));
	block.var[3][1][1] = (mat2(-2.0, 0.0, -7.0, 4.0));
	block.var[3][1][2] = (mat2(-2.0, -8.0, 0.0, 6.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat3(block.var[0][0][0], mat3(-4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(-2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(8.0, -5.0, -5.0, -8.0, -4.0, -7.0, 9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-8.0, 6.0, 4.0, -3.0, 9.0, -2.0, 2.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(7.0, -4.0, 4.0, -4.0, 1.0, 6.0, -2.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(-9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-6.0, 4.0, -6.0, 8.0, 1.0, -7.0, -1.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(5.0, 5.0, -1.0, -9.0, -7.0, 7.0, 9.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(-7.0, 0.0, -4.0, 1.0, -7.0, 1.0, -8.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-4.0, -2.0, -7.0, 2.0, -2.0, 9.0, 2.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(-2.0, 5.0, -3.0, 7.0, -5.0, 2.0, 4.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(2.0, 8.0, -3.0, -7.0, -9.0, -7.0, 4.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(-7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(7.0, -4.0, 4.0, 5.0, 3.0, 0.0, -1.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(-9.0, 6.0, -4.0, -2.0, -4.0, 3.0, 8.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(-9.0, 2.0, -6.0, 6.0, 7.0, 8.0, -2.0, 1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0][0][0] = (vec3(-4.0, 9.0, -4.0));
	block.var[0][0][0][1] = (vec3(2.0, 5.0, 5.0));
	block.var[0][0][0][2] = (vec3(-9.0, -5.0, 3.0));
	block.var[0][0][1][0] = (vec3(1.0, 8.0, 6.0));
	block.var[0][0][1][1] = (vec3(9.0, -8.0, -1.0));
	block.var[0][0][1][2] = (vec3(5.0, 1.0, 6.0));
	block.var[0][0][2][0] = (vec3(-5.0, -4.0, -8.0));
	block.var[0][0][2][1] = (vec3(-8.0, -2.0, 9.0));
	block.var[0][0][2][2] = (vec3(-4.0, 4.0, 4.0));
	block.var[0][1][0][0] = (vec3(-8.0, 2.0, -6.0));
	block.var[0][1][0][1] = (vec3(9.0, -7.0, 9.0));
	block.var[0][1][0][2] = (vec3(6.0, 1.0, -4.0));
	block.var[0][1][1][0] = (vec3(8.0, -7.0, 1.0));
	block.var[0][1][1][1] = (vec3(0.0, 4.0, -6.0));
	block.var[0][1][1][2] = (vec3(-3.0, 3.0, -5.0));
	block.var[0][1][2][0] = (vec3(-6.0, 5.0, 4.0));
	block.var[0][1][2][1] = (vec3(3.0, -2.0, -6.0));
	block.var[0][1][2][2] = (vec3(-4.0, -1.0, 4.0));
	block.var[1][0][0][0] = (vec3(-1.0, 5.0, -1.0));
	block.var[1][0][0][1] = (vec3(0.0, 9.0, 7.0));
	block.var[1][0][0][2] = (vec3(7.0, 5.0, 8.0));
	block.var[1][0][1][0] = (vec3(-6.0, -1.0, -1.0));
	block.var[1][0][1][1] = (vec3(-2.0, -5.0, -5.0));
	block.var[1][0][1][2] = (vec3(6.0, -3.0, -4.0));
	block.var[1][0][2][0] = (vec3(-6.0, 2.0, 3.0));
	block.var[1][0][2][1] = (vec3(-1.0, 2.0, -3.0));
	block.var[1][0][2][2] = (vec3(4.0, 1.0, 9.0));
	block.var[1][1][0][0] = (vec3(4.0, -6.0, 0.0));
	block.var[1][1][0][1] = (vec3(2.0, -5.0, 5.0));
	block.var[1][1][0][2] = (vec3(8.0, -2.0, 3.0));
	block.var[1][1][1][0] = (vec3(-1.0, 7.0, -9.0));
	block.var[1][1][1][1] = (vec3(-9.0, -8.0, 9.0));
	block.var[1][1][1][2] = (vec3(-9.0, -5.0, 1.0));
	block.var[1][1][2][0] = (vec3(-2.0, 1.0, -8.0));
	block.var[1][1][2][1] = (vec3(-4.0, -3.0, 3.0));
	block.var[1][1][2][2] = (vec3(-4.0, -3.0, -5.0));
	block.var[2][0][0][0] = (vec3(-3.0, -9.0, 6.0));
	block.var[2][0][0][1] = (vec3(-1.0, -6.0, 6.0));
	block.var[2][0][0][2] = (vec3(2.0, -5.0, -1.0));
	block.var[2][0][1][0] = (vec3(-2.0, 2.0, 9.0));
	block.var[2][0][1][1] = (vec3(1.0, -8.0, 6.0));
	block.var[2][0][1][2] = (vec3(-1.0, 7.0, 4.0));
	block.var[2][0][2][0] = (vec3(2.0, -8.0, 0.0));
	block.var[2][0][2][1] = (vec3(3.0, 9.0, 9.0));
	block.var[2][0][2][2] = (vec3(-8.0, -4.0, -8.0));
	block.var[2][1][0][0] = (vec3(7.0, 5.0, -2.0));
	block.var[2][1][0][1] = (vec3(-2.0, 8.0, -3.0));
	block.var[2][1][0][2] = (vec3(1.0, 7.0, -9.0));
	block.var[2][1][1][0] = (vec3(8.0, 7.0, 2.0));
	block.var[2][1][1][1] = (vec3(2.0, -5.0, -8.0));
	block.var[2][1][1][2] = (vec3(-5.0, 6.0, 4.0));
	block.var[2][1][2][0] = (vec3(1.0, 9.0, 5.0));
	block.var[2][1][2][1] = (vec3(-6.0, 7.0, -7.0));
	block.var[2][1][2][2] = (vec3(-2.0, -6.0, 0.0));
	block.var[3][0][0][0] = (vec3(3.0, 4.0, -4.0));
	block.var[3][0][0][1] = (vec3(4.0, 1.0, 0.0));
	block.var[3][0][0][2] = (vec3(4.0, 5.0, -9.0));
	block.var[3][0][1][0] = (vec3(-4.0, 2.0, -6.0));
	block.var[3][0][1][1] = (vec3(8.0, 3.0, 2.0));
	block.var[3][0][1][2] = (vec3(0.0, -1.0, 7.0));
	block.var[3][0][2][0] = (vec3(1.0, 3.0, 5.0));
	block.var[3][0][2][1] = (vec3(1.0, -6.0, 2.0));
	block.var[3][0][2][2] = (vec3(-5.0, 4.0, -9.0));
	block.var[3][1][0][0] = (vec3(-9.0, 7.0, -2.0));
	block.var[3][1][0][1] = (vec3(0.0, 5.0, 8.0));
	block.var[3][1][0][2] = (vec3(8.0, -1.0, -4.0));
	block.var[3][1][1][0] = (vec3(3.0, 5.0, -9.0));
	block.var[3][1][1][1] = (vec3(8.0, -7.0, 7.0));
	block.var[3][1][1][2] = (vec3(-3.0, 4.0, -6.0));
	block.var[3][1][2][0] = (vec3(3.0, 6.0, -9.0));
	block.var[3][1][2][1] = (vec3(9.0, 3.0, 8.0));
	block.var[3][1][2][2] = (vec3(8.0, -2.0, 3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_mat4(block.var[0][0][0], mat4(6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(-2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(-2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(-3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(-9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-8.0, 9.0, 1.0, 3.0, -9.0, 9.0, -2.0, -7.0, 2.0, 9.0, -7.0, -5.0, 5.0, 7.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(-4.0, -8.0, -3.0, -3.0, 0.0, 3.0, 9.0, 7.0, 2.0, 4.0, 6.0, -9.0, 8.0, 8.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(-1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(-9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-2.0, 1.0, -4.0, 8.0, -8.0, -5.0, -7.0, 8.0, -9.0, 4.0, 3.0, 2.0, 9.0, -3.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(-4.0, 9.0, 3.0, -5.0, -7.0, 0.0, 3.0, -3.0, 6.0, -9.0, 9.0, 9.0, 8.0, 9.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(7.0, -7.0, -6.0, 0.0, -3.0, -2.0, 5.0, 2.0, -1.0, 0.0, -8.0, 1.0, -4.0, -7.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0][0][0] = (vec4(-6.0, 8.0, 7.0, -8.0));
	block.var[0][0][0][1] = (vec4(6.0, 1.0, -6.0, 6.0));
	block.var[0][0][0][2] = (vec4(0.0, -6.0, 3.0, 3.0));
	block.var[0][0][0][3] = (vec4(3.0, -3.0, 2.0, -8.0));
	block.var[0][0][1][0] = (vec4(9.0, -6.0, 6.0, 1.0));
	block.var[0][0][1][1] = (vec4(9.0, -7.0, 4.0, -5.0));
	block.var[0][0][1][2] = (vec4(5.0, -6.0, 5.0, 7.0));
	block.var[0][0][1][3] = (vec4(7.0, -5.0, -9.0, 7.0));
	block.var[0][0][2][0] = (vec4(-2.0, -1.0, -4.0, -3.0));
	block.var[0][0][2][1] = (vec4(3.0, -8.0, 7.0, -8.0));
	block.var[0][0][2][2] = (vec4(-5.0, -9.0, -1.0, 0.0));
	block.var[0][0][2][3] = (vec4(-7.0, 7.0, 8.0, -6.0));
	block.var[0][1][0][0] = (vec4(-9.0, 9.0, 7.0, -9.0));
	block.var[0][1][0][1] = (vec4(5.0, 1.0, -4.0, -1.0));
	block.var[0][1][0][2] = (vec4(-2.0, 1.0, 5.0, -1.0));
	block.var[0][1][0][3] = (vec4(-5.0, 7.0, -6.0, 1.0));
	block.var[0][1][1][0] = (vec4(0.0, 9.0, -3.0, 7.0));
	block.var[0][1][1][1] = (vec4(0.0, -6.0, -7.0, -8.0));
	block.var[0][1][1][2] = (vec4(1.0, -2.0, 9.0, 0.0));
	block.var[0][1][1][3] = (vec4(-2.0, 6.0, -1.0, -5.0));
	block.var[0][1][2][0] = (vec4(-1.0, -3.0, 5.0, -7.0));
	block.var[0][1][2][1] = (vec4(4.0, 5.0, -9.0, -1.0));
	block.var[0][1][2][2] = (vec4(0.0, 8.0, 8.0, -3.0));
	block.var[0][1][2][3] = (vec4(4.0, -4.0, -4.0, 5.0));
	block.var[1][0][0][0] = (vec4(-6.0, -1.0, 6.0, 3.0));
	block.var[1][0][0][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	block.var[1][0][0][2] = (vec4(-1.0, 3.0, -5.0, 4.0));
	block.var[1][0][0][3] = (vec4(-4.0, 3.0, 4.0, -4.0));
	block.var[1][0][1][0] = (vec4(-8.0, 4.0, 5.0, -5.0));
	block.var[1][0][1][1] = (vec4(0.0, -3.0, -4.0, 5.0));
	block.var[1][0][1][2] = (vec4(-4.0, -7.0, 4.0, -3.0));
	block.var[1][0][1][3] = (vec4(9.0, 3.0, -4.0, -3.0));
	block.var[1][0][2][0] = (vec4(-9.0, 6.0, -3.0, -6.0));
	block.var[1][0][2][1] = (vec4(-1.0, 8.0, 3.0, -2.0));
	block.var[1][0][2][2] = (vec4(9.0, -2.0, -3.0, -8.0));
	block.var[1][0][2][3] = (vec4(3.0, -8.0, 5.0, 7.0));
	block.var[1][1][0][0] = (vec4(8.0, -8.0, -1.0, -7.0));
	block.var[1][1][0][1] = (vec4(8.0, 4.0, -1.0, -1.0));
	block.var[1][1][0][2] = (vec4(-9.0, 3.0, 2.0, 4.0));
	block.var[1][1][0][3] = (vec4(-2.0, 7.0, 5.0, 0.0));
	block.var[1][1][1][0] = (vec4(-5.0, 2.0, 2.0, 4.0));
	block.var[1][1][1][1] = (vec4(4.0, -9.0, 3.0, 1.0));
	block.var[1][1][1][2] = (vec4(0.0, 5.0, -8.0, -3.0));
	block.var[1][1][1][3] = (vec4(-3.0, 3.0, -6.0, -5.0));
	block.var[1][1][2][0] = (vec4(9.0, 0.0, -6.0, -2.0));
	block.var[1][1][2][1] = (vec4(-4.0, 3.0, 1.0, 4.0));
	block.var[1][1][2][2] = (vec4(1.0, -3.0, 6.0, -2.0));
	block.var[1][1][2][3] = (vec4(-7.0, -7.0, 9.0, -2.0));
	block.var[2][0][0][0] = (vec4(-2.0, -7.0, 3.0, 8.0));
	block.var[2][0][0][1] = (vec4(-7.0, -6.0, 4.0, -4.0));
	block.var[2][0][0][2] = (vec4(6.0, -2.0, -7.0, 7.0));
	block.var[2][0][0][3] = (vec4(8.0, -8.0, -2.0, -8.0));
	block.var[2][0][1][0] = (vec4(3.0, 9.0, 3.0, 1.0));
	block.var[2][0][1][1] = (vec4(-3.0, -5.0, -8.0, -7.0));
	block.var[2][0][1][2] = (vec4(5.0, -1.0, -6.0, 8.0));
	block.var[2][0][1][3] = (vec4(-8.0, 4.0, 8.0, 6.0));
	block.var[2][0][2][0] = (vec4(-5.0, 4.0, -3.0, -1.0));
	block.var[2][0][2][1] = (vec4(-8.0, 3.0, 5.0, 0.0));
	block.var[2][0][2][2] = (vec4(7.0, 6.0, -4.0, 1.0));
	block.var[2][0][2][3] = (vec4(4.0, 3.0, 6.0, -3.0));
	block.var[2][1][0][0] = (vec4(-6.0, -2.0, -5.0, -9.0));
	block.var[2][1][0][1] = (vec4(4.0, 4.0, -5.0, -1.0));
	block.var[2][1][0][2] = (vec4(-1.0, 0.0, -7.0, 5.0));
	block.var[2][1][0][3] = (vec4(7.0, -3.0, -7.0, 9.0));
	block.var[2][1][1][0] = (vec4(-7.0, 5.0, 1.0, -7.0));
	block.var[2][1][1][1] = (vec4(4.0, 8.0, -9.0, 6.0));
	block.var[2][1][1][2] = (vec4(2.0, -8.0, 8.0, 3.0));
	block.var[2][1][1][3] = (vec4(6.0, 9.0, 6.0, -4.0));
	block.var[2][1][2][0] = (vec4(-8.0, -1.0, 1.0, 0.0));
	block.var[2][1][2][1] = (vec4(5.0, 8.0, 6.0, 3.0));
	block.var[2][1][2][2] = (vec4(8.0, -7.0, -1.0, 2.0));
	block.var[2][1][2][3] = (vec4(3.0, 7.0, 3.0, -2.0));
	block.var[3][0][0][0] = (vec4(-8.0, -6.0, 5.0, -9.0));
	block.var[3][0][0][1] = (vec4(-3.0, 0.0, -1.0, -5.0));
	block.var[3][0][0][2] = (vec4(9.0, -8.0, -9.0, -1.0));
	block.var[3][0][0][3] = (vec4(2.0, 5.0, 6.0, 2.0));
	block.var[3][0][1][0] = (vec4(3.0, 8.0, 8.0, -7.0));
	block.var[3][0][1][1] = (vec4(-1.0, 5.0, -3.0, 5.0));
	block.var[3][0][1][2] = (vec4(-3.0, -4.0, 6.0, -6.0));
	block.var[3][0][1][3] = (vec4(-5.0, 7.0, -6.0, 7.0));
	block.var[3][0][2][0] = (vec4(-3.0, -8.0, 1.0, 1.0));
	block.var[3][0][2][1] = (vec4(2.0, 3.0, 1.0, 5.0));
	block.var[3][0][2][2] = (vec4(-2.0, 2.0, -2.0, -9.0));
	block.var[3][0][2][3] = (vec4(-1.0, 2.0, -1.0, 8.0));
	block.var[3][1][0][0] = (vec4(-1.0, 0.0, -2.0, 7.0));
	block.var[3][1][0][1] = (vec4(-6.0, 5.0, 5.0, -9.0));
	block.var[3][1][0][2] = (vec4(-8.0, -5.0, 0.0, -2.0));
	block.var[3][1][0][3] = (vec4(3.0, 8.0, 4.0, -2.0));
	block.var[3][1][1][0] = (vec4(-3.0, -9.0, 9.0, -6.0));
	block.var[3][1][1][1] = (vec4(-1.0, -3.0, 3.0, -7.0));
	block.var[3][1][1][2] = (vec4(5.0, -6.0, 8.0, 0.0));
	block.var[3][1][1][3] = (vec4(-5.0, 0.0, 4.0, -2.0));
	block.var[3][1][2][0] = (vec4(-9.0, -1.0, -2.0, 2.0));
	block.var[3][1][2][1] = (vec4(-4.0, -6.0, -5.0, 4.0));
	block.var[3][1][2][2] = (vec4(-4.0, 7.0, 2.0, 3.0));
	block.var[3][1][2][3] = (vec4(2.0, -2.0, -5.0, -9.0));
}
#version 450
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
	bvec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((block.var[0][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][1][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[0][1][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[0][2][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[0][2][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[0][3][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][3][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1][0][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][0][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1][2][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[1][2][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][3][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[1][3][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[2][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2][0][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[2][1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2][1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2][2][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[2][2][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[2][3][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[2][3][1]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (bvec2(true, false));
	block.var[0][0][1] = (bvec2(true, true));
	block.var[0][1][0] = (bvec2(false, false));
	block.var[0][1][1] = (bvec2(false, true));
	block.var[0][2][0] = (bvec2(false, true));
	block.var[0][2][1] = (bvec2(true, true));
	block.var[0][3][0] = (bvec2(true, false));
	block.var[0][3][1] = (bvec2(true, false));
	block.var[1][0][0] = (bvec2(false, false));
	block.var[1][0][1] = (bvec2(false, false));
	block.var[1][1][0] = (bvec2(true, true));
	block.var[1][1][1] = (bvec2(false, false));
	block.var[1][2][0] = (bvec2(false, false));
	block.var[1][2][1] = (bvec2(true, true));
	block.var[1][3][0] = (bvec2(true, false));
	block.var[1][3][1] = (bvec2(false, false));
	block.var[2][0][0] = (bvec2(false, true));
	block.var[2][0][1] = (bvec2(true, true));
	block.var[2][1][0] = (bvec2(true, false));
	block.var[2][1][1] = (bvec2(true, false));
	block.var[2][2][0] = (bvec2(true, false));
	block.var[2][2][1] = (bvec2(false, false));
	block.var[2][3][0] = (bvec2(false, false));
	block.var[2][3][1] = (bvec2(false, true));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(4.0, 9.0, 6.0, -4.0, -3.0, 3.0, -3.0, 5.0, -3.0, 6.0, -9.0, 2.0, 5.0, 7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(-5.0, -3.0, 7.0, -5.0, -5.0, -7.0, -9.0, 5.0, 3.0, -1.0, 9.0, -3.0, 4.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(-9.0, 0.0, -3.0, -3.0, -4.0, -6.0, -9.0, 9.0, 8.0, 6.0, 3.0, -2.0, 1.0, 5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(5.0, -4.0, -6.0, -5.0, 7.0, -3.0, 5.0, -5.0, -8.0, 2.0, -5.0, 8.0, 2.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(-6.0, -7.0, -9.0, 4.0, 6.0, -4.0, 2.0, -1.0, 9.0, 3.0, -3.0, 3.0, -6.0, 5.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(-8.0, -6.0, 5.0, 0.0, -1.0, -7.0, 4.0, 2.0, -1.0, -9.0, 6.0, 4.0, -9.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(6.0, -2.0, 6.0, -6.0, 6.0, 4.0, 7.0, 9.0, -7.0, -3.0, -4.0, 9.0, 5.0, -8.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(-8.0, 1.0, 4.0, -5.0, 3.0, 6.0, -6.0, 7.0, -1.0, -4.0, 7.0, 1.0, -6.0, 5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(-3.0, 8.0, -5.0, 2.0, -2.0, -2.0, 9.0, 4.0, 0.0, 3.0, -5.0, 4.0, 0.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(7.0, -4.0, 0.0, -2.0, -9.0, -9.0, 0.0, -9.0, 7.0, 9.0, -9.0, -9.0, -8.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(8.0, 6.0, 6.0, 7.0, 8.0, 4.0, 5.0, 0.0, 6.0, -6.0, 6.0, 7.0, 9.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(4.0, -6.0, -6.0, -8.0, 9.0, 3.0, 8.0, -6.0, -4.0, -5.0, -7.0, -4.0, -7.0, -4.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	block.var[0][0][1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	block.var[0][1][0] = (mat4(4.0, -8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0));
	block.var[0][1][1] = (mat4(-9.0, -2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0));
	block.var[0][2][0] = (mat4(5.0, 4.0, 4.0, 1.0, 7.0, -5.0, 1.0, 7.0, 8.0, 8.0, 5.0, 4.0, 9.0, -4.0, 9.0, 7.0));
	block.var[0][2][1] = (mat4(8.0, 7.0, -8.0, 1.0, -7.0, 7.0, 0.0, -2.0, 1.0, -8.0, -2.0, 8.0, -8.0, 9.0, -6.0, -1.0));
	block.var[0][3][0] = (mat4(4.0, 2.0, -9.0, 1.0, 5.0, -7.0, -4.0, -2.0, -7.0, -5.0, 1.0, -6.0, -8.0, 6.0, -2.0, 4.0));
	block.var[0][3][1] = (mat4(-4.0, 2.0, -7.0, -3.0, -2.0, 4.0, -5.0, 8.0, -3.0, 2.0, -8.0, -9.0, 0.0, 8.0, 5.0, -5.0));
	block.var[1][0][0] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
	block.var[1][0][1] = (mat4(-1.0, 9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0));
	block.var[1][1][0] = (mat4(5.0, -2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0));
	block.var[1][1][1] = (mat4(-2.0, -6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0));
	block.var[1][2][0] = (mat4(-3.0, -5.0, -4.0, -7.0, -9.0, -6.0, -8.0, 6.0, -1.0, 8.0, 0.0, -8.0, -4.0, 4.0, 8.0, -5.0));
	block.var[1][2][1] = (mat4(-4.0, -9.0, 6.0, 9.0, -4.0, -2.0, -8.0, -8.0, 4.0, 7.0, 3.0, 6.0, -4.0, -3.0, -4.0, 6.0));
	block.var[1][3][0] = (mat4(-1.0, -9.0, -7.0, 0.0, -9.0, -9.0, 7.0, -8.0, -5.0, -2.0, -2.0, -8.0, 5.0, 1.0, 7.0, -6.0));
	block.var[1][3][1] = (mat4(-8.0, -1.0, 9.0, 1.0, -8.0, -1.0, -6.0, 2.0, -8.0, -8.0, -9.0, -1.0, -8.0, 1.0, -1.0, 0.0));
	block.var[2][0][0] = (mat4(5.0, 6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0));
	block.var[2][0][1] = (mat4(7.0, -1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0));
	block.var[2][1][0] = (mat4(-9.0, -3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0));
	block.var[2][1][1] = (mat4(6.0, 9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0));
	block.var[2][2][0] = (mat4(7.0, 4.0, 4.0, 3.0, -8.0, -4.0, -4.0, 7.0, -3.0, -4.0, 4.0, -6.0, 2.0, 8.0, 4.0, -7.0));
	block.var[2][2][1] = (mat4(1.0, 1.0, 6.0, 3.0, 8.0, 2.0, -7.0, 7.0, 9.0, -8.0, 9.0, 0.0, 8.0, 4.0, 8.0, 2.0));
	block.var[2][3][0] = (mat4(4.0, 8.0, 5.0, 7.0, -8.0, -2.0, 3.0, -9.0, 5.0, -1.0, -6.0, -3.0, -9.0, 9.0, -8.0, 9.0));
	block.var[2][3][1] = (mat4(2.0, 0.0, 2.0, 2.0, 9.0, -4.0, -4.0, 8.0, -8.0, -2.0, -7.0, 4.0, -1.0, 2.0, -6.0, 1.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	bvec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((block.var[0][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][1][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[0][1][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[0][2][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[0][2][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[0][3][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][3][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1][0][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][0][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1][2][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[1][2][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][3][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[1][3][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[2][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2][0][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[2][1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2][1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2][2][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[2][2][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[2][3][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[2][3][1]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (bvec2(true, false));
	block.var[0][0][1] = (bvec2(true, true));
	block.var[0][1][0] = (bvec2(false, false));
	block.var[0][1][1] = (bvec2(false, true));
	block.var[0][2][0] = (bvec2(false, true));
	block.var[0][2][1] = (bvec2(true, true));
	block.var[0][3][0] = (bvec2(true, false));
	block.var[0][3][1] = (bvec2(true, false));
	block.var[1][0][0] = (bvec2(false, false));
	block.var[1][0][1] = (bvec2(false, false));
	block.var[1][1][0] = (bvec2(true, true));
	block.var[1][1][1] = (bvec2(false, false));
	block.var[1][2][0] = (bvec2(false, false));
	block.var[1][2][1] = (bvec2(true, true));
	block.var[1][3][0] = (bvec2(true, false));
	block.var[1][3][1] = (bvec2(false, false));
	block.var[2][0][0] = (bvec2(false, true));
	block.var[2][0][1] = (bvec2(true, true));
	block.var[2][1][0] = (bvec2(true, false));
	block.var[2][1][1] = (bvec2(true, false));
	block.var[2][2][0] = (bvec2(true, false));
	block.var[2][2][1] = (bvec2(false, false));
	block.var[2][3][0] = (bvec2(false, false));
	block.var[2][3][1] = (bvec2(false, true));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-9.0, -5.0, -9.0, 1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-7.0, -4.0, 0.0, 2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(-1.0, 1.0, 9.0, 7.0, 0.0, 9.0, -1.0, -1.0, -7.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(5.0, 7.0, -6.0, -7.0, 6.0, -5.0, -4.0, -1.0, 8.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(6.0, -3.0, 0.0, -6.0, -3.0, -6.0, 8.0, 4.0, 2.0, 4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(-1.0, -7.0, 6.0, -3.0, -8.0, -4.0, 6.0, 4.0, 6.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-4.0, -7.0, 7.0, -5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-7.0, 4.0, 9.0, 8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(0.0, -9.0, -1.0, 9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(-2.0, -5.0, -2.0, -2.0, 9.0, 9.0, -6.0, 0.0, -5.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(8.0, -9.0, 6.0, -7.0, 6.0, 5.0, -5.0, -1.0, 5.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(2.0, -8.0, 4.0, 7.0, -9.0, -4.0, 2.0, -4.0, -9.0, 4.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(-7.0, -3.0, 9.0, -6.0, 0.0, -2.0, -4.0, 8.0, 3.0, -4.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(3.0, -3.0, 0.0, 8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(6.0, 2.0, -1.0, -6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(5.0, -5.0, -1.0, -9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-3.0, 1.0, 7.0, -9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(8.0, 3.0, -1.0, 2.0, 5.0, -8.0, 0.0, -6.0, 4.0, 6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(8.0, 4.0, -1.0, -5.0, 0.0, -6.0, 3.0, 7.0, -8.0, -4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(-5.0, -4.0, -7.0, 2.0, -5.0, -5.0, 2.0, 4.0, -5.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(2.0, 3.0, -9.0, -6.0, -1.0, -7.0, 8.0, -6.0, 1.0, 7.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	block.var[0][0][1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	block.var[0][1][0] = (mat4x3(-8.0, -3.0, -8.0, -5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0));
	block.var[0][1][1] = (mat4x3(8.0, -8.0, -9.0, 9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0));
	block.var[0][2][0] = (mat4x3(4.0, 9.0, 7.0, 5.0, 7.0, -2.0, -4.0, -2.0, 3.0, -6.0, 0.0, -7.0));
	block.var[0][2][1] = (mat4x3(9.0, -6.0, -9.0, 5.0, -1.0, -2.0, 4.0, 7.0, 2.0, 8.0, -7.0, 9.0));
	block.var[0][3][0] = (mat4x3(5.0, -9.0, 3.0, -6.0, -1.0, 2.0, 6.0, -2.0, 0.0, 5.0, -5.0, -5.0));
	block.var[0][3][1] = (mat4x3(-3.0, -7.0, -1.0, -5.0, 2.0, -7.0, 9.0, 1.0, 1.0, -5.0, 8.0, -6.0));
	block.var[1][0][0] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
	block.var[1][0][1] = (mat4x3(9.0, -7.0, -4.0, -3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0));
	block.var[1][1][0] = (mat4x3(-8.0, 9.0, 8.0, -9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0));
	block.var[1][1][1] = (mat4x3(8.0, -3.0, -6.0, 2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0));
	block.var[1][2][0] = (mat4x3(7.0, 3.0, 4.0, 9.0, 8.0, -1.0, -6.0, -4.0, 5.0, -8.0, -4.0, 1.0));
	block.var[1][2][1] = (mat4x3(-1.0, 6.0, 7.0, -9.0, 0.0, 8.0, -4.0, 2.0, 0.0, 3.0, -3.0, 1.0));
	block.var[1][3][0] = (mat4x3(-7.0, -1.0, 4.0, 4.0, -4.0, -4.0, -1.0, -2.0, 0.0, -3.0, 8.0, 7.0));
	block.var[1][3][1] = (mat4x3(-8.0, -4.0, -4.0, 2.0, 3.0, -9.0, 2.0, -1.0, -4.0, 3.0, 5.0, 1.0));
	block.var[2][0][0] = (mat4x3(9.0, 0.0, 0.0, 7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0));
	block.var[2][0][1] = (mat4x3(-4.0, 1.0, 3.0, -5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0));
	block.var[2][1][0] = (mat4x3(1.0, -6.0, -5.0, -5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0));
	block.var[2][1][1] = (mat4x3(-4.0, 8.0, 5.0, -4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0));
	block.var[2][2][0] = (mat4x3(7.0, 7.0, -6.0, 0.0, 1.0, 7.0, 2.0, 8.0, -2.0, -5.0, 8.0, 3.0));
	block.var[2][2][1] = (mat4x3(-1.0, -5.0, -8.0, 1.0, 4.0, 0.0, 2.0, -3.0, 8.0, -5.0, -9.0, 4.0));
	block.var[2][3][0] = (mat4x3(1.0, -2.0, 8.0, -8.0, -5.0, -8.0, -8.0, -7.0, 7.0, -9.0, 8.0, -2.0));
	block.var[2][3][1] = (mat4x3(-7.0, -4.0, 2.0, 2.0, 5.0, 7.0, -5.0, 5.0, 2.0, -2.0, 9.0, -6.0));
}
#version 450
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
	allOk = compare_ivec3((block.s.a), ivec3(-4, -5, 3)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(-2.0, -7.0, 6.0, -3.0, 7.0, 5.0, -8.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(2.0, -7.0, -2.0, -2.0, -2.0, 1.0, -4.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(-8.0, -8.0, -3.0, 0.0, -4.0, 9.0, 1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(-9.0, 3.0, -7.0, -4.0, -4.0, -1.0, 6.0, -1.0, -3.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(-4.0, -8.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(-8, -9, 6));
	block.s.b[0][0] = (vec3(-6.0, -2.0, 4.0));
	block.s.b[0][1] = (vec3(-5.0, -9.0, -7.0));
	block.s.b[0][2] = (vec3(-1.0, 2.0, 2.0));
	block.s.b[1][0] = (vec3(-5.0, 0.0, -7.0));
	block.s.b[1][1] = (vec3(9.0, 9.0, -1.0));
	block.s.b[1][2] = (vec3(-4.0, 4.0, -4.0));
	block.s.b[2][0] = (vec3(9.0, 8.0, 0.0));
	block.s.b[2][1] = (vec3(-8.0, -7.0, -1.0));
	block.s.b[2][2] = (vec3(-1.0, -7.0, -3.0));
	block.s.b[3][0] = (vec3(6.0, -5.0, 4.0));
	block.s.b[3][1] = (vec3(-9.0, 3.0, -6.0));
	block.s.b[3][2] = (vec3(1.0, -5.0, 9.0));
	block.s.c = (vec4(1.0, 4.0, -5.0, -1.0));
}
#version 450
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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(6u, 2u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(1.0, 8.0, -5.0, -3.0, 1.0, -6.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(2.0, -1.0, 5.0, -5.0, 5.0, -9.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(7.0, -7.0, -4.0, -3.0, 2.0, -1.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(-8.0, 2.0, -4.0, 7.0, 3.0, -2.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(-8.0, 9.0, 0.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(0u, 4u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(1.0, 3.0, -6.0, -6.0, 2.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(-8.0, -4.0, 5.0, 1.0, -2.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(4.0, 6.0, 1.0, 7.0, 0.0, -5.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(9.0, -2.0, 4.0, 9.0, 2.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(0.0, -3.0, -2.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(5u, 2u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(-9.0, -3.0, 7.0, 1.0, 9.0, 8.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(5.0, -4.0, -9.0, -2.0, 8.0, 9.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(-5.0, 4.0, -8.0, -8.0, 0.0, -2.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(-2.0, 1.0, 7.0, 6.0, 3.0, -9.0, -4.0, 9.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(2.0, 0.0, 9.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(9u, 4u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(1.0, 3.0, -8.0, -8.0, -4.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(2.0, 0.0, -4.0, -6.0, 1.0, 2.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(0.0, -4.0, 8.0, 0.0, -9.0, -4.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(5.0, 1.0, -5.0, -8.0, 8.0, -6.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(3.0, -1.0, -1.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(4u, 0u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(5.0, 9.0, 9.0, 0.0, 0.0, -5.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(-6.0, 0.0, -1.0, -1.0, 3.0, 2.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(-2.0, 7.0, -4.0, -7.0, 4.0, 2.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(5.0, 2.0, -8.0, -4.0, -9.0, 0.0, 2.0, -6.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(-4.0, 5.0, -8.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(9u, 2u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(6.0, 8.0, -3.0, 4.0, -8.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(4.0, 6.0, -2.0, 8.0, -8.0, 2.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(-6.0, -2.0, 1.0, 3.0, 7.0, -9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(-5.0, 2.0, 1.0, 7.0, -9.0, -8.0, -4.0, -5.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(1.0, 8.0, 3.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(1u, 2u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(-8.0, -5.0, 6.0, -5.0, 0.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(-6.0, 4.0, 1.0, -8.0, 2.0, -5.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(-6.0, -3.0, 6.0, 8.0, -6.0, -6.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(3.0, 4.0, -2.0, 7.0, 2.0, 1.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(-7.0, 3.0, 7.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(6u, 9u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(3.0, 6.0, 9.0, 0.0, -3.0, 0.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(8.0, 1.0, 4.0, -9.0, -1.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(8.0, -5.0, -4.0, 4.0, 9.0, -8.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(5.0, -2.0, 4.0, -5.0, 2.0, -7.0, -4.0, 2.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(-7.0, 6.0, -8.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(5u, 5u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(-7.0, 4.0, -9.0, -6.0, -6.0, -3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(3.0, 0.0, -4.0, 6.0, -5.0, -7.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(-8.0, -7.0, -3.0, 5.0, 4.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(-8.0, -6.0, -8.0, -8.0, -4.0, -9.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(2.0, -3.0, 5.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(7u, 2u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(1.0, 0.0, 0.0, -6.0, 6.0, -5.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(5.0, 1.0, 4.0, -7.0, -3.0, 8.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(-9.0, -3.0, -6.0, 1.0, 2.0, 5.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(-2.0, -5.0, -7.0, 7.0, -1.0, 2.0, -5.0, -7.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(-1.0, 3.0, 1.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(4u, 1u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(-1.0, 5.0, -1.0, 1.0, 1.0, 4.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(5.0, -9.0, -9.0, -7.0, -3.0, 8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(-5.0, -9.0, 3.0, 4.0, -5.0, 2.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(0.0, 3.0, -4.0, 2.0, 0.0, 2.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(5.0, 5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (1u);
	block[0].s[0].a = (uvec2(4u, 2u));
	block[0].s[0].b[0][0] = (vec4(9.0, 4.0, -9.0, 3.0));
	block[0].s[0].b[0][1] = (vec4(9.0, 4.0, 0.0, 2.0));
	block[0].s[0].b[1][0] = (vec4(-1.0, -8.0, 5.0, 4.0));
	block[0].s[0].b[1][1] = (vec4(0.0, 4.0, 7.0, -7.0));
	block[0].s[0].b[2][0] = (vec4(-9.0, 8.0, -3.0, 3.0));
	block[0].s[0].b[2][1] = (vec4(-3.0, -8.0, 5.0, -8.0));
	block[0].s[0].b[3][0] = (vec4(7.0, -5.0, 8.0, -3.0));
	block[0].s[0].b[3][1] = (vec4(9.0, -9.0, -7.0, 3.0));
	block[0].s[0].c = (vec3(-6.0, -7.0, -2.0));
	block[0].s[1].a = (uvec2(8u, 4u));
	block[0].s[1].b[0][0] = (vec4(5.0, 7.0, 3.0, 6.0));
	block[0].s[1].b[0][1] = (vec4(3.0, 5.0, 3.0, -4.0));
	block[0].s[1].b[1][0] = (vec4(1.0, -3.0, -4.0, -6.0));
	block[0].s[1].b[1][1] = (vec4(3.0, 2.0, -2.0, 6.0));
	block[0].s[1].b[2][0] = (vec4(6.0, 8.0, 5.0, -2.0));
	block[0].s[1].b[2][1] = (vec4(3.0, -9.0, 0.0, 8.0));
	block[0].s[1].b[3][0] = (vec4(2.0, -8.0, -4.0, 4.0));
	block[0].s[1].b[3][1] = (vec4(1.0, 5.0, -6.0, -6.0));
	block[0].s[1].c = (vec3(4.0, 8.0, -2.0));
	block[0].s[2].a = (uvec2(9u, 8u));
	block[0].s[2].b[0][0] = (vec4(-4.0, -4.0, -6.0, -1.0));
	block[0].s[2].b[0][1] = (vec4(7.0, 7.0, -8.0, -6.0));
	block[0].s[2].b[1][0] = (vec4(-2.0, 3.0, -3.0, 8.0));
	block[0].s[2].b[1][1] = (vec4(2.0, -9.0, 9.0, 0.0));
	block[0].s[2].b[2][0] = (vec4(4.0, -9.0, -3.0, 6.0));
	block[0].s[2].b[2][1] = (vec4(-6.0, -9.0, 5.0, 4.0));
	block[0].s[2].b[3][0] = (vec4(-4.0, -2.0, -8.0, -9.0));
	block[0].s[2].b[3][1] = (vec4(5.0, 5.0, 1.0, 8.0));
	block[0].s[2].c = (vec3(5.0, 0.0, 9.0));
	block[0].s[3].a = (uvec2(4u, 9u));
	block[0].s[3].b[0][0] = (vec4(3.0, 7.0, 1.0, 0.0));
	block[0].s[3].b[0][1] = (vec4(6.0, -4.0, 3.0, 7.0));
	block[0].s[3].b[1][0] = (vec4(4.0, 2.0, 8.0, -7.0));
	block[0].s[3].b[1][1] = (vec4(-5.0, -7.0, 9.0, 8.0));
	block[0].s[3].b[2][0] = (vec4(2.0, -5.0, 1.0, 8.0));
	block[0].s[3].b[2][1] = (vec4(-1.0, -5.0, 5.0, -5.0));
	block[0].s[3].b[3][0] = (vec4(7.0, 8.0, -4.0, 0.0));
	block[0].s[3].b[3][1] = (vec4(2.0, 1.0, 6.0, 5.0));
	block[0].s[3].c = (vec3(1.0, -5.0, -9.0));
	block[1].v = (9u);
	block[1].s[0].a = (uvec2(0u, 4u));
	block[1].s[0].b[0][0] = (vec4(-1.0, -9.0, 3.0, -8.0));
	block[1].s[0].b[0][1] = (vec4(7.0, 2.0, -4.0, 5.0));
	block[1].s[0].b[1][0] = (vec4(1.0, 7.0, -8.0, -4.0));
	block[1].s[0].b[1][1] = (vec4(-8.0, -7.0, -5.0, -6.0));
	block[1].s[0].b[2][0] = (vec4(5.0, -1.0, -9.0, 3.0));
	block[1].s[0].b[2][1] = (vec4(-5.0, -2.0, -5.0, -4.0));
	block[1].s[0].b[3][0] = (vec4(3.0, 3.0, 7.0, 5.0));
	block[1].s[0].b[3][1] = (vec4(1.0, 5.0, -9.0, 6.0));
	block[1].s[0].c = (vec3(4.0, 9.0, 3.0));
	block[1].s[1].a = (uvec2(0u, 3u));
	block[1].s[1].b[0][0] = (vec4(0.0, -3.0, -5.0, 5.0));
	block[1].s[1].b[0][1] = (vec4(-5.0, 7.0, -7.0, 9.0));
	block[1].s[1].b[1][0] = (vec4(-9.0, 1.0, -9.0, 9.0));
	block[1].s[1].b[1][1] = (vec4(7.0, 6.0, -2.0, -1.0));
	block[1].s[1].b[2][0] = (vec4(-4.0, 1.0, 3.0, -5.0));
	block[1].s[1].b[2][1] = (vec4(4.0, -5.0, -4.0, 6.0));
	block[1].s[1].b[3][0] = (vec4(9.0, -6.0, -6.0, -8.0));
	block[1].s[1].b[3][1] = (vec4(3.0, 8.0, 0.0, -2.0));
	block[1].s[1].c = (vec3(4.0, -3.0, 0.0));
	block[1].s[2].a = (uvec2(4u, 2u));
	block[1].s[2].b[0][0] = (vec4(-1.0, 3.0, 7.0, 7.0));
	block[1].s[2].b[0][1] = (vec4(-4.0, -4.0, 0.0, -9.0));
	block[1].s[2].b[1][0] = (vec4(5.0, 3.0, -9.0, 5.0));
	block[1].s[2].b[1][1] = (vec4(-8.0, -2.0, -7.0, -9.0));
	block[1].s[2].b[2][0] = (vec4(6.0, 6.0, 0.0, 6.0));
	block[1].s[2].b[2][1] = (vec4(2.0, 4.0, -4.0, -5.0));
	block[1].s[2].b[3][0] = (vec4(4.0, -9.0, -1.0, -9.0));
	block[1].s[2].b[3][1] = (vec4(3.0, 8.0, 9.0, 1.0));
	block[1].s[2].c = (vec3(8.0, 3.0, 8.0));
	block[1].s[3].a = (uvec2(5u, 6u));
	block[1].s[3].b[0][0] = (vec4(-7.0, 9.0, -4.0, 5.0));
	block[1].s[3].b[0][1] = (vec4(-6.0, -6.0, -5.0, -6.0));
	block[1].s[3].b[1][0] = (vec4(6.0, 7.0, -6.0, -9.0));
	block[1].s[3].b[1][1] = (vec4(9.0, -1.0, 5.0, -4.0));
	block[1].s[3].b[2][0] = (vec4(-5.0, 3.0, 3.0, -4.0));
	block[1].s[3].b[2][1] = (vec4(-7.0, 1.0, 0.0, -4.0));
	block[1].s[3].b[3][0] = (vec4(0.0, 8.0, -6.0, 9.0));
	block[1].s[3].b[3][1] = (vec4(-4.0, 0.0, 8.0, 8.0));
	block[1].s[3].c = (vec3(-8.0, -7.0, 9.0));
	block[2].v = (6u);
	block[2].s[0].a = (uvec2(3u, 4u));
	block[2].s[0].b[0][0] = (vec4(9.0, 6.0, 7.0, -1.0));
	block[2].s[0].b[0][1] = (vec4(1.0, 5.0, 7.0, -8.0));
	block[2].s[0].b[1][0] = (vec4(-7.0, -9.0, 2.0, -6.0));
	block[2].s[0].b[1][1] = (vec4(-7.0, 5.0, -5.0, 9.0));
	block[2].s[0].b[2][0] = (vec4(0.0, 6.0, 9.0, -6.0));
	block[2].s[0].b[2][1] = (vec4(-4.0, -8.0, -4.0, 4.0));
	block[2].s[0].b[3][0] = (vec4(-9.0, 3.0, -4.0, 5.0));
	block[2].s[0].b[3][1] = (vec4(-7.0, 6.0, -1.0, -2.0));
	block[2].s[0].c = (vec3(-4.0, 2.0, 6.0));
	block[2].s[1].a = (uvec2(9u, 1u));
	block[2].s[1].b[0][0] = (vec4(1.0, -7.0, -3.0, 1.0));
	block[2].s[1].b[0][1] = (vec4(8.0, 0.0, -8.0, 9.0));
	block[2].s[1].b[1][0] = (vec4(-9.0, -1.0, -2.0, 5.0));
	block[2].s[1].b[1][1] = (vec4(3.0, 8.0, 2.0, -4.0));
	block[2].s[1].b[2][0] = (vec4(8.0, 7.0, -5.0, 1.0));
	block[2].s[1].b[2][1] = (vec4(6.0, -9.0, -6.0, -1.0));
	block[2].s[1].b[3][0] = (vec4(8.0, -9.0, 8.0, -5.0));
	block[2].s[1].b[3][1] = (vec4(-6.0, -4.0, 3.0, -4.0));
	block[2].s[1].c = (vec3(-5.0, -1.0, -6.0));
	block[2].s[2].a = (uvec2(4u, 0u));
	block[2].s[2].b[0][0] = (vec4(-3.0, 7.0, -4.0, 2.0));
	block[2].s[2].b[0][1] = (vec4(5.0, -3.0, -6.0, 2.0));
	block[2].s[2].b[1][0] = (vec4(-8.0, 0.0, -4.0, -6.0));
	block[2].s[2].b[1][1] = (vec4(1.0, 3.0, -2.0, -2.0));
	block[2].s[2].b[2][0] = (vec4(-4.0, 9.0, -1.0, -7.0));
	block[2].s[2].b[2][1] = (vec4(-1.0, 5.0, 6.0, -5.0));
	block[2].s[2].b[3][0] = (vec4(7.0, -4.0, -6.0, -3.0));
	block[2].s[2].b[3][1] = (vec4(8.0, -8.0, 5.0, -9.0));
	block[2].s[2].c = (vec3(5.0, 5.0, 2.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
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
	allOk = compare_mat2(block[0].var, mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(block[1].var, mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block[2].var, mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2(1.0, 2.0, 6.0, -6.0));
	block[1].var = (mat2(2.0, 4.0, 4.0, 7.0));
	block[2].var = (mat2(0.0, 8.0, 0.0, -1.0));
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_float(block[0].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 7.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(5.0, 0.0, 3.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-5.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(8.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(2.0, 6.0, 7.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -6.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 4.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -5.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(1.0, 7.0, 3.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(4.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-7.0, -9.0, -6.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(1.0, 4.0, -5.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 7.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[3][2], 2.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(4.0, -7.0, -2.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(5.0, -7.0, 6.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(7.0, 1.0, -4.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(-7.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	block[1].var = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	block[2].var = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
}
#version 450
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
	f16vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(block[0].var), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block[1].var), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block[2].var), vec2(6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = f16vec2(vec2(-2.0, 4.0));
	block[1].var = f16vec2(vec2(-2.0, 4.0));
	block[2].var = f16vec2(vec2(-1.0, 1.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 8.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-3.0, 8.0)) && allOk;
	allOk = compare_float((block[1].padding), 2.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 2.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(3.0, 2.0)) && allOk;
	allOk = compare_float((block[2].padding), 4.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -1.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(1.0, 5.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (5.0);
	block[0].var[0] = (vec2(-4.0, 5.0));
	block[0].var[1] = (vec2(1.0, -8.0));
	block[1].padding = (-1.0);
	block[1].var[0] = (vec2(9.0, -8.0));
	block[1].var[1] = (vec2(5.0, -4.0));
	block[2].padding = (5.0);
	block[2].var[0] = (vec2(-2.0, 9.0));
	block[2].var[1] = (vec2(-9.0, -1.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block[0].padding), -6.0) && allOk;
	allOk = compare_f16vec2(vec2(block[0].var), vec2(-3.0, 1.0)) && allOk;
	allOk = compare_float16_t(float(block[1].padding), -5.0) && allOk;
	allOk = compare_f16vec2(vec2(block[1].var), vec2(6.0, 3.0)) && allOk;
	allOk = compare_float16_t(float(block[2].padding), 2.0) && allOk;
	allOk = compare_f16vec2(vec2(block[2].var), vec2(-1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = float16_t(-2.0);
	block[0].var = f16vec2(vec2(4.0, -2.0));
	block[1].padding = float16_t(4.0);
	block[1].var = f16vec2(vec2(-1.0, 1.0));
	block[2].padding = float16_t(9.0);
	block[2].var = f16vec2(vec2(4.0, 8.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(buffer_reference) buffer BlockA
{
	layout(offset = 0) highp float a;
	layout(offset = 4) lowp uvec3 b;
	layout(offset = 16) mediump mat2 c;
};
layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) mediump mat3 a;
	layout(offset = 48) lowp ivec2 b;
	layout(offset = 64) highp vec4 c;
	layout(offset = 80) bool d;
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
	allOk = compare_float((blockA.a), 3.0) && allOk;
	allOk = compare_float(blockA.c[0][0], -7.0) && allOk;
	allOk = compare_float(blockA.c[0][1], 0.0) && allOk;
	allOk = compare_float(blockA.c[1][0], 6.0) && allOk;
	allOk = compare_float(blockA.c[1][1], 8.0) && allOk;
	allOk = compare_vec2(blockA.c[0], vec2(-7.0, 0.0)) && allOk;
	allOk = compare_vec2(blockA.c[1], vec2(6.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(9, -8)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (3.0);
	blockB.a[0] = (vec3(1.0, 8.0, -9.0));
	blockB.a[1] = (vec3(-5.0, 0.0, 7.0));
	blockB.a[2] = (vec3(2.0, 0.0, 0.0));
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

layout(std430, column_major, buffer_reference) buffer BlockB
{
	mediump vec4 a[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp mat3x4 b;
	lowp uint c;
	mediump mat3x4 d;
	mediump float e;
	highp vec3 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a[0]), vec4(0.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockC.b, mat3x4(0.0, -5.0, 3.0, 3.0, -3.0, -2.0, 6.0, 3.0, 1.0, -7.0, 2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec4(5.0, -5.0, 3.0, 9.0));
	blockC.b = (mat3x4(-5.0, -1.0, -4.0, 8.0, -5.0, -9.0, -8.0, 6.0, 0.0, 2.0, -4.0, -3.0));
	blockC.c = (5u);
	blockC.d = (mat3x4(-4.0, -8.0, -1.0, 9.0, -2.0, -5.0, 1.0, -8.0, -9.0, 9.0, 7.0, -6.0));
}
#version 450
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
	highp mat3x4 a[];
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	mediump mat3x2 b[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
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

struct sA
{
	lowp int mA;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	sA a;
	bvec3 b;
	mediump vec3 c;
	highp mat3x2 d;
	mediump mat2 e[];
};
layout(std140, buffer_reference) buffer BlockC
{
	bvec4 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC[3];
};

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

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) bool a;
	layout(offset = 4) mediump int b;
	layout(offset = 16) bvec4 c;
	layout(offset = 32) bvec3 d;
	layout(offset = 48) highp uvec2 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp vec2 f;
	layout(offset = 8) bvec2 g[1];
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec2 h;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) mediump ivec3 i[1];
	layout(offset = 16) bvec3 j;
	layout(offset = 28) bool k;
	layout(offset = 32) lowp vec3 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD[3];
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_int((blockB.b), -6) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.d), bvec3(false, false, true)) && allOk;
	allOk = compare_uvec2((blockB.e), uvec2(2u, 8u)) && allOk;
	allOk = compare_bvec2((blockC[0].g[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC[1].g[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[2].g[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[0].h), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[1].h), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[2].h), bvec2(true, false)) && allOk;
	allOk = compare_bvec3((blockE[0].j), bvec3(false, false, false)) && allOk;
	allOk = compare_vec3((blockE[0].l), vec3(0.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (bvec4(true, true, false, true));
	blockB.d = (bvec3(true, true, false));
	blockB.e = (uvec2(8u, 1u));
	blockC[0].f = (vec2(5.0, -6.0));
	blockC[0].g[0] = (bvec2(false, true));
	blockC[1].f = (vec2(-9.0, 3.0));
	blockC[1].g[0] = (bvec2(true, false));
	blockC[2].f = (vec2(2.0, 7.0));
	blockC[2].g[0] = (bvec2(true, true));
	blockD[0].h = (bvec2(false, true));
	blockD[1].h = (bvec2(true, true));
	blockD[2].h = (bvec2(true, true));
	blockE[0].i[0] = (ivec3(-2, -2, -6));
	blockE[0].j = (bvec3(false, false, false));
	blockE[0].k = (true);
	blockE[0].l = (vec3(6.0, 8.0, -7.0));
}
#version 450
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
	layout(offset = 16) bvec3 b[1];
	layout(offset = 32) highp uvec3 c;
	layout(offset = 44) highp float d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp float e;
	layout(offset = 4) bvec2 f;
	layout(offset = 12) highp uint g;
	layout(offset = 16) mediump vec2 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.b[0]), bvec3(false, false, true)) && allOk;
	allOk = compare_float((blockB.d), 8.0) && allOk;
	allOk = compare_float((blockC[0].e), -9.0) && allOk;
	allOk = compare_bvec2((blockC[0].f), bvec2(false, false)) && allOk;
	allOk = compare_vec2((blockC[0].h), vec2(2.0, -1.0)) && allOk;
	allOk = compare_float((blockC[1].e), 2.0) && allOk;
	allOk = compare_bvec2((blockC[1].f), bvec2(false, false)) && allOk;
	allOk = compare_vec2((blockC[1].h), vec2(-7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(0u, 3u));
	blockB.b[0] = (bvec3(true, true, true));
	blockB.c = (uvec3(0u, 7u, 5u));
	blockC[0].e = (7.0);
	blockC[0].f = (bvec2(true, false));
	blockC[0].g = (5u);
	blockC[0].h = (vec2(-1.0, -5.0));
	blockC[1].e = (-6.0);
	blockC[1].f = (bvec2(false, true));
	blockC[1].g = (0u);
	blockC[1].h = (vec2(8.0, 8.0));
}
#version 450
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
	layout(offset = 0) mediump uvec4 a;
	layout(offset = 16) mediump uvec2 b;
	layout(offset = 32) lowp ivec4 c;
	layout(offset = 48) bvec4 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump ivec2 e;
	layout(offset = 16) bvec3 f;
	layout(offset = 32) mediump uvec2 g;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump uvec4 h;
	layout(offset = 16) mediump vec3 i;
	layout(offset = 32) lowp vec4 j;
	layout(offset = 48) bool k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(2u, 0u, 7u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(9u, 9u)) && allOk;
	allOk = compare_ivec4((blockB.c), ivec4(9, 4, 6, 2)) && allOk;
	allOk = compare_bvec4((blockB.d), bvec4(false, false, true, false)) && allOk;
	allOk = compare_ivec2((blockC[0].e), ivec2(-6, 0)) && allOk;
	allOk = compare_bvec3((blockC[0].f), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec4((blockD.h), uvec4(8u, 1u, 7u, 9u)) && allOk;
	allOk = compare_vec3((blockD.i), vec3(-4.0, 7.0, 8.0)) && allOk;
	allOk = compare_vec4((blockD.j), vec4(2.0, 3.0, 4.0, -2.0)) && allOk;
	allOk = compare_bool((blockD.k), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec2(9u, 1u));
	blockB.c = (ivec4(8, -8, 0, 4));
	blockC[0].e = (ivec2(-8, -1));
	blockC[0].f = (bvec3(false, false, false));
	blockC[0].g = (uvec2(7u, 9u));
	blockD.h = (uvec4(7u, 8u, 8u, 0u));
	blockD.i = (vec3(-1.0, 4.0, 8.0));
	blockD.j = (vec4(8.0, 7.0, -1.0, -3.0));
}
#version 450
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
	lowp uvec2 b[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	highp mat3 c;
	lowp vec3 d;
	highp mat2x3 e;
	highp uvec3 f[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	mediump mat2x3 g;
	highp uvec4 h;
	mediump vec3 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_mat3(blockC.c, mat3(-6.0, 9.0, 1.0, -8.0, 7.0, 5.0, -5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3((blockC.d), vec3(-8.0, -7.0, 7.0)) && allOk;
	allOk = compare_uvec3((blockC.f[0]), uvec3(9u, 6u, 0u)) && allOk;
	allOk = compare_uvec3((blockC.f[1]), uvec3(0u, 0u, 0u)) && allOk;
	allOk = compare_uvec3((blockC.f[2]), uvec3(4u, 2u, 0u)) && allOk;
	allOk = compare_uvec3((blockC.f[3]), uvec3(5u, 1u, 0u)) && allOk;
	allOk = compare_uvec3((blockC.f[4]), uvec3(3u, 9u, 5u)) && allOk;
	allOk = compare_mat2x3(blockD[0].g, mat2x3(-6.0, -1.0, 5.0, 1.0, -5.0, -8.0)) && allOk;
	allOk = compare_uvec4((blockD[0].h), uvec4(1u, 6u, 0u, 8u)) && allOk;
	allOk = compare_vec3((blockD[0].i[0]), vec3(-6.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec3((blockD[0].i[1]), vec3(6.0, -3.0, -3.0)) && allOk;
	allOk = compare_vec3((blockD[0].i[2]), vec3(-1.0, -1.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD[0].i[3]), vec3(6.0, 3.0, 8.0)) && allOk;
	allOk = compare_vec3((blockD[0].i[4]), vec3(-7.0, 0.0, 1.0)) && allOk;
	allOk = compare_vec3((blockD[0].i[5]), vec3(7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockD[1].g, mat2x3(-5.0, -6.0, 4.0, -9.0, -7.0, 8.0)) && allOk;
	allOk = compare_uvec4((blockD[1].h), uvec4(7u, 2u, 6u, 9u)) && allOk;
	allOk = compare_vec3((blockD[1].i[0]), vec3(7.0, 3.0, -4.0)) && allOk;
	allOk = compare_vec3((blockD[1].i[1]), vec3(-9.0, -3.0, 0.0)) && allOk;
	allOk = compare_vec3((blockD[1].i[2]), vec3(4.0, 9.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD[1].i[3]), vec3(7.0, -3.0, -7.0)) && allOk;
	allOk = compare_vec3((blockD[1].i[4]), vec3(0.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec3((blockD[1].i[5]), vec3(7.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec3((blockD[1].i[6]), vec3(7.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockB.b[0] = (uvec2(4u, 8u));
	blockB.b[1] = (uvec2(7u, 2u));
	blockB.b[2] = (uvec2(2u, 9u));
	blockB.b[3] = (uvec2(4u, 3u));
	blockC.c = (mat3(2.0, 5.0, -1.0, 9.0, -5.0, 7.0, 8.0, 8.0, -9.0));
	blockC.d = (vec3(-3.0, -1.0, 6.0));
	blockC.f[0] = (uvec3(5u, 0u, 5u));
	blockC.f[1] = (uvec3(5u, 3u, 6u));
	blockC.f[2] = (uvec3(1u, 7u, 9u));
	blockC.f[3] = (uvec3(9u, 0u, 0u));
	blockC.f[4] = (uvec3(3u, 0u, 0u));
	blockD[0].h = (uvec4(9u, 3u, 0u, 0u));
	blockD[1].h = (uvec4(9u, 7u, 7u, 1u));
}
#version 450
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
	mediump mat3x4 mB[2];
};
struct sB
{
	lowp mat2 mA;
};
struct sC
{
	highp mat4x2 mA;
	mediump uvec2 mB;
	lowp uvec3 mC;
	sB mD;
};
struct sD
{
	bvec3 mA;
	highp float mB[4];
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	mediump vec2 a[7];
	sA b;
	sC c;
	highp mat2x3 d;
	mediump vec3 e;
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	lowp vec3 f;
	lowp vec4 g;
	highp mat4x3 h;
	bvec4 i;
	lowp ivec2 j;
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	highp mat2 k;
	highp mat4x2 l;
	sD m;
	mediump mat4 n;
	lowp mat3 o[];
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB[0].b.mA, mat2(-9.0, 7.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockB[0].b.mB[0], mat3x4(-7.0, -4.0, 2.0, -4.0, 2.0, -5.0, -3.0, -4.0, 3.0, -7.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockB[0].b.mB[1], mat3x4(-3.0, 5.0, 3.0, 0.0, 3.0, 1.0, 7.0, -8.0, -9.0, -5.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec3((blockB[0].e), vec3(3.0, 3.0, 5.0)) && allOk;
	allOk = compare_vec4((blockC.g), vec4(9.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockC.j), ivec2(-2, 9)) && allOk;
	allOk = compare_mat2(blockD.k, mat2(-9.0, -3.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockD.l, mat4x2(0.0, 8.0, 1.0, 5.0, -1.0, 6.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4(blockD.n, mat4(4.0, 8.0, 8.0, 7.0, -2.0, -9.0, -5.0, 0.0, 5.0, 3.0, 8.0, 4.0, 3.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(blockD.o[0], mat3(5.0, -5.0, 4.0, -9.0, 3.0, -3.0, 9.0, -5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (vec2(-1.0, 1.0));
	blockB[0].a[1] = (vec2(-1.0, 8.0));
	blockB[0].a[2] = (vec2(9.0, -4.0));
	blockB[0].a[3] = (vec2(-2.0, 9.0));
	blockB[0].a[4] = (vec2(-9.0, 3.0));
	blockB[0].a[5] = (vec2(-8.0, -9.0));
	blockB[0].a[6] = (vec2(-4.0, -3.0));
	blockB[0].b.mA = (mat2(2.0, 4.0, 5.0, 8.0));
	blockB[0].b.mB[0] = (mat3x4(2.0, -6.0, 4.0, -5.0, -5.0, -9.0, -7.0, 7.0, -8.0, 8.0, -9.0, 1.0));
	blockB[0].b.mB[1] = (mat3x4(1.0, 7.0, 4.0, 5.0, 4.0, 8.0, -7.0, 0.0, 5.0, 7.0, -8.0, -8.0));
	blockB[0].c.mA = (mat4x2(1.0, 1.0, 2.0, -5.0, -9.0, 6.0, -9.0, 0.0));
	blockB[0].c.mB = (uvec2(2u, 5u));
	blockB[0].c.mC = (uvec3(9u, 2u, 5u));
	blockB[0].c.mD.mA = (mat2(-4.0, -3.0, -5.0, -5.0));
	blockB[0].d = (mat2x3(-2.0, -6.0, 5.0, -5.0, -9.0, -8.0));
	blockB[0].e = (vec3(2.0, -9.0, 9.0));
	blockC.h = (mat4x3(4.0, 6.0, 5.0, -4.0, -2.0, 7.0, 7.0, 0.0, -5.0, -6.0, 4.0, -1.0));
	blockC.i = (bvec4(true, true, false, false));
	blockC.j = (ivec2(-8, -4));
	blockD.l = (mat4x2(-3.0, -9.0, -3.0, 0.0, -7.0, 7.0, -6.0, 8.0));
	blockD.n = (mat4(0.0, -8.0, 0.0, -7.0, 5.0, -1.0, -7.0, 6.0, -5.0, -7.0, 3.0, -6.0, 1.0, -4.0, 1.0, -2.0));
	blockD.o[0] = (mat3(3.0, -1.0, -6.0, -8.0, -4.0, -6.0, 4.0, -5.0, 0.0));
}
#version 450
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
	i16vec3 a;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump vec2 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockB.a), ivec3(-9, 9, 2)) && allOk;
	allOk = compare_vec2((blockC.b), vec2(0.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec3(ivec3(-9, -3, 8));
	blockC.b = (vec2(0.0, -3.0));
}
#version 450
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
	u16vec4 a;
	mediump vec3 b;
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp ivec4 c[1];
	mediump uint d;
	lowp ivec2 e;
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump uvec2 f;
	bvec2 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.a), uvec4(7u, 9u, 0u, 1u)) && allOk;
	allOk = compare_vec3((blockB.b), vec3(-1.0, 0.0, -3.0)) && allOk;
	allOk = compare_ivec4((blockC.c[0]), ivec4(9, -2, 0, 3)) && allOk;
	allOk = compare_ivec2((blockC.e), ivec2(2, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec3(-3.0, -9.0, 1.0));
	blockC.c[0] = (ivec4(2, 8, -2, 5));
	blockC.e = (ivec2(-5, -9));
	blockD.f = (uvec2(9u, 5u));
	blockD.g = (bvec2(true, false));
}
#version 450
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
	mediump vec4 e[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	f16vec4 f;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp ivec3 g;
	float16_t h;
	lowp int i;
	bvec3 j;
	mediump mat2 k[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	lowp mat2x3 l[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(blockB.a), uvec2(0u, 2u)) && allOk;
	allOk = compare_mat4x2(blockB.b, mat4x2(8.0, 9.0, 0.0, -4.0, -4.0, -6.0, -5.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.f), vec4(0.0, 2.0, 1.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockD.g), ivec3(0, 9, -1)) && allOk;
	allOk = compare_float16_t(float(blockD.h), -1.0) && allOk;
	allOk = compare_mat2(blockD.k[0], mat2(-4.0, 1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(blockD.k[1], mat2(0.0, 0.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat2(blockD.k[2], mat2(2.0, -5.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2(blockD.k[3], mat2(-5.0, -9.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec2(uvec2(4u, 1u));
	blockB.b = (mat4x2(-2.0, -6.0, 0.0, 3.0, -6.0, -7.0, 6.0, 8.0));
	blockB.c = int16_t(5);
	blockB.d = u16vec2(uvec2(9u, 4u));
	blockB.e[0] = (vec4(-2.0, 2.0, 3.0, -1.0));
	blockB.e[1] = (vec4(4.0, -4.0, -6.0, -7.0));
	blockC.f = f16vec4(vec4(-7.0, -4.0, 8.0, 2.0));
	blockD.g = (ivec3(-9, 0, 4));
	blockE.l[0] = (mat2x3(7.0, -5.0, 5.0, 0.0, 6.0, -6.0));
	blockE.l[1] = (mat2x3(-6.0, 6.0, 3.0, 6.0, -6.0, 2.0));
	blockE.l[2] = (mat2x3(-4.0, -9.0, -9.0, 5.0, 5.0, -5.0));
	blockE.l[3] = (mat2x3(-1.0, -7.0, 2.0, -8.0, 8.0, 8.0));
	blockE.l[4] = (mat2x3(-1.0, 3.0, 6.0, -1.0, -6.0, -1.0));
	blockE.l[5] = (mat2x3(-9.0, 5.0, 5.0, 7.0, -7.0, -3.0));
}
#version 450
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
	f16vec4 a;
	float16_t b[6];
	highp ivec3 c;
	highp int d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.c), ivec3(-1, -2, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec4(vec4(-5.0, -3.0, -2.0, 0.0));
	blockB.d[0] = (-2);
	blockB.d[1] = (2);
	blockB.d[2] = (3);
	blockB.d[3] = (-1);
	blockB.d[4] = (4);
	blockB.d[5] = (-4);
}
#version 450
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
	mediump mat2x3 a[];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump mat4 b;
	f16vec4 c;
	highp mat2x3 d[6];
	u16vec4 e;
	f16vec2 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB[0].a[0], mat2x3(9.0, -2.0, -1.0, 7.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a[1], mat2x3(-7.0, -4.0, 2.0, 8.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a[2], mat2x3(7.0, 6.0, 2.0, -1.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a[3], mat2x3(1.0, 4.0, -7.0, -2.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a[4], mat2x3(0.0, -2.0, 8.0, -4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a[5], mat2x3(4.0, 1.0, 0.0, 7.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a[6], mat2x3(-3.0, 2.0, 9.0, 7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a[0], mat2x3(-2.0, -3.0, 1.0, 9.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a[1], mat2x3(-9.0, -4.0, -3.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a[2], mat2x3(5.0, 3.0, -2.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a[3], mat2x3(4.0, -6.0, 2.0, 9.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a[4], mat2x3(9.0, 1.0, 3.0, 0.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a[5], mat2x3(-7.0, 9.0, 0.0, -4.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a[6], mat2x3(3.0, 4.0, 6.0, 4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a[7], mat2x3(-5.0, 0.0, -5.0, 7.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a[0], mat2x3(-5.0, -5.0, 8.0, 0.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a[1], mat2x3(8.0, 6.0, -3.0, 1.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a[2], mat2x3(8.0, 5.0, -4.0, 6.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a[3], mat2x3(-2.0, -8.0, -9.0, -8.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4(blockC.b, mat4(-2.0, -3.0, 9.0, -2.0, 6.0, 0.0, -9.0, -1.0, -2.0, 1.0, -5.0, 0.0, 9.0, 1.0, 9.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.c), vec4(7.0, 5.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockC.d[0], mat2x3(2.0, 9.0, 2.0, -4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockC.d[1], mat2x3(3.0, -7.0, -5.0, -9.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockC.d[2], mat2x3(-8.0, -6.0, 3.0, 6.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockC.d[3], mat2x3(-4.0, -4.0, 9.0, -5.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockC.d[4], mat2x3(-9.0, -9.0, 8.0, -8.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockC.d[5], mat2x3(-1.0, -3.0, 2.0, -6.0, 2.0, 9.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.e), uvec4(7u, 1u, 2u, 6u)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f[0]), vec2(1.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f[1]), vec2(6.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f[2]), vec2(8.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f[3]), vec2(-7.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f[4]), vec2(4.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f[5]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f[6]), vec2(-8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f[7]), vec2(0.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (mat2x3(1.0, -6.0, -2.0, 5.0, 1.0, -6.0));
	blockB[0].a[1] = (mat2x3(-5.0, -1.0, 4.0, -7.0, -3.0, -5.0));
	blockB[0].a[2] = (mat2x3(7.0, -3.0, -4.0, 3.0, -5.0, -1.0));
	blockB[0].a[3] = (mat2x3(-5.0, -6.0, 6.0, 5.0, -1.0, 2.0));
	blockB[0].a[4] = (mat2x3(8.0, 8.0, -2.0, -7.0, -6.0, 5.0));
	blockB[0].a[5] = (mat2x3(-2.0, -2.0, 6.0, 8.0, -3.0, 7.0));
	blockB[0].a[6] = (mat2x3(9.0, -9.0, -8.0, -5.0, 3.0, -8.0));
	blockB[1].a[0] = (mat2x3(-7.0, -1.0, -1.0, -1.0, 9.0, 1.0));
	blockB[1].a[1] = (mat2x3(1.0, -3.0, -5.0, 0.0, -3.0, -2.0));
	blockB[1].a[2] = (mat2x3(8.0, 3.0, 7.0, -4.0, -2.0, -4.0));
	blockB[1].a[3] = (mat2x3(-8.0, 5.0, -6.0, 8.0, 6.0, 4.0));
	blockB[1].a[4] = (mat2x3(6.0, -4.0, -6.0, 3.0, 1.0, 7.0));
	blockB[1].a[5] = (mat2x3(7.0, 9.0, 0.0, 3.0, -3.0, 4.0));
	blockB[1].a[6] = (mat2x3(-1.0, 6.0, -2.0, 5.0, -6.0, -8.0));
	blockB[1].a[7] = (mat2x3(-5.0, 0.0, 4.0, 3.0, -1.0, 9.0));
	blockB[2].a[0] = (mat2x3(-6.0, -4.0, 3.0, -3.0, -1.0, 6.0));
	blockB[2].a[1] = (mat2x3(-6.0, -4.0, 3.0, 2.0, 9.0, 5.0));
	blockB[2].a[2] = (mat2x3(2.0, -3.0, -7.0, 3.0, 0.0, 7.0));
	blockB[2].a[3] = (mat2x3(-4.0, 4.0, -4.0, 3.0, -4.0, -1.0));
	blockC.c = f16vec4(vec4(-1.0, 8.0, -8.0, -8.0));
	blockC.f[0] = f16vec2(vec2(3.0, 2.0));
	blockC.f[1] = f16vec2(vec2(-6.0, -9.0));
	blockC.f[2] = f16vec2(vec2(-2.0, 9.0));
	blockC.f[3] = f16vec2(vec2(-6.0, -1.0));
	blockC.f[4] = f16vec2(vec2(-3.0, 5.0));
	blockC.f[5] = f16vec2(vec2(5.0, -7.0));
	blockC.f[6] = f16vec2(vec2(6.0, 8.0));
	blockC.f[7] = f16vec2(vec2(-6.0, 8.0));
}
#version 450
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
	float16_t mB;
};
struct sB
{
	highp ivec4 mA[6];
	lowp mat4x2 mB;
	f16vec3 mC;
	u16vec2 mD;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	bvec4 a;
	sA b;
	highp uvec4 c;
	f16vec3 d[][6];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump mat4x2 e;
	int16_t f;
	lowp mat4x2 g;
	sB h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, true, false, false)) && allOk;
	allOk = compare_ivec4((blockB.b.mA), ivec4(8, 0, -3, 5)) && allOk;
	allOk = compare_float16_t(float(blockB.b.mB), 6.0) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[0][0]), vec3(9.0, 3.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[0][1]), vec3(-8.0, 3.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[0][2]), vec3(-4.0, -3.0, 3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[0][3]), vec3(-6.0, 3.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[0][4]), vec3(9.0, -3.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[0][5]), vec3(-4.0, -3.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[1][0]), vec3(-4.0, 6.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[1][1]), vec3(2.0, -6.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[1][2]), vec3(-4.0, -5.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[1][3]), vec3(-9.0, -9.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[1][4]), vec3(7.0, -1.0, -6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[1][5]), vec3(9.0, -9.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[2][0]), vec3(6.0, 0.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[2][1]), vec3(7.0, -8.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[2][2]), vec3(3.0, -6.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[2][3]), vec3(-5.0, 9.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[2][4]), vec3(2.0, 3.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d[2][5]), vec3(-5.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockC.e, mat4x2(-1.0, 5.0, 6.0, -4.0, 9.0, 0.0, -5.0, -2.0)) && allOk;
	allOk = compare_int16_t(int(blockC.f), -7) && allOk;
	allOk = compare_mat4x2(blockC.g, mat4x2(0.0, 6.0, 8.0, -1.0, 4.0, -2.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, true, true));
	blockB.b.mA = (ivec4(-5, 0, -7, -6));
	blockB.b.mB = float16_t(-7.0);
	blockB.c = (uvec4(2u, 9u, 6u, 7u));
	blockB.d[0][0] = f16vec3(vec3(-6.0, 4.0, 6.0));
	blockB.d[0][1] = f16vec3(vec3(9.0, 8.0, -8.0));
	blockB.d[0][2] = f16vec3(vec3(-8.0, -4.0, 9.0));
	blockB.d[0][3] = f16vec3(vec3(-2.0, -5.0, 3.0));
	blockB.d[0][4] = f16vec3(vec3(-8.0, 1.0, 2.0));
	blockB.d[0][5] = f16vec3(vec3(9.0, -1.0, -6.0));
	blockB.d[1][0] = f16vec3(vec3(4.0, -2.0, -1.0));
	blockB.d[1][1] = f16vec3(vec3(3.0, 3.0, -9.0));
	blockB.d[1][2] = f16vec3(vec3(7.0, 2.0, -5.0));
	blockB.d[1][3] = f16vec3(vec3(-2.0, 3.0, -2.0));
	blockB.d[1][4] = f16vec3(vec3(-5.0, -3.0, 7.0));
	blockB.d[1][5] = f16vec3(vec3(9.0, -9.0, 1.0));
	blockB.d[2][0] = f16vec3(vec3(-5.0, 0.0, 1.0));
	blockB.d[2][1] = f16vec3(vec3(-9.0, 1.0, 0.0));
	blockB.d[2][2] = f16vec3(vec3(9.0, -8.0, -4.0));
	blockB.d[2][3] = f16vec3(vec3(2.0, 1.0, 2.0));
	blockB.d[2][4] = f16vec3(vec3(3.0, -9.0, 6.0));
	blockB.d[2][5] = f16vec3(vec3(1.0, 7.0, -1.0));
	blockC.f = int16_t(7);
	blockC.g = (mat4x2(-5.0, -4.0, 1.0, 7.0, -3.0, 9.0, 5.0, 5.0));
	blockC.h.mA[0] = (ivec4(-7, 1, -3, -5));
	blockC.h.mA[1] = (ivec4(2, -2, -8, 3));
	blockC.h.mA[2] = (ivec4(8, -9, -5, -6));
	blockC.h.mA[3] = (ivec4(7, -2, -3, -4));
	blockC.h.mA[4] = (ivec4(1, 0, 2, 0));
	blockC.h.mA[5] = (ivec4(-7, 4, 5, -8));
	blockC.h.mB = (mat4x2(5.0, 7.0, -7.0, 1.0, 1.0, 9.0, 7.0, 9.0));
	blockC.h.mC = f16vec3(vec3(5.0, 7.0, -7.0));
	blockC.h.mD = u16vec2(uvec2(6u, 0u));
}
#version 450
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
	highp uvec4 a;
	f16vec2 b;
	mediump mat3x2 c[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	bool d;
	mediump mat3x2 e;
	mediump mat3x4 f[5];
	highp vec3 g;
	bool h[][4];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	bvec3 i;
	mediump vec4 j;
	uint16_t k;
	float16_t l;
	highp vec4 m[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB.b), vec2(4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[0], mat3x2(9.0, -8.0, 3.0, -6.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[1], mat3x2(7.0, 6.0, -1.0, -5.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[2], mat3x2(-6.0, -4.0, 5.0, -7.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[3], mat3x2(0.0, 5.0, 6.0, -9.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[4], mat3x2(-2.0, 1.0, 6.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[5], mat3x2(-1.0, 1.0, 7.0, -8.0, 9.0, 1.0)) && allOk;
	allOk = compare_bool((blockC[0].d), false) && allOk;
	allOk = compare_vec3((blockC[0].g), vec3(3.0, -6.0, 8.0)) && allOk;
	allOk = compare_bvec3((blockD.i), bvec3(true, true, true)) && allOk;
	allOk = compare_vec4((blockD.j), vec4(-1.0, 8.0, 8.0, 4.0)) && allOk;
	allOk = compare_vec4((blockD.m[0]), vec4(9.0, 8.0, 6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(3u, 2u, 9u, 0u));
	blockB.b = f16vec2(vec2(-8.0, 8.0));
	blockB.c[0] = (mat3x2(4.0, -5.0, 6.0, -7.0, -5.0, 5.0));
	blockB.c[1] = (mat3x2(2.0, 0.0, -4.0, 9.0, -8.0, 3.0));
	blockB.c[2] = (mat3x2(1.0, -4.0, -6.0, -6.0, 4.0, 9.0));
	blockB.c[3] = (mat3x2(3.0, -8.0, 7.0, 5.0, 7.0, -2.0));
	blockB.c[4] = (mat3x2(-7.0, 0.0, -2.0, -1.0, 5.0, 5.0));
	blockB.c[5] = (mat3x2(4.0, -1.0, -9.0, 7.0, -1.0, -1.0));
	blockC[0].d = (true);
	blockC[0].e = (mat3x2(4.0, -3.0, 1.0, 6.0, 5.0, 8.0));
	blockC[0].f[0] = (mat3x4(5.0, -1.0, -1.0, -1.0, 2.0, -8.0, -1.0, -2.0, -8.0, 1.0, -7.0, -3.0));
	blockC[0].f[1] = (mat3x4(3.0, -6.0, 1.0, -1.0, -1.0, 1.0, 2.0, -5.0, -4.0, 4.0, 7.0, -2.0));
	blockC[0].f[2] = (mat3x4(8.0, -5.0, -9.0, 2.0, 3.0, 1.0, -5.0, -2.0, 5.0, -1.0, 0.0, -2.0));
	blockC[0].f[3] = (mat3x4(2.0, -7.0, -7.0, -7.0, 9.0, -6.0, -8.0, 6.0, 5.0, 3.0, 2.0, 4.0));
	blockC[0].f[4] = (mat3x4(-9.0, 9.0, 1.0, 6.0, -8.0, -6.0, -8.0, -6.0, -8.0, 7.0, 3.0, -6.0));
	blockC[0].h[0][0] = (true);
	blockC[0].h[0][1] = (false);
	blockC[0].h[0][2] = (true);
	blockC[0].h[0][3] = (false);
	blockC[0].h[1][0] = (true);
	blockC[0].h[1][1] = (false);
	blockC[0].h[1][2] = (false);
	blockC[0].h[1][3] = (true);
	blockC[0].h[2][0] = (true);
	blockC[0].h[2][1] = (true);
	blockC[0].h[2][2] = (true);
	blockC[0].h[2][3] = (true);
	blockD.i = (bvec3(false, true, true));
	blockD.j = (vec4(4.0, -7.0, 4.0, -5.0));
	blockD.k = uint16_t(8u);
	blockD.l = float16_t(3.0);
}
#version 450
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
	mediump float a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (9.0);
	blockB[nonuniformEXT(1)].a = (-2.0);
	blockB[nonuniformEXT(2)].a = (-3.0);
}
#version 450
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
	highp mat3 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB[nonuniformEXT(0)].a, mat3(1.0, -8.0, 7.0, -4.0, -9.0, 0.0, -2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(1)].a, mat3(-6.0, -8.0, 6.0, -6.0, 3.0, 9.0, -7.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat3(-7.0, 9.0, 6.0, -4.0, -9.0, -3.0, 2.0, -5.0, 1.0));
	blockB[nonuniformEXT(1)].a = (mat3(-9.0, -8.0, 5.0, -1.0, -9.0, -4.0, 4.0, -6.0, 9.0));
}
#version 450
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
	i8vec4 a;
	lowp mat4x3 b;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp ivec3 c;
	i8vec2 d;
	lowp uvec2 e;
	highp vec2 f;
	mediump mat3x2 g[3];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.a), ivec4(4294967294, 4, 3, 4294967288)) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(3.0, -5.0, -4.0, -5.0, -3.0, -2.0, -3.0, 6.0, -6.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_ivec3((blockC.c), ivec3(-6, -3, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d), ivec2(4294967290, 1)) && allOk;
	allOk = compare_uvec2((blockC.e), uvec2(6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec4(ivec4(4294967289, 3, 4294967287, 4294967289));
	blockB.b = (mat4x3(-4.0, -1.0, 9.0, -4.0, -4.0, 3.0, -7.0, -4.0, 0.0, -7.0, -9.0, -8.0));
	blockC.c = (ivec3(-4, -7, 2));
	blockC.e = (uvec2(5u, 4u));
	blockC.f = (vec2(9.0, 4.0));
}
#version 450
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
};
struct sB
{
	lowp uvec2 mA;
	mediump mat4x2 mB;
	highp ivec2 mC;
	bvec4 mD;
};
layout(std140, buffer_reference) buffer BlockB
{
	lowp mat4 a;
	sA b;
	lowp mat4x2 c[];
};
layout(std430, buffer_reference) buffer BlockC
{
	i8vec2 d[][7];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	bvec4 e;
	lowp ivec2 f;
	i8vec4 g;
	sB h;
	highp uvec2 i[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	lowp uvec3 j;
	bvec2 k;
	lowp vec3 l;
	lowp mat4 m;
	bvec2 n[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(2.0, 7.0, -9.0, 3.0, 0.0, -7.0, 7.0, -2.0, 3.0, 9.0, 1.0, -5.0, -2.0, 0.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockB.b.mA, mat3x4(-9.0, -6.0, -9.0, 6.0, 1.0, -6.0, 0.0, 2.0, 5.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockD.e), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uvec2((blockD.h.mA), uvec2(7u, 8u)) && allOk;
	allOk = compare_mat4x2(blockD.h.mB, mat4x2(9.0, 0.0, 8.0, 1.0, 9.0, -2.0, -2.0, 5.0)) && allOk;
	allOk = compare_ivec2((blockD.h.mC), ivec2(6, 1)) && allOk;
	allOk = compare_bvec4((blockD.h.mD), bvec4(false, true, false, false)) && allOk;
	allOk = compare_uvec3((blockE.j), uvec3(1u, 0u, 1u)) && allOk;
	allOk = compare_bvec2((blockE.k), bvec2(false, true)) && allOk;
	allOk = compare_vec3((blockE.l), vec3(8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(blockE.m, mat4(-7.0, 2.0, 5.0, 8.0, 7.0, 1.0, -7.0, -9.0, -7.0, -3.0, -2.0, 4.0, -3.0, -3.0, 2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(8.0, 9.0, -5.0, 5.0, -4.0, 2.0, -1.0, 9.0, -3.0, 5.0, -8.0, -2.0, 4.0, 1.0, -2.0, -8.0));
	blockB.b.mA = (mat3x4(-6.0, 9.0, 4.0, -5.0, 5.0, -1.0, 4.0, -7.0, 5.0, -6.0, 4.0, -3.0));
	blockB.c[0] = (mat4x2(9.0, 0.0, -8.0, 6.0, -8.0, -7.0, -2.0, 5.0));
	blockB.c[1] = (mat4x2(1.0, 3.0, -3.0, -1.0, 1.0, -6.0, -5.0, -4.0));
	blockB.c[2] = (mat4x2(-2.0, 8.0, -7.0, 4.0, 0.0, 7.0, 2.0, -4.0));
	blockB.c[3] = (mat4x2(1.0, 6.0, -2.0, 5.0, 7.0, -9.0, -4.0, 7.0));
	blockB.c[4] = (mat4x2(-9.0, 7.0, 7.0, -8.0, 5.0, -2.0, -3.0, -9.0));
	blockB.c[5] = (mat4x2(7.0, -4.0, -6.0, 3.0, -7.0, -4.0, 2.0, -4.0));
	blockB.c[6] = (mat4x2(-3.0, 3.0, 2.0, 0.0, 8.0, 8.0, -2.0, -6.0));
	blockC.d[0][0] = i8vec2(ivec2(7, 1));
	blockC.d[0][1] = i8vec2(ivec2(9, 4294967295));
	blockC.d[0][2] = i8vec2(ivec2(4294967288, 1));
	blockC.d[0][3] = i8vec2(ivec2(0, 4294967294));
	blockC.d[0][4] = i8vec2(ivec2(4294967288, 7));
	blockC.d[0][5] = i8vec2(ivec2(4294967290, 4294967291));
	blockC.d[0][6] = i8vec2(ivec2(4294967290, 4294967289));
	blockC.d[1][0] = i8vec2(ivec2(4294967291, 9));
	blockC.d[1][1] = i8vec2(ivec2(6, 8));
	blockC.d[1][2] = i8vec2(ivec2(0, 1));
	blockC.d[1][3] = i8vec2(ivec2(0, 4294967289));
	blockC.d[1][4] = i8vec2(ivec2(8, 5));
	blockC.d[1][5] = i8vec2(ivec2(4294967295, 3));
	blockC.d[1][6] = i8vec2(ivec2(4294967294, 4294967291));
	blockD.f = (ivec2(-6, -2));
	blockD.g = i8vec4(ivec4(4294967292, 4294967289, 4294967291, 4));
	blockD.h.mA = (uvec2(8u, 2u));
	blockD.h.mB = (mat4x2(-3.0, 7.0, -6.0, -4.0, -8.0, -4.0, -7.0, -2.0));
	blockD.h.mC = (ivec2(-8, 0));
	blockD.h.mD = (bvec4(true, true, true, false));
	blockD.i[0] = (uvec2(7u, 4u));
	blockD.i[1] = (uvec2(3u, 5u));
	blockD.i[2] = (uvec2(5u, 7u));
	blockD.i[3] = (uvec2(5u, 9u));
	blockD.i[4] = (uvec2(0u, 2u));
	blockD.i[5] = (uvec2(8u, 8u));
	blockD.i[6] = (uvec2(4u, 2u));
	blockD.i[7] = (uvec2(4u, 5u));
	blockE.j = (uvec3(4u, 5u, 9u));
	blockE.k = (bvec2(true, true));
	blockE.l = (vec3(-5.0, -1.0, -5.0));
	blockE.m = (mat4(6.0, 6.0, 4.0, 5.0, -7.0, -4.0, -8.0, -3.0, -4.0, 3.0, 6.0, 9.0, -1.0, -7.0, 7.0, 7.0));
	blockE.n[0] = (bvec2(false, true));
}
#version 450
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
	i8vec2 mA;
	highp float mB;
	bvec2 mC;
	bool mD;
};
layout(std140, buffer_reference) buffer BlockB
{
	lowp float a;
	sA b;
	mediump mat2x3 c[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	uint8_t d;
	u8vec2 e[1];
	lowp ivec2 f;
	mediump ivec2 g[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	mediump mat3x4 h;
	sB i;
	u8vec3 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[0].a), -5.0) && allOk;
	allOk = compare_int8_t(int(blockB[0].b.mA), 4294967287) && allOk;
	allOk = compare_uint8_t(uint(blockC.d), 7u) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.e[0]), uvec2(2u, 8u)) && allOk;
	allOk = compare_ivec2((blockC.f), ivec2(-3, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].c[0] = (mat2x3(-4.0, -7.0, -3.0, -9.0, 1.0, 2.0));
	blockC.d = uint8_t(1u);
	blockC.e[0] = u8vec2(uvec2(6u, 6u));
	blockC.f = (ivec2(-7, -5));
	blockC.g[0] = (ivec2(-9, -9));
	blockD.h = (mat3x4(-7.0, 3.0, 1.0, 2.0, -4.0, -6.0, 7.0, 1.0, 9.0, 1.0, 3.0, 9.0));
}
#version 450
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
	lowp uint mB;
};
struct sB
{
	bool mA;
};
struct sC
{
	lowp uvec4 mA;
	highp int mB;
	sB mC;
	highp mat4 mD;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	mediump mat2 a;
	highp mat2x3 b;
	sA c;
	highp mat4 d;
	u8vec3 e[][1];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockC
{
	lowp ivec2 f[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	highp mat3x4 g;
};
layout(std140, column_major, buffer_reference) readonly buffer BlockE
{
	sC h;
	mediump mat4 i[];
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(-8.0, -9.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockB.b, mat2x3(3.0, -5.0, 3.0, 0.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockB.c.mA, mat2x3(1.0, 6.0, -1.0, 4.0, 9.0, -8.0)) && allOk;
	allOk = compare_uint((blockB.c.mB), 7u) && allOk;
	allOk = compare_ivec2((blockC.f[0]), ivec2(-3, -2)) && allOk;
	allOk = compare_ivec2((blockC.f[1]), ivec2(9, -7)) && allOk;
	allOk = compare_ivec2((blockC.f[2]), ivec2(-9, 8)) && allOk;
	allOk = compare_ivec2((blockC.f[3]), ivec2(7, 9)) && allOk;
	allOk = compare_ivec2((blockC.f[4]), ivec2(6, -4)) && allOk;
	allOk = compare_ivec2((blockC.f[5]), ivec2(4, -4)) && allOk;
	allOk = compare_ivec2((blockC.f[6]), ivec2(5, 2)) && allOk;
	allOk = compare_ivec2((blockC.f[7]), ivec2(3, -9)) && allOk;
	allOk = compare_mat3x4(blockD.g, mat3x4(8.0, 5.0, 2.0, -7.0, 2.0, 8.0, 4.0, 7.0, 3.0, 7.0, 1.0, 2.0)) && allOk;
	allOk = compare_uvec4((blockE.h.mA), uvec4(2u, 2u, 3u, 9u)) && allOk;
	allOk = compare_int((blockE.h.mB), 6) && allOk;
	allOk = compare_bool((blockE.h.mC.mA), true) && allOk;
	allOk = compare_mat4(blockE.h.mD, mat4(-1.0, -4.0, -9.0, 2.0, -5.0, -1.0, -6.0, -3.0, 5.0, 7.0, 2.0, 0.0, -4.0, 1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(blockE.i[0], mat4(-2.0, 8.0, 0.0, -4.0, 4.0, -2.0, -3.0, 0.0, 8.0, -9.0, 3.0, 9.0, -2.0, 7.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4(blockE.i[1], mat4(-7.0, -3.0, 1.0, 3.0, -8.0, -6.0, 8.0, -1.0, -6.0, 9.0, 1.0, -9.0, 1.0, -9.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat4(blockE.i[2], mat4(0.0, -5.0, 6.0, -3.0, 9.0, -5.0, 5.0, 5.0, -1.0, 4.0, -8.0, 2.0, 5.0, 9.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat4(blockE.i[3], mat4(-1.0, 2.0, -3.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, -2.0, -3.0, 6.0, -9.0, -9.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4(blockE.i[4], mat4(5.0, 0.0, -5.0, -2.0, 0.0, -6.0, 8.0, 4.0, -8.0, 9.0, 8.0, -2.0, 6.0, -6.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4(blockE.i[5], mat4(6.0, -8.0, -6.0, 3.0, 6.0, 8.0, 7.0, 1.0, 2.0, 9.0, 1.0, -3.0, -5.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4(blockE.i[6], mat4(6.0, -3.0, 9.0, -1.0, 4.0, -5.0, 5.0, -5.0, -4.0, -6.0, 7.0, -3.0, 8.0, -1.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(7.0, -6.0, -8.0, -6.0));
	blockB.b = (mat2x3(3.0, -1.0, 9.0, 5.0, 2.0, 3.0));
	blockB.c.mA = (mat2x3(-7.0, 4.0, 7.0, -7.0, 1.0, -3.0));
	blockB.c.mB = (3u);
	blockD.g = (mat3x4(6.0, -7.0, -2.0, 1.0, 6.0, 5.0, -7.0, 0.0, -4.0, -9.0, 5.0, 9.0));
}
#version 450
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
	highp int a;
	bvec2 b;
	bvec4 c;
	u8vec2 d;
	lowp mat3 e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump uvec4 f[5];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	u8vec2 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[0].a), 1) && allOk;
	allOk = compare_bvec2((blockB[0].b), bvec2(false, true)) && allOk;
	allOk = compare_bvec4((blockB[0].c), bvec4(true, true, true, true)) && allOk;
	allOk = compare_mat3(blockB[0].e[0], mat3(9.0, -7.0, 3.0, 0.0, 0.0, 5.0, -8.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(blockB[0].e[1], mat3(-8.0, -4.0, 9.0, -2.0, 0.0, 3.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(blockB[0].e[2], mat3(7.0, -9.0, -6.0, -4.0, 3.0, 8.0, -1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3(blockB[0].e[3], mat3(6.0, -2.0, -7.0, -1.0, -8.0, -4.0, -6.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB[0].e[4], mat3(-5.0, -5.0, 6.0, -1.0, 2.0, 1.0, -5.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3(blockB[0].e[5], mat3(1.0, -1.0, -4.0, -1.0, 2.0, 9.0, 5.0, 2.0, 3.0)) && allOk;
	allOk = compare_int((blockB[1].a), 7) && allOk;
	allOk = compare_bvec2((blockB[1].b), bvec2(false, true)) && allOk;
	allOk = compare_bvec4((blockB[1].c), bvec4(true, false, false, true)) && allOk;
	allOk = compare_mat3(blockB[1].e[0], mat3(-4.0, 5.0, -9.0, -8.0, 7.0, 8.0, 5.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3(blockB[1].e[1], mat3(-1.0, 8.0, -6.0, -2.0, 8.0, -1.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_int((blockB[2].a), -2) && allOk;
	allOk = compare_bvec2((blockB[2].b), bvec2(false, false)) && allOk;
	allOk = compare_bvec4((blockB[2].c), bvec4(false, false, false, false)) && allOk;
	allOk = compare_mat3(blockB[2].e[0], mat3(-3.0, 5.0, -9.0, -8.0, -9.0, 6.0, -8.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3(blockB[2].e[1], mat3(-6.0, -2.0, -9.0, 9.0, 1.0, -1.0, -5.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB[2].e[2], mat3(7.0, -8.0, 2.0, -5.0, 0.0, 5.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(blockB[2].e[3], mat3(-5.0, -1.0, 7.0, 4.0, -3.0, 3.0, -7.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3(blockB[2].e[4], mat3(-2.0, -6.0, 8.0, 9.0, 9.0, 1.0, 4.0, -7.0, -5.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.g[0]), uvec2(1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (-7);
	blockB[0].b = (bvec2(false, false));
	blockB[0].c = (bvec4(true, false, true, true));
	blockB[0].d = u8vec2(uvec2(3u, 8u));
	blockB[0].e[0] = (mat3(-1.0, -9.0, -4.0, 4.0, -6.0, 9.0, -1.0, -2.0, -3.0));
	blockB[0].e[1] = (mat3(5.0, 6.0, 0.0, 6.0, 1.0, 8.0, -4.0, -4.0, -4.0));
	blockB[0].e[2] = (mat3(-2.0, -2.0, -5.0, -9.0, 9.0, 6.0, 3.0, 7.0, -6.0));
	blockB[0].e[3] = (mat3(-1.0, -3.0, -2.0, 9.0, -6.0, 1.0, 6.0, 7.0, -7.0));
	blockB[0].e[4] = (mat3(2.0, -1.0, 9.0, 0.0, 9.0, 6.0, -2.0, 8.0, 0.0));
	blockB[0].e[5] = (mat3(4.0, 2.0, -5.0, -5.0, 2.0, -5.0, 0.0, -2.0, -3.0));
	blockB[1].a = (-3);
	blockB[1].b = (bvec2(true, false));
	blockB[1].c = (bvec4(true, true, true, false));
	blockB[1].d = u8vec2(uvec2(3u, 7u));
	blockB[1].e[0] = (mat3(0.0, -7.0, -6.0, -9.0, -7.0, 1.0, 2.0, 3.0, -7.0));
	blockB[1].e[1] = (mat3(-5.0, 6.0, -1.0, 7.0, 5.0, -9.0, 7.0, -8.0, -1.0));
	blockB[2].a = (-8);
	blockB[2].b = (bvec2(false, true));
	blockB[2].c = (bvec4(false, false, true, true));
	blockB[2].d = u8vec2(uvec2(0u, 4u));
	blockB[2].e[0] = (mat3(9.0, 8.0, -4.0, 5.0, -1.0, 0.0, 0.0, 1.0, 9.0));
	blockB[2].e[1] = (mat3(-7.0, 2.0, 6.0, 8.0, 4.0, -2.0, 4.0, -3.0, -6.0));
	blockB[2].e[2] = (mat3(2.0, -7.0, 9.0, 5.0, -3.0, -2.0, 7.0, 4.0, -1.0));
	blockB[2].e[3] = (mat3(9.0, -5.0, 7.0, 7.0, -7.0, -6.0, 4.0, -7.0, -7.0));
	blockB[2].e[4] = (mat3(9.0, 7.0, 6.0, -1.0, -7.0, -6.0, -1.0, -8.0, -1.0));
	blockC.f[0] = (uvec4(3u, 0u, 0u, 8u));
	blockC.f[1] = (uvec4(2u, 0u, 1u, 6u));
	blockC.f[2] = (uvec4(2u, 3u, 2u, 0u));
	blockC.f[3] = (uvec4(3u, 6u, 9u, 6u));
	blockC.f[4] = (uvec4(3u, 0u, 7u, 0u));
	blockD.g[0] = u8vec2(uvec2(2u, 5u));
}
#version 450
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
	layout(offset = 0) int8_t a;
	layout(offset = 1) uint8_t b;
	layout(offset = 4) mediump uvec3 c;
	layout(offset = 16) int8_t d;
	layout(offset = 20) bvec2 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp int f;
	layout(offset = 16) bvec3 g[1];
	layout(offset = 32) i8vec2 h;
	layout(offset = 36) mediump ivec3 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(blockB.a), 6) && allOk;
	allOk = compare_uint8_t(uint(blockB.b), 6u) && allOk;
	allOk = compare_uvec3((blockB.c), uvec3(3u, 8u, 4u)) && allOk;
	allOk = compare_bvec2((blockB.e), bvec2(true, true)) && allOk;
	allOk = compare_int((blockC.f), 2) && allOk;
	allOk = compare_bvec3((blockC.g[0]), bvec3(true, true, false)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.h), ivec2(4294967288, 1)) && allOk;
	allOk = compare_ivec3((blockC.i), ivec3(6, 4, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int8_t(7);
	blockB.b = uint8_t(7u);
	blockB.c = (uvec3(6u, 8u, 9u));
	blockB.d = int8_t(9);
	blockC.f = (-8);
	blockC.g[0] = (bvec3(true, false, true));
	blockC.h = i8vec2(ivec2(4294967293, 4294967289));
	blockC.i = (ivec3(1, 0, 1));
}
#version 450
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
	layout(offset = 0) lowp uvec3 a;
	layout(offset = 12) i8vec3 b;
	layout(offset = 16) mediump int c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp uvec4 d;
	layout(offset = 16) mediump uvec2 e[1];
	layout(offset = 32) highp ivec4 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(0u, 7u, 0u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b), ivec3(2, 5, 4294967294)) && allOk;
	allOk = compare_int((blockB.c), -2) && allOk;
	allOk = compare_uvec2((blockC.e[0]), uvec2(3u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(6u, 8u, 5u));
	blockB.c = (-9);
	blockC.d = (uvec4(4u, 2u, 1u, 1u));
	blockC.e[0] = (uvec2(3u, 7u));
	blockC.f = (ivec4(-3, -7, -6, 6));
}
#version 450
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
	layout(offset = 0) u8vec3 a;
	layout(offset = 4) highp uvec3 b;
	layout(offset = 16) lowp vec2 c;
	layout(offset = 32) mediump uvec3 d;
	layout(offset = 44) uint8_t e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp vec4 f;
	layout(offset = 16) bool g;
	layout(offset = 32) bvec4 h;
	layout(offset = 48) u8vec2 i;
	layout(offset = 52) mediump uvec3 j;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) u8vec2 k;
	layout(offset = 2) u8vec4 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.b), uvec3(6u, 2u, 0u)) && allOk;
	allOk = compare_vec2((blockB.c), vec2(2.0, 8.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB.e), 2u) && allOk;
	allOk = compare_vec4((blockC.f), vec4(5.0, -4.0, 0.0, 1.0)) && allOk;
	allOk = compare_bool((blockC.g), true) && allOk;
	allOk = compare_bvec4((blockC.h), bvec4(false, true, false, true)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.k), uvec2(5u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.l), uvec4(1u, 0u, 5u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec3(uvec3(9u, 7u, 7u));
	blockB.b = (uvec3(0u, 2u, 5u));
	blockB.c = (vec2(-8.0, -7.0));
	blockB.d = (uvec3(9u, 4u, 1u));
	blockB.e = uint8_t(0u);
	blockC.f = (vec4(-9.0, 2.0, 3.0, 9.0));
	blockC.h = (bvec4(true, false, true, true));
	blockC.i = u8vec2(uvec2(5u, 1u));
	blockC.j = (uvec3(6u, 4u, 2u));
	blockD.k = u8vec2(uvec2(5u, 1u));
	blockD.l = u8vec4(uvec4(9u, 6u, 4u, 4u));
}
#version 450
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
	i8vec4 a;
	lowp mat4 b[][3];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

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
