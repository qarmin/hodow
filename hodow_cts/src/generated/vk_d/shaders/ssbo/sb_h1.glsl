#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(3.0, 2.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(9.0, 6.0, -9.0, -4.0));
}
#version 450
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(2.0, 7.0, 4.0, -4.0, -1.0, -9.0, -2.0, 4.0, -5.0, -5.0, -7.0, -8.0, 5.0, 2.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4(2.0, 0.0, -9.0, -5.0, 3.0, -8.0, 5.0, -4.0, 0.0, 1.0, 6.0, -2.0, -7.0, -5.0, 0.0, -5.0));
}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[0][3], 5.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[1][2], 7.0) && allOk;
	allOk = compare_float(var[1][3], 8.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-6.0, 5.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(2.0, -6.0, 7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(8.0, -9.0, 0.0, -6.0));
	var[1] = (vec4(7.0, 8.0, 6.0, -6.0));
}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(2.0, 6.0, -4.0, 0.0, -4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(-3.0, 6.0, -1.0, 9.0, 4.0, 5.0));
}
#version 450
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

	var[0] = (vec3(-5.0, 8.0, 1.0));
	var[1] = (vec3(-5.0, 5.0, 1.0));
	var[2] = (vec3(-8.0, -8.0, -7.0));
	var[3] = (vec3(-6.0, 1.0, 7.0));
}
#version 450
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

	var = (mat3(2.0, -3.0, 9.0, -8.0, 1.0, 7.0, 4.0, -1.0, 8.0));
}
#version 450
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
	allOk = compare_mat2x4(var, mat2x4(4.0, -6.0, -1.0, -3.0, -2.0, 8.0, -5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(-3.0, 3.0, -6.0, -5.0, -3.0, -3.0, -7.0, -9.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[0][3], -7.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[1][2], 8.0) && allOk;
	allOk = compare_float(var[1][3], -5.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -4.0) && allOk;
	allOk = compare_float(var[2][2], 2.0) && allOk;
	allOk = compare_float(var[2][3], 5.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-3.0, -1.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(6.0, 2.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(6.0, -4.0, 2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(-5.0, 8.0, 7.0, 1.0, -4.0, -9.0, 1.0, 4.0, 3.0, 8.0, 8.0, -7.0));
}
#version 450
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
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_vec2(var[0], vec2(2.0, 0.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(8.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var = (mat2(-8.0, 5.0, -7.0, -3.0));
}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[0][2], 2.0) && allOk;
	allOk = compare_float(var[0][3], 3.0) && allOk;
	allOk = compare_float(var[1][0], -9.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_float(var[1][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-4.0, 2.0, 2.0, 3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-9.0, -5.0, -1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var = (mat2x4(9.0, 8.0, 6.0, 6.0, 7.0, -3.0, 2.0, 0.0));
}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(-5.0, -7.0, -2.0, 6.0, -3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var = (mat3x2(7.0, 6.0, -7.0, 5.0, 0.0, -8.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(6.0, -2.0));
	var[0][1] = (vec2(2.0, 8.0));
	var[0][2] = (vec2(-5.0, 3.0));
	var[0][3] = (vec2(-1.0, -7.0));
	var[1][0] = (vec2(4.0, 2.0));
	var[1][1] = (vec2(-4.0, 8.0));
	var[1][2] = (vec2(3.0, 8.0));
	var[1][3] = (vec2(-1.0, 6.0));
	var[2][0] = (vec2(-8.0, 2.0));
	var[2][1] = (vec2(-5.0, 5.0));
	var[2][2] = (vec2(-4.0, -9.0));
	var[2][3] = (vec2(0.0, 4.0));
}
#version 450
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
	highp mat3x4 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	var[1] = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	var[2] = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
}
#version 450
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
	u8vec3 var[3];
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(var[0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2]), uvec3(8u, 6u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = u8vec3(uvec3(4u, 5u, 9u));
	var[1] = u8vec3(uvec3(6u, 9u, 4u));
	var[2] = u8vec3(uvec3(7u, 1u, 5u));
}
#version 450
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
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat3x2(var[0], mat3x2(-4.0, 7.0, 2.0, 0.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(3.0, -1.0, 3.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-8.0, 5.0, -4.0, 8.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0] = (mat3x2(-3.0, -4.0, 2.0, -7.0, 7.0, -2.0));
	var[1] = (mat3x2(-8.0, -2.0, 3.0, 4.0, 9.0, 4.0));
	var[2] = (mat3x2(-7.0, 9.0, 9.0, -1.0, 1.0, -9.0));
}
#version 450
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
	highp mat2x4 var[];
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
	allOk = compare_mat2x4(var[3], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(4.0, 7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(-6.0, 0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-1.0, 7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(-7.0, 9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(6.0, -8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-1.0, -3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(-2.0, -2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	var[0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	var[1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	var[1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	var[2][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	var[2][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	var[3][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	var[3][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	var[4][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	var[4][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	var[5][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	var[5][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	var[6][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	var[6][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	var[7][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	var[7][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	var[8][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	var[8][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	var[9][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	var[9][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	var[10][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	var[10][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	var[11][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	var[11][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
	var[12][0] = (vec4(-7.0, 4.0, -9.0, 1.0));
	var[12][1] = (vec4(0.0, -5.0, 6.0, -3.0));
	var[13][0] = (vec4(-9.0, -4.0, 8.0, -1.0));
	var[13][1] = (vec4(7.0, -1.0, -9.0, -2.0));
	var[14][0] = (vec4(-9.0, -6.0, -1.0, -3.0));
	var[14][1] = (vec4(6.0, -6.0, 2.0, 1.0));
	var[15][0] = (vec4(-3.0, -3.0, -5.0, -1.0));
	var[15][1] = (vec4(4.0, 0.0, -9.0, -1.0));
	var[16][0] = (vec4(1.0, -2.0, 4.0, -4.0));
	var[16][1] = (vec4(3.0, -9.0, 0.0, -4.0));
	var[17][0] = (vec4(-7.0, 7.0, 9.0, -2.0));
	var[17][1] = (vec4(5.0, -3.0, -5.0, 5.0));
	var[18][0] = (vec4(-2.0, 4.0, 0.0, -2.0));
	var[18][1] = (vec4(9.0, -8.0, 7.0, 0.0));
}
#version 450
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
	u16vec4 var[];
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(var[0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[4]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[5]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[6]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[7]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[8]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[9]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[10]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[11]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[12]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[13]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[14]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[15]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[16]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[17]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[18]), uvec4(2u, 6u, 2u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	var[1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	var[2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	var[3] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	var[4] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	var[5] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	var[6] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	var[7] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	var[8] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	var[9] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	var[10] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	var[11] = u16vec4(uvec4(1u, 8u, 4u, 7u));
	var[12] = u16vec4(uvec4(6u, 9u, 4u, 2u));
	var[13] = u16vec4(uvec4(9u, 7u, 6u, 2u));
	var[14] = u16vec4(uvec4(8u, 4u, 6u, 2u));
	var[15] = u16vec4(uvec4(2u, 1u, 0u, 1u));
	var[16] = u16vec4(uvec4(9u, 9u, 4u, 6u));
	var[17] = u16vec4(uvec4(4u, 4u, 2u, 8u));
	var[18] = u16vec4(uvec4(7u, 8u, 2u, 8u));
}
#version 450
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
	highp mat3 var[];
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
	allOk = compare_mat3(var[3], mat3(-4.0, -2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(-2.0, 1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(3.0, 0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(0.0, 1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(-5.0, -7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(4.0, -4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(0.0, -5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-1.0, 3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(-4.0, 7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(-1.0, 5.0, -1.0, 7.0, -2.0, -7.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(-3.0, -8.0, 0.0, -2.0, 6.0, -7.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(1.0, 7.0, 9.0, -8.0, 7.0, -3.0, -9.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(-9.0, 2.0, -9.0, 9.0, 5.0, 3.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(2.0, -4.0, -3.0, 6.0, -4.0, -3.0, -8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(-1.0, 5.0, -7.0, -9.0, 2.0, 9.0, -3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(0.0, 0.0, 9.0, -5.0, 2.0, 9.0, -4.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(-1.0, 1.0, 4.0));
	var[0][1] = (vec3(6.0, -5.0, -5.0));
	var[0][2] = (vec3(9.0, -6.0, 5.0));
	var[1][0] = (vec3(7.0, 7.0, -2.0));
	var[1][1] = (vec3(-4.0, 1.0, -5.0));
	var[1][2] = (vec3(8.0, -1.0, -8.0));
	var[2][0] = (vec3(-6.0, -4.0, 5.0));
	var[2][1] = (vec3(3.0, 9.0, -8.0));
	var[2][2] = (vec3(-4.0, 8.0, 0.0));
	var[3][0] = (vec3(5.0, -1.0, 2.0));
	var[3][1] = (vec3(3.0, 0.0, 8.0));
	var[3][2] = (vec3(-8.0, -9.0, -1.0));
	var[4][0] = (vec3(-9.0, 4.0, -9.0));
	var[4][1] = (vec3(7.0, 3.0, 7.0));
	var[4][2] = (vec3(5.0, -4.0, 3.0));
	var[5][0] = (vec3(-9.0, 9.0, 4.0));
	var[5][1] = (vec3(7.0, -1.0, 2.0));
	var[5][2] = (vec3(-5.0, 2.0, -9.0));
	var[6][0] = (vec3(9.0, -7.0, -5.0));
	var[6][1] = (vec3(-4.0, -8.0, -6.0));
	var[6][2] = (vec3(-9.0, -6.0, -5.0));
	var[7][0] = (vec3(7.0, -5.0, 1.0));
	var[7][1] = (vec3(-7.0, 6.0, -4.0));
	var[7][2] = (vec3(-3.0, -4.0, -2.0));
	var[8][0] = (vec3(-4.0, -4.0, 3.0));
	var[8][1] = (vec3(-9.0, -7.0, 0.0));
	var[8][2] = (vec3(3.0, 0.0, -1.0));
	var[9][0] = (vec3(-5.0, -6.0, 8.0));
	var[9][1] = (vec3(3.0, 3.0, -1.0));
	var[9][2] = (vec3(-7.0, 5.0, 7.0));
	var[10][0] = (vec3(7.0, 4.0, -7.0));
	var[10][1] = (vec3(7.0, 7.0, -4.0));
	var[10][2] = (vec3(-5.0, 9.0, -8.0));
	var[11][0] = (vec3(-6.0, -7.0, -1.0));
	var[11][1] = (vec3(8.0, 9.0, 3.0));
	var[11][2] = (vec3(0.0, -5.0, -7.0));
	var[12][0] = (vec3(4.0, 2.0, 9.0));
	var[12][1] = (vec3(-7.0, 2.0, 0.0));
	var[12][2] = (vec3(0.0, -4.0, 3.0));
	var[13][0] = (vec3(-7.0, -7.0, 1.0));
	var[13][1] = (vec3(1.0, -5.0, 0.0));
	var[13][2] = (vec3(5.0, -6.0, 7.0));
	var[14][0] = (vec3(-2.0, 8.0, -5.0));
	var[14][1] = (vec3(4.0, -8.0, 2.0));
	var[14][2] = (vec3(4.0, 2.0, -7.0));
	var[15][0] = (vec3(-5.0, 2.0, -4.0));
	var[15][1] = (vec3(0.0, 5.0, -5.0));
	var[15][2] = (vec3(3.0, 3.0, -8.0));
	var[16][0] = (vec3(0.0, -7.0, -2.0));
	var[16][1] = (vec3(-8.0, 3.0, -2.0));
	var[16][2] = (vec3(9.0, -7.0, -7.0));
	var[17][0] = (vec3(4.0, -6.0, -3.0));
	var[17][1] = (vec3(-9.0, -3.0, 8.0));
	var[17][2] = (vec3(-8.0, -1.0, -6.0));
	var[18][0] = (vec3(0.0, 5.0, 9.0));
	var[18][1] = (vec3(-2.0, -2.0, 3.0));
	var[18][2] = (vec3(-5.0, 3.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3], mat2x3(-2.0, -1.0, 3.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(5.0, 8.0, 1.0, -7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(0.0, 9.0, -1.0, -8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(-6.0, 9.0, 9.0, -2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(8.0, -6.0, -2.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(-2.0, -9.0, -1.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(-5.0, -9.0, -3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(-9.0, -1.0, -9.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(-6.0, -1.0, 7.0, -5.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(8.0, -7.0, 1.0, -9.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(3.0, 8.0, -5.0, -1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(9.0, -5.0, 0.0, 0.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(-8.0, -1.0, 3.0, -7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(-7.0, 6.0, -9.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(-7.0, 1.0, 7.0, 2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(5.0, -9.0, 5.0, 6.0, 6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	var[1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	var[2] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
	var[3] = (mat2x3(6.0, 9.0, 2.0, -3.0, 0.0, 5.0));
	var[4] = (mat2x3(-9.0, 6.0, -3.0, 9.0, -7.0, 2.0));
	var[5] = (mat2x3(8.0, -3.0, 7.0, -9.0, 7.0, -1.0));
	var[6] = (mat2x3(-4.0, -3.0, -6.0, -1.0, -5.0, 7.0));
	var[7] = (mat2x3(1.0, 9.0, -7.0, 3.0, 3.0, 1.0));
	var[8] = (mat2x3(-4.0, -9.0, 4.0, -1.0, -4.0, 1.0));
	var[9] = (mat2x3(-7.0, 0.0, -4.0, -6.0, -1.0, -1.0));
	var[10] = (mat2x3(5.0, -5.0, 0.0, -6.0, -9.0, -6.0));
	var[11] = (mat2x3(-2.0, -1.0, -6.0, -6.0, 3.0, -3.0));
	var[12] = (mat2x3(-1.0, -7.0, 4.0, 3.0, 8.0, -7.0));
	var[13] = (mat2x3(-1.0, -2.0, 2.0, 6.0, -5.0, 4.0));
	var[14] = (mat2x3(-8.0, 0.0, -4.0, 7.0, -5.0, -1.0));
	var[15] = (mat2x3(4.0, -6.0, -1.0, -4.0, 7.0, 8.0));
	var[16] = (mat2x3(-1.0, 4.0, -9.0, -3.0, -5.0, 8.0));
	var[17] = (mat2x3(5.0, -4.0, -4.0, 8.0, 6.0, 4.0));
	var[18] = (mat2x3(-9.0, -9.0, 0.0, 3.0, 6.0, -8.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat4x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(8.0, -5.0, -3.0, -5.0, 3.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-3.0, 9.0, 0.0, 7.0, 9.0, -6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-9.0, 3.0, -7.0, -8.0, 7.0, -1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(-7.0, 0.0, -1.0, -5.0, 7.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(-2.0, 4.0, 6.0, -4.0, 1.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(9.0, 0.0, 1.0, -9.0, -5.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(6.0, 1.0, -3.0, -1.0, -3.0, -9.0, -7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	var[1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	var[2] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
	var[3] = (mat4x2(-5.0, -9.0, -1.0, -9.0, 0.0, -4.0, 2.0, -7.0));
	var[4] = (mat4x2(-3.0, -5.0, 1.0, -5.0, -1.0, 7.0, 4.0, 4.0));
	var[5] = (mat4x2(-5.0, 2.0, -4.0, -3.0, 0.0, 4.0, -7.0, 5.0));
	var[6] = (mat4x2(1.0, -9.0, 0.0, -4.0, 2.0, 9.0, -5.0, -3.0));
	var[7] = (mat4x2(6.0, -4.0, -9.0, 5.0, -5.0, -6.0, 8.0, -5.0));
	var[8] = (mat4x2(-4.0, -5.0, 6.0, 9.0, -3.0, -4.0, 3.0, -7.0));
	var[9] = (mat4x2(-8.0, 8.0, -4.0, -6.0, 0.0, -3.0, -6.0, -4.0));
	var[10] = (mat4x2(5.0, 4.0, 5.0, 7.0, 2.0, -7.0, 8.0, -3.0));
	var[11] = (mat4x2(8.0, 7.0, 0.0, -5.0, 4.0, 5.0, -6.0, -8.0));
	var[12] = (mat4x2(-7.0, 4.0, -8.0, -6.0, -3.0, -4.0, 8.0, -4.0));
	var[13] = (mat4x2(6.0, -9.0, -7.0, -3.0, -9.0, -6.0, -3.0, -8.0));
	var[14] = (mat4x2(8.0, -4.0, -8.0, 4.0, 0.0, 4.0, -3.0, 8.0));
	var[15] = (mat4x2(0.0, 7.0, -2.0, -3.0, -5.0, 6.0, -2.0, 7.0));
	var[16] = (mat4x2(4.0, -1.0, 6.0, -2.0, 0.0, 7.0, 0.0, 2.0));
	var[17] = (mat4x2(-7.0, -7.0, -6.0, 8.0, -7.0, -4.0, 9.0, 9.0));
	var[18] = (mat4x2(4.0, -8.0, -6.0, -3.0, 8.0, -1.0, -5.0, 5.0));
}
#version 450
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

	var[0] = i16vec3(ivec3(6, 1, -2));
	var[1] = i16vec3(ivec3(-3, -1, -4));
	var[2] = i16vec3(ivec3(-2, -2, 2));
	var[3] = i16vec3(ivec3(0, -6, -2));
	var[4] = i16vec3(ivec3(0, -9, 2));
	var[5] = i16vec3(ivec3(-8, 6, 2));
	var[6] = i16vec3(ivec3(-5, -4, -8));
	var[7] = i16vec3(ivec3(0, 9, 6));
	var[8] = i16vec3(ivec3(5, -3, 4));
	var[9] = i16vec3(ivec3(-3, 9, 0));
	var[10] = i16vec3(ivec3(1, -5, 8));
	var[11] = i16vec3(ivec3(-5, 0, 7));
	var[12] = i16vec3(ivec3(-6, 7, -4));
	var[13] = i16vec3(ivec3(-8, 4, 1));
	var[14] = i16vec3(ivec3(5, -4, -6));
	var[15] = i16vec3(ivec3(-6, 2, -7));
	var[16] = i16vec3(ivec3(-2, 2, -5));
	var[17] = i16vec3(ivec3(-3, -1, 0));
	var[18] = i16vec3(ivec3(-6, 9, -3));
}
#version 450
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
	highp mat3 var[];
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
	allOk = compare_mat3(var[3], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(6.0, 2.0, -2.0, -8.0, 6.0, -8.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(2.0, -5.0, -3.0, 8.0, -9.0, -7.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(4.0, 7.0, -9.0, 5.0, 0.0, -7.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(-1.0, -3.0, 9.0, -3.0, 4.0, 3.0, 3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(6.0, 8.0, -8.0, 7.0, -1.0, 4.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(2.0, 8.0, 8.0, -5.0, 4.0, -5.0, 8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(8.0, 6.0, -5.0, 8.0, 3.0, 2.0, -2.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	var[1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	var[2] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
	var[3] = (mat3(8.0, -1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0));
	var[4] = (mat3(-2.0, 9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0));
	var[5] = (mat3(-9.0, -7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0));
	var[6] = (mat3(-2.0, 9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0));
	var[7] = (mat3(-5.0, 6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0));
	var[8] = (mat3(6.0, 6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0));
	var[9] = (mat3(-1.0, 6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0));
	var[10] = (mat3(3.0, -9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0));
	var[11] = (mat3(-6.0, -9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0));
	var[12] = (mat3(1.0, -8.0, 4.0, 5.0, 7.0, 9.0, 5.0, 8.0, -6.0));
	var[13] = (mat3(-9.0, -5.0, 9.0, 8.0, -9.0, -8.0, -5.0, 6.0, -7.0));
	var[14] = (mat3(2.0, 4.0, 5.0, -8.0, -2.0, 8.0, 6.0, 2.0, -9.0));
	var[15] = (mat3(-8.0, 1.0, -1.0, 7.0, -2.0, -3.0, 5.0, 3.0, 0.0));
	var[16] = (mat3(-1.0, -2.0, -3.0, 3.0, -9.0, -3.0, -4.0, -7.0, -5.0));
	var[17] = (mat3(-8.0, 9.0, 8.0, 8.0, 4.0, 5.0, 1.0, 8.0, 7.0));
	var[18] = (mat3(2.0, 2.0, -3.0, 0.0, 0.0, 9.0, 3.0, 9.0, 2.0));
}
#version 450
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
	highp vec2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var[0][0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((var[0][1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[0][2]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((var[1][0]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((var[1][1]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((var[1][2]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((var[2][0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((var[2][1]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((var[2][2]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((var[3][0]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[3][1]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((var[3][2]), vec2(-6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(3.0, 8.0));
	var[0][1] = (vec2(7.0, -1.0));
	var[0][2] = (vec2(-4.0, 8.0));
	var[1][0] = (vec2(-2.0, -5.0));
	var[1][1] = (vec2(-2.0, 5.0));
	var[1][2] = (vec2(6.0, -2.0));
	var[2][0] = (vec2(-6.0, -6.0));
	var[2][1] = (vec2(1.0, 6.0));
	var[2][2] = (vec2(-7.0, 6.0));
	var[3][0] = (vec2(1.0, -6.0));
	var[3][1] = (vec2(-9.0, 0.0));
	var[3][2] = (vec2(-8.0, -4.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(-5.0, -8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(1.0, 4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(4.0, 4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-2.0, 5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(-9.0, -7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(-5.0, -4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(-9.0, 2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(-5.0, 2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(6.0, 1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	var[0][1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	var[0][2] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
	var[1][0] = (mat2x4(-3.0, -9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0));
	var[1][1] = (mat2x4(-3.0, -3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0));
	var[1][2] = (mat2x4(4.0, 9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0));
	var[2][0] = (mat2x4(-6.0, 9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0));
	var[2][1] = (mat2x4(8.0, -6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0));
	var[2][2] = (mat2x4(-1.0, 2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0));
	var[3][0] = (mat2x4(2.0, 0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0));
	var[3][1] = (mat2x4(5.0, -8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0));
	var[3][2] = (mat2x4(4.0, 9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0));
}
#version 450
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
	highp uvec2 var[4][3];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var[0][0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((var[0][1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((var[0][2]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((var[1][0]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((var[1][1]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((var[1][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[2][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((var[2][1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((var[2][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[3][0]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((var[3][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((var[3][2]), uvec2(8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (uvec2(6u, 1u));
	var[0][1] = (uvec2(8u, 1u));
	var[0][2] = (uvec2(7u, 4u));
	var[1][0] = (uvec2(6u, 6u));
	var[1][1] = (uvec2(5u, 8u));
	var[1][2] = (uvec2(4u, 7u));
	var[2][0] = (uvec2(8u, 4u));
	var[2][1] = (uvec2(6u, 3u));
	var[2][2] = (uvec2(6u, 0u));
	var[3][0] = (uvec2(3u, 5u));
	var[3][1] = (uvec2(2u, 4u));
	var[3][2] = (uvec2(7u, 8u));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	highp mat4x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(3.0, -2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(-1.0, 0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(2.0, -2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(0.0, 7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(8.0, 8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(7.0, 4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(8.0, -7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(-4.0, 1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(2.0, -3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	var[0][1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	var[0][2] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
	var[1][0] = (mat4x2(8.0, 7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0));
	var[1][1] = (mat4x2(1.0, 6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0));
	var[1][2] = (mat4x2(3.0, -5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0));
	var[2][0] = (mat4x2(-4.0, 4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0));
	var[2][1] = (mat4x2(8.0, -4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0));
	var[2][2] = (mat4x2(-4.0, -8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0));
	var[3][0] = (mat4x2(-5.0, 7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0));
	var[3][1] = (mat4x2(6.0, -7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0));
	var[3][2] = (mat4x2(3.0, -8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0));
}
#version 450
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
	highp mat3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat3(var[0][0], mat3(-8.0, -3.0, -9.0, -1.0, 8.0, 8.0, 3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(1.0, 3.0, 0.0, -1.0, -1.0, -1.0, 5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(1.0, -7.0, 1.0, 3.0, 1.0, 1.0, 4.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(7.0, -9.0, -1.0, 5.0, -4.0, -7.0, -2.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(3.0, 0.0, 1.0, 6.0, 4.0, -7.0, 3.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(9.0, -3.0, 2.0, 4.0, 3.0, -9.0, 6.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(5.0, 7.0, -9.0, 3.0, -3.0, 8.0, 3.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(3.0, 4.0, -7.0, 5.0, -5.0, 5.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-9.0, -4.0, 5.0, 3.0, 1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(1.0, -5.0, 4.0, 2.0, -5.0, 1.0, 7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(7.0, 8.0, 5.0, 7.0, 0.0, 0.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(9.0, -5.0, 8.0, -5.0, -9.0, 7.0, -3.0, 8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (8.0);
	var[0][0][0] = (vec3(6.0, 2.0, -9.0));
	var[0][0][1] = (vec3(-8.0, 5.0, 2.0));
	var[0][0][2] = (vec3(3.0, 9.0, 3.0));
	var[0][1][0] = (vec3(2.0, -9.0, -5.0));
	var[0][1][1] = (vec3(5.0, 8.0, 8.0));
	var[0][1][2] = (vec3(-3.0, -4.0, -5.0));
	var[0][2][0] = (vec3(3.0, -5.0, -4.0));
	var[0][2][1] = (vec3(-7.0, 5.0, 3.0));
	var[0][2][2] = (vec3(-3.0, -3.0, -8.0));
	var[1][0][0] = (vec3(8.0, 2.0, -9.0));
	var[1][0][1] = (vec3(-3.0, 6.0, -3.0));
	var[1][0][2] = (vec3(7.0, 8.0, 7.0));
	var[1][1][0] = (vec3(-7.0, 6.0, -7.0));
	var[1][1][1] = (vec3(2.0, 3.0, -3.0));
	var[1][1][2] = (vec3(-3.0, 6.0, -1.0));
	var[1][2][0] = (vec3(8.0, 4.0, -3.0));
	var[1][2][1] = (vec3(8.0, -6.0, 4.0));
	var[1][2][2] = (vec3(-5.0, -1.0, 5.0));
	var[2][0][0] = (vec3(1.0, -3.0, -7.0));
	var[2][0][1] = (vec3(-5.0, 4.0, 1.0));
	var[2][0][2] = (vec3(9.0, -7.0, -3.0));
	var[2][1][0] = (vec3(-5.0, 6.0, 2.0));
	var[2][1][1] = (vec3(-9.0, -9.0, -1.0));
	var[2][1][2] = (vec3(-5.0, -8.0, 2.0));
	var[2][2][0] = (vec3(-6.0, 0.0, 3.0));
	var[2][2][1] = (vec3(9.0, -8.0, 3.0));
	var[2][2][2] = (vec3(8.0, -8.0, -9.0));
	var[3][0][0] = (vec3(6.0, -4.0, -8.0));
	var[3][0][1] = (vec3(3.0, 8.0, 1.0));
	var[3][0][2] = (vec3(9.0, 2.0, -9.0));
	var[3][1][0] = (vec3(-4.0, -1.0, -4.0));
	var[3][1][1] = (vec3(-6.0, 4.0, 9.0));
	var[3][1][2] = (vec3(-5.0, -7.0, -3.0));
	var[3][2][0] = (vec3(-9.0, -5.0, -9.0));
	var[3][2][1] = (vec3(-1.0, -9.0, 7.0));
	var[3][2][2] = (vec3(-9.0, 0.0, -4.0));
}
#version 450
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
	bool var[4][2][3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((var[0][0][0]), false) && allOk;
	allOk = compare_bool((var[0][0][1]), true) && allOk;
	allOk = compare_bool((var[0][0][2]), true) && allOk;
	allOk = compare_bool((var[0][1][0]), true) && allOk;
	allOk = compare_bool((var[0][1][1]), false) && allOk;
	allOk = compare_bool((var[0][1][2]), true) && allOk;
	allOk = compare_bool((var[1][0][0]), false) && allOk;
	allOk = compare_bool((var[1][0][1]), false) && allOk;
	allOk = compare_bool((var[1][0][2]), true) && allOk;
	allOk = compare_bool((var[1][1][0]), true) && allOk;
	allOk = compare_bool((var[1][1][1]), false) && allOk;
	allOk = compare_bool((var[1][1][2]), true) && allOk;
	allOk = compare_bool((var[2][0][0]), true) && allOk;
	allOk = compare_bool((var[2][0][1]), false) && allOk;
	allOk = compare_bool((var[2][0][2]), false) && allOk;
	allOk = compare_bool((var[2][1][0]), false) && allOk;
	allOk = compare_bool((var[2][1][1]), false) && allOk;
	allOk = compare_bool((var[2][1][2]), false) && allOk;
	allOk = compare_bool((var[3][0][0]), false) && allOk;
	allOk = compare_bool((var[3][0][1]), false) && allOk;
	allOk = compare_bool((var[3][0][2]), true) && allOk;
	allOk = compare_bool((var[3][1][0]), true) && allOk;
	allOk = compare_bool((var[3][1][1]), false) && allOk;
	allOk = compare_bool((var[3][1][2]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (false);
	var[0][0][1] = (false);
	var[0][0][2] = (true);
	var[0][1][0] = (false);
	var[0][1][1] = (false);
	var[0][1][2] = (true);
	var[1][0][0] = (true);
	var[1][0][1] = (false);
	var[1][0][2] = (false);
	var[1][1][0] = (false);
	var[1][1][1] = (true);
	var[1][1][2] = (false);
	var[2][0][0] = (true);
	var[2][0][1] = (true);
	var[2][0][2] = (true);
	var[2][1][0] = (true);
	var[2][1][1] = (true);
	var[2][1][2] = (true);
	var[3][0][0] = (true);
	var[3][0][1] = (false);
	var[3][0][2] = (false);
	var[3][1][0] = (true);
	var[3][1][1] = (true);
	var[3][1][2] = (false);
}
#version 450
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
	highp mat2x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(6.0, 0.0, 6.0, 8.0, -9.0, 4.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-9.0, -1.0, 7.0, 9.0, 0.0, -2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-8.0, 4.0, 8.0, 3.0, -3.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(9.0, -9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(6.0, -4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(0.0, -5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-9.0, 6.0, -4.0, -8.0, -5.0, -4.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-8.0, 0.0, 4.0, -6.0, 5.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-1.0, -2.0, 0.0, -7.0, 8.0, -2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-9.0, -1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(1.0, 2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(-8.0, 1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(9.0, -3.0, -7.0, 2.0, -4.0, -3.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(1.0, -8.0, -2.0, 6.0, 8.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(-7.0, 3.0, 5.0, -3.0, -6.0, 8.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(-7.0, -6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(-5.0, -2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(2.0, -3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(-6.0, -9.0, 7.0, 2.0, -1.0, 5.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(4.0, 2.0, 9.0, -9.0, -1.0, 9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(7.0, 8.0, 4.0, -3.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	var[0][0][1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	var[0][0][2] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
	var[0][1][0] = (mat2x4(8.0, 3.0, 0.0, -3.0, 5.0, -4.0, 8.0, -3.0));
	var[0][1][1] = (mat2x4(7.0, -1.0, 5.0, 0.0, -5.0, 2.0, -3.0, -8.0));
	var[0][1][2] = (mat2x4(-9.0, 5.0, -6.0, -2.0, 0.0, 0.0, -2.0, -9.0));
	var[1][0][0] = (mat2x4(-8.0, -9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0));
	var[1][0][1] = (mat2x4(-5.0, 8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0));
	var[1][0][2] = (mat2x4(-6.0, -7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0));
	var[1][1][0] = (mat2x4(3.0, -5.0, -5.0, -6.0, 3.0, 0.0, -2.0, 5.0));
	var[1][1][1] = (mat2x4(-9.0, -9.0, 4.0, -7.0, -9.0, -2.0, 5.0, 9.0));
	var[1][1][2] = (mat2x4(0.0, 6.0, -3.0, -4.0, 0.0, -2.0, 8.0, 1.0));
	var[2][0][0] = (mat2x4(0.0, -6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0));
	var[2][0][1] = (mat2x4(-5.0, 4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0));
	var[2][0][2] = (mat2x4(-4.0, -7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0));
	var[2][1][0] = (mat2x4(-3.0, -9.0, -7.0, -5.0, -2.0, 8.0, -8.0, -8.0));
	var[2][1][1] = (mat2x4(-5.0, 1.0, -1.0, 8.0, 3.0, 3.0, -4.0, 8.0));
	var[2][1][2] = (mat2x4(2.0, 5.0, -9.0, 0.0, -3.0, 2.0, -2.0, 9.0));
	var[3][0][0] = (mat2x4(-1.0, 7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0));
	var[3][0][1] = (mat2x4(-5.0, 3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0));
	var[3][0][2] = (mat2x4(5.0, 7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0));
	var[3][1][0] = (mat2x4(-7.0, -3.0, 5.0, -4.0, -2.0, 0.0, 2.0, -6.0));
	var[3][1][1] = (mat2x4(2.0, 3.0, 1.0, 6.0, -7.0, -8.0, -7.0, 9.0));
	var[3][1][2] = (mat2x4(-6.0, -2.0, -6.0, -8.0, -5.0, 7.0, 9.0, -5.0));
}
#version 450
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
	u8vec2 var[4][2][3];
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(var[0][0][0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][0][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][0][2]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][1][0]), uvec2(8u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][1][1]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][1][2]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][0][0]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][0][1]), uvec2(9u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][0][2]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][1][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][1][1]), uvec2(2u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][1][2]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][0][0]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][0][1]), uvec2(6u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][0][2]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][1][0]), uvec2(6u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][1][1]), uvec2(5u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][1][2]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][0][0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][0][1]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][0][2]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][1][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][1][1]), uvec2(7u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][1][2]), uvec2(3u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u8vec2(uvec2(7u, 7u));
	var[0][0][1] = u8vec2(uvec2(9u, 6u));
	var[0][0][2] = u8vec2(uvec2(0u, 2u));
	var[0][1][0] = u8vec2(uvec2(1u, 8u));
	var[0][1][1] = u8vec2(uvec2(4u, 0u));
	var[0][1][2] = u8vec2(uvec2(2u, 7u));
	var[1][0][0] = u8vec2(uvec2(1u, 1u));
	var[1][0][1] = u8vec2(uvec2(0u, 8u));
	var[1][0][2] = u8vec2(uvec2(8u, 5u));
	var[1][1][0] = u8vec2(uvec2(2u, 0u));
	var[1][1][1] = u8vec2(uvec2(2u, 5u));
	var[1][1][2] = u8vec2(uvec2(3u, 4u));
	var[2][0][0] = u8vec2(uvec2(2u, 7u));
	var[2][0][1] = u8vec2(uvec2(4u, 4u));
	var[2][0][2] = u8vec2(uvec2(7u, 2u));
	var[2][1][0] = u8vec2(uvec2(7u, 4u));
	var[2][1][1] = u8vec2(uvec2(0u, 1u));
	var[2][1][2] = u8vec2(uvec2(2u, 3u));
	var[3][0][0] = u8vec2(uvec2(4u, 5u));
	var[3][0][1] = u8vec2(uvec2(0u, 2u));
	var[3][0][2] = u8vec2(uvec2(1u, 8u));
	var[3][1][0] = u8vec2(uvec2(5u, 4u));
	var[3][1][1] = u8vec2(uvec2(4u, 2u));
	var[3][1][2] = u8vec2(uvec2(1u, 9u));
}
#version 450
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
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat3(var[0][0][0], mat3(-8.0, -3.0, -9.0, -1.0, 8.0, 8.0, 3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(1.0, 3.0, 0.0, -1.0, -1.0, -1.0, 5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(1.0, -7.0, 1.0, 3.0, 1.0, 1.0, 4.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(-4.0, -1.0, -2.0, 2.0, -4.0, -2.0, -7.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(5.0, 2.0, -2.0, 5.0, 7.0, 6.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(0.0, -1.0, 8.0, 6.0, -4.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(7.0, -9.0, -1.0, 5.0, -4.0, -7.0, -2.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(3.0, 0.0, 1.0, 6.0, 4.0, -7.0, 3.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(9.0, -3.0, 2.0, 4.0, 3.0, -9.0, 6.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(3.0, 3.0, -2.0, 9.0, 6.0, -1.0, 7.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(1.0, 0.0, -1.0, -5.0, 3.0, 3.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(4.0, 7.0, -5.0, 6.0, -1.0, -8.0, 4.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(5.0, 7.0, -9.0, 3.0, -3.0, 8.0, 3.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(3.0, 4.0, -7.0, 5.0, -5.0, 5.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-9.0, -4.0, 5.0, 3.0, 1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-6.0, -4.0, -4.0, 7.0, -9.0, -8.0, -5.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(-2.0, -6.0, -6.0, 1.0, 5.0, 8.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(5.0, 0.0, 4.0, 4.0, -2.0, 2.0, -1.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(1.0, -5.0, 4.0, 2.0, -5.0, 1.0, 7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(7.0, 8.0, 5.0, 7.0, 0.0, 0.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(9.0, -5.0, 8.0, -5.0, -9.0, 7.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(-6.0, 5.0, -7.0, -5.0, -1.0, -1.0, -1.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(6.0, 0.0, 5.0, 6.0, -4.0, -8.0, 8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(-6.0, -7.0, -9.0, -5.0, -2.0, -5.0, 7.0, 3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (8.0);
	var[0][0][0][0] = (vec3(6.0, 2.0, -9.0));
	var[0][0][0][1] = (vec3(-8.0, 5.0, 2.0));
	var[0][0][0][2] = (vec3(3.0, 9.0, 3.0));
	var[0][0][1][0] = (vec3(2.0, -9.0, -5.0));
	var[0][0][1][1] = (vec3(5.0, 8.0, 8.0));
	var[0][0][1][2] = (vec3(-3.0, -4.0, -5.0));
	var[0][0][2][0] = (vec3(3.0, -5.0, -4.0));
	var[0][0][2][1] = (vec3(-7.0, 5.0, 3.0));
	var[0][0][2][2] = (vec3(-3.0, -3.0, -8.0));
	var[0][1][0][0] = (vec3(1.0, 7.0, -5.0));
	var[0][1][0][1] = (vec3(7.0, 9.0, 4.0));
	var[0][1][0][2] = (vec3(8.0, 7.0, -2.0));
	var[0][1][1][0] = (vec3(-8.0, -6.0, 7.0));
	var[0][1][1][1] = (vec3(-3.0, 2.0, -5.0));
	var[0][1][1][2] = (vec3(2.0, 1.0, -6.0));
	var[0][1][2][0] = (vec3(1.0, 3.0, -7.0));
	var[0][1][2][1] = (vec3(6.0, -8.0, 4.0));
	var[0][1][2][2] = (vec3(6.0, -7.0, -3.0));
	var[1][0][0][0] = (vec3(8.0, 2.0, -9.0));
	var[1][0][0][1] = (vec3(-3.0, 6.0, -3.0));
	var[1][0][0][2] = (vec3(7.0, 8.0, 7.0));
	var[1][0][1][0] = (vec3(-7.0, 6.0, -7.0));
	var[1][0][1][1] = (vec3(2.0, 3.0, -3.0));
	var[1][0][1][2] = (vec3(-3.0, 6.0, -1.0));
	var[1][0][2][0] = (vec3(8.0, 4.0, -3.0));
	var[1][0][2][1] = (vec3(8.0, -6.0, 4.0));
	var[1][0][2][2] = (vec3(-5.0, -1.0, 5.0));
	var[1][1][0][0] = (vec3(-5.0, -8.0, 8.0));
	var[1][1][0][1] = (vec3(7.0, 2.0, -3.0));
	var[1][1][0][2] = (vec3(-8.0, 3.0, 3.0));
	var[1][1][1][0] = (vec3(-1.0, 6.0, 7.0));
	var[1][1][1][1] = (vec3(9.0, -1.0, 2.0));
	var[1][1][1][2] = (vec3(-1.0, -6.0, -9.0));
	var[1][1][2][0] = (vec3(4.0, 9.0, 5.0));
	var[1][1][2][1] = (vec3(5.0, 4.0, -9.0));
	var[1][1][2][2] = (vec3(-6.0, 9.0, 3.0));
	var[2][0][0][0] = (vec3(1.0, -3.0, -7.0));
	var[2][0][0][1] = (vec3(-5.0, 4.0, 1.0));
	var[2][0][0][2] = (vec3(9.0, -7.0, -3.0));
	var[2][0][1][0] = (vec3(-5.0, 6.0, 2.0));
	var[2][0][1][1] = (vec3(-9.0, -9.0, -1.0));
	var[2][0][1][2] = (vec3(-5.0, -8.0, 2.0));
	var[2][0][2][0] = (vec3(-6.0, 0.0, 3.0));
	var[2][0][2][1] = (vec3(9.0, -8.0, 3.0));
	var[2][0][2][2] = (vec3(8.0, -8.0, -9.0));
	var[2][1][0][0] = (vec3(1.0, -2.0, 0.0));
	var[2][1][0][1] = (vec3(-9.0, 5.0, 1.0));
	var[2][1][0][2] = (vec3(3.0, 8.0, -2.0));
	var[2][1][1][0] = (vec3(-3.0, 7.0, -8.0));
	var[2][1][1][1] = (vec3(0.0, 1.0, -3.0));
	var[2][1][1][2] = (vec3(0.0, 0.0, -7.0));
	var[2][1][2][0] = (vec3(-2.0, -1.0, -5.0));
	var[2][1][2][1] = (vec3(-1.0, 4.0, -2.0));
	var[2][1][2][2] = (vec3(1.0, 4.0, -9.0));
	var[3][0][0][0] = (vec3(6.0, -4.0, -8.0));
	var[3][0][0][1] = (vec3(3.0, 8.0, 1.0));
	var[3][0][0][2] = (vec3(9.0, 2.0, -9.0));
	var[3][0][1][0] = (vec3(-4.0, -1.0, -4.0));
	var[3][0][1][1] = (vec3(-6.0, 4.0, 9.0));
	var[3][0][1][2] = (vec3(-5.0, -7.0, -3.0));
	var[3][0][2][0] = (vec3(-9.0, -5.0, -9.0));
	var[3][0][2][1] = (vec3(-1.0, -9.0, 7.0));
	var[3][0][2][2] = (vec3(-9.0, 0.0, -4.0));
	var[3][1][0][0] = (vec3(-4.0, 8.0, 0.0));
	var[3][1][0][1] = (vec3(-5.0, -4.0, 2.0));
	var[3][1][0][2] = (vec3(-3.0, 6.0, -8.0));
	var[3][1][1][0] = (vec3(-8.0, 8.0, 0.0));
	var[3][1][1][1] = (vec3(-8.0, -6.0, -9.0));
	var[3][1][1][2] = (vec3(0.0, -8.0, 1.0));
	var[3][1][2][0] = (vec3(-2.0, 9.0, -6.0));
	var[3][1][2][1] = (vec3(-2.0, 6.0, 0.0));
	var[3][1][2][2] = (vec3(3.0, 8.0, 4.0));
}
#version 450
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
	highp mat2x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(-8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(2.0, -4.0, -7.0, -8.0, -5.0, 9.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(5.0, 4.0, -5.0, 1.0, -3.0, -3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-8.0, -5.0, -3.0, -6.0, -1.0, -1.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(-7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(-8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-8.0, -6.0, -8.0, 7.0, 8.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(5.0, 0.0, 5.0, -4.0, -9.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(3.0, -9.0, 0.0, 2.0, -8.0, -7.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-5.0, -6.0, -5.0, 5.0, 1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(-6.0, -1.0, -2.0, -4.0, 3.0, -7.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(6.0, -6.0, 3.0, -7.0, -1.0, -5.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(-4.0, -7.0, -3.0, -8.0, -2.0, 2.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(8.0, 9.0, -5.0, -4.0, -9.0, -4.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(-2.0, -5.0, 3.0, 7.0, -8.0, -6.0, 5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0][0][0] = (mat2x4(9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0, -1.0));
	var[0][0][1] = (mat2x4(-4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0, 9.0));
	var[0][0][2] = (mat2x4(-9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0, -7.0));
	var[0][1][0] = (mat2x4(-5.0, -6.0, -8.0, -5.0, 3.0, -4.0, -5.0, -3.0));
	var[0][1][1] = (mat2x4(-5.0, 7.0, -7.0, 7.0, 8.0, 6.0, 7.0, -8.0));
	var[0][1][2] = (mat2x4(2.0, 0.0, 3.0, 7.0, 9.0, 3.0, 0.0, -9.0));
	var[1][0][0] = (mat2x4(-4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0, 0.0));
	var[1][0][1] = (mat2x4(-4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0, 3.0));
	var[1][0][2] = (mat2x4(-8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0, 4.0));
	var[1][1][0] = (mat2x4(1.0, -3.0, 3.0, 2.0, 9.0, -5.0, 3.0, 4.0));
	var[1][1][1] = (mat2x4(1.0, 6.0, 5.0, 6.0, -8.0, 9.0, -8.0, -6.0));
	var[1][1][2] = (mat2x4(-7.0, 0.0, -1.0, -3.0, -5.0, -4.0, 3.0, -7.0));
	var[2][0][0] = (mat2x4(-7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0, -2.0));
	var[2][0][1] = (mat2x4(1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0, -8.0));
	var[2][0][2] = (mat2x4(7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0, 2.0));
	var[2][1][0] = (mat2x4(-3.0, -2.0, -2.0, -6.0, -7.0, 1.0, 6.0, 0.0));
	var[2][1][1] = (mat2x4(7.0, 8.0, 8.0, 2.0, -2.0, 6.0, -8.0, 5.0));
	var[2][1][2] = (mat2x4(-2.0, 5.0, -9.0, -1.0, 4.0, 6.0, 1.0, 6.0));
	var[3][0][0] = (mat2x4(9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0, 5.0));
	var[3][0][1] = (mat2x4(-9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0, -6.0));
	var[3][0][2] = (mat2x4(-9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0, 7.0));
	var[3][1][0] = (mat2x4(-8.0, 1.0, -8.0, -1.0, 0.0, -1.0, 9.0, -7.0));
	var[3][1][1] = (mat2x4(0.0, 8.0, 0.0, -6.0, 3.0, -9.0, -7.0, 0.0));
	var[3][1][2] = (mat2x4(2.0, -7.0, -2.0, -3.0, 9.0, 7.0, 7.0, 8.0));
}
#version 450
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
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-8.0, -3.0, -8.0, 8.0, -2.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(3.0, -6.0, 9.0, -3.0, 1.0, 0.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(2.0, -4.0, 5.0, -1.0, 4.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(4.0, 5.0, 5.0, -3.0, -8.0, 6.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(9.0, 7.0, 0.0, -4.0, -2.0, 3.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-5.0, -8.0, 4.0, 8.0, -8.0, 3.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(6.0, 3.0, 4.0, -9.0, -7.0, -6.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(6.0, -7.0, -3.0, -9.0, -7.0, 0.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(-4.0, 6.0, -2.0, 8.0, -2.0, -3.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(9.0, 7.0, 4.0, -4.0, 3.0, -7.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(1.0, 7.0, -8.0, -4.0, 2.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(7.0, 2.0, -4.0, -5.0, 8.0, -1.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-7.0, -5.0, 1.0, 8.0, 2.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(5.0, -2.0, -2.0, -7.0, 4.0, -2.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(-9.0, 1.0, -5.0, -1.0, -5.0, -5.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(1.0, 9.0, -9.0, -3.0, -3.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(4.0, -4.0, -2.0, -3.0, 7.0, -3.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(-6.0, -4.0, -7.0, -7.0, 4.0, -2.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(-1.0, 8.0, -9.0, -8.0, 8.0, -1.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(-1.0, -9.0, -2.0, -3.0, -9.0, -2.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(-7.0, 7.0, 5.0, 3.0, 8.0, -1.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(5.0, -5.0, -7.0, -8.0, -1.0, 6.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(8.0, -1.0, -2.0, 8.0, 7.0, 4.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(4.0, 8.0, -5.0, 1.0, 3.0, -4.0, 5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0][0][0] = (vec4(-4.0, -6.0, -3.0, 6.0));
	var[0][0][0][1] = (vec4(4.0, -6.0, 2.0, -5.0));
	var[0][0][1][0] = (vec4(1.0, 7.0, 0.0, 9.0));
	var[0][0][1][1] = (vec4(1.0, 6.0, 1.0, 8.0));
	var[0][0][2][0] = (vec4(-6.0, 5.0, 5.0, -6.0));
	var[0][0][2][1] = (vec4(6.0, -7.0, -4.0, 5.0));
	var[0][1][0][0] = (vec4(7.0, 6.0, 4.0, 7.0));
	var[0][1][0][1] = (vec4(0.0, -1.0, 5.0, -6.0));
	var[0][1][1][0] = (vec4(-5.0, -5.0, -6.0, 8.0));
	var[0][1][1][1] = (vec4(5.0, -9.0, 9.0, 2.0));
	var[0][1][2][0] = (vec4(3.0, 5.0, 5.0, 8.0));
	var[0][1][2][1] = (vec4(4.0, 8.0, 5.0, 2.0));
	var[1][0][0][0] = (vec4(-8.0, 6.0, 9.0, 4.0));
	var[1][0][0][1] = (vec4(-4.0, 0.0, 2.0, -8.0));
	var[1][0][1][0] = (vec4(-7.0, 4.0, 2.0, -2.0));
	var[1][0][1][1] = (vec4(0.0, -2.0, -3.0, 2.0));
	var[1][0][2][0] = (vec4(-7.0, 3.0, -4.0, -7.0));
	var[1][0][2][1] = (vec4(3.0, 8.0, -9.0, -3.0));
	var[1][1][0][0] = (vec4(-3.0, 0.0, 2.0, -7.0));
	var[1][1][0][1] = (vec4(7.0, -5.0, -9.0, 4.0));
	var[1][1][1][0] = (vec4(-6.0, 1.0, -4.0, -8.0));
	var[1][1][1][1] = (vec4(-2.0, 4.0, 5.0, 5.0));
	var[1][1][2][0] = (vec4(2.0, 1.0, -2.0, 2.0));
	var[1][1][2][1] = (vec4(2.0, 2.0, 4.0, 1.0));
	var[2][0][0][0] = (vec4(-8.0, 6.0, 0.0, 4.0));
	var[2][0][0][1] = (vec4(-1.0, -6.0, -2.0, 0.0));
	var[2][0][1][0] = (vec4(3.0, -7.0, -4.0, 3.0));
	var[2][0][1][1] = (vec4(-8.0, -6.0, 7.0, -8.0));
	var[2][0][2][0] = (vec4(5.0, -9.0, 7.0, 7.0));
	var[2][0][2][1] = (vec4(2.0, 8.0, -7.0, 6.0));
	var[2][1][0][0] = (vec4(1.0, -2.0, 4.0, 5.0));
	var[2][1][0][1] = (vec4(4.0, 2.0, 8.0, 0.0));
	var[2][1][1][0] = (vec4(-7.0, -6.0, -1.0, 7.0));
	var[2][1][1][1] = (vec4(7.0, 8.0, 6.0, -1.0));
	var[2][1][2][0] = (vec4(-6.0, 4.0, 0.0, 8.0));
	var[2][1][2][1] = (vec4(-9.0, 8.0, 3.0, 0.0));
	var[3][0][0][0] = (vec4(0.0, 8.0, -1.0, -1.0));
	var[3][0][0][1] = (vec4(7.0, -7.0, 4.0, 4.0));
	var[3][0][1][0] = (vec4(9.0, 0.0, 5.0, -9.0));
	var[3][0][1][1] = (vec4(-5.0, 4.0, 6.0, 2.0));
	var[3][0][2][0] = (vec4(1.0, 2.0, 2.0, -6.0));
	var[3][0][2][1] = (vec4(0.0, -8.0, 6.0, 5.0));
	var[3][1][0][0] = (vec4(-1.0, 1.0, 1.0, 7.0));
	var[3][1][0][1] = (vec4(9.0, 6.0, 5.0, 6.0));
	var[3][1][1][0] = (vec4(-7.0, -4.0, -9.0, 7.0));
	var[3][1][1][1] = (vec4(-6.0, -7.0, 9.0, -2.0));
	var[3][1][2][0] = (vec4(1.0, 7.0, 7.0, -3.0));
	var[3][1][2][1] = (vec4(4.0, -8.0, -3.0, -9.0));
}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(5.0, 7.0, 1.0, -5.0, 5.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-7.0, -4.0, 7.0, 7.0, 5.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(-9.0, -7.0, -1.0, 8.0, 0.0, 4.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-9.0, 4.0, -2.0, 2.0, 8.0, -8.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-5.0, 3.0, 2.0, -1.0, 2.0, 1.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(-5.0, 0.0, 7.0, 6.0, 9.0, -7.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-5.0, -3.0, 4.0, 7.0, -4.0, -5.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(9.0, 2.0, -1.0, -1.0, 7.0, 2.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(4.0, 4.0, 9.0, -9.0, -2.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-5.0, 2.0, 3.0, -3.0, -6.0, -3.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-9.0, 8.0, 8.0, -7.0, 8.0, -9.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(-1.0, 0.0, 6.0, -2.0, -3.0, -2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(5.0, -8.0, 2.0, 3.0, 3.0, 2.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-8.0, -3.0, -1.0, 4.0, -8.0, -4.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(-7.0, 1.0, 0.0, -9.0, -6.0, 6.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-2.0, 4.0, 1.0, -8.0, 8.0, -1.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-5.0, 6.0, -2.0, -2.0, -9.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(7.0, -1.0, 5.0, 0.0, -1.0, 5.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(-8.0, 5.0, -3.0, 8.0, 6.0, -4.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(5.0, -2.0, -8.0, -1.0, 4.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(1.0, 5.0, -3.0, -4.0, 7.0, -7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(-2.0, -8.0, 3.0, -3.0, 5.0, 9.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(-2.0, 5.0, -6.0, 7.0, -7.0, -8.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(0.0, -7.0, 2.0, -2.0, 6.0, -2.0, -4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0][0][0][0] = (vec2(-4.0, -4.0));
	var[0][0][0][1] = (vec2(2.0, 0.0));
	var[0][0][0][2] = (vec2(-7.0, 3.0));
	var[0][0][0][3] = (vec2(9.0, 9.0));
	var[0][0][1][0] = (vec2(8.0, -9.0));
	var[0][0][1][1] = (vec2(-9.0, -6.0));
	var[0][0][1][2] = (vec2(-4.0, -6.0));
	var[0][0][1][3] = (vec2(-6.0, -8.0));
	var[0][0][2][0] = (vec2(6.0, -8.0));
	var[0][0][2][1] = (vec2(-8.0, 3.0));
	var[0][0][2][2] = (vec2(2.0, 8.0));
	var[0][0][2][3] = (vec2(5.0, -8.0));
	var[0][1][0][0] = (vec2(5.0, -5.0));
	var[0][1][0][1] = (vec2(3.0, 4.0));
	var[0][1][0][2] = (vec2(-9.0, 1.0));
	var[0][1][0][3] = (vec2(-3.0, 0.0));
	var[0][1][1][0] = (vec2(-8.0, 3.0));
	var[0][1][1][1] = (vec2(-7.0, 9.0));
	var[0][1][1][2] = (vec2(-8.0, -7.0));
	var[0][1][1][3] = (vec2(8.0, 7.0));
	var[0][1][2][0] = (vec2(-1.0, -2.0));
	var[0][1][2][1] = (vec2(-8.0, -3.0));
	var[0][1][2][2] = (vec2(9.0, -1.0));
	var[0][1][2][3] = (vec2(1.0, -2.0));
	var[1][0][0][0] = (vec2(-3.0, 0.0));
	var[1][0][0][1] = (vec2(7.0, 5.0));
	var[1][0][0][2] = (vec2(-8.0, 5.0));
	var[1][0][0][3] = (vec2(-1.0, 7.0));
	var[1][0][1][0] = (vec2(4.0, -2.0));
	var[1][0][1][1] = (vec2(4.0, -2.0));
	var[1][0][1][2] = (vec2(-2.0, 9.0));
	var[1][0][1][3] = (vec2(8.0, 4.0));
	var[1][0][2][0] = (vec2(-5.0, -5.0));
	var[1][0][2][1] = (vec2(-6.0, 8.0));
	var[1][0][2][2] = (vec2(9.0, -5.0));
	var[1][0][2][3] = (vec2(-4.0, -2.0));
	var[1][1][0][0] = (vec2(-8.0, -7.0));
	var[1][1][0][1] = (vec2(-5.0, 7.0));
	var[1][1][0][2] = (vec2(-5.0, -7.0));
	var[1][1][0][3] = (vec2(1.0, -5.0));
	var[1][1][1][0] = (vec2(-4.0, 8.0));
	var[1][1][1][1] = (vec2(-7.0, 6.0));
	var[1][1][1][2] = (vec2(5.0, 2.0));
	var[1][1][1][3] = (vec2(2.0, -5.0));
	var[1][1][2][0] = (vec2(-9.0, 7.0));
	var[1][1][2][1] = (vec2(-3.0, -3.0));
	var[1][1][2][2] = (vec2(-7.0, -4.0));
	var[1][1][2][3] = (vec2(3.0, 3.0));
	var[2][0][0][0] = (vec2(6.0, -2.0));
	var[2][0][0][1] = (vec2(2.0, -5.0));
	var[2][0][0][2] = (vec2(3.0, -3.0));
	var[2][0][0][3] = (vec2(1.0, -6.0));
	var[2][0][1][0] = (vec2(-6.0, -7.0));
	var[2][0][1][1] = (vec2(9.0, 1.0));
	var[2][0][1][2] = (vec2(-4.0, 3.0));
	var[2][0][1][3] = (vec2(-4.0, 7.0));
	var[2][0][2][0] = (vec2(7.0, -4.0));
	var[2][0][2][1] = (vec2(8.0, -2.0));
	var[2][0][2][2] = (vec2(9.0, 0.0));
	var[2][0][2][3] = (vec2(-9.0, -9.0));
	var[2][1][0][0] = (vec2(-6.0, -7.0));
	var[2][1][0][1] = (vec2(-7.0, 5.0));
	var[2][1][0][2] = (vec2(-8.0, 4.0));
	var[2][1][0][3] = (vec2(7.0, 4.0));
	var[2][1][1][0] = (vec2(-6.0, -9.0));
	var[2][1][1][1] = (vec2(7.0, 7.0));
	var[2][1][1][2] = (vec2(-2.0, 6.0));
	var[2][1][1][3] = (vec2(-5.0, 1.0));
	var[2][1][2][0] = (vec2(7.0, 6.0));
	var[2][1][2][1] = (vec2(-4.0, 2.0));
	var[2][1][2][2] = (vec2(1.0, 5.0));
	var[2][1][2][3] = (vec2(-9.0, -8.0));
	var[3][0][0][0] = (vec2(1.0, 4.0));
	var[3][0][0][1] = (vec2(-7.0, 9.0));
	var[3][0][0][2] = (vec2(-5.0, 2.0));
	var[3][0][0][3] = (vec2(7.0, -9.0));
	var[3][0][1][0] = (vec2(-8.0, 5.0));
	var[3][0][1][1] = (vec2(-2.0, -8.0));
	var[3][0][1][2] = (vec2(7.0, -6.0));
	var[3][0][1][3] = (vec2(-3.0, -7.0));
	var[3][0][2][0] = (vec2(-3.0, 7.0));
	var[3][0][2][1] = (vec2(6.0, -5.0));
	var[3][0][2][2] = (vec2(9.0, -2.0));
	var[3][0][2][3] = (vec2(1.0, -9.0));
	var[3][1][0][0] = (vec2(-6.0, 4.0));
	var[3][1][0][1] = (vec2(4.0, 7.0));
	var[3][1][0][2] = (vec2(-7.0, -9.0));
	var[3][1][0][3] = (vec2(-6.0, 7.0));
	var[3][1][1][0] = (vec2(8.0, -8.0));
	var[3][1][1][1] = (vec2(-6.0, -7.0));
	var[3][1][1][2] = (vec2(-4.0, -2.0));
	var[3][1][1][3] = (vec2(-6.0, -9.0));
	var[3][1][2][0] = (vec2(4.0, -6.0));
	var[3][1][2][1] = (vec2(2.0, 3.0));
	var[3][1][2][2] = (vec2(6.0, 8.0));
	var[3][1][2][3] = (vec2(9.0, -8.0));
}
#version 450
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
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(6.0, 7.0, 9.0, 7.0, 0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(7.0, -7.0, 1.0, 0.0, -9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(-2.0, -2.0, 7.0, -9.0, 3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(-9.0, 0.0, -2.0, -3.0, 4.0, -7.0, 8.0, -2.0, -7.0, -1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(0.0, 8.0, -8.0, -9.0, 5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(9.0, -4.0, -6.0, 0.0, 0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(6.0, 7.0, 1.0, 5.0, 4.0, 9.0, 5.0, 4.0, 9.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(1.0, 0.0, -7.0, -4.0, -3.0, 3.0, -7.0, 4.0, 1.0, 0.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(5.0, 2.0, -1.0, 1.0, 1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(-5.0, 1.0, 4.0, 5.0, 5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-1.0, 9.0, 4.0, -7.0, -2.0, 8.0, 8.0, 5.0, 3.0, -7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(-8.0, -3.0, 1.0, -8.0, -6.0, 9.0, 2.0, 4.0, 4.0, 1.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	var[0][0][0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	var[0][0][0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	var[0][0][1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	var[0][0][1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	var[0][0][1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	var[0][1][0][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	var[0][1][0][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	var[0][1][0][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	var[0][1][1][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	var[0][1][1][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	var[0][1][1][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	var[0][2][0][0] = (vec4(6.0, 2.0, 8.0, -5.0));
	var[0][2][0][1] = (vec4(9.0, 5.0, 9.0, -1.0));
	var[0][2][0][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[0][2][1][0] = (vec4(0.0, -4.0, 7.0, 1.0));
	var[0][2][1][1] = (vec4(4.0, 1.0, 9.0, 9.0));
	var[0][2][1][2] = (vec4(-9.0, -5.0, 3.0, 8.0));
	var[0][3][0][0] = (vec4(1.0, -1.0, -4.0, 2.0));
	var[0][3][0][1] = (vec4(5.0, 8.0, 5.0, -9.0));
	var[0][3][0][2] = (vec4(7.0, -9.0, 0.0, -3.0));
	var[0][3][1][0] = (vec4(-6.0, 6.0, -6.0, -5.0));
	var[0][3][1][1] = (vec4(5.0, 3.0, 4.0, 8.0));
	var[0][3][1][2] = (vec4(7.0, 0.0, -5.0, -6.0));
	var[1][0][0][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	var[1][0][0][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	var[1][0][0][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	var[1][0][1][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	var[1][0][1][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	var[1][0][1][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	var[1][1][0][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	var[1][1][0][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	var[1][1][0][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	var[1][1][1][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	var[1][1][1][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	var[1][1][1][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	var[1][2][0][0] = (vec4(4.0, -1.0, -2.0, 2.0));
	var[1][2][0][1] = (vec4(-5.0, 4.0, -2.0, -4.0));
	var[1][2][0][2] = (vec4(8.0, -7.0, -1.0, -9.0));
	var[1][2][1][0] = (vec4(8.0, 5.0, 3.0, 6.0));
	var[1][2][1][1] = (vec4(0.0, 6.0, 0.0, 2.0));
	var[1][2][1][2] = (vec4(-1.0, -5.0, -6.0, -4.0));
	var[1][3][0][0] = (vec4(5.0, 0.0, 8.0, 4.0));
	var[1][3][0][1] = (vec4(3.0, -1.0, -7.0, 0.0));
	var[1][3][0][2] = (vec4(-1.0, 6.0, -6.0, 1.0));
	var[1][3][1][0] = (vec4(0.0, 8.0, 0.0, 9.0));
	var[1][3][1][1] = (vec4(-6.0, 8.0, -5.0, -1.0));
	var[1][3][1][2] = (vec4(0.0, 6.0, -9.0, 9.0));
	var[2][0][0][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	var[2][0][0][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	var[2][0][0][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	var[2][0][1][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	var[2][0][1][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	var[2][0][1][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	var[2][1][0][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	var[2][1][0][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	var[2][1][0][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	var[2][1][1][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	var[2][1][1][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	var[2][1][1][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
	var[2][2][0][0] = (vec4(-3.0, -5.0, -4.0, -4.0));
	var[2][2][0][1] = (vec4(-8.0, -8.0, 1.0, 7.0));
	var[2][2][0][2] = (vec4(-6.0, -3.0, -7.0, 1.0));
	var[2][2][1][0] = (vec4(-5.0, 5.0, 0.0, 1.0));
	var[2][2][1][1] = (vec4(6.0, 2.0, 5.0, 5.0));
	var[2][2][1][2] = (vec4(5.0, -1.0, -7.0, -1.0));
	var[2][3][0][0] = (vec4(8.0, -2.0, -5.0, 0.0));
	var[2][3][0][1] = (vec4(1.0, 4.0, -3.0, -6.0));
	var[2][3][0][2] = (vec4(2.0, -2.0, -2.0, 3.0));
	var[2][3][1][0] = (vec4(-5.0, -4.0, -6.0, 2.0));
	var[2][3][1][1] = (vec4(-6.0, 0.0, 1.0, 9.0));
	var[2][3][1][2] = (vec4(2.0, 5.0, -8.0, 5.0));
}
#version 450
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
	f16vec3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(var[0][0][0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][0][1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][1][0]), vec3(1.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][1][1]), vec3(-7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][2][0]), vec3(-1.0, -7.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][2][1]), vec3(2.0, 6.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][3][0]), vec3(8.0, 2.0, 0.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][3][1]), vec3(-1.0, 2.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][0][0]), vec3(4.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][0][1]), vec3(4.0, 4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][1][0]), vec3(-8.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][1][1]), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][2][0]), vec3(-5.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][2][1]), vec3(5.0, 4.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][3][0]), vec3(-4.0, -8.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][3][1]), vec3(5.0, 7.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][0][0]), vec3(2.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][0][1]), vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][1][0]), vec3(-4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][1][1]), vec3(-8.0, 6.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][2][0]), vec3(6.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][2][1]), vec3(6.0, -8.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][3][0]), vec3(6.0, -9.0, -6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][3][1]), vec3(0.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = f16vec3(vec3(3.0, 3.0, 7.0));
	var[0][0][1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	var[0][1][0] = f16vec3(vec3(-5.0, -4.0, 6.0));
	var[0][1][1] = f16vec3(vec3(-3.0, -7.0, -4.0));
	var[0][2][0] = f16vec3(vec3(6.0, 6.0, -6.0));
	var[0][2][1] = f16vec3(vec3(-3.0, 1.0, -5.0));
	var[0][3][0] = f16vec3(vec3(2.0, -5.0, -9.0));
	var[0][3][1] = f16vec3(vec3(-8.0, 4.0, 1.0));
	var[1][0][0] = f16vec3(vec3(-1.0, 0.0, 6.0));
	var[1][0][1] = f16vec3(vec3(5.0, -7.0, 2.0));
	var[1][1][0] = f16vec3(vec3(-4.0, 5.0, 0.0));
	var[1][1][1] = f16vec3(vec3(-6.0, 4.0, -1.0));
	var[1][2][0] = f16vec3(vec3(6.0, 9.0, 7.0));
	var[1][2][1] = f16vec3(vec3(2.0, 5.0, 3.0));
	var[1][3][0] = f16vec3(vec3(-9.0, -5.0, 5.0));
	var[1][3][1] = f16vec3(vec3(-3.0, -6.0, 0.0));
	var[2][0][0] = f16vec3(vec3(9.0, 1.0, -5.0));
	var[2][0][1] = f16vec3(vec3(-5.0, 5.0, 2.0));
	var[2][1][0] = f16vec3(vec3(-2.0, 3.0, -8.0));
	var[2][1][1] = f16vec3(vec3(-4.0, -2.0, 4.0));
	var[2][2][0] = f16vec3(vec3(9.0, -8.0, 2.0));
	var[2][2][1] = f16vec3(vec3(-7.0, -8.0, -3.0));
	var[2][3][0] = f16vec3(vec3(-3.0, 9.0, -1.0));
	var[2][3][1] = f16vec3(vec3(-9.0, 0.0, -5.0));
}
#version 450
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

	s.a = (ivec3(-5, -2, 8));
	s.b[0] = (mat3(8.0, -7.0, 8.0, -2.0, -2.0, -6.0, 6.0, 0.0, -6.0));
	s.b[1] = (mat3(-4.0, 3.0, -6.0, -4.0, -4.0, -3.0, -6.0, 0.0, -2.0));
	s.b[2] = (mat3(-1.0, -2.0, -2.0, -8.0, 7.0, -6.0, 9.0, -2.0, -5.0));
	s.b[3] = (mat3(7.0, -9.0, -9.0, 8.0, 1.0, 9.0, -5.0, -4.0, 1.0));
	s.c = (vec4(-6.0, 7.0, 8.0, -2.0));
}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(-4, -5, 3)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-2.0, -7.0, 6.0, -3.0, 7.0, 5.0, -8.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(2.0, -7.0, -2.0, -2.0, -2.0, 1.0, -4.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(-8.0, -8.0, -3.0, 0.0, -4.0, 9.0, 1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(-9.0, 3.0, -7.0, -4.0, -4.0, -1.0, 6.0, -1.0, -3.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(-4.0, -8.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3(t.a, mat3(-4.0, 1.0, 1.0, -7.0, 9.0, -9.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_ivec3((t.b.a), ivec3(3, -1, -5)) && allOk;
	allOk = compare_mat3(t.b.b[0], mat3(-6.0, 0.0, -7.0, 8.0, -3.0, 1.0, -5.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3(t.b.b[1], mat3(1.0, -6.0, 3.0, 0.0, -6.0, 8.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3(t.b.b[2], mat3(-6.0, -6.0, -4.0, 9.0, 2.0, -1.0, 8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3(t.b.b[3], mat3(-5.0, -5.0, -6.0, 2.0, -4.0, -8.0, -4.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec4((t.b.c), vec4(-1.0, 6.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	t.a[0] = (vec3(7.0, -4.0, 3.0));
	t.a[1] = (vec3(9.0, 8.0, 5.0));
	t.a[2] = (vec3(-9.0, 2.0, -5.0));
	t.b.a = (ivec3(0, 2, -3));
	t.b.b[0][0] = (vec3(-6.0, -9.0, -6.0));
	t.b.b[0][1] = (vec3(6.0, -3.0, -5.0));
	t.b.b[0][2] = (vec3(5.0, -2.0, -5.0));
	t.b.b[1][0] = (vec3(7.0, -7.0, 5.0));
	t.b.b[1][1] = (vec3(-1.0, 3.0, -5.0));
	t.b.b[1][2] = (vec3(1.0, -5.0, -7.0));
	t.b.b[2][0] = (vec3(-4.0, -7.0, -4.0));
	t.b.b[2][1] = (vec3(-3.0, -4.0, 7.0));
	t.b.b[2][2] = (vec3(2.0, -3.0, 2.0));
	t.b.b[3][0] = (vec3(2.0, 1.0, 2.0));
	t.b.b[3][1] = (vec3(-7.0, -6.0, -8.0));
	t.b.b[3][2] = (vec3(6.0, 3.0, 0.0));
	t.b.c = (vec4(5.0, -9.0, 2.0, -3.0));
	u = (9u);
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((s[0][0].a), ivec3(2, -6, 5)) && allOk;
	allOk = compare_vec4((s[0][0].c), vec4(3.0, -7.0, 4.0, 0.0)) && allOk;
	allOk = compare_ivec3((s[0][1].a), ivec3(4, -2, -2)) && allOk;
	allOk = compare_vec4((s[0][1].c), vec4(8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_ivec3((s[1][0].a), ivec3(-9, -6, -3)) && allOk;
	allOk = compare_vec4((s[1][0].c), vec4(-7.0, 8.0, -4.0, 6.0)) && allOk;
	allOk = compare_ivec3((s[1][1].a), ivec3(-1, 7, 2)) && allOk;
	allOk = compare_vec4((s[1][1].c), vec4(-7.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_ivec3((s[2][0].a), ivec3(-9, 9, 4)) && allOk;
	allOk = compare_vec4((s[2][0].c), vec4(-2.0, -9.0, -2.0, 8.0)) && allOk;
	allOk = compare_ivec3((s[2][1].a), ivec3(6, 0, 9)) && allOk;
	allOk = compare_vec4((s[2][1].c), vec4(4.0, 0.0, 0.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (vec4(-3.0, 7.0, 0.0, -9.0));
	s[0][0].a = (ivec3(6, 1, -9));
	s[0][0].c = (vec4(3.0, 7.0, -4.0, -3.0));
	s[0][1].a = (ivec3(-5, -2, 3));
	s[0][1].c = (vec4(-7.0, -7.0, 1.0, 5.0));
	s[1][0].a = (ivec3(-8, -6, 5));
	s[1][0].c = (vec4(-3.0, -4.0, 2.0, -2.0));
	s[1][1].a = (ivec3(-7, 5, 8));
	s[1][1].c = (vec4(2.0, 0.0, -9.0, -6.0));
	s[2][0].a = (ivec3(4, -2, -8));
	s[2][0].c = (vec4(-8.0, -5.0, 6.0, -2.0));
	s[2][1].a = (ivec3(0, 4, -4));
	s[2][1].c = (vec4(-7.0, -7.0, 9.0, -1.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
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
	allOk = compare_mat4x2(block[0].var, mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	block[1].var = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	block[2].var = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
}
#version 450
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
	u16vec3 var;
} block[3];

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(block[0].var), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(block[1].var), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block[2].var), uvec3(7u, 1u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = u16vec3(uvec3(1u, 2u, 6u));
	block[1].var = u16vec3(uvec3(8u, 3u, 3u));
	block[2].var = u16vec3(uvec3(4u, 4u, 9u));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 8.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-9.0, -2.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][3], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -3.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-4.0, 1.0, 0.0, -7.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -1.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(5.0, 4.0, -2.0, 4.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(2.0, -4.0, 5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	block[0].var[1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block[1].var[0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	block[1].var[1] = (vec4(1.0, 7.0, 0.0, 9.0));
	block[2].var[0] = (vec4(8.0, 6.0, -7.0, -4.0));
	block[2].var[1] = (vec4(-6.0, 5.0, 5.0, -6.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -5.0) && allOk;
	allOk = compare_mat3x2(block[0].var, mat3x2(-4.0, 7.0, 2.0, 0.0, -8.0, -7.0)) && allOk;
	allOk = compare_float((block[1].padding), 3.0) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(3.0, -5.0, 4.0, -6.0, -1.0, -8.0)) && allOk;
	allOk = compare_float((block[2].padding), -4.0) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(-3.0, 2.0, 5.0, -1.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-3.0);
	block[0].var = (mat3x2(-3.0, -4.0, 2.0, -7.0, 7.0, -2.0));
	block[1].padding = (-8.0);
	block[1].var = (mat3x2(3.0, 4.0, 9.0, 4.0, -2.0, -7.0));
	block[2].padding = (9.0);
	block[2].var = (mat3x2(1.0, -9.0, 9.0, 0.0, -1.0, -3.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 5.0) && allOk;
	allOk = compare_mat3x4(block[0].var, mat3x4(5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0, -7.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_float((block[1].padding), -9.0) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(-3.0, -5.0, -9.0, -4.0, 7.0, -4.0, 5.0, 4.0, -5.0, 2.0, 6.0, -3.0)) && allOk;
	allOk = compare_float((block[2].padding), 5.0) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(1.0, 3.0, -1.0, 5.0, -2.0, 2.0, 7.0, -6.0, -1.0, 2.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (0.0);
	block[0].var = (mat3x4(5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0, 2.0, -8.0, -3.0, 0.0));
	block[1].padding = (-1.0);
	block[1].var = (mat3x4(-4.0, -6.0, 0.0, -5.0, -5.0, 1.0, -9.0, -7.0, 4.0, 7.0, 4.0, -7.0));
	block[2].padding = (7.0);
	block[2].var = (mat3x4(5.0, -9.0, -3.0, 0.0, 7.0, 1.0, -4.0, 0.0, -8.0, -2.0, -9.0, 5.0));
}
#version 450
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
	highp mat4x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 8.0) && allOk;
	allOk = compare_mat4x2(block[0].var, mat4x2(1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0, 8.0)) && allOk;
	allOk = compare_float((block[1].padding), -6.0) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(-5.0, 7.0, -8.0, -2.0, 5.0, -8.0, 9.0, 4.0)) && allOk;
	allOk = compare_float((block[2].padding), 4.0) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(4.0, 3.0, -6.0, -6.0, 8.0, 3.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-9.0);
	block[0].var = (mat4x2(-8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0, 5.0));
	block[1].padding = (8.0);
	block[1].var = (mat4x2(8.0, 8.0, 6.0, -3.0, -6.0, -4.0, -6.0, -9.0));
	block[2].padding = (1.0);
	block[2].var = (mat4x2(-1.0, 8.0, -7.0, 5.0, -3.0, 8.0, 7.0, 6.0));
}
#version 450
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
	i16vec3 var;
} block[3];

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block[0].padding), 3) && allOk;
	allOk = compare_i16vec3(ivec3(block[0].var), ivec3(4, 8, 7)) && allOk;
	allOk = compare_int16_t(int(block[1].padding), -4) && allOk;
	allOk = compare_i16vec3(ivec3(block[1].var), ivec3(0, 6, -5)) && allOk;
	allOk = compare_int16_t(int(block[2].padding), -9) && allOk;
	allOk = compare_i16vec3(ivec3(block[2].var), ivec3(9, 4, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = int16_t(6);
	block[0].var = i16vec3(ivec3(1, -2, -3));
	block[1].padding = int16_t(-1);
	block[1].var = i16vec3(ivec3(-4, -2, -2));
	block[2].padding = int16_t(2);
	block[2].var = i16vec3(ivec3(0, -6, -2));
}
#version 450
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
	mediump ivec3 a;
	highp vec4 b;
	mediump float c;
	highp mat2x3 d;
	lowp mat3x2 e;
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp uvec2 f;
	lowp vec2 g;
	lowp mat3x4 h[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a), ivec3(2, -8, -4)) && allOk;
	allOk = compare_vec4((b), vec4(7.0, 4.0, 0.0, -5.0)) && allOk;
	allOk = compare_float((c), -8.0) && allOk;
	allOk = compare_mat2x3(d, mat2x3(-6.0, 4.0, 5.0, 6.0, -6.0, 1.0)) && allOk;
	allOk = compare_vec2((blockC.g), vec2(-8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockC.h[0], mat3x4(2.0, -8.0, 1.0, 6.0, 3.0, 9.0, 1.0, -3.0, -7.0, -9.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockC.h[1], mat3x4(6.0, 7.0, -9.0, -8.0, -4.0, 5.0, -5.0, 9.0, 6.0, 8.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockC.h[2], mat3x4(-8.0, 1.0, -7.0, 7.0, 5.0, 7.0, 7.0, 2.0, -1.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockC.h[3], mat3x4(1.0, -6.0, 9.0, -3.0, 5.0, -5.0, -5.0, -3.0, 3.0, 6.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockC.h[4], mat3x4(-9.0, -1.0, 2.0, 6.0, 5.0, -4.0, -2.0, -2.0, -2.0, 3.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockC.h[5], mat3x4(3.0, 9.0, -5.0, -4.0, 7.0, -1.0, 3.0, -9.0, 5.0, 7.0, -9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (5.0);
	d = (mat2x3(4.0, 8.0, 6.0, 7.0, -5.0, 5.0));
	e = (mat3x2(-2.0, 7.0, 4.0, 7.0, 0.0, 9.0));
	blockC.f = (uvec2(4u, 7u));
	blockC.g = (vec2(4.0, 9.0));
	blockC.h[0] = (mat3x4(-7.0, -4.0, -4.0, -6.0, -6.0, 8.0, 6.0, 8.0, -2.0, -6.0, -3.0, -6.0));
	blockC.h[1] = (mat3x4(-7.0, -7.0, 4.0, -5.0, -1.0, 2.0, -6.0, -1.0, 4.0, -1.0, 5.0, -2.0));
	blockC.h[2] = (mat3x4(-3.0, -6.0, 8.0, 4.0, -7.0, 7.0, -3.0, 9.0, 8.0, 9.0, -4.0, 0.0));
	blockC.h[3] = (mat3x4(1.0, -9.0, -6.0, -1.0, 2.0, -9.0, -8.0, -8.0, -3.0, 0.0, 4.0, -9.0));
	blockC.h[4] = (mat3x4(0.0, -9.0, 6.0, -4.0, 0.0, 4.0, 6.0, 3.0, 9.0, 7.0, -5.0, -5.0));
	blockC.h[5] = (mat3x4(-2.0, 2.0, 4.0, 4.0, 0.0, 9.0, -2.0, -1.0, -5.0, -4.0, -5.0, 3.0));
}
#version 450
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
	bvec4 a;
	bvec2 b;
	mediump uint c[];
};
layout(std430, binding = 2) buffer BlockC
{
	lowp ivec2 d;
	lowp mat4 e;
	lowp ivec3 f[7];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	lowp mat3x2 g[][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_mat3x2(g[0][0], mat3x2(3.0, 3.0, 4.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(g[0][1], mat3x2(-1.0, 7.0, 7.0, -2.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, false, true, true));
	b = (bvec2(false, true));
	c[0] = (6u);
	d = (ivec2(-8, -9));
	e = (mat4(5.0, 4.0, -2.0, -5.0, 5.0, -6.0, 3.0, -5.0, 0.0, -9.0, 3.0, -9.0, -1.0, 6.0, 2.0, 7.0));
	g[0][0] = (mat3x2(-6.0, 8.0, 3.0, -7.0, 6.0, 5.0));
	g[0][1] = (mat3x2(6.0, 6.0, -4.0, 5.0, 7.0, 0.0));
}
#version 450
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
	mediump uvec2 mA;
	mediump vec4 mB;
	highp uint mC;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	highp vec3 a[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	sA b;
	mediump uvec4 c;
	highp ivec2 d;
	lowp uvec4 e[];
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	bvec2 f;
	lowp mat3x4 g;
	bvec3 h[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((b.mA), uvec2(6u, 8u)) && allOk;
	allOk = compare_vec4((b.mB), vec4(6.0, -1.0, 9.0, -1.0)) && allOk;
	allOk = compare_uint((b.mC), 8u) && allOk;
	allOk = compare_uvec4((c), uvec4(3u, 4u, 6u, 4u)) && allOk;
	allOk = compare_uvec4((e[0]), uvec4(9u, 9u, 8u, 6u)) && allOk;
	allOk = compare_mat3x4(blockD.g, mat3x4(9.0, -6.0, 5.0, -2.0, -8.0, -1.0, -6.0, 5.0, 3.0, 3.0, -9.0, 4.0)) && allOk;
	allOk = compare_bvec3((blockD.h[0]), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec3(1.0, 1.0, -4.0));
	b.mA = (uvec2(2u, 1u));
	b.mB = (vec4(-4.0, 1.0, -9.0, 3.0));
	b.mC = (7u);
	d = (ivec2(-1, -4));
	e[0] = (uvec4(2u, 3u, 6u, 4u));
	blockD.f = (bvec2(false, true));
	blockD.g = (mat3x4(-4.0, -8.0, 2.0, 0.0, 3.0, 9.0, -8.0, -9.0, -2.0, 0.0, 2.0, 6.0));
}
#version 450
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
	mediump mat3x2 mB;
	lowp uvec2 mC;
};
struct sB
{
	highp uvec3 mA;
	sA mB;
};
struct sC
{
	lowp mat4x2 mA;
	mediump mat4 mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	lowp uvec3 a;
	highp vec2 b[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	lowp uint c;
	highp uvec4 d;
	mediump uvec3 e[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	bvec3 f;
	lowp uvec3 g;
	sB h;
	mediump uvec2 i;
	lowp mat3 j;
};
layout(std140, column_major, binding = 4) buffer BlockE
{
	bvec3 k;
	lowp mat4x2 l;
	sC m;
	highp uint n[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b[0]), vec2(7.0, -5.0)) && allOk;
	allOk = compare_uint((c), 3u) && allOk;
	allOk = compare_uvec3((e[0]), uvec3(7u, 6u, 1u)) && allOk;
	allOk = compare_bvec3((f), bvec3(false, false, true)) && allOk;
	allOk = compare_uvec3((g), uvec3(2u, 1u, 5u)) && allOk;
	allOk = compare_uvec3((h.mA), uvec3(9u, 6u, 1u)) && allOk;
	allOk = compare_uint((h.mB.mA), 3u) && allOk;
	allOk = compare_mat3x2(h.mB.mB, mat3x2(1.0, -9.0, 6.0, 0.0, -8.0, -1.0)) && allOk;
	allOk = compare_uvec2((h.mB.mC), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((i), uvec2(3u, 8u)) && allOk;
	allOk = compare_mat3(j, mat3(-1.0, 1.0, 0.0, -2.0, 0.0, 5.0, -9.0, 8.0, -7.0)) && allOk;
	allOk = compare_bvec3((k), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(9u, 2u, 5u));
	blockB.b[0] = (vec2(-7.0, 6.0));
	d = (uvec4(4u, 1u, 7u, 5u));
	f = (bvec3(true, true, false));
	g = (uvec3(0u, 9u, 5u));
	h.mA = (uvec3(7u, 8u, 3u));
	h.mB.mA = (2u);
	h.mB.mB = (mat3x2(2.0, -9.0, 6.0, 7.0, 6.0, 6.0));
	h.mB.mC = (uvec2(4u, 8u));
	i = (uvec2(9u, 0u));
	j = (mat3(4.0, -7.0, 9.0, -5.0, -1.0, 5.0, 0.0, 7.0, -4.0));
	k = (bvec3(true, false, false));
	m.mA = (mat4x2(-1.0, 8.0, 4.0, 9.0, -5.0, 8.0, 0.0, 3.0));
	m.mB = (mat4(8.0, 9.0, 3.0, -9.0, 6.0, 7.0, 3.0, 2.0, -5.0, 6.0, 3.0, -9.0, 6.0, 8.0, 1.0, -3.0));
	n[0] = (2u);
}
#version 450
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
	mediump mat2 mB;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	mediump vec3 a;
	sA b[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp vec3 c;
	mediump int d;
	lowp mat2 e;
	lowp mat4 f;
	lowp mat4x3 g[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(4.0, -1.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockB.b[0].mA), ivec2(6, 1)) && allOk;
	allOk = compare_mat2(blockB.b[0].mB, mat2(-1.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB.b[1].mA), ivec2(9, -6)) && allOk;
	allOk = compare_mat2(blockB.b[1].mB, mat2(6.0, -4.0, -1.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockB.b[2].mA), ivec2(-4, 2)) && allOk;
	allOk = compare_mat2(blockB.b[2].mB, mat2(3.0, 9.0, -7.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB.b[3].mA), ivec2(-9, 6)) && allOk;
	allOk = compare_mat2(blockB.b[3].mB, mat2(7.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockB.b[4].mA), ivec2(8, -9)) && allOk;
	allOk = compare_mat2(blockB.b[4].mB, mat2(3.0, -6.0, -5.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockB.b[5].mA), ivec2(-6, -5)) && allOk;
	allOk = compare_mat2(blockB.b[5].mB, mat2(-4.0, -5.0, 8.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockB.b[6].mA), ivec2(-8, 7)) && allOk;
	allOk = compare_mat2(blockB.b[6].mB, mat2(6.0, -1.0, -3.0, -6.0)) && allOk;
	allOk = compare_ivec2((blockB.b[7].mA), ivec2(-7, -1)) && allOk;
	allOk = compare_mat2(blockB.b[7].mB, mat2(7.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2(blockC.e, mat2(5.0, 7.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4(blockC.f, mat4(6.0, 5.0, 1.0, -7.0, -6.0, 4.0, 0.0, 9.0, -6.0, 7.0, 2.0, -6.0, 8.0, 4.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockC.g[0], mat4x3(5.0, 8.0, -6.0, -5.0, -2.0, 3.0, 6.0, 7.0, 2.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockC.g[1], mat4x3(-4.0, 9.0, 9.0, 1.0, -7.0, -1.0, 0.0, -8.0, 0.0, 3.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockC.g[2], mat4x3(-1.0, -7.0, -1.0, 6.0, 5.0, -9.0, 6.0, -7.0, -2.0, 2.0, -7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(5.0, 7.0, -9.0));
	blockB.b[0].mA = (ivec2(-6, 1));
	blockB.b[0].mB = (mat2(5.0, 9.0, 2.0, -1.0));
	blockB.b[1].mA = (ivec2(-2, -1));
	blockB.b[1].mB = (mat2(-7.0, 3.0, -7.0, -5.0));
	blockB.b[2].mA = (ivec2(-3, -9));
	blockB.b[2].mB = (mat2(7.0, 5.0, 5.0, 7.0));
	blockB.b[3].mA = (ivec2(-9, -2));
	blockB.b[3].mB = (mat2(-3.0, 2.0, -2.0, 9.0));
	blockB.b[4].mA = (ivec2(-4, -4));
	blockB.b[4].mB = (mat2(5.0, 7.0, -5.0, 9.0));
	blockB.b[5].mA = (ivec2(3, 4));
	blockB.b[5].mB = (mat2(-3.0, 8.0, -3.0, 7.0));
	blockB.b[6].mA = (ivec2(9, 1));
	blockB.b[6].mB = (mat2(-4.0, -9.0, -2.0, 9.0));
	blockB.b[7].mA = (ivec2(2, -6));
	blockB.b[7].mB = (mat2(7.0, 8.0, -1.0, 5.0));
	blockC.d = (-5);
	blockC.f = (mat4(2.0, -9.0, 7.0, -4.0, 6.0, -2.0, 0.0, -9.0, 3.0, -9.0, 2.0, -5.0, -7.0, 9.0, 3.0, 4.0));
}
#version 450
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
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump float b;
	layout(offset = 4) mediump ivec2 c;
	layout(offset = 16) mediump ivec4 d;
	layout(offset = 32) highp uvec4 e;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp uvec4 f;
	layout(offset = 16) mediump vec4 g;
	layout(offset = 32) mediump uint h;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump int i;
	layout(offset = 4) lowp ivec3 j;
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((b), 9.0) && allOk;
	allOk = compare_ivec2((c), ivec2(-8, 6)) && allOk;
	allOk = compare_vec4((g), vec4(-4.0, -8.0, 6.0, -7.0)) && allOk;
	allOk = compare_uint((h), 3u) && allOk;
	allOk = compare_int((blockE[0].i), 5) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec3(-3.0, -9.0, -1.0));
	b = (-1.0);
	c = (ivec2(-1, -7));
	d = (ivec4(2, -3, -3, 5));
	e = (uvec4(7u, 2u, 5u, 9u));
	f = (uvec4(0u, 6u, 1u, 4u));
	g = (vec4(-4.0, 7.0, 1.0, -2.0));
	h = (5u);
	blockE[0].i = (-8);
	blockE[0].j = (ivec3(-2, 0, -1));
}
#version 450
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
	i16vec3 a;
	int16_t b;
	lowp ivec2 c;
	mediump float d;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	bvec3 e;
	lowp int f;
	highp uvec2 g;
	mediump ivec4 h;
	i16vec4 i;
};
layout(std140, binding = 3) buffer BlockD
{
	mediump ivec4 j;
	i16vec4 k;
	bvec4 l[1];
	f16vec3 m;
};
layout(std430, binding = 4) readonly buffer BlockE
{
	bvec4 n;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockB.a), ivec3(2, -3, 2)) && allOk;
	allOk = compare_int16_t(int(blockB.b), -4) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(4, 6)) && allOk;
	allOk = compare_float((blockB.d), -2.0) && allOk;
	allOk = compare_uvec2((g), uvec2(6u, 8u)) && allOk;
	allOk = compare_ivec4((h), ivec4(7, 3, 3, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(i), ivec4(8, -7, -9, -3)) && allOk;
	allOk = compare_ivec4((j), ivec4(4, -3, -7, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(k), ivec4(-1, 9, -6, 8)) && allOk;
	allOk = compare_f16vec3(vec3(m), vec3(-3.0, -5.0, 4.0)) && allOk;
	allOk = compare_bvec4((n), bvec4(false, false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec3(ivec3(8, 7, -2));
	blockB.b = int16_t(6);
	blockB.c = (ivec2(0, 5));
	blockB.d = (9.0);
	e = (bvec3(false, false, false));
	f = (-1);
	i = i16vec4(ivec4(-2, -4, -2, 4));
	j = (ivec4(-2, 3, 0, -8));
	k = i16vec4(ivec4(6, -7, 4, 6));
	l[0] = (bvec4(false, false, true, true));
	m = f16vec3(vec3(3.0, -3.0, 3.0));
}
#version 450
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
	mediump mat2 a;
	u16vec4 b[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	u16vec4 c[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	lowp mat3x2 d;
	mediump vec3 e[];
} blockD;
layout(std140, row_major, binding = 4) buffer BlockE
{
	bvec4 f;
	mediump mat2x3 g;
	i16vec4 h;
	u16vec2 i;
	u16vec3 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockC.c[0]), uvec4(4u, 3u, 4u, 7u)) && allOk;
	allOk = compare_vec3((blockD.e[0]), vec3(0.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(g, mat2x3(4.0, 9.0, 2.0, -9.0, 7.0, -8.0)) && allOk;
	allOk = compare_i16vec4(ivec4(h), ivec4(7, 5, -7, -5)) && allOk;
	allOk = compare_u16vec2(uvec2(i), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(j[0]), uvec3(7u, 6u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(-7.0, 3.0, -9.0, -7.0));
	blockB.b[0] = u16vec4(uvec4(9u, 4u, 3u, 0u));
	blockC.c[0] = u16vec4(uvec4(6u, 4u, 5u, 2u));
	blockD.d = (mat3x2(0.0, -7.0, -9.0, -8.0, -4.0, -7.0));
	h = i16vec4(ivec4(9, -6, 8, 5));
	j[0] = u16vec3(uvec3(6u, 6u, 4u));
}
#version 450
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
	bvec2 a;
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	bvec4 b;
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	u16vec4 c;
	u16vec3 d;
	highp ivec4 e;
	bool f[];
};
layout(std140, column_major, binding = 4) buffer BlockE
{
	i16vec2 g;
	mediump ivec4 h;
	mediump ivec4 i;
	lowp mat2x3 j;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(c), uvec4(6u, 0u, 8u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(d), uvec3(1u, 4u, 0u)) && allOk;
	allOk = compare_ivec4((e), ivec4(-1, 2, 0, 1)) && allOk;
	allOk = compare_ivec4((h), ivec4(7, -5, 4, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec2(true, false));
	b = (bvec4(true, true, true, false));
	c = u16vec4(uvec4(9u, 5u, 4u, 2u));
	d = u16vec3(uvec3(4u, 1u, 2u));
	e = (ivec4(-7, 1, 3, 2));
	g = i16vec2(ivec2(4, 9));
	h = (ivec4(-8, -1, 3, -1));
	i = (ivec4(4, 1, -8, -8));
}
#version 450
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
	f16vec4 a[1];
	float16_t b[];
};
layout(std430, binding = 2) buffer BlockC
{
	mediump vec4 c[1];
	mediump mat4x3 d;
	lowp ivec4 e;
	highp int f[];
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	int16_t g;
	lowp uvec4 h;
	float16_t i[];
};
layout(std430, column_major, binding = 4) buffer BlockE
{
	bvec2 j;
	mediump mat2 k;
	highp int l;
	f16vec3 m;
	f16vec2 n;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(a[0]), vec4(2.0, -3.0, 2.0, -4.0)) && allOk;
	allOk = compare_float16_t(float(b[0]), 4.0) && allOk;
	allOk = compare_vec4((c[0]), vec4(6.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(-3.0, 1.0, -3.0, 8.0, 7.0, 3.0, 3.0, -4.0, 8.0, -7.0, -9.0, -3.0)) && allOk;
	allOk = compare_ivec4((e), ivec4(4, -3, -7, -7)) && allOk;
	allOk = compare_int((f[0]), -1) && allOk;
	allOk = compare_int16_t(int(g), 9) && allOk;
	allOk = compare_float16_t(float(i[0]), 1.0) && allOk;
	allOk = compare_mat2(blockE.k, mat2(-3.0, -5.0, 4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = f16vec4(vec4(8.0, 7.0, -2.0, 6.0));
	b[0] = float16_t(0.0);
	c[0] = (vec4(5.0, 9.0, -5.0, 4.0));
	d = (mat4x3(7.0, -1.0, 6.0, 5.0, 8.0, 6.0, 2.0, -7.0, -2.0, -4.0, -2.0, 4.0));
	f[0] = (6);
	g = int16_t(-7);
	h = (uvec4(1u, 0u, 7u, 7u));
	i[0] = float16_t(3.0);
	blockE.j = (bvec2(true, true));
	blockE.k = (mat2(-3.0, 3.0, 2.0, 2.0));
	blockE.l = (-6);
	blockE.m = f16vec3(vec3(-8.0, -6.0, 4.0));
	blockE.n = f16vec2(vec2(-7.0, -9.0));
}
#version 450
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
	u16vec4 b;
	u16vec3 c[8];
	bvec4 d[];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((a), bvec4(true, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, true, true, true));
	b = u16vec4(uvec4(7u, 6u, 5u, 3u));
	d[0] = (bvec4(false, false, false, true));
	d[1] = (bvec4(true, false, false, false));
	d[2] = (bvec4(false, false, false, true));
	d[3] = (bvec4(true, false, false, true));
}
#version 450
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
	layout(offset = 0) highp vec4 a;
	layout(offset = 16) uint16_t b;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) uint16_t c;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(5.0, -4.0, 7.0, 9.0));
	blockB.b = uint16_t(1u);
	blockC.c = uint16_t(1u);
}
#version 450
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
	bvec2 mB;
};
struct sB
{
	bvec4 mA;
	mediump mat4 mB;
	sA mC;
	f16vec3 mD;
};
struct sC
{
	highp uint mA;
	float16_t mB;
	u16vec4 mC;
	mediump mat4x2 mD;
};
struct sD
{
	highp int mA;
	u16vec4 mB;
	u16vec2 mC[5];
	sC mD;
};
layout(scalar, binding = 1) buffer BlockB
{
	mediump uvec2 a[];
};
layout(scalar, binding = 2) buffer BlockC
{
	bool b;
	mediump vec2 c;
	u16vec3 d;
	sB e;
	sD f;
} blockC;
layout(scalar, column_major, binding = 3) readonly buffer BlockD
{
	f16vec3 g[1];
} blockD[1];
layout(scalar, row_major, binding = 4) buffer BlockE
{
	highp mat4x3 h;
	mediump ivec2 i;
	mediump mat4x2 j[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((a[0]), uvec2(2u, 3u)) && allOk;
	allOk = compare_uvec2((a[1]), uvec2(7u, 5u)) && allOk;
	allOk = compare_uvec2((a[2]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((a[3]), uvec2(4u, 7u)) && allOk;
	allOk = compare_uvec2((a[4]), uvec2(0u, 3u)) && allOk;
	allOk = compare_uvec2((a[5]), uvec2(2u, 0u)) && allOk;
	allOk = compare_bool((blockC.b), false) && allOk;
	allOk = compare_ivec2((blockE.i), ivec2(-9, 1)) && allOk;
	allOk = compare_mat4x2(blockE.j[0], mat4x2(1.0, -9.0, -3.0, -3.0, -4.0, 9.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockE.j[1], mat4x2(6.0, -9.0, -3.0, 7.0, -7.0, -3.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockE.j[2], mat4x2(2.0, 4.0, 4.0, 1.0, -4.0, -6.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockE.j[3], mat4x2(-5.0, -4.0, 2.0, 7.0, -4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockE.j[4], mat4x2(-1.0, 4.0, -2.0, -2.0, -9.0, 2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockE.j[5], mat4x2(-9.0, 3.0, -4.0, 9.0, 0.0, -5.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockE.j[6], mat4x2(-7.0, 3.0, 9.0, -9.0, -5.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockE.j[7], mat4x2(9.0, -9.0, 5.0, 4.0, 3.0, 7.0, -5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (uvec2(2u, 0u));
	a[1] = (uvec2(0u, 7u));
	a[2] = (uvec2(4u, 5u));
	a[3] = (uvec2(2u, 5u));
	a[4] = (uvec2(1u, 2u));
	a[5] = (uvec2(0u, 9u));
	blockC.c = (vec2(-6.0, -3.0));
	blockC.d = u16vec3(uvec3(0u, 4u, 5u));
	blockC.e.mA = (bvec4(false, false, true, false));
	blockC.e.mB = (mat4(5.0, -4.0, 9.0, 1.0, 4.0, -5.0, 8.0, -5.0, 4.0, -9.0, -1.0, -6.0, 9.0, -8.0, -4.0, -9.0));
	blockC.e.mC.mA = (mat3x4(9.0, -2.0, 3.0, 1.0, -6.0, -2.0, 5.0, -3.0, 4.0, 7.0, -1.0, -2.0));
	blockC.e.mC.mB = (bvec2(false, true));
	blockC.e.mD = f16vec3(vec3(0.0, 2.0, -9.0));
	blockC.f.mA = (0);
	blockC.f.mB = u16vec4(uvec4(0u, 1u, 1u, 5u));
	blockC.f.mC[0] = u16vec2(uvec2(5u, 3u));
	blockC.f.mC[1] = u16vec2(uvec2(2u, 5u));
	blockC.f.mC[2] = u16vec2(uvec2(1u, 1u));
	blockC.f.mC[3] = u16vec2(uvec2(6u, 1u));
	blockC.f.mC[4] = u16vec2(uvec2(7u, 4u));
	blockC.f.mD.mA = (3u);
	blockC.f.mD.mB = float16_t(-6.0);
	blockC.f.mD.mC = u16vec4(uvec4(2u, 1u, 2u, 1u));
	blockC.f.mD.mD = (mat4x2(7.0, -3.0, -2.0, -3.0, 0.0, 7.0, 3.0, -1.0));
	blockE.h = (mat4x3(-4.0, -2.0, -8.0, -5.0, -7.0, 1.0, 0.0, -2.0, 1.0, 2.0, -2.0, -6.0));
	blockE.i = (ivec2(-1, -1));
}
#version 450
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
	highp uvec4 a;
	highp mat3x2 b[][8];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	lowp mat4x3 c[6];
	f16vec3 d;
	mediump uvec4 e;
	lowp mat3 f[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.b[0][0], mat3x2(0.0, -2.0, -6.0, 9.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[0][1], mat3x2(0.0, 5.0, -2.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[0][2], mat3x2(6.0, 0.0, 6.0, 0.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[0][3], mat3x2(2.0, 0.0, 7.0, -5.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[0][4], mat3x2(-5.0, -2.0, -4.0, 9.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[0][5], mat3x2(2.0, 3.0, 8.0, 8.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[0][6], mat3x2(-4.0, -6.0, -1.0, -1.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[0][7], mat3x2(1.0, 0.0, -5.0, -5.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1][0], mat3x2(4.0, -8.0, 8.0, 5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1][1], mat3x2(7.0, -2.0, -8.0, -3.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1][2], mat3x2(2.0, 7.0, 5.0, -6.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1][3], mat3x2(-3.0, 9.0, -8.0, -5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1][4], mat3x2(3.0, 8.0, 3.0, 1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1][5], mat3x2(0.0, 4.0, 8.0, -6.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1][6], mat3x2(9.0, -4.0, -1.0, -5.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1][7], mat3x2(-1.0, -6.0, -6.0, 7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2][0], mat3x2(-6.0, 3.0, -9.0, 5.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2][1], mat3x2(1.0, 8.0, 0.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2][2], mat3x2(4.0, 3.0, 3.0, 4.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2][3], mat3x2(6.0, -9.0, 5.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2][4], mat3x2(-1.0, -7.0, 3.0, 9.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2][5], mat3x2(-7.0, -2.0, 9.0, -5.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2][6], mat3x2(0.0, -5.0, 1.0, -1.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2][7], mat3x2(-8.0, -4.0, -9.0, -4.0, -7.0, 5.0)) && allOk;
	allOk = compare_uvec4((blockC.e), uvec4(6u, 5u, 2u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.d = f16vec3(vec3(-3.0, 5.0, -9.0));
	blockC.f[0] = (mat3(1.0, -1.0, -1.0, -3.0, 5.0, 0.0, 1.0, -5.0, 1.0));
	blockC.f[1] = (mat3(5.0, 1.0, 3.0, 7.0, 2.0, 7.0, -5.0, -6.0, 6.0));
	blockC.f[2] = (mat3(3.0, 4.0, 3.0, 8.0, 0.0, -5.0, -3.0, 9.0, -9.0));
	blockC.f[3] = (mat3(-3.0, -2.0, -9.0, -4.0, 3.0, -4.0, 2.0, -8.0, 8.0));
	blockC.f[4] = (mat3(-3.0, 7.0, 8.0, -9.0, 2.0, -5.0, -5.0, 1.0, -1.0));
}
#version 450
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
	mediump uvec3 a;
	mediump mat3x4 b;
	mediump mat4x2 c;
	i16vec2 d;
	i16vec2 e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[nonuniformEXT(0)].a), uvec3(4u, 0u, 4u)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(0)].c, mat4x2(7.0, -8.0, 1.0, 5.0, -5.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(1)].a), uvec3(5u, 6u, 9u)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(1)].c, mat4x2(0.0, -4.0, -6.0, -1.0, 5.0, 1.0, -5.0, -8.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(2)].a), uvec3(6u, 7u, 9u)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(2)].c, mat4x2(7.0, -2.0, -9.0, -5.0, -6.0, 4.0, -9.0, -7.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(3)].a), uvec3(9u, 1u, 9u)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(3)].c, mat4x2(-1.0, 7.0, 2.0, 7.0, 7.0, -3.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (mat3x4(0.0, -3.0, 9.0, -5.0, 2.0, 1.0, 8.0, 6.0, 2.0, 9.0, 8.0, 5.0));
	blockB[nonuniformEXT(0)].c = (mat4x2(-5.0, 8.0, -1.0, 7.0, -9.0, -3.0, -1.0, 6.0));
	blockB[nonuniformEXT(0)].e = i16vec2(ivec2(9, -4));
	blockB[nonuniformEXT(1)].b = (mat3x4(-8.0, -4.0, 1.0, -4.0, -4.0, -7.0, -1.0, 9.0, -8.0, 6.0, 2.0, -1.0));
	blockB[nonuniformEXT(1)].c = (mat4x2(0.0, 2.0, -2.0, -1.0, 3.0, 0.0, -8.0, 9.0));
	blockB[nonuniformEXT(1)].e = i16vec2(ivec2(-2, -3));
	blockB[nonuniformEXT(2)].b = (mat3x4(4.0, -6.0, -5.0, -3.0, -5.0, 6.0, 6.0, -1.0, -3.0, -7.0, -3.0, -6.0));
	blockB[nonuniformEXT(2)].c = (mat4x2(-2.0, 0.0, -2.0, -3.0, -8.0, 1.0, 8.0, -6.0));
	blockB[nonuniformEXT(2)].e = i16vec2(ivec2(6, -6));
	blockB[nonuniformEXT(3)].b = (mat3x4(-8.0, 9.0, 5.0, -6.0, -6.0, -1.0, -6.0, -2.0, 3.0, -4.0, 7.0, -6.0));
	blockB[nonuniformEXT(3)].c = (mat4x2(-9.0, -3.0, 1.0, 8.0, 7.0, -9.0, 6.0, -4.0));
	blockB[nonuniformEXT(3)].e = i16vec2(ivec2(5, -1));
}
#version 450
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
	lowp ivec3 a[1];
};
layout(std430, binding = 2) buffer BlockC
{
	mediump uvec3 b;
	highp ivec4 c;
	i8vec2 d;
	bvec2 e;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	highp vec4 f;
	i8vec4 g;
	highp ivec2 h;
	mediump uvec3 i[1];
	int8_t j;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a[0]), ivec3(2, 7, -9)) && allOk;
	allOk = compare_ivec4((blockC.c), ivec4(7, -2, 3, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d), ivec2(1, 4294967291)) && allOk;
	allOk = compare_bvec2((blockC.e), bvec2(true, true)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.g), ivec4(1, 4294967290, 0, 2)) && allOk;
	allOk = compare_uvec3((blockD.i[0]), uvec3(5u, 8u, 4u)) && allOk;
	allOk = compare_int8_t(int(blockD.j), 4294967291) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (ivec3(8, 9, -5));
	blockC.c = (ivec4(-1, 9, -3, 5));
	blockC.d = i8vec2(ivec2(4294967288, 4294967294));
	blockC.e = (bvec2(false, false));
	blockD.h = (ivec2(4, -7));
	blockD.i[0] = (uvec3(6u, 4u, 8u));
	blockD.j = int8_t(4294967293);
}
#version 450
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
	highp vec2 a;
	lowp mat3 b;
	highp mat3x2 c[8][4];
	highp mat3 d;
	lowp mat3x2 e[];
};
layout(std140, binding = 2) buffer BlockC
{
	highp mat3x4 f;
	highp vec3 g;
	bool h;
	bool i;
	bool j;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	highp vec4 k;
	bvec4 l[];
};
layout(std430, row_major, binding = 4) buffer BlockE
{
	highp ivec2 m;
	bool n;
	int8_t o[2];
	mediump uint p;
	bvec4 q;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(b, mat3(0.0, -9.0, -1.0, 4.0, -4.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(c[0][0], mat3x2(5.0, 1.0, -6.0, 9.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(c[0][1], mat3x2(7.0, 5.0, -6.0, 5.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(c[0][2], mat3x2(4.0, -1.0, -1.0, -5.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x2(c[0][3], mat3x2(8.0, -7.0, -4.0, -7.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(c[1][0], mat3x2(7.0, 8.0, -1.0, 5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat3x2(c[1][1], mat3x2(5.0, -9.0, 2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(c[1][2], mat3x2(-9.0, -2.0, 5.0, -8.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat3x2(c[1][3], mat3x2(-1.0, 5.0, 8.0, -5.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(c[2][0], mat3x2(-1.0, -2.0, 2.0, 2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat3x2(c[2][1], mat3x2(8.0, -2.0, -4.0, -8.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(c[2][2], mat3x2(-2.0, -6.0, 6.0, -2.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(c[2][3], mat3x2(-9.0, 2.0, 2.0, 5.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3x2(c[3][0], mat3x2(-9.0, 0.0, -9.0, -3.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(c[3][1], mat3x2(-8.0, 7.0, -1.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x2(c[3][2], mat3x2(-9.0, -2.0, -4.0, 9.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(c[3][3], mat3x2(-7.0, 7.0, -2.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(c[4][0], mat3x2(5.0, -9.0, 7.0, -4.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(c[4][1], mat3x2(-6.0, 1.0, 4.0, -6.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(c[4][2], mat3x2(7.0, -9.0, 0.0, -4.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(c[4][3], mat3x2(0.0, 9.0, -4.0, 4.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(c[5][0], mat3x2(3.0, 6.0, -1.0, -7.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat3x2(c[5][1], mat3x2(4.0, -9.0, -9.0, -3.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(c[5][2], mat3x2(0.0, -1.0, 1.0, 5.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x2(c[5][3], mat3x2(8.0, -5.0, 5.0, -9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(c[6][0], mat3x2(-8.0, 2.0, -9.0, -2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(c[6][1], mat3x2(0.0, -1.0, 9.0, 1.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3x2(c[6][2], mat3x2(8.0, 1.0, -6.0, -3.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(c[6][3], mat3x2(6.0, -1.0, -1.0, 8.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3x2(c[7][0], mat3x2(7.0, 4.0, -3.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(c[7][1], mat3x2(2.0, -3.0, 2.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(c[7][2], mat3x2(-1.0, -4.0, -2.0, 6.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(c[7][3], mat3x2(4.0, 1.0, -2.0, -9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3(d, mat3(4.0, -5.0, -9.0, 0.0, 2.0, -3.0, 9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(e[0], mat3x2(-8.0, -9.0, -1.0, 8.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(e[1], mat3x2(3.0, 0.0, -7.0, 8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(e[2], mat3x2(-8.0, -4.0, -7.0, -5.0, 3.0, 6.0)) && allOk;
	allOk = compare_bool((blockC.h), true) && allOk;
	allOk = compare_bool((blockC.i), false) && allOk;
	allOk = compare_bool((blockC.j), false) && allOk;
	allOk = compare_vec4((k), vec4(-4.0, 9.0, 7.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockE.m), ivec2(-3, -3)) && allOk;
	allOk = compare_int8_t(int(blockE.o[0]), 4294967287) && allOk;
	allOk = compare_int8_t(int(blockE.o[1]), 4294967293) && allOk;
	allOk = compare_bvec4((blockE.q), bvec4(false, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat3(-3.0, -1.0, -2.0, 7.0, -7.0, -6.0, -5.0, -9.0, 4.0));
	c[0][0] = (mat3x2(-6.0, 2.0, 6.0, 4.0, 6.0, -5.0));
	c[0][1] = (mat3x2(2.0, -9.0, -8.0, 3.0, 6.0, -6.0));
	c[0][2] = (mat3x2(5.0, 6.0, -6.0, 3.0, 7.0, -8.0));
	c[0][3] = (mat3x2(-2.0, -6.0, -3.0, 0.0, 7.0, -1.0));
	c[1][0] = (mat3x2(-5.0, -8.0, 9.0, 7.0, -9.0, -8.0));
	c[1][1] = (mat3x2(-4.0, 0.0, -3.0, 9.0, 9.0, -2.0));
	c[1][2] = (mat3x2(2.0, -6.0, 0.0, -6.0, -6.0, -4.0));
	c[1][3] = (mat3x2(-9.0, 4.0, -5.0, 8.0, 8.0, -3.0));
	c[2][0] = (mat3x2(-1.0, 2.0, -2.0, 2.0, -1.0, 7.0));
	c[2][1] = (mat3x2(-1.0, 3.0, 2.0, -8.0, 9.0, -3.0));
	c[2][2] = (mat3x2(8.0, -7.0, -9.0, -5.0, 9.0, 0.0));
	c[2][3] = (mat3x2(-7.0, 7.0, 7.0, 3.0, -6.0, -4.0));
	c[3][0] = (mat3x2(5.0, -1.0, -8.0, -9.0, -7.0, -4.0));
	c[3][1] = (mat3x2(-1.0, -2.0, -1.0, -8.0, 5.0, -6.0));
	c[3][2] = (mat3x2(7.0, -5.0, 8.0, -9.0, 9.0, -1.0));
	c[3][3] = (mat3x2(1.0, -9.0, 4.0, -8.0, 2.0, -1.0));
	c[4][0] = (mat3x2(3.0, 1.0, 9.0, 3.0, 4.0, 8.0));
	c[4][1] = (mat3x2(-9.0, -7.0, -3.0, -7.0, -2.0, -3.0));
	c[4][2] = (mat3x2(5.0, -5.0, 6.0, -3.0, 1.0, 4.0));
	c[4][3] = (mat3x2(-1.0, -3.0, -5.0, -4.0, -5.0, -6.0));
	c[5][0] = (mat3x2(7.0, -3.0, 2.0, 4.0, 3.0, -1.0));
	c[5][1] = (mat3x2(-4.0, 9.0, 3.0, 8.0, -2.0, 5.0));
	c[5][2] = (mat3x2(7.0, 9.0, 0.0, -1.0, 1.0, -7.0));
	c[5][3] = (mat3x2(7.0, -5.0, 7.0, 7.0, 8.0, 7.0));
	c[6][0] = (mat3x2(4.0, 0.0, 5.0, -9.0, 4.0, 5.0));
	c[6][1] = (mat3x2(-6.0, 6.0, -1.0, 9.0, -8.0, -6.0));
	c[6][2] = (mat3x2(3.0, -7.0, 1.0, -2.0, 6.0, 7.0));
	c[6][3] = (mat3x2(0.0, 1.0, 7.0, -8.0, 6.0, -7.0));
	c[7][0] = (mat3x2(-9.0, -4.0, -5.0, -2.0, -4.0, 0.0));
	c[7][1] = (mat3x2(3.0, 4.0, -5.0, -9.0, 0.0, -5.0));
	c[7][2] = (mat3x2(9.0, -2.0, 6.0, -8.0, 7.0, 1.0));
	c[7][3] = (mat3x2(2.0, 1.0, 0.0, -4.0, 8.0, 7.0));
	d = (mat3(4.0, -7.0, 6.0, -3.0, -8.0, -5.0, 2.0, 4.0, -8.0));
	e[0] = (mat3x2(7.0, 5.0, 6.0, -4.0, 3.0, 0.0));
	e[1] = (mat3x2(3.0, -1.0, -8.0, 3.0, -5.0, 7.0));
	e[2] = (mat3x2(1.0, -6.0, -8.0, 1.0, 7.0, 8.0));
	blockC.f = (mat3x4(-8.0, 0.0, -9.0, -3.0, -4.0, 1.0, 6.0, -8.0, -6.0, 8.0, -6.0, 7.0));
	blockC.g = (vec3(7.0, 6.0, -7.0));
	blockC.i = (false);
	blockC.j = (false);
	k = (vec4(-1.0, 1.0, 4.0, -3.0));
	l[0] = (bvec4(false, true, false, true));
	l[1] = (bvec4(false, true, false, true));
	l[2] = (bvec4(false, false, true, false));
	l[3] = (bvec4(true, false, false, true));
	blockE.m = (ivec2(9, 7));
	blockE.n = (false);
	blockE.o[0] = int8_t(1);
	blockE.o[1] = int8_t(1);
	blockE.p = (4u);
}
#version 450
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
	bvec3 mA;
	lowp vec3 mB;
	mediump mat2x3 mC;
	lowp mat4 mD;
};
struct sB
{
	sA mA;
	int8_t mB;
	int8_t mC;
	u8vec2 mD[4];
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	sB a[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA.mA = (bvec3(true, false, true));
	blockB.a[0].mA.mB = (vec3(4.0, -6.0, 2.0));
	blockB.a[0].mA.mC = (mat2x3(-5.0, -9.0, 3.0, 2.0, -8.0, 6.0));
	blockB.a[0].mA.mD = (mat4(-8.0, 0.0, -8.0, -8.0, -2.0, 7.0, 9.0, -4.0, -6.0, -1.0, 7.0, 0.0, -3.0, -5.0, -9.0, -3.0));
	blockB.a[0].mB = int8_t(2);
	blockB.a[0].mC = int8_t(2);
	blockB.a[0].mD[0] = u8vec2(uvec2(8u, 0u));
	blockB.a[0].mD[1] = u8vec2(uvec2(5u, 4u));
	blockB.a[0].mD[2] = u8vec2(uvec2(0u, 6u));
	blockB.a[0].mD[3] = u8vec2(uvec2(9u, 6u));
	blockB.a[1].mA.mA = (bvec3(true, true, false));
	blockB.a[1].mA.mB = (vec3(6.0, 4.0, 6.0));
	blockB.a[1].mA.mC = (mat2x3(-6.0, 6.0, 3.0, 5.0, -6.0, 7.0));
	blockB.a[1].mA.mD = (mat4(9.0, -6.0, -4.0, 8.0, 9.0, 0.0, -9.0, 8.0, -2.0, -6.0, 4.0, -3.0, 2.0, -6.0, -5.0, -1.0));
	blockB.a[1].mB = int8_t(4294967294);
	blockB.a[1].mC = int8_t(4294967295);
	blockB.a[1].mD[0] = u8vec2(uvec2(3u, 6u));
	blockB.a[1].mD[1] = u8vec2(uvec2(5u, 6u));
	blockB.a[1].mD[2] = u8vec2(uvec2(6u, 4u));
	blockB.a[1].mD[3] = u8vec2(uvec2(9u, 9u));
}
#version 450
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
	i8vec2 mA;
	lowp vec3 mB;
	i8vec4 mC;
	bvec2 mD;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	sA a;
	mediump mat4x2 b;
	u8vec3 c;
	highp float d;
	highp uvec4 e[];
};
layout(std140, binding = 2) buffer BlockC
{
	lowp uvec2 f;
	mediump mat2 g;
	lowp uint h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(b, mat4x2(6.0, -8.0, 8.0, 6.0, 2.0, -4.0, -6.0, 2.0)) && allOk;
	allOk = compare_uvec4((e[0]), uvec4(4u, 9u, 6u, 0u)) && allOk;
	allOk = compare_uvec4((e[1]), uvec4(7u, 2u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((e[2]), uvec4(4u, 0u, 3u, 8u)) && allOk;
	allOk = compare_uvec4((e[3]), uvec4(5u, 7u, 4u, 1u)) && allOk;
	allOk = compare_uvec4((e[4]), uvec4(7u, 8u, 3u, 7u)) && allOk;
	allOk = compare_mat2(g, mat2(5.0, 9.0, -9.0, 5.0)) && allOk;
	allOk = compare_uint((h[0]), 6u) && allOk;
	allOk = compare_uint((h[1]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = i8vec2(ivec2(0, 9));
	a.mB = (vec3(5.0, -7.0, -6.0));
	a.mC = i8vec4(ivec4(9, 4294967291, 2, 4294967291));
	a.mD = (bvec2(false, false));
	b = (mat4x2(7.0, 4.0, 4.0, -5.0, -9.0, -3.0, 1.0, -4.0));
	c = u8vec3(uvec3(7u, 8u, 9u));
	d = (-4.0);
	e[0] = (uvec4(8u, 4u, 5u, 1u));
	e[1] = (uvec4(4u, 1u, 4u, 9u));
	e[2] = (uvec4(6u, 2u, 4u, 2u));
	e[3] = (uvec4(9u, 9u, 6u, 5u));
	e[4] = (uvec4(6u, 9u, 5u, 0u));
	g = (mat2(-4.0, 8.0, -8.0, -2.0));
	h[0] = (6u);
	h[1] = (6u);
}
#version 450
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
	layout(offset = 16) lowp vec2 b;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bool c;
	layout(offset = 16) lowp vec3 d[1];
	layout(offset = 32) mediump float e;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump uvec2 f;
	layout(offset = 8) lowp float g;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) highp vec4 h;
	layout(offset = 16) u8vec3 i;
	layout(offset = 20) mediump uvec2 j;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-7.0, 3.0, 4.0, -6.0)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(7.0, 7.0)) && allOk;
	allOk = compare_bool((c), false) && allOk;
	allOk = compare_float((e), -7.0) && allOk;
	allOk = compare_float((g), 9.0) && allOk;
	allOk = compare_vec4((h), vec4(6.0, 9.0, 1.0, 4.0)) && allOk;
	allOk = compare_u8vec3(uvec3(i), uvec3(8u, 7u, 5u)) && allOk;
	allOk = compare_uvec2((j), uvec2(1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(0.0, -2.0, -1.0, 6.0));
	blockB.b = (vec2(7.0, 4.0));
	d[0] = (vec3(-7.0, 2.0, -1.0));
	f = (uvec2(8u, 1u));
	g = (-5.0);
	h = (vec4(0.0, -6.0, 0.0, -8.0));
	i = u8vec3(uvec3(1u, 5u, 4u));
	j = (uvec2(3u, 4u));
}
#version 450
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
	layout(offset = 16) mediump uvec2 b;
	layout(offset = 32) lowp vec4 c;
	layout(offset = 48) uint8_t d;
	layout(offset = 49) i8vec3 e;
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp uint f;
	layout(offset = 4) uint8_t g;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec3 h;
	layout(offset = 12) int8_t i;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) i8vec2 j;
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[0].b), uvec2(2u, 6u)) && allOk;
	allOk = compare_vec4((blockB[0].c), vec4(9.0, 1.0, 1.0, -3.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[0].e), ivec3(7, 9, 4294967291)) && allOk;
	allOk = compare_uvec2((blockB[1].b), uvec2(0u, 9u)) && allOk;
	allOk = compare_vec4((blockB[1].c), vec4(-6.0, 9.0, -6.0, 2.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[1].e), ivec3(4294967293, 4294967293, 4294967291)) && allOk;
	allOk = compare_uint((blockC.f), 9u) && allOk;
	allOk = compare_int8_t(int(blockD.i), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec4(true, true, false, true));
	blockB[0].c = (vec4(-7.0, 8.0, 6.0, -7.0));
	blockB[0].d = uint8_t(3u);
	blockB[0].e = i8vec3(ivec3(4294967289, 3, 4294967287));
	blockB[1].a = (bvec4(true, false, true, false));
	blockB[1].c = (vec4(6.0, -8.0, -7.0, -8.0));
	blockB[1].d = uint8_t(5u);
	blockB[1].e = i8vec3(ivec3(4294967293, 8, 8));
	blockC.f = (2u);
	blockC.g = uint8_t(2u);
	blockD.h = (bvec3(false, true, false));
	blockE[0].j = i8vec2(ivec2(7, 4294967295));
}
#version 450
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
	layout(offset = 4) highp ivec2 b;
	layout(offset = 16) mediump ivec4 c;
	layout(offset = 32) u8vec2 d;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp uvec2 e;
	layout(offset = 16) lowp vec4 f;
	layout(offset = 32) int8_t g;
	layout(offset = 33) u8vec2 h;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) u8vec4 i;
	layout(offset = 16) bvec4 j;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(a), uvec4(1u, 1u, 2u, 6u)) && allOk;
	allOk = compare_ivec2((b), ivec2(-7, -9)) && allOk;
	allOk = compare_ivec4((c), ivec4(6, -7, 3, -8)) && allOk;
	allOk = compare_uvec2((blockC.e), uvec2(2u, 8u)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(5.0, -8.0, -3.0, -3.0)) && allOk;
	allOk = compare_int8_t(int(blockC.g), 4) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.h), uvec2(3u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.i), uvec4(0u, 7u, 1u, 0u)) && allOk;
	allOk = compare_bvec4((blockD.j), bvec4(false, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec4(uvec4(1u, 3u, 1u, 1u));
	b = (ivec2(2, 3));
	d = u8vec2(uvec2(1u, 1u));
	blockC.f = (vec4(9.0, -9.0, 4.0, -8.0));
	blockC.g = int8_t(4294967287);
	blockD.i = u8vec4(uvec4(8u, 8u, 6u, 9u));
	blockD.j = (bvec4(true, false, true, true));
}
#version 450
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
	layout(offset = 0) lowp uvec3 a[1];
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp uvec3 b;
	layout(offset = 16) bvec4 c;
	layout(offset = 32) mediump float d[1];
	layout(offset = 48) lowp ivec4 e[1];
} blockC[2];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump int f;
	layout(offset = 4) bvec2 g;
	layout(offset = 12) i8vec3 h;
	layout(offset = 16) lowp ivec3 i;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a[0]), uvec3(6u, 8u, 4u)) && allOk;
	allOk = compare_uvec3((blockC[0].b), uvec3(0u, 7u, 0u)) && allOk;
	allOk = compare_bvec4((blockC[0].c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_float((blockC[0].d[0]), 5.0) && allOk;
	allOk = compare_ivec4((blockC[0].e[0]), ivec4(6, -9, 5, 5)) && allOk;
	allOk = compare_uvec3((blockC[1].b), uvec3(0u, 6u, 7u)) && allOk;
	allOk = compare_bvec4((blockC[1].c), bvec4(false, false, false, true)) && allOk;
	allOk = compare_float((blockC[1].d[0]), 3.0) && allOk;
	allOk = compare_ivec4((blockC[1].e[0]), ivec4(-1, -9, -2, 9)) && allOk;
	allOk = compare_int((blockD.f), 0) && allOk;
	allOk = compare_bvec2((blockD.g), bvec2(true, false)) && allOk;
	allOk = compare_ivec3((blockD.i), ivec3(9, -1, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b = (uvec3(0u, 3u, 1u));
	blockC[0].e[0] = (ivec4(6, 3, -5, -2));
	blockC[1].b = (uvec3(7u, 2u, 2u));
	blockC[1].e[0] = (ivec4(-1, -6, 4, 6));
	blockD.g = (bvec2(false, false));
	blockD.h = i8vec3(ivec3(4294967291, 4294967295, 2));
}
#version 450
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
	lowp float a;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[nonuniformEXT(0)].a), 0.0) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(1)].a), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	layout(offset = 1) u8vec4 b;
	layout(offset = 16) highp vec3 c[1];
	layout(offset = 32) mediump mat3 d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(0)].a), 3u) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[nonuniformEXT(0)].b), uvec4(1u, 0u, 6u, 8u)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(0)].d, mat3(-1.0, 6.0, 0.0, -9.0, 1.0, 8.0, 1.0, -2.0, -8.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(1)].a), 9u) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[nonuniformEXT(1)].b), uvec4(8u, 6u, 8u, 1u)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(1)].d, mat3(5.0, -2.0, -8.0, -1.0, -6.0, 5.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(2)].a), 3u) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[nonuniformEXT(2)].b), uvec4(8u, 8u, 4u, 3u)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(2)].d, mat3(-5.0, -9.0, -7.0, 6.0, -3.0, 6.0, 4.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = u8vec4(uvec4(4u, 3u, 2u, 1u));
	blockB[nonuniformEXT(1)].b = u8vec4(uvec4(6u, 4u, 8u, 5u));
	blockB[nonuniformEXT(2)].b = u8vec4(uvec4(4u, 6u, 9u, 5u));
}
#version 450
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
	mediump ivec2 a;
	lowp vec2 b;
	highp mat4x3 c;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].a), ivec2(-5, -2)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].b), vec2(3.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].a), ivec2(7, -5)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].b), vec2(-4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (vec2(-1.0, -3.0));
	blockB[nonuniformEXT(1)].b = (vec2(5.0, 0.0));
}
#version 450
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
	uint8_t b;
	mediump ivec3 c[1];
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB[nonuniformEXT(0)].c[0]), ivec3(8, -9, 7)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(1)].c[0]), ivec3(-4, -3, 5)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(2)].c[0]), ivec3(-4, -9, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4x3(-1.0, 1.0, -1.0, 8.0, 9.0, -4.0, -2.0, 9.0, -9.0, 3.0, -8.0, -9.0));
	blockB[nonuniformEXT(0)].b = uint8_t(2u);
	blockB[nonuniformEXT(0)].c[0] = (ivec3(-3, 2, 4));
	blockB[nonuniformEXT(1)].a = (mat4x3(5.0, 8.0, 2.0, -6.0, 4.0, -5.0, -5.0, -9.0, -7.0, 7.0, -8.0, 8.0));
	blockB[nonuniformEXT(1)].b = uint8_t(3u);
	blockB[nonuniformEXT(1)].c[0] = (ivec3(1, 1, 7));
	blockB[nonuniformEXT(2)].a = (mat4x3(4.0, 5.0, 4.0, 8.0, -7.0, 0.0, 5.0, 7.0, -8.0, -8.0, 1.0, 1.0));
	blockB[nonuniformEXT(2)].b = uint8_t(7u);
	blockB[nonuniformEXT(2)].c[0] = (ivec3(-5, -9, 6));
}
#version 450
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
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -4.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], 0.0) && allOk;
	allOk = compare_vec2(var[0], vec2(4.0, 4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[2][0], 8.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[3][0], -7.0) && allOk;
	allOk = compare_float(var[3][1], -1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-4.0, -7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(8.0, 0.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], 8.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], 6.0) && allOk;
	allOk = compare_float(var[1][0], 7.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[2][0], -8.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], 3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(8.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(7.0, 7.0, 1.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-8.0, -2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x2(var, mat4x2(6.0, -6.0, 5.0, -1.0, -8.0, 2.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_float(var[2][0], -1.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[3][0], 0.0) && allOk;
	allOk = compare_float(var[3][1], -3.0) && allOk;
	allOk = compare_float(var[3][2], 7.0) && allOk;
	allOk = compare_vec3(var[0], vec3(1.0, 7.0, -7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, -1.0, -1.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-1.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(0.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2(var, mat2(2.0, -5.0, 4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-3.0, 1.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(7.0, 3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[0][3], -1.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], 2.0) && allOk;
	allOk = compare_float(var[2][0], 8.0) && allOk;
	allOk = compare_float(var[2][1], -3.0) && allOk;
	allOk = compare_float(var[2][2], 7.0) && allOk;
	allOk = compare_float(var[2][3], -1.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], 5.0) && allOk;
	allOk = compare_float(var[3][2], 9.0) && allOk;
	allOk = compare_float(var[3][3], 8.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-7.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(8.0, 4.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(8.0, -3.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-4.0, 5.0, 9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[0][3], 2.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_float(var[1][3], 2.0) && allOk;
	allOk = compare_float(var[2][0], 8.0) && allOk;
	allOk = compare_float(var[2][1], 3.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_float(var[2][3], -5.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], -8.0) && allOk;
	allOk = compare_float(var[3][2], -8.0) && allOk;
	allOk = compare_float(var[3][3], 5.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-4.0, 1.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(8.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(8.0, 3.0, -6.0, -5.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-5.0, -8.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2x3(var, mat2x3(-5.0, -4.0, 8.0, -5.0, 6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2x4(var, mat2x4(-2.0, 5.0, -5.0, -5.0, 0.0, 4.0, 4.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(-5.0, -7.0, -2.0, 6.0, -3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(-6.0, 0.0, 3.0, -8.0, 9.0, -8.0, 5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(-8.0, -3.0, 8.0, 3.0, 2.0, -5.0, -2.0, -1.0, -1.0, -3.0, 6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x4(var[0], mat3x4(5.0, -7.0, -9.0, 4.0, 5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-9.0, 7.0, -4.0, 5.0, -9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(4.0, 1.0, 3.0, -1.0, -3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x2(var[0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bvec4 var[3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), true) && allOk;
	allOk = compare_bvec4((var[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[1]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((var[2]), bvec4(false, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat2(var[0], mat2(3.0, -8.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(5.0, 4.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(2.0, -7.0, 4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(-3.0, -5.0, -5.0, -4.0, 8.0, -3.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-8.0, 9.0, -7.0, -5.0, -5.0, -5.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(3.0, -7.0, 5.0, 3.0, 9.0, -8.0, 8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	u8vec3 var[];
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(var[0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2]), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[4]), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[5]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[6]), uvec3(3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[7]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[8]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[9]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[10]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[11]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[12]), uvec3(8u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[13]), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[14]), uvec3(3u, 9u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[15]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[16]), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[17]), uvec3(9u, 3u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[18]), uvec3(5u, 0u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bvec3 var[];
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((var[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[3]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[4]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[5]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((var[6]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((var[7]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[8]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[9]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[10]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[11]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[12]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[13]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[14]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[15]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[16]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[17]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[18]), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_float(block.var[0][0], 2.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], 4.0) && allOk;
	allOk = compare_float(block.var[1][1], 1.0) && allOk;
	allOk = compare_float(block.var[1][2], 2.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(2.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(4.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(9.0, 9.0, 9.0));
	block.var[1] = (vec3(8.0, -3.0, -5.0));
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[0][2], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][2], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], -1.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], 6.0) && allOk;
	allOk = compare_float(block.var[3][0], 0.0) && allOk;
	allOk = compare_float(block.var[3][1], -3.0) && allOk;
	allOk = compare_float(block.var[3][2], 7.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(1.0, 7.0, -7.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(3.0, -1.0, -1.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-1.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(0.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(1.0, 1.0, 8.0));
	block.var[1] = (vec3(0.0, 4.0, -9.0));
	block.var[2] = (vec3(-3.0, 7.0, -6.0));
	block.var[3] = (vec3(-7.0, -9.0, -7.0));
}
#version 450
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
	allOk = compare_vec4((block.var), vec4(-2.0, 4.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (vec4(-3.0, 6.0, 7.0, 3.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 2.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], 4.0) && allOk;
	allOk = compare_float(block.var[1][1], 1.0) && allOk;
	allOk = compare_float(block.var[1][2], 2.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(2.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(4.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(9.0, 9.0, 9.0));
	block.var[1] = (vec3(8.0, -3.0, -5.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(-6.0, -6.0, -8.0, -2.0, -6.0, -3.0, 8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(2.0, -2.0, -6.0, 0.0, -7.0, 7.0, -9.0, 0.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], 5.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], -2.0) && allOk;
	allOk = compare_float(block.var[2][1], 2.0) && allOk;
	allOk = compare_float(block.var[3][0], -4.0) && allOk;
	allOk = compare_float(block.var[3][1], 3.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-7.0, 5.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(5.0, -5.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(4.0, 4.0, -5.0, -6.0, 0.0, 4.0, 2.0, 9.0));
}
#version 450
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
	i8vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(block.var), ivec2(4294967288, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = i8vec2(ivec2(0, 8));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[1][0], 5.0) && allOk;
	allOk = compare_float(block.var[1][1], -4.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-3.0, 1.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var = (mat2(-6.0, -5.0, -4.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 4.0) && allOk;
	allOk = compare_mat4x3(block.var, mat4x3(1.0, 0.0, 3.0, 8.0, -3.0, -1.0, 2.0, -9.0, 8.0, -7.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var = (mat4x3(9.0, 9.0, -3.0, 6.0, 1.0, 1.0, -1.0, -1.0, -5.0, -7.0, -2.0, -1.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	block.var[1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	block.var[2] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2x4(block.var[0], mat2x4(-1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0][0] = (vec4(-6.0, -9.0, -3.0, 5.0));
	block.var[0][1] = (vec4(1.0, -7.0, 1.0, -7.0));
	block.var[1][0] = (vec4(-4.0, 1.0, 9.0, -1.0));
	block.var[1][1] = (vec4(-2.0, 2.0, 4.0, -1.0));
	block.var[2][0] = (vec4(-9.0, -6.0, 6.0, -7.0));
	block.var[2][1] = (vec4(5.0, 8.0, 4.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_mat3x4(block.var[0], mat3x4(-7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0, -9.0, 3.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0, -4.0, 9.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0, -6.0, -7.0, 8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var[0][0] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block.var[0][1] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block.var[0][2] = (vec4(-4.0, 2.0, -3.0, 0.0));
	block.var[1][0] = (vec4(5.0, 2.0, 6.0, 6.0));
	block.var[1][1] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block.var[1][2] = (vec4(6.0, 0.0, 6.0, 3.0));
	block.var[2][0] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block.var[2][1] = (vec4(7.0, -8.0, -3.0, -2.0));
	block.var[2][2] = (vec4(-3.0, 6.0, -2.0, 6.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat4x3(block.var[0], mat4x3(5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0, 9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0, -2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0, 8.0, 7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0] = (mat4x3(-5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0, 9.0, 2.0, -5.0));
	block.var[1] = (mat4x3(-6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0, 2.0, 4.0, 4.0));
	block.var[2] = (mat4x3(-9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0, 2.0, 8.0, 9.0));
}
#version 450
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
	f16vec3 var[3];
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
	allOk = compare_f16vec3(vec3(block.var[0]), vec3(1.0, 9.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1]), vec3(7.0, -5.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2]), vec3(2.0, -4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = float16_t(3.0);
	block.var[0] = f16vec3(vec3(3.0, 7.0, -3.0));
	block.var[1] = f16vec3(vec3(-5.0, -9.0, -1.0));
	block.var[2] = f16vec3(vec3(0.0, 6.0, 5.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(8.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(8.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(9.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(-1.0, -8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(3.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(0.0, -3.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(8.0, -5.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(7.0, 8.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(9.0, 8.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(3.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(-3.0, -8.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(6.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(-2.0, -9.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(4.0, -9.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	block.var[1] = (mat2(2.0, 2.0, -4.0, -5.0));
	block.var[2] = (mat2(-1.0, -4.0, 0.0, -1.0));
	block.var[3] = (mat2(0.0, 4.0, -3.0, -4.0));
	block.var[4] = (mat2(-6.0, 0.0, 5.0, 1.0));
	block.var[5] = (mat2(-6.0, 9.0, 5.0, 9.0));
	block.var[6] = (mat2(5.0, -3.0, -3.0, 6.0));
	block.var[7] = (mat2(-4.0, -6.0, -2.0, -6.0));
	block.var[8] = (mat2(-3.0, -4.0, -7.0, -9.0));
	block.var[9] = (mat2(8.0, 2.0, -6.0, 9.0));
	block.var[10] = (mat2(-5.0, -2.0, 4.0, 9.0));
	block.var[11] = (mat2(4.0, 7.0, 4.0, -8.0));
	block.var[12] = (mat2(5.0, 7.0, 7.0, -8.0));
	block.var[13] = (mat2(7.0, -9.0, -2.0, 4.0));
	block.var[14] = (mat2(3.0, 3.0, 3.0, -6.0));
	block.var[15] = (mat2(-4.0, -8.0, -2.0, 5.0));
	block.var[16] = (mat2(-3.0, 5.0, 0.0, -2.0));
	block.var[17] = (mat2(-3.0, 0.0, -9.0, 1.0));
	block.var[18] = (mat2(-8.0, 1.0, -1.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3], mat3x2(-2.0, -1.0, 5.0, 2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[4], mat3x2(9.0, -5.0, 7.0, 6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[5], mat3x2(-1.0, -4.0, 0.0, -2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[6], mat3x2(7.0, 3.0, -1.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[7], mat3x2(-8.0, -5.0, 9.0, -3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[8], mat3x2(-4.0, 6.0, -7.0, 0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[9], mat3x2(-9.0, 0.0, 9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[10], mat3x2(-7.0, -5.0, 3.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[11], mat3x2(-3.0, -2.0, 3.0, -8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[12], mat3x2(-4.0, -8.0, -7.0, -9.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[13], mat3x2(-1.0, -4.0, -4.0, 6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[14], mat3x2(-8.0, 8.0, -4.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[15], mat3x2(-3.0, -7.0, -5.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[16], mat3x2(0.0, -8.0, -1.0, 9.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[17], mat3x2(-7.0, -9.0, 6.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[18], mat3x2(0.0, 9.0, -1.0, -2.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(9.0, -4.0));
	block.var[0][1] = (vec2(-7.0, 8.0));
	block.var[0][2] = (vec2(-2.0, -9.0));
	block.var[1][0] = (vec2(-1.0, 7.0));
	block.var[1][1] = (vec2(-3.0, -3.0));
	block.var[1][2] = (vec2(-8.0, 2.0));
	block.var[2][0] = (vec2(-2.0, -1.0));
	block.var[2][1] = (vec2(-3.0, -3.0));
	block.var[2][2] = (vec2(-4.0, 5.0));
	block.var[3][0] = (vec2(9.0, 7.0));
	block.var[3][1] = (vec2(-4.0, 7.0));
	block.var[3][2] = (vec2(1.0, 6.0));
	block.var[4][0] = (vec2(-8.0, 9.0));
	block.var[4][1] = (vec2(8.0, 1.0));
	block.var[4][2] = (vec2(6.0, 8.0));
	block.var[5][0] = (vec2(-1.0, 2.0));
	block.var[5][1] = (vec2(1.0, -1.0));
	block.var[5][2] = (vec2(0.0, 3.0));
	block.var[6][0] = (vec2(-3.0, -2.0));
	block.var[6][1] = (vec2(-9.0, -8.0));
	block.var[6][2] = (vec2(-8.0, 4.0));
	block.var[7][0] = (vec2(-2.0, 9.0));
	block.var[7][1] = (vec2(-1.0, 3.0));
	block.var[7][2] = (vec2(-2.0, 9.0));
	block.var[8][0] = (vec2(-2.0, -4.0));
	block.var[8][1] = (vec2(-1.0, 9.0));
	block.var[8][2] = (vec2(-9.0, -4.0));
	block.var[9][0] = (vec2(-3.0, -2.0));
	block.var[9][1] = (vec2(7.0, -5.0));
	block.var[9][2] = (vec2(-5.0, 0.0));
	block.var[10][0] = (vec2(4.0, -4.0));
	block.var[10][1] = (vec2(5.0, 5.0));
	block.var[10][2] = (vec2(2.0, -3.0));
	block.var[11][0] = (vec2(-5.0, -3.0));
	block.var[11][1] = (vec2(-7.0, 6.0));
	block.var[11][2] = (vec2(-6.0, 8.0));
	block.var[12][0] = (vec2(9.0, 4.0));
	block.var[12][1] = (vec2(-8.0, -6.0));
	block.var[12][2] = (vec2(4.0, -6.0));
	block.var[13][0] = (vec2(-9.0, -3.0));
	block.var[13][1] = (vec2(8.0, 9.0));
	block.var[13][2] = (vec2(4.0, -8.0));
	block.var[14][0] = (vec2(0.0, -4.0));
	block.var[14][1] = (vec2(6.0, -1.0));
	block.var[14][2] = (vec2(-7.0, 8.0));
	block.var[15][0] = (vec2(4.0, 2.0));
	block.var[15][1] = (vec2(2.0, -3.0));
	block.var[15][2] = (vec2(1.0, -6.0));
	block.var[16][0] = (vec2(7.0, 3.0));
	block.var[16][1] = (vec2(-7.0, 5.0));
	block.var[16][2] = (vec2(2.0, -9.0));
	block.var[17][0] = (vec2(-2.0, -8.0));
	block.var[17][1] = (vec2(-9.0, 5.0));
	block.var[17][2] = (vec2(-2.0, 1.0));
	block.var[18][0] = (vec2(2.0, -5.0));
	block.var[18][1] = (vec2(2.0, 8.0));
	block.var[18][2] = (vec2(1.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(6.0, -1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(-5.0, -9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(2.0, -1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(7.0, 1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(2.0, 9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(9.0, 6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(6.0, -3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	block.var[1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	block.var[2] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	block.var[3] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	block.var[4] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	block.var[5] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	block.var[6] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	block.var[7] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	block.var[8] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	block.var[9] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	block.var[10] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	block.var[11] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
	block.var[12] = (mat4x3(-2.0, 7.0, -6.0, -4.0, -2.0, 0.0, 4.0, -2.0, 6.0, -6.0, -5.0, -8.0));
	block.var[13] = (mat4x3(-1.0, 2.0, 4.0, 2.0, -2.0, 9.0, 0.0, -4.0, 6.0, -7.0, -4.0, 2.0));
	block.var[14] = (mat4x3(1.0, 2.0, -9.0, -3.0, 6.0, -9.0, 8.0, 2.0, 1.0, -8.0, 3.0, 2.0));
	block.var[15] = (mat4x3(1.0, 4.0, 9.0, -7.0, -5.0, 2.0, -8.0, 0.0, 0.0, -4.0, 9.0, 5.0));
	block.var[16] = (mat4x3(-2.0, -9.0, 6.0, -9.0, -4.0, -7.0, 9.0, -5.0, 3.0, 5.0, -1.0, -4.0));
	block.var[17] = (mat4x3(1.0, -1.0, -8.0, 4.0, 4.0, 4.0, -3.0, 4.0, 0.0, 0.0, -7.0, -1.0));
	block.var[18] = (mat4x3(2.0, 6.0, 9.0, -5.0, -9.0, -9.0, 5.0, 6.0, 4.0, 6.0, -3.0, 1.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(6.0, -4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(3.0, 2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(2.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(-7.0, 8.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(3.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(2.0, -7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(1.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(-5.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(-8.0, 7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(-8.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(-3.0, -8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(5.0, -3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(-9.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(9.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(4.0, 4.0, -9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(1.0, 2.0, 6.0, -6.0));
	block.var[1] = (mat2(2.0, 4.0, 4.0, 7.0));
	block.var[2] = (mat2(0.0, 8.0, 0.0, -1.0));
	block.var[3] = (mat2(8.0, -4.0, -5.0, 7.0));
	block.var[4] = (mat2(-3.0, -1.0, 0.0, 6.0));
	block.var[5] = (mat2(-6.0, 7.0, 4.0, -7.0));
	block.var[6] = (mat2(1.0, -8.0, -9.0, -7.0));
	block.var[7] = (mat2(1.0, -2.0, -6.0, -8.0));
	block.var[8] = (mat2(-6.0, -6.0, 2.0, -9.0));
	block.var[9] = (mat2(9.0, 0.0, -3.0, -7.0));
	block.var[10] = (mat2(8.0, 8.0, 7.0, -3.0));
	block.var[11] = (mat2(7.0, 2.0, -8.0, -7.0));
	block.var[12] = (mat2(5.0, 1.0, -7.0, -2.0));
	block.var[13] = (mat2(-8.0, -9.0, 4.0, -4.0));
	block.var[14] = (mat2(-7.0, -9.0, -5.0, 3.0));
	block.var[15] = (mat2(-1.0, -1.0, -6.0, -3.0));
	block.var[16] = (mat2(-9.0, -4.0, -8.0, -1.0));
	block.var[17] = (mat2(-8.0, 1.0, -2.0, 9.0));
	block.var[18] = (mat2(9.0, 4.0, -3.0, -3.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(0.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(-4.0, -1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(-1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(-7.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(-9.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(-4.0, -9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(-9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(-9.0, 2.0, -7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(-3.0, 3.0));
	block.var[0][0][1] = (vec2(4.0, 4.0));
	block.var[0][1][0] = (vec2(9.0, -9.0));
	block.var[0][1][1] = (vec2(-5.0, 8.0));
	block.var[0][2][0] = (vec2(0.0, 4.0));
	block.var[0][2][1] = (vec2(2.0, -4.0));
	block.var[1][0][0] = (vec2(-3.0, 3.0));
	block.var[1][0][1] = (vec2(-8.0, -7.0));
	block.var[1][1][0] = (vec2(-7.0, -6.0));
	block.var[1][1][1] = (vec2(-2.0, 1.0));
	block.var[1][2][0] = (vec2(-4.0, 3.0));
	block.var[1][2][1] = (vec2(0.0, 7.0));
	block.var[2][0][0] = (vec2(-7.0, -5.0));
	block.var[2][0][1] = (vec2(6.0, -6.0));
	block.var[2][1][0] = (vec2(-4.0, 0.0));
	block.var[2][1][1] = (vec2(2.0, 3.0));
	block.var[2][2][0] = (vec2(-2.0, -4.0));
	block.var[2][2][1] = (vec2(-1.0, 1.0));
	block.var[3][0][0] = (vec2(8.0, -9.0));
	block.var[3][0][1] = (vec2(8.0, -6.0));
	block.var[3][1][0] = (vec2(7.0, -2.0));
	block.var[3][1][1] = (vec2(1.0, -2.0));
	block.var[3][2][0] = (vec2(-7.0, -6.0));
	block.var[3][2][1] = (vec2(8.0, -4.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(-7.0, 6.0, -9.0, 5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(8.0, -3.0, -5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(-1.0, 3.0, 2.0, -6.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(8.0, -3.0, 9.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(2.0, 4.0, 5.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(0.0, 1.0, 8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(-4.0, 8.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(-5.0, -5.0, 2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-7.0, -1.0, -4.0, 8.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	block.var[0][1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	block.var[0][2] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
	block.var[1][0] = (mat3x2(-4.0, -9.0, 4.0, 7.0, 9.0, 7.0));
	block.var[1][1] = (mat3x2(9.0, -1.0, -5.0, 6.0, -2.0, 6.0));
	block.var[1][2] = (mat3x2(-6.0, -8.0, 1.0, 5.0, 7.0, 1.0));
	block.var[2][0] = (mat3x2(0.0, 0.0, 2.0, -7.0, 5.0, 1.0));
	block.var[2][1] = (mat3x2(6.0, 0.0, -1.0, -4.0, -5.0, -3.0));
	block.var[2][2] = (mat3x2(-8.0, 4.0, -1.0, 9.0, -1.0, 7.0));
	block.var[3][0] = (mat3x2(-8.0, -3.0, 6.0, 0.0, 4.0, 4.0));
	block.var[3][1] = (mat3x2(-8.0, 8.0, -9.0, -4.0, 5.0, 5.0));
	block.var[3][2] = (mat3x2(4.0, 7.0, -3.0, 2.0, 8.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-5.0, -5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(-5.0, 8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(5.0, -4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(-3.0, 0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(-1.0, 0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(7.0, -1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(2.0, 6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(2.0, -4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(-7.0, -7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(1.0, 2.0, -5.0));
	block.var[0][0][1] = (vec3(-3.0, -2.0, 2.0));
	block.var[0][0][2] = (vec3(-5.0, 9.0, 4.0));
	block.var[0][0][3] = (vec3(2.0, -4.0, 9.0));
	block.var[0][1][0] = (vec3(8.0, -4.0, -5.0));
	block.var[0][1][1] = (vec3(-5.0, 6.0, 8.0));
	block.var[0][1][2] = (vec3(-7.0, 4.0, -8.0));
	block.var[0][1][3] = (vec3(-1.0, 1.0, 1.0));
	block.var[0][2][0] = (vec3(-4.0, 5.0, 7.0));
	block.var[0][2][1] = (vec3(9.0, 5.0, -7.0));
	block.var[0][2][2] = (vec3(8.0, 9.0, 0.0));
	block.var[0][2][3] = (vec3(-3.0, 3.0, 0.0));
	block.var[1][0][0] = (vec3(7.0, -8.0, -7.0));
	block.var[1][0][1] = (vec3(2.0, 7.0, 5.0));
	block.var[1][0][2] = (vec3(5.0, -7.0, 0.0));
	block.var[1][0][3] = (vec3(-2.0, 9.0, -7.0));
	block.var[1][1][0] = (vec3(2.0, -9.0, 0.0));
	block.var[1][1][1] = (vec3(9.0, -2.0, -8.0));
	block.var[1][1][2] = (vec3(-9.0, 5.0, 9.0));
	block.var[1][1][3] = (vec3(0.0, 8.0, -9.0));
	block.var[1][2][0] = (vec3(2.0, 1.0, -7.0));
	block.var[1][2][1] = (vec3(-7.0, 8.0, 7.0));
	block.var[1][2][2] = (vec3(8.0, -8.0, -5.0));
	block.var[1][2][3] = (vec3(5.0, 1.0, -3.0));
	block.var[2][0][0] = (vec3(2.0, 5.0, 2.0));
	block.var[2][0][1] = (vec3(2.0, 3.0, -2.0));
	block.var[2][0][2] = (vec3(5.0, 4.0, 6.0));
	block.var[2][0][3] = (vec3(-1.0, 5.0, 6.0));
	block.var[2][1][0] = (vec3(1.0, 2.0, -4.0));
	block.var[2][1][1] = (vec3(9.0, -1.0, 6.0));
	block.var[2][1][2] = (vec3(9.0, -1.0, -2.0));
	block.var[2][1][3] = (vec3(-1.0, -8.0, 3.0));
	block.var[2][2][0] = (vec3(-4.0, 1.0, -4.0));
	block.var[2][2][1] = (vec3(4.0, 2.0, 0.0));
	block.var[2][2][2] = (vec3(1.0, -6.0, 1.0));
	block.var[2][2][3] = (vec3(-7.0, -9.0, 8.0));
	block.var[3][0][0] = (vec3(1.0, 9.0, -4.0));
	block.var[3][0][1] = (vec3(1.0, -5.0, 9.0));
	block.var[3][0][2] = (vec3(2.0, -1.0, -1.0));
	block.var[3][0][3] = (vec3(5.0, 7.0, -4.0));
	block.var[3][1][0] = (vec3(-2.0, 9.0, -4.0));
	block.var[3][1][1] = (vec3(-4.0, 4.0, -1.0));
	block.var[3][1][2] = (vec3(0.0, 7.0, 9.0));
	block.var[3][1][3] = (vec3(-8.0, 3.0, 9.0));
	block.var[3][2][0] = (vec3(-7.0, -1.0, -9.0));
	block.var[3][2][1] = (vec3(-7.0, 3.0, 5.0));
	block.var[3][2][2] = (vec3(-7.0, 1.0, -1.0));
	block.var[3][2][3] = (vec3(-5.0, -7.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0], mat3x4(-8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0, -2.0, -5.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0, 9.0, -2.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0, 8.0, -3.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(-2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0, 1.0, 4.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0, -6.0, -8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0, 8.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(-2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0, -9.0, 1.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0, 1.0, -4.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0, 5.0, 3.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(-3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0, 6.0, 7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(-3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0, 1.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0, 8.0, -1.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0][0] = (mat3x4(-6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0, 6.0, 4.0, -6.0, -9.0));
	block.var[0][1] = (mat3x4(-4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0, 9.0, -2.0, 3.0, -7.0));
	block.var[0][2] = (mat3x4(-1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0, 6.0, 0.0, 4.0, -9.0));
	block.var[1][0] = (mat3x4(-5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0, 1.0, -3.0, -5.0, -4.0));
	block.var[1][1] = (mat3x4(-8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0, 4.0, 3.0, 8.0, -9.0));
	block.var[1][2] = (mat3x4(-6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0, -3.0, 7.0, -7.0, 3.0));
	block.var[2][0] = (mat3x4(-9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0, 1.0, -4.0, -8.0, 1.0));
	block.var[2][1] = (mat3x4(-9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0, -1.0, -1.0, -7.0, 9.0));
	block.var[2][2] = (mat3x4(-7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0, 2.0, -4.0, -9.0, 4.0));
	block.var[3][0] = (mat3x4(-7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0, -5.0, 0.0, -5.0, -9.0));
	block.var[3][1] = (mat3x4(-9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0, 0.0, 8.0, 4.0, 6.0));
	block.var[3][2] = (mat3x4(6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0, -3.0, -7.0, -8.0, -5.0));
}
#version 450
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
	highp float var[4][2][3];
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
	allOk = compare_float((block.var[0][0][2]), -6.0) && allOk;
	allOk = compare_float((block.var[0][1][0]), 1.0) && allOk;
	allOk = compare_float((block.var[0][1][1]), -3.0) && allOk;
	allOk = compare_float((block.var[0][1][2]), -7.0) && allOk;
	allOk = compare_float((block.var[1][0][0]), 0.0) && allOk;
	allOk = compare_float((block.var[1][0][1]), -7.0) && allOk;
	allOk = compare_float((block.var[1][0][2]), 5.0) && allOk;
	allOk = compare_float((block.var[1][1][0]), 8.0) && allOk;
	allOk = compare_float((block.var[1][1][1]), -9.0) && allOk;
	allOk = compare_float((block.var[1][1][2]), -4.0) && allOk;
	allOk = compare_float((block.var[2][0][0]), 4.0) && allOk;
	allOk = compare_float((block.var[2][0][1]), 2.0) && allOk;
	allOk = compare_float((block.var[2][0][2]), -1.0) && allOk;
	allOk = compare_float((block.var[2][1][0]), -4.0) && allOk;
	allOk = compare_float((block.var[2][1][1]), -5.0) && allOk;
	allOk = compare_float((block.var[2][1][2]), 9.0) && allOk;
	allOk = compare_float((block.var[3][0][0]), -6.0) && allOk;
	allOk = compare_float((block.var[3][0][1]), -2.0) && allOk;
	allOk = compare_float((block.var[3][0][2]), -1.0) && allOk;
	allOk = compare_float((block.var[3][1][0]), 7.0) && allOk;
	allOk = compare_float((block.var[3][1][1]), -7.0) && allOk;
	allOk = compare_float((block.var[3][1][2]), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (-2.0);
	block.var[0][0][1] = (4.0);
	block.var[0][0][2] = (6.0);
	block.var[0][1][0] = (-6.0);
	block.var[0][1][1] = (-9.0);
	block.var[0][1][2] = (-4.0);
	block.var[1][0][0] = (7.0);
	block.var[1][0][1] = (-4.0);
	block.var[1][0][2] = (5.0);
	block.var[1][1][0] = (3.0);
	block.var[1][1][1] = (7.0);
	block.var[1][1][2] = (6.0);
	block.var[2][0][0] = (-8.0);
	block.var[2][0][1] = (9.0);
	block.var[2][0][2] = (-5.0);
	block.var[2][1][0] = (5.0);
	block.var[2][1][1] = (4.0);
	block.var[2][1][2] = (-8.0);
	block.var[3][0][0] = (8.0);
	block.var[3][0][1] = (-5.0);
	block.var[3][0][2] = (6.0);
	block.var[3][1][0] = (5.0);
	block.var[3][1][1] = (8.0);
	block.var[3][1][2] = (9.0);
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(2.0, -9.0, 8.0, -3.0, -3.0, -1.0, -8.0, -7.0, -8.0, 4.0, 2.0, -4.0, -5.0, 1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(6.0, -2.0, -2.0, -9.0, 7.0, 8.0, -4.0, -9.0, -8.0, -4.0, 6.0, 7.0, -4.0, -5.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(3.0, 8.0, 3.0, 9.0, -8.0, 9.0, 4.0, -3.0, -1.0, -3.0, 5.0, -1.0, 3.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-4.0, -1.0, 7.0, 7.0, 0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(5.0, 0.0, 8.0, -9.0, 0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(-4.0, -3.0, -4.0, -7.0, 4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-7.0, 9.0, -8.0, -7.0, -5.0, 5.0, 6.0, 9.0, -7.0, -2.0, 5.0, 7.0, -2.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(3.0, 7.0, 1.0, -2.0, 8.0, 6.0, 9.0, 5.0, 3.0, 4.0, -8.0, -4.0, -5.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(-3.0, 9.0, 7.0, -3.0, 8.0, -4.0, -7.0, 1.0, -3.0, 9.0, -9.0, -1.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(9.0, -6.0, 6.0, 6.0, -2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-4.0, -3.0, -8.0, 5.0, 8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(5.0, -1.0, 6.0, 0.0, -1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(8.0, 1.0, -4.0, 3.0, 7.0, 9.0, 6.0, -6.0, 2.0, 8.0, 2.0, 3.0, -8.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-5.0, 3.0, -1.0, -1.0, -9.0, 4.0, -7.0, 5.0, 5.0, 3.0, 8.0, -1.0, 6.0, 3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(-5.0, 5.0, 1.0, 6.0, 0.0, -7.0, -5.0, -8.0, 2.0, 0.0, 4.0, 9.0, -3.0, 8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(0.0, -4.0, 0.0, 2.0, 5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(9.0, 2.0, 5.0, -7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(-9.0, -5.0, 3.0, -4.0, -6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(5.0, -3.0, -9.0, 6.0, -1.0, -9.0, 1.0, -2.0, 4.0, -2.0, 2.0, -5.0, 6.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(4.0, 4.0, 9.0, -5.0, -1.0, 8.0, 9.0, 8.0, 5.0, 6.0, -9.0, 1.0, 9.0, 8.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(-5.0, 7.0, -9.0, -5.0, 6.0, -4.0, -5.0, -4.0, -9.0, -8.0, 9.0, 4.0, 2.0, 5.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	block.var[0][0][1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	block.var[0][0][2] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
	block.var[0][1][0] = (mat4(4.0, -5.0, 0.0, -7.0, 5.0, 6.0, -9.0, 8.0, -2.0, -3.0, -2.0, -2.0, -4.0, -1.0, -7.0, -8.0));
	block.var[0][1][1] = (mat4(6.0, 2.0, 6.0, -7.0, 2.0, 4.0, -8.0, -9.0, -9.0, -5.0, -7.0, 1.0, 9.0, 1.0, 5.0, -3.0));
	block.var[0][1][2] = (mat4(7.0, 8.0, 7.0, -3.0, 0.0, -2.0, -3.0, -6.0, -6.0, -6.0, 6.0, -6.0, -6.0, 9.0, 8.0, -5.0));
	block.var[1][0][0] = (mat4(-3.0, 1.0, -5.0, 0.0, -1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0));
	block.var[1][0][1] = (mat4(4.0, 7.0, 2.0, 2.0, 5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0));
	block.var[1][0][2] = (mat4(-6.0, 0.0, -6.0, 3.0, -1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0));
	block.var[1][1][0] = (mat4(4.0, -4.0, 4.0, 7.0, -4.0, 5.0, -8.0, 5.0, -8.0, 9.0, 3.0, 9.0, 3.0, -3.0, -8.0, -6.0));
	block.var[1][1][1] = (mat4(2.0, 4.0, -9.0, 6.0, 4.0, -1.0, 2.0, 1.0, 2.0, 6.0, -9.0, -1.0, -5.0, -1.0, -7.0, 9.0));
	block.var[1][1][2] = (mat4(6.0, -6.0, -2.0, -7.0, 6.0, 8.0, -3.0, -9.0, 7.0, 6.0, -5.0, 9.0, -5.0, 0.0, -9.0, 3.0));
	block.var[2][0][0] = (mat4(7.0, 9.0, -3.0, -6.0, 3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0));
	block.var[2][0][1] = (mat4(3.0, -3.0, 1.0, 4.0, -1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0));
	block.var[2][0][2] = (mat4(-6.0, -5.0, 3.0, -8.0, -4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0));
	block.var[2][1][0] = (mat4(-6.0, -4.0, 9.0, 8.0, 6.0, 8.0, -4.0, 1.0, -6.0, 4.0, -2.0, 2.0, -3.0, -4.0, 3.0, -5.0));
	block.var[2][1][1] = (mat4(2.0, 9.0, -7.0, -6.0, 2.0, -1.0, 9.0, 2.0, 9.0, -4.0, 4.0, -1.0, -3.0, -4.0, 0.0, -3.0));
	block.var[2][1][2] = (mat4(8.0, -4.0, -1.0, -5.0, 9.0, -8.0, -2.0, -9.0, -5.0, -3.0, 0.0, 0.0, 1.0, 1.0, -4.0, 4.0));
	block.var[3][0][0] = (mat4(-5.0, 2.0, 1.0, 1.0, -7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0));
	block.var[3][0][1] = (mat4(-4.0, -3.0, 2.0, -2.0, 4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0));
	block.var[3][0][2] = (mat4(6.0, -9.0, 7.0, 7.0, -1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0));
	block.var[3][1][0] = (mat4(-9.0, -9.0, 4.0, 8.0, 2.0, -6.0, -1.0, 5.0, -4.0, -6.0, -8.0, 7.0, 4.0, -2.0, -4.0, -1.0));
	block.var[3][1][1] = (mat4(1.0, 7.0, 5.0, 2.0, 5.0, 9.0, 3.0, -9.0, -6.0, -4.0, 4.0, 7.0, 6.0, -1.0, -7.0, -5.0));
	block.var[3][1][2] = (mat4(0.0, 9.0, 4.0, 7.0, 3.0, -1.0, 9.0, -1.0, 3.0, 3.0, 5.0, 7.0, 7.0, -8.0, -9.0, -5.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(3.0, -1.0, 4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(7.0, 0.0, -3.0, 7.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(-3.0, -5.0, -4.0, -9.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(0.0, -2.0, -7.0, 9.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-6.0, 8.0, -1.0, 3.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(-5.0, -2.0, 3.0, -9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(8.0, -6.0, -1.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(-5.0, -2.0, 2.0, -7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(3.0, 5.0, 2.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(4.0, 7.0, 0.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(4.0, 4.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(2.0, 4.0, 7.0, 9.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-1.0, 9.0, -7.0, -1.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(6.0, -9.0, -4.0, 2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(6.0, 0.0, -9.0, -8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(7.0, 5.0, -9.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(1.0, 4.0, -6.0, 3.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(1.0, -7.0, -5.0, -9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(0.0, 1.0, -9.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(-4.0, 5.0, -3.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(9.0, 8.0, 8.0, 5.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(4.0, 5.0, 5.0, 8.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(-6.0, 0.0, -5.0, 2.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(-6.0, -8.0, -1.0, -8.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	block.var[0][0][1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	block.var[0][0][2] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
	block.var[0][1][0] = (mat2x3(-1.0, -9.0, 3.0, -5.0, 2.0, 6.0));
	block.var[0][1][1] = (mat2x3(5.0, 8.0, 1.0, 0.0, 1.0, -3.0));
	block.var[0][1][2] = (mat2x3(-5.0, -7.0, -6.0, -7.0, -8.0, -4.0));
	block.var[1][0][0] = (mat2x3(9.0, 3.0, 8.0, 4.0, 4.0, 2.0));
	block.var[1][0][1] = (mat2x3(4.0, -1.0, -6.0, -5.0, 9.0, 7.0));
	block.var[1][0][2] = (mat2x3(-1.0, -3.0, -1.0, 6.0, 4.0, 8.0));
	block.var[1][1][0] = (mat2x3(-9.0, 8.0, 1.0, -7.0, 4.0, 8.0));
	block.var[1][1][1] = (mat2x3(3.0, -9.0, 6.0, 7.0, 2.0, -8.0));
	block.var[1][1][2] = (mat2x3(0.0, -7.0, -7.0, -2.0, 8.0, -5.0));
	block.var[2][0][0] = (mat2x3(-2.0, -1.0, 6.0, 5.0, -8.0, 8.0));
	block.var[2][0][1] = (mat2x3(-3.0, 5.0, -8.0, -9.0, 9.0, 7.0));
	block.var[2][0][2] = (mat2x3(-3.0, -1.0, -2.0, 6.0, 2.0, -6.0));
	block.var[2][1][0] = (mat2x3(-2.0, 1.0, -5.0, -3.0, -5.0, -9.0));
	block.var[2][1][1] = (mat2x3(3.0, 8.0, -9.0, 8.0, 6.0, 0.0));
	block.var[2][1][2] = (mat2x3(2.0, 3.0, 4.0, 3.0, 4.0, 2.0));
	block.var[3][0][0] = (mat2x3(-7.0, 6.0, 7.0, -8.0, 5.0, -5.0));
	block.var[3][0][1] = (mat2x3(5.0, -1.0, 8.0, -7.0, -3.0, -4.0));
	block.var[3][0][2] = (mat2x3(-5.0, 3.0, -8.0, 9.0, -8.0, 3.0));
	block.var[3][1][0] = (mat2x3(-1.0, -4.0, 9.0, -8.0, 2.0, 8.0));
	block.var[3][1][1] = (mat2x3(6.0, -6.0, 4.0, -3.0, -1.0, -9.0));
	block.var[3][1][2] = (mat2x3(6.0, 3.0, -4.0, -2.0, 7.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(8.0, -5.0, -3.0, -5.0, 3.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-3.0, 9.0, 0.0, 7.0, 9.0, -6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(-9.0, 3.0, -7.0, -8.0, 7.0, -1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-7.0, 0.0, -1.0, -5.0, 7.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-2.0, 4.0, 6.0, -4.0, 1.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(9.0, 0.0, 1.0, -9.0, -5.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(6.0, 1.0, -3.0, -1.0, -3.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(2.0, 4.0, -4.0, 9.0, 9.0, 7.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(5.0, -9.0, -2.0, 8.0, 7.0, 0.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(8.0, -9.0, -2.0, -7.0, 6.0, -6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(4.0, -2.0, -9.0, 4.0, 9.0, 1.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(6.0, 9.0, 2.0, 5.0, -9.0, -3.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	block.var[0][0][1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	block.var[0][0][2] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
	block.var[0][1][0] = (mat4x2(-7.0, 4.0, -8.0, -6.0, -3.0, -4.0, 8.0, -4.0));
	block.var[0][1][1] = (mat4x2(6.0, -9.0, -7.0, -3.0, -9.0, -6.0, -3.0, -8.0));
	block.var[0][1][2] = (mat4x2(8.0, -4.0, -8.0, 4.0, 0.0, 4.0, -3.0, 8.0));
	block.var[1][0][0] = (mat4x2(-5.0, -9.0, -1.0, -9.0, 0.0, -4.0, 2.0, -7.0));
	block.var[1][0][1] = (mat4x2(-3.0, -5.0, 1.0, -5.0, -1.0, 7.0, 4.0, 4.0));
	block.var[1][0][2] = (mat4x2(-5.0, 2.0, -4.0, -3.0, 0.0, 4.0, -7.0, 5.0));
	block.var[1][1][0] = (mat4x2(0.0, 7.0, -2.0, -3.0, -5.0, 6.0, -2.0, 7.0));
	block.var[1][1][1] = (mat4x2(4.0, -1.0, 6.0, -2.0, 0.0, 7.0, 0.0, 2.0));
	block.var[1][1][2] = (mat4x2(-7.0, -7.0, -6.0, 8.0, -7.0, -4.0, 9.0, 9.0));
	block.var[2][0][0] = (mat4x2(1.0, -9.0, 0.0, -4.0, 2.0, 9.0, -5.0, -3.0));
	block.var[2][0][1] = (mat4x2(6.0, -4.0, -9.0, 5.0, -5.0, -6.0, 8.0, -5.0));
	block.var[2][0][2] = (mat4x2(-4.0, -5.0, 6.0, 9.0, -3.0, -4.0, 3.0, -7.0));
	block.var[2][1][0] = (mat4x2(4.0, -8.0, -6.0, -3.0, 8.0, -1.0, -5.0, 5.0));
	block.var[2][1][1] = (mat4x2(1.0, 9.0, -4.0, -5.0, 1.0, -2.0, 7.0, 1.0));
	block.var[2][1][2] = (mat4x2(-3.0, -1.0, 4.0, 9.0, 6.0, 3.0, -9.0, 2.0));
	block.var[3][0][0] = (mat4x2(-8.0, 8.0, -4.0, -6.0, 0.0, -3.0, -6.0, -4.0));
	block.var[3][0][1] = (mat4x2(5.0, 4.0, 5.0, 7.0, 2.0, -7.0, 8.0, -3.0));
	block.var[3][0][2] = (mat4x2(8.0, 7.0, 0.0, -5.0, 4.0, 5.0, -6.0, -8.0));
	block.var[3][1][0] = (mat4x2(-3.0, 9.0, 7.0, -5.0, -4.0, 0.0, -9.0, 9.0));
	block.var[3][1][1] = (mat4x2(6.0, 8.0, -4.0, -2.0, -7.0, -7.0, -4.0, 9.0));
	block.var[3][1][2] = (mat4x2(6.0, 7.0, -4.0, 6.0, -5.0, -4.0, 7.0, -1.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(9.0, -6.0, -8.0, -7.0, 2.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-4.0, 1.0, 5.0, 2.0, -6.0, 5.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(8.0, 9.0, 2.0, -7.0, -8.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(2.0, -9.0, -1.0, 9.0, -9.0, -1.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(4.0, 4.0, 6.0, -7.0, -9.0, 5.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(4.0, 7.0, 4.0, 9.0, -4.0, 3.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(6.0, 4.0, 1.0, -8.0, -6.0, -5.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-2.0, -3.0, 3.0, 9.0, -4.0, 6.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(6.0, -6.0, -5.0, -5.0, -2.0, -1.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-3.0, -4.0, 4.0, -9.0, 1.0, -3.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-7.0, 5.0, 0.0, -2.0, -9.0, 4.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(3.0, -8.0, 1.0, -3.0, -4.0, -4.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-8.0, 7.0, 2.0, -1.0, -4.0, 9.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(1.0, -3.0, -2.0, 3.0, 7.0, 1.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(4.0, 7.0, -8.0, 0.0, 4.0, 0.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(7.0, 0.0, -5.0, 3.0, 3.0, -5.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-5.0, 9.0, -3.0, 8.0, 2.0, 5.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(6.0, -8.0, 7.0, 6.0, -7.0, 0.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(2.0, -4.0, -2.0, 1.0, -7.0, 6.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(1.0, 6.0, -5.0, -9.0, -6.0, 4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(-2.0, 7.0, 8.0, -1.0, -1.0, -3.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(-1.0, 6.0, -3.0, 7.0, -9.0, -8.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(-2.0, -9.0, 3.0, 4.0, -4.0, 4.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(-3.0, -3.0, -9.0, 4.0, -5.0, 6.0, -2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0][0][0][0] = (vec2(-2.0, 8.0));
	block.var[0][0][0][1] = (vec2(-4.0, 4.0));
	block.var[0][0][0][2] = (vec2(9.0, 5.0));
	block.var[0][0][0][3] = (vec2(-9.0, -2.0));
	block.var[0][0][1][0] = (vec2(6.0, -8.0));
	block.var[0][0][1][1] = (vec2(-5.0, -1.0));
	block.var[0][0][1][2] = (vec2(9.0, 0.0));
	block.var[0][0][1][3] = (vec2(4.0, 5.0));
	block.var[0][0][2][0] = (vec2(4.0, -5.0));
	block.var[0][0][2][1] = (vec2(-2.0, -4.0));
	block.var[0][0][2][2] = (vec2(6.0, 4.0));
	block.var[0][0][2][3] = (vec2(-2.0, 5.0));
	block.var[0][1][0][0] = (vec2(-4.0, 6.0));
	block.var[0][1][0][1] = (vec2(-7.0, 4.0));
	block.var[0][1][0][2] = (vec2(-6.0, -5.0));
	block.var[0][1][0][3] = (vec2(0.0, -2.0));
	block.var[0][1][1][0] = (vec2(-3.0, 0.0));
	block.var[0][1][1][1] = (vec2(-8.0, -9.0));
	block.var[0][1][1][2] = (vec2(6.0, 0.0));
	block.var[0][1][1][3] = (vec2(7.0, 6.0));
	block.var[0][1][2][0] = (vec2(2.0, 3.0));
	block.var[0][1][2][1] = (vec2(-4.0, -6.0));
	block.var[0][1][2][2] = (vec2(5.0, -1.0));
	block.var[0][1][2][3] = (vec2(-7.0, -8.0));
	block.var[1][0][0][0] = (vec2(-6.0, -5.0));
	block.var[1][0][0][1] = (vec2(7.0, -6.0));
	block.var[1][0][0][2] = (vec2(8.0, 5.0));
	block.var[1][0][0][3] = (vec2(5.0, 5.0));
	block.var[1][0][1][0] = (vec2(-6.0, -3.0));
	block.var[1][0][1][1] = (vec2(-1.0, -1.0));
	block.var[1][0][1][2] = (vec2(-2.0, 6.0));
	block.var[1][0][1][3] = (vec2(-5.0, -1.0));
	block.var[1][0][2][0] = (vec2(-5.0, 5.0));
	block.var[1][0][2][1] = (vec2(5.0, 9.0));
	block.var[1][0][2][2] = (vec2(-7.0, 0.0));
	block.var[1][0][2][3] = (vec2(-8.0, 6.0));
	block.var[1][1][0][0] = (vec2(0.0, 0.0));
	block.var[1][1][0][1] = (vec2(-7.0, -3.0));
	block.var[1][1][0][2] = (vec2(-7.0, -3.0));
	block.var[1][1][0][3] = (vec2(7.0, 2.0));
	block.var[1][1][1][0] = (vec2(3.0, 3.0));
	block.var[1][1][1][1] = (vec2(-8.0, -2.0));
	block.var[1][1][1][2] = (vec2(-4.0, 0.0));
	block.var[1][1][1][3] = (vec2(6.0, 2.0));
	block.var[1][1][2][0] = (vec2(2.0, 3.0));
	block.var[1][1][2][1] = (vec2(-3.0, 2.0));
	block.var[1][1][2][2] = (vec2(4.0, 1.0));
	block.var[1][1][2][3] = (vec2(5.0, 6.0));
	block.var[2][0][0][0] = (vec2(5.0, 2.0));
	block.var[2][0][0][1] = (vec2(6.0, -4.0));
	block.var[2][0][0][2] = (vec2(-4.0, 8.0));
	block.var[2][0][0][3] = (vec2(4.0, 5.0));
	block.var[2][0][1][0] = (vec2(7.0, 0.0));
	block.var[2][0][1][1] = (vec2(-7.0, -4.0));
	block.var[2][0][1][2] = (vec2(1.0, -1.0));
	block.var[2][0][1][3] = (vec2(-1.0, 7.0));
	block.var[2][0][2][0] = (vec2(9.0, -9.0));
	block.var[2][0][2][1] = (vec2(7.0, -8.0));
	block.var[2][0][2][2] = (vec2(5.0, -4.0));
	block.var[2][0][2][3] = (vec2(-6.0, 4.0));
	block.var[2][1][0][0] = (vec2(3.0, 5.0));
	block.var[2][1][0][1] = (vec2(2.0, 5.0));
	block.var[2][1][0][2] = (vec2(-8.0, 8.0));
	block.var[2][1][0][3] = (vec2(5.0, -9.0));
	block.var[2][1][1][0] = (vec2(-5.0, 3.0));
	block.var[2][1][1][1] = (vec2(3.0, 5.0));
	block.var[2][1][1][2] = (vec2(9.0, -6.0));
	block.var[2][1][1][3] = (vec2(3.0, 4.0));
	block.var[2][1][2][0] = (vec2(-1.0, 3.0));
	block.var[2][1][2][1] = (vec2(0.0, 0.0));
	block.var[2][1][2][2] = (vec2(-4.0, 6.0));
	block.var[2][1][2][3] = (vec2(-3.0, -3.0));
	block.var[3][0][0][0] = (vec2(9.0, 1.0));
	block.var[3][0][0][1] = (vec2(-6.0, -3.0));
	block.var[3][0][0][2] = (vec2(-7.0, 9.0));
	block.var[3][0][0][3] = (vec2(3.0, 3.0));
	block.var[3][0][1][0] = (vec2(3.0, -7.0));
	block.var[3][0][1][1] = (vec2(0.0, 6.0));
	block.var[3][0][1][2] = (vec2(-8.0, -2.0));
	block.var[3][0][1][3] = (vec2(5.0, 7.0));
	block.var[3][0][2][0] = (vec2(2.0, -2.0));
	block.var[3][0][2][1] = (vec2(8.0, 8.0));
	block.var[3][0][2][2] = (vec2(1.0, -3.0));
	block.var[3][0][2][3] = (vec2(-6.0, -8.0));
	block.var[3][1][0][0] = (vec2(-9.0, 4.0));
	block.var[3][1][0][1] = (vec2(0.0, 1.0));
	block.var[3][1][0][2] = (vec2(4.0, 4.0));
	block.var[3][1][0][3] = (vec2(9.0, 9.0));
	block.var[3][1][1][0] = (vec2(-6.0, 2.0));
	block.var[3][1][1][1] = (vec2(-2.0, -9.0));
	block.var[3][1][1][2] = (vec2(-4.0, 6.0));
	block.var[3][1][1][3] = (vec2(-8.0, 1.0));
	block.var[3][1][2][0] = (vec2(-8.0, -1.0));
	block.var[3][1][2][1] = (vec2(8.0, 4.0));
	block.var[3][1][2][2] = (vec2(7.0, -3.0));
	block.var[3][1][2][3] = (vec2(7.0, -4.0));
}
#version 450
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
	u16vec2 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.padding), 8u) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][0][0]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][0][1]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][0][2]), uvec2(6u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][1][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][1][1]), uvec2(2u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][1][2]), uvec2(2u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][0][0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][0][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][0][2]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][1][0]), uvec2(9u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][1][1]), uvec2(8u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][1][2]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][0][0]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][0][1]), uvec2(9u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][0][2]), uvec2(1u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][1][0]), uvec2(0u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][1][1]), uvec2(8u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][1][2]), uvec2(4u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][0][0]), uvec2(5u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][0][1]), uvec2(4u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][0][2]), uvec2(1u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][1][0]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][1][1]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][1][2]), uvec2(2u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint16_t(8u);
	block.var[0][0][0] = u16vec2(uvec2(0u, 6u));
	block.var[0][0][1] = u16vec2(uvec2(0u, 6u));
	block.var[0][0][2] = u16vec2(uvec2(9u, 3u));
	block.var[0][1][0] = u16vec2(uvec2(0u, 3u));
	block.var[0][1][1] = u16vec2(uvec2(9u, 8u));
	block.var[0][1][2] = u16vec2(uvec2(9u, 1u));
	block.var[1][0][0] = u16vec2(uvec2(2u, 9u));
	block.var[1][0][1] = u16vec2(uvec2(2u, 4u));
	block.var[1][0][2] = u16vec2(uvec2(5u, 1u));
	block.var[1][1][0] = u16vec2(uvec2(2u, 5u));
	block.var[1][1][1] = u16vec2(uvec2(7u, 9u));
	block.var[1][1][2] = u16vec2(uvec2(9u, 7u));
	block.var[2][0][0] = u16vec2(uvec2(1u, 2u));
	block.var[2][0][1] = u16vec2(uvec2(8u, 1u));
	block.var[2][0][2] = u16vec2(uvec2(5u, 0u));
	block.var[2][1][0] = u16vec2(uvec2(6u, 4u));
	block.var[2][1][1] = u16vec2(uvec2(4u, 6u));
	block.var[2][1][2] = u16vec2(uvec2(4u, 5u));
	block.var[3][0][0] = u16vec2(uvec2(2u, 3u));
	block.var[3][0][1] = u16vec2(uvec2(8u, 1u));
	block.var[3][0][2] = u16vec2(uvec2(8u, 7u));
	block.var[3][1][0] = u16vec2(uvec2(7u, 9u));
	block.var[3][1][1] = u16vec2(uvec2(3u, 3u));
	block.var[3][1][2] = u16vec2(uvec2(2u, 6u));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(0.0, -5.0, 8.0, -6.0, -1.0, -7.0, 0.0, 3.0, -2.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(-4.0, -5.0, 4.0, 2.0, -5.0, -5.0, -9.0, 2.0, -7.0, 9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(0.0, -3.0, -6.0, 4.0, -8.0, -1.0, 9.0, 9.0, 2.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(-7.0, 4.0, 7.0, 7.0, 0.0, -9.0, -8.0, -1.0, -6.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(2.0, 0.0, -4.0, 6.0, 3.0, -2.0, -9.0, 8.0, -8.0, 8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(-7.0, -2.0, 9.0, -3.0, 9.0, -8.0, 1.0, -7.0, -8.0, -9.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(8.0, -2.0, 1.0, 8.0, 4.0, 6.0, -6.0, -5.0, 1.0, -7.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(5.0, 1.0, 1.0, -6.0, 0.0, -8.0, -7.0, 3.0, 3.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(-2.0, 9.0, -3.0, -1.0, -8.0, 5.0, 9.0, -3.0, 7.0, 2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(0.0, 7.0, -2.0, 1.0, 7.0, 1.0, -5.0, 4.0, 4.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-2.0, -2.0, 3.0, -6.0, -5.0, -1.0, 2.0, -4.0, -8.0, -7.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(-3.0, -9.0, 3.0, 8.0, 3.0, 7.0, 9.0, 3.0, -3.0, 7.0, -8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	block.var[0][0][0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	block.var[0][0][0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	block.var[0][0][1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	block.var[0][0][1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	block.var[0][0][1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	block.var[0][1][0][0] = (vec4(7.0, 4.0, -2.0, -4.0));
	block.var[0][1][0][1] = (vec4(6.0, -9.0, -7.0, 3.0));
	block.var[0][1][0][2] = (vec4(-3.0, -6.0, -1.0, 0.0));
	block.var[0][1][1][0] = (vec4(2.0, 3.0, -1.0, 9.0));
	block.var[0][1][1][1] = (vec4(-3.0, -9.0, -1.0, 0.0));
	block.var[0][1][1][2] = (vec4(-9.0, 1.0, 6.0, 5.0));
	block.var[0][2][0][0] = (vec4(7.0, 5.0, 1.0, 8.0));
	block.var[0][2][0][1] = (vec4(-4.0, 6.0, -3.0, -6.0));
	block.var[0][2][0][2] = (vec4(2.0, -9.0, -8.0, 6.0));
	block.var[0][2][1][0] = (vec4(-7.0, 0.0, 5.0, 8.0));
	block.var[0][2][1][1] = (vec4(9.0, 8.0, -6.0, -2.0));
	block.var[0][2][1][2] = (vec4(9.0, -5.0, 4.0, -4.0));
	block.var[0][3][0][0] = (vec4(-1.0, -1.0, -9.0, -5.0));
	block.var[0][3][0][1] = (vec4(6.0, 2.0, -2.0, 8.0));
	block.var[0][3][0][2] = (vec4(9.0, 2.0, -4.0, 7.0));
	block.var[0][3][1][0] = (vec4(-8.0, -7.0, 8.0, -8.0));
	block.var[0][3][1][1] = (vec4(-5.0, 2.0, -3.0, 5.0));
	block.var[0][3][1][2] = (vec4(-3.0, -2.0, -5.0, 3.0));
	block.var[1][0][0][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	block.var[1][0][0][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	block.var[1][0][0][2] = (vec4(0.0, 4.0, 1.0, -9.0));
	block.var[1][0][1][0] = (vec4(3.0, -3.0, 5.0, 9.0));
	block.var[1][0][1][1] = (vec4(4.0, -2.0, -3.0, -6.0));
	block.var[1][0][1][2] = (vec4(8.0, 9.0, -9.0, -5.0));
	block.var[1][1][0][0] = (vec4(-8.0, 4.0, -8.0, 5.0));
	block.var[1][1][0][1] = (vec4(4.0, 3.0, -7.0, 5.0));
	block.var[1][1][0][2] = (vec4(-4.0, 7.0, 2.0, -6.0));
	block.var[1][1][1][0] = (vec4(-2.0, 4.0, -9.0, -3.0));
	block.var[1][1][1][1] = (vec4(7.0, 5.0, -1.0, 1.0));
	block.var[1][1][1][2] = (vec4(6.0, -2.0, -5.0, 9.0));
	block.var[1][2][0][0] = (vec4(-5.0, -1.0, -2.0, -8.0));
	block.var[1][2][0][1] = (vec4(-2.0, 5.0, -5.0, 9.0));
	block.var[1][2][0][2] = (vec4(7.0, -5.0, -3.0, 0.0));
	block.var[1][2][1][0] = (vec4(-5.0, -6.0, 7.0, 0.0));
	block.var[1][2][1][1] = (vec4(7.0, -8.0, -6.0, 0.0));
	block.var[1][2][1][2] = (vec4(7.0, -9.0, 2.0, 3.0));
	block.var[1][3][0][0] = (vec4(-3.0, 8.0, -3.0, -6.0));
	block.var[1][3][0][1] = (vec4(-4.0, 6.0, -2.0, -2.0));
	block.var[1][3][0][2] = (vec4(-4.0, -3.0, -1.0, -3.0));
	block.var[1][3][1][0] = (vec4(7.0, 9.0, -4.0, 8.0));
	block.var[1][3][1][1] = (vec4(-6.0, 4.0, -4.0, -8.0));
	block.var[1][3][1][2] = (vec4(1.0, 2.0, 2.0, -4.0));
	block.var[2][0][0][0] = (vec4(3.0, 4.0, -1.0, -5.0));
	block.var[2][0][0][1] = (vec4(9.0, -2.0, 4.0, -9.0));
	block.var[2][0][0][2] = (vec4(1.0, -8.0, -2.0, 1.0));
	block.var[2][0][1][0] = (vec4(-8.0, -2.0, 9.0, 8.0));
	block.var[2][0][1][1] = (vec4(-5.0, -8.0, -2.0, 7.0));
	block.var[2][0][1][2] = (vec4(-3.0, -9.0, 0.0, -9.0));
	block.var[2][1][0][0] = (vec4(-6.0, 2.0, 5.0, -5.0));
	block.var[2][1][0][1] = (vec4(2.0, 4.0, -3.0, 1.0));
	block.var[2][1][0][2] = (vec4(9.0, -1.0, -1.0, -1.0));
	block.var[2][1][1][0] = (vec4(7.0, -4.0, -7.0, -3.0));
	block.var[2][1][1][1] = (vec4(9.0, -7.0, -5.0, -9.0));
	block.var[2][1][1][2] = (vec4(3.0, 9.0, 2.0, -5.0));
	block.var[2][2][0][0] = (vec4(6.0, -9.0, -7.0, 6.0));
	block.var[2][2][0][1] = (vec4(0.0, 2.0, 9.0, -1.0));
	block.var[2][2][0][2] = (vec4(3.0, -4.0, 9.0, -2.0));
	block.var[2][2][1][0] = (vec4(-4.0, 6.0, 1.0, -2.0));
	block.var[2][2][1][1] = (vec4(-4.0, 3.0, 1.0, -1.0));
	block.var[2][2][1][2] = (vec4(9.0, -4.0, -1.0, 3.0));
	block.var[2][3][0][0] = (vec4(-1.0, -9.0, 2.0, 6.0));
	block.var[2][3][0][1] = (vec4(5.0, 9.0, 3.0, -7.0));
	block.var[2][3][0][2] = (vec4(7.0, -8.0, -1.0, -8.0));
	block.var[2][3][1][0] = (vec4(3.0, -4.0, 6.0, -5.0));
	block.var[2][3][1][1] = (vec4(-5.0, 3.0, 5.0, -2.0));
	block.var[2][3][1][2] = (vec4(-3.0, 2.0, 1.0, 6.0));
}
#version 450
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

layout(scalar, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(6.0, 7.0, 9.0, 7.0, 0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(7.0, -7.0, 1.0, 0.0, -9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(-2.0, -2.0, 7.0, -9.0, 3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(-9.0, 0.0, -2.0, -3.0, 4.0, -7.0, 8.0, -2.0, -7.0, -1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(0.0, 8.0, -8.0, -9.0, 5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(9.0, -4.0, -6.0, 0.0, 0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(6.0, 7.0, 1.0, 5.0, 4.0, 9.0, 5.0, 4.0, 9.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(1.0, 0.0, -7.0, -4.0, -3.0, 3.0, -7.0, 4.0, 1.0, 0.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(5.0, 2.0, -1.0, 1.0, 1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(-5.0, 1.0, 4.0, 5.0, 5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-1.0, 9.0, 4.0, -7.0, -2.0, 8.0, 8.0, 5.0, 3.0, -7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(-8.0, -3.0, 1.0, -8.0, -6.0, 9.0, 2.0, 4.0, 4.0, 1.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	block.var[0][0][0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block.var[0][0][0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block.var[0][0][1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	block.var[0][0][1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	block.var[0][0][1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block.var[0][1][0][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	block.var[0][1][0][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	block.var[0][1][0][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	block.var[0][1][1][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	block.var[0][1][1][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	block.var[0][1][1][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	block.var[0][2][0][0] = (vec4(6.0, 2.0, 8.0, -5.0));
	block.var[0][2][0][1] = (vec4(9.0, 5.0, 9.0, -1.0));
	block.var[0][2][0][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[0][2][1][0] = (vec4(0.0, -4.0, 7.0, 1.0));
	block.var[0][2][1][1] = (vec4(4.0, 1.0, 9.0, 9.0));
	block.var[0][2][1][2] = (vec4(-9.0, -5.0, 3.0, 8.0));
	block.var[0][3][0][0] = (vec4(1.0, -1.0, -4.0, 2.0));
	block.var[0][3][0][1] = (vec4(5.0, 8.0, 5.0, -9.0));
	block.var[0][3][0][2] = (vec4(7.0, -9.0, 0.0, -3.0));
	block.var[0][3][1][0] = (vec4(-6.0, 6.0, -6.0, -5.0));
	block.var[0][3][1][1] = (vec4(5.0, 3.0, 4.0, 8.0));
	block.var[0][3][1][2] = (vec4(7.0, 0.0, -5.0, -6.0));
	block.var[1][0][0][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	block.var[1][0][0][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block.var[1][0][0][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	block.var[1][0][1][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	block.var[1][0][1][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	block.var[1][0][1][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	block.var[1][1][0][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	block.var[1][1][0][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	block.var[1][1][0][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	block.var[1][1][1][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	block.var[1][1][1][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	block.var[1][1][1][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	block.var[1][2][0][0] = (vec4(4.0, -1.0, -2.0, 2.0));
	block.var[1][2][0][1] = (vec4(-5.0, 4.0, -2.0, -4.0));
	block.var[1][2][0][2] = (vec4(8.0, -7.0, -1.0, -9.0));
	block.var[1][2][1][0] = (vec4(8.0, 5.0, 3.0, 6.0));
	block.var[1][2][1][1] = (vec4(0.0, 6.0, 0.0, 2.0));
	block.var[1][2][1][2] = (vec4(-1.0, -5.0, -6.0, -4.0));
	block.var[1][3][0][0] = (vec4(5.0, 0.0, 8.0, 4.0));
	block.var[1][3][0][1] = (vec4(3.0, -1.0, -7.0, 0.0));
	block.var[1][3][0][2] = (vec4(-1.0, 6.0, -6.0, 1.0));
	block.var[1][3][1][0] = (vec4(0.0, 8.0, 0.0, 9.0));
	block.var[1][3][1][1] = (vec4(-6.0, 8.0, -5.0, -1.0));
	block.var[1][3][1][2] = (vec4(0.0, 6.0, -9.0, 9.0));
	block.var[2][0][0][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	block.var[2][0][0][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	block.var[2][0][0][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	block.var[2][0][1][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	block.var[2][0][1][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	block.var[2][0][1][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	block.var[2][1][0][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	block.var[2][1][0][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	block.var[2][1][0][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	block.var[2][1][1][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	block.var[2][1][1][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	block.var[2][1][1][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
	block.var[2][2][0][0] = (vec4(-3.0, -5.0, -4.0, -4.0));
	block.var[2][2][0][1] = (vec4(-8.0, -8.0, 1.0, 7.0));
	block.var[2][2][0][2] = (vec4(-6.0, -3.0, -7.0, 1.0));
	block.var[2][2][1][0] = (vec4(-5.0, 5.0, 0.0, 1.0));
	block.var[2][2][1][1] = (vec4(6.0, 2.0, 5.0, 5.0));
	block.var[2][2][1][2] = (vec4(5.0, -1.0, -7.0, -1.0));
	block.var[2][3][0][0] = (vec4(8.0, -2.0, -5.0, 0.0));
	block.var[2][3][0][1] = (vec4(1.0, 4.0, -3.0, -6.0));
	block.var[2][3][0][2] = (vec4(2.0, -2.0, -2.0, 3.0));
	block.var[2][3][1][0] = (vec4(-5.0, -4.0, -6.0, 2.0));
	block.var[2][3][1][1] = (vec4(-6.0, 0.0, 1.0, 9.0));
	block.var[2][3][1][2] = (vec4(2.0, 5.0, -8.0, 5.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	bvec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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

layout(std430, buffer_reference) buffer Block
{
	bvec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((block[0].var), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block[1].var), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block[2].var), bvec4(false, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (bvec4(true, true, true, false));
	block[1].var = (bvec4(true, false, false, false));
	block[2].var = (bvec4(false, true, true, true));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
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
	allOk = compare_mat3(block[0].var, mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].var, mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].var, mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	block[1].var = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	block[2].var = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
}
#version 450
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
    Block block[3];
};

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

layout(std430, buffer_reference) buffer Block
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
	allOk = compare_mat2x4(block[0].var, mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	block[1].var = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	block[2].var = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -1.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(8.0, -1.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 2.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-4.0, -3.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(4.0, 2.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -6.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(8.0, -3.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(3.0, -5.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(-3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(-8.0, -4.0));
	block[0].var[1] = (vec2(-3.0, 5.0));
	block[0].var[2] = (vec2(-9.0, 4.0));
	block[1].var[0] = (vec2(-2.0, -1.0));
	block[1].var[1] = (vec2(8.0, 3.0));
	block[1].var[2] = (vec2(7.0, 2.0));
	block[2].var[0] = (vec2(-4.0, 4.0));
	block[2].var[1] = (vec2(3.0, -6.0));
	block[2].var[2] = (vec2(-4.0, 3.0));
}
#version 450
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
	allOk = compare_mat4x3(block[0].var, mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	block[1].var = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	block[2].var = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -4.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 5.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(3.0, -8.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(8.0, 5.0)) && allOk;
	allOk = compare_float((block[1].padding), 5.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 2.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-2.0, 2.0)) && allOk;
	allOk = compare_float((block[2].padding), -7.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(4.0, -7.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (2.0);
	block[0].var = (mat2(4.0, 4.0, -1.0, 2.0));
	block[1].padding = (-5.0);
	block[1].var = (mat2(1.0, -1.0, -2.0, -9.0));
	block[2].padding = (-3.0);
	block[2].var = (mat2(-8.0, -6.0, -7.0, 1.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 0.0) && allOk;
	allOk = compare_mat4(block[0].var, mat4(-2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_float((block[1].padding), -1.0) && allOk;
	allOk = compare_mat4(block[1].var, mat4(-2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0, 8.0, 1.0, 7.0, -9.0, -6.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -8.0) && allOk;
	allOk = compare_mat4(block[2].var, mat4(-8.0, -3.0, 6.0, -5.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -2.0, -7.0, 6.0, 1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-6.0);
	block[0].var = (mat4(5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0, 6.0, -9.0, 9.0, -6.0));
	block[1].padding = (-2.0);
	block[1].var = (mat4(9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0, 3.0, -2.0, 2.0, -7.0, 6.0, -2.0, -6.0, -4.0));
	block[2].padding = (3.0);
	block[2].var = (mat4(-2.0, 9.0, -2.0, 6.0, -7.0, 8.0, 1.0, 6.0, 7.0, 8.0, -3.0, 6.0, -4.0, 7.0, -3.0, -4.0));
}
#version 450
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
	allOk = compare_float((blockA.a), 4.0) && allOk;
	allOk = compare_uint((blockB.b.a), 6u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(1.0, -3.0, 5.0, -5.0, -7.0, -9.0, -3.0, -8.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(-3, 6)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(1, 1)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(0, 6)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(-9, -3)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(2.0, 5.0, -4.0, -1.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-8.0);
	blockA.b.a = (mat3(8.0, -7.0, -9.0, 5.0, 2.0, 9.0, -9.0, -9.0, 0.0));
	blockA.b.b[0] = (ivec2(-3, 7));
	blockA.b.b[1] = (ivec2(-9, 8));
	blockA.b.b[2] = (ivec2(-2, 5));
	blockA.b.b[3] = (ivec2(1, 6));
	blockA.b.c = (vec4(4.0, -5.0, -1.0, -2.0));
	blockB.a = (mat2(-2.0, -9.0, 9.0, 9.0));
	blockB.b.a = (4u);
	blockB.b.b.a = (mat3(-5.0, 0.0, 4.0, 6.0, 5.0, -6.0, -8.0, 4.0, -6.0));
	blockB.b.b.b[0] = (ivec2(-1, 8));
	blockB.b.b.b[1] = (ivec2(-1, 6));
	blockB.b.b.b[2] = (ivec2(-2, 7));
	blockB.b.b.b[3] = (ivec2(-9, -6));
	blockB.b.b.c = (vec4(-6.0, 3.0, -3.0, 8.0));
	blockB.b.c = (bvec4(true, true, true, false));
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

layout(std140, buffer_reference) buffer BlockB
{
	lowp mat4 a;
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump uvec4 b[1];
	lowp vec2 c;
	bvec3 d;
	highp vec2 e;
	mediump mat3x2 f;
};
layout(std430, column_major, buffer_reference) readonly buffer BlockD
{
	mediump vec4 g;
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	mediump vec4 h[1];
	mediump mat3x2 i;
	mediump uvec3 j;
	bvec3 k;
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(-7.0, 8.0, 8.0, 2.0, 4.0, 0.0, -2.0, 6.0, -1.0, 5.0, -9.0, 9.0, -2.0, -9.0, 2.0, 0.0)) && allOk;
	allOk = compare_vec2((blockC.c), vec2(0.0, -2.0)) && allOk;
	allOk = compare_bvec3((blockC.d), bvec3(false, true, true)) && allOk;
	allOk = compare_vec4((blockE.h[0]), vec4(4.0, -9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockE.i, mat3x2(-1.0, 0.0, -3.0, 2.0, 5.0, 7.0)) && allOk;
	allOk = compare_uvec3((blockE.j), uvec3(0u, 1u, 7u)) && allOk;
	allOk = compare_bvec3((blockE.k), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(0.0, -7.0, 3.0, -2.0, 2.0, -7.0, 4.0, 6.0, -8.0, 8.0, -3.0, 3.0, -3.0, -1.0, 6.0, 9.0));
	blockC.b[0] = (uvec4(3u, 6u, 3u, 4u));
	blockC.c = (vec2(2.0, -3.0));
	blockC.e = (vec2(-5.0, -2.0));
	blockC.f = (mat3x2(-2.0, 8.0, -3.0, -3.0, -8.0, 1.0));
	blockE.h[0] = (vec4(-4.0, -5.0, -1.0, -3.0));
	blockE.i = (mat3x2(1.0, 9.0, -9.0, -8.0, 8.0, -8.0));
	blockE.j = (uvec3(2u, 3u, 1u));
}
#version 450
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
	highp ivec3 b[];
};
layout(std430, buffer_reference) readonly buffer BlockC
{
	highp vec2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockC.c[0]), vec2(6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(1, 1));
}
#version 450
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
	mediump mat4x3 mA;
	mediump mat3 mB;
};
struct sB
{
	bool mA;
	mediump uvec3 mB;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	sA a;
	mediump uvec4 b[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp mat2x3 c;
	highp vec3 d;
	sB e[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	highp uvec2 f[6];
	highp mat3x2 g[];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockE
{
	mediump mat4 h;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b[0]), uvec4(3u, 0u, 2u, 4u)) && allOk;
	allOk = compare_uvec4((blockB.b[1]), uvec4(8u, 0u, 9u, 4u)) && allOk;
	allOk = compare_uvec4((blockB.b[2]), uvec4(9u, 1u, 8u, 6u)) && allOk;
	allOk = compare_uvec4((blockB.b[3]), uvec4(2u, 0u, 8u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.b[4]), uvec4(3u, 5u, 4u, 9u)) && allOk;
	allOk = compare_uvec4((blockB.b[5]), uvec4(1u, 0u, 7u, 2u)) && allOk;
	allOk = compare_uvec2((blockD.f[0]), uvec2(9u, 7u)) && allOk;
	allOk = compare_uvec2((blockD.f[1]), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec2((blockD.f[2]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((blockD.f[3]), uvec2(7u, 3u)) && allOk;
	allOk = compare_uvec2((blockD.f[4]), uvec2(2u, 7u)) && allOk;
	allOk = compare_uvec2((blockD.f[5]), uvec2(0u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (mat4x3(-5.0, -6.0, -7.0, -3.0, 6.0, 8.0, -2.0, -6.0, 5.0, 0.0, 3.0, -6.0));
	blockB.a.mB = (mat3(-7.0, 3.0, -4.0, -2.0, -1.0, -6.0, 2.0, 4.0, -7.0));
	blockB.b[0] = (uvec4(9u, 3u, 4u, 5u));
	blockB.b[1] = (uvec4(6u, 1u, 9u, 7u));
	blockB.b[2] = (uvec4(4u, 0u, 5u, 5u));
	blockB.b[3] = (uvec4(4u, 3u, 0u, 1u));
	blockB.b[4] = (uvec4(7u, 8u, 4u, 3u));
	blockB.b[5] = (uvec4(5u, 2u, 2u, 0u));
	blockC.c = (mat2x3(8.0, -1.0, -1.0, 1.0, 7.0, 8.0));
	blockC.d = (vec3(7.0, 0.0, -5.0));
	blockC.e[0].mA = (false);
	blockC.e[0].mB = (uvec3(5u, 7u, 0u));
	blockC.e[1].mA = (false);
	blockC.e[1].mB = (uvec3(5u, 6u, 4u));
	blockC.e[2].mA = (true);
	blockC.e[2].mB = (uvec3(4u, 2u, 0u));
	blockC.e[3].mA = (false);
	blockC.e[3].mB = (uvec3(8u, 0u, 6u));
	blockC.e[4].mA = (true);
	blockC.e[4].mB = (uvec3(4u, 8u, 9u));
	blockC.e[5].mA = (true);
	blockC.e[5].mB = (uvec3(1u, 9u, 8u));
	blockC.e[6].mA = (false);
	blockC.e[6].mB = (uvec3(6u, 8u, 6u));
	blockC.e[7].mA = (false);
	blockC.e[7].mB = (uvec3(4u, 3u, 7u));
	blockD.f[0] = (uvec2(1u, 1u));
	blockD.f[1] = (uvec2(0u, 2u));
	blockD.f[2] = (uvec2(0u, 0u));
	blockD.f[3] = (uvec2(3u, 2u));
	blockD.f[4] = (uvec2(0u, 3u));
	blockD.f[5] = (uvec2(1u, 5u));
}
#version 450
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
	highp uvec2 a;
	mediump mat3x2 b;
	lowp mat3x4 c[];
};
layout(std430, buffer_reference) readonly buffer BlockC
{
	mediump mat3x4 d;
	mediump uvec2 e;
};
layout(std430, buffer_reference) readonly buffer BlockD
{
	lowp mat3x2 f[][6];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	mediump uvec3 g;
	mediump mat3x4 h;
	lowp uint i;
	mediump vec2 j[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockE.g), uvec3(2u, 6u, 4u)) && allOk;
	allOk = compare_uint((blockE.i), 1u) && allOk;
	allOk = compare_vec2((blockE.j[0]), vec2(9.0, 4.0)) && allOk;
	allOk = compare_vec2((blockE.j[1]), vec2(-7.0, 3.0)) && allOk;
	allOk = compare_vec2((blockE.j[2]), vec2(3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3x2(-5.0, 5.0, -4.0, 2.0, -1.0, 9.0));
	blockE.g = (uvec3(9u, 6u, 7u));
	blockE.h = (mat3x4(1.0, 1.0, -7.0, -8.0, 7.0, 5.0, 0.0, 4.0, -9.0, 8.0, 2.0, -8.0));
	blockE.i = (6u);
	blockE.j[0] = (vec2(-3.0, -6.0));
	blockE.j[1] = (vec2(-6.0, 3.0));
	blockE.j[2] = (vec2(7.0, -7.0));
}
#version 450
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
	mediump mat3x4 mA[3];
	lowp mat2 mB;
};
struct sB
{
	lowp mat2x3 mA;
	lowp uvec2 mB;
};
struct sC
{
	mediump mat3 mA;
};
struct sD
{
	mediump uvec4 mA;
	bool mB;
	sC mC;
};
layout(std140, buffer_reference) buffer BlockB
{
	bool a;
	mediump mat2 b[7];
	mediump mat2x3 c;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump ivec3 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	highp ivec3 e;
	sA f;
	highp ivec2 g;
	sB h[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	sD i;
	lowp ivec4 j;
	mediump uvec3 k;
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_ivec3((blockC.d[0]), ivec3(9, -3, 1)) && allOk;
	allOk = compare_ivec3((blockC.d[1]), ivec3(4, -9, 2)) && allOk;
	allOk = compare_ivec3((blockC.d[2]), ivec3(7, -1, -3)) && allOk;
	allOk = compare_ivec3((blockC.d[3]), ivec3(5, 0, 2)) && allOk;
	allOk = compare_ivec3((blockC.d[4]), ivec3(7, 3, 3)) && allOk;
	allOk = compare_ivec3((blockC.d[5]), ivec3(8, -4, 8)) && allOk;
	allOk = compare_ivec3((blockC.d[6]), ivec3(0, 0, 4)) && allOk;
	allOk = compare_ivec3((blockC.d[7]), ivec3(1, -5, -5)) && allOk;
	allOk = compare_ivec2((blockD.g), ivec2(-1, 0)) && allOk;
	allOk = compare_mat2x3(blockD.h[0].mA, mat2x3(-2.0, -4.0, -9.0, 8.0, -1.0, -9.0)) && allOk;
	allOk = compare_uvec2((blockD.h[0].mB), uvec2(4u, 3u)) && allOk;
	allOk = compare_mat2x3(blockD.h[1].mA, mat2x3(-4.0, -2.0, 4.0, 8.0, -4.0, 5.0)) && allOk;
	allOk = compare_uvec2((blockD.h[1].mB), uvec2(7u, 4u)) && allOk;
	allOk = compare_mat2x3(blockD.h[2].mA, mat2x3(7.0, 7.0, 8.0, 3.0, 2.0, -4.0)) && allOk;
	allOk = compare_uvec2((blockD.h[2].mB), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec4((blockE.i.mA), uvec4(8u, 9u, 6u, 2u)) && allOk;
	allOk = compare_bool((blockE.i.mB), false) && allOk;
	allOk = compare_mat3(blockE.i.mC.mA, mat3(-6.0, 5.0, -1.0, 5.0, -6.0, 5.0, -4.0, 5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b[0] = (mat2(3.0, -2.0, 2.0, -7.0));
	blockB.b[1] = (mat2(4.0, 6.0, -8.0, 8.0));
	blockB.b[2] = (mat2(-3.0, 3.0, -3.0, -1.0));
	blockB.b[3] = (mat2(6.0, 9.0, 5.0, -6.0));
	blockB.b[4] = (mat2(-1.0, -2.0, 2.0, -3.0));
	blockB.b[5] = (mat2(-9.0, -5.0, 3.0, 5.0));
	blockB.b[6] = (mat2(-5.0, -2.0, -2.0, 8.0));
	blockB.c = (mat2x3(-3.0, -3.0, -8.0, 1.0, -3.0, -1.0));
	blockC.d[0] = (ivec3(3, 7, -4));
	blockC.d[1] = (ivec3(-5, -1, -3));
	blockC.d[2] = (ivec3(1, -9, 8));
	blockC.d[3] = (ivec3(9, -8, -8));
	blockC.d[4] = (ivec3(3, -3, 0));
	blockC.d[5] = (ivec3(4, 6, 1));
	blockC.d[6] = (ivec3(-4, 6, 0));
	blockC.d[7] = (ivec3(-2, -1, 5));
	blockD.e = (ivec3(2, -7, -6));
	blockD.g = (ivec2(2, -8));
	blockD.h[0].mA = (mat2x3(-4.0, -3.0, -7.0, 3.0, 1.0, 6.0));
	blockD.h[0].mB = (uvec2(2u, 9u));
	blockD.h[1].mA = (mat2x3(1.0, -9.0, -9.0, 0.0, -8.0, -1.0));
	blockD.h[1].mB = (uvec2(1u, 5u));
	blockD.h[2].mA = (mat2x3(-3.0, 8.0, -5.0, 3.0, 5.0, -7.0));
	blockD.h[2].mB = (uvec2(3u, 6u));
	blockE.i.mA = (uvec4(9u, 0u, 9u, 3u));
	blockE.i.mB = (true);
	blockE.i.mC.mA = (mat3(5.0, 9.0, 7.0, 3.0, 5.0, 0.0, -1.0, -4.0, 4.0));
	blockE.j = (ivec4(9, 5, -4, 0));
	blockE.k = (uvec3(9u, 4u, 9u));
}
#version 450
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
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	highp int a;
	sA b;
	lowp mat2 c;
	lowp vec2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.c, mat2(3.0, 0.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB.d), vec2(-2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (8);
	blockB.d = (vec2(9.0, -3.0));
}
#version 450
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
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	sA a;
	lowp mat4x3 b[7];
	bool c;
	highp vec4 d[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uvec4 e;
	mediump mat4x2 f;
	lowp mat4 g;
	bvec3 h[4][1];
	highp vec4 i[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	bool j;
	lowp float k[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a.mA), ivec2(-2, 4)) && allOk;
	allOk = compare_bool((blockB.c), true) && allOk;
	allOk = compare_mat4x2(blockC.f, mat4x2(8.0, 3.0, -3.0, 1.0, 8.0, 3.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4(blockC.g, mat4(7.0, 0.0, 1.0, -4.0, 5.0, -6.0, 6.0, 6.0, 4.0, -6.0, -3.0, -1.0, 4.0, -4.0, 2.0, 0.0)) && allOk;
	allOk = compare_bvec3((blockC.h[0][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockC.h[1][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockC.h[2][0]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockC.h[3][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bool((blockD.j), false) && allOk;
	allOk = compare_float((blockD.k[0]), -2.0) && allOk;
	allOk = compare_float((blockD.k[1]), 4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (ivec2(7, -6));
	blockB.d[0] = (vec4(0.0, 7.0, -5.0, 3.0));
	blockB.d[1] = (vec4(-1.0, 2.0, 2.0, 9.0));
	blockB.d[2] = (vec4(7.0, -9.0, 9.0, -8.0));
	blockB.d[3] = (vec4(8.0, -7.0, -8.0, -5.0));
	blockB.d[4] = (vec4(-2.0, 6.0, -8.0, 8.0));
	blockB.d[5] = (vec4(-1.0, 2.0, 8.0, -3.0));
	blockB.d[6] = (vec4(4.0, 8.0, -5.0, 2.0));
	blockC.e = (uvec4(7u, 4u, 9u, 6u));
	blockC.g = (mat4(-4.0, 0.0, 8.0, -1.0, -1.0, 3.0, -7.0, -2.0, 6.0, 3.0, -9.0, -5.0, -4.0, 8.0, -5.0, 0.0));
	blockC.h[0][0] = (bvec3(true, true, true));
	blockC.h[1][0] = (bvec3(true, true, false));
	blockC.h[2][0] = (bvec3(true, false, false));
	blockC.h[3][0] = (bvec3(true, true, true));
	blockD.j = (true);
}
#version 450
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
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

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

layout(std140, column_major, buffer_reference) buffer BlockB
{
	highp uvec2 a;
	lowp mat2x3 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(8u, 2u)) && allOk;
	allOk = compare_mat2x3(blockB.b[0], mat2x3(9.0, -7.0, -4.0, -4.0, -6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(9u, 2u));
}
#version 450
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
	highp uvec4 a;
	lowp mat2 b;
	lowp ivec4 c[];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockC
{
	mediump ivec2 d[];
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump int e;
	f16vec4 f[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	mediump vec3 g;
	bool h[];
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(5u, 7u, 3u, 1u)) && allOk;
	allOk = compare_mat2(blockB.b, mat2(9.0, 7.0, -5.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockC.d[0]), ivec2(-2, -1)) && allOk;
	allOk = compare_f16vec4(vec4(blockD.f[0]), vec4(2.0, -4.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec3((blockE.g), vec3(-1.0, 3.0, -2.0)) && allOk;
	allOk = compare_bool((blockE.h[0]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockD.e = (4);
	blockE.g = (vec3(4.0, 7.0, 3.0));
}
#version 450
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
	highp uvec3 mA;
	lowp uvec4 mB[2];
	u16vec2 mC;
	highp ivec2 mD;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	sA a;
	highp mat4x3 b;
	mediump mat2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB[0].b, mat4x3(7.0, 2.0, -7.0, -9.0, 3.0, -4.0, -7.0, -6.0, 2.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].b, mat4x3(-6.0, 4.0, 4.0, 7.0, 0.0, -3.0, 2.0, 4.0, -9.0, 8.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB[2].b, mat4x3(-8.0, 2.0, 0.0, 7.0, -9.0, 5.0, 1.0, 4.0, -6.0, 3.0, 1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (uvec3(4u, 4u, 5u));
	blockB[0].a.mB[0] = (uvec4(2u, 7u, 4u, 8u));
	blockB[0].a.mB[1] = (uvec4(5u, 2u, 1u, 3u));
	blockB[0].a.mC = u16vec2(uvec2(8u, 5u));
	blockB[0].a.mD = (ivec2(4, 3));
	blockB[0].b = (mat4x3(-8.0, -9.0, 4.0, -8.0, -8.0, 3.0, -7.0, 7.0, -9.0, 7.0, 4.0, -9.0));
	blockB[0].c[0] = (mat2(-3.0, 7.0, 8.0, 9.0));
	blockB[0].c[1] = (mat2(-7.0, 4.0, -7.0, -1.0));
	blockB[0].c[2] = (mat2(6.0, -8.0, 3.0, 6.0));
	blockB[1].a.mA = (uvec3(6u, 1u, 5u));
	blockB[1].a.mB[0] = (uvec4(0u, 5u, 9u, 4u));
	blockB[1].a.mB[1] = (uvec4(6u, 4u, 4u, 1u));
	blockB[1].a.mC = u16vec2(uvec2(3u, 0u));
	blockB[1].a.mD = (ivec2(-7, -2));
	blockB[1].b = (mat4x3(8.0, 9.0, 1.0, 5.0, 3.0, -9.0, 8.0, 4.0, 5.0, 9.0, 4.0, -4.0));
	blockB[1].c[0] = (mat2(-4.0, 8.0, 5.0, 2.0));
	blockB[2].a.mA = (uvec3(9u, 1u, 2u));
	blockB[2].a.mB[0] = (uvec4(1u, 0u, 8u, 5u));
	blockB[2].a.mB[1] = (uvec4(9u, 7u, 9u, 3u));
	blockB[2].a.mC = u16vec2(uvec2(9u, 4u));
	blockB[2].a.mD = (ivec2(3, 1));
	blockB[2].b = (mat4x3(9.0, 1.0, 1.0, -6.0, 6.0, 3.0, 1.0, -1.0, 0.0, 3.0, 4.0, -9.0));
	blockB[2].c[0] = (mat2(-1.0, 4.0, 9.0, 0.0));
	blockB[2].c[1] = (mat2(7.0, -6.0, 9.0, -6.0));
	blockB[2].c[2] = (mat2(-8.0, 8.0, -5.0, 8.0));
	blockB[2].c[3] = (mat2(0.0, 3.0, -8.0, -2.0));
	blockB[2].c[4] = (mat2(2.0, 5.0, 4.0, 4.0));
	blockB[2].c[5] = (mat2(-1.0, 8.0, 8.0, -3.0));
	blockB[2].c[6] = (mat2(-6.0, 1.0, 1.0, -5.0));
}
#version 450
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
};
struct sB
{
	f16vec2 mA;
	f16vec3 mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	f16vec4 a;
	bvec3 b;
	highp vec2 c[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	u16vec3 d[2][2];
	i16vec2 e;
	bvec2 f[5];
	highp mat4x2 g;
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	sA h;
	mediump uvec2 i;
	lowp vec2 j[];
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockE
{
	sB k[][4];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a), vec4(0.0, -6.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec2((blockB.c[0]), vec2(2.0, 8.0)) && allOk;
	allOk = compare_vec2((blockB.c[1]), vec2(-2.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB.c[2]), vec2(4.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB.c[3]), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB.c[4]), vec2(1.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB.c[5]), vec2(-6.0, 3.0)) && allOk;
	allOk = compare_uvec2((blockD.i), uvec2(8u, 3u)) && allOk;
	allOk = compare_vec2((blockD.j[0]), vec2(4.0, -3.0)) && allOk;
	allOk = compare_vec2((blockD.j[1]), vec2(0.0, -9.0)) && allOk;
	allOk = compare_vec2((blockD.j[2]), vec2(7.0, -9.0)) && allOk;
	allOk = compare_vec2((blockD.j[3]), vec2(8.0, -2.0)) && allOk;
	allOk = compare_vec2((blockD.j[4]), vec2(-2.0, 0.0)) && allOk;
	allOk = compare_vec2((blockD.j[5]), vec2(-1.0, 4.0)) && allOk;
	allOk = compare_vec2((blockD.j[6]), vec2(-9.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[0][0].mA), vec2(-6.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[0][0].mB), vec3(2.0, 1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[0][1].mA), vec2(3.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[0][1].mB), vec3(-8.0, -9.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[0][2].mA), vec2(5.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[0][2].mB), vec3(9.0, -3.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[0][3].mA), vec2(-1.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[0][3].mB), vec3(-9.0, 2.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[1][0].mA), vec2(9.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[1][0].mB), vec3(9.0, -6.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[1][1].mA), vec2(6.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[1][1].mB), vec3(8.0, -4.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[1][2].mA), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[1][2].mB), vec3(6.0, 7.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[1][3].mA), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[1][3].mB), vec3(9.0, -1.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[2][0].mA), vec2(7.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[2][0].mB), vec3(-4.0, 4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[2][1].mA), vec2(6.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[2][1].mB), vec3(-5.0, 4.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[2][2].mA), vec2(-5.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[2][2].mB), vec3(5.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[2][3].mA), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[2][3].mB), vec3(-3.0, 5.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[3][0].mA), vec2(1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[3][0].mB), vec3(9.0, 4.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[3][1].mA), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[3][1].mB), vec3(-2.0, -3.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[3][2].mA), vec2(8.0, 3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[3][2].mB), vec3(5.0, 0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[3][3].mA), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[3][3].mB), vec3(7.0, 9.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[4][0].mA), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[4][0].mB), vec3(7.0, 1.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[4][1].mA), vec2(8.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[4][1].mB), vec3(8.0, 6.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[4][2].mA), vec2(4.0, 3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[4][2].mB), vec3(-5.0, 8.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[4][3].mA), vec2(-4.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[4][3].mB), vec3(-2.0, 2.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[5][0].mA), vec2(-6.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[5][0].mB), vec3(-6.0, -1.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[5][1].mA), vec2(5.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[5][1].mB), vec3(-3.0, 3.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[5][2].mA), vec2(5.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[5][2].mB), vec3(2.0, -4.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[5][3].mA), vec2(7.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[5][3].mB), vec3(-4.0, 7.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[6][0].mA), vec2(1.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[6][0].mB), vec3(-9.0, -3.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[6][1].mA), vec2(6.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[6][1].mB), vec3(6.0, -3.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[6][2].mA), vec2(1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[6][2].mB), vec3(8.0, 0.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[0].k[6][3].mA), vec2(-5.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[0].k[6][3].mB), vec3(-3.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[1].k[0][0].mA), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[1].k[0][0].mB), vec3(-2.0, -2.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[1].k[0][1].mA), vec2(-9.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[1].k[0][1].mB), vec3(1.0, -4.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[1].k[0][2].mA), vec2(2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[1].k[0][2].mB), vec3(-4.0, 8.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[1].k[0][3].mA), vec2(-5.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[1].k[0][3].mB), vec3(-9.0, 0.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[1].k[1][0].mA), vec2(-1.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[1].k[1][0].mB), vec3(-2.0, -5.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[1].k[1][1].mA), vec2(-2.0, 3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[1].k[1][1].mB), vec3(0.0, -3.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[1].k[1][2].mA), vec2(-7.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[1].k[1][2].mB), vec3(-7.0, -4.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[1].k[1][3].mA), vec2(-8.0, 0.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[1].k[1][3].mB), vec3(5.0, 3.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[0][0].mA), vec2(-8.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[0][0].mB), vec3(5.0, 6.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[0][1].mA), vec2(-9.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[0][1].mB), vec3(-8.0, 7.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[0][2].mA), vec2(-1.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[0][2].mB), vec3(-4.0, 8.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[0][3].mA), vec2(9.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[0][3].mB), vec3(0.0, 5.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[1][0].mA), vec2(4.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[1][0].mB), vec3(-8.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[1][1].mA), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[1][1].mB), vec3(-5.0, 5.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[1][2].mA), vec2(2.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[1][2].mB), vec3(9.0, 8.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[1][3].mA), vec2(1.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[1][3].mB), vec3(3.0, -1.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[2][0].mA), vec2(0.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[2][0].mB), vec3(-6.0, -6.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[2][1].mA), vec2(9.0, 3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[2][1].mB), vec3(-2.0, -8.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[2][2].mA), vec2(-6.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[2][2].mB), vec3(-3.0, 8.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[2][3].mA), vec2(-4.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[2][3].mB), vec3(9.0, -9.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[3][0].mA), vec2(4.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[3][0].mB), vec3(-4.0, 0.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[3][1].mA), vec2(-1.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[3][1].mB), vec3(2.0, 8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[3][2].mA), vec2(2.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[3][2].mB), vec3(7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[3][3].mA), vec2(3.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[3][3].mB), vec3(-3.0, 9.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[4][0].mA), vec2(1.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[4][0].mB), vec3(0.0, -2.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[4][1].mA), vec2(7.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[4][1].mB), vec3(0.0, -2.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[4][2].mA), vec2(-8.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[4][2].mB), vec3(5.0, -8.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[4][3].mA), vec2(-9.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[4][3].mB), vec3(2.0, -7.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[5][0].mA), vec2(-2.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE[2].k[5][0].mB), vec3(-5.0, -8.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE[2].k[5][1].mA), vec2(-8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec4(vec4(6.0, 3.0, -9.0, 0.0));
	blockB.b = (bvec3(false, true, false));
	blockB.c[0] = (vec2(-6.0, 3.0));
	blockB.c[1] = (vec2(5.0, -8.0));
	blockB.c[2] = (vec2(-7.0, -8.0));
	blockB.c[3] = (vec2(3.0, -6.0));
	blockB.c[4] = (vec2(-9.0, 9.0));
	blockB.c[5] = (vec2(-9.0, 9.0));
	blockC.e = i16vec2(ivec2(-2, 5));
	blockD.j[0] = (vec2(8.0, -8.0));
	blockD.j[1] = (vec2(3.0, -1.0));
	blockD.j[2] = (vec2(4.0, 4.0));
	blockD.j[3] = (vec2(-4.0, 9.0));
	blockD.j[4] = (vec2(8.0, -7.0));
	blockD.j[5] = (vec2(-1.0, -7.0));
	blockD.j[6] = (vec2(2.0, -7.0));
}
#version 450
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
	lowp mat3 a;
	highp int b;
	mediump mat4 c;
	highp mat3x2 d;
};
layout(std140, buffer_reference) buffer BlockC
{
	highp mat3x2 e;
	i8vec4 f;
	u8vec3 g;
	bvec4 h;
	bvec4 i;
};
layout(std140, buffer_reference) buffer BlockD
{
	int8_t j[1];
};
layout(std140, buffer_reference) buffer BlockE
{
	u8vec3 k;
	u8vec3 l;
	lowp vec4 m[1];
	lowp mat3x4 n;
	highp vec2 o;
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(-8.0, 9.0, 9.0, -7.0, -4.0, -4.0, -6.0, -2.0, 8.0)) && allOk;
	allOk = compare_int((blockB.b), 4) && allOk;
	allOk = compare_mat3x2(blockB.d, mat3x2(9.0, -1.0, -1.0, 6.0, 1.0, 1.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f), ivec4(0, 4294967295, 1, 4294967288)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.g), uvec3(3u, 5u, 0u)) && allOk;
	allOk = compare_bvec4((blockC.h), bvec4(false, false, true, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE.l), uvec3(3u, 0u, 5u)) && allOk;
	allOk = compare_vec4((blockE.m[0]), vec4(0.0, 0.0, -7.0, -9.0)) && allOk;
	allOk = compare_vec2((blockE.o), vec2(-5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(4.0, 0.0, 9.0, 4.0, 1.0, -7.0, -4.0, -4.0, -6.0));
	blockB.b = (-5);
	blockB.c = (mat4(-2.0, 4.0, -2.0, 5.0, -9.0, -3.0, -1.0, -9.0, 1.0, 1.0, 7.0, 8.0, 9.0, -7.0, -1.0, -6.0));
	blockB.d = (mat3x2(5.0, 6.0, 5.0, 6.0, -6.0, -9.0));
	blockC.e = (mat3x2(3.0, -7.0, -4.0, -6.0, -5.0, 3.0));
	blockC.f = i8vec4(ivec4(4294967287, 4294967290, 4294967293, 4294967289));
	blockC.g = u8vec3(uvec3(5u, 1u, 5u));
	blockC.h = (bvec4(false, false, false, false));
	blockC.i = (bvec4(false, false, false, false));
	blockD.j[0] = int8_t(4294967293);
	blockE.k = u8vec3(uvec3(7u, 1u, 5u));
	blockE.l = u8vec3(uvec3(3u, 4u, 7u));
	blockE.n = (mat3x4(-9.0, 0.0, -2.0, -6.0, -3.0, -7.0, 9.0, 5.0, -5.0, -2.0, 1.0, 8.0));
	blockE.o = (vec2(-2.0, -4.0));
}
#version 450
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
	highp mat3 a;
};
layout(std140, row_major, buffer_reference) readonly buffer BlockC
{
	lowp vec3 b;
	highp int c[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	bvec3 d;
	lowp vec4 e[2];
	mediump mat2x3 f;
	lowp mat3 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(0.0, -6.0, 9.0, -5.0, 0.0, 3.0, 7.0, -1.0, -8.0)) && allOk;
	allOk = compare_bvec3((blockD.d), bvec3(true, false, false)) && allOk;
	allOk = compare_vec4((blockD.e[0]), vec4(-7.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec4((blockD.e[1]), vec4(-7.0, 2.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(6.0, 3.0, -9.0, 0.0, 9.0, 2.0, -6.0, 6.0, -6.0));
	blockD.d = (bvec3(true, false, false));
	blockD.e[0] = (vec4(-1.0, -4.0, 0.0, -4.0));
	blockD.e[1] = (vec4(2.0, 1.0, 2.0, 9.0));
	blockD.f = (mat2x3(-3.0, -6.0, 5.0, -2.0, -2.0, -3.0));
}
#version 450
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
	mediump uvec4 b;
	i8vec4 c;
	mediump mat4x3 d;
	uint8_t e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump uvec4 f;
	lowp float g;
	mediump mat3 h;
	highp float i;
	mediump vec2 j[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	bool k[1];
	u8vec3 l;
	lowp mat3x4 m;
	highp uvec3 n;
	lowp vec2 o[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(4.0, 1.0, -1.0, 9.0, 1.0, -6.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockB.d, mat4x3(7.0, -2.0, -4.0, -7.0, -7.0, -1.0, -1.0, 4.0, 8.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB.e[0]), 1u) && allOk;
	allOk = compare_float((blockC.g), -9.0) && allOk;
	allOk = compare_mat3(blockC.h, mat3(7.0, 3.0, -6.0, -5.0, -3.0, -4.0, -5.0, 8.0, -3.0)) && allOk;
	allOk = compare_vec2((blockC.j[0]), vec2(-1.0, -3.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.l), uvec3(9u, 7u, 3u)) && allOk;
	allOk = compare_mat3x4(blockD.m, mat3x4(-2.0, 3.0, 3.0, 1.0, 5.0, 8.0, 7.0, -7.0, 6.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockD.n), uvec3(9u, 9u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(5.0, 1.0, 7.0, -2.0, -9.0, -1.0, -6.0, -3.0));
	blockB.b = (uvec4(9u, 4u, 8u, 6u));
	blockB.c = i8vec4(ivec4(4294967292, 3, 4, 9));
	blockB.d = (mat4x3(1.0, 9.0, 3.0, 2.0, 2.0, -7.0, -6.0, -1.0, -5.0, 5.0, -7.0, 7.0));
	blockB.e[0] = uint8_t(1u);
	blockC.f = (uvec4(7u, 0u, 5u, 5u));
	blockC.i = (-4.0);
	blockC.j[0] = (vec2(-9.0, -2.0));
	blockD.l = u8vec3(uvec3(3u, 0u, 1u));
	blockD.n = (uvec3(7u, 3u, 5u));
	blockD.o[0] = (vec2(-9.0, 9.0));
}
#version 450
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
	u8vec2 a;
	mediump float b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump mat3x2 c;
	highp mat4 d;
	bvec2 e[];
};
layout(std430, buffer_reference) buffer BlockD
{
	i8vec4 f;
	u8vec4 g;
};
layout(std430, buffer_reference) readonly buffer BlockE
{
	lowp mat4x3 h;
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
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockC[0].c, mat3x2(7.0, -5.0, 2.0, -1.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4(blockC[0].d, mat4(-6.0, 5.0, -7.0, 2.0, 8.0, 8.0, 6.0, -8.0, 7.0, -1.0, 2.0, 2.0, 6.0, 1.0, 1.0, 1.0)) && allOk;
	allOk = compare_bvec2((blockC[0].e[0]), bvec2(false, true)) && allOk;
	allOk = compare_mat3x2(blockC[1].c, mat3x2(0.0, -1.0, -1.0, 5.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4(blockC[1].d, mat4(-1.0, -2.0, -9.0, 1.0, 0.0, 8.0, 0.0, 5.0, -7.0, 6.0, 6.0, 7.0, -7.0, 6.0, -8.0, 5.0)) && allOk;
	allOk = compare_bvec2((blockC[1].e[0]), bvec2(false, true)) && allOk;
	allOk = compare_mat3x2(blockC[2].c, mat3x2(4.0, -4.0, 0.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat4(blockC[2].d, mat4(-1.0, -9.0, -9.0, -1.0, -4.0, 5.0, 1.0, -9.0, 8.0, 9.0, -6.0, -3.0, -4.0, 9.0, 9.0, 1.0)) && allOk;
	allOk = compare_bvec2((blockC[2].e[0]), bvec2(true, false)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.f), ivec4(4294967289, 4294967293, 4294967287, 5)) && allOk;
	allOk = compare_mat4x3(blockE.h, mat4x3(2.0, -8.0, 1.0, 7.0, 3.0, 2.0, 2.0, 3.0, -8.0, -6.0, 3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(9u, 2u));
	blockC[0].c = (mat3x2(-7.0, 6.0, 2.0, -8.0, 7.0, 6.0));
	blockC[0].d = (mat4(-4.0, 5.0, 7.0, 9.0, -2.0, 6.0, 4.0, 0.0, 7.0, 5.0, -3.0, 1.0, 0.0, -8.0, -8.0, 5.0));
	blockC[0].e[0] = (bvec2(true, true));
	blockC[1].c = (mat3x2(7.0, 6.0, 3.0, 9.0, -8.0, 1.0));
	blockC[1].d = (mat4(4.0, -5.0, 0.0, -7.0, -1.0, 7.0, 9.0, 5.0, -4.0, -6.0, 0.0, -8.0, -2.0, 5.0, -8.0, 0.0));
	blockC[1].e[0] = (bvec2(false, false));
	blockC[2].c = (mat3x2(3.0, -2.0, 9.0, -1.0, 8.0, 4.0));
	blockC[2].d = (mat4(9.0, -5.0, 8.0, 0.0, 3.0, 8.0, 9.0, 3.0, -9.0, 6.0, 7.0, 3.0, 2.0, -5.0, 6.0, 3.0));
	blockC[2].e[0] = (bvec2(false, false));
	blockD.f = i8vec4(ivec4(8, 1, 4294967293, 4294967294));
}
#version 450
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
	lowp vec2 mB;
	highp mat3x2 mC;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	highp uvec2 a;
	mediump uvec4 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp vec4 c;
	sA d[];
};
layout(std140, buffer_reference) buffer BlockD
{
	highp mat3x4 e[6];
	i8vec4 f;
	bvec3 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[0].a), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((blockB[1].a), uvec2(2u, 0u)) && allOk;
	allOk = compare_uvec2((blockB[2].a), uvec2(7u, 5u)) && allOk;
	allOk = compare_vec4((blockC[0].c), vec4(-3.0, 3.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC[1].c), vec4(-9.0, -1.0, 7.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC[2].c), vec4(4.0, -4.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (uvec4(7u, 8u, 8u, 2u));
	blockB[0].b[1] = (uvec4(9u, 3u, 3u, 1u));
	blockB[0].b[2] = (uvec4(6u, 3u, 9u, 6u));
	blockB[0].b[3] = (uvec4(2u, 8u, 1u, 7u));
	blockB[0].b[4] = (uvec4(9u, 4u, 1u, 4u));
	blockB[0].b[5] = (uvec4(3u, 8u, 9u, 1u));
	blockB[0].b[6] = (uvec4(6u, 3u, 6u, 5u));
	blockB[0].b[7] = (uvec4(5u, 6u, 5u, 2u));
	blockB[1].b[0] = (uvec4(1u, 7u, 5u, 4u));
	blockB[1].b[1] = (uvec4(5u, 0u, 0u, 5u));
	blockB[1].b[2] = (uvec4(8u, 2u, 0u, 9u));
	blockB[1].b[3] = (uvec4(1u, 8u, 5u, 8u));
	blockB[1].b[4] = (uvec4(1u, 6u, 5u, 5u));
	blockB[1].b[5] = (uvec4(7u, 2u, 2u, 9u));
	blockB[2].b[0] = (uvec4(5u, 2u, 8u, 1u));
	blockC[0].c = (vec4(6.0, 1.0, 5.0, -8.0));
	blockC[0].d[0].mA = u8vec4(uvec4(9u, 8u, 4u, 3u));
	blockC[0].d[0].mB = (vec2(5.0, 5.0));
	blockC[0].d[0].mC = (mat3x2(-7.0, -5.0, 6.0, -3.0, -6.0, 8.0));
	blockC[0].d[1].mA = u8vec4(uvec4(6u, 3u, 6u, 1u));
	blockC[0].d[1].mB = (vec2(-6.0, -2.0));
	blockC[0].d[1].mC = (mat3x2(4.0, 5.0, -5.0, 2.0, 9.0, 7.0));
	blockC[0].d[2].mA = u8vec4(uvec4(0u, 0u, 7u, 0u));
	blockC[0].d[2].mB = (vec2(6.0, 0.0));
	blockC[0].d[2].mC = (mat3x2(3.0, -9.0, 3.0, 4.0, 5.0, 8.0));
	blockC[0].d[3].mA = u8vec4(uvec4(8u, 4u, 3u, 8u));
	blockC[0].d[3].mB = (vec2(-9.0, 8.0));
	blockC[0].d[3].mC = (mat3x2(6.0, -3.0, 9.0, 4.0, -1.0, -2.0));
	blockC[0].d[4].mA = u8vec4(uvec4(5u, 4u, 9u, 4u));
	blockC[0].d[4].mB = (vec2(-7.0, 8.0));
	blockC[0].d[4].mC = (mat3x2(-2.0, -3.0, -6.0, -5.0, -8.0, 0.0));
	blockC[0].d[5].mA = u8vec4(uvec4(5u, 6u, 6u, 5u));
	blockC[0].d[5].mB = (vec2(6.0, -8.0));
	blockC[0].d[5].mC = (mat3x2(4.0, 1.0, 3.0, -9.0, 9.0, 1.0));
	blockC[1].c = (vec4(6.0, 8.0, 3.0, -1.0));
	blockC[1].d[0].mA = u8vec4(uvec4(8u, 8u, 2u, 4u));
	blockC[1].d[0].mB = (vec2(4.0, -5.0));
	blockC[1].d[0].mC = (mat3x2(6.0, 3.0, 3.0, -3.0, -2.0, -4.0));
	blockC[1].d[1].mA = u8vec4(uvec4(1u, 2u, 9u, 8u));
	blockC[1].d[1].mB = (vec2(7.0, 7.0));
	blockC[1].d[1].mC = (mat3x2(-9.0, -1.0, -9.0, -2.0, 5.0, 9.0));
	blockC[1].d[2].mA = u8vec4(uvec4(3u, 2u, 3u, 8u));
	blockC[1].d[2].mB = (vec2(-5.0, -8.0));
	blockC[1].d[2].mC = (mat3x2(8.0, -2.0, -8.0, 8.0, 6.0, 6.0));
	blockC[1].d[3].mA = u8vec4(uvec4(0u, 5u, 1u, 5u));
	blockC[1].d[3].mB = (vec2(2.0, 4.0));
	blockC[1].d[3].mC = (mat3x2(2.0, 6.0, -9.0, -5.0, -1.0, -7.0));
	blockC[1].d[4].mA = u8vec4(uvec4(2u, 6u, 6u, 7u));
	blockC[1].d[4].mB = (vec2(-6.0, 5.0));
	blockC[1].d[4].mC = (mat3x2(7.0, 4.0, -9.0, 5.0, 9.0, -5.0));
	blockC[1].d[5].mA = u8vec4(uvec4(7u, 7u, 4u, 0u));
	blockC[1].d[5].mB = (vec2(-3.0, -9.0));
	blockC[1].d[5].mC = (mat3x2(6.0, 4.0, -7.0, 5.0, -6.0, 2.0));
	blockC[1].d[6].mA = u8vec4(uvec4(8u, 1u, 2u, 9u));
	blockC[1].d[6].mB = (vec2(-3.0, -8.0));
	blockC[1].d[6].mC = (mat3x2(-2.0, -5.0, 0.0, -3.0, 1.0, 7.0));
	blockC[1].d[7].mA = u8vec4(uvec4(8u, 5u, 3u, 6u));
	blockC[1].d[7].mB = (vec2(9.0, -3.0));
	blockC[1].d[7].mC = (mat3x2(4.0, -9.0, 3.0, 2.0, 5.0, -3.0));
	blockC[2].c = (vec4(9.0, -9.0, -4.0, -6.0));
	blockC[2].d[0].mA = u8vec4(uvec4(5u, 6u, 6u, 5u));
	blockC[2].d[0].mB = (vec2(4.0, -7.0));
	blockC[2].d[0].mC = (mat3x2(-8.0, 4.0, -7.0, 5.0, 9.0, -3.0));
	blockC[2].d[1].mA = u8vec4(uvec4(8u, 1u, 5u, 9u));
	blockC[2].d[1].mB = (vec2(-4.0, -4.0));
	blockC[2].d[1].mC = (mat3x2(3.0, 9.0, 0.0, 4.0, 0.0, -2.0));
	blockC[2].d[2].mA = u8vec4(uvec4(9u, 9u, 8u, 6u));
	blockC[2].d[2].mB = (vec2(4.0, 3.0));
	blockC[2].d[2].mC = (mat3x2(-4.0, -7.0, -1.0, 3.0, -7.0, 8.0));
	blockC[2].d[3].mA = u8vec4(uvec4(0u, 3u, 9u, 3u));
	blockC[2].d[3].mB = (vec2(-1.0, 2.0));
	blockC[2].d[3].mC = (mat3x2(-8.0, 3.0, 0.0, 1.0, -7.0, 7.0));
	blockC[2].d[4].mA = u8vec4(uvec4(8u, 6u, 5u, 0u));
	blockC[2].d[4].mB = (vec2(8.0, 1.0));
	blockC[2].d[4].mC = (mat3x2(0.0, 6.0, -4.0, 9.0, 2.0, -6.0));
	blockC[2].d[5].mA = u8vec4(uvec4(1u, 5u, 5u, 8u));
	blockC[2].d[5].mB = (vec2(-1.0, -8.0));
	blockC[2].d[5].mC = (mat3x2(-4.0, -3.0, -8.0, -3.0, -3.0, -7.0));
	blockD.e[0] = (mat3x4(-4.0, 5.0, 9.0, -7.0, -8.0, 7.0, 3.0, 0.0, 9.0, 1.0, 6.0, 0.0));
	blockD.e[1] = (mat3x4(-3.0, 6.0, -9.0, 7.0, 4.0, -7.0, 7.0, 6.0, -8.0, -3.0, 1.0, -8.0));
	blockD.e[2] = (mat3x4(0.0, 9.0, 0.0, -9.0, -1.0, -2.0, 7.0, 9.0, 1.0, -5.0, 4.0, -8.0));
	blockD.e[3] = (mat3x4(4.0, 7.0, 4.0, 1.0, 8.0, 4.0, -4.0, 0.0, -4.0, 8.0, -6.0, 4.0));
	blockD.e[4] = (mat3x4(-6.0, -3.0, 0.0, 6.0, 9.0, -9.0, -9.0, 9.0, 1.0, 4.0, -7.0, -2.0));
	blockD.e[5] = (mat3x4(-9.0, 3.0, 8.0, 7.0, -1.0, 6.0, -4.0, 7.0, 6.0, 7.0, 2.0, 0.0));
	blockD.f = i8vec4(ivec4(3, 1, 4294967291, 1));
	blockD.g[0] = (bvec3(true, false, true));
	blockD.g[1] = (bvec3(true, true, true));
	blockD.g[2] = (bvec3(true, false, false));
}
#version 450
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
};
layout(std140, row_major, buffer_reference) readonly buffer BlockB
{
	bvec4 a;
	mediump vec4 b[7];
	sA c;
	lowp float d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp vec4 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_vec4((blockB.b[0]), vec4(5.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_vec4((blockB.b[1]), vec4(6.0, -2.0, -6.0, 4.0)) && allOk;
	allOk = compare_vec4((blockB.b[2]), vec4(-6.0, -3.0, 2.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB.b[3]), vec4(-7.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_vec4((blockB.b[4]), vec4(5.0, 2.0, -9.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB.b[5]), vec4(-5.0, 0.0, 1.0, -8.0)) && allOk;
	allOk = compare_vec4((blockB.b[6]), vec4(0.0, 3.0, -5.0, 5.0)) && allOk;
	allOk = compare_float((blockB.d[0]), 2.0) && allOk;
	allOk = compare_float((blockB.d[1]), 0.0) && allOk;
	allOk = compare_float((blockB.d[2]), 1.0) && allOk;
	allOk = compare_float((blockB.d[3]), 8.0) && allOk;
	allOk = compare_float((blockB.d[4]), -3.0) && allOk;
	allOk = compare_float((blockB.d[5]), 7.0) && allOk;
	allOk = compare_float((blockB.d[6]), -6.0) && allOk;
	allOk = compare_float((blockB.d[7]), -9.0) && allOk;
	allOk = compare_vec4((blockC.e[0]), vec4(-5.0, 6.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC.e[1]), vec4(3.0, 3.0, 8.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC.e[2]), vec4(-1.0, 3.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.e[0] = (vec4(-2.0, 5.0, -3.0, 4.0));
	blockC.e[1] = (vec4(7.0, -1.0, -2.0, 2.0));
	blockC.e[2] = (vec4(-2.0, 1.0, 0.0, 2.0));
}
#version 450
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
	lowp uvec3 mB;
};
layout(std140, buffer_reference) buffer BlockB
{
	uint8_t a;
	lowp mat4x3 b;
	sA c[3];
};
layout(std430, buffer_reference) buffer BlockC
{
	i8vec4 d[4][7];
	highp ivec4 e[5];
	highp mat3x4 f[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	i8vec4 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB[0].b, mat4x3(0.0, -7.0, -9.0, 0.0, -2.0, -6.0, 9.0, 7.0, -1.0, 0.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].b, mat4x3(-6.0, -1.0, -1.0, 5.0, -1.0, 1.0, 0.0, -5.0, -5.0, 1.0, 2.0, 4.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[0][0]), ivec4(0, 4, 8, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[0][1]), ivec4(9, 9, 9, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[0][2]), ivec4(4294967295, 4294967291, 8, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[0][3]), ivec4(4294967295, 4294967290, 4294967290, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[0][4]), ivec4(6, 4294967288, 4294967290, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[0][5]), ivec4(4294967287, 5, 4294967294, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[0][6]), ivec4(1, 8, 0, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[1][0]), ivec4(4294967293, 4294967291, 4, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[1][1]), ivec4(3, 4, 4294967292, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[1][2]), ivec4(6, 4294967287, 5, 4294967288)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[1][3]), ivec4(6, 4294967292, 4294967295, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[1][4]), ivec4(3, 9, 4294967291, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[1][5]), ivec4(4294967289, 4294967294, 9, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[1][6]), ivec4(4294967292, 4294967294, 0, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[2][0]), ivec4(1, 4294967295, 4294967294, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[2][1]), ivec4(4294967288, 4294967292, 4294967287, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[2][2]), ivec4(4294967289, 5, 4294967287, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[2][3]), ivec4(4294967287, 4294967290, 4294967288, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[2][4]), ivec4(4294967289, 4294967291, 4294967293, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[2][5]), ivec4(4294967293, 7, 0, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[2][6]), ivec4(6, 4294967290, 5, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[3][0]), ivec4(4294967287, 4294967292, 4, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[3][1]), ivec4(4, 1, 1, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[3][2]), ivec4(7, 5, 0, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[3][3]), ivec4(0, 0, 4294967295, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[3][4]), ivec4(4294967292, 4294967290, 4, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[3][5]), ivec4(4294967287, 0, 4294967291, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d[3][6]), ivec4(9, 2, 4, 4294967289)) && allOk;
	allOk = compare_ivec4((blockC.e[0]), ivec4(0, -3, 2, 6)) && allOk;
	allOk = compare_ivec4((blockC.e[1]), ivec4(-7, 4, -9, 2)) && allOk;
	allOk = compare_ivec4((blockC.e[2]), ivec4(-8, -9, 7, -3)) && allOk;
	allOk = compare_ivec4((blockC.e[3]), ivec4(8, -4, 9, 5)) && allOk;
	allOk = compare_ivec4((blockC.e[4]), ivec4(7, -5, -1, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.g[0]), ivec4(5, 4294967288, 6, 4294967291)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].c[0].mA = (bvec4(false, true, false, false));
	blockB[0].c[0].mB = (uvec3(4u, 8u, 4u));
	blockB[0].c[1].mA = (bvec4(false, false, true, true));
	blockB[0].c[1].mB = (uvec3(6u, 5u, 2u));
	blockB[0].c[2].mA = (bvec4(true, true, true, true));
	blockB[0].c[2].mB = (uvec3(9u, 9u, 6u));
	blockB[1].c[0].mA = (bvec4(true, false, false, true));
	blockB[1].c[0].mB = (uvec3(5u, 1u, 6u));
	blockB[1].c[1].mA = (bvec4(false, false, true, true));
	blockB[1].c[1].mB = (uvec3(8u, 5u, 6u));
	blockB[1].c[2].mA = (bvec4(false, false, false, true));
	blockB[1].c[2].mB = (uvec3(2u, 2u, 3u));
	blockC.d[0][0] = i8vec4(ivec4(2, 4294967289, 4294967293, 8));
	blockC.d[0][1] = i8vec4(ivec4(4294967290, 3, 4294967295, 4294967287));
	blockC.d[0][2] = i8vec4(ivec4(3, 8, 3, 2));
	blockC.d[0][3] = i8vec4(ivec4(4294967290, 4, 7, 8));
	blockC.d[0][4] = i8vec4(ivec4(4294967293, 4294967292, 4294967294, 5));
	blockC.d[0][5] = i8vec4(ivec4(4294967288, 4294967294, 4294967295, 4294967289));
	blockC.d[0][6] = i8vec4(ivec4(4294967293, 4294967291, 4294967292, 2));
	blockC.d[1][0] = i8vec4(ivec4(7, 4294967292, 7, 4294967295));
	blockC.d[1][1] = i8vec4(ivec4(5, 9, 2, 4294967289));
	blockC.d[1][2] = i8vec4(ivec4(7, 3, 4294967287, 4294967289));
	blockC.d[1][3] = i8vec4(ivec4(4294967295, 4294967288, 4, 4294967295));
	blockC.d[1][4] = i8vec4(ivec4(2, 4294967294, 2, 9));
	blockC.d[1][5] = i8vec4(ivec4(0, 4294967288, 4294967287, 5));
	blockC.d[1][6] = i8vec4(ivec4(2, 4, 8, 8));
	blockC.d[2][0] = i8vec4(ivec4(5, 5, 4294967289, 8));
	blockC.d[2][1] = i8vec4(ivec4(4294967293, 4294967294, 6, 7));
	blockC.d[2][2] = i8vec4(ivec4(4294967294, 4294967288, 4294967287, 4294967290));
	blockC.d[2][3] = i8vec4(ivec4(9, 9, 7, 3));
	blockC.d[2][4] = i8vec4(ivec4(1, 5, 4294967287, 6));
	blockC.d[2][5] = i8vec4(ivec4(9, 4294967294, 0, 7));
	blockC.d[2][6] = i8vec4(ivec4(4294967293, 4294967293, 4294967295, 0));
	blockC.d[3][0] = i8vec4(ivec4(8, 4294967289, 5, 6));
	blockC.d[3][1] = i8vec4(ivec4(0, 6, 1, 4294967291));
	blockC.d[3][2] = i8vec4(ivec4(1, 5, 4, 4294967292));
	blockC.d[3][3] = i8vec4(ivec4(5, 1, 4294967293, 7));
	blockC.d[3][4] = i8vec4(ivec4(4294967289, 9, 4, 9));
	blockC.d[3][5] = i8vec4(ivec4(4294967293, 4294967289, 0, 8));
	blockC.d[3][6] = i8vec4(ivec4(4, 4294967287, 5, 4294967295));
	blockC.e[0] = (ivec4(0, 2, -5, 6));
	blockC.e[1] = (ivec4(7, -1, 4, -6));
	blockC.e[2] = (ivec4(3, 9, 5, 9));
	blockC.e[3] = (ivec4(2, -6, -2, -7));
	blockC.e[4] = (ivec4(0, -4, 0, 8));
	blockC.f[0] = (mat3x4(-4.0, 8.0, 2.0, -8.0, -6.0, 3.0, 8.0, 9.0, -3.0, 5.0, -9.0, -6.0));
	blockC.f[1] = (mat3x4(7.0, -6.0, 3.0, 1.0, -1.0, -1.0, -3.0, 5.0, 0.0, 1.0, -5.0, 1.0));
	blockC.f[2] = (mat3x4(5.0, 1.0, 3.0, 7.0, 2.0, 7.0, -5.0, -6.0, 6.0, 3.0, 4.0, 3.0));
	blockC.f[3] = (mat3x4(8.0, 0.0, -5.0, -3.0, 9.0, -9.0, -3.0, -2.0, -9.0, -4.0, 3.0, -4.0));
	blockC.f[4] = (mat3x4(2.0, -8.0, 8.0, -3.0, 7.0, 8.0, -9.0, 2.0, -5.0, -5.0, 1.0, -1.0));
	blockC.f[5] = (mat3x4(-9.0, -3.0, -6.0, 7.0, -4.0, 4.0, 9.0, -3.0, -8.0, 5.0, 1.0, -3.0));
	blockC.f[6] = (mat3x4(-2.0, -4.0, 6.0, 2.0, 4.0, 0.0, -6.0, -8.0, 7.0, -8.0, 8.0, 2.0));
	blockD.g[0] = i8vec4(ivec4(4294967287, 6, 4294967293, 4294967295));
}
#version 450
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
	bvec4 a[1];
	lowp ivec3 b;
	mediump uvec2 c;
	mediump int d;
	bvec4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].c), uvec2(0u, 0u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].e), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].c), uvec2(0u, 0u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].e), bvec4(false, false, false, false)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(2)].c), uvec2(3u, 3u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(2)].e), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(3)].c), uvec2(6u, 2u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(3)].e), bvec4(true, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (bvec4(true, false, true, false));
	blockB[nonuniformEXT(0)].e = (bvec4(true, false, true, true));
	blockB[nonuniformEXT(1)].a[0] = (bvec4(false, true, true, false));
	blockB[nonuniformEXT(1)].e = (bvec4(false, true, false, true));
	blockB[nonuniformEXT(2)].a[0] = (bvec4(false, false, true, false));
	blockB[nonuniformEXT(2)].e = (bvec4(true, true, true, true));
	blockB[nonuniformEXT(3)].a[0] = (bvec4(true, true, false, true));
	blockB[nonuniformEXT(3)].e = (bvec4(true, false, true, true));
}
